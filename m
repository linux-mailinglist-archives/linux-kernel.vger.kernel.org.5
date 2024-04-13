Return-Path: <linux-kernel+bounces-143655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B068A3BF7
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 11:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04C801C20ECC
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 09:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2527F2C695;
	Sat, 13 Apr 2024 09:36:14 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9044A33
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 09:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713000973; cv=none; b=NFgB5fps6prm4xzJQaGwIzNCx7+R6v9h97iFhqRN0FjNE5UL1jEvAoGavDRRhQqKW2a1D4jlTFl8AW82dxdTArTu56QzbT1s58G61SyP/LUpVa2yNUU2kwDRFGnG5aKJO1o9RBY+jQRwQbTq2ZsoCz3d3+aPXYThABNLuUCSh3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713000973; c=relaxed/simple;
	bh=3A9/MCs2OtB9W5K0PTeQWE1rW1ih2Y3E3KdOrLUDEHU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=A8hf50nfWPbqasjgd1OrshaQWrNHe6AjNYKV3B9jHTDIkNDpVWBvKuaHB/HSEBuz8BEsWJhsv2BbWjoEFM+JgdYAwCtGJXyqjftBMX2VHa/ziqXQ3xirqEP6QDGJnI3sg5D1utQ2BFREPHac0l0gqLDPgUEGT/Rga15TucEYw0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36afb9ef331so18687085ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 02:36:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713000971; x=1713605771;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n5Kwquua+A7tuQwx4dlzvSOU4A4y7A8XsR9dY1hHbGA=;
        b=WtnTjJ0F35KwiQ+xyjgw94GpYQf+3kvEgeZSMqoX790Ng5EkxKiXYl4Sl9pBL/8ZT+
         Rgz067ypyQm/ROJINw1JqjLxRYssPLtKoztoAgeRkFgtmG3AleCCpwhMnup7grbJP7R9
         VqdZYMlO5TId+BDjT9bpA/zE8l4WqKJwFZTtsW8FW33LZ5QLvRXZMpLEvoGmFN8kk2qO
         gbFOZOcMqpUf2BlCIqAa6hLLDjQtYt3J6c/aqS1kOVZW/HMgzyFIPGVm2I5/EezjOIu3
         9KEOVGZj67XNsy0BdcpTfklD4VyBz4998cOnfYAquTLQ0f6SeQtW0RHoxZRla/ACrlXp
         WJPw==
X-Forwarded-Encrypted: i=1; AJvYcCVR2/12v8YEUF9bnI666Eh1iAzEkFHAaz6GWb56vfyv9xleAyM81c3sjf7CDacaZ71uDjwMDP/JuWWgGo6WJN6JC53MzcGryj+FrZp7
X-Gm-Message-State: AOJu0YxPYgRM6hifCSuGfvBeHoGkN7xMQGryaig1Gw1ST3uKJ90lD0sY
	uqNH7MS129wZOUaxyiH1cM8vX6QPsc7gWFlE0qAedwCuogEWXhYKBY5loI42JfMmMC0as60BYBh
	ni+5QW4Fwi5ZibNsNarsZ4Dmt1JdFtPxwEdtYa9gqUm+KPJwqzo6HZOQ=
X-Google-Smtp-Source: AGHT+IEqlevpVBvTay1/b/V8HZewUzL98UdKgheBzCPaaDWiTQ9UOsByNHjynQEby2yY/UwtSqcKLbEJQQMPsRxDVthve/bFc5hv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8b:b0:36a:3fb0:c96b with SMTP id
 h11-20020a056e021d8b00b0036a3fb0c96bmr399399ila.1.1713000971085; Sat, 13 Apr
 2024 02:36:11 -0700 (PDT)
Date: Sat, 13 Apr 2024 02:36:11 -0700
In-Reply-To: <tencent_A6684B2C74B976B5674C3DC1375496EC3709@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000061ba760615f71e49@google.com>
Subject: Re: [syzbot] [gfs2?] KASAN: slab-use-after-free Read in gfs2_invalidate_folio
From: syzbot <syzbot+3a36aeabd31497d63f6e@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in gfs2_invalidate_folio

==================================================================
BUG: KASAN: slab-use-after-free in list_empty include/linux/list.h:373 [inline]
BUG: KASAN: slab-use-after-free in gfs2_discard fs/gfs2/aops.c:617 [inline]
BUG: KASAN: slab-use-after-free in gfs2_invalidate_folio+0x718/0x820 fs/gfs2/aops.c:655
Read of size 8 at addr ffff88801eda0168 by task syz-executor.0/5408

