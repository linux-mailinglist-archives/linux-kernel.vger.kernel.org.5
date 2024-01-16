Return-Path: <linux-kernel+bounces-27352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF73482EE88
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47DFEB22C80
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2284B1B95C;
	Tue, 16 Jan 2024 11:55:10 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34C21B944
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 11:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7bf2a5cd631so387629539f.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 03:55:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705406106; x=1706010906;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pfbcYPWUL8S9OzKOy12pJgAig6uehjg34qol4goNDN0=;
        b=vXZtYFT32rSPysh1jQQGZSR+QB9dOMn6h/kJQMnNFs+jfQo0HOsCvMAKtUAqvd4BYI
         vti0Z9ta+7YVxAo/8uP9D3ygx2T8/eAKwuIhWius7VRcxqV/oovK2Kop85sbyEl/lCHs
         tdOWOx8gnT07CSngDfmDW91w9SQpxarL+UtWX5ztVVFvaPgUoVj3LZgh4R2DPqREvVC8
         uNeX5qwnDIfAHNzD++CDw5qJpWhLm/EgCoxcZZZzQu++KaK7ZCndrAlyDdIzOTR7C2tG
         iJE5OWpnMH/Mizz55tssAiZ32woSxQpRn4rw5gdQLzG6o8cGFxHqC25Z0wc3KcargoWr
         jGgg==
X-Gm-Message-State: AOJu0YzQnk2vLlpP9MuCakC3r+OMKc7LI9fYA6W7/AH/Rdus7uziuUL7
	DKWnbvID5IDNy7KrEvSQp+3VqAD5xfYTapwCnQ3xkG/uN9Dl
X-Google-Smtp-Source: AGHT+IGg75kXtj0k45wGB6kO+M0gQD/mD1wYOy590XBAokG6n9BukFHu7xBA44edYib7MDNKSt1zcYg7+vfr/i5yB4PBdcmcybC3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20cb:b0:35f:a338:44ae with SMTP id
 11-20020a056e0220cb00b0035fa33844aemr1065062ilq.3.1705406106097; Tue, 16 Jan
 2024 03:55:06 -0800 (PST)
Date: Tue, 16 Jan 2024 03:55:06 -0800
In-Reply-To: <20240116113426.909-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000026dd41060f0ecdf4@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-out-of-bounds Read in dsa_user_prechangeupper
From: syzbot <syzbot+7ec955e36bb239bd720f@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-out-of-bounds Read in dsa_user_changeupper

==================================================================
BUG: KASAN: slab-out-of-bounds in dsa_user_to_port net/dsa/user.h:58 [inline]
BUG: KASAN: slab-out-of-bounds in dsa_user_changeupper+0x3d/0x570 net/dsa/user.c:2809
Read of size 8 at addr ffff88802c9c2c90 by task syz-executor.0/5476

CPU: 1 PID: 5476 Comm: syz-executor.0 Not tainted 6.7.0-syzkaller-09928-g052d534373b7-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:488
 kasan_report+0x142/0x170 mm/kasan/report.c:601
 dsa_user_to_port net/dsa/user.h:58 [inline]
 dsa_user_changeupper+0x3d/0x570 net/dsa/user.c:2809
 dsa_user_netdevice_event+0x47f/0x2ab0 net/dsa/user.c:3347
 notifier_call_chain+0x18c/0x3b0 kernel/notifier.c:93
 __netdev_upper_dev_link+0x4bf/0x670 net/core/dev.c:7759
 netdev_upper_dev_link+0x9e/0xe0 net/core/dev.c:7800
 macvlan_common_newlink+0x11c9/0x1930 drivers/net/macvlan.c:1539
 macvtap_newlink+0x154/0x1d0 drivers/net/macvtap.c:108
 rtnl_newlink_create net/core/rtnetlink.c:3515 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3735 [inline]
 rtnl_newlink+0x1584/0x2080 net/core/rtnetlink.c:3748
 rtnetlink_rcv_msg+0x882/0x1030 net/core/rtnetlink.c:6615
 netlink_rcv_skb+0x1df/0x430 net/netlink/af_netlink.c:2543
 netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
 netlink_unicast+0x7e6/0x980 net/netlink/af_netlink.c:1367
 netlink_sendmsg+0xa37/0xd70 net/netlink/af_netlink.c:1908
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0x592/0x890 net/socket.c:2584
 ___sys_sendmsg net/socket.c:2638 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f35ef47cd29
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f35f02ca0c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f35ef5abf80 RCX: 00007f35ef47cd29
RDX: 0000000000000000 RSI: 0000000020000280 RDI: 0000000000000005
RBP: 00007f35ef4c947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f35ef5abf80 R15: 00007ffe96db21d8
 </TASK>

Allocated by task 5403:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x70 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:372 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:389
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:3981 [inline]
 __kmalloc_node+0x24e/0x4e0 mm/slub.c:3988
 kmalloc_node include/linux/slab.h:610 [inline]
 kvmalloc_node+0x72/0x180 mm/util.c:617
 kvmalloc include/linux/slab.h:728 [inline]
 kvzalloc include/linux/slab.h:736 [inline]
 alloc_netdev_mqs+0x9d/0xf80 net/core/dev.c:10826
 rtnl_create_link+0x2ea/0xc10 net/core/rtnetlink.c:3379
 rtnl_newlink_create net/core/rtnetlink.c:3505 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3735 [inline]
 rtnl_newlink+0x141e/0x2080 net/core/rtnetlink.c:3748
 rtnetlink_rcv_msg+0x882/0x1030 net/core/rtnetlink.c:6615
 netlink_rcv_skb+0x1df/0x430 net/netlink/af_netlink.c:2543
 netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
 netlink_unicast+0x7e6/0x980 net/netlink/af_netlink.c:1367
 netlink_sendmsg+0xa37/0xd70 net/netlink/af_netlink.c:1908
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 __sys_sendto+0x440/0x600 net/socket.c:2191
 __do_sys_sendto net/socket.c:2203 [inline]
 __se_sys_sendto net/socket.c:2199 [inline]
 __x64_sys_sendto+0xde/0xf0 net/socket.c:2199
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

