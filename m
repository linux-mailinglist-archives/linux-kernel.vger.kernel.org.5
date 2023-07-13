Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAA937518B6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 08:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234009AbjGMGTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 02:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233395AbjGMGTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 02:19:00 -0400
Received: from mail-oi1-f206.google.com (mail-oi1-f206.google.com [209.85.167.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7621BF9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 23:18:58 -0700 (PDT)
Received: by mail-oi1-f206.google.com with SMTP id 5614622812f47-39a9590f9fdso441549b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 23:18:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689229137; x=1691821137;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DeD5ebV40eOirnVqAohkUvt+ZgrzeXIPbY4SVfKbCGE=;
        b=CclcbeTiiPIKM5G+VsqBeo1xcSD0yYj9epKvJ4YfdVtpViQF/NfBNdkbe9C1Xw95Uy
         j7NsuQ7mKfQBkNVcYgDveV2ZtiMLAydZCtKrfclCL/+OU9Z6sA81C0ABER9GOnLhESs9
         ofsS7Fm1M98YsZI5LRe/mWRlIJtEZs7Gkah5McB8TcKYNYKieLViUmXCxgu5p/Q6txzQ
         Awhd4nBe1bvXA061nATQDS5VBXztUCdAGVtQFVChIxlSh1kE56THu4MNnRpVkGp9zvMF
         LR4k6bpFt1MSZMEh5PX41nIl0VKS5TtUCgwy/aa/Py/X01sCEv6XfijckFDGnWb0Frij
         wjEg==
X-Gm-Message-State: ABy/qLaU6D/WvI+OjarGnhiiVE74q0jPmq3BlybpKBwL5wDuKS7Li/jA
        2iTWsHlcs4cIqFif3107s6NbQkktk2Gz8X+DCIj9XXVOhdbW
X-Google-Smtp-Source: APBJJlFbGWC6am5hjO+k1kyi3NpAJ10vt+N67xSPHrFVidvH+xRIbJcgKvF47Wqnu9+Si2MnT6oYdkByg9KHp8R4TMFKnpAqrYYe
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1998:b0:3a0:9db4:a575 with SMTP id
 bj24-20020a056808199800b003a09db4a575mr5195318oib.1.1689229137651; Wed, 12
 Jul 2023 23:18:57 -0700 (PDT)
Date:   Wed, 12 Jul 2023 23:18:57 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b1aecc0600584e76@google.com>
Subject: [syzbot] [net?] memory leak in mld_newpack (2)
From:   syzbot <syzbot+6667f589ca803e522dd5@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    1c7873e33645 mm: lock newly mapped VMA with corrected orde..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=154d4628a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=832b404e095b70c0
dashboard link: https://syzkaller.appspot.com/bug?extid=6667f589ca803e522dd5
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15571688a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/43b42bd2cf70/disk-1c7873e3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/011ba1b9e8c1/vmlinux-1c7873e3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/18b349342595/bzImage-1c7873e3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6667f589ca803e522dd5@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88811bcfc000 (size 2048):
  comm "kworker/0:2", pid 2509, jiffies 4295029694 (age 93.370s)
  hex dump (first 32 bytes):
    00 00 33 33 00 00 00 16 fa 19 b9 c5 55 d7 86 dd  ..33........U...
    60 00 00 00 00 24 00 01 00 00 00 00 00 00 00 00  `....$..........
  backtrace:
    [<ffffffff8154c38b>] __do_kmalloc_node mm/slab_common.c:984 [inline]
    [<ffffffff8154c38b>] __kmalloc_node_track_caller+0x4b/0x120 mm/slab_common.c:1005
    [<ffffffff83e184ec>] kmalloc_reserve+0x9c/0x180 net/core/skbuff.c:575
    [<ffffffff83e1bb55>] __alloc_skb+0xd5/0x230 net/core/skbuff.c:644
    [<ffffffff83e24b6f>] alloc_skb include/linux/skbuff.h:1289 [inline]
    [<ffffffff83e24b6f>] alloc_skb_with_frags+0x6f/0x340 net/core/skbuff.c:6228
    [<ffffffff83e116b3>] sock_alloc_send_pskb+0x3a3/0x3e0 net/core/sock.c:2782
    [<ffffffff842fc401>] sock_alloc_send_skb include/net/sock.h:1871 [inline]
    [<ffffffff842fc401>] mld_newpack.isra.0+0x81/0x220 net/ipv6/mcast.c:1748
    [<ffffffff842fc66c>] add_grhead+0xcc/0xf0 net/ipv6/mcast.c:1851
    [<ffffffff842fce63>] add_grec+0x7d3/0x840 net/ipv6/mcast.c:1989
    [<ffffffff842ff31f>] mld_send_cr net/ipv6/mcast.c:2115 [inline]
    [<ffffffff842ff31f>] mld_ifc_work+0x26f/0x750 net/ipv6/mcast.c:2653
    [<ffffffff812b19e4>] process_one_work+0x2c4/0x620 kernel/workqueue.c:2597
    [<ffffffff812b233d>] worker_thread+0x5d/0x5c0 kernel/workqueue.c:2748
    [<ffffffff812bbde3>] kthread+0x133/0x180 kernel/kthread.c:389
    [<ffffffff81002b5f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

BUG: memory leak
unreferenced object 0xffff88811bcfd800 (size 2048):
  comm "kworker/0:4", pid 5090, jiffies 4295029925 (age 91.060s)
  hex dump (first 32 bytes):
    00 00 33 33 00 00 00 16 aa aa aa aa aa 1b 86 dd  ..33............
    60 00 00 00 00 38 00 01 00 00 00 00 00 00 00 00  `....8..........
  backtrace:
    [<ffffffff8154c38b>] __do_kmalloc_node mm/slab_common.c:984 [inline]
    [<ffffffff8154c38b>] __kmalloc_node_track_caller+0x4b/0x120 mm/slab_common.c:1005
    [<ffffffff83e184ec>] kmalloc_reserve+0x9c/0x180 net/core/skbuff.c:575
    [<ffffffff83e1bb55>] __alloc_skb+0xd5/0x230 net/core/skbuff.c:644
    [<ffffffff83e24b6f>] alloc_skb include/linux/skbuff.h:1289 [inline]
    [<ffffffff83e24b6f>] alloc_skb_with_frags+0x6f/0x340 net/core/skbuff.c:6228
    [<ffffffff83e116b3>] sock_alloc_send_pskb+0x3a3/0x3e0 net/core/sock.c:2782
    [<ffffffff842fc401>] sock_alloc_send_skb include/net/sock.h:1871 [inline]
    [<ffffffff842fc401>] mld_newpack.isra.0+0x81/0x220 net/ipv6/mcast.c:1748
    [<ffffffff842fc66c>] add_grhead+0xcc/0xf0 net/ipv6/mcast.c:1851
    [<ffffffff842fce63>] add_grec+0x7d3/0x840 net/ipv6/mcast.c:1989
    [<ffffffff842ff31f>] mld_send_cr net/ipv6/mcast.c:2115 [inline]
    [<ffffffff842ff31f>] mld_ifc_work+0x26f/0x750 net/ipv6/mcast.c:2653
    [<ffffffff812b19e4>] process_one_work+0x2c4/0x620 kernel/workqueue.c:2597
    [<ffffffff812b233d>] worker_thread+0x5d/0x5c0 kernel/workqueue.c:2748
    [<ffffffff812bbde3>] kthread+0x133/0x180 kernel/kthread.c:389
    [<ffffffff81002b5f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
