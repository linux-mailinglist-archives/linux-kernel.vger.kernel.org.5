Return-Path: <linux-kernel+bounces-13850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 709F5821379
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 11:14:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08E441F220C9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 10:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCF53C39;
	Mon,  1 Jan 2024 10:14:21 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969AB2112
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jan 2024 10:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7baf2c8f19eso550398639f.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jan 2024 02:14:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704104058; x=1704708858;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GXvqISVn8onyZBKPrIZRQ97IB9/CKJb74yBSAE58lx8=;
        b=bwDDTLeusoEFmPVMcqiNJfr+PdsZUXigfczY6L0Uk80zunzu5KDHwm7ISKKeKrhpqr
         zyqGUhD76zG7zp2oDPY6m1WeMmH+60gaHDQ7nLYubFS7cZU6iX6yraYAe9czYdOqWyXk
         nBnGP4Ic2khW+ZyJEOUVQFKGrt1WlEARe0FXNZ30RmciVKN+unbdf0OWuIBPPVWR4L0T
         2rRFdmVjiQhe71i9gUXifW+I6UA7Lgg/8sZfsngeSjDlW7NImfk33T5AumhBmjS2fb1I
         OJ1wK5YPa4PKUcCwwmxD1w/GFAGCNvNgzr6L3Rdi3z2lbHoCkjHJIdQrIiqQgPRmOPK6
         X1LA==
X-Gm-Message-State: AOJu0Yxx9lmZZcSHXGgfhFQJK9/0+cPKQuugoNB6vXJIoEQJz3BKDP5G
	UfNp6W5UoEtL/z7co8yuoJp8jgVHrBxeER9+/hEwNiNxOjuX
X-Google-Smtp-Source: AGHT+IG9WCs0yadqIyxWkG+e9QpgUgkNv0sV4LNNJsBrhkqessl9rE0X6f9YMyo0+7WD5qk4h0CjVBcQOdYdnJjBl2mAkyMase+3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c2d:b0:360:e80:1bd6 with SMTP id
 m13-20020a056e021c2d00b003600e801bd6mr1541462ilh.1.1704104058798; Mon, 01 Jan
 2024 02:14:18 -0800 (PST)
Date: Mon, 01 Jan 2024 02:14:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000015c980060ddfa5d0@google.com>
Subject: [syzbot] [hams?] KMSAN: uninit-value in ax25cmp (3)
From: syzbot <syzbot+74161d266475935e9c5d@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, ralf@linux-mips.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fbafc3e621c3 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13563e09e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e0c7078a6b901aa3
dashboard link: https://syzkaller.appspot.com/bug?extid=74161d266475935e9c5d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a0b836e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1201287ee80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1520f7b6daa4/disk-fbafc3e6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8b490af009d5/vmlinux-fbafc3e6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/202ca200f4a4/bzImage-fbafc3e6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+74161d266475935e9c5d@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in ax25cmp+0x3a5/0x460 net/ax25/ax25_addr.c:119
 ax25cmp+0x3a5/0x460 net/ax25/ax25_addr.c:119
 nr_dev_get+0x20e/0x450 net/netrom/nr_route.c:601
 nr_route_frame+0x1a2/0xfc0 net/netrom/nr_route.c:774
 nr_xmit+0x5a/0x1c0 net/netrom/nr_dev.c:144
 __netdev_start_xmit include/linux/netdevice.h:4940 [inline]
 netdev_start_xmit include/linux/netdevice.h:4954 [inline]
 xmit_one net/core/dev.c:3548 [inline]
 dev_hard_start_xmit+0x247/0xa10 net/core/dev.c:3564
 __dev_queue_xmit+0x33b8/0x5130 net/core/dev.c:4349
 dev_queue_xmit include/linux/netdevice.h:3134 [inline]
 raw_sendmsg+0x654/0xc10 net/ieee802154/socket.c:299
 ieee802154_sock_sendmsg+0x91/0xc0 net/ieee802154/socket.c:96
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2584
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2638
 __sys_sendmsg net/socket.c:2667 [inline]
 __do_sys_sendmsg net/socket.c:2676 [inline]
 __se_sys_sendmsg net/socket.c:2674 [inline]
 __x64_sys_sendmsg+0x307/0x490 net/socket.c:2674
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was created at:
 slab_post_alloc_hook+0x129/0xa70 mm/slab.h:768
 slab_alloc_node mm/slub.c:3478 [inline]
 kmem_cache_alloc_node+0x5e9/0xb10 mm/slub.c:3523
 kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:560
 __alloc_skb+0x318/0x740 net/core/skbuff.c:651
 alloc_skb include/linux/skbuff.h:1286 [inline]
 alloc_skb_with_frags+0xc8/0xbd0 net/core/skbuff.c:6334
 sock_alloc_send_pskb+0xa80/0xbf0 net/core/sock.c:2780
 sock_alloc_send_skb include/net/sock.h:1884 [inline]
 raw_sendmsg+0x36d/0xc10 net/ieee802154/socket.c:282
 ieee802154_sock_sendmsg+0x91/0xc0 net/ieee802154/socket.c:96
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0x9c2/0xd60 net/socket.c:2584
 ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2638
 __sys_sendmsg net/socket.c:2667 [inline]
 __do_sys_sendmsg net/socket.c:2676 [inline]
 __se_sys_sendmsg net/socket.c:2674 [inline]
 __x64_sys_sendmsg+0x307/0x490 net/socket.c:2674
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

CPU: 0 PID: 5037 Comm: syz-executor166 Not tainted 6.7.0-rc7-syzkaller-00003-gfbafc3e621c3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
=====================================================


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

