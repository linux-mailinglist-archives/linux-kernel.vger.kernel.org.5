Return-Path: <linux-kernel+bounces-35064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CD0838B5A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A4CF28FF0D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B043A5BAF5;
	Tue, 23 Jan 2024 10:05:09 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F2C5A790
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 10:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706004309; cv=none; b=WPXPOE7UvTqkBN/dIIM3kbHfSpPOW6nYSHAnU2Vy88Z/3XW6zCJ5uZAQdcGH0s6RBSwIGFvHYHTDARJGOi3r9XlGFIWzKgy4hx2R1cpGsupj+9YZJkp1GDwkRW8vTaiLVgv+/CC6ysayboFdRfn4DZXAl68E/jIn4p/aRKqcRhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706004309; c=relaxed/simple;
	bh=tBswinHhOGAiuHYYwrfJBeuwv6s6in2J1BirPS7AHa8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=m+VqDitLhupPDXCHF9fLtbKagCUS4ERKk2rWOKYsaxSuVCvFieTn/qOFx9lU87wZ4DQ3ivAAEeZxeltB3jqIvS8OhyQAhji7vnQmg7r6QdAA6fFEDo/OB9jXVl7V+4XWvTvErE1QYZkHVlLOR7hj6D5JudJKqCCzmtuTMimvyTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7beebd130aaso415019939f.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 02:05:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706004306; x=1706609106;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AS2P3nQdsUNC5p4LXiOIShjbvIlAWTYX3zFAQ+Hlvpc=;
        b=HJQIdnDcU3cEvBs8/0PkltNbr6ZXtA07nEFEzR5c4neaLpZP6RLCpwrYw1BMnoHw42
         r2BKFB3D+qpHnVstr3+fUQivPrGm0oh7odIAtmantwRfT61juMJc0vmw5YVuvM3LRnKO
         sOdrixxn+ol+VwB9kjw6oyg5sxHS7QKGs6AlqJkzz6NA0rgeedJyvDW3QtvrOB50OwGC
         wzEyb+YGZrErC2t72EPOq9mLO1i6toHN6Q4CahOhCgRw9EDTCM9T/XCqDicUMaazTrxg
         egJ5PQEOK+pstl+xeNkkR1nB2i3DkU9W2o88qt8l4PbNMNlaaRqNWEhmgihW7Rrdojq5
         arTA==
X-Gm-Message-State: AOJu0YwUkMb1zzcbyIKvxAJciCnK3cayc9p0fr4z0zStDZgRAS0UFJ07
	EX9N8zeZ25awcyESQ6PdSL+2h9hmcNmNcJAvJ3fyu7mNz3b16RkPf2Q2k4R0skAlVim+fexN/wr
	nBiacAJC1cr+w6wQinj45OkB1i/+p15ba9G8cVu12665Wo6BJ8B7MUjc=
X-Google-Smtp-Source: AGHT+IFmFQhZabab/mhzOsVkCrjwLraxpc7YVVMyfIR+XwTAHGx5JCoiRPNGLSkxqXSQBjNNSgy7HUssl8AuRDF6/3Kl+6B47rKU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:148a:b0:46e:d877:ef75 with SMTP id
 j10-20020a056638148a00b0046ed877ef75mr240084jak.3.1706004306199; Tue, 23 Jan
 2024 02:05:06 -0800 (PST)
Date: Tue, 23 Jan 2024 02:05:06 -0800
In-Reply-To: <tencent_EA9AECE6CEAC79FA6CAC2DDD6D0095E8EA0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a80f14060f9a1430@google.com>
Subject: Re: [syzbot] [can?] memory leak in j1939_netdev_start
From: syzbot <syzbot+1d37bef05da87b99c5a6@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
memory leak in corrupted

BUG: memory leak
unreferenced object 0xffff888122468000 (size 8192):
  comm "syz-executor.3", pid 5871, jiffies 4294945607
  hex dump (first 32 bytes):
    00 80 46 22 81 88 ff ff 00 80 46 22 81 88 ff ff  ..F"......F"....
    00 00 00 00 00 00 00 00 00 80 03 1b 81 88 ff ff  ................
  backtrace (crc aa0f28f1):
    [<ffffffff815fa713>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff815fa713>] slab_post_alloc_hook mm/slub.c:3817 [inline]
    [<ffffffff815fa713>] slab_alloc_node mm/slub.c:3860 [inline]
    [<ffffffff815fa713>] kmalloc_trace+0x283/0x330 mm/slub.c:4007
    [<ffffffff84584249>] kmalloc include/linux/slab.h:590 [inline]
    [<ffffffff84584249>] kzalloc include/linux/slab.h:711 [inline]
    [<ffffffff84584249>] j1939_priv_create net/can/j1939/main.c:135 [inline]
    [<ffffffff84584249>] j1939_netdev_start+0x159/0x6f0 net/can/j1939/main.c:272
    [<ffffffff84585eae>] j1939_sk_bind+0x21e/0x550 net/can/j1939/socket.c:486
    [<ffffffff83f04a0c>] __sys_bind+0x11c/0x130 net/socket.c:1847
    [<ffffffff83f04a3c>] __do_sys_bind net/socket.c:1858 [inline]
    [<ffffffff83f04a3c>] __se_sys_bind net/socket.c:1856 [inline]
    [<ffffffff83f04a3c>] __x64_sys_bind+0x1c/0x20 net/socket.c:1856
    [<ffffffff84bc08c0>] do_syscall_x64 arch/x86/entry/common.c:52 [inline]
    [<ffffffff84bc08c0>] do_syscall_64+0x50/0x140 arch/x86/entry/common.c:83
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b

