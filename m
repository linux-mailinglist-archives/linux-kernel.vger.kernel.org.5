Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1F680B84F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 02:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbjLJBTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 20:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjLJBTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 20:19:00 -0500
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2009F114
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 17:19:06 -0800 (PST)
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-58d5604c050so3447223eaf.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Dec 2023 17:19:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702171145; x=1702775945;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dfn9yVkErGqxJURzCKeWuJP/+pYLPK6gaMsnRxOTFZE=;
        b=PL+7w7SVqfUbSwUrMo72fDqFMG6gdSyG6YsEnDinXWaMeydvnS+RHod/cwuQ3pJHwo
         zWzxz4K5dR7i9mZZVwYyCsvK3dWL1PewxN9JZQvey2HXMsiQSE4ptr8iQ6oYfltwfrtO
         Ohs50NLCaDTtkMfC5i9UxFyYyxyzczx7E7UbwbVUXpVHam6fjNZ05XqkOe3xwxkaHYis
         BjKGMk+XzR2lRnSpiOuxj8GcxLsfCpUa+FCbdJXcFE/qDh2wjEJsV27htFT+g8FqTyUw
         Lb0aBBRtypBx+7r06mLASJLxWXa/ttS5CpxwAy3P12CEc5wuY+FkvYdsyOGD1DU73IlC
         QDQQ==
X-Gm-Message-State: AOJu0YxWYXVX9tTnaJZRXpTtobCXDHSbdEDUzuKrDZMnVoYulGrln5Uk
        Vg6CujBJVSpIH0VU4TCfi3z+p+WTFHgRmYS/YMsdcFCFl9bl
X-Google-Smtp-Source: AGHT+IHgmss9O3I+lpBNY71RZ50h8ZeY+GLMYR9lY10QWDB1qB2lESCo4ium5xNk0dc4vkk4E8vAImDMFkpiXovYNX/JXgQuOpdn
MIME-Version: 1.0
X-Received: by 2002:a05:6870:e305:b0:1fa:16c4:8954 with SMTP id
 z5-20020a056870e30500b001fa16c48954mr2752521oad.0.1702171145510; Sat, 09 Dec
 2023 17:19:05 -0800 (PST)
Date:   Sat, 09 Dec 2023 17:19:05 -0800
In-Reply-To: <tencent_0E30CFAC0DE825820DBC923D5DE75DAF1907@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000079a7f0060c1d9aa6@google.com>
Subject: Re: [syzbot] [arm-msm?] [net?] memory leak in radix_tree_insert (2)
From:   syzbot <syzbot+006987d1be3586e13555@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
memory leak in radix_tree_insert

