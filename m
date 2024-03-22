Return-Path: <linux-kernel+bounces-111866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D57748871E0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BD8B1F23024
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4725FBBB;
	Fri, 22 Mar 2024 17:26:28 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12375E3AF
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 17:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711128387; cv=none; b=PbbTh7dqVdcRyl4rc4RlWsiMzQeMMWaFFcpv4SxFtXM0BMLfL0OyTAvDWBI+hElQeNE8BwWFd8cyeY3F/zaZLCbGJWBvxNVUbnIMFR1x53H1NruEYWZWXi7V+fTEarjuXyj9KbRuEOHdHIqxhXlygM/1K7QPt1XvP49KIAybLsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711128387; c=relaxed/simple;
	bh=2CKlv4+T3vj39SBEUKoS2DPuXIpvy/3FoZqU2TjnnR0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=SJi5XVqbbGvvs8yWHZX/E9QrbI/FUmKLqtoo0Hps/BXEWqYcBfNINTR70U15pIOZvHnPLq4Pk012ZXdo7E+epMCZdQDB2JzakrdI3aelgT5H9tUza9mN/ZpoqlTNYUApJQTYf4tRB84XJ9dLh62R/U0YuDUsQnKT4ovEze5dP4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36850d89e64so24050035ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 10:26:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711128385; x=1711733185;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XYXZlVsCre4i8XQwEHc1ovgUMqljeJWzH2iHLGCbKkY=;
        b=KRi55gfk0ReOY2oGRhuum4oyqCV0UNM1aTanpkctZ2qY2cT1IwDescJ7LrV4CRgH9t
         PNyhpP8D1fc9N3kAjOFIhDOWTYWVZRrt4zXn3TOmvSkeVDlrr5QYWeeWlc5AOq+1nsh+
         LaOMTwrevUs34pvmnj3ETxhGM8q/I3DhrjGBupYxc8Z5yCeWjFZOE3tUDu/+fywWr9R6
         PQai7mbYXTpSddizB9X+WsnLsTgdzXqJtFe7rSWW83BazRf2KjExvBURPtSKBTm2XXoH
         3ijSQdrp8ujM4xpDgJRvkcxldCjBVC6V+fkSR9vZbaRNYLNOLAAmo6LACXc1k4nj9Tiz
         iKdg==
X-Forwarded-Encrypted: i=1; AJvYcCUZAAREGBVO3Cgh0MK8JBOCUEGn0fhCz5BqaS4HFadhC4EN0YLK7TXcU9PREJKYG0KCYO6G+a7uYpn0WOcx/1dn63JLV3q/VRBXsn+w
X-Gm-Message-State: AOJu0YzegNLp34kB8zxTYZ0YKgTgRYT1t8q13RMU+vE3F97bLvvPa+g7
	CHLQ9mPZLS5TaLJ29Y909wFZBwiLvr8WvM9FOBmwQNeMGnN7XdHcUSwDoM3CongPMCk6KShNkGp
	XoRKKtIEn8yb5QOUKYfd/te16KgO53TqV+EWNyDgUpNOHP8uGFoCFe04=
X-Google-Smtp-Source: AGHT+IFOucJOm6usN4h7L1CkochZx0y/BKfEredQ9/vq/XXYBFE/enVConp/yiYTk0xOrFq3UZsVQKctNJO2OIuC9iVgtJa40aIR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3001:b0:366:bcbd:ed9e with SMTP id
 bd1-20020a056e02300100b00366bcbded9emr1687ilb.3.1711128385159; Fri, 22 Mar
 2024 10:26:25 -0700 (PDT)
Date: Fri, 22 Mar 2024 10:26:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000090170a0614431f47@google.com>
Subject: [syzbot] [usb?] KASAN: slab-use-after-free Read in
 __usb_hcd_giveback_urb (2)
