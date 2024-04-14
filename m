Return-Path: <linux-kernel+bounces-143936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 484738A3FE0
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 04:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31E5C1C20AF2
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 02:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C278A12E6D;
	Sun, 14 Apr 2024 02:04:08 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289B12901
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 02:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713060247; cv=none; b=F3WVF9MV8c8xLqKLL1X300thmpXtpXusXmav7kTqIAsGnaAoIN447h7VlhMTYUIh7S2t9WydnEPZ2WYSWpwd0M2THiqalE4VD7enp+DhuQAEmlAOv9uSWUaKKK8XUUtBKMfgVGn9Zj6vu9syjwC+xi3yAMRqV5kwwEDJyyJ9nuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713060247; c=relaxed/simple;
	bh=79t1iIXwYDILZkqVHeU5uVeBpBahelNMzbAmsZ7rAEQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=brx/4+VaaOs9155BFmM9nAMI96Qp0qkZIKlPOy3DC92157UGVgzF+n/JUbOjxhR+v/6Yr6kvNxmsfRB8flBKRrrPRkuBVpD+Lv3UGDTdmn4Mhk5vGr/0tTbDxZIao9H+F/wd6J7aWPd0gsK22PqTC6iniK9IwBwilnYBH1clrZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7d5e2b1cfabso219942939f.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 19:04:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713060245; x=1713665045;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4zbb7sgquNhSaF6Zufi4bKsGp5lauvpevp7tE6E9AU=;
        b=bbT5yp+31xt2/CDnpZb7cY8xtNnuvOARioCU5ZNm+6AD9VCY99F1/wY8/y8L2jWBR/
         t8oHsUvs4mTWgwHVPKX7feknYrvn0xuDTT76rgg3z1jiT/Xrgzx+0/J8NxnLv4FDwjcz
         8EdQXgx4wZvoNte0dOAqKQeHGHAYRCgjasBszWmzxJcC4izZzEgLSUbAYcxBQ1ayvtH9
         8zOT27wmCgG3P9uR9eq16AU8hgXgvHOr+hKkRJ5fK2dBpC2ZwLtFg1E4qrrh9fbTOFo1
         iM0dCXwL6+rrQirsk+qsKhJB7h0id/4W1D8t27Z+sBvtfP1tx1s0pInX3nFz3cmfv/rm
         frTA==
X-Forwarded-Encrypted: i=1; AJvYcCUYxsHJmW/wbAeiaIhGRAT2SQzAox3A661mbtY0yJJSZ3DLnEgDIt1KepRpmJ0XKy7WkcHdmaq7Q7/f/ag0fds898bB2mZX0PlnM9aH
X-Gm-Message-State: AOJu0YzpU5bAV70cPBqEtDRpY1Cig3osFr5NW3IBw4jNNKG7YSzKlmrM
	XTL84O8fiJBJVI+kEFcujfCCcaKeWb9e6I6uyn3G2pVM8YqdkAzaZ1Em2GwtSO/FKOLyW/JODKt
	53Oxz73SaT4sQLiyQx1xEFYwJwizffPiRlDxIS2SDJG7pFxwUX+gotfc=
X-Google-Smtp-Source: AGHT+IFmyOewOq/IVoDL9U4dpgiwtXB+2TF0vNQpwQgWgif+J7xKWarUeBhPcYYnt+YP8gYsbt9XnUFc5Yqpd14/vve0thEvdTmH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:412a:b0:482:e7cd:7910 with SMTP id
 ay42-20020a056638412a00b00482e7cd7910mr217821jab.3.1713060245349; Sat, 13 Apr
 2024 19:04:05 -0700 (PDT)
Date: Sat, 13 Apr 2024 19:04:05 -0700
In-Reply-To: <tencent_5D519E8D1BA04BB71B792555BAB6BBB73308@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000673a85061604ebbe@google.com>
Subject: Re: [syzbot] [gfs2?] KASAN: slab-use-after-free Read in gfs2_invalidate_folio
From: syzbot <syzbot+3a36aeabd31497d63f6e@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: sleeping function called from invalid context in gfs2_trans_add_data

