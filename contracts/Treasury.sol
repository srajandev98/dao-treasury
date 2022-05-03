// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

contract Treasury {
  mapping(address => uint256) public treasure;
  uint256 public totalFund = 0;

  function depositFunds() public payable {
    treasure[msg.sender] += msg.value;
    totalFund += msg.value;
  }

  function withdrawFunds(uint amount) public payable {
    require(treasure[msg.sender] >= amount, "Insufficient Funds");
    treasure[msg.sender] -= amount;
    totalFund -= amount;

    // Transfer back fund
    payable(msg.sender).transfer(amount);
  }

  function transferFunds(address receiver, uint amount) public payable {
    require(treasure[msg.sender] >= amount, "Insufficient Funds");
    treasure[msg.sender] -= amount;
    totalFund -= amount;

    // Transfer the fund to the receiver
    treasure[receiver] += amount;
    payable(receiver).transfer(amount);
  }

}
