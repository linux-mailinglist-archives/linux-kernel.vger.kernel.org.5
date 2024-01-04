Return-Path: <linux-kernel+bounces-16163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D758239F3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 01:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC6B6B24A65
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 00:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B861865;
	Thu,  4 Jan 2024 00:59:28 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B7F5226
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 00:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-35fed23b27eso93850915ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 16:59:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704329965; x=1704934765;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yU8aTAho/la/2jmgxd/SKYnyY6RfB+tiAv63beqq4g4=;
        b=tvmAy773sQdaXuioVzsneq2a6riXep4WxJsLKEviSbzbXeaPhQirExuXsrZUkK3oJ2
         y1CFowDjjmAN984QLWj+szHSmcDcI+t60ZrlkYH6R7lcIYC7daKdBAqSnPCRhbtTS2eh
         hugR+wdP878NBrvmw6hBXyTZWWYmIWDh4zkN5p9h0mnIM4ZV/Y4ZyFzffIjX5fLAIdEy
         OfFqtGW3H41Boz+boWqfRMerL3Kpib21Ua9qXcqCU4x9VsEQhYJOPCTA/+2vOawMzoy+
         etbidRs8IV0rOtKJarpy+Qn7MnmMGM04Kv1CdCxSrxIFh9uNPwUI+vAs6+NpaFUII8+z
         fcmg==
X-Gm-Message-State: AOJu0YyJ/KWQipQITapuGFpcAFJB2CpAI28LafWO84MASy4PKGFUvGf7
	uJROpVj0BSCU1w3/QG5L96xTdg8nv2cm4xmkdLk2XxA7DOFD
X-Google-Smtp-Source: AGHT+IG3RUKN9obvLX/6bwA1inpX7yvw1vUx04cVWl91wxmskmnbJMRicsPg+tCQvBhUozahYV9aP5hmVOSGHrwDZ/OlB4nV81nU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c249:0:b0:35f:d260:57b3 with SMTP id
 k9-20020a92c249000000b0035fd26057b3mr2760751ilo.3.1704329965078; Wed, 03 Jan
 2024 16:59:25 -0800 (PST)
Date: Wed, 03 Jan 2024 16:59:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000026100c060e143e5a@google.com>
Subject: [syzbot] [net?] [nfc?] INFO: task hung in nfc_targets_found
From: syzbot <syzbot+2b131f51bb4af224ab40@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, krzysztof.kozlowski@linaro.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    453f5db0619e Merge tag 'trace-v6.7-rc7' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=141bc48de80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f8e72bae38c079e4
dashboard link: https://syzkaller.appspot.com/bug?extid=2b131f51bb4af224ab40
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6ed2cada0823/disk-453f5db0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1fa106f79073/vmlinux-453f5db0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c75ff5078c5c/bzImage-453f5db0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2b131f51bb4af224ab40@syzkaller.appspotmail.com

INFO: task kworker/u4:93:7607 blocked for more than 143 seconds.
      Not tainted 6.7.0-rc7-syzkaller-00049-g453f5db0619e #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u4:93   state:D stack:20248 pid:7607  tgid:7607  ppid:2      flags:0x00004000
Workqueue: nfc2_nci_rx_wq nci_rx_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5376 [inline]
 __schedule+0x1961/0x4ab0 kernel/sched/core.c:6688
 __schedule_loop kernel/sched/core.c:6763 [inline]
 schedule+0x149/0x260 kernel/sched/core.c:6778
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6835
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0x6a3/0xd60 kernel/locking/mutex.c:747
 device_lock include/linux/device.h:992 [inline]
 nfc_targets_found+0x26f/0x590 net/nfc/core.c:778
 nci_ntf_packet+0x4431/0x4f40
 nci_rx_work+0x14c/0x2b0 net/nfc/nci/core.c:1522
 process_one_work kernel/workqueue.c:2627 [inline]
 process_scheduled_works+0x90f/0x1420 kernel/workqueue.c:2700
 worker_thread+0xa5f/0x1000 kernel/workqueue.c:2781
 kthread+0x2d3/0x370 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>
