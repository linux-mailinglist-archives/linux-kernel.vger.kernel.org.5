Return-Path: <linux-kernel+bounces-36356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F48839F9F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C933282389
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D634BE61;
	Wed, 24 Jan 2024 02:51:08 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4116DBE45
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 02:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706064667; cv=none; b=gWIQA7vt43wgKOsG32QjoWkiC1gzrXCkM6pjqUx1BXUfiBqd4AZ8OqyqUoe1nQs41onwdrwwtWAGElyM5ty/pxkFkz6wNRKr8cfw/T1mpsUA2M1YAbexaxEqppXM6TkCPkpOwiaBTMwxJFWYj61DglFBfW/Xa8AUC+enHmYZn1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706064667; c=relaxed/simple;
	bh=ycNP+a8NhST+9uaMU0omn9nmqoiUGhkB6HDfgVWWHXA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rpvI0iGmM4fqYRzwe3Qej3OrmS/nwclHIZvvhSlg7mhC9fgBvN4h0U+Vnc/VZGQYiCgjMSDBd8iaIvDK7zu5qzg8szafBuPytrt7D+4S2X4cQH37G7nRPpggAoTukFU3KMjJmPoIT2HwBKsU7mTCfFpy5R14oKCPBbdU7B1S1sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-361a7af102eso27368285ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 18:51:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706064664; x=1706669464;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L+g72DXx2jSxu6m10Huj2z9SBaJK1Z8TtWL2BpS8toM=;
        b=buG+thY+YCr7g2iiQoR5vQn/xQni80x7IlTF8p14FYJ5WzOtpCBLQGSvSs+AsohaHR
         hZ38TiiuQ2EHGdQd00HwV7NjxETniVpzNwTJt8SE79M4FUgQEKUQrQ5Dc/TxLs+xs8BO
         yztWxag40cYA02KfEyv29LgGaWw6L566NbnreeuGmhDiBFNbOf8g3AW8zPLSYJTy4v3j
         snk00+0PtgS7dBb5T2qC5G/JWGYGJNz9SUGan61pOjTTKJStUoj5HtU9oeWS6X5ZfAFH
         yavoDnnDZJZfTC1fmE44YIJzeh/2AXQQMPi+PTlWmBCdnVszJ+INRqeowJRYcLRkVYcE
         ZMxQ==
X-Gm-Message-State: AOJu0YzxQBqgbhuiO7MOcrp5J8VyCVVpC0Z2kpmCe5/gorItERJhyPs6
	guXeAdGs8HJMO41SAtMSlzt/g/WwTsoN868qroud5/TgbI/Olt+nhuJDxKEGet6s2BTqmsBN7ua
	1IVuR4/EkwXVRvan8JZ5bh6ZPUEtjhF7cw8sZAqe67I77FRw72Ac3vDI=
X-Google-Smtp-Source: AGHT+IFSQdcwMvqO343/QjGS/JmJue0nwvIn+qoLmYri3GIlru835ixqrtHuaVA/5dyAfVKpHYwFv/eEiS3Dfwop7PYdwjBBWDBx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2193:b0:35f:e864:f6f with SMTP id
 j19-20020a056e02219300b0035fe8640f6fmr48222ila.0.1706064664346; Tue, 23 Jan
 2024 18:51:04 -0800 (PST)
Date: Tue, 23 Jan 2024 18:51:04 -0800
In-Reply-To: <tencent_748DB7122CDDCBDDB29965CF870D9225BF07@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000484891060fa82256@google.com>
Subject: Re: [syzbot] [can?] memory leak in j1939_netdev_start
From: syzbot <syzbot+1d37bef05da87b99c5a6@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
memory leak in corrupted

