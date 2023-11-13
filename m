Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7137E9C62
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 13:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjKMMsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 07:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKMMsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 07:48:08 -0500
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35329D79
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 04:48:05 -0800 (PST)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-27ff9e2ffdfso6183651a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 04:48:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699879684; x=1700484484;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BByW91C+avxA2rWvlg2K1pJFWJ4lxE+IMjZinf+hK9w=;
        b=D1+kO1JrpCR+iX2eQnNH6mTeAb7XcnR8EfPkurbarjqJd8uEzVIPmv+v8iuv1YDphK
         JtpsGhPZyKmYq6rwDyIRpRCVVpYe0r5WlAV/fatDik+FOtJ8x2QGS+vLRwi/HSlmpQvT
         3DGYs8RndupGsO9ancsT50HNxOBYYG6gTI7rgl4fZx9SFv9xmKr+l5LdZGRx+JqtTK0M
         1UNF+oYyr9qClc9YdHkt+icA2SbkzZ+eusXikNe2ktQwvlwgB4JBPsOfzZ5mIQ0dnLxs
         tI1Y3vjRrPA0XeInZs4dJj+wPZ5NAeJx3wN0AlgzUHntkTltUH3aguCfGxzyWiLb2kMT
         6NdQ==
X-Gm-Message-State: AOJu0Yw8qx3OOYyXpqT5PzOmi2mfZra9VATS1UYL0eykOCnxFiNTBJZe
        FXhYmWFr+gaIMfzJMe1kSfy7/QL2bWSZQzoAMiGKnVOfP4vD
X-Google-Smtp-Source: AGHT+IFMBKKh4qPXFUdfvoARwyfmcM4USd9gQOKWaiz71EOHtzIM3XvKCcVgQnpUbsYWDdk3obvOgOOEJFUyDSnrNOd/U4O4s92+
MIME-Version: 1.0
X-Received: by 2002:a17:90a:d803:b0:27d:a0b:bff with SMTP id
 a3-20020a17090ad80300b0027d0a0b0bffmr1942279pjv.2.1699879684766; Mon, 13 Nov
 2023 04:48:04 -0800 (PST)
Date:   Mon, 13 Nov 2023 04:48:04 -0800
In-Reply-To: <tencent_C5A3BA24589777F76D86C7136A837B496305@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c5816a060a0814fc@google.com>
Subject: Re: [syzbot] [squashfs?] KASAN: slab-out-of-bounds Write in
 squashfs_readahead (2)
From:   syzbot <syzbot+604424eb051c2f696163@syzkaller.appspotmail.com>
To:     eadavis@qq.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-out-of-bounds Write in squashfs_readahead

SQUASHFS error: Unable to read metadata cache entry [6fa]
SQUASHFS error: Unable to read metadata cache entry [6fa]
p: ffff88801ea30b18, bs: 4096, bl: 12, mp: 1, start: 0, fe: 0, squashfs_readahead
p: ffff88801ea30b18, mp: 0, e: 0,isr: 0, start: 0, squashfs_readahead
==================================================================
BUG: KASAN: slab-out-of-bounds in __readahead_batch include/linux/pagemap.h:1364 [inline]
BUG: KASAN: slab-out-of-bounds in squashfs_readahead+0xa5a/0x1de0 fs/squashfs/file.c:574
Write of size 8 at addr ffff88801ea30b20 by task syz-executor.0/5481

CPU: 1 PID: 5481 Comm: syz-executor.0 Not tainted 6.6.0-syzkaller-15156-g13d88ac54ddd-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:475
 kasan_report+0x142/0x170 mm/kasan/report.c:588
 __readahead_batch include/linux/pagemap.h:1364 [inline]
 squashfs_readahead+0xa5a/0x1de0 fs/squashfs/file.c:574
 read_pages+0x183/0x830 mm/readahead.c:160
 page_cache_ra_unbounded+0x68e/0x7c0 mm/readahead.c:269
 page_cache_sync_readahead include/linux/pagemap.h:1266 [inline]
 filemap_get_pages+0x49c/0x2080 mm/filemap.c:2497
 filemap_read+0x42b/0x10b0 mm/filemap.c:2593
 __kernel_read+0x425/0x8b0 fs/read_write.c:428
 integrity_kernel_read+0xb0/0xf0 security/integrity/iint.c:221
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:485 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:516 [inline]
 ima_calc_file_hash+0xad1/0x1b30 security/integrity/ima/ima_crypto.c:573
 ima_collect_measurement+0x554/0xb30 security/integrity/ima/ima_api.c:290
 process_measurement+0x1373/0x21c0 security/integrity/ima/ima_main.c:359
 ima_file_check+0xf1/0x170 security/integrity/ima/ima_main.c:557
 do_open fs/namei.c:3624 [inline]
 path_openat+0x2893/0x3280 fs/namei.c:3779
 do_filp_open+0x234/0x490 fs/namei.c:3809
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1440
 do_sys_open fs/open.c:1455 [inline]
 __do_sys_open fs/open.c:1463 [inline]
 __se_sys_open fs/open.c:1459 [inline]
 __x64_sys_open+0x225/0x270 fs/open.c:1459
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f57b767cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f57b84070c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007f57b779bf80 RCX: 00007f57b767cae9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000200000c0
RBP: 00007f57b76c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f57b779bf80 R15: 00007ffd5c197a58
 </TASK>

