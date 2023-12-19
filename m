Return-Path: <linux-kernel+bounces-5069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14581818636
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E78C2B213EA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244BD154AD;
	Tue, 19 Dec 2023 11:20:09 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3503815484
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 11:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-35f766cf0f6so35663375ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 03:20:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702984806; x=1703589606;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vwYNtXz42XfB8mF8se+mbTiowiLQ3v3qhqzcDp3QZQw=;
        b=X/wpGKhqbw3XEhHU7RKUcIlbRPugeb2d7BB4s78eIPGJoj6rSDn3zo4XiM9e7DFI3w
         DZdj/yVMzWhLAYyNqqWAFcDx7zAh0W7zJQBqiVUibddLpbDRXguvNEypADbSDJbqL03z
         gEcgOBmHXDm9jLDj5W0K90j5WzkdCTNMFJDxEEk8jJlkTZZiSsp8vw/LfUF/0WS84vTK
         GIKcNKjy9/KWB00Xu4zf8SdzAZMLp1jSRP6j4/7gam37bW3VuDKlFSoNg/7k7Lu+R8GH
         SU+gjzxy1AAZbrwHS33SpIZtkmCOFTZGUF/hy02z+CXsUoKmJLKwPXUxr8qf4Lv1YeyI
         rCRg==
X-Gm-Message-State: AOJu0YyROtLQV8ZgHHtSm0Yw5+ma92lNue213eQEwbV7SUOEQIzVaFmp
	hlLCPrgcy8NgO5dZxHw6PIwPMLXOuoHJAj9yBbGTRc6I/Cb0
X-Google-Smtp-Source: AGHT+IH4kD8nJyJc/eb1FiUsI00+o39EBni6aR6U7vXb9Z1A/I1k18RN4sxG4hpfvZAG5NRHJd3azFmm8xWanvnV2SwElTbFdoef
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:60a:0:b0:35f:b8ba:4b6d with SMTP id
 x10-20020a92060a000000b0035fb8ba4b6dmr90615ilg.3.1702984806411; Tue, 19 Dec
 2023 03:20:06 -0800 (PST)
Date: Tue, 19 Dec 2023 03:20:06 -0800
In-Reply-To: <20231219105938.1773-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000071b6d0060cdb0c0c@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in taprio_dump
From: syzbot <syzbot+d4d8c0fd15a0abe39bcf@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in call_rcu

