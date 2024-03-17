Return-Path: <linux-kernel+bounces-105375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FA187DCF4
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 11:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89BEF1C209B4
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 10:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1B617BDC;
	Sun, 17 Mar 2024 10:31:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6A0FC1D
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 10:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710671465; cv=none; b=BgCYpfoMa+HVjTaw8sgZj5r0LHN73oWXqvGzWS7i4/U6GOjknR4i+FaLKEUhyB6iv9z/GU40GgMHvUNLI7c1kimPCoJpI4vkykC+mCS4p4gdPznHupFhp5a0i7zGQ5aB4hniOpdPyPJ3ZPoEUsuLGk9Hjh3KdRWq+XhEvlu+gj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710671465; c=relaxed/simple;
	bh=Y9F5q9G9VY+1JHl4XJ9ZO4krF9niR+jAM91fQ0bb5xc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hiC/7YWxuBL+cTyG97T4m6hsEPNZ+YgTnO0LriDecFviqKRJ+83EVhbvi4DDUvLm8fADu9l3frZ4Ncsh3b4M1568jWGravXAfVafZVoBby0IaR0B9L+uvl4X5PqCwEhc7JDVNiRVF2Q2xrW0ejG67QsLjz3nufEOzqNgUXUEeAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c8a6a122b5so314267639f.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 03:31:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710671462; x=1711276262;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nof/MbW3RPu9461fHgertmM5dP6XoPyCNSD/I7blmJw=;
        b=te6RBRXDLCS+wtxnCsLaFaQPGb5qurYtUmXpKvpn+79te/JbGUgKewlz3uomvvLDqH
         nrHjNrp52VDiUDHMd+drGsTt321iln/LKOS1bBdaJUNuBOFJSN7nK0LnAkd57lGtAujg
         G3QTQSyYBdT7SXfdkVKk1dQesgqG1xdcck+ms9mMe02u5UY7z46nAp76LWf9+2mnShVy
         nCKMeOrBX27x9Bx+g5H9Ossv5CHgojRLYJOkh+eqL4Xf/m6M/0kMwnmHZI6rPlGI2v3S
         zU/FaWYMnN9UEJBoKi7o5xwqAnvVSPHTYrdk4+f6WBJBkJB0PbBCDRTjH+eUXg4H0pft
         K6Jw==
X-Forwarded-Encrypted: i=1; AJvYcCWs6osWIOf9s97kzdK79OhGwY7h819Zv5xDNOyF30vsORccNWWq8eGjCIWyVOIegOBbK6S1NVjQz54YZciWF1TreIzDkTCxLWnmYCn5
X-Gm-Message-State: AOJu0Yx5tKM4NpQtNG5lLM2M360C3zrcij1T7LXn4fcVVRkZi1QlM5cU
	UD4kn6iUScIjDHp+G2Q4vyK+Wx0B+MbUZxvbOdjRJkoI9O4Sn9BXWfz/vx3xvviVAwijHLf212b
	vtaU8Km83Nt45rSjNZWWFEUITUuiGABXeckPZG/c3vtkij+6FvFOJj9U=
X-Google-Smtp-Source: AGHT+IGYgLnjCfEFuJY8TpBNF4GRHxtjvoCqe+n8Hxl65i8equTAsg02StPJaD8THIMssr4/gkJTcDT2ARYFR9JoGywCI4kSGEP/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1646:b0:7cc:838:7f3a with SMTP id
 y6-20020a056602164600b007cc08387f3amr116802iow.1.1710671462387; Sun, 17 Mar
 2024 03:31:02 -0700 (PDT)
Date: Sun, 17 Mar 2024 03:31:02 -0700
In-Reply-To: <20240317100451.2053-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d7e3880613d8bcf9@google.com>
Subject: Re: [syzbot] [netfilter?] KASAN: slab-use-after-free Read in ip_skb_dst_mtu
From: syzbot <syzbot+e5167d7144a62715044c@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in linkwatch_event

INFO: task kworker/1:0:24 blocked for more than 143 seconds.
      Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:0     state:D stack:22672 pid:24    tgid:24    ppid:2      flags:0x00004000
Workqueue: events linkwatch_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5409 [inline]
 __schedule+0x17d3/0x4a20 kernel/sched/core.c:6736
 __schedule_loop kernel/sched/core.c:6813 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6828
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6885
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 linkwatch_event+0xe/0x60 net/core/link_watch.c:276
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 </TASK>
INFO: task kworker/1:1:44 blocked for more than 143 seconds.
      Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:1     state:D stack:20272 pid:44    tgid:44    ppid:2      flags:0x00004000
