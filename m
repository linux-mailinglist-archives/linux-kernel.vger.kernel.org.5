Return-Path: <linux-kernel+bounces-24001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCFB82B514
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 20:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63B871F257CA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 19:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A46E55C2E;
	Thu, 11 Jan 2024 19:08:29 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350BE54BD7
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 19:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7bef67c486aso199676439f.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 11:08:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705000105; x=1705604905;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8kVsg7p0HHxIk12aVdP3dBN3Rda5J0erJo1PNnuorUo=;
        b=tlnOKX41l95HqvC6wkWvSP06p8HIx19i+kTDMRPBFjKIZg7bWjwrUoSathoGQK09j2
         Ch1eLDxjeo5GGjEFJw/Uy5EPER+bZGAwknEAdHjCSq1KDn5ZfELNKWiMAPcMpLDMz+IF
         PqL+dRdyzaT9uTqvGrOXQ/iKVSI9iB5Pgb/Bo4cggeoy6sUnDr3lqf4GVPvUpt6Ot+f2
         g5rk/3+NOn2HyHrc2i4mvhm1l9D91rGSX2Y/Chl+TnaenwsH5aVo/4BJ5Co2LXHFvY7w
         +1is9qlUkE69aWJe45HHfW3XxKivwhNXwhqFggRuBwZmU/asaci1PNRVIz07IyYEy6i7
         BepA==
X-Gm-Message-State: AOJu0Yw9g70MdlaLuUhzVhEeFGKKz4+sWT+Sy6JidW+qKQ9Kqw3wj7Q0
	dFpdtqhCDrZ1rOe7EgXamfQfWi7XznuVQnpjxPLiBmLZgB6b
X-Google-Smtp-Source: AGHT+IHeCpuhKL84HtWrKuHD4tCoJ3NwPu9/qLDkxY5rrchuIjX+PxkaHoWLl90JJHooxjqePIhKknN2OT6w9RN3leS6K+UAu9Yk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1515:b0:46e:3965:4513 with SMTP id
 b21-20020a056638151500b0046e39654513mr4038jat.6.1705000105425; Thu, 11 Jan
 2024 11:08:25 -0800 (PST)
Date: Thu, 11 Jan 2024 11:08:25 -0800
In-Reply-To: <00000000000026100c060e143e5a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a041b0060eb045ec@google.com>
Subject: Re: [syzbot] [net?] [nfc?] INFO: task hung in nfc_targets_found
From: syzbot <syzbot+2b131f51bb4af224ab40@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, gregkh@linuxfoundation.org, 
	hdanton@sina.com, krzysztof.kozlowski@linaro.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	penguin-kernel@i-love.sakura.ne.jp, stern@rowland.harvard.edu, 
	syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    acc657692aed keys, dns: Fix size check of V1 server-list h..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10c95b33e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5c882ebde8a5f3b4
dashboard link: https://syzkaller.appspot.com/bug?extid=2b131f51bb4af224ab40
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=103698bde80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1617e0fbe80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/015b89b33490/disk-acc65769.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5e0949d278bb/vmlinux-acc65769.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0fc2cb65191a/bzImage-acc65769.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2b131f51bb4af224ab40@syzkaller.appspotmail.com

INFO: task kworker/u4:2:38 blocked for more than 143 seconds.
      Not tainted 6.7.0-syzkaller-02320-gacc657692aed #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u4:2    state:D stack:22728 pid:38    tgid:38    ppid:2      flags:0x00004000
Workqueue: nfc3_nci_rx_wq nci_rx_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5399 [inline]
 __schedule+0x177f/0x4960 kernel/sched/core.c:6726
 __schedule_loop kernel/sched/core.c:6801 [inline]
 schedule+0x149/0x260 kernel/sched/core.c:6816
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6873
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a3/0xd60 kernel/locking/mutex.c:752
 device_lock include/linux/device.h:992 [inline]
 nfc_targets_found+0x26f/0x590 net/nfc/core.c:778
 nci_ntf_packet+0x4431/0x4f40
 nci_rx_work+0x14c/0x2b0 net/nfc/nci/core.c:1522
 process_one_work kernel/workqueue.c:2633 [inline]
 process_scheduled_works+0x90f/0x1420 kernel/workqueue.c:2706
 worker_thread+0xa5f/0x1000 kernel/workqueue.c:2787
 kthread+0x2d3/0x370 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>
