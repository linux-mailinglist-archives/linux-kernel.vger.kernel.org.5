Return-Path: <linux-kernel+bounces-78012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21755860DFC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BE2F1F247E6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C804C5C912;
	Fri, 23 Feb 2024 09:29:20 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4554C22067
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 09:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708680560; cv=none; b=fvRzeNV9dJgjSpogKwOa5Zyu4swpDSteAy8sholAq6RgKvdiAyKoY40Ifexc939Y70Ps6UsV2EGTmR4UcOigPEhJXpt+wVzA1baAJx6EJb+WPy9050oudDFvfGIRX8mIs6NAsYYUElpnbDq3xWdpHMHBmUWVIDkXnvjm/CmU0CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708680560; c=relaxed/simple;
	bh=XBlO+prX+BVwr6GjAnBwa/wZVwpBnk+2ogglTH5kX/4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fNToZcNKm/R05SEzRvTq6gizJM7ljtIWPucq2iUOWeaPNDlx5GDlyK1hlHLWhJ+Bj3+37iBanl+ekNsorrVRHh50JEBHNo/3jxDXVx1tUWBYik7CqL809KmMOKVkF6hCtviro1nnCkpZaGMiemQRzQ2wsMzrsy8M4vLmNCcXMJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c78573f2d0so4890039f.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 01:29:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708680557; x=1709285357;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XrMKjAtGdZ4VbbjBnNhK2wcFEC5IGVt631N4784tKfE=;
        b=WRsd0LSbYSlSmqUbzob19qi1q5MKS67xH19cL4zgCp9wEmiy7aBhlBq4da8BRnSklm
         WSG32VFlOW1pZM6VNV1if4ujYzTYkpwX/+6qNeeqGR7BCzdKdzsJbDvJIUPUJrU1Ztzv
         s90xHhUUnouMlE5Dhjk76hwAgxZJ31Irj7ZhOhY9qzH2Z1famx6eEFS7lEEcu/GFY1Ih
         bBfk3MHbUbgiqKOlNbkTukXq6HNp88i6t2xEETnqHY8Almk8gp3MUZNbxFjsabtrVXbN
         fz0OOfqeKiB3BIpKCIxSoZSQMbM6CI+amlrjShfEwCNdtquYrsWFw3HpkRsq+MUVJZQb
         acMg==
X-Forwarded-Encrypted: i=1; AJvYcCU5o3TTYLe5zc6Oog4poNo/svpaLd9GmYCjNzmqY0yWNsI4Ii7meMYRYbWcLo//esud+kLm77G/XX748L77cb4X2i+/tDyinjy7Y3Wg
X-Gm-Message-State: AOJu0Yz3eFUQn6e9pnzQ+rtRfjBleYUySVEtXbSumGXw4STBj/umDnT7
	iJdQPREwpgadffKnfksWTJfOVQOTGaN3evXNj1KwLUwNHwY8uysANIy5Nv8AGJ7TcBSpp4friaF
	RoFrhJwSQ2oeGQJKjPZq9qQ3kE/mOWSyfSBH1PYKhm2pZhaus3pW8EuE=
X-Google-Smtp-Source: AGHT+IGdcZEYKTCVa6hsnVv9C5POed1dF6gao3PbHhn1Pd0LaCbg3mKKNDrsOa20ek3hj8B37IxKPS1o2dR5d+t1WXXGSoZCBU6l
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a5e:8d0b:0:b0:7c7:8e70:39ec with SMTP id
 m11-20020a5e8d0b000000b007c78e7039ecmr9925ioj.1.1708680557440; Fri, 23 Feb
 2024 01:29:17 -0800 (PST)
Date: Fri, 23 Feb 2024 01:29:17 -0800
In-Reply-To: <000000000000c848d3060cd1d16a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a9373b0612093168@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in advance_sched
From: syzbot <syzbot+b65e0af58423fc8a73aa@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, jhs@mojatatu.com, 
	jiri@resnulli.us, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	vinicius.gomes@intel.com, xiyou.wangcong@gmail.com, xrivendell7@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    9abbc24128bc Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=14334f1a180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=af5c6c699e57bbb3
dashboard link: https://syzkaller.appspot.com/bug?extid=b65e0af58423fc8a73aa
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16d85b34180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10a70158180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ce13ec3ed5ad/disk-9abbc241.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/256cbd314121/vmlinux-9abbc241.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0af86fb52109/Image-9abbc241.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b65e0af58423fc8a73aa@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in advance_sched+0xa70/0xac0 net/sched/sch_taprio.c:953
Read of size 8 at addr ffff0000d31b4110 by task syz-executor440/31519

