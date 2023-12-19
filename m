Return-Path: <linux-kernel+bounces-4515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB7A817EB2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 01:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 105A1285E49
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 00:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648A110E4;
	Tue, 19 Dec 2023 00:19:30 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D392568
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 00:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7b7c7f991f3so212468139f.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 16:19:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702945167; x=1703549967;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3nQpN/eRV4Z2x07wBJ3Sju0zAXDmB07aBl6O/3eLZLk=;
        b=UGhOK7FWxDO1/Ps6oXQyi/R/hF6uaSJd4/EjDBS96809T22O3fQ+6FNvPXU7kUURds
         fQa8z3zpn6KbLbWawd+OINgDjVRsibv+2c4RrlBjFg+rmQh0ixyi+kL2VII2VuGDowKg
         pAQ9ZosA2wL+6swtGBd4g+Cy1iqS8AtBFuALmTYPfum0Rrz/qrEaE6E8n9fCM9Dej9i9
         qNrDhQU1I9WtpjuZa3PrIVoMYWNJ4REnc28aaPQ0Rldxf9lEu3JtPimJ2RcVZvtLbs6r
         OU312/zIzhbXoVw3xNlj0wppyE8byRD63938f5u+Q0b9x4YTmYM6NPX/Xpg2gqsjqjhA
         qPsQ==
X-Gm-Message-State: AOJu0YwvT/OjrMU/dKqoSyypVPL864lrPnUxhYOrl0P1j9XWEhrfjVcL
	R0Jpno0pRfjMBrpzYpKnVyD+UeuC7o8CvwOybWd/3p1x62mV
X-Google-Smtp-Source: AGHT+IEDouMV+qxSc1mfL7bXy73QtgTxXrUWwU3SUWgNPg3ZWw5ZIjl1R6XYfZodCQp5X4pI4rTfxlBMz/SjmAkjgMXxDZ6Jrr2F
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:214a:b0:35f:b057:d899 with SMTP id
 d10-20020a056e02214a00b0035fb057d899mr479615ilv.4.1702945167523; Mon, 18 Dec
 2023 16:19:27 -0800 (PST)
Date: Mon, 18 Dec 2023 16:19:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c848d3060cd1d16a@google.com>
Subject: [syzbot] [net?] KASAN: slab-use-after-free Read in advance_sched
From: syzbot <syzbot+b65e0af58423fc8a73aa@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, jhs@mojatatu.com, 
	jiri@resnulli.us, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	vinicius.gomes@intel.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1b666016d0ad net: mvpp2: add support for mii
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14bc6e2ae80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f2346961f26c5509
dashboard link: https://syzkaller.appspot.com/bug?extid=b65e0af58423fc8a73aa
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/192f72b9a0c6/disk-1b666016.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9c20faee44c3/vmlinux-1b666016.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e7886c48d638/bzImage-1b666016.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b65e0af58423fc8a73aa@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in advance_sched+0xc03/0xc60 net/sched/sch_taprio.c:953
Read of size 8 at addr ffff888027fbc910 by task kworker/u4:6/6820

