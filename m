Return-Path: <linux-kernel+bounces-121896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3CA88EF0C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9E031C2C97B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C9914D28A;
	Wed, 27 Mar 2024 19:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ERCnRVJm"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C600C13172D
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 19:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711567000; cv=none; b=CSJkwCxkgt9/vYl5TAQ91c75bznOHNzfp7ZvFJN5+qyNwzkqgVGaR7ubFzZ3ZYvOjnpDXc2Qf5XRoxvwMUg94ODay6LyCyjFKvXjearVc/P0GjzX19u1GQRIfPtrRW02QURo8uw+3YRSlnccMGlq7A/WFjuVzWr5b+1xPXuBjmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711567000; c=relaxed/simple;
	bh=rT7083cc0YiUftDA+tFAepIVi96Nohvyc/mp9LpuIkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JEY1/tZp0T8jzrsMEkXVLs5p+q/3srXGbHo36Boy3utyNctFcx3ebH7pTMrkGAtfJmDu8LfRpiC3rtCiqehmZaLlkXUaC6N/A+sShEycBozuyE5gfctLBjMBSmt8vrgQiXL3nTzSTrVwijGbOhJVE7W6Kr30Ea4s32mtsaeLhNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ERCnRVJm; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-60a0599f631so1543017b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 12:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1711566996; x=1712171796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qY9pVjsmMhniDRXvBSM9SVCxWBDBVXOSDIoyD1+tWkY=;
        b=ERCnRVJmB0LS6EWFSECBF5BzMWWIAqT8Z7dxO+Gijynn4o2Ew3anvw9rjqjjNO1HML
         MJd5G9LQiO/BM1It9KwlnmklB09Cr79YSrqikcK8vCzTsdRBxzVDSa3kwrU44fKSUZ2J
         vxKFoEDobs69iWCx8GsHtEzRrKee19cB3xb0RbmtHFS7eXamAVN2a5Oj5AryQ/DB2P86
         HAp+gB4fmth7Tn3/2SGNF8IcfEi5ewB0nSmLHYC56Rbq0+HWCyiB93cLv/sh/bTso5K8
         oTEMmygKoV9z2kj7h206OIHMFSI4C09wJcmHthWBGJDDd1qZwd9BLnCxwF9VoYDX0gLC
         ewEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711566996; x=1712171796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qY9pVjsmMhniDRXvBSM9SVCxWBDBVXOSDIoyD1+tWkY=;
        b=EYELyHNjq8Koj6yCH2h2irGj9P1Z2R5qDRPHKQ0BM1d9JfuqCwxuYgM14uwOfoo9nj
         hjQnBo9j671HN1/jfGJjtR17vx22Mtl2LRybA1hS1z93pLrQi4vBZc/aPFIB5zhH65cj
         xHwFk9Y90MQsKo/ziEdKwKDfMEZj0MWnBtbkZmAdQ0VXX3VqrqBe1oPtoVH/rvtgnIWj
         bbIzQXT/na236OK1hPpidr3Vyxs0tC79oD4uo+BvKb7YAJyS41l2Oungo4by/hLJFHpf
         FAbsBO8iVPb6JmzbPYpzn+11QcYjO2WYHP0acrpBs1xhCsmX1GcpBPfmJ4wMg68R48dO
         WGjg==
X-Forwarded-Encrypted: i=1; AJvYcCViMo3FSxzkL8tznk6ipXk0igygiCSM35jPwO6wjZOj8I6lDPTfatY4OvvrjD81UZBNYOuaNvskBz8frbe5GgNwUmJumF/KJ1Yyp0+D
X-Gm-Message-State: AOJu0YyJnkjOdtAxTNk1l89T+ZWYg20zDibUWqQQHuD4Srpx6gO8a/hd
	YI67BEWdcoVNa+srMLvGUDKAJwQk0PkuojJUaSBrb1nYFmaWS5fffJ7AsAjBmP0vyk6kOTf+gA5
	yExwXk/katKGZnaLNVxB8cvZuwJ5JwdurjCngtX8L9u77KBGWRA==
