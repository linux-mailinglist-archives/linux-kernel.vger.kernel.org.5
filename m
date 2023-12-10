Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F91A80B9CD
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 09:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjLJINC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 03:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjLJIM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 03:12:58 -0500
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A69C5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 00:13:04 -0800 (PST)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6d9decbc5d7so4058967a34.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 00:13:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702195984; x=1702800784;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DDcqDSo0luJBPZRr5X8W/lW27xG0MXkNcXRt+xChv+s=;
        b=M+y4NJBvh+tiMNjPnEhQbMqBBUWzT1aFGdyuzIAqVnH1ZxXp+1BUAjx9y630WFcNl4
         XLiZZYT1KXasLBzojOPaVxJxggzXjpiOdHxvZI2knol/fZ/rJ7AKxS43CUrI3xnqvX1W
         GZnmT8VnAfhKqJCnWYtPNJUYobKpJx2hNTLvR4srY4+vC5xzmCodOPDQIYgkUgeIFarq
         5H6TUlW3bpbZ4UvCzJhDlawAZo9ZxKRlu/wfO0mXEd6c+QXjDCp2CZ7jQa1KDzKdpkiX
         O8LZtqHWrSuaZSlFA3NnuLSRup1QLX/Rphsfrvi4MrHs5bPZHt3A+lKSoGldyB/Rdx0q
         Fz/Q==
X-Gm-Message-State: AOJu0Yy+9eXSrYk+wUcdJ2PZIYo7EHscaYt70qKlVgGI7QDGtaqYrIOA
        7U8sjPJpypPpz3XL91NaWib3073PyazZkev2QZb3xlMbrCDS
X-Google-Smtp-Source: AGHT+IF/Y5Sn2bg5sJSTMUbvI8vmW/vEs1WvGu8ou/82G6xV/PW0KVUQnDXJ39anrKXTnycukJOBMtD79zujE4QziJ4K1lirm+/+
MIME-Version: 1.0
X-Received: by 2002:a05:6830:4428:b0:6d9:da80:7f38 with SMTP id
 q40-20020a056830442800b006d9da807f38mr2350017otv.5.1702195984061; Sun, 10 Dec
 2023 00:13:04 -0800 (PST)
Date:   Sun, 10 Dec 2023 00:13:04 -0800
In-Reply-To: <tencent_5DCBB36DE37A697AA3A5A44C176557784605@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f7dc33060c2362be@google.com>
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

2023/12/10 08:04:23 executed programs: 3
BUG: memory leak
unreferenced object 0xffff88810b920000 (size 576):
  comm "syz-executor.0", pid 5753, jiffies 4294945520 (age 13.500s)
  hex dump (first 32 bytes):
    3c 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00  <...............
    30 79 97 0c 81 88 ff ff 18 00 92 0b 81 88 ff ff  0y..............
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
    [<ffffffff84ae10d0>] qrtr_tx_wait net/qrtr/af_qrtr.c:277 [inline]
    [<ffffffff84ae10d0>] qrtr_node_enqueue+0x5d0/0x6a0 net/qrtr/af_qrtr.c:356
    [<ffffffff84ae2786>] qrtr_bcast_enqueue+0x66/0xd0 net/qrtr/af_qrtr.c:899
    [<ffffffff84ae3362>] qrtr_sendmsg+0x232/0x450 net/qrtr/af_qrtr.c:1000
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
unreferenced object 0xffff88810b920248 (size 576):
  comm "syz-executor.0", pid 5753, jiffies 4294945520 (age 13.500s)
  hex dump (first 32 bytes):
    36 0f 01 00 00 00 00 00 00 00 92 0b 81 88 ff ff  6...............
    30 79 97 0c 81 88 ff ff 60 02 92 0b 81 88 ff ff  0y......`.......
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
    [<ffffffff84ae10d0>] qrtr_tx_wait net/qrtr/af_qrtr.c:277 [inline]
    [<ffffffff84ae10d0>] qrtr_node_enqueue+0x5d0/0x6a0 net/qrtr/af_qrtr.c:356
    [<ffffffff84ae2786>] qrtr_bcast_enqueue+0x66/0xd0 net/qrtr/af_qrtr.c:899
    [<ffffffff84ae3362>] qrtr_sendmsg+0x232/0x450 net/qrtr/af_qrtr.c:1000
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
unreferenced object 0xffff88810b920490 (size 576):
  comm "syz-executor.0", pid 5753, jiffies 4294945520 (age 13.500s)
  hex dump (first 32 bytes):
    30 3f 01 00 00 00 00 00 48 02 92 0b 81 88 ff ff  0?......H.......
    30 79 97 0c 81 88 ff ff a8 04 92 0b 81 88 ff ff  0y..............
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
    [<ffffffff84ae10d0>] qrtr_tx_wait net/qrtr/af_qrtr.c:277 [inline]
    [<ffffffff84ae10d0>] qrtr_node_enqueue+0x5d0/0x6a0 net/qrtr/af_qrtr.c:356
    [<ffffffff84ae2786>] qrtr_bcast_enqueue+0x66/0xd0 net/qrtr/af_qrtr.c:899
    [<ffffffff84ae3362>] qrtr_sendmsg+0x232/0x450 net/qrtr/af_qrtr.c:1000
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
unreferenced object 0xffff88810b9206d8 (size 576):
  comm "syz-executor.0", pid 5753, jiffies 4294945520 (age 13.500s)
  hex dump (first 32 bytes):
    2a 3f 00 00 00 00 00 00 90 04 92 0b 81 88 ff ff  *?..............
    30 79 97 0c 81 88 ff ff f0 06 92 0b 81 88 ff ff  0y..............
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
    [<ffffffff84ae10d0>] qrtr_tx_wait net/qrtr/af_qrtr.c:277 [inline]
    [<ffffffff84ae10d0>] qrtr_node_enqueue+0x5d0/0x6a0 net/qrtr/af_qrtr.c:356
    [<ffffffff84ae2786>] qrtr_bcast_enqueue+0x66/0xd0 net/qrtr/af_qrtr.c:899
    [<ffffffff84ae3362>] qrtr_sendmsg+0x232/0x450 net/qrtr/af_qrtr.c:1000
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
console output: https://syzkaller.appspot.com/x/log.txt?x=120e98b2e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=37d1b8bb20150e6
dashboard link: https://syzkaller.appspot.com/bug?extid=006987d1be3586e13555
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13605feee80000

