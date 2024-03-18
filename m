Return-Path: <linux-kernel+bounces-106409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0AE87EE3F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AF191C21501
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7400155E57;
	Mon, 18 Mar 2024 16:58:23 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C631855769
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 16:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710781102; cv=none; b=XdZBN1cmom8c6GO9Mcl1fUxYYm57F4WI5o9gQy8SW32sxOeNs5rkSoqDjP1/jJlNLCuOKihjnXVl/x+eTo5eqcx7Aetx/CAfNQZTsOZoEzfZujdgQXG6fyOte7CfYVFq0XRJov4nQDQCo+yUIetU4MuvcVuIRAW9wIB2tY8zDs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710781102; c=relaxed/simple;
	bh=EDRhD0W5RaseMzcIYypwzbpZn3HXkiqOgLRm2P0uAq8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Y0FQWA4pWs1cNtiwHOAaWHayGj1HwE/fgiuf6ODHuXNGJOq1c/STnDYgWMUhTXEv5b/8fQn0uaZHuI9vudRSQRFvUk1idF0z3aXbYkC5dQp7AqR6jvIWdkr+aedsnyyIIHqnEFIatJzG7cPZfOXjgRTERG8rOTpQ6HNdfxd1wpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c75dee76c0so334224339f.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 09:58:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710781100; x=1711385900;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YxBT5JqqnppwVVZN+x3gFikurhLXay1BC6a88PlHsl4=;
        b=BHiq3nt7xu3YskasPwqW5Jwr9R6YDNwdphkzAp5yWfIYlXHBvrpWCaJqHTvEFxxNcW
         OHXXcnezoGM4+r8x3DhrbWRc/sbSN8ZlxGLspalSNWdpBovmNg8aU/4pK1BblIYSLgJo
         ixx2a8Px+SGf8y9CPemIAWa7FUYgq3jErvS6i+CQX5eC0K7Xw+VQXVR7mrb1xyccaI9J
         /7Q7bYAGK835F5AXQKl4+x+JyZMsjdH7UTZnL0C1wRPW4ww5gw0VungV7LvrUDvg19hL
         ulCI0/LjCY41CreXwbq08u7IEucbep7LqQn3J1Lu2SCKihToEHs1qN5z5v72tfNEyk9S
         J4RQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrGaTs4JfFeJCqTjvihSrMx8zG7K1PuBd8vX7L4iZHT1sk2Dp/Wy8H8CnGM9LrQaJXSUWqAbJYBlHz1bySGFJmEeob0eVZCGzV+ki9
X-Gm-Message-State: AOJu0YyQOXjhJKnB+d8nkPVcR/DHDtTnujS6ke/xKdIBZGIfXL8GCLku
	WMl8+bVIUbIpRZP1j0tDtKr7OOl0Ic7lmowrNkx6lGTwsB/O7K+0JdlCrTXhfGK9I4pJDkgSwPw
	t7RoOsK7Ei1L15wisGA2dVP2VTDmqFGHZvr1tweH70qFQRqMb8vQza9E=
X-Google-Smtp-Source: AGHT+IF1cJvGS2ShHKslKnSH2uLa6dRsneHfv/NAcAyi5hvtNJv/LguckzfMaGpBGW9hG8fuA+reFNFk1fULzNnziio6xOPkv/Eg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3408:b0:7c8:56ec:ac1 with SMTP id
 n8-20020a056602340800b007c856ec0ac1mr3549ioz.2.1710781099941; Mon, 18 Mar
 2024 09:58:19 -0700 (PDT)
