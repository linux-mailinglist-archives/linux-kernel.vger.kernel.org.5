Return-Path: <linux-kernel+bounces-97033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2515F87649B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BCC51F225D3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5CC1BF37;
	Fri,  8 Mar 2024 13:00:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78F7367
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 13:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709902805; cv=none; b=FTInc4cdT1Gzilj/AVlHT3VtpnwMIaaJzJTREIDmcwT0uPW++oSGowFAeKKSfoEIhvWsgH9PRNkbUSJcmrwhJK9wnCWJ08ZTIzBX9VA9mX1dZD6W8b7Bm1AmAMGqQtFf05qwBSrY1RlysKU5XidF/lCNzD3GubphtYbCmyHzQ5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709902805; c=relaxed/simple;
	bh=7jdYTxmb0kqadj/2fx1/o8g9ZlS/wn2km+Mn0xHQdhk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZTG7DUYw2l05TxnK9GOh/AcZ/gZHkXqR38SXfDbugBHdJoN0Ff0rWLjDJ+MRvdOfh9aVDR0iWe6RpECRzGKzB3qspWu6T15P8YDzkkBywWjmEMW0Jn+xWGvQiaqIULZFnrdFEPAbTDtt0EBjdwe9Pgdit8yMasNijPoA1UKVj10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c874fb2baaso88680339f.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 05:00:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709902802; x=1710507602;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YiBPn4ZfwSPU7bRFNXvYGk864uy/Gguen9w5PLLe5H4=;
        b=RMVelVVkM0RGLvN3F4I8l2pje76H/GfU98wl8x6o1lbhDQk8d9yoE7JdOxTVfU+ZG4
         K1Krp1oZolLeyJlL6rs035d0wyvA97t7XlGbr0cff9tAE86ZoMLP1CuVkUmHJL+6qrRb
         o/IQsBR9UNA4WgQNjtrhUqll3bkAryfTpuWLwyyX1RL9kSMlYoktZ4RIhiTluHTc30aL
         ell73KoWCuPrFP2rK86bPTetDbTBRKdb8WAOtyw3tx0jystBeTJaX4jLrm/03e1scQM2
         ocq93q1U7+qWLHtkPgFAdzD+FEbTXk1IvdbTgBsND0q2kO+64mT//d3V515jiQu3aDZ9
         +EaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUipp4dbeHYaN4JlCfjHnKPR2+F3ul9RYyi+qPYb7z+T4j7s/35xyivdEO5EaTh0yvSOAVcIolJXnrhgBUgMAxVtQ1CvHEfhyvbxOuZ
X-Gm-Message-State: AOJu0Yz467U5xjCUSafjkw6yr24MAsZ/TviTx8Lb4qRqXOrBJ504rPFT
	3hZF9svhA/ec4QN6OON4Nt8WKfUMU68kozkgXrjiMiOn8QS0NljdsDvN6f4s/nZ3sK4zUce20p6
	f462aAE2Yi3lPRAY5NDzyHlidNJPuLoW59rZYzqCRjc138osVFYOVcyU=
X-Google-Smtp-Source: AGHT+IETs47jSbyutOeKjYugxRflJb47u1yALeLL2YSzXFvYXVzvHeQojNTJtRlSX8o0T1jg9qxbsJFtGxtHkp1ylOhdW+dag1GN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3710:b0:476:71e5:fc35 with SMTP id
 k16-20020a056638371000b0047671e5fc35mr460758jav.3.1709902802493; Fri, 08 Mar
 2024 05:00:02 -0800 (PST)
Date: Fri, 08 Mar 2024 05:00:02 -0800
In-Reply-To: <20240308121558.1773-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000024b425061325c532@google.com>
Subject: Re: [syzbot] [netfilter?] KASAN: slab-use-after-free Read in ip_skb_dst_mtu
From: syzbot <syzbot+e5167d7144a62715044c@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in switchdev_deferred_process_work

