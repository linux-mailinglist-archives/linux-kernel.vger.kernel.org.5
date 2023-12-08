Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92DB8097A9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 01:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444172AbjLHAwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 19:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjLHAw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 19:52:27 -0500
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBCB1715
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 16:52:33 -0800 (PST)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1fb1c742f0bso2756147fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 16:52:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701996752; x=1702601552;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q+lLU4UeUFRuZ1hTtp7No7qPuCAeUchRtyaBvI4kxJM=;
        b=C4A1gnjlGCw2VXSanEa3OQH5ohdbAfHTRcWRXDJ4mFKaemIi8ovlTfMesFiX2F9ISi
         +WLpGWo8QApsCpj+aH3GWTRSA/oEf+guj8eyT9bYnQGCtXIUrb40YJf4KQC85+ojA72y
         wSHbhvdr8JRKjQLEwvt/z7vvPI3y9fw/5uJTanGqwU7PTMu03Fzt3jo3/dOylDnAAN0N
         jOgLSLyUoAlS1aA8UUAZXn+6uSOAhJ6nkX7qg1TNNhNpId0PVgSNzdy8JEQzOUblYJVY
         CBkDE5C3p0jmjCRs5COk0Ukna85Fsaah3vngBGzB70Jy0xC+AaZYpjOWgdCaNsTqwD5d
         uVRg==
X-Gm-Message-State: AOJu0YxKPrujniB8xmTvYyRsZOuWbNot6FIj2jpUhJRvOpm+CNH1fDDu
        hjSpf1asujPDedw58Ecoj3SG8yyGOdflR0MgyUzTmGKU2soS
X-Google-Smtp-Source: AGHT+IHz0t9HDTwTPbGcqm3L8DilUF699lfVq5Ys0NNmRQ6uTy+NWhRg9XN2Fhdsp7k1S/luzO0oYbl3gzkK+eX+bo/rEqdhdt3s
MIME-Version: 1.0
X-Received: by 2002:a05:6870:fba2:b0:1fb:1176:50ff with SMTP id
 kv34-20020a056870fba200b001fb117650ffmr4228508oab.6.1701996750942; Thu, 07
 Dec 2023 16:52:30 -0800 (PST)
Date:   Thu, 07 Dec 2023 16:52:30 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bfba3a060bf4ffcf@google.com>
Subject: [syzbot] [arm-msm?] [net?] memory leak in radix_tree_insert (2)
From:   syzbot <syzbot+006987d1be3586e13555@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mani@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    33cc938e65a9 Linux 6.7-rc4
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16ddf83ce80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=37d1b8bb20150e6
dashboard link: https://syzkaller.appspot.com/bug?extid=006987d1be3586e13555
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10276ebae80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=128c50d2e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bd6d7a5ff2af/disk-33cc938e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ce91b40ecddb/vmlinux-33cc938e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5507257fe99e/bzImage-33cc938e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+006987d1be3586e13555@syzkaller.appspotmail.com

