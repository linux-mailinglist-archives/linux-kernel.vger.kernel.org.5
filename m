Return-Path: <linux-kernel+bounces-119044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B69588C311
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABE141C2CEA0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EFD71756;
	Tue, 26 Mar 2024 13:13:47 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBB05CDE7
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 13:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711458826; cv=none; b=DEpTBHFCj5DuDlcSFnk1nKTr+Vbc0Kal/goNUmREgcjuC2ypd+l8jk9NmSh/uQDZmOvqrTjcwvfVHKs0OdpX3a8Ljk+JljMuuNsjnlEQF/buSOlYsneeq4I1AZvMpcZawufzXluWAAprhw05LwoqRu3VY+vK6qFQpj8h4TVNBQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711458826; c=relaxed/simple;
	bh=01rXpUtRadwgSZ4e86OoQVxRQkmfd4pGXxG0GUkQX/Q=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KwOb3BrzzACcAo3WSdmVGVIm9rMzVUGQ2YBTSbciMWEWlJYSLJa5on6+M5X7okXmCXI3Kf5Ph/nD0JzztyzdL1jeb2AbYn3P4mWuuo8QpbnnHUNysMt3so3carFl/9Nrpaswnzpefw0icn6GFLCjPdFnBo/HmzWiY1Dz3Hl86FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7cf265b30e2so556786139f.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 06:13:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711458824; x=1712063624;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d9isEF4216kbY5BoMZnM3m0Nc6D/iwXUtaIHD8mAK9Y=;
        b=T6p1mmdNiZU3KDTNfVq2zy8ZQVxI87CaB5RK5yhG/BpWgJRexaKnlJoRqpZUh13yhO
         y3oca508w4nfmITKjJaj08fBm0qGzlSTwJ6SXwkCGhFm7Icni2/cNjnkQyfg0abute7/
         o+3zr8FvXkqGfiFksGAeNdUwWwap1sst6522lE0enyiqYadky1IUuQP5IhV5JWoKVEQ0
         3d5kNs0wyeaKIF0R9SD6Bx73LfhpvTEI5unxkMMM3VY6fA4v82n5U8A9kNZwuwS/LaNy
         ymG7493wb+SkGfN0fOp16CpID2sEdT7BrgZrPwKBU7aO1PIrmUNYdPKyoLtcjJVDSRBJ
         m/ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOQ5KqTwFyiIfGw96p/GnVLH/rwgPlr3c7wveXlIWYFZUdOFWLjtiL7jksSmrBPRJQkSYqJR1gadFo0WFHIZG9PvzbJTAU54f3vX3C
X-Gm-Message-State: AOJu0YzuZzJ77/hgoVpvwYZzQq1ejsmiJ+qrMxShIcIiu045SLB61r3g
	ikFyWRympc0GLJicT+2YGjJoaMu23Nz3vW1yWCxA+W1J2Js0qKvHKqOJUiybvtU4eDmK6Omj/Gh
	3KJBuyU0V85LZKx2B0wGkQM8ImO0ijfTwsRvIxlYVn7EMyx/DAwSfAG0=
X-Google-Smtp-Source: AGHT+IHNcvfQVw2v6mEwMqMCx2PV+8QaNynrDznqj4s/DSejhJ/FY851u01ED6HKTOtkrgTPj9+qZk2TxzmjFdZgHqPBBgP2Uu/M
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2b23:b0:47c:19be:1f5b with SMTP id
 fm35-20020a0566382b2300b0047c19be1f5bmr484426jab.0.1711458824388; Tue, 26 Mar
 2024 06:13:44 -0700 (PDT)
Date: Tue, 26 Mar 2024 06:13:44 -0700
In-Reply-To: <000000000000c676ac061478ebeb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004696ac0614900f54@google.com>
Subject: Re: [syzbot] [kernel?] inconsistent lock state in sock_map_delete_elem
From: syzbot <syzbot+27b586a74c69839e9bba@syzkaller.appspotmail.com>
To: frederic@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1297023a180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aef2a55903e5791c
dashboard link: https://syzkaller.appspot.com/bug?extid=27b586a74c69839e9bba
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13534231180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12201aa5180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/089e25869df5/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/423b1787914f/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4c043e30c07d/bzImage-fe46a7dd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+27b586a74c69839e9bba@syzkaller.appspotmail.com