INFO: task kworker/1:1:27 blocked for more than 143 seconds.
      Not tainted 6.8.0-rc7-syzkaller-g3aaa8ce7a335-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:1     state:D stack:19352 pid:27    tgid:27    ppid:2      flags:0x00004000
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
INFO: task kworker/0:2:781 blocked for more than 143 seconds.
      Not tainted 6.8.0-rc7-syzkaller-g3aaa8ce7a335-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:2     state:D stack:22584 pid:781   tgid:781   ppid:2      flags:0x00004000
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
      Not tainted 6.8.0-rc7-syzkaller-g3aaa8ce7a335-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:dhcpcd          state:D stack:20952 pid:4736  tgid:4736  ppid:4735   flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0x17d1/0x49f0 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6802 [inline]
 schedule+0x149/0x260 kernel/sched/core.c:6817
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6874
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a3/0xd70 kernel/locking/mutex.c:752
 devinet_ioctl+0x2ce/0x1bc0 net/ipv4/devinet.c:1091
 inet_ioctl+0x3d7/0x4f0 net/ipv4/af_inet.c:1000
 sock_do_ioctl+0x158/0x460 net/socket.c:1222
 sock_ioctl+0x629/0x8e0 net/socket.c:1341
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:857
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7fbee8a8ed49
RSP: 002b:00007ffd87e02fb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fbee89c06c0 RCX: 00007fbee8a8ed49
RDX: 00007ffd87e131a8 RSI: 0000000000008914 RDI: 0000000000000018
RBP: 00007ffd87e23368 R08: 00007ffd87e13168 R09: 00007ffd87e13118
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd87e131a8 R14: 0000000000000028 R15: 0000000000008914
 </TASK>
INFO: task syz-executor.0:14966 blocked for more than 143 seconds.
      Not tainted 6.8.0-rc7-syzkaller-g3aaa8ce7a335-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:20984 pid:14966 tgid:14966 ppid:1      flags:0x00004006
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
RIP: 0033:0x7fd058e7fa9c
RSP: 002b:00007ffd38f21060 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007fd059ad4620 RCX: 00007fd058e7fa9c
RDX: 000000000000006c RSI: 00007fd059ad4670 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007ffd38f210b4 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
R13: 0000000000000000 R14: 00007fd059ad4670 R15: 0000000000000000
 </TASK>

Showing all locks held in the system:
3 locks held by kworker/1:0/23:
 #0: ffff8880299f1138 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2608 [inline]
 #0: ffff8880299f1138 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1420 kernel/workqueue.c:2706
 #1: ffffc900001d7d20 ((work_completion)(&(&net->ipv6.addr_chk_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2608 [inline]
 #1: ffffc900001d7d20 ((work_completion)(&(&net->ipv6.addr_chk_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1420 kernel/workqueue.c:2706
 #2: ffffffff8f375d88 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_verify_work+0x19/0x30 net/ipv6/addrconf.c:4686
3 locks held by kworker/1:1/27:
 #0: ffff888014c78938 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2608 [inline]
 #0: ffff888014c78938 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1420 kernel/workqueue.c:2706
 #1: ffffc90000a2fd20 (deferred_process_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2608 [inline]
 #1: ffffc90000a2fd20 (deferred_process_work){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1420 kernel/workqueue.c:2706
 #2: ffffffff8f375d88 (rtnl_mutex){+.+.}-{3:3}, at: switchdev_deferred_process_work+0xe/0x20 net/switchdev/switchdev.c:104
1 lock held by khungtaskd/30:
 #0: ffffffff8e130be0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #0: ffffffff8e130be0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #0: ffffffff8e130be0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6614
5 locks held by kworker/u4:5/308:
 #0: ffff888015ea4938 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2608 [inline]
 #0: ffff888015ea4938 ((wq_completion)netns){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1420 kernel/workqueue.c:2706
 #1: ffffc90002f3fd20 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2608 [inline]
 #1: ffffc90002f3fd20 (net_cleanup_work){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1420 kernel/workqueue.c:2706
 #2: ffffffff8f369810 (pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+0xf5/0xb90 net/core/net_namespace.c:580
 #3: ffffffff8f375d88 (rtnl_mutex){+.+.}-{3:3}, at: default_device_exit_batch+0xe8/0x9d0 net/core/dev.c:11583
 #4: ffffffff8e136578 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:292 [inline]
 #4: ffffffff8e136578 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x3a3/0x890 kernel/rcu/tree_exp.h:995
3 locks held by kworker/0:2/781:
 #0: ffff888014c78938 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2608 [inline]
 #0: ffff888014c78938 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1420 kernel/workqueue.c:2706
 #1: ffffc9000430fd20 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2608 [inline]
 #1: ffffc9000430fd20 ((linkwatch_work).work){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1420 kernel/workqueue.c:2706
 #2: ffffffff8f375d88 (rtnl_mutex){+.+.}-{3:3}, at: linkwatch_event+0xe/0x60 net/core/link_watch.c:281
3 locks held by kworker/0:3/1150:
 #0: ffff8880299f1138 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2608 [inline]
 #0: ffff8880299f1138 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1420 kernel/workqueue.c:2706
 #1: ffffc90004a57d20 ((work_completion)(&(&net->ipv6.addr_chk_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2608 [inline]
 #1: ffffc90004a57d20 ((work_completion)(&(&net->ipv6.addr_chk_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1420 kernel/workqueue.c:2706
 #2: ffffffff8f375d88 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_verify_work+0x19/0x30 net/ipv6/addrconf.c:4686
