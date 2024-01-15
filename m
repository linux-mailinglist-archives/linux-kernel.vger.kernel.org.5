Return-Path: <linux-kernel+bounces-26120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F316D82DB92
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CAFC28330C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9277D17BAA;
	Mon, 15 Jan 2024 14:44:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E1817BA0
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 14:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7bf2a953988so205497239f.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 06:44:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705329844; x=1705934644;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MaitCPFvyIY9al8Q6TsPj6Cx5sAjS5Oz7uBT4t9XoyI=;
        b=gR7ce77eQve5yE6EC1e/g8uYjovawzGpQQFTsmgRa3MfLkTNYjSxZUHJQnuOiVeWSO
         AFqKz1s8OtyNiKeeq2ykzQ3qeH7s4M2YVd1EpodHAULPFuMz5IMwdM9bXU2ggaDlKn3J
         +HDezBgcIC25sLW/NXvs5iS2ZbFCz19lJ8HXbTqUUwrS/sVcAxW5MeCTWuxFKkcFvEgU
         fqrYV9kMtyAZcqusKlwZwla2iB1+p2SND07d2u5/Kitx+QEPOoQ7EfQ+v14HU8jefAxy
         BWliQgNRZX5hXY1J1EEzwOD3MfJ7/lZnD9zIJIfrhnMaxPt9y/Sunf0mncgpT2e7AVTC
         ZhcA==
X-Gm-Message-State: AOJu0Ywm849u9I/u1u7GM1uIp4PZS/WlgwYB2pPqVGAh9Rc+RqjmZoH6
	wIv7mGq99C+wILIX3uZt1uJBuLjh6E0wwKh3EqPlDrkShXt9
X-Google-Smtp-Source: AGHT+IEa1pjWZvNmya+nzQ6zWqvdwSU1zmtbNonl5pPowCN36kaZyCEdmd8Xy11uy+OIj+GP9SNxpUcKBZuOMu/1av5ppHKR34DQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:19d8:b0:7bf:1ddd:f3a6 with SMTP id
 ba24-20020a05660219d800b007bf1dddf3a6mr56674iob.0.1705329843954; Mon, 15 Jan
 2024 06:44:03 -0800 (PST)
Date: Mon, 15 Jan 2024 06:44:03 -0800
In-Reply-To: <tencent_E8B0751D76BD66F43CDD363296D836844A09@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000092edb0060efd0b74@google.com>
Subject: Re: [syzbot] [net?] KMSAN: uninit-value in hsr_get_node (2)
From: syzbot <syzbot+2ef3a8ce8e91b5a50098@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in hsr_get_node

=====================================================
BUG: KMSAN: uninit-value in hsr_get_node+0xca2/0xd10 net/hsr/hsr_framereg.c:248
 hsr_get_node+0xca2/0xd10 net/hsr/hsr_framereg.c:248
 fill_frame_info net/hsr/hsr_forward.c:577 [inline]
 hsr_forward_skb+0xe12/0x30e0 net/hsr/hsr_forward.c:615
 hsr_dev_xmit+0x1a1/0x270 net/hsr/hsr_device.c:223
 __netdev_start_xmit include/linux/netdevice.h:4940 [inline]
 netdev_start_xmit include/linux/netdevice.h:4954 [inline]
 xmit_one net/core/dev.c:3548 [inline]
 dev_hard_start_xmit+0x247/0xa10 net/core/dev.c:3564
 __dev_queue_xmit+0x33b8/0x5130 net/core/dev.c:4349
 dev_queue_xmit include/linux/netdevice.h:3134 [inline]
 packet_xmit+0x9c/0x6b0 net/packet/af_packet.c:276
 packet_snd net/packet/af_packet.c:3087 [inline]
 packet_sendmsg+0x8b1d/0x9f30 net/packet/af_packet.c:3119
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 __sys_sendto+0x735/0xa10 net/socket.c:2191
 __do_sys_sendto net/socket.c:2203 [inline]
 __se_sys_sendto net/socket.c:2199 [inline]
 __x64_sys_sendto+0x125/0x1c0 net/socket.c:2199
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x6d/0x140 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was created at:
 slab_post_alloc_hook+0x129/0xa70 mm/slab.h:768
 slab_alloc_node mm/slub.c:3478 [inline]
 kmem_cache_alloc_node+0x5e9/0xb10 mm/slub.c:3523
 kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:560
 __alloc_skb+0x318/0x740 net/core/skbuff.c:651
 alloc_skb include/linux/skbuff.h:1286 [inline]
 alloc_skb_with_frags+0xc8/0xbd0 net/core/skbuff.c:6334
 sock_alloc_send_pskb+0xa80/0xbf0 net/core/sock.c:2787
 packet_alloc_skb net/packet/af_packet.c:2936 [inline]
 packet_snd net/packet/af_packet.c:3030 [inline]
 packet_sendmsg+0x70e8/0x9f30 net/packet/af_packet.c:3119
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 __sys_sendto+0x735/0xa10 net/socket.c:2191
 __do_sys_sendto net/socket.c:2203 [inline]
 __se_sys_sendto net/socket.c:2199 [inline]
 __x64_sys_sendto+0x125/0x1c0 net/socket.c:2199
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x6d/0x140 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

CPU: 0 PID: 5476 Comm: syz-executor.0 Not tainted 6.7.0-syzkaller-00562-g9f8413c4a66f-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
=====================================================


Tested on:

commit:         9f8413c4 Merge tag 'cgroup-for-6.8' of git://git.kerne..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14df3ca5e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=656820e61b758b15
dashboard link: https://syzkaller.appspot.com/bug?extid=2ef3a8ce8e91b5a50098
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1233e735e80000