BUG: memory leak
unreferenced object 0xffff888122b02200 (size 240):
  comm "softirq", pid 0, jiffies 4294945607
  hex dump (first 32 bytes):
    68 ac 2a 22 81 88 ff ff 68 ac 2a 22 81 88 ff ff  h.*"....h.*"....
    00 80 03 1b 81 88 ff ff 00 00 00 00 00 00 00 00  ................
  backtrace (crc 54b3c139):
    [<ffffffff815f9bba>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff815f9bba>] slab_post_alloc_hook mm/slub.c:3817 [inline]
    [<ffffffff815f9bba>] slab_alloc_node mm/slub.c:3860 [inline]
    [<ffffffff815f9bba>] kmem_cache_alloc_node+0x28a/0x330 mm/slub.c:3903
    [<ffffffff83f183cf>] __alloc_skb+0x1ef/0x230 net/core/skbuff.c:641
    [<ffffffff8458ce6a>] alloc_skb include/linux/skbuff.h:1296 [inline]
    [<ffffffff8458ce6a>] j1939_session_fresh_new net/can/j1939/transport.c:1536 [inline]
    [<ffffffff8458ce6a>] j1939_xtp_rx_rts_session_new net/can/j1939/transport.c:1633 [inline]
    [<ffffffff8458ce6a>] j1939_xtp_rx_rts+0x4ba/0xa70 net/can/j1939/transport.c:1737
    [<ffffffff8458d925>] j1939_tp_cmd_recv net/can/j1939/transport.c:2060 [inline]
    [<ffffffff8458d925>] j1939_tp_recv+0x1b5/0x7f0 net/can/j1939/transport.c:2147
    [<ffffffff84583e19>] j1939_can_recv+0x349/0x4e0 net/can/j1939/main.c:112
    [<ffffffff84574864>] deliver net/can/af_can.c:572 [inline]
    [<ffffffff84574864>] can_rcv_filter+0xd4/0x290 net/can/af_can.c:606
    [<ffffffff84574f20>] can_receive+0xf0/0x140 net/can/af_can.c:663
    [<ffffffff84575060>] can_rcv+0xf0/0x130 net/can/af_can.c:687
    [<ffffffff83f50de6>] __netif_receive_skb_one_core+0x66/0x90 net/core/dev.c:5534
    [<ffffffff83f50e5d>] __netif_receive_skb+0x1d/0x90 net/core/dev.c:5648
    [<ffffffff83f511bc>] process_backlog+0xbc/0x190 net/core/dev.c:5976
    [<ffffffff83f5234e>] __napi_poll+0x3e/0x310 net/core/dev.c:6576
    [<ffffffff83f52d68>] napi_poll net/core/dev.c:6645 [inline]
    [<ffffffff83f52d68>] net_rx_action+0x3d8/0x510 net/core/dev.c:6778
    [<ffffffff84bde94d>] __do_softirq+0xbd/0x2b0 kernel/softirq.c:553

