Return-Path: <linux-kernel+bounces-81058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC94866F9A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2F95288713
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5633958AA5;
	Mon, 26 Feb 2024 09:32:29 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9EF58AA4
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 09:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708939948; cv=none; b=pKBWT/lAZrxVvUtw0JIuAAUmkoTrpVDfAaGcPIxFWhfeIsSGabI5ia0rjwLZMh3fy3AVJHDQLT5vPkPAV70D/OsTvLX5mRX0ZLUV53U5Cr2eJZ6L23SWx8zAQshREcN2S61VD1U/XH46yUGBdSV7JCvNZQXCDT4vMeAAU8dZNnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708939948; c=relaxed/simple;
	bh=66MEspg+SaHHJDXk2+owU0lr3b3hOrlJPu9/Q6uv9zg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=kaJht5D7SWgfxDbEMBQtcRqr2v0q55e01qhWE6Uu4HNX/aOOJ2KHy24dV/Jfd7+niGHywJ3bTjJUfJv4g3+fdvFCbol5UTJYy5P3XzcfTmdjPc0fkYWy0GyV0Gudu1tPAEUgzDRqrRuIjxPaFWkJESSL9ZliOSEEpaEyDhvSjjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36525729ea3so20180455ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 01:32:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708939946; x=1709544746;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4UhTGcgZLr+ph10fSFIawsjoJb3sC8UPlcGF0sIJ0Mc=;
        b=gq9CyjcFEjA2Mz3IUN/+uIRhScDKK8tamoexxrHwfYw8y0F6shIEeqX7HTc0JQubLU
         5FiaVbZOEAQ3M0r58io3e+7D+cBzHKBGHFim+vi7BSE6py2GEqTZjh5jOun7ir7w1sFH
         XEQd43bc+3AoPBhc9IP3mLM8NMyGFo9GicRDmoGz4Pf4b5PmVEaPsqcgjzZP/IdkaIFr
         8Qyk1uAjQQg/THKh7MBzo7G2A/ybAFOXbaLb+cUDs5pKsTW+C4L5aEZHyrMKTyo+Kja6
         TslMH2I8wrnO50MlWWneAbDQTpEPz+WhPCstoGFaJIMa9pojHfkmlPQ8SuYeURahef0b
         AyvA==
X-Forwarded-Encrypted: i=1; AJvYcCWFpxYrzrKzKAX4JceRtPyczdTLE1ueUzRzkNuQOkrT5LiXCFN9LkLBFe9nkvDo8g+uJ5r4a71CNelPNd1bTdTSAzXh5NmySHpNroSX
X-Gm-Message-State: AOJu0YwYnfxfBR15rFn7od++Qrn1OiusIzZFeIX9RXQvjOcKMuqd3JXo
	WvCY/50o3AnkbFXhunGBgp7rq2G57Jj6/kSVNBfRpeWZ2vJMF2pq/1S5k82VjsBl2qhOGNdEouJ
	gxgZHLHD3afzBX21Uwh949UklwUvLWDaA5XoBzskWnJrN6xaQCTuRR3I=
X-Google-Smtp-Source: AGHT+IHw925CSt9I6AcKQyWizLg4ZczVBAS+EIdmC/ID0NK9R/KKcCipbLx/gE08CDSlOR/ATfMVlbJRw5jILMukwoWrg3O7M/Ua
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ec:b0:363:cc38:db22 with SMTP id
 l12-20020a056e0212ec00b00363cc38db22mr515255iln.3.1708939946258; Mon, 26 Feb
 2024 01:32:26 -0800 (PST)
