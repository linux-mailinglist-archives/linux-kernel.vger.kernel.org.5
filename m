Return-Path: <linux-kernel+bounces-143942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A03B08A3FF1
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 04:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C87A1B21A81
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 02:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D29E168B7;
	Sun, 14 Apr 2024 02:39:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48E714292
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 02:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713062346; cv=none; b=V7du3pVrSZPtS2oO1kg3JedJTs0ZoYs+ARLE152elowzvc612sUtSD86wbAtNVu0MgrqlrfQwiOe/La/nB95OdqsMT/tuHBrnfgYVLOLc1nNocTbPGy1iIG2Ri0SH0GrRzXtrW0r4/zqFDr6TkJxL/Ns1+yXNgHZa1SRgsWap/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713062346; c=relaxed/simple;
	bh=Y+cY1YY6nxzb114ai2z8flntZ7tyec7Sf0ONWyoKFPg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rP0kmPIIKOJ7oYFzwKlem8AIOGECJkf/Y7GEBhs1NnUWgNtDms6pg/jHuoW3dbWTxFo83FE9xNOU4wm245L+W1+dczpqZBI0KoAih3OxlXo6jG+JPYXpNyTfXgnplWLB4oYtD2PSeyZdy1yOF1l7o7OSha17/yJmcKcPrXjJUoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36b0ad52a87so19107235ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 19:39:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713062344; x=1713667144;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mr663TqTlbKKLrS0R+TR6tf444Er2+wgzPEsWrcjvvw=;
        b=M347ofk7HfC5J0R6AJzeqAjuUUFqWj0pnlkyeY1K2zbxU7iUzGr/oUBKMehTDZ/J93
         E6itm8egVzKl75CacKsZYNZT1fGNXUmcOrujxmJsmcowbIO3Ja8sRypl97DC+453ulmr
         goGgNeVGOCapI0I0E4EUyaNIlT89fljGvVHGalovyFm5PBm1OtOgn3HiGnVjoudTtiKb
         u9cvyZkdVSobP9C9Qins38rkjtaYO++bAwReCz2YeSdr7hmKHIP3T15rQ44bXmGjXRQU
         tIVsgtm8ZyG5q4sEe42W+7N4ipFMui8il5MISuuQXVSf1hUO/TXgYTJS0NHeDLHEbpGJ
         OHCg==
X-Forwarded-Encrypted: i=1; AJvYcCXYyrGAzjf0dWUvC//Aeczg2bMrE2a+z5Ss/NvgkLXWOvQd7cE1LpthrwISDp8sleIYeQW2sodC70RH/eJLfyWuMsDm//g/cJwSDeHe
X-Gm-Message-State: AOJu0YyWQkxeYxQJT2t1Wdf4wf5538Tqz2uQoeg7NZ8huFq64eqNGVZL
	1EA+yRPMqwcERkFLv2oiFwIMEKP7VqmROXfnm+0bM6K0r4KH+/hfPDaTWOh+0dfl3y5C0btP2hX
	lCALYyQZQ6KCeNSZpEH2RJx84kYoLAetieG3xLuc2hQ5gEg60XD/NlPk=
X-Google-Smtp-Source: AGHT+IG2AyO985j/oqe672/xku9V+G7H/TlMBR1YMgEQflVYOtcp0dgElU2hAJY3WYyJm6gCXa0xKPKG0iHbG+L0yxmXpqr1lyPM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:160b:b0:36b:1b03:d111 with SMTP id
 t11-20020a056e02160b00b0036b1b03d111mr29033ilu.6.1713062344163; Sat, 13 Apr
 2024 19:39:04 -0700 (PDT)
Date: Sat, 13 Apr 2024 19:39:04 -0700
In-Reply-To: <20240413233341.1957-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000809c06061605688e@google.com>
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in __vma_reservation_common
From: syzbot <syzbot+ad1b592fc4483655438b@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in hugetlb_fault

==================================================================
BUG: KASAN: slab-use-after-free in __vma_shareable_lock include/linux/hugetlb.h:1273 [inline]
BUG: KASAN: slab-use-after-free in hugetlb_vma_unlock_read mm/hugetlb.c:281 [inline]
BUG: KASAN: slab-use-after-free in hugetlb_no_page mm/hugetlb.c:6383 [inline]
BUG: KASAN: slab-use-after-free in hugetlb_fault+0x27b9/0x3910 mm/hugetlb.c:6487
Read of size 8 at addr ffff88801eda2ea8 by task syz-executor.0/6040

CPU: 0 PID: 6040 Comm: syz-executor.0 Not tainted 6.9.0-rc3-next-20240412-syzkaller-dirty #0
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
RIP: 0033:0x7fe7d8a5eeeb
Code: fa 10 73 2d 83 fa 08 73 46 83 fa 04 73 16 83 fa 01 7c 10 8a 0e 74 0a 0f b7 74 16 fe 66 89 74 17 fe 88 0f c3 8b 4c 16 fc 8b 36 <89> 4c 17 fc 89 37 c3 c5 fa 6f 06 c5 fa 6f 4c 16 f0 c5 fa 7f 07 c5
RSP: 002b:00007ffd32a0d108 EFLAGS: 00010246
RAX: 0000000020000700 RBX: 00007ffd32a0d218 RCX: 000000000073666a
RDX: 0000000000000004 RSI: 000000000073666a RDI: 0000000020000700
RBP: 0000000000000048 R08: 00007fe7d8a00000 R09: 00007fe7d8babf8c
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fe7d86000c8
R13: fffffffffffffffe R14: 00007fe7d8600000 R15: 00007fe7d86000d0
 </TASK>

