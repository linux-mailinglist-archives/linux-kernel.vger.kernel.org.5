Return-Path: <linux-kernel+bounces-144070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFB88A417A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 11:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08C71281E6B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 09:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF1B2261D;
	Sun, 14 Apr 2024 09:13:07 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D16815E9B
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 09:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713085987; cv=none; b=E6FqhoRCfg1dpiOtFXv8myD5BF3TwPQ9ukYdQ/pO/9DH+ZmhVQ1hnxXQp0x7U+GIxDubKaG9k2nl0q6+BaqTa/vclEd+GN0x9VFUEAOZQU3DhNKq/KRUkUwciTihmWchFiuAwK3jf9pkUj9Q4jde3XgyiGyKWesQPRcTbv/hXSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713085987; c=relaxed/simple;
	bh=DcqoUyogB0i48HUpQU27SrM73YndcyYilq/q5l/8p8w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=I1R6cns5Vh94bNVCOMLhoVknkzfZ8OGlcKfFLyRem9cOstjK40VCky7Sqmwm1WAlQ8Rsa0F1LZudf9+Tms2Pl/4O7RlwX/VHpF+mkJskN8PxRO5hTVRKeO3hv7jk6TwzbTSE9BLuUZ0SwZJ84HTToP/lDendXPY8Obfjc60ekcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cf265b30e2so267432239f.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 02:13:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713085984; x=1713690784;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pbgjfn3dguO4zVDH1oEYyFD6nDfomXfL+xA5YXOQjOY=;
        b=tjMyo7X84H+62MAZmYim+2dQ1VJSc/ioEdfLzmv4GL8t55EuMSZibnS2fI7+ngl01D
         bPxmzW+vR9DpNc4Wb00t8KacVJr1o55CBeDXCsR5RuqoLsDKszokWh8LLYo/HVs3KzcX
         oIrLmPB3SWd+N/SuvOpAsSvrCxt9Pp7ZpHyfCDO+Fp2KbEogox0FUhoOMMvI3k108jUr
         7q/BA9UxDWxxlv2aro1sBBEedlTbGAXQlSeLSt+REdwdohYOGHotAfQyR5evQ3Iobi45
         vCCg9D6KPi4aptdgkc/v4Hb2qYnIWddZ1fSVguNdRhylPosqgLCxDGXoS8XcRAwMftkF
         Nxbw==
X-Forwarded-Encrypted: i=1; AJvYcCULdYfSzEqHYhuXk987PhL0VZGqbaAcbrMnmpZE///XZVs6CTeCiyGzCSeP46skL75PrDPqEfIYDbLtb3AuBfZh3Oc+frXU0SuHJpuv
X-Gm-Message-State: AOJu0YxTW1n0Y48XHFnTaGI2hN/qElunQiKGTtXJ0CcJ2PuesWpupl9H
	VnrazBbVYTGhPdK57kY5XXRKR1PgYbZtdfnk88/xIiNVkBJYv5A4ifCCGzUl7RZJxaxP3oZ6zLN
	HXHiclJ42JlNJhp85/8pCCbDFkhHKTFvcmDPS9WUsWMT4AvI8MH5f5xI=
X-Google-Smtp-Source: AGHT+IEgM9CQLnjukLP8Cw2J9jmkH+bMFs2kvgz6LgN/xTWHq2E0Y0yEoW8DBaOfSUAZBYX8h8+4mRQ8eMTSNvGCI5VPrLsZT93R
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:24d1:b0:482:c669:46eb with SMTP id
 y17-20020a05663824d100b00482c66946ebmr476471jat.1.1713085984813; Sun, 14 Apr
 2024 02:13:04 -0700 (PDT)
Date: Sun, 14 Apr 2024 02:13:04 -0700
In-Reply-To: <tencent_3C86D1B360E370E96663A06449F774776B05@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009844c706160ae92f@google.com>
Subject: Re: [syzbot] [gfs2?] KASAN: slab-use-after-free Read in gfs2_invalidate_folio
From: syzbot <syzbot+3a36aeabd31497d63f6e@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in gfs2_invalidate_folio

 </TASK>
