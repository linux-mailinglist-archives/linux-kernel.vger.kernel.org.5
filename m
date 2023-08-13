Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC18B77A4C0
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 04:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjHMCl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 22:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjHMCl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 22:41:27 -0400
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7469E52
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 19:41:29 -0700 (PDT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1bc394829b8so38675475ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 19:41:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691894489; x=1692499289;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NPrGBDVPKeAed3PWP15m2YN0OPoAz6Vj4q1XqVEjHZw=;
        b=V9sapIjAYdYm5i/xtCky5+CAyd++i68maIJEMoSc1R6bTZ/g1sPeowIGd2nAJ/fKYf
         uAJc0fI+pHqehlkrOtmn/9+U/5ph9c/wh/mhdPtZpgs8x9IKJwB/cFKJdsppZEc/T+g+
         VuvonGiRTWcd00UD9Ya6/j0JJa+/nMF0Qd2EWJSCFwgDbtl0rcI3D5xxctmrqrR4A45y
         HYFKs21eiBqd/Ph2VSb74LJKD23wOmLcAvFGGYZd6dl06Drg43yNR0OYWoqildPiyzqp
         U9A6GhfIrmj1jFxb1UpSMS22VTfIoWM7+nVwBAgQ0xeFxbWa+AMyyHJTHNOPBmRiQS6k
         RYSA==
X-Gm-Message-State: AOJu0YxooKg7nB3R35o2HJPlfIAofsbDy83NQuLYYgQQCwts3aPvtDkB
        D0hnv9s7xHCc0U0oV1b0f0Y/ley4y3KVfmPNJWTWgXMc8wb6
X-Google-Smtp-Source: AGHT+IHfwOpYn646NOtzX8lAKxJdiUzQTc7Y8FGEGswBl04U0Ad7kfVK9i5OkXdTt5ny7T+jZhoP6g497sCIESa9Bj2TD1UtDTRv
MIME-Version: 1.0
X-Received: by 2002:a17:903:11c8:b0:1ba:1704:8a1b with SMTP id
 q8-20020a17090311c800b001ba17048a1bmr2413933plh.12.1691894489416; Sat, 12 Aug
 2023 19:41:29 -0700 (PDT)
Date:   Sat, 12 Aug 2023 19:41:29 -0700
In-Reply-To: <20230813020336.1128-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000a09950602c4e27f@google.com>
Subject: Re: [syzbot] [udf?] KASAN: use-after-free Read in udf_sync_fs
From:   syzbot <syzbot+82df44ede2faca24c729@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-out-of-bounds Write in udf_close_lvid

==================================================================
BUG: KASAN: slab-out-of-bounds in udf_close_lvid+0x6a8/0x9a0 fs/udf/super.c:2035
Write of size 1 at addr ffff88807d255e28 by task syz-executor.0/5372

CPU: 0 PID: 5372 Comm: syz-executor.0 Not tainted 6.5.0-rc5-syzkaller-00296-gf8de32cc060b-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:475
 kasan_report+0x175/0x1b0 mm/kasan/report.c:588
 udf_close_lvid+0x6a8/0x9a0 fs/udf/super.c:2035
 udf_put_super+0xcd/0x160 fs/udf/super.c:2322
 generic_shutdown_super+0x134/0x340 fs/super.c:499
 kill_block_super+0x68/0xa0 fs/super.c:1417
 deactivate_locked_super+0xa4/0x110 fs/super.c:330
 cleanup_mnt+0x426/0x4c0 fs/namespace.c:1254
 task_work_run+0x24a/0x300 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop+0xd9/0x100 kernel/entry/common.c:171
 exit_to_user_mode_prepare+0xb1/0x140 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x64/0x280 kernel/entry/common.c:297
 do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7ff30167de17
Code: b0 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 b0 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffd888c4358 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007ff30167de17
RDX: 0000000000000000 RSI: 000000000000000a RDI: 00007ffd888c4410
RBP: 00007ffd888c4410 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffd888c54d0
R13: 00007ff3016c73b9 R14: 0000000000014647 R15: 0000000000000007
 </TASK>

Allocated by task 5271:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:196 [inline]
 __do_kmalloc_node mm/slab_common.c:985 [inline]
 __kmalloc+0xb9/0x230 mm/slab_common.c:998
 kmalloc include/linux/slab.h:586 [inline]
 tomoyo_realpath_from_path+0xcf/0x5e0 security/tomoyo/realpath.c:251
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_perm+0x28d/0x700 security/tomoyo/file.c:822
 security_inode_getattr+0xd3/0x120 security/security.c:2114
 vfs_getattr fs/stat.c:167 [inline]
 vfs_statx+0x18f/0x480 fs/stat.c:242
 vfs_fstatat fs/stat.c:276 [inline]
 __do_sys_newfstatat fs/stat.c:446 [inline]
 __se_sys_newfstatat fs/stat.c:440 [inline]
 __x64_sys_newfstatat+0x14f/0x1d0 fs/stat.c:440
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 5271:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 kasan_save_free_info+0x28/0x40 mm/kasan/generic.c:522
 ____kasan_slab_free+0xd6/0x120 mm/kasan/common.c:236
 kasan_slab_free include/linux/kasan.h:162 [inline]
 slab_free_hook mm/slub.c:1792 [inline]
 slab_free_freelist_hook mm/slub.c:1818 [inline]
 slab_free mm/slub.c:3801 [inline]
 __kmem_cache_free+0x25f/0x3b0 mm/slub.c:3814
 tomoyo_realpath_from_path+0x5a3/0x5e0 security/tomoyo/realpath.c:286
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_perm+0x28d/0x700 security/tomoyo/file.c:822
 security_inode_getattr+0xd3/0x120 security/security.c:2114
 vfs_getattr fs/stat.c:167 [inline]
 vfs_statx+0x18f/0x480 fs/stat.c:242
 vfs_fstatat fs/stat.c:276 [inline]
 __do_sys_newfstatat fs/stat.c:446 [inline]
 __se_sys_newfstatat fs/stat.c:440 [inline]
 __x64_sys_newfstatat+0x14f/0x1d0 fs/stat.c:440
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff88807d254000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 3624 bytes to the right of
 allocated 4096-byte region [ffff88807d254000, ffff88807d255000)

The buggy address belongs to the physical page:
page:ffffea0001f49400 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7d250
head:ffffea0001f49400 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000010200 ffff888012842140 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000040004 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4479, tgid 4479 (udevd), ts 26549380925, free_ts 26143601613
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1e6/0x210 mm/page_alloc.c:1570
 prep_new_page mm/page_alloc.c:1577 [inline]
 get_page_from_freelist+0x31e8/0x3370 mm/page_alloc.c:3221
 __alloc_pages+0x255/0x670 mm/page_alloc.c:4477
 alloc_slab_page+0x6a/0x160 mm/slub.c:1862
 allocate_slab mm/slub.c:2009 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2062
 ___slab_alloc+0xade/0x1100 mm/slub.c:3215
 __slab_alloc mm/slub.c:3314 [inline]
 __slab_alloc_node mm/slub.c:3367 [inline]
 slab_alloc_node mm/slub.c:3460 [inline]
 __kmem_cache_alloc_node+0x1af/0x270 mm/slub.c:3509
 __do_kmalloc_node mm/slab_common.c:984 [inline]
 __kmalloc+0xa8/0x230 mm/slab_common.c:998
 kmalloc include/linux/slab.h:586 [inline]
 tomoyo_realpath_from_path+0xcf/0x5e0 security/tomoyo/realpath.c:251
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path2_perm+0x3b8/0xb20 security/tomoyo/file.c:923
 tomoyo_path_rename+0x198/0x1e0 security/tomoyo/tomoyo.c:299
 security_path_rename+0x173/0x210 security/security.c:1789
 do_renameat2+0x924/0x1660 fs/namei.c:4996
 __do_sys_rename fs/namei.c:5055 [inline]
 __se_sys_rename fs/namei.c:5053 [inline]
 __x64_sys_rename+0x86/0x90 fs/namei.c:5053
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1161 [inline]
 free_unref_page_prepare+0x903/0xa30 mm/page_alloc.c:2348
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2443
 discard_slab mm/slub.c:2108 [inline]
 __unfreeze_partials+0x1dc/0x220 mm/slub.c:2647
 put_cpu_partial+0x116/0x180 mm/slub.c:2723
 __slab_free+0x2b6/0x390 mm/slub.c:3671
 qlist_free_all+0x22/0x60 mm/kasan/quarantine.c:185
 kasan_quarantine_reduce+0x14b/0x160 mm/kasan/quarantine.c:292
 __kasan_slab_alloc+0x23/0x70 mm/kasan/common.c:305
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook+0x6c/0x3b0 mm/slab.h:762
 slab_alloc_node mm/slub.c:3470 [inline]
 slab_alloc mm/slub.c:3478 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3485 [inline]
 kmem_cache_alloc+0x123/0x300 mm/slub.c:3494
 getname_flags+0xbc/0x4e0 fs/namei.c:140
 vfs_fstatat fs/stat.c:275 [inline]
 __do_sys_newfstatat fs/stat.c:446 [inline]
 __se_sys_newfstatat fs/stat.c:440 [inline]
 __x64_sys_newfstatat+0x12e/0x1d0 fs/stat.c:440
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88807d255d00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88807d255d80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88807d255e00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                  ^
 ffff88807d255e80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88807d255f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         f8de32cc Merge tag 'tpmdd-v6.5-rc7' of git://git.kerne..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1231456fa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=171b698bc2e613cf
dashboard link: https://syzkaller.appspot.com/bug?extid=82df44ede2faca24c729
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14c5e773a80000

