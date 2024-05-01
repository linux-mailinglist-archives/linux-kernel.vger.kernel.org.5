Return-Path: <linux-kernel+bounces-164911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8900B8B84CD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 06:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BC331C22BC6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 04:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30693D393;
	Wed,  1 May 2024 04:19:23 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FA6EED6
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 04:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714537163; cv=none; b=j8IMnfQbMKTTMEdvkgvBmr4D3P2NrqdYEyYLcYC4K9nv97xX5KMS1UXau+6/TF2CrmKySx8Rl0LJKZ3z8AySVXzMwyLtqWGVYVRtcwmTJFxtiQT08Q8GsUogvC1XL6VPdc7WrzHqCsai50YTy+T8nnRe96WnWwf2Ly5gw8E6jT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714537163; c=relaxed/simple;
	bh=gBAFypkIVlsZLqXrFgQZsrs4aDIRCsT6MPgpA1NBAOw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TLU2rWWQcZqgiqbonTWb4I8tdGtng6A+xt4oE6wnMX+W7jej7OcWUxR+0KzlctjJfFt0cxKRc0nvKHp3WSx6VVI/EfdSOIeIuyAYoMRrii0eGbQG3/YQF4CrvUbtVbeHh5xKMIw9qGSy4K0Q6dzDfuhWQ2IqJK23Htvlqg9FHL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7dd8cd201d6so721262739f.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 21:19:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714537160; x=1715141960;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wphcx2dBM60sViwV3qH9IOT4i1WcdGMIdFqUDnGUGe4=;
        b=iC2l+xNuKcV9puv+u/UlNKHc+KH+W8kZJ4W29XVT6xnHt90z+my1qAIrbmyXbTeChJ
         LFKBPxDfWGLUzklDVa1EX7eY3b9iJxtgYCvw/INQeOSWfHB+mxxoS04W2+y8NJIqE3I+
         n0p8wUuWbPwcYUiRAxmX0pfRCqdk+OqjEJK+GsBjFLOZJ5jYl6OF08bADoMG8uMniWM9
         2J6bhkPGK3XesAGkpc4H4FutyIor3IpUI2+exwhdjdKRqMksf0erZNutdnT7HjnwKJXQ
         XjN2mM5YGk9cXNEWsu7oKKF44eDLJc2scWPCOqT5jNm1o26mem5vfTq1PnnZNrf3XEsg
         IpRg==
X-Forwarded-Encrypted: i=1; AJvYcCXuChjOF/jwVoRE+ijPBJK0OdYrbe8l8XCsaajdkg2a8/br7WnejJyOPPsHUh7kbGkknxyUygTSpJBOwqwkg6ngTqgZR7kqNaCr3Y6A
X-Gm-Message-State: AOJu0YwxMeCoSS54cJvpCE9YCF7Qyl+5EiG+iya8U50ANUSJtuttz8qt
	IsasL8bF3oApThZLg8fLY5FV7mRoeqWUj6Ytkk3V1d45/0BIDc2EQycRF7mk3cBl4eDbO/50AFU
	xY1+1H6cMiLeL2R535jLTgUHKRhU/7X3hC/oy2m8ywb8iudprNdev1CU=
X-Google-Smtp-Source: AGHT+IFNQqAwWHBpX2rgoDdORl2uZ3RnkxoRqSe0ptReiQxXXRFVtWmIcZ2/O0/zdo8aUmPIM06yOu1ATIsoMvGhJLwAx5JMvELN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:31c9:b0:485:907:ffa with SMTP id
 n9-20020a05663831c900b0048509070ffamr118922jav.1.1714537160773; Tue, 30 Apr
 2024 21:19:20 -0700 (PDT)
Date: Tue, 30 Apr 2024 21:19:20 -0700
In-Reply-To: <000000000000a0703c0616a9cf58@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006c25b806175ccab3@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in skb_release_head_state
From: syzbot <syzbot+d863bc2d28ef7ff42984@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    50dffbf77180 Merge tag 'for-v6.9-rc' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=175cb917180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3310e643b6ef5d69
dashboard link: https://syzkaller.appspot.com/bug?extid=d863bc2d28ef7ff42984
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10ba57bb180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bee47aac5cdf/disk-50dffbf7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fa34e947bc0e/vmlinux-50dffbf7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/30e0143a8439/bzImage-50dffbf7.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/721857493545/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d863bc2d28ef7ff42984@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in skb_dst_drop include/net/dst.h:274 [inline]
BUG: KASAN: slab-use-after-free in skb_release_head_state+0x283/0x2b0 net/core/skbuff.c:1185
Read of size 8 at addr ffff88807683fa58 by task syz-executor.0/5091

