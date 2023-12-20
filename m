Return-Path: <linux-kernel+bounces-6914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE28819F46
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4BB21F289D4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BB424B4C;
	Wed, 20 Dec 2023 12:44:07 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EB224B28
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 12:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-35fc4376ceeso13809555ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 04:44:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703076245; x=1703681045;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KKSDPWoic49VZgMUDNSDFb50PiIua8AvJzyFaGtMJ4s=;
        b=pxbmyBJ8H5AQELLC8gg4GNpbGZGLaBJ57/tCsUmq8jO5mEdyk2LfYRlOFYkGvXb6iK
         N+M3o2ri2WNl+JTeTHfcqN5JoJzAMrIRUSt8D3vWCH2c8oscHpKtScQAEuPShS/ySFzQ
         mi3Sp1IrToXV4miJqkjlIHI9dTFxGKrD2ib39HhEF/q8GaBB5u0DBJ1q72rGsY+sPNsf
         Wy5xTLG5Ow0g8exBY1tHIGeBAJu26oaNVmgHS7bN8LKuj8X7yQF5Yu/i1UYM2uCo01i2
         NCRSbZq2C6cTtvzumyUv7dAmL1U4vrKLGSIZantJU7eF1s5vxGznYtZ8auhUGA+BaVCW
         CtcA==
X-Gm-Message-State: AOJu0Yx/4m0nL5LIDln/YhJoWqhWm/Mr3FPcxlS35lJd1WXnbtHvLk3Y
	YI4hfOd6wIml9kttfgOJDZzadt8YhGZ38JJb/mx6mWoNKR8o
X-Google-Smtp-Source: AGHT+IGldMtyC5Lf7S8zbFvkb+SKSKCS2S3hsgORz5BHVKipzi519vl05ez4OrmhGW0pcyMt9bO9V7qnZTj4LmyD3ot7kXPNxYJh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c569:0:b0:35f:a0ff:de13 with SMTP id
 b9-20020a92c569000000b0035fa0ffde13mr938863ilj.3.1703076244852; Wed, 20 Dec
 2023 04:44:04 -0800 (PST)
Date: Wed, 20 Dec 2023 04:44:04 -0800
In-Reply-To: <20231220111554.1127-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000999995060cf05663@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in taprio_dump
From: syzbot <syzbot+d4d8c0fd15a0abe39bcf@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in call_rcu

