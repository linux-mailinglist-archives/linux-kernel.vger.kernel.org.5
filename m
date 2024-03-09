Return-Path: <linux-kernel+bounces-97777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CF0876F45
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 06:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E56C728240B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 05:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D721DDF5;
	Sat,  9 Mar 2024 05:19:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D29C2C69D
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 05:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709961545; cv=none; b=Auneict5pSvUr7mOKijVGFOKFElUqOw4QZBPmcbSVGFvuy1pH7c9R5ON2yKEjp7djzpdfzQNZslm4aYkhbyKQ62vJmU7R7Ya//u3i1ADUQsvQnYKfElyCO8BZGmtsSSHk3ToDSshXAZwUvav6/0eSo66q2KIflfO0Q28vaGwUIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709961545; c=relaxed/simple;
	bh=SnTcyf3k55xcmfp9+++ZJoN58Hy9FNNANfLJyq0bKwQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=R9MeyRce3fGIGUXZlKkDAIhVXKZ29gsvSZfZxASpFu/Uxh2N+WZjLpbuxD5jgby/WQfWGBEE5YcEAXxr9p8RontePwOLzzxh4ecH2GQ8F5ui/Yo/o0F6qBvY41fpF+TR5O9znrf92AQxMfJwlmPbvisq9E8rDR5HEClGMAM1ZQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c874fb29b9so313593239f.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 21:19:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709961542; x=1710566342;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i1/tLnlXqfMG+r8lkv1m3kZdw09L3OJUGH7XpBxeQCI=;
        b=I127f+gbTK4ZiX45OevqtPP3+KJ8lYuDIlwNOn8Ko7kImSJgN8ehLqWjE12Em0neKJ
         4d9gXXhzH/5ZPCSSvVmiyl0yflM80/NW11K9MSTfIahpayftQm5qOT4NunrJSRAv2HzI
         A9f3OQdKKC9RQZh/VAAKIeLF8V6LP3CLBESGFbSTBrDYP2yqIibsb+9mFg03GOCdlox/
         R1eebCSjv5kujUnHOFTRp6ODy0fq6VnHSwqyFmoEco+jRAxXRpsY3qEH3sjNom9jaPHI
         UU8aSJ2HYMoYNp8rwQC0NnaGmdMhbR1lCsyF19+MzhHbDqg/sMI1PGjnji0GVivCREdn
         GoAw==
X-Forwarded-Encrypted: i=1; AJvYcCVpHU+JThya5hpakwRi1HI6JXpCLN0innuAupNL5B1VsNOvCjClQOgJ9XUVVLKVEE8tN5npJJaQLLk97UVZSAXG1EQaY7HzG9mO+0+n
X-Gm-Message-State: AOJu0YzrdZdfj9eBNCDgY/GOkotrVFrVmWzK0bJldQhlPxTNdIAkyj1I
	EReANaIbEjsa+Lrsn4NAi3QLgZ+MYgFnwXksYGDUu5+6NGtRCqe+UEH7SsBgtY2nlBI9jbMUdDe
	itJnPOXOl1g/LqnLMqqQdnsXIspNbZpT103BzHScTEWXjQ7LHATHDkn8=
X-Google-Smtp-Source: AGHT+IFsH4jBlfZuXO6dFobBhxRSP8wvBn+yauKVakOYaMscpEmXMKBTVbZBOlYODAPkYnMmNMaLZ7abOBla6sForh+7EVdOr3+4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1688:b0:7c8:8710:9d31 with SMTP id
 s8-20020a056602168800b007c887109d31mr44797iow.4.1709961542457; Fri, 08 Mar
 2024 21:19:02 -0800 (PST)
Date: Fri, 08 Mar 2024 21:19:02 -0800
In-Reply-To: <20240309045324.1891-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005167f406133372c6@google.com>
Subject: Re: [syzbot] [netfilter?] KASAN: slab-use-after-free Read in ip_skb_dst_mtu
From: syzbot <syzbot+e5167d7144a62715044c@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in switchdev_deferred_process_work

