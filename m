Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50BD80B8E8
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 06:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjLJEsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 23:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjLJEr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 23:47:58 -0500
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3A2C4
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 20:48:04 -0800 (PST)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3b9ed87a1fcso2502038b6e.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Dec 2023 20:48:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702183683; x=1702788483;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VNxmJH+jAu4My0Lr4U1OUO/pPBctNmejIKDzLw+l7GY=;
        b=qe0uIMM9mcdfnJmyZx1wqb2h9fDQ0ELJs/tk+dd81S/RPcc72R/iyiS4vGSXM1OzWR
         AMqgf/av4dhFJqO5k081Z94M/lH0oLw+9UTLM3po1XNwBX8kIqEnzH+TUv/4eSdsfs0p
         ZC+oAjKDcb/HLv1HynVVedDqnOV0rMUufgNhEg9M8GiqTJA/PCMBrhxQMdcnhl+UAEpY
         82KrhM5TGSXU1B9o4DeWFlsrZ3yOq78QcIam0izrUGaIhGF11KGRKe8TFszuHPMd8EqV
         5oi25rPGqUhukMi74whRtOFA5qK2uXS/NW8KcZWyT2ug+ydHuxS0MuwGxmf4BAs/lC8K
         xqzA==
X-Gm-Message-State: AOJu0YzR5lZlw1Wk9Ja9tNwhj6ya1ZT/M1ev/vRfmpoahmbA3S5WrOkj
        Kxs28modaoRaixVtJLz4dBkj919ON4n2jfsRZ5Ika9m4n9zO
X-Google-Smtp-Source: AGHT+IGKe1eIcFFVDgLmphTUSRGXMzZ95JeA0edSChnmvChdJAXMJymjB7dI0eQRQLVeehyBy6XurbLnNC/UCuy/aQhk092dJ1wG
MIME-Version: 1.0
X-Received: by 2002:a05:6808:201b:b0:3b9:e899:68f8 with SMTP id
 q27-20020a056808201b00b003b9e89968f8mr2515315oiw.3.1702183683442; Sat, 09 Dec
 2023 20:48:03 -0800 (PST)
Date:   Sat, 09 Dec 2023 20:48:03 -0800
In-Reply-To: <tencent_FDEC79DE6C3C2C356F409770E8F6EFC2CE0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cb8430060c2085ef@google.com>
Subject: Re: [syzbot] [arm-msm?] [net?] memory leak in radix_tree_insert (2)
From:   syzbot <syzbot+006987d1be3586e13555@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
memory leak in radix_tree_insert

