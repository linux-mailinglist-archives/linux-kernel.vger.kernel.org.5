Return-Path: <linux-kernel+bounces-13802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D81821146
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 00:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2282F2826C7
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 23:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48278C8CF;
	Sun, 31 Dec 2023 23:38:22 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8E2C15B
	for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 23:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-35fd42a187bso58812655ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 15:38:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704065899; x=1704670699;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yBPG0jD4joUl5mOrKlSvFtp8B+BSg6tUyqdhSm2Q0kQ=;
        b=iCONIr0BbC6ONQF/DZ4ABtPIk769QteOPXrmrS9CweBVT/ZnTHZbqzDBZnpoHIb/G/
         r3AeRcL0yigPyZvis1NKx5nrzyyKDwiyAmWHXhGIWTqSjpDlnw7PgHTjQlGba/CgQ/Oy
         qLed6h+0x8V8VjqWd4nscFXEzw+joR+GgoQYVP418ReA3jPyolViNQ7hGuTxU8H3KRmv
         k3hRTRw5JYN7+QJnV0O+BbZkofr1JKYEahCXapSzF4MDtEQVXdzij8wIsihP9lUIg+cw
         69mNLbcUoPGYWBcuYQ8CM9jzj6K/VLNnY4jbdz9+jTB7eKNDc8u7d+5KbmZWwOEOKOZe
         9teA==
X-Gm-Message-State: AOJu0YyyUTR6/QpdwC8ycuLIjWFdTEMvoJ25kihAYfy4X/a2MJwFWYap
	L4KezW954hDWiorkSArj3/EDFPfqavP5tk22kk7yyJFoUCB4
X-Google-Smtp-Source: AGHT+IHwz08QnIlLH5aNgXdvdbRNIKqMY+Lw393O4cvAu/HZtiBwRJxOWncqg6U9KkQG6IypcozWLB/NOnma1Y07Ct0V8ZfsqJgJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b4c:b0:360:290:902d with SMTP id
 f12-20020a056e020b4c00b003600290902dmr1940705ilu.3.1704065899585; Sun, 31 Dec
 2023 15:38:19 -0800 (PST)
Date: Sun, 31 Dec 2023 15:38:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009e6825060dd6c287@google.com>
Subject: [syzbot] [dri?] [media?] memory leak in get_sg_table
From: syzbot <syzbot+9b4adfed366b14496e7e@syzkaller.appspotmail.com>
To: christian.koenig@amd.com, dri-devel@lists.freedesktop.org, 
	kraxel@redhat.com, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	sumit.semwal@linaro.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fbafc3e621c3 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10ae11cee80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e81921f96ae24ec0
dashboard link: https://syzkaller.appspot.com/bug?extid=9b4adfed366b14496e7e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1635d436e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15e8171ae80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/76e4a40f41aa/disk-fbafc3e6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a2f88511ce98/vmlinux-fbafc3e6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2b21933ed8f1/bzImage-fbafc3e6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9b4adfed366b14496e7e@syzkaller.appspotmail.com