------------[ cut here ]------------
ODEBUG: activate active (active state 1) object: 00000000dde3d5ec object type: rcu_head hint: 0x0
WARNING: CPU: 0 PID: 6475 at lib/debugobjects.c:517 debug_print_object lib/debugobjects.c:514 [inline]
WARNING: CPU: 0 PID: 6475 at lib/debugobjects.c:517 debug_object_activate+0x578/0x7e0 lib/debugobjects.c:733
Modules linked in:
CPU: 0 PID: 6475 Comm: syz-executor.4 Not tainted 6.7.0-rc5-syzkaller-00083-gd5b235ec8eab-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : debug_print_object lib/debugobjects.c:514 [inline]
pc : debug_object_activate+0x578/0x7e0 lib/debugobjects.c:733
lr : debug_print_object lib/debugobjects.c:514 [inline]
lr : debug_object_activate+0x578/0x7e0 lib/debugobjects.c:733
sp : ffff800080007a00
x29: ffff800080007ad0 x28: dfff800000000000 x27: ffff700010000f44
x26: 0000000000000000 x25: ffff0000e798f100 x24: 0000000000000000
x23: ffff80008a9af3a0 x22: ffff80008ae8cdc0 x21: 0000000000000001
x20: ffff80008a9af3a0 x19: ffff0000e798f100 x18: ffff800080006ee0
x17: 6535643365646430 x16: ffff80008a82f3a0 x15: 0000000000000001
x14: 1fffe0003682623a x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000010004 x10: 0000000000ff0100 x9 : 20b7275ad0946800
x8 : 20b7275ad0946800 x7 : 0000000000000001 x6 : 0000000000000001
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
 __daif_local_irq_enable arch/arm64/include/asm/irqflags.h:27 [inline]
 arch_local_irq_enable arch/arm64/include/asm/irqflags.h:49 [inline]
 raw_spin_rq_unlock_irq kernel/sched/sched.h:1361 [inline]
 finish_lock_switch+0xc0/0x1e4 kernel/sched/core.c:5130
 finish_task_switch+0x120/0x614 kernel/sched/core.c:5248
 context_switch kernel/sched/core.c:5379 [inline]
 __schedule+0x1358/0x2360 kernel/sched/core.c:6688
 __schedule_loop kernel/sched/core.c:6763 [inline]
 schedule+0xb8/0x19c kernel/sched/core.c:6778
 do_nanosleep+0x170/0x504 kernel/time/hrtimer.c:2047
 hrtimer_nanosleep+0x1c4/0x358 kernel/time/hrtimer.c:2100
 common_nsleep+0xa8/0xc0 kernel/time/posix-timers.c:1350
 __do_sys_clock_nanosleep kernel/time/posix-timers.c:1396 [inline]
 __se_sys_clock_nanosleep kernel/time/posix-timers.c:1373 [inline]
 __arm64_sys_clock_nanosleep+0x350/0x38c kernel/time/posix-timers.c:1373
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595
irq event stamp: 3966950
hardirqs last  enabled at (3966949): [<ffff80008028f0b8>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1361 [inline]
hardirqs last  enabled at (3966949): [<ffff80008028f0b8>] finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5130
hardirqs last disabled at (3966950): [<ffff80008a82af84>] __el1_irq arch/arm64/kernel/entry-common.c:499 [inline]
hardirqs last disabled at (3966950): [<ffff80008a82af84>] el1_interrupt+0x24/0x68 arch/arm64/kernel/entry-common.c:517
softirqs last  enabled at (3966932): [<ffff80008002189c>] softirq_handle_end kernel/softirq.c:399 [inline]
softirqs last  enabled at (3966932): [<ffff80008002189c>] __do_softirq+0xac8/0xce4 kernel/softirq.c:582
softirqs last disabled at (3966927): [<ffff80008002aadc>] ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:81
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
ODEBUG: active_state active (active state 1) object: 00000000dde3d5ec object type: rcu_head hint: 0x0
WARNING: CPU: 0 PID: 6475 at lib/debugobjects.c:517 debug_print_object lib/debugobjects.c:514 [inline]
WARNING: CPU: 0 PID: 6475 at lib/debugobjects.c:517 debug_object_active_state+0x2e4/0x414 lib/debugobjects.c:993
Modules linked in:
CPU: 0 PID: 6475 Comm: syz-executor.4 Tainted: G        W          6.7.0-rc5-syzkaller-00083-gd5b235ec8eab-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : debug_print_object lib/debugobjects.c:514 [inline]
pc : debug_object_active_state+0x2e4/0x414 lib/debugobjects.c:993
lr : debug_print_object lib/debugobjects.c:514 [inline]
lr : debug_object_active_state+0x2e4/0x414 lib/debugobjects.c:993
sp : ffff800080007ac0
x29: ffff800080007ad0 x28: ffff80008e4f0000 x27: dfff800000000000
x26: 1fffe0001ae8f202 x25: ffff800092d4d000 x24: 1fffe0001ae8f203
x23: 0000000000000000 x22: ffff0000e798f100 x21: ffff80008a9af3a0
x20: ffff80008ae8cdc0 x19: 0000000000000001 x18: ffff800080006ee0
x17: 6564643030303030 x16: ffff80008a82f3a0 x15: 0000000000000001
x14: 1fffe0003682623a x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000010004 x10: 0000000000ff0100 x9 : 20b7275ad0946800
x8 : 20b7275ad0946800 x7 : 0000000000000001 x6 : 0000000000000001
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
 __daif_local_irq_enable arch/arm64/include/asm/irqflags.h:27 [inline]
 arch_local_irq_enable arch/arm64/include/asm/irqflags.h:49 [inline]
 raw_spin_rq_unlock_irq kernel/sched/sched.h:1361 [inline]
 finish_lock_switch+0xc0/0x1e4 kernel/sched/core.c:5130
 finish_task_switch+0x120/0x614 kernel/sched/core.c:5248
 context_switch kernel/sched/core.c:5379 [inline]
 __schedule+0x1358/0x2360 kernel/sched/core.c:6688
 __schedule_loop kernel/sched/core.c:6763 [inline]
 schedule+0xb8/0x19c kernel/sched/core.c:6778
 do_nanosleep+0x170/0x504 kernel/time/hrtimer.c:2047
 hrtimer_nanosleep+0x1c4/0x358 kernel/time/hrtimer.c:2100
 common_nsleep+0xa8/0xc0 kernel/time/posix-timers.c:1350
 __do_sys_clock_nanosleep kernel/time/posix-timers.c:1396 [inline]
 __se_sys_clock_nanosleep kernel/time/posix-timers.c:1373 [inline]
 __arm64_sys_clock_nanosleep+0x350/0x38c kernel/time/posix-timers.c:1373
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x54/0x158 arch/arm64/kernel/entry-common.c:678
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:696
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595
irq event stamp: 3966950
hardirqs last  enabled at (3966949): [<ffff80008028f0b8>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1361 [inline]
hardirqs last  enabled at (3966949): [<ffff80008028f0b8>] finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5130
hardirqs last disabled at (3966950): [<ffff80008a82af84>] __el1_irq arch/arm64/kernel/entry-common.c:499 [inline]
hardirqs last disabled at (3966950): [<ffff80008a82af84>] el1_interrupt+0x24/0x68 arch/arm64/kernel/entry-common.c:517
softirqs last  enabled at (3966932): [<ffff80008002189c>] softirq_handle_end kernel/softirq.c:399 [inline]
softirqs last  enabled at (3966932): [<ffff80008002189c>] __do_softirq+0xac8/0xce4 kernel/softirq.c:582
softirqs last disabled at (3966927): [<ffff80008002aadc>] ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:81
---[ end trace 0000000000000000 ]---
rcu: __call_rcu_common(): Double-freed CB 00000000dde3d5ec->taprio_free_sched_cb+0x0/0x178()!!!   slab kmalloc-512 start ffff0000e798f000 pointer offset 256 size 512


Tested on:

commit:         d5b235ec Merge branch 'for-next/core' into for-kernelci
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=13e8c811e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f36ea342ce412b14
dashboard link: https://syzkaller.appspot.com/bug?extid=d4d8c0fd15a0abe39bcf
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=179f7076e80000


