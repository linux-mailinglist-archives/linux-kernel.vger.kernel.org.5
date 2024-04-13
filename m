Return-Path: <linux-kernel+bounces-143623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 167448A3B89
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 09:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F07E1C20FC1
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 07:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17505208B8;
	Sat, 13 Apr 2024 07:58:43 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8912C695
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 07:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712995122; cv=none; b=EjSnoftGGmdkHxTLlIQA266Gme3U7zcygSbY9WYa4JKKO8e7BA/94aPUT126V0du7/6kDAhBjLbQA002bNdFaSKqaQfSxn0zEfkDAUE0HjdluQ32U6gUpy+hK6VcoAZKahGQjo8UWGaRF24Cv/ezEU62/jQuXV/9AzIkRvu2Ls4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712995122; c=relaxed/simple;
	bh=Wd/pEArtIDmE+1J2q4bKC+DHlAifMG6JaYAmps8tlGs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hIDpxKDn8igfhFmTdMk+fCxhibvAMlyEExfQtTli0FHnM82uqmjXoETkAf+w5o39rkRNBn9nsdGmU60buG/RbH/CDDE8t0hyP8Yoon1jS7p4mAMmdcF7tqNZE7tS3qHbEt+KOhW2o7bMwqL4YHF4DzRbaMg742SkzQWp2tbW+to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7d5e2b1d05aso175174239f.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 00:58:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712995120; x=1713599920;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WZaaZWzEpPFcGYMrhCooJonvkKViPv5nqF3GIJ0T7n8=;
        b=k4zVQ2FETgszZqxd7M5SXS/n1Yaf37x7GRXP0lc7TSew42g27ruQOvr9yDpe5iI7Te
         0jMiffNd0Sf+2PaS30Hr1a3zgZ9WY16tjNgULQY3L/RiaKWakl1QlbKAxmgdCzBNDQtx
         KcuSB8vVrwrqJyu0aW6UGdXQzi8DvTXJgBqwbijtWww+u3a/6cpi0+P3+q2BB/U6WoQs
         9oHk1RZnQ2I1TqjBXRzDWQf0HipPtQic12Hafchsu5Mi2dskapCQ13aCSleRMuXDWDNL
         83Szx/0jOVyB4gipNL531jy5iyZlALpMO7zLoFZnAKjlJQh5A8QNjjjlOFf91tZVcTUO
         UKgQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/uudP0iYeOGSKz0M/Pb95wFcTaAtwT1G/TCDFW2GGSbsmX3U5zCsBGyXchwBKFyTozd3V3GueIzrptu3P/DTHLYKNk6HF3PFuVY7Z
X-Gm-Message-State: AOJu0YznfhrsCDJS1DOaSdTuctkf/PFBNQryX00AsC7hNYART49nTCrx
	SnNl884D55Y7+HJo8MLfM/r+YW/0vniOj4ar4saj+GAHRM2X4jsYoRQOcmNTjiQTepZciGcItHh
	TCO0EyPcXr7/BrIPD1Nq01U7NuKMh4dYiHFR4MXNx3fCH/zxDwXMJRAE=
X-Google-Smtp-Source: AGHT+IGiZSFhZpjtS9NP6RwInAYdWUtlWU6MGVPCifqyoSHOuIr80pjUviVy1GKP14Yyp/nc07nsxY9+Uznc+joZ06K+ckaGNX9i
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e01:b0:36a:190f:1c93 with SMTP id
 g1-20020a056e021e0100b0036a190f1c93mr348092ila.5.1712995119817; Sat, 13 Apr
 2024 00:58:39 -0700 (PDT)
