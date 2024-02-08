Return-Path: <linux-kernel+bounces-57746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0906484DCEF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DBE91C2197A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF586F087;
	Thu,  8 Feb 2024 09:27:35 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C186E2D9
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 09:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707384454; cv=none; b=HEveX1sHB/r+f1xlJuhrCgtlYJCFLAXQyIWceL2Blm22lxXUEbFrFZbI8lsBJnw47YNkhsPW8U/jIJZbpTbOF4Y8XsqTN7g4FBFbt3cl7im5gga4eAG4dQjMrmqdVUp8IQFSJ0ropGdSBiHlsW9ZywGy70arCD5AznH8VrJFaj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707384454; c=relaxed/simple;
	bh=pwexVJafXkeAOUnPAu4B/60LT1J523HNhEZa5sAFQe4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=EGM35nRZDiZMGQNL4f8Dm8lKIlmcB/EtDpCDw3Vgryj+urM2Cp4x3nSo+HNBsWW/MbFCuHXzVOirjLROzx2CSpuBuaJ0yHwkmCWMVZiJZ9FWGjp+DWzoUILU1629FDCnTDIHuz/oOna/cTz4o8WhI48TdobvALJJC7t1zpCremA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-363d86bef43so8389985ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 01:27:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707384451; x=1707989251;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7b150suGM+XIny5Nrp5YcF8s5+BlSE8/7PlYVOopfwQ=;
        b=FhU6ZkcnaWsFTpAECX6TQNHXBEjUEQZmESyBzRgxLV9MSgb2jE3haw3+BVfAi5Smzt
         4/5rHZAleBseAMf9e/r2IFBsc0f8BBEwle0yBNZRBA8skw8Bj1myLs+z2bPug/myOQM3
         miVVvMcahQD8Q0z+m69rjVoHkPGm2QRbQ4BHJVVwYB7c8g2CJjovJ1T+XvX1j/GHL6by
         8vUUy/CX3gvnGJSgNSuZ93zvVQeUR2fiGWYGv7Z7cNkYzVg4hDVNttNpq6/4QCBATTAk
         dHjv76HOsVQPuOHhKFGsDk9ZJjd+FMxNBdj19JWHaG/qdeFBHOrrVJdPkPgxT5jdmRN1
         uwUA==
X-Forwarded-Encrypted: i=1; AJvYcCWuDAefVTk8sQimFCatdYtZkhB0JUZswJBdgfwjLjsO6YKsmBXiahJV/cHlsVDyFTGoE5DimgWaiuKlkEo6IWrQ54OJpzvkOIGffVwS
X-Gm-Message-State: AOJu0YxtebPVJcVTBi4cNxhVAv8NGTwHsBr+FotrQyIiAd/wIsmop012
	pPnUPivK36CRgncER48ruoKZxnTyDhTqiIccwROM2mujUWwtEGl6XDNQzlcyFZw3yolZQNrIOEp
	lcpP37xKlLJWJ2JEhWG7RMilfNAjz7Z5lljsEDp/eU6lPA/6FSrRnzRo=
X-Google-Smtp-Source: AGHT+IEkooOFMAh8njO3fd36owBe1eTZK4mB+heMZk31KB1n6gxbhHEa6kNy2Ka4JRRZIgPTRkCaQlcfrjPWcBGo+WNtp4OBpStD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:152b:b0:363:cc38:db22 with SMTP id
 i11-20020a056e02152b00b00363cc38db22mr561569ilu.3.1707384451345; Thu, 08 Feb
 2024 01:27:31 -0800 (PST)
Date: Thu, 08 Feb 2024 01:27:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b7b62e0610db6b8a@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in __hci_acl_create_connection_sync
From: syzbot <syzbot+3f0a39be7a2035700868@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b1d3a0e70c38 Add linux-next specific files for 20240208
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15530be4180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bb693ba195662a06
dashboard link: https://syzkaller.appspot.com/bug?extid=3f0a39be7a2035700868
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11d95147e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=107c2d8fe80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/176a6b395bbe/disk-b1d3a0e7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/02d7d46f81bd/vmlinux-b1d3a0e7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/18a5a5030e19/bzImage-b1d3a0e7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3f0a39be7a2035700868@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __hci_acl_create_connection_sync+0x6ce/0x990 net/bluetooth/hci_sync.c:6518
Write of size 2 at addr ffff88806b80c036 by task kworker/u9:4/5087

CPU: 0 PID: 5087 Comm: kworker/u9:4 Not tainted 6.8.0-rc3-next-20240208-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Workqueue: hci4 hci_cmd_sync_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 __hci_acl_create_connection_sync+0x6ce/0x990 net/bluetooth/hci_sync.c:6518
 hci_cmd_sync_work+0x22b/0x400 net/bluetooth/hci_sync.c:306
 process_one_work kernel/workqueue.c:3102 [inline]
 process_scheduled_works+0x9d7/0x1730 kernel/workqueue.c:3182
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3263
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:242
 </TASK>

