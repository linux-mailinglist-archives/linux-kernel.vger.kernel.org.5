Return-Path: <linux-kernel+bounces-126870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 307F889423A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 18:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 219961C21A15
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4B14AEF6;
	Mon,  1 Apr 2024 16:50:36 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6386340876
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 16:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711990235; cv=none; b=TvT5nv62sHxRulvYjzcKG1X9OrnX/hqNCSQ4jQpHX8lCHSrV0E9qlncBENJrcxhcLQPuVwpe6Z73VpTnoRjyqT2sI8iFH3f58vmjxuu9onCY1kpxKKm91Ec+j5XSkz9jRU+O+0ODP5XH7lRl3VBqIKuOXlDSjxohdgTyzYePUqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711990235; c=relaxed/simple;
	bh=bZXcFJJP+773blryEuHSCEo+hf2b81ll8AoGEz6Jtbk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=G/HFAn2v7tjizwDAQ3BIgUbIZhVRcaAAlXvwatWYE5EikhxYdRXRWYSfe0TdRc9G6q1S2LGtICEYQRnT1+Ipy0znYvS34kolPT6p91gFxzebLa7Hz42yL/MlLvM50P9UIWY7lzDl682Tc3KmuLQrMsRf4DLKKVWtEaWPUMmipoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7d096c4d663so450619239f.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 09:50:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711990232; x=1712595032;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S01sG59m3tk+kToJdb3TFv3qbuOhbOI54TKa1NiTKuE=;
        b=YWgGvLZFtK/KBFoSkcFRRqTwz4I4uOZWeoHkvEnyNgQoJf2VfYaU6MHFOFPqYWz/7d
         fW+We2fiVQVKXLNs1LY+7HUs824Rpjd8k2liYxdgzRPCMO6jZdr16Tf60BL7f8mtOh8T
         WKu8W19J6Iwn6R+QhWNULelmajmcLDBkrvpDz2Uxex6TrhQjwQ1Nl2GSagUUwFrDHpLM
         eHTcNaF3J8G7DZ4CwWuTQ05DkXWqSEPlik+Lo1rKHFDNBY/NG2vRKpU9Bb7QkZ5EIX8W
         mIATTbDASpU7Umqxd3Vs+PHdwXvsP2umc3s1ium/nfucwHoA6C5B+yqX95H4fEFTayWv
         RSIg==
X-Forwarded-Encrypted: i=1; AJvYcCVXi2U5psHF84GWOWVaooVDiZOPmnS9Ma2mU7VnuN8tZJ/JoBMXmVz/bOUpyUK0mMFGWSGzFwaPmrFMuGe89qvP/2BLzANhYkVHzKct
X-Gm-Message-State: AOJu0Yzi5iADWepGXxmiqquQS4TpE0m14lhIl3riOil4IKuU8gs6jjX3
	Gou7QqMqNGFezL/UyIwwX6apzftMgu/P9QlNAWtfn96aVIH2Y2NUo7STwPqnE5Rrs6S85qSPr1W
	vihKmHgUuV8fyBT5V7qmHTAE/HP4XksVYorx/3qqS0V+CwvrC599bm9k=
X-Google-Smtp-Source: AGHT+IHRX1iLcLhoPsbzNejwXoIDpAUVSisDhR4sra6Z51Yh1GOWCdtaxdxB71U8TmizSDJ9s/1guyKzxhQiY4VWS9X2sShOhq3L
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:188a:b0:369:bc79:92dd with SMTP id
 o10-20020a056e02188a00b00369bc7992ddmr165476ilu.0.1711990232614; Mon, 01 Apr
 2024 09:50:32 -0700 (PDT)
Date: Mon, 01 Apr 2024 09:50:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ac924c06150bc9eb@google.com>
Subject: [syzbot] [usb?] KASAN: slab-use-after-free Write in
 usb_anchor_suspend_wakeups (2)
From: syzbot <syzbot+9a3c54f52bd1edbd975f@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    480e035fc4c7 Merge tag 'drm-next-2024-03-13' of https://gi..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=150cb7fd180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e5b814e91787669
dashboard link: https://syzkaller.appspot.com/bug?extid=9a3c54f52bd1edbd975f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10bd9dd9180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1244fe29180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5f73b6ef963d/disk-480e035f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/46c949396aad/vmlinux-480e035f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e3b4d0f5a5f8/bzImage-480e035f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9a3c54f52bd1edbd975f@syzkaller.appspotmail.com

BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
BUG: KASAN: slab-use-after-free in atomic_inc include/linux/atomic/atomic-instrumented.h:435 [inline]
BUG: KASAN: slab-use-after-free in usb_anchor_suspend_wakeups+0x28/0x40 drivers/usb/core/urb.c:927
Write of size 4 at addr ffff888078ad2910 by task kworker/1:2/1146

CPU: 1 PID: 1146 Comm: kworker/1:2 Not tainted 6.8.0-syzkaller-08073-g480e035fc4c7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue: usb_hub_wq hub_event
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
 instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
 atomic_inc include/linux/atomic/atomic-instrumented.h:435 [inline]
 usb_anchor_suspend_wakeups+0x28/0x40 drivers/usb/core/urb.c:927
 __usb_hcd_giveback_urb+0x25c/0x530 drivers/usb/core/hcd.c:1637
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
RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x70 kernel/kcov.c:200
Code: 89 fb e8 23 00 00 00 48 8b 3d 6c fc 1b 0c 48 89 de 5b e9 23 fb 57 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <f3> 0f 1e fa 48 8b 04 24 65 48 8b 0c 25 80 d0 03 00 65 8b 15 20 db
RSP: 0018:ffffc900051c6f40 EFLAGS: 00000286
RAX: 0000000000000000 RBX: 0000000080000000 RCX: 0000000000000001
RDX: ffff888022de0000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc900051c7020 R08: ffffffff8140ade5 R09: ffffffff8140a8df
R10: 0000000000000003 R11: ffff888022de0000 R12: ffffc900051c7768
R13: dffffc0000000000 R14: ffffc900051c0000 R15: ffffc900051c7770
 unwind_next_frame+0x1e82/0x2a00 arch/x86/kernel/unwind_orc.c:672
 arch_stack_walk+0x151/0x1b0 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xa6/0xe0 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2106 [inline]
 slab_free mm/slub.c:4280 [inline]
 kmem_cache_free+0x102/0x2b0 mm/slub.c:4344
 kernfs_put+0x2a4/0x420 fs/kernfs/dir.c:569
 kernfs_remove_by_name_ns+0xe4/0x160 fs/kernfs/dir.c:1686
 kernfs_remove_by_name include/linux/kernfs.h:623 [inline]
 remove_files fs/sysfs/group.c:28 [inline]
 sysfs_remove_group+0xfe/0x2b0 fs/sysfs/group.c:292
 sysfs_remove_groups+0x54/0xb0 fs/sysfs/group.c:316
 device_remove drivers/base/dd.c:564 [inline]
 __device_release_driver drivers/base/dd.c:1272 [inline]
 device_release_driver_internal+0x45a/0x7c0 drivers/base/dd.c:1295
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
 </TASK>

Allocated by task 5137:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 kmalloc_trace+0x1db/0x360 mm/slub.c:3997
 kmalloc include/linux/slab.h:628 [inline]
 kzalloc include/linux/slab.h:749 [inline]
 usbtmc_open+0x93/0x890 drivers/usb/class/usbtmc.c:175
 usb_open+0x225/0x300 drivers/usb/core/file.c:47
 chrdev_open+0x5b0/0x630 fs/char_dev.c:414
 do_dentry_open+0x907/0x15a0 fs/open.c:955
 do_open fs/namei.c:3642 [inline]
 path_openat+0x2860/0x3240 fs/namei.c:3799
 do_filp_open+0x235/0x490 fs/namei.c:3826
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1406
 do_sys_open fs/open.c:1421 [inline]
 __do_sys_openat fs/open.c:1437 [inline]
 __se_sys_openat fs/open.c:1432 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1432
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

Freed by task 5137:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object+0xa6/0xe0 mm/kasan/common.c:240
 __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2106 [inline]
 slab_free mm/slub.c:4280 [inline]
 kfree+0x14a/0x380 mm/slub.c:4390
 usbtmc_release+0x24f/0x280 drivers/usb/class/usbtmc.c:261
 __fput+0x429/0x8a0 fs/file_table.c:422
 task_work_run+0x24f/0x310 kernel/task_work.c:180
 ptrace_notify+0x2d2/0x380 kernel/signal.c:2404
 ptrace_report_syscall include/linux/ptrace.h:415 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:477 [inline]
 syscall_exit_work+0xbd/0x170 kernel/entry/common.c:167
 syscall_exit_to_user_mode_prepare kernel/entry/common.c:194 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:199 [inline]
 syscall_exit_to_user_mode+0x273/0x360 kernel/entry/common.c:212
 do_syscall_64+0x10a/0x240 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

