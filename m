Return-Path: <linux-kernel+bounces-114715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 337318891B8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D68A0293A0C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259F61966B6;
	Mon, 25 Mar 2024 00:34:09 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E61262565
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 23:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322906; cv=none; b=bITwlkOfGyKAjAUsZnZaHdmEsrzeuyHktfr9Q+D6harWjmX7yQoML+UTZyIrUHt0YAvqPl8QtJKai6Sn/+wBMfKu8VBruF+MDXzjGaAfZ4Mq8HBDgibvR2aAW/Yxdey0Ygf+9ADh3+tUNMdpTm21qmXhsctkKWv1RF9/+HXDgwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322906; c=relaxed/simple;
	bh=L3rirMAkG+wCxoaMqp9OoT3/KuPdSW8Pl4TcWXAuCHM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=c+euoaNcV9bG1bkbfG72g1ppGbapn/KgfisnAOXSLxEJR1e4gFtlbMSBQM+ikJDFf8mUKUdVAlfmgiK08ccEaj5DfC0ETDAyQrwa4U4MUJHsXVGAv/6h00gh6t6N4fhBcaXSG1P6N4e9G/oApm4Dfp/2EDM9cqqTeA6wwcHfH+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cbf1aea97fso406056239f.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 16:28:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711322903; x=1711927703;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3dYLu89uYfcbH8akytOwMScgCy7EygCEYMlMe5+0wXI=;
        b=rtPfiIt6IGqdCfmv38pnbMUzK5D1DArTScSJpdFjHDB0PofTjjlZWWf1Gv6gZdwb+d
         cMWwOVsPAtV8jjZP5y1oAdv9x8ayQ90iyVVW4w6iggtFb1S9sgiRoEtkJOIa7V2ox4bY
         vNLL3SQsRp6TLR9cycrsKjCMRj+STDWz2G4rGhO4f+HKTkn+YO5iEtMahNw+QTQJirek
         jPJukPAiEs/oo3dKc5NXy8y61AIPg6wivYtRslVMiHLOSmb2CkkgE6hwWfkPKzCekuHx
         OMMZq3JPU+2G9BgbdFKtmS9/+Y+YoxoWxUBBJHLZuSkTevOklHbh9H8X+3HvabNQ+Sp7
         QioQ==
X-Forwarded-Encrypted: i=1; AJvYcCWruAMuFckn27JVW9+Oy9fA8iVFxBZ99CNjtwv3SwElrb9eQCrfc3pT4/DLgGsCuC3ERfDTdd7GjJSjQIq174N91sI2YqkSjihZ5UBC
X-Gm-Message-State: AOJu0Yxpp3WPHIG8VnK13Mg+MMnCDyIwuDwmKnEL5untlKvxqIRAjk7r
	AGAJZvdfwAEOxOVBQdmybWap07bPjQvUkoLx4hmdbgsQhIbl6n0H3kBSsP3h8969u+C/2leqpWK
	zKMtf0U13Wy8Sa48P7wldra60Uw3Ca/LEairBwDdLoKQ6Wu40/HO/L6c=
X-Google-Smtp-Source: AGHT+IEMNq3/hgbAitmgosqeoB7PUYL2LJNbZHc2Jp0Xa0WQv8T5RbbXY7PIbp7hy25x+9Zwk83kbug7/vxhKcNHID2nQ82/1sFs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3725:b0:47b:f666:f7ab with SMTP id
 k37-20020a056638372500b0047bf666f7abmr371592jav.6.1711322902885; Sun, 24 Mar
 2024 16:28:22 -0700 (PDT)
Date: Sun, 24 Mar 2024 16:28:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b906b406147069d4@google.com>
Subject: [syzbot] [bpf?] [trace?] KASAN: slab-use-after-free Read in bpf_trace_run1
From: syzbot <syzbot+981935d9485a560bfbcb@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	martin.lau@linux.dev, mathieu.desnoyers@efficios.com, mhiramat@kernel.org, 
	netdev@vger.kernel.org, rostedt@goodmis.org, sdf@google.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    520fad2e3206 selftests/bpf: scale benchmark counting by us..
git tree:       bpf-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=105af946180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=981935d9485a560bfbcb
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=114f17a5180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=162bb7a5180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4eef3506c5ce/disk-520fad2e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/24d60ebe76cc/vmlinux-520fad2e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8f883e706550/bzImage-520fad2e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+981935d9485a560bfbcb@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __bpf_trace_run kernel/trace/bpf_trace.c:2376 [inline]
BUG: KASAN: slab-use-after-free in bpf_trace_run1+0xcb/0x510 kernel/trace/bpf_trace.c:2430
Read of size 8 at addr ffff8880290d9918 by task migration/0/19

