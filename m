Return-Path: <linux-kernel+bounces-142734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D3A8A2F78
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0FF02819DC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B6F824B7;
	Fri, 12 Apr 2024 13:32:36 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064388249D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 13:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712928755; cv=none; b=ASV9pdP9HahcwOTNp1VfT2bqaCDJNv19YrKX1jw6bIPy22/DMr90c0PPZrquU6woezJvjjITdSdQgD5OBrgZDOsCtAIGRRm+0KseMmj5h0c4OWYTeX9OOGdgPDJSwU9JZifJcBf7SqXfHAWjL9GTeSso3KD2NWCQ8mx+r8lBXkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712928755; c=relaxed/simple;
	bh=FcWLQQSywxyOx7ugQEEncsES++XA1k4etScmJNCxwGo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rU3QBxaOiSUiST5uFKNIfFOkvP5DGxHPaciD/OShZ/j/DNZ7iwYlQ7kiWYxINRq0KU59OlQK09B5OYp21jxg1gFEcZYfFyA1V6/iB48UAqIoI0VBaXmYT1IqBx0uvih9yV6DHpE0AXpCCfo6YrrZua75ptixE4C+jXIgKoAhWD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7d622cae9e4so94839939f.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 06:32:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712928753; x=1713533553;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JGy54622EIIOJTih/JC0l32pL4GhzD27D4cIKrWXNUQ=;
        b=IYBGmYsfq8bXtZc+/tL5VP0ipFyRvTgQCNVA5gkEE1+cs9DyFlQQSq+Y+hwuKn4E4S
         WZ5HSx+XD8FnTMPwX9JAYYanjB6thmUjCPAkLCRT5+vMwL4h3th9X3KWNX1/5+aYn2L+
         2eL9ky4r7G3UUSYz8RvGBKDBIZUq9rfA+QM7V74wKHc7aqAxu1hN9M4Il9Vdw+ao24Dz
         qIciUXe0LcT20mkNViIZZpt1rkCJy9EI5fvEhhBhwMGsowr9bjTCCDegx5f6YXtacAeO
         FyurPOVhbalfth8JGXDFZ3XSloXN1+ZRKM7geu3JbKltyRLeX5edwkKTidnqvNWqr05n
         1Hfg==
X-Forwarded-Encrypted: i=1; AJvYcCUCsFFmBG1Aeeaj2TF9tiaiSHQECmlIemzZjZTnycgNyPZZyXphv3YpHWE5ZRPt9U1Rcx1QqcUBeckgOiuKGeEGwY/aW4PkM7b3aqUi
X-Gm-Message-State: AOJu0Yy6ATLTIIgNcJpZbKo6YmT2+WZ/eMQfvZQ7OP+Fl+joeQfYAv5C
	bWOyYDiM5qgoJfDFR9uXKkXWsO3/FhHPGkGJ7Rt621yhS3+l+ocDd18B9lzZ2efTGgzaBbJPVcl
	TQ9S5zL94fdJ/Kgg4mGQSjUoJt568Cheah9nN8U4+CWmvnA8jzd82Yfc=
X-Google-Smtp-Source: AGHT+IGQ/ghFWWDxfK/609NHQ56mxbE47ZvCI6TyCsMANNx29ulO8ckgAiPocpZMHt2rKD9PI1ix3+voA4vKdQfWfEtx8fVPODox
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:890b:b0:482:bdf8:f269 with SMTP id
 jc11-20020a056638890b00b00482bdf8f269mr54492jab.3.1712928753113; Fri, 12 Apr
 2024 06:32:33 -0700 (PDT)
Date: Fri, 12 Apr 2024 06:32:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000daf1e10615e64dcb@google.com>
Subject: [syzbot] [mm?] KASAN: slab-use-after-free Read in __vma_reservation_common
From: syzbot <syzbot+ad1b592fc4483655438b@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, muchun.song@linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    11cb68ad52ac Add linux-next specific files for 20240408
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13a6f483180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=727d5608101b5d77
dashboard link: https://syzkaller.appspot.com/bug?extid=ad1b592fc4483655438b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4e90f2d3b1ef/disk-11cb68ad.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d886b454e2cc/vmlinux-11cb68ad.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ed94857c6f92/bzImage-11cb68ad.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ad1b592fc4483655438b@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in is_vm_hugetlb_page include/linux/hugetlb_inline.h:11 [inline]
BUG: KASAN: slab-use-after-free in vma_resv_map mm/hugetlb.c:1150 [inline]
BUG: KASAN: slab-use-after-free in __vma_reservation_common+0xc9/0x7d0 mm/hugetlb.c:2807
Read of size 8 at addr ffff88807c6434f8 by task syz-executor.2/8726

CPU: 0 PID: 8726 Comm: syz-executor.2 Not tainted 6.9.0-rc3-next-20240408-syzkaller #0
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
 hugetlb_no_page mm/hugetlb.c:6390 [inline]
 hugetlb_fault+0x19ae/0x3710 mm/hugetlb.c:6486
 handle_mm_fault+0x18e8/0x1bb0 mm/memory.c:5662
 do_user_addr_fault arch/x86/mm/fault.c:1368 [inline]
 handle_page_fault arch/x86/mm/fault.c:1511 [inline]
 exc_page_fault+0x459/0x900 arch/x86/mm/fault.c:1569
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0033:0x7f9770c2c621
Code: 48 8b 54 24 08 48 85 d2 74 17 8b 44 24 18 0f c8 89 c0 48 89 44 24 18 48 83 fa 01 0f 85 b3 01 00 00 48 8b 44 24 10 8b 54 24 18 <89> 10 e9 15 fd ff ff 48 8b 44 24 10 8b 10 48 8b 44 24 08 48 85 c0
RSP: 002b:00007fff24941e70 EFLAGS: 00010246
RAX: 0000000020000000 RBX: 0000000000000004 RCX: 0000000000000000
RDX: 0000000000000194 RSI: 0000000000000000 RDI: 000055558dd3e360
RBP: 0000000000000004 R08: 0000000000000000 R09: 0000000000000000
R10: 00007fff24941fe0 R11: 0000000000000246 R12: 00007f9770801138
R13: fffffffffffffffe R14: 00007f9770800000 R15: 00007f9770801140
 </TASK>

