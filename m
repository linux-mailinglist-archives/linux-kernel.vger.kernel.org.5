Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC12178EF4C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 16:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345995AbjHaOJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 10:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346143AbjHaOJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 10:09:01 -0400
Received: from mail-pg1-f206.google.com (mail-pg1-f206.google.com [209.85.215.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA2ED7
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 07:08:51 -0700 (PDT)
Received: by mail-pg1-f206.google.com with SMTP id 41be03b00d2f7-570096f51acso782257a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 07:08:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693490930; x=1694095730;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y69wRiW/7EFoXp8Ea7n7MhAJ3pFY/pldn4BtBDUsmqU=;
        b=K7W7tLlCMCrpot2RFtcVSP4fL0beiLdrPH+VUic7hOxL+WY/ZBYijrEvgfsPqWv/97
         HCtsEslS2KNPycxYJJYU/W1C+cyP9Uzwt3Kf1fq94VpQzgl6Uacxc0tc8bOG5rbiMJgp
         7AbSkbbDhsvGtCv7d9JdvuZw8kmc9xJA3/KZzjL26mPKOmAanrr6/i+j8Nc4EeJdp0WO
         406ZKjsFIcJD9FipjUZKmRVdllFgwzJO7BqgcavIXkYO7hG3IeDhLsfhQEHIWDWqPmaY
         3yzCIvmf4eT8QA5HrJh8ZkxCkWNNaIjHXHbJANq1C/6y6d6mEiCrQFhtwmKpmr0qMQgL
         r6WQ==
X-Gm-Message-State: AOJu0YxMuS7xGkpxJAdpvQf4YSSwF2aAFGM1waXbicFbfox7H00nhPuN
        qtyegnHKxW0e0vvPOUM479hI7FPdenk0lQcy9Rorl/iIlAWu
X-Google-Smtp-Source: AGHT+IEoWEesxBYhnOkNEGeUDVkC0t8e9++tzg0ettwj9zEij2pOOzEpFby+X5r/wkOwKcHbgnjwTKoGkOHxittipopVJ5/+YbVX
MIME-Version: 1.0
X-Received: by 2002:a63:754f:0:b0:56c:55eb:252b with SMTP id
 f15-20020a63754f000000b0056c55eb252bmr294350pgn.5.1693490930766; Thu, 31 Aug
 2023 07:08:50 -0700 (PDT)
Date:   Thu, 31 Aug 2023 07:08:50 -0700
In-Reply-To: <000000000000ebf27305f64b04d8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005bdb2106043895cc@google.com>
Subject: Re: [syzbot] [kernel?] KASAN: slab-use-after-free Read in dev_uevent
From:   syzbot <syzbot+5ee79919ffe91d629b96@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    ef2a0b7cdbc5 Merge tag 'devicetree-header-cleanups-for-6.6..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1636912fa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=70a96c99bb5352a3
dashboard link: https://syzkaller.appspot.com/bug?extid=5ee79919ffe91d629b96
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1113aa10680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1738dfffa80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/207d0a5481f5/disk-ef2a0b7c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/33a620ea40a4/vmlinux-ef2a0b7c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/93ff8f39ac26/bzImage-ef2a0b7c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5ee79919ffe91d629b96@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in string_nocheck lib/vsprintf.c:645 [inline]
BUG: KASAN: slab-use-after-free in string+0x218/0x2b0 lib/vsprintf.c:727
Read of size 1 at addr ffff88802c09a487 by task udevd/9531

CPU: 0 PID: 9531 Comm: udevd Not tainted 6.5.0-syzkaller-08262-gef2a0b7cdbc5 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:475
 kasan_report+0x175/0x1b0 mm/kasan/report.c:588
 string_nocheck lib/vsprintf.c:645 [inline]
 string+0x218/0x2b0 lib/vsprintf.c:727
 vsnprintf+0x10fc/0x1d80 lib/vsprintf.c:2818
 add_uevent_var+0x1c4/0x440 lib/kobject_uevent.c:665
 dev_uevent+0x3ec/0x8f0 drivers/base/core.c:2575
 uevent_show+0x19a/0x310 drivers/base/core.c:2646
 dev_attr_show+0x54/0xc0 drivers/base/core.c:2349
 sysfs_kf_seq_show+0x331/0x4b0 fs/sysfs/file.c:59
 seq_read_iter+0x43e/0xd10 fs/seq_file.c:230
 call_read_iter include/linux/fs.h:1979 [inline]
 new_sync_read fs/read_write.c:389 [inline]
 vfs_read+0x795/0xb00 fs/read_write.c:470
 ksys_read+0x1a0/0x2c0 fs/read_write.c:613
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f49f3b16b6a
Code: 00 3d 00 00 41 00 75 0d 50 48 8d 3d 2d 08 0a 00 e8 ea 7d 01 00 31 c0 e9 07 ff ff ff 64 8b 04 25 18 00 00 00 85 c0 75 1b 0f 05 <48> 3d 00 f0 ff ff 76 6c 48 8b 15 8f a2 0d 00 f7 d8 64 89 02 48 83
RSP: 002b:00007ffcd3fc9478 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 000055dfae9e07a0 RCX: 00007f49f3b16b6a
RDX: 0000000000001000 RSI: 000055dfae9e0980 RDI: 0000000000000008
RBP: 000055dfae9e07a0 R08: 0000000000000008 R09: 0000000000000000
R10: 000000000000010f R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000003fff R14: 00007ffcd3fc9958 R15: 000000000000000a
 </TASK>

Allocated by task 12253:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:383
 kmalloc include/linux/slab.h:599 [inline]
 raw_ioctl_init drivers/usb/gadget/legacy/raw_gadget.c:462 [inline]
 raw_ioctl+0x1aad/0x3cd0 drivers/usb/gadget/legacy/raw_gadget.c:1252
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 12253:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 kasan_save_free_info+0x28/0x40 mm/kasan/generic.c:522
 ____kasan_slab_free+0xd6/0x120 mm/kasan/common.c:236
 kasan_slab_free include/linux/kasan.h:162 [inline]
 slab_free_hook mm/slub.c:1800 [inline]
 slab_free_freelist_hook mm/slub.c:1826 [inline]
 slab_free mm/slub.c:3809 [inline]
 __kmem_cache_free+0x25f/0x3b0 mm/slub.c:3822
 dev_free drivers/usb/gadget/legacy/raw_gadget.c:210 [inline]
 kref_put+0xb5/0x7c0 include/linux/kref.h:65
 raw_release+0x138/0x1e0 drivers/usb/gadget/legacy/raw_gadget.c:426
 __fput+0x3f8/0x910 fs/file_table.c:384
 task_work_run+0x24a/0x300 kernel/task_work.c:179
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0x68f/0x2290 kernel/exit.c:874
 do_group_exit+0x206/0x2c0 kernel/exit.c:1024
 __do_sys_exit_group kernel/exit.c:1035 [inline]
 __se_sys_exit_group kernel/exit.c:1033 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1033
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff88802c09a480
 which belongs to the cache kmalloc-32 of size 32
The buggy address is located 7 bytes inside of
 freed 32-byte region [ffff88802c09a480, ffff88802c09a4a0)

The buggy address belongs to the physical page:
page:ffffea0000b02680 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2c09a
ksm flags: 0xfff00000000800(slab|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000800 ffff888012841500 ffffea000057f180 dead000000000003
raw: 0000000000000000 0000000000400040 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12c40(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY), pid 4463, tgid 4463 (S02klogd), ts 15840613892, free_ts 14931433200
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1e6/0x210 mm/page_alloc.c:1536
 prep_new_page mm/page_alloc.c:1543 [inline]
 get_page_from_freelist+0x31ec/0x3370 mm/page_alloc.c:3183
 __alloc_pages+0x255/0x670 mm/page_alloc.c:4439
 alloc_slab_page+0x6a/0x160 mm/slub.c:1870
 allocate_slab mm/slub.c:2017 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2070
 ___slab_alloc+0xade/0x1100 mm/slub.c:3223
 __slab_alloc mm/slub.c:3322 [inline]
 __slab_alloc_node mm/slub.c:3375 [inline]
 slab_alloc_node mm/slub.c:3468 [inline]
 __kmem_cache_alloc_node+0x1af/0x270 mm/slub.c:3517
 __do_kmalloc_node mm/slab_common.c:1022 [inline]
 __kmalloc+0xa8/0x230 mm/slab_common.c:1036
 kmalloc include/linux/slab.h:603 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 tomoyo_encode2 security/tomoyo/realpath.c:45 [inline]
 tomoyo_encode+0x26f/0x530 security/tomoyo/realpath.c:80
 tomoyo_realpath_from_path+0x598/0x5e0 security/tomoyo/realpath.c:283
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_check_open_permission+0x254/0x4e0 security/tomoyo/file.c:771
 security_file_open+0x63/0xa0 security/security.c:2836
 do_dentry_open+0x325/0x1430 fs/open.c:916
 do_open fs/namei.c:3639 [inline]
 path_openat+0x27bb/0x3180 fs/namei.c:3796
 do_filp_open+0x234/0x490 fs/namei.c:3823
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1422
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1136 [inline]
 free_unref_page_prepare+0x8c3/0x9f0 mm/page_alloc.c:2312
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2405
 kasan_depopulate_vmalloc_pte+0x74/0x90 mm/kasan/shadow.c:427
 apply_to_pte_range mm/memory.c:2585 [inline]
 apply_to_pmd_range mm/memory.c:2629 [inline]
 apply_to_pud_range mm/memory.c:2665 [inline]
 apply_to_p4d_range mm/memory.c:2701 [inline]
 __apply_to_page_range+0x8e2/0xdf0 mm/memory.c:2735
 kasan_release_vmalloc+0x9a/0xb0 mm/kasan/shadow.c:544
 __purge_vmap_area_lazy+0xc0f/0x19c0 mm/vmalloc.c:1770
 _vm_unmap_aliases+0x79d/0x840 mm/vmalloc.c:2306
 change_page_attr_set_clr+0x2f8/0xf80 arch/x86/mm/pat/set_memory.c:1838
 change_page_attr_set arch/x86/mm/pat/set_memory.c:1879 [inline]
 set_memory_nx+0xf2/0x130 arch/x86/mm/pat/set_memory.c:2072
 free_init_pages arch/x86/mm/init.c:927 [inline]
 free_kernel_image_pages arch/x86/mm/init.c:946 [inline]
 free_initmem+0x75/0xc0 arch/x86/mm/init.c:973
 kernel_init+0x31/0x2a0 init/main.c:1446
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:145
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

Memory state around the buggy address:
 ffff88802c09a380: 00 00 00 fc fc fc fc fc fa fb fb fb fc fc fc fc
 ffff88802c09a400: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
>ffff88802c09a480: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
                   ^
 ffff88802c09a500: fa fb fb fb fc fc fc fc 00 00 00 00 fc fc fc fc
 ffff88802c09a580: fa fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