INFO: task kworker/1:2:927 blocked for more than 143 seconds.
      Not tainted 6.7.0-syzkaller-02320-gacc657692aed #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:2     state:D stack:24400 pid:927   tgid:927   ppid:2      flags:0x00004000
Workqueue: events nfc_urelease_event_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5399 [inline]
 __schedule+0x177f/0x4960 kernel/sched/core.c:6726
 __schedule_loop kernel/sched/core.c:6801 [inline]
 schedule+0x149/0x260 kernel/sched/core.c:6816
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6873
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a3/0xd60 kernel/locking/mutex.c:752
 nfc_urelease_event_work+0x111/0x2f0 net/nfc/netlink.c:1849
 process_one_work kernel/workqueue.c:2633 [inline]
 process_scheduled_works+0x90f/0x1420 kernel/workqueue.c:2706
 worker_thread+0xa5f/0x1000 kernel/workqueue.c:2787
 kthread+0x2d3/0x370 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>
INFO: task syz-executor393:5158 blocked for more than 143 seconds.
      Not tainted 6.7.0-syzkaller-02320-gacc657692aed #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor393 state:D stack:25488 pid:5158  tgid:5158  ppid:5119   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5399 [inline]
 __schedule+0x177f/0x4960 kernel/sched/core.c:6726
 __schedule_loop kernel/sched/core.c:6801 [inline]
 schedule+0x149/0x260 kernel/sched/core.c:6816
 schedule_timeout+0xb0/0x300 kernel/time/timer.c:2159
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common kernel/sched/completion.c:116 [inline]
 wait_for_common kernel/sched/completion.c:127 [inline]
 wait_for_completion+0x354/0x620 kernel/sched/completion.c:148
 __flush_workqueue+0x730/0x1630 kernel/workqueue.c:3198
 nci_close_device+0x193/0x600 net/nfc/nci/core.c:579
 nci_unregister_device+0x40/0x240 net/nfc/nci/core.c:1297
 virtual_ncidev_close+0x59/0x90 drivers/nfc/virtual_ncidev.c:168
 __fput+0x428/0x890 fs/file_table.c:382
 __do_sys_close fs/open.c:1554 [inline]
 __se_sys_close fs/open.c:1539 [inline]
 __x64_sys_close+0x7e/0x100 fs/open.c:1539
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f2bd642ca9a
RSP: 002b:00007ffc00a39ae0 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f2bd642ca9a
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 0000000000104645 R08: 0000000000000000 R09: 00007ffc00a39bb0
R10: 0000000000000000 R11: 0000000000000293 R12: 00007f2bd64bd1fc
R13: 00007ffc00a39b40 R14: 00007f2bd63f60b0 R15: 00007ffc00a39bb0
 </TASK>
INFO: task syz-executor393:5159 blocked for more than 144 seconds.
      Not tainted 6.7.0-syzkaller-02320-gacc657692aed #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor393 state:D stack:25576 pid:5159  tgid:5158  ppid:5119   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5399 [inline]
 __schedule+0x177f/0x4960 kernel/sched/core.c:6726
 __schedule_loop kernel/sched/core.c:6801 [inline]
 schedule+0x149/0x260 kernel/sched/core.c:6816
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6873
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a3/0xd60 kernel/locking/mutex.c:752
 nci_request net/nfc/nci/core.c:149 [inline]
 nci_start_poll+0xa30/0xf30 net/nfc/nci/core.c:854
 nfc_start_poll+0x188/0x300 net/nfc/core.c:225
 nfc_genl_start_poll+0x1eb/0x350 net/nfc/netlink.c:828
 genl_family_rcv_msg_doit net/netlink/genetlink.c:972 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1052 [inline]
 genl_rcv_msg+0xacf/0xe40 net/netlink/genetlink.c:1067
 netlink_rcv_skb+0x1df/0x430 net/netlink/af_netlink.c:2545
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1076
 netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
 netlink_unicast+0x7e6/0x980 net/netlink/af_netlink.c:1368
 netlink_sendmsg+0xa37/0xd70 net/netlink/af_netlink.c:1910
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0x592/0x890 net/socket.c:2584
 ___sys_sendmsg net/socket.c:2638 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f2bd642db49
