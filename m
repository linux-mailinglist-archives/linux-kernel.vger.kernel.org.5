Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9179B812A19
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 09:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234352AbjLNIPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 03:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjLNIPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 03:15:18 -0500
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782D5CF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 00:15:23 -0800 (PST)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6ceb34b96fbso4813801b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 00:15:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702541723; x=1703146523;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q2ulKuoq72Pn9SlOBn9i6jG9e0gOWsCcYWgayS3GhB8=;
        b=NXjouV7pnNMfH8TEhtKwtQarcbREjb142upUAUVhKn74nsXIfgcy0p4Qd/GszByTwl
         +crOsVydL4AU1wW8trKWsBCNZavIdVYMBg34748e0ieRjb06D1wgMFhZY6zjI/Ix5JdA
         YsTufc4BVc+KSsPEG5UB1Q+bLPDrzaehQDSgvgfCxFPM7LeztxF6Qx4AY9Mr3FxNUs0k
         GeHcD4rU/wIZt6JkRS/wOUzZuyb0ADEm/vvNC/LzPnuwsN9odkLWS6Uw2d4yJT7joPAY
         wI+gaWfG420BFjoJDPIC3W23vEmT5DjwjseO7XmQWAp/fDF71MhLwTJuR9JY9L/S4R8l
         IUuQ==
X-Gm-Message-State: AOJu0YzVM9xWxvDp9zyRH6+CpRbk2ZkXhTX/47U2YrT5M2Yjp3gs1n4w
        0w0awWklgAWi5grb2G07Jqxr8Ie6sXSfzBegLj2pUiT7ttl1
X-Google-Smtp-Source: AGHT+IHBg4dPtwn9W8uzlpptHAWD1jYrfuInfghlYHkLpixrN5bFQzkTbGLocMIaQXdmh//ZxuxC7PIugRHa6+pddmRsu+qKuOgI
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:1412:b0:6cd:f50c:32ac with SMTP id
 l18-20020a056a00141200b006cdf50c32acmr1180836pfu.6.1702541722858; Thu, 14 Dec
 2023 00:15:22 -0800 (PST)
Date:   Thu, 14 Dec 2023 00:15:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009b39bc060c73e209@google.com>
Subject: [syzbot] [net?] KASAN: slab-out-of-bounds Read in dns_resolver_preparse
From:   syzbot <syzbot+94bbb75204a05da3d89f@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dhowells@redhat.com, edumazet@google.com,
        jarkko@kernel.org, jmorris@namei.org, keyrings@vger.kernel.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, paul@paul-moore.com, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SORTED_RECIPS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    48e8992e33ab Add linux-next specific files for 20231213
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=155c1ac1e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=978b8aaa2e92a8f
dashboard link: https://syzkaller.appspot.com/bug?extid=94bbb75204a05da3d89f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10e0a966e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1555a15ce80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ade5327f8151/disk-48e8992e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/16bff810e759/vmlinux-48e8992e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/14c4448589de/bzImage-48e8992e.xz

The issue was bisected to:

commit b946001d3bb1202e90093cf5e72dbcb20e2689a0
Author: David Howells <dhowells@redhat.com>
Date:   Sat Dec 9 00:41:55 2023 +0000

    keys, dns: Allow key types (eg. DNS) to be reclaimed immediately on expiry

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10c349c1e80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12c349c1e80000
console output: https://syzkaller.appspot.com/x/log.txt?x=14c349c1e80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+94bbb75204a05da3d89f@syzkaller.appspotmail.com
Fixes: b946001d3bb1 ("keys, dns: Allow key types (eg. DNS) to be reclaimed immediately on expiry")

==================================================================
BUG: KASAN: slab-out-of-bounds in dns_resolver_preparse+0xc9f/0xd60 net/dns_resolver/dns_key.c:127
Read of size 1 at addr ffff888028894084 by task syz-executor265/5069

CPU: 0 PID: 5069 Comm: syz-executor265 Not tainted 6.7.0-rc5-next-20231213-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 dns_resolver_preparse+0xc9f/0xd60 net/dns_resolver/dns_key.c:127
 __key_create_or_update+0x453/0xdf0 security/keys/key.c:842
 key_create_or_update+0x42/0x50 security/keys/key.c:1007
 __do_sys_add_key+0x29c/0x450 security/keys/keyctl.c:134
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x62/0x6a
RIP: 0033:0x7fd37f34f2e9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff2f4f3198 EFLAGS: 00000246 ORIG_RAX: 00000000000000f8
RAX: ffffffffffffffda RBX: 00007fff2f4f3368 RCX: 00007fd37f34f2e9
RDX: 0000000020000080 RSI: 0000000000000000 RDI: 00000000200003c0
RBP: 00007fd37f3c2610 R08: 0000000002853c32 R09: 00007fff2f4f3368
R10: 0000000000000004 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fff2f4f3358 R14: 0000000000000001 R15: 0000000000000001
 </TASK>

