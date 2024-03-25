Return-Path: <linux-kernel+bounces-116361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D8888974B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D9531C30476
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C771D17B4E5;
	Mon, 25 Mar 2024 04:20:39 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0139E2CCB60
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 00:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711328067; cv=none; b=dsIYFixXa0zSM38sQLwOeY4osmxL4rNzU1scLwbgrT5csWF0K+w8qPyalhepzG1CNpsdTSnCNnrPbTrSDmeqnvhkB34kuFjHLH3GepqdrSB+nKcKC7syfhgHyQ/V3l7WhmcHBsPckZUqxzLoy77uwbabe+q47HrANAaOZkrEqmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711328067; c=relaxed/simple;
	bh=o9ykBhmUE/bjkZDfwuv5a/CD03A9OiU7erjSh1VFBcc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SUrX+ciKwSznXwGmFQevZE2/b5j6wjCw5iJybe6Ubd8pEcVeRhCuDkLpk+gtmdJNd1YSgwiDbZudSixG8XQtE09sM5ioyuw+F+peojEoouykNq2XtJsC1Xm5DH9nirHIYOY3FNQyNPPBxYUBXsKMwSzk+Ms6NvM9zjmISHWYhn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c8a960bd9eso337235439f.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 17:54:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711328063; x=1711932863;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E8j825byIpGk2R+o/YG4IjV2BYZmyUIliuoIWAKGsS8=;
        b=Klvgdfcczp1TF863gFuEqcXjZDgDE1x7/kKTos/yqm2sx0LpmVlR4lP+nL7xeDbGbu
         x1uA5ZQk5fBQJlGbFAelm8Ct/RTqv1zLOuEB/A3XgObt0c3d9jxkOlAIrkFWyQeG0U4A
         GRlBNl0tyTQUNKbaFzv8Qao1ruG0B8UNIDuHdEtqs7MZVdLiw9anqb1ctFY55XSSziha
         NwiLR5Wg08acETHotsroyYQJbyvFM7ZDJnJt5+UkQAI7RSH+5NIIZOF55yCouh3xwSyR
         Yh0ppOeQ3wmI+H52jb8TzuY7Jk4j8OnS8FdXeFwl/eEt9KVPMTXiSS7TmmUnne86av+M
         vOpg==
X-Gm-Message-State: AOJu0Yxa4qeDLpXktsSx8FHTQwU8sG8Y10mCAS00RKmeAcZxHe1Y28FN
	GUA1hWK8NQMSJJ2biGRdWCD/PEkyq0Ype93osJugSd1V92Wr5TNyPksqDhBPJpjPrHTm7sDqvzv
	tvf/UekDGAa/NwnFZtQ+kn2sVjfBzam3MIAzqqFwI20hXm3anFjXYZuOiQg==
X-Google-Smtp-Source: AGHT+IG4GI+7fkrv7tGd3LlmqnMCIpjEw/NfNbkvSQUrZS8E4HuZymzMJQR6kS9IxE+hhILsgq1JU72fdNbI5g+mErhJZqCQbEw0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3725:b0:476:f2d0:7722 with SMTP id
 k37-20020a056638372500b00476f2d07722mr198693jav.6.1711328063192; Sun, 24 Mar
 2024 17:54:23 -0700 (PDT)
Date: Sun, 24 Mar 2024 17:54:23 -0700
In-Reply-To: <00000000000002a89b06146e6ecb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004d19010614719d7f@google.com>
Subject: Re: [syzbot] [kernel?] possible deadlock in __hrtimer_run_queues (2)
From: syzbot <syzbot+bacb240dbeebb88518ae@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    61df575632d6 libbpf: Add new sec_def "sk_skb/verdict"
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=111bbffa180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=bacb240dbeebb88518ae
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1793a2e6180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16c8dac9180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0d2d0f91bfad/disk-61df5756.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0b0f2fd80260/vmlinux-61df5756.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0450c835a85f/bzImage-61df5756.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bacb240dbeebb88518ae@syzkaller.appspotmail.com