Warning: Permanently added '10.128.0.162' (ED25519) to the list of known hosts.
executing program
executing program
BUG: memory leak
unreferenced object 0xffff88810af03840 (size 16):
  comm "syz-executor111", pid 5038, jiffies 4294942820 (age 13.250s)
  hex dump (first 16 bytes):
    80 8b 89 0b 81 88 ff ff 04 00 00 00 04 00 00 00  ................
  backtrace:
    [<ffffffff816346ed>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff816346ed>] slab_post_alloc_hook mm/slab.h:766 [inline]
    [<ffffffff816346ed>] slab_alloc_node mm/slub.c:3478 [inline]
    [<ffffffff816346ed>] __kmem_cache_alloc_node+0x2dd/0x3f0 mm/slub.c:3517
    [<ffffffff8157f315>] kmalloc_trace+0x25/0x90 mm/slab_common.c:1098
    [<ffffffff82cfd7fa>] kmalloc include/linux/slab.h:600 [inline]
    [<ffffffff82cfd7fa>] kzalloc include/linux/slab.h:721 [inline]
    [<ffffffff82cfd7fa>] get_sg_table.isra.0+0x2a/0xe0 drivers/dma-buf/udmabuf.c:93
    [<ffffffff82cfd943>] begin_cpu_udmabuf+0x63/0xa0 drivers/dma-buf/udmabuf.c:156
    [<ffffffff82cf114b>] dma_buf_begin_cpu_access+0x3b/0xc0 drivers/dma-buf/dma-buf.c:1402
    [<ffffffff82cf1d90>] dma_buf_ioctl+0x550/0x660 drivers/dma-buf/dma-buf.c:475
    [<ffffffff816bf4a2>] vfs_ioctl fs/ioctl.c:51 [inline]
    [<ffffffff816bf4a2>] __do_sys_ioctl fs/ioctl.c:871 [inline]
    [<ffffffff816bf4a2>] __se_sys_ioctl fs/ioctl.c:857 [inline]
    [<ffffffff816bf4a2>] __x64_sys_ioctl+0xf2/0x140 fs/ioctl.c:857
    [<ffffffff84b71e2f>] do_syscall_x64 arch/x86/entry/common.c:52 [inline]
    [<ffffffff84b71e2f>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:83
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b

BUG: memory leak
unreferenced object 0xffff88810b898b80 (size 128):
  comm "syz-executor111", pid 5038, jiffies 4294942820 (age 13.250s)
  hex dump (first 32 bytes):
    c0 09 2a 04 00 ea ff ff 00 00 00 00 00 10 00 00  ..*.............
    00 70 82 0a 01 00 00 00 00 10 00 00 00 00 00 00  .p..............
  backtrace:
    [<ffffffff816346ed>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff816346ed>] slab_post_alloc_hook mm/slab.h:766 [inline]
    [<ffffffff816346ed>] slab_alloc_node mm/slub.c:3478 [inline]
    [<ffffffff816346ed>] __kmem_cache_alloc_node+0x2dd/0x3f0 mm/slub.c:3517
    [<ffffffff8157f9bb>] __do_kmalloc_node mm/slab_common.c:1006 [inline]
    [<ffffffff8157f9bb>] __kmalloc+0x4b/0x150 mm/slab_common.c:1020
    [<ffffffff8251661f>] kmalloc_array include/linux/slab.h:637 [inline]
    [<ffffffff8251661f>] sg_kmalloc lib/scatterlist.c:167 [inline]
    [<ffffffff8251661f>] get_next_sg lib/scatterlist.c:402 [inline]
    [<ffffffff8251661f>] sg_alloc_append_table_from_pages+0x35f/0x770 lib/scatterlist.c:526
    [<ffffffff82516abc>] sg_alloc_table_from_pages_segment+0x8c/0x120 lib/scatterlist.c:586
    [<ffffffff82cfd82e>] sg_alloc_table_from_pages include/linux/scatterlist.h:477 [inline]
    [<ffffffff82cfd82e>] get_sg_table.isra.0+0x5e/0xe0 drivers/dma-buf/udmabuf.c:96
    [<ffffffff82cfd943>] begin_cpu_udmabuf+0x63/0xa0 drivers/dma-buf/udmabuf.c:156
    [<ffffffff82cf114b>] dma_buf_begin_cpu_access+0x3b/0xc0 drivers/dma-buf/dma-buf.c:1402
    [<ffffffff82cf1d90>] dma_buf_ioctl+0x550/0x660 drivers/dma-buf/dma-buf.c:475
    [<ffffffff816bf4a2>] vfs_ioctl fs/ioctl.c:51 [inline]
    [<ffffffff816bf4a2>] __do_sys_ioctl fs/ioctl.c:871 [inline]
    [<ffffffff816bf4a2>] __se_sys_ioctl fs/ioctl.c:857 [inline]
    [<ffffffff816bf4a2>] __x64_sys_ioctl+0xf2/0x140 fs/ioctl.c:857
    [<ffffffff84b71e2f>] do_syscall_x64 arch/x86/entry/common.c:52 [inline]
    [<ffffffff84b71e2f>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:83
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b



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