RSP: 002b:00007f2bd63e7138 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000008 RCX: 00007f2bd642db49
RDX: 0000000000000000 RSI: 0000000020000440 RDI: 0000000000000005
RBP: 0000000000000003 R08: 0000000000000003 R09: 0000000000000000
R10: 0000000000000008 R11: 0000000000000246 R12: 0000000000000008
R13: 0000000000000000 R14: 00007ffc00a39930 R15: 00007ffc00a39a18
 </TASK>
INFO: task kworker/0:3:5161 blocked for more than 144 seconds.
      Not tainted 6.7.0-syzkaller-02320-gacc657692aed #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:3     state:D stack:24328 pid:5161  tgid:5161  ppid:2      flags:0x00004000
Workqueue: events nfc_urelease_event_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5399 [inline]
 __schedule+0x177f/0x4960 kernel/sched/core.c:6726
 __schedule_loop kernel/sched/core.c:6801 [inline]
 schedule+0x149/0x260 kernel/sched/core.c:6816
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6873
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a3/0xd60 kernel/locking/mutex.c:752
 nfc_urelease_event_work+0xa7/0x2f0 net/nfc/netlink.c:1843
 process_one_work kernel/workqueue.c:2633 [inline]
 process_scheduled_works+0x90f/0x1420 kernel/workqueue.c:2706
 worker_thread+0xa5f/0x1000 kernel/workqueue.c:2787
 kthread+0x2d3/0x370 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>
INFO: task syz-executor393:5165 blocked for more than 144 seconds.
      Not tainted 6.7.0-syzkaller-02320-gacc657692aed #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor393 state:D stack:25808 pid:5165  tgid:5164  ppid:5122   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5399 [inline]
 __schedule+0x177f/0x4960 kernel/sched/core.c:6726
 __schedule_loop kernel/sched/core.c:6801 [inline]
 schedule+0x149/0x260 kernel/sched/core.c:6816
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6873
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a3/0xd60 kernel/locking/mutex.c:752
 genl_lock net/netlink/genetlink.c:33 [inline]
 genl_op_lock net/netlink/genetlink.c:58 [inline]
 genl_rcv_msg+0x121/0xe40 net/netlink/genetlink.c:1066
 netlink_rcv_skb+0x1df/0x430 net/netlink/af_netlink.c:2545
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1076
 netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
 netlink_unicast+0x7e6/0x980 net/netlink/af_netlink.c:1368
 netlink_sendmsg+0xa37/0xd70 net/netlink/af_netlink.c:1910
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0x592/0x890 net/socket.c:2584
 ___sys_sendmsg net/socket.c:2638 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f2bd642db49
RSP: 002b:00007f2bd63e7138 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000008 RCX: 00007f2bd642db49
RDX: 0000000000000000 RSI: 0000000020000440 RDI: 0000000000000005
RBP: 0000000000000003 R08: 0000000000000003 R09: 0000000000000000
R10: 0000000000000008 R11: 0000000000000246 R12: 0000000000000008
R13: 0000000000000000 R14: 00007ffc00a39930 R15: 00007ffc00a39a18
 </TASK>
INFO: task syz-executor393:5175 blocked for more than 145 seconds.
      Not tainted 6.7.0-syzkaller-02320-gacc657692aed #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor393 state:D stack:27632 pid:5175  tgid:5164  ppid:5122   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5399 [inline]
 __schedule+0x177f/0x4960 kernel/sched/core.c:6726
 __schedule_loop kernel/sched/core.c:6801 [inline]
 schedule+0x149/0x260 kernel/sched/core.c:6816
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6873
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a3/0xd60 kernel/locking/mutex.c:752
 nfc_unregister_device+0x175/0x2a0 net/nfc/core.c:1181
 virtual_ncidev_close+0x59/0x90 drivers/nfc/virtual_ncidev.c:168
 __fput+0x428/0x890 fs/file_table.c:382
 task_work_run+0x24a/0x300 kernel/task_work.c:180
 get_signal+0x166e/0x1840 kernel/signal.c:2669
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:309
 exit_to_user_mode_loop kernel/entry/common.c:105 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:201 [inline]
 syscall_exit_to_user_mode+0xc8/0x370 kernel/entry/common.c:212
 do_syscall_64+0x102/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f2bd642db49