------------[ cut here ]------------
======================================================
WARNING: possible circular locking dependency detected
6.8.0-syzkaller-05238-g61df575632d6 #0 Not tainted
------------------------------------------------------
swapper/1/0 is trying to acquire lock:
ffffffff8e125be0 (console_owner){-...}-{0:0}, at: console_trylock_spinning kernel/printk/printk.c:1951 [inline]
ffffffff8e125be0 (console_owner){-...}-{0:0}, at: vprintk_emit+0x33e/0x720 kernel/printk/printk.c:2291

but task is already holding lock:
ffff8880b952c8d8 (hrtimer_bases.lock){-.-.}-{2:2}, at: __run_hrtimer kernel/time/hrtimer.c:1696 [inline]
ffff8880b952c8d8 (hrtimer_bases.lock){-.-.}-{2:2}, at: __hrtimer_run_queues+0x65a/0xd00 kernel/time/hrtimer.c:1756

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (hrtimer_bases.lock){-.-.}-{2:2}:
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       lock_hrtimer_base kernel/time/hrtimer.c:175 [inline]
       hrtimer_start_range_ns+0xdf/0xc60 kernel/time/hrtimer.c:1303
       rpm_suspend+0x1725/0x1c10 drivers/base/power/runtime.c:605
       __pm_runtime_idle+0x131/0x1a0 drivers/base/power/runtime.c:1103
       pm_runtime_put include/linux/pm_runtime.h:460 [inline]
       __device_attach+0x3e5/0x520 drivers/base/dd.c:1048
       bus_probe_device+0x189/0x260 drivers/base/bus.c:532
       device_add+0x8ff/0xca0 drivers/base/core.c:3639
       serdev_controller_add+0x2f/0x4b0 drivers/tty/serdev/core.c:782
       serdev_tty_port_register+0x163/0x260 drivers/tty/serdev/serdev-ttyport.c:302
       tty_port_register_device_attr_serdev+0xe1/0x160 drivers/tty/tty_port.c:191
       serial_core_add_one_port drivers/tty/serial/serial_core.c:3191 [inline]
       serial_core_register_port+0xee0/0x1e30 drivers/tty/serial/serial_core.c:3398
       serial8250_register_8250_port+0x1433/0x1cd0 drivers/tty/serial/8250/8250_core.c:1138
       serial_pnp_probe+0x7d5/0xa20 drivers/tty/serial/8250/8250_pnp.c:478
       pnp_device_probe+0x2ba/0x460 drivers/pnp/driver.c:111
       really_probe+0x29e/0xc50 drivers/base/dd.c:658
       __driver_probe_device+0x1a2/0x3e0 drivers/base/dd.c:800
       driver_probe_device+0x50/0x430 drivers/base/dd.c:830
       __driver_attach+0x45f/0x710 drivers/base/dd.c:1216
       bus_for_each_dev+0x239/0x2b0 drivers/base/bus.c:368
       bus_add_driver+0x347/0x620 drivers/base/bus.c:673
       driver_register+0x23a/0x320 drivers/base/driver.c:246
       serial8250_init+0x9e/0x170 drivers/tty/serial/8250/8250_core.c:1239
       do_one_initcall+0x238/0x830 init/main.c:1241
       do_initcall_level+0x157/0x210 init/main.c:1303
       do_initcalls+0x3f/0x80 init/main.c:1319
       kernel_init_freeable+0x435/0x5d0 init/main.c:1557
       kernel_init+0x1d/0x2a0 init/main.c:1446
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243

