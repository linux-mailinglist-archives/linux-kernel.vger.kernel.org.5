Return-Path: <linux-kernel+bounces-31258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8F2832B48
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2D1F1F24D81
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 14:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9002753E01;
	Fri, 19 Jan 2024 14:23:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FF85380C
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 14:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705674187; cv=none; b=MoYUqWeZxeU3ERBRa7bhAJnLQGan6xRYv/ylB3CbEe6v2LYzRgLlQwWYzlE9sl4ygSjJOJYwqHRl9/7lXmgPM4xdIaNG4JStfAoxMNp9xBn3ReZFXoUmxEAZi/mshh0YwFlEvBID/JGcP2TRc/BaS5eAhED2tDr96spjLLZMVhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705674187; c=relaxed/simple;
	bh=O1Yah0LaGXZGay1B9zuj9o9GQfGOTAGq//u5CXQN+2A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LhlGjk0ohCpZGCjCo2gDCtv0aKSuxBilIhElKmiJZ9HoRozZSAaJDoW0VtKPPrZuc1Pp2WNF3bQrFsDqtiC2vrWrQkFVpPOrttm2ds81R6MmsJTZOCx7OKGNz4etSXVe7gVBeirkxFFfrZObnwmncrQiJou4CnzMdg8SvQH9E1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36037f2de0aso6563645ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 06:23:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705674184; x=1706278984;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zo0poaXOCLVUZwZ4CkyHeRMqIpcaqrvdLYjaLRYWg8o=;
        b=WQBe6oyrhXxxQbktxTWU80DopfxFmhyG2Jp1sSgwiTNQ+OoFvaZBYbCuy5t7cs518E
         hFjbSlUAECYlfPW2ArYrmmBfbBrsyL5WgIbfkrd0qSjejL4Wn7gIPhbrE9WZdkoT1IHg
         jkX1xSo/caPrwsYsYblwmpBjWcYtdkGfVx0B2PvZYXnDCMUH3DNjP1JtnEw8s5RznQwV
         n89KAkj4cESZJpek9TNNQDQVGe9bi0THXGF0co/GWD0KdyIYT08nFz8vGrKNKqEqwNbZ
         /53Be4H4kDsy/XvUUUxiTVPrCc/cEYDRxD5n46cXb3Q4aLImcWGjQLLh9TmG4QDPJGbJ
         f5kw==
X-Gm-Message-State: AOJu0YyBKQZnU1II+5d+HrSMk2EBGFZu0lyogNzzHGfwKknHRGVIM6lN
	oEjvEZ+/PWziUl5tY49H3JVpGTCsl5TqvaqIna7Zf+dxW7eoGfo3Hr9jQOpBVSp3Ec0P9saLeBr
	xD60MEcyiHsJ+SfLP0D++upxu6MhDlYECjTcA+9SKI6qaZjmEClikBYcZIg==
X-Google-Smtp-Source: AGHT+IFHC6omXxOCsxijXc8ufbyowaKXEyvEO+ZXw9Nwn+09GTpnZwijGHXhv6qx0fmKtB4LADDwbpxD3n0rlfEcZT6tuo1WZDBW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:144d:b0:35f:9ada:73a8 with SMTP id
 p13-20020a056e02144d00b0035f9ada73a8mr416672ilo.2.1705674184716; Fri, 19 Jan
 2024 06:23:04 -0800 (PST)
Date: Fri, 19 Jan 2024 06:23:04 -0800
In-Reply-To: <20240119132659.3158-1-n.zhandarovich@fintech.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e1f800060f4d375f@google.com>
Subject: Re: [syzbot] [can?] memory leak in j1939_netdev_start
From: syzbot <syzbot+1d37bef05da87b99c5a6@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, n.zhandarovich@fintech.ru, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
memory leak in corrupted

BUG: memory leak
unreferenced object 0xffff88812162e000 (size 8192):
  comm "syz-executor.2", pid 5912, jiffies 4294946210
  hex dump (first 32 bytes):
    00 e0 62 21 81 88 ff ff 00 e0 62 21 81 88 ff ff  ..b!......b!....
    00 00 00 00 00 00 00 00 00 00 36 1c 81 88 ff ff  ..........6.....
  backtrace (crc bbd5015e):
    [<ffffffff815fa6f3>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff815fa6f3>] slab_post_alloc_hook mm/slub.c:3817 [inline]
    [<ffffffff815fa6f3>] slab_alloc_node mm/slub.c:3860 [inline]
    [<ffffffff815fa6f3>] kmalloc_trace+0x283/0x330 mm/slub.c:4007
    [<ffffffff8457ddd9>] kmalloc include/linux/slab.h:590 [inline]
    [<ffffffff8457ddd9>] kzalloc include/linux/slab.h:711 [inline]
    [<ffffffff8457ddd9>] j1939_priv_create net/can/j1939/main.c:135 [inline]
    [<ffffffff8457ddd9>] j1939_netdev_start+0x159/0x6f0 net/can/j1939/main.c:272
    [<ffffffff8457fa1e>] j1939_sk_bind+0x21e/0x550 net/can/j1939/socket.c:485
    [<ffffffff83efe59c>] __sys_bind+0x11c/0x130 net/socket.c:1847
    [<ffffffff83efe5cc>] __do_sys_bind net/socket.c:1858 [inline]
    [<ffffffff83efe5cc>] __se_sys_bind net/socket.c:1856 [inline]
    [<ffffffff83efe5cc>] __x64_sys_bind+0x1c/0x20 net/socket.c:1856
    [<ffffffff84bb9910>] do_syscall_x64 arch/x86/entry/common.c:52 [inline]
    [<ffffffff84bb9910>] do_syscall_64+0x50/0x140 arch/x86/entry/common.c:83
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b

