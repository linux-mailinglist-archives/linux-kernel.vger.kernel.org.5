Return-Path: <linux-kernel+bounces-39180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C0883CC1F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F4D5B21A0C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BF1135416;
	Thu, 25 Jan 2024 19:31:37 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC4D1350CB
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 19:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706211096; cv=none; b=nwFxr/ZUyg44NoZWEod/ihRqq8xCVShPSxn25gqMk1IHCgZhe5Vldh0T5JZXKQv8YJnLmRsI1hrPcRt+0XEBvjKSM+RJHd40zS2Zgtb7kRQm8cqpeu7hMQZnwQviFSLBbbKUuz+lmZ1SOEMQQLP5Jn/Qg8gyL/HuLOiGfgnubow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706211096; c=relaxed/simple;
	bh=qsfCjdbrIa5MAWUi1No6qKB4gMcdukFiTFGSPaOzpk4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UeGUv+2ybGi5XwkBO5FDXeE6zOe2DiTm3DqrXFDfh8D3c+CpvAVU/H18RO1JLlG7g7CpJH+m7xqMKksMZCvAjTdH6OpvlAJ+kUno5ENz+xZUBLTaYbijPnXq5+KE4NSIvh8J7M3q9mM0gjU4cUoQK8y0XUSeE3lsqZJ43bufsFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-35fc6976630so59789385ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 11:31:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706211094; x=1706815894;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pnJF9wz83hBRcmFwcvanKj4sa0OcSNp8RyMTa15ma0A=;
        b=sRtp4V5UZMedOvKAZjhX187iVdqtZ2+ItIhQ9jLwAUVGOwYTw7lWTnpFeU54Ge0wMX
         pX9q9aCUyB2G1lcJHR5l2naDMAIxH2DXY46X9tbhW8TIs9dd2gSpbmETDf8AfRa4BULx
         dCnMOIEPegI1/AEObeJE61tYp9VJ0c83+UlxHSvUFjymnltSw4iOoNPqRfQB/V+d+1eV
         SzcBMEtDMOGFgULcqrUECweDJg+E8fOnwLXBkyQNnICn9K26BWoYpejzpaO7HuNHyCd6
         ui97xdt2pcRdxVLJ5E6p6IGBsPknHGh9PJcFFKYvlM4RkYpSWx1it28Um48zbGLgkzj1
         s1QA==
X-Gm-Message-State: AOJu0Yykb/xbHl20C7A0qFSNrbbdCGjg1dzlyZA+C5AAq03gkWoiYoQ+
	txCSgEk9qXzJnj2aJ1TR9pZsOijDEgB7bGSY/W4lRiP2+qNN8Yq4ojs1g0gavrfT90/c9YjAgQ3
	et6z4A/qKEK1reeHdnQ1C70O4EXoQDUDgMdNYNwCTg4+MMQLUBb9D958=
X-Google-Smtp-Source: AGHT+IGIttVkEPMElQUiTa3PaxzUkBuB9Ab/x84X6vPhgJxWzwcRzX/odoX8t5g21GSF5vMmd5LywWmEwISYptxpMeUKRXp5LRP/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a6b:b0:361:9a73:5a8f with SMTP id
 w11-20020a056e021a6b00b003619a735a8fmr24922ilv.5.1706211093976; Thu, 25 Jan
 2024 11:31:33 -0800 (PST)
Date: Thu, 25 Jan 2024 11:31:33 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002b1fc7060fca3adf@google.com>
Subject: [syzbot] [block?] [trace?] INFO: task hung in blk_trace_remove (2)
From: syzbot <syzbot+2373f6be3e6de4f92562@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, axboe@kernel.dk, dvyukov@google.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com, 
	mhiramat@kernel.org, pengfei.xu@intel.com, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7a396820222d Merge tag 'v6.8-rc-part2-smb-client' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10c2406be80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4059ab9bf06b6ceb
dashboard link: https://syzkaller.appspot.com/bug?extid=2373f6be3e6de4f92562
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14669c6fe80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12d23ae3e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6bbe281de19f/disk-7a396820.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/aad457fc635f/vmlinux-7a396820.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b41601ff5beb/bzImage-7a396820.xz

The issue was bisected to:

commit 0d345996e4cb573f8cc81d49b3ee9a7fd2035bef
Author: Pengfei Xu <pengfei.xu@intel.com>
Date:   Mon Jul 31 03:04:18 2023 +0000

    x86/kernel: increase kcov coverage under arch/x86/kernel folder

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1594cacfe80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1794cacfe80000
console output: https://syzkaller.appspot.com/x/log.txt?x=1394cacfe80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2373f6be3e6de4f92562@syzkaller.appspotmail.com
Fixes: 0d345996e4cb ("x86/kernel: increase kcov coverage under arch/x86/kernel folder")

INFO: task syz-executor208:5137 blocked for more than 143 seconds.
      Not tainted 6.7.0-syzkaller-12991-g7a396820222d #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor208 state:D stack:29312 pid:5137  tgid:5134  ppid:5112   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0xf12/0x5c00 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6802 [inline]
 schedule+0xe9/0x270 kernel/sched/core.c:6817
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6874
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b9/0x9d0 kernel/locking/mutex.c:752
 blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:406
 sg_ioctl_common drivers/scsi/sg.c:1126 [inline]
 sg_ioctl+0x9ac/0x2760 drivers/scsi/sg.c:1160
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd3/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f61c0ac50d9
RSP: 002b:00007f61c0a60168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f61c0b4c3d8 RCX: 00007f61c0ac50d9
RDX: 0000000000000000 RSI: 0000000000001276 RDI: 0000000000000003
RBP: 00007f61c0b4c3d0 R08: 00007ffdb9ff9147 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f61c0b4c3dc
R13: 000000000000006e R14: 00007ffdb9ff9060 R15: 00007ffdb9ff9148
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/29:
 #0: ffffffff8d1acba0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #0: ffffffff8d1acba0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #0: ffffffff8d1acba0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x75/0x340 kernel/locking/lockdep.c:6614