-> #2 (&dev->power.lock){-...}-{2:2}:
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       __pm_runtime_resume+0x112/0x180 drivers/base/power/runtime.c:1170
       pm_runtime_get include/linux/pm_runtime.h:408 [inline]
       __uart_start+0x17a/0x3c0 drivers/tty/serial/serial_core.c:148
       uart_write+0x427/0x5c0 drivers/tty/serial/serial_core.c:615
       process_output_block drivers/tty/n_tty.c:574 [inline]
       n_tty_write+0xd6a/0x1230 drivers/tty/n_tty.c:2379
       iterate_tty_write drivers/tty/tty_io.c:1021 [inline]
       file_tty_write+0x54f/0x9b0 drivers/tty/tty_io.c:1096
       call_write_iter include/linux/fs.h:2108 [inline]
       new_sync_write fs/read_write.c:497 [inline]
       vfs_write+0xa84/0xcb0 fs/read_write.c:590
       ksys_write+0x1a0/0x2c0 fs/read_write.c:643
       do_syscall_64+0xfb/0x240
       entry_SYSCALL_64_after_hwframe+0x6d/0x75

-> #1 (&port_lock_key){-.-.}-{2:2}:
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       uart_port_lock_irqsave include/linux/serial_core.h:616 [inline]
       serial8250_console_write+0x1a8/0x1840 drivers/tty/serial/8250/8250_port.c:3403
       console_emit_next_record kernel/printk/printk.c:2890 [inline]
       console_flush_all+0x80b/0xec0 kernel/printk/printk.c:2956
       console_unlock+0x13b/0x4d0 kernel/printk/printk.c:3025
       vprintk_emit+0x509/0x720 kernel/printk/printk.c:2292
       _printk+0xd5/0x120 kernel/printk/printk.c:2317
       register_console+0x70a/0xcd0 kernel/printk/printk.c:3531
       univ8250_console_init+0x49/0x50 drivers/tty/serial/8250/8250_core.c:717
       console_init+0x198/0x680 kernel/printk/printk.c:3677
       start_kernel+0x2d3/0x500 init/main.c:1012
       x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:509
       x86_64_start_kernel+0x99/0xa0 arch/x86/kernel/head64.c:490
       common_startup_64+0x13e/0x147

-> #0 (console_owner){-...}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
       console_trylock_spinning kernel/printk/printk.c:1951 [inline]
       vprintk_emit+0x35b/0x720 kernel/printk/printk.c:2291
       _printk+0xd5/0x120 kernel/printk/printk.c:2317
       __report_bug lib/bug.c:195 [inline]
       report_bug+0x346/0x500 lib/bug.c:219
       handle_bug+0x3e/0x70 arch/x86/kernel/traps.c:239
       exc_invalid_op+0x1a/0x50 arch/x86/kernel/traps.c:260
       asm_exc_invalid_op+0x1a/0x20 arch/x86/include/asm/idtentry.h:621
       __local_bh_enable_ip+0x1ae/0x200 kernel/softirq.c:361
       spin_unlock_bh include/linux/spinlock.h:396 [inline]
       sock_hash_delete_elem+0x1a6/0x300 net/core/sock_map.c:947
       bpf_prog_2c29ac5cdc6b1842+0x42/0x46
       bpf_dispatcher_nop_func include/linux/bpf.h:1233 [inline]
       __bpf_prog_run include/linux/filter.h:657 [inline]
       bpf_prog_run include/linux/filter.h:664 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2390 [inline]
       bpf_trace_run2+0x2ec/0x530 kernel/trace/bpf_trace.c:2431
       trace_hrtimer_start include/trace/events/timer.h:222 [inline]
       debug_activate kernel/time/hrtimer.c:479 [inline]
       enqueue_hrtimer+0x335/0x3a0 kernel/time/hrtimer.c:1090
       __run_hrtimer kernel/time/hrtimer.c:1709 [inline]
       __hrtimer_run_queues+0x6b5/0xd00 kernel/time/hrtimer.c:1756
       hrtimer_interrupt+0x396/0x990 kernel/time/hrtimer.c:1818
       local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
       __sysvec_apic_timer_interrupt+0x107/0x3a0 arch/x86/kernel/apic/apic.c:1049
       instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
       sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1043
       asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
       native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
       arch_safe_halt arch/x86/include/asm/irqflags.h:86 [inline]
       acpi_safe_halt+0x21/0x30 drivers/acpi/processor_idle.c:112
       acpi_idle_enter+0xe4/0x140 drivers/acpi/processor_idle.c:707
       cpuidle_enter_state+0x118/0x490 drivers/cpuidle/cpuidle.c:267
       cpuidle_enter+0x5d/0xa0 drivers/cpuidle/cpuidle.c:388
       call_cpuidle kernel/sched/idle.c:155 [inline]
       cpuidle_idle_call kernel/sched/idle.c:236 [inline]
       do_idle+0x375/0x5d0 kernel/sched/idle.c:332
       cpu_startup_entry+0x42/0x60 kernel/sched/idle.c:430
       __pfx_ap_starting+0x0/0x10 arch/x86/kernel/smpboot.c:313
       common_startup_64+0x13e/0x147

