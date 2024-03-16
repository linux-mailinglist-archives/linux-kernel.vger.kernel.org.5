Return-Path: <linux-kernel+bounces-105178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8BF87DA1A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 13:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE5361C20B8D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 12:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E57F1862A;
	Sat, 16 Mar 2024 12:17:26 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C97B18B04
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 12:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710591445; cv=none; b=CIbFYf296ZXmzkkBd94V1i81o5TVrSzZ+HDLnUly32QMBtv5D7tCJCZfra2caEGWxqiQl99DUKW4nGunHz4t/QkP9DDhw8Q6LIq1+YO5cweG8bFZjuRGCOwrImkpAKavR3ifqGvLF3nSuPZZdM61GIvSi5EkDlFIz/gTwvCGLCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710591445; c=relaxed/simple;
	bh=uY4MIVexZPXIGJoJf8dlxpORm1/Ogn9wnfGHlRvNGL8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=u8u+2VDRql174ZEh8aWaKbksSzioLlIu7kibhb/FKYxw06E1VbSMRz4nX2zcRooJmGiJJFeL8DgdnFtk73vPXW0u5FTts+mWD5J9iVuHXuWSlJkyvMVfH3v1qI8Ow0Mxw7PS7suDbb1biKySIKr8NpxcxkJVStPJ+koo6oqqqMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3662e583684so37786585ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 05:17:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710591442; x=1711196242;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c4v0h0nN+FV+M8Sph5srdIPQp+kwJLl3sv0tcpRJTEQ=;
        b=supiRcpQv3pwgy7EHFeKDXNNV2zO3RfheX79Lr0ojjx4sKn3a3jIBSo33eSfrVfAIU
         PXnA1En9N2x320hWn8loYNTcpeE3bAw3Su+T0njqDNb74PiAuZxNof2YK9XGK7MPrxZm
         oX3l5BvKVKNuIn43N8NobBwU1SuiK4HwbBzEHRMrjqqDCU+X/+nEvwJqfxB5X4lcmLyt
         Jng+TtvTb4t3/vHF53fTkLmjH0TnUitKjrxqV8e3VYvZxoV00R64cUme8H0rv4PYDo2N
         zSgJvkK3cQ2yccUO+0xbBlClrdiRHBr9SmjmoaW/wUWFP1reH8iqGjulmrf1px+gX9gf
         8R7g==
X-Forwarded-Encrypted: i=1; AJvYcCUXuXh1+9AZcI0BG+nR0MCl9R1WCGcp5+Ab5jkSnk9g4n88ohvkEAtr9vBUgurTizwE1ThahABSQiNTWanhFy9H8z9gfrcfL0wVjq+N
X-Gm-Message-State: AOJu0Yy4MY8LegAgLlzlMkDO+p5M+xc9MiVDhmr2rTMkoVW9QXZ8OyXg
	pFTjKxoAWEqJo7836xCEbqnWppVnJ6ULXi6oylCA6gKdu1Xrvf2Ar8VXB/8zXFUdglz6txJP0tY
	7ZviN61ims2qEpQoa83kbDpYzaz30+nsqBxj1d0Na/eSpl75I1WY9sLE=
X-Google-Smtp-Source: AGHT+IHD0elaO23rgKwFa+SBmhDIjb39hpxypvA7Ynr/l4KUQCj3RWNBVkQe9t8oy7u2oKaNndgBVsclcVc4F2EKp6UO1jrHW3A0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:180b:b0:366:7471:281c with SMTP id
 a11-20020a056e02180b00b003667471281cmr302991ilv.0.1710591442699; Sat, 16 Mar
 2024 05:17:22 -0700 (PDT)
Date: Sat, 16 Mar 2024 05:17:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004c59360613c61b75@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in hci_cmd_timeout
From: syzbot <syzbot+f8efc266777e73f0567b@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    277100b3d5fe Merge tag 'block-6.9-20240315' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16ca443a180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1c6662240382da2
dashboard link: https://syzkaller.appspot.com/bug?extid=f8efc266777e73f0567b
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-277100b3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6872e049b27c/vmlinux-277100b3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/68ec7230df0f/bzImage-277100b3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f8efc266777e73f0567b@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in hci_cmd_timeout+0x216/0x260 net/bluetooth/hci_core.c:1526
Read of size 2 at addr ffff888025ed4cb8 by task kworker/u33:6/5234

CPU: 0 PID: 5234 Comm: kworker/u33:6 Not tainted 6.8.0-syzkaller-11063-g277100b3d5fe #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: hci0 hci_cmd_timeout
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 hci_cmd_timeout+0x216/0x260 net/bluetooth/hci_core.c:1526
 process_one_work+0x9a9/0x1a60 kernel/workqueue.c:3254
 process_scheduled_works kernel/workqueue.c:3335 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3416
 kthread+0x2c1/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 </TASK>

