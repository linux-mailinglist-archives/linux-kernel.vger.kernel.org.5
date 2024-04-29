Return-Path: <linux-kernel+bounces-162130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8328B5659
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5191328306E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA8D40C09;
	Mon, 29 Apr 2024 11:19:27 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BD53F9C2
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 11:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714389566; cv=none; b=JwVEcEXtFiOuxwVa01AelDC9K8eeRnq/+Q1O+XWoJjOsnhQCx8dDbTXrmSBxP5rP5XxqdNzP5BF0lH5iwvD+hOHWKkbo6j5HG5mTVrnGAdi2afuEn1xu8mvQq8BC/JrV3lVd4J8HeuUFmPrfUDar55hIKjeKn9pjWCqAfh1WJeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714389566; c=relaxed/simple;
	bh=Lix7uNvfqH88qdvdGtgjuA8uZt5vdnK97Cnx6teIZ9E=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=J6XwXAmgZt8dexzy/7LiNteqERH82f4m1giZcNZ/ir6eftGlPj7QZJJJv0DO0M+CDjnGj0p30oJmyJsVjsSBjZsR07JRcMAATMf1ZT7RZ5wmB873IKv9oXi0qoguVEXR47woMbE4QW+KfLcfMqRWNK7fPBCjgSxqKM4u1YejhgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36c520ec766so4138285ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 04:19:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714389564; x=1714994364;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QrwA6ccGS9ZzNPR7IhbU5qe0XHxBzNl13GT3NqqI0h4=;
        b=dbgEFFFtnxYj7W9oXAyZU6gQLHdxY6Bk93FYicmZDQYBywf2KAofH2003m2kXwBOcF
         Y90+1wKT+ahsfRsiQ4b8nUkqi6mFkmeMzXr0uJMQOamvB0xh6O1668rai5glMkrzBvVN
         9Shxzqn+iBy4d/lVLFXZSKEXNr6T5VaxwmLtm6HXtUxH31FhGIsSe//yziDwcCXaa4RW
         JCMGawfMGX/t8pdbqetxogqRxdSi+2OayoqdRkjAZA1s5twfGLi0j/aih7gcbd4XOujC
         b85HBo2rhsfaU33GJSM6T6pwEcc7aAj7thZLA6dmnv1hT1w7cy14I5Kito7GnhiAmv2X
         zxoA==
X-Forwarded-Encrypted: i=1; AJvYcCVPRAI9RXJHOh6jZevdYRnrVxmxySi1z3HEQ9rHs6zLIEsiw3rgu6IFwx6gRZkOAjDUyL852txsS5/KvmVEdTbNpTov2Y8wUn5eWXmE
X-Gm-Message-State: AOJu0YyRN4p5D9Nx4/0VPx9ThFeMVmvlhmreEpp8574PWhjqALySsLEh
	gpkPOd+rBzZiLgV2UvkCkrhOtkK0CUoBEqSL+SKSASqawhV0MtxFRSPiCdIiDsnHVueAS8AOGWT
	L135yuoRcj6tN+VyjUZD1Eb2wIbJnJP1vrfJ0PCp1fV57phsYwgXcj40=
X-Google-Smtp-Source: AGHT+IEuBysXCKvQBTo3DClN56b7Q9v0iwRmrIhf4Pv5vVS3luhq3wf2TCIcfYJ4S307Tb3KgsL7+z5qXAHrkkKR3Fv5/gubb9XN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:11a1:b0:36c:48c5:d59e with SMTP id
 1-20020a056e0211a100b0036c48c5d59emr178826ilj.6.1714389563938; Mon, 29 Apr
 2024 04:19:23 -0700 (PDT)
Date: Mon, 29 Apr 2024 04:19:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f72e8a06173a6c61@google.com>
Subject: [syzbot] [wireguard?] WARNING in wg_packet_send_staged_packets
From: syzbot <syzbot+c369d311130fba58211b@syzkaller.appspotmail.com>
To: Jason@zx2c4.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    443574b03387 riscv, bpf: Fix kfunc parameters incompatibil..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=124bc980980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=c369d311130fba58211b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3f355021a085/disk-443574b0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/44cf4de7472a/vmlinux-443574b0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a99a36c7ad65/bzImage-443574b0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c369d311130fba58211b@syzkaller.appspotmail.com