other info that might help us debug this:

Chain exists of:
  console_owner --> &dev->power.lock --> hrtimer_bases.lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(hrtimer_bases.lock);
                               lock(&dev->power.lock);
                               lock(hrtimer_bases.lock);
  lock(console_owner);

 *** DEADLOCK ***

2 locks held by swapper/1/0:
 #0: ffff8880b952c8d8 (hrtimer_bases.lock){-.-.}-{2:2}, at: __run_hrtimer kernel/time/hrtimer.c:1696 [inline]
 #0: ffff8880b952c8d8 (hrtimer_bases.lock){-.-.}-{2:2}, at: __hrtimer_run_queues+0x65a/0xd00 kernel/time/hrtimer.c:1756
 #1: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #1: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #1: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2389 [inline]
 #1: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run2+0x1fc/0x530 kernel/trace/bpf_trace.c:2431

stack backtrace:
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.8.0-syzkaller-05238-g61df575632d6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
 console_trylock_spinning kernel/printk/printk.c:1951 [inline]
 vprintk_emit+0x35b/0x720 kernel/printk/printk.c:2291
 _printk+0xd5/0x120 kernel/printk/printk.c:2317
 __report_bug lib/bug.c:195 [inline]
 report_bug+0x346/0x500 lib/bug.c:219
 handle_bug+0x3e/0x70 arch/x86/kernel/traps.c:239
 exc_invalid_op+0x1a/0x50 arch/x86/kernel/traps.c:260
 asm_exc_invalid_op+0x1a/0x20 arch/x86/include/asm/idtentry.h:621
