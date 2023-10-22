Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE3F7D2556
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 20:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbjJVSh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 14:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJVShy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 14:37:54 -0400
Received: from mail-ot1-f78.google.com (mail-ot1-f78.google.com [209.85.210.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5774AE0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 11:37:52 -0700 (PDT)
Received: by mail-ot1-f78.google.com with SMTP id 46e09a7af769-6c4ededcba7so3539395a34.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 11:37:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697999871; x=1698604671;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uFVGlUE0bTBeZzG3HMCR0baFJSkC3wP+ENnuh3WW1WU=;
        b=jCutgw16QcXR68zEdz584NVHfgoZjBtVefqed1Zd/0ojHnvgvrm3uEhLObuDO2BBz0
         mtb0FDkEOeq6QgIxKnSPYujNmkSkO9lhxcoEffoKyAQrPXkrFjSKt+Osaz7CBUHYDLzS
         s9LNil0z6xXyVba2g3WLly0wvp3KC5TXib5Sm9y9uUf4EXrmE777k140u+zr8xQNyqPa
         R6VIVLEzmLJWA1RZpyx7MpR7gizWog28VS6P4NN2f2pjsL9zSgXVbNHnR/ibdAKO4zFn
         TfCb2GfnSUsKabKqRE66VQ1+JJ7g1EmWkg9EPFU+IQ/BUY0az1Dso8/JIJprrsFcIGqW
         iYow==
X-Gm-Message-State: AOJu0YxCX19BNxdh7DLafgmVb+BZJ32Y35kb5D6L+PcxKYv3MNUQtbt1
        8xPq0H4CsR6u1GcmEGnUfLokwYQ9K2sV9smLYYXczMdykdOF
X-Google-Smtp-Source: AGHT+IG2sZd1Rp9YkYeolkdjwiadv+6Wj1ZmdrjYA16GWpRYA0k12DSLInGa9M8C9G4Tike3uaphk8xdp4NKRvtzrnIqk35aQatl
MIME-Version: 1.0
X-Received: by 2002:a05:6830:140e:b0:6ce:262b:630a with SMTP id
 v14-20020a056830140e00b006ce262b630amr2199682otp.6.1697999871706; Sun, 22 Oct
 2023 11:37:51 -0700 (PDT)
Date:   Sun, 22 Oct 2023 11:37:51 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002e8d4a06085267f3@google.com>
Subject: [syzbot] [net?] KASAN: slab-use-after-free Read in ptp_read
From:   syzbot <syzbot+9704e6f099d952508943@syzkaller.appspotmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, reibax@gmail.com, richardcochran@gmail.com,
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

syzbot found the following issue on:

HEAD commit:    2dac75696c6d Add linux-next specific files for 20231018
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12543ee5680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6f8545e1ef7a2b66
dashboard link: https://syzkaller.appspot.com/bug?extid=9704e6f099d952508943
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11136303680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1753f619680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2375f16ed327/disk-2dac7569.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c80aee6e2e6c/vmlinux-2dac7569.xz
kernel image: https://storage.googleapis.com/syzbot-assets/664dc23b738d/bzImage-2dac7569.xz

The issue was bisected to:

commit 8f5de6fb245326704f37d91780b9a10253a8a100
Author: Xabier Marquiegui <reibax@gmail.com>
Date:   Wed Oct 11 22:39:55 2023 +0000

    ptp: support multiple timestamp event readers

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=136f424d680000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10ef424d680000
console output: https://syzkaller.appspot.com/x/log.txt?x=176f424d680000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9704e6f099d952508943@syzkaller.appspotmail.com
Fixes: 8f5de6fb2453 ("ptp: support multiple timestamp event readers")

==================================================================
BUG: KASAN: slab-use-after-free in queue_cnt drivers/ptp/ptp_private.h:89 [inline]
BUG: KASAN: slab-use-after-free in ptp_read+0x7c4/0x830 drivers/ptp/ptp_chardev.c:547
Read of size 4 at addr ffff88801af1d004 by task syz-executor341/5060

CPU: 0 PID: 5060 Comm: syz-executor341 Not tainted 6.6.0-rc6-next-20231018-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 queue_cnt drivers/ptp/ptp_private.h:89 [inline]
 ptp_read+0x7c4/0x830 drivers/ptp/ptp_chardev.c:547
 posix_clock_read+0x138/0x1b0 kernel/time/posix-clock.c:51
 vfs_read+0x1ce/0x8f0 fs/read_write.c:468
 ksys_read+0x12f/0x250 fs/read_write.c:613
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f79c5938c39
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f79c58fb238 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007f79c59c2308 RCX: 00007f79c5938c39
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007f79c59c2300 R08: 00007f79c58fb6c0 R09: 00007f79c58fb6c0
R10: 00007f79c58fb6c0 R11: 0000000000000246 R12: 7074702f7665642f
R13: 0000000000000000 R14: 00007ffca835e430 R15: 00007ffca835e518
 </TASK>

Allocated by task 5060:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:721 [inline]
 ptp_open+0xe3/0x4f0 drivers/ptp/ptp_chardev.c:112
 posix_clock_open+0x17e/0x240 kernel/time/posix-clock.c:134
 chrdev_open+0x26d/0x6e0 fs/char_dev.c:414
 do_dentry_open+0x8d4/0x18d0 fs/open.c:948
 do_open fs/namei.c:3621 [inline]
 path_openat+0x1d3b/0x2ce0 fs/namei.c:3778
 do_filp_open+0x1de/0x430 fs/namei.c:3808
 do_sys_openat2+0x176/0x1e0 fs/open.c:1440
 do_sys_open fs/open.c:1455 [inline]
 __do_sys_openat fs/open.c:1471 [inline]
 __se_sys_openat fs/open.c:1466 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1466
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Freed by task 5061:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:522
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x15b/0x1b0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:164 [inline]
 slab_free_hook mm/slub.c:1800 [inline]
 slab_free_freelist_hook+0x114/0x1e0 mm/slub.c:1826
 slab_free mm/slub.c:3809 [inline]
 __kmem_cache_free+0xc0/0x180 mm/slub.c:3822
 ptp_release+0x204/0x2b0 drivers/ptp/ptp_chardev.c:150
 ptp_read+0xf6/0x830 drivers/ptp/ptp_chardev.c:589
 posix_clock_read+0x138/0x1b0 kernel/time/posix-clock.c:51
 vfs_read+0x1ce/0x8f0 fs/read_write.c:468
 ksys_read+0x12f/0x250 fs/read_write.c:613
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

The buggy address belongs to the object at ffff88801af1c000
 which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 4100 bytes inside of
 freed 8192-byte region [ffff88801af1c000, ffff88801af1e000)

The buggy address belongs to the physical page:
page:ffffea00006bc600 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1af18
head:ffffea00006bc600 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888012c42280 ffffea000067c800 0000000000000002
raw: 0000000000000000 0000000080020002 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 4710, tgid 4710 (rcS), ts 62110954256, free_ts 62079685567
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2cf/0x340 mm/page_alloc.c:1537
 prep_new_page mm/page_alloc.c:1544 [inline]
 get_page_from_freelist+0xa16/0x3680 mm/page_alloc.c:3348
 __alloc_pages+0x1d0/0x4c0 mm/page_alloc.c:4604
 alloc_pages_mpol+0x258/0x5f0 mm/mempolicy.c:2133
 alloc_slab_page mm/slub.c:1870 [inline]
 allocate_slab+0x251/0x380 mm/slub.c:2017
 new_slab mm/slub.c:2070 [inline]
 ___slab_alloc+0x8c7/0x1580 mm/slub.c:3223
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3322
 __slab_alloc_node mm/slub.c:3375 [inline]
 slab_alloc_node mm/slub.c:3468 [inline]
 __kmem_cache_alloc_node+0x131/0x310 mm/slub.c:3517
 kmalloc_trace+0x27/0xf0 mm/slab_common.c:1098
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:721 [inline]
 tomoyo_print_bprm security/tomoyo/audit.c:26 [inline]
 tomoyo_init_log+0xcdf/0x2110 security/tomoyo/audit.c:264
 tomoyo_supervisor+0x30c/0xea0 security/tomoyo/common.c:2089
 tomoyo_audit_env_log security/tomoyo/environ.c:36 [inline]
 tomoyo_env_perm+0x18f/0x200 security/tomoyo/environ.c:63
 tomoyo_environ security/tomoyo/domain.c:672 [inline]
 tomoyo_find_next_domain+0xef6/0x2020 security/tomoyo/domain.c:878
 tomoyo_bprm_check_security security/tomoyo/tomoyo.c:101 [inline]
 tomoyo_bprm_check_security+0x12b/0x1d0 security/tomoyo/tomoyo.c:91
 security_bprm_check+0x6a/0xe0 security/security.c:1103
 search_binary_handler fs/exec.c:1725 [inline]
 exec_binprm fs/exec.c:1779 [inline]
 bprm_execve fs/exec.c:1854 [inline]
 bprm_execve+0x738/0x1a90 fs/exec.c:1810
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1137 [inline]
 free_unref_page_prepare+0x476/0xa40 mm/page_alloc.c:2383
 free_unref_page+0x33/0x3b0 mm/page_alloc.c:2523
 __unfreeze_partials+0x21d/0x240 mm/slub.c:2655
 qlink_free mm/kasan/quarantine.c:168 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x18e/0x1d0 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x65/0x90 mm/kasan/common.c:305
 kasan_slab_alloc include/linux/kasan.h:188 [inline]
 slab_post_alloc_hook mm/slab.h:763 [inline]
 slab_alloc_node mm/slub.c:3478 [inline]
 __kmem_cache_alloc_node+0x195/0x310 mm/slub.c:3517
 kmalloc_trace+0x27/0xf0 mm/slab_common.c:1098
 kmalloc include/linux/slab.h:600 [inline]
 tomoyo_print_header security/tomoyo/audit.c:156 [inline]
 tomoyo_init_log+0x1a0/0x2110 security/tomoyo/audit.c:255
 tomoyo_supervisor+0x30c/0xea0 security/tomoyo/common.c:2089
 tomoyo_audit_path_log security/tomoyo/file.c:168 [inline]
 tomoyo_path_permission security/tomoyo/file.c:587 [inline]
 tomoyo_path_permission+0x270/0x3b0 security/tomoyo/file.c:573
 tomoyo_check_open_permission+0x371/0x3b0 security/tomoyo/file.c:777
 tomoyo_file_open security/tomoyo/tomoyo.c:332 [inline]
 tomoyo_file_open+0xa8/0xd0 security/tomoyo/tomoyo.c:327
 security_file_open+0x6a/0xe0 security/security.c:2836
 do_dentry_open+0x583/0x18d0 fs/open.c:935
 do_open fs/namei.c:3621 [inline]
 path_openat+0x1d3b/0x2ce0 fs/namei.c:3778

Memory state around the buggy address:
 ffff88801af1cf00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88801af1cf80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88801af1d000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff88801af1d080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88801af1d100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