------------[ cut here ]------------
ODEBUG: activate active (active state 1) object: 0000000040a741f2 object type: rcu_head hint: 0x0
WARNING: CPU: 0 PID: 10724 at lib/debugobjects.c:517 debug_print_object lib/debugobjects.c:514 [inline]
WARNING: CPU: 0 PID: 10724 at lib/debugobjects.c:517 debug_object_activate+0x578/0x7e0 lib/debugobjects.c:733
Modules linked in:
CPU: 0 PID: 10724 Comm: syz-executor.4 Not tainted 6.7.0-rc5-syzkaller-00083-gd5b235ec8eab-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : debug_print_object lib/debugobjects.c:514 [inline]
pc : debug_object_activate+0x578/0x7e0 lib/debugobjects.c:733
lr : debug_print_object lib/debugobjects.c:514 [inline]
lr : debug_object_activate+0x578/0x7e0 lib/debugobjects.c:733
sp : ffff800080007a00
x29: ffff800080007ad0 x28: dfff800000000000 x27: ffff700010000f44
x26: 0000000000000000 x25: ffff0000da75c900 x24: 0000000000000000
x23: ffff80008a9af3a0 x22: ffff80008ae8cdc0 x21: 0000000000000001
x20: ffff80008a9af3a0 x19: ffff0000da75c900 x18: ffff800080006ee0
x17: 6631343761303430 x16: ffff80008a82f460 x15: 0000000000000001
x14: 1fffe0003682623a x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000010004 x10: 0000000000ff0100 x9 : f1155cbcba9a1100
x8 : f1155cbcba9a1100 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff8000800072f8 x4 : ffff80008e5d2600 x3 : ffff8000805ad1c0
x2 : 0000000000000001 x1 : 0000000100010002 x0 : 0000000000000000
Call trace:
 debug_print_object lib/debugobjects.c:514 [inline]
 debug_object_activate+0x578/0x7e0 lib/debugobjects.c:733
 debug_rcu_head_queue kernel/rcu/rcu.h:227 [inline]
 __call_rcu_common kernel/rcu/tree.c:2666 [inline]
 call_rcu+0x48/0xaf4 kernel/rcu/tree.c:2795
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
 call_on_irq_stack+0x24/0x4c arch/arm64/kernel/entry.S:886
 do_interrupt_handler+0xd4/0x138 arch/arm64/kernel/entry-common.c:276
 __el1_irq arch/arm64/kernel/entry-common.c:502 [inline]
 el1_interrupt+0x34/0x68 arch/arm64/kernel/entry-common.c:517
 el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:522
 el1h_64_irq+0x64/0x68 arch/arm64/kernel/entry.S:591
 __daif_local_irq_restore arch/arm64/include/asm/irqflags.h:176 [inline]
 arch_local_irq_restore arch/arm64/include/asm/irqflags.h:196 [inline]
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
 _raw_spin_unlock_irqrestore+0x44/0x98 kernel/locking/spinlock.c:194
 unlock_hrtimer_base kernel/time/hrtimer.c:1020 [inline]
 hrtimer_start_range_ns+0x8a0/0x9ac kernel/time/hrtimer.c:1304
 hrtimer_start include/linux/hrtimer.h:418 [inline]
 taprio_dump+0xa40/0xc68 net/sched/sch_taprio.c:2444
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
irq event stamp: 2628
hardirqs last  enabled at (2627): [<ffff80008a91ca44>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (2627): [<ffff80008a91ca44>] _raw_spin_unlock_irqrestore+0x38/0x98 kernel/locking/spinlock.c:194
hardirqs last disabled at (2628): [<ffff80008a82b044>] __el1_irq arch/arm64/kernel/entry-common.c:499 [inline]
hardirqs last disabled at (2628): [<ffff80008a82b044>] el1_interrupt+0x24/0x68 arch/arm64/kernel/entry-common.c:517
softirqs last  enabled at (2616): [<ffff800088d03038>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
softirqs last  enabled at (2616): [<ffff800088d03038>] taprio_change+0x3504/0x3d40 net/sched/sch_taprio.c:2010
softirqs last disabled at (2608): [<ffff800088d029c0>] spin_lock_bh include/linux/spinlock.h:356 [inline]
softirqs last disabled at (2608): [<ffff800088d029c0>] taprio_change+0x2e8c/0x3d40 net/sched/sch_taprio.c:1943
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
ODEBUG: active_state active (active state 1) object: 0000000040a741f2 object type: rcu_head hint: 0x0
WARNING: CPU: 0 PID: 10724 at lib/debugobjects.c:517 debug_print_object lib/debugobjects.c:514 [inline]
WARNING: CPU: 0 PID: 10724 at lib/debugobjects.c:517 debug_object_active_state+0x2e4/0x414 lib/debugobjects.c:993
Modules linked in:
CPU: 0 PID: 10724 Comm: syz-executor.4 Tainted: G        W          6.7.0-rc5-syzkaller-00083-gd5b235ec8eab-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : debug_print_object lib/debugobjects.c:514 [inline]
pc : debug_object_active_state+0x2e4/0x414 lib/debugobjects.c:993
lr : debug_print_object lib/debugobjects.c:514 [inline]
lr : debug_object_active_state+0x2e4/0x414 lib/debugobjects.c:993
sp : ffff800080007ac0
x29: ffff800080007ad0 x28: ffff80008e4f0000 x27: dfff800000000000
x26: 1fffe0001ac85cf7 x25: ffff800092d4d000 x24: 1fffe0001ac85cf8
x23: 0000000000000000 x22: ffff0000da75c900 x21: ffff80008a9af3a0
x20: ffff80008ae8cdc0 x19: 0000000000000001 x18: ffff800080006ee0
x17: 6130343030303030 x16: ffff80008a82f460 x15: 0000000000000001
x14: 1fffe0003682623a x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000010004 x10: 0000000000ff0100 x9 : f1155cbcba9a1100
x8 : f1155cbcba9a1100 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff8000800073b8 x4 : ffff80008e5d2600 x3 : ffff8000805ad1c0
x2 : 0000000000000001 x1 : 0000000100010002 x0 : 0000000000000000
Call trace:
 debug_print_object lib/debugobjects.c:514 [inline]
 debug_object_active_state+0x2e4/0x414 lib/debugobjects.c:993
 debug_rcu_head_queue kernel/rcu/rcu.h:228 [inline]
 __call_rcu_common kernel/rcu/tree.c:2666 [inline]
 call_rcu+0x60/0xaf4 kernel/rcu/tree.c:2795
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
 call_on_irq_stack+0x24/0x4c arch/arm64/kernel/entry.S:886
 do_interrupt_handler+0xd4/0x138 arch/arm64/kernel/entry-common.c:276
 __el1_irq arch/arm64/kernel/entry-common.c:502 [inline]
 el1_interrupt+0x34/0x68 arch/arm64/kernel/entry-common.c:517
 el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:522
 el1h_64_irq+0x64/0x68 arch/arm64/kernel/entry.S:591
 __daif_local_irq_restore arch/arm64/include/asm/irqflags.h:176 [inline]
 arch_local_irq_restore arch/arm64/include/asm/irqflags.h:196 [inline]
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
 _raw_spin_unlock_irqrestore+0x44/0x98 kernel/locking/spinlock.c:194
 unlock_hrtimer_base kernel/time/hrtimer.c:1020 [inline]
 hrtimer_start_range_ns+0x8a0/0x9ac kernel/time/hrtimer.c:1304
 hrtimer_start include/linux/hrtimer.h:418 [inline]
 taprio_dump+0xa40/0xc68 net/sched/sch_taprio.c:2444
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
irq event stamp: 2628
hardirqs last  enabled at (2627): [<ffff80008a91ca44>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (2627): [<ffff80008a91ca44>] _raw_spin_unlock_irqrestore+0x38/0x98 kernel/locking/spinlock.c:194
hardirqs last disabled at (2628): [<ffff80008a82b044>] __el1_irq arch/arm64/kernel/entry-common.c:499 [inline]
hardirqs last disabled at (2628): [<ffff80008a82b044>] el1_interrupt+0x24/0x68 arch/arm64/kernel/entry-common.c:517
softirqs last  enabled at (2616): [<ffff800088d03038>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
softirqs last  enabled at (2616): [<ffff800088d03038>] taprio_change+0x3504/0x3d40 net/sched/sch_taprio.c:2010
softirqs last disabled at (2608): [<ffff800088d029c0>] spin_lock_bh include/linux/spinlock.h:356 [inline]
softirqs last disabled at (2608): [<ffff800088d029c0>] taprio_change+0x2e8c/0x3d40 net/sched/sch_taprio.c:1943
---[ end trace 0000000000000000 ]---
rcu: __call_rcu_common(): Double-freed CB 0000000040a741f2->taprio_free_sched_cb+0x0/0x178()!!!   slab kmalloc-512 start ffff0000da75c800 pointer offset 256 size 512


Tested on:

commit:         d5b235ec Merge branch 'for-next/core' into for-kernelci
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11d6e2bee80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f36ea342ce412b14
dashboard link: https://syzkaller.appspot.com/bug?extid=d4d8c0fd15a0abe39bcf
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11e0f416e80000