X-Google-Smtp-Source: AGHT+IFz2nBHDeDJuGJOmEGPA+S7LMXBg8QdPSi9mM++es/FpkMBOmsmqYNrG4GGCYwIA/lIrbfeHOYLo59g9jpOFLs=
X-Received: by 2002:a0d:dc46:0:b0:613:fdf2:77cf with SMTP id
 f67-20020a0ddc46000000b00613fdf277cfmr657527ywe.34.1711566995774; Wed, 27 Mar
 2024 12:16:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000d929dd0614a8ba8c@google.com>
In-Reply-To: <000000000000d929dd0614a8ba8c@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 27 Mar 2024 15:16:25 -0400
Message-ID: <CAHC9VhTWk8j2OnnH+307UzH+A4tLAmcyw7xde3KboZJ0JE2hzw@mail.gmail.com>
Subject: Re: [syzbot] [audit?] [bpf?] INFO: rcu detected stall in
 kauditd_thread (4)
To: syzbot <syzbot+81f5ca46b043d4a1b789@syzkaller.appspotmail.com>
Cc: andrii@kernel.org, ast@kernel.org, audit@vger.kernel.org, 
	bpf@vger.kernel.org, daniel@iogearbox.net, eparis@redhat.com, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	john.ogness@linutronix.de, pmladek@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 2:39=E2=80=AFPM syzbot
<syzbot+81f5ca46b043d4a1b789@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kerne=
l..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D121a9e2118000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Daef2a55903e57=
91c
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D81f5ca46b043d4a=
1b789
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for D=
ebian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D12104f9e180=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D112840ee18000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/089e25869df5/dis=
k-fe46a7dd.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/423b1787914f/vmlinu=
x-fe46a7dd.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/4c043e30c07d/b=
zImage-fe46a7dd.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+81f5ca46b043d4a1b789@syzkaller.appspotmail.com

This doesn't look to be audit related, but I do see something that may
be related in the printk code which was just merged into Linus' tree:

  commit 8076972468584d4a21dab9aa50e388b3ea9ad8c7
  Author: John Ogness <john.ogness@linutronix.de>
  Date:   Mon Feb 26 13:07:24 2024 +0106

   printk: Update @console_may_schedule in console_trylock_spinning()

   console_trylock_spinning() may takeover the console lock from a
   schedulable context. Update @console_may_schedule to make sure it
   reflects a trylock acquire.

   Reported-by: Mukesh Ojha <quic_mojha@quicinc.com>
   Closes: https://lore.kernel.org/lkml/20240222090538.23017-1-quic_mojha@q=
uicinc.com
   Fixes: dbdda842fe96 ("printk: Add console owner and ...")
   Signed-off-by: John Ogness <john.ogness@linutronix.de>
   Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>
   Reviewed-by: Petr Mladek <pmladek@suse.com>
   Link: https://lore.kernel.org/r/875xybmo2z.fsf@jogness.linutronix.de
   Signed-off-by: Petr Mladek <pmladek@suse.com>

> rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> rcu:    1-...!: (1 ticks this GP) idle=3D9bf4/1/0x4000000000000000 softir=
q=3D6591/6591 fqs=3D5
> rcu:    (detected by 0, t=3D10502 jiffies, g=3D7873, q=3D65 ncpus=3D2)
> Sending NMI from CPU 0 to CPUs 1:
> NMI backtrace for cpu 1
> CPU: 1 PID: 28 Comm: kauditd Not tainted 6.8.0-syzkaller-08951-gfe46a7dd1=
89e #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 02/29/2024
> RIP: 0010:write_comp_data+0x0/0x90 kernel/kcov.c:230
> Code: 48 8b 05 13 e2 76 7e 48 8b 80 08 16 00 00 c3 cc cc cc cc 0f 1f 80 0=
0 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <49> 89 d2 49 89=
 f8 49 89 f1 65 48 8b 15 df e1 76 7e 65 8b 05 e0 e1
