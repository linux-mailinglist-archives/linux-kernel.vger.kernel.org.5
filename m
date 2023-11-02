Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC3F87DFD28
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 00:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377558AbjKBXDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 19:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234773AbjKBXDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 19:03:35 -0400
Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378B6181
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 16:03:29 -0700 (PDT)
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-3b56bf3d7a9so2277710b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 16:03:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698966208; x=1699571008;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0hp00lgwf/F76NsEWIxA/kWLcn0cy6Nk29JiYM9cV+8=;
        b=Ic/5kZEjLYlxx9/GnfczGnMmnrWFcoMbYrt4VXD0ra4fKDhbvMHIwzPWkS/YCcQWiT
         mHgeXMMJx4zK5JV14lQjlRqx01MKReHXP+RwP+nsibYQnWUEgA03T8L643v7X7dYrc0I
         IieRzeB25Is2uqxqKJ30Vg4ztMs9Ngitn3NClu7i7KhZTsiW088cpoDeqrQGXuXrnXyo
         y+YeNnUQHIIrNot6CDe2YUT5seRDgWMI65Bx9GMYxfgElJM13l1XPOE3iN7PxUNWQ6pM
         Iscdvk0Wh8A5zvLuFX7o4IFipaRqNOmXMt1DMM65w+1e395PzF6XnOBRf9ubjIYmcGUZ
         N92g==
X-Gm-Message-State: AOJu0YwKfcTp5Be7fFhJX3FMVaR7g0vz75ImkkblNbZ5laIKBHp0PszM
        IH7FQDGvw0JOqZpHyTSAjNCvQdvhkhSoLii/Rov3SimHsvc3
X-Google-Smtp-Source: AGHT+IE8jk1VHumpO1mm/VthuEIo/+SB5YSn/IVcdVMwbHkyIAvfViEAs0+zA1SckCaVhumo+JX7QhKKvwLjKqPAYtscVxM1cFiA
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1cc:b0:3a4:1e93:8988 with SMTP id
 x12-20020a05680801cc00b003a41e938988mr6144672oic.10.1698966208374; Thu, 02
 Nov 2023 16:03:28 -0700 (PDT)
Date:   Thu, 02 Nov 2023 16:03:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000055ef9a0609336580@google.com>
Subject: [syzbot] [iommu?] KASAN: slab-use-after-free Read in iommufd_vfio_ioas
From:   syzbot <syzbot+d31adfb277377ef8fcba@syzkaller.appspotmail.com>
To:     iommu@lists.linux.dev, jgg@nvidia.com, jgg@ziepe.ca,
        joro@8bytes.org, kevin.tian@intel.com,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        syzkaller-bugs@googlegroups.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    2af9b20dbb39 Merge tag 'x86-urgent-2023-10-28' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=114a6a73680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb98fe061049a6e4
dashboard link: https://syzkaller.appspot.com/bug?extid=d31adfb277377ef8fcba
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=122fb4d1680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1330c151680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/073dcbc6250b/disk-2af9b20d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/842a91197227/vmlinux-2af9b20d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/760ca08d7937/bzImage-2af9b20d.xz

The issue was bisected to:

commit 99f98a7c0d6985d5507c8130a981972e4b7b3bdc
Author: Jason Gunthorpe <jgg@nvidia.com>
Date:   Tue Jul 25 19:05:49 2023 +0000

    iommufd: IOMMUFD_DESTROY should not increase the refcount

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=125266e7680000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=115266e7680000
console output: https://syzkaller.appspot.com/x/log.txt?x=165266e7680000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d31adfb277377ef8fcba@syzkaller.appspotmail.com
Fixes: 99f98a7c0d69 ("iommufd: IOMMUFD_DESTROY should not increase the refcount")

==================================================================
BUG: KASAN: slab-use-after-free in __up_read+0x627/0x750 kernel/locking/rwsem.c:1342
Read of size 8 at addr ffff888073cde868 by task syz-executor934/6535

CPU: 1 PID: 6535 Comm: syz-executor934 Not tainted 6.6.0-rc7-syzkaller-00195-g2af9b20dbb39 #0
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
 iommufd_fops_ioctl+0x347/0x4d0 drivers/iommu/iommufd/main.c:398
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0x18f/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f7d7a6505d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7d7a5f0218 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000037 RCX: 00007f7d7a6505d9
RDX: 0000000020000080 RSI: 0000000000003b88 RDI: 0000000000000003
RBP: 00007f7d7a6da358 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f7d7a6d8100
R13: 00007f7d7a6da350 R14: 00007f7d7a6da35c R15: 00007f7d7a6a7074
 </TASK>

Allocated by task 6529:
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

Freed by task 6536:
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

The buggy address belongs to the object at ffff888073cde800
 which belongs to the cache kmalloc-cg-1k of size 1024
The buggy address is located 104 bytes inside of
 freed 1024-byte region [ffff888073cde800, ffff888073cdec00)

The buggy address belongs to the physical page:
page:ffffea0001cf3780 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x73cde
flags: 0xfff00000000800(slab|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0x2()
raw: 00fff00000000800 ffff888012c4d800 ffffea000082b690 ffffea0000712a10
raw: 0000000000000000 ffff888073cde000 0000000100000002 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2420c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_COMP|__GFP_THISNODE), pid 4488, tgid 4488 (udevd), ts 55677988515, free_ts 55675597837
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
 selinux_genfs_get_sid security/selinux/hooks.c:1341 [inline]
 inode_doinit_with_dentry+0xac0/0x12c0 security/selinux/hooks.c:1539
 selinux_d_instantiate+0x26/0x30 security/selinux/hooks.c:6284
 security_d_instantiate+0x54/0xe0 security/security.c:3799
 d_splice_alias+0x94/0xdf0 fs/dcache.c:3145
 kernfs_iop_lookup+0x283/0x330 fs/kernfs/dir.c:1208
 __lookup_slow+0x24d/0x450 fs/namei.c:1694
 lookup_slow fs/namei.c:1711 [inline]
 walk_component+0x349/0x5a0 fs/namei.c:2002
 lookup_last fs/namei.c:2459 [inline]
 path_lookupat+0x17f/0x770 fs/namei.c:2483
 filename_lookup+0x1e7/0x5b0 fs/namei.c:2512
 vfs_statx+0x160/0x430 fs/stat.c:240
 vfs_fstatat+0xb3/0x140 fs/stat.c:295
 __do_sys_newfstatat+0x98/0x110 fs/stat.c:459
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff888073cde700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888073cde780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888073cde800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                          ^
 ffff888073cde880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888073cde900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