Workqueue: events switchdev_deferred_process_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5409 [inline]
 __schedule+0x17d3/0x4a20 kernel/sched/core.c:6736
 __schedule_loop kernel/sched/core.c:6813 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6828
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6885
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 switchdev_deferred_process_work+0xe/0x20 net/switchdev/switchdev.c:104
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 </TASK>
INFO: task dhcpcd:4737 blocked for more than 143 seconds.
      Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:dhcpcd          state:D stack:20888 pid:4737  tgid:4737  ppid:4736   flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5409 [inline]
 __schedule+0x17d3/0x4a20 kernel/sched/core.c:6736
 __schedule_loop kernel/sched/core.c:6813 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6828
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6885
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 netlink_dump+0x5d3/0xe50 net/netlink/af_netlink.c:2268
 netlink_recvmsg+0x6bb/0x11d0 net/netlink/af_netlink.c:1987
 sock_recvmsg_nosec net/socket.c:1046 [inline]
 sock_recvmsg+0x22f/0x280 net/socket.c:1068
 ____sys_recvmsg+0x1db/0x470 net/socket.c:2803
 ___sys_recvmsg net/socket.c:2845 [inline]
 __sys_recvmsg+0x2f0/0x3e0 net/socket.c:2875
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f412b50691e
RSP: 002b:00007ffdf9c62d68 EFLAGS: 00000246 ORIG_RAX: 000000000000002f
RAX: ffffffffffffffda RBX: 00007ffdf9c63e90 RCX: 00007f412b50691e
RDX: 0000000000000000 RSI: 00007ffdf9c63db0 RDI: 0000000000000018
RBP: 00007ffdf9c63e20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000101 R11: 0000000000000246 R12: 0000000000000f00
R13: 00007ffdf9c63d94 R14: 00007ffdf9c63db0 R15: 00007ffdf9c63da0
 </TASK>
INFO: task syz-executor.0:14939 blocked for more than 144 seconds.
      Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:24632 pid:14939 tgid:14939 ppid:1      flags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5409 [inline]
 __schedule+0x17d3/0x4a20 kernel/sched/core.c:6736
 __schedule_loop kernel/sched/core.c:6813 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6828
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6885
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 rtnl_lock net/core/rtnetlink.c:79 [inline]
 rtnetlink_rcv_msg+0x842/0x10d0 net/core/rtnetlink.c:6592
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2559
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x8e1/0xcb0 net/netlink/af_netlink.c:1905
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 __sys_sendto+0x3a4/0x4f0 net/socket.c:2191
 __do_sys_sendto net/socket.c:2203 [inline]
 __se_sys_sendto net/socket.c:2199 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2199
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7fa03a67fa9c
RSP: 002b:00007fffbd622ad0 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007fa03b2d4620 RCX: 00007fa03a67fa9c
RDX: 0000000000000028 RSI: 00007fa03b2d4670 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007fffbd622b24 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
R13: 0000000000000000 R14: 00007fa03b2d4670 R15: 0000000000000000
 </TASK>

Showing all locks held in the system:
3 locks held by kworker/1:0/24:
 #0: ffff888014c78948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3229 [inline]
 #0: ffff888014c78948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x8e0/0x1770 kernel/workqueue.c:3335
 #1: ffffc900001e7d00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3230 [inline]
 #1: ffffc900001e7d00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_scheduled_works+0x91b/0x1770 kernel/workqueue.c:3335
 #2: ffffffff8f38da88 (rtnl_mutex){+.+.}-{3:3}, at: linkwatch_event+0xe/0x60 net/core/link_watch.c:276
1 lock held by khungtaskd/29:
 #0: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #0: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #0: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6614
3 locks held by kworker/1:1/44:
 #0: ffff888014c78948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3229 [inline]
 #0: ffff888014c78948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x8e0/0x1770 kernel/workqueue.c:3335
 #1: ffffc90000b47d00 (deferred_process_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3230 [inline]
 #1: ffffc90000b47d00 (deferred_process_work){+.+.}-{0:0}, at: process_scheduled_works+0x91b/0x1770 kernel/workqueue.c:3335
 #2: ffffffff8f38da88 (rtnl_mutex){+.+.}-{3:3}, at: switchdev_deferred_process_work+0xe/0x20 net/switchdev/switchdev.c:104
