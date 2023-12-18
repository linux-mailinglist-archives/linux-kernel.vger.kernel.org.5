Return-Path: <linux-kernel+bounces-3341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C87B7816B36
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 425B71F2163A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD27718AE6;
	Mon, 18 Dec 2023 10:31:29 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289AC18E0D
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 10:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7b711ddbf1aso352437139f.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 02:31:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702895486; x=1703500286;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vg/dD/4v5uY0l1PFrFTxEq2hPpkwMp/0hLrDOm4qYhA=;
        b=rVFUup+ltJdPrf6Iy72LVL0zxEh9AMX3D17U/mlcqgjj2k8NYNd6Faacvt4Iu/zMpH
         g5LCuLijL43Z/r6Us5+9qrm2NW/3v59GJbL4Is1i8jSSi1xEXyWjRgtaJ/50dcWGwjqR
         Pp5zdnL7X0DkRZb40KY168L6IyOYEkwr0Xf1sCf8bS9gaoV6oFbCNB3PP98VPXGNd0+w
         pG+IhjQA/FZjP4PzGz2Xk5e9w0vtE2QLK/55zDmFnjwvPTKFu00hs2py5rMZhQV/SoBg
         Mm09RuiG4WlbzZfcka8HqObIesztUdrqnyZcFs0Ry4Vb911lomlxvVoG3oTkQc8wqFyh
         Ikuw==
X-Gm-Message-State: AOJu0Yy3zofZQL9WaZYKHicAkgQVIntjyzEu/0CHmCpjnAIzZJ3YP7Ri
	Jcof9mJEpO6hYO1rNecodxIWYIGaJdrtbnwOQKhnVHWD+MSz
X-Google-Smtp-Source: AGHT+IG1HaDY78iTGh0nFfD2z8IG0dgVUP3U3sWvrBk8xnlUe8ik3b4bx/ueCNzk2Ri8fijYCeG2nDALKui+HGbaW0z/E71ID/x5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2108:b0:46b:5487:cea7 with SMTP id
 n8-20020a056638210800b0046b5487cea7mr78459jaj.6.1702895486391; Mon, 18 Dec
 2023 02:31:26 -0800 (PST)
Date: Mon, 18 Dec 2023 02:31:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008e6074060cc640bc@google.com>
Subject: [syzbot] [block?] INFO: task hung in blkdev_flush_mapping
From: syzbot <syzbot+20e9a5e0dd424a875f55@syzkaller.appspotmail.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5bd7ef53ffe5 Merge tag 'pull-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1661ea92e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e043d554f0a5f852
dashboard link: https://syzkaller.appspot.com/bug?extid=20e9a5e0dd424a875f55
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10c80dc1e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1581aee6e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/29942596057f/disk-5bd7ef53.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bb808f8abb6b/vmlinux-5bd7ef53.xz
kernel image: https://storage.googleapis.com/syzbot-assets/da472273df77/bzImage-5bd7ef53.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+20e9a5e0dd424a875f55@syzkaller.appspotmail.com

INFO: task udevd:5097 blocked for more than 143 seconds.
      Not tainted 6.7.0-rc5-syzkaller-00047-g5bd7ef53ffe5 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D stack:26112 pid:5097  tgid:5097  ppid:4521   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5376 [inline]
 __schedule+0xedb/0x5af0 kernel/sched/core.c:6688
 __schedule_loop kernel/sched/core.c:6763 [inline]
 schedule+0xe9/0x270 kernel/sched/core.c:6778
 io_schedule+0xbe/0x130 kernel/sched/core.c:8998
 folio_wait_bit_common+0x3dc/0x9c0 mm/filemap.c:1273
 __folio_lock mm/filemap.c:1611 [inline]
 folio_lock include/linux/pagemap.h:1031 [inline]
 folio_lock include/linux/pagemap.h:1027 [inline]
 __filemap_get_folio+0x633/0xaa0 mm/filemap.c:1864
 truncate_inode_pages_range+0x3a0/0xf00 mm/truncate.c:376
 kill_bdev block/bdev.c:76 [inline]
 blkdev_flush_mapping+0x14d/0x310 block/bdev.c:632
 blkdev_put_whole+0xb9/0xe0 block/bdev.c:663
 blkdev_put+0x40f/0x8e0 block/bdev.c:944
 bdev_release+0x4f/0x80 block/bdev.c:954
 blkdev_release+0x37/0x50 block/fops.c:616
 __fput+0x270/0xbb0 fs/file_table.c:394
 task_work_run+0x14d/0x240 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa92/0x2ae0 kernel/exit.c:871
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1021
 get_signal+0x23be/0x2790 kernel/signal.c:2904
 arch_do_signal_or_restart+0x90/0x7f0 arch/x86/kernel/signal.c:309
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x121/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x1e/0x60 kernel/entry/common.c:296
 do_syscall_64+0x4d/0x110 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7ff86c77f9a4
RSP: 002b:00007ffde3c9a490 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: 0000000000000008 RBX: 0000563006ab5550 RCX: 00007ff86c77f9a4
RDX: 00000000000a0800 RSI: 0000563006aaa4a0 RDI: 00000000ffffff9c
RBP: 0000563006aaa4a0 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000a0800
R13: 0000563006aa26f0 R14: 0000000000000001 R15: 0000563006a90910
 </TASK>
