Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208907B3E62
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 07:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbjI3FPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 01:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjI3FPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 01:15:37 -0400
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C2FB9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 22:15:34 -0700 (PDT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6be515ec5d2so28705807a34.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 22:15:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696050934; x=1696655734;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kDaVE+7sOLuKLfCYjVnxg1WlVHuYKKdqp6UNpAPVfpw=;
        b=b5hKgU32ctOAgJ8A/hxkLg/q1VAoRDfyaFvidDz9H5wkp6FGXtBhciDksuScIgV47t
         xkZUU8dcVUs+IXr18KpyyW5eZ7S1Nx+6V1F4+420LiQpprJjVVe7f3q3ehtmZnljGLFV
         hE2J0GepK2bt2YgkCWO+PEzX1wUr2UOGXCOj6gBqWbwgzZeT2XKWRQef1smYWiRQwYVG
         kxpML5aLQMxR6g2GBL2ODBJzSzfsRT9I2pJGa88Wle5gNm4p0hZQvA0iJXb8cc4MRvFk
         /0mJJkWwSvP4goC65TFOctXO5lyk23DhR1yHkJsxFIa2toMnFZYY089qQVvegGPiS7dl
         dCYQ==
X-Gm-Message-State: AOJu0YyW/MU4lCIJvT3rDaZ9+b0Ey6Yo0BmGzr9DrpCrk3qvh7M2Y/23
        Y6+XOixtflW4HVIpXXW+7haIpW2d3AsuGsX8sdlND5eHJm7E
X-Google-Smtp-Source: AGHT+IEOHIht/bQ+HeQ56XN/0M3tCY+XBrz4mGs7FudYqRv4gE/+qIj5IRRxEoiWjCKZGv17Z0Ig4/kqxDeXNpD8xfy/zwYre53n
MIME-Version: 1.0
X-Received: by 2002:a9d:7dc8:0:b0:6bc:fb26:499e with SMTP id
 k8-20020a9d7dc8000000b006bcfb26499emr1901860otn.2.1696050934250; Fri, 29 Sep
 2023 22:15:34 -0700 (PDT)
Date:   Fri, 29 Sep 2023 22:15:34 -0700
In-Reply-To: <20230930045452.1463-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000075038506068ca189@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in tls_encrypt_done
From:   syzbot <syzbot+29c22ea2d6b2c5fd2eae@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in tls_encrypt_done

==================================================================
BUG: KASAN: slab-use-after-free in debug_spin_unlock kernel/locking/spinlock_debug.c:99 [inline]
BUG: KASAN: slab-use-after-free in do_raw_spin_unlock+0x1f7/0x230 kernel/locking/spinlock_debug.c:140
Read of size 4 at addr ffff88801ed8493c by task kworker/3:2/813

CPU: 3 PID: 813 Comm: kworker/3:2 Not tainted 6.6.0-rc3-syzkaller-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: pencrypt_serial padata_serial_worker
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 debug_spin_unlock kernel/locking/spinlock_debug.c:99 [inline]
 do_raw_spin_unlock+0x1f7/0x230 kernel/locking/spinlock_debug.c:140
 __raw_spin_unlock_bh include/linux/spinlock_api_smp.h:166 [inline]
 _raw_spin_unlock_bh+0x1e/0x30 kernel/locking/spinlock.c:210
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 tls_encrypt_done+0x281/0x560 net/tls/tls_sw.c:488
 padata_serial_worker+0x246/0x490 kernel/padata.c:378
 process_one_work+0x884/0x15c0 kernel/workqueue.c:2630
 process_scheduled_works kernel/workqueue.c:2703 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2784
 kthread+0x33c/0x440 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
 </TASK>

Allocated by task 7577:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0xa3/0xb0 mm/kasan/common.c:383
 kmalloc include/linux/slab.h:599 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 tls_set_sw_offload+0x12e0/0x1700 net/tls/tls_sw.c:2606
 do_tls_setsockopt_conf net/tls/tls_main.c:666 [inline]
 do_tls_setsockopt net/tls/tls_main.c:771 [inline]
 tls_setsockopt+0x108c/0x1340 net/tls/tls_main.c:799
 __sys_setsockopt+0x2cd/0x5b0 net/socket.c:2308
 __do_sys_setsockopt net/socket.c:2319 [inline]
 __se_sys_setsockopt net/socket.c:2316 [inline]
 __x64_sys_setsockopt+0xbd/0x150 net/socket.c:2316
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 7576:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x28/0x40 mm/kasan/generic.c:522
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x138/0x190 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:164 [inline]
 __cache_free mm/slab.c:3370 [inline]
 __do_kmem_cache_free mm/slab.c:3557 [inline]
 __kmem_cache_free+0xcc/0x2d0 mm/slab.c:3564
 tls_sk_proto_close+0x5ce/0xac0 net/tls/tls_main.c:389
 inet_release+0x132/0x270 net/ipv4/af_inet.c:433
 inet6_release+0x4f/0x70 net/ipv6/af_inet6.c:484
 __sock_release+0xae/0x260 net/socket.c:659
 sock_close+0x1c/0x20 net/socket.c:1402
 __fput+0x3f7/0xa70 fs/file_table.c:384
 __fput_sync+0x47/0x50 fs/file_table.c:465
 __do_sys_close fs/open.c:1572 [inline]
 __se_sys_close fs/open.c:1557 [inline]
 __x64_sys_close+0x87/0xf0 fs/open.c:1557
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Last potentially related work creation:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 __kasan_record_aux_stack+0x78/0x80 mm/kasan/generic.c:492
 kvfree_call_rcu+0x70/0xbe0 kernel/rcu/tree.c:3372
 tls_ctx_free net/tls/tls_main.c:333 [inline]
 tls_ctx_free+0x69/0x90 net/tls/tls_main.c:323
 tls_sk_proto_close+0x588/0xac0 net/tls/tls_main.c:397
 inet_release+0x132/0x270 net/ipv4/af_inet.c:433
 inet6_release+0x4f/0x70 net/ipv6/af_inet6.c:484
 __sock_release+0xae/0x260 net/socket.c:659
 sock_close+0x1c/0x20 net/socket.c:1402
 __fput+0x3f7/0xa70 fs/file_table.c:384
 __fput_sync+0x47/0x50 fs/file_table.c:465
 __do_sys_close fs/open.c:1572 [inline]
 __se_sys_close fs/open.c:1557 [inline]
 __x64_sys_close+0x87/0xf0 fs/open.c:1557
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Second to last potentially related work creation:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 __kasan_record_aux_stack+0x78/0x80 mm/kasan/generic.c:492
 kvfree_call_rcu+0x70/0xbe0 kernel/rcu/tree.c:3372
 tls_ctx_free net/tls/tls_main.c:333 [inline]
 tls_ctx_free+0x69/0x90 net/tls/tls_main.c:323
 tls_sk_proto_close+0x588/0xac0 net/tls/tls_main.c:397
 inet_release+0x132/0x270 net/ipv4/af_inet.c:433
 inet6_release+0x4f/0x70 net/ipv6/af_inet6.c:484
 __sock_release+0xae/0x260 net/socket.c:659
 sock_close+0x1c/0x20 net/socket.c:1402
 __fput+0x3f7/0xa70 fs/file_table.c:384
 __fput_sync+0x47/0x50 fs/file_table.c:465
 __do_sys_close fs/open.c:1572 [inline]
 __se_sys_close fs/open.c:1557 [inline]
 __x64_sys_close+0x87/0xf0 fs/open.c:1557
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff88801ed84800
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 316 bytes inside of
 freed 512-byte region [ffff88801ed84800, ffff88801ed84a00)

The buggy address belongs to the physical page:
page:ffffea00007b6100 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1ed84
flags: 0xfff00000000800(slab|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0x4()
raw: 00fff00000000800 ffff888012c40600 ffffea00008cf150 ffffea0000ee6e10
raw: 0000000000000000 ffff88801ed84000 0000000100000004 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x3420c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_COMP|__GFP_HARDWALL|__GFP_THISNODE), pid 5237, tgid 5237 (udevd), ts 60297213654, free_ts 60296881728
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
 kmalloc_trace+0x25/0xe0 mm/slab_common.c:1114
 kmalloc include/linux/slab.h:599 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 kernfs_fop_open+0x318/0xe00 fs/kernfs/file.c:670
 do_dentry_open+0x88b/0x1730 fs/open.c:929
 do_open fs/namei.c:3639 [inline]
 path_openat+0x19af/0x29c0 fs/namei.c:3796
 do_filp_open+0x1de/0x430 fs/namei.c:3823
 do_sys_openat2+0x176/0x1e0 fs/open.c:1422
 do_sys_open fs/open.c:1437 [inline]
 __do_sys_openat fs/open.c:1453 [inline]
 __se_sys_openat fs/open.c:1448 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1448
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
 __lookup_slow+0x24d/0x450 fs/namei.c:1693
 lookup_slow fs/namei.c:1710 [inline]
 walk_component+0x349/0x5a0 fs/namei.c:2001
 lookup_last fs/namei.c:2458 [inline]
 path_lookupat+0x17f/0x770 fs/namei.c:2482
 filename_lookup+0x1e7/0x5b0 fs/namei.c:2511
 vfs_statx+0x160/0x430 fs/stat.c:240
 vfs_fstatat+0xb3/0x140 fs/stat.c:295
 __do_sys_newfstatat+0x98/0x110 fs/stat.c:459
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88801ed84800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88801ed84880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88801ed84900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                        ^
 ffff88801ed84980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88801ed84a00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         6465e260 Linux 6.6-rc3
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10465026680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d7d7928f78936aa
dashboard link: https://syzkaller.appspot.com/bug?extid=29c22ea2d6b2c5fd2eae
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1084ea06680000