1 lock held by dhcpcd/4736:
 #0: ffffffff8f375d88 (rtnl_mutex){+.+.}-{3:3}, at: devinet_ioctl+0x2ce/0x1bc0 net/ipv4/devinet.c:1091
2 locks held by getty/4819:
 #0: ffff88802a0830a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6b4/0x1e10 drivers/tty/n_tty.c:2201
2 locks held by kworker/0:4/5085:
 #0: ffff888014c7a538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2608 [inline]
 #0: ffff888014c7a538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1420 kernel/workqueue.c:2706
 #1: ffffc90003ccfd20 ((work_completion)(&rew->rew_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2608 [inline]
 #1: ffffc90003ccfd20 ((work_completion)(&rew->rew_work)){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1420 kernel/workqueue.c:2706
1 lock held by syz-executor.0/14966:
 #0: ffffffff8f375d88 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8f375d88 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x82c/0x1040 net/core/rtnetlink.c:6614
1 lock held by syz-executor.0/14990:
 #0: ffffffff8f375d88 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8f375d88 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x82c/0x1040 net/core/rtnetlink.c:6614
1 lock held by syz-executor.0/14997:
 #0: ffffffff8f375d88 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8f375d88 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x82c/0x1040 net/core/rtnetlink.c:6614

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 30 Comm: khungtaskd Not tainted 6.8.0-rc7-syzkaller-g3aaa8ce7a335-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
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
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 4504 Comm: syslogd Not tainted 6.8.0-rc7-syzkaller-g3aaa8ce7a335-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
RIP: 0010:__preempt_count_add kernel/rcu/tree.c:696 [inline]
RIP: 0010:rcu_is_watching+0x6/0xb0 kernel/rcu/tree.c:699
Code: 5e 03 e9 2b ff ff ff e8 e8 49 ec 09 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 41 57 <41> 56 53 65 ff 05 28 eb 88 7e e8 eb 67 ec 09 89 c3 83 f8 08 73 7a
RSP: 0018:ffffc9000312fbf0 EFLAGS: 00000257
RAX: 0000000000000001 RBX: 0000000000000000 RCX: ffffffff81711844
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffff8f856c28
RBP: ffffc9000312fd58 R08: ffffffff8f856c2f R09: 1ffffffff1f0ad85
R10: dffffc0000000000 R11: fffffbfff1f0ad86 R12: 1ffff92000625f88
R13: dffffc0000000000 R14: 0000000000000000 R15: 1ffff1100fc3c0a5
FS:  00007ff39ead3380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055ba48cdb0a8 CR3: 0000000028d0c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 trace_lock_acquire include/trace/events/lock.h:24 [inline]
 lock_acquire+0xe3/0x530 kernel/locking/lockdep.c:5725
 __might_fault+0xc5/0x120 mm/memory.c:6080
 clear_rseq_cs kernel/rseq.c:257 [inline]
 rseq_ip_fixup kernel/rseq.c:291 [inline]
 __rseq_handle_notify_resume+0x625/0x1490 kernel/rseq.c:329
 rseq_handle_notify_resume include/linux/rseq.h:38 [inline]
 resume_user_mode_work include/linux/resume_user_mode.h:62 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:108 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:201 [inline]
 syscall_exit_to_user_mode+0x113/0x360 kernel/entry/common.c:212
 do_syscall_64+0x108/0x240 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7ff39ec27b6a
Code: 00 3d 00 00 41 00 75 0d 50 48 8d 3d 2d 08 0a 00 e8 ea 7d 01 00 31 c0 e9 07 ff ff ff 64 8b 04 25 18 00 00 00 85 c0 75 1b 0f 05 <48> 3d 00 f0 ff ff 76 6c 48 8b 15 8f a2 0d 00 f7 d8 64 89 02 48 83
RSP: 002b:00007ffeec16bd38 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: 0000000000000088 RBX: 0000000000000002 RCX: 00007ff39ec27b6a
RDX: 00000000000000ff RSI: 0000561d21dae950 RDI: 0000000000000000
RBP: 0000561d21dae910 R08: 0000000000000001 R09: 0000000000000000
R10: 00007ff39edc63a3 R11: 0000000000000246 R12: 0000561d21dae999
R13: 0000561d21dae950 R14: 0000000000000000 R15: 00007ff39ee04a80
 </TASK>


Tested on:

commit:         3aaa8ce7 Merge tag 'mm-hotfixes-stable-2024-03-07-16-1..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=14ee84d1180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=165e1d0fff4d3c47
dashboard link: https://syzkaller.appspot.com/bug?extid=e5167d7144a62715044c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1242f756180000


