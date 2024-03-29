Return-Path: <linux-kernel+bounces-124570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62059891A11
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 175F128527A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8CC155383;
	Fri, 29 Mar 2024 12:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBdhGXbr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850F4154435;
	Fri, 29 Mar 2024 12:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715432; cv=none; b=u1ANeibTmKOkDWNVkzdDBybhGQJILo4yyNOPvdzZ8v2rpBZBsh+PsaO9HbNXgwuiGLH69fhTPDUd7CJKdCoX0AJhXm6HgQ0KY6Nl2K5IfXMaXjeTX7RXeS+z3MdLxb7wodsoWL3lGoDQy/VqRINShzrPKMwpuboW9fCpYMDtmzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715432; c=relaxed/simple;
	bh=JV8mQzOSLax/5tOLkwzc1CiPbJd4SpIXSABdF3z54CU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZT3SDC6EI9pJWDH3bojYglFQCOn4pumVyVMukdLva1VHwr9JIQKfXyloHjxwj5/4Iw4zeV1V/qViHfzXrusWyU2+ijX3gbbPjYi4Wjd0cYkhEXehMF345fnFHfWhHD21DY6o7IgB3ju/QBM6PzeP80LpVmpf05olgX67pEUIR1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBdhGXbr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 418DBC433C7;
	Fri, 29 Mar 2024 12:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715432;
	bh=JV8mQzOSLax/5tOLkwzc1CiPbJd4SpIXSABdF3z54CU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CBdhGXbrWfwnxTSve1PKeAmbr2jsNpq2hHdfGY7rCRNqR1gFzMn838ega3wn2v5GV
	 TFyqmL9zThXU6ixsLTbPFotuglj7tKsBs2aFq2H6Uumn6vJ6pXrqaCsKw94+PG01Vb
	 CcBzHZ7Kb+prxxgIiTTmkFT3b/vNXRZ/7UqFNPy7+V/jJt0C1fkHE6XMV0YxblP9kX
	 QXjMc5Ef/5Glqgue62f8F4BZQYlcOylAGgzbFrvMgctexTVA6S95jLhdxXQTQA0c+J
	 L1ttGZPqqb8rlof4plLF0aKwGF6Gr0XvD3O5AQLM6Pw7KJMxMNcBrkVBvEtPNQAwMC
	 TJwr3H4p8xo0A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	syzbot <syzkaller@googlegroups.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	pabeni@redhat.com,
	dsahern@kernel.org,
	steffen.klassert@secunet.com,
	idosch@nvidia.com,
	amcohen@nvidia.com,
	petrm@nvidia.com,
	jbenc@redhat.com,
	leitao@debian.org,
	b.galvani@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 19/52] net: add netdev_lockdep_set_classes() to virtual drivers
Date: Fri, 29 Mar 2024 08:28:49 -0400
Message-ID: <20240329122956.3083859-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122956.3083859-1-sashal@kernel.org>
References: <20240329122956.3083859-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 0bef512012b1cd8820f0c9ec80e5f8ceb43fdd59 ]

Based on a syzbot report, it appears many virtual
drivers do not yet use netdev_lockdep_set_classes(),
triggerring lockdep false positives.

WARNING: possible recursive locking detected
6.8.0-rc4-next-20240212-syzkaller #0 Not tainted

