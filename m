Return-Path: <linux-kernel+bounces-3837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C80888173A4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42CD1B2259F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE4D1D148;
	Mon, 18 Dec 2023 14:33:29 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE6E1D12A
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 14:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7b7c7f991f3so153038139f.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 06:33:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702910006; x=1703514806;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mHqXAXC9IJS35+e76KEwP+h9cwIzTMH2Oz/+Skx4up4=;
        b=nukn7l0N1qZIQtCRam4OTkspavzUQ2kyN78d6nzl6CZ+WG2XKzmZOp70xOUs55QzvA
         MAt6yLJAywSpkb3661Ou3WvgXZGou3szHAxtIdd0zxsWN9TtTS8pqxZBGhMUqt4/vt3c
         dwL1ipnjcCEa4jsDMpBFNow5rvx0yQVwaheaf+GYaW5u8bp2bFuMeEBtTFUGLhvDawiJ
         Nqqforx1+kuEjkBjUEySs1EtR6CZgR0M0KU/ut7pLeeOiCIVBHVLnRZaa4XAWnLYMLrq
         nR+fGlD8jz+DCpKyClnbChfh2wX9+Y3cuespLzOETjOMHgkSIj7DxgcbcaI3fEpkvv4G
         dZMQ==
X-Gm-Message-State: AOJu0YxlyIP4VV5SFPEFGiM8i8RwC/gLn2pfO4+lE/TuqxJcZwD5wrK4
	GVSB/YUwiDy2wawk2yCVIsD/v2L2BWHuWN3gfwLqABj4n3ii
X-Google-Smtp-Source: AGHT+IHXfRAtY9RT5qM9zmOMPAT9/mATWf2HJvLy0p7ZVePT99cZ4uZPFxrH9u7YO0FRkZduNP5wkG8lITIZrWtYMGV5Em9TxtYf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:210a:b0:469:2a61:9e97 with SMTP id
 n10-20020a056638210a00b004692a619e97mr618317jaj.4.1702910006419; Mon, 18 Dec
 2023 06:33:26 -0800 (PST)
Date: Mon, 18 Dec 2023 06:33:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000467ea060cc9a24b@google.com>
Subject: [syzbot] [net?] KASAN: slab-use-after-free Read in taprio_dump
From: syzbot <syzbot+d4d8c0fd15a0abe39bcf@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, jhs@mojatatu.com, 
	jiri@resnulli.us, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	vinicius.gomes@intel.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d5b235ec8eab Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=126c1c8ae80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f36ea342ce412b14
dashboard link: https://syzkaller.appspot.com/bug?extid=d4d8c0fd15a0abe39bcf
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=112380bae80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15e40371e80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/edab88544ce7/disk-d5b235ec.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2d149255b78d/vmlinux-d5b235ec.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c3bfc66db2fc/Image-d5b235ec.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d4d8c0fd15a0abe39bcf@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in taprio_dump_tc_entries net/sched/sch_taprio.c:2307 [inline]
BUG: KASAN: slab-use-after-free in taprio_dump+0x72c/0xb94 net/sched/sch_taprio.c:2420
Read of size 4 at addr ffff0000c1f660d8 by task syz-executor368/7987

