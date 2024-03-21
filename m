Return-Path: <linux-kernel+bounces-109614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB553881B69
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 04:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFA3A1C214DC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 03:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE60749C;
	Thu, 21 Mar 2024 03:10:07 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF496FBF
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 03:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710990606; cv=none; b=hIV1Th5xzKllxek0MIqkIWdCrwEkQaZg14jrfo4v+IvgIAxdNevxYmZb2wtmnAmRDQ6zg1bS39adb8mZq2wY26YVpig1nFXmvucOO1s29o6Fd1JtBaQq+j9G+rTavyVMyjPjf5oga4/ZAcCn672XDxlqWlD7OJ7tR1JksUGl4cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710990606; c=relaxed/simple;
	bh=l7ls7/t50sFzw3p42bJmr+zxYgLgDgVH1zDgLr/4SNQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=N71G6FApv53RuZQxJKO/97FOO7ZjE+0xeQXi0PJ9WZE4uVShMvOFpHJtcbl24EUm6AZAAtDnhY77Q4OIcYZ7FKUzMGbEiBALkQGDIuONfAQvIXOxwayFXz/Pvd5S2h6wykTXrXgEH/hD0p7HUJZK7laoGTMHlmKeIT1QdDAVm/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cb806fc9f7so50493739f.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 20:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710990604; x=1711595404;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rzh97IfamFkLuWIyoyKFs+OGWLAQdTvdcEXR34jZbaQ=;
        b=H6fMkiYnj3mNn16qxjKU3MYFYI3PAEI4iC7WZ2GEKfFIiPhfgZfTLewilQjOv20AgO
         j4cjBFgrGnBvT6E/GqhWI9VH6jAx4Evfe5SzSZbHIh+i+k8QLOHEA2TbiVIQt2Lp9w0t
         n6Ihp8i1qFdR8ZQHIbQQvfu5KFzuKP+5nCMH806R7fktz2V3H2JeXKdE7i5AjfkkY7xO
         EknPR8/j+bjI+sXitBkhF6uQSUqe22sEjs7ppwsmuVUzZuGcrvz9//HwLoehZrT20s95
         n447GS712YePgH4NLPwHxrg5LkU+ranvv5AJFHreWjcE5d089sqogrWpgveu1B5RKrdc
         df3w==
X-Forwarded-Encrypted: i=1; AJvYcCWoCOzGXJOe53GTMiCycai4FNNnze8+uoGKRbwt12w8Q7r2nmdzr9CZv5rXpOf3OIffU6foPhrCGPSbEOOOCUC9o4on2jGXpP0lDq1w
X-Gm-Message-State: AOJu0YyuHFrq8jn/vir6oOKCn3MqcX6C3LPG2CeU+RVo4qMSU29s6Q1q
	Q81YJ9sV3+suEj+A8xx+p8Og52DtRlFNb7kYkuf/7GjD+RxMwpOMc9sNSsmSV+8+Zsk4xCGF1l3
	1wgLEr2aNkLmRb8cMaeNkWncgUdQaKKdh5M1x369duClOB9zmC/vtB4U=
X-Google-Smtp-Source: AGHT+IGxaCEoGJSoVJ4VQIPemHCAEQvT9ph7eJIxjLryZMga0bTw0AfTcKl2QVcexD4jmB8/8NHpjTYNso660FtT5be97bNdFuxU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2b23:b0:474:7952:8ab6 with SMTP id
 fm35-20020a0566382b2300b0047479528ab6mr403313jab.5.1710990603873; Wed, 20 Mar
 2024 20:10:03 -0700 (PDT)
Date: Wed, 20 Mar 2024 20:10:03 -0700
In-Reply-To: <tencent_53C96CD89554EA8AEF32CD2C784E6D202F0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002884070614230beb@google.com>
Subject: Re: [syzbot] [wireless?] [usb?] UBSAN: array-index-out-of-bounds in htc_issue_send
From: syzbot <syzbot+93cbd5fbb85814306ba1@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Read in hif_usb_regout_cb

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: slab-use-after-free in atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
BUG: KASAN: slab-use-after-free in refcount_read include/linux/refcount.h:136 [inline]
BUG: KASAN: slab-use-after-free in skb_unref include/linux/skbuff.h:1227 [inline]
BUG: KASAN: slab-use-after-free in __kfree_skb_reason net/core/skbuff.c:1116 [inline]
BUG: KASAN: slab-use-after-free in kfree_skb_reason+0x36/0x210 net/core/skbuff.c:1143
Read of size 4 at addr ffff888121db8c1c by task swapper/0/0

CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.8.0-rc6-syzkaller-00190-ga788e53c05ae-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:488
 kasan_report+0xda/0x110 mm/kasan/report.c:601
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0xef/0x190 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
 refcount_read include/linux/refcount.h:136 [inline]
 skb_unref include/linux/skbuff.h:1227 [inline]
 __kfree_skb_reason net/core/skbuff.c:1116 [inline]
 kfree_skb_reason+0x36/0x210 net/core/skbuff.c:1143
 kfree_skb include/linux/skbuff.h:1244 [inline]
 hif_usb_regout_cb+0x15f/0x1d0 drivers/net/wireless/ath/ath9k/hif_usb.c:95
 __usb_hcd_giveback_urb+0x359/0x5c0 drivers/usb/core/hcd.c:1648
 usb_hcd_giveback_urb+0x389/0x430 drivers/usb/core/hcd.c:1731
 dummy_timer+0x1415/0x3600 drivers/usb/gadget/udc/dummy_hcd.c:1987
 call_timer_fn+0x193/0x590 kernel/time/timer.c:1700
 expire_timers kernel/time/timer.c:1751 [inline]
 __run_timers+0x759/0xaa0 kernel/time/timer.c:2038
 run_timer_softirq+0x58/0xd0 kernel/time/timer.c:2051
 __do_softirq+0x20a/0x8c1 kernel/softirq.c:553
 invoke_softirq kernel/softirq.c:427 [inline]
 __irq_exit_rcu kernel/softirq.c:632 [inline]
 irq_exit_rcu+0xa7/0x110 kernel/softirq.c:644
 sysvec_apic_timer_interrupt+0x90/0xb0 arch/x86/kernel/apic/apic.c:1076
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:649
RIP: 0010:native_irq_disable arch/x86/include/asm/irqflags.h:37 [inline]
RIP: 0010:arch_local_irq_disable arch/x86/include/asm/irqflags.h:72 [inline]
RIP: 0010:acpi_safe_halt+0x1b/0x20 drivers/acpi/processor_idle.c:113
Code: ed c3 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 65 48 8b 04 25 c0 b0 03 00 48 8b 00 a8 08 75 0c 66 90 0f 00 2d e7 5b 58 00 fb f4 <fa> c3 0f 1f 00 0f b6 47 08 3c 01 74 0b 3c 02 74 05 8b 7f 04 eb 9f
RSP: 0018:ffffffff87c07d68 EFLAGS: 00000246
RAX: 0000000000004000 RBX: 0000000000000001 RCX: ffffffff86574aa7
RDX: 0000000000000001 RSI: ffff88810369d800 RDI: ffff88810369d864
RBP: ffff88810369d864 R08: 0000000000000001 R09: ffffed103ecc6da5
R10: ffff8881f6636d2b R11: 0000000000000000 R12: ffff88810fec8000
R13: ffffffff88308580 R14: 0000000000000000 R15: 0000000000000000
 acpi_idle_enter+0xc5/0x160 drivers/acpi/processor_idle.c:707
 cpuidle_enter_state+0x83/0x500 drivers/cpuidle/cpuidle.c:267
 cpuidle_enter+0x4e/0xa0 drivers/cpuidle/cpuidle.c:388
 cpuidle_idle_call kernel/sched/idle.c:215 [inline]
 do_idle+0x319/0x400 kernel/sched/idle.c:312
 cpu_startup_entry+0x50/0x60 kernel/sched/idle.c:410
 rest_init+0x16f/0x2b0 init/main.c:730
 arch_call_rest_init+0x13/0x30 init/main.c:827
 start_kernel+0x39a/0x480 init/main.c:1072
 x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:555
 x86_64_start_kernel+0xb2/0xc0 arch/x86/kernel/head64.c:536
 secondary_startup_64_no_verify+0x15e/0x16b
 </TASK>

