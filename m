Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B397903D4
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 00:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351142AbjIAWzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 18:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351102AbjIAWzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 18:55:05 -0400
Received: from mail-pg1-f207.google.com (mail-pg1-f207.google.com [209.85.215.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCC61982
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 14:09:49 -0700 (PDT)
Received: by mail-pg1-f207.google.com with SMTP id 41be03b00d2f7-56c49207ce2so2639069a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 14:09:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693602589; x=1694207389;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rHA6IU4YUc+nHmSg07snvf4B/OzsiCZp4v/QLp4ekP0=;
        b=WdegWGz98DdwMOfS0Nx6HEGoIyk0stalGqymODfdLaazItrW54Mn3xmSl7sPKQ6uyH
         kuL7nUhv921mU8Aw3sjz7bKAdaeDHhpz3n6/mSzp/ThF5aEWYGekBf+FOqrtNhTpz5mp
         RwabPYqxHOB97sX2udQxeQdH3k7lTQGpZqURdWMoUGb9Y/2sB3zYd7o/45WY5Vcbw5PN
         +gAutsXj4mFsb4Pef02noNNBC88R8a6AXTqb+Q/kbsZv98zhlVZga4nhASLE6exLLjXe
         hEIja69dsD3JSV/EBSckg74dlDr+bau4B4N8kZQMPY/FTiygQptAIx61irBDin6mQ++S
         uJyQ==
X-Gm-Message-State: AOJu0YyHe2xaZsusvrPPW1voT5C1rKOC5D9JDWgiMN/kKA7GnEmycsZl
        DxCOcrku7HVlrRD+pwmGkDbulSdqcMpqRMhba2PCS7wSrp4S
X-Google-Smtp-Source: AGHT+IGJr4YxmdC+jpGKIGAymdCTOcOXxij/xoWvKIX3VHKgEOjmJ4Ou6EC799pKx7B6ER/3RwNk0xFRXys+ZRHg2yVIAt7/YO6D
MIME-Version: 1.0
X-Received: by 2002:a63:8c4f:0:b0:565:f00f:6862 with SMTP id
 q15-20020a638c4f000000b00565f00f6862mr753380pgn.8.1693602588841; Fri, 01 Sep
 2023 14:09:48 -0700 (PDT)
Date:   Fri, 01 Sep 2023 14:09:48 -0700
In-Reply-To: <0000000000007f826b06044878ed@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b2dd65060452948f@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in __sco_sock_close
From:   syzbot <syzbot+dec4d528fb7a7c5d8ce3@syzkaller.appspotmail.com>
To:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    99d99825fc07 Merge tag 'nfs-for-6.6-1' of git://git.linux-..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1636e913a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=988789167afa40d5
dashboard link: https://syzkaller.appspot.com/bug?extid=dec4d528fb7a7c5d8ce3
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12e9ba2fa80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=111affcba80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e43170401ca7/disk-99d99825.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c2be4288f38f/vmlinux-99d99825.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8a6478588fd9/bzImage-99d99825.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dec4d528fb7a7c5d8ce3@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
BUG: KASAN: slab-use-after-free in atomic_dec_and_test include/linux/atomic/atomic-instrumented.h:1375 [inline]
BUG: KASAN: slab-use-after-free in hci_conn_drop include/net/bluetooth/hci_core.h:1523 [inline]
BUG: KASAN: slab-use-after-free in __sco_sock_close+0x2bc/0x690 net/bluetooth/sco.c:444
Write of size 4 at addr ffff888079e5e010 by task syz-executor321/5276

CPU: 0 PID: 5276 Comm: syz-executor321 Not tainted 6.5.0-syzkaller-09276-g99d99825fc07 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 check_region_inline mm/kasan/generic.c:181 [inline]
 kasan_check_range+0xef/0x190 mm/kasan/generic.c:187
 instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
 atomic_dec_and_test include/linux/atomic/atomic-instrumented.h:1375 [inline]
 hci_conn_drop include/net/bluetooth/hci_core.h:1523 [inline]
 __sco_sock_close+0x2bc/0x690 net/bluetooth/sco.c:444
 sco_sock_close net/bluetooth/sco.c:469 [inline]
 sco_sock_release+0x6f/0x2c0 net/bluetooth/sco.c:1246
 __sock_release+0xae/0x260 net/socket.c:659
 sock_close+0x1c/0x20 net/socket.c:1401
 __fput+0x3f7/0xa70 fs/file_table.c:384
 task_work_run+0x14d/0x240 kernel/task_work.c:179
 ptrace_notify+0x10c/0x130 kernel/signal.c:2387
 ptrace_report_syscall include/linux/ptrace.h:411 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:473 [inline]
 syscall_exit_work kernel/entry/common.c:251 [inline]
 syscall_exit_to_user_mode_prepare+0x120/0x220 kernel/entry/common.c:278
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0xd/0x60 kernel/entry/common.c:296
 do_syscall_64+0x44/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fe1bd28f279
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe1bca4e218 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: 0000000000000000 RBX: 00007fe1bd319328 RCX: 00007fe1bd28f279
RDX: 0000000000000008 RSI: 0000000020000040 RDI: 0000000000000004
RBP: 00007fe1bd319320 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
R13: 0000000000000004 R14: 00007fe1bca4e670 R15: 0000000000000000
 </TASK>

Allocated by task 5276:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
 kmalloc include/linux/slab.h:599 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 hci_conn_add+0xc2/0x1770 net/bluetooth/hci_conn.c:957
 hci_connect_sco+0x3ac/0xf80 net/bluetooth/hci_conn.c:1692
 sco_connect net/bluetooth/sco.c:266 [inline]
 sco_sock_connect+0x2c7/0xa50 net/bluetooth/sco.c:591
 __sys_connect_file+0x15b/0x1a0 net/socket.c:2032
 __sys_connect+0x145/0x170 net/socket.c:2049
 __do_sys_connect net/socket.c:2059 [inline]
 __se_sys_connect net/socket.c:2056 [inline]
 __x64_sys_connect+0x72/0xb0 net/socket.c:2056
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 5054:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:522
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x15b/0x1b0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:162 [inline]
 slab_free_hook mm/slub.c:1800 [inline]
 slab_free_freelist_hook+0x114/0x1e0 mm/slub.c:1826
 slab_free mm/slub.c:3809 [inline]
 __kmem_cache_free+0xb8/0x2f0 mm/slub.c:3822
 device_release+0xa1/0x240 drivers/base/core.c:2484
 kobject_cleanup lib/kobject.c:682 [inline]
 kobject_release lib/kobject.c:713 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1f7/0x5b0 lib/kobject.c:730
 put_device+0x1f/0x30 drivers/base/core.c:3731
 hci_abort_conn_sync+0xacb/0xe20 net/bluetooth/hci_sync.c:5435
 abort_conn_sync+0x18e/0x3a0 net/bluetooth/hci_conn.c:2894
 hci_cmd_sync_work+0x1a4/0x3c0 net/bluetooth/hci_sync.c:306
 process_one_work+0xaa2/0x16f0 kernel/workqueue.c:2600
 worker_thread+0x687/0x1110 kernel/workqueue.c:2751
 kthread+0x33a/0x430 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

The buggy address belongs to the object at ffff888079e5e000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 16 bytes inside of
 freed 4096-byte region [ffff888079e5e000, ffff888079e5f000)

The buggy address belongs to the physical page:
page:ffffea0001e79600 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x79e58
head:ffffea0001e79600 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888012842140 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000040004 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4494, tgid 4494 (udevd), ts 25028304092, free_ts 25023027630
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2cf/0x340 mm/page_alloc.c:1536
 prep_new_page mm/page_alloc.c:1543 [inline]
 get_page_from_freelist+0x10a9/0x31e0 mm/page_alloc.c:3183
 __alloc_pages+0x1d0/0x4a0 mm/page_alloc.c:4439
 alloc_pages+0x1a9/0x270 mm/mempolicy.c:2298
 alloc_slab_page mm/slub.c:1870 [inline]
 allocate_slab+0x251/0x380 mm/slub.c:2017
 new_slab mm/slub.c:2070 [inline]
 ___slab_alloc+0x8be/0x1570 mm/slub.c:3223
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3322
 __slab_alloc_node mm/slub.c:3375 [inline]
 slab_alloc_node mm/slub.c:3468 [inline]
 __kmem_cache_alloc_node+0x137/0x350 mm/slub.c:3517
 __do_kmalloc_node mm/slab_common.c:1022 [inline]
 __kmalloc+0x4f/0x100 mm/slab_common.c:1036
 kmalloc include/linux/slab.h:603 [inline]
 tomoyo_realpath_from_path+0xb9/0x710 security/tomoyo/realpath.c:251
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path2_perm+0x2a1/0x710 security/tomoyo/file.c:922
 tomoyo_path_rename+0x102/0x1b0 security/tomoyo/tomoyo.c:299
 security_path_rename+0x148/0x230 security/security.c:1828
 do_renameat2+0x78b/0xdc0 fs/namei.c:4999
 __do_sys_rename fs/namei.c:5058 [inline]
 __se_sys_rename fs/namei.c:5056 [inline]
 __x64_sys_rename+0x81/0xa0 fs/namei.c:5056
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1136 [inline]
 free_unref_page_prepare+0x476/0xa40 mm/page_alloc.c:2312
 free_unref_page+0x33/0x3b0 mm/page_alloc.c:2405
 __unfreeze_partials+0x21d/0x240 mm/slub.c:2655
 qlink_free mm/kasan/quarantine.c:166 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:185
 kasan_quarantine_reduce+0x18b/0x1d0 mm/kasan/quarantine.c:292
 __kasan_slab_alloc+0x65/0x90 mm/kasan/common.c:305
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook mm/slab.h:762 [inline]
 slab_alloc_node mm/slub.c:3478 [inline]
 __kmem_cache_alloc_node+0x19b/0x350 mm/slub.c:3517
 kmalloc_trace+0x25/0xe0 mm/slab_common.c:1114
 kmalloc include/linux/slab.h:599 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 kernfs_get_open_node fs/kernfs/file.c:572 [inline]
 kernfs_fop_open+0xad1/0xe00 fs/kernfs/file.c:740
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

Memory state around the buggy address:
 ffff888079e5df00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888079e5df80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888079e5e000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff888079e5e080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888079e5e100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
