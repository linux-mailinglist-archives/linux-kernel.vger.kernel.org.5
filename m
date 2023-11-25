Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E7B7F8AFF
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 13:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbjKYM6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 07:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjKYM56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 07:57:58 -0500
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5A9BC
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 04:58:05 -0800 (PST)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6b496e1e53bso3863722b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 04:58:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700917084; x=1701521884;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MKb4HtaG93ZmDUP2kAxRHHZ9QJcU0NShPtIVas47Kyc=;
        b=e5oJ418Wh9Qshdq9HYxdN/dbkKnGk9lnuDLWtAafez8nIhXpuRKGTXz0JKoAOPpD05
         a6x13paic95mneMsvmmH/bVhSLPTqxzWYoMqaxkDuy1uZrCzU7HAihKWT47yil5t9n4a
         4IWFXLIqpagVBDEPtGBIaNVacv5aSW0QPZFmo2A5O/Tq4jla7rZ4kbClO0TGvwiFzs/N
         vzg99lX8Vf2nBO0iEJqR1wlGJVOmB+AmjciDBnSxDmtDc9+Y5KB3UhLKO65aAlOGV4pV
         +teLvWqWu81zztab7Ifd6nERCCCj2zVIxNej2Xr0y0K9070WnDHxBvEYozkUpYB/gEaS
         bQ1Q==
X-Gm-Message-State: AOJu0YzzmRT7hnibBb/uKOjFfd5tDVsT5uKniZzieW2YsonXijTk/Bxh
        Uj9d8dqxe1emPMrAY4Mr6mGUSuoWq0wHtnQ86iqSU9riBwZE
X-Google-Smtp-Source: AGHT+IHeJ1oXIUtYNWkVvMmCgFzvAARFdnmRsnuAoZ3o53Fv8fz5eAVTPDqdK8j6R5TLALaU2pI2ni/M86bT6YvbgQC7THuJ8L3+
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:10c5:b0:68f:cb69:8e76 with SMTP id
 d5-20020a056a0010c500b0068fcb698e76mr1429662pfu.2.1700917084585; Sat, 25 Nov
 2023 04:58:04 -0800 (PST)
Date:   Sat, 25 Nov 2023 04:58:04 -0800
In-Reply-To: <tencent_18F764177706CB137F63662968E3A6645A05@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009e8563060af99e5c@google.com>
Subject: Re: [syzbot] [ntfs3?] WARNING in indx_insert_into_buffer
From:   syzbot <syzbot+c5b339d16ffa61fd512d@syzkaller.appspotmail.com>
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
KASAN: invalid-free in indx_insert_into_buffer

R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 000000000000000b R14: 00007f1a99f9bf80 R15: 00007ffdd50705e8
 </TASK>
==================================================================
BUG: KASAN: invalid-free in indx_insert_into_buffer.isra.0+0xec4/0x11f0 fs/ntfs3/index.c:1912
Free of addr ffff88801c22c018 by task syz-executor.0/5511

CPU: 0 PID: 5511 Comm: syz-executor.0 Not tainted 6.7.0-rc1-syzkaller-00344-g037266a5f723-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report_invalid_free+0xab/0xd0 mm/kasan/report.c:550
 ____kasan_slab_free+0x17d/0x190 mm/kasan/common.c:216
 kasan_slab_free include/linux/kasan.h:164 [inline]
 __cache_free mm/slab.c:3370 [inline]
 __do_kmem_cache_free mm/slab.c:3557 [inline]
 __kmem_cache_free+0xcc/0x3d0 mm/slab.c:3564
 indx_insert_into_buffer.isra.0+0xec4/0x11f0 fs/ntfs3/index.c:1912
 indx_insert_entry+0x1a5/0x460 fs/ntfs3/index.c:1984
 ni_add_name+0x4d9/0x820 fs/ntfs3/frecord.c:3055
 ni_rename+0xa1/0x1a0 fs/ntfs3/frecord.c:3087
 ntfs_rename+0x91f/0xec0 fs/ntfs3/namei.c:322
 vfs_rename+0x13e0/0x1c30 fs/namei.c:4844
 do_renameat2+0xc3c/0xdc0 fs/namei.c:4996
 __do_sys_rename fs/namei.c:5042 [inline]
 __se_sys_rename fs/namei.c:5040 [inline]
 __x64_sys_rename+0x81/0xa0 fs/namei.c:5040
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f1a99e7cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1a9ab210c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
RAX: ffffffffffffffda RBX: 00007f1a99f9bf80 RCX: 00007f1a99e7cae9
RDX: 0000000000000000 RSI: 0000000020000a40 RDI: 0000000020000300
RBP: 00007f1a9ab21120 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 000000000000000b R14: 00007f1a99f9bf80 R15: 00007ffdd50705e8
 </TASK>

