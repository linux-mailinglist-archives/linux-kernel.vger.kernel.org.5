Return-Path: <linux-kernel+bounces-144004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AA18A40A5
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 08:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8AE4B2108E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 06:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5271CD1F;
	Sun, 14 Apr 2024 06:27:37 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7632D1C290
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 06:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713076056; cv=none; b=hLk614O5rdQMhtTZ8HcwE2hELx2zDIOBXusqOaHuhMxjfZrZ13WalYkHKRgPRSqPP7MTYfNrH9HqV7KawKR34ppsqp0kyOp+jja/SCqLlZAMBrMvekMyo+tiTeOWe/PNKuIyXlRFc/PuS6TCwaEBZ3BNErBiVk5JWgY/0lfB0tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713076056; c=relaxed/simple;
	bh=mdzAcLlJ/Fl696CX7w7hYPiYG4H27UxIaLaCBToAeHw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WK/8TWY+B/tzlrA2oGFPiJ2QsKTTdFo/TPcGT9c7ahSEknFkIP5twj+FuEv3ZjrBlOOIauV8RB6pdGymgeidoNDc8f3+NXAYt8Tw9MT1wq8IbFWXfd284oU1H74waQUBMWLQCk3sYm6e9qY6jTTHpdjrf78POrbli+u4nLBI0OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36b0ad52a87so20318545ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 23:27:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713076053; x=1713680853;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JLg2GQWsZGkAR0+hnAq/u4FeIl+zdxISivDMgQEvFLE=;
        b=ZI2fAum6JyPNfLeEl3nRzMsD+s9SVY0S8vxkexnPSrbGWOeR0ZrGqWKzAqIpEYF27/
         gx14HB0P6Y7jkzBU7bjRIqb3KqfNKtrcrV+cs229ii2zcHbpTnbzrF9q/vs2Q7xfoJzQ
         +A5kauFBx+12jpAxb4P5aiTjFwee6npiMLMFRN4EFY3N9Bqa0DHg9zzMT8pLNE54urW9
         6hsLr4LzQFACrTBD22Cm/rrS2qfFDqgRHo9MDowLf81mCCFU+8QfH54Wpo4Y75vaEFF9
         f13/9/RCwxFECtFRmawWyuDDRT88BXENU57GbbT1vXyO3PUEgd/W5S+yDtizv9oG6ERG
         ZR+A==
X-Forwarded-Encrypted: i=1; AJvYcCU5KMNV+kbXRnlsaZxuxnNjzCHTO6uI4xDezq0yiKZlHI2q9Ug+II8lMluuxtcvRqAvbCVlxMcOKYWWtbWFGq4z2DWFG287ZEtgwnY7
X-Gm-Message-State: AOJu0Yy2uOhdb9MpCtrtBx3FummvDMudEb2592kr+LAoYWw5EMVOUs6w
	YK9KL6xXTPtFI7tSxacfTBHOchfGwVqmtcPUQFvf3iZ8A4EM/wJyV0z4b6Hr6MLpcz/+UHF957u
	ZWZ2xXJnK0jA21YELSLqe2ToWpCJp41QOCO1Z93f5LXFkxIrvxlgWsEc=
X-Google-Smtp-Source: AGHT+IHuoVxI8ovshMQSE2etOluomFFVe6SnPJaGYGKRxmL7y9TTyj1ouM7y7eILlgyro3eUTtwmsDCWIaoltjLfSs8ZJ+kDr2dg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1545:b0:36a:1813:d85c with SMTP id
 j5-20020a056e02154500b0036a1813d85cmr499264ilu.4.1713076053764; Sat, 13 Apr
 2024 23:27:33 -0700 (PDT)
Date: Sat, 13 Apr 2024 23:27:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a87d17061608997e@google.com>
Subject: [syzbot] [can?] KASAN: slab-use-after-free Read in j1939_xtp_rx_dat_one
From: syzbot <syzbot+75ec36af46e2098f253c@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kernel@pengutronix.de, 
	kuba@kernel.org, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mkl@pengutronix.de, netdev@vger.kernel.org, o.rempel@pengutronix.de, 
	pabeni@redhat.com, robin@protonic.nl, socketcan@hartkopp.net, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2c71fdf02a95 Merge tag 'drm-fixes-2024-04-09' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1147924d180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=285be8dd6baeb438
