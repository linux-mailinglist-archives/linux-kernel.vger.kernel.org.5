Return-Path: <linux-kernel+bounces-90659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C4B8702D0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D5A0287F23
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A193E48F;
	Mon,  4 Mar 2024 13:33:07 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210273E483
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 13:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709559186; cv=none; b=bi1WrMcNz3ZPosqkwcnp/ZvTforyHhDjiesmObOl25NQfIFMBOJPuJN/aOB97KHpQqgWhBMdWfuAdqRScrCiQOPVCsMzX95i6r6A/j36wIG03NiGzxNtpraFR5bvq1xTRMW/vgpHQPlAUJbyvAHZWlN+g7kggvJ+vD3KlIrH0rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709559186; c=relaxed/simple;
	bh=hD52GYv7KONedkCcl5QZznOydXenBRyagK0ZJwI9HVc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ud59O3lvMJJ45uWxAKE3/RMcCJwOhQDtkcCff1q5wO/gETiBjDd2rvHABZdDQ9IAYZUJfxBEzBWjMhExPZluPYL9EpOF8XMzkaH1XxF9CDT6sXzKHBxTqM1h1onSLbeAEJNQxU3wo4dRWo8Q96+BnnCG37zZlfSbnQmos3Kli4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c84b3570cfso116749239f.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 05:33:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709559184; x=1710163984;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E0XeiHS7UfBSLU7uYpx8HLuGwKfTUu7QYJgc1DMUkIA=;
        b=AlbcbXCtjSk/XvJmhI+3g6UpawNOpoNN9zPWKFla7QXOMHtFwVRktsc7RrKtQ4NgwL
         j3VS0VSw/Wtm8XR7Z2nxr4PXgR0KEpnR5mW3f64t0QM4FX3pVwpZovawwMsx9yKuMUeI
         ES31PMNkXuViAkwgxduoYX9sBwnJM9ZZxRdU8ek4vv27rWuzkfUZLg8V+NJKAccDwTVF
         p73z/48U0hHoWdQs/7QVMmrI6zCf+983xVVJ14YSEEr9YuLWyDAltEPdd4vX2k3/6SdT
         Yfue/Ge7K/Kf6gndckhgo1NHrL2/qKowJO7VyxaG7SSm4F1eci0tiNfsDXIuT6drYPrH
         L4BQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwBqnxMegVx3JB9sbpPQiB4mUHxcGyFZiSfttkloU4cP6rZmy+QmWYSFhuN4GNHfgqszOOoLFykxaqIJAEtwkwUNIAJCOwyIeiSooV
X-Gm-Message-State: AOJu0YxJyaZxfRNSAFd4ZQdMngHWthPIW5x9VaXo/pe6EyfRLv+9Ka1z
	xz8OguicA7WZsMZmImojCkHLRZMu30nViO2gcVSvCVvEYYlH1M4MjmcJic/totjq9LbT5X5N0hI
	5+VtmJJcHwTKcHMl1hj1Ch3xE0wZUGiEEhCq1wTT6mHRuZvge5lx4dmA=
X-Google-Smtp-Source: AGHT+IGyzHjgI/PBdX4ZTg3da/1bZ5nTD00wpIjyKUADiPppDX2hKn+KECeNxqnA1nzLOPRuRp5IDmNxc3fq+xvtnQ6lBoyf/7b2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a68:b0:365:3e12:3eb1 with SMTP id
 w8-20020a056e021a6800b003653e123eb1mr684636ilv.1.1709559182899; Mon, 04 Mar
 2024 05:33:02 -0800 (PST)
Date: Mon, 04 Mar 2024 05:33:02 -0800
In-Reply-To: <20240304104457.1348-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d1c9260612d5c377@google.com>
Subject: Re: [syzbot] [fs?] KASAN: slab-use-after-free Read in sys_io_cancel
From: syzbot <syzbot+b91eb2ed18f599dd3c31@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in sys_io_cancel

==================================================================
BUG: KASAN: slab-use-after-free in __do_sys_io_cancel fs/aio.c:2212 [inline]
BUG: KASAN: slab-use-after-free in __se_sys_io_cancel+0x3a2/0x3b0 fs/aio.c:2174
Read of size 4 at addr ffff88801fe56020 by task syz-executor.0/5491

CPU: 0 PID: 5491 Comm: syz-executor.0 Not tainted 6.8.0-rc7-syzkaller-g90d35da658da-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x167/0x540 mm/kasan/report.c:488
 kasan_report+0x142/0x180 mm/kasan/report.c:601
 __do_sys_io_cancel fs/aio.c:2212 [inline]
 __se_sys_io_cancel+0x3a2/0x3b0 fs/aio.c:2174
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7f963407dda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9634ed70c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000d2
RAX: ffffffffffffffda RBX: 00007f96341abf80 RCX: 00007f963407dda9
RDX: 0000000000000000 RSI: 0000000020000180 RDI: 00007f9634eb6000
RBP: 00007f96340ca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f96341abf80 R15: 00007ffc37361bc8
 </TASK>

