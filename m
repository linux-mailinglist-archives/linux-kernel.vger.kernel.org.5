Return-Path: <linux-kernel+bounces-21240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAE5828C67
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F035B1C259F5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C2A3C48C;
	Tue,  9 Jan 2024 18:20:33 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB593C062
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 18:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7baae0a27efso190507439f.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 10:20:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704824430; x=1705429230;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Tr1aIIWsVt//WG/Z51hhDuQCyR30G6igbYh+x2XRxA=;
        b=Vh0gJbJEJc1YajTlkEOPgjpbbUiATh8kkkWDU1gvISxalNle8RG40GNRPli/ZIxvEN
         pluMxWeqCe4z/9juFQXEqfEWOofN1n4R1RO2+WYrLxFywl53grLQC1lQECxX8WWOvzHk
         GN+QsgSKzgpaoQHDXnF+JWsB2GyzthcbhqEvAEpBm6ZJwpysJsc6F4cqqzwihp79XH6Q
         oAOfGe0Iw8RjAlRzX7plr+O5+8aKftSn/juYq0Bs9eCmBs0jKxsuhv/evzq+AaZMH/4s
         Nfo+TFfgLZ10pOLN7V+V7gRE8UkAtamV3843hCJ+LgF9LxAgHJCAwD33KGFAfkNM/LyT
         V+oA==
X-Gm-Message-State: AOJu0YxSbU7hnm+7NczSeKLaJ/Lynnlj0EaKWanW1zYqJ0JxhoJHd1fF
	8AqOSV+G4VsSgdAUcesYrkOFYufXwtFIFniuIckv1DOTBE4X
X-Google-Smtp-Source: AGHT+IHqa0NlqwbwjIezxAumM3nzDK1GGtqOkAJEHlw/qe/PfUY6XEpcX7Iv2ZpPENr15hQdlhVfIJv+q5Fpt10KBXmqBRZBGMwV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3e06:b0:46e:3b5e:70d0 with SMTP id
 co6-20020a0566383e0600b0046e3b5e70d0mr81788jab.3.1704824430144; Tue, 09 Jan
 2024 10:20:30 -0800 (PST)
Date: Tue, 09 Jan 2024 10:20:30 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000903473060e875e9e@google.com>
Subject: [syzbot] [hams?] KMSAN: uninit-value in nr_route_frame
From: syzbot <syzbot+f770ce3566e60e5573ac@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, ralf@linux-mips.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f5837722ffec Merge tag 'mm-hotfixes-stable-2023-12-27-15-0..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11b07dcee80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d4130d4bb32c48ef
dashboard link: https://syzkaller.appspot.com/bug?extid=f770ce3566e60e5573ac
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d07cf63b077e/disk-f5837722.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/444db9c07b7a/vmlinux-f5837722.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7ed4733987d7/bzImage-f5837722.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f770ce3566e60e5573ac@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in nr_route_frame+0x4a9/0xfc0 net/netrom/nr_route.c:787
 nr_route_frame+0x4a9/0xfc0 net/netrom/nr_route.c:787
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

CPU: 1 PID: 9891 Comm: syz-executor.5 Not tainted 6.7.0-rc7-syzkaller-00016-gf5837722ffec #0
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

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