Allocated by task 5481:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:198 [inline]
 __do_kmalloc_node mm/slab_common.c:1007 [inline]
 __kmalloc+0xb9/0x230 mm/slab_common.c:1020
 kmalloc_array include/linux/slab.h:637 [inline]
 squashfs_readahead+0x2e8/0x1de0 fs/squashfs/file.c:552
 read_pages+0x183/0x830 mm/readahead.c:160
 page_cache_ra_unbounded+0x68e/0x7c0 mm/readahead.c:269
 page_cache_sync_readahead include/linux/pagemap.h:1266 [inline]
 filemap_get_pages+0x49c/0x2080 mm/filemap.c:2497
 filemap_read+0x42b/0x10b0 mm/filemap.c:2593
 __kernel_read+0x425/0x8b0 fs/read_write.c:428
 integrity_kernel_read+0xb0/0xf0 security/integrity/iint.c:221
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:485 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:516 [inline]
 ima_calc_file_hash+0xad1/0x1b30 security/integrity/ima/ima_crypto.c:573
 ima_collect_measurement+0x554/0xb30 security/integrity/ima/ima_api.c:290
 process_measurement+0x1373/0x21c0 security/integrity/ima/ima_main.c:359
 ima_file_check+0xf1/0x170 security/integrity/ima/ima_main.c:557
 do_open fs/namei.c:3624 [inline]
 path_openat+0x2893/0x3280 fs/namei.c:3779
 do_filp_open+0x234/0x490 fs/namei.c:3809
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1440
 do_sys_open fs/open.c:1455 [inline]
 __do_sys_open fs/open.c:1463 [inline]
 __se_sys_open fs/open.c:1459 [inline]
 __x64_sys_open+0x225/0x270 fs/open.c:1459
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

The buggy address belongs to the object at ffff88801ea30b18
 which belongs to the cache kmalloc-8 of size 8
The buggy address is located 0 bytes to the right of
 allocated 8-byte region [ffff88801ea30b18, ffff88801ea30b20)

The buggy address belongs to the physical page:
page:ffffea00007a8c00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1ea30
flags: 0xfff00000000800(slab|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000800 ffff888012c41280 dead000000000100 dead000000000122
raw: 0000000000000000 0000000080660066 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12c40(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY), pid 25, tgid 25 (kdevtmpfs), ts 8927536691, free_ts 8917015211
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
 __do_kmalloc_node mm/slab_common.c:1006 [inline]
 __kmalloc_node_track_caller+0xa5/0x230 mm/slab_common.c:1027
 kstrndup+0x41/0xb0 mm/util.c:108
 smk_parse_smack security/smack/smack_access.c:468 [inline]
 smk_import_entry+0x18d/0x610 security/smack/smack_access.c:563
 smk_fetch+0xdd/0x140 security/smack/smack_lsm.c:310
 smack_d_instantiate+0x74a/0xa50 security/smack/smack_lsm.c:3573
 security_d_instantiate+0x9b/0xf0 security/security.c:3799
 d_instantiate+0x55/0x90 fs/dcache.c:2033
 shmem_mknod+0x191/0x1c0 mm/shmem.c:3246
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1137 [inline]
 free_unref_page_prepare+0x92a/0xa50 mm/page_alloc.c:2347
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2487
 mm_free_pgd kernel/fork.c:803 [inline]
 __mmdrop+0xb8/0x3d0 kernel/fork.c:919
 free_bprm+0x144/0x330 fs/exec.c:1490
 kernel_execve+0x8f5/0xa10 fs/exec.c:2024
 call_usermodehelper_exec_async+0x233/0x370 kernel/umh.c:110
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

Memory state around the buggy address:
 ffff88801ea30a00: 06 fc fc fc fc fb fc fc fc fc 00 fc fc fc fc fb
 ffff88801ea30a80: fc fc fc fc fb fc fc fc fc fb fc fc fc fc fa fc
>ffff88801ea30b00: fc fc fc 00 fc fc fc fc fb fc fc fc fc 06 fc fc
                               ^
 ffff88801ea30b80: fc fc 06 fc fc fc fc fb fc fc fc fc fb fc fc fc
 ffff88801ea30c00: fc fb fc fc fc fc fb fc fc fc fc 06 fc fc fc fc
==================================================================


Tested on:

commit:         13d88ac5 Merge tag 'vfs-6.7.fsid' of git://git.kernel...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=139741a7680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=beb32a598fd79db9
dashboard link: https://syzkaller.appspot.com/bug?extid=604424eb051c2f696163
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12214824e80000

