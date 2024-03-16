Return-Path: <linux-kernel+bounces-105155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2466C87D9CD
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 11:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F809B2126E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 10:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F1811CAB;
	Sat, 16 Mar 2024 10:54:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F261094E
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 10:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710586444; cv=none; b=FXPkZz2Xvkod/JGpp4Gm9DNk+AzmkNOEGSXuJ8GOciW2R4YdtteFUpg2lI21rgJ+5Xgwg0prethVUBuPaQThZLxTnVg5XcNt141PbIHf7I5wuwuQYEanKG/c3/ey7ZfafqGZ6OAvKRX0c4byZo+1Tm8SsKl7x9N2txx4TI6cIKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710586444; c=relaxed/simple;
	bh=i7BeUgC3Y8PcPKOUQWiMIezjcOSBFL3Kl4cXU8BbhMc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QiknpiXRjnfOmDEm4TMCyz77U4goMHWLbs8+qQi9rlDHQ1Y5gaxJTdlDAGvnX4cFnBfh4zSYpGyu9uGW3A53stC6SHhr7vxXoYFKBtiF8vA9cRZzKPC5hswaIDX1x4mTemVVdz1crloV8ejF229PnMn3/IKZQ/LtgG4RkExD6iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cbfd4781fcso124773339f.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 03:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710586442; x=1711191242;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UIPfs1nUMe7uwNCUHoiwURcICvUH8WrNXUBDkI/pqNc=;
        b=Ygbbd3d0kpj0er9oW8cx2JnTHBy9GWd/eG4q3FlTPS/LBT87FkY1xOUZFl19IH6tHO
         oAPAKKfifX1VRlrKqN6M5Zmyv6OxLFx8G38zbH91aTXylCauUPXHo3EkeV2zfGQFazpy
         USaWgZdnbRkKttW6mnEr9gEmGury/LWgghtRqbQer5D7MHF2kvRaujfPFZvBt5sda2za
         oLRh0EDJNyCLMfv00TB+6VxyeSHQRV0+Lo1cwklGIFp7uRJDt2iBM6cPMHJC9adYKEUi
         6eUw53/vceEJS+UPwL2/HlQ2sDyayEu9eHWj1E6kyjIEHfbm04EkGkYIzYjDh/avG1Iz
         gL5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUurgpJqevFjsTS8fB8XcqMVjod/wossDYdnk+6YYyGLBKvyhRV4BjBA+6Ffr8m8Tq4GEm9EjZbndXyA10VGne9cBMlnPhgJeHwogf7
X-Gm-Message-State: AOJu0YwUK1grOEEu0ZyC7VlkjSRC+wOQXHVIzjyxuU6RsTRPiDWuKrSQ
	pQ+Pp7ru6mw6pN7YZ2hMSEoKWRi0w4DWH3/IR7s2765+/zAoWOlhFlK0n8ZlJ/Rn9sgSFX5IICD
	Pbc4LxAx8AnihZCR2Wq3IgJgaRgif7ov46rQpwdWeqEoZqoTJNBwmPvA=
X-Google-Smtp-Source: AGHT+IGNh4GjvOJdaSNLSyOheGGSvyV1QJuu0aHTDS8Ocz4KqFZ+aEDyQAJ7G2gumEaGMaAH/tJZzU2qjaOhXy78PeRbfiy+HtXA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:25c7:b0:477:3027:ed77 with SMTP id
 u7-20020a05663825c700b004773027ed77mr291621jat.1.1710586441954; Sat, 16 Mar
 2024 03:54:01 -0700 (PDT)
Date: Sat, 16 Mar 2024 03:54:01 -0700
In-Reply-To: <20240316090031.1922-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003b06860613c4f1ae@google.com>
Subject: Re: [syzbot] [netfilter?] KASAN: slab-use-after-free Read in ip_skb_dst_mtu
From: syzbot <syzbot+e5167d7144a62715044c@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in devinet_ioctl