CPU: 1 PID: 5408 Comm: syz-executor.0 Not tainted 6.9.0-rc3-syzkaller-00073-ge8c39d0f57f3-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 list_empty include/linux/list.h:373 [inline]
 gfs2_discard fs/gfs2/aops.c:617 [inline]
 gfs2_invalidate_folio+0x718/0x820 fs/gfs2/aops.c:655
 folio_invalidate mm/truncate.c:158 [inline]
 truncate_cleanup_folio+0x2ac/0x3e0 mm/truncate.c:178
 truncate_inode_pages_range+0x271/0xe90 mm/truncate.c:358
 gfs2_evict_inode+0x75b/0x1460 fs/gfs2/super.c:1508
 evict+0x2ed/0x6c0 fs/inode.c:667
 iput_final fs/inode.c:1741 [inline]
 iput.part.0+0x5a8/0x7f0 fs/inode.c:1767
 iput+0x5c/0x80 fs/inode.c:1757
 gfs2_put_super+0x2bd/0x760 fs/gfs2/super.c:625
 generic_shutdown_super+0x159/0x3d0 fs/super.c:641
 kill_block_super+0x3b/0x90 fs/super.c:1675
 gfs2_kill_sb+0x360/0x410 fs/gfs2/ops_fstype.c:1804
 deactivate_locked_super+0xbe/0x1a0 fs/super.c:472
 deactivate_super+0xde/0x100 fs/super.c:505
 cleanup_mnt+0x222/0x450 fs/namespace.c:1267
 task_work_run+0x14e/0x250 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x278/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xdc/0x260 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6eafc7f197
Code: b0 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 b0 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffe0a357d88 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f6eafc7f197
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffe0a357e40
RBP: 00007ffe0a357e40 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffe0a358f00
R13: 00007f6eafcc93b9 R14: 0000000000012bfa R15: 0000000000000001
 </TASK>

Allocated by task 5408:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x89/0x90 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3798 [inline]
 slab_alloc_node mm/slub.c:3845 [inline]
 kmem_cache_alloc+0x136/0x320 mm/slub.c:3852
 kmem_cache_zalloc include/linux/slab.h:739 [inline]
 gfs2_alloc_bufdata fs/gfs2/trans.c:168 [inline]
 gfs2_trans_add_data+0x4b3/0x7f0 fs/gfs2/trans.c:209
 gfs2_unstuffer_folio fs/gfs2/bmap.c:81 [inline]
 __gfs2_unstuff_inode fs/gfs2/bmap.c:119 [inline]
 gfs2_unstuff_dinode+0xad9/0x1460 fs/gfs2/bmap.c:166
 gfs2_adjust_quota+0x124/0xb10 fs/gfs2/quota.c:879
 do_sync+0xa73/0xd30 fs/gfs2/quota.c:990
 gfs2_quota_sync+0x419/0x630 fs/gfs2/quota.c:1370
 gfs2_sync_fs+0x44/0xb0 fs/gfs2/super.c:669
 sync_filesystem+0x10d/0x290 fs/sync.c:56
 generic_shutdown_super+0x7e/0x3d0 fs/super.c:620
 kill_block_super+0x3b/0x90 fs/super.c:1675
 gfs2_kill_sb+0x360/0x410 fs/gfs2/ops_fstype.c:1804
 deactivate_locked_super+0xbe/0x1a0 fs/super.c:472
 deactivate_super+0xde/0x100 fs/super.c:505
 cleanup_mnt+0x222/0x450 fs/namespace.c:1267
 task_work_run+0x14e/0x250 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x278/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xdc/0x260 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5408:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:240 [inline]
 __kasan_slab_free+0x11d/0x1a0 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2106 [inline]
 slab_free mm/slub.c:4280 [inline]
 kmem_cache_free+0x12e/0x380 mm/slub.c:4344
 trans_drain fs/gfs2/log.c:1031 [inline]
 gfs2_log_flush+0x149f/0x29c0 fs/gfs2/log.c:1170
 do_sync+0x550/0xd30 fs/gfs2/quota.c:1010
 gfs2_quota_sync+0x419/0x630 fs/gfs2/quota.c:1370
 gfs2_sync_fs+0x44/0xb0 fs/gfs2/super.c:669
 sync_filesystem+0x10d/0x290 fs/sync.c:56
 generic_shutdown_super+0x7e/0x3d0 fs/super.c:620
 kill_block_super+0x3b/0x90 fs/super.c:1675
 gfs2_kill_sb+0x360/0x410 fs/gfs2/ops_fstype.c:1804
 deactivate_locked_super+0xbe/0x1a0 fs/super.c:472
 deactivate_super+0xde/0x100 fs/super.c:505
 cleanup_mnt+0x222/0x450 fs/namespace.c:1267
 task_work_run+0x14e/0x250 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x278/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xdc/0x260 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88801eda0150
 which belongs to the cache gfs2_bufdata of size 80
