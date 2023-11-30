Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0597FFD66
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 22:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376930AbjK3VRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 16:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376964AbjK3VRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 16:17:37 -0500
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1612A19BD
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 13:17:20 -0800 (PST)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6cde5cf72a0so1541636b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 13:17:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701379039; x=1701983839;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZUZnLWZX4b9hAqkq+tPuwlVJAfesWgOImstiB4jK5SE=;
        b=DHA0OXpoz3bi9LYGbwh9HXA3iHkbvtA/jfONhLcK6MUhBUSeSeoRO97NbRGHY9Q5ye
         veufcuhGQFEktE2frzgy2yPOcJ/bPfQ4DyXKfwbb6niE69QI23M+3aXkyrIbcq016g/s
         Jbfq1B+L0WAe1H1htx9k3cbj8mW8+CiDMPlwLvsl5yzcPLQVaO3+YdumhOBiznXVIuoK
         DglTiN5+fwbNjlIWofFSNUNR5eNotDa1ICsefKmXc5uqM3yDu93IR9m7C24+Hb7cQpys
         AWMUbT9m1U49quB/c7yEufRI0hW5soUl3dgpEoCPlzqSbRTVaYuO3BmE/X1v9kLbSfSJ
         kdzQ==
X-Gm-Message-State: AOJu0YwlLEunGGaB8ezK4W9xMqbMaKWTVT/uA4lkcduxk/8pb54CCZsc
        86Zo/JQHutx+4ertUqwV+ri/oyay1FsoXgPkgY7AF0WazzX1
X-Google-Smtp-Source: AGHT+IFxookyfCUEYxgYtjIZInscR9jMB+jkbe4TD30Pmp3cxfGKyfW2pcX5DK2a7D6i8FZh5iJxfE7qbJdhBtoOXld7Nynoi9f8
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:1483:b0:6bc:de83:2e1b with SMTP id
 v3-20020a056a00148300b006bcde832e1bmr5895135pfu.3.1701379039552; Thu, 30 Nov
 2023 13:17:19 -0800 (PST)
Date:   Thu, 30 Nov 2023 13:17:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000047eb7e060b652d9a@google.com>
Subject: [syzbot] [block?] [trace?] INFO: task hung in blk_trace_ioctl (4)
From:   syzbot <syzbot+ed812ed461471ab17a0c@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, axboe@kernel.dk, dvyukov@google.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
        pengfei.xu@intel.com, rostedt@goodmis.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    8c9660f65153 Add linux-next specific files for 20231124
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1006f178e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ca1e8655505e280
dashboard link: https://syzkaller.appspot.com/bug?extid=ed812ed461471ab17a0c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14ec6e62e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11964f7ce80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/345ed4af3a0d/disk-8c9660f6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/191053c69d57/vmlinux-8c9660f6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/aac7ee5e55e0/bzImage-8c9660f6.xz

The issue was bisected to:

commit 0d345996e4cb573f8cc81d49b3ee9a7fd2035bef
Author: Pengfei Xu <pengfei.xu@intel.com>
Date:   Mon Jul 31 03:04:18 2023 +0000

    x86/kernel: increase kcov coverage under arch/x86/kernel folder

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14782eaae80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16782eaae80000
console output: https://syzkaller.appspot.com/x/log.txt?x=12782eaae80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ed812ed461471ab17a0c@syzkaller.appspotmail.com
Fixes: 0d345996e4cb ("x86/kernel: increase kcov coverage under arch/x86/kernel folder")

INFO: task syz-executor216:5234 blocked for more than 143 seconds.
      Not tainted 6.7.0-rc2-next-20231124-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor216 state:D stack:29104 pid:5234  tgid:5232  ppid:5106   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5399 [inline]
 __schedule+0xf15/0x5c00 kernel/sched/core.c:6726
 __schedule_loop kernel/sched/core.c:6801 [inline]
 schedule+0xe7/0x270 kernel/sched/core.c:6816
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6873
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0x5b4/0x9c0 kernel/locking/mutex.c:747
 blk_trace_ioctl+0xc9/0x290 kernel/trace/blktrace.c:736
 blkdev_common_ioctl+0x1575/0x1ce0 block/ioctl.c:562
 blkdev_ioctl+0x249/0x770 block/ioctl.c:627
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x62/0x6a
RIP: 0033:0x7f914d80ca89
RSP: 002b:00007f914cfa3168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f914d89c1d8 RCX: 00007f914d80ca89
RDX: 0000000000000000 RSI: 0000000000001276 RDI: 0000000000000004
RBP: 00007f914d89c1d0 R08: 00007ffdb3560fd7 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f914d89c1dc
R13: 000000000000006e R14: 00007ffdb3560ef0 R15: 00007ffdb3560fd8
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/29:
 #0: ffffffff8cfacf60 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:301 [inline]
 #0: ffffffff8cfacf60 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:747 [inline]
 #0: ffffffff8cfacf60 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x75/0x340 kernel/locking/lockdep.c:6613
1 lock held by klogd/4501:
 #0: ffff8880b993c718 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:558
