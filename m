Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A62F785A8C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 16:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236447AbjHWOc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 10:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236170AbjHWOc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 10:32:28 -0400
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCE4E74
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 07:32:24 -0700 (PDT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-53ff4f39c0fso6300405a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 07:32:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692801143; x=1693405943;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ScA6Akx0VCHJI+vElTa6mVrXCUiV4W0qnHdlMLR7p58=;
        b=Zorp10QVD2+lNHMpJMoqhTbVhcuLu0hHLbe/y8wh5PehIyaPu0+bB4TaztaZ+IHzp/
         Vff2jizhqERB3qFXbxZSg31a6gaPhvwNgJeBuHJ4kgYLJqQSPn7D5hCIgQ+IXmRGMaQG
         uoqPKr87ThXg2r+Xr/eTzeH7eLe/3mUx6HoWpshq9QMCRbdqgdv1lwiOOhW1AqBP+1oT
         +Puip63QycjOFCPY2/2ijn6JfPortYYO3Lpjz9SJpX1gC9CdbxqDoQPaBqmESVxmOl5t
         RWYn1QigzvMCtje+MLXNPCAutiEL5CqRAvdrIOWGKnuJ1yIoEeTWqffP3OAXCmppJM3c
         welg==
X-Gm-Message-State: AOJu0Yzp+qNz06a4wAhBNNNlQEiyIsk/LVyf4VD/VWPJmE2+vPFU70KQ
        LvPVNnopdd7tOA/NnCMHH4d0m2ljbX1gM/J4cTEYiQ8xTr1F
X-Google-Smtp-Source: AGHT+IGukamF5sCkLq/YzoJkU/p5OMyRIPsSJGkNG/SOIvg4u329S4qTmx4GQTgMXhvh66Ny9WicILn1eiHqXp+cO5QdHWcVP052
MIME-Version: 1.0
X-Received: by 2002:a63:33ca:0:b0:55b:61bd:9bc9 with SMTP id
 z193-20020a6333ca000000b0055b61bd9bc9mr2126786pgz.12.1692801143555; Wed, 23
 Aug 2023 07:32:23 -0700 (PDT)
Date:   Wed, 23 Aug 2023 07:32:23 -0700
In-Reply-To: <20230823140836.2923-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d64f9b060397fa13@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in hci_send_acl
From:   syzbot <syzbot+a0c80b06ae2cb8895bc4@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-out-of-bounds Read in l2cap_chan_del

==================================================================
BUG: KASAN: slab-out-of-bounds in hci_conn_drop include/net/bluetooth/hci_core.h:1549 [inline]
BUG: KASAN: slab-out-of-bounds in hci_conn_drop include/net/bluetooth/hci_core.h:1519 [inline]
BUG: KASAN: slab-out-of-bounds in l2cap_chan_del+0xa0b/0xa70 net/bluetooth/l2cap_core.c:668
Read of size 8 at addr ffff888068778718 by task kworker/0:0/8

CPU: 0 PID: 8 Comm: kworker/0:0 Not tainted 6.5.0-rc6-next-20230818-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Workqueue: events l2cap_chan_timeout
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 hci_conn_drop include/net/bluetooth/hci_core.h:1549 [inline]
 hci_conn_drop include/net/bluetooth/hci_core.h:1519 [inline]
 l2cap_chan_del+0xa0b/0xa70 net/bluetooth/l2cap_core.c:668
 l2cap_chan_close+0xff/0xa20 net/bluetooth/l2cap_core.c:851
 l2cap_chan_timeout+0x17d/0x2f0 net/bluetooth/l2cap_core.c:452
 process_one_work+0x887/0x15d0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8bb/0x1290 kernel/workqueue.c:2784
 kthread+0x33a/0x430 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>

Allocated by task 4708:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:198 [inline]
 __do_kmalloc_node mm/slab_common.c:1004 [inline]
 __kmalloc_node_track_caller+0x61/0x100 mm/slab_common.c:1024
 kmalloc_reserve+0xef/0x270 net/core/skbuff.c:575
 __alloc_skb+0x12b/0x330 net/core/skbuff.c:644
 alloc_skb include/linux/skbuff.h:1286 [inline]
 alloc_skb_with_frags+0xe4/0x710 net/core/skbuff.c:6274
 sock_alloc_send_pskb+0x7c8/0x950 net/core/sock.c:2794
 unix_dgram_sendmsg+0x455/0x1c30 net/unix/af_unix.c:1953
 sock_sendmsg_nosec net/socket.c:730 [inline]
 sock_sendmsg+0xd9/0x180 net/socket.c:753
 sock_write_iter+0x29b/0x3d0 net/socket.c:1140
 call_write_iter include/linux/fs.h:1983 [inline]
 do_iter_readv_writev+0x21e/0x3c0 fs/read_write.c:735
 do_iter_write+0x17f/0x830 fs/read_write.c:860
 vfs_writev+0x221/0x700 fs/read_write.c:933
 do_writev+0x285/0x370 fs/read_write.c:976
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 4707:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:522
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x15b/0x1b0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:164 [inline]
 slab_free_hook mm/slub.c:1800 [inline]
 slab_free_freelist_hook+0x114/0x1e0 mm/slub.c:1826
 slab_free mm/slub.c:3809 [inline]
 __kmem_cache_free+0xb8/0x2f0 mm/slub.c:3822
 skb_kfree_head net/core/skbuff.c:939 [inline]
 skb_free_head+0x110/0x1b0 net/core/skbuff.c:951
 skb_release_data+0x5ba/0x870 net/core/skbuff.c:981
 skb_release_all net/core/skbuff.c:1047 [inline]
 __kfree_skb net/core/skbuff.c:1061 [inline]
 consume_skb net/core/skbuff.c:1277 [inline]
 consume_skb+0xd2/0x170 net/core/skbuff.c:1271
 __unix_dgram_recvmsg+0x814/0xe50 net/unix/af_unix.c:2442
 unix_dgram_recvmsg+0xc3/0xf0 net/unix/af_unix.c:2459
 sock_recvmsg_nosec net/socket.c:1026 [inline]
 sock_recvmsg+0xe2/0x170 net/socket.c:1048
 sock_read_iter+0x2c3/0x3c0 net/socket.c:1118
 call_read_iter include/linux/fs.h:1977 [inline]
 do_iter_readv_writev+0x2f2/0x3c0 fs/read_write.c:733
 do_iter_read+0x315/0x870 fs/read_write.c:795
 vfs_readv+0x12d/0x1a0 fs/read_write.c:915
 do_readv+0x285/0x370 fs/read_write.c:952
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888068778400
 which belongs to the cache kmalloc-cg-512 of size 512
The buggy address is located 280 bytes to the right of
 allocated 512-byte region [ffff888068778400, ffff888068778600)

The buggy address belongs to the physical page:
page:ffffea0001a1de00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x68778
head:ffffea0001a1de00 order:2 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff88801937bc01
flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888012c4f140 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000100010 00000001ffffffff ffff88801937bc01
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 4708, tgid 4708 (dhcpcd), ts 448399025420, free_ts 448388778101
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2cf/0x340 mm/page_alloc.c:1536
 prep_new_page mm/page_alloc.c:1543 [inline]
 get_page_from_freelist+0x10d7/0x31b0 mm/page_alloc.c:3219
 __alloc_pages+0x1d0/0x4a0 mm/page_alloc.c:4475
 alloc_pages+0x1a9/0x270 mm/mempolicy.c:2298
 alloc_slab_page mm/slub.c:1870 [inline]
 allocate_slab+0x251/0x380 mm/slub.c:2017
 new_slab mm/slub.c:2070 [inline]
 ___slab_alloc+0x8be/0x1570 mm/slub.c:3223
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3322
 __slab_alloc_node mm/slub.c:3375 [inline]
 slab_alloc_node mm/slub.c:3468 [inline]
 __kmem_cache_alloc_node+0x137/0x350 mm/slub.c:3517
 __do_kmalloc_node mm/slab_common.c:1003 [inline]
 __kmalloc_node_track_caller+0x50/0x100 mm/slab_common.c:1024
 kmalloc_reserve+0xef/0x270 net/core/skbuff.c:575
 __alloc_skb+0x12b/0x330 net/core/skbuff.c:644
 alloc_skb include/linux/skbuff.h:1286 [inline]
 alloc_skb_with_frags+0xe4/0x710 net/core/skbuff.c:6274
 sock_alloc_send_pskb+0x7c8/0x950 net/core/sock.c:2794
 unix_dgram_sendmsg+0x455/0x1c30 net/unix/af_unix.c:1953
 sock_sendmsg_nosec net/socket.c:730 [inline]
 sock_sendmsg+0xd9/0x180 net/socket.c:753
 sock_write_iter+0x29b/0x3d0 net/socket.c:1140
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1136 [inline]
 free_unref_page_prepare+0x476/0xa40 mm/page_alloc.c:2348
 free_unref_page+0x33/0x3b0 mm/page_alloc.c:2441
 skb_kfree_head net/core/skbuff.c:939 [inline]
 skb_free_head+0x110/0x1b0 net/core/skbuff.c:951
 skb_release_data+0x5ba/0x870 net/core/skbuff.c:981
 skb_release_all net/core/skbuff.c:1047 [inline]
 __kfree_skb net/core/skbuff.c:1061 [inline]
 consume_skb net/core/skbuff.c:1277 [inline]
 consume_skb+0xd2/0x170 net/core/skbuff.c:1271
 __unix_dgram_recvmsg+0x814/0xe50 net/unix/af_unix.c:2442
 unix_dgram_recvmsg+0xc3/0xf0 net/unix/af_unix.c:2459
 sock_recvmsg_nosec net/socket.c:1026 [inline]
 sock_recvmsg+0xe2/0x170 net/socket.c:1048
 sock_read_iter+0x2c3/0x3c0 net/socket.c:1118
 call_read_iter include/linux/fs.h:1977 [inline]
 do_iter_readv_writev+0x2f2/0x3c0 fs/read_write.c:733
 do_iter_read+0x315/0x870 fs/read_write.c:795
 vfs_readv+0x12d/0x1a0 fs/read_write.c:915
 do_readv+0x285/0x370 fs/read_write.c:952
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff888068778600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888068778680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888068778700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                            ^
 ffff888068778780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888068778800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         7271b2a5 Add linux-next specific files for 20230818
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=142e2cbda80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1936af09cdef7dd6
dashboard link: https://syzkaller.appspot.com/bug?extid=a0c80b06ae2cb8895bc4
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12838e5ba80000