Allocated by task 8728:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3897 [inline]
 slab_alloc_node mm/slub.c:3957 [inline]
 kmem_cache_alloc_noprof+0x135/0x290 mm/slub.c:3964
 vm_area_alloc+0x24/0x1d0 kernel/fork.c:467
 mmap_region+0xc09/0x2020 mm/mmap.c:2852
 do_mmap+0x8ad/0xf70 mm/mmap.c:1387
 vm_mmap_pgoff+0x1dd/0x3d0 mm/util.c:573
 ksys_mmap_pgoff+0x53c/0x6e0 mm/mmap.c:1433
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x72/0x7a

Freed by task 15:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2190 [inline]
 slab_free mm/slub.c:4393 [inline]
 kmem_cache_free+0x145/0x340 mm/slub.c:4468
 rcu_do_batch kernel/rcu/tree.c:2215 [inline]
 rcu_core+0xafd/0x1830 kernel/rcu/tree.c:2489
 __do_softirq+0x2c6/0x980 kernel/softirq.c:554

Last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:541
 __call_rcu_common kernel/rcu/tree.c:2752 [inline]
 call_rcu+0x167/0xa70 kernel/rcu/tree.c:2856
 remove_vma mm/mmap.c:148 [inline]
 remove_mt mm/mmap.c:2334 [inline]
 do_vmi_align_munmap+0x155c/0x18c0 mm/mmap.c:2677
 do_vmi_munmap+0x24e/0x2d0 mm/mmap.c:2741
 mmap_region+0x729/0x2020 mm/mmap.c:2792
 do_mmap+0x8ad/0xf70 mm/mmap.c:1387
 vm_mmap_pgoff+0x1dd/0x3d0 mm/util.c:573
 ksys_mmap_pgoff+0x53c/0x6e0 mm/mmap.c:1433
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x72/0x7a

The buggy address belongs to the object at ffff88807c6434d8
 which belongs to the cache vm_area_struct of size 184
The buggy address is located 32 bytes inside of
 freed 184-byte region [ffff88807c6434d8, ffff88807c643590)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88807c643aa8 pfn:0x7c643
memcg:ffff88802cfea301
anon flags: 0xfff80000000000(node=0|zone=1|lastcpupid=0xfff)
page_type: 0xffffefff(slab)
raw: 00fff80000000000 ffff8880162a7b40 ffffea00017aa380 dead000000000005
raw: ffff88807c643aa8 000000000010000b 00000001ffffefff ffff88802cfea301
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY), pid 8361, tgid -847542916 (dhcpcd-run-hook), ts 8361, free_ts 221237227404
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1468
 prep_new_page mm/page_alloc.c:1476 [inline]
 get_page_from_freelist+0x2ce2/0x2d90 mm/page_alloc.c:3438
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4696
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
 vm_area_dup+0x27/0x290 kernel/fork.c:482
 dup_mmap kernel/fork.c:697 [inline]
 dup_mm kernel/fork.c:1687 [inline]
 copy_mm+0xd0f/0x1fd0 kernel/fork.c:1736
 copy_process+0x187a/0x3dc0 kernel/fork.c:2389
 kernel_clone+0x226/0x8f0 kernel/fork.c:2796
 __do_sys_clone kernel/fork.c:2939 [inline]
 __se_sys_clone kernel/fork.c:2923 [inline]
 __x64_sys_clone+0x258/0x2a0 kernel/fork.c:2923
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x72/0x7a
page last free pid 5098 tgid 5098 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1088 [inline]
 free_unref_folios+0xf23/0x19e0 mm/page_alloc.c:2650
 folios_put_refs+0x93a/0xa60 mm/swap.c:1022
 folio_batch_release include/linux/pagevec.h:101 [inline]
 invalidate_inode_pages2_range+0xdfa/0x10e0 mm/truncate.c:670
 close_ctree+0x673/0xd20 fs/btrfs/disk-io.c:4367
 generic_shutdown_super+0x136/0x2d0 fs/super.c:641
 kill_anon_super+0x3b/0x70 fs/super.c:1225
 btrfs_kill_super+0x41/0x50 fs/btrfs/super.c:2091
 deactivate_locked_super+0xc4/0x130 fs/super.c:472
 cleanup_mnt+0x426/0x4c0 fs/namespace.c:1267
 task_work_run+0x24f/0x310 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x168/0x370 kernel/entry/common.c:218
 do_syscall_64+0x10a/0x240 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x72/0x7a

Memory state around the buggy address:
 ffff88807c643380: fb fb fb fb fc fc fc fc fc fc fc fc fa fb fb fb
 ffff88807c643400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88807c643480: fb fb fb fc fc fc fc fc fc fc fc fa fb fb fb fb
                                                                ^
 ffff88807c643500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807c643580: fb fb fc fc fc fc fc fc fc fc fa fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

