Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7622801A3F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 04:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbjLBDgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 22:36:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLBDgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 22:36:00 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2848E1B2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 19:36:06 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7b3755259a0so296312139f.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 19:36:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701488165; x=1702092965;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iqler++v/AV3bO4X3qazvFJJJuqWmcolFWsVI9aUWSw=;
        b=PsJYMLdKP+ojsyDxvKalhcwGER1lCRFsAnhXpSvpmAszhc7lUNpEp25eT62JZw4fXd
         4oO6S7YiTeQwEbOK+em26nwxfkICxDy4ttV4LLE4meCscpYvOtjxkKoJRLnXJ1F1R7NM
         jPmSXOS4rF1AC0IbFafMFmJ8l2DWokQpqh0stw33OQDoJcfJKe3o0zOmou8dn28j1w/m
         1hxfT4XvPu2W+vcwN7dOiM37dg6v20BLARYAxksBE76vs18+ZNrlO1+2I7trC+Gz2cHz
         X4Q35g4gycTxwMR9fBBK4Ula7ZTy68/W6dcpeNOB8XxtLMpQ6o+jE4FZ/StgtWotJJBX
         5jbA==
X-Gm-Message-State: AOJu0Yz2jvs87utQsUbDVCeaM4HEpJsrrQEUjEAVLXQNg/yRobZ4i57a
        5WZ98MrJEjFcMMg1MmHTooXuK2rC6yor8E8YaolaLkeBN8bp
X-Google-Smtp-Source: AGHT+IHlefhF+0cnym0tk2WjWDk1P5ks3KJcWH4OzmXY08zlBHGWUWe5VQFJVjjuqDrcBhifbW/FhzRi9gxRLM9kiaO9EKdH7N0j
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2788:b0:463:f79d:e184 with SMTP id
 dl8-20020a056638278800b00463f79de184mr204797jab.5.1701488165452; Fri, 01 Dec
 2023 19:36:05 -0800 (PST)
Date:   Fri, 01 Dec 2023 19:36:05 -0800
In-Reply-To: <tencent_3436E64AC8741F77C766E83DE336CA963209@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b1090b060b7e9545@google.com>
Subject: Re: [syzbot] [block?] [trace?] INFO: task hung in blk_trace_ioctl (4)
From:   syzbot <syzbot+ed812ed461471ab17a0c@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in blk_trace_ioctl

INFO: task syz-executor.5:5690 blocked for more than 143 seconds.
      Not tainted 6.7.0-rc2-next-20231124-syzkaller-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.5  state:D stack:29344 pid:5690  tgid:5688  ppid:5422   flags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5399 [inline]
 __schedule+0xf15/0x5c00 kernel/sched/core.c:6726
 __schedule_loop kernel/sched/core.c:6801 [inline]
 schedule+0xe7/0x270 kernel/sched/core.c:6816
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6873
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0x5b4/0x9c0 kernel/locking/mutex.c:747
 blk_trace_ioctl+0xe9/0x2b0 kernel/trace/blktrace.c:739
 blkdev_common_ioctl+0x1575/0x1ce0 block/ioctl.c:562
 blkdev_ioctl+0x249/0x770 block/ioctl.c:627
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x62/0x6a
RIP: 0033:0x7f74daa7cae9
RSP: 002b:00007f74db6f50c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f74dab9c050 RCX: 00007f74daa7cae9
RDX: 0000000000000000 RSI: 0000000000001276 RDI: 0000000000000004
RBP: 00007f74daac847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f74dab9c050 R15: 00007ffe5d9903a8
 </TASK>
