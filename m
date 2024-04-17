Return-Path: <linux-kernel+bounces-149282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B42928A8ED9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 00:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F8D11F223B6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B2380626;
	Wed, 17 Apr 2024 22:30:30 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEC07BB14
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 22:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713393029; cv=none; b=KeOZT8HEFxJBr0iJq55O3ONvqVTjUwrYcVGQ7rgXMEGhNnayP8s7dKW0HD8XqIuo3zS/Teh0XZjxdlLm2kfpe7rNABMCvivge2ILkd0HfISHNAIMz89hjg4PcHv/jS97P/fG7LWAqqFSknCkR3+FAIIzF+blaMg2hXcMaGoC5NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713393029; c=relaxed/simple;
	bh=77nybY2YChGHkFZaZm4AXxj6jQStL1C5IwaTlyQn2ps=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Uz0rzc/4MqHNMqVsaQS6g3KgzF6Y+zQ1WL0cXYIj0MsJ1bbscKng4wO2NRUXljZz8fVBeBqtzcWc87qOKvGNqENhTx0D/ywuud0TYt+7+IlAc32UBGOV9jzNAZg4q3Z4WbaaCdwRnpZxzc0cPQY/5MhW+xzKgCTGeMdiW/MCjXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7d5d7d6b971so34280139f.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 15:30:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713393027; x=1713997827;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=krRhbXD31nIwp7RmsuS2p3sp/ezVsPyX2T90dm00HNU=;
        b=tZ9V6FZHyExM+U+3OLxz0Y36ieuIpQsr/2jZ72QO/4Q0Q+sY4LQDAYC+SVjkBwVt1N
         8CRp1L8KG2BV6aE7NbkuvICEjkpH8oV9C1lvJlNaA9W3yrzl+KZ0wR4JI3hpJPXkt0gD
         y3kNRDtRMP8QdT11BtXJXLgb4s//cX+zsDMi7yZNkSyS1iC9lj6G86WHMrv4nF8XhB6F
         5uaq1yQ2GvNg6hxc9ZB1vE/Lk0QrX7+dZ4dhFrWSp5737GzudMXYb7yQYhX3OVnapBlG
         y5X9BDJWGcI5hGL7v5dVzMSftjdraNf+wG/N77hRrBenu3/naqUMa+40Pcm1snzkrpMd
         dGHw==
X-Forwarded-Encrypted: i=1; AJvYcCUcskvNT1lGkAZpKedLgPfuYMYx3TMwVkZ+X4wfS0s8OtwKAMwaZP3YP1oMkqjG2iEa6VoHrmUxRqn1tm1NMFSDh3G0X7TaSmT0Jd55
X-Gm-Message-State: AOJu0YzMYn6QqO1RWtzfx0FrXG6vFXV32Wha7N+OV9uV2oHoZYX23H29
	BHfw6CYXKJuFpPch0al1/cNWQG5p7cAEzmK5T/Mhv++KKfZTDY2jhMY396Lt5UXPFlOy6vatH+T
	QagzxHmnLDRs0ulyPWt2FBls9kBXBxNrNPfvWI8ct45VYdcLXP7wMeM0=
X-Google-Smtp-Source: AGHT+IHP/3krd/RLJoSzQZZNdNdiJRvRYYA8b6lGTiAOgXWIokXJL4TVixBRqVS2RFa/9LOjs+jnpohl8+7Rvmtm4fbs3slVzcmA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:22d5:b0:484:a2fc:fbd with SMTP id
 j21-20020a05663822d500b00484a2fc0fbdmr31521jat.4.1713393026446; Wed, 17 Apr
 2024 15:30:26 -0700 (PDT)
Date: Wed, 17 Apr 2024 15:30:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b3c7fa061652665f@google.com>
Subject: [syzbot] [mm?] KASAN: slab-use-after-free Read in hugetlb_fault
From: syzbot <syzbot+7fd4b85697bcf2a9daa2@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, muchun.song@linux.dev, syzkaller-bugs@googlegroups.com, 
	vishal.moola@gmail.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9ed46da14b9b Add linux-next specific files for 20240412
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14a4d74d180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7ea0abc478c49859
dashboard link: https://syzkaller.appspot.com/bug?extid=7fd4b85697bcf2a9daa2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1011afeb180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16f89857180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fc649744d68c/disk-9ed46da1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/11eab7b9945d/vmlinux-9ed46da1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e7885afd198d/bzImage-9ed46da1.xz

The issue was bisected to:

commit 7c43a553792a1701affeef20959dfb2ccb26dcee
Author: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Date:   Wed Feb 21 23:47:32 2024 +0000

    hugetlb: allow faults to be handled under the VMA lock

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=105bf935180000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=125bf935180000
console output: https://syzkaller.appspot.com/x/log.txt?x=145bf935180000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7fd4b85697bcf2a9daa2@syzkaller.appspotmail.com
Fixes: 7c43a553792a ("hugetlb: allow faults to be handled under the VMA lock")

