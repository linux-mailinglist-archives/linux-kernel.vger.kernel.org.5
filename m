Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FED17E8004
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235602AbjKJSDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:03:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235777AbjKJSCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:02:44 -0500
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1BB31E73
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 03:56:06 -0800 (PST)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2802c0b610dso2132260a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 03:56:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699617366; x=1700222166;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QieGfk+d2SGlwwhOgF2NGDkotoidc4rhn4869gUqaCE=;
        b=NOhbfKB2xFJxqpqJDvroU5gamXx5eiOz45dCVmvk0EBso9U+92aZ5+SQ3C4YfR6FxR
         /DG0ZLkcE1930NafAG2cOnZ4w5o5bthKmrzAma9DxVjYFM4sSzUVqGV780hPdYB2rTGN
         Vt04c5z+MMFMkmL7/6Ceo775c26v/AeUMNsybMd0Vzk1TYk3SZTazN6zUT/OMzqLgGI5
         I5FescZTJZ5dfiPxhIE+rzt4/UkEdoAV7iNatuK+5QNTSZHyqVrjSCE3ezABWeKxxryq
         M59HO5H3pCi4f5bL7XC4Yzi3VE3rj4o27hi7blw4jNSI6TIEEUTQmfkRdPgDvISzC09r
         j2PQ==
X-Gm-Message-State: AOJu0Yy320zF7zqydqOHdOtP9PIeaH1rAhrnISDybYPKumZX886Cb1CM
        uTaNurpQJUATDJYu7htVQSR8RuZ9P1X761UHsVuj6xo1VGqe
X-Google-Smtp-Source: AGHT+IFwvmI6n9KrZNTLZZYhyXmY/kv3vN4A6dZ4DRP/4HKeCKPVylnZL4vh7skIaWSl/Oe/A+OTaeDeWdNxeJy7LSFYU8n4K20Q
MIME-Version: 1.0
X-Received: by 2002:a17:90a:e398:b0:27d:c90:1718 with SMTP id
 b24-20020a17090ae39800b0027d0c901718mr1139073pjz.7.1699617365808; Fri, 10 Nov
 2023 03:56:05 -0800 (PST)
Date:   Fri, 10 Nov 2023 03:56:05 -0800
In-Reply-To: <tencent_86284A9674717691670C3DBF360C96CA3609@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000057dfda0609cb0148@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KASAN: slab-use-after-free Read in nfc_alloc_send_skb
From:   syzbot <syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in nfc_alloc_send_skb

finded: ffff888028181000, d: ffff888028182000, nfc_llcp_send_ui_frame
finded: ffff888028181000, d: ffff888028182000, nfc_llcp_send_ui_frame
finded: ffff888028181000, d: ffff888028182000, nfc_llcp_send_ui_frame
==================================================================
BUG: KASAN: slab-use-after-free in nfc_alloc_send_skb+0x189/0x1c0 net/nfc/core.c:726
Read of size 4 at addr ffff888028182548 by task syz-executor.0/5582

CPU: 0 PID: 5582 Comm: syz-executor.0 Not tainted 6.6.0-syzkaller-14263-gaea6bf908d73-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:475
 kasan_report+0x142/0x170 mm/kasan/report.c:588
 nfc_alloc_send_skb+0x189/0x1c0 net/nfc/core.c:726
 nfc_llcp_send_ui_frame+0x2e7/0x6b0 net/nfc/llcp_commands.c:767
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0x592/0x890 net/socket.c:2588
 ___sys_sendmsg net/socket.c:2642 [inline]
 __sys_sendmmsg+0x3b2/0x730 net/socket.c:2728
 __do_sys_sendmmsg net/socket.c:2757 [inline]
 __se_sys_sendmmsg net/socket.c:2754 [inline]
 __x64_sys_sendmmsg+0xa0/0xb0 net/socket.c:2754
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f675dc7cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f675e9120c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 00007f675dd9bf80 RCX: 00007f675dc7cae9
RDX: 0000000000000001 RSI: 00000000200013c0 RDI: 0000000000000004
RBP: 00007f675dcc847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f675dd9bf80 R15: 00007ffcae207c28
 </TASK>

Allocated by task 5582:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:383
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:721 [inline]
 nfc_allocate_device+0x12f/0x520 net/nfc/core.c:1065
 nci_allocate_device+0x1e2/0x360 net/nfc/nci/core.c:1179
 virtual_ncidev_open+0x75/0x1b0 drivers/nfc/virtual_ncidev.c:136
 misc_open+0x30b/0x380 drivers/char/misc.c:165
 chrdev_open+0x5ab/0x630 fs/char_dev.c:414
 do_dentry_open+0x8fd/0x1590 fs/open.c:948
 do_open fs/namei.c:3622 [inline]
 path_openat+0x2845/0x3280 fs/namei.c:3779
 do_filp_open+0x234/0x490 fs/namei.c:3809
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1440
 do_sys_open fs/open.c:1455 [inline]
 __do_sys_openat fs/open.c:1471 [inline]
 __se_sys_openat fs/open.c:1466 [inline]
 __x64_sys_openat+0x247/0x290 fs/open.c:1466
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Freed by task 5580:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 kasan_save_free_info+0x28/0x40 mm/kasan/generic.c:522
 ____kasan_slab_free+0xd6/0x120 mm/kasan/common.c:236
 kasan_slab_free include/linux/kasan.h:164 [inline]
 slab_free_hook mm/slub.c:1800 [inline]
 slab_free_freelist_hook mm/slub.c:1826 [inline]
 slab_free mm/slub.c:3809 [inline]
 __kmem_cache_free+0x263/0x3a0 mm/slub.c:3822
 device_release+0x95/0x1c0
 kobject_cleanup lib/kobject.c:682 [inline]
 kobject_release lib/kobject.c:716 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1ee/0x430 lib/kobject.c:733
 nfc_free_device include/net/nfc/nfc.h:213 [inline]
 nci_free_device+0x38/0x50 net/nfc/nci/core.c:1209
 virtual_ncidev_close+0x70/0x90 drivers/nfc/virtual_ncidev.c:164
 __fput+0x3cc/0xa10 fs/file_table.c:394
 __do_sys_close fs/open.c:1590 [inline]
 __se_sys_close+0x15f/0x220 fs/open.c:1575
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

