Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1156B7DFEEE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 06:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjKCFwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 01:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjKCFwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 01:52:10 -0400
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350F41B2
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 22:52:04 -0700 (PDT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3b3e601436cso2397321b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 22:52:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698990723; x=1699595523;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ukmjKeXWizUZ7lWfVs7EcHYwR+t2ISkHJDXjogS06HI=;
        b=HxqpPa/Edb3YP0znLXwf0eVYMlI3KeUNwLVm/kbg9kWA6v1VpitWaO9T1/agnSFxP7
         qsTX+dUoOta5SjfTcu1Kih6eJtKh2el4VrmpZ/mR5HrG+fipbcebQPoVhi55XrlUEnhF
         zYxZubtKMffQwr+z4cKy2pKfmELSJ9+DPBZxaMwU5yPJnvnnM3gmAWHRzaHP8J5nG6kB
         CAv4chkafYKsuOSkCHi/sjmQN1vUmlsEComffBhE1B+yqAf2c/P/YssLaDO/wwGmQ9mp
         flXKHdtdNYgQUYX/9xFGdF7ijI0YIoVxWhYMVhCdi2TOstSOnWF12VNhvLFmFhe1OdKa
         ni4w==
X-Gm-Message-State: AOJu0YzNeIbWZczVNoM3uUniF8FAQJEBRRHpMssBl3A8AhgAl5oUnpUq
        JsYsMmgcbu8MZ9vX/kQWZXSKhrh/7AEtL6izw/Vqx1gRjmqRxsU=
X-Google-Smtp-Source: AGHT+IHcWjR5YC+GJbYWBV8a1MXuORF5ZVgkWHSIlihcca7VIfBFj3JQ1UsH7sb+3qe2R4ZzOulnaCTNkI7cVh2s2gD6n8vs7wWb
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2090:b0:3af:c82e:c80f with SMTP id
 s16-20020a056808209000b003afc82ec80fmr8019285oiw.2.1698990723639; Thu, 02 Nov
 2023 22:52:03 -0700 (PDT)
Date:   Thu, 02 Nov 2023 22:52:03 -0700
In-Reply-To: <20231103053639.1095013-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008f30a80609391aec@google.com>
Subject: Re: [syzbot] [iommu?] KASAN: slab-use-after-free Read in iommufd_vfio_ioas
From:   syzbot <syzbot+d31adfb277377ef8fcba@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, lizhi.xu@windriver.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in iommufd_vfio_ioas

==================================================================
BUG: KASAN: slab-use-after-free in __up_read+0x627/0x750 kernel/locking/rwsem.c:1342
Read of size 8 at addr ffff88801c36c868 by task syz-executor.3/6257

CPU: 1 PID: 6257 Comm: syz-executor.3 Not tainted 6.6.0-rc7-syzkaller-00195-g2af9b20dbb39-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 __up_read+0x627/0x750 kernel/locking/rwsem.c:1342
 iommufd_put_object drivers/iommu/iommufd/iommufd_private.h:149 [inline]
 iommufd_vfio_ioas+0x46c/0x580 drivers/iommu/iommufd/vfio_compat.c:146
 iommufd_fops_ioctl+0x347/0x4d0 drivers/iommu/iommufd/main.c:399
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f8704c7cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f870596e0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f8704d9c050 RCX: 00007f8704c7cae9
RDX: 0000000020000080 RSI: 0000000000003b88 RDI: 0000000000000003
RBP: 00007f8704cc847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f8704d9c050 R15: 00007ffcfcbdc3a8
 </TASK>

Allocated by task 6255:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0xa3/0xb0 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:198 [inline]
 __do_kmalloc_node mm/slab_common.c:1026 [inline]
 __kmalloc+0x60/0x100 mm/slab_common.c:1039
 kmalloc include/linux/slab.h:603 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 _iommufd_object_alloc+0x26/0x1b0 drivers/iommu/iommufd/main.c:40
 iommufd_ioas_alloc drivers/iommu/iommufd/ioas.c:27 [inline]
 iommufd_ioas_alloc_ioctl+0xaf/0x370 drivers/iommu/iommufd/ioas.c:46
 iommufd_fops_ioctl+0x347/0x4d0 drivers/iommu/iommufd/main.c:399
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 6260:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x28/0x40 mm/kasan/generic.c:522
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x138/0x190 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:164 [inline]
 __cache_free mm/slab.c:3370 [inline]
 __do_kmem_cache_free mm/slab.c:3557 [inline]
 __kmem_cache_free+0xcc/0x2d0 mm/slab.c:3564
 iommufd_destroy+0x11e/0x180 drivers/iommu/iommufd/main.c:217
 iommufd_fops_ioctl+0x347/0x4d0 drivers/iommu/iommufd/main.c:399
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Last potentially related work creation:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 __kasan_record_aux_stack+0x78/0x80 mm/kasan/generic.c:492
 kvfree_call_rcu+0x70/0xbe0 kernel/rcu/tree.c:3372
 drop_sysctl_table+0x1d4/0x3b0 fs/proc/proc_sysctl.c:1508
 unregister_sysctl_table fs/proc/proc_sysctl.c:1529 [inline]
 unregister_sysctl_table+0x41/0x60 fs/proc/proc_sysctl.c:1521
 neigh_sysctl_unregister+0x5f/0x80 net/core/neighbour.c:3873
 devinet_sysctl_unregister net/ipv4/devinet.c:2659 [inline]
 inetdev_event+0xedc/0x1900 net/ipv4/devinet.c:1631
 notifier_call_chain+0xb6/0x3b0 kernel/notifier.c:93
 call_netdevice_notifiers_info+0xb9/0x130 net/core/dev.c:1995
 call_netdevice_notifiers_extack net/core/dev.c:2033 [inline]
 call_netdevice_notifiers net/core/dev.c:2047 [inline]
 dev_change_name+0x495/0x7c0 net/core/dev.c:1269
 do_setlink+0x2f99/0x3fa0 net/core/rtnetlink.c:2853
 __rtnl_newlink+0xc1d/0x1940 net/core/rtnetlink.c:3671
 rtnl_newlink+0x67/0xa0 net/core/rtnetlink.c:3718
 rtnetlink_rcv_msg+0x3c4/0xdf0 net/core/rtnetlink.c:6442
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2545
 netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
 netlink_unicast+0x536/0x810 net/netlink/af_netlink.c:1368
 netlink_sendmsg+0x93c/0xe40 net/netlink/af_netlink.c:1910
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0xd5/0x180 net/socket.c:745
 __sys_sendto+0x255/0x340 net/socket.c:2194
 __do_sys_sendto net/socket.c:2206 [inline]
 __se_sys_sendto net/socket.c:2202 [inline]
 __x64_sys_sendto+0xe0/0x1b0 net/socket.c:2202
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff88801c36c800
 which belongs to the cache kmalloc-cg-1k of size 1024
The buggy address is located 104 bytes inside of
 freed 1024-byte region [ffff88801c36c800, ffff88801c36cc00)

The buggy address belongs to the physical page:
page:ffffea000070db00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1c36c
memcg:ffff88801770ad81
flags: 0xfff00000000800(slab|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0x2()
raw: 00fff00000000800 ffff888012c4d800 ffffea0001f77e50 ffffea00007fbfd0
raw: 0000000000000000 ffff88801c36c000 0000000100000002 ffff88801770ad81
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2c20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_THISNODE), pid 4694, tgid 4694 (dhcpcd), ts 56107701927, free_ts 46839953379
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2cf/0x340 mm/page_alloc.c:1536
 prep_new_page mm/page_alloc.c:1543 [inline]
 get_page_from_freelist+0xee0/0x2f20 mm/page_alloc.c:3170
 __alloc_pages+0x1d0/0x4a0 mm/page_alloc.c:4426
 __alloc_pages_node include/linux/gfp.h:237 [inline]
 kmem_getpages mm/slab.c:1356 [inline]
 cache_grow_begin+0x99/0x3a0 mm/slab.c:2550
 cache_alloc_refill+0x294/0x3a0 mm/slab.c:2923
 ____cache_alloc mm/slab.c:2999 [inline]
 ____cache_alloc mm/slab.c:2982 [inline]
 __do_cache_alloc mm/slab.c:3182 [inline]
 slab_alloc_node mm/slab.c:3230 [inline]
 __kmem_cache_alloc_node+0x3c5/0x470 mm/slab.c:3521
 __do_kmalloc_node mm/slab_common.c:1025 [inline]
 __kmalloc_node_track_caller+0x50/0x100 mm/slab_common.c:1046
 kmalloc_reserve+0xef/0x260 net/core/skbuff.c:581
 __alloc_skb+0x12b/0x330 net/core/skbuff.c:650
 alloc_skb include/linux/skbuff.h:1286 [inline]
 alloc_skb_with_frags+0xe4/0x710 net/core/skbuff.c:6313
 sock_alloc_send_pskb+0x7e4/0x970 net/core/sock.c:2795
 unix_dgram_sendmsg+0x455/0x1c30 net/unix/af_unix.c:1953
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0xd5/0x180 net/socket.c:745
 sock_write_iter+0x29b/0x3d0 net/socket.c:1158
 call_write_iter include/linux/fs.h:1956 [inline]
 do_iter_readv_writev+0x21e/0x3c0 fs/read_write.c:735
 do_iter_write+0x17f/0x830 fs/read_write.c:860
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1136 [inline]
 free_unref_page_prepare+0x476/0xa40 mm/page_alloc.c:2312
 free_unref_page+0x33/0x3b0 mm/page_alloc.c:2405
 slab_destroy mm/slab.c:1608 [inline]
 slabs_destroy+0x85/0xc0 mm/slab.c:1628
 cache_flusharray mm/slab.c:3341 [inline]
 ___cache_free+0x2b7/0x420 mm/slab.c:3404
 qlink_free mm/kasan/quarantine.c:166 [inline]
 qlist_free_all+0x4c/0x1b0 mm/kasan/quarantine.c:185
 kasan_quarantine_reduce+0x18e/0x1d0 mm/kasan/quarantine.c:292
 __kasan_slab_alloc+0x65/0x90 mm/kasan/common.c:305
 kasan_slab_alloc include/linux/kasan.h:188 [inline]
 slab_post_alloc_hook mm/slab.h:762 [inline]
 slab_alloc_node mm/slab.c:3237 [inline]
 slab_alloc mm/slab.c:3246 [inline]
 __kmem_cache_alloc_lru mm/slab.c:3423 [inline]
 kmem_cache_alloc+0x159/0x400 mm/slab.c:3432
 getname_flags.part.0+0x50/0x4e0 fs/namei.c:140
 getname_flags include/linux/audit.h:321 [inline]
 getname+0x90/0xe0 fs/namei.c:219
 do_sys_openat2+0x100/0x1e0 fs/open.c:1416
 do_sys_open fs/open.c:1437 [inline]
 __do_sys_openat fs/open.c:1453 [inline]
 __se_sys_openat fs/open.c:1448 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1448
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88801c36c700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88801c36c780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88801c36c800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                          ^
 ffff88801c36c880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88801c36c900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         2af9b20d Merge tag 'x86-urgent-2023-10-28' of git://gi..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15522940e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb98fe061049a6e4
dashboard link: https://syzkaller.appspot.com/bug?extid=d31adfb277377ef8fcba
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17d652f3680000

