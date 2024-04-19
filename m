Return-Path: <linux-kernel+bounces-151238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3CA8AAB95
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8393A1C2113D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921E07E0E9;
	Fri, 19 Apr 2024 09:39:24 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EA779B87
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 09:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713519563; cv=none; b=QH//YhVtqqPpyvAOVpthuMoIZIMDGJOITSXD4tHgwmyCs7qtMT0STjQaypiPrlt1G36q9m06rt8hSlfl2E+yIZQVeGC1PY+euWKoCiBWvdd8D2125gWWjhtHGagdnX6tPYBN1eCGRq4ESC6Pmhffj6KpioICnJFrJZyrgz025bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713519563; c=relaxed/simple;
	bh=14Y4KZZiAhcjzJBMPil9WLZmrBhb5dyYBHzD9Q9GixU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MTfgtwq3n79/ZUuBUXPJ1fGOyYGPaNWp7fD+UsjUaJfmLGZ2YhtVq6gf/xWfu/gHLqrGdbhxmEOUmt1zX/yWqdG3zl7M2jLzxaxGHZt7oRGkBoLdDEKuPyx9sTF8Np3bY7z/Uv0VSiQXRmsSlEAxGHpaZSxtFUBrgD0smPHGOQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7d9d0936d6aso253808139f.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 02:39:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713519561; x=1714124361;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n/4BKGxSNKE1tgUH4BDYpPfAMy1V7jfjPS2wZ8yJuYM=;
        b=cxu97AluetyUPMS+dqRPb8nxagp8524n1Cov35QOOwEiZG9P89hFVbvl4nv47Z38zL
         hAPbgmTsU/bt29IQpZJG8wb31nLqH1YwtDaQMUyD5TVR/gjMeBzgmvwbwQP737d1Dn8a
         E8sDoB5MDaTLL+xu/3y7wdgoBG2djAdj2dhAZiMOqESMX1Mj5gIiLuR5Qq5FaAFACcvD
         xDDBSDGPyJ4w+ooulwHHdiTYtpMD1M1FzsKIIJJhER9BqQFThJGaeLmusxOUAZjA29i/
         Kghp4MKKZ1E+iK+Ao7zbdOWrmP0YOiBWQjwsKnd9Fm9v8/JFNcEIhGMD7rT/rqhgLUMG
         YqFA==
X-Forwarded-Encrypted: i=1; AJvYcCUaM7lS8lX7l50HCF8/EW2A6wQJj1pK+BJilie3EB//+5o3AV0usqoZOic7HnsUYkdGcHp1X0t3evPj2cX0XCK2qJ9oy9o10JlJVumh
X-Gm-Message-State: AOJu0Yyq8INDNtvIF+KqFWbD62a1ypDwxQOKJkZp5WJMG1MsxbiMPN64
	3LZEsIrlSUJ2OpARNmrDz9wZINFUk/pFn6C93MVGHPggKU7ynZe6SW4/0bNlQEtLor+Vv92RXk0
	WaY1p5WozIvr8t852rN2H4R56R+QW8+wdI2elNLZabuMzMb+FIKph5TE=
X-Google-Smtp-Source: AGHT+IHb74c1pr8r0ZUEXq2T0+3WN7/E1SX6B1RfHduI/JElDKADeaCEmdGXUnn5CY772WvjQIzJgDnr9M33U1CrAj9AeUyGDOt8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2394:b0:482:eef9:835c with SMTP id
 q20-20020a056638239400b00482eef9835cmr101759jat.6.1713519561140; Fri, 19 Apr
 2024 02:39:21 -0700 (PDT)
Date: Fri, 19 Apr 2024 02:39:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c1fa0506166fdcfe@google.com>
Subject: [syzbot] [net?] KASAN: slab-use-after-free Read in unix_del_edges
From: syzbot <syzbot+f3f3eef1d2100200e593@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7b4f2bc91c15 Add linux-next specific files for 20240418
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14a54a53180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ae644165a243bf62
dashboard link: https://syzkaller.appspot.com/bug?extid=f3f3eef1d2100200e593
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=155e53af180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=128b1d53180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/524a18e6c5be/disk-7b4f2bc9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/029f1b84d653/vmlinux-7b4f2bc9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c02d1542e886/bzImage-7b4f2bc9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f3f3eef1d2100200e593@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in unix_edge_successor net/unix/garbage.c:109 [inline]
BUG: KASAN: slab-use-after-free in unix_del_edge net/unix/garbage.c:165 [inline]
BUG: KASAN: slab-use-after-free in unix_del_edges+0x148/0x630 net/unix/garbage.c:237
Read of size 8 at addr ffff888079c6e640 by task kworker/u8:6/1099