From: syzbot <syzbot+7f5e98b052c766f47f68@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    480e035fc4c7 Merge tag 'drm-next-2024-03-13' of https://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=125789be180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e5b814e91787669
dashboard link: https://syzkaller.appspot.com/bug?extid=7f5e98b052c766f47f68
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5f73b6ef963d/disk-480e035f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/46c949396aad/vmlinux-480e035f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e3b4d0f5a5f8/bzImage-480e035f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7f5e98b052c766f47f68@syzkaller.appspotmail.com

xpad 1-1:179.65: xpad_irq_in - usb_submit_urb failed with result -19
xpad 1-1:179.65: xpad_irq_out - usb_submit_urb failed with result -19
==================================================================
BUG: KASAN: slab-use-after-free in register_lock_class+0x8d1/0x980 kernel/locking/lockdep.c:1333
Read of size 1 at addr ffff88809222f091 by task syz-executor.1/5107

CPU: 1 PID: 5107 Comm: syz-executor.1 Not tainted 6.8.0-syzkaller-08073-g480e035fc4c7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 register_lock_class+0x8d1/0x980 kernel/locking/lockdep.c:1333
 __lock_acquire+0xda/0x1fd0 kernel/locking/lockdep.c:5014
 lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
 __wake_up_common_lock+0x25/0x1e0 kernel/sched/wait.c:105
 __usb_hcd_giveback_urb+0x3ac/0x530 drivers/usb/core/hcd.c:1653
 dummy_timer+0x8aa/0x3220 drivers/usb/gadget/udc/dummy_hcd.c:1987
 call_timer_fn+0x17e/0x600 kernel/time/timer.c:1792
 expire_timers kernel/time/timer.c:1843 [inline]
 __run_timers kernel/time/timer.c:2408 [inline]
 __run_timer_base+0x66a/0x8e0 kernel/time/timer.c:2419
 run_timer_base kernel/time/timer.c:2428 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2438
 __do_softirq+0x2bc/0x943 kernel/softirq.c:554
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf2/0x1c0 kernel/softirq.c:633
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:645
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:ptep_get include/linux/pgtable.h:291 [inline]
RIP: 0010:copy_pte_range mm/memory.c:1075 [inline]
RIP: 0010:copy_pmd_range mm/memory.c:1187 [inline]
RIP: 0010:copy_pud_range mm/memory.c:1224 [inline]
RIP: 0010:copy_p4d_range mm/memory.c:1248 [inline]
RIP: 0010:copy_page_range+0x11c2/0x4240 mm/memory.c:1346
Code: 00 e8 b2 45 b5 ff c7 44 24 3c 00 00 00 00 eb 09 89 5c 24 3c e8 9f 45 b5 ff 48 8b 5c 24 20 49 89 de 49 c1 ee 03 43 80 3c 2e 00 <74> 08 48 89 df e8 a4 94 18 00 48 8b 1b 48 8d bc 24 80 03 00 00 48
RSP: 0018:ffffc9000441f400 EFLAGS: 00000246
RAX: ffffffff81dfafb1 RBX: ffff888029b8d958 RCX: ffff88807966bc00
RDX: 0000000000000000 RSI: 0000000000000018 RDI: 000000000000001f
RBP: ffffc9000441f8b0 R08: ffffffff81dfae98 R09: 1ffffffff1f0e59d
R10: dffffc0000000000 R11: fffffbfff1f0e59e R12: ffff88802c9bea00
R13: dffffc0000000000 R14: 1ffff11005371b2b R15: 8000000085de3007
 dup_mmap kernel/fork.c:747 [inline]
 dup_mm kernel/fork.c:1687 [inline]
 copy_mm+0x12f5/0x21b0 kernel/fork.c:1736
 copy_process+0x187a/0x3df0 kernel/fork.c:2389
 kernel_clone+0x21e/0x8d0 kernel/fork.c:2796
 __do_sys_clone kernel/fork.c:2939 [inline]
 __se_sys_clone kernel/fork.c:2923 [inline]
 __x64_sys_clone+0x258/0x2a0 kernel/fork.c:2923
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f94a6c7add3
Code: 1f 84 00 00 00 00 00 64 48 8b 04 25 10 00 00 00 45 31 c0 31 d2 31 f6 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 89 c2 85 c0 75 2c 64 48 8b 04 25 10 00 00
RSP: 002b:00007f94a6ecfc58 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f94a6c7add3
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: 000055556a081750 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000001
 </TASK>