INFO: task kworker/0:1:11541 blocked for more than 143 seconds.
      Not tainted 6.7.0-rc7-syzkaller-00049-g453f5db0619e #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:1     state:D stack:23280 pid:11541 tgid:11541 ppid:2      flags:0x00004000
Workqueue: events nfc_urelease_event_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5376 [inline]
 __schedule+0x1961/0x4ab0 kernel/sched/core.c:6688
 __schedule_loop kernel/sched/core.c:6763 [inline]
 schedule+0x149/0x260 kernel/sched/core.c:6778
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6835
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0x6a3/0xd60 kernel/locking/mutex.c:747
 nci_request net/nfc/nci/core.c:149 [inline]
 nci_stop_poll+0x123/0x480 net/nfc/nci/core.c:873
 nfc_stop_poll+0xea/0x220 net/nfc/core.c:259
 nfc_urelease_event_work+0x160/0x2f0 net/nfc/netlink.c:1852
 process_one_work kernel/workqueue.c:2627 [inline]
 process_scheduled_works+0x90f/0x1420 kernel/workqueue.c:2700
 worker_thread+0xa5f/0x1000 kernel/workqueue.c:2781
 kthread+0x2d3/0x370 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>
INFO: task syz-executor.1:27827 blocked for more than 143 seconds.
      Not tainted 6.7.0-rc7-syzkaller-00049-g453f5db0619e #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.1  state:D stack:25392 pid:27827 tgid:27824 ppid:27038  flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5376 [inline]
 __schedule+0x1961/0x4ab0 kernel/sched/core.c:6688
 __schedule_loop kernel/sched/core.c:6763 [inline]
 schedule+0x149/0x260 kernel/sched/core.c:6778
 schedule_timeout+0xb0/0x300 kernel/time/timer.c:2143
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common kernel/sched/completion.c:116 [inline]
 wait_for_common kernel/sched/completion.c:127 [inline]
 wait_for_completion+0x354/0x620 kernel/sched/completion.c:148
 __flush_workqueue+0x730/0x1630 kernel/workqueue.c:3192
 nci_close_device+0x193/0x600 net/nfc/nci/core.c:579
 nci_unregister_device+0x40/0x240 net/nfc/nci/core.c:1297
 virtual_ncidev_close+0x59/0x90 drivers/nfc/virtual_ncidev.c:168
 __fput+0x3cc/0x9e0 fs/file_table.c:394
 task_work_run+0x24a/0x300 kernel/task_work.c:180
 get_signal+0x166e/0x1840 kernel/signal.c:2680
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:309
 exit_to_user_mode_loop+0x6a/0x100 kernel/entry/common.c:168
 exit_to_user_mode_prepare+0xb1/0x150 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x69/0x2a0 kernel/entry/common.c:296
 do_syscall_64+0x52/0x110 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fab9d07cce9
RSP: 002b:00007fab9ddde0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: fffffffffffffff2 RBX: 00007fab9d19bf80 RCX: 00007fab9d07cce9
RDX: 0000000000000064 RSI: 0000000020000500 RDI: 0000000000000003
RBP: 00007fab9d0c947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fab9d19bf80 R15: 00007ffe08b6c548
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/29:
 #0: ffffffff8d92dae0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:301 [inline]
 #0: ffffffff8d92dae0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:747 [inline]
 #0: ffffffff8d92dae0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6614
2 locks held by getty/4825:
 #0: ffff88802a6320a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6b4/0x1e10 drivers/tty/n_tty.c:2201
3 locks held by kworker/u4:93/7607:
 #0: ffff8880368b3938 ((wq_completion)nfc2_nci_rx_wq){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2602 [inline]
 #0: ffff8880368b3938 ((wq_completion)nfc2_nci_rx_wq){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1420 kernel/workqueue.c:2700
 #1: ffffc900156b7d20 ((work_completion)(&ndev->rx_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2602 [inline]
 #1: ffffc900156b7d20 ((work_completion)(&ndev->rx_work)){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1420 kernel/workqueue.c:2700
 #2: ffff88802bed5100 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:992 [inline]
 #2: ffff88802bed5100 (&dev->mutex){....}-{3:3}, at: nfc_targets_found+0x26f/0x590 net/nfc/core.c:778