INFO: task dhcpcd:4738 blocked for more than 143 seconds.
      Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:dhcpcd          state:D stack:20440 pid:4738  tgid:4738  ppid:4737   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5409 [inline]
 __schedule+0x17d3/0x4a20 kernel/sched/core.c:6736
 __schedule_loop kernel/sched/core.c:6813 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6828
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6885
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 devinet_ioctl+0x2ce/0x1bc0 net/ipv4/devinet.c:1096
 inet_ioctl+0x3d7/0x4f0 net/ipv4/af_inet.c:1001
 sock_do_ioctl+0x158/0x460 net/socket.c:1222
 sock_ioctl+0x629/0x8e0 net/socket.c:1341
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:904 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:890
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f7c316dcd49
RSP: 002b:00007fff890d63f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f7c3160e6c0 RCX: 00007f7c316dcd49
RDX: 00007fff890e65e8 RSI: 0000000000008914 RDI: 0000000000000018
RBP: 00007fff890f67a8 R08: 00007fff890e65a8 R09: 00007fff890e6558
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff890e65e8 R14: 0000000000000028 R15: 0000000000008914
 </TASK>
INFO: task kworker/0:4:5082 blocked for more than 143 seconds.
      Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:4     state:D stack:20816 pid:5082  tgid:5082  ppid:2      flags:0x00004000
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
INFO: task kworker/1:4:5466 blocked for more than 143 seconds.
      Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:4     state:D stack:22680 pid:5466  tgid:5466  ppid:2      flags:0x00004000
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
INFO: task syz-executor.0:14960 blocked for more than 143 seconds.
      Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:24632 pid:14960 tgid:14960 ppid:1      flags:0x00000006
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
RIP: 0033:0x7fe09e27fa9c
RSP: 002b:00007fff8336bc70 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007fe09eed4620 RCX: 00007fe09e27fa9c
RDX: 0000000000000028 RSI: 00007fe09eed4670 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007fff8336bcc4 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
R13: 0000000000000000 R14: 00007fe09eed4670 R15: 0000000000000000
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/29:
 #0: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #0: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #0: ffffffff8e132020 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6614
5 locks held by kworker/u8:2/42:
 #0: ffff888015acd948 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3229 [inline]
 #0: ffff888015acd948 ((wq_completion)netns){+.+.}-{0:0}, at: process_scheduled_works+0x8e0/0x1770 kernel/workqueue.c:3335
 #1: ffffc90000b27d00 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3230 [inline]
 #1: ffffc90000b27d00 (net_cleanup_work){+.+.}-{0:0}, at: process_scheduled_works+0x91b/0x1770 kernel/workqueue.c:3335
 #2: ffffffff8f381410 (pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+0x16a/0xcc0 net/core/net_namespace.c:591
 #3: ffffffff8f38da88 (rtnl_mutex){+.+.}-{3:3}, at: cleanup_net+0x6af/0xcc0 net/core/net_namespace.c:627
 #4: ffffffff8e137280 (rcu_state.barrier_mutex){+.+.}-{3:3}, at: rcu_barrier+0x4c/0x550 kernel/rcu/tree.c:4073
3 locks held by kworker/u8:6/2456:
 #0: ffff888029e26948 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3229 [inline]
 #0: ffff888029e26948 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_scheduled_works+0x8e0/0x1770 kernel/workqueue.c:3335
 #1: ffffc9000a44fd00 ((work_completion)(&(&net->ipv6.addr_chk_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3230 [inline]
 #1: ffffc9000a44fd00 ((work_completion)(&(&net->ipv6.addr_chk_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x91b/0x1770 kernel/workqueue.c:3335
 #2: ffffffff8f38da88 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_verify_work+0x19/0x30 net/ipv6/addrconf.c:4731
1 lock held by dhcpcd/4738:
 #0: ffffffff8f38da88 (rtnl_mutex){+.+.}-{3:3}, at: devinet_ioctl+0x2ce/0x1bc0 net/ipv4/devinet.c:1096
2 locks held by getty/4822:
 #0: ffff88802aa950a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f1e2f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6b5/0x1e10 drivers/tty/n_tty.c:2201
3 locks held by kworker/0:4/5082:
 #0: ffff888014c78948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3229 [inline]
 #0: ffff888014c78948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x8e0/0x1770 kernel/workqueue.c:3335
 #1: ffffc90003f47d00 (deferred_process_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3230 [inline]
 #1: ffffc90003f47d00 (deferred_process_work){+.+.}-{0:0}, at: process_scheduled_works+0x91b/0x1770 kernel/workqueue.c:3335
 #2: ffffffff8f38da88 (rtnl_mutex){+.+.}-{3:3}, at: switchdev_deferred_process_work+0xe/0x20 net/switchdev/switchdev.c:104
