Return-Path: <linux-kernel+bounces-160070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9139B8B38AD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B460A1C23399
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD6B1487DD;
	Fri, 26 Apr 2024 13:39:33 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAE9148303
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 13:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714138772; cv=none; b=q8ngNfQOjC6bNiJQdZ06cIsNYmUKka6zmyj2YVa5wI4iFS+kESXRnZyZLkNyQ1gR7DyYgDXd2SPThrC5QmgSl4K/Bxtw4XpZ0UuoMr6pFucV/k7L2TO8x2X2gKYDzjx0a+vyZ8HCHWn3XsMcMNdq9PTcJwLyabFUQEwvzkZh6XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714138772; c=relaxed/simple;
	bh=QsaJjHlJj5Qim5L5Nsu+366mg121psAXifrWo0USDxA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NTeapzlKCrEAm4KWM8WwBHU/gslZct7Cg1H/bQ1wlfEBJe09NvEONeitlvgBBBMa0iyfWEDxPnERgv186moDK5mZK+4at02T1VJDRzTaRxmuzsI07qKdxY3G2cahzw2y7+4xfvPP74VftC0Z946Yl4s/XQP30pBylZ3Wh4v1yUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7d9d0936d6aso227530239f.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 06:39:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714138770; x=1714743570;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UGfNVVjqWxMSxZjqD8msnPmXD86vTarzTPWqGniIPmM=;
        b=F0EGOt2HsLOlB2WA8U6bHO+69Gt4zAmcAGpZ903d1r1fY9JcyN9COutKrbGaSQ8g9g
         0i1BuPpfHiSmifGlgA1mK/t1j+gG/bNrl9RlJnwjfoJ3EhwYLZl9U/KszTOYrAOZB0wa
         oGHg++2IJV9HFtcKFrOkeOahormF7kVgGRyzhKD1NyDzyJkIwGKXe0ojV+zWqJ31eVKM
         AdKsTg2CfD8f8VuUw9vy9G+dQ1mTHWMiX/+gwlHg1HPpL1awjTtySKO44s40kwOEom55
         rwvp+P33PU1BUnvKw0ROLM+IwSPEIBHHrYz6m3TL4LYzOuzLDAq5uZvRMZy0/aTk964l
         OR+A==
X-Forwarded-Encrypted: i=1; AJvYcCU/i9PzxTMlbekxjMMuQjR/e9XxxHUxfgBHVAr0Rym8BOFe+4TsFS0brFMaCS++jyfI09oGzyaCUzq1sBZOyjc0iHSpWDbzq868D8MF
X-Gm-Message-State: AOJu0YwUMDuQ6FuAd3Z/xcE6VYKx/IK+fsFzfqIIwDfmA6kdFl0CdqbN
	kewCqokVjxkAyorzVy/8HZixucE7js+o9luKubOaNYnqLAxaz6WpBo9iu6EbnKvIZPulq99R7hB
	In5Tlsd00oLj5/ypP5CRr4HwNhM77WHUp+22z5UPw4hInE8NsOz3c57w=
X-Google-Smtp-Source: AGHT+IGzeyBaJUG3OY/7s7IR44S7RUt5idFlbvH2pHkQr9+MZaQc5JuAsF3W6iw2uZQ/OMt2yLrB0Y+2e5sVdAlxVwE8OE/6S3XE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:270e:b0:482:83aa:16be with SMTP id
 m14-20020a056638270e00b0048283aa16bemr195429jav.5.1714138770452; Fri, 26 Apr
 2024 06:39:30 -0700 (PDT)
Date: Fri, 26 Apr 2024 06:39:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000823ce8061700087a@google.com>
Subject: [syzbot] [bluetooth?] possible deadlock in hci_unregister_dev (2)
From: syzbot <syzbot+ab10eccaaf6fdf23dd55@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    bb7a2467e6be Add linux-next specific files for 20240426
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13daed0f180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5c6a0288262dd108
dashboard link: https://syzkaller.appspot.com/bug?extid=ab10eccaaf6fdf23dd55
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5175af7dda64/disk-bb7a2467.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/70db0462e868/vmlinux-bb7a2467.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3217fb825698/bzImage-bb7a2467.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ab10eccaaf6fdf23dd55@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.9.0-rc5-next-20240426-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.0/6085 is trying to acquire lock:
ffff8880696fc8d0 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
ffff8880696fc8d0 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
ffff8880696fc8d0 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: start_flush_work kernel/workqueue.c:4113 [inline]
ffff8880696fc8d0 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: __flush_work+0xe6/0xd00 kernel/workqueue.c:4172

