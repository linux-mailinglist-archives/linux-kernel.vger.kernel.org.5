Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883417F8B23
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 14:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbjKYNjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 08:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbjKYNjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 08:39:00 -0500
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8D2BB
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 05:39:07 -0800 (PST)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1cf9a4ed7dbso24047475ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 05:39:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700919546; x=1701524346;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2xdiHNr4de1AWTAQWhIufLpYHB+OEyZaJfju7Q6HDbQ=;
        b=HLI5FGJPPhb1s1AwOs6rWoQGrcsQvjFDYQNJv21jKEbgaWE/KdzdQCriq0xVXjaclD
         hpGUh7P+7DaTh7bRRJXNe7/a5T3RPXJ62oEWh0GDrbOALjHwxX43K4+tIMTkReHkAafF
         xi3pcqXe8iNfpbNMfII/4LrzkUhMY13YI2MWGraEIwE6KwQbaml8rCpJlEilYae8/U17
         REwuKPdwFO0W2AMepqjREPMq/O+1Xg0+8pvXjZYjzjO2oLFz4t0T2IGWtBd3Bi28/bQ0
         p0K/GXlq2/3A2lLyYxhQUo240oA86aeonHWRtlBkqUH/tVi0HfyBKXz8TK2El1G5NZpZ
         r9vw==
X-Gm-Message-State: AOJu0Yx6GZ+It0l9SMveNbkXnm74ZuLZf+/ligAus0tutQJMGuIdMswz
        PDygKZL0UYZnCyiwFdBVZJmbnz3ORZc3JBlo/TvPgN45UI0T
X-Google-Smtp-Source: AGHT+IGwfUU3bnZPMjdtBgtLPzNr5RWSP8hEPsok1vjEmSa4jQvqroRdpEGmnf41dKBRDpFU8Edb0+bMinVQVd8+urqu5FIzRe7H
MIME-Version: 1.0
X-Received: by 2002:a17:902:a986:b0:1cc:3f29:2904 with SMTP id
 bh6-20020a170902a98600b001cc3f292904mr1088919plb.7.1700919546647; Sat, 25 Nov
 2023 05:39:06 -0800 (PST)
Date:   Sat, 25 Nov 2023 05:39:06 -0800
In-Reply-To: <tencent_F60445D778976B46CD3364E3732976A3AE05@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005e98aa060afa317a@google.com>
Subject: Re: [syzbot] [udf?] KASAN: slab-use-after-free Read in udf_free_blocks
From:   syzbot <syzbot+0b7937459742a0a4cffd@syzkaller.appspotmail.com>
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
KASAN: slab-out-of-bounds Read in udf_free_blocks

==================================================================
BUG: KASAN: slab-out-of-bounds in udf_free_blocks+0x12d7/0x1330 fs/udf/balloc.c:677
Read of size 2 at addr ffff888022c83282 by task syz-executor.0/5711

CPU: 0 PID: 5711 Comm: syz-executor.0 Not tainted 6.4.0-next-20230707-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x5f0 mm/kasan/report.c:475
 kasan_report+0xbe/0xf0 mm/kasan/report.c:588
 udf_free_blocks+0x12d7/0x1330 fs/udf/balloc.c:677
 udf_split_extents fs/udf/inode.c:954 [inline]
 inode_getblk+0x37c8/0x4310 fs/udf/inode.c:889
 udf_map_block+0x2e4/0x560 fs/udf/inode.c:446
 __udf_get_block+0x99/0x330 fs/udf/inode.c:460
 __block_write_begin_int+0x3a7/0x1460 fs/buffer.c:2128
 __block_write_begin fs/buffer.c:2178 [inline]
 block_write_begin+0xb1/0x490 fs/buffer.c:2237
 udf_write_begin+0x283/0x360 fs/udf/inode.c:261
 generic_perform_write+0x26c/0x5f0 mm/filemap.c:3925
 __generic_file_write_iter+0x1f9/0x240 mm/filemap.c:4020
 udf_file_write_iter+0x239/0x740 fs/udf/file.c:111
 call_write_iter include/linux/fs.h:1873 [inline]
 do_iter_readv_writev+0x208/0x3b0 fs/read_write.c:735
 do_iter_write+0x17f/0x830 fs/read_write.c:860
 vfs_iter_write+0x7a/0xb0 fs/read_write.c:901
 iter_file_splice_write+0x666/0xba0 fs/splice.c:738
 do_splice_from fs/splice.c:933 [inline]
 direct_splice_actor+0x118/0x180 fs/splice.c:1142
 splice_direct_to_actor+0x347/0xa30 fs/splice.c:1088
 do_splice_direct+0x1af/0x280 fs/splice.c:1194
 do_sendfile+0xb70/0x1370 fs/read_write.c:1254
 __do_sys_sendfile64 fs/read_write.c:1322 [inline]
 __se_sys_sendfile64 fs/read_write.c:1308 [inline]
 __x64_sys_sendfile64+0x1cd/0x210 fs/read_write.c:1308
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fa4e6e7c959
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa4e7c600c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007fa4e6f9c050 RCX: 00007fa4e6e7c959
RDX: 0000000000000000 RSI: 0000000000000007 RDI: 0000000000000005
RBP: 00007fa4e6ed8c88 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000100000001 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007fa4e6f9c050 R15: 00007ffce58c34a8
 </TASK>

