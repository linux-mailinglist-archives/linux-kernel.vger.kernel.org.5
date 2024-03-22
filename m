Return-Path: <linux-kernel+bounces-110930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC2B8865D3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 05:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB2EF282B2D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 04:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671DEB67D;
	Fri, 22 Mar 2024 04:42:23 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CC04416
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 04:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711082541; cv=none; b=HesJ4tLB0vO3OJ3fxcurHHnNfpCMg0w/TKlLjNpygQSsZpBKOgoxi6/GmS1TWzjXmdfaQ5t1wL1pHSMLy2d5Gk237KVTLQ9fcRr7Tp5UO9qjefuExdU/pHwJX77lWRv35+4OoC+nPTPXnGOVtN7FEJRgbnuAuIRMDwJwz0J3AmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711082541; c=relaxed/simple;
	bh=pqI8CHWC1r4cwN7+vWQHg8V+GMx9K+0qwO5fnfq+6gk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pxfNtEK+wrK1adbOMsPpWXx3DLfD9117yhM8X6Dg6FVaNjUVDT8OM40XC0UHN4rY/YqZ1vxwSReuh/h6KRvUTf9W7+W/osVKrwj4q7stlsNUAuf+U+IbS7qsPmdScHFw5oYrkoaCBkZWtiO73Yq143CXdm08XWBMQxxl3WIu/ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7cbef888187so149881239f.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 21:42:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711082539; x=1711687339;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=siydCImL2vRHcJltwvGBJaKzacjVJ/YjObjkT8pfj1Y=;
        b=HVTqWNzYHHc6IUEIKTFJegGmu24oYbpA3lgaYPv1AglEm1AhSzDMHcrrvFlgnxviCg
         MnlCT2ahYIf+cY9pC9PZtodImmP65Fa27+1M9A1IhwzKlXmwFq3CtU7y4hz59zhiV8NC
         sXlkF6shJbl/kggHzKdLPApvrsokfkzjOGoRX7lvSP6GfvQgKR5rAbsAN6XwndYh1AgE
         ZxsZTjHgfL4KAV0kF69uIi8g4DVRc1NgTSa/zcNALq7H1byvxeN2mLYisn0IdT53D3KR
         4dcV5FnKbT1C7K9T97ByuNwFuZ70+6WYDQHQp3QuIRMxdXwvP19gL/ffUr8y0PPFL4Z1
         784Q==
X-Forwarded-Encrypted: i=1; AJvYcCV975DLd02P9caXUhmBlsREk2UGLCPor0vE3yOSQ2vGtbHUYD3z4+Kk3DNP3pNlltefEQrH7Nzqd2ANVfJGFpir7n5bnMSsqQjOxonc
X-Gm-Message-State: AOJu0YxOEdMaeo2ZapNRp0WFQ0rR7qwNsn5ie6O1+a81kRwQxsIsJPlw
	igVHzgyaWA8D/pZUJ+rUtYVSXpWwW54cDoCf8+n2P0aEx+kmH+av48ew+tPQSy8XKIrWC/4Jd5g
	8oBEnP5CSUfm4YChLalnZuZfq3whH8NRIDR+qDG2gzDY738gCRzc76q4=
X-Google-Smtp-Source: AGHT+IEu5yo7Qr6EfIb8JY4ChK17LMaTXR1EexcKz2qfjnj2T8oBKmWZcAGNoJ6H02IDp283zAXkuejoaCjjmFAFVLK1cj6oZnNO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:52f:b0:365:fe09:6450 with SMTP id
 h15-20020a056e02052f00b00365fe096450mr53286ils.4.1711082538801; Thu, 21 Mar
 2024 21:42:18 -0700 (PDT)
Date: Thu, 21 Mar 2024 21:42:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e82df406143872eb@google.com>
Subject: [syzbot] [bpf?] [net?] possible deadlock in tty_port_tty_get (2)
From: syzbot <syzbot+afcf1c450aca9ec1b5f1@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	jakub@cloudflare.com, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=158dd231180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1a07d5da4eb21586
dashboard link: https://syzkaller.appspot.com/bug?extid=afcf1c450aca9ec1b5f1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b42ab0fd4947/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b8a6e7231930/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4fbf3e4ce6f8/bzImage-fe46a7dd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+afcf1c450aca9ec1b5f1@syzkaller.appspotmail.com