INFO: task syz-executor.3:5697 blocked for more than 144 seconds.
      Not tainted 6.7.0-rc2-next-20231124-syzkaller-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.3  state:D stack:28240 pid:5697  tgid:5695  ppid:5424   flags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5399 [inline]
 __schedule+0xf15/0x5c00 kernel/sched/core.c:6726
 __schedule_loop kernel/sched/core.c:6801 [inline]
 schedule+0xe7/0x270 kernel/sched/core.c:6816
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6873
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0x5b4/0x9c0 kernel/locking/mutex.c:747
 blk_trace_ioctl+0x216/0x2b0 kernel/trace/blktrace.c:737
 blkdev_ioctl+0x111/0x770 block/ioctl.c:622
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x62/0x6a
RIP: 0033:0x7fdf0727cae9
RSP: 002b:00007fdf07fce0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fdf0739bf80 RCX: 00007fdf0727cae9
RDX: 0000000020000380 RSI: 00000000c0481273 RDI: 0000000000000004
RBP: 00007fdf072c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fdf0739bf80 R15: 00007fffd6989178
 </TASK>
INFO: task syz-executor.3:5700 blocked for more than 144 seconds.
      Not tainted 6.7.0-rc2-next-20231124-syzkaller-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.3  state:D stack:29536 pid:5700  tgid:5695  ppid:5424   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5399 [inline]
 __schedule+0xf15/0x5c00 kernel/sched/core.c:6726
 __schedule_loop kernel/sched/core.c:6801 [inline]
 schedule+0xe7/0x270 kernel/sched/core.c:6816
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6873
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0x5b4/0x9c0 kernel/locking/mutex.c:747
 blk_trace_ioctl+0xe9/0x2b0 kernel/trace/blktrace.c:739
 blkdev_common_ioctl+0x1575/0x1ce0 block/ioctl.c:562
 blkdev_ioctl+0x249/0x770 block/ioctl.c:627
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x62/0x6a
RIP: 0033:0x7fdf0727cae9
RSP: 002b:00007fdf07fad0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fdf0739c050 RCX: 00007fdf0727cae9
RDX: 0000000000000000 RSI: 0000000000001276 RDI: 0000000000000004
RBP: 00007fdf072c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007fdf0739c050 R15: 00007fffd6989178
 </TASK>
INFO: task syz-executor.2:5699 blocked for more than 145 seconds.
      Not tainted 6.7.0-rc2-next-20231124-syzkaller-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.2  state:D stack:28464 pid:5699  tgid:5698  ppid:5432   flags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5399 [inline]
 __schedule+0xf15/0x5c00 kernel/sched/core.c:6726
 __schedule_loop kernel/sched/core.c:6801 [inline]
 schedule+0xe7/0x270 kernel/sched/core.c:6816
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6873
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0x5b4/0x9c0 kernel/locking/mutex.c:747
 blk_trace_ioctl+0x216/0x2b0 kernel/trace/blktrace.c:737
 blkdev_ioctl+0x111/0x770 block/ioctl.c:622
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x62/0x6a
RIP: 0033:0x7fe49b47cae9
RSP: 002b:00007fe49c22b0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fe49b59bf80 RCX: 00007fe49b47cae9
RDX: 0000000020000380 RSI: 00000000c0481273 RDI: 0000000000000004
RBP: 00007fe49b4c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fe49b59bf80 R15: 00007ffcc7430b68
 </TASK>
INFO: task syz-executor.2:5701 blocked for more than 146 seconds.
      Not tainted 6.7.0-rc2-next-20231124-syzkaller-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.2  state:D stack:29536 pid:5701  tgid:5698  ppid:5432   flags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5399 [inline]
 __schedule+0xf15/0x5c00 kernel/sched/core.c:6726
 __schedule_loop kernel/sched/core.c:6801 [inline]
 schedule+0xe7/0x270 kernel/sched/core.c:6816
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6873
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0x5b4/0x9c0 kernel/locking/mutex.c:747
 blk_trace_ioctl+0xe9/0x2b0 kernel/trace/blktrace.c:739
 blkdev_common_ioctl+0x1575/0x1ce0 block/ioctl.c:562
 blkdev_ioctl+0x249/0x770 block/ioctl.c:627
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x62/0x6a
RIP: 0033:0x7fe49b47cae9
RSP: 002b:00007fe49c20a0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fe49b59c050 RCX: 00007fe49b47cae9
RDX: 0000000000000000 RSI: 0000000000001276 RDI: 0000000000000004
RBP: 00007fe49b4c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007fe49b59c050 R15: 00007ffcc7430b68
 </TASK>