INFO: task kworker/0:1:9 blocked for more than 143 seconds.
      Not tainted 6.8.0-rc7-syzkaller-gc381c89de180-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:1     state:D stack:22136 pid:9     tgid:9     ppid:2      flags:0x00004000
Workqueue: events switchdev_deferred_process_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0x17d1/0x49f0 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6802 [inline]
 schedule+0x149/0x260 kernel/sched/core.c:6817
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6874
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a3/0xd70 kernel/locking/mutex.c:752
 switchdev_deferred_process_work+0xe/0x20 net/switchdev/switchdev.c:104
 process_one_work kernel/workqueue.c:2633 [inline]
 process_scheduled_works+0x913/0x1420 kernel/workqueue.c:2706
 worker_thread+0xa5f/0x1000 kernel/workqueue.c:2787
 kthread+0x2ef/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:243
 </TASK>
INFO: task kworker/1:2:930 blocked for more than 143 seconds.
      Not tainted 6.8.0-rc7-syzkaller-gc381c89de180-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:2     state:D stack:21656 pid:930   tgid:930   ppid:2      flags:0x00004000
Workqueue: events linkwatch_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0x17d1/0x49f0 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6802 [inline]
 schedule+0x149/0x260 kernel/sched/core.c:6817
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6874
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a3/0xd70 kernel/locking/mutex.c:752
 linkwatch_event+0xe/0x60 net/core/link_watch.c:281
 process_one_work kernel/workqueue.c:2633 [inline]
 process_scheduled_works+0x913/0x1420 kernel/workqueue.c:2706
 worker_thread+0xa5f/0x1000 kernel/workqueue.c:2787
 kthread+0x2ef/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:243
 </TASK>
INFO: task dhcpcd:4736 blocked for more than 143 seconds.
      Not tainted 6.8.0-rc7-syzkaller-gc381c89de180-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:dhcpcd          state:D stack:20504 pid:4736  tgid:4736  ppid:4735   flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0x17d1/0x49f0 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6802 [inline]
 schedule+0x149/0x260 kernel/sched/core.c:6817
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6874
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a3/0xd70 kernel/locking/mutex.c:752
 rtnl_lock net/core/rtnetlink.c:79 [inline]
 rtnetlink_rcv_msg+0x82c/0x1040 net/core/rtnetlink.c:6614
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2543
 netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
 netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1367
 netlink_sendmsg+0xa3b/0xd70 net/netlink/af_netlink.c:1908
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
 ___sys_sendmsg net/socket.c:2638 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7f4199ba6a4b
RSP: 002b:00007fff84cbbcc8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f4199ace6c0 RCX: 00007f4199ba6a4b
RDX: 0000000000000000 RSI: 00007fff84ccfe78 RDI: 0000000000000018
RBP: 0000000000000018 R08: 0000000000000000 R09: 00007fff84ccfe78
R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffff
R13: 00007fff84ccfe78 R14: 0000000000000030 R15: 0000000000000001
 </TASK>
INFO: task syz-executor.0:14964 blocked for more than 144 seconds.
      Not tainted 6.8.0-rc7-syzkaller-gc381c89de180-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:20984 pid:14964 tgid:14964 ppid:1      flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0x17d1/0x49f0 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6802 [inline]
 schedule+0x149/0x260 kernel/sched/core.c:6817
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6874
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a3/0xd70 kernel/locking/mutex.c:752
 rtnl_lock net/core/rtnetlink.c:79 [inline]
 rtnetlink_rcv_msg+0x82c/0x1040 net/core/rtnetlink.c:6614
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2543
 netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
 netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1367
 netlink_sendmsg+0xa3b/0xd70 net/netlink/af_netlink.c:1908
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 __sys_sendto+0x3a4/0x4f0 net/socket.c:2191
 __do_sys_sendto net/socket.c:2203 [inline]
 __se_sys_sendto net/socket.c:2199 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2199
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7f49d9c7fa9c
RSP: 002b:00007ffe9fe96940 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f49da8d4620 RCX: 00007f49d9c7fa9c
RDX: 000000000000003c RSI: 00007f49da8d4670 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007ffe9fe96994 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
R13: 0000000000000000 R14: 00007f49da8d4670 R15: 0000000000000000
 </TASK>

