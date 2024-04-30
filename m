Return-Path: <linux-kernel+bounces-163381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1A68B6A25
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DA1C1C220B9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 06:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97B51863B;
	Tue, 30 Apr 2024 06:02:27 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02EA179B2
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 06:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714456947; cv=none; b=olQc8qVMoj3IdQ00CeIuth57XixxQz2S8HvuXmX5djFmV93CKHn07T9ar43V3uXaGFgNCKmqgv7zcV62oeeHwSHphRtHtyqIZXTAZzA5klNFS5gas+Zay2D5upfyd5Okephed0XH7Xol6tRaG+C8gr68DKggypk8PxgZNNgl7jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714456947; c=relaxed/simple;
	bh=KPHUxYuNxRuo+07oAQ5+qbTmGk8t7Up23tE8I2d2TJ4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JHn7nHmbD7wysEOhwmLtMg1y/jYkGPFio4IOdqU1TkAyTm19gF+wDh3gcmvGPaPku+C0NDXrrDPcYiP22bB9ZZDk3T+maKiHsihae8Tb0PsygbkKdEqh4boVAaRHbUDOqlmGlw5zy8ezjwIqbEHww1e8JTXTUOwMKScb2jE31f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7decf9533a3so143254739f.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 23:02:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714456945; x=1715061745;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hGTvjrFwRbCmETbxdiIxlM9DylbzpEhQs6jrFbB1e0M=;
        b=gGR11NUhIH9MzV3/fOngjF/Csi0LtWlsnUPknitB35/OXr02t0Gk9/aEMigOssU9md
         ICCFkG7W1MjIIr+HZjsmLc5BPfuSnAKbs9eOTOtzLQ1fEp1UM3I45vZwMPmHznAznwFF
         SdNOOE64rVtgo2S132mLg8Q6Lh2KAPau5ALdz6U9zi257jLRIGcsb5Xgya7m9XUwv3gf
         9aBXqKFJWMw/VtWJptW1j+b5a2APEp507LuDZ825rgMTQF6pgfl+JEIRdU826WGkg8lV
         DUJtRlqkCJxVVjmikqq8CMQIEO1sA6gdfnwCsJDD4sGrv7nlA1MWv2xB7updCJzqeAfa
         G9rw==
X-Forwarded-Encrypted: i=1; AJvYcCVGLNFtAgMwffO+ALBklmMI1ke5pc/gQOH6jJlLQmXyNmcL/tjrNJkv93kS6JRAbrkIHq1QCeF8wCYNl7zycDxW7uZrP1ObD0cTUmRm
X-Gm-Message-State: AOJu0Yxjdw07ntuHIXRz5wmnLQS9Y90WkVRCWv9aiRyimZWvgnWIhub6
	2xqpr7iY6h+3KFkfEy4CsADGem0bZ/z1xKb8bfMA+YEI4IIK4vyJxvqM+NyYHsMJKjxj392kzN2
	8kVbScJ6UvdqipmQXfZE0l90AbuTUS38eviHN7PF6WI4SDn2NkuGD920=
X-Google-Smtp-Source: AGHT+IFvngwB/les2brJ3oBZDJKWTwibyc/ZRqWeWxFajXO6PdAZV8rHG+VFc99F2dc9/wxy4HFTJSs0/cwtvqXFovK7WIBxiUBL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:868e:b0:487:5dce:65ab with SMTP id
 iv14-20020a056638868e00b004875dce65abmr109876jab.0.1714456944883; Mon, 29 Apr
 2024 23:02:24 -0700 (PDT)
Date: Mon, 29 Apr 2024 23:02:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002ecbdb06174a1d9a@google.com>
Subject: [syzbot] [mm?] KMSAN: uninit-value in zswap_rb_insert
From: syzbot <syzbot+9c9d60f1b20b22ce218a@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, chengming.zhou@linux.dev, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, nphamcs@gmail.com, 
	syzkaller-bugs@googlegroups.com, yosryahmed@google.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e33c4963bf53 Merge tag 'nfsd-6.9-5' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=123d5a0f180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=776c05250f36d55c