Showing all locks held in the system:
4 locks held by kworker/1:0/23:
 #0: ffff888013074d38 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x78c/0x15f0 kernel/workqueue.c:2608
 #1: ffffc900001d7d80 ((work_completion)(&data->fib_event_work)){+.+.}-{0:0}, at: process_one_work+0x7f6/0x15f0 kernel/workqueue.c:2609
 #2: ffff888040930240 (&data->fib_lock){+.+.}-{3:3}, at: nsim_fib_event_work+0x1bb/0x26e0 drivers/net/netdevsim/fib.c:1489
 #3: ffff8880b993c718 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:558
1 lock held by khungtaskd/29:
 #0: ffffffff8cfacf60 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:301 [inline]
 #0: ffffffff8cfacf60 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:747 [inline]
 #0: ffffffff8cfacf60 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x75/0x340 kernel/locking/lockdep.c:6613
2 locks held by kworker/u4:5/127:
 #0: ffff888013075938 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x78c/0x15f0 kernel/workqueue.c:2608
 #1: ffffc90002d9fd80 ((work_completion)(&sub_info->work)){+.+.}-{0:0}, at: process_one_work+0x7f6/0x15f0 kernel/workqueue.c:2609
2 locks held by kworker/u4:11/3621:
2 locks held by getty/4809:
 #0: ffff88814d2a80a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfc4/0x1490 drivers/tty/n_tty.c:2201
3 locks held by kworker/0:3/5057:
 #0: ffff8880265d5938 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work+0x78c/0x15f0 kernel/workqueue.c:2608
 #1: ffffc90003bdfd80 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work+0x7f6/0x15f0 kernel/workqueue.c:2609
 #2: ffffffff8eaac528 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_dad_work+0xcf/0x14b0 net/ipv6/addrconf.c:4137
2 locks held by kworker/1:6/5530:
 #0: ffff888013076938 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: process_one_work+0x78c/0x15f0 kernel/workqueue.c:2608
 #1: ffffc90004d1fd80 ((work_completion)(&rew->rew_work)){+.+.}-{0:0}, at: process_one_work+0x7f6/0x15f0 kernel/workqueue.c:2609
3 locks held by kworker/1:8/5567:
 #0: ffff8880265d5938 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work+0x78c/0x15f0 kernel/workqueue.c:2608
 #1: ffffc900057efd80 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work+0x7f6/0x15f0 kernel/workqueue.c:2609
 #2: ffffffff8eaac528 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_dad_work+0xcf/0x14b0 net/ipv6/addrconf.c:4137
4 locks held by syz-executor.5/5689:
1 lock held by syz-executor.5/5690:
 #0: ffff88801e502a98 (&q->debugfs_mutex/2){+.+.}-{3:3}, at: blk_trace_ioctl+0xe9/0x2b0 kernel/trace/blktrace.c:739
1 lock held by syz-executor.3/5697:
 #0: ffff88801e502a98 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0x216/0x2b0 kernel/trace/blktrace.c:737
1 lock held by syz-executor.3/5700:
 #0: ffff88801e502a98 (&q->debugfs_mutex/2){+.+.}-{3:3}, at: blk_trace_ioctl+0xe9/0x2b0 kernel/trace/blktrace.c:739
1 lock held by syz-executor.2/5699:
 #0: ffff88801e502a98 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0x216/0x2b0 kernel/trace/blktrace.c:737
1 lock held by syz-executor.2/5701:
 #0: ffff88801e502a98 (&q->debugfs_mutex/2){+.+.}-{3:3}, at: blk_trace_ioctl+0xe9/0x2b0 kernel/trace/blktrace.c:739
1 lock held by syz-executor.1/5889:
 #0: ffff88801e502a98 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0x216/0x2b0 kernel/trace/blktrace.c:737