CPU: 0 PID: 19 Comm: migration/0 Not tainted 6.8.0-syzkaller-05233-g520fad2e3206 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Stopper: 0x0 <- 0x0
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 __bpf_trace_run kernel/trace/bpf_trace.c:2376 [inline]
 bpf_trace_run1+0xcb/0x510 kernel/trace/bpf_trace.c:2430
 __traceiter_rcu_utilization+0x74/0xb0 include/trace/events/rcu.h:27
 trace_rcu_utilization+0x194/0x1c0 include/trace/events/rcu.h:27
 rcu_note_context_switch+0xc7c/0xff0 kernel/rcu/tree_plugin.h:360
 __schedule+0x345/0x4a20 kernel/sched/core.c:6635
 __schedule_loop kernel/sched/core.c:6813 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6828
 smpboot_thread_fn+0x61e/0xa30 kernel/smpboot.c:160
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 </TASK>

Allocated by task 5075:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 kmalloc_trace+0x1d9/0x360 mm/slub.c:4012
 kmalloc include/linux/slab.h:590 [inline]
 kzalloc include/linux/slab.h:711 [inline]
 bpf_raw_tp_link_attach+0x2a0/0x6e0 kernel/bpf/syscall.c:3816
 bpf_raw_tracepoint_open+0x1c2/0x240 kernel/bpf/syscall.c:3863
 __sys_bpf+0x3c0/0x810 kernel/bpf/syscall.c:5673
 __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5736
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

Freed by task 5075:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:589
 poison_slab_object+0xa6/0xe0 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2121 [inline]
 slab_free mm/slub.c:4299 [inline]
 kfree+0x14a/0x380 mm/slub.c:4409
 bpf_link_release+0x3b/0x50 kernel/bpf/syscall.c:3071
 __fput+0x429/0x8a0 fs/file_table.c:423
 task_work_run+0x24f/0x310 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa1b/0x27e0 kernel/exit.c:878
 do_group_exit+0x207/0x2c0 kernel/exit.c:1027
 __do_sys_exit_group kernel/exit.c:1038 [inline]
 __se_sys_exit_group kernel/exit.c:1036 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1036
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

The buggy address belongs to the object at ffff8880290d9900
 which belongs to the cache kmalloc-128 of size 128
The buggy address is located 24 bytes inside of
 freed 128-byte region [ffff8880290d9900, ffff8880290d9980)

The buggy address belongs to the physical page:
page:ffffea0000a43640 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x290d9
anon flags: 0xfff00000000800(slab|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000800 ffff888014c418c0 0000000000000000 0000000000000001
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 4527, tgid 4527 (udevd), ts 43150902736, free_ts 43094996342
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1533
 prep_new_page mm/page_alloc.c:1540 [inline]
 get_page_from_freelist+0x33ea/0x3580 mm/page_alloc.c:3311
 __alloc_pages+0x256/0x680 mm/page_alloc.c:4569
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page+0x5f/0x160 mm/slub.c:2190
 allocate_slab mm/slub.c:2354 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2407
 ___slab_alloc+0xd1b/0x13e0 mm/slub.c:3540
 __slab_alloc mm/slub.c:3625 [inline]
 __slab_alloc_node mm/slub.c:3678 [inline]
 slab_alloc_node mm/slub.c:3850 [inline]
 kmalloc_trace+0x267/0x360 mm/slub.c:4007
 kmalloc include/linux/slab.h:590 [inline]
 kzalloc include/linux/slab.h:711 [inline]
 kernfs_get_open_node fs/kernfs/file.c:523 [inline]
 kernfs_fop_open+0x803/0xcd0 fs/kernfs/file.c:691
 do_dentry_open+0x907/0x15a0 fs/open.c:956
 do_open fs/namei.c:3643 [inline]
 path_openat+0x2860/0x3240 fs/namei.c:3800
 do_filp_open+0x235/0x490 fs/namei.c:3827
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1407
 do_sys_open fs/open.c:1422 [inline]
 __do_sys_openat fs/open.c:1438 [inline]
 __se_sys_openat fs/open.c:1433 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1433
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
page last free pid 4526 tgid 4526 stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1140 [inline]
 free_unref_page_prepare+0x968/0xa90 mm/page_alloc.c:2346
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2486
 rcu_do_batch kernel/rcu/tree.c:2196 [inline]
 rcu_core+0xafd/0x1830 kernel/rcu/tree.c:2471
 __do_softirq+0x2bc/0x943 kernel/softirq.c:554

Memory state around the buggy address:
 ffff8880290d9800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880290d9880: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8880290d9900: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff8880290d9980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880290d9a00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

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

