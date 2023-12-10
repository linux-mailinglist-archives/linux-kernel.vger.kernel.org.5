Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75DA80B8CE
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 05:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbjLJEIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 23:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbjLJEIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 23:08:16 -0500
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F38EB
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 20:08:07 -0800 (PST)
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1faf4442fa5so5859063fac.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Dec 2023 20:08:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702181287; x=1702786087;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O1ucpX9GtPXf2qy8IMPdYCdmRnC06lUTmQWKejBpx6c=;
        b=PAT86h3nAjH/I72SwgsAdK8mTg9YhGFb5cCtkxD32oIhn4nIrZLuGDFxnFw5a423Lv
         EbXbS8YJY5gx1CMBX0wM1lbfjk/PWB1lXPJTHxM5hoJi0e5T+N14CLQ+hmt0Ock/U3vw
         Oy1QFrdEA2H15NlhIB/NghS4pERVzu5mgaV1vJDr4r7kk+0FkQ/fbITBaRqOnlDdk1cf
         VWtVtGHwoRqjz1STr5uEL+/IUFG5gavfNHRg6iZRaPSxdhN3taMaooTHKpvRWx7Etu4T
         C0kMT94CD08Jm/slNHDRDRYjtaGHGU6wodIOtJGu8VUwXgTI2PRngB78BOwvhVmcny6p
         kyAg==
X-Gm-Message-State: AOJu0YwOMhv8+rdNeec8cXD0SUNi+wkmSk+0/iEemze+4SrM8LEKCVQj
        NOPWKnWihrgBg1Veyctz9vGx7uVjf22/EEY/+yXYdaGFKtSd
X-Google-Smtp-Source: AGHT+IFPrig1GY8Oa4lAIq6NYbXoCyN5oInMJkYXz+mcNhfXMORTYMvXyolT4m+1iqNLWK0WfCJ+JOxGBXgcKdYt4iaHKRYhoGFT
MIME-Version: 1.0
X-Received: by 2002:a05:6870:e415:b0:1fb:f51:25bb with SMTP id
 n21-20020a056870e41500b001fb0f5125bbmr2665014oag.5.1702181287071; Sat, 09 Dec
 2023 20:08:07 -0800 (PST)
Date:   Sat, 09 Dec 2023 20:08:07 -0800
In-Reply-To: <tencent_1571C9B12ED06EED4CAC67FD86C052FC4606@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f59633060c1ff65d@google.com>
Subject: Re: [syzbot] [arm-msm?] [net?] memory leak in radix_tree_insert (2)
From:   syzbot <syzbot+006987d1be3586e13555@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
memory leak in radix_tree_insert

2023/12/10 04:02:40 executed programs: 1
BUG: memory leak
unreferenced object 0xffff88810e4ac248 (size 576):
  comm "syz-executor.0", pid 5510, jiffies 4294944556 (age 13.040s)
  hex dump (first 32 bytes):
    3c 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00  <...............
    30 3c 8d 1a 81 88 ff ff 60 c2 4a 0e 81 88 ff ff  0<......`.J.....
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
    [<ffffffff84ae1012>] qrtr_tx_wait net/qrtr/af_qrtr.c:281 [inline]
    [<ffffffff84ae1012>] qrtr_node_enqueue+0x512/0x6d0 net/qrtr/af_qrtr.c:354
    [<ffffffff84ae27b6>] qrtr_bcast_enqueue+0x66/0xd0 net/qrtr/af_qrtr.c:897
    [<ffffffff84ae3392>] qrtr_sendmsg+0x232/0x450 net/qrtr/af_qrtr.c:998
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
unreferenced object 0xffff88810e4ac000 (size 576):
  comm "syz-executor.0", pid 5510, jiffies 4294944556 (age 13.040s)
  hex dump (first 32 bytes):
    36 0f 01 00 00 00 00 00 48 c2 4a 0e 81 88 ff ff  6.......H.J.....
    30 3c 8d 1a 81 88 ff ff 18 c0 4a 0e 81 88 ff ff  0<........J.....
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
    [<ffffffff84ae1012>] qrtr_tx_wait net/qrtr/af_qrtr.c:281 [inline]
    [<ffffffff84ae1012>] qrtr_node_enqueue+0x512/0x6d0 net/qrtr/af_qrtr.c:354
    [<ffffffff84ae27b6>] qrtr_bcast_enqueue+0x66/0xd0 net/qrtr/af_qrtr.c:897
    [<ffffffff84ae3392>] qrtr_sendmsg+0x232/0x450 net/qrtr/af_qrtr.c:998
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
unreferenced object 0xffff88810e4adda8 (size 576):
  comm "syz-executor.0", pid 5510, jiffies 4294944556 (age 13.040s)
  hex dump (first 32 bytes):
    30 3f 01 00 00 00 00 00 00 c0 4a 0e 81 88 ff ff  0?........J.....
    30 3c 8d 1a 81 88 ff ff c0 dd 4a 0e 81 88 ff ff  0<........J.....
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
    [<ffffffff84ae1012>] qrtr_tx_wait net/qrtr/af_qrtr.c:281 [inline]
    [<ffffffff84ae1012>] qrtr_node_enqueue+0x512/0x6d0 net/qrtr/af_qrtr.c:354
    [<ffffffff84ae27b6>] qrtr_bcast_enqueue+0x66/0xd0 net/qrtr/af_qrtr.c:897
    [<ffffffff84ae3392>] qrtr_sendmsg+0x232/0x450 net/qrtr/af_qrtr.c:998
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
unreferenced object 0xffff88810e4da000 (size 576):
  comm "syz-executor.0", pid 5510, jiffies 4294944556 (age 13.040s)
  hex dump (first 32 bytes):
    2a 3f 00 00 00 00 00 00 a8 dd 4a 0e 81 88 ff ff  *?........J.....
    30 3c 8d 1a 81 88 ff ff 18 a0 4d 0e 81 88 ff ff  0<........M.....
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
    [<ffffffff84ae1012>] qrtr_tx_wait net/qrtr/af_qrtr.c:281 [inline]
    [<ffffffff84ae1012>] qrtr_node_enqueue+0x512/0x6d0 net/qrtr/af_qrtr.c:354
    [<ffffffff84ae27b6>] qrtr_bcast_enqueue+0x66/0xd0 net/qrtr/af_qrtr.c:897
    [<ffffffff84ae3392>] qrtr_sendmsg+0x232/0x450 net/qrtr/af_qrtr.c:998
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
console output: https://syzkaller.appspot.com/x/log.txt?x=1485aebce80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=37d1b8bb20150e6
dashboard link: https://syzkaller.appspot.com/bug?extid=006987d1be3586e13555
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10dfa02ae80000