CPU: 0 PID: 6820 Comm: kworker/u4:6 Not tainted 6.7.0-rc4-syzkaller-00954-g1b666016d0ad #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Workqueue: bat_events batadv_purge_orig
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:475
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 advance_sched+0xc03/0xc60 net/sched/sch_taprio.c:953
 __run_hrtimer kernel/time/hrtimer.c:1688 [inline]
 __hrtimer_run_queues+0x203/0xc20 kernel/time/hrtimer.c:1752
 hrtimer_interrupt+0x31b/0x800 kernel/time/hrtimer.c:1814
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1065 [inline]
 __sysvec_apic_timer_interrupt+0x105/0x400 arch/x86/kernel/apic/apic.c:1082
 sysvec_apic_timer_interrupt+0x90/0xb0 arch/x86/kernel/apic/apic.c:1076
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:649
RIP: 0010:lock_acquire+0x1ef/0x520 kernel/locking/lockdep.c:5722
Code: c1 05 6d 69 9a 7e 83 f8 01 0f 85 b4 02 00 00 9c 58 f6 c4 02 0f 85 9f 02 00 00 48 85 ed 74 01 fb 48 b8 00 00 00 00 00 fc ff df <48> 01 c3 48 c7 03 00 00 00 00 48 c7 43 08 00 00 00 00 48 8b 84 24
RSP: 0018:ffffc900042afa88 EFLAGS: 00000206
RAX: dffffc0000000000 RBX: 1ffff92000855f53 RCX: ffffffff81672f5e
RDX: 0000000000000001 RSI: ffffffff8accbc20 RDI: ffffffff8b2f13e0
RBP: 0000000000000200 R08: 0000000000000000 R09: fffffbfff23e2deb
R10: ffffffff91f16f5f R11: 0000000000000002 R12: 0000000000000001
R13: 0000000000000000 R14: ffff88803c2bda18 R15: 0000000000000000
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
 _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:178
 spin_lock_bh include/linux/spinlock.h:356 [inline]
 batadv_purge_orig_ref+0x16d/0x1520 net/batman-adv/originator.c:1271
 batadv_purge_orig+0x19/0x60 net/batman-adv/originator.c:1300
 process_one_work+0x886/0x15d0 kernel/workqueue.c:2627
 process_scheduled_works kernel/workqueue.c:2700 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2781
 kthread+0x2c6/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
 </TASK>

Allocated by task 13485:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:721 [inline]
 taprio_change+0x55a/0x38d0 net/sched/sch_taprio.c:1881
 qdisc_change net/sched/sch_api.c:1387 [inline]
 tc_modify_qdisc+0x7d5/0x1c30 net/sched/sch_api.c:1717
 rtnetlink_rcv_msg+0x3c7/0xe00 net/core/rtnetlink.c:6566
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2544
 netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
 netlink_unicast+0x53b/0x810 net/netlink/af_netlink.c:1367
 netlink_sendmsg+0x8b7/0xd70 net/netlink/af_netlink.c:1909
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0xd5/0x180 net/socket.c:745
 ____sys_sendmsg+0x6ac/0x940 net/socket.c:2584
 ___sys_sendmsg+0x135/0x1d0 net/socket.c:2638
 __sys_sendmsg+0x117/0x1e0 net/socket.c:2667
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Freed by task 13492:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:522
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x15b/0x1b0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:164 [inline]
 slab_free_hook mm/slub.c:1800 [inline]
 slab_free_freelist_hook+0x114/0x1e0 mm/slub.c:1826
 slab_free mm/slub.c:3809 [inline]
 __kmem_cache_free+0xc0/0x180 mm/slub.c:3822
 rcu_do_batch kernel/rcu/tree.c:2158 [inline]
 rcu_core+0x819/0x1680 kernel/rcu/tree.c:2431
 __do_softirq+0x21a/0x8de kernel/softirq.c:553