BUG: memory leak
unreferenced object 0xffff888122a49d00 (size 240):
  comm "softirq", pid 0, jiffies 4294946210
  hex dump (first 32 bytes):
    68 4c a6 21 81 88 ff ff 68 4c a6 21 81 88 ff ff  hL.!....hL.!....
    00 00 36 1c 81 88 ff ff 00 00 00 00 00 00 00 00  ..6.............
  backtrace (crc d6a71e41):
    [<ffffffff815f9b9a>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff815f9b9a>] slab_post_alloc_hook mm/slub.c:3817 [inline]
    [<ffffffff815f9b9a>] slab_alloc_node mm/slub.c:3860 [inline]
    [<ffffffff815f9b9a>] kmem_cache_alloc_node+0x28a/0x330 mm/slub.c:3903
    [<ffffffff83f11f5f>] __alloc_skb+0x1ef/0x230 net/core/skbuff.c:641
    [<ffffffff8458699f>] alloc_skb include/linux/skbuff.h:1296 [inline]
    [<ffffffff8458699f>] j1939_session_fresh_new net/can/j1939/transport.c:1535 [inline]
    [<ffffffff8458699f>] j1939_xtp_rx_rts_session_new net/can/j1939/transport.c:1631 [inline]
    [<ffffffff8458699f>] j1939_xtp_rx_rts+0x49f/0xa50 net/can/j1939/transport.c:1735
    [<ffffffff84587455>] j1939_tp_cmd_recv net/can/j1939/transport.c:2057 [inline]
    [<ffffffff84587455>] j1939_tp_recv+0x1b5/0x7f0 net/can/j1939/transport.c:2144
    [<ffffffff8457d9a9>] j1939_can_recv+0x349/0x4e0 net/can/j1939/main.c:112
    [<ffffffff8456e3f4>] deliver net/can/af_can.c:572 [inline]
    [<ffffffff8456e3f4>] can_rcv_filter+0xd4/0x290 net/can/af_can.c:606
    [<ffffffff8456eab0>] can_receive+0xf0/0x140 net/can/af_can.c:663
    [<ffffffff8456ebf0>] can_rcv+0xf0/0x130 net/can/af_can.c:687
    [<ffffffff83f4a976>] __netif_receive_skb_one_core+0x66/0x90 net/core/dev.c:5534
    [<ffffffff83f4a9ed>] __netif_receive_skb+0x1d/0x90 net/core/dev.c:5648
    [<ffffffff83f4ad4c>] process_backlog+0xbc/0x190 net/core/dev.c:5976
    [<ffffffff83f4bede>] __napi_poll+0x3e/0x310 net/core/dev.c:6576
    [<ffffffff83f4c8f8>] napi_poll net/core/dev.c:6645 [inline]
    [<ffffffff83f4c8f8>] net_rx_action+0x3d8/0x510 net/core/dev.c:6778
    [<ffffffff84bd799d>] __do_softirq+0xbd/0x2b0 kernel/softirq.c:553

