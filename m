Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7B575E090
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 11:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjGWJFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 05:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjGWJFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 05:05:01 -0400
Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AA512D
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 02:05:00 -0700 (PDT)
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-56768da274aso6096011eaf.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 02:05:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690103099; x=1690707899;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Z7PC83KsxoVU5Bzl33X/u0SPn6MRJplL3HDqlvZzBo=;
        b=BWD+Gzq+vk1ZIG3TKHolCmP5XYq7R3NDDLsMuGQKpTXbt1V0NovA0Rc8pL4BuU+3kD
         sgwrF7LXGGtUg7W/t3VY6Nb+XzxfDmB8nmIL+ulDboVqtjXBwT5ASkhKL+/OQii3a+L1
         8LSPqCjF7NkyP+nadsf41tRZhi6lXwmIrZLSGndDv6BJhmfdN42ZYGKgko01hjV/B7lJ
         U8ji0pRixrdml53SNA82GX4Qprz+Z9zKNj+Xib/wsGaP3tCXb1Jd0GiD5n5ZvQQrJVUB
         aLsBQDphwtjwJoqql949RhoTP4infZgnLESYrloofrZsAvMFDssbVg6oxCPUpGEJ9J9r
         lY4g==
X-Gm-Message-State: ABy/qLayfhlgZOOW4lDblfoViGWPz8rC/8YgMqvJknuLbX/W0UtwtZcb
        lpRxFAPcgw0DNJ8NOOqWvhgAU9b82IoKRG3yauV364GdQPkG
X-Google-Smtp-Source: APBJJlFQdcYY9cg4tNJFXkSCa1L1k1gByIFG2HQ+CcpbR4gCIBed9LPe9W1c/hYlg7t3WoCKihk+K/4ERFJb9mL4C/r1mM3HPACw
MIME-Version: 1.0
X-Received: by 2002:a05:6808:210e:b0:3a3:edca:2950 with SMTP id
 r14-20020a056808210e00b003a3edca2950mr13320629oiw.5.1690103099730; Sun, 23
 Jul 2023 02:04:59 -0700 (PDT)
Date:   Sun, 23 Jul 2023 02:04:59 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e4b0f0060123ca40@google.com>
Subject: [syzbot] [mm?] KASAN: slab-use-after-free Read in madvise_collapse
From:   syzbot <syzbot+173cc8cfdfbbef6dd755@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
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

syzbot found the following issue on:

HEAD commit:    ae867bc97b71 Add linux-next specific files for 20230721
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1553a881a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c403a6b36e7c85ac
dashboard link: https://syzkaller.appspot.com/bug?extid=173cc8cfdfbbef6dd755
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1076d84aa80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=161debd1a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a76b93f21f84/disk-ae867bc9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8eb30097a952/vmlinux-ae867bc9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7506a6b3ec38/bzImage-ae867bc9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+173cc8cfdfbbef6dd755@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in madvise_collapse+0xa6c/0xb50 mm/khugepaged.c:2723
Read of size 8 at addr ffff88802b4e6588 by task syz-executor296/5046

CPU: 0 PID: 5046 Comm: syz-executor296 Not tainted 6.5.0-rc2-next-20230721-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 madvise_collapse+0xa6c/0xb50 mm/khugepaged.c:2723
 madvise_vma_behavior+0x200/0x1e60 mm/madvise.c:1094
 madvise_walk_vmas+0x1cf/0x2c0 mm/madvise.c:1268
 do_madvise+0x333/0x660 mm/madvise.c:1448
 __do_sys_madvise mm/madvise.c:1461 [inline]
 __se_sys_madvise mm/madvise.c:1459 [inline]
 __x64_sys_madvise+0xaa/0x110 mm/madvise.c:1459
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f7ec298d359
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7ec292d238 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
RAX: ffffffffffffffda RBX: 00007f7ec2a17318 RCX: 00007f7ec298d359
RDX: 0000000000000019 RSI: 000000000060005f RDI: 0000000020000000
RBP: 00007f7ec2a17310 R08: 00007fffd329edf7 R09: 00007f7ec292d6c0
R10: 0000000000000000 R11: 0000000000000246 R12: b635773f07ebbeea
R13: 000000000000006e R14: 00007fffd329ed10 R15: 00007fffd329edf8
 </TASK>