CPU: 0 PID: 7987 Comm: syz-executor368 Not tainted 6.7.0-rc5-syzkaller-gd5b235ec8eab #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:291
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:298
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd0/0x124 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0x174/0x514 mm/kasan/report.c:475
 kasan_report+0xd8/0x138 mm/kasan/report.c:588
 __asan_report_load4_noabort+0x20/0x2c mm/kasan/report_generic.c:380
 taprio_dump_tc_entries net/sched/sch_taprio.c:2307 [inline]
 taprio_dump+0x72c/0xb94 net/sched/sch_taprio.c:2420
 tc_fill_qdisc+0x570/0xf1c net/sched/sch_api.c:952
 qdisc_notify+0x1a0/0x338 net/sched/sch_api.c:1024
 tc_modify_qdisc+0x16d4/0x1870 net/sched/sch_api.c:1719
 rtnetlink_rcv_msg+0x748/0xdbc net/core/rtnetlink.c:6558
 netlink_rcv_skb+0x214/0x3c4 net/netlink/af_netlink.c:2545
 rtnetlink_rcv+0x28/0x38 net/core/rtnetlink.c:6576
 netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
 netlink_unicast+0x65c/0x898 net/netlink/af_netlink.c:1368
 netlink_sendmsg+0x83c/0xb20 net/netlink/af_netlink.c:1910
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0x56c/0x840 net/socket.c:2584
 ___sys_sendmsg net/socket.c:2638 [inline]
 __sys_sendmsg+0x26c/0x33c net/socket.c:2667
 __do_sys_sendmsg net/socket.c:2676 [inline]
 __se_sys_sendmsg net/socket.c:2674 [inline]
 __arm64_sys_sendmsg+0x80/0x94 net/socket.c:2674
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595

Allocated by task 7987:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4c/0x7c mm/kasan/common.c:52
 kasan_save_alloc_info+0x24/0x30 mm/kasan/generic.c:511
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0xac/0xc4 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:198 [inline]
 kmalloc_trace+0x70/0x88 mm/slab_common.c:1103
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:721 [inline]
 taprio_change+0xd74/0x3c54 net/sched/sch_taprio.c:1881
 qdisc_change net/sched/sch_api.c:1387 [inline]
 tc_modify_qdisc+0x1474/0x1870 net/sched/sch_api.c:1717
 rtnetlink_rcv_msg+0x748/0xdbc net/core/rtnetlink.c:6558
 netlink_rcv_skb+0x214/0x3c4 net/netlink/af_netlink.c:2545
 rtnetlink_rcv+0x28/0x38 net/core/rtnetlink.c:6576
 netlink_unicast_kernel net/netlink/af_netlink.c:1342 [inline]
 netlink_unicast+0x65c/0x898 net/netlink/af_netlink.c:1368
 netlink_sendmsg+0x83c/0xb20 net/netlink/af_netlink.c:1910
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0x56c/0x840 net/socket.c:2584
 ___sys_sendmsg net/socket.c:2638 [inline]
 __sys_sendmsg+0x26c/0x33c net/socket.c:2667
 __do_sys_sendmsg net/socket.c:2676 [inline]
 __se_sys_sendmsg net/socket.c:2674 [inline]
 __arm64_sys_sendmsg+0x80/0x94 net/socket.c:2674
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595

Freed by task 40:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4c/0x7c mm/kasan/common.c:52
 kasan_save_free_info+0x38/0x5c mm/kasan/generic.c:522
 ____kasan_slab_free+0x144/0x1c0 mm/kasan/common.c:236
 __kasan_slab_free+0x18/0x28 mm/kasan/common.c:244
 kasan_slab_free include/linux/kasan.h:164 [inline]
 slab_free_hook mm/slub.c:1800 [inline]
 slab_free_freelist_hook mm/slub.c:1826 [inline]
 slab_free mm/slub.c:3809 [inline]
 __kmem_cache_free+0x2ac/0x480 mm/slub.c:3822
 kfree+0xb8/0x19c mm/slab_common.c:1056
 taprio_free_sched_cb+0x158/0x178 net/sched/sch_taprio.c:199
 rcu_do_batch kernel/rcu/tree.c:2158 [inline]
 rcu_core+0x890/0x1b34 kernel/rcu/tree.c:2431
 rcu_core_si+0x10/0x1c kernel/rcu/tree.c:2448
 __do_softirq+0x2d8/0xce4 kernel/softirq.c:553