BUG: memory leak
unreferenced object 0xffff88810e94a000 (size 8192):
  comm "syz-executor.4", pid 5915, jiffies 4294946150
  hex dump (first 32 bytes):
    00 a0 94 0e 81 88 ff ff 00 a0 94 0e 81 88 ff ff  ................
    00 00 00 00 00 00 00 00 00 00 70 10 81 88 ff ff  ..........p.....
  backtrace (crc 77c14305):
    [<ffffffff815fa713>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff815fa713>] slab_post_alloc_hook mm/slub.c:3817 [inline]
    [<ffffffff815fa713>] slab_alloc_node mm/slub.c:3860 [inline]
    [<ffffffff815fa713>] kmalloc_trace+0x283/0x330 mm/slub.c:4007
    [<ffffffff845842c9>] kmalloc include/linux/slab.h:590 [inline]
    [<ffffffff845842c9>] kzalloc include/linux/slab.h:711 [inline]
    [<ffffffff845842c9>] j1939_priv_create net/can/j1939/main.c:135 [inline]
    [<ffffffff845842c9>] j1939_netdev_start+0x159/0x6f0 net/can/j1939/main.c:272
    [<ffffffff84585f2e>] j1939_sk_bind+0x21e/0x550 net/can/j1939/socket.c:486
    [<ffffffff83f04a8c>] __sys_bind+0x11c/0x130 net/socket.c:1847
    [<ffffffff83f04abc>] __do_sys_bind net/socket.c:1858 [inline]
    [<ffffffff83f04abc>] __se_sys_bind net/socket.c:1856 [inline]
    [<ffffffff83f04abc>] __x64_sys_bind+0x1c/0x20 net/socket.c:1856
    [<ffffffff84bc08c0>] do_syscall_x64 arch/x86/entry/common.c:52 [inline]
    [<ffffffff84bc08c0>] do_syscall_64+0x50/0x140 arch/x86/entry/common.c:83
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b

BUG: memory leak
unreferenced object 0xffff888122f26000 (size 8192):
  comm "syz-executor.1", pid 5923, jiffies 4294946164
  hex dump (first 32 bytes):
    00 60 f2 22 81 88 ff ff 00 60 f2 22 81 88 ff ff  .`.".....`."....
    00 00 00 00 00 00 00 00 00 80 60 10 81 88 ff ff  ..........`.....
  backtrace (crc c2cb0355):
    [<ffffffff815fa713>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff815fa713>] slab_post_alloc_hook mm/slub.c:3817 [inline]
    [<ffffffff815fa713>] slab_alloc_node mm/slub.c:3860 [inline]
    [<ffffffff815fa713>] kmalloc_trace+0x283/0x330 mm/slub.c:4007
    [<ffffffff845842c9>] kmalloc include/linux/slab.h:590 [inline]
    [<ffffffff845842c9>] kzalloc include/linux/slab.h:711 [inline]
    [<ffffffff845842c9>] j1939_priv_create net/can/j1939/main.c:135 [inline]
    [<ffffffff845842c9>] j1939_netdev_start+0x159/0x6f0 net/can/j1939/main.c:272
    [<ffffffff84585f2e>] j1939_sk_bind+0x21e/0x550 net/can/j1939/socket.c:486
    [<ffffffff83f04a8c>] __sys_bind+0x11c/0x130 net/socket.c:1847
    [<ffffffff83f04abc>] __do_sys_bind net/socket.c:1858 [inline]
    [<ffffffff83f04abc>] __se_sys_bind net/socket.c:1856 [inline]
    [<ffffffff83f04abc>] __x64_sys_bind+0x1c/0x20 net/socket.c:1856
    [<ffffffff84bc08c0>] do_syscall_x64 arch/x86/entry/common.c:52 [inline]
    [<ffffffff84bc08c0>] do_syscall_64+0x50/0x140 arch/x86/entry/common.c:83
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b

BUG: memory leak
unreferenced object 0xffff888122c06700 (size 240):
  comm "softirq", pid 0, jiffies 4294946164
  hex dump (first 32 bytes):
    68 42 2f 22 81 88 ff ff 68 42 2f 22 81 88 ff ff  hB/"....hB/"....
    00 80 60 10 81 88 ff ff 00 00 00 00 00 00 00 00  ..`.............
  backtrace (crc 205e59a3):
    [<ffffffff815f9bba>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff815f9bba>] slab_post_alloc_hook mm/slub.c:3817 [inline]
    [<ffffffff815f9bba>] slab_alloc_node mm/slub.c:3860 [inline]
    [<ffffffff815f9bba>] kmem_cache_alloc_node+0x28a/0x330 mm/slub.c:3903
    [<ffffffff83f1844f>] __alloc_skb+0x1ef/0x230 net/core/skbuff.c:641
    [<ffffffff8458ceea>] alloc_skb include/linux/skbuff.h:1296 [inline]
    [<ffffffff8458ceea>] j1939_session_fresh_new net/can/j1939/transport.c:1536 [inline]
    [<ffffffff8458ceea>] j1939_xtp_rx_rts_session_new net/can/j1939/transport.c:1634 [inline]
    [<ffffffff8458ceea>] j1939_xtp_rx_rts+0x4ba/0xa70 net/can/j1939/transport.c:1738
    [<ffffffff8458d9d5>] j1939_tp_cmd_recv net/can/j1939/transport.c:2063 [inline]
    [<ffffffff8458d9d5>] j1939_tp_recv+0x1b5/0x7f0 net/can/j1939/transport.c:2150
    [<ffffffff84583e99>] j1939_can_recv+0x349/0x4e0 net/can/j1939/main.c:112
    [<ffffffff845748e4>] deliver net/can/af_can.c:572 [inline]
    [<ffffffff845748e4>] can_rcv_filter+0xd4/0x290 net/can/af_can.c:606
    [<ffffffff84574fa0>] can_receive+0xf0/0x140 net/can/af_can.c:663
    [<ffffffff845750e0>] can_rcv+0xf0/0x130 net/can/af_can.c:687
    [<ffffffff83f50e66>] __netif_receive_skb_one_core+0x66/0x90 net/core/dev.c:5534
    [<ffffffff83f50edd>] __netif_receive_skb+0x1d/0x90 net/core/dev.c:5648
    [<ffffffff83f5123c>] process_backlog+0xbc/0x190 net/core/dev.c:5976
    [<ffffffff83f523ce>] __napi_poll+0x3e/0x310 net/core/dev.c:6576
    [<ffffffff83f52de8>] napi_poll net/core/dev.c:6645 [inline]
    [<ffffffff83f52de8>] net_rx_action+0x3d8/0x510 net/core/dev.c:6778
    [<ffffffff84bde94d>] __do_softirq+0xbd/0x2b0 kernel/softirq.c:553