==================================================================
BUG: KASAN: slab-use-after-free in __vma_shareable_lock include/linux/hugetlb.h:1273 [inline]
BUG: KASAN: slab-use-after-free in hugetlb_vma_unlock_read mm/hugetlb.c:281 [inline]
BUG: KASAN: slab-use-after-free in hugetlb_no_page mm/hugetlb.c:6383 [inline]
BUG: KASAN: slab-use-after-free in hugetlb_fault+0x27b9/0x3910 mm/hugetlb.c:6487
Read of size 8 at addr ffff8880163ac400 by task syz-executor233/5335

CPU: 0 PID: 5335 Comm: syz-executor233 Not tainted 6.9.0-rc3-next-20240412-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 __vma_shareable_lock include/linux/hugetlb.h:1273 [inline]
 hugetlb_vma_unlock_read mm/hugetlb.c:281 [inline]
 hugetlb_no_page mm/hugetlb.c:6383 [inline]
 hugetlb_fault+0x27b9/0x3910 mm/hugetlb.c:6487
 handle_mm_fault+0x18e8/0x1bb0 mm/memory.c:5701
 do_user_addr_fault arch/x86/mm/fault.c:1368 [inline]
 handle_page_fault arch/x86/mm/fault.c:1511 [inline]
 exc_page_fault+0x459/0x900 arch/x86/mm/fault.c:1569
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x7f6a2c7e7fcb
Code: bf a9 01 00 00 e8 15 4d 03 00 48 83 f8 ff 0f 84 99 fd ff ff 48 89 05 34 c1 0b 00 48 83 c4 08 5b 5d c3 66 0f 6f 05 c5 b0 08 00 <0f> 29 04 25 00 00 00 20 66 0f 6f 05 c5 b0 08 00 0f 11 04 25 0c 00
RSP: 002b:00007f6a2c7b6160 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 00007f6a2c8a6318 RCX: 00007f6a2c81ccd9
RDX: fe319eacbf5b3dac RSI: 0000000000000000 RDI: 00007f6a2c7b65a0
RBP: 00007f6a2c8a6310 R08: 0000000000000000 R09: 00007f6a2c7b66c0
R10: 00007f6a2c7b66c0 R11: 0000000000000246 R12: 00007f6a2c8a631c
R13: 000000000000006e R14: 00007ffee83e4b30 R15: 00007ffee83e4c18
 </TASK>

Allocated by task 5328:
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

Freed by task 51:
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

The buggy address belongs to the object at ffff8880163ac3e0
 which belongs to the cache vm_area_struct of size 184
The buggy address is located 32 bytes inside of
 freed 184-byte region [ffff8880163ac3e0, ffff8880163ac498)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x163ac
flags: 0xfff80000000000(node=0|zone=1|lastcpupid=0xfff)
page_type: 0xffffefff(slab)
raw: 00fff80000000000 ffff8880162a7b40 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000100010 00000001ffffefff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 4760, tgid 1563571937 (dhcpcd-run-hook), ts 4760, free_ts 31621429750
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
 __bprm_mm_init fs/exec.c:261 [inline]
 bprm_mm_init fs/exec.c:395 [inline]
 alloc_bprm+0x37a/0xa40 fs/exec.c:1599
 do_execveat_common+0x1b3/0x700 fs/exec.c:1949
 do_execve fs/exec.c:2072 [inline]
 __do_sys_execve fs/exec.c:2148 [inline]
 __se_sys_execve fs/exec.c:2143 [inline]
 __x64_sys_execve+0x92/0xb0 fs/exec.c:2143
 do_syscall_x64 arch/x86/entry/common.c:74 [inline]
 do_syscall_64+0xfa/0x250 arch/x86/entry/common.c:105
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 4759 tgid 4759 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1094 [inline]
 free_unref_page+0xd22/0xea0 mm/page_alloc.c:2607
 tlb_batch_list_free mm/mmu_gather.c:159 [inline]
 tlb_finish_mmu+0x11f/0x200 mm/mmu_gather.c:468
 exit_mmap+0x44f/0xc80 mm/mmap.c:3325
 __mmput+0x115/0x3c0 kernel/fork.c:1346
 exit_mm+0x220/0x310 kernel/exit.c:569
 do_exit+0x99e/0x27e0 kernel/exit.c:865
 do_group_exit+0x207/0x2c0 kernel/exit.c:1027
 __do_sys_exit_group kernel/exit.c:1038 [inline]
 __se_sys_exit_group kernel/exit.c:1036 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1036
 do_syscall_x64 arch/x86/entry/common.c:74 [inline]
 do_syscall_64+0xfa/0x250 arch/x86/entry/common.c:105
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff8880163ac300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff8880163ac380: 00 00 00 00 fc fc fc fc fc fc fc fc fa fb fb fb
>ffff8880163ac400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff8880163ac480: fb fb fb fc fc fc fc fc fc fc fc fa fb fb fb fb
 ffff8880163ac500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

