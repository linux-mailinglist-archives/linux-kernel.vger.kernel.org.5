Return-Path: <linux-kernel+bounces-160947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C61E78B44F8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 09:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2450D283B87
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 07:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1693943AB3;
	Sat, 27 Apr 2024 07:44:19 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7114942062
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 07:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714203858; cv=none; b=SHSwFEDMVo3biy6BE/0TMYG12QmPUrxY9VqZuP+Udw9oXK6OtjaBSsg4KWdLMKb1u0gHjDyW/UhU/j5rITi1GE/xs/h5VVAruP5EGhRP48cg6z199+Cml+gsV6lIFjiBqH9P6r9IuarkppM/goA63dUcqN8eIfbjmEWDWG5h1B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714203858; c=relaxed/simple;
	bh=bjZmVcTDEnNXCR5XjaMeOuY1Qflnsmipj61fzC62U5I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ELPMFC8NgeXYEbSej6jRN2gKa5D98aizVlIy47HEqz2zFx9Dnqw1QI2nS9KNXdHncSD9ToH9azsl7WGqOJQMi/3xqjPoPinoT9bVCh7aRnpL6nlAdARZryVgHX6JDkEYi41Z0Gr2a9/TZEvW8UTv10IPAMr7qBVYM9w2uM6iFAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36c44d70a29so159235ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 00:44:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714203855; x=1714808655;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pwb4eLQhu+E9phBOZbX7TcdQUIpjytF2MxYWpRktvxI=;
        b=C1uQkhIwxOpeDnOX3PsQ/7WEqtBI9ZeyA+A47F5HkzYQpQiC59DVLQdEn2/rmKWkrx
         68ay4Hbiu1wxObJJEkVQQIvzZFjY41MJTM62/Y1BNNCSZwtcN9mWeOmb4JYYuTMuc3jB
         y1aBrOENX700cTgfenlmxlT7RF5/vQYFzc9CgVMrqQHnrezzR2xTbSTh/4Ovf2yS5uhj
         ycTIrCVsS2RItUjK92/zwfgUuYkdtuvdLlB53OSmOCes+257re4wB1pgeB5IPplZBpGp
         re6WA+7oRjwWSIz2SPtasecSyyxflPFjugmGJ9Ijz4Jxr+fc4U+DFflNoHNtku8rhZWq
         wxMg==
X-Forwarded-Encrypted: i=1; AJvYcCVdAdDzQc7G7rVtubcTWfsTPrBTPq9/tllSXRMy50L9pzGqmc0Bbh7ahqE6Q04yobpbhNfdSEmjS8NTH1mD/Afabwpl2uphB+u/1MzI
X-Gm-Message-State: AOJu0YxGUaBiYUscne45Je6oyxGvvCgf7ByihVCQ3lL98UzUJTF7wHTj
	o9G7kyaxOl5OwNFuKs0Bo74voOMX8HhLi5ZkVU0W4D+5FaxJrSpX2NHOagnm+/UEt04aotyZP5l
	v/qTlqKFE9sGgYBCUoL5q4duK+AXOQlLlfCFgWqxozKfYKkwy53NPG3Y=
X-Google-Smtp-Source: AGHT+IGSzMAz8EpfPqpwUtsE5zhTSGQxjAAWASpm2YVyZHYPFhmYkfmoNihjL/1nwCT1ruGEFluirxb88/P3HtkjU8yL6uAjkNR6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd88:0:b0:36a:3fb0:c96b with SMTP id
 r8-20020a92cd88000000b0036a3fb0c96bmr166042ilb.1.1714203855693; Sat, 27 Apr
 2024 00:44:15 -0700 (PDT)