but task is already holding lock:
ffff8880696fd060 (&hdev->req_lock){+.+.}-{3:3}, at: hci_dev_do_close net/bluetooth/hci_core.c:559 [inline]
ffff8880696fd060 (&hdev->req_lock){+.+.}-{3:3}, at: hci_unregister_dev+0x1d3/0x4e0 net/bluetooth/hci_core.c:2778

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&hdev->req_lock){+.+.}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       hci_cmd_sync_work+0x1ec/0x400 net/bluetooth/hci_sync.c:309
       process_one_work kernel/workqueue.c:3222 [inline]
       process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3303
       worker_thread+0x86d/0xd70 kernel/workqueue.c:3384
       kthread+0x2f0/0x390 kernel/kthread.c:389
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       touch_work_lockdep_map kernel/workqueue.c:3885 [inline]
       start_flush_work kernel/workqueue.c:4139 [inline]
       __flush_work+0x73c/0xd00 kernel/workqueue.c:4172
       __cancel_work_sync+0xbc/0x110 kernel/workqueue.c:4322
       hci_cmd_sync_clear+0x30/0x220 net/bluetooth/hci_sync.c:588
       hci_dev_close_sync+0xbae/0x1060 net/bluetooth/hci_sync.c:5188
       hci_dev_do_close net/bluetooth/hci_core.c:561 [inline]
       hci_unregister_dev+0x1db/0x4e0 net/bluetooth/hci_core.c:2778
       vhci_release+0x83/0xd0 drivers/bluetooth/hci_vhci.c:674
       __fput+0x406/0x8b0 fs/file_table.c:422
       task_work_run+0x24f/0x310 kernel/task_work.c:180
       exit_task_work include/linux/task_work.h:38 [inline]
       do_exit+0xa27/0x27e0 kernel/exit.c:874
       do_group_exit+0x207/0x2c0 kernel/exit.c:1023
       __do_sys_exit_group kernel/exit.c:1034 [inline]
       __se_sys_exit_group kernel/exit.c:1032 [inline]
       __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1032
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&hdev->req_lock);
                               lock((work_completion)(&hdev->cmd_sync_work));
                               lock(&hdev->req_lock);
  lock((work_completion)(&hdev->cmd_sync_work));

 *** DEADLOCK ***

2 locks held by syz-executor.0/6085:
 #0: ffff8880696fd060 (&hdev->req_lock){+.+.}-{3:3}, at: hci_dev_do_close net/bluetooth/hci_core.c:559 [inline]
 #0: ffff8880696fd060 (&hdev->req_lock){+.+.}-{3:3}, at: hci_unregister_dev+0x1d3/0x4e0 net/bluetooth/hci_core.c:2778
 #1: ffffffff8e333ba0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 #1: ffffffff8e333ba0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #1: ffffffff8e333ba0 (rcu_read_lock){....}-{1:2}, at: start_flush_work kernel/workqueue.c:4113 [inline]
 #1: ffffffff8e333ba0 (rcu_read_lock){....}-{1:2}, at: __flush_work+0xe6/0xd00 kernel/workqueue.c:4172

stack backtrace:
CPU: 0 PID: 6085 Comm: syz-executor.0 Not tainted 6.9.0-rc5-next-20240426-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
 touch_work_lockdep_map kernel/workqueue.c:3885 [inline]
 start_flush_work kernel/workqueue.c:4139 [inline]
 __flush_work+0x73c/0xd00 kernel/workqueue.c:4172
 __cancel_work_sync+0xbc/0x110 kernel/workqueue.c:4322
 hci_cmd_sync_clear+0x30/0x220 net/bluetooth/hci_sync.c:588
 hci_dev_close_sync+0xbae/0x1060 net/bluetooth/hci_sync.c:5188
 hci_dev_do_close net/bluetooth/hci_core.c:561 [inline]
 hci_unregister_dev+0x1db/0x4e0 net/bluetooth/hci_core.c:2778
 vhci_release+0x83/0xd0 drivers/bluetooth/hci_vhci.c:674
 __fput+0x406/0x8b0 fs/file_table.c:422
 task_work_run+0x24f/0x310 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa27/0x27e0 kernel/exit.c:874
 do_group_exit+0x207/0x2c0 kernel/exit.c:1023
 __do_sys_exit_group kernel/exit.c:1034 [inline]
 __se_sys_exit_group kernel/exit.c:1032 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1032
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1eb1a7dea9
Code: Unable to access opcode bytes at 0x7f1eb1a7de7f.
RSP: 002b:00007ffdd8d72208 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f1eb1ac93de RCX: 00007f1eb1a7dea9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000002 R08: 00007ffdd8d6ffa7 R09: 00007ffdd8d734c0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffdd8d734c0
R13: 00007f1eb1ac93b9 R14: 000000000001e31b R15: 0000000000000003
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

