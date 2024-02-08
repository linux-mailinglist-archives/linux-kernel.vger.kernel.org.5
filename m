Return-Path: <linux-kernel+bounces-57708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CB584DC9F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B39631F24FE3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D05D6BB55;
	Thu,  8 Feb 2024 09:17:32 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37C06BB43
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 09:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707383851; cv=none; b=Nt4Im7c6wIFqUfFENE2C9Mk60sn8MEH4HLLRYJwyAAb2hL0fe/IsMYA8BfG3XG23cCGRGWr+HCLIR6Za+R4p1ZOlxAiHMs1W0bzaN0fMBntCzlqigIBLXvt2LSrxWzo+LrbsEXfm3ouUN1EYLp3RVwLWwq4Y2LrL7V4TpntpNaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707383851; c=relaxed/simple;
	bh=5QGlvwWwK5NX6M3faMusU5zN0ItBkNk7c7q7SRpusLs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=O5hOZ3U5X+V1EnbRmDecCYNDNxrAYHjkjLLDMLCYrJMkDC41YmHlzxkp1K9cwfsJvXh1DJGbypsN3qpaoacGUXNx2wvrko3/1bvTLzHH9L6j1ySGgAj0NMZ/LbXI9njTl4qFoXzytls6gdks7oCVxZ7OuhN60ijKGDKAHLjka7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c0252f7749so112810339f.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 01:17:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707383849; x=1707988649;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GbQKhMkgUAdXOuR+N9fHEjxW2Yakh7ERvRxxb5b3kUE=;
        b=A0cTCPsO4HFOafJF5MswV1PcID/yzJaY3oKvzqmtEE6bdYEP4rYVVhb5QMr3MGymTZ
         xFZnwOdgI2V2as6vq7pFtoqF2tpNC2D/RCnuUHOKRlpxOoN8/qYC9jHLwbvVxn6Z/QhP
         aPbK0X3tLl2HV5A61HAWZWyrt/Xd16RbPaWaSi8qjI9UJM9kpmueN7R23uV2Pd1XTX/e
         DwSzuEJ10CaFQ1Xm5WJvI/DvcsCT8ETcr/OMiF98U14PzuE7eTgAoZPmbaHCOhoMhIVs
         nBAsCSgG76EhjqwjEQ3m9eNw19WNDx5YidnQ/bKpC7mmXi020XPC4UG2Acz3qL9FxmXz
         prMw==
X-Gm-Message-State: AOJu0YznQJEIzYmb/wdyYWjWheeYIe1G1i1knGInENbEQgGuaR1FhhBZ
	eOjQAMKkiVzLj44pM37Uhh2R9yTds8yQ5xSguI/X8Ht05OpLxIvzXyWvjDAXjsN4mz9eZ6ad9GR
	BxaX2hzNhlzGTEfvdPYkQSRPhQAO0dwmloDLi59BbqQ5EA51BIkwH+7p3Qg==
X-Google-Smtp-Source: AGHT+IEhg0VvULUFiNgMZyw8dhF7pIAOWCm3ui644MwMqLxIEt48phLUG22SrNn5AumOk3XGq5KHlR+cW5osVSO3K79WtRA0r4HA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12cf:b0:363:7b86:21bd with SMTP id
 i15-20020a056e0212cf00b003637b8621bdmr576926ilm.4.1707383848838; Thu, 08 Feb
 2024 01:17:28 -0800 (PST)
Date: Thu, 08 Feb 2024 01:17:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ce2dde0610db47a8@google.com>
Subject: [syzbot] [media?] possible deadlock in v4l2_ctrl_handler_log_status
From: syzbot <syzbot+9948f8e188482c5d1a3e@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	mchehab@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b1d3a0e70c38 Add linux-next specific files for 20240208
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=105d3360180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bb693ba195662a06
dashboard link: https://syzkaller.appspot.com/bug?extid=9948f8e188482c5d1a3e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=148953c4180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1746f9b7e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/176a6b395bbe/disk-b1d3a0e7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/02d7d46f81bd/vmlinux-b1d3a0e7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/18a5a5030e19/bzImage-b1d3a0e7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9948f8e188482c5d1a3e@syzkaller.appspotmail.com