dashboard link: https://syzkaller.appspot.com/bug?extid=75ec36af46e2098f253c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11ae00cb180000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-2c71fdf0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1d7474aaf31a/vmlinux-2c71fdf0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/895428c29966/bzImage-2c71fdf0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+75ec36af46e2098f253c@syzkaller.appspotmail.com

vcan0: j1939_xtp_rx_dat_one: 0xffff88802c9a1400: Data of RX-looped back packet (00 00 00 00 00 00 00) doesn't match TX data (00 63 67 72 6f 75 70)!
==================================================================
BUG: KASAN: slab-use-after-free in j1939_xtp_rx_dat_one+0xf2d/0xfb0 net/can/j1939/transport.c:1888
Read of size 1 at addr ffff88803c35394e by task syz-executor.0/6638

CPU: 1 PID: 6638 Comm: syz-executor.0 Not tainted 6.9.0-rc3-syzkaller-00023-g2c71fdf02a95 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc3/0x620 mm/kasan/report.c:488
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 j1939_xtp_rx_dat_one+0xf2d/0xfb0 net/can/j1939/transport.c:1888
 j1939_xtp_rx_dat net/can/j1939/transport.c:1940 [inline]
 j1939_tp_recv+0x7c5/0xf50 net/can/j1939/transport.c:2134
 j1939_can_recv+0x78f/0xa70 net/can/j1939/main.c:112
 deliver net/can/af_can.c:572 [inline]
 can_rcv_filter+0x2a8/0x900 net/can/af_can.c:606
 can_receive+0x320/0x5c0 net/can/af_can.c:663
 can_rcv+0x1e0/0x280 net/can/af_can.c:687
 __netif_receive_skb_one_core+0x1b1/0x1e0 net/core/dev.c:5538
 __netif_receive_skb+0x1d/0x160 net/core/dev.c:5652
 process_backlog+0x12f/0x6f0 net/core/dev.c:5981
 __napi_poll.constprop.0+0xb7/0x550 net/core/dev.c:6632
 napi_poll net/core/dev.c:6701 [inline]
 net_rx_action+0x9ad/0xf10 net/core/dev.c:6816
 __do_softirq+0x218/0x922 kernel/softirq.c:554
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:633 [inline]
 irq_exit_rcu+0xb9/0x120 kernel/softirq.c:645
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:preempt_count_add+0x1f/0x150 kernel/sched/core.c:5874
Code: 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 c7 c0 a0 0a 6b 94 55 48 ba 00 00 00 00 00 fc ff df 48 89 c1 53 83 e0 07 89 fb <48> c1 e9 03 83 c0 03 65 01 3d 7b ee a5 7e 0f b6 14 11 38 d0 7c 08
RSP: 0018:ffffc9000df47d10 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffffffff946b0aa0
RDX: dffffc0000000000 RSI: ffffffff820230f6 RDI: 0000000000000001
RBP: ffff88802a87fa60 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000000 R12: ffff888024238350
R13: ffff88802a87fa68 R14: 0000000000000000 R15: dffffc0000000000
 mnt_get_write_access+0x20/0x300 fs/namespace.c:352
 mnt_want_write+0x149/0x450 fs/namespace.c:410
 filename_create+0x10d/0x530 fs/namei.c:3885
 do_symlinkat+0xbf/0x310 fs/namei.c:4500
 __do_sys_symlinkat fs/namei.c:4523 [inline]
 __se_sys_symlinkat fs/namei.c:4520 [inline]
 __x64_sys_symlinkat+0x97/0xc0 fs/namei.c:4520
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f35bd27d5e7
Code: 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 0a 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc8ec53158 EFLAGS: 00000202 ORIG_RAX: 000000000000010a
RAX: ffffffffffffffda RBX: 00007ffc8ec53220 RCX: 00007f35bd27d5e7
RDX: 00007f35bd2ca526 RSI: 00000000ffffff9c RDI: 00007ffc8ec53220
RBP: 0000000000000001 R08: 0000000000000017 R09: 00007ffc8ec52ea7
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000000
 </TASK>

