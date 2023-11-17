Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFFD7EF6DE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 18:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbjKQRSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 12:18:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbjKQRSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 12:18:14 -0500
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25414AD
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 09:18:11 -0800 (PST)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2839a931608so893104a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 09:18:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700241490; x=1700846290;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VJfS9ybq8nmswLLUaSk47qeo4P5pbbdO9WmKxZ8IpmI=;
        b=ivhZMiLRY7XhrjjuMSbHdlFB90Po1nCu7PHNt4GsT/AKliLxEr72zXe+iHaNiJEhvf
         XZGZKY75cUCBSsiFJT83xym7nX5E/9gIvDkPAN8snEKqJBUBbv0O4IX4Bh3i5d9XieYN
         7vmwL68nHSPSBu2EzKwuBVc8jgAXYbEVssEUHB/cE8vYwdcbx4xxDWZORIMvZiUZDKwt
         OAdrRFHNGKoZo/1bQxURxpc0q8SP1vRZlUfgavax65Rkq1EvdqK8JKmnDWeZFa/7NnR2
         ZGbPV//8b/XExzFnQ69Qt9VprEsxFErVH4+6e5LS28Je//PU7FYUZmlpaN4Z1Ko/4cIE
         Lq1g==
X-Gm-Message-State: AOJu0YxBjaMOXVx+1uwbU+Ja1xxDKU2Ixme9VNg3VX2ibnaLqatC79ls
        tlNCvdxgq6DEBZ2+6PG32ajkfhMQ2W+kjSLC3vvgEbMmtdPFPNM=
X-Google-Smtp-Source: AGHT+IE2ecoyVGAuW+k5YTgcPgo+5JKPamRXGr7D3NHfjg+KfjrxO+QmaMgk6/mSDxZcOVVH0voa6y0wvZ1SAmjTXMVychcI2xBj
MIME-Version: 1.0
X-Received: by 2002:a17:90a:2e88:b0:26d:a6b:9a47 with SMTP id
 r8-20020a17090a2e8800b0026d0a6b9a47mr19245pjd.2.1700241490659; Fri, 17 Nov
 2023 09:18:10 -0800 (PST)
Date:   Fri, 17 Nov 2023 09:18:10 -0800
In-Reply-To: <CAJjsb4pOb-wGf9Dhp1S8BDABMXFf8YVNhYO95jHau6v9cLWfgg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000154ec0060a5c52f7@google.com>
Subject: Re: [syzbot] [mm?] [ext4?] KASAN: slab-out-of-bounds Read in generic_perform_write
From:   syzbot <syzbot+4a2376bc62e59406c414@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tintinm2017@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-out-of-bounds Read in generic_perform_write

wlan1: Created IBSS using preconfigured BSSID 50:50:50:50:50:50
wlan1: Creating new IBSS network, BSSID 50:50:50:50:50:50
==================================================================
BUG: KASAN: slab-out-of-bounds in memcpy_from_iter lib/iov_iter.c:73 [inline]
BUG: KASAN: slab-out-of-bounds in iterate_bvec include/linux/iov_iter.h:122 [inline]
BUG: KASAN: slab-out-of-bounds in iterate_and_advance2 include/linux/iov_iter.h:249 [inline]
BUG: KASAN: slab-out-of-bounds in iterate_and_advance include/linux/iov_iter.h:271 [inline]
BUG: KASAN: slab-out-of-bounds in __copy_from_iter lib/iov_iter.c:268 [inline]
BUG: KASAN: slab-out-of-bounds in copy_page_from_iter_atomic+0x9b2/0x1e70 lib/iov_iter.c:500
Read of size 2048 at addr ffff888027867800 by task kworker/u4:10/2830