Showing all locks held in the system:
3 locks held by kworker/0:0/8:
 #0: ffff888029cdbd38 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2608 [inline]
 #0: ffff888029cdbd38 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1420 kernel/workqueue.c:2706
 #1: ffffc900000d7d20 ((work_completion)(&(&net->ipv6.addr_chk_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2608 [inline]
 #1: ffffc900000d7d20 ((work_completion)(&(&net->ipv6.addr_chk_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1420 kernel/workqueue.c:2706
 #2: ffffffff8f375d88 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_verify_work+0x19/0x30 net/ipv6/addrconf.c:4686
3 locks held by kworker/0:1/9:
 #0: ffff888014c78938 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2608 [inline]
 #0: ffff888014c78938 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1420 kernel/workqueue.c:2706
 #1: ffffc900000e7d20 (deferred_process_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2608 [inline]
 #1: ffffc900000e7d20 (deferred_process_work){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1420 kernel/workqueue.c:2706
 #2: ffffffff8f375d88 (rtnl_mutex){+.+.}-{3:3}, at: switchdev_deferred_process_work+0xe/0x20 net/switchdev/switchdev.c:104
1 lock held by khungtaskd/29:
 #0: ffffffff8e130be0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #0: ffffffff8e130be0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #0: ffffffff8e130be0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6614
2 locks held by kworker/u4:2/42:
 #0: ffff8880b953c958 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559
 #1: ffff8880b9528988 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x441/0x770 kernel/sched/psi.c:988
3 locks held by kworker/1:2/930:
 #0: ffff888014c78938 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2608 [inline]
 #0: ffff888014c78938 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1420 kernel/workqueue.c:2706
 #1: ffffc900042e7d20 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2608 [inline]
 #1: ffffc900042e7d20 ((linkwatch_work).work){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1420 kernel/workqueue.c:2706
 #2: ffffffff8f375d88 (rtnl_mutex){+.+.}-{3:3}, at: linkwatch_event+0xe/0x60 net/core/link_watch.c:281
5 locks held by kworker/u4:7/1097:
 #0: ffff888015ea4938 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2608 [inline]
 #0: ffff888015ea4938 ((wq_completion)netns){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1420 kernel/workqueue.c:2706
 #1: ffffc9000495fd20 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2608 [inline]
 #1: ffffc9000495fd20 (net_cleanup_work){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1420 kernel/workqueue.c:2706
 #2: ffffffff8f369810 (pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+0xf5/0xb90 net/core/net_namespace.c:580
 #3: ffffffff8f375d88 (rtnl_mutex){+.+.}-{3:3}, at: default_device_exit_batch+0xe8/0x9d0 net/core/dev.c:11583
 #4: ffffffff8e136578 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:292 [inline]
 #4: ffffffff8e136578 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x3a3/0x890 kernel/rcu/tree_exp.h:995
1 lock held by dhcpcd/4736:
 #0: ffffffff8f375d88 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8f375d88 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x82c/0x1040 net/core/rtnetlink.c:6614
3 locks held by kworker/1:3/4809:
 #0: ffff888029cdbd38 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2608 [inline]
 #0: ffff888029cdbd38 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1420 kernel/workqueue.c:2706
 #1: ffffc9000356fd20 ((work_completion)(&(&net->ipv6.addr_chk_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2608 [inline]
 #1: ffffc9000356fd20 ((work_completion)(&(&net->ipv6.addr_chk_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1420 kernel/workqueue.c:2706
 #2: ffffffff8f375d88 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_verify_work+0x19/0x30 net/ipv6/addrconf.c:4686
