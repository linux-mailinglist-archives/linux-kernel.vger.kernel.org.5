Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB7D779EB5
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 11:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236795AbjHLJyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 05:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjHLJyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 05:54:22 -0400
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A8019B3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 02:54:25 -0700 (PDT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-564fec87e4fso3099980a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 02:54:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691834064; x=1692438864;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oxd4UdigsXjp4/mRYDuOKrj5OUCnZYn0WeCiYjxN8hs=;
        b=Zdwz2h7T6kd40RrjN0qU3DAOLaJhNOjh+JUudQY4eXufXCtpQ3exXRpjshcAZy48/r
         HCBRo0xYtesUfLUKSne3XHo3xVIeYUnGAZ9Kd3SW5NL54jZjaIg71a0QFCeJGr2JjFcO
         27Z6E3OxknVXSrKzht/3peXqmJ38FQJ521PMWh3vaUd8yTQRg48jxMePQq8DvVFc4eLY
         gpqbsGmbAL7CjtdWQriGRqLWugHBxEdo3XnGT8KFVTmtbuqzZ3FsoFLinYC09CwG5mY0
         FQquoqb3MvKEYqKPxBy3hyfo83lPb7vC7Oa3spMj0UFNy5oPxoK5nMSQslGYuEquI1g9
         SGPw==
X-Gm-Message-State: AOJu0YypbpfhD1BZDH2NG5rVLrat/3CK3BQuAU7TIKQ/Z7MiwAvqAzJT
        MVuVXn5lU5uJROW38JnfIFJlxjUgMxCD5Tv44J106OGlhj+h
X-Google-Smtp-Source: AGHT+IFjb+nlxdz8zlBIXB5j+KYLopJyU1ohzXJq3m0z8WuwZNJ35FVZTS9YXJ9fXnxxDkLxvXIHKcx7L0VokCSXw/e2TYHT7bKG
MIME-Version: 1.0
X-Received: by 2002:a63:794e:0:b0:565:29ad:359a with SMTP id
 u75-20020a63794e000000b0056529ad359amr709440pgc.6.1691834064762; Sat, 12 Aug
 2023 02:54:24 -0700 (PDT)
Date:   Sat, 12 Aug 2023 02:54:24 -0700
In-Reply-To: <20230812092703.668-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000072fdec0602b6d0c9@google.com>
Subject: Re: [syzbot] [net?] WARNING in rtnl_dellink (3)
From:   syzbot <syzbot+4b4f06495414e92701d5@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-out-of-bounds Read in unregister_vlan_dev

==================================================================
BUG: KASAN: slab-out-of-bounds in unregister_vlan_dev+0x4fa/0x580 net/8021q/vlan.c:92
Read of size 8 at addr ffff88806a042d30 by task syz-executor.0/5775

CPU: 0 PID: 5775 Comm: syz-executor.0 Not tainted 6.5.0-rc4-syzkaller-00248-g048c796beb6e-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 unregister_vlan_dev+0x4fa/0x580 net/8021q/vlan.c:92
 vlan_device_event+0x17e2/0x2070 net/8021q/vlan.c:489
 notifier_call_chain+0xb6/0x3b0 kernel/notifier.c:93
 call_netdevice_notifiers_info+0xb9/0x130 net/core/dev.c:1962
 call_netdevice_notifiers_extack net/core/dev.c:2000 [inline]
 call_netdevice_notifiers net/core/dev.c:2014 [inline]
 unregister_netdevice_many_notify+0x82b/0x19a0 net/core/dev.c:10850
 rtnl_delete_link net/core/rtnetlink.c:3214 [inline]
 rtnl_dellink+0x3c1/0xae0 net/core/rtnetlink.c:3266
 rtnetlink_rcv_msg+0x439/0xd30 net/core/rtnetlink.c:6428
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2549
 netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
 netlink_unicast+0x539/0x800 net/netlink/af_netlink.c:1365
 netlink_sendmsg+0x93c/0xe30 net/netlink/af_netlink.c:1914
 sock_sendmsg_nosec net/socket.c:725 [inline]
 sock_sendmsg+0xd9/0x180 net/socket.c:748
 ____sys_sendmsg+0x6ac/0x940 net/socket.c:2494
 ___sys_sendmsg+0x135/0x1d0 net/socket.c:2548
 __sys_sendmsg+0x117/0x1e0 net/socket.c:2577
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f2b57e7cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2b58cc50c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f2b57f9bf80 RCX: 00007f2b57e7cae9
RDX: 0000000000000000 RSI: 0000000020000140 RDI: 0000000000000003
RBP: 00007f2b57ec847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000004d R14: 00007f2b57f9bf80 R15: 00007ffddd57e0c8
 </TASK>

Allocated by task 5373:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:196 [inline]
 __do_kmalloc_node mm/slab_common.c:985 [inline]
 __kmalloc_node+0x60/0x100 mm/slab_common.c:992
 kmalloc_node include/linux/slab.h:602 [inline]
 kvmalloc_node+0x99/0x1a0 mm/util.c:604
 kvmalloc include/linux/slab.h:720 [inline]
 kvzalloc include/linux/slab.h:728 [inline]
 alloc_netdev_mqs+0x9b/0x1240 net/core/dev.c:10594
 rtnl_create_link+0xc9c/0xfd0 net/core/rtnetlink.c:3336
 rtnl_newlink_create net/core/rtnetlink.c:3462 [inline]
 __rtnl_newlink+0x1075/0x18c0 net/core/rtnetlink.c:3689
 rtnl_newlink+0x67/0xa0 net/core/rtnetlink.c:3702
 rtnetlink_rcv_msg+0x439/0xd30 net/core/rtnetlink.c:6428
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2549
 netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
 netlink_unicast+0x539/0x800 net/netlink/af_netlink.c:1365
 netlink_sendmsg+0x93c/0xe30 net/netlink/af_netlink.c:1914
 sock_sendmsg_nosec net/socket.c:725 [inline]
 sock_sendmsg+0xd9/0x180 net/socket.c:748
 __sys_sendto+0x255/0x340 net/socket.c:2134
 __do_sys_sendto net/socket.c:2146 [inline]
 __se_sys_sendto net/socket.c:2142 [inline]
 __x64_sys_sendto+0xe0/0x1b0 net/socket.c:2142
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff88806a042000
 which belongs to the cache kmalloc-cg-4k of size 4096
The buggy address is located 105 bytes to the right of
 allocated 3271-byte region [ffff88806a042000, ffff88806a042cc7)

The buggy address belongs to the physical page:
page:ffffea0001a81000 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x6a040
head:ffffea0001a81000 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff88802b2789c1
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000010200 ffff88801284f500 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000040004 00000001ffffffff ffff88802b2789c1
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 5373, tgid 5373 (syz-executor.0), ts 68111966563, free_ts 44747678296
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2d2/0x350 mm/page_alloc.c:1570
 prep_new_page mm/page_alloc.c:1577 [inline]
 get_page_from_freelist+0x10a9/0x31e0 mm/page_alloc.c:3221
 __alloc_pages+0x1d0/0x4a0 mm/page_alloc.c:4477
 alloc_pages+0x1a9/0x270 mm/mempolicy.c:2292
 alloc_slab_page mm/slub.c:1862 [inline]
 allocate_slab+0x24e/0x380 mm/slub.c:2009
 new_slab mm/slub.c:2062 [inline]
 ___slab_alloc+0x8bc/0x1570 mm/slub.c:3215
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3314
 __slab_alloc_node mm/slub.c:3367 [inline]
 slab_alloc_node mm/slub.c:3460 [inline]
 __kmem_cache_alloc_node+0x137/0x350 mm/slub.c:3509
 __do_kmalloc_node mm/slab_common.c:984 [inline]
 __kmalloc_node_track_caller+0x4d/0x100 mm/slab_common.c:1005
 kmemdup+0x29/0x60 mm/util.c:131
 kmemdup include/linux/fortify-string.h:765 [inline]
 __addrconf_sysctl_register+0xc2/0x3f0 net/ipv6/addrconf.c:7076
 addrconf_sysctl_register net/ipv6/addrconf.c:7141 [inline]
 addrconf_sysctl_register+0x133/0x1d0 net/ipv6/addrconf.c:7130
 ipv6_add_dev+0x9ee/0x13d0 net/ipv6/addrconf.c:449
 addrconf_notify+0x566/0x1940 net/ipv6/addrconf.c:3557
 notifier_call_chain+0xb6/0x3b0 kernel/notifier.c:93
 call_netdevice_notifiers_info+0xb9/0x130 net/core/dev.c:1962
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1161 [inline]
 free_unref_page_prepare+0x508/0xb90 mm/page_alloc.c:2348
 free_unref_page+0x33/0x3b0 mm/page_alloc.c:2443
 vfree+0x181/0x7a0 mm/vmalloc.c:2842
 kcov_put kernel/kcov.c:429 [inline]
 kcov_put+0x26/0x40 kernel/kcov.c:425
 kcov_close+0x10/0x20 kernel/kcov.c:525
 __fput+0x3fd/0xac0 fs/file_table.c:384
 task_work_run+0x14d/0x240 kernel/task_work.c:179
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa99/0x2a20 kernel/exit.c:874
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1024
 get_signal+0x23ea/0x2770 kernel/signal.c:2881
 arch_do_signal_or_restart+0x89/0x5f0 arch/x86/kernel/signal.c:308
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:297
 do_syscall_64+0x44/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88806a042c00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88806a042c80: 00 00 00 00 00 00 00 00 07 fc fc fc fc fc fc fc
>ffff88806a042d00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                     ^
 ffff88806a042d80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88806a042e00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         048c796b ipv6: adjust ndisc_is_useropt() to also retur..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=142903aba80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa5bd4cd5ab6259d
dashboard link: https://syzkaller.appspot.com/bug?extid=4b4f06495414e92701d5
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16e4d78ba80000

