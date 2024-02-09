Return-Path: <linux-kernel+bounces-60067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C7984FF73
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 23:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 013C3B218F3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9613B210FA;
	Fri,  9 Feb 2024 22:10:34 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F00107AA
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 22:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707516634; cv=none; b=O3XcZYjI4ygpvgrp5mg+oc/gI3y2whMUsQlzovQvpOV1C9gvFGom8hZ7ilP2WM9bL0lRe6c8VG27GWxtjr2m9QEzPbJ8I2usAhAxovAug5RqFMUhJFXVKeiBBQxqTrvP9rYA43gY63WQ+jVNm0hXlNtFATQWfrMbDCsEO4hxJ5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707516634; c=relaxed/simple;
	bh=FbPrgaVYVx/Y2b65Tnm0kYD6DQGnYXAIo43/KnRZdXA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mdNSPFYQ1p2bR4N2PFIaGZp/Ku5Jgl+ojHzV4g7i2+5b3NWCsNTnsK++UWseevaxnx73Vjamgv7Dy+8auOnYWfD5Ed+lcM5dewwTCAlzNBXoAhd64HPn1UpgP9cmoJCiiFY71kVQkxWrmJpj9SlmT+Cys6kbYdFGnKY23V2RpjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3610073a306so11595085ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 14:10:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707516632; x=1708121432;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kYMKdXEgEYoOzbuN4s8Mp96TJ3NrCTFqEoQiv1HCOb0=;
        b=bZcchag/KZF+MBztEjbZ5+xc8UpdSpas87suZwXxLFaqf8Tff9IxtWwJOWmqyyRNq7
         o4Ntvnpc3LE/sgKkntxavqOAcmvlWT5iS0nf7PJs5TKQ+pKeIpv3mbJTxx01Kyjshxje
         7yMasQkpaveqaBCsMNM0Zr/t5Uw0qpfjPlhWTt/E2HTb9dtkGp0GxWyL7GMbQkaiqhYT
         g3IZvaeCt1u8kM5KiuLezQjkAH+i9/vGdhoQDKpSBaQ8mrphvG54vdedDxl7/VazLn8q
         jGqlm/vYa05xuVTa7paMdybKtMUo0R7rUcn/l9E9I5nz8wNhsd/8nlbNWJ/7TaSpxBg6
         Ul8g==
X-Gm-Message-State: AOJu0YwgK3SDiQn7pASGt3cXBmenz7wCfs/6dViFp38gAVo0d41Zdfpx
	myQKB5TSOLp72RVrrvtG3ffNra2X5uaBW47hswSS6LRBHDOtoE8M1QzyuK6V2UDuFIcxAdRkri8
	oEJi3cj3NnIgkioFp3G7uwfzD0xN9ejXgf1tsRSIxyFXN6XcjMBwWDU4=
X-Google-Smtp-Source: AGHT+IEwoDlrwJtfpvZJDJ+cxkRbuTG9pkve1xAHBaqzCAa+6mIDt9nNVnbKQiHG5ZVW0pcL14OEXsM34+5Pc6wxxnQEh/S8HCtU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c24a:0:b0:363:c576:d6c5 with SMTP id
 k10-20020a92c24a000000b00363c576d6c5mr27774ilo.3.1707516631914; Fri, 09 Feb
 2024 14:10:31 -0800 (PST)
Date: Fri, 09 Feb 2024 14:10:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004b1fa70610fa3230@google.com>
Subject: [syzbot] [io-uring?] KMSAN: uninit-value in io_rw_fail (2)
From: syzbot <syzbot+0198afa90d8c29ef9557@syzkaller.appspotmail.com>
To: asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9f8413c4a66f Merge tag 'cgroup-for-6.8' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1743d3e4180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=656820e61b758b15
dashboard link: https://syzkaller.appspot.com/bug?extid=0198afa90d8c29ef9557
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/79d9f2f4b065/disk-9f8413c4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cbc68430d9c6/vmlinux-9f8413c4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9740ad9fc172/bzImage-9f8413c4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0198afa90d8c29ef9557@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in io_fixup_rw_res io_uring/rw.c:311 [inline]
BUG: KMSAN: uninit-value in io_rw_fail+0x1a7/0x1b0 io_uring/rw.c:1099
 io_fixup_rw_res io_uring/rw.c:311 [inline]
 io_rw_fail+0x1a7/0x1b0 io_uring/rw.c:1099
 io_req_defer_failed+0x217/0x3e0 io_uring/io_uring.c:1065
 io_queue_sqe_fallback+0x1f4/0x260 io_uring/io_uring.c:2100
 io_submit_state_end io_uring/io_uring.c:2345 [inline]
 io_submit_sqes+0x2b85/0x2ff0 io_uring/io_uring.c:2463
 __do_sys_io_uring_enter io_uring/io_uring.c:3712 [inline]
 __se_sys_io_uring_enter+0x40c/0x42d0 io_uring/io_uring.c:3647
 __x64_sys_io_uring_enter+0x11b/0x1a0 io_uring/io_uring.c:3647
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x6d/0x140 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was created at:
 slab_post_alloc_hook+0x129/0xa70 mm/slab.h:768
 slab_alloc_node mm/slub.c:3478 [inline]
 __kmem_cache_alloc_node+0x5c9/0x970 mm/slub.c:3517
 __do_kmalloc_node mm/slab_common.c:1006 [inline]
 __kmalloc+0x121/0x3c0 mm/slab_common.c:1020
 kmalloc include/linux/slab.h:604 [inline]
 io_alloc_async_data io_uring/io_uring.c:1780 [inline]
 io_req_prep_async+0x384/0x5a0 io_uring/io_uring.c:1801
 io_queue_sqe_fallback+0x95/0x260 io_uring/io_uring.c:2097
 io_submit_state_end io_uring/io_uring.c:2345 [inline]
 io_submit_sqes+0x2b85/0x2ff0 io_uring/io_uring.c:2463
 __do_sys_io_uring_enter io_uring/io_uring.c:3712 [inline]
 __se_sys_io_uring_enter+0x40c/0x42d0 io_uring/io_uring.c:3647
 __x64_sys_io_uring_enter+0x11b/0x1a0 io_uring/io_uring.c:3647
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x6d/0x140 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

CPU: 0 PID: 5401 Comm: syz-executor.4 Not tainted 6.7.0-syzkaller-00562-g9f8413c4a66f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
=====================================================


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