CPU: 0 PID: 5091 Comm: syz-executor.0 Not tainted 6.9.0-rc6-syzkaller-00042-g50dffbf77180 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 skb_dst_drop include/net/dst.h:274 [inline]
 skb_release_head_state+0x283/0x2b0 net/core/skbuff.c:1185
 skb_release_all net/core/skbuff.c:1200 [inline]
 __kfree_skb net/core/skbuff.c:1216 [inline]
 kfree_skb_reason+0xed/0x210 net/core/skbuff.c:1252
 kfree_skb include/linux/skbuff.h:1262 [inline]
 __hci_req_sync+0x61d/0x980 net/bluetooth/hci_request.c:184
 hci_req_sync+0x97/0xd0 net/bluetooth/hci_request.c:206
 hci_dev_cmd+0x653/0x9c0 net/bluetooth/hci_core.c:790
 hci_sock_ioctl+0x4f3/0x8e0 net/bluetooth/hci_sock.c:1153
 sock_do_ioctl+0x116/0x280 net/socket.c:1222
 sock_ioctl+0x22e/0x6c0 net/socket.c:1341
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:904 [inline]
 __se_sys_ioctl fs/ioctl.c:890 [inline]
 __x64_sys_ioctl+0x193/0x220 fs/ioctl.c:890
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f19e347dc0b
Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
RSP: 002b:00007ffe54d6d580 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f19e347dc0b
RDX: 00007ffe54d6d5f8 RSI: 00000000400448dd RDI: 0000000000000003
RBP: 000055556149b430 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000008 R11: 0000000000000246 R12: 0000000000000001
R13: 0000000000000001 R14: 0000000000000001 R15: 00000000fffffff1
 </TASK>

Allocated by task 5109:
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
 process_one_work+0x9a9/0x1ac0 kernel/workqueue.c:3267
 process_scheduled_works kernel/workqueue.c:3348 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3429
 kthread+0x2c1/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 4472:
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
 hci_req_sync_complete+0x16c/0x270 net/bluetooth/hci_request.c:109
 hci_event_packet+0x963/0x1170 net/bluetooth/hci_event.c:7607
 hci_rx_work+0x2c4/0x1610 net/bluetooth/hci_core.c:4171
 process_one_work+0x9a9/0x1ac0 kernel/workqueue.c:3267
 process_scheduled_works kernel/workqueue.c:3348 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3429
 kthread+0x2c1/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff88807683fa00
 which belongs to the cache skbuff_head_cache of size 240
The buggy address is located 88 bytes inside of
 freed 240-byte region [ffff88807683fa00, ffff88807683faf0)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7683f
flags: 0xfff00000000800(slab|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000800 ffff888018e98780 dead000000000122 0000000000000000
raw: 0000000000000000 00000000800c000c 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 5091, tgid -863472599 (syz-executor.0), ts 5092, free_ts 99223985895
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
 bt_skb_alloc include/net/bluetooth/bluetooth.h:489 [inline]
 vhci_get_user drivers/bluetooth/hci_vhci.c:497 [inline]
 vhci_write+0xc7/0x470 drivers/bluetooth/hci_vhci.c:617
 call_write_iter include/linux/fs.h:2110 [inline]
 do_iter_readv_writev+0x504/0x780 fs/read_write.c:741
 vfs_writev+0x36f/0xdb0 fs/read_write.c:971
 do_writev+0x137/0x370 fs/read_write.c:1018
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5076 tgid 5072 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1141 [inline]
 free_unref_page_prepare+0x527/0xb10 mm/page_alloc.c:2347
 free_unref_page+0x33/0x3c0 mm/page_alloc.c:2487
 vfree+0x181/0x7a0 mm/vmalloc.c:3340
 sel_release_policy+0xd7/0x120 security/selinux/selinuxfs.c:422
 __fput+0x270/0xb80 fs/file_table.c:422
 __fput_sync+0x47/0x50 fs/file_table.c:507
 __do_sys_close fs/open.c:1556 [inline]
 __se_sys_close fs/open.c:1541 [inline]
 __x64_sys_close+0x86/0x100 fs/open.c:1541
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88807683f900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88807683f980: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
>ffff88807683fa00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                    ^
 ffff88807683fa80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc
 ffff88807683fb00: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