=====================================================
WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
6.8.0-syzkaller-08951-gfe46a7dd189e #0 Not tainted
-----------------------------------------------------
kworker/u8:6/1257 [HC0[0]:SC0[2]:HE0:SE0] is trying to acquire:
ffff8880385a9020 (&htab->buckets[i].lock){+...}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
ffff8880385a9020 (&htab->buckets[i].lock){+...}-{2:2}, at: sock_hash_delete_elem+0xcb/0x260 net/core/sock_map.c:939

and this task is already holding:
ffff888037561958 (&port->lock){-.-.}-{2:2}, at: tty_insert_flip_string_and_push_buffer+0x7f/0x1f0 drivers/tty/tty_buffer.c:557
which would create a new lock dependency:
 (&port->lock){-.-.}-{2:2} -> (&htab->buckets[i].lock){+...}-{2:2}

but this new dependency connects a HARDIRQ-irq-safe lock:
 (&port->lock){-.-.}-{2:2}

.. which became HARDIRQ-irq-safe at:
  lock_acquire kernel/locking/lockdep.c:5754 [inline]
  lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
  _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
  tty_port_tty_get+0x21/0x100 drivers/tty/tty_port.c:327
  tty_port_default_wakeup+0x15/0x40 drivers/tty/tty_port.c:66
  serial8250_tx_chars+0x55a/0x8b0 drivers/tty/serial/8250/8250_port.c:1835
  serial8250_handle_irq+0x5d3/0x780 drivers/tty/serial/8250/8250_port.c:1942
  serial8250_default_handle_irq+0x9a/0x210 drivers/tty/serial/8250/8250_port.c:1962
  serial8250_interrupt+0x106/0x210 drivers/tty/serial/8250/8250_core.c:127
  __handle_irq_event_percpu+0x22c/0x750 kernel/irq/handle.c:158
  handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
  handle_irq_event+0xab/0x1e0 kernel/irq/handle.c:210
  handle_edge_irq+0x263/0xd10 kernel/irq/chip.c:831
  generic_handle_irq_desc include/linux/irqdesc.h:161 [inline]
  handle_irq arch/x86/kernel/irq.c:238 [inline]
  __common_interrupt+0xe1/0x250 arch/x86/kernel/irq.c:257
  common_interrupt+0xab/0xd0 arch/x86/kernel/irq.c:247
  asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
  __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
  _raw_spin_unlock_irqrestore+0x31/0x80 kernel/locking/spinlock.c:194
  spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
  uart_port_unlock_irqrestore include/linux/serial_core.h:667 [inline]
  serial_port_runtime_resume+0x2b7/0x340 drivers/tty/serial/serial_port.c:41
  __rpm_callback+0xc8/0x4c0 drivers/base/power/runtime.c:394
  rpm_callback+0x1da/0x220 drivers/base/power/runtime.c:448
  rpm_resume+0xcf9/0x12f0 drivers/base/power/runtime.c:914
  pm_runtime_work+0x10c/0x150 drivers/base/power/runtime.c:979
  process_one_work+0x9ac/0x1a60 kernel/workqueue.c:3254
  process_scheduled_works kernel/workqueue.c:3335 [inline]
  worker_thread+0x6c8/0xf70 kernel/workqueue.c:3416
  kthread+0x2c4/0x3a0 kernel/kthread.c:388
  ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243

to a HARDIRQ-irq-unsafe lock:
 (&htab->buckets[i].lock){+...}-{2:2}

