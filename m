Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1BDA763C41
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 18:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbjGZQUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 12:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjGZQUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 12:20:00 -0400
Received: from mail-oa1-f77.google.com (mail-oa1-f77.google.com [209.85.160.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E355E2D5E
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 09:19:41 -0700 (PDT)
Received: by mail-oa1-f77.google.com with SMTP id 586e51a60fabf-187959a901eso58892fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 09:19:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690388381; x=1690993181;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ja9lwwJiczR3VDcDEQG9wgS0ZmuFEIWnaFuz4pyvceE=;
        b=lmXV+ku7eMB36BoBjQfnQathUG1dWH80GzTMmXx45CwpZh+13O2flC8nzfT2S4SHPa
         fTFINI4rKGv6EwAuy0hSSK6L8JKUis6XdFTgKO9WBCE0xIpe5yFZ9t1MihqoVtQLlhYi
         SpmZ//VD9pHOpkv5cuMhPm/d4eyRaEAgFI0GS2zQCfY1WZZlgxYk3grT/oXoDByrSCwd
         x4a7bVfF72HEsIYBMntRKyt7BcWsd+O9xdtbypvnxx6xjXqIn9EsDt+cFrlxLOi0Dgxu
         mX/LHtQxw2k4tjiq3Lvd8cPJvqi+c7nffH1xOy5YUnhJ7kJRKKT4mMgcCFpIh+ESChPf
         k3og==
X-Gm-Message-State: ABy/qLbKOB6Vnxy7BYLM2jCoj01k18txMRs1U0RYEx30TVix5UH2GDaj
        zYu4rAVk5OytPG0Mcj+n+OwEsaqtMS5RLLq+Ln0d9P5y6aYN
X-Google-Smtp-Source: APBJJlEn1YgXjOs36M36KnHcEy8x7JjmCEc4U9plYZLdf6dEihXYPrLzaVt4KiZKG2g1PhgJbsMMUQQ9aFylokuPb1B1lIU91EqO
MIME-Version: 1.0
X-Received: by 2002:a05:6870:3a06:b0:1bb:b65c:c28 with SMTP id
 du6-20020a0568703a0600b001bbb65c0c28mr45245oab.0.1690388381117; Wed, 26 Jul
 2023 09:19:41 -0700 (PDT)
Date:   Wed, 26 Jul 2023 09:19:41 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fd316406016636ee@google.com>
Subject: [syzbot] [net?] memory leak in kcm_sendmsg (2)
From:   syzbot <syzbot+6f98de741f7dbbfc4ccb@syzkaller.appspotmail.com>
To:     bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    18b44bc5a672 ovl: Always reevaluate the file signature for..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15e732c9a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f187978508424dc
dashboard link: https://syzkaller.appspot.com/bug?extid=6f98de741f7dbbfc4ccb
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17d3d94ea80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13de8306a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7520f98f6651/disk-18b44bc5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f13d09e3480e/vmlinux-18b44bc5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/587382b9a0e6/bzImage-18b44bc5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6f98de741f7dbbfc4ccb@syzkaller.appspotmail.com

Warning: Permanently added '10.128.0.5' (ED25519) to the list of known hosts.
executing program
executing program
BUG: memory leak
unreferenced object 0xffff88810b088c00 (size 240):
  comm "syz-executor186", pid 5012, jiffies 4294943306 (age 13.680s)
  hex dump (first 32 bytes):
    00 89 08 0b 81 88 ff ff 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff83e5d5ff>] __alloc_skb+0x1ef/0x230 net/core/skbuff.c:634
    [<ffffffff84606e59>] alloc_skb include/linux/skbuff.h:1289 [inline]
    [<ffffffff84606e59>] kcm_sendmsg+0x269/0x1050 net/kcm/kcmsock.c:815
    [<ffffffff83e479c6>] sock_sendmsg_nosec net/socket.c:725 [inline]
    [<ffffffff83e479c6>] sock_sendmsg+0x56/0xb0 net/socket.c:748
    [<ffffffff83e47f55>] ____sys_sendmsg+0x365/0x470 net/socket.c:2494
    [<ffffffff83e4c389>] ___sys_sendmsg+0xc9/0x130 net/socket.c:2548
    [<ffffffff83e4c536>] __sys_sendmsg+0xa6/0x120 net/socket.c:2577
    [<ffffffff84ad7bb8>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84ad7bb8>] do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff88810a2cc000 (size 640):
  comm "syz-executor186", pid 5012, jiffies 4294943306 (age 13.680s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff83e5a2d1>] kmalloc_reserve+0xe1/0x180 net/core/skbuff.c:559
    [<ffffffff83e5d4e5>] __alloc_skb+0xd5/0x230 net/core/skbuff.c:644
    [<ffffffff84606e59>] alloc_skb include/linux/skbuff.h:1289 [inline]
    [<ffffffff84606e59>] kcm_sendmsg+0x269/0x1050 net/kcm/kcmsock.c:815
    [<ffffffff83e479c6>] sock_sendmsg_nosec net/socket.c:725 [inline]
    [<ffffffff83e479c6>] sock_sendmsg+0x56/0xb0 net/socket.c:748
    [<ffffffff83e47f55>] ____sys_sendmsg+0x365/0x470 net/socket.c:2494
    [<ffffffff83e4c389>] ___sys_sendmsg+0xc9/0x130 net/socket.c:2548
    [<ffffffff83e4c536>] __sys_sendmsg+0xa6/0x120 net/socket.c:2577
    [<ffffffff84ad7bb8>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84ad7bb8>] do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd



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
