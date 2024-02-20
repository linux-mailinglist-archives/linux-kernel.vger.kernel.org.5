Return-Path: <linux-kernel+bounces-72242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 527BC85B115
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CBD21C212E0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE94151033;
	Tue, 20 Feb 2024 03:05:08 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D44482C8
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 03:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708398308; cv=none; b=Az8ci5gf95YB75ajy/OOrggVKEVfcLwdZXZXZ9KVRzRUw/dIdHb46T8U7OjayUzUXi/aoPCyPEaeyxTlyyOnnpUEb+rNlI2QSvr88+Bth7zKVd1wckSMm95DtVPw+Yg0iIjeSF32SHb7v1u63U27mcfcA50bbwf4hRx3RZOrqc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708398308; c=relaxed/simple;
	bh=otP/z4vqGd9MF21P1rofwqvlaYtd2JX6/yfLvFt23zw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pdcNBnkfQiR3ctq/gI17sZDaKKkH+lZdTZT1sSAtGJeorCPn+c1ugDX9+I4cpS9wPakp1Z4tSe1mOkwBzCa4UArki5gi2sDxkLRSj4em3TBCABvZSA5bmcliu/WxbZpIf1jz6mypMoc3Aahd7t4/N8qEtR7yuR9U0PkUb5VpyeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c414467bc2so422787139f.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 19:05:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708398306; x=1709003106;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CL6V1V6OYxBcznfQ2MY8gKZwdi7G15Kucj26wfcg0wc=;
        b=oVyFwO4mvCXmzR4LXRWHS+9dL1oKC4YLPzNvaiudjydSHEREgpoG8wa8FP/zgXgY7H
         vY/dj5sUv9ocRg45GzN06JlP/798zQLPZL3zyn/QRqUW574LUbLHwAetXkv+f80QR6ZT
         Gp/MMY39stqiDU0WWlkE3Nqj/odNXHC9NC4HYx8FybE95YVL6iTJNTgr3mKXNmsLU61V
         2cRPVIf7vdVxJIFEOjG11evCOC5HZRNGudPDLvYhiVupaW5XsIofWJcSC8dEBYD4JXdZ
         48weRx4pJrQ2b73HEDWhVPHzueEdJc+vSdUBQQBZ9oWSpR3HxhZNAThO/3R1jnUHh3T4
         xG/g==
X-Forwarded-Encrypted: i=1; AJvYcCUbBUBXzMz8m2EaTn3iLNJGgfq/pQUp3Os4vz3rPTfwMakNtCvX2W8YsTWdYr9xqZqf1djFkgnrhvE/seW9Z476qzfW/H+IDwOlebU3
X-Gm-Message-State: AOJu0Yy52waNfuYUgd9w6mbMKqANvkHEgEcbRA98LtWv90ETeSQS1lxT
	rRu3LVsdxsUP12+a5gyZ2QCtSkfD1f8CHOU40OKCfCS2DGAqnMo+y6hSCTHf5mChAdBXWCe5o9S
	wQ5R1KEDsqc3VtAoI3mfwR12SkhzWk3s0XnZK+yG4DUEacADFjPZco1g=
X-Google-Smtp-Source: AGHT+IEHsD1GdxWwUWmI3IEwRGZM2lZlQ1oJTfyGiQBnz4nqsQrUwgBGafqCSw2RhsG1tVaVCb/34v/u8s2c5RcbSvIODBvoaUkH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4114:b0:474:3936:723f with SMTP id
 ay20-20020a056638411400b004743936723fmr10461jab.5.1708398305929; Mon, 19 Feb
 2024 19:05:05 -0800 (PST)
Date: Mon, 19 Feb 2024 19:05:05 -0800
In-Reply-To: <tencent_8712375DDCDDA9995CCFA38DF325920DFF07@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000028ef720611c77a54@google.com>
Subject: Re: [syzbot] [jfs?] KASAN: slab-use-after-free Read in jfs_syncpt
From: syzbot <syzbot+c244f4a09ca85dd2ebc1@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in jfs_lazycommit

==================================================================
BUG: KASAN: slab-use-after-free in jfs_lazycommit+0xa54/0xb60 fs/jfs/jfs_txnmgr.c:2741
Read of size 4 at addr ffff888043198894 by task jfsCommit/132

CPU: 2 PID: 132 Comm: jfsCommit Not tainted 6.8.0-rc5-syzkaller-gb401b621758e-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:488
 kasan_report+0xda/0x110 mm/kasan/report.c:601
 jfs_lazycommit+0xa54/0xb60 fs/jfs/jfs_txnmgr.c:2741
 kthread+0x2c6/0x3b0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:242
 </TASK>

Allocated by task 5671:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:372 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:389
 kmalloc include/linux/slab.h:590 [inline]
 kzalloc include/linux/slab.h:711 [inline]
 jfs_fill_super+0xe5/0xd40 fs/jfs/super.c:495
 mount_bdev+0x1e3/0x2d0 fs/super.c:1663
 legacy_get_tree+0x109/0x220 fs/fs_context.c:662
 vfs_get_tree+0x8f/0x380 fs/super.c:1784
 do_new_mount fs/namespace.c:3352 [inline]
 path_mount+0x14ea/0x1f20 fs/namespace.c:3679
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount fs/namespace.c:3875 [inline]
 __x64_sys_mount+0x297/0x320 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd5/0x270 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6f/0x77