Allocated by task 5033:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 __kasan_slab_alloc+0x81/0x90 mm/kasan/common.c:328
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook mm/slab.h:762 [inline]
 slab_alloc_node mm/slub.c:3478 [inline]
 slab_alloc mm/slub.c:3486 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
 kmem_cache_alloc+0x172/0x3b0 mm/slub.c:3502
 vm_area_alloc+0x1f/0x220 kernel/fork.c:485
 mmap_region+0x386/0x2640 mm/mmap.c:2717
 do_mmap+0x87c/0xed0 mm/mmap.c:1353
 vm_mmap_pgoff+0x1a6/0x3b0 mm/util.c:543
 ksys_mmap_pgoff+0x7d/0x5b0 mm/mmap.c:1399
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 5035:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:522
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x15e/0x1b0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:162 [inline]
 slab_free_hook mm/slub.c:1800 [inline]
 slab_free_freelist_hook+0x114/0x1e0 mm/slub.c:1826
 slab_free mm/slub.c:3809 [inline]
 kmem_cache_free+0xf0/0x490 mm/slub.c:3831
 rcu_do_batch kernel/rcu/tree.c:2139 [inline]
 rcu_core+0x7fb/0x1bb0 kernel/rcu/tree.c:2403
 __do_softirq+0x218/0x965 kernel/softirq.c:553

Last potentially related work creation:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:492
 __call_rcu_common.constprop.0+0x9a/0x790 kernel/rcu/tree.c:2653
 remove_vma+0x140/0x170 mm/mmap.c:148
 remove_mt mm/mmap.c:2285 [inline]
 do_vmi_align_munmap+0xf75/0x1710 mm/mmap.c:2547
 do_vmi_munmap+0x20e/0x450 mm/mmap.c:2611
 mmap_region+0x194/0x2640 mm/mmap.c:2661
 do_mmap+0x87c/0xed0 mm/mmap.c:1353
 vm_mmap_pgoff+0x1a6/0x3b0 mm/util.c:543
 ksys_mmap_pgoff+0x7d/0x5b0 mm/mmap.c:1399
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff88802b4e6500
 which belongs to the cache vm_area_struct of size 192
The buggy address is located 136 bytes inside of
 freed 192-byte region [ffff88802b4e6500, ffff88802b4e65c0)

The buggy address belongs to the physical page:
page:ffffea0000ad3980 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2b4e6
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000200 ffff888014674b40 ffffea0001dce680 dead000000000002
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 4724, tgid 4724 (dhcpcd-run-hook), ts 33134643925, free_ts 33125953991
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2d2/0x350 mm/page_alloc.c:1569
 prep_new_page mm/page_alloc.c:1576 [inline]
 get_page_from_freelist+0x10d7/0x31b0 mm/page_alloc.c:3256
 __alloc_pages+0x1d0/0x4a0 mm/page_alloc.c:4512
 alloc_pages+0x1a9/0x270 mm/mempolicy.c:2279
 alloc_slab_page mm/slub.c:1870 [inline]
 allocate_slab+0x24e/0x380 mm/slub.c:2017
 new_slab mm/slub.c:2070 [inline]
 ___slab_alloc+0x8bc/0x1570 mm/slub.c:3223
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3322
 __slab_alloc_node mm/slub.c:3375 [inline]
 slab_alloc_node mm/slub.c:3468 [inline]
 slab_alloc mm/slub.c:3486 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
 kmem_cache_alloc+0x392/0x3b0 mm/slub.c:3502
 vm_area_alloc+0x1f/0x220 kernel/fork.c:485
 mmap_region+0x386/0x2640 mm/mmap.c:2717
 do_mmap+0x87c/0xed0 mm/mmap.c:1353
 vm_mmap_pgoff+0x1a6/0x3b0 mm/util.c:543
 ksys_mmap_pgoff+0x422/0x5b0 mm/mmap.c:1399
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1160 [inline]
 free_unref_page_prepare+0x508/0xb90 mm/page_alloc.c:2383
 free_unref_page+0x33/0x3b0 mm/page_alloc.c:2478
 vfree+0x181/0x7a0 mm/vmalloc.c:2842
 delayed_vfree_work+0x56/0x70 mm/vmalloc.c:2763
 process_one_work+0xaa2/0x16f0 kernel/workqueue.c:2600
 worker_thread+0x687/0x1110 kernel/workqueue.c:2751
 kthread+0x33a/0x430 kernel/kthread.c:389
 ret_from_fork+0x2c/0x70 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:296

Memory state around the buggy address:
 ffff88802b4e6480: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
 ffff88802b4e6500: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88802b4e6580: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
                      ^
 ffff88802b4e6600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88802b4e6680: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