Last potentially related work creation:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:492
 __call_rcu_common.constprop.0+0x9a/0x7a0 kernel/rcu/tree.c:2681
 taprio_change+0x28f8/0x38d0 net/sched/sch_taprio.c:1991
 qdisc_change net/sched/sch_api.c:1387 [inline]
 tc_modify_qdisc+0x7d5/0x1c30 net/sched/sch_api.c:1717
 rtnetlink_rcv_msg+0x3c7/0xe00 net/core/rtnetlink.c:6566
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2544
 netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
 netlink_unicast+0x53b/0x810 net/netlink/af_netlink.c:1367
 netlink_sendmsg+0x8b7/0xd70 net/netlink/af_netlink.c:1909
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0xd5/0x180 net/socket.c:745
 ____sys_sendmsg+0x6ac/0x940 net/socket.c:2584
 ___sys_sendmsg+0x135/0x1d0 net/socket.c:2638
 __sys_sendmsg+0x117/0x1e0 net/socket.c:2667
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Second to last potentially related work creation:
 kasan_save_stack+0x33/0x50 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:492
 __call_rcu_common.constprop.0+0x9a/0x7a0 kernel/rcu/tree.c:2681
 fib6_info_release include/net/ip6_fib.h:333 [inline]
 nsim_rt6_release drivers/net/netdevsim/fib.c:515 [inline]
 nsim_fib6_event_fini+0x1b1/0x280 drivers/net/netdevsim/fib.c:841
 nsim_fib_event drivers/net/netdevsim/fib.c:891 [inline]
 nsim_fib_event_work+0x2fe/0x26e0 drivers/net/netdevsim/fib.c:1492
 process_one_work+0x886/0x15d0 kernel/workqueue.c:2627
 process_scheduled_works kernel/workqueue.c:2700 [inline]
 worker_thread+0x8b9/0x1290 kernel/workqueue.c:2781
 kthread+0x2c6/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

The buggy address belongs to the object at ffff888027fbc800
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 272 bytes inside of
 freed 512-byte region [ffff888027fbc800, ffff888027fbca00)

The buggy address belongs to the physical page:
page:ffffea00009fef00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x27fbc
head:ffffea00009fef00 order:2 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000840(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000840 ffff888013041c80 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 2, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 3285, tgid 3285 (kworker/u4:2), ts 18559127120, free_ts 0
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2d0/0x350 mm/page_alloc.c:1544
 prep_new_page mm/page_alloc.c:1551 [inline]
 get_page_from_freelist+0xa28/0x3730 mm/page_alloc.c:3319
 __alloc_pages+0x22e/0x2420 mm/page_alloc.c:4575
 alloc_pages_mpol+0x258/0x5f0 mm/mempolicy.c:2133
 alloc_slab_page mm/slub.c:1870 [inline]
 allocate_slab mm/slub.c:2017 [inline]
 new_slab+0x283/0x3c0 mm/slub.c:2070
 ___slab_alloc+0x979/0x1500 mm/slub.c:3223
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3322
 __slab_alloc_node mm/slub.c:3375 [inline]
 slab_alloc_node mm/slub.c:3468 [inline]
 __kmem_cache_alloc_node+0x131/0x310 mm/slub.c:3517
 kmalloc_trace+0x25/0x60 mm/slab_common.c:1098
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:721 [inline]
 alloc_bprm+0x51/0xb00 fs/exec.c:1512
 kernel_execve+0xaf/0x4e0 fs/exec.c:1987
 call_usermodehelper_exec_async+0x256/0x4c0 kernel/umh.c:110
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888027fbc800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888027fbc880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888027fbc900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff888027fbc980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888027fbca00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
----------------
Code disassembly (best guess):
   0:	c1 05 6d 69 9a 7e 83 	roll   $0x83,0x7e9a696d(%rip)        # 0x7e9a6974
   7:	f8                   	clc
   8:	01 0f                	add    %ecx,(%rdi)
   a:	85 b4 02 00 00 9c 58 	test   %esi,0x589c0000(%rdx,%rax,1)
  11:	f6 c4 02             	test   $0x2,%ah
  14:	0f 85 9f 02 00 00    	jne    0x2b9
  1a:	48 85 ed             	test   %rbp,%rbp
  1d:	74 01                	je     0x20
  1f:	fb                   	sti
  20:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  27:	fc ff df
* 2a:	48 01 c3             	add    %rax,%rbx <-- trapping instruction
  2d:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
  34:	48 c7 43 08 00 00 00 	movq   $0x0,0x8(%rbx)
  3b:	00
  3c:	48                   	rex.W
  3d:	8b                   	.byte 0x8b
  3e:	84                   	.byte 0x84
  3f:	24                   	.byte 0x24


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