Date: Sat, 13 Apr 2024 00:58:39 -0700
In-Reply-To: <0000000000001e41e20615824081@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009e80a40615f5c189@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in __hci_req_sync
From: syzbot <syzbot+27209997e4015fb4702e@syzkaller.appspotmail.com>
To: hdanton@sina.com, johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    8f2c057754b2 Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16952da3180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c5a8421528fe0176
dashboard link: https://syzkaller.appspot.com/bug?extid=27209997e4015fb4702e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14905af5180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=171da243180000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-8f2c0577.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4ed4e9e9deb1/vmlinux-8f2c0577.xz
kernel image: https://storage.googleapis.com/syzbot-assets/136318846a1c/bzImage-8f2c0577.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+27209997e4015fb4702e@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: slab-use-after-free in atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
BUG: KASAN: slab-use-after-free in refcount_read include/linux/refcount.h:136 [inline]
BUG: KASAN: slab-use-after-free in skb_unref include/linux/skbuff.h:1227 [inline]
BUG: KASAN: slab-use-after-free in __kfree_skb_reason net/core/skbuff.c:1224 [inline]
BUG: KASAN: slab-use-after-free in kfree_skb_reason+0x36/0x210 net/core/skbuff.c:1251
Read of size 4 at addr ffff888029a1fee4 by task syz-executor145/5234

CPU: 0 PID: 5234 Comm: syz-executor145 Not tainted 6.9.0-rc3-syzkaller-00344-g8f2c057754b2 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0xef/0x1a0 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
 refcount_read include/linux/refcount.h:136 [inline]
 skb_unref include/linux/skbuff.h:1227 [inline]
 __kfree_skb_reason net/core/skbuff.c:1224 [inline]
 kfree_skb_reason+0x36/0x210 net/core/skbuff.c:1251
 kfree_skb include/linux/skbuff.h:1262 [inline]
 __hci_req_sync+0x61d/0x980 net/bluetooth/hci_request.c:184
 hci_req_sync+0x97/0xd0 net/bluetooth/hci_request.c:206
 hci_dev_cmd+0x653/0x9c0 net/bluetooth/hci_core.c:790
 hci_sock_ioctl+0x4f3/0x8e0 net/bluetooth/hci_sock.c:1153
 hci_sock_compat_ioctl net/bluetooth/hci_sock.c:1180 [inline]
 hci_sock_compat_ioctl+0x68/0x80 net/bluetooth/hci_sock.c:1169
 compat_sock_ioctl+0x181/0x7f0 net/socket.c:3521
 __do_compat_sys_ioctl+0x2c3/0x330 fs/ioctl.c:1004
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0x75/0x120 arch/x86/entry/common.c:321
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:346
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf7e3c579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000ffa29e34 EFLAGS: 00000292 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000400448dd
RDX: 00000000ffa29f04 RSI: 00000000f7f0bff4 RDI: 00000000577e83d8
RBP: 00000000ffa2a118 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000292 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Allocated by task 5243:
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
 process_one_work+0x902/0x1a30 kernel/workqueue.c:3254
 process_scheduled_works kernel/workqueue.c:3335 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3416
 kthread+0x2c1/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 5243:
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
 hci_event_packet+0x963/0x1190 net/bluetooth/hci_event.c:7604
 hci_rx_work+0x2c4/0x1610 net/bluetooth/hci_core.c:4171
 process_one_work+0x902/0x1a30 kernel/workqueue.c:3254
 process_scheduled_works kernel/workqueue.c:3335 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3416
 kthread+0x2c1/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff888029a1fe00
 which belongs to the cache skbuff_head_cache of size 240
The buggy address is located 228 bytes inside of
 freed 240-byte region [ffff888029a1fe00, ffff888029a1fef0)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x29a1e
