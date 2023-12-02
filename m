Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7A7801D60
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 15:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbjLBOhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 09:37:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjLBOg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 09:36:59 -0500
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F20D129
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 06:37:05 -0800 (PST)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1fafbf42404so2275247fac.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Dec 2023 06:37:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701527824; x=1702132624;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pZDXcJSRbGQRwJZ0YPEk/jTcyn2Fi5g3nq57TZSWdW4=;
        b=O/bnCSS+4f03UHq9G9xPGEX7EReWz46TRF6X8snV1dbWoqlFJMKI3pb+4jPgax9oqm
         6wHc7jBOB5NB+z2E7/OL8a2Oa/4SOe4vpXsiat8FmYRPivG5dDGnQLolkPhXdK1g2SXh
         QbE8GYT/uedVogyvjD3jmWyffqNG9mdzFbRbHkQ/WRAR+KxUbY0IOQx1efEZciRyr9Jb
         EgRqDmFbwn4l3e7sSF3zMC9S6ke8AWolJ/EU1vExDAXZx44v72igNL6EQBOHfV/dFAEQ
         Ji1OAvtHPKEOIYHSVziYrpC6s1hjuN5XuU+Xi1HGuNnDB2whnXaw0dQJuScJct5gOBRH
         THDg==
X-Gm-Message-State: AOJu0YxmRrI8HZvGbd/rnRGpeWwxRdQdQWvM0Ojjbl630pJHP2sz88Xg
        yMe6JPwkq71I7gbq69mbcE58TAOXfS5RxzGqfM6uyT0ETcTC
X-Google-Smtp-Source: AGHT+IHAgrcB4MuGVebZg+rKkpA7idxRHl8tpHGU/ocjnCWhILfV9rvCOY+aW1umuCDN7wG3NRuAROrEa340znu/sMW5+ztH9V4I
MIME-Version: 1.0
X-Received: by 2002:a05:6870:d60e:b0:1fa:fa54:1a6a with SMTP id
 a14-20020a056870d60e00b001fafa541a6amr702349oaq.6.1701527824494; Sat, 02 Dec
 2023 06:37:04 -0800 (PST)
Date:   Sat, 02 Dec 2023 06:37:04 -0800
In-Reply-To: <b4bc6554-6870-43fe-87df-1a2f947e6408@siddh.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008df3d7060b87d156@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KASAN: slab-use-after-free Read in nfc_alloc_send_skb
From:   syzbot <syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com>
To:     code@siddh.me, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

llcp: nfc_llcp_send_ui_frame: Could not allocate PDU (error=-6)
==================================================================
BUG: KASAN: slab-use-after-free in nfc_alloc_send_skb+0x149/0x1c0 net/nfc/core.c:722
Read of size 4 at addr ffff8880213d0548 by task syz-executor.0/5687

CPU: 0 PID: 5687 Comm: syz-executor.0 Not tainted 6.7.0-rc3-syzkaller-00686-g7453d7a633d0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:475
 kasan_report+0x142/0x170 mm/kasan/report.c:588
 nfc_alloc_send_skb+0x149/0x1c0 net/nfc/core.c:722
 nfc_llcp_send_ui_frame+0x2ac/0x670 net/nfc/llcp_commands.c:766
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0x592/0x890 net/socket.c:2584
 ___sys_sendmsg net/socket.c:2638 [inline]
 __sys_sendmmsg+0x3b2/0x730 net/socket.c:2724
 __do_sys_sendmmsg net/socket.c:2753 [inline]
 __se_sys_sendmmsg net/socket.c:2750 [inline]
 __x64_sys_sendmmsg+0xa0/0xb0 net/socket.c:2750
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fa12c27cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa12d00b0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 00007fa12c39bf80 RCX: 00007fa12c27cae9
RDX: 0000000000000001 RSI: 00000000200013c0 RDI: 0000000000000004
RBP: 00007fa12c2c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fa12c39bf80 R15: 00007ffd319ae358
 </TASK>