================================
WARNING: inconsistent lock state
6.8.0-syzkaller-08951-gfe46a7dd189e #0 Not tainted
--------------------------------
inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
syz-executor298/5057 [HC0[0]:SC0[0]:HE0:SE1] takes:
ffff8880b943e698 (&rq->__lock){?.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:559
{IN-HARDIRQ-W} state was registered at:
  lock_acquire kernel/locking/lockdep.c:5754 [inline]
  lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
  _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
  raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:559
  raw_spin_rq_lock kernel/sched/sched.h:1385 [inline]
  rq_lock kernel/sched/sched.h:1699 [inline]
  scheduler_tick+0xa2/0x650 kernel/sched/core.c:5679
  update_process_times+0x199/0x220 kernel/time/timer.c:2481
  tick_periodic+0x7e/0x230 kernel/time/tick-common.c:100
  tick_handle_periodic+0x45/0x120 kernel/time/tick-common.c:112
  timer_interrupt+0x4e/0x80 arch/x86/kernel/time.c:57
  __handle_irq_event_percpu+0x22c/0x750 kernel/irq/handle.c:158
  handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
  handle_irq_event+0xab/0x1e0 kernel/irq/handle.c:210
  handle_level_irq+0x25d/0x6f0 kernel/irq/chip.c:648
  generic_handle_irq_desc include/linux/irqdesc.h:161 [inline]
  handle_irq arch/x86/kernel/irq.c:238 [inline]
  __common_interrupt+0xe1/0x250 arch/x86/kernel/irq.c:257
  common_interrupt+0xab/0xd0 arch/x86/kernel/irq.c:247
  asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
  __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
  _raw_spin_unlock_irqrestore+0x31/0x80 kernel/locking/spinlock.c:194
  __setup_irq+0x1069/0x1e80 kernel/irq/manage.c:1818
  request_threaded_irq+0x2b4/0x3e0 kernel/irq/manage.c:2202
  request_irq include/linux/interrupt.h:168 [inline]
  setup_default_timer_irq arch/x86/kernel/time.c:70 [inline]
  hpet_time_init+0x5b/0x90 arch/x86/kernel/time.c:82
  x86_late_time_init+0x51/0xc0 arch/x86/kernel/time.c:94
  start_kernel+0x317/0x490 init/main.c:1039
  x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:509
  x86_64_start_kernel+0xb2/0xc0 arch/x86/kernel/head64.c:490
  common_startup_64+0x13e/0x148
irq event stamp: 2112
hardirqs last  enabled at (2109): [<ffffffff8ad251cb>] irqentry_exit+0x3b/0x90 kernel/entry/common.c:351
hardirqs last disabled at (2110): [<ffffffff8ad48b14>] __schedule+0x2644/0x5c70 kernel/sched/core.c:6634
softirqs last  enabled at (2112): [<ffffffff88cb3a2d>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
softirqs last  enabled at (2112): [<ffffffff88cb3a2d>] __sock_map_delete net/core/sock_map.c:424 [inline]
softirqs last  enabled at (2112): [<ffffffff88cb3a2d>] sock_map_delete_elem+0xfd/0x150 net/core/sock_map.c:446
softirqs last disabled at (2111): [<ffffffff88cb39f8>] spin_lock_bh include/linux/spinlock.h:356 [inline]
softirqs last disabled at (2111): [<ffffffff88cb39f8>] __sock_map_delete net/core/sock_map.c:414 [inline]
softirqs last disabled at (2111): [<ffffffff88cb39f8>] sock_map_delete_elem+0xc8/0x150 net/core/sock_map.c:446

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&rq->__lock
);
  <Interrupt>
    lock(&rq->__lock
);

 *** DEADLOCK ***

6 locks held by syz-executor298/5057:
 #0: ffffffff8d8265a8
 (tracepoints_mutex
){+.+.}-{3:3}
, at: tracepoint_probe_register_prio_may_exist+0x9c/0x110 kernel/tracepoint.c:478
 #1: 
ffffffff8d653cb0
 (cpu_hotplug_lock
){++++}-{0:0}
, at: static_key_enable+0x12/0x20 kernel/jump_label.c:217
 #2: ffffffff8d8bbc08
 (jump_label_mutex
){+.+.}-{3:3}
, at: jump_label_lock kernel/jump_label.c:27 [inline]
, at: static_key_enable_cpuslocked+0xb5/0x270 kernel/jump_label.c:202
 #3: ffffffff8d671328
 (text_mutex
){+.+.}-{3:3}
, at: arch_jump_label_transform_apply+0x17/0x30 arch/x86/kernel/jump_label.c:145
 #4: ffff8880b943e698
 (&rq->__lock
){?.-.}-{2:2}
, at: raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:559
 #5: ffffffff8d7b08e0
 (rcu_read_lock
){....}-{1:2}
, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
, at: __bpf_trace_run kernel/trace/bpf_trace.c:2380 [inline]
, at: bpf_trace_run4+0x107/0x460 kernel/trace/bpf_trace.c:2422

stack backtrace:
CPU: 0 PID: 5057 Comm: syz-executor298 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 print_usage_bug kernel/locking/lockdep.c:3971 [inline]
 valid_state kernel/locking/lockdep.c:4013 [inline]
 mark_lock_irq kernel/locking/lockdep.c:4216 [inline]
 mark_lock+0x923/0xc60 kernel/locking/lockdep.c:4678
 mark_held_locks+0x9f/0xe0 kernel/locking/lockdep.c:4274
 __trace_hardirqs_on_caller kernel/locking/lockdep.c:4292 [inline]
 lockdep_hardirqs_on_prepare+0x137/0x420 kernel/locking/lockdep.c:4359
 trace_hardirqs_on+0x36/0x40 kernel/trace/trace_preemptirq.c:61
 __local_bh_enable_ip+0xa4/0x120 kernel/softirq.c:387
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 __sock_map_delete net/core/sock_map.c:424 [inline]
 sock_map_delete_elem+0xfd/0x150 net/core/sock_map.c:446


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

