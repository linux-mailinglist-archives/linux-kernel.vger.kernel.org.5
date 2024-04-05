Return-Path: <linux-kernel+bounces-132503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2098995FA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32FB21C21983
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F5D2C693;
	Fri,  5 Apr 2024 06:55:28 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A692026ACA
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 06:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712300127; cv=none; b=LrfPEspDVl6FelzSFoBSP90bek4qCkcKCTlUVutmbl8QDwzt/NqWc/8cmNuWX0Keiwy1UeJoXzrTnEmtzes888LY8oB4VkSR/bHJFnSRgQ88jVi7pPWhO6XmFshNnNb+dm1QZqDVa0OfD6Hdl0pCCmTGVS2P8Rzu5BdY6PJXJEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712300127; c=relaxed/simple;
	bh=dL5L+n5ag8PJQ9Jv/y2xtaF3xC2tMdoKXIR4//yJItI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=n0npsY7aSFMSUYq0aqX7hvno/QD2Vfc9U6poY4Tt7xouXl+5c6m/mQb0bPnAsQOzZLXQuZmaUebmslvRFcKzQ5MxOYxbnQ2CK7TrP3CU3pCNEj35TXEazH22RewISl4koxLmV5dyjZUqL1zZ2lcNm1yFqRGNiBStC20gXa1gLsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36a0a33c1bbso7547775ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 23:55:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712300125; x=1712904925;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RDnh/D5T7n7ZqWztdoHzvl2vnLvDv2JXdXIOKNWNq5c=;
        b=FndHPJIfQ/hjHYddE8/XhZSce1MiJvsgPn3kI7tFXyFwocDnxysHN3YNWlb3+lYn7s
         ZqWs0hjEbBGhxHoH/yQ0MmyZgIfXuXicmJ/x3dfJJMxePnNtt9ALNX+KgbJoxn9gM/Gs
         q0zBv4nciYhwfHFVrllDRmhtgqwUBlcPKg1ftNYs0R9iAyCkcBq1+GZLTdo2LXTXzeKD
         j9+tJz4o+AJbkRIYHHG+vmS5L6PrccF1oLByz+Sy+ERXrG2MfjFpA0QE4oRsn1MKeTjF
         9eanoG4hsE4zZH4qAgXAWyjoDJSLdlmFctcJ+L3yYRrGplvyTHfY9Z3RcxQ1ROQdU2ad
         6oUg==
X-Forwarded-Encrypted: i=1; AJvYcCW3dwD3y901uqU+b6IhJXSkJdZ+7y/nch32Sf1ROCtHvu0uZpI6CSQ37+LJiVGsBzC+n5gynCzkp0Y8lMaB14phFJOrJFxMEnRcLH5X
X-Gm-Message-State: AOJu0Yyos/sc8V2HA4AAiDUbPq10ORZVgnLgzpAEgx5TLQS0jq1zCf1Q
	FY43AZURMRULsA/SjxJKIvcJut6BOXK3Afr/G6FhKcAmEAAWIZqweDoTO1AMoMIWjcXD5RDu/Bc
	kW22jXZNRnk2UYUcOlwskZ+UzhhqVJmdPr7ycuEBOrp5LoaDZOdIGmWs=
X-Google-Smtp-Source: AGHT+IFRKl+ETsdKgVqObuOeGAoO3IavnzO6NzjZNPOGie/sp1RFqtJRr4wgRgYC2/X8gTRL7NE5llHAFqia8StUWmajei09+Z2e
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13ab:b0:368:7775:2df2 with SMTP id
 h11-20020a056e0213ab00b0036877752df2mr41808ilo.5.1712300124820; Thu, 04 Apr
 2024 23:55:24 -0700 (PDT)
Date: Thu, 04 Apr 2024 23:55:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b0848f061553f0d5@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-out-of-bounds Read in sco_sock_setsockopt
From: syzbot <syzbot+b71011ec0a23f4d15625@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17e823e3180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d90a36f0cab495a
dashboard link: https://syzkaller.appspot.com/bug?extid=b71011ec0a23f4d15625
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12155aa9180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ace2a9180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f6c04726a2ae/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/09c26ce901ea/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/134acf7f5322/bzImage-fe46a7dd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b71011ec0a23f4d15625@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in copy_from_sockptr_offset include/linux/sockptr.h:49 [inline]
BUG: KASAN: slab-out-of-bounds in copy_from_sockptr include/linux/sockptr.h:55 [inline]
BUG: KASAN: slab-out-of-bounds in sco_sock_setsockopt+0xc0b/0xf90 net/bluetooth/sco.c:893
Read of size 4 at addr ffff8880296aeb83 by task syz-executor142/5061