bh: ffff88802f675110, bd: ffff88802f675150, trans_drain
bh: ffff88803dd9dbc8, bd: ffff88802f675150, gfs2_discard
==================================================================
BUG: KASAN: slab-use-after-free in list_empty include/linux/list.h:373 [inline]
BUG: KASAN: slab-use-after-free in gfs2_discard fs/gfs2/aops.c:618 [inline]
BUG: KASAN: slab-use-after-free in gfs2_invalidate_folio+0x731/0x840 fs/gfs2/aops.c:656
Read of size 8 at addr ffff88802f675168 by task syz-executor.0/5425

CPU: 0 PID: 5425 Comm: syz-executor.0 Not tainted 6.9.0-rc3-syzkaller-00073-ge8c39d0f57f3-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 list_empty include/linux/list.h:373 [inline]
 gfs2_discard fs/gfs2/aops.c:618 [inline]
 gfs2_invalidate_folio+0x731/0x840 fs/gfs2/aops.c:656
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
RIP: 0033:0x7ff35ce7f197
Code: b0 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 b0 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007fffb7457c68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007ff35ce7f197
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007fffb7457d20
RBP: 00007fffb7457d20 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007fffb7458de0
R13: 00007ff35cec93b9 R14: 000000000001327f R15: 0000000000000001
 </TASK>

Allocated by task 5425:
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
 gfs2_trans_add_data+0x4d1/0x820 fs/gfs2/trans.c:209
 gfs2_unstuffer_folio fs/gfs2/bmap.c:82 [inline]
 __gfs2_unstuff_inode fs/gfs2/bmap.c:122 [inline]
 gfs2_unstuff_dinode+0xb30/0x1510 fs/gfs2/bmap.c:170
 gfs2_adjust_quota+0x124/0xb10 fs/gfs2/quota.c:879
 do_sync+0xa88/0xd40 fs/gfs2/quota.c:990
 gfs2_quota_sync+0x419/0x630 fs/gfs2/quota.c:1371
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

Freed by task 5425:
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
 do_sync+0x565/0xd40 fs/gfs2/quota.c:1011
 gfs2_quota_sync+0x419/0x630 fs/gfs2/quota.c:1371
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

The buggy address belongs to the object at ffff88802f675150
 which belongs to the cache gfs2_bufdata of size 80
The buggy address is located 24 bytes inside of
 freed 80-byte region [ffff88802f675150, ffff88802f6751a0)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2f675
flags: 0xfff80000000800(slab|node=0|zone=1|lastcpupid=0xfff)
page_type: 0xffffffff()
raw: 00fff80000000800 ffff888015fa28c0 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080240024 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112c40(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY|__GFP_HARDWALL), pid 5425, tgid 5425 (syz-executor.0), ts 79266814979, free_ts 79245423591
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
 gfs2_trans_add_meta+0xae4/0xf60 fs/gfs2/trans.c:255
 gfs2_alloc_extent fs/gfs2/rgrp.c:2240 [inline]
 gfs2_alloc_blocks+0x4ea/0x1b30 fs/gfs2/rgrp.c:2451
 __gfs2_unstuff_inode fs/gfs2/bmap.c:109 [inline]
 gfs2_unstuff_dinode+0x49e/0x1510 fs/gfs2/bmap.c:170
 gfs2_adjust_quota+0x124/0xb10 fs/gfs2/quota.c:879
 do_sync+0xa88/0xd40 fs/gfs2/quota.c:990
 gfs2_quota_sync+0x419/0x630 fs/gfs2/quota.c:1371
 gfs2_sync_fs+0x44/0xb0 fs/gfs2/super.c:669
 sync_filesystem+0x10d/0x290 fs/sync.c:56
 generic_shutdown_super+0x7e/0x3d0 fs/super.c:620
page last free pid 5425 tgid 5425 stack trace:
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
 ffff88802f675000: fa fb fb fb fb fb fb fb fb fb fc fc fc fc fa fb
 ffff88802f675080: fb fb fb fb fb fb fb fb fc fc fc fc fa fb fb fb
>ffff88802f675100: fb fb fb fb fb fb fc fc fc fc fa fb fb fb fb fb
                                                          ^
 ffff88802f675180: fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88802f675200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         e8c39d0f Merge tag 'probes-fixes-v6.9-rc3' of git://gi..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=150cd74d180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=285be8dd6baeb438
dashboard link: https://syzkaller.appspot.com/bug?extid=3a36aeabd31497d63f6e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11383c43180000