write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory
BUG: memory leak
unreferenced object 0xffff88810bbf56d8 (size 576):
  comm "syz-executor250", pid 5051, jiffies 4294951219 (age 12.920s)
  hex dump (first 32 bytes):
    3c 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00  <...............
    f0 a9 2d 0c 81 88 ff ff f0 56 bf 0b 81 88 ff ff  ..-......V......
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
    [<ffffffff84ae105d>] qrtr_tx_wait net/qrtr/af_qrtr.c:277 [inline]
    [<ffffffff84ae105d>] qrtr_node_enqueue+0x57d/0x630 net/qrtr/af_qrtr.c:348
    [<ffffffff84ae26f6>] qrtr_bcast_enqueue+0x66/0xd0 net/qrtr/af_qrtr.c:891
    [<ffffffff84ae32d2>] qrtr_sendmsg+0x232/0x450 net/qrtr/af_qrtr.c:992
    [<ffffffff83ec3c32>] sock_sendmsg_nosec net/socket.c:730 [inline]
    [<ffffffff83ec3c32>] __sock_sendmsg+0x52/0xa0 net/socket.c:745
    [<ffffffff83ec3d7b>] sock_write_iter+0xfb/0x180 net/socket.c:1158
    [<ffffffff816961a7>] call_write_iter include/linux/fs.h:2020 [inline]
    [<ffffffff816961a7>] new_sync_write fs/read_write.c:491 [inline]
    [<ffffffff816961a7>] vfs_write+0x327/0x590 fs/read_write.c:584
    [<ffffffff816966fb>] ksys_write+0x13b/0x170 fs/read_write.c:637
    [<ffffffff84b6ddcf>] do_syscall_x64 arch/x86/entry/common.c:51 [inline]
    [<ffffffff84b6ddcf>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b

BUG: memory leak
unreferenced object 0xffff88810bbf5920 (size 576):
  comm "syz-executor250", pid 5051, jiffies 4294951219 (age 12.920s)
  hex dump (first 32 bytes):
    36 0f 01 00 00 00 00 00 d8 56 bf 0b 81 88 ff ff  6........V......
    f0 a9 2d 0c 81 88 ff ff 38 59 bf 0b 81 88 ff ff  ..-.....8Y......
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
    [<ffffffff84ae105d>] qrtr_tx_wait net/qrtr/af_qrtr.c:277 [inline]
    [<ffffffff84ae105d>] qrtr_node_enqueue+0x57d/0x630 net/qrtr/af_qrtr.c:348
    [<ffffffff84ae26f6>] qrtr_bcast_enqueue+0x66/0xd0 net/qrtr/af_qrtr.c:891
    [<ffffffff84ae32d2>] qrtr_sendmsg+0x232/0x450 net/qrtr/af_qrtr.c:992
    [<ffffffff83ec3c32>] sock_sendmsg_nosec net/socket.c:730 [inline]
    [<ffffffff83ec3c32>] __sock_sendmsg+0x52/0xa0 net/socket.c:745
    [<ffffffff83ec3d7b>] sock_write_iter+0xfb/0x180 net/socket.c:1158
    [<ffffffff816961a7>] call_write_iter include/linux/fs.h:2020 [inline]
    [<ffffffff816961a7>] new_sync_write fs/read_write.c:491 [inline]
    [<ffffffff816961a7>] vfs_write+0x327/0x590 fs/read_write.c:584
    [<ffffffff816966fb>] ksys_write+0x13b/0x170 fs/read_write.c:637
    [<ffffffff84b6ddcf>] do_syscall_x64 arch/x86/entry/common.c:51 [inline]
    [<ffffffff84b6ddcf>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b

BUG: memory leak
unreferenced object 0xffff88810c832000 (size 576):
  comm "syz-executor250", pid 5051, jiffies 4294951219 (age 12.920s)
  hex dump (first 32 bytes):
    30 3f 01 00 00 00 00 00 20 59 bf 0b 81 88 ff ff  0?...... Y......
    f0 a9 2d 0c 81 88 ff ff 18 20 83 0c 81 88 ff ff  ..-...... ......
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
    [<ffffffff84ae105d>] qrtr_tx_wait net/qrtr/af_qrtr.c:277 [inline]
    [<ffffffff84ae105d>] qrtr_node_enqueue+0x57d/0x630 net/qrtr/af_qrtr.c:348
    [<ffffffff84ae26f6>] qrtr_bcast_enqueue+0x66/0xd0 net/qrtr/af_qrtr.c:891
    [<ffffffff84ae32d2>] qrtr_sendmsg+0x232/0x450 net/qrtr/af_qrtr.c:992
    [<ffffffff83ec3c32>] sock_sendmsg_nosec net/socket.c:730 [inline]
    [<ffffffff83ec3c32>] __sock_sendmsg+0x52/0xa0 net/socket.c:745
    [<ffffffff83ec3d7b>] sock_write_iter+0xfb/0x180 net/socket.c:1158
    [<ffffffff816961a7>] call_write_iter include/linux/fs.h:2020 [inline]
    [<ffffffff816961a7>] new_sync_write fs/read_write.c:491 [inline]
    [<ffffffff816961a7>] vfs_write+0x327/0x590 fs/read_write.c:584
    [<ffffffff816966fb>] ksys_write+0x13b/0x170 fs/read_write.c:637
    [<ffffffff84b6ddcf>] do_syscall_x64 arch/x86/entry/common.c:51 [inline]
    [<ffffffff84b6ddcf>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b

BUG: memory leak
unreferenced object 0xffff88810c832248 (size 576):
  comm "syz-executor250", pid 5051, jiffies 4294951219 (age 12.920s)
  hex dump (first 32 bytes):
    2a 3f 00 00 00 00 00 00 00 20 83 0c 81 88 ff ff  *?....... ......
    f0 a9 2d 0c 81 88 ff ff 60 22 83 0c 81 88 ff ff  ..-.....`"......
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
    [<ffffffff84ae105d>] qrtr_tx_wait net/qrtr/af_qrtr.c:277 [inline]
    [<ffffffff84ae105d>] qrtr_node_enqueue+0x57d/0x630 net/qrtr/af_qrtr.c:348
    [<ffffffff84ae26f6>] qrtr_bcast_enqueue+0x66/0xd0 net/qrtr/af_qrtr.c:891
    [<ffffffff84ae32d2>] qrtr_sendmsg+0x232/0x450 net/qrtr/af_qrtr.c:992
    [<ffffffff83ec3c32>] sock_sendmsg_nosec net/socket.c:730 [inline]
    [<ffffffff83ec3c32>] __sock_sendmsg+0x52/0xa0 net/socket.c:745
    [<ffffffff83ec3d7b>] sock_write_iter+0xfb/0x180 net/socket.c:1158
    [<ffffffff816961a7>] call_write_iter include/linux/fs.h:2020 [inline]
    [<ffffffff816961a7>] new_sync_write fs/read_write.c:491 [inline]
    [<ffffffff816961a7>] vfs_write+0x327/0x590 fs/read_write.c:584
    [<ffffffff816966fb>] ksys_write+0x13b/0x170 fs/read_write.c:637
    [<ffffffff84b6ddcf>] do_syscall_x64 arch/x86/entry/common.c:51 [inline]
    [<ffffffff84b6ddcf>] do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0x6b

write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