BUG: memory leak
unreferenced object 0xffff88810e5afda8 (size 576):
  comm "syz-executor.0", pid 5489, jiffies 4294944355 (age 12.710s)
  hex dump (first 32 bytes):
    3c 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00  <...............
    70 ee 73 1b 81 88 ff ff c0 fd 5a 0e 81 88 ff ff  p.s.......Z.....
  backtrace:
    [<ffffffff81631398>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff81631398>] slab_post_alloc_hook mm/slab.h:766 [inline]
    [<ffffffff81631398>] slab_alloc_node mm/slub.c:3478 [inline]
    [<ffffffff81631398>] slab_alloc mm/slub.c:3486 [inline]
    [<ffffffff81631398>] __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
    [<ffffffff81631398>] kmem_cache_alloc+0x298/0x430 mm/slub.c:3502
    [<ffffffff84b5094c>] radix_tree_node_alloc.constprop.0+0x7c/0x1a0 lib/radix-tree.c:276
    [<ffffffff84b524cf>] __radix_tree_create lib/radix-tree.c:624 [inline]
    [<ffffffff84b524cf>] radix_tree_insert+0x14f/0x360 lib/radix-tree.c:712
    [<ffffffff84ae108c>] qrtr_tx_wait net/qrtr/af_qrtr.c:277 [inline]
    [<ffffffff84ae108c>] qrtr_node_enqueue+0x58c/0x660 net/qrtr/af_qrtr.c:354
    [<ffffffff84ae2746>] qrtr_bcast_enqueue+0x66/0xd0 net/qrtr/af_qrtr.c:897
    [<ffffffff84ae3322>] qrtr_sendmsg+0x232/0x450 net/qrtr/af_qrtr.c:998
    [<ffffffff83ec3c42>] sock_sendmsg_nosec net/socket.c:730 [inline]
    [<ffffffff83ec3c42>] __sock_sendmsg+0x52/0xa0 net/socket.c:745
    [<ffffffff83ec3d8b>] sock_write_iter+0xfb/0x180 net/socket.c:1158
    [<ffffffff816961a7>] call_write_iter include/linux/fs.h:2020 [inline]
    [<ffffffff816961a7>] new_sync_write fs/read_write.c:491 [inline]
    [<ffffffff816961a7>] vfs_write+0x327/0x590 fs/read_write.c:584
    [<ffffffff816966fb>] ksys_write+0x13b/0x170 fs/read_write.c:637
    [<ffffffff84b6ddcf>] do_syscall_x64 arch/x86/entry/common.c:51 [inline]
    [<ffffffff84b6ddcf>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b

BUG: memory leak
unreferenced object 0xffff88810e5ec248 (size 576):
  comm "syz-executor.0", pid 5489, jiffies 4294944355 (age 12.710s)
  hex dump (first 32 bytes):
    36 0f 01 00 00 00 00 00 a8 fd 5a 0e 81 88 ff ff  6.........Z.....
    70 ee 73 1b 81 88 ff ff 60 c2 5e 0e 81 88 ff ff  p.s.....`.^.....
  backtrace:
    [<ffffffff81631398>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff81631398>] slab_post_alloc_hook mm/slab.h:766 [inline]
    [<ffffffff81631398>] slab_alloc_node mm/slub.c:3478 [inline]
    [<ffffffff81631398>] slab_alloc mm/slub.c:3486 [inline]
    [<ffffffff81631398>] __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
    [<ffffffff81631398>] kmem_cache_alloc+0x298/0x430 mm/slub.c:3502
    [<ffffffff84b5094c>] radix_tree_node_alloc.constprop.0+0x7c/0x1a0 lib/radix-tree.c:276
    [<ffffffff84b524cf>] __radix_tree_create lib/radix-tree.c:624 [inline]
    [<ffffffff84b524cf>] radix_tree_insert+0x14f/0x360 lib/radix-tree.c:712
    [<ffffffff84ae108c>] qrtr_tx_wait net/qrtr/af_qrtr.c:277 [inline]
    [<ffffffff84ae108c>] qrtr_node_enqueue+0x58c/0x660 net/qrtr/af_qrtr.c:354
    [<ffffffff84ae2746>] qrtr_bcast_enqueue+0x66/0xd0 net/qrtr/af_qrtr.c:897
    [<ffffffff84ae3322>] qrtr_sendmsg+0x232/0x450 net/qrtr/af_qrtr.c:998
    [<ffffffff83ec3c42>] sock_sendmsg_nosec net/socket.c:730 [inline]
    [<ffffffff83ec3c42>] __sock_sendmsg+0x52/0xa0 net/socket.c:745
    [<ffffffff83ec3d8b>] sock_write_iter+0xfb/0x180 net/socket.c:1158
    [<ffffffff816961a7>] call_write_iter include/linux/fs.h:2020 [inline]
    [<ffffffff816961a7>] new_sync_write fs/read_write.c:491 [inline]
    [<ffffffff816961a7>] vfs_write+0x327/0x590 fs/read_write.c:584
    [<ffffffff816966fb>] ksys_write+0x13b/0x170 fs/read_write.c:637
    [<ffffffff84b6ddcf>] do_syscall_x64 arch/x86/entry/common.c:51 [inline]
    [<ffffffff84b6ddcf>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b

BUG: memory leak
unreferenced object 0xffff88810e635488 (size 576):
  comm "syz-executor.0", pid 5489, jiffies 4294944355 (age 12.710s)
  hex dump (first 32 bytes):
    30 3f 01 00 00 00 00 00 48 c2 5e 0e 81 88 ff ff  0?......H.^.....
    70 ee 73 1b 81 88 ff ff a0 54 63 0e 81 88 ff ff  p.s......Tc.....
  backtrace:
    [<ffffffff81631398>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff81631398>] slab_post_alloc_hook mm/slab.h:766 [inline]
    [<ffffffff81631398>] slab_alloc_node mm/slub.c:3478 [inline]
    [<ffffffff81631398>] slab_alloc mm/slub.c:3486 [inline]
    [<ffffffff81631398>] __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
    [<ffffffff81631398>] kmem_cache_alloc+0x298/0x430 mm/slub.c:3502
    [<ffffffff84b5094c>] radix_tree_node_alloc.constprop.0+0x7c/0x1a0 lib/radix-tree.c:276
    [<ffffffff84b524cf>] __radix_tree_create lib/radix-tree.c:624 [inline]
    [<ffffffff84b524cf>] radix_tree_insert+0x14f/0x360 lib/radix-tree.c:712
    [<ffffffff84ae108c>] qrtr_tx_wait net/qrtr/af_qrtr.c:277 [inline]
    [<ffffffff84ae108c>] qrtr_node_enqueue+0x58c/0x660 net/qrtr/af_qrtr.c:354
    [<ffffffff84ae2746>] qrtr_bcast_enqueue+0x66/0xd0 net/qrtr/af_qrtr.c:897
    [<ffffffff84ae3322>] qrtr_sendmsg+0x232/0x450 net/qrtr/af_qrtr.c:998
    [<ffffffff83ec3c42>] sock_sendmsg_nosec net/socket.c:730 [inline]
    [<ffffffff83ec3c42>] __sock_sendmsg+0x52/0xa0 net/socket.c:745
    [<ffffffff83ec3d8b>] sock_write_iter+0xfb/0x180 net/socket.c:1158
    [<ffffffff816961a7>] call_write_iter include/linux/fs.h:2020 [inline]
    [<ffffffff816961a7>] new_sync_write fs/read_write.c:491 [inline]
    [<ffffffff816961a7>] vfs_write+0x327/0x590 fs/read_write.c:584
    [<ffffffff816966fb>] ksys_write+0x13b/0x170 fs/read_write.c:637
    [<ffffffff84b6ddcf>] do_syscall_x64 arch/x86/entry/common.c:51 [inline]
    [<ffffffff84b6ddcf>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b

BUG: memory leak
unreferenced object 0xffff88810e4fa000 (size 576):
  comm "syz-executor.0", pid 5489, jiffies 4294944355 (age 12.710s)
  hex dump (first 32 bytes):
    2a 3f 00 00 00 00 00 00 88 54 63 0e 81 88 ff ff  *?.......Tc.....
    70 ee 73 1b 81 88 ff ff 18 a0 4f 0e 81 88 ff ff  p.s.......O.....
  backtrace:
    [<ffffffff81631398>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff81631398>] slab_post_alloc_hook mm/slab.h:766 [inline]
    [<ffffffff81631398>] slab_alloc_node mm/slub.c:3478 [inline]
    [<ffffffff81631398>] slab_alloc mm/slub.c:3486 [inline]
    [<ffffffff81631398>] __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
    [<ffffffff81631398>] kmem_cache_alloc+0x298/0x430 mm/slub.c:3502
    [<ffffffff84b5094c>] radix_tree_node_alloc.constprop.0+0x7c/0x1a0 lib/radix-tree.c:276
    [<ffffffff84b524cf>] __radix_tree_create lib/radix-tree.c:624 [inline]
    [<ffffffff84b524cf>] radix_tree_insert+0x14f/0x360 lib/radix-tree.c:712
    [<ffffffff84ae108c>] qrtr_tx_wait net/qrtr/af_qrtr.c:277 [inline]
    [<ffffffff84ae108c>] qrtr_node_enqueue+0x58c/0x660 net/qrtr/af_qrtr.c:354
    [<ffffffff84ae2746>] qrtr_bcast_enqueue+0x66/0xd0 net/qrtr/af_qrtr.c:897
    [<ffffffff84ae3322>] qrtr_sendmsg+0x232/0x450 net/qrtr/af_qrtr.c:998
    [<ffffffff83ec3c42>] sock_sendmsg_nosec net/socket.c:730 [inline]
    [<ffffffff83ec3c42>] __sock_sendmsg+0x52/0xa0 net/socket.c:745
    [<ffffffff83ec3d8b>] sock_write_iter+0xfb/0x180 net/socket.c:1158
    [<ffffffff816961a7>] call_write_iter include/linux/fs.h:2020 [inline]
    [<ffffffff816961a7>] new_sync_write fs/read_write.c:491 [inline]
    [<ffffffff816961a7>] vfs_write+0x327/0x590 fs/read_write.c:584
    [<ffffffff816966fb>] ksys_write+0x13b/0x170 fs/read_write.c:637
    [<ffffffff84b6ddcf>] do_syscall_x64 arch/x86/entry/common.c:51 [inline]
    [<ffffffff84b6ddcf>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b



Tested on:

commit:         33cc938e Linux 6.7-rc4
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15858332e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=37d1b8bb20150e6
dashboard link: https://syzkaller.appspot.com/bug?extid=006987d1be3586e13555
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15b888b6e80000