Allocated by task 5069:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:47
 kasan_set_track+0x24/0x30 mm/kasan/common.c:61
 ____kasan_kmalloc mm/kasan/common.c:375 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:384
 kasan_kmalloc include/linux/kasan.h:198 [inline]
 __do_kmalloc_node mm/slub.c:3985 [inline]
 __kmalloc_node+0x226/0x480 mm/slub.c:3992
 kmalloc_node include/linux/slab.h:610 [inline]
 kvmalloc_node+0x99/0x1a0 mm/util.c:617
 kvmalloc include/linux/slab.h:728 [inline]
 __do_sys_add_key+0x1f8/0x450 security/keys/keyctl.c:116
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x62/0x6a

The buggy address belongs to the object at ffff888028894080
 which belongs to the cache kmalloc-8 of size 8
The buggy address is located 0 bytes to the right of
 allocated 4-byte region [ffff888028894080, ffff888028894084)

The buggy address belongs to the physical page:
page:ffffea0000a22500 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x28894
anon flags: 0xfff00000000800(slab|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000800 ffff888013041280 0000000000000000 dead000000000001
raw: 0000000000000000 0000000080800080 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 1, tgid 1 (swapper/0), ts 27978623390, free_ts 27978121808
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2d0/0x350 mm/page_alloc.c:1540
 prep_new_page mm/page_alloc.c:1547 [inline]
 get_page_from_freelist+0xa19/0x3740 mm/page_alloc.c:3355
 __alloc_pages+0x22e/0x2410 mm/page_alloc.c:4611
 alloc_pages_mpol+0x258/0x5f0 mm/mempolicy.c:2133
 alloc_slab_page mm/slub.c:2191 [inline]
 allocate_slab mm/slub.c:2358 [inline]
 new_slab+0x283/0x3c0 mm/slub.c:2411
 ___slab_alloc+0x4ab/0x1990 mm/slub.c:3544
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3629
 __slab_alloc_node mm/slub.c:3682 [inline]
 slab_alloc_node mm/slub.c:3854 [inline]
 __do_kmalloc_node mm/slub.c:3984 [inline]
 __kmalloc_node_track_caller+0x367/0x470 mm/slub.c:4005
 kstrdup+0x3c/0x70 mm/util.c:62
 kstrdup_const+0x5f/0x70 mm/util.c:85
 kvasprintf_const+0x10b/0x190 lib/kasprintf.c:48
 kobject_set_name_vargs+0x5a/0x130 lib/kobject.c:272
 kobject_add_varg lib/kobject.c:366 [inline]
 kobject_init_and_add+0xe8/0x190 lib/kobject.c:455
 locate_module_kobject+0xef/0x190 kernel/params.c:781
 kernel_add_sysfs_param kernel/params.c:808 [inline]
 param_sysfs_builtin kernel/params.c:856 [inline]
 param_sysfs_builtin_init+0x25f/0x450 kernel/params.c:990
 do_one_initcall+0x128/0x680 init/main.c:1236
page last free pid 3062 tgid 3062 stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1140 [inline]
 free_unref_page_prepare+0x51f/0xb10 mm/page_alloc.c:2390
 free_unref_page+0x33/0x3b0 mm/page_alloc.c:2530
 mm_free_pgd kernel/fork.c:799 [inline]
 __mmdrop+0xd5/0x470 kernel/fork.c:915
 mmdrop include/linux/sched/mm.h:54 [inline]
 __mmput+0x40a/0x4d0 kernel/fork.c:1352
 mmput+0x62/0x70 kernel/fork.c:1363
 free_bprm+0x143/0x3e0 fs/exec.c:1490
 kernel_execve+0x3e6/0x4e0 fs/exec.c:2036
 call_usermodehelper_exec_async+0x252/0x4c0 kernel/umh.c:110
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

Memory state around the buggy address:
 ffff888028893f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888028894000: 07 fc fc fc 07 fc fc fc fa fc fc fc 05 fc fc fc
>ffff888028894080: 04 fc fc fc fb fc fc fc fb fc fc fc 06 fc fc fc
                   ^
 ffff888028894100: 06 fc fc fc fb fc fc fc 00 fc fc fc 00 fc fc fc
 ffff888028894180: fb fc fc fc 04 fc fc fc 04 fc fc fc fb fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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