Allocated by task 5491:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3813 [inline]
 slab_alloc_node mm/slub.c:3860 [inline]
 kmem_cache_alloc+0x16f/0x340 mm/slub.c:3867
 aio_get_req fs/aio.c:1060 [inline]
 io_submit_one+0x154/0x18b0 fs/aio.c:2050
 __do_sys_io_submit fs/aio.c:2113 [inline]
 __se_sys_io_submit+0x17f/0x300 fs/aio.c:2083
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77

Freed by task 5082:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:589
 poison_slab_object+0xa6/0xe0 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2121 [inline]
 slab_free mm/slub.c:4299 [inline]
 kmem_cache_free+0x102/0x2a0 mm/slub.c:4363
 aio_poll_complete_work+0x467/0x670 fs/aio.c:1767
 process_one_work kernel/workqueue.c:2633 [inline]
 process_scheduled_works+0x913/0x1420 kernel/workqueue.c:2706
 worker_thread+0xa5f/0x1000 kernel/workqueue.c:2787
 kthread+0x2ef/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:243

Last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:551
 insert_work+0x3e/0x330 kernel/workqueue.c:1653
 __queue_work+0xbf4/0x1000 kernel/workqueue.c:1802
 queue_work_on+0x14f/0x250 kernel/workqueue.c:1837
 queue_work include/linux/workqueue.h:548 [inline]
 schedule_work include/linux/workqueue.h:609 [inline]
 aio_poll_cancel+0xbb/0x130 fs/aio.c:1779
 __do_sys_io_cancel fs/aio.c:2196 [inline]
 __se_sys_io_cancel+0x122/0x3b0 fs/aio.c:2174
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77

The buggy address belongs to the object at ffff88801fe56000
 which belongs to the cache aio_kiocb of size 216
The buggy address is located 32 bytes inside of
 freed 216-byte region [ffff88801fe56000, ffff88801fe560d8)

The buggy address belongs to the physical page:
page:ffffea00007f9580 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1fe56
flags: 0xfff00000000800(slab|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000800 ffff88801772adc0 dead000000000122 0000000000000000
raw: 0000000000000000 00000000800c000c 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY), pid 5491, tgid 5490 (syz-executor.0), ts 90500359314, free_ts 90328660331
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1533
 prep_new_page mm/page_alloc.c:1540 [inline]
 get_page_from_freelist+0x33ea/0x3580 mm/page_alloc.c:3311
 __alloc_pages+0x255/0x680 mm/page_alloc.c:4567
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page+0x5f/0x160 mm/slub.c:2190
 allocate_slab mm/slub.c:2354 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2407
 ___slab_alloc+0xd17/0x13e0 mm/slub.c:3540
 __slab_alloc mm/slub.c:3625 [inline]
 __slab_alloc_node mm/slub.c:3678 [inline]
 slab_alloc_node mm/slub.c:3850 [inline]
 kmem_cache_alloc+0x24d/0x340 mm/slub.c:3867
 aio_get_req fs/aio.c:1060 [inline]
 io_submit_one+0x154/0x18b0 fs/aio.c:2050
 __do_sys_io_submit fs/aio.c:2113 [inline]
 __se_sys_io_submit+0x17f/0x300 fs/aio.c:2083
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
page last free pid 5470 tgid 5470 stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1140 [inline]
 free_unref_page_prepare+0x968/0xa90 mm/page_alloc.c:2346
 free_unref_page_list+0x5a3/0x850 mm/page_alloc.c:2532
 release_pages+0x2744/0x2a80 mm/swap.c:1042
 tlb_batch_pages_flush mm/mmu_gather.c:98 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:293 [inline]
 tlb_flush_mmu+0x34c/0x4e0 mm/mmu_gather.c:300
 tlb_finish_mmu+0xd4/0x200 mm/mmu_gather.c:392
 exit_mmap+0x4b6/0xd40 mm/mmap.c:3292
 __mmput+0x115/0x3c0 kernel/fork.c:1343
 exit_mm+0x21f/0x310 kernel/exit.c:569
 do_exit+0x9af/0x2740 kernel/exit.c:858
 do_group_exit+0x206/0x2c0 kernel/exit.c:1020
 __do_sys_exit_group kernel/exit.c:1031 [inline]
 __se_sys_exit_group kernel/exit.c:1029 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1029
 do_syscall_64+0xf9/0x240
 entry_SYSCALL_64_after_hwframe+0x6f/0x77

Memory state around the buggy address:
 ffff88801fe55f00: 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc
 ffff88801fe55f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88801fe56000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                               ^
 ffff88801fe56080: fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc fc
 ffff88801fe56100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         90d35da6 Linux 6.8-rc7
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1665e3ca180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c11c5c676adb61f0
dashboard link: https://syzkaller.appspot.com/bug?extid=b91eb2ed18f599dd3c31
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12d5b14c180000