Allocated by task 7837:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 kmalloc_trace+0x1db/0x360 mm/slub.c:3997
 kmalloc include/linux/slab.h:628 [inline]
 kzalloc include/linux/slab.h:749 [inline]
 xpad_probe+0x3c8/0x1b90 drivers/input/joystick/xpad.c:2013
 usb_probe_interface+0x5cb/0xb00 drivers/usb/core/driver.c:399
 really_probe+0x29e/0xc50 drivers/base/dd.c:658
 __driver_probe_device+0x1a2/0x3e0 drivers/base/dd.c:800
 driver_probe_device+0x50/0x430 drivers/base/dd.c:830
 __device_attach_driver+0x2d6/0x530 drivers/base/dd.c:958
 bus_for_each_drv+0x24e/0x2e0 drivers/base/bus.c:457
 __device_attach+0x333/0x520 drivers/base/dd.c:1030
 bus_probe_device+0x189/0x260 drivers/base/bus.c:532
 device_add+0x8ff/0xca0 drivers/base/core.c:3639
 usb_set_configuration+0x1976/0x1fb0 drivers/usb/core/message.c:2207
 usb_generic_driver_probe+0x88/0x140 drivers/usb/core/generic.c:254
 usb_probe_device+0x13e/0x2d0 drivers/usb/core/driver.c:294
 really_probe+0x29e/0xc50 drivers/base/dd.c:658
 __driver_probe_device+0x1a2/0x3e0 drivers/base/dd.c:800
 driver_probe_device+0x50/0x430 drivers/base/dd.c:830
 __device_attach_driver+0x2d6/0x530 drivers/base/dd.c:958
 bus_for_each_drv+0x24e/0x2e0 drivers/base/bus.c:457
 __device_attach+0x333/0x520 drivers/base/dd.c:1030
 bus_probe_device+0x189/0x260 drivers/base/bus.c:532
 device_add+0x8ff/0xca0 drivers/base/core.c:3639
 usb_new_device+0x104a/0x19a0 drivers/usb/core/hub.c:2614
 hub_port_connect drivers/usb/core/hub.c:5483 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5623 [inline]
 port_event drivers/usb/core/hub.c:5783 [inline]
 hub_event+0x2d13/0x50f0 drivers/usb/core/hub.c:5865
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243

Freed by task 7828:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xa6/0xe0 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2106 [inline]
 slab_free mm/slub.c:4280 [inline]
 kfree+0x14a/0x380 mm/slub.c:4390
 xpad_disconnect+0x359/0x490 drivers/input/joystick/xpad.c:2194
 usb_unbind_interface+0x1d4/0x850 drivers/usb/core/driver.c:461
 device_remove drivers/base/dd.c:569 [inline]
 __device_release_driver drivers/base/dd.c:1272 [inline]
 device_release_driver_internal+0x503/0x7c0 drivers/base/dd.c:1295
 bus_remove_device+0x34f/0x420 drivers/base/bus.c:574
 device_del+0x581/0xa30 drivers/base/core.c:3828
 usb_disable_device+0x3bf/0x850 drivers/usb/core/message.c:1416
 usb_disconnect+0x340/0x950 drivers/usb/core/hub.c:2267
 hub_port_connect drivers/usb/core/hub.c:5323 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5623 [inline]
 port_event drivers/usb/core/hub.c:5783 [inline]
 hub_event+0x1e62/0x50f0 drivers/usb/core/hub.c:5865
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa00/0x1770 kernel/workqueue.c:3335
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243

