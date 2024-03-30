Return-Path: <linux-kernel+bounces-125731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35487892B4B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 14:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 887B1283189
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 13:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F04E21364;
	Sat, 30 Mar 2024 13:19:22 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0011427B
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 13:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711804761; cv=none; b=lo4IV6QD3nKiMlfqnWtEMFlOGs4dmcChtFC3LR0XdNj9tIbB7ZRVQR8vUfBIngi6kpmRD+A9CQXD9++pN9/Um352FYZ+Ovp9Hw25Rc2oVrGi1MBINw4ivqICrYP1lEvnidZIs79cEJFscwok7zPhK12KgjKiSkiVNuZwOiOh4IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711804761; c=relaxed/simple;
	bh=HYV/JRQE0/mXAN6uA2PqRtNdnfEcbXaWVA2fORovUuU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qtfEGmfUDLH1PO/6tW9KixLkw2MjEwynsE14I/rWl9pON+IeU2yYcjM3e5j2X4X8Tuw/Wlxbp89W3zVY/AC36jlDMBi06MRsxobW5L+H5ZUhENUaIhX0nOLMppnGwmo5JZJcQC8WtS6aR4sr3dPJSdwKBqT/dJzF4WJTBZsB9HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c9aa481ce4so283573339f.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 06:19:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711804759; x=1712409559;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8wNBEXtBeqkE/P4HohCn/zU42lC2eI5hJ+p+PumMu7k=;
        b=BNT+0KpTH4UxNToMhdOcVFPEfmUMx23YS5VIPydyMH/aAVf/4XBnzQdcTd0zk95Xvg
         fQc5LYxIgx70TRwXZP2IWO+lfsmte1naXgsUk3Y2JSs/9hCuZQV8/eAhAvo7IxISVYJa
         oYR2EzmMVYWlznDzQ6UibGEkViuWnSWX981Oevwov85b93APWr1QAQTio+99lbCUnpP8
         fjFo9AsP4WuKss7mX4xDMl/Lwa/hzPJyPkSaljMdK4vi5gsQvjKo7X9goBqQPKRI6bkx
         GPq+tcknpG4Co4mul1dN6oJxN6NXi7Raz0eA0G1jHzSQZ6YOWYPHy/N/UFxxnWDn6n0c
         S2HA==
X-Forwarded-Encrypted: i=1; AJvYcCXft3oK84rh59j2XarbMM6x1XrL+RpFvPsxNelu3CR6oerr/syicGdQ2geh/nL5XZmEoT+VoR9dVrwPYxtFhZ58J1GOjAK5klGw9wlD
X-Gm-Message-State: AOJu0YzUhWRurvTSUfi/zvp/vr2mfF2Pqut5Uv4xmxhG4GHMsbll1qSQ
	XN1G6ZX3EgGm/+NhwJdLZB3GAtzfyMB/iXUuBUO3Rjez62WTLUvUTpyU2iSUmh2M661fLzouB4t
	sRlR8ozeBYD6rrXLAqIrgm8/YWSKwkaQDC99anekc3TZvaP1pJILHEsQ=
X-Google-Smtp-Source: AGHT+IHusaEsOgH5WjFwmajaC9hz/Gj0e+GybbGsj8JLMZLBpKpkoPp7tvo2TadJOwtdqVRBVeiuZyP2TJn7ZE7VlPrYew524o20
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2198:b0:368:efa4:be01 with SMTP id
 j24-20020a056e02219800b00368efa4be01mr241070ila.3.1711804759442; Sat, 30 Mar
 2024 06:19:19 -0700 (PDT)
Date: Sat, 30 Mar 2024 06:19:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009c96a60614e09a8c@google.com>
Subject: [syzbot] [kernel?] WARNING in scheduler_tick
From: syzbot <syzbot+effa8aeb3d011d4d4c78@syzkaller.appspotmail.com>
To: frederic@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    928a87efa423 Merge tag 'gfs2-v6.8-fix' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=161e3185180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a2fbd4c518bbb6b3
dashboard link: https://syzkaller.appspot.com/bug?extid=effa8aeb3d011d4d4c78
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-928a87ef.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ab1845cd4618/vmlinux-928a87ef.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a80aea5d79f2/bzImage-928a87ef.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+effa8aeb3d011d4d4c78@syzkaller.appspotmail.com

