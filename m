Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFED279961C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 05:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236353AbjIIDge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 23:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjIIDgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 23:36:33 -0400
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A6F1FE3
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 20:36:29 -0700 (PDT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1c0d58f127fso37985655ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 20:36:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694230588; x=1694835388;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=51M7UAOPqAiqM8T9BCdBrH1s9dkMbXDZvn1Oz3KUj/o=;
        b=iRtBcRi51elY36SqtT95QrgmLiKtfb9LOd70IMBQtGfyxDbPt2fdJ6dEKHHrpfUxKz
         siKRztznN/+ji8kWBoQovWmmK+LDsiuQmw1PamJyD7Ku44V2Ux5kCtTcLvPhU7a2tqyD
         DcVQYeHJRbWKCbOZ8mDbyBlj2sWigBKqY/zxLefV1w6kP66yUxqswWvAJT9sXIdXCpul
         Y+WuobRhRWUO7NrQTLKru5xqFnid4XxN6F74mWDM1vjo8Goscyw9BeM9bKwKWaAicKjM
         G8jWEF9QD+s9X8iG10N0Wx+GFHZBaAD56GnC7Mt3vQhtcI6QkouF/tTx91aHkhG5WECh
         GNxA==
X-Gm-Message-State: AOJu0Yz7j59ja5Fq1y3DEpsFQX51IgjnYTXmX/7SO9F1i0gn9R731h96
        lB0Yujnd7OFvV4xsnu8h02lL4UK48Zs+LR7g3lZ31XTBq3lO
X-Google-Smtp-Source: AGHT+IG9EuqCYo1wk7DuTNPNFjw7Nn/aAkOvEaV0m9lBphrTEO3O+llKynoRhZLPNBiunHtJ7haIgANLtts+ncH85zSAq9OSqlCL
MIME-Version: 1.0
X-Received: by 2002:a17:902:c649:b0:1c3:2af5:19e5 with SMTP id
 s9-20020a170902c64900b001c32af519e5mr1339748pls.4.1694230588667; Fri, 08 Sep
 2023 20:36:28 -0700 (PDT)
Date:   Fri, 08 Sep 2023 20:36:28 -0700
In-Reply-To: <20230909025602.5753-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000067bd600604e4cc0a@google.com>
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
KASAN: slab-use-after-free Read in team_device_event

8021q: adding VLAN 0 to HW filter on device bond1
==================================================================
BUG: KASAN: slab-use-after-free in team_device_event+0xa3b/0xad0 drivers/net/team/team.c:3024
Read of size 8 at addr ffff888055dd5b88 by task syz-executor408/19067

CPU: 0 PID: 19067 Comm: syz-executor408 Not tainted 6.5.0-syzkaller-04043-gf8fdd54ee6a1-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 team_device_event+0xa3b/0xad0 drivers/net/team/team.c:3024
 notifier_call_chain+0xb6/0x3b0 kernel/notifier.c:93
 call_netdevice_notifiers_info+0xb9/0x130 net/core/dev.c:1970
 call_netdevice_notifiers_extack net/core/dev.c:2008 [inline]
 call_netdevice_notifiers net/core/dev.c:2022 [inline]
 netdev_features_change net/core/dev.c:1333 [inline]
 netdev_update_features net/core/dev.c:9874 [inline]
 netdev_update_features net/core/dev.c:9871 [inline]
 dev_disable_lro+0x224/0x3e0 net/core/dev.c:1606
 team_port_add drivers/net/team/team.c:1249 [inline]
 team_add_slave+0x1c53/0x2560 drivers/net/team/team.c:1980
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
RIP: 0033:0x7f1732fde5d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 d1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff2a8f2868 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f1732fde5d9
RDX: 0000000000000000 RSI: 0000000020000080 RDI: 0000000000000007
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Allocated by task 18103:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:196 [inline]
 __do_kmalloc_node mm/slab_common.c:985 [inline]
 __kmalloc_node_track_caller+0x5e/0x100 mm/slab_common.c:1005
 kstrdup+0x3c/0x70 mm/util.c:62
 kstrdup_const+0x5f/0x70 mm/util.c:85
 kvasprintf_const+0x10b/0x190 lib/kasprintf.c:48
 kobject_set_name_vargs+0x5a/0x130 lib/kobject.c:267
 dev_set_name+0xc8/0x100 drivers/base/core.c:3429
 netdev_register_kobject+0xc1/0x3f0 net/core/net-sysfs.c:2031
 register_netdevice+0xbcb/0x1490 net/core/dev.c:10136
 macsec_newlink+0x4ca/0x1a30 drivers/net/macsec.c:4079
 rtnl_newlink_create net/core/rtnetlink.c:3485 [inline]
 __rtnl_newlink+0x1177/0x1940 net/core/rtnetlink.c:3705
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

The buggy address belongs to the object at ffff888055dd5b80
 which belongs to the cache kmalloc-16 of size 16
The buggy address is located 8 bytes inside of
 freed 16-byte region [ffff888055dd5b80, ffff888055dd5b90)

The buggy address belongs to the physical page:
page:ffffea0001577540 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x55dd5
anon flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000200 ffff8880128413c0 0000000000000000 dead000000000001
raw: 0000000000000000 0000000080800080 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY), pid 5390, tgid 5390 (syz-executor.0), ts 134688220071, free_ts 134681893991
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
 ffff888055dd5a80: fa fb fc fc fa fb fc fc 00 00 fc fc fb fb fc fc
 ffff888055dd5b00: fb fb fc fc 00 04 fc fc fb fb fc fc 00 00 fc fc
>ffff888055dd5b80: fb fb fc fc fb fb fc fc fb fb fc fc fb fb fc fc
                      ^
 ffff888055dd5c00: fb fb fc fc fb fb fc fc fb fb fc fc fa fb fc fc
 ffff888055dd5c80: fa fb fc fc fb fb fc fc fb fb fc fc fb fb fc fc
==================================================================


Tested on:

commit:         f8fdd54e Merge branch 'sja1105-fixes'
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
console output: https://syzkaller.appspot.com/x/log.txt?x=138e0da4680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=634e05b4025da9da
dashboard link: https://syzkaller.appspot.com/bug?extid=44ae022028805f4600fc
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=149ee384680000