> RSP: 0018:ffffc90000a08d78 EFLAGS: 00000046
> RAX: 0000000000000001 RBX: 0000000000000001 RCX: ffffffff88e73a44
> RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000005
> RBP: 000000000003d3cc R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000002 R12: ffff8880b952cac0
> R13: ffff88802abeb340 R14: ffff88802abeb340 R15: ffffffff88e73220
> FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000555582f0dca8 CR3: 000000002bcea000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <NMI>
>  </NMI>
>  <IRQ>
>  advance_sched+0x824/0xc60 net/sched/sch_taprio.c:925
>  __run_hrtimer kernel/time/hrtimer.c:1692 [inline]
>  __hrtimer_run_queues+0x20c/0xc20 kernel/time/hrtimer.c:1756
>  hrtimer_interrupt+0x31b/0x800 kernel/time/hrtimer.c:1818
>  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
>  __sysvec_apic_timer_interrupt+0x10f/0x410 arch/x86/kernel/apic/apic.c:10=
49
>  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inli=
ne]
>  sysvec_apic_timer_interrupt+0x90/0xb0 arch/x86/kernel/apic/apic.c:1043
>  </IRQ>
>  <TASK>
>  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.=
h:702
> RIP: 0010:console_flush_all+0xa19/0xd70 kernel/printk/printk.c:2979
> Code: e8 9c dd 25 00 9c 5b 81 e3 00 02 00 00 31 ff 48 89 de e8 0a c9 1e 0=
0 48 85 db 0f 85 8b 01 00 00 e8 ec cd 1e 00 fb 48 8b 04 24 <4c> 89 fa 83 e2=
 07 0f b6 00 38 d0 7f 08 84 c0 0f 85 a9 02 00 00 41
> RSP: 0018:ffffc90000a47a98 EFLAGS: 00000293
> RAX: fffff52000148f7a RBX: 0000000000000000 RCX: ffffffff816e2ab6
> RDX: ffff888018ee9e00 RSI: ffffffff816e2ac4 RDI: 0000000000000007
> RBP: dffffc0000000000 R08: 0000000000000007 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000003 R12: 0000000000000200
> R13: ffffffff8e3995f8 R14: ffffffff8e3995a0 R15: ffffc90000a47bd0
>  console_unlock+0xae/0x290 kernel/printk/printk.c:3042
>  vprintk_emit kernel/printk/printk.c:2342 [inline]
>  vprintk_emit+0x11a/0x5a0 kernel/printk/printk.c:2297
>  vprintk+0x7f/0xa0 kernel/printk/printk_safe.c:45
>  _printk+0xc8/0x100 kernel/printk/printk.c:2367
>  kauditd_printk_skb kernel/audit.c:546 [inline]
>  kauditd_hold_skb+0x1fb/0x240 kernel/audit.c:581
>  kauditd_send_queue+0x236/0x290 kernel/audit.c:766
>  kauditd_thread+0x61e/0xa80 kernel/audit.c:890
>  kthread+0x2c1/0x3a0 kernel/kthread.c:388
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
>  </TASK>
> INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 2.415=
 msecs
