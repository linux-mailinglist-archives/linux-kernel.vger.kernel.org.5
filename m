Return-Path: <linux-kernel+bounces-97842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C464877054
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 11:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B1231C20B5A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 10:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952FB38391;
	Sat,  9 Mar 2024 10:19:58 +0000 (UTC)
Received: from mail114-240.sinamail.sina.com.cn (mail114-240.sinamail.sina.com.cn [218.30.114.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829BA381DA
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 10:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.114.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709979597; cv=none; b=dsN9FbrDx+y5j++66RzQe1MvlLdV2dOVptJnXOA/LkoA7HIMyZIoH8zWJKQ3yU81w/VzY92fhxKqaGKZWnJnYTfeZwr6wz4CIff6PpLkwk3gvYuP9k4sgqoojA95VrkleuFu5dUBXRrnyGAd37JtvvwwI/7FiB+TZvm9Lr8q5Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709979597; c=relaxed/simple;
	bh=mr9CJOYnpBJJHiZbZawfFNTHJ3JgVS0pvIujUF/snrs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cLG9kPp6btL1jXhCmjNWOk/85QSmXrrTuVI+J8gZaThMJMuijZdkJIb4Vb4GbM/lcSq3Pu32oclFevOGbWCsZHfAVpZszXhhgpHsNWjjZt+J4gZAwr8mPYF2J43mSM37t+zYy1YHLARtxAL3huLcy7zyAVfmJjn7SDvfLgzRrsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.114.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.49.120])
	by sina.com (172.16.235.24) with ESMTP
	id 65EC37B900003ACC; Sat, 9 Mar 2024 18:19:39 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 65107045089305
X-SMAIL-UIID: 7263A743163644BFB93521B979DD4484-20240309-181939-1
From: Hillf Danton <hdanton@sina.com>
To: Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzbot <syzbot+e5167d7144a62715044c@syzkaller.appspotmail.com>,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [netfilter?] KASAN: slab-use-after-free Read in ip_skb_dst_mtu
Date: Sat,  9 Mar 2024 18:19:26 +0800
Message-Id: <20240309101926.1994-1-hdanton@sina.com>
In-Reply-To: <0000000000002e5b66061336b7df@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 09 Mar 2024 01:13:02 -0800
> Hello,
> 
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> INFO: task hung in switchdev_deferred_process_work

Task hung [0] again with Frederic's fix [1] applied [2].

	kworker/1:2:783		kworker/u4:5/146
	---			---
				lock rtnl_mutex
	lock rtnl_mutex		synchronize_rcu_expedited()

[0] Subject: Re: [syzbot] [bluetooth?] INFO: task hung in hci_conn_failed
https://lore.kernel.org/lkml/Zbnq5o_HJOMIIK-c@Boquns-Mac-mini.home/

[1] Subject: [PATCH 8/8] rcu/exp: Remove rcu_par_gp_wq
https://lore.kernel.org/lkml/20240129232349.3170819-9-boqun.feng@gmail.com/

