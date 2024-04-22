Return-Path: <linux-kernel+bounces-152802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 761F98AC476
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E962B21382
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 06:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A506482F6;
	Mon, 22 Apr 2024 06:47:32 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6760481AB
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 06:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713768451; cv=none; b=OqEkoXIAPCDw0eKim2yMBbb+CwIo/sXZTf/2bFS+rRPYwIxitlJnrkfebXidewGD7fRWSlt56SSf55aRkbwKsgOBaXI1ZXz/DfiW1p3NGCaoaikFfUbzOpuH0sBJ8hJDPslfPhQISwQ/LqZkKEdolMG1uKuw0wnXqZ1TmdI7/UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713768451; c=relaxed/simple;
	bh=jn0M3c9MA560ThkHKSB6M7ayaMVw8hhaVifBATme3CQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KopE8w5dSc+CkfsJvlygkXosuyRJ83CxvTxDOLWjgf9M8kjETg0ppLhKzhZ4DP4OJIrpAbs2L5q+pN4EJVI1hzymneNyK1WO7sdgq1DF6GDyfIS3f0Z+D1i8RYdNQPis7gC1jtUKKBbXZ7x/ykYkqHKnYwy1OE2IpUh3RCX+PNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7dc40011f18so624839f.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 23:47:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713768449; x=1714373249;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sd5A0PbIgmmWu1aP2p5ReHy453hqB8lCSuxgdLrl/1Y=;
        b=EFQwsUzSWhYm9B0j7V+mzZbug8N1/3vxJVjPlokwc0hkRWX2WKlWdwSBbEbcfXZlgZ
         i2so0LF3nKPkQMyTmRDXWTmDCP+aZp8Vml2D9W5z/mHGJ+VGKREIHE0HWauDXgiRKsgV
         /j1L1fVlCUsPQJRZu/VwSgGuselUhmvrwoXlnxVCNvvzt8JPG+B9mCsgkhXXja2tHMix
         2qkD32SqxnYn8UJfDI6dSooL1P85rCIRzwj0zfjaZFNpF30NamfEDKmVkq0aWmNcXgtY
         xTMlTQ97urk7W0P68kHXxapkc9Bn/y+2L4ddbbnHDudrwPSXok3zj8bmy6z/puw1ZF78
         yBNA==
X-Forwarded-Encrypted: i=1; AJvYcCVk3gUe6NEhOJMqqLLTKFrUhlgfsbvauBo4CtxkRDDaoU4RfpC3ihqRK1jhVoJ4/YG17jUMm7v3F6gvph/KSehjuYz6Ar/bPY0KeSHv
X-Gm-Message-State: AOJu0YwkYawvLLi4Jb1KLLZsMfe4NPezvDw2YKXlypjP39chOxcCeLiy
	iCwGMPTKQy6XcsIjDQsH9oZfYiJL3sBRFePDgTC6CoTyly3V5BuR38MEh7uuBI2tpBf+eQ1RVOC
	ylIbUSwHsaecRMKFgrdy0ARPTy3pbMBdI5miGion7oxk4Z5DSAUlMLEA=
X-Google-Smtp-Source: AGHT+IERoLcMgz7H9B5Q6rGQivMdVDiRIu2hEvML4rcOxA+RMM/eti6rXudFo0pqAMu4IbRz9RBwxvWjRa+uNnQ4Mxp0JB74Ft5H
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:6f02:b0:484:802a:a787 with SMTP id
 hp2-20020a0566386f0200b00484802aa787mr178467jab.3.1713768449143; Sun, 21 Apr
 2024 23:47:29 -0700 (PDT)
Date: Sun, 21 Apr 2024 23:47:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a380400616a9cfa2@google.com>
Subject: [syzbot] [bluetooth?] KASAN: invalid-free in hci_req_sync_complete
From: syzbot <syzbot+35ebc808442df6420eae@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    dbe0a7be2838 Merge tag 'thermal-6.9-rc5' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1797a520980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c5d33c579b4e833f
dashboard link: https://syzkaller.appspot.com/bug?extid=35ebc808442df6420eae
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/533abb2e04bb/disk-dbe0a7be.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bab25bf1664b/vmlinux-dbe0a7be.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a86e1d3d98aa/bzImage-dbe0a7be.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+35ebc808442df6420eae@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: double-free in kfree_skbmem+0x10e/0x200 net/core/skbuff.c:1159
Free of addr ffff8880114bcdc0 by task kworker/u9:0/52