Freed by task 5422:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3f/0x60 mm/kasan/generic.c:640
 poison_slab_object mm/kasan/common.c:241 [inline]
 __kasan_slab_free+0x121/0x1c0 mm/kasan/common.c:257
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2121 [inline]
 slab_free mm/slub.c:4299 [inline]
 kfree+0x124/0x370 mm/slub.c:4409
 generic_shutdown_super+0x159/0x3d0 fs/super.c:646
 kill_block_super+0x3b/0x90 fs/super.c:1680
 deactivate_locked_super+0xbe/0x1a0 fs/super.c:477
 deactivate_super+0xde/0x100 fs/super.c:510
 cleanup_mnt+0x222/0x450 fs/namespace.c:1267
 task_work_run+0x14f/0x250 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:108 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:201 [inline]
 syscall_exit_to_user_mode+0x281/0x2b0 kernel/entry/common.c:212
 do_syscall_64+0xe5/0x270 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x6f/0x77

The buggy address belongs to the object at ffff888043198800
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 148 bytes inside of
 freed 512-byte region [ffff888043198800, ffff888043198a00)

The buggy address belongs to the physical page:
page:ffffea00010c6600 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x43198
head:ffffea00010c6600 order:2 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888014c42c80 dead000000000100 dead000000000122
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 5416, tgid 5416 (syz-executor.2), ts 82216613876, free_ts 60094503130
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2d4/0x350 mm/page_alloc.c:1533
 prep_new_page mm/page_alloc.c:1540 [inline]
 get_page_from_freelist+0xa28/0x3780 mm/page_alloc.c:3311
 __alloc_pages+0x22f/0x2440 mm/page_alloc.c:4567
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page mm/slub.c:2190 [inline]
 allocate_slab mm/slub.c:2354 [inline]
 new_slab+0xcc/0x3a0 mm/slub.c:2407
 ___slab_alloc+0x4af/0x19a0 mm/slub.c:3540
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3625
 __slab_alloc_node mm/slub.c:3678 [inline]
 slab_alloc_node mm/slub.c:3850 [inline]
 __do_kmalloc_node mm/slub.c:3980 [inline]
 __kmalloc+0x3b8/0x440 mm/slub.c:3994
 kmalloc include/linux/slab.h:594 [inline]
 kzalloc include/linux/slab.h:711 [inline]
 fib6_info_alloc+0x40/0x100 net/ipv6/ip6_fib.c:155
 ip6_route_info_create+0x337/0x1b70 net/ipv6/route.c:3749
 ip6_route_add+0x26/0x150 net/ipv6/route.c:3843
 addrconf_add_mroute+0x1de/0x350 net/ipv6/addrconf.c:2501
 addrconf_add_dev+0x14e/0x1c0 net/ipv6/addrconf.c:2519
 inet6_addr_add+0x1a8/0xbe0 net/ipv6/addrconf.c:2965
 inet6_rtm_newaddr+0x11de/0x1ab0 net/ipv6/addrconf.c:4976
 rtnetlink_rcv_msg+0x3c7/0xe10 net/core/rtnetlink.c:6618
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2543
page last free pid 5173 tgid 5168 stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1140 [inline]
 free_unref_page_prepare+0x527/0xb10 mm/page_alloc.c:2346
 free_unref_page+0x33/0x3c0 mm/page_alloc.c:2486
 release_pages+0x51f/0x14f0 mm/swap.c:1008
 tlb_batch_pages_flush+0x9a/0x190 mm/mmu_gather.c:98
 tlb_flush_mmu_free mm/mmu_gather.c:293 [inline]
 tlb_flush_mmu mm/mmu_gather.c:300 [inline]
 tlb_finish_mmu+0x14b/0x700 mm/mmu_gather.c:392
 exit_mmap+0x3da/0xb50 mm/mmap.c:3292
 __mmput+0x12a/0x4d0 kernel/fork.c:1343
 mmput+0x62/0x70 kernel/fork.c:1365
 exit_mm kernel/exit.c:569 [inline]
 do_exit+0x9a5/0x2ad0 kernel/exit.c:858
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1020
 get_signal+0x23b9/0x2790 kernel/signal.c:2893
 arch_do_signal_or_restart+0x90/0x7f0 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:105 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:201 [inline]
 syscall_exit_to_user_mode+0x156/0x2b0 kernel/entry/common.c:212
 do_syscall_64+0xe5/0x270 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x6f/0x77

Memory state around the buggy address:
 ffff888043198780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888043198800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888043198880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff888043198900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888043198980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


Tested on:

commit:         b401b621 Linux 6.8-rc5
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=16850158180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c6a2287897dfeb9a
dashboard link: https://syzkaller.appspot.com/bug?extid=c244f4a09ca85dd2ebc1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1699e1d0180000