CPU: 0 PID: 31519 Comm: syz-executor440 Tainted: G    B              6.8.0-rc5-syzkaller-g9abbc24128bc #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:291
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:298
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd0/0x124 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x178/0x518 mm/kasan/report.c:488
 kasan_report+0xd8/0x138 mm/kasan/report.c:601
 __asan_report_load8_noabort+0x20/0x2c mm/kasan/report_generic.c:381
 advance_sched+0xa70/0xac0 net/sched/sch_taprio.c:953
 __run_hrtimer kernel/time/hrtimer.c:1689 [inline]
 __hrtimer_run_queues+0x484/0xca0 kernel/time/hrtimer.c:1753
 hrtimer_interrupt+0x4e0/0xb64 kernel/time/hrtimer.c:1815
 timer_handler drivers/clocksource/arm_arch_timer.c:674 [inline]
 arch_timer_handler_virt+0x74/0x88 drivers/clocksource/arm_arch_timer.c:685
 handle_percpu_devid_irq+0x2a4/0x804 kernel/irq/chip.c:942
 generic_handle_irq_desc include/linux/irqdesc.h:161 [inline]
 handle_irq_desc kernel/irq/irqdesc.c:672 [inline]
 generic_handle_domain_irq+0x7c/0xc4 kernel/irq/irqdesc.c:728
 __gic_handle_irq drivers/irqchip/irq-gic-v3.c:782 [inline]
 __gic_handle_irq_from_irqson drivers/irqchip/irq-gic-v3.c:833 [inline]
 gic_handle_irq+0x6c/0x190 drivers/irqchip/irq-gic-v3.c:877
 call_on_irq_stack+0x24/0x4c arch/arm64/kernel/entry.S:889
 do_interrupt_handler+0xd4/0x138 arch/arm64/kernel/entry-common.c:310
 __el1_irq arch/arm64/kernel/entry-common.c:536 [inline]
 el1_interrupt+0x34/0x68 arch/arm64/kernel/entry-common.c:551
 el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:556
 el1h_64_irq+0x64/0x68 arch/arm64/kernel/entry.S:594
 __ext4_new_inode+0xc40/0x39a0 fs/ext4/ialloc.c:1030
 ext4_symlink+0x328/0x9bc fs/ext4/namei.c:3396
 vfs_symlink+0x138/0x260 fs/namei.c:4480
 do_symlinkat+0x1bc/0x45c fs/namei.c:4506
 __do_sys_symlinkat fs/namei.c:4522 [inline]
 __se_sys_symlinkat fs/namei.c:4519 [inline]
 __arm64_sys_symlinkat+0xa4/0xbc fs/namei.c:4519
 __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:51
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:136
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:155
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598

Allocated by task 31501:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x40/0x78 mm/kasan/common.c:68
 kasan_save_alloc_info+0x70/0x84 mm/kasan/generic.c:626
 poison_kmalloc_redzone mm/kasan/common.c:372 [inline]
 __kasan_kmalloc+0xac/0xc4 mm/kasan/common.c:389
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 kmalloc_trace+0x26c/0x49c mm/slub.c:4012
 kmalloc include/linux/slab.h:590 [inline]
 kzalloc include/linux/slab.h:711 [inline]
 taprio_change+0xd14/0x3bf0 net/sched/sch_taprio.c:1881
 qdisc_change net/sched/sch_api.c:1416 [inline]
 tc_modify_qdisc+0x1474/0x1870 net/sched/sch_api.c:1746
 rtnetlink_rcv_msg+0x748/0xdbc net/core/rtnetlink.c:6618
 netlink_rcv_skb+0x214/0x3c4 net/netlink/af_netlink.c:2543
 rtnetlink_rcv+0x28/0x38 net/core/rtnetlink.c:6636
 netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
 netlink_unicast+0x65c/0x898 net/netlink/af_netlink.c:1367
 netlink_sendmsg+0x83c/0xb20 net/netlink/af_netlink.c:1908
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
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598

Freed by task 16:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x40/0x78 mm/kasan/common.c:68
 kasan_save_free_info+0x5c/0x74 mm/kasan/generic.c:640
 poison_slab_object+0x124/0x18c mm/kasan/common.c:241
 __kasan_slab_free+0x3c/0x78 mm/kasan/common.c:257
 kasan_slab_free include/linux/kasan.h:184 [inline]
 slab_free_hook mm/slub.c:2121 [inline]
 slab_free mm/slub.c:4299 [inline]
 kfree+0x144/0x3cc mm/slub.c:4409
 taprio_free_sched_cb+0x158/0x178 net/sched/sch_taprio.c:199
 rcu_do_batch kernel/rcu/tree.c:2190 [inline]
 rcu_core+0x890/0x1b34 kernel/rcu/tree.c:2465
 rcu_core_si+0x10/0x1c kernel/rcu/tree.c:2482
 __do_softirq+0x2d8/0xce4 kernel/softirq.c:553

Last potentially related work creation:
 kasan_save_stack+0x40/0x6c mm/kasan/common.c:47
 __kasan_record_aux_stack+0xc4/0x110 mm/kasan/generic.c:586
 kasan_record_aux_stack_noalloc+0x14/0x20 mm/kasan/generic.c:612
 __call_rcu_common kernel/rcu/tree.c:2715 [inline]
 call_rcu+0x104/0xaf4 kernel/rcu/tree.c:2829
 taprio_change+0x3288/0x3bf0 net/sched/sch_taprio.c:1991
 qdisc_change net/sched/sch_api.c:1416 [inline]
 tc_modify_qdisc+0x1474/0x1870 net/sched/sch_api.c:1746
 rtnetlink_rcv_msg+0x748/0xdbc net/core/rtnetlink.c:6618
 netlink_rcv_skb+0x214/0x3c4 net/netlink/af_netlink.c:2543
 rtnetlink_rcv+0x28/0x38 net/core/rtnetlink.c:6636
 netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
 netlink_unicast+0x65c/0x898 net/netlink/af_netlink.c:1367
 netlink_sendmsg+0x83c/0xb20 net/netlink/af_netlink.c:1908
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
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598

The buggy address belongs to the object at ffff0000d31b4000
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 272 bytes inside of
 freed 512-byte region [ffff0000d31b4000, ffff0000d31b4200)

The buggy address belongs to the physical page:
page:000000004df8a1f0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1131b4
head:000000004df8a1f0 order:2 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0x5ffc00000000840(slab|head|node=0|zone=2|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 05ffc00000000840 ffff0000c0001c80 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff0000d31b4000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff0000d31b4080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff0000d31b4100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff0000d31b4180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff0000d31b4200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