BUG: memory leak
unreferenced object 0xffff888122f20000 (size 131072):
  comm "softirq", pid 0, jiffies 4294946210
  hex dump (first 32 bytes):
    0e 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc f7abe560):
    [<ffffffff815f313e>] __kmalloc_large_node+0xde/0x150 mm/slub.c:3935
    [<ffffffff815f8f8f>] __do_kmalloc_node mm/slub.c:3969 [inline]
    [<ffffffff815f8f8f>] __kmalloc_node_track_caller+0x35f/0x420 mm/slub.c:4001
    [<ffffffff83f0e1b6>] kmalloc_reserve+0x96/0x170 net/core/skbuff.c:582
    [<ffffffff83f11e45>] __alloc_skb+0xd5/0x230 net/core/skbuff.c:651
    [<ffffffff8458699f>] alloc_skb include/linux/skbuff.h:1296 [inline]
    [<ffffffff8458699f>] j1939_session_fresh_new net/can/j1939/transport.c:1535 [inline]
    [<ffffffff8458699f>] j1939_xtp_rx_rts_session_new net/can/j1939/transport.c:1631 [inline]
    [<ffffffff8458699f>] j1939_xtp_rx_rts+0x49f/0xa50 net/can/j1939/transport.c:1735
    [<ffffffff84587455>] j1939_tp_cmd_recv net/can/j1939/transport.c:2057 [inline]
    [<ffffffff84587455>] j1939_tp_recv+0x1b5/0x7f0 net/can/j1939/transport.c:2144
    [<ffffffff8457d9a9>] j1939_can_recv+0x349/0x4e0 net/can/j1939/main.c:112
    [<ffffffff8456e3f4>] deliver net/can/af_can.c:572 [inline]
    [<ffffffff8456e3f4>] can_rcv_filter+0xd4/0x290 net/can/af_can.c:606
    [<ffffffff8456eab0>] can_receive+0xf0/0x140 net/can/af_can.c:663
    [<ffffffff8456ebf0>] can_rcv+0xf0/0x130 net/can/af_can.c:687
    [<ffffffff83f4a976>] __netif_receive_skb_one_core+0x66/0x90 net/core/dev.c:5534
    [<ffffffff83f4a9ed>] __netif_receive_skb+0x1d/0x90 net/core/dev.c:5648
    [<ffffffff83f4ad4c>] process_backlog+0xbc/0x190 net/core/dev.c:5976
    [<ffffffff83f4bede>] __napi_poll+0x3e/0x310 net/core/dev.c:6576
    [<ffffffff83f4c8f8>] napi_poll net/core/dev.c:6645 [inline]
    [<ffffffff83f4c8f8>] net_rx_action+0x3d8/0x510 net/core/dev.c:6778
    [<ffffffff84bd799d>] __do_softirq+0xbd/0x2b0 kernel/softirq.c:553

BUG: memory leak
unreferenced object 0xffff888121a64c00 (size 512):
  comm "softirq", pid 0, jiffies 4294946210
  hex dump (first 32 bytes):
    00 e0 62 21 81 88 ff ff 28 f0 62 21 81 88 ff ff  ..b!....(.b!....
    28 f0 62 21 81 88 ff ff 18 4c a6 21 81 88 ff ff  (.b!.....L.!....
  backtrace (crc 5752fd94):
    [<ffffffff815fa6f3>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff815fa6f3>] slab_post_alloc_hook mm/slub.c:3817 [inline]
    [<ffffffff815fa6f3>] slab_alloc_node mm/slub.c:3860 [inline]
    [<ffffffff815fa6f3>] kmalloc_trace+0x283/0x330 mm/slub.c:4007
    [<ffffffff84581a13>] kmalloc include/linux/slab.h:590 [inline]
    [<ffffffff84581a13>] kzalloc include/linux/slab.h:711 [inline]
    [<ffffffff84581a13>] j1939_session_new+0x53/0x140 net/can/j1939/transport.c:1494
    [<ffffffff84586a35>] j1939_session_fresh_new net/can/j1939/transport.c:1546 [inline]
    [<ffffffff84586a35>] j1939_xtp_rx_rts_session_new net/can/j1939/transport.c:1631 [inline]
    [<ffffffff84586a35>] j1939_xtp_rx_rts+0x535/0xa50 net/can/j1939/transport.c:1735
    [<ffffffff84587455>] j1939_tp_cmd_recv net/can/j1939/transport.c:2057 [inline]
    [<ffffffff84587455>] j1939_tp_recv+0x1b5/0x7f0 net/can/j1939/transport.c:2144
    [<ffffffff8457d9a9>] j1939_can_recv+0x349/0x4e0 net/can/j1939/main.c:112
    [<ffffffff8456e3f4>] deliver net/can/af_can.c:572 [inline]
    [<ffffffff8456e3f4>] can_rcv_filter+0xd4/0x290 net/can/af_can.c:606
    [<ffffffff8456eab0>] can_receive+0xf0/0x140 net/can/af_can.c:663
    [<ffffffff8456ebf0>] can_rcv+0xf0/0x130 net/can/af_can.c:687
    [<ffffffff83f4a976>] __netif_receive_skb_one_core+0x66/0x90 net/core/dev.c:5534
    [<ffffffff83f4a9ed>] __netif_receive_skb+0x1d/0x90 net/core/dev.c:5648
    [<ffffffff83f4ad4c>] process_backlog+0xbc/0x190 net/core/dev.c:5976
    [<ffffffff83f4bede>] __napi_poll+0x3e/0x310 net/core/dev.c:6576
    [<ffffffff83f4c8f8>] napi_poll net/core/dev.c:6645 [inline]
    [<ffffffff83f4c8f8>] net_rx_action+0x3d8/0x510 net/core/dev.c:6778
    [<ffffffff84bd799d>] __do_softirq+0xbd/0x2b0 kernel/softirq.c:553



Tested on:

commit:         9d1694dc Merge tag 'for-6.8/block-2024-01-18' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17efd763e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=447c03a4f5a8d571
dashboard link: https://syzkaller.appspot.com/bug?extid=1d37bef05da87b99c5a6
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