BUG: memory leak
unreferenced object 0xffff888122b40000 (size 131072):
  comm "softirq", pid 0, jiffies 4294945607
  hex dump (first 32 bytes):
    0e 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc f7abe560):
    [<ffffffff815f315e>] __kmalloc_large_node+0xde/0x150 mm/slub.c:3935
    [<ffffffff815f8faf>] __do_kmalloc_node mm/slub.c:3969 [inline]
    [<ffffffff815f8faf>] __kmalloc_node_track_caller+0x35f/0x420 mm/slub.c:4001
    [<ffffffff83f14626>] kmalloc_reserve+0x96/0x170 net/core/skbuff.c:582
    [<ffffffff83f182b5>] __alloc_skb+0xd5/0x230 net/core/skbuff.c:651
    [<ffffffff8458ce6a>] alloc_skb include/linux/skbuff.h:1296 [inline]
    [<ffffffff8458ce6a>] j1939_session_fresh_new net/can/j1939/transport.c:1536 [inline]
    [<ffffffff8458ce6a>] j1939_xtp_rx_rts_session_new net/can/j1939/transport.c:1633 [inline]
    [<ffffffff8458ce6a>] j1939_xtp_rx_rts+0x4ba/0xa70 net/can/j1939/transport.c:1737
    [<ffffffff8458d925>] j1939_tp_cmd_recv net/can/j1939/transport.c:2060 [inline]
    [<ffffffff8458d925>] j1939_tp_recv+0x1b5/0x7f0 net/can/j1939/transport.c:2147
    [<ffffffff84583e19>] j1939_can_recv+0x349/0x4e0 net/can/j1939/main.c:112
    [<ffffffff84574864>] deliver net/can/af_can.c:572 [inline]
    [<ffffffff84574864>] can_rcv_filter+0xd4/0x290 net/can/af_can.c:606
    [<ffffffff84574f20>] can_receive+0xf0/0x140 net/can/af_can.c:663
    [<ffffffff84575060>] can_rcv+0xf0/0x130 net/can/af_can.c:687
    [<ffffffff83f50de6>] __netif_receive_skb_one_core+0x66/0x90 net/core/dev.c:5534
    [<ffffffff83f50e5d>] __netif_receive_skb+0x1d/0x90 net/core/dev.c:5648
    [<ffffffff83f511bc>] process_backlog+0xbc/0x190 net/core/dev.c:5976
    [<ffffffff83f5234e>] __napi_poll+0x3e/0x310 net/core/dev.c:6576
    [<ffffffff83f52d68>] napi_poll net/core/dev.c:6645 [inline]
    [<ffffffff83f52d68>] net_rx_action+0x3d8/0x510 net/core/dev.c:6778
    [<ffffffff84bde94d>] __do_softirq+0xbd/0x2b0 kernel/softirq.c:553

BUG: memory leak
unreferenced object 0xffff8881222aac00 (size 512):
  comm "softirq", pid 0, jiffies 4294945607
  hex dump (first 32 bytes):
    00 80 46 22 81 88 ff ff 28 90 46 22 81 88 ff ff  ..F"....(.F"....
    28 90 46 22 81 88 ff ff 18 ac 2a 22 81 88 ff ff  (.F"......*"....
  backtrace (crc 32877ad9):
    [<ffffffff815fa713>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff815fa713>] slab_post_alloc_hook mm/slub.c:3817 [inline]
    [<ffffffff815fa713>] slab_alloc_node mm/slub.c:3860 [inline]
    [<ffffffff815fa713>] kmalloc_trace+0x283/0x330 mm/slub.c:4007
    [<ffffffff84587ea3>] kmalloc include/linux/slab.h:590 [inline]
    [<ffffffff84587ea3>] kzalloc include/linux/slab.h:711 [inline]
    [<ffffffff84587ea3>] j1939_session_new+0x53/0x140 net/can/j1939/transport.c:1495
    [<ffffffff8458cefc>] j1939_session_fresh_new net/can/j1939/transport.c:1547 [inline]
    [<ffffffff8458cefc>] j1939_xtp_rx_rts_session_new net/can/j1939/transport.c:1633 [inline]
    [<ffffffff8458cefc>] j1939_xtp_rx_rts+0x54c/0xa70 net/can/j1939/transport.c:1737
    [<ffffffff8458d925>] j1939_tp_cmd_recv net/can/j1939/transport.c:2060 [inline]
    [<ffffffff8458d925>] j1939_tp_recv+0x1b5/0x7f0 net/can/j1939/transport.c:2147
    [<ffffffff84583e19>] j1939_can_recv+0x349/0x4e0 net/can/j1939/main.c:112
    [<ffffffff84574864>] deliver net/can/af_can.c:572 [inline]
    [<ffffffff84574864>] can_rcv_filter+0xd4/0x290 net/can/af_can.c:606
    [<ffffffff84574f20>] can_receive+0xf0/0x140 net/can/af_can.c:663
    [<ffffffff84575060>] can_rcv+0xf0/0x130 net/can/af_can.c:687
    [<ffffffff83f50de6>] __netif_receive_skb_one_core+0x66/0x90 net/core/dev.c:5534
    [<ffffffff83f50e5d>] __netif_receive_skb+0x1d/0x90 net/core/dev.c:5648
    [<ffffffff83f511bc>] process_backlog+0xbc/0x190 net/core/dev.c:5976
    [<ffffffff83f5234e>] __napi_poll+0x3e/0x310 net/core/dev.c:6576
    [<ffffffff83f52d68>] napi_poll net/core/dev.c:6645 [inline]
    [<ffffffff83f52d68>] net_rx_action+0x3d8/0x510 net/core/dev.c:6778
    [<ffffffff84bde94d>] __do_softirq+0xbd/0x2b0 kernel/softirq.c:553



Tested on:

commit:         7ed2632e drm/ttm: fix ttm pool initialization for no-d..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1681d2d7e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9f6b64adeddd3dbc
dashboard link: https://syzkaller.appspot.com/bug?extid=1d37bef05da87b99c5a6
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1770fa6be80000