Date: Sat, 27 Apr 2024 00:44:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e43c5106170f2fb4@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in l2cap_recv_frame
From: syzbot <syzbot+5c915dc5dd417b83b348@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4d2008430ce8 Merge tag 'docs-6.9-fixes2' of git://git.lwn...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14555ae7180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=98d5a8e00ed1044a
dashboard link: https://syzkaller.appspot.com/bug?extid=5c915dc5dd417b83b348
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=176f9880980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5670e5771b96/disk-4d200843.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/03314e6c8879/vmlinux-4d200843.xz
kernel image: https://storage.googleapis.com/syzbot-assets/41aca7a9505a/bzImage-4d200843.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5c915dc5dd417b83b348@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in l2cap_connect net/bluetooth/l2cap_core.c:3920 [inline]
BUG: KASAN: slab-use-after-free in l2cap_connect_req net/bluetooth/l2cap_core.c:4061 [inline]
BUG: KASAN: slab-use-after-free in l2cap_bredr_sig_cmd net/bluetooth/l2cap_core.c:4759 [inline]
BUG: KASAN: slab-use-after-free in l2cap_sig_channel net/bluetooth/l2cap_core.c:5533 [inline]
BUG: KASAN: slab-use-after-free in l2cap_recv_frame+0x19ca/0x107c0 net/bluetooth/l2cap_core.c:6793
Read of size 8 at addr ffff88802ab26000 by task kworker/u9:7/5103

CPU: 0 PID: 5103 Comm: kworker/u9:7 Not tainted 6.9.0-rc5-syzkaller-00007-g4d2008430ce8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue: hci3 hci_rx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 l2cap_connect net/bluetooth/l2cap_core.c:3920 [inline]
 l2cap_connect_req net/bluetooth/l2cap_core.c:4061 [inline]
 l2cap_bredr_sig_cmd net/bluetooth/l2cap_core.c:4759 [inline]
 l2cap_sig_channel net/bluetooth/l2cap_core.c:5533 [inline]
 l2cap_recv_frame+0x19ca/0x107c0 net/bluetooth/l2cap_core.c:6793
 hci_acldata_packet net/bluetooth/hci_core.c:3939 [inline]
 hci_rx_work+0x50f/0xca0 net/bluetooth/hci_core.c:4176
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa10/0x17c0 kernel/workqueue.c:3335
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

Allocated by task 5096:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 kmalloc_trace+0x1db/0x360 mm/slub.c:3997
 kmalloc include/linux/slab.h:628 [inline]
 kzalloc include/linux/slab.h:749 [inline]
 l2cap_conn_add+0xa9/0x9c0 net/bluetooth/l2cap_core.c:6836
 l2cap_connect_cfm+0x136/0x1220 net/bluetooth/l2cap_core.c:7227
 hci_connect_cfm include/net/bluetooth/hci_core.h:2007 [inline]
 hci_remote_features_evt+0x68b/0xa70 net/bluetooth/hci_event.c:3778
 hci_event_func net/bluetooth/hci_event.c:7542 [inline]
 hci_event_packet+0xac0/0x1540 net/bluetooth/hci_event.c:7594
 hci_rx_work+0x3e8/0xca0 net/bluetooth/hci_core.c:4171
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa10/0x17c0 kernel/workqueue.c:3335
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Freed by task 5102:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xa6/0xe0 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2106 [inline]
 slab_free mm/slub.c:4280 [inline]
 kfree+0x153/0x3a0 mm/slub.c:4390
 l2cap_connect_cfm+0x11f/0x1220 net/bluetooth/l2cap_core.c:7223
 hci_connect_cfm include/net/bluetooth/hci_core.h:2007 [inline]
 hci_conn_failed+0x1f6/0x340 net/bluetooth/hci_conn.c:1230
 hci_abort_conn_sync+0x583/0xde0 net/bluetooth/hci_sync.c:5567
 hci_cmd_sync_work+0x22b/0x400 net/bluetooth/hci_sync.c:310
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa10/0x17c0 kernel/workqueue.c:3335
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

Last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:541
 insert_work+0x3e/0x330 kernel/workqueue.c:2248
 __queue_work+0xc24/0xef0 kernel/workqueue.c:2400
 call_timer_fn+0x18e/0x650 kernel/time/timer.c:1793
 expire_timers kernel/time/timer.c:1839 [inline]
 __run_timers kernel/time/timer.c:2418 [inline]
 __run_timer_base+0x695/0x8e0 kernel/time/timer.c:2429
 run_timer_base kernel/time/timer.c:2438 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2448
 __do_softirq+0x2c6/0x980 kernel/softirq.c:554