6 locks held by kworker/0:1/11541:
 #0: ffff888012c70d38 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2602 [inline]
 #0: ffff888012c70d38 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1420 kernel/workqueue.c:2700
 #1: ffffc90004a6fd20 ((work_completion)(&w->w)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2602 [inline]
 #1: ffffc90004a6fd20 ((work_completion)(&w->w)){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1420 kernel/workqueue.c:2700
 #2: ffffffff8ee4d808 (nfc_devlist_mutex){+.+.}-{3:3}, at: nfc_urelease_event_work+0xa7/0x2f0 net/nfc/netlink.c:1843
 #3: ffff88802bed5508 (&genl_data->genl_data_mutex){+.+.}-{3:3}, at: nfc_urelease_event_work+0x111/0x2f0 net/nfc/netlink.c:1849
 #4: ffff88802bed5100 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:992 [inline]
 #4: ffff88802bed5100 (&dev->mutex){....}-{3:3}, at: nfc_stop_poll+0x3c/0x220 net/nfc/core.c:247
 #5: ffff88802bed4350 (&ndev->req_lock){+.+.}-{3:3}, at: nci_request net/nfc/nci/core.c:149 [inline]
 #5: ffff88802bed4350 (&ndev->req_lock){+.+.}-{3:3}, at: nci_stop_poll+0x123/0x480 net/nfc/nci/core.c:873
3 locks held by kworker/1:2/16113:
 #0: ffff888012c70d38 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2602 [inline]
 #0: ffff888012c70d38 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1420 kernel/workqueue.c:2700
 #1: ffffc9000322fd20 ((work_completion)(&w->w)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2602 [inline]
 #1: ffffc9000322fd20 ((work_completion)(&w->w)){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1420 kernel/workqueue.c:2700
 #2: ffffffff8ee4d808 (nfc_devlist_mutex){+.+.}-{3:3}, at: nfc_urelease_event_work+0xa7/0x2f0 net/nfc/netlink.c:1843
3 locks held by kworker/1:9/17613:
 #0: ffff888012c70d38 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2602 [inline]
 #0: ffff888012c70d38 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1420 kernel/workqueue.c:2700
 #1: ffffc9000d927d20 ((work_completion)(&w->w)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2602 [inline]
 #1: ffffc9000d927d20 ((work_completion)(&w->w)){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1420 kernel/workqueue.c:2700
 #2: ffffffff8ee4d808 (nfc_devlist_mutex){+.+.}-{3:3}, at: nfc_urelease_event_work+0xa7/0x2f0 net/nfc/netlink.c:1843
3 locks held by kworker/0:5/22239:
 #0: ffff888012c70d38 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2602 [inline]
 #0: ffff888012c70d38 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1420 kernel/workqueue.c:2700
 #1: ffffc90014e57d20 ((work_completion)(&w->w)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2602 [inline]
 #1: ffffc90014e57d20 ((work_completion)(&w->w)){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1420 kernel/workqueue.c:2700
 #2: ffffffff8ee4d808 (nfc_devlist_mutex){+.+.}-{3:3}, at: nfc_urelease_event_work+0xa7/0x2f0 net/nfc/netlink.c:1843
3 locks held by kworker/1:0/23072:
 #0: ffff888012c70d38 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2602 [inline]
 #0: ffff888012c70d38 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1420 kernel/workqueue.c:2700
 #1: ffffc9000a5afd20 ((work_completion)(&w->w)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:2602 [inline]
 #1: ffffc9000a5afd20 ((work_completion)(&w->w)){+.+.}-{0:0}, at: process_scheduled_works+0x825/0x1420 kernel/workqueue.c:2700
 #2: ffffffff8ee4d808 (nfc_devlist_mutex){+.+.}-{3:3}, at: nfc_urelease_event_work+0xa7/0x2f0 net/nfc/netlink.c:1843
