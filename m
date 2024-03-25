Return-Path: <linux-kernel+bounces-116757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A1988A365
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A46001C3A013
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285C31591FB;
	Mon, 25 Mar 2024 10:37:41 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E111591FD
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 09:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711359446; cv=none; b=CFnyjYQ+bRo1IgeKxaw9k9nNIhKbUsH9JLxmoqYArZV2AMsbMUa+2F6AQCqsWXmSDG2AWzXSnEHae0RgSaXg6okrO6U+ni95Rgg9u91fUjr2mKQkhoU2pmua/T55gjYizvDe9ImXVfYNLvNJqsWcbKsH1bBPKWhV8hTor8k/lNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711359446; c=relaxed/simple;
	bh=+TXcX5uFocg2+vJZwvwqhlBizZkF2m8w9WaebBbIrl0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=skfUCbsW4iujEFW9a9TIswrEj1nAlF8s7huP/cqSWlR5rMeln9KLuT+z+yAJ4nL7tVMViUY6wRheCsq/WVf7cjK4AELSDTXpm0Cj5h2vYqJrubVrsrc5CUB4hXz4y1cFbSrUzw1FzayBGxSD468hj0NsU8yhuP68oRnv1vrFMGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36896e99c4bso2605965ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 02:37:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711359444; x=1711964244;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zIreNWfLXpRyO5KPGptWahploMWL6kRGRjYwZPSTkpY=;
        b=Net7uKmCA/+taQPBOEl+1Wqmd41qTePfrAw8UYvnmKJkaz/xQtvJfSoHGq6hybykW4
         WFMiorZ0vsm0FEFZkjYp7VOqNa8MY24fDcNJmd8YV20DAG06ufi9IlKR9G64fPyej8zt
         y7qKHeXXJTdwWnIxvL+A0pEPeLwFy4ACN9tw+GzaiVW253t/i5A/kYDWzJ51gThNxL16
         1qqJQIwNwhse8huK+XEn8+fGNkswErN+/84s8QDA9AtuqxqeoPRri26xx65nJng/KLKY
         u4cQrB9Cr4zWVeZs5okcLrWVG3jPhh8pyITg7fA37k/xpRWC2wF1PyjBoKJhc5wQTIKf
         hr5g==
X-Forwarded-Encrypted: i=1; AJvYcCUaNgofO0/uCO/XfLQjhvKrbE7ttNH89pVpWSO+d2MVQ0/H90/OfuQFKRPz8oJiyaNVqxKVNYWUG+n9PBQJ/sj1BWhfncfroo3ShGzU
X-Gm-Message-State: AOJu0YwJ32ZMdN5qZL8VgBsw2B3n0j4RvJNXh7SgZzkbjSjFU1SXUUpI
	i6ynNcq643c0SBBEUpZXHATZm8AbYgd2+La6l91W8h4UHKez6zg/f9OEr5uqGz/55+4OkpYCdxX
	Q0G6F3wrWUGRh0fR5T3xwQiGqGoGLJI0MhrLcbwOxeqdzoLWxfFXYc0c=
X-Google-Smtp-Source: AGHT+IExHlbWAnP196as8siCtFvK2ezMeb3jj6q4jQfyujvixvFEhqrfktNEs2MsGStTpkZrktDHRkTU5UNl7WcmdPxDsMFgxIF7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd8d:0:b0:365:3e12:3eb1 with SMTP id
 r13-20020a92cd8d000000b003653e123eb1mr305200ilb.1.1711359444543; Mon, 25 Mar
 2024 02:37:24 -0700 (PDT)
