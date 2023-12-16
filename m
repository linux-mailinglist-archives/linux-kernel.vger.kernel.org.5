Return-Path: <linux-kernel+bounces-2111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B48D8157FF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 07:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19AB91F24E8C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 06:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C891612E43;
	Sat, 16 Dec 2023 06:22:05 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F9712B68
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 06:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7b70c8b7314so220311539f.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 22:22:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702707723; x=1703312523;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gTmqEJUqo8mgq0Gq1BZ7a2ZpXFKHO46XjkjxRWlx1v8=;
        b=KWlFEsUb+fH1s9OocdSL9DWMXaomLS+JeyIvGgDvFxuH9HeXiHVMa8CqZKVqCyGvNg
         /uXjkYBoJi8fcBmhXezxPsk8BlsbNhsGyzlOQL3Ijd9NQoi9mmuRPcWQnA9YXqF6BEb9
         EepYEmDcuqN7w3z3wIxT+oL9F2h9Zx+ql1cTNNm5VkkX9Q7uRK+rfpXSlJb2huyIzFJZ
         LzwkTklN7EKX6+LWOeKXjSTxOfUyOb67FJaoU5XH1gZOEoBLOKFOBMNR0Z5qrkVdtgEU
         MfNn61YuectZFpCAuHwd7Ydc4mTdwfJAU6SbJFHcK7J1mDXJlojiPW5c3pb+senbvoLX
         qVxw==
X-Gm-Message-State: AOJu0YzaqVja6xEMnc4ghYwAP6eJe/yE8wtxEElrCjLYRxgxri+ONmC4
	epLcrOeuSyd9MpydB2WOPZRnJvVpNnO5fdJXDzWWm0a430cL
X-Google-Smtp-Source: AGHT+IHyNnLt63HPzzJT+lKuhQkv1jbZNXdNLI/gpuHLTVJZqUoa1pFg5N/2IY5VaPdETwFb3g08NikuVcdBALm2pvvGKH5UwSqp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1926:b0:469:221d:5f12 with SMTP id
 p38-20020a056638192600b00469221d5f12mr567632jal.4.1702707722831; Fri, 15 Dec
 2023 22:22:02 -0800 (PST)
Date: Fri, 15 Dec 2023 22:22:02 -0800
In-Reply-To: <20231216054106.1572-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f9cc66060c9a8811@google.com>
Subject: Re: [syzbot] [block?] INFO: task hung in bdev_release
From: syzbot <syzbot+4da851837827326a7cd4@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in blkdev_put

INFO: task syz-executor.0:5497 blocked for more than 143 seconds.
      Not tainted 6.7.0-rc5-syzkaller-00214-gc8e97fc6b4c0 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:27872 pid:5497  tgid:5496  ppid:5434   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5376 [inline]
 __schedule+0xedb/0x5af0 kernel/sched/core.c:6688
 __schedule_loop kernel/sched/core.c:6763 [inline]
 schedule+0xe9/0x270 kernel/sched/core.c:6778
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6835
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0x5b9/0x9d0 kernel/locking/mutex.c:747
 blkdev_put+0xb0/0x8e0 block/bdev.c:930
 bdev_release+0x4f/0x80 block/bdev.c:954
 blkdev_release+0x37/0x50 block/fops.c:616
 __fput+0x270/0xb70 fs/file_table.c:394
 task_work_run+0x14d/0x240 kernel/task_work.c:180
 get_signal+0x106f/0x2790 kernel/signal.c:2680
 arch_do_signal_or_restart+0x90/0x7f0 arch/x86/kernel/signal.c:309
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x121/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x1e/0x60 kernel/entry/common.c:296
 do_syscall_64+0x4d/0x110 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f766767cae9
RSP: 002b:00007f766845b0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: 0000000000000000 RBX: 00007f766779bf80 RCX: 00007f766767cae9
RDX: 0000000000000000 RSI: 000000000000ab03 RDI: 0000000000000005
RBP: 00007f76676c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f766779bf80 R15: 00007ffc44ea6c78
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/29:
 #0: ffffffff8cfab760 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:301 [inline]
 #0: ffffffff8cfab760 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:747 [inline]
 #0: ffffffff8cfab760 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x75/0x340 kernel/locking/lockdep.c:6614
2 locks held by getty/4818:
 #0: ffff88814b8ea0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfc6/0x1490 drivers/tty/n_tty.c:2201
1 lock held by udevd/5426:
 #0: ffff888140b5d4c8 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_get_by_dev.part.0+0x4ea/0xb10 block/bdev.c:788
1 lock held by syz-executor.0/5497:
 #0: ffff888140b5d4c8 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_put+0xb0/0x8e0 block/bdev.c:930
1 lock held by syz-executor.0/5806:
 #0: ffff888140b5d4c8 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_get_by_dev.part.0+0x4ea/0xb10 block/bdev.c:788
1 lock held by syz-executor.0/5826:
 #0: ffff888140b5d4c8 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_get_by_dev.part.0+0x4ea/0xb10 block/bdev.c:788

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 29 Comm: khungtaskd Not tainted 6.7.0-rc5-syzkaller-00214-gc8e97fc6b4c0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
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
CPU: 0 PID: 2415 Comm: kworker/u4:9 Not tainted 6.7.0-rc5-syzkaller-00214-gc8e97fc6b4c0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Workqueue: events_unbound cfg80211_wiphy_work
RIP: 0010:__sanitizer_cov_trace_pc+0x59/0x60 kernel/kcov.c:225
Code: 82 d8 15 00 00 83 f8 02 75 20 48 8b 8a e0 15 00 00 8b 92 dc 15 00 00 48 8b 01 48 83 c0 01 48 39 d0 73 07 48 89 01 48 89 34 c1 <c3> 66 0f 1f 44 00 00 f3 0f 1e fa 41 57 41 56 49 89 d6 41 55 41 54
RSP: 0018:ffffc9000a8b79d0 EFLAGS: 00000293
RAX: 0000000000000000 RBX: ffff88801a3ba000 RCX: 1ffffffff23e7cce
RDX: ffff8880259f8000 RSI: ffffffff813b3858 RDI: ffff88801a3ba000
RBP: 0000000080000000 R08: 0000000000000001 R09: fffffbfff23e25dd
R10: ffffffff91f12eef R11: 0000000000000003 R12: 0000000000000000
R13: 0000000000000000 R14: ffff88806fc7cc80 R15: ffff88806af7d550
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000562c2ba01600 CR3: 000000000cd77000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 __phys_addr+0x18/0x140 arch/x86/mm/physaddr.c:17
 virt_to_folio include/linux/mm.h:1281 [inline]
 kfree+0x45/0x150 mm/slab_common.c:1048
 ieee80211_rx_mgmt_probe_beacon net/mac80211/ibss.c:1578 [inline]
 ieee80211_ibss_rx_queued_mgmt+0x1b00/0x3120 net/mac80211/ibss.c:1604
 ieee80211_iface_process_skb net/mac80211/iface.c:1589 [inline]
 ieee80211_iface_work+0xa67/0xda0 net/mac80211/iface.c:1643
 cfg80211_wiphy_work+0x24e/0x330 net/wireless/core.c:437
 process_one_work+0x886/0x15d0 kernel/workqueue.c:2627
 process_scheduled_works kernel/workqueue.c:2700 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2781
 kthread+0x2c6/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>


Tested on:

commit:         c8e97fc6 Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=132d7556e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=48e9d2b9b4b93f29
dashboard link: https://syzkaller.appspot.com/bug?extid=4da851837827326a7cd4
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