2 locks held by getty/4815:
 #0: ffff8880273ee0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfc4/0x1490 drivers/tty/n_tty.c:2201
2 locks held by kworker/0:5/5180:
2 locks held by syz-executor216/5233:
1 lock held by syz-executor216/5234:
 #0: ffff888142f94490 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0xc9/0x290 kernel/trace/blktrace.c:736
1 lock held by syz-executor216/5240:
 #0: ffff888142f94490 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0xc9/0x290 kernel/trace/blktrace.c:736
1 lock held by syz-executor216/5241:
 #0: ffff888142f94490 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0xc9/0x290 kernel/trace/blktrace.c:736
1 lock held by syz-executor216/5245:
 #0: ffff888142f94490 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0xc9/0x290 kernel/trace/blktrace.c:736
1 lock held by syz-executor216/5246:
 #0: ffff888142f94490 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0xc9/0x290 kernel/trace/blktrace.c:736
1 lock held by syz-executor216/5248:
 #0: ffff888142f94490 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0xc9/0x290 kernel/trace/blktrace.c:736
1 lock held by syz-executor216/5249:
 #0: ffff888142f94490 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0xc9/0x290 kernel/trace/blktrace.c:736
1 lock held by syz-executor216/5251:
 #0: ffff888142f94490 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0xc9/0x290 kernel/trace/blktrace.c:736
1 lock held by syz-executor216/5252:
 #0: ffff888142f94490 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0xc9/0x290 kernel/trace/blktrace.c:736
1 lock held by syz-executor216/5254:
 #0: ffff888142f94490 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0xc9/0x290 kernel/trace/blktrace.c:736
1 lock held by syz-executor216/5255:
 #0: ffff888142f94490 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_ioctl+0xc9/0x290 kernel/trace/blktrace.c:736

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 29 Comm: khungtaskd Not tainted 6.7.0-rc2-next-20231124-syzkaller #0
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
CPU: 1 PID: 5233 Comm: syz-executor216 Not tainted 6.7.0-rc2-next-20231124-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
RIP: 0010:__sanitizer_cov_trace_switch+0x4f/0x90 kernel/kcov.c:341
Code: 83 f8 10 75 2f 41 bd 03 00 00 00 4c 8b 75 00 31 db 4d 85 f6 74 1e 48 8b 74 dd 10 4c 89 e2 4c 89 ef 48 83 c3 01 48 8b 4c 24 28 <e8> 2c fe ff ff 49 39 de 75 e2 5b 5d 41 5c 41 5d 41 5e c3 48 83 f8
RSP: 0018:ffffc90003fdf3a0 EFLAGS: 00000202
RAX: 0000000000000008 RBX: 0000000000000001 RCX: ffffffff813a44c8
RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000001
RBP: ffffffff8ac9d800 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: dffffc0000000000 R12: 0000000000000001
R13: 0000000000000001 R14: 0000000000000003 R15: 0000000000000001
FS:  00007f914cfc46c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f914d899f18 CR3: 00000000a0ad4000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 unwind_next_frame+0xea8/0x2390 arch/x86/kernel/unwind_orc.c:641
 arch_stack_walk+0xfa/0x170 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x95/0xd0 kernel/stacktrace.c:122
 save_stack+0x15e/0x1f0 mm/page_owner.c:130
 __set_page_owner+0x1f/0x60 mm/page_owner.c:196
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2d0/0x350 mm/page_alloc.c:1533
 prep_new_page mm/page_alloc.c:1540 [inline]
 get_page_from_freelist+0xa16/0x3690 mm/page_alloc.c:3344
 __alloc_pages+0x22d/0x2400 mm/page_alloc.c:4600
 alloc_pages_mpol+0x258/0x5f0 mm/mempolicy.c:2133
 relay_alloc_buf kernel/relay.c:121 [inline]
 relay_create_buf kernel/relay.c:162 [inline]
 relay_open_buf.part.0+0x27d/0xba0 kernel/relay.c:384
 relay_open_buf kernel/relay.c:536 [inline]
 relay_open+0x641/0xab0 kernel/relay.c:517
 do_blk_trace_setup+0x4a9/0xaa0 kernel/trace/blktrace.c:591
 __blk_trace_setup+0xd8/0x180 kernel/trace/blktrace.c:631
 blk_trace_ioctl+0x163/0x290 kernel/trace/blktrace.c:741
 blkdev_ioctl+0x111/0x770 block/ioctl.c:622
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x62/0x6a
RIP: 0033:0x7f914d80ca89
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 1c 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f914cfc4168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f914d89c1c8 RCX: 00007f914d80ca89
RDX: 0000000020000380 RSI: 00000000c0481273 RDI: 0000000000000004
RBP: 00007f914d89c1c0 R08: 00007f914cfc46c0 R09: 0000000000000000
R10: 00007f914cfc46c0 R11: 0000000000000246 R12: 00007f914d89c1cc
R13: 000000000000000b R14: 00007ffdb3560ef0 R15: 00007ffdb3560fd8
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 2.100 msecs


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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
