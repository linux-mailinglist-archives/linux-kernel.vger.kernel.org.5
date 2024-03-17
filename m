Return-Path: <linux-kernel+bounces-105436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2264187DDD6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 16:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7323B20C30
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 15:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A831C6A1;
	Sun, 17 Mar 2024 15:15:28 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3101C680
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 15:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710688527; cv=none; b=GqHtIMAaybVjdYnIcWU7f4D3EUXP95t1l7VgUgPXQ9BOAkX/ptTXL0ASSIS1I8G+w5NVhy2jcxjIWQrX+inyqAb4hxmBl4oxXTS8RKO0zwIsuDdwIhR/EFSw6toGiDGyfx31Es42QJYvPHIQeL3Xj4sI8q1/Nu3YmrK1tJfPvb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710688527; c=relaxed/simple;
	bh=JNMyT6Pp9T/AN28IGslHtW/8uUWOtjEo+0vtv76E6ok=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=g9/cUJT9fxqhcNe+w26iOkdiSF2aTJHoPEIDY1gcw2IeFCNo2Ow26v5DPr8UJ4BLu2MxDE7JDYlCxYfKRaCnw0OW0XmFY4q9C8DWmOfUD558rGMohHviP+QH4JejSlVaEsrjLHWu6J2n2jWpQXirenrBHAZIxihEzSExJQ0Z5n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c7c9831579so333385239f.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 08:15:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710688525; x=1711293325;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c4MegSmNgbP67cM4Eg9+6Ly/Lj6iOzU/s39gtIU5YNA=;
        b=PLM5luvCJgMfLN/UUVPfp+qfBTir9plDh3FglNNXbIq3kI0KuBe1v45sK1Sq7vaVX1
         ZB61ACteldOzSefL8pMmHMvi3+UeBz98uzSfIh38az6UKBRUB+jjlIGitQMj4ga9uT5W
         bRR7DVPdw9lEtN8Nq/X7MaJ0zNxkNMQCnQ7ih8nHvRAHDcsqqemWxKlNsogIg7tRrEzy
         em6EwhTls27Sgy+0T0X+PrHGPTI3Ba+3v2vC6BDdG14QwRSGte5RciA3znev5bHz1qUI
         TDAHTo5HXhs4iDdeBFi8aGMlCbOwHQltbKiYl4bfFnTp81CfPQ3E6mgS6xCJXyPjf8H5
         oLcQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+0MHLsmizjTxfgSQBU2OMiOBXklavNhgaphBlGTyN1W096VGvmBmdiYFDJHeHdF4kydEM/vFtGxzNjUYLS0bmOYUCPPCl/UCLKwwG
X-Gm-Message-State: AOJu0YzChxY4U1WraKN5rgd2LCAai5vtYkuj07ZYIN/mTrd2wZzHIVYQ
	3kIJ4nfNP0tMhggdMG+IOY06mb71F00tdLd9HugFvAoJIOEa2+b1I8fmjUS4KJ+dktbzGPPPmdg
	62Vt1vbaYTCj99rpHLe+dGckGDttc+TWuXnxvjOXlqiajkiKcnc/5DDQ=
X-Google-Smtp-Source: AGHT+IGOI7cZzAMSL6yMplFa5y6AX80e1XSk0w8sadvRzZ0r+OU3OxUW29wdtXGii0ZbuxRyGaN5AC7dkymb2ah/cEDBUYSS2t8i
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:502:b0:366:b7c0:9c72 with SMTP id
 d2-20020a056e02050200b00366b7c09c72mr89508ils.3.1710688525553; Sun, 17 Mar
 2024 08:15:25 -0700 (PDT)
Date: Sun, 17 Mar 2024 08:15:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e327b00613dcb50d@google.com>
Subject: [syzbot] [bluetooth?] WARNING in l2cap_chan_del
From: syzbot <syzbot+3272785b7a1fc9b510f6@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b0546776ad3f Merge tag 'printk-for-6.9' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15bf5b99180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4ae24324b37fdefe
dashboard link: https://syzkaller.appspot.com/bug?extid=3272785b7a1fc9b510f6
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-b0546776.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a07801fab32c/vmlinux-b0546776.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0696c91a7e74/bzImage-b0546776.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3272785b7a1fc9b510f6@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 9 at kernel/workqueue.c:2322 __queue_work+0xc44/0x1170 kernel/workqueue.c:2321
Modules linked in:
CPU: 0 PID: 9 Comm: kworker/0:1 Not tainted 6.8.0-syzkaller-05292-gb0546776ad3f #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: events l2cap_chan_timeout
RIP: 0010:__queue_work+0xc44/0x1170 kernel/workqueue.c:2321
Code: 38 d0 7c 09 84 d2 74 05 e8 89 f6 8f 00 8b 5b 2c 31 ff 83 e3 20 89 de e8 5a 64 34 00 85 db 0f 85 fe 00 00 00 e8 6d 69 34 00 90 <0f> 0b 90 e9 1c f9 ff ff e8 5f 69 34 00 90 0f 0b 90 e9 cb f8 ff ff
RSP: 0018:ffffc900003b7ab8 EFLAGS: 00010093
RAX: 0000000000000000 RBX: ffff888014c94000 RCX: ffffffff815ae3ea
RDX: ffff888015704880 RSI: ffffffff815928d3 RDI: ffff888014c94008
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000200000 R11: 0000000000000004 R12: ffff88801f8648c0
R13: 0000000000000008 R14: ffff88801f8648c8 R15: ffff88804bf9e000
FS:  0000000000000000(0000) GS:ffff88802c200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000030e25000 CR3: 00000000277b0000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __queue_delayed_work+0x21b/0x2e0 kernel/workqueue.c:2551
 queue_delayed_work_on+0x10e/0x130 kernel/workqueue.c:2595
 queue_delayed_work include/linux/workqueue.h:620 [inline]
 hci_conn_drop include/net/bluetooth/hci_core.h:1621 [inline]
 hci_conn_drop include/net/bluetooth/hci_core.h:1591 [inline]
 l2cap_chan_del+0x5a3/0x930 net/bluetooth/l2cap_core.c:647
 l2cap_chan_close+0xff/0xa30 net/bluetooth/l2cap_core.c:820
 l2cap_chan_timeout+0x17d/0x2f0 net/bluetooth/l2cap_core.c:432
 process_one_work+0x902/0x19d0 kernel/workqueue.c:3254
 process_scheduled_works kernel/workqueue.c:3335 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3416
 kthread+0x2c1/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
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

