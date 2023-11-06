Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10227E27D4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 15:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjKFO5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 09:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbjKFO5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 09:57:09 -0500
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AA6B6
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 06:57:06 -0800 (PST)
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1e990f0629cso6506772fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 06:57:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699282626; x=1699887426;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ucnt0j9TaEOr9g8fzoeTJ50kltjx1K9hY66zLUAmMPQ=;
        b=NRS2Vzt3thq0Sj6Z7z4sxYtt0TmXvFRyZbrFTJQOy7B+TICcnzd2aQyX5q9Qo/KIsW
         Bz10HTALRr/NIuAQU+d3BH5phfOZLoR5hSD4c9+KniySuBZmqa6PhjfpU4aZ3XDIzzP/
         Ln7FFzjnoC8XWW6F2sffpli8I6LvyVZZIHfw2damxw8840VxLDiu37VpbPwvSHKCiuQ4
         dPj2/qMNEOaPt+/6IviJSTdvf6aKxC0usdew5zRb9OOZyg4QScLonHUDyeihTzCw1S2j
         i/SgxsUFievoDsvkk4wV6Fl/aH60dLfqUvHxZIw7K1Su89Cq5Lv03uhNe693xprb93aC
         toeg==
X-Gm-Message-State: AOJu0Yz2rnj5Uvh0vKJu3GvsRLQ8VqcGus1JMILHa+NQi6S5sxp23PLk
        vJvDD3wY5fPoLcqMe1OvUulIdX4uyXUIcX7jXNYMElU7j5uZ720=
X-Google-Smtp-Source: AGHT+IFtnMcLs16bgbo8YkQSjeh9oAqbDgkTtbsKPVf4cIE2gV0CeqGK6hbJbLtLvDewb+R2SrDS6FZNx5geMdbbDraEBHhC4F7R
MIME-Version: 1.0
X-Received: by 2002:a05:6870:71d0:b0:1d1:3ff8:9f80 with SMTP id
 p16-20020a05687071d000b001d13ff89f80mr13595690oag.8.1699282625931; Mon, 06
 Nov 2023 06:57:05 -0800 (PST)
Date:   Mon, 06 Nov 2023 06:57:05 -0800
In-Reply-To: <DB3PR10MB68359EFF4A40FF59B3ED54F6E8AAA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004ab16106097d11d4@google.com>
Subject: Re: [syzbot] [bluetooth?] general protection fault in
 l2cap_chan_timeout (3)
From:   syzbot <syzbot+f0908ddc8b64b86e81f2@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        yuran.pereira@hotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in l2cap_chan_timeout

==================================================================
BUG: KASAN: slab-use-after-free in __mutex_lock+0x6bc/0xd60 kernel/locking/mutex.c:197
Read of size 8 at addr ffff88806fdebb20 by task kworker/1:3/4986

CPU: 1 PID: 4986 Comm: kworker/1:3 Not tainted 6.6.0-syzkaller-14651-gd2f51b3516da #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
Workqueue: events l2cap_chan_timeout
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:475
 kasan_report+0x142/0x170 mm/kasan/report.c:588
 __mutex_lock+0x6bc/0xd60 kernel/locking/mutex.c:197
 l2cap_chan_timeout+0x5a/0x340 net/bluetooth/l2cap_core.c:438
 process_scheduled_works+0x90f/0x1400 kernel/workqueue.c:2630
 worker_thread+0xa5f/0xff0 kernel/workqueue.c:2784
 kthread+0x2cd/0x360 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>

Allocated by task 28939:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:383
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:721 [inline]
 l2cap_conn_add+0xb2/0xc10 net/bluetooth/l2cap_core.c:7845
 l2cap_chan_connect+0x61f/0xeb0 net/bluetooth/l2cap_core.c:8053
 l2cap_sock_connect+0x5b1/0x7f0 net/bluetooth/l2cap_sock.c:256
 __sys_connect+0x2db/0x310 net/socket.c:2050
 __do_sys_connect net/socket.c:2077 [inline]
 __se_sys_connect net/socket.c:2074 [inline]
 __x64_sys_connect+0x7a/0x90 net/socket.c:2074
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0xe0 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Freed by task 50:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 kasan_save_free_info+0x28/0x40 mm/kasan/generic.c:522
 ____kasan_slab_free+0xd6/0x120 mm/kasan/common.c:236
 kasan_slab_free include/linux/kasan.h:164 [inline]
 slab_free_hook mm/slub.c:1800 [inline]
 slab_free_freelist_hook mm/slub.c:1826 [inline]
 slab_free mm/slub.c:3809 [inline]
 __kmem_cache_free+0x263/0x3a0 mm/slub.c:3822
 l2cap_connect_cfm+0x121/0x1280 net/bluetooth/l2cap_core.c:8238
 hci_connect_cfm include/net/bluetooth/hci_core.h:1959 [inline]
 hci_conn_failed+0x1f2/0x340 net/bluetooth/hci_conn.c:1283
 hci_abort_conn_sync+0x57e/0xdd0 net/bluetooth/hci_sync.c:5424
 hci_cmd_sync_work+0x228/0x400 net/bluetooth/hci_sync.c:306
 process_scheduled_works+0x90f/0x1400 kernel/workqueue.c:2630
 worker_thread+0xa5f/0xff0 kernel/workqueue.c:2784
 kthread+0x2cd/0x360 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