Allocated by task 6043:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3897 [inline]
 slab_alloc_node mm/slub.c:3957 [inline]
 kmem_cache_alloc_noprof+0x135/0x290 mm/slub.c:3964
 vm_area_alloc+0x24/0x1d0 kernel/fork.c:467
 mmap_region+0xc20/0x2030 mm/mmap.c:2850
 do_mmap+0x8ad/0xfa0 mm/mmap.c:1387
 vm_mmap_pgoff+0x1dd/0x3d0 mm/util.c:573
 ksys_mmap_pgoff+0x544/0x720 mm/mmap.c:1433
 do_syscall_x64 arch/x86/entry/common.c:74 [inline]
 do_syscall_64+0xfa/0x250 arch/x86/entry/common.c:105
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 6043:
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
 do_vmi_align_munmap+0x14b6/0x1870 mm/mmap.c:2675
 do_vmi_munmap+0x24e/0x2d0 mm/mmap.c:2739
 mmap_region+0x729/0x2030 mm/mmap.c:2790
 do_mmap+0x8ad/0xfa0 mm/mmap.c:1387
 vm_mmap_pgoff+0x1dd/0x3d0 mm/util.c:573
 ksys_mmap_pgoff+0x544/0x720 mm/mmap.c:1433
 do_syscall_x64 arch/x86/entry/common.c:74 [inline]
 do_syscall_64+0xfa/0x250 arch/x86/entry/common.c:105
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88801eda2e88
 which belongs to the cache vm_area_struct of size 184
The buggy address is located 32 bytes inside of
 freed 184-byte region [ffff88801eda2e88, ffff88801eda2f40)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1eda2
memcg:ffff88801ee05801
flags: 0xfff80000000000(node=0|zone=1|lastcpupid=0xfff)
page_type: 0xffffefff(slab)
raw: 00fff80000000000 ffff8880162a7b40 ffffea0000899500 dead000000000004
raw: 0000000000000000 0000000000100010 00000001ffffefff ffff88801ee05801
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 5030, tgid -2004887359 (sftp-server), ts 5030, free_ts 49525412931
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
 mmap_region+0xc20/0x2030 mm/mmap.c:2850
 do_mmap+0x8ad/0xfa0 mm/mmap.c:1387
 vm_mmap_pgoff+0x1dd/0x3d0 mm/util.c:573
 ksys_mmap_pgoff+0x4f1/0x720 mm/mmap.c:1433
 do_syscall_x64 arch/x86/entry/common.c:74 [inline]
 do_syscall_64+0xfa/0x250 arch/x86/entry/common.c:105
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5030 tgid 5030 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1094 [inline]
 free_unref_folios+0xf23/0x19e0 mm/page_alloc.c:2656
 folios_put_refs+0x93a/0xa60 mm/swap.c:1022
 free_pages_and_swap_cache+0x2ea/0x690 mm/swap_state.c:329
 __tlb_batch_free_encoded_pages mm/mmu_gather.c:136 [inline]
 tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
 tlb_flush_mmu+0x3a3/0x680 mm/mmu_gather.c:373
 tlb_finish_mmu+0xd4/0x200 mm/mmu_gather.c:465
 exit_mmap+0x44f/0xc80 mm/mmap.c:3323
 __mmput+0x115/0x3c0 kernel/fork.c:1346
 exec_mmap+0x69d/0x730 fs/exec.c:1063
 begin_new_exec+0x125f/0x1f50 fs/exec.c:1329
 load_elf_binary+0x97d/0x25a0 fs/binfmt_elf.c:996
 search_binary_handler fs/exec.c:1797 [inline]
 exec_binprm fs/exec.c:1839 [inline]
 bprm_execve+0xaf8/0x17c0 fs/exec.c:1891
 do_execveat_common+0x553/0x700 fs/exec.c:1998
 do_execve fs/exec.c:2072 [inline]
 __do_sys_execve fs/exec.c:2148 [inline]
 __se_sys_execve fs/exec.c:2143 [inline]
 __x64_sys_execve+0x92/0xb0 fs/exec.c:2143
 do_syscall_x64 arch/x86/entry/common.c:74 [inline]
 do_syscall_64+0xfa/0x250 arch/x86/entry/common.c:105
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88801eda2d80: fc fc fa fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88801eda2e00: fb fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc
>ffff88801eda2e80: fc fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                  ^
 ffff88801eda2f00: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff88801eda2f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         9ed46da1 Add linux-next specific files for 20240412
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10766467180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7ea0abc478c49859
dashboard link: https://syzkaller.appspot.com/bug?extid=ad1b592fc4483655438b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=126b7a77180000