Allocated by task 6640:
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x89/0x90 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3798 [inline]
 slab_alloc_node mm/slub.c:3845 [inline]
 kmem_cache_alloc_node+0x177/0x340 mm/slub.c:3888
 __alloc_skb+0x2b1/0x380 net/core/skbuff.c:658
 alloc_skb include/linux/skbuff.h:1313 [inline]
 alloc_skb_with_frags+0xe4/0x710 net/core/skbuff.c:6504
 sock_alloc_send_pskb+0x7f1/0x980 net/core/sock.c:2795
 sock_alloc_send_skb include/net/sock.h:1842 [inline]
 j1939_sk_alloc_skb net/can/j1939/socket.c:878 [inline]
 j1939_sk_send_loop net/can/j1939/socket.c:1142 [inline]
 j1939_sk_sendmsg+0x6d4/0x1370 net/can/j1939/socket.c:1277
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 sock_sendmsg+0x3cb/0x470 net/socket.c:768
 splice_to_socket+0xab2/0x1040 fs/splice.c:889
 do_splice_from fs/splice.c:941 [inline]
 direct_splice_actor+0x19b/0x6d0 fs/splice.c:1164
 splice_direct_to_actor+0x346/0xa40 fs/splice.c:1108
 do_splice_direct_actor fs/splice.c:1207 [inline]
 do_splice_direct+0x17e/0x250 fs/splice.c:1233
 do_sendfile+0xaa8/0xdb0 fs/read_write.c:1295
 __do_sys_sendfile64 fs/read_write.c:1362 [inline]
 __se_sys_sendfile64 fs/read_write.c:1348 [inline]
 __x64_sys_sendfile64+0x1da/0x220 fs/read_write.c:1348
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 24:
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
 j1939_session_skb_drop_old net/can/j1939/transport.c:347 [inline]
 j1939_xtp_rx_cts_one net/can/j1939/transport.c:1445 [inline]
 j1939_xtp_rx_cts+0x619/0xf60 net/can/j1939/transport.c:1484
 j1939_tp_cmd_recv net/can/j1939/transport.c:2072 [inline]
 j1939_tp_recv+0x568/0xf50 net/can/j1939/transport.c:2144
 j1939_can_recv+0x78f/0xa70 net/can/j1939/main.c:112
 deliver net/can/af_can.c:572 [inline]
 can_rcv_filter+0x2a8/0x900 net/can/af_can.c:606
 can_receive+0x320/0x5c0 net/can/af_can.c:663
 can_rcv+0x1e0/0x280 net/can/af_can.c:687
 __netif_receive_skb_one_core+0x1b1/0x1e0 net/core/dev.c:5538
 __netif_receive_skb+0x1d/0x160 net/core/dev.c:5652
 process_backlog+0x12f/0x6f0 net/core/dev.c:5981
 __napi_poll.constprop.0+0xb7/0x550 net/core/dev.c:6632
 napi_poll net/core/dev.c:6701 [inline]
 net_rx_action+0x9ad/0xf10 net/core/dev.c:6816
 __do_softirq+0x218/0x922 kernel/softirq.c:554

The buggy address belongs to the object at ffff88803c353900
 which belongs to the cache skbuff_head_cache of size 240
The buggy address is located 78 bytes inside of
 freed 240-byte region [ffff88803c353900, ffff88803c3539f0)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x3c352
