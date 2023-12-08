Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A0780A1A2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 11:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573653AbjLHK67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 05:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbjLHK65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 05:58:57 -0500
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C8DAC
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 02:59:03 -0800 (PST)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1fb0ff92c7eso2771567fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 02:59:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702033143; x=1702637943;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O+7AedpKvppbBgtxi8r9ujx1tuoFqlE/t1TbZPrAgns=;
        b=uKYO8eK4hoQ0N6bzoMTht/b9/iPTkmbtWgLtbbu7Od9x//7BIoOKgmpg7Jrd69mTwd
         ydge6x+KAGGNitt+jkjqtGIA6yz2YUuVSlZB5Qtaswx9jcXCgG+nsWitbrRr3Bivsair
         cdS4FH9Ly5KhdIiXBkpcu7vvSKhxLwi1w4+R7DSxvEjmCOmTrfhWAunzNzRKMJQH4YD8
         zkRcuKm7zSxDX2yTWXRalIRDtPTS1jjt7rQsgr1W47vpBcHEEOrEGCiUHH/tmtsXvCBR
         9dX5TDBTPrkQd2GJuJdMjMHqIHRsLcR7osJZJRioZjz1SNiBVCdLdCwvitGAUHTCOgrg
         smnQ==
X-Gm-Message-State: AOJu0YwW3cgyVxYGWy+rwDCZBEfkU2jm1JmRqJUZdUMDsUAsLfj8X9yP
        Kr5PONotiBA9IFQsCLO8waDySR3icoc4yc94JCrvZZVx3i5N4eg=
X-Google-Smtp-Source: AGHT+IHRhzEQicgz/ADOYVHwftJHFnmLq43gqCj4Yr7h0oczuIh3jfCuJEoA1x8CSyTUOnvUgYQTuAPMQENgZAu1j9q9y5/TnhHQ
MIME-Version: 1.0
X-Received: by 2002:a05:6870:390a:b0:1fb:2a24:f0a9 with SMTP id
 b10-20020a056870390a00b001fb2a24f0a9mr762420oap.1.1702033142924; Fri, 08 Dec
 2023 02:59:02 -0800 (PST)
Date:   Fri, 08 Dec 2023 02:59:02 -0800
In-Reply-To: <20231208094538.2466543-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e14a49060bfd782d@google.com>
Subject: Re: [syzbot] [arm-msm?] [net?] memory leak in radix_tree_insert (2)
From:   syzbot <syzbot+006987d1be3586e13555@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, lizhi.xu@windriver.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
memory leak in radix_tree_insert

