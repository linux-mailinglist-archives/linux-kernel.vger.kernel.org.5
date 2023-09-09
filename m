Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1AE0799662
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 07:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239929AbjIIFCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 01:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237883AbjIIFCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 01:02:31 -0400
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10C6F5
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 22:02:26 -0700 (PDT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1bde8160fbdso39453865ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 22:02:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694235746; x=1694840546;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HIikoWI7pbIU7ojwBE0RGvIykBvrlPp+hl1KTlYOGMw=;
        b=UDaG8MIDSfnj3isGTlUYdQi7HA4Qnw5AfLS6SOx8OZn/3V/uljLIyXYESHaMrcx90w
         0IUMkv58XAkZQmO2WLIPVx0bTOADjOySB5+Sb3hI8/YW5q0l4A8uCgn8Q3n1H3p2KzYx
         NAo7dbW1NGa0/ZdNt+EEbkjojX1V96BmhljLSJQ4/Zq0KNXt26YzlV/FbRAp35CoRgsW
         Hbz/RmMOai7kBzZfRiDf32OoPZoKt7CS4djsShMdnlkZc92M++k1vs3/P2Na2bIb/TwZ
         d69JK/x2WMu5oGClDezgvR0epcu4HFdjut1biO7bvDuQ1tw+77OXQNmocyxcs+A53toR
         pWXQ==
X-Gm-Message-State: AOJu0YxghI+R6KlrrdPsY97uGXAhJwoNms6H0cBl0erl7uFejKjtCPCW
        61G6Y6QK/60LB6IvkCkQFnbdhR6FR9eVc6xgDlwgyrfS9Z9w
X-Google-Smtp-Source: AGHT+IH49+qMoWbX/VfmLqmCL84X0C+nL29jyFptOI+eoXu+qsGiXgvhCMyFkX3N9F1ogvDLUx1Lie6PULsa2HkV/Jk2IEIqFk7s
MIME-Version: 1.0
X-Received: by 2002:a17:902:d489:b0:1bc:e6a:205e with SMTP id
 c9-20020a170902d48900b001bc0e6a205emr1656244plg.5.1694235746166; Fri, 08 Sep
 2023 22:02:26 -0700 (PDT)
Date:   Fri, 08 Sep 2023 22:02:26 -0700
In-Reply-To: <20230909040639.5886-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d0edc90604e5ff52@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in team_device_event
From:   syzbot <syzbot+44ae022028805f4600fc@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-out-of-bounds Read in team_device_event

8021q: adding VLAN 0 to HW filter on device bond1
team0: Device bond1 failed to register rx_handler
==================================================================
BUG: KASAN: slab-out-of-bounds in team_device_event+0xba3/0xe40 drivers/net/team/team.c:3002
Read of size 4 at addr ffff888016f42910 by task syz-executor.0/5633

CPU: 1 PID: 5633 Comm: syz-executor.0 Not tainted 6.5.0-syzkaller-04043-gf8fdd54ee6a1-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 team_device_event+0xba3/0xe40 drivers/net/team/team.c:3002
 notifier_call_chain+0xb6/0x3b0 kernel/notifier.c:93
 call_netdevice_notifiers_info+0xb9/0x130 net/core/dev.c:1970
 __netdev_upper_dev_unlink+0x111/0x430 net/core/dev.c:7799
 netdev_upper_dev_unlink+0x84/0xb0 net/core/dev.c:7831
 team_upper_dev_unlink drivers/net/team/team.c:1126 [inline]
 team_port_add drivers/net/team/team.c:1316 [inline]
 team_add_slave+0x1849/0x2310 drivers/net/team/team.c:1977
 do_set_master+0x1bc/0x220 net/core/rtnetlink.c:2674
 do_setlink+0xa07/0x3fa0 net/core/rtnetlink.c:2873
 __rtnl_newlink+0xc1d/0x1940 net/core/rtnetlink.c:3671
 rtnl_newlink+0x67/0xa0 net/core/rtnetlink.c:3718
 rtnetlink_rcv_msg+0x439/0xd30 net/core/rtnetlink.c:6444
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2545
 netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
 netlink_unicast+0x536/0x810 net/netlink/af_netlink.c:1368
 netlink_sendmsg+0x93c/0xe40 net/netlink/af_netlink.c:1910
 sock_sendmsg_nosec net/socket.c:728 [inline]
 sock_sendmsg+0xd9/0x180 net/socket.c:751
 ____sys_sendmsg+0x6ac/0x940 net/socket.c:2539
 ___sys_sendmsg+0x135/0x1d0 net/socket.c:2593
 __sys_sendmsg+0x117/0x1e0 net/socket.c:2622
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f9a4087cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9a415690c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f9a4099bf80 RCX: 00007f9a4087cae9
RDX: 0000000000000000 RSI: 0000000020000080 RDI: 0000000000000007
RBP: 00007f9a408c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f9a4099bf80 R15: 00007ffc4b5304d8
 </TASK>

Allocated by task 5633:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
 kmalloc include/linux/slab.h:582 [inline]
 kzalloc include/linux/slab.h:703 [inline]
 apparmor_sk_alloc_security+0x87/0x150 security/apparmor/lsm.c:828
 security_sk_alloc+0x72/0xb0 security/security.c:4386
 sk_prot_alloc+0x1c3/0x2a0 net/core/sock.c:2093
 sk_alloc+0x3a/0x7f0 net/core/sock.c:2143
 __netlink_create+0x63/0x380 net/netlink/af_netlink.c:647
 netlink_create+0x3dc/0x670 net/netlink/af_netlink.c:712
 __sock_create+0x334/0x810 net/socket.c:1550
 sock_create net/socket.c:1601 [inline]
 __sys_socket_create net/socket.c:1638 [inline]
 __sys_socket+0x14c/0x260 net/socket.c:1689
 __do_sys_socket net/socket.c:1703 [inline]
 __se_sys_socket net/socket.c:1701 [inline]
 __x64_sys_socket+0x72/0xb0 net/socket.c:1701
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888016f42900
 which belongs to the cache kmalloc-16 of size 16
The buggy address is located 0 bytes to the right of
 allocated 16-byte region [ffff888016f42900, ffff888016f42910)

The buggy address belongs to the physical page:
page:ffffea00005bd080 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x16f42
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000200 ffff8880128413c0 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080800080 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY), pid 5391, tgid 5391 (syz-executor.0), ts 94696443415, free_ts 94682336522
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2d2/0x350 mm/page_alloc.c:1570
 prep_new_page mm/page_alloc.c:1577 [inline]
 get_page_from_freelist+0x10a9/0x31e0 mm/page_alloc.c:3221
 __alloc_pages+0x1d0/0x4a0 mm/page_alloc.c:4477
 __alloc_pages_node include/linux/gfp.h:237 [inline]
 alloc_slab_page mm/slub.c:1864 [inline]
 allocate_slab+0xa1/0x380 mm/slub.c:2009
 new_slab mm/slub.c:2062 [inline]
 ___slab_alloc+0x8bc/0x1570 mm/slub.c:3215
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3314
 __slab_alloc_node mm/slub.c:3367 [inline]
 slab_alloc_node mm/slub.c:3460 [inline]
 __kmem_cache_alloc_node+0x137/0x350 mm/slub.c:3509
 __do_kmalloc_node mm/slab_common.c:984 [inline]
 __kmalloc_node+0x4f/0x100 mm/slab_common.c:992
 kmalloc_node include/linux/slab.h:602 [inline]
 kvmalloc_node+0x99/0x1a0 mm/util.c:604
 xt_jumpstack_alloc net/netfilter/x_tables.c:1354 [inline]
 xt_replace_table+0x1ea/0x940 net/netfilter/x_tables.c:1393
 __do_replace+0x1d5/0x9c0 net/ipv4/netfilter/arp_tables.c:912
 do_replace net/ipv6/netfilter/ip6_tables.c:1154 [inline]
 do_ip6t_set_ctl+0x93a/0xbd0 net/ipv6/netfilter/ip6_tables.c:1636
 nf_setsockopt+0x87/0xe0 net/netfilter/nf_sockopt.c:101
 ipv6_setsockopt+0x12b/0x190 net/ipv6/ipv6_sockglue.c:1017
 tcp_setsockopt+0x9d/0x100 net/ipv4/tcp.c:3680
 __sys_setsockopt+0x2cd/0x5b0 net/socket.c:2306
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1161 [inline]
 free_unref_page_prepare+0x508/0xb90 mm/page_alloc.c:2348
 free_unref_page_list+0xe6/0xb30 mm/page_alloc.c:2489
 release_pages+0x32a/0x14e0 mm/swap.c:1042
 tlb_batch_pages_flush+0x9a/0x190 mm/mmu_gather.c:97
 tlb_flush_mmu_free mm/mmu_gather.c:292 [inline]
 tlb_flush_mmu mm/mmu_gather.c:299 [inline]
 tlb_finish_mmu+0x14b/0x7e0 mm/mmu_gather.c:391
 exit_mmap+0x2db/0x960 mm/mmap.c:3215
 __mmput+0x12a/0x4d0 kernel/fork.c:1356
 mmput+0x62/0x70 kernel/fork.c:1378
 exit_mm kernel/exit.c:567 [inline]
 do_exit+0x9b4/0x2a20 kernel/exit.c:861
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1024
 get_signal+0x23ea/0x2770 kernel/signal.c:2881
 arch_do_signal_or_restart+0x89/0x5f0 arch/x86/kernel/signal.c:308
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x1d/0x60 kernel/entry/common.c:296
 do_syscall_64+0x44/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff888016f42800: 00 00 fc fc 00 00 fc fc 00 01 fc fc 00 01 fc fc
 ffff888016f42880: 00 01 fc fc 00 07 fc fc 00 04 fc fc 00 00 fc fc
>ffff888016f42900: 00 00 fc fc 00 00 fc fc 00 04 fc fc 00 04 fc fc
                         ^
 ffff888016f42980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888016f42a00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         f8fdd54e Merge branch 'sja1105-fixes'
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16688684680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=634e05b4025da9da
dashboard link: https://syzkaller.appspot.com/bug?extid=44ae022028805f4600fc
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=120c0278680000