RSP: 002b:00007f2bd63c6138 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: fffffffffffffff2 RBX: 00007f2bd64bd1f8 RCX: 00007f2bd642db49
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007f2bd64bd1f0 R08: 00007f2bd63c66c0 R09: 0000000000000000
R10: 00007f2bd63c66c0 R11: 0000000000000246 R12: 00007f2bd64bd1fc
R13: 000000000000006e R14: 00007ffc00a39930 R15: 00007ffc00a39a18
 </TASK>
INFO: task syz-executor393:5170 blocked for more than 145 seconds.
      Not tainted 6.7.0-syzkaller-02320-gacc657692aed #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor393 state:D stack:24816 pid:5170  tgid:5169  ppid:5118   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5399 [inline]
 __schedule+0x177f/0x4960 kernel/sched/core.c:6726
 __schedule_loop kernel/sched/core.c:6801 [inline]
 schedule+0x149/0x260 kernel/sched/core.c:6816
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6873
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a3/0xd60 kernel/locking/mutex.c:752
 genl_lock net/netlink/genetlink.c:33 [inline]
 genl_op_lock net/netlink/genetlink.c:58 [inline]
 genl_rcv_msg+0x121/0xe40 net/netlink/genetlink.c:1066
 netlink_rcv_skb+0x1df/0x430 net/netlink/af_netlink.c:2545
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1076
 netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
 netlink_unicast+0x7e6/0x980 net/netlink/af_netlink.c:1368
 netlink_sendmsg+0xa37/0xd70 net/netlink/af_netlink.c:1910
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0x592/0x890 net/socket.c:2584
 ___sys_sendmsg net/socket.c:2638 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f2bd642db49
RSP: 002b:00007f2bd63e7138 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f2bd64bd1e8 RCX: 00007f2bd642db49
RDX: 0000000000000000 RSI: 0000000020000140 RDI: 0000000000000005
RBP: 00007f2bd64bd1e0 R08: 00007f2bd63e76c0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f2bd64bd1ec
R13: 0000000000000011 R14: 00007ffc00a39930 R15: 00007ffc00a39a18
 </TASK>
INFO: task syz-executor393:5183 blocked for more than 145 seconds.
      Not tainted 6.7.0-syzkaller-02320-gacc657692aed #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor393 state:D stack:26864 pid:5183  tgid:5169  ppid:5118   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5399 [inline]
 __schedule+0x177f/0x4960 kernel/sched/core.c:6726
 __schedule_loop kernel/sched/core.c:6801 [inline]
 schedule+0x149/0x260 kernel/sched/core.c:6816
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6873
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a3/0xd60 kernel/locking/mutex.c:752
 nfc_unregister_device+0x175/0x2a0 net/nfc/core.c:1181
 virtual_ncidev_close+0x59/0x90 drivers/nfc/virtual_ncidev.c:168
 __fput+0x428/0x890 fs/file_table.c:382
 task_work_run+0x24a/0x300 kernel/task_work.c:180
 get_signal+0x166e/0x1840 kernel/signal.c:2669
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:309
 exit_to_user_mode_loop kernel/entry/common.c:105 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:201 [inline]
 syscall_exit_to_user_mode+0xc8/0x370 kernel/entry/common.c:212
 do_syscall_64+0x102/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f2bd642db49
RSP: 002b:00007f2bd63c6138 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: fffffffffffffff2 RBX: 00007f2bd64bd1f8 RCX: 00007f2bd642db49
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007f2bd64bd1f0 R08: 00007f2bd63c66c0 R09: 0000000000000000
R10: 00007ffc00a39a17 R11: 0000000000000246 R12: 00007f2bd64bd1fc
R13: 000000000000006e R14: 00007ffc00a39930 R15: 00007ffc00a39a18
 </TASK>