vivid-000: =================  START STATUS  =================
vivid-000: Boolean: 
======================================================
WARNING: possible circular locking dependency detected
6.8.0-rc3-next-20240208-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor190/5068 is trying to acquire lock:
ffff8880253306e0 (vivid_ctrls:1606:(hdl_user_gen)->_lock){+.+.}-{3:3}, at: v4l2_ctrl_lock include/media/v4l2-ctrls.h:572 [inline]
ffff8880253306e0 (vivid_ctrls:1606:(hdl_user_gen)->_lock){+.+.}-{3:3}, at: log_ctrl drivers/media/v4l2-core/v4l2-ctrls-core.c:2518 [inline]
ffff8880253306e0 (vivid_ctrls:1606:(hdl_user_gen)->_lock){+.+.}-{3:3}, at: v4l2_ctrl_handler_log_status+0x2f3/0x540 drivers/media/v4l2-core/v4l2-ctrls-core.c:2556

but task is already holding lock:
ffff888025334278 (vivid_ctrls:1634:(hdl_sdr_cap)->_lock){+.+.}-{3:3}, at: v4l2_ctrl_handler_log_status+0x11f/0x540 drivers/media/v4l2-core/v4l2-ctrls-core.c:2551

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (vivid_ctrls:1634:(hdl_sdr_cap)->_lock){+.+.}-{3:3}:
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       find_ref_lock+0x5b/0x470 drivers/media/v4l2-core/v4l2-ctrls-core.c:1647
       handler_new_ref+0x102/0x940 drivers/media/v4l2-core/v4l2-ctrls-core.c:1684
       v4l2_ctrl_add_handler+0x1a1/0x290 drivers/media/v4l2-core/v4l2-ctrls-core.c:2208
       vivid_create_controls+0x2b3c/0x3580 drivers/media/test-drivers/vivid/vivid-ctrls.c:1981
       vivid_create_instance drivers/media/test-drivers/vivid/vivid-core.c:1854 [inline]
       vivid_probe+0x4289/0x6fa0 drivers/media/test-drivers/vivid/vivid-core.c:2018
       platform_probe+0x13a/0x1c0 drivers/base/platform.c:1404
       really_probe+0x29e/0xc50 drivers/base/dd.c:658
       __driver_probe_device+0x1a2/0x3e0 drivers/base/dd.c:800
       driver_probe_device+0x50/0x430 drivers/base/dd.c:830
       __driver_attach+0x45f/0x710 drivers/base/dd.c:1216
       bus_for_each_dev+0x239/0x2b0 drivers/base/bus.c:368
       bus_add_driver+0x347/0x620 drivers/base/bus.c:673
       driver_register+0x23a/0x320 drivers/base/driver.c:246
       vivid_init+0x3d/0x70 drivers/media/test-drivers/vivid/vivid-core.c:2145
       do_one_initcall+0x238/0x830 init/main.c:1233
       do_initcall_level+0x157/0x210 init/main.c:1295
       do_initcalls+0x3f/0x80 init/main.c:1311
       kernel_init_freeable+0x430/0x5d0 init/main.c:1542
       kernel_init+0x1d/0x2b0 init/main.c:1432
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:242