CPU: 0 PID: 1099 Comm: kworker/u8:6 Not tainted 6.9.0-rc4-next-20240418-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue: events_unbound __unix_gc
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 unix_edge_successor net/unix/garbage.c:109 [inline]
 unix_del_edge net/unix/garbage.c:165 [inline]
 unix_del_edges+0x148/0x630 net/unix/garbage.c:237
 unix_destroy_fpl+0x59/0x210 net/unix/garbage.c:298
 unix_detach_fds net/unix/af_unix.c:1811 [inline]
 unix_destruct_scm+0x13e/0x210 net/unix/af_unix.c:1826
 skb_release_head_state+0x100/0x250 net/core/skbuff.c:1127
 skb_release_all net/core/skbuff.c:1138 [inline]
 __kfree_skb net/core/skbuff.c:1154 [inline]
 kfree_skb_reason+0x16d/0x3b0 net/core/skbuff.c:1190
 __skb_queue_purge_reason include/linux/skbuff.h:3251 [inline]
 __skb_queue_purge include/linux/skbuff.h:3256 [inline]
 __unix_gc+0x1732/0x1830 net/unix/garbage.c:575
 process_one_work kernel/workqueue.c:3218 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3299
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3380
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 14427:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3897 [inline]
 slab_alloc_node mm/slub.c:3957 [inline]
 kmem_cache_alloc_noprof+0x135/0x290 mm/slub.c:3964
 sk_prot_alloc+0x58/0x210 net/core/sock.c:2074
 sk_alloc+0x38/0x370 net/core/sock.c:2133
 unix_create1+0xb4/0x770
 unix_create+0x14e/0x200 net/unix/af_unix.c:1034
 __sock_create+0x490/0x920 net/socket.c:1571
 sock_create net/socket.c:1622 [inline]
 __sys_socketpair+0x33e/0x720 net/socket.c:1773
 __do_sys_socketpair net/socket.c:1822 [inline]
 __se_sys_socketpair net/socket.c:1819 [inline]
 __x64_sys_socketpair+0x9b/0xb0 net/socket.c:1819
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 1805:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2190 [inline]
 slab_free mm/slub.c:4393 [inline]
 kmem_cache_free+0x145/0x340 mm/slub.c:4468
 sk_prot_free net/core/sock.c:2114 [inline]
 __sk_destruct+0x467/0x5f0 net/core/sock.c:2208
 sock_put include/net/sock.h:1948 [inline]
 unix_release_sock+0xa8b/0xd20 net/unix/af_unix.c:665
 unix_release+0x91/0xc0 net/unix/af_unix.c:1049
 __sock_release net/socket.c:659 [inline]
 sock_close+0xbc/0x240 net/socket.c:1421
 __fput+0x406/0x8b0 fs/file_table.c:422
 delayed_fput+0x59/0x80 fs/file_table.c:445
 process_one_work kernel/workqueue.c:3218 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3299
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3380
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff888079c6e000
 which belongs to the cache UNIX of size 1920
The buggy address is located 1600 bytes inside of
 freed 1920-byte region [ffff888079c6e000, ffff888079c6e780)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888079c6c000 pfn:0x79c68
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff80000000240(workingset|head|node=0|zone=1|lastcpupid=0xfff)
page_type: 0xffffefff(slab)
raw: 00fff80000000240 ffff888017395a00 ffff8880173357c8 ffffea0001f97410
raw: ffff888079c6c000 0000000000100005 00000001ffffefff 0000000000000000
head: 00fff80000000240 ffff888017395a00 ffff8880173357c8 ffffea0001f97410
head: ffff888079c6c000 0000000000100005 00000001ffffefff 0000000000000000
head: 00fff80000000003 ffffea0001e71a01 ffffffffffffffff 0000000000000000
head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 7008, tgid -583571348 (syz-executor297), ts 7008, free_ts 67977031729
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1476
 prep_new_page mm/page_alloc.c:1484 [inline]
 get_page_from_freelist+0x2ce2/0x2d90 mm/page_alloc.c:3446
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4704
 __alloc_pages_node_noprof include/linux/gfp.h:244 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:271 [inline]
 alloc_slab_page+0x5f/0x120 mm/slub.c:2259
 allocate_slab+0x5a/0x2e0 mm/slub.c:2422
 new_slab mm/slub.c:2475 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3624
 __slab_alloc+0x58/0xa0 mm/slub.c:3714
 __slab_alloc_node mm/slub.c:3767 [inline]
 slab_alloc_node mm/slub.c:3945 [inline]
 kmem_cache_alloc_noprof+0x1c1/0x290 mm/slub.c:3964
 sk_prot_alloc+0x58/0x210 net/core/sock.c:2074
 sk_alloc+0x38/0x370 net/core/sock.c:2133
 unix_create1+0xb4/0x770
 unix_create+0x14e/0x200 net/unix/af_unix.c:1034
 __sock_create+0x490/0x920 net/socket.c:1571
 sock_create net/socket.c:1622 [inline]
 __sys_socketpair+0x33e/0x720 net/socket.c:1773
 __do_sys_socketpair net/socket.c:1822 [inline]
 __se_sys_socketpair net/socket.c:1819 [inline]
 __x64_sys_socketpair+0x9b/0xb0 net/socket.c:1819
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
page last free pid 5089 tgid 5089 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1096 [inline]
 free_unref_page+0xd22/0xea0 mm/page_alloc.c:2609
 __slab_free+0x31b/0x3d0 mm/slub.c:4304
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9e/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3897 [inline]
 slab_alloc_node mm/slub.c:3957 [inline]
 kmem_cache_alloc_noprof+0x135/0x290 mm/slub.c:3964
 vma_lock_alloc kernel/fork.c:441 [inline]
 vm_area_dup+0x61/0x290 kernel/fork.c:494
 dup_mmap kernel/fork.c:697 [inline]
 dup_mm kernel/fork.c:1688 [inline]
 copy_mm+0xcf5/0x1fb0 kernel/fork.c:1737
 copy_process+0x187a/0x3dc0 kernel/fork.c:2390
 kernel_clone+0x226/0x8f0 kernel/fork.c:2797
 __do_sys_clone kernel/fork.c:2940 [inline]
 __se_sys_clone kernel/fork.c:2924 [inline]
 __x64_sys_clone+0x258/0x2a0 kernel/fork.c:2924
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888079c6e500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888079c6e580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888079c6e600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                           ^
 ffff888079c6e680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888079c6e700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