BUG: memory leak
unreferenced object 0xffff88810bad6db0 (size 576):
  comm "syz-executor.0", pid 5766, jiffies 4294945919 (age 13.560s)
  hex dump (first 32 bytes):
    3c 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00  <...............
    f0 b3 c9 1b 81 88 ff ff c8 6d ad 0b 81 88 ff ff  .........m......
  backtrace:
    [<ffffffff81631398>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff81631398>] slab_post_alloc_hook mm/slab.h:766 [inline]
    [<ffffffff81631398>] slab_alloc_node mm/slub.c:3478 [inline]
    [<ffffffff81631398>] slab_alloc mm/slub.c:3486 [inline]
    [<ffffffff81631398>] __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
    [<ffffffff81631398>] kmem_cache_alloc+0x298/0x430 mm/slub.c:3502
    [<ffffffff84b5094c>] radix_tree_node_alloc.constprop.0+0x7c/0x1a0 lib/radix-tree.c:276
    [<ffffffff84b5252b>] __radix_tree_create lib/radix-tree.c:628 [inline]
    [<ffffffff84b5252b>] radix_tree_insert+0x16b/0x3a0 lib/radix-tree.c:717
    [<ffffffff84ae107d>] qrtr_tx_wait net/qrtr/af_qrtr.c:277 [inline]
    [<ffffffff84ae107d>] qrtr_node_enqueue+0x57d/0x640 net/qrtr/af_qrtr.c:349
    [<ffffffff84ae2726>] qrtr_bcast_enqueue+0x66/0xd0 net/qrtr/af_qrtr.c:892
    [<ffffffff84ae3302>] qrtr_sendmsg+0x232/0x450 net/qrtr/af_qrtr.c:993
    [<ffffffff83ec3c42>] sock_sendmsg_nosec net/socket.c:730 [inline]
    [<ffffffff83ec3c42>] __sock_sendmsg+0x52/0xa0 net/socket.c:745
    [<ffffffff83ec3d8b>] sock_write_iter+0xfb/0x180 net/socket.c:1158
    [<ffffffff816961a7>] call_write_iter include/linux/fs.h:2020 [inline]
    [<ffffffff816961a7>] new_sync_write fs/read_write.c:491 [inline]
    [<ffffffff816961a7>] vfs_write+0x327/0x590 fs/read_write.c:584
    [<ffffffff816966fb>] ksys_write+0x13b/0x170 fs/read_write.c:637
    [<ffffffff84b6de4f>] do_syscall_x64 arch/x86/entry/common.c:51 [inline]
    [<ffffffff84b6de4f>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b

BUG: memory leak
unreferenced object 0xffff88810c246000 (size 576):
  comm "syz-executor.0", pid 5766, jiffies 4294945920 (age 13.550s)
  hex dump (first 32 bytes):
    36 0f 01 00 00 00 00 00 b0 6d ad 0b 81 88 ff ff  6........m......
    f0 b3 c9 1b 81 88 ff ff 18 60 24 0c 81 88 ff ff  .........`$.....
  backtrace:
    [<ffffffff81631398>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff81631398>] slab_post_alloc_hook mm/slab.h:766 [inline]
    [<ffffffff81631398>] slab_alloc_node mm/slub.c:3478 [inline]
    [<ffffffff81631398>] slab_alloc mm/slub.c:3486 [inline]
    [<ffffffff81631398>] __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
    [<ffffffff81631398>] kmem_cache_alloc+0x298/0x430 mm/slub.c:3502
    [<ffffffff84b5094c>] radix_tree_node_alloc.constprop.0+0x7c/0x1a0 lib/radix-tree.c:276
    [<ffffffff84b5252b>] __radix_tree_create lib/radix-tree.c:628 [inline]
    [<ffffffff84b5252b>] radix_tree_insert+0x16b/0x3a0 lib/radix-tree.c:717
    [<ffffffff84ae107d>] qrtr_tx_wait net/qrtr/af_qrtr.c:277 [inline]
    [<ffffffff84ae107d>] qrtr_node_enqueue+0x57d/0x640 net/qrtr/af_qrtr.c:349
    [<ffffffff84ae2726>] qrtr_bcast_enqueue+0x66/0xd0 net/qrtr/af_qrtr.c:892
    [<ffffffff84ae3302>] qrtr_sendmsg+0x232/0x450 net/qrtr/af_qrtr.c:993
    [<ffffffff83ec3c42>] sock_sendmsg_nosec net/socket.c:730 [inline]
    [<ffffffff83ec3c42>] __sock_sendmsg+0x52/0xa0 net/socket.c:745
    [<ffffffff83ec3d8b>] sock_write_iter+0xfb/0x180 net/socket.c:1158
    [<ffffffff816961a7>] call_write_iter include/linux/fs.h:2020 [inline]
    [<ffffffff816961a7>] new_sync_write fs/read_write.c:491 [inline]
    [<ffffffff816961a7>] vfs_write+0x327/0x590 fs/read_write.c:584
    [<ffffffff816966fb>] ksys_write+0x13b/0x170 fs/read_write.c:637
    [<ffffffff84b6de4f>] do_syscall_x64 arch/x86/entry/common.c:51 [inline]
    [<ffffffff84b6de4f>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b

BUG: memory leak
unreferenced object 0xffff88810c246248 (size 576):
  comm "syz-executor.0", pid 5766, jiffies 4294945921 (age 13.540s)
  hex dump (first 32 bytes):
    30 3f 01 00 00 00 00 00 00 60 24 0c 81 88 ff ff  0?.......`$.....
    f0 b3 c9 1b 81 88 ff ff 60 62 24 0c 81 88 ff ff  ........`b$.....
  backtrace:
    [<ffffffff81631398>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff81631398>] slab_post_alloc_hook mm/slab.h:766 [inline]
    [<ffffffff81631398>] slab_alloc_node mm/slub.c:3478 [inline]
    [<ffffffff81631398>] slab_alloc mm/slub.c:3486 [inline]
    [<ffffffff81631398>] __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
    [<ffffffff81631398>] kmem_cache_alloc+0x298/0x430 mm/slub.c:3502
    [<ffffffff84b5094c>] radix_tree_node_alloc.constprop.0+0x7c/0x1a0 lib/radix-tree.c:276
    [<ffffffff84b5252b>] __radix_tree_create lib/radix-tree.c:628 [inline]
    [<ffffffff84b5252b>] radix_tree_insert+0x16b/0x3a0 lib/radix-tree.c:717
    [<ffffffff84ae107d>] qrtr_tx_wait net/qrtr/af_qrtr.c:277 [inline]
    [<ffffffff84ae107d>] qrtr_node_enqueue+0x57d/0x640 net/qrtr/af_qrtr.c:349
    [<ffffffff84ae2726>] qrtr_bcast_enqueue+0x66/0xd0 net/qrtr/af_qrtr.c:892
    [<ffffffff84ae3302>] qrtr_sendmsg+0x232/0x450 net/qrtr/af_qrtr.c:993
    [<ffffffff83ec3c42>] sock_sendmsg_nosec net/socket.c:730 [inline]
    [<ffffffff83ec3c42>] __sock_sendmsg+0x52/0xa0 net/socket.c:745
    [<ffffffff83ec3d8b>] sock_write_iter+0xfb/0x180 net/socket.c:1158
    [<ffffffff816961a7>] call_write_iter include/linux/fs.h:2020 [inline]
    [<ffffffff816961a7>] new_sync_write fs/read_write.c:491 [inline]
    [<ffffffff816961a7>] vfs_write+0x327/0x590 fs/read_write.c:584
    [<ffffffff816966fb>] ksys_write+0x13b/0x170 fs/read_write.c:637
    [<ffffffff84b6de4f>] do_syscall_x64 arch/x86/entry/common.c:51 [inline]
    [<ffffffff84b6de4f>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b

BUG: memory leak
unreferenced object 0xffff88810c246490 (size 576):
  comm "syz-executor.0", pid 5766, jiffies 4294945921 (age 13.540s)
  hex dump (first 32 bytes):
    2a 3f 00 00 00 00 00 00 48 62 24 0c 81 88 ff ff  *?......Hb$.....
    f0 b3 c9 1b 81 88 ff ff a8 64 24 0c 81 88 ff ff  .........d$.....
  backtrace:
    [<ffffffff81631398>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff81631398>] slab_post_alloc_hook mm/slab.h:766 [inline]
    [<ffffffff81631398>] slab_alloc_node mm/slub.c:3478 [inline]
    [<ffffffff81631398>] slab_alloc mm/slub.c:3486 [inline]
    [<ffffffff81631398>] __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
    [<ffffffff81631398>] kmem_cache_alloc+0x298/0x430 mm/slub.c:3502
    [<ffffffff84b5094c>] radix_tree_node_alloc.constprop.0+0x7c/0x1a0 lib/radix-tree.c:276
    [<ffffffff84b5252b>] __radix_tree_create lib/radix-tree.c:628 [inline]
    [<ffffffff84b5252b>] radix_tree_insert+0x16b/0x3a0 lib/radix-tree.c:717
    [<ffffffff84ae107d>] qrtr_tx_wait net/qrtr/af_qrtr.c:277 [inline]
    [<ffffffff84ae107d>] qrtr_node_enqueue+0x57d/0x640 net/qrtr/af_qrtr.c:349
    [<ffffffff84ae2726>] qrtr_bcast_enqueue+0x66/0xd0 net/qrtr/af_qrtr.c:892
    [<ffffffff84ae3302>] qrtr_sendmsg+0x232/0x450 net/qrtr/af_qrtr.c:993
    [<ffffffff83ec3c42>] sock_sendmsg_nosec net/socket.c:730 [inline]
    [<ffffffff83ec3c42>] __sock_sendmsg+0x52/0xa0 net/socket.c:745
    [<ffffffff83ec3d8b>] sock_write_iter+0xfb/0x180 net/socket.c:1158
    [<ffffffff816961a7>] call_write_iter include/linux/fs.h:2020 [inline]
    [<ffffffff816961a7>] new_sync_write fs/read_write.c:491 [inline]
    [<ffffffff816961a7>] vfs_write+0x327/0x590 fs/read_write.c:584
    [<ffffffff816966fb>] ksys_write+0x13b/0x170 fs/read_write.c:637
    [<ffffffff84b6de4f>] do_syscall_x64 arch/x86/entry/common.c:51 [inline]
    [<ffffffff84b6de4f>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b



Tested on:

commit:         33cc938e Linux 6.7-rc4
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=151b7d6ce80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=37d1b8bb20150e6
dashboard link: https://syzkaller.appspot.com/bug?extid=006987d1be3586e13555
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1242ef32e80000