BUG: memory leak
unreferenced object 0xffff8881231e0000 (size 131072):
  comm "softirq", pid 0, jiffies 4294946164
  hex dump (first 32 bytes):
    0e 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc f7abe560):
    [<ffffffff815f315e>] __kmalloc_large_node+0xde/0x150 mm/slub.c:3935
    [<ffffffff815f8faf>] __do_kmalloc_node mm/slub.c:3969 [inline]
    [<ffffffff815f8faf>] __kmalloc_node_track_caller+0x35f/0x420 mm/slub.c:4001
    [<ffffffff83f146a6>] kmalloc_reserve+0x96/0x170 net/core/skbuff.c:582
    [<ffffffff83f18335>] __alloc_skb+0xd5/0x230 net/core/skbuff.c:651
    [<ffffffff8458ceea>] alloc_skb include/linux/skbuff.h:1296 [inline]
    [<ffffffff8458ceea>] j1939_session_fresh_new net/can/j1939/transport.c:1536 [inline]
    [<ffffffff8458ceea>] j1939_xtp_rx_rts_session_new net/can/j1939/transport.c:1634 [inline]
    [<ffffffff8458ceea>] j1939_xtp_rx_rts+0x4ba/0xa70 net/can/j1939/transport.c:1738
    [<ffffffff8458d9d5>] j1939_tp_cmd_recv net/can/j1939/transport.c:2063 [inline]
    [<ffffffff8458d9d5>] j1939_tp_recv+0x1b5/0x7f0 net/can/j1939/transport.c:2150
    [<ffffffff84583e99>] j1939_can_recv+0x349/0x4e0 net/can/j1939/main.c:112
    [<ffffffff845748e4>] deliver net/can/af_can.c:572 [inline]
    [<ffffffff845748e4>] can_rcv_filter+0xd4/0x290 net/can/af_can.c:606
    [<ffffffff84574fa0>] can_receive+0xf0/0x140 net/can/af_can.c:663
    [<ffffffff845750e0>] can_rcv+0xf0/0x130 net/can/af_can.c:687
    [<ffffffff83f50e66>] __netif_receive_skb_one_core+0x66/0x90 net/core/dev.c:5534
    [<ffffffff83f50edd>] __netif_receive_skb+0x1d/0x90 net/core/dev.c:5648
    [<ffffffff83f5123c>] process_backlog+0xbc/0x190 net/core/dev.c:5976
    [<ffffffff83f523ce>] __napi_poll+0x3e/0x310 net/core/dev.c:6576
    [<ffffffff83f52de8>] napi_poll net/core/dev.c:6645 [inline]
    [<ffffffff83f52de8>] net_rx_action+0x3d8/0x510 net/core/dev.c:6778
    [<ffffffff84bde94d>] __do_softirq+0xbd/0x2b0 kernel/softirq.c:553



Tested on:

commit:         615d3006 Merge tag 'trace-v6.8-rc1' of git://git.kerne..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=100e8b3be80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9f6b64adeddd3dbc
dashboard link: https://syzkaller.appspot.com/bug?extid=1d37bef05da87b99c5a6
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17d2a6f7e80000