Allocated by task 6357:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 kmalloc_trace+0x1d9/0x360 mm/slub.c:4013
 kmalloc include/linux/slab.h:590 [inline]
 kzalloc include/linux/slab.h:711 [inline]
 hci_conn_add+0xc7/0x13a0 net/bluetooth/hci_conn.c:914
 hci_conn_add_unset net/bluetooth/hci_conn.c:1016 [inline]
 hci_connect_acl+0x15d/0x470 net/bluetooth/hci_conn.c:1632
 hci_connect_sco+0x3f/0x350 net/bluetooth/hci_conn.c:1692
 sco_connect net/bluetooth/sco.c:266 [inline]
 sco_sock_connect+0x2ce/0x950 net/bluetooth/sco.c:591
 __sys_connect_file net/socket.c:2048 [inline]
 __sys_connect+0x2df/0x310 net/socket.c:2065
 __do_sys_connect net/socket.c:2075 [inline]
 __se_sys_connect net/socket.c:2072 [inline]
 __x64_sys_connect+0x7a/0x90 net/socket.c:2072
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

Freed by task 5087:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:586
 poison_slab_object+0xa6/0xe0 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2122 [inline]
 slab_free mm/slub.c:4296 [inline]
 kfree+0x14a/0x380 mm/slub.c:4406
 device_release+0x99/0x1c0
 kobject_cleanup lib/kobject.c:682 [inline]
 kobject_release lib/kobject.c:716 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1f5/0x430 lib/kobject.c:733
 hci_conn_cleanup net/bluetooth/hci_conn.c:176 [inline]
 hci_conn_del+0x8f0/0xc70 net/bluetooth/hci_conn.c:1126
 hci_abort_conn_sync+0x583/0xde0 net/bluetooth/hci_sync.c:5361
 __hci_acl_create_connection_sync+0x60c/0x990 net/bluetooth/hci_sync.c:6554
 hci_cmd_sync_work+0x22b/0x400 net/bluetooth/hci_sync.c:306
 process_one_work kernel/workqueue.c:3102 [inline]
 process_scheduled_works+0x9d7/0x1730 kernel/workqueue.c:3182
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3263
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:242

The buggy address belongs to the object at ffff88806b80c000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 54 bytes inside of
 freed 4096-byte region [ffff88806b80c000, ffff88806b80d000)

The buggy address belongs to the physical page:
page:ffffea0001ae0200 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x6b808
head:ffffea0001ae0200 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff80000000840(slab|head|node=0|zone=1|lastcpupid=0xfff)
page_type: 0xffffffff()
raw: 00fff80000000840 ffff888014c42140 ffffea000073c600 dead000000000002
raw: 0000000000000000 0000000000040004 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 5397, tgid 5397 (syz-executor270), ts 117997642770, free_ts 25758092955
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1539
 prep_new_page mm/page_alloc.c:1546 [inline]
 get_page_from_freelist+0x34eb/0x3680 mm/page_alloc.c:3353
 __alloc_pages+0x256/0x6a0 mm/page_alloc.c:4609
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page+0x5f/0x160 mm/slub.c:2191
 allocate_slab mm/slub.c:2354 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2407
 ___slab_alloc+0xc73/0x1260 mm/slub.c:3541
 __slab_alloc mm/slub.c:3626 [inline]
 __slab_alloc_node mm/slub.c:3679 [inline]
 slab_alloc_node mm/slub.c:3851 [inline]
 __do_kmalloc_node mm/slub.c:3981 [inline]
 __kmalloc+0x2e3/0x4a0 mm/slub.c:3995
 kmalloc include/linux/slab.h:594 [inline]
 tomoyo_realpath_from_path+0xcf/0x5e0 security/tomoyo/realpath.c:251
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_perm+0x2b7/0x740 security/tomoyo/file.c:822
 tomoyo_path_symlink+0xde/0x120 security/tomoyo/tomoyo.c:212
 security_path_symlink+0xe3/0x140 security/security.c:1870
 do_symlinkat+0x136/0x3a0 fs/namei.c:4502
 __do_sys_symlink fs/namei.c:4525 [inline]
 __se_sys_symlink fs/namei.c:4523 [inline]
 __x64_sys_symlink+0x7e/0x90 fs/namei.c:4523
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
page last free pid 1 tgid 1 stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1140 [inline]
 free_unref_page_prepare+0x968/0xa90 mm/page_alloc.c:2388
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2528
 free_contig_range+0x9e/0x160 mm/page_alloc.c:6574
 destroy_args+0x8a/0x890 mm/debug_vm_pgtable.c:1028
 debug_vm_pgtable+0x4be/0x550 mm/debug_vm_pgtable.c:1408
 do_one_initcall+0x238/0x830 init/main.c:1233
 do_initcall_level+0x157/0x210 init/main.c:1295
 do_initcalls+0x3f/0x80 init/main.c:1311
 kernel_init_freeable+0x430/0x5d0 init/main.c:1542
 kernel_init+0x1d/0x2b0 init/main.c:1432
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:242

Memory state around the buggy address:
 ffff88806b80bf00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88806b80bf80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88806b80c000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                     ^
 ffff88806b80c080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88806b80c100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