1 lock held by syz-executor.1/27827:
 #0: ffff88802bed4350 (&ndev->req_lock){+.+.}-{3:3}, at: nci_close_device+0x10a/0x600 net/nfc/nci/core.c:561
2 locks held by syz-executor.1/27953:
 #0: ffffffff8e0dcb48 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x5c/0x380 drivers/char/misc.c:129
 #1: ffffffff8ee4d808 (nfc_devlist_mutex){+.+.}-{3:3}, at: nfc_register_device+0x3c/0x320 net/nfc/core.c:1116
1 lock held by syz-executor.5/27976:
 #0: ffffffff8e0dcb48 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x5c/0x380 drivers/char/misc.c:129
1 lock held by syz-executor.5/27979:
 #0: ffffffff8e0dcb48 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x5c/0x380 drivers/char/misc.c:129
1 lock held by syz-executor.5/27981:
 #0: ffffffff8e0dcb48 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x5c/0x380 drivers/char/misc.c:129
1 lock held by syz-executor.5/27984:
 #0: ffffffff8e0dcb48 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x5c/0x380 drivers/char/misc.c:129
1 lock held by syz-executor.5/27986:
 #0: ffffffff8e0dcb48 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x5c/0x380 drivers/char/misc.c:129
1 lock held by syz-executor.1/28013:
 #0: ffffffff8e0dcb48 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x5c/0x380 drivers/char/misc.c:129

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 29 Comm: khungtaskd Not tainted 6.7.0-rc7-syzkaller-00049-g453f5db0619e #0
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
CPU: 1 PID: 7038 Comm: kworker/u4:23 Not tainted 6.7.0-rc7-syzkaller-00049-g453f5db0619e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Workqueue: bat_events batadv_nc_worker
RIP: 0010:bytes_is_nonzero mm/kasan/generic.c:84 [inline]
RIP: 0010:memory_is_nonzero mm/kasan/generic.c:102 [inline]
RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:127 [inline]
RIP: 0010:memory_is_poisoned mm/kasan/generic.c:159 [inline]
RIP: 0010:check_region_inline mm/kasan/generic.c:178 [inline]
RIP: 0010:kasan_check_range+0x79/0x290 mm/kasan/generic.c:187
Code: 4d 89 c1 49 c1 e9 03 49 be 01 00 00 00 00 fc ff df 4f 8d 3c 31 4c 89 fd 4c 29 dd 48 83 fd 10 7f 29 48 85 ed 0f 84 3e 01 00 00 <4c> 89 cd 48 f7 d5 48 01 dd 41 80 3b 00 0f 85 c5 01 00 00 49 ff c3
RSP: 0018:ffffc9000d9379f0 EFLAGS: 00000202
RAX: 0000000000000001 RBX: 1ffff1100f2ad320 RCX: ffffffff816e8191
RDX: 0000000000000001 RSI: 0000000000000004 RDI: ffff888079569900
RBP: 0000000000000001 R08: ffff888079569903 R09: 1ffff1100f2ad320
R10: dffffc0000000000 R11: ffffed100f2ad320 R12: ffff888079569900
R13: 1ffff92001b26f50 R14: dffffc0000000001 R15: ffffed100f2ad321
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c00a3bd000 CR3: 000000000d731000 CR4: 00000000003506f0
DR0: 000000000000d8dd DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
 atomic_try_cmpxchg_acquire include/linux/atomic/atomic-instrumented.h:1294 [inline]
 queued_spin_lock include/asm-generic/qspinlock.h:111 [inline]
 do_raw_spin_lock+0x141/0x370 kernel/locking/spinlock_debug.c:115
 spin_lock_bh include/linux/spinlock.h:356 [inline]
 batadv_nc_purge_paths+0xe8/0x3a0 net/batman-adv/network-coding.c:442
 batadv_nc_worker+0x328/0x610 net/batman-adv/network-coding.c:720
 process_one_work kernel/workqueue.c:2627 [inline]
 process_scheduled_works+0x90f/0x1420 kernel/workqueue.c:2700
 worker_thread+0xa5f/0x1000 kernel/workqueue.c:2781
 kthread+0x2d3/0x370 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

