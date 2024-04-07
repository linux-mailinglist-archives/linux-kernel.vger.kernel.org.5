Return-Path: <linux-kernel+bounces-134518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1DE89B26D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 16:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDE8A1C20F7B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 14:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C1238385;
	Sun,  7 Apr 2024 14:10:29 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95888374F1
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 14:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712499028; cv=none; b=hUYlEUw7P8/HskE/JWOCSasNRWt7e0OGQj5W9TJ9q8YMbFxCQFD81ndMqoUitcRZ+F82rVhUsMLuO3uiyscyJ9UDg1gEBmIglQ2t5cjkPCrbkEsKnxuX2E3GcnzDV2WR/F58+5f8wbJga09rFZCig1YUZwJXEv3pU8+5H27cBmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712499028; c=relaxed/simple;
	bh=Rizh+zpVbcGZFrVE0tE8QJ40fxbjCGwYLjjLtnTo9eE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Slm5DfWKyH+6+lnmvhSJzAVpKV4KXXufYJKQjlh17siK7+rgm4jKdBHanTD4DhNgn11dcxYSeIkQFneni1cMCwGnsTXPF4+Li2EmZhjLxFdTaGjxYIpIju9UbztwOV14Y2QgvkR3ghwitZrWIVJs5tvkBGvuw6FslRXMhKG6u9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cf265b30e2so411409739f.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 07:10:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712499026; x=1713103826;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f1RVKXS4g+qfYzWDmmof/0/Hg4NSuTXFNkuYFyXmwRg=;
        b=T4jJie37U7tHe+CxW0y9+gcZaQyXjcXnBdQ7Spj8S95mdXAddIupiZSeauwbhIB210
         UOap0v6Y4PzBh6nsmGU3Cx5AvcZdtOTunOjo8gjC/nfbUq2kikLRwrBUGuEf+MdBp/R7
         mjAjfMXG1clYURwSkRfYMA+qe49QW4cc5t8NY5SfewTwGUlUKPr162+4uT6HEYwMp3MT
         X7F82Z12fkh4BED+m1sSOYjOHTEdCo+uYz9NWXSRU5qwPO4Gs6gep7CjFdTDzAoroW+m
         gcwLOX8mmiZ3bGZL//XU3AGZdUrHMd/T6JrVtZs9dRrSYLQSmlmBPZlj122pfYLZ4uqt
         6ddA==
X-Forwarded-Encrypted: i=1; AJvYcCVqsPeZ18QEr0nnJ+tnlDxe1bqzjGa7beWlIZYsibiw7yPXyGGanYuHv/8bJlww0oKkpCdKegN1gqzfvhjJ7EVVQhlNQVh6Mo6FGggm
X-Gm-Message-State: AOJu0YyVm6YFZnpXjyy7OXdHjC+Ita4kLk54v3v3P8CxhbE4ZizeHHkn
	vPDe+3b0lw9ypmz1C2gBqlYCc6VuBSC93yoF1lpq4BEkj4WKRgwM4Wd27kXMrEEqpdzTacRx3sk
	INgyaQU4PtF4QCnggulnFvU6nBuwjdN9KVfvO7b0m5zHvOXYCRnA4w+8=
X-Google-Smtp-Source: AGHT+IFhHNFGV8zSTwHh6y+fjoq3YrS/9nrfCL9E7KwmqPQ86AjfEsIas5l78vW245/nhkn43gvDmTE0SNp1wcJJpEdVi85At52D
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2656:b0:47f:bbce:999f with SMTP id
 n22-20020a056638265600b0047fbbce999fmr474214jat.0.1712499025915; Sun, 07 Apr
 2024 07:10:25 -0700 (PDT)
Date: Sun, 07 Apr 2024 07:10:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001e41e20615824081@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in __hci_req_sync
From: syzbot <syzbot+27209997e4015fb4702e@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8568bb2ccc27 Add linux-next specific files for 20240405
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1344efc5180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=48ca5acf8d2eb3bc
dashboard link: https://syzkaller.appspot.com/bug?extid=27209997e4015fb4702e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1d120b5e779c/disk-8568bb2c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a89e3589a585/vmlinux-8568bb2c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/045e657c0e0d/bzImage-8568bb2c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+27209997e4015fb4702e@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: slab-use-after-free in atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
BUG: KASAN: slab-use-after-free in refcount_read include/linux/refcount.h:136 [inline]
BUG: KASAN: slab-use-after-free in skb_unref include/linux/skbuff.h:1227 [inline]
BUG: KASAN: slab-use-after-free in __kfree_skb_reason net/core/skbuff.c:1197 [inline]
BUG: KASAN: slab-use-after-free in kfree_skb_reason+0x41/0x3b0 net/core/skbuff.c:1224
Read of size 4 at addr ffff8880645c9864 by task syz-executor.1/5107