CPU: 0 PID: 5061 Comm: syz-executor142 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 copy_from_sockptr_offset include/linux/sockptr.h:49 [inline]
 copy_from_sockptr include/linux/sockptr.h:55 [inline]
 sco_sock_setsockopt+0xc0b/0xf90 net/bluetooth/sco.c:893
 do_sock_setsockopt+0x3af/0x720 net/socket.c:2311
 __sys_setsockopt+0x1ae/0x250 net/socket.c:2334
 __do_sys_setsockopt net/socket.c:2343 [inline]
 __se_sys_setsockopt net/socket.c:2340 [inline]
 __x64_sys_setsockopt+0xb5/0xd0 net/socket.c:2340
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7fe1069a9d89
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 91 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdb5d99c28 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fe1069a9d89
RDX: 0000000000000010 RSI: 0000000000000112 RDI: 0000000000000007
RBP: 0000000000000006 R08: 0000000000000002 R09: 0000000000000000
R10: 0000000020000000 R11: 0000000000000246 R12: 0000555584ea7338
R13: 000000000000000e R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Allocated by task 5061:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:3966 [inline]
 __kmalloc+0x233/0x4a0 mm/slub.c:3979
 kmalloc include/linux/slab.h:632 [inline]
 __cgroup_bpf_run_filter_setsockopt+0xd2f/0x1040 kernel/bpf/cgroup.c:1869
 do_sock_setsockopt+0x6b4/0x720 net/socket.c:2293
 __sys_setsockopt+0x1ae/0x250 net/socket.c:2334
 __do_sys_setsockopt net/socket.c:2343 [inline]
 __se_sys_setsockopt net/socket.c:2340 [inline]
 __x64_sys_setsockopt+0xb5/0xd0 net/socket.c:2340
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

The buggy address belongs to the object at ffff8880296aeb80
 which belongs to the cache kmalloc-8 of size 8
The buggy address is located 1 bytes to the right of
 allocated 2-byte region [ffff8880296aeb80, ffff8880296aeb82)

The buggy address belongs to the physical page:
page:ffffea0000a5ab80 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x296ae
flags: 0xfff00000000800(slab|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000800 ffff888014c41280 dead000000000100 dead000000000122
raw: 0000000000000000 0000000080800080 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 1, tgid 1 (swapper/0), ts 18614896584, free_ts 17708736389
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1533
 prep_new_page mm/page_alloc.c:1540 [inline]
 get_page_from_freelist+0x33ea/0x3580 mm/page_alloc.c:3311
 __alloc_pages+0x256/0x680 mm/page_alloc.c:4569
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page+0x5f/0x160 mm/slub.c:2175
 allocate_slab mm/slub.c:2338 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2391
 ___slab_alloc+0xc73/0x1260 mm/slub.c:3525
 __slab_alloc mm/slub.c:3610 [inline]
 __slab_alloc_node mm/slub.c:3663 [inline]
 slab_alloc_node mm/slub.c:3835 [inline]
 kmalloc_trace+0x269/0x360 mm/slub.c:3992
 kmalloc include/linux/slab.h:628 [inline]
 kzalloc include/linux/slab.h:749 [inline]
 add_sysfs_param+0x541/0x7f0 kernel/params.c:646
 kernel_add_sysfs_param+0xb4/0x130 kernel/params.c:817
 param_sysfs_builtin+0x16e/0x1f0 kernel/params.c:856
 param_sysfs_builtin_init+0x31/0x40 kernel/params.c:990
 do_one_initcall+0x238/0x830 init/main.c:1241
 do_initcall_level+0x157/0x210 init/main.c:1303
 do_initcalls+0x3f/0x80 init/main.c:1319
 kernel_init_freeable+0x435/0x5d0 init/main.c:1550
 kernel_init+0x1d/0x2a0 init/main.c:1439
page last free pid 57 tgid 57 stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1140 [inline]
 free_unref_page_prepare+0x95d/0xa80 mm/page_alloc.c:2346
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2486
 vfree+0x186/0x2e0 mm/vmalloc.c:2914
 delayed_vfree_work+0x56/0x80 mm/vmalloc.c:2835
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243

Memory state around the buggy address:
 ffff8880296aea80: 00 fc fc fc 00 fc fc fc fa fc fc fc 07 fc fc fc
 ffff8880296aeb00: 07 fc fc fc fa fc fc fc 00 fc fc fc 00 fc fc fc
>ffff8880296aeb80: 02 fc fc fc 04 fc fc fc 04 fc fc fc fa fc fc fc
                   ^
 ffff8880296aec00: fa fc fc fc fa fc fc fc fa fc fc fc 00 fc fc fc
 ffff8880296aec80: 00 fc fc fc fa fc fc fc fa fc fc fc fa fc fc fc
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