Date: Mon, 25 Mar 2024 02:37:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c676ac061478ebeb@google.com>
Subject: [syzbot] [kernel?] inconsistent lock state in sock_map_delete_elem
From: syzbot <syzbot+27b586a74c69839e9bba@syzkaller.appspotmail.com>
To: frederic@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16f03185180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aef2a55903e5791c
dashboard link: https://syzkaller.appspot.com/bug?extid=27b586a74c69839e9bba
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

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
kworker/u8:8/2467 [HC0[0]:SC0[0]:HE0:SE1] takes:
ffff8880b943e698 (
&rq->__lock){?.-.}-{2:2}
, at: raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:559
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
  handle_edge_irq+0x263/0xd10 kernel/irq/chip.c:831
  generic_handle_irq_desc include/linux/irqdesc.h:161 [inline]
  handle_irq arch/x86/kernel/irq.c:238 [inline]
  __common_interrupt+0xe1/0x250 arch/x86/kernel/irq.c:257
  common_interrupt+0xab/0xd0 arch/x86/kernel/irq.c:247
  asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
  console_flush_all+0xa19/0xd70 kernel/printk/printk.c:2979
  console_unlock+0xae/0x290 kernel/printk/printk.c:3042
  vprintk_emit kernel/printk/printk.c:2342 [inline]
  vprintk_emit+0x11a/0x5a0 kernel/printk/printk.c:2297
  vprintk+0x7f/0xa0 kernel/printk/printk_safe.c:45
  _printk+0xc8/0x100 kernel/printk/printk.c:2367
  __clocksource_register_scale+0xc7/0x590 kernel/time/clocksource.c:1223
  clocksource_register_khz include/linux/clocksource.h:251 [inline]
  tsc_init+0x4e0/0xa20 arch/x86/kernel/tsc.c:1619
  x86_late_time_init+0x7a/0xc0 arch/x86/kernel/time.c:101
  start_kernel+0x317/0x490 init/main.c:1039
  x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:509
  x86_64_start_kernel+0xb2/0xc0 arch/x86/kernel/head64.c:490
  common_startup_64+0x13e/0x148
irq event stamp: 6864716
hardirqs last  enabled at (6864713): [<ffffffff8ad60263>] __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:159 [inline]
hardirqs last  enabled at (6864713): [<ffffffff8ad60263>] _raw_spin_unlock_irq+0x23/0x50 kernel/locking/spinlock.c:202
hardirqs last disabled at (6864714): [<ffffffff8ad48b14>] __schedule+0x2644/0x5c70 kernel/sched/core.c:6634
softirqs last  enabled at (6864716): [<ffffffff88cb3a2d>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
softirqs last  enabled at (6864716): [<ffffffff88cb3a2d>] __sock_map_delete net/core/sock_map.c:424 [inline]
softirqs last  enabled at (6864716): [<ffffffff88cb3a2d>] sock_map_delete_elem+0xfd/0x150 net/core/sock_map.c:446
softirqs last disabled at (6864715): [<ffffffff88cb39f8>] spin_lock_bh include/linux/spinlock.h:356 [inline]
softirqs last disabled at (6864715): [<ffffffff88cb39f8>] __sock_map_delete net/core/sock_map.c:414 [inline]
softirqs last disabled at (6864715): [<ffffffff88cb39f8>] sock_map_delete_elem+0xc8/0x150 net/core/sock_map.c:446

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(
&rq->__lock);
  <Interrupt>
    lock(&rq->__lock
);

 *** DEADLOCK ***

2 locks held by kworker/u8:8/2467:
 #0: ffff8880b943e698
 (&rq->__lock
){?.-.}-{2:2}
, at: raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:559
 #1: ffffffff8d7b08e0
 (rcu_read_lock
){....}-{1:2}
, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
, at: __bpf_trace_run kernel/trace/bpf_trace.c:2380 [inline]
, at: bpf_trace_run4+0x107/0x460 kernel/trace/bpf_trace.c:2422

stack backtrace:
CPU: 0 PID: 2467 Comm: kworker/u8:8 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Workqueue:  0x0
 (bat_events)
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
 ___bpf_prog_run+0x3e51/0xae80 kernel/bpf/core.c:1997
 __bpf_prog_run32+0xc1/0x100 kernel/bpf/core.c:2236
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run4+0x176/0x460 kernel/trace/bpf_trace.c:2422


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

