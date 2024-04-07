Return-Path: <linux-kernel+bounces-134388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0858889B0E7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 14:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8951C1F21783
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 12:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7B62BAE8;
	Sun,  7 Apr 2024 12:50:07 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC20322318
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 12:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712494206; cv=none; b=EdIS7oY3YMB5iXJozDsxk8xzHTdvSV/jfj0UNQDxmb2hFBD4oNqifLrJ2gzYJ5940I6fU1fPpNeF+nPdo9BD/hfmXriQ8kcg46+vQiC7lEXJwmBJUNQyUF9DugKjbu9exrgf9ZoPrNCoLHeCWu+Se93tsCTdGx3jxEFicnUqNzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712494206; c=relaxed/simple;
	bh=exOWKChOIijjL1c7yDjZNUt4Z4uq26KgtSWkJnj4FLA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FrvOJ2vLGApIyCA5jQM6yejMoWQEYtYjt0+TgQ2qRtNqrOy2F+gurkKaolYyGKcwvQA763k0kXeSejVfj8URfxZTbejdo39iaGog9kfeIIFqWvj25gc24qkoOGKDyt71hyzNQOxekYYUQbIbnWJMQGN1MD4/5D4ReIcnxAL4bxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7d5da88bb06so84665239f.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 05:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712494204; x=1713099004;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=07cU1XgAr2W9+95XM3EtmiPAQVS65hPv7ACknCR8gDM=;
        b=xFVNmzIL/hKHXok9BtvJJx6Tk7yyY0Y8YH8S6dX8sHtzpJJQppi03aSXme88QHTq+F
         OGi+wWkmmsVooFLumlo9fysiTKT9jxaVrKz1u63eMvSUcg8ptJ3a/ttfwkZWBstohC/p
         TopGrTagDw9OBCBxHsXJ7tITWmKeJHHxMb4+5m5kvcIMdKzzXBZnbE2+jXOSyEenfyGi
         zehvP3bmhiuLKcUhfSjbC3CuziDFpUp1amRxWTM7lVY1xEkGjHZK91vOa0FCaSFGpD0H
         ax5Alcz7UZxvGP3YpebQCUOTixZQ/29mCN41EoZzHconVtIDxooivM8WslTq5Yrq0NHS
         l+Kw==
X-Forwarded-Encrypted: i=1; AJvYcCWw538xmJxZw5969T4aQVmcU5E01lTNcNN/2lsGEsCQUVj4heP6xhkcmC5ZX8XM2R1IN9VnmMEmma97Cn1n+juRjHumIo0BXvHLI5Yt
X-Gm-Message-State: AOJu0YwnKWfOqeQ5SnhAZ+NaPEpcBBzz96uDhm0SczZXyrDcAltpOS2N
	xDMIdDbXbSJmzMv6HHVxzO1SKITyPAcYxXSwDX3fFBfuvPPYYTDwk6qlEDDLFrcAmDoGDe5lGF8
	LR2rc0dZoPJz90s3kEAzqJwZpdUwvoOWTD7P3kpYByzyKd2PMpQ015T0=
X-Google-Smtp-Source: AGHT+IEsVZlNxGH/jnyLSP0VeTxE9j/CqUOgNEbr2dj8GiYpV7qJbYZOiph5qhouPldGynbjQ/9yqQVQRGhO649yYKQyXCw4AD7t
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4115:b0:47b:f5f5:f0de with SMTP id
 ay21-20020a056638411500b0047bf5f5f0demr216686jab.3.1712494204145; Sun, 07 Apr
 2024 05:50:04 -0700 (PDT)
Date: Sun, 07 Apr 2024 05:50:04 -0700
In-Reply-To: <20240407121609.1426-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b7e70f0615812006@google.com>
Subject: Re: [syzbot] [bluetooth?] BUG: sleeping function called from invalid
 context in hci_le_create_big_complete_evt
From: syzbot <syzbot+2fb0835e0c9cefc34614@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in hci_le_create_big_complete_evt

==================================================================
BUG: KASAN: slab-use-after-free in hci_le_create_big_complete_evt+0x383/0xb00
Read of size 8 at addr ffff88801f0b4000 by task kworker/u9:1/4465

CPU: 1 PID: 4465 Comm: kworker/u9:1 Not tainted 6.8.0-syzkaller-08073-g480e035fc4c7-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 hci_le_create_big_complete_evt+0x383/0xb00
 hci_event_func net/bluetooth/hci_event.c:7514 [inline]
 hci_event_packet+0xa53/0x1540 net/bluetooth/hci_event.c:7569
 hci_rx_work+0x3e8/0xca0 net/bluetooth/hci_core.c:4171
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 </TASK>