3 locks held by kworker/u8:5/65:
 #0: ffff88802a4d8148 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3229 [inline]
 #0: ffff88802a4d8148 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_scheduled_works+0x8e0/0x1770 kernel/workqueue.c:3335
 #1: ffffc900015e7d00 ((work_completion)(&(&net->ipv6.addr_chk_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3230 [inline]
 #1: ffffc900015e7d00 ((work_completion)(&(&net->ipv6.addr_chk_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x91b/0x1770 kernel/workqueue.c:3335
 #2: ffffffff8f38da88 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_verify_work+0x19/0x30 net/ipv6/addrconf.c:4731
5 locks held by kworker/u8:6/1089:
 #0: ffff888015acd948 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3229 [inline]
 #0: ffff888015acd948 ((wq_completion)netns){+.+.}-{0:0}, at: process_scheduled_works+0x8e0/0x1770 kernel/workqueue.c:3335
 #1: ffffc90004d07d00 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3230 [inline]
 #1: ffffc90004d07d00 (net_cleanup_work){+.+.}-{0:0}, at: process_scheduled_works+0x91b/0x1770 kernel/workqueue.c:3335
 #2: ffffffff8f381410 (pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+0x16a/0xcc0 net/core/net_namespace.c:591
 #3: ffffffff8f38da88 (rtnl_mutex){+.+.}-{3:3}, at: cleanup_net+0x6af/0xcc0 net/core/net_namespace.c:627
 #4: ffffffff8e137280 (rcu_state.barrier_mutex){+.+.}-{3:3}, at: rcu_barrier+0x4c/0x550 kernel/rcu/tree.c:4074
2 locks held by dhcpcd/4737:
 #0: ffff888041854678 (nlk_cb_mutex-ROUTE){+.+.}-{3:3}, at: netlink_dump+0xcb/0xe50 net/netlink/af_netlink.c:2209
 #1: ffffffff8f38da88 (rtnl_mutex){+.+.}-{3:3}, at: netlink_dump+0x5d3/0xe50 net/netlink/af_netlink.c:2268
2 locks held by getty/4819:
 #0: ffff88802a54c0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc900031332f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6b5/0x1e10 drivers/tty/n_tty.c:2201
1 lock held by syz-executor.0/14939:
 #0: ffffffff8f38da88 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8f38da88 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x842/0x10d0 net/core/rtnetlink.c:6592
1 lock held by syz-executor.0/14942:
 #0: ffffffff8f38da88 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8f38da88 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x842/0x10d0 net/core/rtnetlink.c:6592
1 lock held by syz-executor.0/14949:
 #0: ffffffff8f38da88 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8f38da88 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x842/0x10d0 net/core/rtnetlink.c:6592

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 29 Comm: khungtaskd Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xfb0/0xff0 kernel/hung_task.c:379
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 10 Comm: kworker/u8:0 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Workqueue: events_unbound cfg80211_wiphy_work
RIP: 0010:__sanitizer_cov_trace_switch+0x83/0x120
Code: 24 e9 aa 00 00 00 41 b8 01 00 00 00 4d 85 d2 75 14 e9 9a 00 00 00 41 b8 05 00 00 00 4d 85 d2 0f 84 8b 00 00 00 4c 8b 4c 24 20 <65> 4c 8b 1c 25 80 d0 03 00 31 d2 eb 08 48 ff c2 49 39 d2 74 71 4c
RSP: 0018:ffffc900000f75a0 EFLAGS: 00000206
RAX: 0000000000000003 RBX: 0000000000000002 RCX: ffff8880172a9e00
RDX: ffffffff909a8172 RSI: ffffffff8dfa0870 RDI: 0000000000000002
RBP: ffffffff909a8177 R08: 0000000000000005 R09: ffffffff81409f66
R10: 0000000000000003 R11: ffff8880172a9e00 R12: ffffffff909a8176
R13: dffffc0000000000 R14: ffffc900000f76f0 R15: 1ffff9200001eed4
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2cc0ad5000 CR3: 000000000df32000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 unwind_next_frame+0xff6/0x2a00 arch/x86/kernel/unwind_orc.c:581
 arch_stack_walk+0x151/0x1b0 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xa6/0xe0 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2106 [inline]
 slab_free mm/slub.c:4280 [inline]
 kmem_cache_free+0x102/0x2b0 mm/slub.c:4344
 kfree_skb include/linux/skbuff.h:1267 [inline]
 ieee80211_iface_work+0x270/0xf10 net/mac80211/iface.c:1661
 cfg80211_wiphy_work+0x221/0x260 net/wireless/core.c:437
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 </TASK>


Tested on:

commit:         fe46a7dd Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1555fc3a180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe78468a74fdc3b7
dashboard link: https://syzkaller.appspot.com/bug?extid=e5167d7144a62715044c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17737946180000