RIP: 0010:__local_bh_enable_ip+0x1ae/0x200 kernel/softirq.c:361
Code: 04 1c 00 00 00 00 65 48 8b 04 25 28 00 00 00 48 3b 44 24 60 75 52 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc 90 <0f> 0b 90 e9 ca fe ff ff e8 55 00 00 00 eb 9c 90 0f 0b 90 e9 fa fe
RSP: 0018:ffffc90000a08ae0 EFLAGS: 00010006
RAX: 0000000080010204 RBX: 1ffff92000141160 RCX: 0000000000000001
RDX: 0000000000000000 RSI: 0000000000000201 RDI: ffffffff895fdf36
RBP: ffffc90000a08ba0 R08: ffff88801dbcfa03 R09: 1ffff11003b79f40
R10: dffffc0000000000 R11: ffffed1003b79f41 R12: dffffc0000000000
R13: 0000000000000008 R14: ffff888028793c00 R15: 0000000000000201
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 sock_hash_delete_elem+0x1a6/0x300 net/core/sock_map.c:947
 bpf_prog_2c29ac5cdc6b1842+0x42/0x46
 bpf_dispatcher_nop_func include/linux/bpf.h:1233 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2390 [inline]
 bpf_trace_run2+0x2ec/0x530 kernel/trace/bpf_trace.c:2431
 trace_hrtimer_start include/trace/events/timer.h:222 [inline]
 debug_activate kernel/time/hrtimer.c:479 [inline]
 enqueue_hrtimer+0x335/0x3a0 kernel/time/hrtimer.c:1090
 __run_hrtimer kernel/time/hrtimer.c:1709 [inline]
 __hrtimer_run_queues+0x6b5/0xd00 kernel/time/hrtimer.c:1756
 hrtimer_interrupt+0x396/0x990 kernel/time/hrtimer.c:1818
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
 __sysvec_apic_timer_interrupt+0x107/0x3a0 arch/x86/kernel/apic/apic.c:1049
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:native_irq_disable arch/x86/include/asm/irqflags.h:37 [inline]
RIP: 0010:arch_local_irq_disable arch/x86/include/asm/irqflags.h:72 [inline]
RIP: 0010:acpi_safe_halt+0x21/0x30 drivers/acpi/processor_idle.c:113
Code: 90 90 90 90 90 90 90 90 90 65 48 8b 04 25 80 ce 03 00 48 f7 00 08 00 00 00 75 10 66 90 0f 00 2d 15 2a 98 00 f3 0f 1e fa fb f4 <fa> c3 cc cc cc cc 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90
RSP: 0018:ffffc90000197d08 EFLAGS: 00000246
RAX: ffff8880172c5a00 RBX: ffff8880172ee064 RCX: 0000000000013589
RDX: 0000000000000001 RSI: ffff8880172ee000 RDI: ffff8880172ee064
RBP: 0000000000039f18 R08: ffff8880b9537d0b R09: 1ffff110172a6fa1
R10: dffffc0000000000 R11: ffffffff8b703580 R12: ffff88801b7d0800
R13: 0000000000000000 R14: 0000000000000001 R15: ffffffff8e8a2e80
 acpi_idle_enter+0xe4/0x140 drivers/acpi/processor_idle.c:707
 cpuidle_enter_state+0x118/0x490 drivers/cpuidle/cpuidle.c:267
 cpuidle_enter+0x5d/0xa0 drivers/cpuidle/cpuidle.c:388
 call_cpuidle kernel/sched/idle.c:155 [inline]
 cpuidle_idle_call kernel/sched/idle.c:236 [inline]
 do_idle+0x375/0x5d0 kernel/sched/idle.c:332
 cpu_startup_entry+0x42/0x60 kernel/sched/idle.c:430
 start_secondary+0x100/0x100 arch/x86/kernel/smpboot.c:313
 common_startup_64+0x13e/0x147
 </TASK>
WARNING: CPU: 1 PID: 0 at kernel/softirq.c:361 __local_bh_enable_ip+0x1ae/0x200 kernel/softirq.c:361
Modules linked in:
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.8.0-syzkaller-05238-g61df575632d6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
RIP: 0010:__local_bh_enable_ip+0x1ae/0x200 kernel/softirq.c:361
Code: 04 1c 00 00 00 00 65 48 8b 04 25 28 00 00 00 48 3b 44 24 60 75 52 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc 90 <0f> 0b 90 e9 ca fe ff ff e8 55 00 00 00 eb 9c 90 0f 0b 90 e9 fa fe
RSP: 0018:ffffc90000a08ae0 EFLAGS: 00010006