Date: Mon, 26 Feb 2024 01:32:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000070784806124596ec@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in l2cap_send_cmd
From: syzbot <syzbot+31c2f641b850a348a734@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b401b621758e Linux 6.8-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12f63152180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=eff9f3183d0a20dd
dashboard link: https://syzkaller.appspot.com/bug?extid=31c2f641b850a348a734
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d31bbc7def2b/disk-b401b621.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/92891f219eae/vmlinux-b401b621.xz
kernel image: https://storage.googleapis.com/syzbot-assets/aedf35bce0a0/bzImage-b401b621.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+31c2f641b850a348a734@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in l2cap_build_cmd net/bluetooth/l2cap_core.c:3100 [inline]
BUG: KASAN: slab-use-after-free in l2cap_send_cmd+0x679/0x8d0 net/bluetooth/l2cap_core.c:958
Read of size 4 at addr ffff88802b3d7010 by task kworker/u5:7/5112

CPU: 0 PID: 5112 Comm: kworker/u5:7 Not tainted 6.8.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Workqueue: hci3 hci_rx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x167/0x540 mm/kasan/report.c:488
 kasan_report+0x142/0x180 mm/kasan/report.c:601
 l2cap_build_cmd net/bluetooth/l2cap_core.c:3100 [inline]
 l2cap_send_cmd+0x679/0x8d0 net/bluetooth/l2cap_core.c:958
 l2cap_recv_frame+0xfe9/0x8bd0
 hci_acldata_packet net/bluetooth/hci_core.c:3875 [inline]
 hci_rx_work+0x50f/0xca0 net/bluetooth/hci_core.c:4110
 process_one_work kernel/workqueue.c:2633 [inline]
 process_scheduled_works+0x915/0x1420 kernel/workqueue.c:2706
 worker_thread+0xa5f/0x1000 kernel/workqueue.c:2787
 kthread+0x2f1/0x390 kernel/kthread.c:388
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:242
 </TASK>

Allocated by task 5104:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:372 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:389
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 kmalloc_trace+0x1d6/0x360 mm/slub.c:4012
 kmalloc include/linux/slab.h:590 [inline]
 kzalloc include/linux/slab.h:711 [inline]
 l2cap_conn_add+0xb6/0xc10 net/bluetooth/l2cap_core.c:7855
 l2cap_connect_cfm+0x138/0x1290 net/bluetooth/l2cap_core.c:8252
 hci_connect_cfm+0xa4/0x150 include/net/bluetooth/hci_core.h:1986
 le_conn_complete_evt+0xd10/0x1290 net/bluetooth/hci_event.c:6025
 hci_le_conn_complete_evt+0x18c/0x420 net/bluetooth/hci_event.c:6051
 hci_event_func net/bluetooth/hci_event.c:7679 [inline]
 hci_event_packet+0xa59/0x1540 net/bluetooth/hci_event.c:7734
 hci_rx_work+0x3e8/0xca0 net/bluetooth/hci_core.c:4105
 process_one_work kernel/workqueue.c:2633 [inline]
 process_scheduled_works+0x915/0x1420 kernel/workqueue.c:2706
 worker_thread+0xa5f/0x1000 kernel/workqueue.c:2787
 kthread+0x2f1/0x390 kernel/kthread.c:388
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:242

Freed by task 5316:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x4e/0x60 mm/kasan/generic.c:640
 poison_slab_object+0xa6/0xe0 mm/kasan/common.c:241
 __kasan_slab_free+0x34/0x70 mm/kasan/common.c:257
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2121 [inline]
 slab_free mm/slub.c:4299 [inline]
 kfree+0x14a/0x380 mm/slub.c:4409
 l2cap_connect_cfm+0x121/0x1290 net/bluetooth/l2cap_core.c:8248
 hci_connect_cfm include/net/bluetooth/hci_core.h:1986 [inline]
 hci_conn_failed+0x1f8/0x340 net/bluetooth/hci_conn.c:1289
 hci_abort_conn_sync+0x583/0xde0 net/bluetooth/hci_sync.c:5356
 hci_cmd_sync_work+0x22d/0x400 net/bluetooth/hci_sync.c:306
 process_one_work kernel/workqueue.c:2633 [inline]
 process_scheduled_works+0x915/0x1420 kernel/workqueue.c:2706
 worker_thread+0xa5f/0x1000 kernel/workqueue.c:2787
 kthread+0x2f1/0x390 kernel/kthread.c:388
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:242

