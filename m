Return-Path: <linux-kernel+bounces-143840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBFD8A3E1A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 20:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC7151F214C4
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 18:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6875A4D595;
	Sat, 13 Apr 2024 18:34:35 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202A410F4
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 18:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713033274; cv=none; b=J4CTxaCVQkwX4/w1MwduiXDNiVTdqVVfDo9ppNlT8GpgiNc2OEM1NMd4V/DAL1oZvrhsCaKF7aKxc9O97WA7BkPesua6wgsBawm3ACieQy6bYE5y3mI1vEIhejfJ2+yDkUgB5oh5o9DyEeQwWlowET/MbEG2FNp9RPCPYid5ONY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713033274; c=relaxed/simple;
	bh=+NH84lNuEhV8GJtPZ8jS7Dm8w4XjeLdF61onwV/H6GM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fZS7oNg64O/mIGwNsNbTQStqICUE3FfaAgeto2fHkKSu+yEFCcl4FHJLDgqyyc1VTZBEFjEGw9hlH+nf3WC83S0SwHek9vWna99SBlNTSjcapU6BewuIZvFPXg1+xpF9kk2pZYVbrnxoZh14A6CieEg5IVo1ckJZ6j7MVIjnO0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7d676654767so229092939f.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 11:34:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713033272; x=1713638072;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dy4zBelow6fpwRCVK4hEqmWZdq7wD25UWFLPy4Mlnes=;
        b=gN9bG3XeXmxaTRPnPC7fJeh8vH3CtqhinTfnqljWwpC+rQW5c5OlUlRajUzvZcDdgN
         tTjxpTg8s53Ic9EmMly3cZhTxp7i/BX7EEPZ8suHETWwSCFqm/hBpIYS1aew+QHmJ7Ig
         SQY+6VAjQeIqaGU27tyegb39XftvWmzC+p+zktianEZYpU1cuEwmulm1gHlb/4XBjZWy
         ZQJQOU//NzeYYp8sPK3bdTCdznzD0ZLWliMB7TRHt8ZVvl8plUjXqWwgP98lBpvBO2++
         lEt/OqUA/Ew5gwcguId3/qvO/jV6UOiWUalea1g2v9ukB7yAG4LwKeYJmtsXzdokYHA0
         moGg==
X-Forwarded-Encrypted: i=1; AJvYcCVht+VPfeP96GPQDCV33eGq4M3bj+mR+HNedG6mK4NQ8+kDu+otYfn21ssEcaGtFNC3J38RpvxvxBFm2v8m3TJbMFPgrLrN6HyOaFzs
X-Gm-Message-State: AOJu0YxlknmqyP3xuAp6uq5P70MLFFjVw7SHmAKH31Yyh8G7VxpZ8jSR
	G455fzcD9HBj9jQY9z9X8e+ygEn/t/lkEiLuFL58bxWdRy/Iqcj2yUY3XWVoqNuVB0U01gJlYnL
	hrRAadn+PX6bt6nnKO9UPquU4cd+DLFxp36/tDS1Biif4IWeLo3YH4mI=
X-Google-Smtp-Source: AGHT+IGiv92YLuTOrkFhXi40xalxFt9VYsY5gc1yxOJ+FwuLDzczzB2Cz0gUAAK8PKC3Y7sVhoPflMHxJ6i/VW6Mf9L+INh0iMdQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:14c5:b0:7d6:3243:3e57 with SMTP id
 b5-20020a05660214c500b007d632433e57mr238959iow.3.1713033272247; Sat, 13 Apr
 2024 11:34:32 -0700 (PDT)
Date: Sat, 13 Apr 2024 11:34:32 -0700
In-Reply-To: <000000000000daf1e10615e64dcb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ae5d410615fea3bf@google.com>
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in __vma_reservation_common
From: syzbot <syzbot+ad1b592fc4483655438b@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, muchun.song@linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    9ed46da14b9b Add linux-next specific files for 20240412
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12bd4457180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7ea0abc478c49859
dashboard link: https://syzkaller.appspot.com/bug?extid=ad1b592fc4483655438b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1370ea67180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fc649744d68c/disk-9ed46da1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/11eab7b9945d/vmlinux-9ed46da1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e7885afd198d/bzImage-9ed46da1.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/52aaf544deaa/mount_1.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ad1b592fc4483655438b@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in is_vm_hugetlb_page include/linux/hugetlb_inline.h:11 [inline]
BUG: KASAN: slab-use-after-free in vma_resv_map mm/hugetlb.c:1150 [inline]
BUG: KASAN: slab-use-after-free in __vma_reservation_common+0xc9/0x7d0 mm/hugetlb.c:2807
Read of size 8 at addr ffff888077a2f4f8 by task syz-executor.1/5375

CPU: 0 PID: 5375 Comm: syz-executor.1 Not tainted 6.9.0-rc3-next-20240412-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 is_vm_hugetlb_page include/linux/hugetlb_inline.h:11 [inline]
 vma_resv_map mm/hugetlb.c:1150 [inline]
 __vma_reservation_common+0xc9/0x7d0 mm/hugetlb.c:2807
 vma_needs_reservation mm/hugetlb.c:2881 [inline]
 restore_reserve_on_error+0x39/0x1d0 mm/hugetlb.c:2931
 hugetlb_no_page mm/hugetlb.c:6391 [inline]
 hugetlb_fault+0x1ae1/0x3910 mm/hugetlb.c:6487
 handle_mm_fault+0x18e8/0x1bb0 mm/memory.c:5701
 do_user_addr_fault arch/x86/mm/fault.c:1368 [inline]
 handle_page_fault arch/x86/mm/fault.c:1511 [inline]
 exc_page_fault+0x459/0x900 arch/x86/mm/fault.c:1569
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x7f0abea29681
Code: 39 c6 7e 57 4c 8b 5f 20 48 8b 57 28 eb 06 0f 1f 00 4c 89 c2 49 39 d3 74 47 4c 8b 57 18 4c 8d 42 01 89 c1 83 c0 08 4c 89 47 28 <41> 0f b6 14 12 89 47 34 48 d3 e2 49 09 d1 39 f0 7c d5 44 89 ca 29
RSP: 002b:00007f0abf824578 EFLAGS: 00010202
RAX: 0000000000000008 RBX: 00007f0abf824eb8 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 00007f0abf824670
RBP: 00007f0abf824670 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000020001602 R11: 000000000000609f R12: 0000000000000003
R13: 00007f0abf824f80 R14: 00007f0abf824f40 R15: 00007f0ab5800000
 </TASK>