head: order:1 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff80000000840(slab|head|node=0|zone=1|lastcpupid=0xfff)
page_type: 0xffffffff()
raw: 00fff80000000840 ffff888015fa8780 ffffea00009fee80 0000000000000004
raw: 0000000000000000 0000000000190019 00000001ffffffff 0000000000000000
head: 00fff80000000840 ffff888015fa8780 ffffea00009fee80 0000000000000004
head: 0000000000000000 0000000000190019 00000001ffffffff 0000000000000000
head: 00fff80000000001 ffffea0000a68781 dead000000000122 00000000ffffffff
head: 0000000200000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0x52820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 5111, tgid 5111 (sshd), ts 41611078310, free_ts 41590764657
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
 ___slab_alloc+0x670/0x16d0 mm/slub.c:3525
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3610
 __slab_alloc_node mm/slub.c:3663 [inline]
 slab_alloc_node mm/slub.c:3835 [inline]
 kmem_cache_alloc_node+0x10a/0x340 mm/slub.c:3888
 __alloc_skb+0x2b3/0x380 net/core/skbuff.c:658
 alloc_skb include/linux/skbuff.h:1313 [inline]
 __tcp_send_ack.part.0+0x64/0x720 net/ipv4/tcp_output.c:4206
 __tcp_send_ack net/ipv4/tcp_output.c:4238 [inline]
 tcp_send_ack+0x82/0xa0 net/ipv4/tcp_output.c:4238
 __tcp_cleanup_rbuf+0x278/0x4b0 net/ipv4/tcp.c:1492
 tcp_recvmsg_locked+0x114e/0x24c0 net/ipv4/tcp.c:2548
 tcp_recvmsg+0x12e/0x680 net/ipv4/tcp.c:2578
 inet_recvmsg+0x12b/0x6a0 net/ipv4/af_inet.c:883
 sock_recvmsg_nosec net/socket.c:1046 [inline]
 sock_recvmsg+0x1b2/0x250 net/socket.c:1068
 sock_read_iter+0x2c7/0x3c0 net/socket.c:1138
page last free pid 5111 tgid 5111 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1141 [inline]
 free_unref_page_prepare+0x527/0xb10 mm/page_alloc.c:2347
 free_unref_page+0x33/0x3c0 mm/page_alloc.c:2487
 skb_free_frag include/linux/skbuff.h:3336 [inline]
 skb_free_head+0xa6/0x1e0 net/core/skbuff.c:1106
 skb_release_data+0x76c/0x990 net/core/skbuff.c:1136
 skb_release_all net/core/skbuff.c:1202 [inline]
 __kfree_skb net/core/skbuff.c:1216 [inline]
 skb_attempt_defer_free+0x3be/0x580 net/core/skbuff.c:7016
 tcp_eat_recv_skb net/ipv4/tcp.c:1513 [inline]
 tcp_recvmsg_locked+0x10dd/0x24c0 net/ipv4/tcp.c:2532
 tcp_recvmsg+0x12e/0x680 net/ipv4/tcp.c:2578
 inet_recvmsg+0x12b/0x6a0 net/ipv4/af_inet.c:883
 sock_recvmsg_nosec net/socket.c:1046 [inline]
 sock_recvmsg+0x1b2/0x250 net/socket.c:1068
 sock_read_iter+0x2c7/0x3c0 net/socket.c:1138
 call_read_iter include/linux/fs.h:2104 [inline]
 new_sync_read fs/read_write.c:395 [inline]
 vfs_read+0x9fd/0xb80 fs/read_write.c:476
 ksys_read+0x1f8/0x260 fs/read_write.c:619
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888029a1fd80: fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc
 ffff888029a1fe00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888029a1fe80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc
                                                       ^
 ffff888029a1ff00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888029a1ff80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	10 06                	adc    %al,(%rsi)
   2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   6:	10 07                	adc    %al,(%rdi)
   8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   c:	10 08                	adc    %cl,(%rax)
   e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1e:	00 51 52             	add    %dl,0x52(%rcx)
  21:	55                   	push   %rbp
  22:	89 e5                	mov    %esp,%ebp
  24:	0f 34                	sysenter
  26:	cd 80                	int    $0x80
* 28:	5d                   	pop    %rbp <-- trapping instruction
  29:	5a                   	pop    %rdx
  2a:	59                   	pop    %rcx
  2b:	c3                   	ret
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
  30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

