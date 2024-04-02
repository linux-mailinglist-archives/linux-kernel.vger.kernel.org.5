Return-Path: <linux-kernel+bounces-128641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0C9895D55
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EDDC2839C0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC9215D5A2;
	Tue,  2 Apr 2024 20:10:32 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF7715CD6D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 20:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712088632; cv=none; b=jZPx5WJ3c4DwSzyZqsLQe7+N+MBDgqFfH3PlhTmCjs3OsAVyVlwg0rcbiBq6RAAb0Dr0c3KI1yBcf2W/AJEB5qHB4wjBmD5UHQfP3GAaJ0oeWVglBQ/UM9yk68LuARonczGcflitKNDcGXAy457C1aWck2tn2jEIC4ZrMI+GRH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712088632; c=relaxed/simple;
	bh=2O47k7c4x5ZHTKzHF9G08ug7TBMyTnVVfp15/D1Plro=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=p3pNRRLtIxWhNu3dCGSBqHFGXVlY/mBy8mPLEtT0vVUiRluEKQgof9OYhGQO4ANJsa4M7Qc1LiM6uQr/85VPdmbZ0NUFZcriqJgP7P7xkQymY72nrMqB1+FwfTdILrwX4++XWDUXshf9Y0rDiDGbgZYcUftS5dpR/QOwpUsiyw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c7f57fa5eeso458085239f.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 13:10:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712088630; x=1712693430;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OBb3XQx21UgjwJOAi0bNC7miMcCUdqAoiin40zlZ5KM=;
        b=VG+Szm4daxiejx+2FlfpsO6MQCpakp6kZjjmPZ+sLMxOYElCwTo6WPYMx9Qgh/5yFM
         h0SEFmRVcW5eBVC7FX23K4PUGLMhESka6i/ibtURGFuUo8Ri1D05lQSz09N++UTMmfgs
         XuNKunYVOYR8QRNnwgMWZwONjaZNlk+lZ8C9yB5ZxcAIwP7J3bp7F/hcB3g4YuFsR0Lo
         POYjwS57obCb1tujheDgNIoRoPNZ2m7uszGZa6LRznouyNgBqiJ77rZqG6Y3jqX83eGz
         p9zkqPfqLDNh0tMxhh0OZLm0GQ2kgFfgXJ8jpFT/6dtKWF1l8IKLCF6eP2bJ6D97oXFP
         XP1w==
X-Forwarded-Encrypted: i=1; AJvYcCUSx6j0Md4igUXpG23d45KTz9vdUQr4MIkpqvilQbbtrvijcrFf1jH11V16CLxxU9x8fwTdcpNTZibgTxfnTVc3uyyQYMvTBLkKPFho
X-Gm-Message-State: AOJu0YyJE7wSMlKYSxzlqsYnz5N0w194SrS78N0yGPjHHsUq3WD7GTvb
	cl6cxUL03OrQy5lYrvpF61iYhkLzHfY2W/4L0jKzMQWqU2EF+MgaSrvBnQAviccm9myHmQRAsih
	oEOx7/V8nJDmOIvRe6PCi4R3JWaGws7NVd2iDnRw3YXEQDILD26z6yEg=
X-Google-Smtp-Source: AGHT+IHKTIeeZlo2cuysuiNFsR5H8kNt84B4bgO7HaJ2fX2jQnKH2lFkKhDfmTg1DTyZFjkf2rv9Xj7Ps31pjDCFF7WM/vayYvEf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3708:b0:47e:c165:74dc with SMTP id
 k8-20020a056638370800b0047ec16574dcmr932110jav.5.1712088629302; Tue, 02 Apr
 2024 13:10:29 -0700 (PDT)
Date: Tue, 02 Apr 2024 13:10:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000092ec58061522b2c7@google.com>
Subject: [syzbot] [mm?] KCSAN: data-race in __delete_from_swap_cache /
 folio_mapping (3)
From: syzbot <syzbot+58fc2a881f3b3df5e336@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    39cd87c4eb2b Linux 6.9-rc2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=129de21d180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d024e89f7bb376ce
dashboard link: https://syzkaller.appspot.com/bug?extid=58fc2a881f3b3df5e336
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b9b2dcffd7d5/disk-39cd87c4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5f4981fa60e6/vmlinux-39cd87c4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/691f671f70ad/bzImage-39cd87c4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+58fc2a881f3b3df5e336@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in __delete_from_swap_cache / folio_mapping