3 locks held by kworker/1:4/5466:
 #0: ffff888014c78948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3229 [inline]
 #0: ffff888014c78948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x8e0/0x1770 kernel/workqueue.c:3335
 #1: ffffc9000518fd00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3230 [inline]
 #1: ffffc9000518fd00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_scheduled_works+0x91b/0x1770 kernel/workqueue.c:3335
 #2: ffffffff8f38da88 (rtnl_mutex){+.+.}-{3:3}, at: linkwatch_event+0xe/0x60 net/core/link_watch.c:276
1 lock held by syz-executor.0/14960:
 #0: ffffffff8f38da88 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8f38da88 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x842/0x10d0 net/core/rtnetlink.c:6592
1 lock held by syz-executor.0/14964:
 #0: ffffffff8f38da88 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8f38da88 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x842/0x10d0 net/core/rtnetlink.c:6592
1 lock held by syz-executor.0/14970:
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
CPU: 0 PID: 4513 Comm: klogd Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
RIP: 0010:__sanitizer_cov_trace_switch+0x6f/0x120
Code: 48 83 f8 07 0f 85 ba 00 00 00 41 b8 07 00 00 00 4d 85 d2 75 24 e9 aa 00 00 00 41 b8 01 00 00 00 4d 85 d2 75 14 e9 9a 00 00 00 <41> b8 05 00 00 00 4d 85 d2 0f 84 8b 00 00 00 4c 8b 4c 24 20 65 4c
RSP: 0018:ffffc900031b7178 EFLAGS: 00000246
RAX: 0000000000000003 RBX: 0000000000000002 RCX: ffff888074001e00
RDX: ffffffff900811d8 RSI: ffffffff8dfa0870 RDI: 0000000000000002
RBP: ffffffff900811dd R08: 0000000000000005 R09: ffffffff8140972e
R10: 0000000000000003 R11: ffff888074001e00 R12: ffffffff900811dc
R13: dffffc0000000000 R14: ffffc900031b7330 R15: 1ffff92000636e5c
FS:  00007f992938b380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f99d96ba070 CR3: 000000002d988000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 unwind_next_frame+0xff6/0x2a00 arch/x86/kernel/unwind_orc.c:581
 __unwind_start+0x641/0x7c0 arch/x86/kernel/unwind_orc.c:760
 unwind_start arch/x86/include/asm/unwind.h:64 [inline]
 arch_stack_walk+0x103/0x1b0 arch/x86/kernel/stacktrace.c:24
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:3966 [inline]
 __kmalloc_node_track_caller+0x24e/0x4e0 mm/slub.c:3986
 kmalloc_reserve+0x111/0x2a0 net/core/skbuff.c:599
 __alloc_skb+0x1f3/0x440 net/core/skbuff.c:668
 alloc_skb include/linux/skbuff.h:1318 [inline]
 alloc_skb_with_frags+0xc3/0x770 net/core/skbuff.c:6504
 sock_alloc_send_pskb+0x91a/0xa60 net/core/sock.c:2795
 unix_dgram_sendmsg+0x6d3/0x1f80 net/unix/af_unix.c:2019
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 __sys_sendto+0x3a4/0x4f0 net/socket.c:2191
 __do_sys_sendto net/socket.c:2203 [inline]
 __se_sys_sendto net/socket.c:2199 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2199
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f99294ed9b5
Code: 8b 44 24 08 48 83 c4 28 48 98 c3 48 98 c3 41 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 26 45 31 c9 45 31 c0 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 76 7a 48 8b 15 44 c4 0c 00 f7 d8 64 89 02 48 83
RSP: 002b:00007ffebdf27bf8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f99294ed9b5
RDX: 000000000000004f RSI: 000055ca0c2e0230 RDI: 0000000000000003
RBP: 000055ca0c2da910 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000004000 R11: 0000000000000246 R12: 0000000000000013
R13: 00007f992967b212 R14: 00007ffebdf27cf8 R15: 0000000000000000
 </TASK>


Tested on:

commit:         fe46a7dd Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=107731be180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe78468a74fdc3b7
dashboard link: https://syzkaller.appspot.com/bug?extid=e5167d7144a62715044c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=151d8aa5180000