The buggy address is located 24 bytes inside of
 freed 80-byte region [ffff88801eda0150, ffff88801eda01a0)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1eda0
flags: 0xfff80000000800(slab|node=0|zone=1|lastcpupid=0xfff)
page_type: 0xffffffff()
raw: 00fff80000000800 ffff88801a5608c0 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080240024 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112c40(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY|__GFP_HARDWALL), pid 5408, tgid 5408 (syz-executor.0), ts 77566437630, free_ts 77557534093
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d4/0x350 mm/page_alloc.c:1534
 prep_new_page mm/page_alloc.c:1541 [inline]
 get_page_from_freelist+0xa28/0x3780 mm/page_alloc.c:3317
 __alloc_pages+0x22b/0x2460 mm/page_alloc.c:4575
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page mm/slub.c:2175 [inline]
 allocate_slab mm/slub.c:2338 [inline]
 new_slab+0xcc/0x3a0 mm/slub.c:2391
 ___slab_alloc+0x66d/0x1790 mm/slub.c:3525
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3610
 __slab_alloc_node mm/slub.c:3663 [inline]
 slab_alloc_node mm/slub.c:3835 [inline]
 kmem_cache_alloc+0x2e9/0x320 mm/slub.c:3852
 kmem_cache_zalloc include/linux/slab.h:739 [inline]
 gfs2_alloc_bufdata fs/gfs2/trans.c:168 [inline]
 gfs2_trans_add_meta+0xade/0xf50 fs/gfs2/trans.c:251
 gfs2_alloc_extent fs/gfs2/rgrp.c:2239 [inline]
 gfs2_alloc_blocks+0x46c/0x19c0 fs/gfs2/rgrp.c:2449
 __gfs2_unstuff_inode fs/gfs2/bmap.c:107 [inline]
 gfs2_unstuff_dinode+0x499/0x1460 fs/gfs2/bmap.c:166
 gfs2_adjust_quota+0x124/0xb10 fs/gfs2/quota.c:879
 do_sync+0xa73/0xd30 fs/gfs2/quota.c:990
 gfs2_quota_sync+0x419/0x630 fs/gfs2/quota.c:1370
 gfs2_sync_fs+0x44/0xb0 fs/gfs2/super.c:669
 sync_filesystem+0x10d/0x290 fs/sync.c:56
 generic_shutdown_super+0x7e/0x3d0 fs/super.c:620
page last free pid 5408 tgid 5408 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1141 [inline]
 free_unref_page_prepare+0x527/0xb10 mm/page_alloc.c:2347
 free_unref_page+0x33/0x3c0 mm/page_alloc.c:2487
 __folio_put_small mm/swap.c:119 [inline]
 __folio_put+0x166/0x1f0 mm/swap.c:142
 folio_put include/linux/mm.h:1506 [inline]
 free_page_and_swap_cache+0x1eb/0x250 mm/swap_state.c:305
 __tlb_remove_table arch/x86/include/asm/tlb.h:34 [inline]
 __tlb_remove_table_free mm/mmu_gather.c:227 [inline]
 tlb_remove_table_rcu+0x89/0xe0 mm/mmu_gather.c:282
 rcu_do_batch kernel/rcu/tree.c:2196 [inline]
 rcu_core+0x828/0x16b0 kernel/rcu/tree.c:2471
 __do_softirq+0x218/0x922 kernel/softirq.c:554

Memory state around the buggy address:
 ffff88801eda0000: fa fb fb fb fb fb fb fb fb fb fc fc fc fc fa fb
 ffff88801eda0080: fb fb fb fb fb fb fb fb fc fc fc fc fa fb fb fb
>ffff88801eda0100: fb fb fb fb fb fb fc fc fc fc fa fb fb fb fb fb
                                                          ^
 ffff88801eda0180: fb fb fb fb fc fc fc fc fa fb fb fb fb fb fb fb
 ffff88801eda0200: fb fb fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         e8c39d0f Merge tag 'probes-fixes-v6.9-rc3' of git://gi..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=13904f97180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=285be8dd6baeb438
dashboard link: https://syzkaller.appspot.com/bug?extid=3a36aeabd31497d63f6e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=116eabf3180000


