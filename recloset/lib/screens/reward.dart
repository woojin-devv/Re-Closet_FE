import 'package:flutter/material.dart';
import 'package:recloset/screens/uploadReward.dart';
import '../models/reward.dart';
import '../screens/reward_detail.dart';
import '../widgets/status_badge.dart';

class RewardScreen extends StatelessWidget {
  RewardScreen({super.key});

  final List<Reward> rewards = [
    Reward(
      id: 1,
      email: "user1@example.com",
      donationSite: "Donation site",
      status: "PENDING",
      rewardGranted: 0,
      detailUrl: "https://example.com/reward/1",
    ),
    Reward(
      id: 2,
      email: "user2@example.com",
      donationSite: "Donation site",
      status: "ACCEPTED",
      rewardGranted: 10,
      detailUrl: "https://example.com/reward/2",
    ),
    Reward(
      id: 3,
      email: "user3@example.com",
      donationSite: "New Hope",
      status: "REJECTED",
      rewardGranted: 0,
      detailUrl: "https://example.com/reward/3",
    ),
  ];

  Color _statusColor(String status) {
    switch (status) {
      case 'ACCEPTED':
        return const Color(0xff48A6A7);
      case 'REJECTED':
        return const Color(0xffF16767);
      default:
        return const Color(0xff2C2C2C);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'My Rewards',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xff979797),
          ),
          onPressed: () {
            Navigator.pop(context); // ← 뒤로 가기 기능
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
              color: Color(0xff979797),
              size: 30,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Uploadreward(),
                ),
              );
            },
          )
        ],
      ),
      body: Column(
        children: [
          // AppBar 아래에 들어갈 Container
          Container(
            width: double.infinity,
            height: 0.5,
            color: const Color(0xffF5F5F5),
          ),
          // ListView는 Expanded로 감싸줘야 overflow 방지됨
          Expanded(
            child: ListView.builder(
              itemCount: rewards.length,
              itemBuilder: (context, index) {
                final reward = rewards[index];
                return Column(
                  children: [
                    ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                reward.donationSite,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff303030),
                                ),
                              ),
                              const SizedBox(height: 10),
                              StatusBadge(status: reward.status),
                              const SizedBox(height: 4),
                            ],
                          ),
                          reward.rewardGranted > 0
                              ? Text(
                                  ' +${reward.rewardGranted}P',
                                  style: const TextStyle(
                                    color: Color(0xff7067FF),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : const SizedBox.shrink(), // 아무것도 표시하지 않음
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                RewardDetailScreen(reward: reward),
                          ),
                        );
                      },
                    ),
                    Container(
                      height: 0.5,
                      color: const Color(0xffCCCCCC),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
