Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0457980B94C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 07:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbjLJG36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 01:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjLJG36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 01:29:58 -0500
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB28CE7
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 22:30:03 -0800 (PST)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6d9f6b89aedso2518438a34.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Dec 2023 22:30:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702189803; x=1702794603;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jwSPXQ9A3SdW9wytk0pMfd2AQBjEBlqo7RtTufxp39Q=;
        b=ErL6pdi3hB9sWj+xsHP4e7z3de5wMhUI9n7ju20l7kuXPoBQYcY+Ocoy154dZp1Bsk
         iGUKgfkb6uv61MJ3mFAe+VcW2uL0ZnxX8eA1luPjLtzSVakPun14EQ4wh6fVx8SU2dng
         W1BtHEhISzrUp3P9KhtYU3O4cbPSKhipihzj4u9kXegbAHcpsgMWKas8rCmVn4yOmVbN
         BaJ5uLueqaIE/dxYVLD3Auf7xnmRJ2T3RJZ/igmzhYFihTJKxxerRHMCu7PBDdeq6IYu
         cAtnBQXXUC0/ain5C87TlpLrUzPsBLHJE4aL4a9fcqhXyHjsMQkLzCKSb7p24Lkf41Bw
         21tw==
X-Gm-Message-State: AOJu0YzGEPo1rAQCAEmzO0EGI3tl5ziVChBSZjCoaj6Qya9CZOsqXgl6
        UuP5kiSOZTZLAa6IA7BzUWm+vVKqA50D9bmUG+WE0uNHWa62
X-Google-Smtp-Source: AGHT+IFGXonJ6lDY87ZIptJVHZeZpJaqLO6KUKsOGB4PbSz2jLQ72ZBN1B69Xn88FWR1LsS4F4hBi7yeckv6yE6jNFS5NqEUNJFC
MIME-Version: 1.0
X-Received: by 2002:a05:6830:4491:b0:6d9:d508:a856 with SMTP id
 r17-20020a056830449100b006d9d508a856mr2553957otv.7.1702189803393; Sat, 09 Dec
 2023 22:30:03 -0800 (PST)
Date:   Sat, 09 Dec 2023 22:30:03 -0800
In-Reply-To: <tencent_F5872516BA75BB5A33CC9E661B2F4BB81B08@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009259a9060c21f28a@google.com>
Subject: Re: [syzbot] [arm-msm?] [net?] memory leak in radix_tree_insert (2)
From:   syzbot <syzbot+006987d1be3586e13555@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
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