Allocated by task 5687:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:383
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:721 [inline]
 nfc_allocate_device+0x12f/0x520 net/nfc/core.c:1065
 nci_allocate_device+0x1e2/0x360 net/nfc/nci/core.c:1179
 virtual_ncidev_open+0x75/0x1b0 drivers/nfc/virtual_ncidev.c:141
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

Freed by task 5686:
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
 virtual_ncidev_close+0x70/0x90 drivers/nfc/virtual_ncidev.c:169
 __fput+0x3cc/0xa10 fs/file_table.c:394
 __do_sys_close fs/open.c:1590 [inline]
 __se_sys_close+0x15f/0x220 fs/open.c:1575
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xad/0xc0 mm/kasan/generic.c:492
 __call_rcu_common kernel/rcu/tree.c:2681 [inline]
 call_rcu+0x167/0xa70 kernel/rcu/tree.c:2795
 netlink_release+0x162a/0x1b00 net/netlink/af_netlink.c:831
 __sock_release net/socket.c:659 [inline]
 sock_close+0xb8/0x230 net/socket.c:1419
 __fput+0x3cc/0xa10 fs/file_table.c:394
 task_work_run+0x24a/0x300 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa34/0x2750 kernel/exit.c:871
 do_group_exit+0x206/0x2c0 kernel/exit.c:1021
 __do_sys_exit_group kernel/exit.c:1032 [inline]
 __se_sys_exit_group kernel/exit.c:1030 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1030
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

The buggy address belongs to the object at ffff8880213d0000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 1352 bytes inside of
 freed 2048-byte region [ffff8880213d0000, ffff8880213d0800)

The buggy address belongs to the physical page:
page:ffffea000084f400 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x213d0
head:ffffea000084f400 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888012c42000 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000080008 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 4501, tgid 4501 (udevd), ts 68833145467, free_ts 66934106075
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1e6/0x210 mm/page_alloc.c:1544
 prep_new_page mm/page_alloc.c:1551 [inline]
 get_page_from_freelist+0x339a/0x3530 mm/page_alloc.c:3319
 __alloc_pages+0x255/0x670 mm/page_alloc.c:4575
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
 __kmalloc+0xa8/0x230 mm/slab_common.c:1020
 kmalloc include/linux/slab.h:604 [inline]
 sk_prot_alloc+0xe0/0x210 net/core/sock.c:2075
 sk_alloc+0x38/0x370 net/core/sock.c:2128
 __netlink_create+0x6b/0x2c0 net/netlink/af_netlink.c:647
 netlink_create+0x3d4/0x590 net/netlink/af_netlink.c:712
 __sock_create+0x48c/0x910 net/socket.c:1569
 sock_create net/socket.c:1620 [inline]
 __sys_socket_create net/socket.c:1657 [inline]
 __sys_socket+0x14f/0x3b0 net/socket.c:1704
 __do_sys_socket net/socket.c:1718 [inline]
 __se_sys_socket net/socket.c:1716 [inline]
 __x64_sys_socket+0x7a/0x90 net/socket.c:1716
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1144 [inline]
 free_unref_page_prepare+0x958/0xa70 mm/page_alloc.c:2354
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2494
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
 slab_alloc mm/slub.c:3486 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
 kmem_cache_alloc+0x1be/0x350 mm/slub.c:3502
 getname_flags+0xbc/0x4f0 fs/namei.c:140
 vfs_fstatat+0x11c/0x190 fs/stat.c:298
 __do_sys_newfstatat fs/stat.c:463 [inline]
 __se_sys_newfstatat fs/stat.c:457 [inline]
 __x64_sys_newfstatat+0x117/0x190 fs/stat.c:457
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Memory state around the buggy address:
 ffff8880213d0400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880213d0480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880213d0500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                              ^
 ffff8880213d0580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880213d0600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         7453d7a6 nfp: ethtool: expose transmit SO_TIMESTAMPING..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main
console output: https://syzkaller.appspot.com/x/log.txt?x=136fe752e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=94286555cac4ea49
dashboard link: https://syzkaller.appspot.com/bug?extid=bbe84a4010eeea00982d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