.. which became HARDIRQ-irq-unsafe at:
..
  lock_acquire kernel/locking/lockdep.c:5754 [inline]
  lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
  __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
  _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:178
  spin_lock_bh include/linux/spinlock.h:356 [inline]
  sock_hash_delete_elem+0xcb/0x260 net/core/sock_map.c:939
  bpf_prog_2c29ac5cdc6b1842+0x42/0x4a
  bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
  __bpf_prog_run include/linux/filter.h:657 [inline]
  bpf_prog_run include/linux/filter.h:664 [inline]
  __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
  bpf_trace_run4+0x179/0x460 kernel/trace/bpf_trace.c:2422
  trace_mm_page_alloc include/trace/events/kmem.h:177 [inline]
  __alloc_pages+0x3ad/0x2410 mm/page_alloc.c:4591
  alloc_pages_mpol+0x258/0x600 mm/mempolicy.c:2133
  vma_alloc_folio+0xad/0x220 mm/mempolicy.c:2172
  alloc_anon_folio mm/memory.c:4234 [inline]
  do_anonymous_page mm/memory.c:4292 [inline]
  do_pte_missing mm/memory.c:3743 [inline]
  handle_pte_fault mm/memory.c:5164 [inline]
  __handle_mm_fault+0x25ca/0x4920 mm/memory.c:5305
  handle_mm_fault+0x476/0xa00 mm/memory.c:5470
  do_user_addr_fault+0x426/0x1080 arch/x86/mm/fault.c:1362
  handle_page_fault arch/x86/mm/fault.c:1505 [inline]
  exc_page_fault+0x5c/0xc0 arch/x86/mm/fault.c:1563
  asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623

other info that might help us debug this:

 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&htab->buckets[i].lock);
                               local_irq_disable();
                               lock(&port->lock);
                               lock(&htab->buckets[i].lock);
  <Interrupt>
    lock(&port->lock);

 *** DEADLOCK ***

8 locks held by kworker/u8:6/1257:
 #0: ffff888015079148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x1296/0x1a60 kernel/workqueue.c:3229
 #1: ffffc900049bfd80 ((work_completion)(&buf->work)){+.+.}-{0:0}, at: process_one_work+0x906/0x1a60 kernel/workqueue.c:3230
 #2: ffff88807e53f8b8 (&port->buf.lock/1){+.+.}-{3:3}, at: flush_to_ldisc+0x31/0x780 drivers/tty/tty_buffer.c:466
 #3: ffff88807994e0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref+0x1c/0x80 drivers/tty/tty_ldisc.c:263
 #4: ffff88807994e2e8 (&o_tty->termios_rwsem/1){++++}-{3:3}, at: n_tty_receive_buf_common+0x85/0x1900 drivers/tty/n_tty.c:1692
 #5: ffffc9000421b380 (&ldata->output_lock){+.+.}-{3:3}, at: flush_echoes drivers/tty/n_tty.c:805 [inline]
 #5: ffffc9000421b380 (&ldata->output_lock){+.+.}-{3:3}, at: __receive_buf drivers/tty/n_tty.c:1632 [inline]
 #5: ffffc9000421b380 (&ldata->output_lock){+.+.}-{3:3}, at: n_tty_receive_buf_common+0x9f2/0x1900 drivers/tty/n_tty.c:1729
 #6: ffff888037561958 (&port->lock){-.-.}-{2:2}, at: tty_insert_flip_string_and_push_buffer+0x7f/0x1f0 drivers/tty/tty_buffer.c:557
 #7: ffffffff8d7b49e0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #7: ffffffff8d7b49e0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #7: ffffffff8d7b49e0 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2380 [inline]
 #7: ffffffff8d7b49e0 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run4+0x107/0x460 kernel/trace/bpf_trace.c:2422

