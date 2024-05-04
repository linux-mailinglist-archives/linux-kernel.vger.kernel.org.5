Return-Path: <linux-kernel+bounces-168481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAA38BB909
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 03:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CD241F23A42
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 01:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03DF185E;
	Sat,  4 May 2024 01:00:36 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93061859
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 01:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714784436; cv=none; b=m2Fg2W7hEPgbewfold8I6gIOYeKto1tsDy5xuCSqAyrDy1YCo9ObaMErMmDnQZMlRjEqaepYfos8ajXVLbNufwlDwIbbKts0Z8ZBsPegSSwNUOgKt/DyHx4iYB0WWhq03ks+eA8Cq+x3e+X6uCcy1W2ABFQLhFDAFnxZYYrm2ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714784436; c=relaxed/simple;
	bh=rbrv/uO8x339Bf9QsPW4XI9G5+0LQ0kLO3wtEO7061s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NsGdG+FzmYxYTALOZMYGlpMAQpsLvIVXTlS7yoVmwh48Ahu+LijlyIsO5TcGAD5R+VgZ3SHfYVFc/nGItL3Dhl4VbNdXIAp8nzAt2dCwCoSReTI9KgmtyfBpnHo6FafspJqi5OWYKGxP5mpCjiCb/XLRyaAlK2UL7i6U9PNrNcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3699565f54fso2735785ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 18:00:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714784434; x=1715389234;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=13VlsOafpue+rR6MEGsLRUTp3wxvRHrbzi94eouLLSg=;
        b=Hf/axbeim+MAR4Y/9H/rrI3WzFJXkTWTUZ2nADJ3eYdPf3k5Jz/ssd8A602Ob9ZMCn
         5LfxP/S0W6CYSzK8braHN2ssDhrd8TgQlRd3OSkHbx4jlgBktV0ycjffnUoc5XsnaBy7
         s19xDz4xPakrGLaB0sPflqz+NZFY7wSJvnJpHeZPVqKRHAJACkAFZMiwHjEYJuMgaOPg
         vGhsUsDWc/zyuhw5cm41ubQNowHTWufa89ptSY3PNx4JPLk4OTnkubtt4fBIXG/rrJOn
         1bxCB6oFav87jU+Sg5aRUgGU+Pe/o9vZl7OFUt0rD9gODCKlDWRdWqetNfG3mKpyHKAS
         Emfw==
X-Forwarded-Encrypted: i=1; AJvYcCVdDVE4RJflmVqGxpWI3GDGqs3Dc97BRzHYQ5hxHkR7EJpaaK9xcEedLNsSIzSPyEIOnWSpFf/gVQeXWK/vyxj+YK1kCwplIhlgHHWb
X-Gm-Message-State: AOJu0YwSuLCuj/Cd7jp122+thdxR9lGXlRZanUuvcYIjf11+BzqA+447
	qQJdMUuzMKEz2QnMMxLqwRdhzOHFa1L03DLb2PDD2YwCxHJONefMgUUomKjlYrszA0BUDVBlajR
	+UldbhZHt7s3ooXtcLoYv+UeydOBDlrekH3wUid6BRrGBmdFdVl8UOE8=
X-Google-Smtp-Source: AGHT+IF1qot3FEmDqiwdE7hOJsVeGwiOubmimtdkAsqCaoz9VYHcjljE8yDi5crARTexprWo/BoMXzsP1/LOplMmCKX/hvs14DRF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17cd:b0:36b:85e:7cdc with SMTP id
 z13-20020a056e0217cd00b0036b085e7cdcmr208245ilu.1.1714784434013; Fri, 03 May
 2024 18:00:34 -0700 (PDT)
Date: Fri, 03 May 2024 18:00:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000e60e70617965d98@google.com>
Subject: [syzbot] [bluetooth?] KFENCE: invalid free in __hci_req_sync
From: syzbot <syzbot+27f0d8597a213f37c0b6@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9d1ddab261f3 Merge tag '6.9-rc5-smb-client-fixes' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=145d5280980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=545d4b3e07d6ccbc
dashboard link: https://syzkaller.appspot.com/bug?extid=27f0d8597a213f37c0b6
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-9d1ddab2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5d5ab6e818c4/vmlinux-9d1ddab2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cf81babb0258/bzImage-9d1ddab2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+27f0d8597a213f37c0b6@syzkaller.appspotmail.com

==================================================================
BUG: KFENCE: invalid free in kfree_skbmem+0x10e/0x200 net/core/skbuff.c:1159

Invalid free of 0xffff88816db60f00 (in kfence-#175):
 kfree_skbmem+0x10e/0x200 net/core/skbuff.c:1159
 __kfree_skb net/core/skbuff.c:1217 [inline]
 kfree_skb_reason+0x13a/0x210 net/core/skbuff.c:1252
 kfree_skb include/linux/skbuff.h:1262 [inline]
 __hci_req_sync+0x61d/0x980 net/bluetooth/hci_request.c:184
 hci_req_sync+0x97/0xd0 net/bluetooth/hci_request.c:206
 hci_dev_cmd+0x653/0x9c0 net/bluetooth/hci_core.c:790
 hci_sock_ioctl+0x4f3/0x8e0 net/bluetooth/hci_sock.c:1153
 sock_do_ioctl+0x116/0x280 net/socket.c:1222
 sock_ioctl+0x22e/0x6c0 net/socket.c:1341
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:904 [inline]
 __se_sys_ioctl fs/ioctl.c:890 [inline]
 __x64_sys_ioctl+0x193/0x220 fs/ioctl.c:890
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

kfence-#175: 0xffff88816db60f00-0xffff88816db60fef, size=240, cache=skbuff_head_cache

allocated by task 64 on cpu 2 at 217.660109s:
 skb_clone+0x190/0x3f0 net/core/skbuff.c:2063
 hci_send_cmd_sync net/bluetooth/hci_core.c:4220 [inline]
 hci_cmd_work+0x66a/0x710 net/bluetooth/hci_core.c:4240
 process_one_work+0x9a9/0x1ac0 kernel/workqueue.c:3254
 process_scheduled_works kernel/workqueue.c:3335 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3416
 kthread+0x2c1/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

freed by task 64 on cpu 2 at 217.660313s:
 kfree_skbmem+0x10e/0x200 net/core/skbuff.c:1159
 __kfree_skb net/core/skbuff.c:1217 [inline]
 kfree_skb_reason+0x13a/0x210 net/core/skbuff.c:1252
 kfree_skb include/linux/skbuff.h:1262 [inline]
 hci_req_sync_complete+0x16c/0x270 net/bluetooth/hci_request.c:109
 hci_event_packet+0x963/0x1170 net/bluetooth/hci_event.c:7604
 hci_rx_work+0x2c4/0x1610 net/bluetooth/hci_core.c:4171
 process_one_work+0x9a9/0x1ac0 kernel/workqueue.c:3254
 process_scheduled_works kernel/workqueue.c:3335 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3416
 kthread+0x2c1/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

CPU: 1 PID: 11620 Comm: syz-executor.2 Not tainted 6.9.0-rc5-syzkaller-00036-g9d1ddab261f3 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
==================================================================


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

