Return-Path: <linux-kernel+bounces-134181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B95589AEB7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 07:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 081041C223A4
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 05:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C411879;
	Sun,  7 Apr 2024 05:48:27 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720041C0DFA
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 05:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712468907; cv=none; b=WVyH/JqDJZu7MofvwZUc2QSnfZV6p+v1mXUWnVd1g1TX0npok64cACaI3l+depOfZnUv5T24EbRNQgucVl5BxNb6INv8DgyRHto2ouyYy46/22i6Cw7QZZMGFUmVTCdTMFk/lVENs0SdV5E6JP+a7WLAHHkmhr8pP87c+mM2bC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712468907; c=relaxed/simple;
	bh=j4iqnCSobKQPOhFvtNj5WmgJwBCNQrzx/T4ftjr9Q/E=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bPeymxnzNQsJMO+0v5tB8R3WGKB5bG3IkQPLoWdyXq6jhlJ7eo03z9GJmatTe2OM3/LD3ZcGEzVOStwh6nyrkAS2L15o/UlyxehWIlOn5sgyHCLaa23CSJUyc/8F/J6fJXTfKdEbUQGEruFQ+suglUSoRoDB/HIW18jwjOyYpMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7d5d9390350so59979339f.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2024 22:48:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712468904; x=1713073704;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jYzA2VDcD6xx2hmXVDFRAx0aOYEWn8KkmSRH8YeXVZE=;
        b=kBRjcfQU3GLuPoIkrvj9tHiwfiQFughWwEvT8SVCjGe4Lot6/K7WIx57P/P7vH4GnX
         kDONZrkYpqCjC2phVZ9/KZhSmBE5qbl/e0iQprVyw7Xvdrf3LrVgj+RQKWxBkaTD12Xm
         rXylD8mQ9oN34DvMzldEoAbN4WOun2q69mglikec7wGztG/QF2asEz27R4LQ/HQ5dXOQ
         JKrUl1vDKgxOpYhPxRQaTLUxSUYxhlNfVr2v4g3PqXBK2jeZellcsFpDSi5hccvnjOfc
         TJxOtJMGyNtY5k965u2HHB293OBnbRzt7nsxB/2uu4UiQfZW4WqEVMh4nomEhZqnS/ZG
         6C1g==
X-Forwarded-Encrypted: i=1; AJvYcCXUXx5RuvvMbxgYqNgzmgw7udAWdqRE9o5ZFQOGa1apXCBaIrY5jFcREiUvMuMmhoHcC3X08jj9WqnDT7f5SyRbdM1hk7Fw9M4P/AJm
X-Gm-Message-State: AOJu0YwvscVqbKNiWyOeq/t+rkJPA5gzFrTS0G6EdNZB6B8tAfh28zQX
	ZTH2jNP8xSSGAp5oCDwK7GT0n+dCVzo0mImK245TdYDVtSNxCBcGE8q7yZ9LDF+HbVdgvZd5gtZ
	s54Amq6QVlYoHcowZeTYb4Yhna+7dijWudPjN/4rl4gwW8c6ZaVG8zaE=
X-Google-Smtp-Source: AGHT+IHPPfPwemGccAaMxGi1+n3Z0Pplb/Qyjgm7uQjo00Z56InCVDcmkvqOK4RdWgY9vDBx1OEO+be1cQyOzUBoNbY83MajtPAm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:892a:b0:482:8e81:f125 with SMTP id
 jc42-20020a056638892a00b004828e81f125mr12542jab.2.1712468904557; Sat, 06 Apr
 2024 22:48:24 -0700 (PDT)
Date: Sat, 06 Apr 2024 22:48:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bed0ca06157b3c5f@google.com>
Subject: [syzbot] [kernel?] inconsistent lock state in __do_softirq
From: syzbot <syzbot+b55883d68766eadcee77@syzkaller.appspotmail.com>
To: anna-maria@linutronix.de, frederic@kernel.org, 
	linux-kernel@vger.kernel.org, mingo@kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=170c9f0d180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1a07d5da4eb21586
dashboard link: https://syzkaller.appspot.com/bug?extid=b55883d68766eadcee77
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b42ab0fd4947/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b8a6e7231930/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4fbf3e4ce6f8/bzImage-fe46a7dd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b55883d68766eadcee77@syzkaller.appspotmail.com

================================
WARNING: inconsistent lock state
6.8.0-syzkaller-08951-gfe46a7dd189e #0 Not tainted
--------------------------------
inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
kworker/1:1/44 [HC0[0]:SC1[1]:HE0:SE0] takes:
ffff8880b953e6d8 (&rq->__lock){?.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:559
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
irq event stamp: 976815
hardirqs last  enabled at (976811): [<ffffffff8ad33eab>] irqentry_exit+0x3b/0x90 kernel/entry/common.c:351
hardirqs last disabled at (976812): [<ffffffff8ad577f4>] __schedule+0x2644/0x5c70 kernel/sched/core.c:6634
softirqs last  enabled at (976814): [<ffffffff88cc194d>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
softirqs last  enabled at (976814): [<ffffffff88cc194d>] __sock_map_delete net/core/sock_map.c:424 [inline]
softirqs last  enabled at (976814): [<ffffffff88cc194d>] sock_map_delete_elem+0xfd/0x150 net/core/sock_map.c:446
softirqs last disabled at (976815): [<ffffffff8152e202>] do_softirq kernel/softirq.c:455 [inline]
softirqs last disabled at (976815): [<ffffffff8152e202>] do_softirq+0xb2/0xf0 kernel/softirq.c:442

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

5 locks held by kworker/1:1/44:
 #0: ffff888015074948
 ((wq_completion)events
){+.+.}-{0:0}
, at: process_one_work+0x1296/0x1a60 kernel/workqueue.c:3229
 #1: ffffc90000b47d80
 ((work_completion)(&(&krcp->krw_arr[i].rcu_work)->work)
){+.+.}-{0:0}
, at: process_one_work+0x906/0x1a60 kernel/workqueue.c:3230
 #2: ffffffff8d7b48c0
 (rcu_callback
){....}-{0:0}
, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
, at: kvfree_rcu_bulk+0x143/0x550 kernel/rcu/tree.c:3027
 #3: ffff8880b953e6d8
 (&rq->__lock
){?.-.}-{2:2}
, at: raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:559
 #4: ffffffff8d7b49e0
 (rcu_read_lock
){....}-{1:2}
, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
, at: __bpf_trace_run kernel/trace/bpf_trace.c:2380 [inline]
, at: bpf_trace_run4+0x107/0x460 kernel/trace/bpf_trace.c:2422

stack backtrace:
CPU: 1 PID: 44 Comm: kworker/1:1 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue: events kfree_rcu_work

Call Trace:
 <IRQ>
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
 __do_softirq+0x1d6/0x8de kernel/softirq.c:538
 do_softirq kernel/softirq.c:455 [inline]
 do_softirq+0xb2/0xf0 kernel/softirq.c:442
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x100/0x120 kernel/softirq.c:382
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 __sock_map_delete net/core/sock_map.c:424 [inline]
 sock_map_delete_elem+0xfd/0x150 net/core/sock_map.c:446
 bpf_prog_2c29ac5cdc6b1842+0x42/0x4a
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run4+0x179/0x460 kernel/trace/bpf_trace.c:2422


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