the dependencies between HARDIRQ-irq-safe lock and the holding lock:
-> (&port->lock){-.-.}-{2:2} {
   IN-HARDIRQ-W at:
                    lock_acquire kernel/locking/lockdep.c:5754 [inline]
                    lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
                    __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                    _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
                    tty_port_tty_get+0x21/0x100 drivers/tty/tty_port.c:327
                    tty_port_default_wakeup+0x15/0x40 drivers/tty/tty_port.c:66
                    serial8250_tx_chars+0x55a/0x8b0 drivers/tty/serial/8250/8250_port.c:1835
                    serial8250_handle_irq+0x5d3/0x780 drivers/tty/serial/8250/8250_port.c:1942
                    serial8250_default_handle_irq+0x9a/0x210 drivers/tty/serial/8250/8250_port.c:1962
                    serial8250_interrupt+0x106/0x210 drivers/tty/serial/8250/8250_core.c:127
                    __handle_irq_event_percpu+0x22c/0x750 kernel/irq/handle.c:158
                    handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
                    handle_irq_event+0xab/0x1e0 kernel/irq/handle.c:210
                    handle_edge_irq+0x263/0xd10 kernel/irq/chip.c:831
                    generic_handle_irq_desc include/linux/irqdesc.h:161 [inline]
                    handle_irq arch/x86/kernel/irq.c:238 [inline]
                    __common_interrupt+0xe1/0x250 arch/x86/kernel/irq.c:257
                    common_interrupt+0xab/0xd0 arch/x86/kernel/irq.c:247
                    asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
                    __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
                    _raw_spin_unlock_irqrestore+0x31/0x80 kernel/locking/spinlock.c:194
                    spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
                    uart_port_unlock_irqrestore include/linux/serial_core.h:667 [inline]
                    serial_port_runtime_resume+0x2b7/0x340 drivers/tty/serial/serial_port.c:41
                    __rpm_callback+0xc8/0x4c0 drivers/base/power/runtime.c:394
                    rpm_callback+0x1da/0x220 drivers/base/power/runtime.c:448
                    rpm_resume+0xcf9/0x12f0 drivers/base/power/runtime.c:914
                    pm_runtime_work+0x10c/0x150 drivers/base/power/runtime.c:979
                    process_one_work+0x9ac/0x1a60 kernel/workqueue.c:3254
                    process_scheduled_works kernel/workqueue.c:3335 [inline]
                    worker_thread+0x6c8/0xf70 kernel/workqueue.c:3416
                    kthread+0x2c4/0x3a0 kernel/kthread.c:388
                    ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
                    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
   IN-SOFTIRQ-W at:
                    lock_acquire kernel/locking/lockdep.c:5754 [inline]
                    lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
                    __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
                    _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
                    tty_port_tty_get+0x21/0x100 drivers/tty/tty_port.c:327
                    tty_port_default_wakeup+0x15/0x40 drivers/tty/tty_port.c:66
                    serial8250_tx_chars+0x55a/0x8b0 drivers/tty/serial/8250/8250_port.c:1835
                    serial8250_handle_irq+0x5d3/0x780 drivers/tty/serial/8250/8250_port.c:1942
                    serial8250_default_handle_irq+0x9a/0x210 drivers/tty/serial/8250/8250_port.c:1962
                    serial8250_interrupt+0x106/0x210 drivers/tty/serial/8250/8250_core.c:127
                    __handle_irq_event_percpu+0x22c/0x750 kernel/irq/handle.c:158
                    handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
                    handle_irq_event+0xab/0x1e0 kernel/irq/handle.c:210
                    handle_edge_irq+0x263/0xd10 kernel/irq/chip.c:831
                    generic_handle_irq_desc include/linux/irqdesc.h:161 [inline]
                    handle_irq arch/x86/kernel/irq.c:238 [inline]
                    __common_interrupt+0xe1/0x250 arch/x86/kernel/irq.c:257
                    common_interrupt+0x52/0xd0 arch/x86/kernel/irq.c:247
                    asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
                    __sanitizer_cov_trace_const_cmp4+0x8/0x20 kernel/kcov.c:304
                    unwind_next_frame+0x46/0x23a0 arch/x86/kernel/unwind_orc.c:475
                    arch_stack_walk+0x100/0x170 arch/x86/kernel/stacktrace.c:25
                    stack_trace_save+0x95/0xd0 kernel/stacktrace.c:122
                    kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
                    kasan_save_track+0x14/0x30 mm/kasan/common.c:68
                    kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:579
                    poison_slab_object mm/kasan/common.c:240 [inline]
                    __kasan_slab_free+0x11d/0x1a0 mm/kasan/common.c:256
                    kasan_slab_free include/linux/kasan.h:184 [inline]
                    slab_free_hook mm/slub.c:2106 [inline]
                    slab_free mm/slub.c:4280 [inline]
                    kmem_cache_free+0x12e/0x360 mm/slub.c:4344
                    rcu_do_batch kernel/rcu/tree.c:2196 [inline]
                    rcu_core+0x82b/0x16b0 kernel/rcu/tree.c:2471
                    __do_softirq+0x21b/0x8de kernel/softirq.c:554
                    invoke_softirq kernel/softirq.c:428 [inline]
                    __irq_exit_rcu kernel/softirq.c:633 [inline]
                    irq_exit_rcu+0xb9/0x120 kernel/softirq.c:645
                    instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
                    sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1043
                    asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
                    native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
                    arch_safe_halt arch/x86/include/asm/irqflags.h:86 [inline]
                    acpi_safe_halt+0x1a/0x20 drivers/acpi/processor_idle.c:112
                    acpi_idle_enter+0xc5/0x160 drivers/acpi/processor_idle.c:707
                    cpuidle_enter_state+0x88/0x510 drivers/cpuidle/cpuidle.c:267
                    cpuidle_enter+0x4e/0xa0 drivers/cpuidle/cpuidle.c:388
                    cpuidle_idle_call kernel/sched/idle.c:236 [inline]
                    do_idle+0x313/0x3f0 kernel/sched/idle.c:332
                    cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:430
                    start_secondary+0x220/0x2b0 arch/x86/kernel/smpboot.c:313
                    common_startup_64+0x13e/0x148
   INITIAL USE at:
                   lock_acquire kernel/locking/lockdep.c:5754 [inline]
                   lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
                   __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline]
                   _raw_spin_lock_irq+0x36/0x50 kernel/locking/spinlock.c:170
                   spin_lock_irq include/linux/spinlock.h:376 [inline]
                   tty_port_open+0x2b/0x1f0 drivers/tty/tty_port.c:768
                   uart_open+0x41/0x60 drivers/tty/serial/serial_core.c:1982
                   tty_open+0x3ff/0x1020 drivers/tty/tty_io.c:2152
                   chrdev_open+0x270/0x6f0 fs/char_dev.c:414
                   do_dentry_open+0x8dd/0x18c0 fs/open.c:955
                   do_open fs/namei.c:3642 [inline]
                   path_openat+0x1dfb/0x2990 fs/namei.c:3799
                   do_filp_open+0x1dc/0x430 fs/namei.c:3826
                   file_open_name+0x2a4/0x450 fs/open.c:1351
                   filp_open+0x4b/0x80 fs/open.c:1371
                   console_on_rootfs+0x1d/0x80 init/main.c:1508
                   kernel_init_freeable+0x6f5/0xc40 init/main.c:1555
                   kernel_init+0x1c/0x2a0 init/main.c:1439
                   ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
                   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 }
 ... key      at: [<ffffffff9491ce60>] __key.1+0x0/0x40