------------[ cut here ]------------
raw_local_irq_restore() called with IRQs enabled
WARNING: CPU: 1 PID: 4522 at kernel/locking/irqflag-debug.c:10 warn_bogus_irq_restore+0x29/0x40 kernel/locking/irqflag-debug.c:10
Modules linked in:
CPU: 1 PID: 4522 Comm: udevd Not tainted 6.8.0-syzkaller-05236-g443574b03387 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:warn_bogus_irq_restore+0x29/0x40 kernel/locking/irqflag-debug.c:10
Code: 90 f3 0f 1e fa 90 80 3d de 59 01 04 00 74 06 90 c3 cc cc cc cc c6 05 cf 59 01 04 01 90 48 c7 c7 20 ba aa 8b e8 f8 d5 e7 f5 90 <0f> 0b 90 90 90 c3 cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 0f 1f
RSP: 0018:ffffc90000a088f8 EFLAGS: 00010246

RAX: 4f8ab1c1a13e3e00 RBX: 0000000000000200 RCX: ffff88804d5abc00
RDX: 0000000080000301 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90000a089d0 R08: ffffffff8157cc12 R09: 1ffff110172a51a2
R10: dffffc0000000000 R11: ffffed10172a51a3 R12: 0000000000000200
R13: 0000000000000000 R14: 0000000000000246 R15: 1ffff92000141124
FS:  00007f0b23ab9c80(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b31125000 CR3: 000000002c066000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 queue_work_on+0x1ea/0x250 kernel/workqueue.c:2439
 wg_queue_enqueue_per_device_and_peer drivers/net/wireguard/queueing.h:176 [inline]
 wg_packet_create_data drivers/net/wireguard/send.c:320 [inline]
 wg_packet_send_staged_packets+0x11d6/0x1900 drivers/net/wireguard/send.c:388
 call_timer_fn+0x17e/0x600 kernel/time/timer.c:1792
------------[ cut here ]------------
WARNING: CPU: 1 PID: 4522 at kernel/softirq.c:307 __local_bh_disable_ip+0x1f6/0x220 kernel/softirq.c:307
Modules linked in:
CPU: 1 PID: 4522 Comm: udevd Not tainted 6.8.0-syzkaller-05236-g443574b03387 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:__local_bh_disable_ip+0x1f6/0x220 kernel/softirq.c:307
Code: 2c 0b 00 65 48 8b 04 25 28 00 00 00 48 3b 84 24 80 00 00 00 75 33 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc 90 <0f> 0b 90 e9 99 fe ff ff e8 4d 84 16 0a 41 f7 c6 00 02 00 00 0f 85
RSP: 0018:ffffc90000a07aa0 EFLAGS: 00010006

RAX: 0000000000010306 RBX: ffffffff895fca60 RCX: ffff88804d5abc00
RDX: dffffc0000000000 RSI: 0000000000000201 RDI: ffffffff895fca60
RBP: ffffc90000a07b68 R08: 0000000000000005 R09: ffffffff89600d7e
R10: 000000000000000c R11: ffff88804d5abc00 R12: dffffc0000000000
R13: 1ffff92000140f58 R14: ffffc90000a07b00 R15: 0000000000000201
FS:  00007f0b23ab9c80(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b31125000 CR3: 000000002c066000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:125 [inline]
 _raw_spin_lock_bh+0x1c/0x50 kernel/locking/spinlock.c:178
 spin_lock_bh include/linux/spinlock.h:356 [inline]
 sock_hash_delete_elem+0xb0/0x300 net/core/sock_map.c:939
 bpf_prog_bc4ba9860fbb0da4+0x46/0x4a
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run3+0x238/0x460 kernel/trace/bpf_trace.c:2421
 trace_workqueue_queue_work include/trace/events/workqueue.h:23 [inline]
 __queue_work+0xe5b/0xec0 kernel/workqueue.c:2382
 queue_work_on+0x14f/0x250 kernel/workqueue.c:2435
 queue_work include/linux/workqueue.h:605 [inline]
 stats_request+0xd0/0x100 drivers/virtio/virtio_balloon.c:374
 vring_interrupt+0x21d/0x380 drivers/virtio/virtio_ring.c:2595
 __handle_irq_event_percpu+0x28a/0xa30 kernel/irq/handle.c:158
 handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
 handle_irq_event+0x89/0x1f0 kernel/irq/handle.c:210
 handle_edge_irq+0x25f/0xc20 kernel/irq/chip.c:831
 generic_handle_irq_desc include/linux/irqdesc.h:161 [inline]
 handle_irq arch/x86/kernel/irq.c:238 [inline]
 __common_interrupt+0x138/0x230 arch/x86/kernel/irq.c:257
 common_interrupt+0x4f/0xd0 arch/x86/kernel/irq.c:247
 asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
RIP: 0010:console_flush_all+0x9cd/0xec0 kernel/printk/printk.c:2962
Code: 48 21 c3 0f 85 fa 01 00 00 e8 1f 6a 1f 00 48 8b 5c 24 38 4d 85 f6 75 07 e8 10 6a 1f 00 eb 06 e8 09 6a 1f 00 fb 48 8b 44 24 58 <42> 0f b6 04 28 84 c0 0f 85 4a 02 00 00 0f b6 1b 31 ff 89 de e8 ea
RSP: 0018:ffffc90000a08180 EFLAGS: 00000246

RAX: 1ffff9200014107c RBX: ffffc90000a083e0 RCX: ffff88804d5abc00
RDX: 0000000000000303 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90000a08330 R08: ffffffff8175863e R09: 1ffffffff1f0d5cd
R10: dffffc0000000000 R11: fffffbfff1f0d5ce R12: ffffffff8e8f47e0
R13: dffffc0000000000 R14: 0000000000000200 R15: ffffffff8e8f4838
 console_unlock+0x13b/0x4d0 kernel/printk/printk.c:3025
 vprintk_emit+0x509/0x720 kernel/printk/printk.c:2292
 _printk+0xd5/0x120 kernel/printk/printk.c:2317
 printk_stack_address arch/x86/kernel/dumpstack.c:72 [inline]
 show_trace_log_lvl+0x43a/0x520 arch/x86/kernel/dumpstack.c:285
 __warn+0x163/0x4b0 kernel/panic.c:675
 __report_bug lib/bug.c:199 [inline]
 report_bug+0x2b3/0x500 lib/bug.c:219
 handle_bug+0x3e/0x70 arch/x86/kernel/traps.c:239
 exc_invalid_op+0x1a/0x50 arch/x86/kernel/traps.c:260
 asm_exc_invalid_op+0x1a/0x20 arch/x86/include/asm/idtentry.h:621
RIP: 0010:warn_bogus_irq_restore+0x29/0x40 kernel/locking/irqflag-debug.c:10
Code: 90 f3 0f 1e fa 90 80 3d de 59 01 04 00 74 06 90 c3 cc cc cc cc c6 05 cf 59 01 04 01 90 48 c7 c7 20 ba aa 8b e8 f8 d5 e7 f5 90 <0f> 0b 90 90 90 c3 cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 0f 1f
RSP: 0018:ffffc90000a088f8 EFLAGS: 00010246

RAX: 4f8ab1c1a13e3e00 RBX: 0000000000000200 RCX: ffff88804d5abc00
RDX: 0000000080000301 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90000a089d0 R08: ffffffff8157cc12 R09: 1ffff110172a51a2
R10: dffffc0000000000 R11: ffffed10172a51a3 R12: 0000000000000200
R13: 0000000000000000 R14: 0000000000000246 R15: 1ffff92000141124
 queue_work_on+0x1ea/0x250 kernel/workqueue.c:2439
 wg_queue_enqueue_per_device_and_peer drivers/net/wireguard/queueing.h:176 [inline]
 wg_packet_create_data drivers/net/wireguard/send.c:320 [inline]
 wg_packet_send_staged_packets+0x11d6/0x1900 drivers/net/wireguard/send.c:388
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
RIP: 0010:check_kcov_mode kernel/kcov.c:175 [inline]
RIP: 0010:write_comp_data kernel/kcov.c:236 [inline]
RIP: 0010:__sanitizer_cov_trace_const_cmp8+0x2f/0x90 kernel/kcov.c:311
Code: 8b 04 24 65 48 8b 0c 25 80 ce 03 00 65 8b 05 20 d9 6e 7e a9 00 01 ff 00 74 10 a9 00 01 00 00 74 57 83 b9 14 16 00 00 00 74 4e <8b> 81 f0 15 00 00 83 f8 03 75 43 48 8b 91 f8 15 00 00 44 8b 89 f4
RSP: 0018:ffffc9000318f7b8 EFLAGS: 00000246

RAX: 0000000080000001 RBX: ffffc9000318f948 RCX: ffff88804d5abc00
RDX: ffffc9000318f935 RSI: ffffffff8140c1eb RDI: 0000000000000000
RBP: ffffffff8140c1ec R08: ffffffff8140911c R09: 0000000000000000
R10: ffffc9000318f900 R11: fffff52000631f2c R12: ffffc9000318f900
R13: ffffc9000318f950 R14: dffffc0000000000 R15: ffffffff8140c1ec
 orc_find arch/x86/kernel/unwind_orc.c:202 [inline]
 unwind_next_frame+0x1ac/0x2a00 arch/x86/kernel/unwind_orc.c:494
 __unwind_start+0x641/0x7c0 arch/x86/kernel/unwind_orc.c:760
 unwind_start arch/x86/include/asm/unwind.h:64 [inline]
 arch_stack_walk+0x103/0x1b0 arch/x86/kernel/stacktrace.c:24
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:312 [inline]
 __kasan_slab_alloc+0x66/0x80 mm/kasan/common.c:338
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slub.c:3813 [inline]
 slab_alloc_node mm/slub.c:3860 [inline]
 kmem_cache_alloc+0x172/0x350 mm/slub.c:3867
 getname_flags+0xbd/0x4f0 fs/namei.c:140
 user_path_at_empty+0x2c/0x60 fs/namei.c:2921
 do_readlinkat+0x118/0x3b0 fs/stat.c:499
 __do_sys_readlink fs/stat.c:532 [inline]
 __se_sys_readlink fs/stat.c:529 [inline]
 __x64_sys_readlink+0x7f/0x90 fs/stat.c:529
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f0b23b90d47
Code: 73 01 c3 48 8b 0d e1 90 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 59 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b1 90 0d 00 f7 d8 64 89 01 48
RSP: 002b:00007fff186caf58 EFLAGS: 00000246
 ORIG_RAX: 0000000000000059
RAX: ffffffffffffffda RBX: 00007fff186caf68 RCX: 00007f0b23b90d47
RDX: 0000000000000400 RSI: 00007fff186caf68 RDI: 00007fff186cb448
RBP: 0000000000000400 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff186cb448
R13: 00007fff186cb3b8 R14: 0000561d6917e910 R15: 0000000000000000
 </TASK>
----------------
Code disassembly (best guess):
   0:	48 21 c3             	and    %rax,%rbx
   3:	0f 85 fa 01 00 00    	jne    0x203
   9:	e8 1f 6a 1f 00       	call   0x1f6a2d
   e:	48 8b 5c 24 38       	mov    0x38(%rsp),%rbx
  13:	4d 85 f6             	test   %r14,%r14
  16:	75 07                	jne    0x1f
  18:	e8 10 6a 1f 00       	call   0x1f6a2d
  1d:	eb 06                	jmp    0x25
  1f:	e8 09 6a 1f 00       	call   0x1f6a2d
  24:	fb                   	sti
  25:	48 8b 44 24 58       	mov    0x58(%rsp),%rax
* 2a:	42 0f b6 04 28       	movzbl (%rax,%r13,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	0f 85 4a 02 00 00    	jne    0x281
  37:	0f b6 1b             	movzbl (%rbx),%ebx
  3a:	31 ff                	xor    %edi,%edi
  3c:	89 de                	mov    %ebx,%esi
  3e:	e8                   	.byte 0xe8
  3f:	ea                   	(bad)


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

