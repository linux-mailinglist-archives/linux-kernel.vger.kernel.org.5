Return-Path: <linux-kernel+bounces-23581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F19C482AEA6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 041A71C23B33
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189C815AD7;
	Thu, 11 Jan 2024 12:23:30 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E1215AC2
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 12:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-360a85e5e82so12650015ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 04:23:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704975807; x=1705580607;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C+Do2wLekHyOSCIJUK3h/DUjhFiTmTBs0NQIfxE6tXs=;
        b=tnxCWr3tFIQTCERgRC4Yw8HRH66gSCcwhgSHMNc2xaONFrVgwlcwdKXLXqxQj9Cv8A
         Pxzt+bQG8eZ//2UBRd2z9VfRZs5sAHzCtZbciHe7scmjdcZFoP7lyrPDA6iYsgpaQVMm
         E/icUOZNvN/6PNWLqjKCpyDFf1l/LWMRtwSC1N5n9EIRiDjCcRrgpPvmL3XfjEZv98Xq
         f3ZtdIDjTx202xnuuWkySrnIRj5iyOevtSjH9omySh4Yv4+BD1vodyz4kNTG8IKyhrKp
         EmCKR0A205txuj+imIeGnS+zmiuVUzhzsTOD6hVk3CVuTTsYQOGakETGsEY+HqQxSWc6
         +lLg==
X-Gm-Message-State: AOJu0Yx6R3YCx1uU+MsBBTGXy+6cwy5u3D691EX+VYTzNjEMTLDo00lk
	ol4OOmuyt4ilQw+Ffa3xfsvh3Li8GNTt1PC3KRWpOZVEOWU5
X-Google-Smtp-Source: AGHT+IEOL4YeE4wbgAcDOYdGqJ9PUjvQ4D6o/XE7rUpmKpy6r3CX4iz/JQLWeTrC8A4y69HqggnOTe+W/4Tn9uRXqjFw2QKY6yfQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ba4:b0:35f:affb:bd7b with SMTP id
 n4-20020a056e021ba400b0035faffbbd7bmr139929ili.2.1704975807167; Thu, 11 Jan
 2024 04:23:27 -0800 (PST)
Date: Thu, 11 Jan 2024 04:23:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005644b8060eaa9d6e@google.com>
Subject: [syzbot] [can?] memory leak in can_create (2)
From: syzbot <syzbot+521ac15269e89d8546e8@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kernel@pengutronix.de, 
	kuba@kernel.org, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mkl@pengutronix.de, netdev@vger.kernel.org, o.rempel@pengutronix.de, 
	pabeni@redhat.com, robin@protonic.nl, socketcan@hartkopp.net, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    52b1853b080a Merge tag 'i2c-for-6.7-final' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17315deee80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dcb7609da8da79e3