the dependencies between the lock to be acquired
 and HARDIRQ-irq-unsafe lock:
-> (&htab->buckets[i].lock){+...}-{2:2} {
   HARDIRQ-ON-W at:
                    lock_acquire kernel/locking/lockdep.c:5754 [inline]
                    lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
                    __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
                    _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:178
                    spin_lock_bh include/linux/spinlock.h:356 [inline]
                    sock_hash_delete_elem+0xcb/0x260 net/core/sock_map.c:939
                    bpf_prog_2c29ac5cdc6b1842+0x42/0x4a
                    bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
                    __bpf_prog_run include/linux/filter.h:657 [inline]
                    bpf_prog_run include/linux/filter.h:664 [inline]
                    __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
                    bpf_trace_run4+0x179/0x460 kernel/trace/bpf_trace.c:2422
                    trace_mm_page_alloc include/trace/events/kmem.h:177 [inline]
                    __alloc_pages+0x3ad/0x2410 mm/page_alloc.c:4591
                    alloc_pages_mpol+0x258/0x600 mm/mempolicy.c:2133
                    vma_alloc_folio+0xad/0x220 mm/mempolicy.c:2172
                    alloc_anon_folio mm/memory.c:4234 [inline]
                    do_anonymous_page mm/memory.c:4292 [inline]
                    do_pte_missing mm/memory.c:3743 [inline]
                    handle_pte_fault mm/memory.c:5164 [inline]
                    __handle_mm_fault+0x25ca/0x4920 mm/memory.c:5305
                    handle_mm_fault+0x476/0xa00 mm/memory.c:5470
                    do_user_addr_fault+0x426/0x1080 arch/x86/mm/fault.c:1362
                    handle_page_fault arch/x86/mm/fault.c:1505 [inline]
                    exc_page_fault+0x5c/0xc0 arch/x86/mm/fault.c:1563
                    asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
   INITIAL USE at:
                   lock_acquire kernel/locking/lockdep.c:5754 [inline]
                   lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
                   __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
                   _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:178
                   spin_lock_bh include/linux/spinlock.h:356 [inline]
                   sock_hash_delete_elem+0xcb/0x260 net/core/sock_map.c:939
                   bpf_prog_2c29ac5cdc6b1842+0x42/0x4a
                   bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
                   __bpf_prog_run include/linux/filter.h:657 [inline]
                   bpf_prog_run include/linux/filter.h:664 [inline]
                   __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
                   bpf_trace_run4+0x179/0x460 kernel/trace/bpf_trace.c:2422
                   trace_mm_page_alloc include/trace/events/kmem.h:177 [inline]
                   __alloc_pages+0x3ad/0x2410 mm/page_alloc.c:4591
                   alloc_pages_mpol+0x258/0x600 mm/mempolicy.c:2133
                   vma_alloc_folio+0xad/0x220 mm/mempolicy.c:2172
                   alloc_anon_folio mm/memory.c:4234 [inline]
                   do_anonymous_page mm/memory.c:4292 [inline]
                   do_pte_missing mm/memory.c:3743 [inline]
                   handle_pte_fault mm/memory.c:5164 [inline]
                   __handle_mm_fault+0x25ca/0x4920 mm/memory.c:5305
                   handle_mm_fault+0x476/0xa00 mm/memory.c:5470
                   do_user_addr_fault+0x426/0x1080 arch/x86/mm/fault.c:1362
                   handle_page_fault arch/x86/mm/fault.c:1505 [inline]
                   exc_page_fault+0x5c/0xc0 arch/x86/mm/fault.c:1563
                   asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
 }
 ... key      at: [<ffffffff949d0480>] __key.0+0x0/0x40
 ... acquired at:
   lock_acquire kernel/locking/lockdep.c:5754 [inline]
   lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
   __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
   _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:178
   spin_lock_bh include/linux/spinlock.h:356 [inline]
   sock_hash_delete_elem+0xcb/0x260 net/core/sock_map.c:939
   bpf_prog_2c29ac5cdc6b1842+0x42/0x4a
   bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
   __bpf_prog_run include/linux/filter.h:657 [inline]
   bpf_prog_run include/linux/filter.h:664 [inline]
   __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
   bpf_trace_run4+0x179/0x460 kernel/trace/bpf_trace.c:2422
   trace_mm_page_alloc include/trace/events/kmem.h:177 [inline]
   __alloc_pages+0x3ad/0x2410 mm/page_alloc.c:4591
   alloc_pages_mpol+0x258/0x600 mm/mempolicy.c:2133
   stack_depot_save_flags+0x568/0x8f0 lib/stackdepot.c:676
   save_stack+0x16f/0x1f0 mm/page_owner.c:130
   __set_page_owner+0x1f/0x60 mm/page_owner.c:195
   set_page_owner include/linux/page_owner.h:31 [inline]
   post_alloc_hook+0x2d4/0x350 mm/page_alloc.c:1533
   prep_new_page mm/page_alloc.c:1540 [inline]
   get_page_from_freelist+0xa28/0x3780 mm/page_alloc.c:3311
   __alloc_pages+0x22b/0x2410 mm/page_alloc.c:4569
   alloc_pages_mpol+0x258/0x600 mm/mempolicy.c:2133
   stack_depot_save_flags+0x568/0x8f0 lib/stackdepot.c:676
   kasan_save_stack+0x42/0x60 mm/kasan/common.c:48
   kasan_save_track+0x14/0x30 mm/kasan/common.c:68
   poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
   __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:387
   kasan_kmalloc include/linux/kasan.h:211 [inline]
   __do_kmalloc_node mm/slub.c:3966 [inline]
   __kmalloc+0x1f9/0x440 mm/slub.c:3979
   kmalloc include/linux/slab.h:632 [inline]
   tty_buffer_alloc+0x297/0x3d0 drivers/tty/tty_buffer.c:179
   __tty_buffer_request_room+0x12e/0x2d0 drivers/tty/tty_buffer.c:272
   __tty_insert_flip_string_flags+0xd7/0x400 drivers/tty/tty_buffer.c:308
   tty_insert_flip_string_fixed_flag include/linux/tty_flip.h:35 [inline]
   tty_insert_flip_string include/linux/tty_flip.h:83 [inline]
   tty_insert_flip_string_and_push_buffer+0x9d/0x1f0 drivers/tty/tty_buffer.c:558
   pty_write+0xd2/0x100 drivers/tty/pty.c:118
   tty_put_char+0x132/0x160 drivers/tty/tty_io.c:3168
   n_tty_process_echo_ops drivers/tty/n_tty.c:663 [inline]
   __process_echoes+0x7fe/0xb40 drivers/tty/n_tty.c:709
   flush_echoes drivers/tty/n_tty.c:807 [inline]
   __receive_buf drivers/tty/n_tty.c:1632 [inline]
   n_tty_receive_buf_common+0xa39/0x1900 drivers/tty/n_tty.c:1729
   tty_ldisc_receive_buf+0xa5/0x190 drivers/tty/tty_buffer.c:386
   tty_port_default_receive_buf+0x70/0xb0 drivers/tty/tty_port.c:37
   receive_buf drivers/tty/tty_buffer.c:444 [inline]
   flush_to_ldisc+0x267/0x780 drivers/tty/tty_buffer.c:494
   process_one_work+0x9ac/0x1a60 kernel/workqueue.c:3254
   process_scheduled_works kernel/workqueue.c:3335 [inline]
   worker_thread+0x6c8/0xf70 kernel/workqueue.c:3416
   kthread+0x2c4/0x3a0 kernel/kthread.c:388
   ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243


