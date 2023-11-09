Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF6D7E721C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 20:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344592AbjKITTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 14:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjKITTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 14:19:06 -0500
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E269E3C11
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 11:19:03 -0800 (PST)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5b62a669d61so1076216a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 11:19:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699557543; x=1700162343;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LAtLnb72EkhhuFO4ZV5fL7VkmsX9UfW8s8n3qZp2iBU=;
        b=rGiGOJUUc+2XswXdjVPvbfgOvJTWBmMihAfH7en9zEJkdQyww/eqCXlBfZ38uK6W94
         X2OXtW5VuC3Sw6dXwTrM80Pc+1cgtNC/QFn4TXYLg0bzGo/Qc0/eilUDsry0P9jAvw9x
         HvB59Eo+Ropt+PY+FOQKn6X1OTGe0y7CQT/k3a0Me5D6ppUWrcIphyZpvZQfQ5yAJWft
         V3i1xtYOFondBVbYdeKkr8Yuxka8sq9qFM3UzD4OFjCHoi5Ob425cjmtYx8Q5ZxQjVpa
         Jcy8wuw8H9b5zHwixhqm5kWCxd812N4CAVtc6I9jXHd92MIvSfqGYLJSGvZpJ7HYHsTa
         +PVw==
X-Gm-Message-State: AOJu0YyXs5fjfLdsoRF/WAbUXfhhOgD9XvcDtpf2UXzz5vOVaffvTRjT
        VZ4CZDPwojU46E8U4QdBI+o4RKjNeYiAEbtOEy/tnF8dNyIY
X-Google-Smtp-Source: AGHT+IHKb+19U+ZmmFPlZshuQVUWzVrT9RNn1wL6q7iFrWwTv0TIxac2wXeuYlTQRJHLMx9SToRgEDfecxHG6yMAzT8E//H83HWV
MIME-Version: 1.0
X-Received: by 2002:a65:5a44:0:b0:5bd:bc9c:7bc4 with SMTP id
 z4-20020a655a44000000b005bdbc9c7bc4mr683178pgs.12.1699557543466; Thu, 09 Nov
 2023 11:19:03 -0800 (PST)
Date:   Thu, 09 Nov 2023 11:19:03 -0800
In-Reply-To: <20231109190331.107211-1-kdipendra88@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a75acb0609bd13f0@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KASAN: slab-use-after-free Read in nfc_alloc_send_skb
From:   syzbot <syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com>
To:     kdipendra88@gmail.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in nfc_alloc_send_skb

==================================================================
BUG: KASAN: slab-use-after-free in nfc_alloc_send_skb+0x189/0x1c0 net/nfc/core.c:726
Read of size 4 at addr ffff88806a407548 by task syz-executor.0/5449

CPU: 1 PID: 5449 Comm: syz-executor.0 Not tainted 6.6.0-rc7-syzkaller-00089-g8de1e7afcc1c-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:475
 kasan_report+0x175/0x1b0 mm/kasan/report.c:588
 nfc_alloc_send_skb+0x189/0x1c0 net/nfc/core.c:726
 nfc_llcp_send_ui_frame+0x2ac/0x670 net/nfc/llcp_commands.c:766
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0x592/0x890 net/socket.c:2558
 ___sys_sendmsg net/socket.c:2612 [inline]
 __sys_sendmmsg+0x3b2/0x730 net/socket.c:2698
 __do_sys_sendmmsg net/socket.c:2727 [inline]
 __se_sys_sendmmsg net/socket.c:2724 [inline]
 __x64_sys_sendmmsg+0xa0/0xb0 net/socket.c:2724
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7efdd1e7cae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007efdd2b050c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 00007efdd1f9bf80 RCX: 00007efdd1e7cae9
RDX: 0000000000000001 RSI: 00000000200013c0 RDI: 0000000000000004
RBP: 00007efdd1ec847a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007efdd1f9bf80 R15: 00007ffcb9f3b548
 </TASK>