INFO: task syz-executor383:5344 blocked for more than 143 seconds.
      Not tainted 6.7.0-rc5-syzkaller-00047-g5bd7ef53ffe5 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor383 state:D stack:28464 pid:5344  tgid:5343  ppid:5096   flags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5376 [inline]
 __schedule+0xedb/0x5af0 kernel/sched/core.c:6688
 __schedule_loop kernel/sched/core.c:6763 [inline]
 schedule+0xe9/0x270 kernel/sched/core.c:6778
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6835
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0x5b9/0x9d0 kernel/locking/mutex.c:747
 blkdev_get_by_dev.part.0+0x4ea/0xb10 block/bdev.c:788
 blkdev_get_by_dev block/bdev.c:853 [inline]
 bdev_open_by_dev+0x166/0x1c0 block/bdev.c:842
 blkdev_open+0xe6/0x390 block/fops.c:600
 do_dentry_open+0x8d6/0x18c0 fs/open.c:948
 do_open fs/namei.c:3622 [inline]
 path_openat+0x1e5a/0x2c50 fs/namei.c:3779
 do_filp_open+0x1de/0x430 fs/namei.c:3809
 do_sys_openat2+0x176/0x1e0 fs/open.c:1440
 do_sys_open fs/open.c:1455 [inline]
 __do_sys_openat fs/open.c:1471 [inline]
 __se_sys_openat fs/open.c:1466 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1466
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f0da6256530
RSP: 002b:00007f0da6214d90 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f0da6256530
RDX: 0000000000000000 RSI: 00007f0da6214e10 RDI: 00000000ffffff9c
RBP: 00007f0da6214e10 R08: 0000000000000000 R09: 002364626e2f7665
R10: 0000000000000000 R11: 0000000000000293 R12: 6666666666666667
R13: 00007f0da62ab1a4 R14: 64626e2f7665642f R15: 00007fff62c3be28
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/28:
 #0: ffffffff8cfabce0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:301 [inline]
 #0: ffffffff8cfabce0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:747 [inline]
 #0: ffffffff8cfabce0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x75/0x340 kernel/locking/lockdep.c:6614
2 locks held by getty/4828:
 #0: ffff88802a0ca0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfc6/0x1490 drivers/tty/n_tty.c:2201
1 lock held by udevd/5097:
 #0: ffff888140f7d4c8 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_put+0xb0/0x8e0 block/bdev.c:930
1 lock held by syz-executor383/5344:
 #0: ffff888140f7d4c8 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_get_by_dev.part.0+0x4ea/0xb10 block/bdev.c:788

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 28 Comm: khungtaskd Not tainted 6.7.0-rc5-syzkaller-00047-g5bd7ef53ffe5 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x277/0x390 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x299/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xf87/0x1210 kernel/hung_task.c:379
 kthread+0x2c6/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 1051 Comm: kworker/u4:6 Not tainted 6.7.0-rc5-syzkaller-00047-g5bd7ef53ffe5 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:__default_send_IPI_dest_field+0x70/0xf0 arch/x86/kernel/apic/ipi.c:186
Code: 0f b6 03 84 c0 74 04 3c 03 7e 7c 8b 04 25 00 c3 5f ff f6 c4 10 75 e7 44 89 24 25 10 c3 5f ff 89 f0 09 e8 89 04 25 00 c3 5f ff <48> 83 c4 08 5b 5d 41 5c c3 bb e8 03 00 00 eb 16 65 ff 05 f9 0f cc
RSP: 0018:ffffc900045b78f0 EFLAGS: 00000002
RAX: 00000000000008fb RBX: fffffbffffebf860 RCX: ffffffff818e47cb
RDX: 0000000000000800 RSI: 00000000000000fb RDI: 0000000002000000
RBP: 0000000000000800 R08: 0000000000000000 R09: fffffbfff1e32882
R10: ffffffff8f194417 R11: 0000000000000006 R12: 0000000002000000
R13: ffffffff817be6d0 R14: 0000000000000001 R15: ffff8880b983d8c0
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005584e8069600 CR3: 000000000cd77000 CR4: 0000000000350ef0
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 _flat_send_IPI_mask+0x40/0x70 arch/x86/kernel/apic/apic_flat_64.c:36
 arch_send_call_function_single_ipi arch/x86/include/asm/smp.h:101 [inline]
 send_call_function_single_ipi kernel/smp.c:117 [inline]
 smp_call_function_many_cond+0x12cf/0x1550 kernel/smp.c:837
 on_each_cpu_cond_mask+0x40/0x90 kernel/smp.c:1023
 on_each_cpu include/linux/smp.h:71 [inline]
 text_poke_sync arch/x86/kernel/alternative.c:2006 [inline]
 text_poke_bp_batch+0x561/0x750 arch/x86/kernel/alternative.c:2299
 text_poke_flush arch/x86/kernel/alternative.c:2407 [inline]
 text_poke_flush arch/x86/kernel/alternative.c:2404 [inline]
 text_poke_finish+0x30/0x40 arch/x86/kernel/alternative.c:2414
 arch_jump_label_transform_apply+0x1c/0x30 arch/x86/kernel/jump_label.c:146
 jump_label_update+0x1d7/0x400 kernel/jump_label.c:829
 static_key_disable_cpuslocked+0x154/0x1c0 kernel/jump_label.c:235
 static_key_disable+0x1a/0x20 kernel/jump_label.c:243
 toggle_allocation_gate mm/kfence/core.c:835 [inline]
 toggle_allocation_gate+0x13f/0x250 mm/kfence/core.c:822
 process_one_work+0x886/0x15d0 kernel/workqueue.c:2627
 process_scheduled_works kernel/workqueue.c:2700 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2781
 kthread+0x2c6/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
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

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