2 locks held by getty/4822:
 #0: ffff88802a4a50a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6b4/0x1e10 drivers/tty/n_tty.c:2201
2 locks held by kworker/1:6/5082:
 #0: ffff888014c7a538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2608 [inline]
 #0: ffff888014c7a538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1420 kernel/workqueue.c:2706
 #1: ffffc90004217d20 ((work_completion)(&rew->rew_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2608 [inline]
 #1: ffffc90004217d20 ((work_completion)(&rew->rew_work)){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1420 kernel/workqueue.c:2706
1 lock held by syz-executor.0/14964:
 #0: ffffffff8f375d88 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8f375d88 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x82c/0x1040 net/core/rtnetlink.c:6614
1 lock held by syz-executor.0/14988:
 #0: ffffffff8f375d88 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8f375d88 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x82c/0x1040 net/core/rtnetlink.c:6614
1 lock held by syz-executor.0/14995:
 #0: ffffffff8f375d88 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8f375d88 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x82c/0x1040 net/core/rtnetlink.c:6614

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 29 Comm: khungtaskd Not tainted 6.8.0-rc7-syzkaller-gc381c89de180-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xfaf/0xff0 kernel/hung_task.c:379
 kthread+0x2ef/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:243
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 270 Comm: kworker/u4:5 Not tainted 6.8.0-rc7-syzkaller-gc381c89de180-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:get_current arch/x86/include/asm/current.h:42 [inline]
RIP: 0010:write_comp_data kernel/kcov.c:235 [inline]
RIP: 0010:__sanitizer_cov_trace_const_cmp4+0x8/0x90 kernel/kcov.c:304
Code: 0a 20 c3 cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 4c 8b 04 24 <65> 48 8b 15 b0 4b 70 7e 65 8b 05 b1 4b 70 7e a9 00 01 ff 00 74 10
RSP: 0018:ffffc9000316f758 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 1ffff9200062df35 RCX: ffff88801e230000
RDX: 0000000000000000 RSI: 0000000000004000 RDI: 0000000000000000
RBP: ffffc9000316f9ac R08: ffffffff8b63c78f R09: 0000000000000000
R10: ffffc9000316f960 R11: fffff5200062df37 R12: ffffc9000316f960
R13: 0000000000004000 R14: ffffc9000316f984 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055d14f5ec028 CR3: 000000000df32000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 insn_get_modrm+0xbf/0x7a0 arch/x86/lib/insn.c:348
 insn_get_sib arch/x86/lib/insn.c:421 [inline]
 insn_get_displacement+0x13e/0x980 arch/x86/lib/insn.c:464
 insn_get_immediate+0x382/0x13e0 arch/x86/lib/insn.c:632
 insn_get_length arch/x86/lib/insn.c:707 [inline]
 insn_decode+0x370/0x500 arch/x86/lib/insn.c:747
 text_poke_loc_init+0xed/0x870 arch/x86/kernel/alternative.c:2401
 arch_jump_label_transform_queue+0x8f/0x100 arch/x86/kernel/jump_label.c:138
 __jump_label_update+0x177/0x3a0 kernel/jump_label.c:475
 static_key_disable_cpuslocked+0xce/0x1c0 kernel/jump_label.c:235
 static_key_disable+0x1a/0x20 kernel/jump_label.c:243
 toggle_allocation_gate+0x1b8/0x250 mm/kfence/core.c:831
 process_one_work kernel/workqueue.c:2633 [inline]
 process_scheduled_works+0x913/0x1420 kernel/workqueue.c:2706
 worker_thread+0xa5f/0x1000 kernel/workqueue.c:2787
 kthread+0x2ef/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:243
 </TASK>


Tested on:

commit:         c381c89d Merge tag 'spi-fix-v6.8-rc7' of git://git.ker..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git stable
console output: https://syzkaller.appspot.com/x/log.txt?x=13ede469180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c11c5c676adb61f0
dashboard link: https://syzkaller.appspot.com/bug?extid=e5167d7144a62715044c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16e50da6180000


