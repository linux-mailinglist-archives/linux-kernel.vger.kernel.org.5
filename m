Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0CB17D457F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 04:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbjJXCbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 22:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjJXCbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 22:31:04 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6792D111;
        Mon, 23 Oct 2023 19:31:00 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c51388ccebso59098961fa.3;
        Mon, 23 Oct 2023 19:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698114658; x=1698719458; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=McFFYzsG6Jmbs6jRU6MeRFK7UV/TNd3mIQFzkLikTaI=;
        b=OqXOaLDUUxXT+fas0DFpZ/tJe4QXRcwSvNBGOYpH1hk0gadwTlLbRfIbvNZnRGm33Y
         Q43RLzyZNWHa8lS1MkJcCBN+JYzS3nYs7BA6tHLGHvjHx5uJGkBcfA91CJeJSljoBYyz
         Wm0xC/RAVuWtGDtpGSzmEOVa2a5+/cFj4HG3tV5X/1ahGqqck2pBIdUTlZqf8vrx4qLo
         XFdqYBYYZxP+7CaLrxVnDcvsIKSmnF1JxHjY5pZUp5xpdAn9p3Lu9H+kl4fFDpXxuWv3
         m8bhXv+6vaCfnaOBnw6KXHh9OJF5UoYB26iNp0RWwJOCjwkFEZ96mO5iImMNqS1uxLXR
         onlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698114658; x=1698719458;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=McFFYzsG6Jmbs6jRU6MeRFK7UV/TNd3mIQFzkLikTaI=;
        b=bqgjGZ8U24ai1UdjT6RxwdeCsyBbn5KD9AS/HjY+tSARsI7J2ulPgLrExJVmQtTSSE
         6y0TZlruWvnIhIjhqtrhzCuaWo1HjKBOrpLZp3pHOkBomiZ+S4dxtlnDNJouzfUeTYUy
         CsPTWVB35r3wTtA3/VJWo+pZR3wj7wGc7WEp52COcD7JAB/6++2X7Occ+UaO2+9pZ5ZV
         Y/JcVecNXe87jswaPK4KkSEdRbUiH5cRr5mSpA7SOp40h1K87E5KfqPNZTT6+cgk5ARQ
         a6fd0z5m1E6J/aLAA3hXiQeXNGeWVlihF3HsPS/BwgwneQzxHIg/b+WwqfAx0j19H70i
         aG9A==
X-Gm-Message-State: AOJu0Yz9oLw8E9EuhHq0U+vG1DIIFIFNf1GIK8kDNS23XSAhJOFBaPwm
        7lI1GRC383tI6MeneK9gtL/pb7orFPESj2vSnojb2XyKYDiKJA==
X-Google-Smtp-Source: AGHT+IFoP6xAvmmoL/BFO3fT1jPT1Edbf/THGwG3kp8xts+acJBL7hvtxbKt2QZ8p2wSdGJra/fSZPQC1KsMztjGczM=
X-Received: by 2002:a2e:9c44:0:b0:2c5:12c4:5ff with SMTP id
 t4-20020a2e9c44000000b002c512c405ffmr7155743ljj.17.1698114657544; Mon, 23 Oct
 2023 19:30:57 -0700 (PDT)
MIME-Version: 1.0
From:   Yikebaer Aizezi <yikebaer61@gmail.com>
Date:   Tue, 24 Oct 2023 10:30:46 +0800
Message-ID: <CALcu4raE3hoh7pLNJBjxWeWv18QOR1XPt4E=XWmdg_b9CN-5Cg@mail.gmail.com>
Subject: KASAN use-after-free Read in search_by_entry_key
To:     reiserfs-devel@vger.kernel.org
Cc:     brauner@kernel.org, "dchinner@redhat.com" <dchinner@redhat.com>,
        jack@suse.cz, jlayton@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When using Healer to fuzz the  Linux 6.6-rc7 Linux kernel,  the following crash
was triggered.

HEAD commit: 05d3ef8bba77c1b5f98d941d8b2d4aeab8118ef1 ( Linux 6.6-rc7)
git tree: upstream

console output:
https://drive.google.com/file/d/1qQhQwRydIp1SIiDJghcfp384uZ3gF8-T/view?usp=drive_link
kernel config:https://drive.google.com/file/d/1gOeRhOnJr2htj6PPnEDTFUkli94JwVvJ/view?usp=drive_link
C reproducer:https://drive.google.com/file/d/19te0q4_oUfcCoMarjNmkWXvnuwyvhRL-/view?usp=drive_link
Syzlang reproducer:
https://drive.google.com/file/d/12vmCNO8HysQ9-C5TC90mpjmZXOJ90k8C/view?usp=drive_link

If you fix this issue, please add the following tag to the commit:
Reported-by: Yikebaer Aizezi <yikebaer61@gmail.com>

==================================================================
BUG: KASAN: use-after-free in search_by_entry_key+0x81f/0x960
fs/reiserfs/namei.c:165
Read of size 4 at addr ffff8880316dcfc4 by task syz-executor.0/41572