1 lock held by syz-executor.1/5891:
 #0: ffff88801e502a98 (&q->debugfs_mutex/2){+.+.}-{3:3}, at: blk_trace_ioctl+0xe9/0x2b0 kernel/trace/blktrace.c:739
1 lock held by syz-executor.0/5957:
 #0: ffff88801e502a98 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0x216/0x2b0 kernel/trace/blktrace.c:737
1 lock held by syz-executor.0/5959:
 #0: ffff88801e502a98 (&q->debugfs_mutex/2){+.+.}-{3:3}, at: blk_trace_ioctl+0xe9/0x2b0 kernel/trace/blktrace.c:739
1 lock held by syz-executor.4/5967:
 #0: ffff88801e502a98 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0x216/0x2b0 kernel/trace/blktrace.c:737
1 lock held by syz-executor.4/5968:
 #0: ffff88801e502a98 (&q->debugfs_mutex/2){+.+.}-{3:3}, at: blk_trace_ioctl+0xe9/0x2b0 kernel/trace/blktrace.c:739
1 lock held by syz-executor.5/5983:
 #0: ffff88801e502a98 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0x216/0x2b0 kernel/trace/blktrace.c:737
1 lock held by syz-executor.5/5984:
 #0: ffff88801e502a98 (&q->debugfs_mutex/2){+.+.}-{3:3}, at: blk_trace_ioctl+0xe9/0x2b0 kernel/trace/blktrace.c:739
1 lock held by syz-executor.2/5986:
 #0: ffff88801e502a98 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0x216/0x2b0 kernel/trace/blktrace.c:737
1 lock held by syz-executor.2/5987:
 #0: ffff88801e502a98 (&q->debugfs_mutex/2){+.+.}-{3:3}, at: blk_trace_ioctl+0xe9/0x2b0 kernel/trace/blktrace.c:739
1 lock held by syz-executor.3/5989:
 #0: ffff88801e502a98 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0x216/0x2b0 kernel/trace/blktrace.c:737
1 lock held by syz-executor.3/5990:
 #0: ffff88801e502a98 (&q->debugfs_mutex/2){+.+.}-{3:3}, at: blk_trace_ioctl+0xe9/0x2b0 kernel/trace/blktrace.c:739
1 lock held by syz-executor.1/6010:
 #0: ffff88801e502a98 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0x216/0x2b0 kernel/trace/blktrace.c:737
1 lock held by syz-executor.1/6011:
 #0: ffff88801e502a98 (&q->debugfs_mutex/2){+.+.}-{3:3}, at: blk_trace_ioctl+0xe9/0x2b0 kernel/trace/blktrace.c:739
1 lock held by syz-executor.5/6050:
 #0: ffffffff8eaac528 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8eaac528 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xe00 net/core/rtnetlink.c:6555
1 lock held by syz-executor.0/6054:
 #0: ffff88801e502a98 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0x216/0x2b0 kernel/trace/blktrace.c:737
1 lock held by syz-executor.0/6056:
 #0: ffff88801e502a98 (&q->debugfs_mutex/2){+.+.}-{3:3}, at: blk_trace_ioctl+0xe9/0x2b0 kernel/trace/blktrace.c:739
3 locks held by syz-executor.2/6057:
 #0: ffffffff8eaac528 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8eaac528 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xe00 net/core/rtnetlink.c:6555
 #1: ffff8880200ad3e8 (&wg->device_update_lock){+.+.}-{3:3}, at: wg_open+0x203/0x4e0 drivers/net/wireguard/device.c:50
 #2: ffffffff8cfb8938 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:293 [inline]
 #2: ffffffff8cfb8938 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x6b1/0x800 kernel/rcu/tree_exp.h:996
1 lock held by syz-executor.3/6059:
 #0: ffffffff8eaac528 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8eaac528 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xe00 net/core/rtnetlink.c:6555