Allocated by task 5373:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3897 [inline]
 slab_alloc_node mm/slub.c:3957 [inline]
 kmem_cache_alloc_noprof+0x135/0x290 mm/slub.c:3964
 vm_area_alloc+0x24/0x1d0 kernel/fork.c:467
 mmap_region+0xc20/0x2030 mm/mmap.c:2852
 do_mmap+0x8ad/0xfa0 mm/mmap.c:1387
 vm_mmap_pgoff+0x1dd/0x3d0 mm/util.c:573
 ksys_mmap_pgoff+0x544/0x720 mm/mmap.c:1433
 do_syscall_x64 arch/x86/entry/common.c:74 [inline]
 do_syscall_64+0xfa/0x250 arch/x86/entry/common.c:105
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 16:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2190 [inline]
 slab_free mm/slub.c:4393 [inline]
 kmem_cache_free+0x145/0x340 mm/slub.c:4468
 rcu_do_batch kernel/rcu/tree.c:2565 [inline]
 rcu_core+0xafd/0x1830 kernel/rcu/tree.c:2839
 __do_softirq+0x2c6/0x980 kernel/softirq.c:554

Last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:541
 __call_rcu_common kernel/rcu/tree.c:3102 [inline]
 call_rcu+0x167/0xa70 kernel/rcu/tree.c:3206
 remove_vma mm/mmap.c:148 [inline]
 remove_mt mm/mmap.c:2334 [inline]
 do_vmi_align_munmap+0x155c/0x18c0 mm/mmap.c:2677
 do_vmi_munmap+0x24e/0x2d0 mm/mmap.c:2741
 mmap_region+0x729/0x2030 mm/mmap.c:2792
 do_mmap+0x8ad/0xfa0 mm/mmap.c:1387
 vm_mmap_pgoff+0x1dd/0x3d0 mm/util.c:573
 ksys_mmap_pgoff+0x544/0x720 mm/mmap.c:1433
 do_syscall_x64 arch/x86/entry/common.c:74 [inline]
 do_syscall_64+0xfa/0x250 arch/x86/entry/common.c:105
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888077a2f4d8
 which belongs to the cache vm_area_struct of size 184
The buggy address is located 32 bytes inside of
 freed 184-byte region [ffff888077a2f4d8, ffff888077a2f590)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x77a2f
memcg:ffff88801a6ca701
flags: 0xfff80000000000(node=0|zone=1|lastcpupid=0xfff)
page_type: 0xffffefff(slab)
raw: 00fff80000000000 ffff8880162a7b40 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000100010 00000001ffffefff ffff88801a6ca701
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY), pid 5359, tgid 1476644483 (syz-executor.2), ts 5362, free_ts 103330549507
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1474
 prep_new_page mm/page_alloc.c:1482 [inline]
 get_page_from_freelist+0x2ce2/0x2d90 mm/page_alloc.c:3444
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4702
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
 vm_area_alloc+0x24/0x1d0 kernel/fork.c:467
 mmap_region+0xc20/0x2030 mm/mmap.c:2852
 do_mmap+0x8ad/0xfa0 mm/mmap.c:1387
 vm_mmap_pgoff+0x1dd/0x3d0 mm/util.c:573
 do_syscall_x64 arch/x86/entry/common.c:74 [inline]
 do_syscall_64+0xfa/0x250 arch/x86/entry/common.c:105
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5295 tgid 5292 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1094 [inline]
 free_unref_folios+0xf23/0x19e0 mm/page_alloc.c:2656
 folios_put_refs+0x93a/0xa60 mm/swap.c:1022
 free_pages_and_swap_cache+0x5c8/0x690 mm/swap_state.c:332
 __tlb_batch_free_encoded_pages mm/mmu_gather.c:136 [inline]
 tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
 tlb_flush_mmu+0x3a3/0x680 mm/mmu_gather.c:373
 tlb_finish_mmu+0xd4/0x200 mm/mmu_gather.c:465
 exit_mmap+0x44f/0xc80 mm/mmap.c:3325
 __mmput+0x115/0x3c0 kernel/fork.c:1346
 exit_mm+0x220/0x310 kernel/exit.c:569
 do_exit+0x99e/0x27e0 kernel/exit.c:865
 do_group_exit+0x207/0x2c0 kernel/exit.c:1027
 get_signal+0x16a1/0x1740 kernel/signal.c:2911
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xc9/0x370 kernel/entry/common.c:218
 do_syscall_64+0x10a/0x250 arch/x86/entry/common.c:111
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888077a2f380: fb fb fb fb fc fc fc fc fc fc fc fc fa fb fb fb
 ffff888077a2f400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888077a2f480: fb fb fb fc fc fc fc fc fc fc fc fa fb fb fb fb
                                                                ^
 ffff888077a2f500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888077a2f580: fb fb fc fc fc fc fc fc fc fc fa fb fb fb fb fb
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