BUG: sleeping function called from invalid context at include/linux/sched/mm.h:315
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 5417, name: syz-executor.0
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
7 locks held by syz-executor.0/5417:
 #0: ffff88802f6340e0 (&type->s_umount_key#67){+.+.}-{3:3}, at: __super_lock fs/super.c:56 [inline]
 #0: ffff88802f6340e0 (&type->s_umount_key#67){+.+.}-{3:3}, at: __super_lock_excl fs/super.c:71 [inline]
 #0: ffff88802f6340e0 (&type->s_umount_key#67){+.+.}-{3:3}, at: deactivate_super+0xd6/0x100 fs/super.c:504
 #1: ffff88803e574b78 (&sdp->sd_quota_sync_mutex){+.+.}-{3:3}, at: gfs2_quota_sync+0x19e/0x630 fs/gfs2/quota.c:1354
 #2: ffff888032be8808 (&gfs2_quota_imutex_key){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:795 [inline]
 #2: ffff888032be8808 (&gfs2_quota_imutex_key){+.+.}-{3:3}, at: do_sync+0x3af/0xd30 fs/gfs2/quota.c:944
 #3: ffff88802f634610 (sb_internal#2){.+.+}-{0:0}, at: gfs2_trans_begin+0x74/0x100 fs/gfs2/trans.c:118
 #4: ffff88803e575060 (&sdp->sd_log_flush_lock){++++}-{3:3}, at: __gfs2_trans_begin+0x533/0xb80 fs/gfs2/trans.c:87
 #5: ffff888032be8ca0 (&ip->i_rw_mutex){++++}-{3:3}, at: gfs2_unstuff_dinode+0x93/0x1460 fs/gfs2/bmap.c:161
 #6: ffff88803e574e88 (&sdp->sd_log_lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #6: ffff88803e574e88 (&sdp->sd_log_lock){+.+.}-{2:2}, at: gfs2_log_lock fs/gfs2/log.h:32 [inline]
 #6: ffff88803e574e88 (&sdp->sd_log_lock){+.+.}-{2:2}, at: gfs2_trans_add_data+0x116/0x710 fs/gfs2/trans.c:203
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 0 PID: 5417 Comm: syz-executor.0 Not tainted 6.9.0-rc3-syzkaller-00073-ge8c39d0f57f3-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:114
 __might_resched+0x3c0/0x5e0 kernel/sched/core.c:10197
 might_alloc include/linux/sched/mm.h:315 [inline]
 might_alloc include/linux/sched/mm.h:310 [inline]
 slab_pre_alloc_hook mm/slub.c:3746 [inline]
 slab_alloc_node mm/slub.c:3827 [inline]
 kmem_cache_alloc+0x281/0x320 mm/slub.c:3852
 kmem_cache_zalloc include/linux/slab.h:739 [inline]
 gfs2_alloc_bufdata fs/gfs2/trans.c:168 [inline]
 gfs2_trans_add_data+0x250/0x710 fs/gfs2/trans.c:206
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
RIP: 0033:0x7f5a5ca7f197
Code: b0 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 b0 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007fff82f87ad8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f5a5ca7f197
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007fff82f87b90
RBP: 00007fff82f87b90 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007fff82f88c50
R13: 00007f5a5cac93b9 R14: 000000000001305f R15: 0000000000000001
 </TASK>
syz-executor.0: attempt to access beyond end of device
loop0: rw=1, sector=131324, nr_sectors = 4 limit=32768
gfs2: fsid=syz:syz.0: Error 10 writing to journal, jid=0
==================================================================
BUG: KASAN: slab-use-after-free in list_empty include/linux/list.h:373 [inline]
BUG: KASAN: slab-use-after-free in gfs2_discard fs/gfs2/aops.c:617 [inline]
BUG: KASAN: slab-use-after-free in gfs2_invalidate_folio+0x718/0x820 fs/gfs2/aops.c:655
Read of size 8 at addr ffff8880274f9168 by task syz-executor.0/5417

CPU: 2 PID: 5417 Comm: syz-executor.0 Tainted: G        W          6.9.0-rc3-syzkaller-00073-ge8c39d0f57f3-dirty #0
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
RIP: 0033:0x7f5a5ca7f197
Code: b0 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 b0 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007fff82f87ad8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f5a5ca7f197
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007fff82f87b90
RBP: 00007fff82f87b90 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007fff82f88c50
R13: 00007f5a5cac93b9 R14: 000000000001305f R15: 0000000000000001
 </TASK>

Allocated by task 5417:
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
 gfs2_trans_add_data+0x250/0x710 fs/gfs2/trans.c:206
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

Freed by task 5417:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:240 [inline]
 __kasan_slab_free+0x11d/0x1a0 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2106 [inline]
 slab_free mm/slub.c:4280 [inline]
 kmem_cache_free+0x12e/0x380 mm/slub.c:4344
 trans_drain fs/gfs2/log.c:1028 [inline]
 gfs2_log_flush+0x1486/0x29b0 fs/gfs2/log.c:1167
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

The buggy address belongs to the object at ffff8880274f9150
 which belongs to the cache gfs2_bufdata of size 80
The buggy address is located 24 bytes inside of
 freed 80-byte region [ffff8880274f9150, ffff8880274f91a0)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x274f9
flags: 0xfff80000000800(slab|node=0|zone=1|lastcpupid=0xfff)
page_type: 0xffffffff()
raw: 00fff80000000800 ffff88801668ba40 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080240024 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112c40(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY|__GFP_HARDWALL), pid 5417, tgid 5417 (syz-executor.0), ts 78780685821, free_ts 78721961391
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
 gfs2_trans_add_meta+0xade/0xf50 fs/gfs2/trans.c:243
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
page last free pid 15 tgid 15 stack trace:
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
 ffff8880274f9000: fa fb fb fb fb fb fb fb fb fb fc fc fc fc fa fb
 ffff8880274f9080: fb fb fb fb fb fb fb fb fc fc fc fc fa fb fb fb
>ffff8880274f9100: fb fb fb fb fb fb fc fc fc fc fa fb fb fb fb fb
                                                          ^
 ffff8880274f9180: fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880274f9200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         e8c39d0f Merge tag 'probes-fixes-v6.9-rc3' of git://gi..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15912add180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=285be8dd6baeb438
dashboard link: https://syzkaller.appspot.com/bug?extid=3a36aeabd31497d63f6e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13bfbfcb180000