RAX: 0000000080010204 RBX: 1ffff92000141160 RCX: 0000000000000001
RDX: 0000000000000000 RSI: 0000000000000201 RDI: ffffffff895fdf36
RBP: ffffc90000a08ba0 R08: ffff88801dbcfa03 R09: 1ffff11003b79f40
R10: dffffc0000000000 R11: ffffed1003b79f41 R12: dffffc0000000000
R13: 0000000000000008 R14: ffff888028793c00 R15: 0000000000000201
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055b07d4945d8 CR3: 000000007b506000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 sock_hash_delete_elem+0x1a6/0x300 net/core/sock_map.c:947
 bpf_prog_2c29ac5cdc6b1842+0x42/0x46
 bpf_dispatcher_nop_func include/linux/bpf.h:1233 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2390 [inline]
 bpf_trace_run2+0x2ec/0x530 kernel/trace/bpf_trace.c:2431
 trace_hrtimer_start include/trace/events/timer.h:222 [inline]
 debug_activate kernel/time/hrtimer.c:479 [inline]
 enqueue_hrtimer+0x335/0x3a0 kernel/time/hrtimer.c:1090
 __run_hrtimer kernel/time/hrtimer.c:1709 [inline]
 __hrtimer_run_queues+0x6b5/0xd00 kernel/time/hrtimer.c:1756
 hrtimer_interrupt+0x396/0x990 kernel/time/hrtimer.c:1818
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
 __sysvec_apic_timer_interrupt+0x107/0x3a0 arch/x86/kernel/apic/apic.c:1049
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:native_irq_disable arch/x86/include/asm/irqflags.h:37 [inline]
RIP: 0010:arch_local_irq_disable arch/x86/include/asm/irqflags.h:72 [inline]
RIP: 0010:acpi_safe_halt+0x21/0x30 drivers/acpi/processor_idle.c:113
Code: 90 90 90 90 90 90 90 90 90 65 48 8b 04 25 80 ce 03 00 48 f7 00 08 00 00 00 75 10 66 90 0f 00 2d 15 2a 98 00 f3 0f 1e fa fb f4 <fa> c3 cc cc cc cc 66 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90
RSP: 0018:ffffc90000197d08 EFLAGS: 00000246

RAX: ffff8880172c5a00 RBX: ffff8880172ee064 RCX: 0000000000013589
RDX: 0000000000000001 RSI: ffff8880172ee000 RDI: ffff8880172ee064
RBP: 0000000000039f18 R08: ffff8880b9537d0b R09: 1ffff110172a6fa1
R10: dffffc0000000000 R11: ffffffff8b703580 R12: ffff88801b7d0800
R13: 0000000000000000 R14: 0000000000000001 R15: ffffffff8e8a2e80
 acpi_idle_enter+0xe4/0x140 drivers/acpi/processor_idle.c:707
 cpuidle_enter_state+0x118/0x490 drivers/cpuidle/cpuidle.c:267
 cpuidle_enter+0x5d/0xa0 drivers/cpuidle/cpuidle.c:388
 call_cpuidle kernel/sched/idle.c:155 [inline]
 cpuidle_idle_call kernel/sched/idle.c:236 [inline]
 do_idle+0x375/0x5d0 kernel/sched/idle.c:332
 cpu_startup_entry+0x42/0x60 kernel/sched/idle.c:430
 start_secondary+0x100/0x100 arch/x86/kernel/smpboot.c:313
 common_startup_64+0x13e/0x147
 </TASK>
----------------
Code disassembly (best guess):
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
   3:	90                   	nop
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	65 48 8b 04 25 80 ce 	mov    %gs:0x3ce80,%rax
  10:	03 00
  12:	48 f7 00 08 00 00 00 	testq  $0x8,(%rax)
  19:	75 10                	jne    0x2b
  1b:	66 90                	xchg   %ax,%ax
  1d:	0f 00 2d 15 2a 98 00 	verw   0x982a15(%rip)        # 0x982a39
  24:	f3 0f 1e fa          	endbr64
  28:	fb                   	sti
  29:	f4                   	hlt
* 2a:	fa                   	cli <-- trapping instruction
  2b:	c3                   	ret
  2c:	cc                   	int3
  2d:	cc                   	int3
  2e:	cc                   	int3
  2f:	cc                   	int3
  30:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  37:	00 00
  39:	90                   	nop
  3a:	90                   	nop
  3b:	90                   	nop
  3c:	90                   	nop
  3d:	90                   	nop
  3e:	90                   	nop
  3f:	90                   	nop


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