The buggy address belongs to the object at ffff88802c9c2000
 which belongs to the cache kmalloc-cg-4k of size 4096
The buggy address is located 3216 bytes inside of
 allocated 3223-byte region [ffff88802c9c2000, ffff88802c9c2c97)

The buggy address belongs to the physical page:
page:ffffea0000b27000 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2c9c0
head:ffffea0000b27000 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff88802c7b3b81
flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888012c4f500 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000040004 00000001ffffffff ffff88802c7b3b81
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 5403, tgid 5403 (syz-executor.0), ts 78669615880, free_ts 78657614450
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1e6/0x210 mm/page_alloc.c:1533
 prep_new_page mm/page_alloc.c:1540 [inline]
 get_page_from_freelist+0x33ea/0x3570 mm/page_alloc.c:3311
 __alloc_pages+0x255/0x680 mm/page_alloc.c:4567
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page+0x5f/0x160 mm/slub.c:2190
 allocate_slab mm/slub.c:2354 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2407
 ___slab_alloc+0xd17/0x13d0 mm/slub.c:3540
 __slab_alloc mm/slub.c:3625 [inline]
 __slab_alloc_node mm/slub.c:3678 [inline]
 slab_alloc_node mm/slub.c:3850 [inline]
 __do_kmalloc_node mm/slub.c:3980 [inline]
 __kmalloc_node_track_caller+0x2cd/0x4e0 mm/slub.c:4001
 kmemdup+0x2a/0x60 mm/util.c:131
 __addrconf_sysctl_register+0xb1/0x3f0 net/ipv6/addrconf.c:7129
 addrconf_sysctl_register+0x167/0x1c0 net/ipv6/addrconf.c:7195
 ipv6_add_dev+0xd60/0x1290 net/ipv6/addrconf.c:453
 addrconf_notify+0x6a7/0x1010 net/ipv6/addrconf.c:3593
 notifier_call_chain+0x18c/0x3b0 kernel/notifier.c:93
 call_netdevice_notifiers_extack net/core/dev.c:2004 [inline]
 call_netdevice_notifiers net/core/dev.c:2018 [inline]
 register_netdevice+0x150c/0x19b0 net/core/dev.c:10294
 team_newlink+0x10a/0x170 drivers/net/team/team.c:2217
 rtnl_newlink_create net/core/rtnetlink.c:3515 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3735 [inline]
 rtnl_newlink+0x1584/0x2080 net/core/rtnetlink.c:3748
page last free pid 5403 tgid 5403 stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1140 [inline]
 free_unref_page_prepare+0x959/0xa80 mm/page_alloc.c:2346
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2486
 discard_slab mm/slub.c:2453 [inline]
 __put_partials+0xeb/0x130 mm/slub.c:2922
 put_cpu_partial+0x17b/0x250 mm/slub.c:2997
 __slab_free+0x2fe/0x410 mm/slub.c:4166
 qlink_free mm/kasan/quarantine.c:160 [inline]
 qlist_free_all+0x6d/0xd0 mm/kasan/quarantine.c:176
 kasan_quarantine_reduce+0x14b/0x160 mm/kasan/quarantine.c:283
 __kasan_slab_alloc+0x23/0x70 mm/kasan/common.c:324
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3813 [inline]
 slab_alloc_node mm/slub.c:3860 [inline]
 kmalloc_trace+0x16a/0x360 mm/slub.c:4007
 kmalloc include/linux/slab.h:590 [inline]
 kzalloc include/linux/slab.h:711 [inline]
 ref_tracker_alloc+0x14b/0x480 lib/ref_tracker.c:203
 __netdev_tracker_alloc include/linux/netdevice.h:4147 [inline]
 netdev_hold include/linux/netdevice.h:4176 [inline]
 rx_queue_add_kobject net/core/net-sysfs.c:1096 [inline]
 net_rx_queue_update_kobjects+0x16b/0x5b0 net/core/net-sysfs.c:1154
 register_queue_kobjects net/core/net-sysfs.c:1814 [inline]
 netdev_register_kobject+0x224/0x310 net/core/net-sysfs.c:2059
 register_netdevice+0x118a/0x19b0 net/core/dev.c:10261
 bond_newlink+0x3b/0x80 drivers/net/bonding/bond_netlink.c:565
 rtnl_newlink_create net/core/rtnetlink.c:3515 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3735 [inline]
 rtnl_newlink+0x1584/0x2080 net/core/rtnetlink.c:3748
 rtnetlink_rcv_msg+0x882/0x1030 net/core/rtnetlink.c:6615

Memory state around the buggy address:
 ffff88802c9c2b80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88802c9c2c00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88802c9c2c80: 00 00 07 fc fc fc fc fc fc fc fc fc fc fc fc fc
                         ^
 ffff88802c9c2d00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88802c9c2d80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         052d5343 Merge tag 'exfat-for-6.8-rc1' of git://git.ke..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=14ccb583e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=490fc2f9d4ae426c
dashboard link: https://syzkaller.appspot.com/bug?extid=7ec955e36bb239bd720f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1336162be80000