dashboard link: https://syzkaller.appspot.com/bug?extid=521ac15269e89d8546e8
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14aa5a41e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0f9568a404dd/disk-52b1853b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e339a63284ed/vmlinux-52b1853b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8aae66c13215/bzImage-52b1853b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+521ac15269e89d8546e8@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88811f2c8400 (size 1024):
  comm "syz-executor.6", pid 5653, jiffies 4295068840 (age 14.060s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    1d 00 07 41 00 00 00 00 00 00 00 00 00 00 00 00  ...A............
  backtrace:
    [<ffffffff8163470d>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff8163470d>] slab_post_alloc_hook mm/slab.h:766 [inline]
    [<ffffffff8163470d>] slab_alloc_node mm/slub.c:3478 [inline]
    [<ffffffff8163470d>] __kmem_cache_alloc_node+0x2dd/0x3f0 mm/slub.c:3517
    [<ffffffff8157f9db>] __do_kmalloc_node mm/slab_common.c:1006 [inline]
    [<ffffffff8157f9db>] __kmalloc+0x4b/0x150 mm/slab_common.c:1020
    [<ffffffff83eccc42>] kmalloc include/linux/slab.h:604 [inline]
    [<ffffffff83eccc42>] sk_prot_alloc+0x112/0x1b0 net/core/sock.c:2082
    [<ffffffff83ecffb6>] sk_alloc+0x36/0x2f0 net/core/sock.c:2135
    [<ffffffff84535474>] can_create+0x194/0x320 net/can/af_can.c:158
    [<ffffffff83ec53cf>] __sock_create+0x19f/0x2e0 net/socket.c:1571
    [<ffffffff83ec8c58>] sock_create net/socket.c:1622 [inline]
    [<ffffffff83ec8c58>] __sys_socket_create net/socket.c:1659 [inline]
    [<ffffffff83ec8c58>] __sys_socket+0xb8/0x1a0 net/socket.c:1706
    [<ffffffff83ec8d5b>] __do_sys_socket net/socket.c:1720 [inline]
    [<ffffffff83ec8d5b>] __se_sys_socket net/socket.c:1718 [inline]
    [<ffffffff83ec8d5b>] __x64_sys_socket+0x1b/0x20 net/socket.c:1718
    [<ffffffff84b71e0f>] do_syscall_x64 arch/x86/entry/common.c:52 [inline]
    [<ffffffff84b71e0f>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:83
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b

BUG: memory leak
unreferenced object 0xffff888120161490 (size 16):
  comm "syz-executor.6", pid 5653, jiffies 4295068840 (age 14.060s)
  hex dump (first 16 bytes):
    00 c3 87 00 81 88 ff ff 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8163470d>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff8163470d>] slab_post_alloc_hook mm/slab.h:766 [inline]
    [<ffffffff8163470d>] slab_alloc_node mm/slub.c:3478 [inline]
    [<ffffffff8163470d>] __kmem_cache_alloc_node+0x2dd/0x3f0 mm/slub.c:3517
    [<ffffffff8157f335>] kmalloc_trace+0x25/0x90 mm/slab_common.c:1098
    [<ffffffff823a7a92>] kmalloc include/linux/slab.h:600 [inline]
    [<ffffffff823a7a92>] kzalloc include/linux/slab.h:721 [inline]
    [<ffffffff823a7a92>] apparmor_sk_alloc_security+0x52/0xd0 security/apparmor/lsm.c:997
    [<ffffffff8236b887>] security_sk_alloc+0x47/0x80 security/security.c:4411
    [<ffffffff83eccc5d>] sk_prot_alloc+0x12d/0x1b0 net/core/sock.c:2085
    [<ffffffff83ecffb6>] sk_alloc+0x36/0x2f0 net/core/sock.c:2135
    [<ffffffff84535474>] can_create+0x194/0x320 net/can/af_can.c:158
    [<ffffffff83ec53cf>] __sock_create+0x19f/0x2e0 net/socket.c:1571
    [<ffffffff83ec8c58>] sock_create net/socket.c:1622 [inline]
    [<ffffffff83ec8c58>] __sys_socket_create net/socket.c:1659 [inline]
    [<ffffffff83ec8c58>] __sys_socket+0xb8/0x1a0 net/socket.c:1706
    [<ffffffff83ec8d5b>] __do_sys_socket net/socket.c:1720 [inline]
    [<ffffffff83ec8d5b>] __se_sys_socket net/socket.c:1718 [inline]
    [<ffffffff83ec8d5b>] __x64_sys_socket+0x1b/0x20 net/socket.c:1718
    [<ffffffff84b71e0f>] do_syscall_x64 arch/x86/entry/common.c:52 [inline]
    [<ffffffff84b71e0f>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:83
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b

BUG: memory leak
unreferenced object 0xffff88811fbf2000 (size 8192):
  comm "syz-executor.6", pid 5653, jiffies 4295068840 (age 14.060s)
  hex dump (first 32 bytes):
    00 20 bf 1f 81 88 ff ff 00 20 bf 1f 81 88 ff ff  . ....... ......
    00 00 00 00 00 00 00 00 00 00 5f 1b 81 88 ff ff  .........._.....
  backtrace:
    [<ffffffff8163470d>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff8163470d>] slab_post_alloc_hook mm/slab.h:766 [inline]
    [<ffffffff8163470d>] slab_alloc_node mm/slub.c:3478 [inline]
    [<ffffffff8163470d>] __kmem_cache_alloc_node+0x2dd/0x3f0 mm/slub.c:3517
    [<ffffffff8157f335>] kmalloc_trace+0x25/0x90 mm/slab_common.c:1098
    [<ffffffff845437c9>] kmalloc include/linux/slab.h:600 [inline]
    [<ffffffff845437c9>] kzalloc include/linux/slab.h:721 [inline]
    [<ffffffff845437c9>] j1939_priv_create net/can/j1939/main.c:135 [inline]
    [<ffffffff845437c9>] j1939_netdev_start+0x159/0x6f0 net/can/j1939/main.c:272
    [<ffffffff8454540e>] j1939_sk_bind+0x21e/0x550 net/can/j1939/socket.c:485
    [<ffffffff83ec926c>] __sys_bind+0x11c/0x130 net/socket.c:1847
    [<ffffffff83ec929c>] __do_sys_bind net/socket.c:1858 [inline]
    [<ffffffff83ec929c>] __se_sys_bind net/socket.c:1856 [inline]
    [<ffffffff83ec929c>] __x64_sys_bind+0x1c/0x20 net/socket.c:1856
    [<ffffffff84b71e0f>] do_syscall_x64 arch/x86/entry/common.c:52 [inline]
    [<ffffffff84b71e0f>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:83
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b

BUG: memory leak
unreferenced object 0xffff888120daf700 (size 240):
  comm "syz-executor.6", pid 5653, jiffies 4295068840 (age 14.060s)
  hex dump (first 32 bytes):
    68 aa 12 1e 81 88 ff ff 68 aa 12 1e 81 88 ff ff  h.......h.......
    00 00 5f 1b 81 88 ff ff 00 84 2c 1f 81 88 ff ff  .._.......,.....
  backtrace:
    [<ffffffff81632177>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff81632177>] slab_post_alloc_hook mm/slab.h:766 [inline]
    [<ffffffff81632177>] slab_alloc_node mm/slub.c:3478 [inline]
    [<ffffffff81632177>] kmem_cache_alloc_node+0x2c7/0x450 mm/slub.c:3523
    [<ffffffff83edcb9f>] __alloc_skb+0x1ef/0x230 net/core/skbuff.c:641
    [<ffffffff83ee6111>] alloc_skb include/linux/skbuff.h:1286 [inline]
    [<ffffffff83ee6111>] alloc_skb_with_frags+0x71/0x3a0 net/core/skbuff.c:6334
    [<ffffffff83ed0c4b>] sock_alloc_send_pskb+0x3ab/0x3e0 net/core/sock.c:2787
    [<ffffffff84545de8>] sock_alloc_send_skb include/net/sock.h:1884 [inline]
    [<ffffffff84545de8>] j1939_sk_alloc_skb net/can/j1939/socket.c:864 [inline]
    [<ffffffff84545de8>] j1939_sk_send_loop net/can/j1939/socket.c:1128 [inline]
    [<ffffffff84545de8>] j1939_sk_sendmsg+0x2f8/0x7f0 net/can/j1939/socket.c:1263
    [<ffffffff83ec6c92>] sock_sendmsg_nosec net/socket.c:730 [inline]
    [<ffffffff83ec6c92>] __sock_sendmsg+0x52/0xa0 net/socket.c:745
    [<ffffffff83ec72f5>] ____sys_sendmsg+0x365/0x470 net/socket.c:2586
    [<ffffffff83ecb019>] ___sys_sendmsg+0xc9/0x130 net/socket.c:2640
    [<ffffffff83ecb1c6>] __sys_sendmsg+0xa6/0x120 net/socket.c:2669
    [<ffffffff84b71e0f>] do_syscall_x64 arch/x86/entry/common.c:52 [inline]
    [<ffffffff84b71e0f>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:83
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