CPU: 1 PID: 5107 Comm: syz-executor.1 Not tainted 6.9.0-rc2-next-20240405-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
 refcount_read include/linux/refcount.h:136 [inline]
 skb_unref include/linux/skbuff.h:1227 [inline]
 __kfree_skb_reason net/core/skbuff.c:1197 [inline]
 kfree_skb_reason+0x41/0x3b0 net/core/skbuff.c:1224
 kfree_skb include/linux/skbuff.h:1262 [inline]
 __hci_req_sync+0x62f/0x950 net/bluetooth/hci_request.c:184
 hci_req_sync+0xa9/0xd0 net/bluetooth/hci_request.c:206
 hci_dev_cmd+0x518/0xa90 net/bluetooth/hci_core.c:797
 sock_do_ioctl+0x158/0x460 net/socket.c:1222
 sock_ioctl+0x629/0x8e0 net/socket.c:1341
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x72/0x7a
RIP: 0033:0x7fd8f7e7dbcb
Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
RSP: 002b:00007ffc3d1858e0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fd8f7e7dbcb
RDX: 00007ffc3d185958 RSI: 00000000400448dd RDI: 0000000000000003
RBP: 00005555747dc430 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000008 R11: 0000000000000246 R12: 0000000000000003
R13: 0000000000000003 R14: 00007fd8f7fac9d8 R15: 000000000000000c
 </TASK>

Allocated by task 5105:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3897 [inline]
 slab_alloc_node mm/slub.c:3957 [inline]
 kmem_cache_alloc_noprof+0x135/0x290 mm/slub.c:3964
 skb_clone+0x20c/0x390 net/core/skbuff.c:2036
 hci_send_cmd_sync net/bluetooth/hci_core.c:4234 [inline]
 hci_cmd_work+0x29e/0x670 net/bluetooth/hci_core.c:4254
 process_one_work kernel/workqueue.c:3218 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3299
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3380
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243

Freed by task 5109:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xe0/0x150 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2190 [inline]
 slab_free mm/slub.c:4393 [inline]
 kmem_cache_free+0x145/0x340 mm/slub.c:4468
 kfree_skb include/linux/skbuff.h:1262 [inline]
 hci_req_sync_complete+0xe7/0x290 net/bluetooth/hci_request.c:109
 hci_event_packet+0xc71/0x1540 net/bluetooth/hci_event.c:7620
 hci_rx_work+0x3e8/0xca0 net/bluetooth/hci_core.c:4185
 process_one_work kernel/workqueue.c:3218 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3299
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3380
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243

The buggy address belongs to the object at ffff8880645c9780
 which belongs to the cache skbuff_head_cache of size 240
The buggy address is located 228 bytes inside of
 freed 240-byte region [ffff8880645c9780, ffff8880645c9870)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x645c9
flags: 0xfff80000000000(node=0|zone=1|lastcpupid=0xfff)
page_type: 0xffffefff(slab)
raw: 00fff80000000000 ffff888018ec2780 dead000000000122 0000000000000000
raw: 0000000000000000 00000000800c000c 00000001ffffefff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY), pid 5106, tgid 1501860599 (kworker/u9:4), ts 5106, free_ts 23287202140
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1490
 prep_new_page mm/page_alloc.c:1498 [inline]
 get_page_from_freelist+0x2e7e/0x2f40 mm/page_alloc.c:3454
 __alloc_pages_noprof+0x256/0x6c0 mm/page_alloc.c:4712
 __alloc_pages_node_noprof include/linux/gfp.h:244 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:271 [inline]
 alloc_slab_page+0x5f/0x120 mm/slub.c:2259
 allocate_slab+0x5a/0x2e0 mm/slub.c:2422
 new_slab mm/slub.c:2475 [inline]
 ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3624
 __slab_alloc+0x58/0xa0 mm/slub.c:3714
 __slab_alloc_node mm/slub.c:3767 [inline]
 slab_alloc_node mm/slub.c:3945 [inline]
 kmem_cache_alloc_node_noprof+0x1fe/0x310 mm/slub.c:4000
 __alloc_skb+0x1c3/0x440 net/core/skbuff.c:658
 alloc_skb include/linux/skbuff.h:1313 [inline]
 bt_skb_alloc include/net/bluetooth/bluetooth.h:490 [inline]
 hci_si_event net/bluetooth/hci_sock.c:784 [inline]
 hci_sock_dev_event+0x100/0x5f0 net/bluetooth/hci_sock.c:826
 hci_dev_open_sync+0xfbe/0x33d0 net/bluetooth/hci_sync.c:5000
 hci_dev_do_open net/bluetooth/hci_core.c:490 [inline]
 hci_power_on+0x1c8/0x700 net/bluetooth/hci_core.c:1022
 process_one_work kernel/workqueue.c:3218 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3299
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3380
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
page last free pid 1 tgid 1 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1110 [inline]
 free_unref_page+0xd3c/0xec0 mm/page_alloc.c:2617
 free_contig_range+0x9e/0x160 mm/page_alloc.c:6667
 destroy_args+0x8a/0x890 mm/debug_vm_pgtable.c:1037
 debug_vm_pgtable+0x4be/0x550 mm/debug_vm_pgtable.c:1417
 do_one_initcall+0x248/0x880 init/main.c:1258
 do_initcall_level+0x157/0x210 init/main.c:1320
 do_initcalls+0x3f/0x80 init/main.c:1336
 kernel_init_freeable+0x435/0x5d0 init/main.c:1569
 kernel_init+0x1d/0x2b0 init/main.c:1458
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243

Memory state around the buggy address:
 ffff8880645c9700: fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc
 ffff8880645c9780: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880645c9800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc
                                                       ^
 ffff8880645c9880: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
 ffff8880645c9900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