Date: Mon, 18 Mar 2024 09:58:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c0297f0613f2439f@google.com>
Subject: [syzbot] [bpf?] [net?] WARNING in __sock_map_delete
From: syzbot <syzbot+ca1c5a4609c82306ce19@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	jakub@cloudflare.com, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    66a27abac311 Merge tag 'powerpc-6.9-1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12252985180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1ef5fbdba17e3dbc
dashboard link: https://syzkaller.appspot.com/bug?extid=ca1c5a4609c82306ce19
compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1138c2a5180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=103089a5180000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/8ead8862021c/non_bootable_disk-66a27aba.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/611e73ba3400/vmlinux-66a27aba.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8e0bfa57ae67/zImage-66a27aba.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ca1c5a4609c82306ce19@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 4390 at kernel/softirq.c:361 __local_bh_enable_ip+0xa0/0xd0 kernel/softirq.c:361
Modules linked in:
Kernel panic - not syncing: kernel: panic_on_warn set ...
CPU: 0 PID: 4390 Comm: syz-executor407 Not tainted 6.8.0-syzkaller #0
Hardware name: ARM-Versatile Express
Backtrace: frame pointer underflow
[<81863324>] (dump_backtrace) from [<81863420>] (show_stack+0x18/0x1c arch/arm/kernel/traps.c:256)
 r7:00000000 r6:82622e44 r5:00000000 r4:81fc0df8
[<81863408>] (show_stack) from [<81880b84>] (__dump_stack lib/dump_stack.c:88 [inline])
[<81863408>] (show_stack) from [<81880b84>] (dump_stack_lvl+0x54/0x7c lib/dump_stack.c:114)
[<81880b30>] (dump_stack_lvl) from [<81880bc4>] (dump_stack+0x18/0x1c lib/dump_stack.c:123)
 r5:00000000 r4:82858d18
[<81880bac>] (dump_stack) from [<81863ec8>] (panic+0x120/0x358 kernel/panic.c:348)
[<81863da8>] (panic) from [<8024388c>] (check_panic_on_warn kernel/panic.c:241 [inline])
[<81863da8>] (panic) from [<8024388c>] (print_tainted+0x0/0xa0 kernel/panic.c:236)
 r3:8260c584 r2:00000001 r1:81fa9b44 r0:81fb16ec
 r7:8024c6d0
[<80243818>] (check_panic_on_warn) from [<80243a80>] (__warn+0x7c/0x180 kernel/panic.c:694)
[<80243a04>] (__warn) from [<80243cfc>] (warn_slowpath_fmt+0x178/0x1f4 kernel/panic.c:719)
 r8:00000009 r7:81fb2024 r6:df801c6c r5:84900000 r4:00000000
[<80243b88>] (warn_slowpath_fmt) from [<8024c6d0>] (__local_bh_enable_ip+0xa0/0xd0 kernel/softirq.c:361)
 r10:8260c590 r9:00000000 r8:00000008 r7:00000000 r6:00000000 r5:00000201
 r4:84900000
[<8024c630>] (__local_bh_enable_ip) from [<8188db78>] (__raw_spin_unlock_bh include/linux/spinlock_api_smp.h:167 [inline])
[<8024c630>] (__local_bh_enable_ip) from [<8188db78>] (_raw_spin_unlock_bh+0x34/0x38 kernel/locking/spinlock.c:210)
 r5:847941cc r4:ffffffea
[<8188db44>] (_raw_spin_unlock_bh) from [<813fd618>] (spin_unlock_bh include/linux/spinlock.h:396 [inline])
[<8188db44>] (_raw_spin_unlock_bh) from [<813fd618>] (__sock_map_delete+0x4c/0x84 net/core/sock_map.c:424)
[<813fd5cc>] (__sock_map_delete) from [<813fd67c>] (sock_map_delete_elem+0x2c/0x38 net/core/sock_map.c:446)
 r7:00000000 r6:803c0bb4 r5:8092da0c r4:dfcb3000
