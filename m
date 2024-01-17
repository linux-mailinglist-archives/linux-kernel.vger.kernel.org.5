Return-Path: <linux-kernel+bounces-28805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA199830331
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2FC01C21405
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C8E14ABA;
	Wed, 17 Jan 2024 10:03:28 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FA41428B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 10:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705485807; cv=none; b=Oj07EmyWpu7NGzKkjvO3Mt5hkBfgSwTtJjpka4w9VwTG0E77Y26Kw6k0CANYRV41F++1awhhctxadGUYEHWKPZpo2IQMgmXLeesDdWkug47uKyAxQ/7SBeLWA5xjb3eNBYlz+d55zNdd84PaGBM4qWhHGjRTpvMSlepCiMv6Vb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705485807; c=relaxed/simple;
	bh=6Ba35sjl5j77N2GQR5J5Qza9P7y57/tDDptoGf9OcXI=;
	h=Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Google-Smtp-Source:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:
	 Message-ID:Subject:From:To:Content-Type; b=VAdAQHK4mXSIiKifCpMUm7pC3HPkIgq7VaUp2Q9Ut6KBiapXNNNOZiEw959tXX/wW/Fi4qp8nzX8CZ/sdRHuwIRlM0k4S3uIVFpuvSbAQZQOVkr5++chmr47oINDIzwERy6GCJJfikGhgZve98Yyt2NfJdHdDnmz0cH6KqILFcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3618e0060d1so10364975ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 02:03:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705485805; x=1706090605;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XnlLyvOefL1ydIX1ocF93Tqp6b+HX/ZrHqzQLe9vBGQ=;
        b=tDZFztrZR+t+nN4RzcOhJZJqDjZDvQMif4Oi+bd4+6aYSo8IqT4CDfW8fdRxcOnl2k
         Vx62bqRjlSayAjTMcnRzY/i+UQ9y5HjzXmQbKqnBTgssnl0wQ6aJjlynSAC00d1rM6QK
         uwPCp5u9krd/auVeAYCpzh9uriw1TEG4pqCItpe8+D+1E7a0TrUU/j//cildmANBjh9x
         hamPJWMktrbTiFEgpxKYjkAfdC6bidQom3+5qNdxytEZwC0DlB8apdg8fzykGr/aIHEG
         y/JwpSl3QlhZGSUtuGIV0z6qfZdjobS7nvYYACeFQ4Sik1+BlEvp4jy6zqdVFMt2/jCO
         EpEg==
X-Gm-Message-State: AOJu0YyUv/LHU5xfbUo0jDxMASATot0RLYQjF151PM+GGCqtJ4/5fTCu
	YXKVbEzb5mlRxpNygVtTdwoWETXGM8YftomAq8sx9biyO5P1
X-Google-Smtp-Source: AGHT+IGvV1agZFiqt/a//m5HZbLHbz1/WZWfpE0D+BlA/d5KlOxjXPWsR2fYtwiSR0/K9fKYRy4Y+8tEhqSYGeXfTim+0tv4CjwG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c565:0:b0:360:134:54b1 with SMTP id
 b5-20020a92c565000000b00360013454b1mr1232890ilj.0.1705485805272; Wed, 17 Jan
 2024 02:03:25 -0800 (PST)
Date: Wed, 17 Jan 2024 02:03:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000097c554060f215b50@google.com>
Subject: [syzbot] [bluetooth?] possible deadlock in __flush_workqueue
From: syzbot <syzbot+da0a9c9721e36db712e8@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    943b9f0ab2cf Add linux-next specific files for 20240117
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=121de2fbe80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=12af1d067b6a6d19
dashboard link: https://syzkaller.appspot.com/bug?extid=da0a9c9721e36db712e8
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9c032ce79e0f/disk-943b9f0a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/93163e287878/vmlinux-943b9f0a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/512cc2e14a4b/bzImage-943b9f0a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+da0a9c9721e36db712e8@syzkaller.appspotmail.com

Bluetooth: hci2: Opcode 0x0c03 failed: -110
============================================
WARNING: possible recursive locking detected
6.7.0-next-20240117-syzkaller #0 Not tainted
--------------------------------------------
kworker/u5:1/21244 is trying to acquire lock:
ffff88802e0a2538 ((wq_completion)hci2){+.+.}-{0:0}, at: __flush_workqueue+0x141/0x1340 kernel/workqueue.c:3147

but task is already holding lock:
ffff88802e0a2538 ((wq_completion)hci2){+.+.}-{0:0}, at: process_one_work+0x7ba/0x16e0 kernel/workqueue.c:2608

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock((wq_completion)hci2);
  lock((wq_completion)hci2);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

2 locks held by kworker/u5:1/21244:
 #0: ffff88802e0a2538 ((wq_completion)hci2){+.+.}-{0:0}, at: process_one_work+0x7ba/0x16e0 kernel/workqueue.c:2608
 #1: ffffc9000dc27d80 ((work_completion)(&hdev->error_reset)){+.+.}-{0:0}, at: process_one_work+0x824/0x16e0 kernel/workqueue.c:2609

stack backtrace:
CPU: 1 PID: 21244 Comm: kworker/u5:1 Not tainted 6.7.0-next-20240117-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Workqueue: hci2 hci_error_reset
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 check_deadlock kernel/locking/lockdep.c:3062 [inline]
 validate_chain kernel/locking/lockdep.c:3856 [inline]
 __lock_acquire+0x20e6/0x3b30 kernel/locking/lockdep.c:5137
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
 __flush_workqueue+0x14b/0x1340 kernel/workqueue.c:3147
 drain_workqueue+0x18f/0x3d0 kernel/workqueue.c:3312
 destroy_workqueue+0xc3/0xb10 kernel/workqueue.c:4801
 hci_release_dev+0x14e/0x620 net/bluetooth/hci_core.c:2808
 bt_host_release+0x6a/0xb0 net/bluetooth/hci_sysfs.c:94
 device_release+0xa1/0x240 drivers/base/core.c:2485
 kobject_cleanup lib/kobject.c:682 [inline]
 kobject_release lib/kobject.c:716 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1d0/0x440 lib/kobject.c:733
 put_device+0x1f/0x30 drivers/base/core.c:3733
 process_one_work+0x8d5/0x16e0 kernel/workqueue.c:2633
 process_scheduled_works kernel/workqueue.c:2707 [inline]
 worker_thread+0x8b6/0x1290 kernel/workqueue.c:2788
 kthread+0x2c1/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:242
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