-> #0 (vivid_ctrls:1606:(hdl_user_gen)->_lock){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       v4l2_ctrl_lock include/media/v4l2-ctrls.h:572 [inline]
       log_ctrl drivers/media/v4l2-core/v4l2-ctrls-core.c:2518 [inline]
       v4l2_ctrl_handler_log_status+0x2f3/0x540 drivers/media/v4l2-core/v4l2-ctrls-core.c:2556
       v4l2_ctrl_log_status+0xe3/0x100 drivers/media/v4l2-core/v4l2-ctrls-api.c:1206
       vidioc_log_status+0x63/0x110 drivers/media/test-drivers/vivid/vivid-core.c:426
       v4l_log_status+0x8f/0x110 drivers/media/v4l2-core/v4l2-ioctl.c:2562
       __video_do_ioctl+0xc26/0xde0 drivers/media/v4l2-core/v4l2-ioctl.c:3049
       video_usercopy+0x899/0x1180 drivers/media/v4l2-core/v4l2-ioctl.c:3390
       v4l2_ioctl+0x18c/0x1e0 drivers/media/v4l2-core/v4l2-dev.c:364
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:871 [inline]
       __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:857
       do_syscall_64+0xfb/0x240
       entry_SYSCALL_64_after_hwframe+0x6d/0x75

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(vivid_ctrls:1634:(hdl_sdr_cap)->_lock);
                               lock(vivid_ctrls:1606:(hdl_user_gen)->_lock);
                               lock(vivid_ctrls:1634:(hdl_sdr_cap)->_lock);
  lock(vivid_ctrls:1606:(hdl_user_gen)->_lock);

 *** DEADLOCK ***

2 locks held by syz-executor190/5068:
 #0: ffff888025335a58 (&dev->mutex#3){+.+.}-{3:3}, at: __video_do_ioctl+0x4ed/0xde0 drivers/media/v4l2-core/v4l2-ioctl.c:3017
 #1: ffff888025334278 (vivid_ctrls:1634:(hdl_sdr_cap)->_lock){+.+.}-{3:3}, at: v4l2_ctrl_handler_log_status+0x11f/0x540 drivers/media/v4l2-core/v4l2-ctrls-core.c:2551

stack backtrace:
CPU: 0 PID: 5068 Comm: syz-executor190 Not tainted 6.8.0-rc3-next-20240208-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
 v4l2_ctrl_lock include/media/v4l2-ctrls.h:572 [inline]
 log_ctrl drivers/media/v4l2-core/v4l2-ctrls-core.c:2518 [inline]
 v4l2_ctrl_handler_log_status+0x2f3/0x540 drivers/media/v4l2-core/v4l2-ctrls-core.c:2556
 v4l2_ctrl_log_status+0xe3/0x100 drivers/media/v4l2-core/v4l2-ctrls-api.c:1206
 vidioc_log_status+0x63/0x110 drivers/media/test-drivers/vivid/vivid-core.c:426
 v4l_log_status+0x8f/0x110 drivers/media/v4l2-core/v4l2-ioctl.c:2562
 __video_do_ioctl+0xc26/0xde0 drivers/media/v4l2-core/v4l2-ioctl.c:3049
 video_usercopy+0x899/0x1180 drivers/media/v4l2-core/v4l2-ioctl.c:3390
 v4l2_ioctl+0x18c/0x1e0 drivers/media/v4l2-core/v4l2-dev.c:364
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:857
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7fc7060250e9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff130f5498 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fff130f5668 RCX: 00007fc7060250e9
RDX: 0000000000000000 RSI: 0000000000005646 RDI: 0000000000000003
RBP: 00007fc706098610 R08: 00236f6964617277 R09: 00007fff130f5668
R10: 000000000000000f R11: 0000000000000246 R12: 0000000000000001
R13: 00007fff130f5658 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
true
vivid-000: Integer 32 Bits: 0
vivid-000: Integer 64 Bits: 0
vivid-000: Menu: Menu Item 3
vivid-000: String:   
vivid-000: Bitmask: 0x80002000
vivid-000: Integer Menu: 5
vivid-000: U32 1 Element Array: [1] 24
vivid-000: U16 8x16 Matrix: [8][16] 24
vivid-000: U8 2x3x4x5 Array: [2][3][4][5] 24
vivid-000: Area: unknown type 262
vivid-000: Read-Only Integer 32 Bits: 0
vivid-000: U32 Dynamic Array: [100] 50
vivid-000: U8 Pixel Array: [640][368] 128
vivid-000: S32 2 Element Array: [2] 2
vivid-000: S64 5 Element Array: [5] 4
vivid-000: Wrap Sequence Number: false
vivid-000: Wrap Timestamp: None
vivid-000: Percentage of Dropped Buffers: 0
vivid-000: FM Deviation: 75000
vivid-000: ==================  END STATUS  ========


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