2 locks held by getty/4817:
 #0: ffff8880297d30a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfc6/0x1490 drivers/tty/n_tty.c:2201
3 locks held by syz-executor208/5136:
1 lock held by syz-executor208/5137:
 #0: ffff88801e9032b0 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:406
1 lock held by syz-executor208/5140:
 #0: ffff88801e9032b0 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:648
1 lock held by syz-executor208/5141:
 #0: ffff88801e9032b0 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:406
1 lock held by syz-executor208/5149:
 #0: ffff88801e9032b0 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:648
1 lock held by syz-executor208/5152:
 #0: ffff88801e9032b0 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:406
1 lock held by syz-executor208/5151:
 #0: ffff88801e9032b0 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:648
1 lock held by syz-executor208/5153:
 #0: ffff88801e9032b0 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:406
1 lock held by syz-executor208/5155:
 #0: ffff88801e9032b0 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_setup+0x33/0x60 kernel/trace/blktrace.c:648
1 lock held by syz-executor208/5156:
 #0: ffff88801e9032b0 (&q->debugfs_mutex){+.+.}-{3:3}, at: blk_trace_remove+0x1f/0x40 kernel/trace/blktrace.c:406

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 29 Comm: khungtaskd Not tainted 6.7.0-syzkaller-12991-g7a396820222d #0
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
CPU: 0 PID: 5136 Comm: syz-executor208 Not tainted 6.7.0-syzkaller-12991-g7a396820222d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
RIP: 0010:check_kcov_mode kernel/kcov.c:173 [inline]
RIP: 0010:write_comp_data+0x19/0x80 kernel/kcov.c:236
Code: 8b 80 f0 15 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 49 89 d2 49 89 f8 49 89 f1 65 48 8b 14 25 80 c2 03 00 65 8b 05 bf a6 7b 7e <a9> 00 01 ff 00 74 0f f6 c4 01 74 59 8b 82 fc 15 00 00 85 c0 74 4f
RSP: 0018:ffffc900045e77e0 EFLAGS: 00000202
RAX: 0000000080000001 RBX: 0000000000000002 RCX: ffffffff813a4c8d
RDX: ffff88806d973b80 RSI: 0000000000000003 RDI: 0000000000000001
RBP: ffffffff8ac9ccc0 R08: 0000000000000001 R09: 0000000000000003
R10: 0000000000000002 R11: 0000000000000002 R12: 0000000000000002
R13: 0000000000000001 R14: 0000000000000003 R15: 0000000000000002
FS:  00007f61c0a606c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055e6254f9440 CR3: 000000006e15a000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 __sanitizer_cov_trace_switch+0x54/0x90 kernel/kcov.c:341
 unwind_next_frame+0x77d/0x2390 arch/x86/kernel/unwind_orc.c:581
 __unwind_start+0x5a4/0x880 arch/x86/kernel/unwind_orc.c:760
 unwind_start arch/x86/include/asm/unwind.h:64 [inline]
 arch_stack_walk+0xaf/0x170 arch/x86/kernel/stacktrace.c:24
 stack_trace_save+0x96/0xd0 kernel/stacktrace.c:122
 save_stack+0x160/0x1f0 mm/page_owner.c:129
 __reset_page_owner+0x51/0x2e0 mm/page_owner.c:150
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1140 [inline]
 free_unref_page_prepare+0x51f/0xb10 mm/page_alloc.c:2346
 free_unref_page+0x33/0x3c0 mm/page_alloc.c:2486
 relay_destroy_buf+0x121/0x3e0 kernel/relay.c:201
 relay_remove_buf kernel/relay.c:221 [inline]
 kref_put include/linux/kref.h:65 [inline]
 relay_close_buf+0x153/0x1b0 kernel/relay.c:430
 relay_close kernel/relay.c:766 [inline]
 relay_close+0x3a8/0x5d0 kernel/relay.c:752
 blk_trace_free+0x37/0x170 kernel/trace/blktrace.c:316
 blk_trace_cleanup kernel/trace/blktrace.c:384 [inline]
 __blk_trace_remove+0x7f/0x130 kernel/trace/blktrace.c:397
 blk_trace_remove+0x27/0x40 kernel/trace/blktrace.c:407
 sg_ioctl_common drivers/scsi/sg.c:1126 [inline]
 sg_ioctl+0x9ac/0x2760 drivers/scsi/sg.c:1160
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd3/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f61c0ac50d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 91 1a 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f61c0a60168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f61c0b4c3d8 RCX: 00007f61c0ac50d9
RDX: 0000000000000000 RSI: 0000000000001276 RDI: 0000000000000003
RBP: 00007f61c0b4c3d0 R08: 00007ffdb9ff9147 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f61c0b4c3dc
R13: 000000000000006e R14: 00007ffdb9ff9060 R15: 00007ffdb9ff9148
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.919 msecs


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

