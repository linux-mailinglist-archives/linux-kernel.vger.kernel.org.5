Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23ECC7DFE88
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 05:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjKCEIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 00:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjKCEIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 00:08:10 -0400
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D2C1A1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 21:08:04 -0700 (PDT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3b56ed16b98so2240009b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 21:08:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698984483; x=1699589283;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OVdulxiHVjjXT/hKtst7CIu5xoDpgyt4qUY7hTKHfHA=;
        b=CG1QSSq8FCt3nnC2DxuvfJJIRj7YstcQt4Zd5X4aG3gqEPdH55wHRAke6njraP6D4e
         Oh18Z+IGDTpH1adE6Q4CnHMyQwZ8N2CaxLgJM92JiQx5IMjXKq732AYGQXF8YcxiJc/O
         vV/UYTqHYEf1Pl790fy4Fa5hUVB3dlrE3+RcO6Adi6WQaxSQTnTsXXgcPig87SIhpYwR
         I4kru94Kt7ONtH+iBiUopuCYA4ZIi3MdhrwcHf44LoSdHNm7oVgI9D74c7Y97s9dVFQi
         1uxWynSmQZixsYnbhEpSeVtsNshvf5NkpWiSBW4b3a6wIogyrf2qUp3E7E4g0UtBPp1Z
         szag==
X-Gm-Message-State: AOJu0YyYukefcguELazIq1EYT2JLlWFjDOoSDuyk2fl4U77alopx/Qjc
        w/mz+FEyk7r5YYUV82mpRW6kaP0cA6n9RQflzQupGdUMypjrodo=
X-Google-Smtp-Source: AGHT+IHEhtAMFcl9wY0Wv0yiKVpLuDC++0Ih9uQMYGaV7rcmMuhSNXhKiD5GfNA7YjwE4fD6nnQKUN+S/X2Jybt3C/9tCCMdbtW2
MIME-Version: 1.0
X-Received: by 2002:a54:4482:0:b0:3ae:1691:c59f with SMTP id
 v2-20020a544482000000b003ae1691c59fmr6533057oiv.1.1698984483407; Thu, 02 Nov
 2023 21:08:03 -0700 (PDT)
Date:   Thu, 02 Nov 2023 21:08:03 -0700
In-Reply-To: <20231103011803.3249005-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009cccd6060937a639@google.com>
Subject: Re: [syzbot] [iommu?] KASAN: slab-use-after-free Read in iommufd_vfio_ioas
From:   syzbot <syzbot+d31adfb277377ef8fcba@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, lizhi.xu@windriver.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
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
BUG: KASAN: slab-use-after-free in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: slab-use-after-free in atomic_long_read include/linux/atomic/atomic-instrumented.h:3160 [inline]
BUG: KASAN: slab-use-after-free in is_rwsem_reader_owned kernel/locking/rwsem.c:193 [inline]
BUG: KASAN: slab-use-after-free in __up_read+0xce/0x750 kernel/locking/rwsem.c:1343
Read of size 8 at addr ffff88807db5a800 by task syz-executor.4/6650

CPU: 0 PID: 6650 Comm: syz-executor.4 Not tainted 6.6.0-rc7-syzkaller-00195-g2af9b20dbb39-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 check_region_inline mm/kasan/generic.c:181 [inline]
 kasan_check_range+0xef/0x190 mm/kasan/generic.c:187
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 atomic_long_read include/linux/atomic/atomic-instrumented.h:3160 [inline]
 is_rwsem_reader_owned kernel/locking/rwsem.c:193 [inline]
 __up_read+0xce/0x750 kernel/locking/rwsem.c:1343
 iommufd_put_object drivers/iommu/iommufd/iommufd_private.h:149 [inline]
 iommufd_vfio_ioas+0x47a/0x5a0 drivers/iommu/iommufd/vfio_compat.c:148
 iommufd_fops_ioctl+0x347/0x4d0 drivers/iommu/iommufd/main.c:398
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f6c5a87cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6c5b60d0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f6c5a99c050 RCX: 00007f6c5a87cae9
RDX: 0000000020000080 RSI: 0000000000003b88 RDI: 0000000000000003
RBP: 00007f6c5a8c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f6c5a99c050 R15: 00007ffecfcd2da8
 </TASK>

Allocated by task 6649:
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
 iommufd_fops_ioctl+0x347/0x4d0 drivers/iommu/iommufd/main.c:398
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 6651:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x28/0x40 mm/kasan/generic.c:522
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x138/0x190 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:164 [inline]
 __cache_free mm/slab.c:3370 [inline]
 __do_kmem_cache_free mm/slab.c:3557 [inline]
 __kmem_cache_free+0xcc/0x2d0 mm/slab.c:3564
 iommufd_destroy+0x11e/0x180 drivers/iommu/iommufd/main.c:216
 iommufd_fops_ioctl+0x347/0x4d0 drivers/iommu/iommufd/main.c:398
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff88807db5a800
 which belongs to the cache kmalloc-cg-1k of size 1024
The buggy address is located 0 bytes inside of
 freed 1024-byte region [ffff88807db5a800, ffff88807db5ac00)

The buggy address belongs to the physical page:
page:ffffea0001f6d680 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7db5a
memcg:ffff888063c85681
flags: 0xfff00000000800(slab|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0x2()
raw: 00fff00000000800 ffff888012c4d800 ffffea0000af4c50 ffffea0001e64e10
raw: 0000000000000000 ffff88807db5a000 0000000100000002 ffff888063c85681
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2420c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_COMP|__GFP_THISNODE), pid 4892, tgid 4892 (dhcpcd-run-hook), ts 66035864217, free_ts 66034134175
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
 __kmalloc+0x4f/0x100 mm/slab_common.c:1039
 kmalloc_array include/linux/slab.h:636 [inline]
 kcalloc include/linux/slab.h:667 [inline]
 alloc_pipe_info+0x1ed/0x580 fs/pipe.c:808
 get_pipe_inode fs/pipe.c:882 [inline]
 create_pipe_files+0x8f/0x870 fs/pipe.c:914
 __do_pipe_flags fs/pipe.c:963 [inline]
 do_pipe2+0xb0/0x1c0 fs/pipe.c:1014
 __do_sys_pipe2 fs/pipe.c:1032 [inline]
 __se_sys_pipe2 fs/pipe.c:1030 [inline]
 __x64_sys_pipe2+0x54/0x80 fs/pipe.c:1030
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1136 [inline]
 free_unref_page_prepare+0x476/0xa40 mm/page_alloc.c:2312
 free_unref_page+0x33/0x3b0 mm/page_alloc.c:2405
 skb_free_frag include/linux/skbuff.h:3260 [inline]
 skb_free_head+0xa6/0x1b0 net/core/skbuff.c:955
 skb_release_data+0x5ba/0x870 net/core/skbuff.c:987
 skb_release_all net/core/skbuff.c:1053 [inline]
 __kfree_skb net/core/skbuff.c:1067 [inline]
 skb_attempt_defer_free+0x3bc/0x570 net/core/skbuff.c:6817
 tcp_eat_recv_skb net/ipv4/tcp.c:1511 [inline]
 tcp_recvmsg_locked+0x10a8/0x24a0 net/ipv4/tcp.c:2522
 tcp_recvmsg+0x12e/0x670 net/ipv4/tcp.c:2568
 inet_recvmsg+0x114/0x630 net/ipv4/af_inet.c:878
 sock_recvmsg_nosec net/socket.c:1044 [inline]
 sock_recvmsg+0xe2/0x170 net/socket.c:1066
 sock_read_iter+0x2c3/0x3c0 net/socket.c:1136
 call_read_iter include/linux/fs.h:1950 [inline]
 new_sync_read fs/read_write.c:389 [inline]
 vfs_read+0x7ef/0x930 fs/read_write.c:470
 ksys_read+0x1f0/0x250 fs/read_write.c:613
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88807db5a700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88807db5a780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88807db5a800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff88807db5a880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807db5a900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         2af9b20d Merge tag 'x86-urgent-2023-10-28' of git://gi..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11260fd7680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb98fe061049a6e4
dashboard link: https://syzkaller.appspot.com/bug?extid=d31adfb277377ef8fcba
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14cde6bb680000

