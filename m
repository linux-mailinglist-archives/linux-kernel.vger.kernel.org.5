Return-Path: <linux-kernel+bounces-76232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9288185F48C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F328281F36
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1AA22BD1C;
	Thu, 22 Feb 2024 09:35:24 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BAF1799E
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 09:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708594524; cv=none; b=csBX4KYSvU2h5EqIJSYiyXBuYzJGcpF0V8VjMIgUjIy0+H+uPw0kOD7RodTbVXxe2y9P9tUlxKvJWAD0B4cSao3MgeBRg4H6MR7Nxth04mv8vqwyWLrpADvvPhLsBgeMx0IPckwRiyFNC/FYYl+Z3Hgz+/h1M4atFYiajyOZXC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708594524; c=relaxed/simple;
	bh=A1j6cI3HyuafN3Oq+UFelCk07PZrFKiD2hmPr5qdttg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=b758zBIb5UpnkacKqRz0uK8/AtH+KfG8QeQCeF2uxYBIZNtjUZuD9NTWrrE8PisqSc9/74AdbAsuVJ6wBJ1ct03mWynBz5oB/f5pGqXOUHBHjiftNjGETgSCv5ceUJUrc0KGGiBXkFb2+259Gj8iCIwPXTdk64qvPYsltXSQ2ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c00a1374ecso139993039f.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 01:35:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708594522; x=1709199322;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iz3Yq/YyMxk/zYfbHfrSscwB4SWnhgOeHQPFTViCTeE=;
        b=gLOuB/Obr01COqli3XEUn/iuGvnXKRmWPS8dO2KTDwVAdK6v1Wf0v1YEXlH1AUtoJO
         YEobBQUWeCJ6EToybGRQNHcGHblXfaradkMZIqXreOsm5FrJBDDXSqEb1sbDhO3jqT5x
         Tnl238SpRYa6jWTDAV7mBbAcW1RfAAMVVED9v+7ANP4gKKtYtcEBktzL4brFYn0pp7I8
         cLuxUQwztORBqHs0YN2PZw8Qh/cZGoU5G/dvjauolEi+kaM1TwgYRyEyp56Zo/VP83hG
         IB0GjMrsI1jhEW23k/kUHssPEZI0SDe8/LyYt2dpeJUavkK0cQ3lhsBU9hYJ8DcUVMIW
         E02Q==
X-Forwarded-Encrypted: i=1; AJvYcCXvM2Wboee1uDEe7E4tnFO8J55MIJrqvrXw2xh2AdVCJ4kJuKNdT1N94Ystxdd5WqeJGs7XgMnNL5lFdncdjhWe2RtZCfW9ypyKY54R
X-Gm-Message-State: AOJu0YzayK9/pyUjkvtaHGGQ6orw0lb4oU5wDv+iDRis1lO/cFzvZkCf
	QvjV9Q+rEdliu68k2ArdNuIpfQgG4wMccj0o/Oqn5HRl8LoA2mT6DdpPy5H4YSe58zruS0BRyPh
	o0os2Si/Uh2y0iGGr0J8ZBENPNlw4XIfagkiUIGvduRxxQhFmQlwsN7s=
X-Google-Smtp-Source: AGHT+IHDlAcJtRyAEJA7Xybjs90n8ZuT9bnHnHktG2E30gAYxxrBXTpXTbo0PX9Dvwjxxl0yT6twXr2tkIuG754ccJ2xf2g1KUvj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4703:b0:471:59aa:c087 with SMTP id
 cs3-20020a056638470300b0047159aac087mr185300jab.5.1708594521455; Thu, 22 Feb
 2024 01:35:21 -0800 (PST)
Date: Thu, 22 Feb 2024 01:35:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008441e70611f52901@google.com>
Subject: [syzbot] [io-uring?] WARNING in io_ring_exit_work (2)
From: syzbot <syzbot+557a278955ff3a4d3938@syzkaller.appspotmail.com>
To: asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2c3b09aac00d Add linux-next specific files for 20240214
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14ba5b8a180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=176d2dcbf8ba7017
dashboard link: https://syzkaller.appspot.com/bug?extid=557a278955ff3a4d3938
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ac51042b61c6/disk-2c3b09aa.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/012344301c35/vmlinux-2c3b09aa.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cba3c3e5cd7c/bzImage-2c3b09aa.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+557a278955ff3a4d3938@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 164 at io_uring/io_uring.c:3062 io_ring_exit_work+0x39b/0x850 io_uring/io_uring.c:3062
Modules linked in:
CPU: 0 PID: 164 Comm: kworker/u8:5 Not tainted 6.8.0-rc4-next-20240214-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Workqueue: events_unbound io_ring_exit_work
RIP: 0010:io_ring_exit_work+0x39b/0x850 io_uring/io_uring.c:3062
Code: 23 e8 c9 0e 24 f6 48 8b 7c 24 10 48 8b 74 24 08 e8 1a b7 0a 00 48 85 c0 75 3d e8 b0 0e 24 f6 e9 96 fd ff ff e8 a6 0e 24 f6 90 <0f> 0b 90 b8 70 17 00 00 48 89 44 24 08 eb cd 44 89 f9 80 e1 07 80
RSP: 0018:ffffc90002e1fa40 EFLAGS: 00010293
RAX: ffffffff8b6fd11a RBX: 000000010000d095 RCX: ffff88801b7cda00
RDX: 0000000000000000 RSI: fffffffffffffffa RDI: 0000000000000000
RBP: ffffc90002e1fbb0 R08: ffffffff8b6fd0ed R09: 1ffff920005c3f38
R10: dffffc0000000000 R11: fffff520005c3f39 R12: 000000010000d08f
R13: ffff88807afd6288 R14: ffff88807afd6538 R15: ffff88807afd6000
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f01f05ad988 CR3: 0000000028fc8000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 process_one_work kernel/workqueue.c:3146 [inline]
 process_scheduled_works+0x9d7/0x1730 kernel/workqueue.c:3226
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3307
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
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

