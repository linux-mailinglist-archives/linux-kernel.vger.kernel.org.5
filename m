Return-Path: <linux-kernel+bounces-27218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA39A82EC5A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40F04B22F99
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84681B94D;
	Tue, 16 Jan 2024 09:56:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5B413AF1
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 09:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-360a49993dfso58969955ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 01:56:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705398965; x=1706003765;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OpyRK2iIAgM2DUoLijvNwdgA1IuefNJJrMohfKIdOq8=;
        b=kCTj0O4k9XpudMtuKloJ7DKtsj1hQNClPS6NLIM4LDFDTGEHVyOq3izQTVZsCRI0q4
         CbE2a+QRZ+LFi8DZNxW4+J5ewqz+MX//ru+z0U/KTqZ5QOgpLfnfBylB+UeAAXeZ7eBH
         kiSfbHceD94QMANk83se5tmqJkzQV/5X4VsjmHGzbKVM0nxfq3RvvPuC87LoxH0wgYzB
         cv8ywmgxJlCoOVbaxami+7dsncoj/xoelvj8bwjTwa33U6moUkgz0zloKK9Qwytk7i1E
         AZzquZnBuOI4B2SwUx8kNpqWmC4kcHEvr6F1xc+FTyMJfpCuBB9U7ME1y4qLajp+TMBe
         O3Gw==
X-Gm-Message-State: AOJu0Yx18XbsMOYO7Wx4SSCCRdZ3go0OrgjMK79YOszYqWQtlyosOFMV
	Bi+28rDhH85cOo5wyt0tB4+Or5fl+e1YUgnKIiePR6eF+81d
X-Google-Smtp-Source: AGHT+IGV1GSAIN5ID8c9xws74cRrSF83Nfx+inmpiP52nFPrginO47ARSKvCCNpaeZcyySDY3Qq3O82ZK2rsYFKnH7/HYgBRXosM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1526:b0:35f:bea3:c041 with SMTP id
 i6-20020a056e02152600b0035fbea3c041mr1014644ilu.4.1705398964904; Tue, 16 Jan
 2024 01:56:04 -0800 (PST)
Date: Tue, 16 Jan 2024 01:56:04 -0800
In-Reply-To: <tencent_674ACC74C977BF672C3C2F37AC97E236F409@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000080eb8e060f0d231e@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-out-of-bounds Read in dsa_user_prechangeupper
From: syzbot <syzbot+7ec955e36bb239bd720f@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-out-of-bounds Read in dsa_user_changeupper

==================================================================
BUG: KASAN: slab-out-of-bounds in dsa_user_to_port net/dsa/user.h:58 [inline]
BUG: KASAN: slab-out-of-bounds in dsa_user_changeupper+0x3d/0x570 net/dsa/user.c:2809
Read of size 8 at addr ffff888027526c90 by task syz-executor.0/5475

CPU: 1 PID: 5475 Comm: syz-executor.0 Not tainted 6.7.0-syzkaller-04629-g3e7aeb78ab01-dirty #0
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
 dsa_user_netdevice_event+0x47f/0x2ab0 net/dsa/user.c:3346
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
RIP: 0033:0x7f745707cd29
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7457e260c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f74571abf80 RCX: 00007f745707cd29
RDX: 0000000000000000 RSI: 0000000020000280 RDI: 0000000000000005
RBP: 00007f74570c947a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f74571abf80 R15: 00007fff7a6d63b8
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

The buggy address belongs to the object at ffff888027526000
 which belongs to the cache kmalloc-cg-4k of size 4096
The buggy address is located 3216 bytes inside of
 allocated 3223-byte region [ffff888027526000, ffff888027526c97)

The buggy address belongs to the physical page:
page:ffffea00009d4800 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x27520
head:ffffea00009d4800 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff888028869701
flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888012c4f500 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000040004 00000001ffffffff ffff888028869701
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 5403, tgid 5403 (syz-executor.0), ts 79518064348, free_ts 79474869363
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
 __devinet_sysctl_register+0xb0/0x2a0 net/ipv4/devinet.c:2595
 devinet_sysctl_register+0x17e/0x1f0 net/ipv4/devinet.c:2647
 inetdev_init+0x296/0x4c0 net/ipv4/devinet.c:286
 inetdev_event+0x338/0x15c0 net/ipv4/devinet.c:1555
 notifier_call_chain+0x18c/0x3b0 kernel/notifier.c:93
 call_netdevice_notifiers_extack net/core/dev.c:2004 [inline]
 call_netdevice_notifiers net/core/dev.c:2018 [inline]
 register_netdevice+0x150c/0x19b0 net/core/dev.c:10294
 team_newlink+0x10a/0x170 drivers/net/team/team.c:2217
 rtnl_newlink_create net/core/rtnetlink.c:3515 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3735 [inline]
 rtnl_newlink+0x1584/0x2080 net/core/rtnetlink.c:3748
page last free pid 4714 tgid 4714 stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1140 [inline]
 free_unref_page_prepare+0x959/0xa80 mm/page_alloc.c:2346
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2486
 folio_put include/linux/mm.h:1494 [inline]
 free_large_kmalloc+0x105/0x1c0 mm/slub.c:4380
 kfree+0x1ba/0x380 mm/slub.c:4403
 skb_kfree_head net/core/skbuff.c:986 [inline]
 skb_free_head net/core/skbuff.c:998 [inline]
 skb_release_data+0x660/0x850 net/core/skbuff.c:1028
 skb_release_all net/core/skbuff.c:1094 [inline]
 __kfree_skb net/core/skbuff.c:1108 [inline]
 consume_skb+0xb3/0x150 net/core/skbuff.c:1324
 netlink_recvmsg+0x60a/0x11d0 net/netlink/af_netlink.c:1986
 sock_recvmsg_nosec net/socket.c:1046 [inline]
 sock_recvmsg net/socket.c:1068 [inline]
 ____sys_recvmsg+0x2a4/0x580 net/socket.c:2803
 ___sys_recvmsg net/socket.c:2845 [inline]
 __sys_recvmsg+0x2f0/0x3d0 net/socket.c:2875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Memory state around the buggy address:
 ffff888027526b80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888027526c00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888027526c80: 00 00 07 fc fc fc fc fc fc fc fc fc fc fc fc fc
                         ^
 ffff888027526d00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888027526d80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         3e7aeb78 Merge tag 'net-next-6.8' of git://git.kernel...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1306b62be80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8e557b1c0a57d2c0
dashboard link: https://syzkaller.appspot.com/bug?extid=7ec955e36bb239bd720f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1606b62be80000