Second to last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:47
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:541
 insert_work+0x3e/0x330 kernel/workqueue.c:2248
 __queue_work+0xb00/0xef0 kernel/workqueue.c:2404
 queue_work_on+0x14f/0x250 kernel/workqueue.c:2435
 queue_work include/linux/workqueue.h:605 [inline]
 l2cap_conn_ready net/bluetooth/l2cap_core.c:1613 [inline]
 l2cap_connect_cfm+0xec2/0x1220 net/bluetooth/l2cap_core.c:7268
 hci_connect_cfm include/net/bluetooth/hci_core.h:2007 [inline]
 hci_remote_features_evt+0x68b/0xa70 net/bluetooth/hci_event.c:3778
 hci_event_func net/bluetooth/hci_event.c:7542 [inline]
 hci_event_packet+0xac0/0x1540 net/bluetooth/hci_event.c:7594
 hci_rx_work+0x3e8/0xca0 net/bluetooth/hci_core.c:4171
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa10/0x17c0 kernel/workqueue.c:3335
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

The buggy address belongs to the object at ffff88802ab26000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 0 bytes inside of
 freed 1024-byte region [ffff88802ab26000, ffff88802ab26400)

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88802ab27000 pfn:0x2ab20
head: order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff80000000a40(workingset|slab|head|node=0|zone=1|lastcpupid=0xfff)
page_type: 0xffffffff()
raw: 00fff80000000a40 ffff888015041dc0 ffffea0000b7c210 ffffea00008af410
raw: ffff88802ab27000 000000000010000e 00000001ffffffff 0000000000000000
head: 00fff80000000a40 ffff888015041dc0 ffffea0000b7c210 ffffea00008af410
head: ffff88802ab27000 000000000010000e 00000001ffffffff 0000000000000000
head: 00fff80000000003 ffffea0000aac801 ffffea0000aac848 00000000ffffffff
head: 0000000800000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid -1362480974 (swapper/0), ts 1, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1534
 prep_new_page mm/page_alloc.c:1541 [inline]
 get_page_from_freelist+0x3410/0x35b0 mm/page_alloc.c:3317
 __alloc_pages+0x256/0x6c0 mm/page_alloc.c:4575
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page+0x5f/0x160 mm/slub.c:2175
 allocate_slab mm/slub.c:2338 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2391
 ___slab_alloc+0xc73/0x1260 mm/slub.c:3525
 __slab_alloc mm/slub.c:3610 [inline]
 __slab_alloc_node mm/slub.c:3663 [inline]
 slab_alloc_node mm/slub.c:3835 [inline]
 kmalloc_trace+0x269/0x360 mm/slub.c:3992
 kmalloc include/linux/slab.h:628 [inline]
 kzalloc include/linux/slab.h:749 [inline]
 fqdir_init+0x59/0x170 net/ipv4/inet_fragment.c:192
 lowpan_frags_init_net+0x33/0x310 net/ieee802154/6lowpan/reassembly.c:453
 ops_init+0x352/0x610 net/core/net_namespace.c:136
 __register_pernet_operations net/core/net_namespace.c:1243 [inline]
 register_pernet_operations+0x2cb/0x660 net/core/net_namespace.c:1312
 register_pernet_subsys+0x28/0x40 net/core/net_namespace.c:1353
 lowpan_net_frag_init+0xb2/0x100 net/ieee802154/6lowpan/reassembly.c:538
 lowpan_init_module+0x10/0x90 net/ieee802154/6lowpan/core.c:250
 do_one_initcall+0x248/0x880 init/main.c:1245
 do_initcall_level+0x157/0x210 init/main.c:1307
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88802ab25f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88802ab25f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88802ab26000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff88802ab26080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802ab26100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