dashboard link: https://syzkaller.appspot.com/bug?extid=9c9d60f1b20b22ce218a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a10175188ebb/disk-e33c4963.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/abe743417d16/vmlinux-e33c4963.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fb10cccc9909/bzImage-e33c4963.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9c9d60f1b20b22ce218a@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in zswap_rb_insert+0x1e9/0x330 mm/zswap.c:842
 zswap_rb_insert+0x1e9/0x330 mm/zswap.c:842
 zswap_store+0x22f2/0x2ca0 mm/zswap.c:1591
 swap_writepage+0x126/0x4c0 mm/page_io.c:198
 pageout mm/vmscan.c:660 [inline]
 shrink_folio_list+0x4a55/0x7910 mm/vmscan.c:1323
 evict_folios+0x9d7f/0xcc20 mm/vmscan.c:4537
 try_to_shrink_lruvec+0x160e/0x1a50 mm/vmscan.c:4733
 shrink_one+0x66f/0xd40 mm/vmscan.c:4772
 shrink_many mm/vmscan.c:4835 [inline]
 lru_gen_shrink_node mm/vmscan.c:4935 [inline]
 shrink_node+0x4856/0x55f0 mm/vmscan.c:5894
 shrink_zones mm/vmscan.c:6152 [inline]
 do_try_to_free_pages+0x820/0x2570 mm/vmscan.c:6214
 try_to_free_pages+0xb7b/0x1820 mm/vmscan.c:6449
 __perform_reclaim mm/page_alloc.c:3774 [inline]
 __alloc_pages_direct_reclaim mm/page_alloc.c:3796 [inline]
 __alloc_pages_slowpath+0x1035/0x31a0 mm/page_alloc.c:4202
 __alloc_pages+0xacf/0xe70 mm/page_alloc.c:4588
 alloc_pages_mpol+0x299/0x990 mm/mempolicy.c:2264
 vma_alloc_folio+0x418/0x680 mm/mempolicy.c:2303
 do_cow_fault mm/memory.c:4918 [inline]
 do_fault mm/memory.c:5026 [inline]
 do_pte_missing mm/memory.c:3880 [inline]
 handle_pte_fault mm/memory.c:5300 [inline]
 __handle_mm_fault mm/memory.c:5441 [inline]
 handle_mm_fault+0x4f2f/0xce00 mm/memory.c:5606
 do_user_addr_fault arch/x86/mm/fault.c:1413 [inline]
 handle_page_fault arch/x86/mm/fault.c:1505 [inline]
 exc_page_fault+0x2a0/0x730 arch/x86/mm/fault.c:1563
 asm_exc_page_fault+0x2b/0x30 arch/x86/include/asm/idtentry.h:623
 rep_stos_alternative+0x40/0x80 arch/x86/lib/clear_page_64.S:92
 load_elf_binary+0x212e/0x4d30 fs/binfmt_elf.c:1132
 search_binary_handler fs/exec.c:1778 [inline]
 exec_binprm fs/exec.c:1820 [inline]
 bprm_execve+0xc57/0x21c0 fs/exec.c:1872
 do_execveat_common+0xceb/0xd70 fs/exec.c:1979
 do_execve fs/exec.c:2053 [inline]
 __do_sys_execve fs/exec.c:2129 [inline]
 __se_sys_execve fs/exec.c:2124 [inline]
 __x64_sys_execve+0xf4/0x130 fs/exec.c:2124
 x64_sys_call+0x1612/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:60
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 __alloc_pages+0x9d6/0xe70 mm/page_alloc.c:4598
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page mm/slub.c:2175 [inline]
 allocate_slab mm/slub.c:2338 [inline]
 new_slab+0x2de/0x1400 mm/slub.c:2391
 ___slab_alloc+0x1184/0x33d0 mm/slub.c:3525
 __slab_alloc mm/slub.c:3610 [inline]
 __slab_alloc_node mm/slub.c:3663 [inline]
 slab_alloc_node mm/slub.c:3835 [inline]
 kmem_cache_alloc_node+0x6ea/0xc50 mm/slub.c:3888
 zswap_entry_cache_alloc mm/zswap.c:874 [inline]
 zswap_store+0xb26/0x2ca0 mm/zswap.c:1535
 swap_writepage+0x126/0x4c0 mm/page_io.c:198
 pageout mm/vmscan.c:660 [inline]
 shrink_folio_list+0x4a55/0x7910 mm/vmscan.c:1323
 evict_folios+0x9d7f/0xcc20 mm/vmscan.c:4537
 try_to_shrink_lruvec+0x160e/0x1a50 mm/vmscan.c:4733
 shrink_one+0x66f/0xd40 mm/vmscan.c:4772
 shrink_many mm/vmscan.c:4835 [inline]
 lru_gen_shrink_node mm/vmscan.c:4935 [inline]
 shrink_node+0x4856/0x55f0 mm/vmscan.c:5894
 shrink_zones mm/vmscan.c:6152 [inline]
 do_try_to_free_pages+0x820/0x2570 mm/vmscan.c:6214
 try_to_free_pages+0xb7b/0x1820 mm/vmscan.c:6449
 __perform_reclaim mm/page_alloc.c:3774 [inline]
 __alloc_pages_direct_reclaim mm/page_alloc.c:3796 [inline]
 __alloc_pages_slowpath+0x1035/0x31a0 mm/page_alloc.c:4202
 __alloc_pages+0xacf/0xe70 mm/page_alloc.c:4588
 alloc_pages_mpol+0x299/0x990 mm/mempolicy.c:2264
 alloc_pages+0x1bf/0x1e0 mm/mempolicy.c:2335
 vm_area_alloc_pages mm/vmalloc.c:3561 [inline]
 __vmalloc_area_node mm/vmalloc.c:3637 [inline]
 __vmalloc_node_range+0x100a/0x28b0 mm/vmalloc.c:3818
 vmalloc_user+0x90/0xb0 mm/vmalloc.c:3972
 kcov_ioctl+0x5d/0x660 kernel/kcov.c:704
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:904 [inline]
 __se_sys_ioctl+0x261/0x450 fs/ioctl.c:890
 __x64_sys_ioctl+0x96/0xe0 fs/ioctl.c:890
 x64_sys_call+0x1883/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:17
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 PID: 5281 Comm: dhcpcd-run-hook Not tainted 6.9.0-rc5-syzkaller-00053-ge33c4963bf53 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
=====================================================


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