1 lock held by syz-executor.4/6091:
 #0: ffff88801e502a98 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0x216/0x2b0 kernel/trace/blktrace.c:737
1 lock held by syz-executor.4/6093:
 #0: ffff88801e502a98 (&q->debugfs_mutex/2){+.+.}-{3:3}, at: blk_trace_ioctl+0xe9/0x2b0 kernel/trace/blktrace.c:739
2 locks held by syz-executor.1/6108:
 #0: ffffffff8ea96f90 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x2d4/0x670 net/core/net_namespace.c:487
 #1: ffffffff8eaac528 (rtnl_mutex){+.+.}-{3:3}, at: ip_tunnel_init_net+0x225/0x5e0 net/ipv4/ip_tunnel.c:1090

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 29 Comm: khungtaskd Not tainted 6.7.0-rc2-next-20231124-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x277/0x390 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x299/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xf86/0x1210 kernel/hung_task.c:379
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 5530 Comm: kworker/1:6 Not tainted 6.7.0-rc2-next-20231124-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Workqueue: wg-kex-wg2 wg_packet_handshake_receive_worker
RIP: 0010:__lock_acquire+0xe75/0x3b10 kernel/locking/lockdep.c:5008
Code: 01 0f 87 ae f2 ff ff 45 89 f7 0f 87 60 1f 00 00 4b 8d 7c fc 08 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 <0f> 85 7d 1f 00 00 4b 8b 44 fc 08 48 85 c0 0f 85 95 f2 ff ff e9 72
RSP: 0018:ffffc90004d1f770 EFLAGS: 00000046
RAX: dffffc0000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: 1ffffffff1b4e7fc RSI: ffff888020b03b80 RDI: ffffffff8da73fe0
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff8f193397 R11: 0000000000000004 R12: ffffffff8da73fd8
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8eed404440 CR3: 0000000151079000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 lock_acquire kernel/locking/lockdep.c:5753 [inline]
 lock_acquire+0x1b1/0x530 kernel/locking/lockdep.c:5718
 __raw_write_lock_irqsave include/linux/rwlock_api_smp.h:186 [inline]
 _raw_write_lock_irqsave+0x3a/0x50 kernel/locking/spinlock.c:318
 stack_depot_put lib/stackdepot.c:621 [inline]
 stack_depot_put+0x24/0x110 lib/stackdepot.c:613
 qlink_free mm/kasan/quarantine.c:151 [inline]
 qlist_free_all+0x5e/0x1e0 mm/kasan/quarantine.c:201
 kasan_quarantine_reduce+0x18e/0x1d0 mm/kasan/quarantine.c:308
 __kasan_slab_alloc+0x65/0x90 mm/kasan/common.c:307
 kasan_slab_alloc include/linux/kasan.h:188 [inline]
 slab_post_alloc_hook mm/slab.h:763 [inline]
 slab_alloc_node mm/slub.c:3452 [inline]
 __kmem_cache_alloc_node+0x195/0x310 mm/slub.c:3491
 kmalloc_trace+0x25/0x60 mm/slab_common.c:1098
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:721 [inline]
 keypair_create drivers/net/wireguard/noise.c:100 [inline]
 wg_noise_handshake_begin_session+0xe1/0xe70 drivers/net/wireguard/noise.c:827
 wg_receive_handshake_packet+0x73c/0xbc0 drivers/net/wireguard/receive.c:176
 wg_packet_handshake_receive_worker+0x17f/0x3a0 drivers/net/wireguard/receive.c:213
 process_one_work+0x8a4/0x15f0 kernel/workqueue.c:2633
 process_scheduled_works kernel/workqueue.c:2706 [inline]
 worker_thread+0x8b6/0x1290 kernel/workqueue.c:2787
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>


Tested on:

commit:         8c9660f6 Add linux-next specific files for 20231124
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=112e2b52e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6eff11e3e3c25a4f
dashboard link: https://syzkaller.appspot.com/bug?extid=ed812ed461471ab17a0c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16e6004ae80000

