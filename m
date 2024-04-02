Return-Path: <linux-kernel+bounces-128465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CBA895B2F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEF562862F9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0AC15AADB;
	Tue,  2 Apr 2024 17:54:28 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF04115AABC
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 17:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712080467; cv=none; b=mCZk2FdNFA89pqnHotakGR5gWszMiSExdtetN0DAEsa1YWzzUWnX01xLftOyNPRaxcWQ7Qz3FazDySL9gAJPeX5aSyg1HXtz2IMDiz7Xg4MD3A8yzKyZFfMrfSyBaSvnfFq3oYSIo1xo2QoduSZ/ojtW1cZLocXaAHOCVeTWe60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712080467; c=relaxed/simple;
	bh=An2Jp3BeEqpuw0kXtMrC3J6wpoU/Nui+LmIiPsH/Ax0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZetKkg0TTyWPA4o66XNT3Psq7Nkk/2Hk5/gJxHkFchX/ffWPPJdCnYOGZQJxJFZ3am8HXrXiiIKZmKpR3djYbcu+bRl/sMILPSQ0nvB7t3rN7dWIPkmIKFdlgtWmszUsiNJcklNv1inbdDnrPxYjYGSDW11tWX5dKRUxO8Wx3pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7cbfd9f04e3so10220739f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 10:54:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712080465; x=1712685265;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dneoHgsX3nsgd/CBqL8Tb4EZ1x6rRPwypobUWP/z48I=;
        b=BTjBOCFY0RcUOV2xv8olG0VhNhbFJ+lIBxTSo5WICB6Hj83OEVRy+wrbOF0KScdRvm
         hjNgxMHgWIpn4VOb446kwDCkg3FapEOnRKj5ULwvoYfm6XIpiTpkFTyq8MiKtbEjgLS1
         oSCjc77AXg+ZOb85f5NRCzebAUyi842ZpYZ7gQeO/+0h+hE4Q3ol46ulgyG4PwxdZQ7w
         IyL1VDoxc98Gbzyl0gSFdfKN29tXOtq02R4m3+Xya22DKDUpsnAmKR5nTathnQi9JDvK
         sMH9yXnR8m9olK2Rxlpklb3R3ux9lX/wR7D536onPxNKeZlW5hTHom6M4y9W7QZXlC/K
         FQKg==
X-Forwarded-Encrypted: i=1; AJvYcCVwBDdGR6KQ4r9mh7finL99YCi8msxu0cK9P6KmMY6h4IvviGp2QcT+mwnKB+1OX/NWnRQDgaQmQCHrG/20S9VKjXP0p3UawxxVUTx1
X-Gm-Message-State: AOJu0Yzgg22iK9+0+eYDKAGlX7LnJ2lL0v8iiDKXlmBP6Tg8qxrylG+g
	/mZMePoAGSRC97ZVuQAr5SYG5yMCxjwrNjbnsDvywAQZ+t0FWSUx7gWN4VOiENufkLrhYPWPV7p
	ducA8OzfKxL+WUhj0wbXvwOpKPF7aVFIjRQKfMddtGgw6UPEJqr5Bvds=
X-Google-Smtp-Source: AGHT+IFrncUXVW+v64ArE/rJ/le2TPQWM4rWPuCk1FkWHuD/NK956lQ1eZaw9GTQPH60b83cSh0aDKkzHdYNLI6OxXfRz/FFMdVr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c86:b0:366:b246:2f10 with SMTP id
 w6-20020a056e021c8600b00366b2462f10mr11956ill.2.1712080465159; Tue, 02 Apr
 2024 10:54:25 -0700 (PDT)
Date: Tue, 02 Apr 2024 10:54:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f3f1ef061520cb6e@google.com>
Subject: [syzbot] [io-uring?] kernel BUG in __io_remove_buffers
From: syzbot <syzbot+beb5226eef6218124e9d@syzkaller.appspotmail.com>
To: asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c0b832517f62 Add linux-next specific files for 20240402
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12d5def9180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=afcaf46d374cec8c
dashboard link: https://syzkaller.appspot.com/bug?extid=beb5226eef6218124e9d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1155ccc5180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14b06795180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0d36ec76edc7/disk-c0b83251.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6f9bb4e37dd0/vmlinux-c0b83251.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2349287b14b7/bzImage-c0b83251.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+beb5226eef6218124e9d@syzkaller.appspotmail.com

 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
------------[ cut here ]------------
kernel BUG at include/linux/mm.h:1135!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 PID: 12 Comm: kworker/u8:1 Not tainted 6.9.0-rc2-next-20240402-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue: events_unbound io_ring_exit_work
RIP: 0010:put_page_testzero include/linux/mm.h:1135 [inline]
RIP: 0010:folio_put_testzero include/linux/mm.h:1141 [inline]
RIP: 0010:folio_put include/linux/mm.h:1508 [inline]
RIP: 0010:put_page include/linux/mm.h:1581 [inline]
RIP: 0010:__io_remove_buffers+0x8ee/0x8f0 io_uring/kbuf.c:196
Code: ff fb ff ff 48 c7 c7 3c 68 a9 8f e8 fc b6 56 fd e9 ee fb ff ff e8 12 dc f1 fc 48 89 ef 48 c7 c6 60 ff 1e 8c e8 13 20 3b fd 90 <0f> 0b 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa
RSP: 0018:ffffc90000117830 EFLAGS: 00010246
RAX: 12798bbc5474ca00 RBX: 0000000000000000 RCX: 0000000000000001
RDX: dffffc0000000000 RSI: ffffffff8bcad5c0 RDI: 0000000000000001
RBP: ffffea0000880c40 R08: ffffffff92f3a5ef R09: 1ffffffff25e74bd
R10: dffffc0000000000 R11: fffffbfff25e74be R12: 0000000000000008
R13: 0000000000000002 R14: ffff88802d20d280 R15: ffffea0000880c74
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200020c4 CR3: 000000007d97a000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 io_put_bl io_uring/kbuf.c:229 [inline]
 io_destroy_buffers+0x14e/0x490 io_uring/kbuf.c:243
 io_ring_ctx_free+0x818/0xe70 io_uring/io_uring.c:2710
 io_ring_exit_work+0x7c7/0x850 io_uring/io_uring.c:2941
 process_one_work kernel/workqueue.c:3218 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3299
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3380
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:put_page_testzero include/linux/mm.h:1135 [inline]
RIP: 0010:folio_put_testzero include/linux/mm.h:1141 [inline]
RIP: 0010:folio_put include/linux/mm.h:1508 [inline]
RIP: 0010:put_page include/linux/mm.h:1581 [inline]
RIP: 0010:__io_remove_buffers+0x8ee/0x8f0 io_uring/kbuf.c:196
Code: ff fb ff ff 48 c7 c7 3c 68 a9 8f e8 fc b6 56 fd e9 ee fb ff ff e8 12 dc f1 fc 48 89 ef 48 c7 c6 60 ff 1e 8c e8 13 20 3b fd 90 <0f> 0b 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa
RSP: 0018:ffffc90000117830 EFLAGS: 00010246
RAX: 12798bbc5474ca00 RBX: 0000000000000000 RCX: 0000000000000001
RDX: dffffc0000000000 RSI: ffffffff8bcad5c0 RDI: 0000000000000001
RBP: ffffea0000880c40 R08: ffffffff92f3a5ef R09: 1ffffffff25e74bd
R10: dffffc0000000000 R11: fffffbfff25e74be R12: 0000000000000008
R13: 0000000000000002 R14: ffff88802d20d280 R15: ffffea0000880c74
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f31a71870f0 CR3: 000000007930c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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