Last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xae/0x100 mm/kasan/generic.c:586
 insert_work+0x3e/0x330 kernel/workqueue.c:1653
 __queue_work+0xcdb/0x1000 kernel/workqueue.c:1806
 queue_work_on+0x14f/0x250 kernel/workqueue.c:1837
 queue_work include/linux/workqueue.h:548 [inline]
 l2cap_conn_ready net/bluetooth/l2cap_core.c:1779 [inline]
 l2cap_connect_cfm+0xf34/0x1290 net/bluetooth/l2cap_core.c:8293
 hci_connect_cfm+0xa4/0x150 include/net/bluetooth/hci_core.h:1986
 le_conn_complete_evt+0xd10/0x1290 net/bluetooth/hci_event.c:6025
 hci_le_conn_complete_evt+0x18c/0x420 net/bluetooth/hci_event.c:6051
 hci_event_func net/bluetooth/hci_event.c:7679 [inline]
 hci_event_packet+0xa59/0x1540 net/bluetooth/hci_event.c:7734
 hci_rx_work+0x3e8/0xca0 net/bluetooth/hci_core.c:4105
 process_one_work kernel/workqueue.c:2633 [inline]
 process_scheduled_works+0x915/0x1420 kernel/workqueue.c:2706
 worker_thread+0xa5f/0x1000 kernel/workqueue.c:2787
 kthread+0x2f1/0x390 kernel/kthread.c:388
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:242

The buggy address belongs to the object at ffff88802b3d7000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 16 bytes inside of
 freed 1024-byte region [ffff88802b3d7000, ffff88802b3d7400)

The buggy address belongs to the physical page:
page:ffffea0000acf400 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2b3d0
head:ffffea0000acf400 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888014c41dc0 ffffea000080da00 dead000000000002
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 17603844133, free_ts 0
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1533
 prep_new_page mm/page_alloc.c:1540 [inline]
 get_page_from_freelist+0x33ea/0x3580 mm/page_alloc.c:3311
 __alloc_pages+0x255/0x680 mm/page_alloc.c:4567
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page+0x5f/0x160 mm/slub.c:2190
 allocate_slab mm/slub.c:2354 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2407
 ___slab_alloc+0xd17/0x13e0 mm/slub.c:3540
 __slab_alloc mm/slub.c:3625 [inline]
 __slab_alloc_node mm/slub.c:3678 [inline]
 slab_alloc_node mm/slub.c:3850 [inline]
 __do_kmalloc_node mm/slub.c:3980 [inline]
 __kmalloc+0x2e0/0x490 mm/slub.c:3994
 kmalloc include/linux/slab.h:594 [inline]
 kzalloc include/linux/slab.h:711 [inline]
 net_alloc_generic net/core/net_namespace.c:75 [inline]
 net_assign_generic net/core/net_namespace.c:95 [inline]
 ops_init+0x203/0x610 net/core/net_namespace.c:130
 __register_pernet_operations net/core/net_namespace.c:1214 [inline]
 register_pernet_operations+0x2cb/0x660 net/core/net_namespace.c:1283
 register_pernet_device+0x33/0x80 net/core/net_namespace.c:1370
 dp_init+0x95/0x160 net/openvswitch/datapath.c:2745
 do_one_initcall+0x23a/0x830 init/main.c:1236
 do_initcall_level+0x157/0x210 init/main.c:1298
 do_initcalls+0x3f/0x80 init/main.c:1314
 kernel_init_freeable+0x42f/0x5d0 init/main.c:1551
 kernel_init+0x1d/0x2a0 init/main.c:1441
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88802b3d6f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88802b3d6f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88802b3d7000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff88802b3d7080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802b3d7100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