Last potentially related work creation:
 kasan_save_stack+0x40/0x6c mm/kasan/common.c:45
 __kasan_record_aux_stack+0xcc/0xe8 mm/kasan/generic.c:492
 kasan_record_aux_stack_noalloc+0x14/0x20 mm/kasan/generic.c:502
 __call_rcu_common kernel/rcu/tree.c:2681 [inline]
 call_rcu+0x104/0xaf4 kernel/rcu/tree.c:2795
 switch_schedules net/sched/sch_taprio.c:210 [inline]
 advance_sched+0x7e0/0xac0 net/sched/sch_taprio.c:984
 __run_hrtimer kernel/time/hrtimer.c:1688 [inline]
 __hrtimer_run_queues+0x484/0xca0 kernel/time/hrtimer.c:1752
 hrtimer_interrupt+0x2c0/0xb64 kernel/time/hrtimer.c:1814
 timer_handler drivers/clocksource/arm_arch_timer.c:674 [inline]
 arch_timer_handler_virt+0x74/0x88 drivers/clocksource/arm_arch_timer.c:685
 handle_percpu_devid_irq+0x2a4/0x804 kernel/irq/chip.c:942
 generic_handle_irq_desc include/linux/irqdesc.h:161 [inline]
 handle_irq_desc kernel/irq/irqdesc.c:672 [inline]
 generic_handle_domain_irq+0x7c/0xc4 kernel/irq/irqdesc.c:728
 __gic_handle_irq drivers/irqchip/irq-gic-v3.c:782 [inline]
 __gic_handle_irq_from_irqson drivers/irqchip/irq-gic-v3.c:833 [inline]
 gic_handle_irq+0x6c/0x190 drivers/irqchip/irq-gic-v3.c:877

Second to last potentially related work creation:
 kasan_save_stack+0x40/0x6c mm/kasan/common.c:45
 __kasan_record_aux_stack+0xcc/0xe8 mm/kasan/generic.c:492
 kasan_record_aux_stack_noalloc+0x14/0x20 mm/kasan/generic.c:502
 __call_rcu_common kernel/rcu/tree.c:2681 [inline]
 call_rcu+0x104/0xaf4 kernel/rcu/tree.c:2795
 switch_schedules net/sched/sch_taprio.c:210 [inline]
 advance_sched+0x7e0/0xac0 net/sched/sch_taprio.c:984
 __run_hrtimer kernel/time/hrtimer.c:1688 [inline]
 __hrtimer_run_queues+0x484/0xca0 kernel/time/hrtimer.c:1752
 hrtimer_interrupt+0x2c0/0xb64 kernel/time/hrtimer.c:1814
 timer_handler drivers/clocksource/arm_arch_timer.c:674 [inline]
 arch_timer_handler_virt+0x74/0x88 drivers/clocksource/arm_arch_timer.c:685
 handle_percpu_devid_irq+0x2a4/0x804 kernel/irq/chip.c:942
 generic_handle_irq_desc include/linux/irqdesc.h:161 [inline]
 handle_irq_desc kernel/irq/irqdesc.c:672 [inline]
 generic_handle_domain_irq+0x7c/0xc4 kernel/irq/irqdesc.c:728
 __gic_handle_irq drivers/irqchip/irq-gic-v3.c:782 [inline]
 __gic_handle_irq_from_irqson drivers/irqchip/irq-gic-v3.c:833 [inline]
 gic_handle_irq+0x6c/0x190 drivers/irqchip/irq-gic-v3.c:877

The buggy address belongs to the object at ffff0000c1f66000
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 216 bytes inside of
 freed 512-byte region [ffff0000c1f66000, ffff0000c1f66200)

The buggy address belongs to the physical page:
page:00000000dead7e4a refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff0000c1f64800 pfn:0x101f64
head:00000000dead7e4a order:2 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x5ffc00000000840(slab|head|node=0|zone=2|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 05ffc00000000840 ffff0000c0001c80 fffffc00036bd110 fffffc0003653210
raw: ffff0000c1f64800 000000000010000e 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff0000c1f65f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff0000c1f66000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff0000c1f66080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                    ^
 ffff0000c1f66100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff0000c1f66180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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