Allocated by task 5404:
 kasan_save_stack+0x20/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 __kasan_slab_alloc+0x81/0x90 mm/kasan/common.c:328
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook mm/slab.h:762 [inline]
 slab_alloc_node mm/slub.c:3470 [inline]
 slab_alloc mm/slub.c:3478 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3485 [inline]
 kmem_cache_alloc+0x169/0x3b0 mm/slub.c:3494
 getname_flags.part.0+0x50/0x4d0 fs/namei.c:140
 getname_flags include/linux/audit.h:319 [inline]
 getname+0x90/0xe0 fs/namei.c:219
 do_sys_openat2+0xe6/0x1c0 fs/open.c:1401
 do_sys_open fs/open.c:1422 [inline]
 __do_sys_openat fs/open.c:1438 [inline]
 __se_sys_openat fs/open.c:1433 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1433
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888022c82200
 which belongs to the cache names_cache of size 4096
The buggy address is located 130 bytes to the right of
 allocated 4096-byte region [ffff888022c82200, ffff888022c83200)

The buggy address belongs to the physical page:
page:ffffea00008b2000 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x22c80
head:ffffea00008b2000 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000010200 ffff888014675640 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000070007 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4976, tgid 4976 (dhcpcd-run-hook), ts 34232111308, free_ts 34204262065
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2d2/0x350 mm/page_alloc.c:1569
 prep_new_page mm/page_alloc.c:1576 [inline]
 get_page_from_freelist+0x10d7/0x3190 mm/page_alloc.c:3256
 __alloc_pages+0x1c8/0x4a0 mm/page_alloc.c:4512
 alloc_pages+0x1a9/0x270 mm/mempolicy.c:2279
 alloc_slab_page mm/slub.c:1862 [inline]
 allocate_slab+0x24e/0x380 mm/slub.c:2009
 new_slab mm/slub.c:2062 [inline]
 ___slab_alloc+0x889/0x1530 mm/slub.c:3215
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3314
 __slab_alloc_node mm/slub.c:3367 [inline]
 slab_alloc_node mm/slub.c:3460 [inline]
 slab_alloc mm/slub.c:3478 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3485 [inline]
 kmem_cache_alloc+0x389/0x3b0 mm/slub.c:3494
 getname_flags.part.0+0x50/0x4d0 fs/namei.c:140
 getname_flags+0x9c/0xf0 include/linux/audit.h:319
 vfs_fstatat+0x77/0xb0 fs/stat.c:275
 __do_sys_newfstatat+0x86/0x100 fs/stat.c:446
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1160 [inline]
 free_unref_page_prepare+0x508/0xb90 mm/page_alloc.c:2383
 free_unref_page+0x33/0x3b0 mm/page_alloc.c:2478
 __unfreeze_partials+0x1fb/0x210 mm/slub.c:2647
 qlink_free mm/kasan/quarantine.c:166 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:185
 kasan_quarantine_reduce+0x18b/0x1d0 mm/kasan/quarantine.c:292
 __kasan_slab_alloc+0x65/0x90 mm/kasan/common.c:305
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook mm/slab.h:762 [inline]
 slab_alloc_node mm/slub.c:3470 [inline]
 slab_alloc mm/slub.c:3478 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3485 [inline]
 kmem_cache_alloc+0x169/0x3b0 mm/slub.c:3494
 getname_flags.part.0+0x50/0x4d0 fs/namei.c:140
 getname_flags+0x9c/0xf0 include/linux/audit.h:319
 vfs_fstatat+0x77/0xb0 fs/stat.c:275
 __do_sys_newfstatat+0x86/0x100 fs/stat.c:446
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff888022c83180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888022c83200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888022c83280: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                   ^
 ffff888022c83300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888022c83380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


Tested on:

commit:         123212f5 Add linux-next specific files for 20230707
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10059724e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aea084cf48368cf0
dashboard link: https://syzkaller.appspot.com/bug?extid=0b7937459742a0a4cffd
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=116bcb5ce80000