[<813fd650>] (sock_map_delete_elem) from [<803c0bd0>] (____bpf_map_delete_elem kernel/bpf/helpers.c:77 [inline])
[<813fd650>] (sock_map_delete_elem) from [<803c0bd0>] (bpf_map_delete_elem+0x1c/0x24 kernel/bpf/helpers.c:73)
[<803c0bb4>] (bpf_map_delete_elem) from [<7f08516c>] (bpf_prog_2c29ac5cdc6b1842+0xc8/0xd4)
[<7f0850a4>] (bpf_prog_2c29ac5cdc6b1842) from [<8037c7b0>] (bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline])
[<7f0850a4>] (bpf_prog_2c29ac5cdc6b1842) from [<8037c7b0>] (__bpf_prog_run include/linux/filter.h:657 [inline])
[<7f0850a4>] (bpf_prog_2c29ac5cdc6b1842) from [<8037c7b0>] (bpf_prog_run include/linux/filter.h:664 [inline])
[<7f0850a4>] (bpf_prog_2c29ac5cdc6b1842) from [<8037c7b0>] (__bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline])
[<7f0850a4>] (bpf_prog_2c29ac5cdc6b1842) from [<8037c7b0>] (bpf_trace_run2+0x70/0x158 kernel/trace/bpf_trace.c:2420)
 r9:844a74c0 r8:00000030 r7:8092da0c r6:844a74c0 r5:8092da0c r4:dfcb3000
[<8037c740>] (bpf_trace_run2) from [<80464c58>] (__bpf_trace_kfree+0x28/0x30 include/trace/events/kmem.h:94)
 r8:00000030 r7:8092da0c r6:844a74c0 r5:8092da0c r4:844a7a08
[<80464c30>] (__bpf_trace_kfree) from [<804629ac>] (__traceiter_kfree+0x3c/0x50 include/trace/events/kmem.h:94)
[<80462970>] (__traceiter_kfree) from [<804b0170>] (trace_kfree include/trace/events/kmem.h:94 [inline])
[<80462970>] (__traceiter_kfree) from [<804b0170>] (kfree+0x1f0/0x334 mm/slub.c:4377)
 r7:8092da0c r6:00000000 r5:84900000 r4:844a74c0
[<804aff80>] (kfree) from [<8092da0c>] (detach_buf_split+0x13c/0x170 drivers/virtio/virtio_ring.c:810)
 r10:8260c590 r9:844a74c0 r8:00000030 r7:00000060 r6:00000000 r5:00000006
 r4:83aa3900
[<8092d8d0>] (detach_buf_split) from [<8092dacc>] (virtqueue_get_buf_ctx_split+0x8c/0x15c drivers/virtio/virtio_ring.c:865)
 r9:00000000 r8:a0000193 r7:83aa3900 r6:83aa3840 r5:83cd50b8 r4:83aa3900
[<8092da40>] (virtqueue_get_buf_ctx_split) from [<8092e51c>] (virtqueue_get_buf_ctx drivers/virtio/virtio_ring.c:2421 [inline])
[<8092da40>] (virtqueue_get_buf_ctx_split) from [<8092e51c>] (virtqueue_get_buf+0x28/0x2c drivers/virtio/virtio_ring.c:2427)
 r5:00000000 r4:83aa3900
[<8092e4f4>] (virtqueue_get_buf) from [<80a7c128>] (virtblk_done+0x78/0x104 drivers/block/virtio_blk.c:363)
[<80a7c0b0>] (virtblk_done) from [<8092e2b0>] (vring_interrupt drivers/virtio/virtio_ring.c:2595 [inline])
[<80a7c0b0>] (virtblk_done) from [<8092e2b0>] (vring_interrupt+0x88/0xfc drivers/virtio/virtio_ring.c:2570)
 r9:20000193 r8:82e1322c r7:00000021 r6:82e13230 r5:00000000 r4:83aa3900
[<8092e228>] (vring_interrupt) from [<80933514>] (vm_interrupt+0x70/0xa8 drivers/virtio/virtio_mmio.c:320)
 r5:00000000 r4:83ab33c0
[<809334a4>] (vm_interrupt) from [<802c13f4>] (__handle_irq_event_percpu+0x5c/0x278 kernel/irq/handle.c:158)
 r9:00000021 r8:00000000 r7:df801f88 r6:84900000 r5:83aaab6c r4:83ab32c0
