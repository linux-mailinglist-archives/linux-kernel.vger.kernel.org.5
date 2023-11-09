Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D24B7E6562
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 09:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbjKIIgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 03:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbjKIIge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 03:36:34 -0500
Received: from mail-pl1-f205.google.com (mail-pl1-f205.google.com [209.85.214.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322D41723
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 00:36:32 -0800 (PST)
Received: by mail-pl1-f205.google.com with SMTP id d9443c01a7336-1cc482cc026so5987495ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 00:36:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699518991; x=1700123791;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=41XWWDi2o7SKIgFmKYMcGYX5sEcMu8NNwvSuE9dw4Jg=;
        b=D7Euip77uchJvuoEi47xiwZvW18pUbR6KbklJCR9sgDBHewd7MidhaRWYDr0INuzQ9
         9otnxLkSQOF06T2L1xe8+R0f+zFFFwlZVan1jHWRN+VuFEBbGvNOBSAdgr69oL9Gx+3A
         eet6NZkn6MuGvkOYCbyqZ6GibclFoEoKpDgLm55Hbxpe6ZeLsMJPW4S05UqUl0Iu60nS
         tkUERxV5Ta3mbW6D/ONrbpN/7QISCDmd/y3pwKZRGxMtiTqJL0IuYaXyMUGzwpAniZoq
         lGIMtlAtz2onaHqN24uWFRJp8O3IWEy0S3pcB4V63IbXwfaEj8I6IGCQDhBqcXZJ7BHY
         klaQ==
X-Gm-Message-State: AOJu0YzKkhJX2B9ONgwkjs2q6bjUWbOwkZCKT2GWvm2RkbKuNfivc7oz
        WnFg0SZR0VCP1An9xmHMbS71WlIs7qASW58AxPi9hQFDLFue
X-Google-Smtp-Source: AGHT+IFOyXgFRDb+gl/1Vg8S3j+inEfgVamxtQlM5HY92XBh/3z0jfmr0d43nAALDrOoCWGtHjHHPDBb80rENasKDcsMcNXdVnUa
MIME-Version: 1.0
X-Received: by 2002:a17:903:1c3:b0:1cc:3147:6937 with SMTP id
 e3-20020a17090301c300b001cc31476937mr348828plh.4.1699518991763; Thu, 09 Nov
 2023 00:36:31 -0800 (PST)
Date:   Thu, 09 Nov 2023 00:36:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cb112e0609b419d3@google.com>
Subject: [syzbot] [net?] [nfc?] KASAN: slab-use-after-free Read in nfc_alloc_send_skb
From:   syzbot <syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com,
        krzysztof.kozlowski@linaro.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    aea6bf908d73 Merge tag 'f2fs-for-6.7-rc1' of git://git.ker..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=134b06eb680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=93ac5233c138249e
dashboard link: https://syzkaller.appspot.com/bug?extid=bbe84a4010eeea00982d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1336f6eb680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=165d67f3680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3e461e471e00/disk-aea6bf90.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3f1784e1f86e/vmlinux-aea6bf90.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4f7a660ae0d9/bzImage-aea6bf90.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com

llcp: nfc_llcp_send_ui_frame: Could not allocate PDU (error=-6)
==================================================================
BUG: KASAN: slab-use-after-free in nfc_alloc_send_skb+0x149/0x1c0 net/nfc/core.c:722
Read of size 4 at addr ffff888075231548 by task syz-executor193/5062

CPU: 1 PID: 5062 Comm: syz-executor193 Not tainted 6.6.0-syzkaller-14263-gaea6bf908d73 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:475
 kasan_report+0x142/0x170 mm/kasan/report.c:588
 nfc_alloc_send_skb+0x149/0x1c0 net/nfc/core.c:722
 nfc_llcp_send_ui_frame+0x2ac/0x670 net/nfc/llcp_commands.c:766
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0x592/0x890 net/socket.c:2588
 ___sys_sendmsg net/socket.c:2642 [inline]
 __sys_sendmmsg+0x3b2/0x730 net/socket.c:2728
 __do_sys_sendmmsg net/socket.c:2757 [inline]
 __se_sys_sendmmsg net/socket.c:2754 [inline]
 __x64_sys_sendmmsg+0xa0/0xb0 net/socket.c:2754
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fa0a3c77969
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa0a3c38208 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 00007fa0a3d03328 RCX: 00007fa0a3c77969
RDX: 0000000000000001 RSI: 00000000200013c0 RDI: 0000000000000004
RBP: 00007fa0a3d03320 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fa0a3cd01a4
R13: 0000000000000039 R14: 00007fa0a3d010f0 R15: 00007fa0a3c38670
 </TASK>

Allocated by task 5062:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:383
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:721 [inline]
 nfc_allocate_device+0x12f/0x520 net/nfc/core.c:1065
 nci_allocate_device+0x1e2/0x360 net/nfc/nci/core.c:1179
 virtual_ncidev_open+0x75/0x1b0 drivers/nfc/virtual_ncidev.c:136
 misc_open+0x30b/0x380 drivers/char/misc.c:165
 chrdev_open+0x5ab/0x630 fs/char_dev.c:414
 do_dentry_open+0x8fd/0x1590 fs/open.c:948
 do_open fs/namei.c:3622 [inline]
 path_openat+0x2845/0x3280 fs/namei.c:3779
 do_filp_open+0x234/0x490 fs/namei.c:3809
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1440
 do_sys_open fs/open.c:1455 [inline]
 __do_sys_openat fs/open.c:1471 [inline]
 __se_sys_openat fs/open.c:1466 [inline]
 __x64_sys_openat+0x247/0x290 fs/open.c:1466
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Freed by task 5061:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 kasan_save_free_info+0x28/0x40 mm/kasan/generic.c:522
 ____kasan_slab_free+0xd6/0x120 mm/kasan/common.c:236
 kasan_slab_free include/linux/kasan.h:164 [inline]
 slab_free_hook mm/slub.c:1800 [inline]
 slab_free_freelist_hook mm/slub.c:1826 [inline]
 slab_free mm/slub.c:3809 [inline]
 __kmem_cache_free+0x263/0x3a0 mm/slub.c:3822
 device_release+0x95/0x1c0
 kobject_cleanup lib/kobject.c:682 [inline]
 kobject_release lib/kobject.c:716 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1ee/0x430 lib/kobject.c:733
 nfc_free_device include/net/nfc/nfc.h:213 [inline]
 nci_free_device+0x38/0x50 net/nfc/nci/core.c:1209
 virtual_ncidev_close+0x70/0x90 drivers/nfc/virtual_ncidev.c:164
 __fput+0x3cc/0xa10 fs/file_table.c:394
 __do_sys_close fs/open.c:1590 [inline]
 __se_sys_close+0x15f/0x220 fs/open.c:1575
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

The buggy address belongs to the object at ffff888075231000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 1352 bytes inside of
 freed 2048-byte region [ffff888075231000, ffff888075231800)

The buggy address belongs to the physical page:
page:ffffea0001d48c00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x75230
head:ffffea0001d48c00 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888012c42000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080080008 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5062, tgid 5061 (syz-executor193), ts 56272329966, free_ts 55738397890
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
 nci_allocate_device+0xe9/0x360 net/nfc/nci/core.c:1163
 virtual_ncidev_open+0x75/0x1b0 drivers/nfc/virtual_ncidev.c:136
 misc_open+0x30b/0x380 drivers/char/misc.c:165
 chrdev_open+0x5ab/0x630 fs/char_dev.c:414
 do_dentry_open+0x8fd/0x1590 fs/open.c:948
 do_open fs/namei.c:3622 [inline]
 path_openat+0x2845/0x3280 fs/namei.c:3779
 do_filp_open+0x234/0x490 fs/namei.c:3809
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1137 [inline]
 free_unref_page_prepare+0x92a/0xa50 mm/page_alloc.c:2347
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2487
 __slab_free+0x2f6/0x390 mm/slub.c:3715
 qlink_free mm/kasan/quarantine.c:168 [inline]
 qlist_free_all+0x75/0xe0 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x14b/0x160 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x23/0x70 mm/kasan/common.c:305
 kasan_slab_alloc include/linux/kasan.h:188 [inline]
 slab_post_alloc_hook+0x6c/0x3c0 mm/slab.h:763
 slab_alloc_node mm/slub.c:3478 [inline]
 __kmem_cache_alloc_node+0x1d0/0x300 mm/slub.c:3517
 __do_kmalloc_node mm/slab_common.c:1006 [inline]
 __kmalloc+0xa8/0x230 mm/slab_common.c:1020
 kmalloc include/linux/slab.h:604 [inline]
 tomoyo_add_entry security/tomoyo/common.c:2023 [inline]
 tomoyo_supervisor+0xe06/0x11f0 security/tomoyo/common.c:2095
 tomoyo_audit_env_log security/tomoyo/environ.c:36 [inline]
 tomoyo_env_perm+0x178/0x210 security/tomoyo/environ.c:63
 tomoyo_environ security/tomoyo/domain.c:672 [inline]
 tomoyo_find_next_domain+0x1383/0x1cf0 security/tomoyo/domain.c:878
 tomoyo_bprm_check_security+0x114/0x170 security/tomoyo/tomoyo.c:101
 security_bprm_check+0x63/0xa0 security/security.c:1103
 search_binary_handler fs/exec.c:1725 [inline]
 exec_binprm fs/exec.c:1779 [inline]
 bprm_execve+0x95f/0x18a0 fs/exec.c:1854
 do_execveat_common+0x580/0x720 fs/exec.c:1962

Memory state around the buggy address:
 ffff888075231400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888075231480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888075231500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                              ^
 ffff888075231580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888075231600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
