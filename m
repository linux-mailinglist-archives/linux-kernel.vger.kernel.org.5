Return-Path: <linux-kernel+bounces-146857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C97BC8A6BF4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B5211F214DC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A719512C54A;
	Tue, 16 Apr 2024 13:14:25 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F7312BF2E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 13:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713273265; cv=none; b=f2SF5IL3DQJ2tb5OcbUwLd0Ez4ZOBcxW90wPWBnmzHwmzcV3VmzZcU+FZHS9Jo3uvFlUcnAfjgFEpA4Pu3EICNLvCnqIq2v5YkD4m6d7+dJ8AzqsQ0FtTKiq9lWV2QaAxGEZ7eHCJW//4NZTPFlRZsP1IdtNWZDQ1vFjLydggP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713273265; c=relaxed/simple;
	bh=0h0/p87CiwSlulYJ7Vq9HEXjOCO3hXlKliBnh07+Rj0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qzBKcrFH7WkMzP8QUQqCYkfb4xN01xKRvYHq0dlIlKF5dA6eFYpZPk2aNMmGfxIA/UxWCPCWvUKXtwj5zEOybCRc0YcrFYA0+IVf7ixNpfVo5nuz4huW0PA8LNG8v9xUbyZuZJZ2BATEQxx3OL7FDRiRxgjkEpwL0TaegUc3L+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7d5e2b1cfabso466841739f.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 06:14:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713273260; x=1713878060;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aGftuxyuYCT1hAdzMTqOM9zYvkUin2a2cUCJ3awfpHY=;
        b=KSdWwwyOIXb0rUBk/QKeVfq5phsmwzcRry8Jp1wdmfJxnq4IMBBa3tS5r+trYlLL1v
         lYXhQZmJzgXYciVQD2vzTe9ew2E3flzpXilKT8ccSOqdPDUyrdIe5UjCFNXmhgjJbLHp
         +HymjZFFraPjD5YgsihqfPEmJwnjHJOVQ8ZdD5forzm1MiMRZlNAtaqFL7ozjnAhwec4
         kiWcbtHSPERILLpKaB1YkCyng06rhu1dP3fSSezk04hnEkuzbtZfJRlnxWPZwSaE/tG2
         JKv/R6bz8fmqFrT3ju1Wh5Uv+BcFahb3GjkovHhidLD6dkifRAO7bac261IjOVRbnh4M
         eguQ==
X-Forwarded-Encrypted: i=1; AJvYcCXM3OY4P3mdBKcIq0uHOAG5IauQR62u3DgFHzpjEu3fnzm7sEfbN7n/MfY1902pyU73w0StNvBTbQEShDZ52vbxN/s2uVerY3Co0NbI
X-Gm-Message-State: AOJu0YzL08YhA2v1jA2PDYr3rTHooqQO9rBcIUDuUMnaS5D1MZ6HhD3K
	sKjhZnM67fymcH3qZLxEeLCHy3iUY8XI2JKLKZjSXJkQ660RtgjDpAn9o4pbkUnyGww3EzL0weM
	REN9Zk4U4YUb4vdcHlPPfwXsl5BSxkS1tHjkW7Rx3nwIklZiwNqLOV40=
X-Google-Smtp-Source: AGHT+IGUbrGbiGRAhFv1LD6mc/kqP+MY7ym/nVA3dB34WCSzC+iOKcFFdWtqXb9a3XXiNaFYF/DpMP7esiJLZPT3SMO4xAW910UG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3786:b0:482:ffee:c6e6 with SMTP id
 w6-20020a056638378600b00482ffeec6e6mr659468jal.3.1713273260563; Tue, 16 Apr
 2024 06:14:20 -0700 (PDT)
Date: Tue, 16 Apr 2024 06:14:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000196a39061636840a@google.com>
Subject: [syzbot] [btrfs?] KMSAN: kernel-infoleak in btrfs_ioctl_logical_to_ino
 (2)
From: syzbot <syzbot+510a1abbb8116eeb341d@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    cef27048e5c2 Merge tag 'bcachefs-2024-04-15' of https://ev..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11a1fec7180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=87a805e655619c64
dashboard link: https://syzkaller.appspot.com/bug?extid=510a1abbb8116eeb341d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fce0439cf562/disk-cef27048.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/99540e71cf72/vmlinux-cef27048.xz
kernel image: https://storage.googleapis.com/syzbot-assets/65fbfc2c486f/bzImage-cef27048.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+510a1abbb8116eeb341d@syzkaller.appspotmail.com

BTRFS info (device loop1): first mount of filesystem c9fe44da-de57-406a-8241-57ec7d4412cf
BTRFS info (device loop1): using crc32c (crc32c-generic) checksum algorithm
BTRFS info (device loop1): using free-space-tree
=====================================================
BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/instrumented.h:114 [inline]
BUG: KMSAN: kernel-infoleak in _copy_to_user+0xbc/0x110 lib/usercopy.c:40
 instrument_copy_to_user include/linux/instrumented.h:114 [inline]
 _copy_to_user+0xbc/0x110 lib/usercopy.c:40
 copy_to_user include/linux/uaccess.h:191 [inline]
 btrfs_ioctl_logical_to_ino+0x440/0x750 fs/btrfs/ioctl.c:3499
 btrfs_ioctl+0x714/0x1260
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:904 [inline]
 __se_sys_ioctl+0x261/0x450 fs/ioctl.c:890
 __x64_sys_ioctl+0x96/0xe0 fs/ioctl.c:890
 x64_sys_call+0x1883/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:17
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 __kmalloc_large_node+0x231/0x370 mm/slub.c:3921
 __do_kmalloc_node mm/slub.c:3954 [inline]
 __kmalloc_node+0xb07/0x1060 mm/slub.c:3973
 kmalloc_node include/linux/slab.h:648 [inline]
 kvmalloc_node+0xc0/0x2d0 mm/util.c:634
 kvmalloc include/linux/slab.h:766 [inline]
 init_data_container+0x49/0x1e0 fs/btrfs/backref.c:2779
 btrfs_ioctl_logical_to_ino+0x17c/0x750 fs/btrfs/ioctl.c:3480
 btrfs_ioctl+0x714/0x1260
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:904 [inline]
 __se_sys_ioctl+0x261/0x450 fs/ioctl.c:890
 __x64_sys_ioctl+0x96/0xe0 fs/ioctl.c:890
 x64_sys_call+0x1883/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:17
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Bytes 40-65535 of 65536 are uninitialized
Memory access of size 65536 starts at ffff888045a40000

CPU: 0 PID: 5428 Comm: syz-executor.1 Not tainted 6.9.0-rc4-syzkaller-00028-gcef27048e5c2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
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