The buggy address belongs to the object at ffff888028182000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 1352 bytes inside of
 freed 2048-byte region [ffff888028182000, ffff888028182800)

The buggy address belongs to the physical page:
page:ffffea0000a06000 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888028184000 pfn:0x28180
head:ffffea0000a06000 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888012c42000 ffffea00004fa000 dead000000000002
raw: ffff888028184000 0000000080080007 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 2846, tgid 2846 (kworker/u4:8), ts 65808136046, free_ts 65805408929
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1e6/0x210 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1544 [inline]
 get_page_from_freelist+0x339a/0x3530 mm/page_alloc.c:3312
 __alloc_pages+0x255/0x670 mm/page_alloc.c:4568
 alloc_pages_mpol+0x3de/0x640 mm/mempolicy.c:2133
 alloc_slab_page+0x6a/0x160 mm/slub.c:1870
 allocate_slab mm/slub.c:2017 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2070
 ___slab_alloc+0xc85/0x1310 mm/slub.c:3223
 __slab_alloc mm/slub.c:3322 [inline]
 __slab_alloc_node mm/slub.c:3375 [inline]
 slab_alloc_node mm/slub.c:3468 [inline]
 __kmem_cache_alloc_node+0x21d/0x300 mm/slub.c:3517
 __do_kmalloc_node mm/slab_common.c:1006 [inline]
 __kmalloc_node_track_caller+0xa5/0x230 mm/slab_common.c:1027
 kmalloc_reserve+0xf3/0x260 net/core/skbuff.c:582
 __alloc_skb+0x1b1/0x420 net/core/skbuff.c:651
 alloc_skb include/linux/skbuff.h:1286 [inline]
 nlmsg_new include/net/netlink.h:1010 [inline]
 rtmsg_ifinfo_build_skb+0x89/0x280 net/core/rtnetlink.c:4067
 unregister_netdevice_many_notify+0xe2a/0x1710 net/core/dev.c:10987
 unregister_netdevice_many net/core/dev.c:11039 [inline]
 default_device_exit_batch+0x5c4/0x630 net/core/dev.c:11508
 ops_exit_list net/core/net_namespace.c:175 [inline]
 cleanup_net+0x767/0xb80 net/core/net_namespace.c:614
 process_one_work kernel/workqueue.c:2630 [inline]
 process_scheduled_works+0x90f/0x1400 kernel/workqueue.c:2703
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1137 [inline]
 free_unref_page_prepare+0x92a/0xa50 mm/page_alloc.c:2347
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2487
 discard_slab mm/slub.c:2116 [inline]
 __unfreeze_partials+0x1dc/0x220 mm/slub.c:2655
 put_cpu_partial+0x17b/0x250 mm/slub.c:2731
 __slab_free+0x2b6/0x390 mm/slub.c:3679
 qlink_free mm/kasan/quarantine.c:168 [inline]
 qlist_free_all+0x75/0xe0 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x14b/0x160 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x23/0x70 mm/kasan/common.c:305
 kasan_slab_alloc include/linux/kasan.h:188 [inline]
 slab_post_alloc_hook+0x6c/0x3c0 mm/slab.h:763
 slab_alloc_node mm/slub.c:3478 [inline]
 kmem_cache_alloc_node+0x1ad/0x3a0 mm/slub.c:3523
 __alloc_skb+0x181/0x420 net/core/skbuff.c:641
 alloc_skb include/linux/skbuff.h:1286 [inline]
 nlmsg_new include/net/netlink.h:1010 [inline]
 inet_netconf_notify_devconf+0x15a/0x220 net/ipv4/devinet.c:2122
 __devinet_sysctl_unregister net/ipv4/devinet.c:2634 [inline]
 devinet_sysctl_unregister net/ipv4/devinet.c:2658 [inline]
 inetdev_destroy net/ipv4/devinet.c:328 [inline]
 inetdev_event+0x858/0x15b0 net/ipv4/devinet.c:1623
 notifier_call_chain+0x18c/0x3a0 kernel/notifier.c:93
 call_netdevice_notifiers_extack net/core/dev.c:2003 [inline]
 call_netdevice_notifiers net/core/dev.c:2017 [inline]
 unregister_netdevice_many_notify+0xd87/0x1710 net/core/dev.c:10983
 unregister_netdevice_many net/core/dev.c:11039 [inline]
 default_device_exit_batch+0x5c4/0x630 net/core/dev.c:11508

Memory state around the buggy address:
 ffff888028182400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888028182480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888028182500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                              ^
 ffff888028182580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888028182600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         aea6bf90 Merge tag 'f2fs-for-6.7-rc1' of git://git.ker..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1251b347680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=93ac5233c138249e
dashboard link: https://syzkaller.appspot.com/bug?extid=bbe84a4010eeea00982d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16347338e80000