write to 0xffffea0004798fa8 of 8 bytes by task 29 on cpu 0:
 __delete_from_swap_cache+0x1f2/0x290 mm/swap_state.c:161
 delete_from_swap_cache+0x72/0xe0 mm/swap_state.c:241
 folio_free_swap+0x19f/0x1c0 mm/swapfile.c:1600
 free_swap_cache mm/swap_state.c:290 [inline]
 free_pages_and_swap_cache+0x1d9/0x400 mm/swap_state.c:322
 __tlb_batch_free_encoded_pages mm/mmu_gather.c:136 [inline]
 tlb_batch_pages_flush mm/mmu_gather.c:149 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:366 [inline]
 tlb_flush_mmu+0x2cf/0x440 mm/mmu_gather.c:373
 tlb_finish_mmu+0x8c/0x100 mm/mmu_gather.c:465
 __oom_reap_task_mm+0x231/0x2e0 mm/oom_kill.c:553
 oom_reap_task_mm mm/oom_kill.c:589 [inline]
 oom_reap_task mm/oom_kill.c:613 [inline]
 oom_reaper+0x264/0x850 mm/oom_kill.c:654
 kthread+0x1d1/0x210 kernel/kthread.c:388
 ret_from_fork+0x4b/0x60 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243

read to 0xffffea0004798fa8 of 8 bytes by task 14567 on cpu 1:
 folio_mapping+0xd2/0x110 mm/util.c:797
 folio_evictable mm/internal.h:256 [inline]
 move_folios_to_lru+0x137/0x690 mm/vmscan.c:1808
 shrink_inactive_list mm/vmscan.c:1929 [inline]
 shrink_list mm/vmscan.c:2163 [inline]
 shrink_lruvec+0xbd8/0x1640 mm/vmscan.c:5687
 shrink_node_memcgs mm/vmscan.c:5873 [inline]
 shrink_node+0xa78/0x15a0 mm/vmscan.c:5908
 shrink_zones mm/vmscan.c:6152 [inline]
 do_try_to_free_pages+0x3cc/0xca0 mm/vmscan.c:6214
 try_to_free_mem_cgroup_pages+0x1eb/0x4e0 mm/vmscan.c:6529
 try_charge_memcg+0x279/0xd10 mm/memcontrol.c:2783
 try_charge mm/memcontrol.c:2931 [inline]
 charge_memcg mm/memcontrol.c:7284 [inline]
 mem_cgroup_swapin_charge_folio+0x107/0x1a0 mm/memcontrol.c:7369
 __read_swap_cache_async+0x2b9/0x520 mm/swap_state.c:514
 swap_cluster_readahead+0x276/0x3f0 mm/swap_state.c:678
 swapin_readahead+0xe2/0x7a0 mm/swap_state.c:904
 do_swap_page+0x3bb/0x15f0 mm/memory.c:4048
 handle_pte_fault mm/memory.c:5303 [inline]
 __handle_mm_fault mm/memory.c:5441 [inline]
 handle_mm_fault+0x7fa/0x27e0 mm/memory.c:5606
 do_user_addr_fault arch/x86/mm/fault.c:1413 [inline]
 handle_page_fault arch/x86/mm/fault.c:1505 [inline]
 exc_page_fault+0x2f5/0x6d0 arch/x86/mm/fault.c:1563
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
 __get_user_8+0x11/0x20 arch/x86/lib/getuser.S:85
 rseq_get_rseq_cs kernel/rseq.c:161 [inline]
 rseq_ip_fixup kernel/rseq.c:281 [inline]
 __rseq_handle_notify_resume+0xc8/0xc00 kernel/rseq.c:329
 rseq_handle_notify_resume include/linux/rseq.h:38 [inline]
 resume_user_mode_work include/linux/resume_user_mode.h:62 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x90/0x130 kernel/entry/common.c:218
 do_syscall_64+0xe2/0x1d0 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x72/0x7a

value changed: 0x0000000000001198 -> 0x0000000000000000

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 14567 Comm: syz-executor.1 Tainted: G        W          6.9.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
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

