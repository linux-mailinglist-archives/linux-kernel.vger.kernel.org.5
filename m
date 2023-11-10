Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A0F7E8278
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346398AbjKJTYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346308AbjKJTYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:24:14 -0500
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770B025A11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 01:57:05 -0800 (PST)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-280740f54b9so1806500a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 01:57:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699610225; x=1700215025;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uElrfL99man08MaXfRjAUPkmHhlLuvhOq09CZVDePPk=;
        b=pSUldosqhpBkU4sNkG1z3L7uQUmtwK9C1O33TwNH/lo/rvZKGYiihcgC/JQdY8hovB
         vUKkS9PKh2eGsf3a5SasWzWdNO//XnO5KLD4sZPgLfS6RExO6QO2Oif1BFSXi2ALoHLl
         RVcvY4El5bPuEs2lJPTfnjQGAvKgGpQn4xgHJzclBd6Ilv9jn82/i6Qkwb6i4/YWxbcY
         KbsZZjzbEcAjeh/Y4tLZs+yXNu2vfbKNFYMhdRYuw8i7T/H96M+OlMn/DlAlBrDuo7ny
         dOmbxYrJ8M4SSGAENjUfUpCLuHdyJYMgvtJ07RBMKsBWPYNhpctceg74O6zZvMxW3bav
         MPEA==
X-Gm-Message-State: AOJu0YzeDnWqFgzRO5pnkxO44de1znFnh4mCcpSvMF8h1Ti20LZPcRn8
        8csDdR0eD2AJrBjFjxi9BlC+vcZgizfxPBgPkUOFkPEdX/lQOBU=
X-Google-Smtp-Source: AGHT+IHZgB8TBn84+deYrDwbV4qgAsho7MvIKInZTW3oomBLKcXD/g5pRu9JAfO/8V+MOMfSpsX8gDl8Dnqn3TEUFBZywYvFVFkN
MIME-Version: 1.0
X-Received: by 2002:a17:90b:3b47:b0:280:27a9:76bb with SMTP id
 ot7-20020a17090b3b4700b0028027a976bbmr1110719pjb.9.1699610224976; Fri, 10 Nov
 2023 01:57:04 -0800 (PST)
Date:   Fri, 10 Nov 2023 01:57:04 -0800
In-Reply-To: <20231110063236.964222-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b76b5f0609c957b7@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KASAN: slab-use-after-free Read in nfc_alloc_send_skb
From:   syzbot <syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, lizhi.xu@windriver.com,
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

finded: ffff8880294a4000, d: ffff8880294a2000, nfc_llcp_find_local
finded: ffff8880294a4000, d: ffff8880294a2000, nfc_llcp_find_local
finded: ffff8880294a4000, d: ffff8880294a2000, nfc_llcp_find_local
==================================================================
BUG: KASAN: slab-use-after-free in nfc_alloc_send_skb+0x189/0x1c0 net/nfc/core.c:726
Read of size 4 at addr ffff8880294a2548 by task syz-executor.0/6008

CPU: 0 PID: 6008 Comm: syz-executor.0 Not tainted 6.6.0-syzkaller-14263-gaea6bf908d73-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:475
 kasan_report+0x142/0x170 mm/kasan/report.c:588
 nfc_alloc_send_skb+0x189/0x1c0 net/nfc/core.c:726
 nfc_llcp_send_ui_frame+0x2a6/0x670 net/nfc/llcp_commands.c:766
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
RIP: 0033:0x7ff34a27cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff34af4f0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 00007ff34a39bf80 RCX: 00007ff34a27cae9
RDX: 0000000000000001 RSI: 00000000200013c0 RDI: 0000000000000004
RBP: 00007ff34a2c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007ff34a39bf80 R15: 00007ffefd720258
 </TASK>

Allocated by task 6008:
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

Freed by task 6007:
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

The buggy address belongs to the object at ffff8880294a2000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 1352 bytes inside of
 freed 2048-byte region [ffff8880294a2000, ffff8880294a2800)

The buggy address belongs to the physical page:
page:ffffea0000a52800 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x294a0
head:ffffea0000a52800 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888012c42000 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000080008 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 48, tgid 48 (kworker/u4:3), ts 69435126753, free_ts 69431633156
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
 rtmsg_ifa+0x1f0/0x3b0 net/ipv4/devinet.c:1927
 __inet_del_ifa+0x86a/0x1020 net/ipv4/devinet.c:431
 inet_del_ifa net/ipv4/devinet.c:469 [inline]
 inetdev_destroy net/ipv4/devinet.c:322 [inline]
 inetdev_event+0x682/0x15b0 net/ipv4/devinet.c:1623
 notifier_call_chain+0x18c/0x3a0 kernel/notifier.c:93
 call_netdevice_notifiers_extack net/core/dev.c:2003 [inline]
 call_netdevice_notifiers net/core/dev.c:2017 [inline]
 unregister_netdevice_many_notify+0xd87/0x1710 net/core/dev.c:10983

Memory state around the buggy address:
 ffff8880294a2400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880294a2480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880294a2500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                              ^
 ffff8880294a2580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880294a2600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         aea6bf90 Merge tag 'f2fs-for-6.7-rc1' of git://git.ker..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1786a8fb680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=93ac5233c138249e
dashboard link: https://syzkaller.appspot.com/bug?extid=bbe84a4010eeea00982d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1358ef87680000