Allocated by task 5234:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x89/0x90 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3798 [inline]
 slab_alloc_node mm/slub.c:3845 [inline]
 kmem_cache_alloc+0x136/0x320 mm/slub.c:3852
 skb_clone+0x190/0x3f0 net/core/skbuff.c:2063
 hci_send_cmd_sync net/bluetooth/hci_core.c:4220 [inline]
 hci_cmd_work+0x668/0x710 net/bluetooth/hci_core.c:4240
 process_one_work+0x9a9/0x1a60 kernel/workqueue.c:3254
 process_scheduled_works kernel/workqueue.c:3335 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3416
 kthread+0x2c1/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243

Freed by task 6970:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:240 [inline]
 __kasan_slab_free+0x11d/0x1a0 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2106 [inline]
 slab_free mm/slub.c:4280 [inline]
 kmem_cache_free+0x12e/0x360 mm/slub.c:4344
 kfree_skbmem+0x10e/0x200 net/core/skbuff.c:1159
 __kfree_skb net/core/skbuff.c:1217 [inline]
 kfree_skb_reason+0x13a/0x210 net/core/skbuff.c:1252
 kfree_skb include/linux/skbuff.h:1267 [inline]
 __hci_req_sync+0x61d/0x980 net/bluetooth/hci_request.c:182
 hci_req_sync+0x97/0xd0 net/bluetooth/hci_request.c:204
 hci_inquiry+0x76c/0x9f0 net/bluetooth/hci_core.c:425
 hci_sock_ioctl+0x2bb/0x8e0 net/bluetooth/hci_sock.c:1156
 sock_do_ioctl+0x116/0x280 net/socket.c:1222
 sock_ioctl+0x22e/0x6c0 net/socket.c:1341
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:904 [inline]
 __se_sys_ioctl fs/ioctl.c:890 [inline]
 __x64_sys_ioctl+0x193/0x220 fs/ioctl.c:890
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

The buggy address belongs to the object at ffff888025ed4c80
 which belongs to the cache skbuff_head_cache of size 240
The buggy address is located 56 bytes inside of
 freed 240-byte region [ffff888025ed4c80, ffff888025ed4d70)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x25ed4
head: order:1 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff80000000840(slab|head|node=0|zone=1|lastcpupid=0xfff)
page_type: 0xffffffff()
raw: 00fff80000000840 ffff888015f10780 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000190019 00000001ffffffff 0000000000000000
head: 00fff80000000840 ffff888015f10780 dead000000000100 dead000000000122
head: 0000000000000000 0000000000190019 00000001ffffffff 0000000000000000
head: 00fff80000000001 ffffea000097b501 dead000000000122 00000000ffffffff
head: 0000000200000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0x152820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL), pid 6786, tgid 6784 (syz-executor.1), ts 141987010741, free_ts 141135100425
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x2d4/0x350 mm/page_alloc.c:1534
 prep_new_page mm/page_alloc.c:1541 [inline]
 get_page_from_freelist+0xa28/0x3780 mm/page_alloc.c:3317
 __alloc_pages+0x22b/0x23f0 mm/page_alloc.c:4575
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page mm/slub.c:2175 [inline]
 allocate_slab mm/slub.c:2338 [inline]
 new_slab+0xcc/0x3a0 mm/slub.c:2391
 ___slab_alloc+0x66d/0x1790 mm/slub.c:3525
 __kmem_cache_alloc_bulk mm/slub.c:4555 [inline]
 kmem_cache_alloc_bulk+0x27c/0x940 mm/slub.c:4629
 xdp_recv_frames net/bpf/test_run.c:258 [inline]
 xdp_test_run_batch net/bpf/test_run.c:356 [inline]
 bpf_test_run_xdp_live+0x118b/0x1af0 net/bpf/test_run.c:384
 bpf_prog_test_run_xdp+0x82d/0x1530 net/bpf/test_run.c:1267
 bpf_prog_test_run kernel/bpf/syscall.c:4240 [inline]
 __sys_bpf+0xd56/0x4b40 kernel/bpf/syscall.c:5649
 __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
 __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd2/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
page last free pid 4688 tgid 4688 stack trace:
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
 __do_softirq+0x218/0x8de kernel/softirq.c:554

Memory state around the buggy address:
 ffff888025ed4b80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888025ed4c00: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
>ffff888025ed4c80: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                        ^
 ffff888025ed4d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc
 ffff888025ed4d80: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
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