INFO: task syz-executor393:5189 blocked for more than 146 seconds.
      Not tainted 6.7.0-syzkaller-02320-gacc657692aed #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor393 state:D stack:28176 pid:5189  tgid:5169  ppid:5118   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5399 [inline]
 __schedule+0x177f/0x4960 kernel/sched/core.c:6726
 __schedule_loop kernel/sched/core.c:6801 [inline]
 schedule+0x149/0x260 kernel/sched/core.c:6816
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6873
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a3/0xd60 kernel/locking/mutex.c:752
 genl_lock net/netlink/genetlink.c:33 [inline]
 genl_op_lock net/netlink/genetlink.c:58 [inline]
 genl_rcv_msg+0x121/0xe40 net/netlink/genetlink.c:1066
 netlink_rcv_skb+0x1df/0x430 net/netlink/af_netlink.c:2545
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1076
 netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
 netlink_unicast+0x7e6/0x980 net/netlink/af_netlink.c:1368
 netlink_sendmsg+0xa37/0xd70 net/netlink/af_netlink.c:1910
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0x592/0x890 net/socket.c:2584
 ___sys_sendmsg net/socket.c:2638 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f2bd642db49
RSP: 002b:00007f2bd63a5138 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000008 RCX: 00007f2bd642db49
RDX: 0000000000000000 RSI: 0000000020000440 RDI: 0000000000000005
RBP: 0000000000000003 R08: 0000000000000003 R09: 0000000000000000
R10: 0000000000000008 R11: 0000000000000246 R12: 0000000000000008
R13: 0000000000000000 R14: 00007ffc00a39930 R15: 00007ffc00a39a18
 </TASK>
Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings
INFO: lockdep is turned off.
NMI backtrace for cpu 0
CPU: 0 PID: 29 Comm: khungtaskd Not tainted 6.7.0-syzkaller-02320-gacc657692aed #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x498/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x310 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xfaf/0xff0 kernel/hung_task.c:379
 kthread+0x2d3/0x370 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 49 Comm: kworker/u4:3 Not tainted 6.7.0-syzkaller-02320-gacc657692aed #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Workqueue: events_unbound cfg80211_wiphy_work
RIP: 0010:check_kcov_mode kernel/kcov.c:173 [inline]
RIP: 0010:write_comp_data kernel/kcov.c:236 [inline]
RIP: 0010:__sanitizer_cov_trace_switch+0xa3/0x110 kernel/kcov.c:341
Code: 84 8a 00 00 00 4c 8b 4c 24 20 65 4c 8b 1d 05 db 74 7e 31 d2 eb 08 48 ff c2 49 39 d2 74 71 4c 8b 74 d6 10 65 8b 05 f5 da 74 7e <a9> 00 01 ff 00 74 11 a9 00 01 00 00 74 de 41 83 bb fc 15 00 00 00
RSP: 0018:ffffc90000b9f198 EFLAGS: 00000202
RAX: 0000000080000000 RBX: 0000000000000028 RCX: ffff888013f18000
RDX: 0000000000000003 RSI: ffffffff8edb9710 RDI: 0000000000000000
RBP: ffffc90000b9f5d0 R08: 0000000000000001 R09: ffffffff8aa108e3
R10: 0000000000000028 R11: ffff888013f18000 R12: 0000000000000008
R13: dffffc0000000000 R14: 0000000000000003 R15: ffff888026966474
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005562339c8600 CR3: 000000000d732000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 _ieee802_11_parse_elems_full+0x6f3/0x4340 net/mac80211/util.c:1049
 ieee802_11_parse_elems_full+0xd47/0x2470 net/mac80211/util.c:1647
 ieee802_11_parse_elems_crc net/mac80211/ieee80211_i.h:2288 [inline]
 ieee802_11_parse_elems net/mac80211/ieee80211_i.h:2295 [inline]
 ieee80211_rx_mgmt_probe_beacon net/mac80211/ibss.c:1573 [inline]
 ieee80211_ibss_rx_queued_mgmt+0x4b3/0x2d30 net/mac80211/ibss.c:1604
 ieee80211_iface_process_skb net/mac80211/iface.c:1589 [inline]
 ieee80211_iface_work+0x805/0xd90 net/mac80211/iface.c:1643
 cfg80211_wiphy_work+0x21e/0x250 net/wireless/core.c:437
 process_one_work kernel/workqueue.c:2633 [inline]
 process_scheduled_works+0x90f/0x1420 kernel/workqueue.c:2706
 worker_thread+0xa5f/0x1000 kernel/workqueue.c:2787
 kthread+0x2d3/0x370 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.624 msecs


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

