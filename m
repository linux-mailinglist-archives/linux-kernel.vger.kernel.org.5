Return-Path: <linux-kernel+bounces-98593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD90877C65
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41D8D1C20D97
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5099717562;
	Mon, 11 Mar 2024 09:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nCV5vGPc"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6541C22F14;
	Mon, 11 Mar 2024 09:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710148512; cv=none; b=GCzDqaRtFiRBn34lrZGxq9Lp1CLAvZ+UVNDk3QnpiZ9S/MP5emIq2c46H1SddbcUVsg6gPkiSMZTM5r4zcxoyIV38XudA42tKk3EYrpSN0sK2CVCKhgmLmom4mfhcxZ0r6yyAXjZ4znN41llII2Mg/0s74TdKZpxEAE0+On3e6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710148512; c=relaxed/simple;
	bh=GhLIU5sRaBTZKgau5yc14KuQA31H1roC2T/f0x3Fi+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZNH25FrWIvnE95fPitOXaKpe+LmaYx5fttzl8yXwceQQdX4xJULIz1liqPMBhsDRaegLWqs7FAGFQ0/MkoDNywxvAyr7ngmUjfLk1j03G1HhQ76l5JpiPjniYC6eIxG/7ynWupOxglV73yjiUJ8eqcw4LLUxt4BX1ynqWwCU68c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nCV5vGPc; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5c66b093b86so3799484a12.0;
        Mon, 11 Mar 2024 02:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710148510; x=1710753310; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MWhBUNsPmm62H/e0c8fmAcvywcTD8S5kwEzqcIxgQ8c=;
        b=nCV5vGPcTWUYrDsJ8ZCo8QU4KEE031kvdF7f8OoehwUP+zxz3p2DiAMq3vlpxueNtN
         RXK6sd0WIcEcyEHlOnhkU/PvmuKzAD9ftjAQYLqTevW+ReL/1dzQ8T4S1WMMlYg4IkII
         nJ6vsKC3C9jBo73b/SAZ4aUpLkvqRU2i8Irb1EMCnDFteorcPp4v1cin0HCtm/I9tEp2
         PJx//26nFt3PSJ7qM3q6RSqrKtX4NQFRnp2Jd9t42DdN9zqsaBnLI2KMSDk7dtboptqM
         9dlrLuOY4y/q8/JX2YoqTuwpKNO54JhBFdxZHyCOGsschJNp1rFxoecjjMjYtkZU3TCy
         dL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710148510; x=1710753310;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MWhBUNsPmm62H/e0c8fmAcvywcTD8S5kwEzqcIxgQ8c=;
        b=Opri9sINrAc2NXXdaKrhPLrN3IxaruILODWmGaDks5jBWgBedrfqw0GQ1hue+PflzY
         tFfYmxYDAFoC3J/fg8OgeuzGADwRDmRySrgdEBecy5ElreXA5KIuii5Uoq443qPD0NSx
         H5uIWo7oJb1cfXSehcNCnLSxYKoMeuZo8uuA86mrLOQd3BUUhfzanqmJFT+0AHcHMvPz
         mbxxO2ZA5ZuOZbSL3Lum8FgN+CHdZvxI/GLoFkW0c85u62dXXhTzRPPRt232r1JsTFr5
         LQL8n5c84VR20arRW/G9jAwYkiIU9QN0SeIwqwOQT/JEr8jhS7SD1mhObopSDlUgL4hv
         11EQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5dsCXGQNqGoWqd56XtQKAYfw0G7TtPTJF/qeozpm4mReMbuMIjLG9czmW5+O0tSIytfpfJcCh5J5Oqnyy3x+r9+WAg4dly932FOZjRzAkQyLA6n2XRJI/pKjhknJ5FXKfNotIrB+abZeBlyndFHAgYzCi91RFxM/iZeQ/4qIzDY2sBHg=
X-Gm-Message-State: AOJu0Yz0Nb/cKy6WdWMGeSDK9QdP5G4+OE7FrnGBSx+ON6doc6LMiHcE
	u/mB0wPrlMw8HXqmkyCpdbWXIu0J7jengDv4o3NxtscbNZ4D6gPsGfZHYq7FZLUTj904VVZR/x4
	Ht/sAO7ItxyQ9grWLrewJSI4JVe8=