CPU: 1 PID: 52 Comm: kworker/u9:0 Not tainted 6.9.0-rc4-syzkaller-00164-gdbe0a7be2838 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue: hci4 hci_rx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report_invalid_free+0xaa/0xd0 mm/kasan/report.c:563
 poison_slab_object mm/kasan/common.c:232 [inline]
 __kasan_slab_free+0x16b/0x1a0 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2106 [inline]
 slab_free mm/slub.c:4280 [inline]
 kmem_cache_free+0x12e/0x380 mm/slub.c:4344
 kfree_skbmem+0x10e/0x200 net/core/skbuff.c:1159
 __kfree_skb net/core/skbuff.c:1217 [inline]
 kfree_skb_reason+0x13a/0x210 net/core/skbuff.c:1252
 kfree_skb include/linux/skbuff.h:1262 [inline]
 hci_req_sync_complete+0x16c/0x270 net/bluetooth/hci_request.c:109
 hci_event_packet+0x966/0x1170 net/bluetooth/hci_event.c:7604
 hci_rx_work+0x2c4/0x1610 net/bluetooth/hci_core.c:4171
 process_one_work+0x9ac/0x1ac0 kernel/workqueue.c:3254
 process_scheduled_works kernel/workqueue.c:3335 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3416
 kthread+0x2c4/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 52:
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
 hci_cmd_work+0x66a/0x710 net/bluetooth/hci_core.c:4240
 process_one_work+0x9ac/0x1ac0 kernel/workqueue.c:3254
 process_scheduled_works kernel/workqueue.c:3335 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3416
 kthread+0x2c4/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 10076:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:240 [inline]
 __kasan_slab_free+0x11d/0x1a0 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2106 [inline]
 slab_free mm/slub.c:4280 [inline]
 kmem_cache_free+0x12e/0x380 mm/slub.c:4344
 kfree_skbmem+0x10e/0x200 net/core/skbuff.c:1159
 __kfree_skb net/core/skbuff.c:1217 [inline]
 kfree_skb_reason+0x13a/0x210 net/core/skbuff.c:1252
 kfree_skb include/linux/skbuff.h:1262 [inline]
 __hci_req_sync+0x61d/0x980 net/bluetooth/hci_request.c:184
 hci_req_sync+0x97/0xd0 net/bluetooth/hci_request.c:206
 hci_dev_cmd+0x653/0x9c0 net/bluetooth/hci_core.c:790
 hci_sock_ioctl+0x4f3/0x8e0 net/bluetooth/hci_sock.c:1153
 sock_do_ioctl+0x119/0x280 net/socket.c:1222
 sock_ioctl+0x22e/0x6c0 net/socket.c:1341
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:904 [inline]
 __se_sys_ioctl fs/ioctl.c:890 [inline]
 __x64_sys_ioctl+0x196/0x220 fs/ioctl.c:890
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff8880114bcdc0
 which belongs to the cache skbuff_head_cache of size 240
The buggy address is located 0 bytes inside of
 240-byte region [ffff8880114bcdc0, ffff8880114bceb0)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x114bc
flags: 0xfff80000000800(slab|node=0|zone=1|lastcpupid=0xfff)
page_type: 0xffffffff()
raw: 00fff80000000800 ffff888018ad6780 ffffea000183fd00 dead000000000002
raw: 0000000000000000 00000000800c000c 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY), pid 4748, tgid 666454001 (dhcpcd), ts 4748, free_ts 597626032748
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
 kmem_cache_alloc_node+0x10a/0x340 mm/slub.c:3888
 __alloc_skb+0x2b1/0x380 net/core/skbuff.c:658
 alloc_skb include/linux/skbuff.h:1313 [inline]
 alloc_skb_with_frags+0xe4/0x710 net/core/skbuff.c:6504
 sock_alloc_send_pskb+0x7f1/0x980 net/core/sock.c:2795
 unix_dgram_sendmsg+0x4b9/0x1b10 net/unix/af_unix.c:2019
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 sock_write_iter+0x50d/0x5c0 net/socket.c:1160
 call_write_iter include/linux/fs.h:2110 [inline]
 do_iter_readv_writev+0x507/0x780 fs/read_write.c:741
 vfs_writev+0x36f/0xdb0 fs/read_write.c:971
 do_writev+0x287/0x370 fs/read_write.c:1018
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
page last free pid 8963 tgid 8961 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1141 [inline]
 free_unref_page_prepare+0x527/0xb10 mm/page_alloc.c:2347
 free_unref_page+0x33/0x3c0 mm/page_alloc.c:2487
 tlb_batch_list_free mm/mmu_gather.c:159 [inline]
 tlb_finish_mmu+0x237/0x7b0 mm/mmu_gather.c:468
 exit_mmap+0x3da/0xb90 mm/mmap.c:3280
 __mmput+0x12a/0x4d0 kernel/fork.c:1346
 mmput+0x62/0x70 kernel/fork.c:1368
 exit_mm kernel/exit.c:569 [inline]
 do_exit+0x999/0x2c10 kernel/exit.c:865
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1027
 get_signal+0x2616/0x2710 kernel/signal.c:2911
 arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x14a/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xdc/0x260 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff8880114bcc80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff8880114bcd00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fc fc
>ffff8880114bcd80: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
                                           ^
 ffff8880114bce00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880114bce80: fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc
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