syz-executor.0/19016 is trying to acquire lock:
 ffff8880162cb298 (_xmit_ETHER#2){+.-.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
 ffff8880162cb298 (_xmit_ETHER#2){+.-.}-{2:2}, at: __netif_tx_lock include/linux/netdevice.h:4452 [inline]
 ffff8880162cb298 (_xmit_ETHER#2){+.-.}-{2:2}, at: sch_direct_xmit+0x1c4/0x5f0 net/sched/sch_generic.c:340

but task is already holding lock:
 ffff8880223db4d8 (_xmit_ETHER#2){+.-.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
 ffff8880223db4d8 (_xmit_ETHER#2){+.-.}-{2:2}, at: __netif_tx_lock include/linux/netdevice.h:4452 [inline]
 ffff8880223db4d8 (_xmit_ETHER#2){+.-.}-{2:2}, at: sch_direct_xmit+0x1c4/0x5f0 net/sched/sch_generic.c:340

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
  lock(_xmit_ETHER#2);
  lock(_xmit_ETHER#2);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

9 locks held by syz-executor.0/19016:
  #0: ffffffff8f385208 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
  #0: ffffffff8f385208 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x82c/0x1040 net/core/rtnetlink.c:6603
  #1: ffffc90000a08c00 ((&in_dev->mr_ifc_timer)){+.-.}-{0:0}, at: call_timer_fn+0xc0/0x600 kernel/time/timer.c:1697
  #2: ffffffff8e131520 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
  #2: ffffffff8e131520 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
  #2: ffffffff8e131520 (rcu_read_lock){....}-{1:2}, at: ip_finish_output2+0x45f/0x1360 net/ipv4/ip_output.c:228
  #3: ffffffff8e131580 (rcu_read_lock_bh){....}-{1:2}, at: local_bh_disable include/linux/bottom_half.h:20 [inline]
  #3: ffffffff8e131580 (rcu_read_lock_bh){....}-{1:2}, at: rcu_read_lock_bh include/linux/rcupdate.h:802 [inline]
  #3: ffffffff8e131580 (rcu_read_lock_bh){....}-{1:2}, at: __dev_queue_xmit+0x2c4/0x3b10 net/core/dev.c:4284
  #4: ffff8880416e3258 (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock){+...}-{2:2}, at: spin_trylock include/linux/spinlock.h:361 [inline]
  #4: ffff8880416e3258 (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock){+...}-{2:2}, at: qdisc_run_begin include/net/sch_generic.h:195 [inline]
  #4: ffff8880416e3258 (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock){+...}-{2:2}, at: __dev_xmit_skb net/core/dev.c:3771 [inline]
  #4: ffff8880416e3258 (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock){+...}-{2:2}, at: __dev_queue_xmit+0x1262/0x3b10 net/core/dev.c:4325
  #5: ffff8880223db4d8 (_xmit_ETHER#2){+.-.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
  #5: ffff8880223db4d8 (_xmit_ETHER#2){+.-.}-{2:2}, at: __netif_tx_lock include/linux/netdevice.h:4452 [inline]
  #5: ffff8880223db4d8 (_xmit_ETHER#2){+.-.}-{2:2}, at: sch_direct_xmit+0x1c4/0x5f0 net/sched/sch_generic.c:340
  #6: ffffffff8e131520 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
  #6: ffffffff8e131520 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
  #6: ffffffff8e131520 (rcu_read_lock){....}-{1:2}, at: ip_finish_output2+0x45f/0x1360 net/ipv4/ip_output.c:228
  #7: ffffffff8e131580 (rcu_read_lock_bh){....}-{1:2}, at: local_bh_disable include/linux/bottom_half.h:20 [inline]
  #7: ffffffff8e131580 (rcu_read_lock_bh){....}-{1:2}, at: rcu_read_lock_bh include/linux/rcupdate.h:802 [inline]
  #7: ffffffff8e131580 (rcu_read_lock_bh){....}-{1:2}, at: __dev_queue_xmit+0x2c4/0x3b10 net/core/dev.c:4284
  #8: ffff888014d9d258 (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock){+...}-{2:2}, at: spin_trylock include/linux/spinlock.h:361 [inline]
  #8: ffff888014d9d258 (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock){+...}-{2:2}, at: qdisc_run_begin include/net/sch_generic.h:195 [inline]
  #8: ffff888014d9d258 (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock){+...}-{2:2}, at: __dev_xmit_skb net/core/dev.c:3771 [inline]
  #8: ffff888014d9d258 (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock){+...}-{2:2}, at: __dev_queue_xmit+0x1262/0x3b10 net/core/dev.c:4325

stack backtrace:
CPU: 1 PID: 19016 Comm: syz-executor.0 Not tainted 6.8.0-rc4-next-20240212-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Call Trace:
 <IRQ>
  __dump_stack lib/dump_stack.c:88 [inline]
  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
  check_deadlock kernel/locking/lockdep.c:3062 [inline]
  validate_chain+0x15c1/0x58e0 kernel/locking/lockdep.c:3856
  __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
  lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
  __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
  _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
  spin_lock include/linux/spinlock.h:351 [inline]
  __netif_tx_lock include/linux/netdevice.h:4452 [inline]
  sch_direct_xmit+0x1c4/0x5f0 net/sched/sch_generic.c:340
  __dev_xmit_skb net/core/dev.c:3784 [inline]
  __dev_queue_xmit+0x1912/0x3b10 net/core/dev.c:4325
  neigh_output include/net/neighbour.h:542 [inline]
  ip_finish_output2+0xe66/0x1360 net/ipv4/ip_output.c:235
  iptunnel_xmit+0x540/0x9b0 net/ipv4/ip_tunnel_core.c:82
  ip_tunnel_xmit+0x20ee/0x2960 net/ipv4/ip_tunnel.c:831
  erspan_xmit+0x9de/0x1460 net/ipv4/ip_gre.c:720
  __netdev_start_xmit include/linux/netdevice.h:4989 [inline]
  netdev_start_xmit include/linux/netdevice.h:5003 [inline]
  xmit_one net/core/dev.c:3555 [inline]
  dev_hard_start_xmit+0x242/0x770 net/core/dev.c:3571
  sch_direct_xmit+0x2b6/0x5f0 net/sched/sch_generic.c:342
  __dev_xmit_skb net/core/dev.c:3784 [inline]
  __dev_queue_xmit+0x1912/0x3b10 net/core/dev.c:4325
  neigh_output include/net/neighbour.h:542 [inline]
  ip_finish_output2+0xe66/0x1360 net/ipv4/ip_output.c:235
  igmpv3_send_cr net/ipv4/igmp.c:723 [inline]
  igmp_ifc_timer_expire+0xb71/0xd90 net/ipv4/igmp.c:813
  call_timer_fn+0x17e/0x600 kernel/time/timer.c:1700
  expire_timers kernel/time/timer.c:1751 [inline]
  __run_timers+0x621/0x830 kernel/time/timer.c:2038
  run_timer_softirq+0x67/0xf0 kernel/time/timer.c:2051
  __do_softirq+0x2bc/0x943 kernel/softirq.c:554
  invoke_softirq kernel/softirq.c:428 [inline]
  __irq_exit_rcu+0xf2/0x1c0 kernel/softirq.c:633
  irq_exit_rcu+0x9/0x30 kernel/softirq.c:645
  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1076 [inline]
  sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1076
 </IRQ>
 <TASK>
  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
 RIP: 0010:resched_offsets_ok kernel/sched/core.c:10127 [inline]
 RIP: 0010:__might_resched+0x16f/0x780 kernel/sched/core.c:10142
Code: 00 4c 89 e8 48 c1 e8 03 48 ba 00 00 00 00 00 fc ff df 48 89 44 24 38 0f b6 04 10 84 c0 0f 85 87 04 00 00 41 8b 45 00 c1 e0 08 <01> d8 44 39 e0 0f 85 d6 00 00 00 44 89 64 24 1c 48 8d bc 24 a0 00
RSP: 0018:ffffc9000ee069e0 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff8880296a9e00
RDX: dffffc0000000000 RSI: ffff8880296a9e00 RDI: ffffffff8bfe8fa0
RBP: ffffc9000ee06b00 R08: ffffffff82326877 R09: 1ffff11002b5ad1b
R10: dffffc0000000000 R11: ffffed1002b5ad1c R12: 0000000000000000
R13: ffff8880296aa23c R14: 000000000000062a R15: 1ffff92001dc0d44
  down_write+0x19/0x50 kernel/locking/rwsem.c:1578
  kernfs_activate fs/kernfs/dir.c:1403 [inline]
  kernfs_add_one+0x4af/0x8b0 fs/kernfs/dir.c:819
  __kernfs_create_file+0x22e/0x2e0 fs/kernfs/file.c:1056
  sysfs_add_file_mode_ns+0x24a/0x310 fs/sysfs/file.c:307
  create_files fs/sysfs/group.c:64 [inline]
  internal_create_group+0x4f4/0xf20 fs/sysfs/group.c:152
  internal_create_groups fs/sysfs/group.c:192 [inline]
  sysfs_create_groups+0x56/0x120 fs/sysfs/group.c:218
  create_dir lib/kobject.c:78 [inline]
  kobject_add_internal+0x472/0x8d0 lib/kobject.c:240
  kobject_add_varg lib/kobject.c:374 [inline]
  kobject_init_and_add+0x124/0x190 lib/kobject.c:457
  netdev_queue_add_kobject net/core/net-sysfs.c:1706 [inline]
  netdev_queue_update_kobjects+0x1f3/0x480 net/core/net-sysfs.c:1758
  register_queue_kobjects net/core/net-sysfs.c:1819 [inline]
  netdev_register_kobject+0x265/0x310 net/core/net-sysfs.c:2059
  register_netdevice+0x1191/0x19c0 net/core/dev.c:10298
  bond_newlink+0x3b/0x90 drivers/net/bonding/bond_netlink.c:576
  rtnl_newlink_create net/core/rtnetlink.c:3506 [inline]
  __rtnl_newlink net/core/rtnetlink.c:3726 [inline]
  rtnl_newlink+0x158f/0x20a0 net/core/rtnetlink.c:3739
  rtnetlink_rcv_msg+0x885/0x1040 net/core/rtnetlink.c:6606
  netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2543
  netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
  netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1367
  netlink_sendmsg+0xa3c/0xd70 net/netlink/af_netlink.c:1908
  sock_sendmsg_nosec net/socket.c:730 [inline]
  __sock_sendmsg+0x221/0x270 net/socket.c:745
  __sys_sendto+0x3a4/0x4f0 net/socket.c:2191
  __do_sys_sendto net/socket.c:2203 [inline]
  __se_sys_sendto net/socket.c:2199 [inline]
  __x64_sys_sendto+0xde/0x100 net/socket.c:2199
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7fc3fa87fa9c

Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/r/20240212140700.2795436-4-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dummy.c            | 1 +
 drivers/net/geneve.c           | 1 +
 drivers/net/loopback.c         | 1 +
 drivers/net/veth.c             | 1 +
 drivers/net/vxlan/vxlan_core.c | 1 +
 net/ipv4/ip_tunnel.c           | 1 +
 net/ipv6/ip6_gre.c             | 2 ++
 net/ipv6/ip6_tunnel.c          | 1 +
 net/ipv6/ip6_vti.c             | 1 +
 net/ipv6/sit.c                 | 1 +
 10 files changed, 11 insertions(+)

diff --git a/drivers/net/dummy.c b/drivers/net/dummy.c
index c4b1b0aa438ac..5560cf683eb73 100644
--- a/drivers/net/dummy.c
+++ b/drivers/net/dummy.c
@@ -71,6 +71,7 @@ static int dummy_dev_init(struct net_device *dev)
 	if (!dev->lstats)
 		return -ENOMEM;
 
+	netdev_lockdep_set_classes(dev);
 	return 0;
 }
 
diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 78f9d588f7129..3bd10ebeb6c7b 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -335,6 +335,7 @@ static int geneve_init(struct net_device *dev)
 		gro_cells_destroy(&geneve->gro_cells);
 		return err;
 	}
+	netdev_lockdep_set_classes(dev);
 	return 0;
 }
 
diff --git a/drivers/net/loopback.c b/drivers/net/loopback.c
index f6d53e63ef4ec..f6eab66c26608 100644
--- a/drivers/net/loopback.c
+++ b/drivers/net/loopback.c
@@ -144,6 +144,7 @@ static int loopback_dev_init(struct net_device *dev)
 	dev->lstats = netdev_alloc_pcpu_stats(struct pcpu_lstats);
 	if (!dev->lstats)
 		return -ENOMEM;
+	netdev_lockdep_set_classes(dev);
 	return 0;
 }
 
diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 0ae90702e7f84..30982f03847b1 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1475,6 +1475,7 @@ static void veth_free_queues(struct net_device *dev)
 
 static int veth_dev_init(struct net_device *dev)
 {
+	netdev_lockdep_set_classes(dev);
 	return veth_alloc_queues(dev);
 }
 
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 5b5597073b004..99ede13124194 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2960,6 +2960,7 @@ static int vxlan_init(struct net_device *dev)
 	if (err)
 		goto err_gro_cells_destroy;
 
+	netdev_lockdep_set_classes(dev);
 	return 0;
 
 err_gro_cells_destroy:
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 2d29fce7c5606..55555143646eb 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -1285,6 +1285,7 @@ int ip_tunnel_init(struct net_device *dev)
 
 	if (tunnel->collect_md)
 		netif_keep_dst(dev);
+	netdev_lockdep_set_classes(dev);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(ip_tunnel_init);
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 070d87abf7c02..447d244c01b15 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1511,6 +1511,7 @@ static int ip6gre_tunnel_init_common(struct net_device *dev)
 	ip6gre_tnl_init_features(dev);
 
 	netdev_hold(dev, &tunnel->dev_tracker, GFP_KERNEL);
+	netdev_lockdep_set_classes(dev);
 	return 0;
 
 cleanup_dst_cache_init:
@@ -1903,6 +1904,7 @@ static int ip6erspan_tap_init(struct net_device *dev)
 	ip6erspan_tnl_link_config(tunnel, 1);
 
 	netdev_hold(dev, &tunnel->dev_tracker, GFP_KERNEL);
+	netdev_lockdep_set_classes(dev);
 	return 0;
 
 cleanup_dst_cache_init:
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 9bbabf750a21e..70478027a7af7 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1898,6 +1898,7 @@ ip6_tnl_dev_init_gen(struct net_device *dev)
 	dev->max_mtu = IP6_MAX_MTU - dev->hard_header_len;
 
 	netdev_hold(dev, &t->dev_tracker, GFP_KERNEL);
+	netdev_lockdep_set_classes(dev);
 	return 0;
 
 destroy_dst:
diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index 73c85d4e0e9cd..04e4368fe4655 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -935,6 +935,7 @@ static inline int vti6_dev_init_gen(struct net_device *dev)
 	if (!dev->tstats)
 		return -ENOMEM;
 	netdev_hold(dev, &t->dev_tracker, GFP_KERNEL);
+	netdev_lockdep_set_classes(dev);
 	return 0;
 }
 
diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index cc24cefdb85c0..eb4c8e2a2b12e 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -1460,6 +1460,7 @@ static int ipip6_tunnel_init(struct net_device *dev)
 		return err;
 	}
 	netdev_hold(dev, &tunnel->dev_tracker, GFP_KERNEL);
+	netdev_lockdep_set_classes(dev);
 	return 0;
 }
 
-- 
2.43.0