X-Google-Smtp-Source: AGHT+IGEF8HVRO+OB9AHJrnM3e1i1OuhRKOD7oSnDWd/K1yvW1ptiJK1DEDo1LYr8J7cqqWsg8Boqm/w7XqXFGr8ces=
X-Received: by 2002:a17:90a:72ce:b0:29b:a345:620a with SMTP id
 l14-20020a17090a72ce00b0029ba345620amr8375253pjk.20.1710148509691; Mon, 11
 Mar 2024 02:15:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000006dbb0b06133aacee@google.com>
In-Reply-To: <0000000000006dbb0b06133aacee@google.com>
From: Z qiang <qiang.zhang1211@gmail.com>
Date: Mon, 11 Mar 2024 17:14:58 +0800
Message-ID: <CALm+0cVun=SSczF2hJPJFZU85NMmntScWAFLL7e9pXJiVt+qWw@mail.gmail.com>
Subject: Re: [syzbot] [mm?] [input?] [usb?] INFO: rcu detected stall in asm_exc_page_fault
To: syzbot <syzbot+360faf5c01a5be55581d@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-usb@vger.kernel.org, 
	pasha.tatashin@soleen.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    90d35da658da Linux 6.8-rc7
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=122f6f6a180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=119d08814b43915b
> dashboard link: https://syzkaller.appspot.com/bug?extid=360faf5c01a5be55581d
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=124056de180000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/fb2c1adf4ec3/disk-90d35da6.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/09c5b88a8ceb/vmlinux-90d35da6.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/5e5cbc312e49/bzImage-90d35da6.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+360faf5c01a5be55581d@syzkaller.appspotmail.com

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
master

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7019a40457a6..69e344f07e68 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9233,6 +9233,7 @@ void show_state_filter(unsigned int state_filter)
                 */
                touch_nmi_watchdog();
                touch_all_softlockup_watchdogs();
+               rcu_cpu_stall_reset();
                if (state_filter_match(state_filter, p))
                        sched_show_task(p);
        }