stack backtrace:
CPU: 1 PID: 1257 Comm: kworker/u8:6 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Workqueue: events_unbound flush_to_ldisc
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 print_bad_irq_dependency kernel/locking/lockdep.c:2626 [inline]
 check_irq_usage+0xe3c/0x1490 kernel/locking/lockdep.c:2865
 check_prev_add kernel/locking/lockdep.c:3138 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain kernel/locking/lockdep.c:3869 [inline]
 __lock_acquire+0x248e/0x3b30 kernel/locking/lockdep.c:5137
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
 _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:178
 spin_lock_bh include/linux/spinlock.h:356 [inline]
 sock_hash_delete_elem+0xcb/0x260 net/core/sock_map.c:939
 bpf_prog_2c29ac5cdc6b1842+0x42/0x4a
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run4+0x179/0x460 kernel/trace/bpf_trace.c:2422
 trace_mm_page_alloc include/trace/events/kmem.h:177 [inline]
 __alloc_pages+0x3ad/0x2410 mm/page_alloc.c:4591
 alloc_pages_mpol+0x258/0x600 mm/mempolicy.c:2133
 stack_depot_save_flags+0x568/0x8f0 lib/stackdepot.c:676
 save_stack+0x16f/0x1f0 mm/page_owner.c:130
 __set_page_owner+0x1f/0x60 mm/page_owner.c:195
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2d4/0x350 mm/page_alloc.c:1533
 prep_new_page mm/page_alloc.c:1540 [inline]
 get_page_from_freelist+0xa28/0x3780 mm/page_alloc.c:3311
 __alloc_pages+0x22b/0x2410 mm/page_alloc.c:4569
 alloc_pages_mpol+0x258/0x600 mm/mempolicy.c:2133
 stack_depot_save_flags+0x568/0x8f0 lib/stackdepot.c:676
 kasan_save_stack+0x42/0x60 mm/kasan/common.c:48
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:3966 [inline]
 __kmalloc+0x1f9/0x440 mm/slub.c:3979
 kmalloc include/linux/slab.h:632 [inline]
 tty_buffer_alloc+0x297/0x3d0 drivers/tty/tty_buffer.c:179
 __tty_buffer_request_room+0x12e/0x2d0 drivers/tty/tty_buffer.c:272
 __tty_insert_flip_string_flags+0xd7/0x400 drivers/tty/tty_buffer.c:308
 tty_insert_flip_string_fixed_flag include/linux/tty_flip.h:35 [inline]
 tty_insert_flip_string include/linux/tty_flip.h:83 [inline]
 tty_insert_flip_string_and_push_buffer+0x9d/0x1f0 drivers/tty/tty_buffer.c:558
 pty_write+0xd2/0x100 drivers/tty/pty.c:118
 tty_put_char+0x132/0x160 drivers/tty/tty_io.c:3168
 n_tty_process_echo_ops drivers/tty/n_tty.c:663 [inline]
 __process_echoes+0x7fe/0xb40 drivers/tty/n_tty.c:709
 flush_echoes drivers/tty/n_tty.c:807 [inline]
 __receive_buf drivers/tty/n_tty.c:1632 [inline]
 n_tty_receive_buf_common+0xa39/0x1900 drivers/tty/n_tty.c:1729
 tty_ldisc_receive_buf+0xa5/0x190 drivers/tty/tty_buffer.c:386
 tty_port_default_receive_buf+0x70/0xb0 drivers/tty/tty_port.c:37
 receive_buf drivers/tty/tty_buffer.c:444 [inline]
 flush_to_ldisc+0x267/0x780 drivers/tty/tty_buffer.c:494
 process_one_work+0x9ac/0x1a60 kernel/workqueue.c:3254
 process_scheduled_works kernel/workqueue.c:3335 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3416
 kthread+0x2c4/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 </TASK>