> rcu: rcu_preempt kthread starved for 10491 jiffies! g7873 f0x0 RCU_GP_WAI=
T_FQS(5) ->state=3D0x0 ->cpu=3D0
> rcu:    Unless rcu_preempt kthread gets sufficient CPU time, OOM is now e=
xpected behavior.
> rcu: RCU grace-period kthread stack dump:
> task:rcu_preempt     state:R  running task     stack:28304 pid:16    tgid=
:16    ppid:2      flags:0x00004000
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5409 [inline]
>  __schedule+0xf15/0x5c70 kernel/sched/core.c:6736
>  __schedule_loop kernel/sched/core.c:6813 [inline]
>  schedule+0xe7/0x350 kernel/sched/core.c:6828
>  schedule_timeout+0x136/0x2a0 kernel/time/timer.c:2572
>  rcu_gp_fqs_loop+0x1eb/0xb00 kernel/rcu/tree.c:1663
>  rcu_gp_kthread+0x271/0x380 kernel/rcu/tree.c:1862
>  kthread+0x2c1/0x3a0 kernel/kthread.c:388
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
>  </TASK>
> rcu: Stack dump where RCU GP kthread last ran:
> CPU: 0 PID: 43 Comm: kworker/u8:3 Not tainted 6.8.0-syzkaller-08951-gfe46=
a7dd189e #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 02/29/2024
> Workqueue: events_unbound toggle_allocation_gate
> RIP: 0010:csd_lock_wait kernel/smp.c:311 [inline]
> RIP: 0010:smp_call_function_many_cond+0x4e7/0x1590 kernel/smp.c:855
> Code: 0c 00 85 ed 74 4d 48 b8 00 00 00 00 00 fc ff df 4d 89 f4 4c 89 f5 4=
9 c1 ec 03 83 e5 07 49 01 c4 83 c5 03 e8 4b 05 0c 00 f3 90 <41> 0f b6 04 24=
 40 38 c5 7c 08 84 c0 0f 85 5d 0e 00 00 8b 43 08 31
> RSP: 0018:ffffc90000b37910 EFLAGS: 00000293
> RAX: 0000000000000000 RBX: ffff8880b9544380 RCX: ffffffff8180f38b
> RDX: ffff8880192f0000 RSI: ffffffff8180f365 RDI: 0000000000000005
> RBP: 0000000000000003 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000006 R12: ffffed10172a8871
> R13: 0000000000000001 R14: ffff8880b9544388 R15: ffff8880b943f840
> FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055e176bb4000 CR3: 000000000d57a000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <IRQ>
>  </IRQ>
>  <TASK>
>  on_each_cpu_cond_mask+0x40/0x90 kernel/smp.c:1023
>  on_each_cpu include/linux/smp.h:71 [inline]
>  text_poke_sync arch/x86/kernel/alternative.c:2086 [inline]
>  text_poke_bp_batch+0x22b/0x760 arch/x86/kernel/alternative.c:2296
>  text_poke_flush arch/x86/kernel/alternative.c:2487 [inline]
>  text_poke_flush arch/x86/kernel/alternative.c:2484 [inline]
>  text_poke_finish+0x30/0x40 arch/x86/kernel/alternative.c:2494
>  arch_jump_label_transform_apply+0x1c/0x30 arch/x86/kernel/jump_label.c:1=
46
>  jump_label_update+0x1d7/0x400 kernel/jump_label.c:829
>  static_key_enable_cpuslocked+0x1b7/0x270 kernel/jump_label.c:205
>  static_key_enable+0x1a/0x20 kernel/jump_label.c:218
>  toggle_allocation_gate mm/kfence/core.c:826 [inline]
>  toggle_allocation_gate+0xf8/0x250 mm/kfence/core.c:818
>  process_one_work+0x9a9/0x1a60 kernel/workqueue.c:3254
>  process_scheduled_works kernel/workqueue.c:3335 [inline]
>  worker_thread+0x6c8/0xf70 kernel/workqueue.c:3416
>  kthread+0x2c1/0x3a0 kernel/kthread.c:388
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
>  </TASK>
> watchdog: BUG: soft lockup - CPU#0 stuck for 246s! [kworker/u8:3:43]
> Modules linked in:
> irq event stamp: 519008
> hardirqs last  enabled at (519007): [<ffffffff8ad251cb>] irqentry_exit+0x=
3b/0x90 kernel/entry/common.c:351
> hardirqs last disabled at (519008): [<ffffffff8ad239ae>] sysvec_apic_time=
r_interrupt+0xe/0xb0 arch/x86/kernel/apic/apic.c:1043
> softirqs last  enabled at (519006): [<ffffffff8ad63156>] softirq_handle_e=
nd kernel/softirq.c:400 [inline]
> softirqs last  enabled at (519006): [<ffffffff8ad63156>] __do_softirq+0x5=
96/0x8de kernel/softirq.c:583
> softirqs last disabled at (518991): [<ffffffff8151a149>] invoke_softirq k=
ernel/softirq.c:428 [inline]
> softirqs last disabled at (518991): [<ffffffff8151a149>] __irq_exit_rcu k=
ernel/softirq.c:633 [inline]
> softirqs last disabled at (518991): [<ffffffff8151a149>] irq_exit_rcu+0xb=
9/0x120 kernel/softirq.c:645
> CPU: 0 PID: 43 Comm: kworker/u8:3 Not tainted 6.8.0-syzkaller-08951-gfe46=
a7dd189e #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 02/29/2024
> Workqueue: events_unbound toggle_allocation_gate
> RIP: 0010:preempt_count arch/x86/include/asm/preempt.h:26 [inline]
> RIP: 0010:check_kcov_mode kernel/kcov.c:173 [inline]
> RIP: 0010:write_comp_data+0x11/0x90 kernel/kcov.c:236
> Code: cc cc 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 9=
0 90 90 49 89 d2 49 89 f8 49 89 f1 65 48 8b 15 df e1 76 7e <65> 8b 05 e0 e1=
 76 7e a9 00 01 ff 00 74 0f f6 c4 01 74 59 8b 82 14
