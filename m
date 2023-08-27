Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83FCD789B19
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 05:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjH0DPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 23:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjH0DPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 23:15:31 -0400
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAA2EC
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 20:15:28 -0700 (PDT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-26f49625bffso1812438a91.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 20:15:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693106128; x=1693710928;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qkQv22+r3quH7dAbkzpxZoL8dR8kxbkLp/89MmjeT3I=;
        b=VWGdqEXqFfwp6WLwuOGJbtkrfOYuX8tuV0kwdjT02NZSTy4DTiKyf0FYaiiLc/oaZE
         luCS0lnBZznajJ5ndBDD6r75eyL9gpmn4QA+T1jZ6ZQt1mj5jtpSdIgZhffErqIi6Pqm
         92nmp84bJIQblh3O3V90lHd24Tz8i5jlojuszvAGUzQENOaifAsSZYcoWJqG6tIkpL2d
         J2yJd7oS9eQU3k82LIIz8xEwvm3IoTnC8KMfb/6EoZRO8aE5pE5A6sBB5AHVM8MbwRdT
         Yq9UKpeL+AylB5/39PaTDiy4R2QwRL5YjaeHIdRpxGcUPrWEMD34uw57IpoW/mrm7T/I
         aJWw==
X-Gm-Message-State: AOJu0YxYn+7zByGOKZVEhG4uDl/An7PlhugfD15uKnKQv44Fql7Gs1Cq
        IPSvFASPYY5ebTiN9Cjeu5ulm9dds+RIM4lDkoi4rpY0nC4A
X-Google-Smtp-Source: AGHT+IFywrMdcPUsyRpvZBevmcu29BknAxTb45qMBhbucWVITjkvMWp+1Vvi2ta0QgnBEkenJ7d+YkvYIZ/BAYSWLwYuHoCCgzIq
MIME-Version: 1.0
X-Received: by 2002:a17:903:1247:b0:1b8:a54c:61ef with SMTP id
 u7-20020a170903124700b001b8a54c61efmr7861438plh.9.1693106127946; Sat, 26 Aug
 2023 20:15:27 -0700 (PDT)
Date:   Sat, 26 Aug 2023 20:15:27 -0700
In-Reply-To: <20230827020301.3530-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000052d1b00603defd5a@google.com>
Subject: Re: [syzbot] [kernfs?] KASAN: slab-use-after-free Read in kernfs_test_super
From:   syzbot <syzbot+f25c61df1ec3d235d52f@syzkaller.appspotmail.com>
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
KASAN: slab-use-after-free Read in kernfs_test_super

==================================================================
BUG: KASAN: slab-use-after-free in kernfs_test_super+0x122/0x150 fs/kernfs/mount.c:295
Read of size 8 at addr ffff88807559d608 by task syz-executor.3/5904

CPU: 0 PID: 5904 Comm: syz-executor.3 Not tainted 6.5.0-rc7-next-20230822-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 kernfs_test_super+0x122/0x150 fs/kernfs/mount.c:295
 sget_fc+0x582/0x9b0 fs/super.c:776
 kernfs_get_tree+0x198/0x9a0 fs/kernfs/mount.c:346
 sysfs_get_tree+0x41/0x140 fs/sysfs/mount.c:31
 vfs_get_tree+0x8c/0x370 fs/super.c:1711
 do_new_mount fs/namespace.c:3335 [inline]
 path_mount+0x1492/0x1ed0 fs/namespace.c:3662
 do_mount fs/namespace.c:3675 [inline]
 __do_sys_mount fs/namespace.c:3884 [inline]
 __se_sys_mount fs/namespace.c:3861 [inline]
 __x64_sys_mount+0x293/0x310 fs/namespace.c:3861
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fbfa307cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbfa3e170c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fbfa319bf80 RCX: 00007fbfa307cae9
RDX: 0000000020000300 RSI: 0000000020000080 RDI: 0000000000000000
RBP: 00007fbfa30c847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fbfa319bf80 R15: 00007ffccce39108
 </TASK>

Allocated by task 5895:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
 kmalloc include/linux/slab.h:599 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 kernfs_get_tree+0x78/0x9a0 fs/kernfs/mount.c:337
 sysfs_get_tree+0x41/0x140 fs/sysfs/mount.c:31
 vfs_get_tree+0x8c/0x370 fs/super.c:1711
 do_new_mount fs/namespace.c:3335 [inline]
 path_mount+0x1492/0x1ed0 fs/namespace.c:3662
 do_mount fs/namespace.c:3675 [inline]
 __do_sys_mount fs/namespace.c:3884 [inline]
 __se_sys_mount fs/namespace.c:3861 [inline]
 __x64_sys_mount+0x293/0x310 fs/namespace.c:3861
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 5409:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:522
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x15b/0x1b0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:164 [inline]
 slab_free_hook mm/slub.c:1800 [inline]
 slab_free_freelist_hook+0x114/0x1e0 mm/slub.c:1826
 slab_free mm/slub.c:3809 [inline]
 __kmem_cache_free+0xb8/0x2f0 mm/slub.c:3822
 sysfs_kill_sb+0x21/0x30 fs/sysfs/mount.c:86
 deactivate_locked_super+0xa0/0x2d0 fs/super.c:454
 deactivate_super+0xde/0x100 fs/super.c:504
 cleanup_mnt+0x222/0x3d0 fs/namespace.c:1254
 task_work_run+0x14d/0x240 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x210/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x1d/0x60 kernel/entry/common.c:297
 do_syscall_64+0x44/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff88807559d600
 which belongs to the cache kmalloc-64 of size 64
The buggy address is located 8 bytes inside of
 freed 64-byte region [ffff88807559d600, ffff88807559d640)

The buggy address belongs to the physical page:
page:ffffea0001d56740 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7559d
flags: 0xfff00000000800(slab|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000800 ffff888012c41640 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000200020 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112c40(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY|__GFP_HARDWALL), pid 4495, tgid 4495 (udevd), ts 112776006479, free_ts 112762382812
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2cf/0x340 mm/page_alloc.c:1530
 prep_new_page mm/page_alloc.c:1537 [inline]
 get_page_from_freelist+0x10d7/0x31b0 mm/page_alloc.c:3213
 __alloc_pages+0x1d0/0x4a0 mm/page_alloc.c:4469
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
 kzalloc include/linux/slab.h:720 [inline]
 tomoyo_encode2+0x100/0x3d0 security/tomoyo/realpath.c:45
 tomoyo_encode+0x29/0x50 security/tomoyo/realpath.c:80
 tomoyo_realpath_from_path+0x196/0x710 security/tomoyo/realpath.c:283
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_check_open_permission+0x2aa/0x3b0 security/tomoyo/file.c:771
 tomoyo_file_open security/tomoyo/tomoyo.c:332 [inline]
 tomoyo_file_open+0xa8/0xd0 security/tomoyo/tomoyo.c:327
 security_file_open+0x6a/0xe0 security/security.c:2836
 do_dentry_open+0x538/0x1730 fs/open.c:916
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1130 [inline]
 free_unref_page_prepare+0x476/0xa40 mm/page_alloc.c:2342
 free_unref_page+0x33/0x3b0 mm/page_alloc.c:2435
 __unfreeze_partials+0x21d/0x240 mm/slub.c:2655
 qlink_free mm/kasan/quarantine.c:166 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:185
 kasan_quarantine_reduce+0x18b/0x1d0 mm/kasan/quarantine.c:292
 __kasan_slab_alloc+0x65/0x90 mm/kasan/common.c:305
 kasan_slab_alloc include/linux/kasan.h:188 [inline]
 slab_post_alloc_hook mm/slab.h:762 [inline]
 slab_alloc_node mm/slub.c:3478 [inline]
 __kmem_cache_alloc_node+0x19b/0x350 mm/slub.c:3517
 __do_kmalloc_node mm/slab_common.c:1022 [inline]
 __kmalloc+0x4f/0x100 mm/slab_common.c:1036
 kmalloc include/linux/slab.h:603 [inline]
 tomoyo_realpath_from_path+0xb9/0x710 security/tomoyo/realpath.c:251
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_number_perm+0x243/0x590 security/tomoyo/file.c:723
 security_file_ioctl+0x72/0xb0 security/security.c:2647
 __do_sys_ioctl fs/ioctl.c:865 [inline]
 __se_sys_ioctl fs/ioctl.c:857 [inline]
 __x64_sys_ioctl+0xbb/0x210 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88807559d500: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff88807559d580: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>ffff88807559d600: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
                      ^
 ffff88807559d680: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff88807559d700: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         28c736b0 Add linux-next specific files for 20230822
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=145d11e0680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=20999f779fa96017
dashboard link: https://syzkaller.appspot.com/bug?extid=f25c61df1ec3d235d52f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1570f187a80000