Allocated by task 2166:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:314 [inline]
 __kasan_slab_alloc+0x66/0x70 mm/kasan/common.c:340
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3813 [inline]
 slab_alloc_node mm/slub.c:3860 [inline]
 kmem_cache_alloc_node+0x156/0x310 mm/slub.c:3903
 __alloc_skb+0x287/0x330 net/core/skbuff.c:641
 alloc_skb include/linux/skbuff.h:1296 [inline]
 htc_connect_service+0x2d7/0x9f0 drivers/net/wireless/ath/ath9k/htc_hst.c:265
 ath9k_wmi_connect+0xf1/0x1c0 drivers/net/wireless/ath/ath9k/wmi.c:275
 ath9k_init_htc_services.constprop.0+0xb3/0x820 drivers/net/wireless/ath/ath9k/htc_drv_init.c:146
 ath9k_htc_probe_device+0x23f/0x25f0 drivers/net/wireless/ath/ath9k/htc_drv_init.c:959
 ath9k_htc_hw_init+0x33/0x70 drivers/net/wireless/ath/ath9k/htc_hst.c:533
 ath9k_hif_usb_firmware_cb+0x272/0x620 drivers/net/wireless/ath/ath9k/hif_usb.c:1273
 request_firmware_work_func+0x13a/0x240 drivers/base/firmware_loader/main.c:1163
 process_one_work+0x886/0x15d0 kernel/workqueue.c:2633
 process_scheduled_works kernel/workqueue.c:2706 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2787
 kthread+0x2c6/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:243

Freed by task 2166:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 kasan_save_free_info+0x3f/0x60 mm/kasan/generic.c:643
 poison_slab_object mm/kasan/common.c:241 [inline]
 __kasan_slab_free+0x106/0x1b0 mm/kasan/common.c:257
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2121 [inline]
 slab_free mm/slub.c:4299 [inline]
 kmem_cache_free+0x10a/0x330 mm/slub.c:4363
 kfree_skbmem+0xef/0x1b0 net/core/skbuff.c:1051
 __kfree_skb net/core/skbuff.c:1109 [inline]
 kfree_skb_reason+0x13a/0x210 net/core/skbuff.c:1144
 kfree_skb include/linux/skbuff.h:1244 [inline]
 htc_connect_service+0x641/0x9f0 drivers/net/wireless/ath/ath9k/htc_hst.c:304
 ath9k_wmi_connect+0xf1/0x1c0 drivers/net/wireless/ath/ath9k/wmi.c:275
 ath9k_init_htc_services.constprop.0+0xb3/0x820 drivers/net/wireless/ath/ath9k/htc_drv_init.c:146
 ath9k_htc_probe_device+0x23f/0x25f0 drivers/net/wireless/ath/ath9k/htc_drv_init.c:959
 ath9k_htc_hw_init+0x33/0x70 drivers/net/wireless/ath/ath9k/htc_hst.c:533
 ath9k_hif_usb_firmware_cb+0x272/0x620 drivers/net/wireless/ath/ath9k/hif_usb.c:1273
 request_firmware_work_func+0x13a/0x240 drivers/base/firmware_loader/main.c:1163
 process_one_work+0x886/0x15d0 kernel/workqueue.c:2633
 process_scheduled_works kernel/workqueue.c:2706 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2787
 kthread+0x2c6/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:243

The buggy address belongs to the object at ffff888121db8b40
 which belongs to the cache skbuff_head_cache of size 232
The buggy address is located 220 bytes inside of
 freed 232-byte region [ffff888121db8b40, ffff888121db8c28)