head: order:1 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff80000000840(slab|head|node=0|zone=1|lastcpupid=0xfff)
page_type: 0xffffffff()
raw: 00fff80000000840 ffff888019288780 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000190019 00000001ffffffff 0000000000000000
head: 00fff80000000840 ffff888019288780 0000000000000000 dead000000000001
head: 0000000000000000 0000000000190019 00000001ffffffff 0000000000000000
head: 00fff80000000001 ffffea0000f0d481 ffffea0000f0d4c8 00000000ffffffff
head: 0000000200000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0x152820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_HARDWALL), pid 12, tgid 12 (kworker/u32:1), ts 292119497381, free_ts 291277043750
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
 skb_clone+0x190/0x3f0 net/core/skbuff.c:2063
 can_send+0x56d/0xb40 net/can/af_can.c:260
 j1939_send_one+0x299/0x360 net/can/j1939/main.c:357
 j1939_tp_tx_dat net/can/j1939/transport.c:646 [inline]
 j1939_session_tx_dat net/can/j1939/transport.c:838 [inline]
 j1939_xtp_txnext_transmiter net/can/j1939/transport.c:900 [inline]
 j1939_tp_txtimer+0xa8f/0x29e0 net/can/j1939/transport.c:1160
 __run_hrtimer kernel/time/hrtimer.c:1692 [inline]
 __hrtimer_run_queues+0x20c/0xcc0 kernel/time/hrtimer.c:1756
 hrtimer_run_softirq+0x17d/0x350 kernel/time/hrtimer.c:1773
 __do_softirq+0x218/0x922 kernel/softirq.c:554
page last free pid 4682 tgid 4682 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1141 [inline]
 free_unref_page_prepare+0x527/0xb10 mm/page_alloc.c:2347
 free_unref_page+0x33/0x3c0 mm/page_alloc.c:2487
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x4e/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x192/0x1e0 mm/kasan/quarantine.c:286
 __kasan_kmalloc+0x8a/0xb0 mm/kasan/common.c:378
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:3966 [inline]
 __kmalloc+0x1f9/0x440 mm/slub.c:3979
 kmalloc include/linux/slab.h:632 [inline]
 kzalloc include/linux/slab.h:749 [inline]
 tomoyo_encode2+0x100/0x3e0 security/tomoyo/realpath.c:45
 tomoyo_encode+0x29/0x50 security/tomoyo/realpath.c:80
 tomoyo_realpath_from_path+0x19d/0x720 security/tomoyo/realpath.c:283
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_perm+0x273/0x450 security/tomoyo/file.c:822
 tomoyo_path_unlink+0x92/0xe0 security/tomoyo/tomoyo.c:162
 security_path_unlink+0x100/0x170 security/security.c:1857
 do_unlinkat+0x55b/0x750 fs/namei.c:4396
 __do_sys_unlink fs/namei.c:4447 [inline]
 __se_sys_unlink fs/namei.c:4445 [inline]
 __x64_sys_unlink+0xc7/0x110 fs/namei.c:4445
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88803c353800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88803c353880: fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc
>ffff88803c353900: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                              ^
 ffff88803c353980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc
 ffff88803c353a00: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
==================================================================
----------------
Code disassembly (best guess):
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
   3:	90                   	nop
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	f3 0f 1e fa          	endbr64
   f:	48 c7 c0 a0 0a 6b 94 	mov    $0xffffffff946b0aa0,%rax
  16:	55                   	push   %rbp
  17:	48 ba 00 00 00 00 00 	movabs $0xdffffc0000000000,%rdx
  1e:	fc ff df
  21:	48 89 c1             	mov    %rax,%rcx
  24:	53                   	push   %rbx
  25:	83 e0 07             	and    $0x7,%eax
  28:	89 fb                	mov    %edi,%ebx
* 2a:	48 c1 e9 03          	shr    $0x3,%rcx <-- trapping instruction
  2e:	83 c0 03             	add    $0x3,%eax
  31:	65 01 3d 7b ee a5 7e 	add    %edi,%gs:0x7ea5ee7b(%rip)        # 0x7ea5eeb3
  38:	0f b6 14 11          	movzbl (%rcx,%rdx,1),%edx
  3c:	38 d0                	cmp    %dl,%al
  3e:	7c 08                	jl     0x48


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