CPU: 0 PID: 41572 Comm: syz-executor.0 Not tainted 6.6.0-rc7-g05d3ef8bba77 #8
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd5/0x150 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc1/0x5e0 mm/kasan/report.c:475
 kasan_report+0xba/0xf0 mm/kasan/report.c:588
 bin_search_in_dir_item fs/reiserfs/namei.c:40 [inline]
 search_by_entry_key+0x81f/0x960 fs/reiserfs/namei.c:165
 reiserfs_find_entry.part.0+0x139/0xdf0 fs/reiserfs/namei.c:322
 reiserfs_find_entry fs/reiserfs/namei.c:392 [inline]
 reiserfs_lookup+0x24d/0x610 fs/reiserfs/namei.c:368
 __lookup_slow+0x24c/0x460 fs/namei.c:1694
 lookup_one_len+0x16a/0x1a0 fs/namei.c:2746
 reiserfs_lookup_privroot+0x92/0x210 fs/reiserfs/xattr.c:977
 reiserfs_fill_super+0x20fa/0x2ea0 fs/reiserfs/super.c:2174
 mount_bdev+0x1fd/0x2f0 fs/super.c:1629
 legacy_get_tree+0x105/0x220 fs/fs_context.c:662
 vfs_get_tree+0x8d/0x370 fs/super.c:1750
 do_new_mount fs/namespace.c:3335 [inline]
 path_mount+0x671/0x1e40 fs/namespace.c:3662
 do_mount fs/namespace.c:3675 [inline]
 __do_sys_mount fs/namespace.c:3884 [inline]
 __se_sys_mount fs/namespace.c:3861 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3861
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7ff4f9690abe
Code: 48 c7 c0 ff ff ff ff eb aa e8 be 0d 00 00 66 2e 0f 1f 84 00 00
00 00 00 0f 1f 40 00 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff4fa3bde38 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 000000000000ffe6 RCX: 00007ff4f9690abe
RDX: 0000000020010000 RSI: 0000000020010040 RDI: 00007ff4fa3bde90
RBP: 00007ff4fa3bded0 R08: 00007ff4fa3bded0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000020010000
R13: 0000000020010040 R14: 00007ff4fa3bde90 R15: 00000000200005c0
 </TASK>

The buggy address belongs to the physical page:
page:ffffea0000c5b700 refcount:0 mapcount:0 mapping:0000000000000000
index:0x1 pfn:0x316dc
flags: 0xfff00000000000(node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000000 dead000000000100 dead000000000122 0000000000000000
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as freed
page last allocated via order 0, migratetype Movable, gfp_mask
0x140cca(GFP_HIGHUSER_MOVABLE|__GFP_COMP), pid 41568, tgid 41567
(syz-executor.2), ts 1584644584471, free_ts 1585399046358
 prep_new_page mm/page_alloc.c:1543 [inline]
 get_page_from_freelist+0xf09/0x2c50 mm/page_alloc.c:3170
 __alloc_pages+0x1c7/0x490 mm/page_alloc.c:4426
 __folio_alloc+0x12/0x40 mm/page_alloc.c:4458
 vma_alloc_folio+0x153/0x870 mm/mempolicy.c:2258
 shmem_alloc_folio+0x121/0x1f0 mm/shmem.c:1658
 shmem_alloc_and_acct_folio+0xd2/0x150 mm/shmem.c:1683
 shmem_get_folio_gfp+0x96b/0x18e0 mm/shmem.c:2020
 shmem_get_folio mm/shmem.c:2143 [inline]
 shmem_write_begin+0x146/0x440 mm/shmem.c:2688
 generic_perform_write+0x267/0x5d0 mm/filemap.c:3969
 shmem_file_write_iter+0x10f/0x140 mm/shmem.c:2865
 call_write_iter include/linux/fs.h:1956 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x989/0xdb0 fs/read_write.c:584
 ksys_write+0x11e/0x240 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1136 [inline]
 free_unref_page_prepare+0x450/0xa30 mm/page_alloc.c:2312
 free_unref_page_list+0xec/0xac0 mm/page_alloc.c:2451
 release_pages+0xca9/0x1350 mm/swap.c:1042
 __folio_batch_release+0x73/0xd0 mm/swap.c:1062
 folio_batch_release include/linux/pagevec.h:83 [inline]
 shmem_undo_range+0x545/0x10f0 mm/shmem.c:1022
 shmem_truncate_range mm/shmem.c:1114 [inline]
 shmem_evict_inode+0x38a/0xb70 mm/shmem.c:1243
 evict+0x2ed/0x6b0 fs/inode.c:664
 iput_final fs/inode.c:1775 [inline]
 iput.part.0+0x50f/0x710 fs/inode.c:1801
 iput+0x58/0x70 fs/inode.c:1791
 dentry_unlink_inode+0x28c/0x430 fs/dcache.c:401
 __dentry_kill+0x3bd/0x640 fs/dcache.c:607
 dentry_kill fs/dcache.c:733 [inline]
 dput+0x847/0xde0 fs/dcache.c:913
 __fput+0x543/0xa70 fs/file_table.c:392
 task_work_run+0x164/0x250 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x215/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:296

Memory state around the buggy address:
 ffff8880316dce80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff8880316dcf00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff8880316dcf80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                           ^
 ffff8880316dd000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff8880316dd080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================