The buggy address belongs to the object at ffff88809222f000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 145 bytes inside of
 freed 1024-byte region [ffff88809222f000, ffff88809222f400)

The buggy address belongs to the physical page:
page:ffffea0002488a00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x92228
head:ffffea0002488a00 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888014c41dc0 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5104, tgid 5104 (syz-executor.0), ts 131508902879, free_ts 0
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1533
 prep_new_page mm/page_alloc.c:1540 [inline]
 get_page_from_freelist+0x33ea/0x3580 mm/page_alloc.c:3311
 __alloc_pages+0x256/0x680 mm/page_alloc.c:4569
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page+0x5f/0x160 mm/slub.c:2175
 allocate_slab mm/slub.c:2338 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2391
 ___slab_alloc+0xc73/0x1260 mm/slub.c:3525
 __slab_alloc mm/slub.c:3610 [inline]
 __slab_alloc_node mm/slub.c:3663 [inline]
 slab_alloc_node mm/slub.c:3835 [inline]
 __do_kmalloc_node mm/slub.c:3965 [inline]
 __kmalloc_node+0x2db/0x4e0 mm/slub.c:3973
 kmalloc_node include/linux/slab.h:648 [inline]
 kzalloc_node include/linux/slab.h:760 [inline]
 qdisc_alloc+0x95/0x950 net/sched/sch_generic.c:941
 qdisc_create_dflt+0x62/0x490 net/sched/sch_generic.c:999
 attach_one_default_qdisc net/sched/sch_generic.c:1164 [inline]
 netdev_for_each_tx_queue include/linux/netdevice.h:2500 [inline]
 attach_default_qdiscs net/sched/sch_generic.c:1182 [inline]
 dev_activate+0x3c0/0x1240 net/sched/sch_generic.c:1241
 __dev_open+0x352/0x450 net/core/dev.c:1439
 __dev_change_flags+0x1e2/0x6f0 net/core/dev.c:8683
 dev_change_flags+0x8b/0x1a0 net/core/dev.c:8755
 do_setlink+0xccd/0x41f0 net/core/rtnetlink.c:2884
 __rtnl_newlink net/core/rtnetlink.c:3680 [inline]
 rtnl_newlink+0x180b/0x20a0 net/core/rtnetlink.c:3727
 rtnetlink_rcv_msg+0x89b/0x10d0 net/core/rtnetlink.c:6595
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88809222ef80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88809222f000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88809222f080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff88809222f100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88809222f180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
----------------
Code disassembly (best guess):
   0:	00 e8                	add    %ch,%al
   2:	b2 45                	mov    $0x45,%dl
   4:	b5 ff                	mov    $0xff,%ch
   6:	c7 44 24 3c 00 00 00 	movl   $0x0,0x3c(%rsp)
   d:	00
   e:	eb 09                	jmp    0x19
  10:	89 5c 24 3c          	mov    %ebx,0x3c(%rsp)
  14:	e8 9f 45 b5 ff       	call   0xffb545b8
  19:	48 8b 5c 24 20       	mov    0x20(%rsp),%rbx
  1e:	49 89 de             	mov    %rbx,%r14
  21:	49 c1 ee 03          	shr    $0x3,%r14
  25:	43 80 3c 2e 00       	cmpb   $0x0,(%r14,%r13,1)
* 2a:	74 08                	je     0x34 <-- trapping instruction
  2c:	48 89 df             	mov    %rbx,%rdi
  2f:	e8 a4 94 18 00       	call   0x1894d8
  34:	48 8b 1b             	mov    (%rbx),%rbx
  37:	48 8d bc 24 80 03 00 	lea    0x380(%rsp),%rdi
  3e:	00
  3f:	48                   	rex.W


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