2023/12/08 10:49:43 executed programs: 1
BUG: memory leak
unreferenced object 0xffff88810c5a6000 (size 576):
  comm "syz-executor.0", pid 5491, jiffies 4294944531 (age 12.550s)
  hex dump (first 32 bytes):
    3c 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00  <...............
    b0 ed 2e 1b 81 88 ff ff 18 60 5a 0c 81 88 ff ff  .........`Z.....
  backtrace:
    [<ffffffff81631398>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff81631398>] slab_post_alloc_hook mm/slab.h:766 [inline]
    [<ffffffff81631398>] slab_alloc_node mm/slub.c:3478 [inline]
    [<ffffffff81631398>] slab_alloc mm/slub.c:3486 [inline]
    [<ffffffff81631398>] __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
    [<ffffffff81631398>] kmem_cache_alloc+0x298/0x430 mm/slub.c:3502
    [<ffffffff84b5094c>] radix_tree_node_alloc.constprop.0+0x7c/0x1a0 lib/radix-tree.c:278
    [<ffffffff84b524cf>] __radix_tree_create lib/radix-tree.c:626 [inline]
    [<ffffffff84b524cf>] radix_tree_insert+0x14f/0x370 lib/radix-tree.c:714
    [<ffffffff84ae107d>] qrtr_tx_wait net/qrtr/af_qrtr.c:277 [inline]
    [<ffffffff84ae107d>] qrtr_node_enqueue+0x57d/0x630 net/qrtr/af_qrtr.c:348
    [<ffffffff84ae2716>] qrtr_bcast_enqueue+0x66/0xd0 net/qrtr/af_qrtr.c:891
    [<ffffffff84ae32f2>] qrtr_sendmsg+0x232/0x450 net/qrtr/af_qrtr.c:992
    [<ffffffff83ec3c42>] sock_sendmsg_nosec net/socket.c:730 [inline]
    [<ffffffff83ec3c42>] __sock_sendmsg+0x52/0xa0 net/socket.c:745
    [<ffffffff83ec3d8b>] sock_write_iter+0xfb/0x180 net/socket.c:1158
    [<ffffffff816961a7>] call_write_iter include/linux/fs.h:2020 [inline]
    [<ffffffff816961a7>] new_sync_write fs/read_write.c:491 [inline]
    [<ffffffff816961a7>] vfs_write+0x327/0x590 fs/read_write.c:584
    [<ffffffff816966fb>] ksys_write+0x13b/0x170 fs/read_write.c:637
    [<ffffffff84b6dddf>] do_syscall_x64 arch/x86/entry/common.c:51 [inline]
    [<ffffffff84b6dddf>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b

BUG: memory leak
unreferenced object 0xffff88810c5a6248 (size 576):
  comm "syz-executor.0", pid 5491, jiffies 4294944531 (age 12.550s)
  hex dump (first 32 bytes):
    36 0f 01 00 00 00 00 00 00 60 5a 0c 81 88 ff ff  6........`Z.....
    b0 ed 2e 1b 81 88 ff ff 60 62 5a 0c 81 88 ff ff  ........`bZ.....
  backtrace:
    [<ffffffff81631398>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff81631398>] slab_post_alloc_hook mm/slab.h:766 [inline]
    [<ffffffff81631398>] slab_alloc_node mm/slub.c:3478 [inline]
    [<ffffffff81631398>] slab_alloc mm/slub.c:3486 [inline]
    [<ffffffff81631398>] __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
    [<ffffffff81631398>] kmem_cache_alloc+0x298/0x430 mm/slub.c:3502
    [<ffffffff84b5094c>] radix_tree_node_alloc.constprop.0+0x7c/0x1a0 lib/radix-tree.c:278
    [<ffffffff84b524cf>] __radix_tree_create lib/radix-tree.c:626 [inline]
    [<ffffffff84b524cf>] radix_tree_insert+0x14f/0x370 lib/radix-tree.c:714
    [<ffffffff84ae107d>] qrtr_tx_wait net/qrtr/af_qrtr.c:277 [inline]
    [<ffffffff84ae107d>] qrtr_node_enqueue+0x57d/0x630 net/qrtr/af_qrtr.c:348
    [<ffffffff84ae2716>] qrtr_bcast_enqueue+0x66/0xd0 net/qrtr/af_qrtr.c:891
    [<ffffffff84ae32f2>] qrtr_sendmsg+0x232/0x450 net/qrtr/af_qrtr.c:992
    [<ffffffff83ec3c42>] sock_sendmsg_nosec net/socket.c:730 [inline]
    [<ffffffff83ec3c42>] __sock_sendmsg+0x52/0xa0 net/socket.c:745
    [<ffffffff83ec3d8b>] sock_write_iter+0xfb/0x180 net/socket.c:1158
    [<ffffffff816961a7>] call_write_iter include/linux/fs.h:2020 [inline]
    [<ffffffff816961a7>] new_sync_write fs/read_write.c:491 [inline]
    [<ffffffff816961a7>] vfs_write+0x327/0x590 fs/read_write.c:584
    [<ffffffff816966fb>] ksys_write+0x13b/0x170 fs/read_write.c:637
    [<ffffffff84b6dddf>] do_syscall_x64 arch/x86/entry/common.c:51 [inline]
    [<ffffffff84b6dddf>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b

BUG: memory leak
unreferenced object 0xffff88810c5a6490 (size 576):
  comm "syz-executor.0", pid 5491, jiffies 4294944531 (age 12.550s)
  hex dump (first 32 bytes):
    30 3f 01 00 00 00 00 00 48 62 5a 0c 81 88 ff ff  0?......HbZ.....
    b0 ed 2e 1b 81 88 ff ff a8 64 5a 0c 81 88 ff ff  .........dZ.....
  backtrace:
    [<ffffffff81631398>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff81631398>] slab_post_alloc_hook mm/slab.h:766 [inline]
    [<ffffffff81631398>] slab_alloc_node mm/slub.c:3478 [inline]
    [<ffffffff81631398>] slab_alloc mm/slub.c:3486 [inline]
    [<ffffffff81631398>] __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
    [<ffffffff81631398>] kmem_cache_alloc+0x298/0x430 mm/slub.c:3502
    [<ffffffff84b5094c>] radix_tree_node_alloc.constprop.0+0x7c/0x1a0 lib/radix-tree.c:278
    [<ffffffff84b524cf>] __radix_tree_create lib/radix-tree.c:626 [inline]
    [<ffffffff84b524cf>] radix_tree_insert+0x14f/0x370 lib/radix-tree.c:714
    [<ffffffff84ae107d>] qrtr_tx_wait net/qrtr/af_qrtr.c:277 [inline]
    [<ffffffff84ae107d>] qrtr_node_enqueue+0x57d/0x630 net/qrtr/af_qrtr.c:348
    [<ffffffff84ae2716>] qrtr_bcast_enqueue+0x66/0xd0 net/qrtr/af_qrtr.c:891
    [<ffffffff84ae32f2>] qrtr_sendmsg+0x232/0x450 net/qrtr/af_qrtr.c:992
    [<ffffffff83ec3c42>] sock_sendmsg_nosec net/socket.c:730 [inline]
    [<ffffffff83ec3c42>] __sock_sendmsg+0x52/0xa0 net/socket.c:745
    [<ffffffff83ec3d8b>] sock_write_iter+0xfb/0x180 net/socket.c:1158
    [<ffffffff816961a7>] call_write_iter include/linux/fs.h:2020 [inline]
    [<ffffffff816961a7>] new_sync_write fs/read_write.c:491 [inline]
    [<ffffffff816961a7>] vfs_write+0x327/0x590 fs/read_write.c:584
    [<ffffffff816966fb>] ksys_write+0x13b/0x170 fs/read_write.c:637
    [<ffffffff84b6dddf>] do_syscall_x64 arch/x86/entry/common.c:51 [inline]
    [<ffffffff84b6dddf>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b

BUG: memory leak
unreferenced object 0xffff88810c5a66d8 (size 576):
  comm "syz-executor.0", pid 5491, jiffies 4294944531 (age 12.550s)
  hex dump (first 32 bytes):
    2a 3f 00 00 00 00 00 00 90 64 5a 0c 81 88 ff ff  *?.......dZ.....
    b0 ed 2e 1b 81 88 ff ff f0 66 5a 0c 81 88 ff ff  .........fZ.....
  backtrace:
    [<ffffffff81631398>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff81631398>] slab_post_alloc_hook mm/slab.h:766 [inline]
    [<ffffffff81631398>] slab_alloc_node mm/slub.c:3478 [inline]
    [<ffffffff81631398>] slab_alloc mm/slub.c:3486 [inline]
    [<ffffffff81631398>] __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
    [<ffffffff81631398>] kmem_cache_alloc+0x298/0x430 mm/slub.c:3502
    [<ffffffff84b5094c>] radix_tree_node_alloc.constprop.0+0x7c/0x1a0 lib/radix-tree.c:278
    [<ffffffff84b524cf>] __radix_tree_create lib/radix-tree.c:626 [inline]
    [<ffffffff84b524cf>] radix_tree_insert+0x14f/0x370 lib/radix-tree.c:714
    [<ffffffff84ae107d>] qrtr_tx_wait net/qrtr/af_qrtr.c:277 [inline]
    [<ffffffff84ae107d>] qrtr_node_enqueue+0x57d/0x630 net/qrtr/af_qrtr.c:348
    [<ffffffff84ae2716>] qrtr_bcast_enqueue+0x66/0xd0 net/qrtr/af_qrtr.c:891
    [<ffffffff84ae32f2>] qrtr_sendmsg+0x232/0x450 net/qrtr/af_qrtr.c:992
    [<ffffffff83ec3c42>] sock_sendmsg_nosec net/socket.c:730 [inline]
    [<ffffffff83ec3c42>] __sock_sendmsg+0x52/0xa0 net/socket.c:745
    [<ffffffff83ec3d8b>] sock_write_iter+0xfb/0x180 net/socket.c:1158
    [<ffffffff816961a7>] call_write_iter include/linux/fs.h:2020 [inline]
    [<ffffffff816961a7>] new_sync_write fs/read_write.c:491 [inline]
    [<ffffffff816961a7>] vfs_write+0x327/0x590 fs/read_write.c:584
    [<ffffffff816966fb>] ksys_write+0x13b/0x170 fs/read_write.c:637
    [<ffffffff84b6dddf>] do_syscall_x64 arch/x86/entry/common.c:51 [inline]
    [<ffffffff84b6dddf>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b



Tested on:

commit:         33cc938e Linux 6.7-rc4
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=102f9bcae80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=37d1b8bb20150e6
dashboard link: https://syzkaller.appspot.com/bug?extid=006987d1be3586e13555
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1369870ee80000

