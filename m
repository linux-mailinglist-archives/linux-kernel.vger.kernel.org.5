Return-Path: <linux-kernel+bounces-3860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 079A5817413
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0CC41C232E1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C1237888;
	Mon, 18 Dec 2023 14:45:29 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F7C37868
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 14:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7b739032bf6so372379039f.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 06:45:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702910726; x=1703515526;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a2hcKBWRTFc8cf/IyxHXD85RGAXgANYdNqTf+HBzUSc=;
        b=ZCTKTpp3ZdVbqqsD0we/M8M+H0CB+WPNNNyn3b5JeygwklVLq5zGlItYyaLJTilAEg
         Pmh+yKJX9S1wwfeOqeg0bHzGmkl3cuhNyOBtHhNAzAqTQ/faKgyHgMshHP7RJfBctqKk
         QDTqM63ibpgwaW1i6zJujns6HKUXiOE9oyF5K8ZNCUvSnStbFghTzQSjgh+V92JJdrI9
         eiAC2M0EhvHQOAMgwzsjpEVBAtDG1wjftnwlMEx0UFgEWIsz/aFUXMD4CGxVm8yCVOZl
         tE+G0Uz0um0HoQZUvNDrLOW0+7ZXLdkIzQtJUclXhn192UYPxZuDpRSU5i5YolaPkZTT
         /K6Q==
X-Gm-Message-State: AOJu0YzVziDZBHlqfLL03GuAmNw9ozfiCIft9bzwUIc9mkHXcIHlofE9
	qU7gv/w6xOx0iOJ8l1JbMuUMOvqEaGjFOULeA/yjgDjSbS+t
X-Google-Smtp-Source: AGHT+IF+3JfM2KpBfG5mwHbgX33kDuZ3QGxZ/xIId/aI3wChlRAvI09KcxDkawRCwL2prle+0KFII/bLFY76X3DyMtsbwUUTxVJT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:12cf:b0:466:509d:18b9 with SMTP id
 v15-20020a05663812cf00b00466509d18b9mr778357jas.3.1702910726475; Mon, 18 Dec
 2023 06:45:26 -0800 (PST)
Date: Mon, 18 Dec 2023 06:45:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ef958c060cc9cc3d@google.com>
Subject: [syzbot] [net?] WARNING in call_rcu (3)
From: syzbot <syzbot+d17177af4afd8c6f804c@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, jhs@mojatatu.com, 
	jiri@resnulli.us, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	vinicius.gomes@intel.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d5b235ec8eab Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=10ee273ae80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f36ea342ce412b14
dashboard link: https://syzkaller.appspot.com/bug?extid=d17177af4afd8c6f804c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/edab88544ce7/disk-d5b235ec.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2d149255b78d/vmlinux-d5b235ec.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c3bfc66db2fc/Image-d5b235ec.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d17177af4afd8c6f804c@syzkaller.appspotmail.com