[2] https://github.com/fbq/linux.git rcu-exp.2024.01.29b
> 
> INFO: task kworker/1:2:783 blocked for more than 143 seconds.
>       Not tainted 6.8.0-rc1-syzkaller-00009-gdd85149da01f-dirty #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:kworker/1:2     state:D stack:21872 pid:783   tgid:783   ppid:2      flags:0x00004000
> Workqueue: events switchdev_deferred_process_work
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5400 [inline]
>  __schedule+0x17d1/0x49f0 kernel/sched/core.c:6727
>  __schedule_loop kernel/sched/core.c:6802 [inline]
>  schedule+0x149/0x260 kernel/sched/core.c:6817
>  schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6874
>  __mutex_lock_common kernel/locking/mutex.c:684 [inline]
>  __mutex_lock+0x6a3/0xd70 kernel/locking/mutex.c:752
>  switchdev_deferred_process_work+0xe/0x20 net/switchdev/switchdev.c:75
>  process_one_work kernel/workqueue.c:2633 [inline]
>  process_scheduled_works+0x913/0x1420 kernel/workqueue.c:2706
>  worker_thread+0xa5f/0x1000 kernel/workqueue.c:2787
>  kthread+0x2ef/0x390 kernel/kthread.c:388
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:242
>  </TASK>
> INFO: task dhcpcd:4739 blocked for more than 143 seconds.
>       Not tainted 6.8.0-rc1-syzkaller-00009-gdd85149da01f-dirty #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:dhcpcd          state:D stack:20952 pid:4739  tgid:4739  ppid:4738   flags:0x00004002
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5400 [inline]
>  __schedule+0x17d1/0x49f0 kernel/sched/core.c:6727
>  __schedule_loop kernel/sched/core.c:6802 [inline]
>  schedule+0x149/0x260 kernel/sched/core.c:6817
>  schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6874
>  __mutex_lock_common kernel/locking/mutex.c:684 [inline]
>  __mutex_lock+0x6a3/0xd70 kernel/locking/mutex.c:752
>  rtnl_lock net/core/rtnetlink.c:79 [inline]
>  rtnetlink_rcv_msg+0x82c/0x1040 net/core/rtnetlink.c:6612
>  netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2543
>  netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
>  netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1367
>  netlink_sendmsg+0xa3b/0xd70 net/netlink/af_netlink.c:1908
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg+0x221/0x270 net/socket.c:745
>  ____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
>  ___sys_sendmsg net/socket.c:2638 [inline]
>  __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
>  do_syscall_64+0xf9/0x240
>  entry_SYSCALL_64_after_hwframe+0x6f/0x77
> RIP: 0033:0x7f85a0637a4b
> RSP: 002b:00007ffebbd31e68 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007f85a055f6c0 RCX: 00007f85a0637a4b
> RDX: 0000000000000000 RSI: 00007ffebbd46018 RDI: 000000000000000f
> RBP: 000000000000000f R08: 0000000000000000 R09: 00007ffebbd46018
> R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffff
> R13: 00007ffebbd46018 R14: 0000000000000030 R15: 0000000000000001
>  </TASK>
> INFO: task kworker/0:3:5086 blocked for more than 143 seconds.
>       Not tainted 6.8.0-rc1-syzkaller-00009-gdd85149da01f-dirty #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:kworker/0:3     state:D stack:21872 pid:5086  tgid:5086  ppid:2      flags:0x00004000
> Workqueue: events linkwatch_event
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5400 [inline]
>  __schedule+0x17d1/0x49f0 kernel/sched/core.c:6727
>  __schedule_loop kernel/sched/core.c:6802 [inline]
>  schedule+0x149/0x260 kernel/sched/core.c:6817
>  schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6874
>  __mutex_lock_common kernel/locking/mutex.c:684 [inline]
>  __mutex_lock+0x6a3/0xd70 kernel/locking/mutex.c:752
>  linkwatch_event+0xe/0x60 net/core/link_watch.c:281
>  process_one_work kernel/workqueue.c:2633 [inline]
>  process_scheduled_works+0x913/0x1420 kernel/workqueue.c:2706
>  worker_thread+0xa5f/0x1000 kernel/workqueue.c:2787
>  kthread+0x2ef/0x390 kernel/kthread.c:388
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:242
>  </TASK>
> INFO: task syz-executor.0:14954 blocked for more than 144 seconds.
>       Not tainted 6.8.0-rc1-syzkaller-00009-gdd85149da01f-dirty #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz-executor.0  state:D stack:19888 pid:14954 tgid:14954 ppid:1      flags:0x00004006
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5400 [inline]
>  __schedule+0x17d1/0x49f0 kernel/sched/core.c:6727
>  __schedule_loop kernel/sched/core.c:6802 [inline]
>  schedule+0x149/0x260 kernel/sched/core.c:6817
>  schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6874
>  __mutex_lock_common kernel/locking/mutex.c:684 [inline]
>  __mutex_lock+0x6a3/0xd70 kernel/locking/mutex.c:752
>  rtnl_lock net/core/rtnetlink.c:79 [inline]
>  rtnetlink_rcv_msg+0x82c/0x1040 net/core/rtnetlink.c:6612
>  netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2543
>  netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
>  netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1367
>  netlink_sendmsg+0xa3b/0xd70 net/netlink/af_netlink.c:1908
>  sock_sendmsg_nosec net/socket.c:730 [inline]
>  __sock_sendmsg+0x221/0x270 net/socket.c:745
>  __sys_sendto+0x3a4/0x4f0 net/socket.c:2191
>  __do_sys_sendto net/socket.c:2203 [inline]
>  __se_sys_sendto net/socket.c:2199 [inline]
>  __x64_sys_sendto+0xde/0x100 net/socket.c:2199
>  do_syscall_64+0xf9/0x240
>  entry_SYSCALL_64_after_hwframe+0x6f/0x77
> RIP: 0033:0x7f2a1c07fa9c
> RSP: 002b:00007ffc5dd132a0 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
> RAX: ffffffffffffffda RBX: 00007f2a1ccd4620 RCX: 00007f2a1c07fa9c
> RDX: 0000000000000028 RSI: 00007f2a1ccd4670 RDI: 0000000000000003
> RBP: 0000000000000000 R08: 00007ffc5dd132f4 R09: 000000000000000c
> R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
> R13: 0000000000000000 R14: 00007f2a1ccd4670 R15: 0000000000000000
>  </TASK>
> 
> Showing all locks held in the system:
> 3 locks held by kworker/0:1/8:
>  #0: ffff88802ae89d38 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2608 [inline]
>  #0: ffff88802ae89d38 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1420 kernel/workqueue.c:2706
>  #1: ffffc900000d7d20 ((work_completion)(&(&net->ipv6.addr_chk_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2608 [inline]
>  #1: ffffc900000d7d20 ((work_completion)(&(&net->ipv6.addr_chk_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1420 kernel/workqueue.c:2706
>  #2: ffffffff8f373948 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_verify_work+0x19/0x30 net/ipv6/addrconf.c:4671
> 1 lock held by khungtaskd/29:
>  #0: ffffffff8e1308e0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
>  #0: ffffffff8e1308e0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
>  #0: ffffffff8e1308e0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6614
> 5 locks held by kworker/u4:5/146:
>  #0: ffff8880162f0938 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2608 [inline]
>  #0: ffff8880162f0938 ((wq_completion)netns){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1420 kernel/workqueue.c:2706
>  #1: ffffc90002e6fd20 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2608 [inline]
>  #1: ffffc90002e6fd20 (net_cleanup_work){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1420 kernel/workqueue.c:2706
>  #2: ffffffff8f3673d0 (pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+0xf5/0xb90 net/core/net_namespace.c:580
>  #3: ffffffff8f373948 (rtnl_mutex){+.+.}-{3:3}, at: default_device_exit_batch+0xdb/0x650 net/core/dev.c:11596
>  #4: ffffffff8e136278 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:291 [inline]
>  #4: ffffffff8e136278 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x39a/0x820 kernel/rcu/tree_exp.h:939
> 3 locks held by kworker/1:2/783:
>  #0: ffff888014c8cd38 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2608 [inline]
>  #0: ffff888014c8cd38 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1420 kernel/workqueue.c:2706
>  #1: ffffc9000408fd20 (deferred_process_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2608 [inline]
>  #1: ffffc9000408fd20 (deferred_process_work){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1420 kernel/workqueue.c:2706
>  #2: ffffffff8f373948 (rtnl_mutex){+.+.}-{3:3}, at: switchdev_deferred_process_work+0xe/0x20 net/switchdev/switchdev.c:75
> 1 lock held by dhcpcd/4739:
>  #0: ffffffff8f373948 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
>  #0: ffffffff8f373948 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x82c/0x1040 net/core/rtnetlink.c:6612
> 2 locks held by getty/4822:
>  #0: ffff88802b64a0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
>  #1: ffffc90002f162f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6b4/0x1e10 drivers/tty/n_tty.c:2201
> 3 locks held by kworker/1:4/5083:
>  #0: ffff88802ae89d38 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2608 [inline]
>  #0: ffff88802ae89d38 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1420 kernel/workqueue.c:2706
>  #1: ffffc90003f6fd20 ((work_completion)(&(&net->ipv6.addr_chk_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2608 [inline]
>  #1: ffffc90003f6fd20 ((work_completion)(&(&net->ipv6.addr_chk_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1420 kernel/workqueue.c:2706
>  #2: ffffffff8f373948 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_verify_work+0x19/0x30 net/ipv6/addrconf.c:4671
> 3 locks held by kworker/0:3/5086:
>  #0: ffff888014c8cd38 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2608 [inline]
>  #0: ffff888014c8cd38 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1420 kernel/workqueue.c:2706
>  #1: ffffc90003fafd20 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2608 [inline]
>  #1: ffffc90003fafd20 ((linkwatch_work).work){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1420 kernel/workqueue.c:2706
>  #2: ffffffff8f373948 (rtnl_mutex){+.+.}-{3:3}, at: linkwatch_event+0xe/0x60 net/core/link_watch.c:281
> 1 lock held by syz-executor.0/14954:
>  #0: ffffffff8f373948 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
>  #0: ffffffff8f373948 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x82c/0x1040 net/core/rtnetlink.c:6612
> 1 lock held by syz-executor.0/14991:
>  #0: ffffffff8f373948 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
>  #0: ffffffff8f373948 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x82c/0x1040 net/core/rtnetlink.c:6612
> 1 lock held by syz-executor.0/14998:
>  #0: ffffffff8f373948 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
>  #0: ffffffff8f373948 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x82c/0x1040 net/core/rtnetlink.c:6612
> 
> =============================================
> 
> NMI backtrace for cpu 0
> CPU: 0 PID: 29 Comm: khungtaskd Not tainted 6.8.0-rc1-syzkaller-00009-gdd85149da01f-dirty #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
>  nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
>  nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
>  trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
>  check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
>  watchdog+0xfaf/0xff0 kernel/hung_task.c:379
>  kthread+0x2ef/0x390 kernel/kthread.c:388
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:242
>  </TASK>
> Sending NMI from CPU 0 to CPUs 1:
> NMI backtrace for cpu 1
> CPU: 1 PID: 14994 Comm: kworker/u4:1 Not tainted 6.8.0-rc1-syzkaller-00009-gdd85149da01f-dirty #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
> Workqueue: events_unbound toggle_allocation_gate
> RIP: 0010:preempt_count arch/x86/include/asm/preempt.h:26 [inline]
> RIP: 0010:check_preemption_disabled+0x20/0x120 lib/smp_processor_id.c:16
> Code: 90 90 90 90 90 90 90 90 90 90 41 57 41 56 41 54 53 48 83 ec 10 65 48 8b 04 25 28 00 00 00 48 89 44 24 08 65 8b 1d 7c 23 9e 74 <65> 8b 05 71 23 9e 74 a9 ff ff ff 7f 74 26 65 48 8b 04 25 28 00 00
> RSP: 0018:ffffc9000a8ef668 EFLAGS: 00000082
> RAX: 7e9a76b27b63e200 RBX: 0000000000000001 RCX: 0000000000000000
> RDX: dffffc0000000000 RSI: ffffffff8bfe5f40 RDI: ffffffff8bfe5f00
> RBP: ffffc9000a8ef770 R08: ffff888014c80627 R09: 1ffff110029900c4
> R10: dffffc0000000000 R11: ffffed10029900c5 R12: 0000000000000001
> R13: 00000000000327bf R14: ffff8880b953c0c0 R15: 000000000000000c
> FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000561393482ff8 CR3: 000000000df32000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <NMI>
>  </NMI>
>  <TASK>
>  get_flush_tlb_info arch/x86/mm/tlb.c:987 [inline]
>  flush_tlb_mm_range+0x23f/0x5c0 arch/x86/mm/tlb.c:1021
>  __text_poke+0x95b/0xd30 arch/x86/kernel/alternative.c:1949
>  text_poke arch/x86/kernel/alternative.c:1986 [inline]
>  text_poke_bp_batch+0x8cd/0xb30 arch/x86/kernel/alternative.c:2375
>  text_poke_flush arch/x86/kernel/alternative.c:2488 [inline]
>  text_poke_finish+0x30/0x50 arch/x86/kernel/alternative.c:2495
>  arch_jump_label_transform_apply+0x1c/0x30 arch/x86/kernel/jump_label.c:146
>  static_key_enable_cpuslocked+0x136/0x260 kernel/jump_label.c:205
>  static_key_enable+0x1a/0x20 kernel/jump_label.c:218
>  toggle_allocation_gate+0xb5/0x250 mm/kfence/core.c:826
>  process_one_work kernel/workqueue.c:2633 [inline]
>  process_scheduled_works+0x913/0x1420 kernel/workqueue.c:2706
>  worker_thread+0xa5f/0x1000 kernel/workqueue.c:2787
>  kthread+0x2ef/0x390 kernel/kthread.c:388
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:242
>  </TASK>
> 
> 
> Tested on:
> 
> commit:         dd85149d rcu/exp: Remove rcu_par_gp_wq
> git tree:       https://github.com/fbq/linux.git rcu-exp.2024.01.29b
> console output: https://syzkaller.appspot.com/x/log.txt?x=174332fa180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4151600db6ca0ae1
> dashboard link: https://syzkaller.appspot.com/bug?extid=e5167d7144a62715044c
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=103a2c1a180000

