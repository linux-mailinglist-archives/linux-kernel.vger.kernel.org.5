Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5EE799739
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 11:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344575AbjIIJ6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 05:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbjIIJ6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 05:58:38 -0400
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229549D
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 02:58:34 -0700 (PDT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5704715480eso3593249a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Sep 2023 02:58:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694253513; x=1694858313;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m8ZH55rXR31vj+dYZqtC4Z5tbIfGskhTO7lBZa9pPf8=;
        b=pBCfxdsocIIUyDj3BXvHo4Xx2u9fqAGrgemvdCHiiKt1cmff3hU7wRs37F9b2hxyLb
         u1pvpiTVaicaGbi1PPpgKMFXiaW1OBcw9T1sofgqPRxK8BZxO31gdrqHrD7YBXapsETU
         IW0Gkpi/27iD4blMhnA2wQUODqQEnmIH19knLgWHRlJQTuFcJI6EzlZ/exY2H1hN22wf
         aRP3I0+mV4O1IL0ksz4KPOBthZBT+SgzyzsDnp+9K8MSqvoctypb+HDcEANce4KKEtwK
         KoE67b1n7/UYlNiRsqZ0sB+YoY9YAfM9Q82dAzAbe2K/OKAa/Ao0mgo84LUVmVCdGksD
         tKEA==
X-Gm-Message-State: AOJu0YzAa3MFO9lTat+idhlJTirNLkUPqHoJH0z2AM9lFwqKGfzdkJOx
        YkM/dYKy/t42aMUa2KmkJ4onFUqa/qU8Mqn/k3gm8gN0Engz
X-Google-Smtp-Source: AGHT+IFwX2z5OGAMIbuiKoRB4yLMXmiIDsDns6hvkVnYHl/9KTuj3s556CHxpSiA/OeARXnln1T+8uLC44ptVOia9TNQtGUL7zWO
MIME-Version: 1.0
X-Received: by 2002:a63:d642:0:b0:577:5299:3a22 with SMTP id
 d2-20020a63d642000000b0057752993a22mr3189pgj.2.1694253513643; Sat, 09 Sep
 2023 02:58:33 -0700 (PDT)
Date:   Sat, 09 Sep 2023 02:58:33 -0700
In-Reply-To: <20230909092011.5956-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d71fae0604ea22a2@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in team_device_event
From:   syzbot <syzbot+44ae022028805f4600fc@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
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
BUG: KASAN: slab-use-after-free in team_device_event+0xa3b/0xad0 drivers/net/team/team.c:3025
Read of size 8 at addr ffff888017364548 by task syz-executor213/19525

CPU: 0 PID: 19525 Comm: syz-executor213 Not tainted 6.5.0-syzkaller-04043-gf8fdd54ee6a1-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/04/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 team_device_event+0xa3b/0xad0 drivers/net/team/team.c:3025
 notifier_call_chain+0xb6/0x3b0 kernel/notifier.c:93
 call_netdevice_notifiers_info+0xb9/0x130 net/core/dev.c:1970
 call_netdevice_notifiers_extack net/core/dev.c:2008 [inline]
 call_netdevice_notifiers net/core/dev.c:2022 [inline]
 netdev_features_change net/core/dev.c:1333 [inline]
 netdev_update_features net/core/dev.c:9874 [inline]
 netdev_update_features net/core/dev.c:9871 [inline]
 dev_disable_lro+0x224/0x3e0 net/core/dev.c:1606
 team_port_add drivers/net/team/team.c:1248 [inline]
 team_add_slave+0x1a8f/0x2360 drivers/net/team/team.c:1980
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
RIP: 0033:0x7fa6368d05d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 d1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc7b3e0188 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fa6368d05d9
RDX: 0000000000000000 RSI: 0000000020000080 RDI: 0000000000000007
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Allocated by task 15081:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:196 [inline]
 __do_kmalloc_node mm/slab_common.c:985 [inline]
 __kmalloc_node_track_caller+0x5e/0x100 mm/slab_common.c:1005
 kstrdup+0x3c/0x70 mm/util.c:62
 kstrdup_const+0x5f/0x70 mm/util.c:85
 __kernfs_new_node+0x9c/0x8a0 fs/kernfs/dir.c:607
 kernfs_new_node+0x94/0x110 fs/kernfs/dir.c:675
 kernfs_create_link+0xcc/0x230 fs/kernfs/symlink.c:39
 sysfs_do_create_link_sd+0x90/0x140 fs/sysfs/symlink.c:44
 sysfs_do_create_link fs/sysfs/symlink.c:80 [inline]
 sysfs_create_link+0x61/0xc0 fs/sysfs/symlink.c:92
 netdev_adjacent_sysfs_add net/core/dev.c:7481 [inline]
 __netdev_adjacent_dev_insert+0x751/0xb40 net/core/dev.c:7537
 __netdev_adjacent_dev_link_lists net/core/dev.c:7619 [inline]
 __netdev_adjacent_dev_link_neighbour net/core/dev.c:7643 [inline]
 __netdev_upper_dev_link+0x410/0x840 net/core/dev.c:7703
 netdev_upper_dev_link+0x92/0xc0 net/core/dev.c:7749
 macsec_newlink+0x800/0x1a30 drivers/net/macsec.c:4087
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

The buggy address belongs to the object at ffff888017364540
 which belongs to the cache kmalloc-16 of size 16
The buggy address is located 8 bytes inside of
 freed 16-byte region [ffff888017364540, ffff888017364550)

The buggy address belongs to the physical page:
page:ffffea00005cd900 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x17364
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000200 ffff8880128413c0 dead000000000100 dead000000000122
raw: 0000000000000000 0000000080800080 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY), pid 5390, tgid 5390 (syz-executor.0), ts 86692200297, free_ts 86666078377
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
 free_unref_page+0x33/0x3b0 mm/page_alloc.c:2443
 __unfreeze_partials+0x21d/0x240 mm/slub.c:2647
 qlink_free mm/kasan/quarantine.c:166 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:185
 kasan_quarantine_reduce+0x18b/0x1d0 mm/kasan/quarantine.c:292
 __kasan_slab_alloc+0x65/0x90 mm/kasan/common.c:305
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook mm/slab.h:762 [inline]
 slab_alloc_node mm/slub.c:3470 [inline]
 slab_alloc mm/slub.c:3478 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3485 [inline]
 kmem_cache_alloc+0x172/0x3b0 mm/slub.c:3494
 kmem_cache_zalloc include/linux/slab.h:693 [inline]
 alloc_buffer_head+0x21/0x140 fs/buffer.c:3037
 folio_alloc_buffers+0x2ad/0x800 fs/buffer.c:941
 grow_dev_page fs/buffer.c:1078 [inline]
 grow_buffers fs/buffer.c:1124 [inline]
 __getblk_slow+0x2ac/0x720 fs/buffer.c:1151
 __getblk_gfp+0x70/0x80 fs/buffer.c:1445
 sb_getblk include/linux/buffer_head.h:369 [inline]
 ext4_getblk+0x229/0x810 fs/ext4/inode.c:829
 ext4_bread+0x2c/0x190 fs/ext4/inode.c:875
 ext4_append+0x26d/0x560 fs/ext4/namei.c:83
 ext4_init_new_dir+0x220/0x4c0 fs/ext4/namei.c:2976
 ext4_mkdir+0x316/0xb70 fs/ext4/namei.c:3022

Memory state around the buggy address:
 ffff888017364400: fb fb fc fc fb fb fc fc fb fb fc fc fb fb fc fc
 ffff888017364480: fb fb fc fc 00 00 fc fc fb fb fc fc fb fb fc fc
>ffff888017364500: fb fb fc fc 00 00 fc fc fb fb fc fc fb fb fc fc
                                              ^
 ffff888017364580: fb fb fc fc fb fb fc fc fb fb fc fc 00 00 fc fc
 ffff888017364600: 00 01 fc fc fb fb fc fc 00 01 fc fc fb fb fc fc
==================================================================


Tested on:

commit:         f8fdd54e Merge branch 'sja1105-fixes'
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15b29abfa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=634e05b4025da9da
dashboard link: https://syzkaller.appspot.com/bug?extid=44ae022028805f4600fc
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17c8150c680000