------------[ cut here ]------------
ODEBUG: activate active (active state 1) object: 000000001b663dc1 object type: rcu_head hint: 0x0
WARNING: CPU: 0 PID: 21462 at lib/debugobjects.c:517 debug_print_object lib/debugobjects.c:514 [inline]
WARNING: CPU: 0 PID: 21462 at lib/debugobjects.c:517 debug_object_activate+0x578/0x7e0 lib/debugobjects.c:733
Modules linked in:
CPU: 0 PID: 21462 Comm: syz-executor.1 Not tainted 6.7.0-rc5-syzkaller-gd5b235ec8eab #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : debug_print_object lib/debugobjects.c:514 [inline]
pc : debug_object_activate+0x578/0x7e0 lib/debugobjects.c:733
lr : debug_print_object lib/debugobjects.c:514 [inline]
lr : debug_object_activate+0x578/0x7e0 lib/debugobjects.c:733
sp : ffff800080007a00
x29: ffff800080007ad0 x28: dfff800000000000 x27: ffff700010000f44
x26: 0000000000000000 x25: ffff0000d99ed500 x24: 0000000000000000
x23: ffff80008a9af3a0 x22: ffff80008ae8cdc0 x21: 0000000000000001
x20: ffff80008a9af3a0 x19: ffff0000d99ed500 x18: ffff800080006ee0
x17: 6364333636623130 x16: ffff80008a77a080 x15: 0000000000000001
x14: 1ffff00010000e5c x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000010205 x10: 0000000000ff0100 x9 : dddee9959d64fa00
x8 : dddee9959d64fa00 x7 : 00000000000310a8 x6 : 0000000000031070
x5 : ffff8000800072f8 x4 : ffff80008e5c8460 x3 : ffff800080366550
x2 : 0000000000000001 x1 : 0000000100010203 x0 : 0000000000000000
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
 spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
 taprio_change+0x335c/0x3c54 net/sched/sch_taprio.c:1993
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
irq event stamp: 647
hardirqs last  enabled at (646): [<ffff80008a91b884>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (646): [<ffff80008a91b884>] _raw_spin_unlock_irqrestore+0x38/0x98 kernel/locking/spinlock.c:194
hardirqs last disabled at (647): [<ffff80008a829e84>] __el1_irq arch/arm64/kernel/entry-common.c:499 [inline]
hardirqs last disabled at (647): [<ffff80008a829e84>] el1_interrupt+0x24/0x68 arch/arm64/kernel/entry-common.c:517
softirqs last  enabled at (636): [<ffff80008002189c>] softirq_handle_end kernel/softirq.c:399 [inline]
softirqs last  enabled at (636): [<ffff80008002189c>] __do_softirq+0xac8/0xce4 kernel/softirq.c:582
softirqs last disabled at (640): [<ffff800088d02978>] spin_lock_bh include/linux/spinlock.h:356 [inline]
softirqs last disabled at (640): [<ffff800088d02978>] taprio_change+0x2e44/0x3c54 net/sched/sch_taprio.c:1943
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
ODEBUG: active_state active (active state 1) object: 000000001b663dc1 object type: rcu_head hint: 0x0
WARNING: CPU: 0 PID: 21462 at lib/debugobjects.c:517 debug_print_object lib/debugobjects.c:514 [inline]
WARNING: CPU: 0 PID: 21462 at lib/debugobjects.c:517 debug_object_active_state+0x2e4/0x414 lib/debugobjects.c:993
Modules linked in:
CPU: 0 PID: 21462 Comm: syz-executor.1 Tainted: G        W          6.7.0-rc5-syzkaller-gd5b235ec8eab #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : debug_print_object lib/debugobjects.c:514 [inline]
pc : debug_object_active_state+0x2e4/0x414 lib/debugobjects.c:993
lr : debug_print_object lib/debugobjects.c:514 [inline]
lr : debug_object_active_state+0x2e4/0x414 lib/debugobjects.c:993
sp : ffff800080007ac0
x29: ffff800080007ad0 x28: ffff80008e4f0000 x27: dfff800000000000
x26: 1fffe0001ab43d28 x25: ffff800092d4d000 x24: 1fffe0001ab43d29
x23: 0000000000000000 x22: ffff0000d99ed500 x21: ffff80008a9af3a0
x20: ffff80008ae8cdc0 x19: 0000000000000001 x18: ffff800080006ee0
x17: 3662313030303030 x16: ffff80008a77a080 x15: 0000000000000001
x14: 1ffff00010000e74 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000010205 x10: 0000000000ff0100 x9 : dddee9959d64fa00
x8 : dddee9959d64fa00 x7 : 0000000000032628 x6 : 00000000000325d0
x5 : ffff8000800073b8 x4 : ffff80008e5c89e8 x3 : ffff800080366550
x2 : 0000000000000001 x1 : 0000000100010203 x0 : 0000000000000000
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
 spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
 taprio_change+0x335c/0x3c54 net/sched/sch_taprio.c:1993
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
irq event stamp: 647
hardirqs last  enabled at (646): [<ffff80008a91b884>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (646): [<ffff80008a91b884>] _raw_spin_unlock_irqrestore+0x38/0x98 kernel/locking/spinlock.c:194
hardirqs last disabled at (647): [<ffff80008a829e84>] __el1_irq arch/arm64/kernel/entry-common.c:499 [inline]
hardirqs last disabled at (647): [<ffff80008a829e84>] el1_interrupt+0x24/0x68 arch/arm64/kernel/entry-common.c:517
softirqs last  enabled at (636): [<ffff80008002189c>] softirq_handle_end kernel/softirq.c:399 [inline]
softirqs last  enabled at (636): [<ffff80008002189c>] __do_softirq+0xac8/0xce4 kernel/softirq.c:582
softirqs last disabled at (640): [<ffff800088d02978>] spin_lock_bh include/linux/spinlock.h:356 [inline]
softirqs last disabled at (640): [<ffff800088d02978>] taprio_change+0x2e44/0x3c54 net/sched/sch_taprio.c:1943
---[ end trace 0000000000000000 ]---
rcu: __call_rcu_common(): Double-freed CB 000000001b663dc1->taprio_free_sched_cb+0x0/0x178()!!!   slab kmalloc-512 start ffff0000d99ed400 pointer offset 256 size 512


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