> RSP: 0018:ffffc90000b37908 EFLAGS: 00000202
> RAX: 0000000000000001 RBX: ffff8880b9544380 RCX: ffffffff8180f38b
> RDX: ffff8880192f0000 RSI: 0000000000000000 RDI: 0000000000000005
> RBP: 0000000000000003 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000006 R12: ffffed10172a8871
> R13: 0000000000000001 R14: ffff8880b9544388 R15: ffff8880b943f840
> FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055e176bb4000 CR3: 000000000d57a000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <IRQ>
>  </IRQ>
>  <TASK>
>  csd_lock_wait kernel/smp.c:311 [inline]
>  smp_call_function_many_cond+0x50b/0x1590 kernel/smp.c:855
>  on_each_cpu_cond_mask+0x40/0x90 kernel/smp.c:1023
>  on_each_cpu include/linux/smp.h:71 [inline]
>  text_poke_sync arch/x86/kernel/alternative.c:2086 [inline]
>  text_poke_bp_batch+0x22b/0x760 arch/x86/kernel/alternative.c:2296
>  text_poke_flush arch/x86/kernel/alternative.c:2487 [inline]
>  text_poke_flush arch/x86/kernel/alternative.c:2484 [inline]
>  text_poke_finish+0x30/0x40 arch/x86/kernel/alternative.c:2494
>  arch_jump_label_transform_apply+0x1c/0x30 arch/x86/kernel/jump_label.c:1=
46
>  jump_label_update+0x1d7/0x400 kernel/jump_label.c:829
>  static_key_enable_cpuslocked+0x1b7/0x270 kernel/jump_label.c:205
>  static_key_enable+0x1a/0x20 kernel/jump_label.c:218
>  toggle_allocation_gate mm/kfence/core.c:826 [inline]
>  toggle_allocation_gate+0xf8/0x250 mm/kfence/core.c:818
>  process_one_work+0x9a9/0x1a60 kernel/workqueue.c:3254
>  process_scheduled_works kernel/workqueue.c:3335 [inline]
>  worker_thread+0x6c8/0xf70 kernel/workqueue.c:3416
>  kthread+0x2c1/0x3a0 kernel/kthread.c:388
>  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
>  </TASK>
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



--=20
paul-moore.com