>
> rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: {
>  1-....
>  } 4831 jiffies s: 1849 root: 0x2/.
> rcu: blocking rcu_node structures (internal RCU debug):
> Sending NMI from CPU 0 to CPUs 1:
>  kthread+0x2ef/0x390 kernel/kthread.c:388
> NMI backtrace for cpu 1
> CPU: 1 PID: 5232 Comm: syz-executor.3 Not tainted 6.8.0-rc7-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
> RIP: 0010:format_decode+0x546/0x1bb0
> Code: 85 96 01 00 00 45 84 ff 0f 84 8d 01 00 00 48 bb 00 ff ff ff 00 ff ff ff 48 8b 44 24 20 42 0f b6 04 30 84 c0 0f 85 4d 10 00 00 <48> 8b 54 24 48 48 21 da 48 8b 44 24 28 42 0f b6 04 30 84 c0 48 8d
> RSP: 0000:ffffc900001efa20 EFLAGS: 00000046
> RAX: 0000000000000000 RBX: ffffff00ffffff00 RCX: ffff8880219e0000
> RDX: ffff8880219e0000 RSI: 0000000000000025 RDI: 0000000000000000
> RBP: ffffc900001efb10 R08: ffffffff8b57a4c8 R09: ffffffff8b57a1aa
> R10: 0000000000000002 R11: ffff8880219e0000 R12: ffffffff8bab75e6
> R13: ffffffff8bab75e6 R14: dffffc0000000000 R15: 0000000000000025
> FS:  0000555555c82480(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f74dc087056 CR3: 0000000021bc6000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <NMI>
>  </NMI>
>  <IRQ>
>  vsnprintf+0x14f/0x1da0 lib/vsprintf.c:2776
>  sprintf+0xda/0x120 lib/vsprintf.c:3028
>  print_time kernel/printk/printk.c:1324 [inline]
>  info_print_prefix+0x16b/0x310 kernel/printk/printk.c:1350
>  record_print_text kernel/printk/printk.c:1399 [inline]
>  printk_get_next_message+0x408/0xce0 kernel/printk/printk.c:2828
>  console_emit_next_record kernel/printk/printk.c:2868 [inline]
>  console_flush_all+0x42d/0xec0 kernel/printk/printk.c:2967
>  console_unlock+0x13b/0x4d0 kernel/printk/printk.c:3036
>  vprintk_emit+0x508/0x720 kernel/printk/printk.c:2303
>  _printk+0xd5/0x120 kernel/printk/printk.c:2328
>  printk_stack_address arch/x86/kernel/dumpstack.c:72 [inline]
>  show_trace_log_lvl+0x438/0x520 arch/x86/kernel/dumpstack.c:285
>  sched_show_task+0x50c/0x6d0 kernel/sched/core.c:9171
>  show_state_filter+0x19e/0x270 kernel/sched/core.c:9216
>  kbd_keycode drivers/tty/vt/keyboard.c:1524 [inline]
>  kbd_event+0x30fa/0x4910 drivers/tty/vt/keyboard.c:1543
>  input_to_handler drivers/input/input.c:132 [inline]
>  input_pass_values+0x945/0x1200 drivers/input/input.c:161
>  input_event_dispose drivers/input/input.c:378 [inline]
>  input_handle_event drivers/input/input.c:406 [inline]
>  input_repeat_key+0x3fd/0x6c0 drivers/input/input.c:2263
>  call_timer_fn+0x17e/0x600 kernel/time/timer.c:1700
>  expire_timers kernel/time/timer.c:1751 [inline]
>  __run_timers+0x621/0x830 kernel/time/timer.c:2038
>  run_timer_softirq+0x67/0xf0 kernel/time/timer.c:2051
>  __do_softirq+0x2bb/0x942 kernel/softirq.c:553
>  invoke_softirq kernel/softirq.c:427 [inline]
>  __irq_exit_rcu+0xf1/0x1c0 kernel/softirq.c:632
>  irq_exit_rcu+0x9/0x30 kernel/softirq.c:644
>  sysvec_apic_timer_interrupt+0x97/0xb0 arch/x86/kernel/apic/apic.c:1076
>  </IRQ>
>  <TASK>
>  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:649
> RIP: 0010:page_table_check_set+0x58/0x700 mm/page_table_check.c:109
> Code: 95 ff 85 ed 0f 84 5f 03 00 00 49 bf 00 00 00 00 00 fc ff df 48 c1 e3 06 48 bd 00 00 00 00 00 ea ff ff 48 8d 3c 2b 48 89 3c 24 <e8> 33 e9 ff ff 49 89 c6 4c 8d 64 2b 08 4c 89 e5 48 c1 ed 03 42 80
> RSP: 0000:ffffc90004d0f650 EFLAGS: 00000202
> RAX: 0000000000000000 RBX: 0000000001c8ae80 RCX: ffff8880219e0000
> RDX: ffff8880219e0000 RSI: 0000000000000001 RDI: ffffea0001c8ae80
> RBP: ffffea0000000000 R08: ffffffff81fdf590 R09: 1ffffffff1f0880d
> R10: dffffc0000000000 R11: fffffbfff1f0880e R12: 0000000000000000
> R13: 0000000000000001 R14: 00000000722ba025 R15: dffffc0000000000
>  __page_table_check_ptes_set+0x220/0x280 mm/page_table_check.c:196
>  page_table_check_ptes_set include/linux/page_table_check.h:74 [inline]
>  set_ptes include/linux/pgtable.h:241 [inline]
>  set_pte_range+0x885/0x8b0 mm/memory.c:4549
>  filemap_map_order0_folio mm/filemap.c:3513 [inline]
>  filemap_map_pages+0xee2/0x1830 mm/filemap.c:3559
>  do_fault_around mm/memory.c:4716 [inline]
>  do_read_fault mm/memory.c:4749 [inline]
>  do_fault mm/memory.c:4888 [inline]
>  do_pte_missing mm/memory.c:3745 [inline]
>  handle_pte_fault mm/memory.c:5164 [inline]
>  __handle_mm_fault+0x485d/0x72d0 mm/memory.c:5305
>  handle_mm_fault+0x27e/0x770 mm/memory.c:5470
>  do_user_addr_fault arch/x86/mm/fault.c:1355 [inline]
>  handle_page_fault arch/x86/mm/fault.c:1498 [inline]
>  exc_page_fault+0x456/0x870 arch/x86/mm/fault.c:1554
>  asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570
> RIP: 0033:0x7f74dc087080
> Code: Unable to access opcode bytes at 0x7f74dc087056.
> RSP: 002b:00007ffe028d3bb8 EFLAGS: 00010246
> RAX: 00007f74dcdfb9d0 RBX: 00007f74dcdfb6c0 RCX: 00007f74dc07de67
> RDX: 0000000000000003 RSI: 0000000000020000 RDI: 00007f74dcdfb6c0
> RBP: 0000000000000000 R08: 00000000ffffffff R09: 0000000000000000
> R10: 0000000000021000 R11: 0000000000000206 R12: 00007ffe028d3e60
> R13: ffffffffffffffc0 R14: 0000000000001000 R15: 0000000000000000
>  </TASK>
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:243
>  </TASK>
> task:kworker/u4:0    state:I stack:24400 pid:11    tgid:11    ppid:2      flags:0x00004000
> Workqueue:  0x0 (events_unbound)
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5400 [inline]
>  __schedule+0x177f/0x49a0 kernel/sched/core.c:6727
>  __schedule_loop kernel/sched/core.c:6802 [inline]
>  schedule+0x149/0x260 kernel/sched/core.c:6817
>  worker_thread+0xc26/0x1000 kernel/workqueue.c:2802
>  kthread+0x2ef/0x390 kernel/kthread.c:388
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:243
>  </TASK>
> task:kworker/u4:1    state:I stack:23344 pid:12    tgid:12    ppid:2      flags:0x00004000
> Workqueue:  0x0 (bat_events)
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5400 [inline]
>  __schedule+0x177f/0x49a0 kernel/sched/core.c:6727
>  __schedule_loop kernel/sched/core.c:6802 [inline]
>  schedule+0x149/0x260 kernel/sched/core.c:6817
>  worker_thread+0xc26/0x1000 kernel/workqueue.c:2802
>  kthread+0x2ef/0x390 kernel/kthread.c:388
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:243
>  </TASK>
> task:kworker/R-mm_pe state:I stack:28752 pid:13    tgid:13    ppid:2      flags:0x00004000
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5400 [inline]
>  __schedule+0x177f/0x49a0 kernel/sched/core.c:6727
>  __schedule_loop kernel/sched/core.c:6802 [inline]
>  schedule+0x149/0x260 kernel/sched/core.c:6817
>  rescuer_thread+0xc45/0xda0 kernel/workqueue.c:2937
>  kthread+0x2ef/0x390 kernel/kthread.c:388
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:243
>  </TASK>
> task:rcu_tasks_kthre state:I stack:27448 pid:14    tgid:14    ppid:2      flags:0x00004000
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5400 [inline]
>  __schedule+0x177f/0x49a0 kernel/sched/core.c:6727
>  __schedule_loop kernel/sched/core.c:6802 [inline]
>  schedule+0x149/0x260 kernel/sched/core.c:6817
>  rcu_tasks_one_gp+0x7f5/0xda0 kernel/rcu/tasks.h:578
>  rcu_tasks_kthread+0x186/0x1b0 kernel/rcu/tasks.h:625
>  kthread+0x2ef/0x390 kernel/kthread.c:388
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:243
>  </TASK>
> task:rcu_tasks_trace state:I stack:27144 pid:15    tgid:15    ppid:2      flags:0x00004000
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5400 [inline]
>  __schedule+0x177f/0x49a0 kernel/sched/core.c:6727
>  __schedule_loop kernel/sched/core.c:6802 [inline]
>  schedule+0x149/0x260 kernel/sched/core.c:6817
>  rcu_tasks_one_gp+0x7f5/0xda0 kernel/rcu/tasks.h:578
>  rcu_tasks_kthread+0x186/0x1b0 kernel/rcu/tasks.h:625
>  kthread+0x2ef/0x390 kernel/kthread.c:388
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:243
>  </TASK>
> task:ksoftirqd/0
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
>

