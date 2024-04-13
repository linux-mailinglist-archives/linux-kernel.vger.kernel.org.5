Return-Path: <linux-kernel+bounces-143758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3845B8A3D12
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 17:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 076411C20B8D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 15:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93DB44C7E;
	Sat, 13 Apr 2024 15:05:07 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5B910957
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 15:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713020707; cv=none; b=INpVEO9864uMT2PPC5zmZPYm+kfV1atYT7UfYiUz2OfyErtIKmjaWrOTtDtLPGwCjDrJ9s54ooXiT+j1/c1eF5n4bT0MOOO6TsHtEgUEofLtNNE6I3tAc3HSrETMeTQbzSuGz3eziD0RoXCMlPWYTHvZ/JeQsAI4b3B22Vua3ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713020707; c=relaxed/simple;
	bh=MHdhiNwbqOAn3+qkeX1l9rMxO9tJ32OqrusxxshOBt4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cZJZ5mVQz9UqTuisu6q/in5ayIQ9Uz0pd7LQv7okvC20hwS/qL5gDsZTAPgbpaG7+mEYf75f79eAKszEkBQKoIbOq0tI+3tOcjZkyye2NYZRX9lDa9rlWXFKvwmI9+8MnOimOLOzoYJ0jlcYPRByKBZQpzxH4QXUEpgBVtyckig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c9aa481ce4so214117239f.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 08:05:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713020704; x=1713625504;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Xt+eijk0z1zPF23qHrtVHQRI8ZJBL5JSTdLbM6McN8=;
        b=v675Z8hWDGgV/HvaxumBOrgc7k8zcNuDFPHXPtyoZnK07Kn0yDln773WvhnojGSk7J
         1PuNxUzt2q1H/iXrR7beP+j+FzGGxZYSIS/YAu8LS11LZD9F3AQutX8FJkKF3y+i/eTI
         FTvIl8ubepai1VHC7Q3zpqJynKU6Xes5/LJq6jnYkfSIlrlTJSm75l5WX5aCnP8nQ4aR
         HcTg4tlNP3grbVluCephOB9RGyD2OcVeRVTIfwIFC/XGuNIVetmbKc+m5/uh31Ag89a0
         b4mjWwDw7dc/51is710eIaICy+BJoKoxR7A8er3mwOafghE4qUvSOoD72bgcOw12lf3D
         2JvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuiNL56LlVyYijmffFcTwdHPmUH6QyyLxC/R31QFPMaUAShcrB14oOWYBPJBA3vTVarTYYcXZdeEUQA9G6KrrSK74J5RcfkidTxD9/
X-Gm-Message-State: AOJu0Ywj9qXArt5dgP5geH2UVhKUKMMshoB8zKxmMWFUQTkTLyk69QGu
	jAxvciuMUKIxfve5ESIyHKaI42eDbHD8sWt7FWFm/FMraGbEkHcdAQtbh3Laac8JgSEJkWcaSfe
	ZdtmASt+3abyB/DJHfLdTAjAVDmPBNWDEqMyE2IE0qiVNinPxmVpt/Ao=
X-Google-Smtp-Source: AGHT+IH+ptKTb4HM0/k2tt0ttZM6saiWYOiqlfjAmjbdpPB3JVcxzBdI9XU/y7bhROGgJA/XFCwV6OlNuLsTD9MBKzUsdSMK5voR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:24d1:b0:482:c669:46eb with SMTP id
 y17-20020a05663824d100b00482c66946ebmr289759jat.1.1713020704680; Sat, 13 Apr
 2024 08:05:04 -0700 (PDT)
Date: Sat, 13 Apr 2024 08:05:04 -0700
In-Reply-To: <tencent_9625BABA15BB89336B9E491B6A4BA61B2808@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000987b7e0615fbb6ee@google.com>
Subject: Re: [syzbot] [gfs2?] KASAN: slab-use-after-free Read in gfs2_invalidate_folio
From: syzbot <syzbot+3a36aeabd31497d63f6e@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in gfs2_invalidate_folio

 </TASK>