Allocated by task 5449:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:383
 kmalloc include/linux/slab.h:599 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 nfc_allocate_device+0x12f/0x520 net/nfc/core.c:1065
 nci_allocate_device+0x1e2/0x360 net/nfc/nci/core.c:1179
 virtual_ncidev_open+0x75/0x1b0 drivers/nfc/virtual_ncidev.c:136
 misc_open+0x30b/0x380 drivers/char/misc.c:165
 chrdev_open+0x551/0x630 fs/char_dev.c:414
 do_dentry_open+0x80f/0x1430 fs/open.c:929
 do_open fs/namei.c:3640 [inline]
 path_openat+0x27bb/0x3180 fs/namei.c:3797
 do_filp_open+0x234/0x490 fs/namei.c:3824
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1422
 do_sys_open fs/open.c:1437 [inline]
 __do_sys_openat fs/open.c:1453 [inline]
 __se_sys_openat fs/open.c:1448 [inline]
 __x64_sys_openat+0x247/0x290 fs/open.c:1448
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 5448:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 kasan_save_free_info+0x28/0x40 mm/kasan/generic.c:522
 ____kasan_slab_free+0xd6/0x120 mm/kasan/common.c:236
 kasan_slab_free include/linux/kasan.h:164 [inline]
 slab_free_hook mm/slub.c:1800 [inline]
 slab_free_freelist_hook mm/slub.c:1826 [inline]
 slab_free mm/slub.c:3809 [inline]
 __kmem_cache_free+0x25f/0x3b0 mm/slub.c:3822
 device_release+0x95/0x1c0
 kobject_cleanup lib/kobject.c:682 [inline]
 kobject_release lib/kobject.c:716 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1ee/0x430 lib/kobject.c:733
 nfc_free_device include/net/nfc/nfc.h:213 [inline]
 nci_free_device+0x38/0x50 net/nfc/nci/core.c:1209
 virtual_ncidev_close+0x70/0x90 drivers/nfc/virtual_ncidev.c:164
 __fput+0x3f8/0x910 fs/file_table.c:384
 __do_sys_close fs/open.c:1572 [inline]
 __se_sys_close+0x15f/0x220 fs/open.c:1557
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff88806a407000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 1352 bytes inside of
 freed 2048-byte region [ffff88806a407000, ffff88806a407800)

The buggy address belongs to the physical page:
page:ffffea0001a90000 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x6a400
head:ffffea0001a90000 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888012842000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000080008 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 5382, tgid 5382 (syz-executor.0), ts 87391067310, free_ts 58677729993
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1e6/0x210 mm/page_alloc.c:1536
 prep_new_page mm/page_alloc.c:1543 [inline]
 get_page_from_freelist+0x31db/0x3360 mm/page_alloc.c:3170
 __alloc_pages+0x255/0x670 mm/page_alloc.c:4426
 alloc_slab_page+0x6a/0x160 mm/slub.c:1870
 allocate_slab mm/slub.c:2017 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2070
 ___slab_alloc+0xc85/0x1310 mm/slub.c:3223
 __slab_alloc mm/slub.c:3322 [inline]
 __slab_alloc_node mm/slub.c:3375 [inline]
 slab_alloc_node mm/slub.c:3468 [inline]
 __kmem_cache_alloc_node+0x1af/0x270 mm/slub.c:3517
 __do_kmalloc_node mm/slab_common.c:1025 [inline]
 __kmalloc+0xa8/0x230 mm/slab_common.c:1039
 kmalloc include/linux/slab.h:603 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 ipt_alloc_initial_table+0x6c/0x570 net/ipv4/netfilter/ip_tables.c:36
 iptable_mangle_table_init+0x1c/0x60 net/ipv4/netfilter/iptable_mangle.c:88
 xt_find_table_lock+0x2d0/0x3b0 net/netfilter/x_tables.c:1259
 xt_request_find_table_lock+0x26/0x100 net/netfilter/x_tables.c:1284
 get_info net/ipv4/netfilter/ip_tables.c:963 [inline]
 do_ipt_get_ctl+0x885/0x18c0 net/ipv4/netfilter/ip_tables.c:1651
 nf_getsockopt+0x292/0x2c0 net/netfilter/nf_sockopt.c:116
 ip_getsockopt+0x21e/0x2e0 net/ipv4/ip_sockglue.c:1788
 tcp_getsockopt+0x160/0x1c0 net/ipv4/tcp.c:4278
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1136 [inline]
 free_unref_page_prepare+0x8c3/0x9f0 mm/page_alloc.c:2312
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2405
 vfree+0x186/0x2e0 mm/vmalloc.c:2842
 kcov_put kernel/kcov.c:429 [inline]
 kcov_close+0x2b/0x50 kernel/kcov.c:525
 __fput+0x3f8/0x910 fs/file_table.c:384
 task_work_run+0x24a/0x300 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa2c/0x2650 kernel/exit.c:874
 do_group_exit+0x206/0x2c0 kernel/exit.c:1024
 get_signal+0x175d/0x1840 kernel/signal.c:2892
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:309
 exit_to_user_mode_loop+0x6a/0x100 kernel/entry/common.c:168
 exit_to_user_mode_prepare+0xb1/0x140 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x64/0x280 kernel/entry/common.c:296
 do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88806a407400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88806a407480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88806a407500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                              ^
 ffff88806a407580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88806a407600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         8de1e7af Merge branch 'for-next/core' into for-kernelci
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1617ab37680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f0d47f0e0359e88e
dashboard link: https://syzkaller.appspot.com/bug?extid=bbe84a4010eeea00982d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11005d0f680000