Allocated by task 5511:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0xa3/0xb0 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:198 [inline]
 __do_kmalloc_node mm/slab_common.c:1007 [inline]
 __kmalloc+0x59/0x90 mm/slab_common.c:1020
 kmalloc include/linux/slab.h:604 [inline]
 indx_read+0x4f1/0xcd0 fs/ntfs3/index.c:1059
 indx_find+0x4a9/0x980 fs/ntfs3/index.c:1181
 indx_insert_entry+0x376/0x460 fs/ntfs3/index.c:1961
 ni_add_name+0x4d9/0x820 fs/ntfs3/frecord.c:3055
 ni_rename+0xa1/0x1a0 fs/ntfs3/frecord.c:3087
 ntfs_rename+0x91f/0xec0 fs/ntfs3/namei.c:322
 vfs_rename+0x13e0/0x1c30 fs/namei.c:4844
 do_renameat2+0xc3c/0xdc0 fs/namei.c:4996
 __do_sys_rename fs/namei.c:5042 [inline]
 __se_sys_rename fs/namei.c:5040 [inline]
 __x64_sys_rename+0x81/0xa0 fs/namei.c:5040
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

The buggy address belongs to the object at ffff88801c22c000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 24 bytes inside of
 4096-byte region [ffff88801c22c000, ffff88801c22d000)

The buggy address belongs to the physical page:
page:ffffea0000708b00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1c22c
head:ffffea0000708b00 order:1 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0x1()
raw: 00fff00000000840 ffff888013040900 ffffea0000b89390 ffffea0000701e90
raw: 0000000000000000 ffff88801c22c000 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0x342040(__GFP_IO|__GFP_NOWARN|__GFP_COMP|__GFP_HARDWALL|__GFP_THISNODE), pid 5318, tgid 5318 (dhcpcd-run-hook), ts 63150203847, free_ts 63102034837
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2d0/0x350 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1544 [inline]
 get_page_from_freelist+0xa25/0x36d0 mm/page_alloc.c:3312
 __alloc_pages+0x22e/0x2420 mm/page_alloc.c:4568
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 kmem_getpages mm/slab.c:1356 [inline]
 cache_grow_begin+0x99/0x3a0 mm/slab.c:2550
 cache_alloc_refill+0x295/0x3b0 mm/slab.c:2923
 ____cache_alloc mm/slab.c:2999 [inline]
 ____cache_alloc mm/slab.c:2982 [inline]
 __do_cache_alloc mm/slab.c:3182 [inline]
 slab_alloc_node mm/slab.c:3230 [inline]
 __kmem_cache_alloc_node+0x3ba/0x460 mm/slab.c:3521
 kmalloc_trace+0x25/0x60 mm/slab_common.c:1098
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:721 [inline]
 tomoyo_environ security/tomoyo/domain.c:633 [inline]
 tomoyo_find_next_domain+0xc08/0x2020 security/tomoyo/domain.c:878
 tomoyo_bprm_check_security security/tomoyo/tomoyo.c:101 [inline]
 tomoyo_bprm_check_security+0x12b/0x1d0 security/tomoyo/tomoyo.c:91
 security_bprm_check+0x6a/0xe0 security/security.c:1103
 search_binary_handler fs/exec.c:1725 [inline]
 exec_binprm fs/exec.c:1779 [inline]
 bprm_execve fs/exec.c:1854 [inline]
 bprm_execve+0x73a/0x1a90 fs/exec.c:1810
 do_execveat_common.isra.0+0x5d3/0x740 fs/exec.c:1962
 do_execve fs/exec.c:2036 [inline]
 __do_sys_execve fs/exec.c:2112 [inline]
 __se_sys_execve fs/exec.c:2107 [inline]
 __x64_sys_execve+0x8c/0xb0 fs/exec.c:2107
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1137 [inline]
 free_unref_page_prepare+0x4fa/0xaa0 mm/page_alloc.c:2347
 free_unref_page+0x33/0x3b0 mm/page_alloc.c:2487
 slab_destroy mm/slab.c:1608 [inline]
 slabs_destroy+0x85/0xc0 mm/slab.c:1628
 cache_flusharray mm/slab.c:3341 [inline]
 ___cache_free+0x2b7/0x420 mm/slab.c:3404
 qlink_free mm/kasan/quarantine.c:168 [inline]
 qlist_free_all+0x4c/0x1b0 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x18e/0x1d0 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x65/0x90 mm/kasan/common.c:305
 kasan_slab_alloc include/linux/kasan.h:188 [inline]
 slab_post_alloc_hook mm/slab.h:763 [inline]
 slab_alloc_node mm/slab.c:3237 [inline]
 slab_alloc mm/slab.c:3246 [inline]
 __kmem_cache_alloc_lru mm/slab.c:3423 [inline]
 kmem_cache_alloc+0x159/0x360 mm/slab.c:3432
 getname_flags.part.0+0x50/0x4e0 fs/namei.c:140
 getname_flags+0x9c/0xf0 include/linux/audit.h:321
 vfs_fstatat+0x9a/0x140 fs/stat.c:294
 __do_sys_newfstatat+0x98/0x110 fs/stat.c:459
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Memory state around the buggy address:
 ffff88801c22bf00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88801c22bf80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88801c22c000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
                            ^
 ffff88801c22c080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88801c22c100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


Tested on:

commit:         037266a5 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12120b44e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=af04b7c4d36966d8
dashboard link: https://syzkaller.appspot.com/bug?extid=c5b339d16ffa61fd512d
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=106773cce80000