bh: ffff88802f874110, bd: ffff88802f874150, trans_drain
bh: ffff88802ffb5d98, bd: ffff88802f874150, gfs2_discard
==================================================================
BUG: KASAN: slab-use-after-free in list_empty include/linux/list.h:373 [inline]
BUG: KASAN: slab-use-after-free in gfs2_discard fs/gfs2/aops.c:618 [inline]
BUG: KASAN: slab-use-after-free in gfs2_invalidate_folio+0x731/0x840 fs/gfs2/aops.c:656
Read of size 8 at addr ffff88802f874168 by task syz-executor.0/5414

CPU: 3 PID: 5414 Comm: syz-executor.0 Not tainted 6.9.0-rc3-syzkaller-00073-ge8c39d0f57f3-dirty #0
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
RIP: 0033:0x7f0c14c7f197
Code: b0 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 b0 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffd638aaec8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f0c14c7f197
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffd638aaf80
RBP: 00007ffd638aaf80 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffd638ac040
R13: 00007f0c14cc93b9 R14: 000000000001278e R15: 0000000000000001
 </TASK>

Allocated by task 5414:
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

Freed by task 5414:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:240 [inline]
 __kasan_slab_free+0x11d/0x1a0 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2106 [inline]
 slab_free mm/slub.c:4280 [inline]
 kmem_cache_free+0x12e/0x380 mm/slub.c:4344
 trans_drain fs/gfs2/log.c:1032 [inline]
 gfs2_log_flush+0x14b8/0x29e0 fs/gfs2/log.c:1171
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

The buggy address belongs to the object at ffff88802f874150
 which belongs to the cache gfs2_bufdata of size 80
The buggy address is located 24 bytes inside of
 freed 80-byte region [ffff88802f874150, ffff88802f8741a0)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2f874
flags: 0xfff80000000800(slab|node=0|zone=1|lastcpupid=0xfff)
page_type: 0xffffffff()
raw: 00fff80000000800 ffff8880192d0a00 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080240024 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112c40(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY|__GFP_HARDWALL), pid 5414, tgid 5414 (syz-executor.0), ts 76465317912, free_ts 71995243169
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
page last free pid 5364 tgid 5364 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1141 [inline]
 free_unref_page_prepare+0x527/0xb10 mm/page_alloc.c:2347
 free_unref_page+0x33/0x3c0 mm/page_alloc.c:2487
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4e/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x192/0x1e0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3798 [inline]
 slab_alloc_node mm/slub.c:3845 [inline]
 __do_kmalloc_node mm/slub.c:3965 [inline]
 __kmalloc+0x1bd/0x440 mm/slub.c:3979
 kmalloc include/linux/slab.h:632 [inline]
 load_elf_phdrs+0x103/0x210 fs/binfmt_elf.c:526
 load_elf_binary+0x1fe/0x4e10 fs/binfmt_elf.c:855
 search_binary_handler fs/exec.c:1778 [inline]
 exec_binprm fs/exec.c:1820 [inline]
 bprm_execve fs/exec.c:1872 [inline]
 bprm_execve+0x703/0x19b0 fs/exec.c:1848
 do_execveat_common.isra.0+0x5cb/0x750 fs/exec.c:1979
 do_execve fs/exec.c:2053 [inline]
 __do_sys_execve fs/exec.c:2129 [inline]
 __se_sys_execve fs/exec.c:2124 [inline]
 __x64_sys_execve+0x8c/0xb0 fs/exec.c:2124
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88802f874000: fa fb fb fb fb fb fb fb fb fb fc fc fc fc fa fb
 ffff88802f874080: fb fb fb fb fb fb fb fb fc fc fc fc fa fb fb fb
>ffff88802f874100: fb fb fb fb fb fb fc fc fc fc fa fb fb fb fb fb
                                                          ^
 ffff88802f874180: fb fb fb fb fc fc fc fc fa fb fb fb fb fb fb fb
 ffff88802f874200: fb fb fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         e8c39d0f Merge tag 'probes-fixes-v6.9-rc3' of git://gi..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=127ab493180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=285be8dd6baeb438
dashboard link: https://syzkaller.appspot.com/bug?extid=3a36aeabd31497d63f6e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1073ac7d180000