Last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xad/0xc0 mm/kasan/generic.c:492
 kvfree_call_rcu+0xf8/0x790 kernel/rcu/tree.c:3386
 neigh_periodic_work+0x3c9/0xd50 net/core/neighbour.c:998
 process_scheduled_works+0x90f/0x1400 kernel/workqueue.c:2630
 worker_thread+0xa5f/0xff0 kernel/workqueue.c:2784
 kthread+0x2cd/0x360 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

The buggy address belongs to the object at ffff88806fdeb800
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 800 bytes inside of
 freed 1024-byte region [ffff88806fdeb800, ffff88806fdebc00)

The buggy address belongs to the physical page:
page:ffffea0001bf7a00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x6fde8
head:ffffea0001bf7a00 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888011441dc0 dead000000000100 dead000000000122
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d2820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 5332, tgid 5332 (syz-executor.2), ts 85495698484, free_ts 17157495338
 prep_new_page mm/page_alloc.c:1544 [inline]
 get_page_from_freelist+0x339a/0x3530 mm/page_alloc.c:3312
 __alloc_pages+0x255/0x670 mm/page_alloc.c:4568
 alloc_pages_mpol+0x3de/0x640 mm/mempolicy.c:2133
 alloc_slab_page+0x6a/0x160 mm/slub.c:1870
 new_slab+0x84/0x2f0 mm/slub.c:2017
 ___slab_alloc+0xc85/0x1310 mm/slub.c:3223
 __slab_alloc mm/slub.c:3322 [inline]
 __slab_alloc_node mm/slub.c:3375 [inline]
 slab_alloc_node mm/slub.c:3468 [inline]
 __kmem_cache_alloc_node+0x21d/0x300 mm/slub.c:3517
 __kmalloc_node_track_caller+0xa5/0x230 mm/slab_common.c:1006
 kmalloc_reserve+0xf3/0x260 net/core/skbuff.c:582
 __alloc_skb+0x1b1/0x420 net/core/skbuff.c:651
 alloc_skb include/linux/skbuff.h:1286 [inline]
 nlmsg_new include/net/netlink.h:1010 [inline]
 inet6_rt_notify+0xe0/0x290 net/ipv6/route.c:6171
 fib6_add+0x1e11/0x3f90 net/ipv6/ip6_fib.c:1257
 __ip6_ins_rt net/ipv6/route.c:1303 [inline]
 ip6_route_add+0x88/0x120 net/ipv6/route.c:3847
 addrconf_add_linklocal+0x616/0xa20 net/ipv6/addrconf.c:2445
 addrconf_addr_gen+0x804/0xb60
 addrconf_init_auto_addrs+0x974/0xec0 net/ipv6/addrconf.c:3440
page last free stack trace:
 free_unref_page_prepare+0x925/0xa40 include/linux/page_owner.h:24
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2487
 free_contig_range+0x9e/0x150 mm/page_alloc.c:6536
 destroy_args+0x8a/0x880 mm/debug_vm_pgtable.c:1028
 debug_vm_pgtable+0x4ba/0x540 mm/debug_vm_pgtable.c:1408
 do_one_initcall+0x234/0x800 init/main.c:1236
 do_initcall_level+0x157/0x210 init/main.c:1298
 do_initcalls+0x3f/0x80 init/main.c:1314
 kernel_init_freeable+0x429/0x5c0 init/main.c:1551
 kernel_init+0x1d/0x2a0 init/main.c:1441
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

Memory state around the buggy address:
 ffff88806fdeba00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88806fdeba80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88806fdebb00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                               ^
 ffff88806fdebb80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88806fdebc00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         d2f51b35 Merge tag 'rtc-6.7' of git://git.kernel.org/p..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=13b4b27b680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=394ba267563feefb
dashboard link: https://syzkaller.appspot.com/bug?extid=f0908ddc8b64b86e81f2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
