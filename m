Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D793E7708BA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 21:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjHDTNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 15:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjHDTNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 15:13:34 -0400
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA89AC
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 12:13:32 -0700 (PDT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3a3df1d46e5so3696888b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 12:13:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691176412; x=1691781212;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sfA6D4sqJtr1YGwqPMe0SpPMxDGMsLKvSj1fjjFvTHU=;
        b=gBiaY2wxM4lqlLqXi4d2zGvrMr+Mb75d5T+6N/KlRkOjEuBIR227qpS3S40peJR9d5
         SF+XWZke0zGR2O4VRHKvnwFY7q9Nt/OEeQvzYFc55xpBUWJm/V642QacM/9VYg7c8CEm
         If+4UpM8JSmRT47sV4QejLC8EUbEZ+v1Zv1bzF5TxPynlV31rhAyxmtClYHaU4ktZp9r
         9Gw0M/yIuZpCh+OVQEShnccrfDDMJAWGcxUqKO+Yu1p71S6pSZBVEi4P3K7FR4lfFzgd
         ia3tX8r929uqzr52LMk16guZ7xZC8STWX5sAUZnkXoGHT51weWPCe+KoZuhPLRnJDuYy
         FzxQ==
X-Gm-Message-State: AOJu0YzE39YcSXxUQapdn+UrY5dQfL4HcmGLpfhYwq3boFkPXOB0GR0p
        ewvCN7uvNpC+9nhBI9BLnQ6FsNisejJ3383pfDmqpnjg2zF+
X-Google-Smtp-Source: AGHT+IFQrNbIhu0N6SBngiuMcQofZDMewV2TcrDgTb7gPsMZEl7VQzwWxhuzNF3q2lcuyjo0064OJPU0hK6zBq+946PB0KfOUdWU
MIME-Version: 1.0
X-Received: by 2002:a05:6808:198b:b0:3a7:75cd:df61 with SMTP id
 bj11-20020a056808198b00b003a775cddf61mr3827284oib.5.1691176412068; Fri, 04
 Aug 2023 12:13:32 -0700 (PDT)
Date:   Fri, 04 Aug 2023 12:13:32 -0700
In-Reply-To: <20230804125406.1583-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004b404f06021db1c4@google.com>
Subject: Re: [syzbot] [fs?] KASAN: slab-use-after-free Read in test_bdev_super_fc
From:   syzbot <syzbot+2faac0423fdc9692822b@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in grab_super

MTD: Attempt to mount non-MTD device "/dev/nullb0"
==================================================================
BUG: KASAN: slab-use-after-free in owner_on_cpu include/linux/sched.h:2306 [inline]
BUG: KASAN: slab-use-after-free in rwsem_can_spin_on_owner kernel/locking/rwsem.c:725 [inline]
BUG: KASAN: slab-use-after-free in rwsem_down_write_slowpath+0xec2/0x1290 kernel/locking/rwsem.c:1113
Read of size 4 at addr ffff888021833bb4 by task syz-executor.1/5704

CPU: 0 PID: 5704 Comm: syz-executor.1 Not tainted 6.5.0-rc3-next-20230728-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 owner_on_cpu include/linux/sched.h:2306 [inline]
 rwsem_can_spin_on_owner kernel/locking/rwsem.c:725 [inline]
 rwsem_down_write_slowpath+0xec2/0x1290 kernel/locking/rwsem.c:1113
 __down_write_common kernel/locking/rwsem.c:1306 [inline]
 __down_write kernel/locking/rwsem.c:1315 [inline]
 down_write+0x1d3/0x200 kernel/locking/rwsem.c:1574
 grab_super+0x5d/0x2a0 fs/super.c:385
 sget_fc+0x5d1/0x860 fs/super.c:612
 get_tree_bdev+0x13e/0x6a0 fs/super.c:1324
 romfs_get_tree fs/romfs/super.c:561 [inline]
 romfs_get_tree+0x4e/0x60 fs/romfs/super.c:552
 vfs_get_tree+0x88/0x350 fs/super.c:1522
 do_new_mount fs/namespace.c:3335 [inline]
 path_mount+0x1492/0x1ed0 fs/namespace.c:3662
 do_mount fs/namespace.c:3675 [inline]
 __do_sys_mount fs/namespace.c:3884 [inline]
 __se_sys_mount fs/namespace.c:3861 [inline]
 __x64_sys_mount+0x293/0x310 fs/namespace.c:3861
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fcba847cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fcba77dd0c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fcba859c050 RCX: 00007fcba847cae9
RDX: 0000000020000040 RSI: 0000000020000080 RDI: 00000000200000c0
RBP: 00007fcba84c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000005 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007fcba859c050 R15: 00007fff1814fcf8
 </TASK>

Allocated by task 5683:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 __kasan_slab_alloc+0x81/0x90 mm/kasan/common.c:328
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook mm/slab.h:762 [inline]
 slab_alloc_node mm/slub.c:3478 [inline]
 kmem_cache_alloc_node+0x185/0x3f0 mm/slub.c:3523
 alloc_task_struct_node kernel/fork.c:173 [inline]
 dup_task_struct kernel/fork.c:1113 [inline]
 copy_process+0x41c/0x7400 kernel/fork.c:2338
 kernel_clone+0xfd/0x930 kernel/fork.c:2920
 __do_sys_clone3+0x1f1/0x260 kernel/fork.c:3221
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 15:
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
 put_task_struct include/linux/sched/task.h:136 [inline]
 put_task_struct include/linux/sched/task.h:123 [inline]
 delayed_put_task_struct+0x246/0x2c0 kernel/exit.c:228
 rcu_do_batch kernel/rcu/tree.c:2139 [inline]
 rcu_core+0x7fb/0x1bb0 kernel/rcu/tree.c:2403
 __do_softirq+0x218/0x965 kernel/softirq.c:553

Last potentially related work creation:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:492
 __call_rcu_common.constprop.0+0x9a/0x790 kernel/rcu/tree.c:2653
 put_task_struct_rcu_user kernel/exit.c:234 [inline]
 put_task_struct_rcu_user+0x87/0xc0 kernel/exit.c:231
 context_switch kernel/sched/core.c:5385 [inline]
 __schedule+0xee9/0x59f0 kernel/sched/core.c:6711
 schedule+0xe7/0x1b0 kernel/sched/core.c:6787
 futex_wait_queue+0xf9/0x1f0 kernel/futex/waitwake.c:366
 futex_wait+0x314/0x6d0 kernel/futex/waitwake.c:667
 do_futex+0x224/0x350 kernel/futex/syscalls.c:102
 __do_sys_futex kernel/futex/syscalls.c:179 [inline]
 __se_sys_futex kernel/futex/syscalls.c:160 [inline]
 __x64_sys_futex+0x1e1/0x4c0 kernel/futex/syscalls.c:160
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Second to last potentially related work creation:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:492
 __call_rcu_common.constprop.0+0x9a/0x790 kernel/rcu/tree.c:2653
 put_task_struct_rcu_user kernel/exit.c:234 [inline]
 put_task_struct_rcu_user+0x87/0xc0 kernel/exit.c:231
 release_task+0xf0a/0x1b90 kernel/exit.c:284
 wait_task_zombie kernel/exit.c:1192 [inline]
 wait_consider_task+0x17ca/0x4030 kernel/exit.c:1419
 do_wait_thread kernel/exit.c:1482 [inline]
 __do_wait+0x23c/0x870 kernel/exit.c:1601
 do_wait+0x1cb/0x4c0 kernel/exit.c:1634
 kernel_wait4+0x16d/0x280 kernel/exit.c:1794
 __do_sys_wait4+0x15b/0x170 kernel/exit.c:1822
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888021833b80
 which belongs to the cache task_struct of size 7360
The buggy address is located 52 bytes inside of
 freed 7360-byte region [ffff888021833b80, ffff888021835840)

The buggy address belongs to the physical page:
page:ffffea0000860c00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x21830
head:ffffea0000860c00 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff88802b2d5e01
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000010200 ffff888014674500 ffffea0000904a00 dead000000000002
raw: 0000000000000000 0000000000040004 00000001ffffffff ffff88802b2d5e01
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4952, tgid 4952 (dhcpcd-run-hook), ts 37131998344, free_ts 37098705574
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
 kmem_cache_alloc_node+0x137/0x3f0 mm/slub.c:3523
 alloc_task_struct_node kernel/fork.c:173 [inline]
 dup_task_struct kernel/fork.c:1113 [inline]
 copy_process+0x41c/0x7400 kernel/fork.c:2338
 kernel_clone+0xfd/0x930 kernel/fork.c:2920
 __do_sys_clone+0xba/0x100 kernel/fork.c:3063
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1160 [inline]
 free_unref_page_prepare+0x508/0xb90 mm/page_alloc.c:2383
 free_unref_page+0x33/0x3b0 mm/page_alloc.c:2478
 __unfreeze_partials+0x21d/0x240 mm/slub.c:2655
 qlink_free mm/kasan/quarantine.c:166 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:185
 kasan_quarantine_reduce+0x18b/0x1d0 mm/kasan/quarantine.c:292
 __kasan_slab_alloc+0x65/0x90 mm/kasan/common.c:305
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook mm/slab.h:762 [inline]
 slab_alloc_node mm/slub.c:3478 [inline]
 slab_alloc mm/slub.c:3486 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3493 [inline]
 kmem_cache_alloc+0x172/0x3b0 mm/slub.c:3502
 getname_flags.part.0+0x50/0x4d0 fs/namei.c:140
 getname_flags include/linux/audit.h:319 [inline]
 getname+0x90/0xe0 fs/namei.c:219
 do_sys_openat2+0x100/0x1e0 fs/open.c:1412
 do_sys_open fs/open.c:1433 [inline]
 __do_sys_openat fs/open.c:1449 [inline]
 __se_sys_openat fs/open.c:1444 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1444
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff888021833a80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888021833b00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888021833b80: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                     ^
 ffff888021833c00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888021833c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         d7b3af5a Add linux-next specific files for 20230728
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16c3ddd5a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=62dd327c382e3fe
dashboard link: https://syzkaller.appspot.com/bug?extid=2faac0423fdc9692822b
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10e0160da80000