------------[ cut here ]------------
================================
WARNING: CPU: 2 PID: 0 at kernel/softirq.c:362 __local_bh_enable_ip+0xc3/0x120 kernel/softirq.c:362
WARNING: inconsistent lock state
Modules linked in:
6.9.0-rc1-syzkaller-00005-g928a87efa423 #0 Not tainted
CPU: 2 PID: 0 Comm: swapper/2 Not tainted 6.9.0-rc1-syzkaller-00005-g928a87efa423 #0
--------------------------------
inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
swapper/0/0 [HC0[0]:SC0[0]:HE0:SE1] takes:
ffff88802c23e718 (&rq->__lock){?.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:559
{IN-HARDIRQ-W} state was registered at:
  lock_acquire kernel/locking/lockdep.c:5754 [inline]
  lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
  _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
RIP: 0010:__local_bh_enable_ip+0xc3/0x120 kernel/softirq.c:362
  raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:559
Code: 00 e8 21 56 0b 00 e8 bc 54 42 00 fb 65 8b 05 9c fd b0 7e 85 c0 74 52 5b 5d c3 cc cc cc cc 65 8b 05 9e b1 af 7e 85 c0 75 9e 90 <0f> 0b 90 eb 98 e8 c3 52 42 00 eb 99 48 89 ef e8 09 cf 19 00 eb a2
  raw_spin_rq_lock kernel/sched/sched.h:1385 [inline]
  rq_lock kernel/sched/sched.h:1699 [inline]
  scheduler_tick+0xa2/0x650 kernel/sched/core.c:5679
RSP: 0018:ffffc90000477b20 EFLAGS: 00010046
  update_process_times+0x199/0x220 kernel/time/timer.c:2491

  tick_periodic+0x7e/0x230 kernel/time/tick-common.c:100
RAX: 0000000000000000 RBX: 0000000000000201 RCX: 1ffffffff1f3f383
  tick_handle_periodic+0x45/0x120 kernel/time/tick-common.c:112
RDX: 0000000000000000 RSI: 0000000000000201 RDI: ffffffff88ce4ce8
  timer_interrupt+0x4e/0x80 arch/x86/kernel/time.c:57
RBP: ffffffff88ce4ce8 R08: 0000000000000000 R09: ffffed1008f71301
R10: ffff888047b8980b R11: 0000000000000002 R12: dffffc0000000000
  __handle_irq_event_percpu+0x22c/0x7c0 kernel/irq/handle.c:158
R13: ffff8880259f8c00 R14: 0000000000000000 R15: 0000000000000004
  handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
  handle_irq_event+0xab/0x1e0 kernel/irq/handle.c:210
FS:  0000000000000000(0000) GS:ffff88802c400000(0000) knlGS:0000000000000000
  handle_level_irq+0x25d/0x6f0 kernel/irq/chip.c:648
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  generic_handle_irq_desc include/linux/irqdesc.h:161 [inline]
  handle_irq arch/x86/kernel/irq.c:238 [inline]
  __common_interrupt+0xe1/0x250 arch/x86/kernel/irq.c:257
CR2: 0000000031a23000 CR3: 000000005da20000 CR4: 0000000000350ef0
  common_interrupt+0xab/0xd0 arch/x86/kernel/irq.c:247
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
  _raw_spin_unlock_irqrestore+0x31/0x80 kernel/locking/spinlock.c:194
Call Trace:
  __setup_irq+0x1069/0x1e80 kernel/irq/manage.c:1818
 <TASK>
  request_threaded_irq+0x2b4/0x3e0 kernel/irq/manage.c:2202
  request_irq include/linux/interrupt.h:168 [inline]
  setup_default_timer_irq arch/x86/kernel/time.c:70 [inline]
  hpet_time_init+0x5b/0x90 arch/x86/kernel/time.c:82
  x86_late_time_init+0x51/0xc0 arch/x86/kernel/time.c:94
  start_kernel+0x317/0x490 init/main.c:1036
  x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:507
  x86_64_start_kernel+0xb2/0xc0 arch/x86/kernel/head64.c:488
  common_startup_64+0x13e/0x148
irq event stamp: 622080
hardirqs last  enabled at (622077): [<ffffffff817fbbd1>] tick_nohz_idle_exit+0x1c1/0x2e0 kernel/time/tick-sched.c:1465
hardirqs last disabled at (622078): [<ffffffff8ad6c44a>] __schedule+0x290a/0x5d00 kernel/sched/core.c:6634
softirqs last  enabled at (622080): [<ffffffff88ce4ce8>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
softirqs last  enabled at (622080): [<ffffffff88ce4ce8>] sock_hash_delete_elem+0x2b8/0x360 net/core/sock_map.c:947
softirqs last disabled at (622079): [<ffffffff88ce4b04>] spin_lock_bh include/linux/spinlock.h:356 [inline]
softirqs last disabled at (622079): [<ffffffff88ce4b04>] sock_hash_delete_elem+0xd4/0x360 net/core/sock_map.c:939
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 sock_hash_delete_elem+0x2b8/0x360 net/core/sock_map.c:947

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
 bpf_prog_2fe495d516d5c300+0x45/0x49
  lock(&rq->__lock);
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run4+0x176/0x460 kernel/trace/bpf_trace.c:2422
  <Interrupt>
    lock(&rq->__lock
);

 *** DEADLOCK ***

2 locks held by swapper/0/0:
 #0: ffff88802c23e718
 trace_sched_switch include/trace/events/sched.h:222 [inline]
 __schedule+0x252c/0x5d00 kernel/sched/core.c:6743
 (&rq->__lock){?.-.}-{2:2}
, at: raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:559
 #1: ffffffff8d7b4b60
 (rcu_read_lock
){....}-{1:2}
, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
, at: __bpf_trace_run kernel/trace/bpf_trace.c:2380 [inline]
, at: bpf_trace_run4+0x107/0x460 kernel/trace/bpf_trace.c:2422

stack backtrace:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.9.0-rc1-syzkaller-00005-g928a87efa423 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
 schedule_idle+0x59/0x90 kernel/sched/core.c:6864
Call Trace:
 do_idle+0x287/0x3f0 kernel/sched/idle.c:360
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:430
 print_usage_bug kernel/locking/lockdep.c:3971 [inline]
 valid_state kernel/locking/lockdep.c:4013 [inline]
 mark_lock_irq kernel/locking/lockdep.c:4216 [inline]
 mark_lock+0x923/0xc60 kernel/locking/lockdep.c:4678
 start_secondary+0x220/0x2b0 arch/x86/kernel/smpboot.c:313
 common_startup_64+0x13e/0x148
 </TASK>


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