CPU: 1 PID: 2830 Comm: kworker/u4:10 Not tainted 6.7.0-rc1-syzkaller-00139-g6bc40e44f1dd #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Workqueue: loop0 loop_workfn
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:475
 kasan_report+0x142/0x170 mm/kasan/report.c:588
 kasan_check_range+0x27e/0x290 mm/kasan/generic.c:187
 __asan_memcpy+0x29/0x70 mm/kasan/shadow.c:105
 memcpy_from_iter lib/iov_iter.c:73 [inline]
 iterate_bvec include/linux/iov_iter.h:122 [inline]
 iterate_and_advance2 include/linux/iov_iter.h:249 [inline]
 iterate_and_advance include/linux/iov_iter.h:271 [inline]
 __copy_from_iter lib/iov_iter.c:268 [inline]
 copy_page_from_iter_atomic+0x9b2/0x1e70 lib/iov_iter.c:500
 generic_perform_write+0x392/0x630 mm/filemap.c:3926
 shmem_file_write_iter+0xfc/0x120 mm/shmem.c:2878
 do_iter_write+0x7ac/0xcb0 fs/read_write.c:860
 lo_write_bvec drivers/block/loop.c:249 [inline]
 lo_write_simple drivers/block/loop.c:271 [inline]
 do_req_filebacked drivers/block/loop.c:495 [inline]
 loop_handle_cmd drivers/block/loop.c:1915 [inline]
 loop_process_work+0x14c3/0x22a0 drivers/block/loop.c:1950
 process_one_work kernel/workqueue.c:2630 [inline]
 process_scheduled_works+0x90f/0x1400 kernel/workqueue.c:2703
 worker_thread+0xa5f/0xff0 kernel/workqueue.c:2784
 kthread+0x2d3/0x370 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>

Allocated by task 5467:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:198 [inline]
 __do_kmalloc_node mm/slab_common.c:1007 [inline]
 __kmalloc+0xb9/0x230 mm/slab_common.c:1020
 kmalloc include/linux/slab.h:604 [inline]
 hfsplus_read_wrapper+0x545/0x1330 fs/hfsplus/wrapper.c:178
 hfsplus_fill_super+0x38e/0x1c90 fs/hfsplus/super.c:413
 mount_bdev+0x237/0x300 fs/super.c:1650
 legacy_get_tree+0xef/0x190 fs/fs_context.c:662
 vfs_get_tree+0x8c/0x280 fs/super.c:1771
 do_new_mount+0x28f/0xae0 fs/namespace.c:3337
 do_mount fs/namespace.c:3677 [inline]
 __do_sys_mount fs/namespace.c:3886 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3863
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

The buggy address belongs to the object at ffff888027867800
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 0 bytes inside of
 allocated 512-byte region [ffff888027867800, ffff888027867a00)

The buggy address belongs to the physical page:
page:ffffea00009e1900 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x27864
head:ffffea00009e1900 order:2 entire_mapcount:0 nr_pages_mapped:0 pincount:0
ksm flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888012841c80 ffffea00009feb00 dead000000000003
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 3246, tgid 3246 (kworker/u4:2), ts 13810055781, free_ts 0
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1e6/0x210 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1544 [inline]
 get_page_from_freelist+0x339a/0x3530 mm/page_alloc.c:3312
 __alloc_pages+0x255/0x670 mm/page_alloc.c:4568
 alloc_pages_mpol+0x3de/0x640 mm/mempolicy.c:2133
 alloc_slab_page+0x6a/0x160 mm/slub.c:1870
 allocate_slab mm/slub.c:2017 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2070
 ___slab_alloc+0xc85/0x1310 mm/slub.c:3223
 __slab_alloc mm/slub.c:3322 [inline]
 __slab_alloc_node mm/slub.c:3375 [inline]
 slab_alloc_node mm/slub.c:3468 [inline]
 __kmem_cache_alloc_node+0x21d/0x300 mm/slub.c:3517
 kmalloc_trace+0x2a/0xe0 mm/slab_common.c:1098
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:721 [inline]
 alloc_bprm+0x56/0x900 fs/exec.c:1512
 kernel_execve+0x96/0xa10 fs/exec.c:1987
 call_usermodehelper_exec_async+0x233/0x370 kernel/umh.c:110
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888027867900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888027867980: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888027867a00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                   ^
 ffff888027867a80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888027867b00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         6bc40e44 Merge tag 'ovl-fixes-6.7-rc2' of git://git.ke..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1325cdb8e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7a0f7dcda113cb99
dashboard link: https://syzkaller.appspot.com/bug?extid=4a2376bc62e59406c414
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