2023/12/10 06:24:31 executed programs: 3
BUG: memory leak
unreferenced object 0xffff88810dca76d0 (size 576):
  comm "syz-executor.0", pid 5751, jiffies 4294945011 (age 13.020s)
  hex dump (first 32 bytes):
    3c 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00  <...............
    30 76 57 0c 81 88 ff ff e8 76 ca 0d 81 88 ff ff  0vW......v......
  backtrace:
    [<ffffffff81631398>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff81631398>] slab_post_alloc_hook mm/slab.h:766 [inline]
    [<ffffffff81631398>] slab_alloc_node mm/slub.c:3478 [inline]
    [<ffffffff81631398>] slab_alloc mm/slub.c:3486 [inline]
    [<ffffffff81631398>] __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
    [<ffffffff81631398>] kmem_cache_alloc+0x298/0x430 mm/slub.c:3502
    [<ffffffff84b5094c>] radix_tree_node_alloc.constprop.0+0x7c/0x1a0 lib/radix-tree.c:276
    [<ffffffff84b524cf>] __radix_tree_create lib/radix-tree.c:636 [inline]
    [<ffffffff84b524cf>] radix_tree_insert+0x14f/0x360 lib/radix-tree.c:724
    [<ffffffff84ae10b8>] qrtr_tx_wait net/qrtr/af_qrtr.c:277 [inline]
    [<ffffffff84ae10b8>] qrtr_node_enqueue+0x5b8/0x670 net/qrtr/af_qrtr.c:354
    [<ffffffff84ae2756>] qrtr_bcast_enqueue+0x66/0xd0 net/qrtr/af_qrtr.c:897
    [<ffffffff84ae3332>] qrtr_sendmsg+0x232/0x450 net/qrtr/af_qrtr.c:998
    [<ffffffff83ec3c42>] sock_sendmsg_nosec net/socket.c:730 [inline]
    [<ffffffff83ec3c42>] __sock_sendmsg+0x52/0xa0 net/socket.c:745
    [<ffffffff83ec3d8b>] sock_write_iter+0xfb/0x180 net/socket.c:1158
    [<ffffffff816961a7>] call_write_iter include/linux/fs.h:2020 [inline]
    [<ffffffff816961a7>] new_sync_write fs/read_write.c:491 [inline]
    [<ffffffff816961a7>] vfs_write+0x327/0x590 fs/read_write.c:584
    [<ffffffff816966fb>] ksys_write+0x13b/0x170 fs/read_write.c:637
    [<ffffffff84b6de2f>] do_syscall_x64 arch/x86/entry/common.c:51 [inline]
    [<ffffffff84b6de2f>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b

BUG: memory leak
unreferenced object 0xffff88810dca66d8 (size 576):
  comm "syz-executor.0", pid 5751, jiffies 4294945011 (age 13.020s)
  hex dump (first 32 bytes):
    36 0f 01 00 00 00 00 00 d0 76 ca 0d 81 88 ff ff  6........v......
    30 76 57 0c 81 88 ff ff f0 66 ca 0d 81 88 ff ff  0vW......f......
  backtrace:
    [<ffffffff81631398>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff81631398>] slab_post_alloc_hook mm/slab.h:766 [inline]
    [<ffffffff81631398>] slab_alloc_node mm/slub.c:3478 [inline]
    [<ffffffff81631398>] slab_alloc mm/slub.c:3486 [inline]
    [<ffffffff81631398>] __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
    [<ffffffff81631398>] kmem_cache_alloc+0x298/0x430 mm/slub.c:3502
    [<ffffffff84b5094c>] radix_tree_node_alloc.constprop.0+0x7c/0x1a0 lib/radix-tree.c:276
    [<ffffffff84b524cf>] __radix_tree_create lib/radix-tree.c:636 [inline]
    [<ffffffff84b524cf>] radix_tree_insert+0x14f/0x360 lib/radix-tree.c:724
    [<ffffffff84ae10b8>] qrtr_tx_wait net/qrtr/af_qrtr.c:277 [inline]
    [<ffffffff84ae10b8>] qrtr_node_enqueue+0x5b8/0x670 net/qrtr/af_qrtr.c:354
    [<ffffffff84ae2756>] qrtr_bcast_enqueue+0x66/0xd0 net/qrtr/af_qrtr.c:897
    [<ffffffff84ae3332>] qrtr_sendmsg+0x232/0x450 net/qrtr/af_qrtr.c:998
    [<ffffffff83ec3c42>] sock_sendmsg_nosec net/socket.c:730 [inline]
    [<ffffffff83ec3c42>] __sock_sendmsg+0x52/0xa0 net/socket.c:745
    [<ffffffff83ec3d8b>] sock_write_iter+0xfb/0x180 net/socket.c:1158
    [<ffffffff816961a7>] call_write_iter include/linux/fs.h:2020 [inline]
    [<ffffffff816961a7>] new_sync_write fs/read_write.c:491 [inline]
    [<ffffffff816961a7>] vfs_write+0x327/0x590 fs/read_write.c:584
    [<ffffffff816966fb>] ksys_write+0x13b/0x170 fs/read_write.c:637
    [<ffffffff84b6de2f>] do_syscall_x64 arch/x86/entry/common.c:51 [inline]
    [<ffffffff84b6de2f>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b

BUG: memory leak
unreferenced object 0xffff88810dd0f488 (size 576):
  comm "syz-executor.0", pid 5751, jiffies 4294945011 (age 13.020s)
  hex dump (first 32 bytes):
    30 3f 01 00 00 00 00 00 d8 66 ca 0d 81 88 ff ff  0?.......f......
    30 76 57 0c 81 88 ff ff a0 f4 d0 0d 81 88 ff ff  0vW.............
  backtrace:
    [<ffffffff81631398>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff81631398>] slab_post_alloc_hook mm/slab.h:766 [inline]
    [<ffffffff81631398>] slab_alloc_node mm/slub.c:3478 [inline]
    [<ffffffff81631398>] slab_alloc mm/slub.c:3486 [inline]
    [<ffffffff81631398>] __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
    [<ffffffff81631398>] kmem_cache_alloc+0x298/0x430 mm/slub.c:3502
    [<ffffffff84b5094c>] radix_tree_node_alloc.constprop.0+0x7c/0x1a0 lib/radix-tree.c:276
    [<ffffffff84b524cf>] __radix_tree_create lib/radix-tree.c:636 [inline]
    [<ffffffff84b524cf>] radix_tree_insert+0x14f/0x360 lib/radix-tree.c:724
    [<ffffffff84ae10b8>] qrtr_tx_wait net/qrtr/af_qrtr.c:277 [inline]
    [<ffffffff84ae10b8>] qrtr_node_enqueue+0x5b8/0x670 net/qrtr/af_qrtr.c:354
    [<ffffffff84ae2756>] qrtr_bcast_enqueue+0x66/0xd0 net/qrtr/af_qrtr.c:897
    [<ffffffff84ae3332>] qrtr_sendmsg+0x232/0x450 net/qrtr/af_qrtr.c:998
    [<ffffffff83ec3c42>] sock_sendmsg_nosec net/socket.c:730 [inline]
    [<ffffffff83ec3c42>] __sock_sendmsg+0x52/0xa0 net/socket.c:745
    [<ffffffff83ec3d8b>] sock_write_iter+0xfb/0x180 net/socket.c:1158
    [<ffffffff816961a7>] call_write_iter include/linux/fs.h:2020 [inline]
    [<ffffffff816961a7>] new_sync_write fs/read_write.c:491 [inline]
    [<ffffffff816961a7>] vfs_write+0x327/0x590 fs/read_write.c:584
    [<ffffffff816966fb>] ksys_write+0x13b/0x170 fs/read_write.c:637
    [<ffffffff84b6de2f>] do_syscall_x64 arch/x86/entry/common.c:51 [inline]
    [<ffffffff84b6de2f>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b

BUG: memory leak
unreferenced object 0xffff8881005e0000 (size 576):
  comm "syz-executor.0", pid 5751, jiffies 4294945011 (age 13.020s)
  hex dump (first 32 bytes):
    2a 3f 00 00 00 00 00 00 88 f4 d0 0d 81 88 ff ff  *?..............
    30 76 57 0c 81 88 ff ff 18 00 5e 00 81 88 ff ff  0vW.......^.....
  backtrace:
    [<ffffffff81631398>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff81631398>] slab_post_alloc_hook mm/slab.h:766 [inline]
    [<ffffffff81631398>] slab_alloc_node mm/slub.c:3478 [inline]
    [<ffffffff81631398>] slab_alloc mm/slub.c:3486 [inline]
    [<ffffffff81631398>] __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
    [<ffffffff81631398>] kmem_cache_alloc+0x298/0x430 mm/slub.c:3502
    [<ffffffff84b5094c>] radix_tree_node_alloc.constprop.0+0x7c/0x1a0 lib/radix-tree.c:276
    [<ffffffff84b524cf>] __radix_tree_create lib/radix-tree.c:636 [inline]
    [<ffffffff84b524cf>] radix_tree_insert+0x14f/0x360 lib/radix-tree.c:724
    [<ffffffff84ae10b8>] qrtr_tx_wait net/qrtr/af_qrtr.c:277 [inline]
    [<ffffffff84ae10b8>] qrtr_node_enqueue+0x5b8/0x670 net/qrtr/af_qrtr.c:354
    [<ffffffff84ae2756>] qrtr_bcast_enqueue+0x66/0xd0 net/qrtr/af_qrtr.c:897
    [<ffffffff84ae3332>] qrtr_sendmsg+0x232/0x450 net/qrtr/af_qrtr.c:998
    [<ffffffff83ec3c42>] sock_sendmsg_nosec net/socket.c:730 [inline]
    [<ffffffff83ec3c42>] __sock_sendmsg+0x52/0xa0 net/socket.c:745
    [<ffffffff83ec3d8b>] sock_write_iter+0xfb/0x180 net/socket.c:1158
    [<ffffffff816961a7>] call_write_iter include/linux/fs.h:2020 [inline]
    [<ffffffff816961a7>] new_sync_write fs/read_write.c:491 [inline]
    [<ffffffff816961a7>] vfs_write+0x327/0x590 fs/read_write.c:584
    [<ffffffff816966fb>] ksys_write+0x13b/0x170 fs/read_write.c:637
    [<ffffffff84b6de2f>] do_syscall_x64 arch/x86/entry/common.c:51 [inline]
    [<ffffffff84b6de2f>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b



Tested on:

commit:         33cc938e Linux 6.7-rc4
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17e587dae80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=37d1b8bb20150e6
dashboard link: https://syzkaller.appspot.com/bug?extid=006987d1be3586e13555
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1626d7eee80000