------------[ cut here ]------------
raw_local_irq_restore() called with IRQs enabled
WARNING: CPU: 1 PID: 1257 at kernel/locking/irqflag-debug.c:10 warn_bogus_irq_restore+0x29/0x30 kernel/locking/irqflag-debug.c:10
Modules linked in:
CPU: 1 PID: 1257 Comm: kworker/u8:6 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Workqueue: events_unbound flush_to_ldisc
RIP: 0010:warn_bogus_irq_restore+0x29/0x30 kernel/locking/irqflag-debug.c:10
Code: 90 f3 0f 1e fa 90 80 3d be b2 b5 04 00 74 06 90 e9 3c f8 03 00 c6 05 af b2 b5 04 01 90 48 c7 c7 00 c3 0c 8b e8 98 c2 7d f6 90 <0f> 0b 90 90 eb df 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc900049bf8e8 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff888037561940 RCX: ffffffff8150f3e9
RDX: ffff888022f18000 RSI: ffffffff8150f3f6 RDI: 0000000000000001
RBP: 0000000000000293 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 1ffff92000937f22
R13: 0000000000000293 R14: ffff888037561940 R15: ffff88803a96f800
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055c6a9e1b178 CR3: 0000000039aa0000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
 _raw_spin_unlock_irqrestore+0x74/0x80 kernel/locking/spinlock.c:194
 spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
 tty_insert_flip_string_and_push_buffer+0x143/0x1f0 drivers/tty/tty_buffer.c:561
 pty_write+0xd2/0x100 drivers/tty/pty.c:118
 tty_put_char+0x132/0x160 drivers/tty/tty_io.c:3168
 n_tty_process_echo_ops drivers/tty/n_tty.c:663 [inline]
 __process_echoes+0x7fe/0xb40 drivers/tty/n_tty.c:709
 flush_echoes drivers/tty/n_tty.c:807 [inline]
 __receive_buf drivers/tty/n_tty.c:1632 [inline]
 n_tty_receive_buf_common+0xa39/0x1900 drivers/tty/n_tty.c:1729
 tty_ldisc_receive_buf+0xa5/0x190 drivers/tty/tty_buffer.c:386
 tty_port_default_receive_buf+0x70/0xb0 drivers/tty/tty_port.c:37
 receive_buf drivers/tty/tty_buffer.c:444 [inline]
 flush_to_ldisc+0x267/0x780 drivers/tty/tty_buffer.c:494
 process_one_work+0x9ac/0x1a60 kernel/workqueue.c:3254
 process_scheduled_works kernel/workqueue.c:3335 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3416
 kthread+0x2c4/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
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