Allocated by task 4465:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 kmalloc_trace+0x1db/0x360 mm/slub.c:3997
 kmalloc include/linux/slab.h:628 [inline]
 kzalloc include/linux/slab.h:749 [inline]
 hci_conn_add+0xc7/0x13a0 net/bluetooth/hci_conn.c:914
 hci_le_big_sync_established_evt+0x1cf/0xb90 net/bluetooth/hci_event.c:6980
 hci_event_func net/bluetooth/hci_event.c:7514 [inline]
 hci_event_packet+0xa53/0x1540 net/bluetooth/hci_event.c:7569
 hci_rx_work+0x3e8/0xca0 net/bluetooth/hci_core.c:4171
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243

Freed by task 4465:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xa6/0xe0 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2106 [inline]
 slab_free mm/slub.c:4280 [inline]
 kfree+0x14a/0x380 mm/slub.c:4390
 device_release+0x99/0x1c0
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x22f/0x480 lib/kobject.c:737
 hci_conn_cleanup net/bluetooth/hci_conn.c:176 [inline]
 hci_conn_del+0x900/0xc80 net/bluetooth/hci_conn.c:1126
 hci_le_create_big_complete_evt+0x61b/0xb00 net/bluetooth/hci_event.c:6941
 hci_event_func net/bluetooth/hci_event.c:7514 [inline]
 hci_event_packet+0xa53/0x1540 net/bluetooth/hci_event.c:7569
 hci_rx_work+0x3e8/0xca0 net/bluetooth/hci_core.c:4171
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243

The buggy address belongs to the object at ffff88801f0b4000
 which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 0 bytes inside of
 freed 8192-byte region [ffff88801f0b4000, ffff88801f0b6000)

The buggy address belongs to the physical page:
page:ffffea00007c2c00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1f0b0
head:ffffea00007c2c00 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888014c42280 ffffea00007efc00 dead000000000002
raw: 0000000000000000 0000000080020002 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd28c0(GFP_NOWAIT|__GFP_IO|__GFP_FS|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4736, tgid 4736 (dhcpcd), ts 33772916994, free_ts 33772629416
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1533
 prep_new_page mm/page_alloc.c:1540 [inline]
 get_page_from_freelist+0x33ea/0x3580 mm/page_alloc.c:3311
 __alloc_pages+0x256/0x680 mm/page_alloc.c:4569
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page+0x5f/0x160 mm/slub.c:2175
 allocate_slab mm/slub.c:2338 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2391
 ___slab_alloc+0xc73/0x1260 mm/slub.c:3525
 __slab_alloc mm/slub.c:3610 [inline]
 __slab_alloc_node mm/slub.c:3663 [inline]
 slab_alloc_node mm/slub.c:3835 [inline]
 __do_kmalloc_node mm/slub.c:3965 [inline]
 __kmalloc_node_track_caller+0x2d6/0x4e0 mm/slub.c:3986
 kmalloc_reserve+0x111/0x2a0 net/core/skbuff.c:599
 __alloc_skb+0x1f3/0x440 net/core/skbuff.c:668
 alloc_skb include/linux/skbuff.h:1318 [inline]
 netlink_dump+0x1e6/0xe50 net/netlink/af_netlink.c:2229
 netlink_recvmsg+0x6bb/0x11d0 net/netlink/af_netlink.c:1987
 sock_recvmsg_nosec net/socket.c:1046 [inline]
 sock_recvmsg+0x22f/0x280 net/socket.c:1068
 ____sys_recvmsg+0x1db/0x470 net/socket.c:2803
 ___sys_recvmsg net/socket.c:2845 [inline]
 __sys_recvmsg+0x2f0/0x3e0 net/socket.c:2875
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
page last free pid 4736 tgid 4736 stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1140 [inline]
 free_unref_page_prepare+0x968/0xa90 mm/page_alloc.c:2346
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2486
 discard_slab mm/slub.c:2437 [inline]
 __put_partials+0xeb/0x130 mm/slub.c:2906
 put_cpu_partial+0x17c/0x250 mm/slub.c:2981
 __slab_free+0x2ea/0x3d0 mm/slub.c:4151
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x5e/0xc0 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3798 [inline]
 slab_alloc_node mm/slub.c:3845 [inline]
 kmem_cache_alloc_node+0x194/0x380 mm/slub.c:3888
 kmalloc_reserve+0xa8/0x2a0 net/core/skbuff.c:577
 __alloc_skb+0x1f3/0x440 net/core/skbuff.c:668
 netlink_sendmsg+0x637/0xcb0 net/netlink/af_netlink.c:1880
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 __sys_sendto+0x3a4/0x4f0 net/socket.c:2191
 __do_sys_sendto net/socket.c:2203 [inline]
 __se_sys_sendto net/socket.c:2199 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2199
 do_syscall_64+0xfb/0x240

Memory state around the buggy address:
 ffff88801f0b3f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88801f0b3f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88801f0b4000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff88801f0b4080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88801f0b4100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         480e035f Merge tag 'drm-next-2024-03-13' of https://gi..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16896499180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e5b814e91787669
dashboard link: https://syzkaller.appspot.com/bug?extid=2fb0835e0c9cefc34614
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17b92e05180000