[<802c1398>] (__handle_irq_event_percpu) from [<802c1698>] (handle_irq_event_percpu kernel/irq/handle.c:193 [inline])
[<802c1398>] (__handle_irq_event_percpu) from [<802c1698>] (handle_irq_event+0x40/0x88 kernel/irq/handle.c:210)
 r10:84900000 r9:84900000 r8:00000000 r7:df801f88 r6:83aaab6c r5:83aaab6c
 r4:83aaab00
[<802c1658>] (handle_irq_event) from [<802c6564>] (handle_fasteoi_irq+0xbc/0x268 kernel/irq/chip.c:720)
 r7:df801f88 r6:81b0f8f0 r5:83aaab6c r4:83aaab00
[<802c64a8>] (handle_fasteoi_irq) from [<802c0ad8>] (generic_handle_irq_desc include/linux/irqdesc.h:161 [inline])
[<802c64a8>] (handle_fasteoi_irq) from [<802c0ad8>] (handle_irq_desc kernel/irq/irqdesc.c:688 [inline])
[<802c64a8>] (handle_fasteoi_irq) from [<802c0ad8>] (generic_handle_domain_irq+0x30/0x40 kernel/irq/irqdesc.c:744)
 r7:df80a00c r6:824b2340 r5:df80a000 r4:8260ce40
[<802c0aa8>] (generic_handle_domain_irq) from [<802011c4>] (gic_handle_irq+0x68/0x7c drivers/irqchip/irq-gic.c:370)
[<8020115c>] (gic_handle_irq) from [<81881464>] (generic_handle_arch_irq+0x60/0x80 kernel/irq/handle.c:238)
 r7:eb395d20 r6:821421b8 r5:8217e2f8 r4:824b3ae4
[<81881404>] (generic_handle_arch_irq) from [<81833030>] (call_with_stack+0x1c/0x20 arch/arm/lib/call_with_stack.S:40)
 r9:84900000 r8:00000090 r7:eb395d54 r6:ffffffff r5:60000013 r4:80559d78
[<81833014>] (call_with_stack) from [<80200b84>] (__irq_svc+0x84/0xac arch/arm/kernel/entry-armv.S:221)
Exception stack(0xeb395d20 to 0xeb395d68)
5d20: 81fc68d8 81a14d28 dfcc9000 00080002 dfcc9000 00000000 00000000 eb395da0
5d40: 00000090 849b62f0 84900000 eb395d84 eb395d58 eb395d70 80397eac 80559d78
5d60: 60000013 ffffffff
[<80397e74>] (bpf_prog_new_fd) from [<80398808>] (bpf_prog_load+0x954/0xca8 kernel/bpf/syscall.c:2925)
 r5:00000000 r4:dfcc9000
[<80397eb4>] (bpf_prog_load) from [<80399920>] (__sys_bpf+0x2ec/0x1ef0 kernel/bpf/syscall.c:5631)
 r10:00000000 r9:00000090 r8:200005c0 r7:00000005 r6:eb395e98 r5:00000090
 r4:00000000
[<80399634>] (__sys_bpf) from [<8039baa4>] (__do_sys_bpf kernel/bpf/syscall.c:5738 [inline])
[<80399634>] (__sys_bpf) from [<8039baa4>] (sys_bpf+0x2c/0x48 kernel/bpf/syscall.c:5736)
 r10:00000182 r9:84900000 r8:80200288 r7:00000182 r6:7ecdd160 r5:00000000
 r4:ffffffff
[<8039ba78>] (sys_bpf) from [<80200060>] (ret_fast_syscall+0x0/0x1c arch/arm/mm/proc-v7.S:66)
Exception stack(0xeb395fa8 to 0xeb395ff0)
5fa0:                   ffffffff 00000000 00000005 200005c0 00000090 00000000
5fc0: ffffffff 00000000 7ecdd160 00000182 20000600 20000500 0008a270 ffffffb7
5fe0: 7eb98c58 7eb98c48 000108a8 0002ec80
Rebooting in 86400 seconds..


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

