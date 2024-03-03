Return-Path: <linux-kernel+bounces-89723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A25986F4B9
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 13:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ECF31F21B90
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 12:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04929BE62;
	Sun,  3 Mar 2024 12:12:07 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160AFB664
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 12:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709467926; cv=none; b=tYIv5g2v3nrvqr28Fl7Tr0uzXrZeQXLEkZ7NkcO/Byfh0H8SwA6F7Qt7XE5RYdIt/x5KOIwqIEsB3Ubk8iO4lQQpf8u5p2FsNH70RIjItSWkm5OBViRshYV6yPVrcn6Pgiy+MCf4lTpjBlh171pf+BNgLLZZFTO1uVW0diUQ9h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709467926; c=relaxed/simple;
	bh=wdQWhihA+tWxfIIIQj2ZJilwsv+rh/p06y1AI3SN5E4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=F9SdoTdH1kj+d8JDqLCKwYOW6L5fiNWUfcX07ZlGaP6+hla0skYMl1A3fIx1OWb+65GVW8kT14U3eM+MRQIv2spkqnmg3K8LzwxaQj92WT8tr4kB9o1ySNnpccbEuVZssGSYc4XbhIsuoO11M4WltTLlrmZrmtGRmCQllOryo6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c83e0f8c51so52457639f.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 04:12:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709467924; x=1710072724;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S4kfNbpTnOQSD55Iq/AlBz6zYWL46TQpEdNRvS9MKaU=;
        b=lpsTGr16TDG74y/pvdYppeeBiM3/JJnecJigNeQyYNqLDXpM9SbJkquIUGnm0ANoRT
         KbN2ljIqaVijMY0f1I38aftBIRL6ifGyGHslFskXrJDdIjZr/6otxrgTsH4p+UkP8taP
         sLI4eYNF61kPnTs+Feaqm8a9ZHsw8Efu0QuOaZBwYlDaJn4wbG6ucOYM2f+/54+U1CuE
         o322sguuRWB99dUcAgsrrXDpHu5o9Z2gHYTDOmkLhJns7BCNVvZJqYx5Omt8/eJYg4e9
         KMK3PSdqPXseEoAEyiAqhYakAIY+bc7SsRnKjeSClIDFExyn3fw7lKy1dr9gOOkkyfgk
         G9WQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIDOQDZ2sNAVnist5dc1bcGidPbZv4+lxUlvpYucLK+FhISq9cOzzeMU/5O4LaqO+Cu9yqiR3Ds4yJPoLcTP2GXnOqUU8qT4jvKsq3
X-Gm-Message-State: AOJu0Yyy9f76j6b9xXw8QeVJXufiC6Cex9E2cR/Mn6sHX6lqNsxpORhb
	b7uMBNWOFGjUnOQ89khhyZu75ZoqOmfjhr1Et/NuMpLMzEXL+wq1qJrS16spWxDYwGzInmxZVkd
	JjdsC4pScz8wi/tPh+fLtUgfDfrYjkVUyfsNxfTzqQApEa7HmvSiruWM=
X-Google-Smtp-Source: AGHT+IGLTkyhKrHhu1BRRI+WzCnaHq1/epNXDS0Zm+OVmJ2Ng9KhNlB511rXvLnpZNntiskmr1eH/PVfN7uagNk7bbnwQ+Mri12w
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c8b:b0:365:1c10:9ce2 with SMTP id
 w11-20020a056e021c8b00b003651c109ce2mr518474ill.2.1709467924139; Sun, 03 Mar
 2024 04:12:04 -0800 (PST)
Date: Sun, 03 Mar 2024 04:12:04 -0800
In-Reply-To: <tencent_FB46CF407B6A6CBC2C596F7C97BCE8EEEE0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005f96040612c084b5@google.com>
Subject: Re: [syzbot] [hams?] KMSAN: uninit-value in nr_route_frame
From: syzbot <syzbot+f770ce3566e60e5573ac@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in nr_route_frame

=====================================================
BUG: KMSAN: uninit-value in nr_route_frame+0x4a9/0xfc0 net/netrom/nr_route.c:787
 nr_route_frame+0x4a9/0xfc0 net/netrom/nr_route.c:787
 nr_xmit+0x5a/0x1c0 net/netrom/nr_dev.c:144
 __netdev_start_xmit include/linux/netdevice.h:4980 [inline]
 netdev_start_xmit include/linux/netdevice.h:4994 [inline]
 xmit_one net/core/dev.c:3547 [inline]
 dev_hard_start_xmit+0x244/0xa10 net/core/dev.c:3563
 __dev_queue_xmit+0x33ed/0x51c0 net/core/dev.c:4351
 dev_queue_xmit include/linux/netdevice.h:3171 [inline]
 raw_sendmsg+0x64e/0xc10 net/ieee802154/socket.c:299
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
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:3819 [inline]
 slab_alloc_node mm/slub.c:3860 [inline]
 kmem_cache_alloc_node+0x5cb/0xbc0 mm/slub.c:3903
 kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:560
 __alloc_skb+0x33d/0x7a0 net/core/skbuff.c:651
 alloc_skb include/linux/skbuff.h:1296 [inline]
 alloc_skb_with_frags+0xc8/0xbd0 net/core/skbuff.c:6395
 sock_alloc_send_pskb+0xa80/0xbf0 net/core/sock.c:2783
 sock_alloc_send_skb include/net/sock.h:1855 [inline]
 raw_sendmsg+0x367/0xc10 net/ieee802154/socket.c:282
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
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

CPU: 1 PID: 5501 Comm: syz-executor.0 Not tainted 6.8.0-rc6-syzkaller-g04b8076df253-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
=====================================================


Tested on:

commit:         04b8076d Merge tag 'firewire-fixes-6.8-rc7' of git://g..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=149cd06c180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=80c7a82a572c0de3
dashboard link: https://syzkaller.appspot.com/bug?extid=f770ce3566e60e5573ac
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1666dc36180000