The buggy address belongs to the physical page:
page:ffffea0004876e00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x121db8
anon flags: 0x200000000000800(slab|node=0|zone=2)
page_type: 0xffffffff()
raw: 0200000000000800 ffff8881026d7000 ffffea000440c480 dead000000000005
raw: 0000000000000000 00000000800c000c 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY), pid 2477, tgid 2477 (sshd), ts 29846224506, free_ts 29763017245
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2d0/0x350 mm/page_alloc.c:1533
 prep_new_page mm/page_alloc.c:1540 [inline]
 get_page_from_freelist+0x139c/0x3470 mm/page_alloc.c:3311
 __alloc_pages+0x228/0x2250 mm/page_alloc.c:4567
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 alloc_slab_page mm/slub.c:2190 [inline]
 allocate_slab mm/slub.c:2354 [inline]
 new_slab+0xcc/0x3a0 mm/slub.c:2407
 ___slab_alloc+0x4b0/0x1860 mm/slub.c:3540
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3625
 __slab_alloc_node mm/slub.c:3678 [inline]
 slab_alloc_node mm/slub.c:3850 [inline]
 kmem_cache_alloc_node+0x286/0x310 mm/slub.c:3903
 __alloc_skb+0x287/0x330 net/core/skbuff.c:641
 alloc_skb include/linux/skbuff.h:1296 [inline]
 __tcp_send_ack.part.0+0x64/0x720 net/ipv4/tcp_output.c:4206
 __tcp_send_ack net/ipv4/tcp_output.c:4238 [inline]
 tcp_send_ack+0x82/0xa0 net/ipv4/tcp_output.c:4238
 __tcp_cleanup_rbuf+0x278/0x4b0 net/ipv4/tcp.c:1491
 tcp_recvmsg_locked+0x113a/0x2450 net/ipv4/tcp.c:2547
 tcp_recvmsg+0x12e/0x670 net/ipv4/tcp.c:2577
 inet_recvmsg+0x114/0x630 net/ipv4/af_inet.c:882
 sock_recvmsg_nosec net/socket.c:1046 [inline]
 sock_recvmsg+0xe2/0x170 net/socket.c:1068
 sock_read_iter+0x2c3/0x3c0 net/socket.c:1138
page last free pid 2479 tgid 2479 stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1140 [inline]
 free_unref_page_prepare+0x504/0xae0 mm/page_alloc.c:2346
 free_unref_page+0x33/0x2d0 mm/page_alloc.c:2486
 __folio_put_small mm/swap.c:106 [inline]
 __folio_put+0x83/0xb0 mm/swap.c:129
 folio_put include/linux/mm.h:1494 [inline]
 put_page include/linux/mm.h:1563 [inline]
 anon_pipe_buf_release+0x36c/0x430 fs/pipe.c:138
 pipe_buf_release include/linux/pipe_fs_i.h:219 [inline]
 pipe_update_tail fs/pipe.c:234 [inline]
 pipe_read+0x6fc/0x1020 fs/pipe.c:354
 call_read_iter include/linux/fs.h:2081 [inline]
 new_sync_read fs/read_write.c:395 [inline]
 vfs_read+0x9f3/0xb70 fs/read_write.c:476
 ksys_read+0x1f0/0x250 fs/read_write.c:619
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd3/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Memory state around the buggy address:
 ffff888121db8b00: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
 ffff888121db8b80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888121db8c00: fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc
                            ^
 ffff888121db8c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888121db8d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc
==================================================================
----------------
Code disassembly (best guess):
   0:	ed                   	in     (%dx),%eax
   1:	c3                   	ret
   2:	66 66 2e 0f 1f 84 00 	data16 cs nopw 0x0(%rax,%rax,1)
   9:	00 00 00 00
   d:	66 90                	xchg   %ax,%ax
   f:	65 48 8b 04 25 c0 b0 	mov    %gs:0x3b0c0,%rax
  16:	03 00
  18:	48 8b 00             	mov    (%rax),%rax
  1b:	a8 08                	test   $0x8,%al
  1d:	75 0c                	jne    0x2b
  1f:	66 90                	xchg   %ax,%ax
  21:	0f 00 2d e7 5b 58 00 	verw   0x585be7(%rip)        # 0x585c0f
  28:	fb                   	sti
  29:	f4                   	hlt
* 2a:	fa                   	cli <-- trapping instruction
  2b:	c3                   	ret
  2c:	0f 1f 00             	nopl   (%rax)
  2f:	0f b6 47 08          	movzbl 0x8(%rdi),%eax
  33:	3c 01                	cmp    $0x1,%al
  35:	74 0b                	je     0x42
  37:	3c 02                	cmp    $0x2,%al
  39:	74 05                	je     0x40
  3b:	8b 7f 04             	mov    0x4(%rdi),%edi
  3e:	eb 9f                	jmp    0xffffffdf


Tested on:

commit:         a788e53c usb: usb-acpi: Fix oops due to freeing uninit..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=162fafc1180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dd8c589043bc2b49
dashboard link: https://syzkaller.appspot.com/bug?extid=93cbd5fbb85814306ba1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=120566be180000