The buggy address belongs to the object at ffff888078ad2800
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 272 bytes inside of
 freed 1024-byte region [ffff888078ad2800, ffff888078ad2c00)

The buggy address belongs to the physical page:
page:ffffea0001e2b400 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x78ad0
head:ffffea0001e2b400 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888014c41dc0 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5132, tgid 5130 (syz-executor105), ts 66677139821, free_ts 66671264188
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
 kmalloc_trace+0x269/0x360 mm/slub.c:3992
 kmalloc include/linux/slab.h:628 [inline]
 kzalloc include/linux/slab.h:749 [inline]
 usbtmc_open+0x93/0x890 drivers/usb/class/usbtmc.c:175
 usb_open+0x225/0x300 drivers/usb/core/file.c:47
 chrdev_open+0x5b0/0x630 fs/char_dev.c:414
 do_dentry_open+0x907/0x15a0 fs/open.c:955
 do_open fs/namei.c:3642 [inline]
 path_openat+0x2860/0x3240 fs/namei.c:3799
 do_filp_open+0x235/0x490 fs/namei.c:3826
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1406
 do_sys_open fs/open.c:1421 [inline]
 __do_sys_openat fs/open.c:1437 [inline]
 __se_sys_openat fs/open.c:1432 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1432
 do_syscall_64+0xfb/0x240
page last free pid 5138 tgid 5134 stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1140 [inline]
 free_unref_page_prepare+0x968/0xa90 mm/page_alloc.c:2346
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2486
 discard_slab mm/slub.c:2437 [inline]
 __put_partials+0xeb/0x130 mm/slub.c:2906
 put_cpu_partial+0x17c/0x250 mm/slub.c:2981
 __slab_free+0x2ea/0x3d0 mm/slub.c:4151
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x5e/0xc0 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:322
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3798 [inline]
 slab_alloc_node mm/slub.c:3845 [inline]
 kmem_cache_alloc+0x174/0x340 mm/slub.c:3852
 getname_flags+0xbd/0x4f0 fs/namei.c:139
 do_sys_openat2+0xd2/0x1d0 fs/open.c:1400
 do_sys_open fs/open.c:1421 [inline]
 __do_sys_openat fs/open.c:1437 [inline]
 __se_sys_openat fs/open.c:1432 [inline]
 __x64_sys_openat+0x247/0x2a0 fs/open.c:1432
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75

Memory state around the buggy address:
 ffff888078ad2800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888078ad2880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888078ad2900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff888078ad2980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888078ad2a00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
----------------
Code disassembly (best guess):
   0:	89 fb                	mov    %edi,%ebx
   2:	e8 23 00 00 00       	call   0x2a
   7:	48 8b 3d 6c fc 1b 0c 	mov    0xc1bfc6c(%rip),%rdi        # 0xc1bfc7a
   e:	48 89 de             	mov    %rbx,%rsi
  11:	5b                   	pop    %rbx
  12:	e9 23 fb 57 00       	jmp    0x57fb3a
  17:	0f 1f 00             	nopl   (%rax)
  1a:	90                   	nop
  1b:	90                   	nop
  1c:	90                   	nop
  1d:	90                   	nop
  1e:	90                   	nop
  1f:	90                   	nop
  20:	90                   	nop
  21:	90                   	nop
  22:	90                   	nop
  23:	90                   	nop
  24:	90                   	nop
  25:	90                   	nop
  26:	90                   	nop
  27:	90                   	nop
  28:	90                   	nop
  29:	90                   	nop
* 2a:	f3 0f 1e fa          	endbr64 <-- trapping instruction
  2e:	48 8b 04 24          	mov    (%rsp),%rax
  32:	65 48 8b 0c 25 80 d0 	mov    %gs:0x3d080,%rcx
  39:	03 00
  3b:	65                   	gs
  3c:	8b                   	.byte 0x8b
  3d:	15                   	.byte 0x15
  3e:	20 db                	and    %bl,%bl


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

