Return-Path: <linux-kernel+bounces-123101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FF289022D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0DC81F272F0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25A912DD92;
	Thu, 28 Mar 2024 14:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fffhrml+"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBC5651AE
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 14:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711637073; cv=none; b=GaENyTBpb/u082CoLsCqCjORh/LmzH+AJOad4fN98GDj+nKaoeBFDYIyugQbStvQnlXxiX9GIhKc+149XFNY/7C6Al8sLulHVBLnL4GPTCbUWpUqBPhEOKT3SumrFjOuQ/Ofru2H1js+WILWAA3PGv2iNb3py4DicV6eYWTnr8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711637073; c=relaxed/simple;
	bh=LEprU2jPM8ksUYabsyoi8PYiiIPWjhL+SWahKNMHrBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWawIHU2ogoqDIx94Lcn9OgK7sjSsizxPfM6gTgXxOGTGPlq6HSaeoMoep8Q8EgDjbQwAl+/UqHBXhPH5RvHdzw5PoKtt73N445n/35FdUqBltP5/6WTAd429Fyf288ANi5kDuQtJhXVW8GvsDdl4THxV9sJZQiniKBq+1KoqrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fffhrml+; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-566e869f631so1174447a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 07:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1711637069; x=1712241869; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=r7ylXFiKHIksB42ti3MSS3aIQj+rujgRhh3qImPjKuE=;
        b=fffhrml+/HzI3725AnaT94MdwmCUGhOAm/impBNA29jGlDrWmdHvv+az0FK0TWEjWd
         HZ3pepNj1lcFdh3f4O5Yzuq6A6NoxWCKX1YZzNPOlykrSHwjsGXdUKIhlcmGZWgLiJ2Q
         4cQXInVRBKJann6JXJgSFr3z5fJ1/bYSR19+jPgNNqvDbqe3GOjB0Ui8ir9ffuyuSBP0
         GVDQXWoHBcZqY3jPFtGFzWpHAdnb5RIgV+9tghrRjSTgpg+3ePLaN8mqyvU//+edTogK
         rxXkPaFhKrOJLVhDsbzfl0dJTr0sfgP/cGBV1uS4BXn29B9QTL1nrRfx1WUk8fSjxki5
         vheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711637069; x=1712241869;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r7ylXFiKHIksB42ti3MSS3aIQj+rujgRhh3qImPjKuE=;
        b=Iwy0okJ81Jt/rsmWwNPE36H9rHybmDdBEQ7+M8Y9PGDKldoJ1GIZ5QB/a9gj6d8usE
         B1WQg9cnA3j5zFuikJlY8SukPxHyS1YkDIbqKMbXXPavlbkNgX6T9mDeNQMqejFujNYP
         s3Cw7hWxfXG1WioS0oZJef0MqzS50pWUm30byctkHXibDRyLEbkW5+h0cbnkMpNLNbbJ
         EtYrRMO6ZDhXjPOnaTipxnZjymxtjzu/7G4yNdhJ4Ol1GkjnmYOkG+Yxo/kPYk5Q8qJN
         vkhWlfZ7d1SFKwrrDpmvWIU2SChfziduUE7Ct8/e5nQl8tSJOc3NqdIk1qpikLkbYHb5
         YCbg==
X-Forwarded-Encrypted: i=1; AJvYcCWrN5In7zI1SgOERNKBQ7uiatiTyuHOOwUKVYfxNJPflZtG0Dc76CmONv4iTfuc2MVCD1oEs6EJsoDdxYvOEeKhhCymVfs5a2UysDUr
X-Gm-Message-State: AOJu0YxEJWkzOeXhkcMIM81iXRvugtS6qPHia6+jxlnICvZHadvNGI5z
	ZO77gdwXZezhOtHhrNm6c3OLtruyGaMeBChfcgswdhDO6WldTO1UtKsdQj5EFTg=
X-Google-Smtp-Source: AGHT+IGuD1iTcuof/WR3530eNCYMuUTYORbLADr99qWkpkrQjIRYslbg6z+8tarJA+KHntZeNlt4Og==
X-Received: by 2002:a50:cc89:0:b0:56b:863c:2c92 with SMTP id q9-20020a50cc89000000b0056b863c2c92mr2715627edi.34.1711637069221;
        Thu, 28 Mar 2024 07:44:29 -0700 (PDT)
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id l13-20020a056402028d00b0056bfa6ad5eesm892876edv.91.2024.03.28.07.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 07:44:28 -0700 (PDT)
Date: Thu, 28 Mar 2024 15:44:27 +0100
From: Petr Mladek <pmladek@suse.com>
To: Paul Moore <paul@paul-moore.com>
Cc: syzbot <syzbot+81f5ca46b043d4a1b789@syzkaller.appspotmail.com>,
	andrii@kernel.org, ast@kernel.org, audit@vger.kernel.org,
	bpf@vger.kernel.org, daniel@iogearbox.net, eparis@redhat.com,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	john.ogness@linutronix.de,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [syzbot] [audit?] [bpf?] INFO: rcu detected stall in
 kauditd_thread (4)
Message-ID: <ZgVvN5DmLLMaAg_S@alley>
References: <000000000000d929dd0614a8ba8c@google.com>
 <CAHC9VhTWk8j2OnnH+307UzH+A4tLAmcyw7xde3KboZJ0JE2hzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhTWk8j2OnnH+307UzH+A4tLAmcyw7xde3KboZJ0JE2hzw@mail.gmail.com>

On Wed 2024-03-27 15:16:25, Paul Moore wrote:
> On Wed, Mar 27, 2024 at 2:39 PM syzbot
> <syzbot+81f5ca46b043d4a1b789@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=121a9e21180000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=aef2a55903e5791c
> > dashboard link: https://syzkaller.appspot.com/bug?extid=81f5ca46b043d4a1b789
> > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12104f9e180000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=112840ee180000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/089e25869df5/disk-fe46a7dd.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/423b1787914f/vmlinux-fe46a7dd.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/4c043e30c07d/bzImage-fe46a7dd.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+81f5ca46b043d4a1b789@syzkaller.appspotmail.com
> 
> This doesn't look to be audit related, but I do see something that may
> be related in the printk code which was just merged into Linus' tree:
> 
>   commit 8076972468584d4a21dab9aa50e388b3ea9ad8c7
>   Author: John Ogness <john.ogness@linutronix.de>
>   Date:   Mon Feb 26 13:07:24 2024 +0106
> 
>    printk: Update @console_may_schedule in console_trylock_spinning()
> 
>    console_trylock_spinning() may takeover the console lock from a
>    schedulable context. Update @console_may_schedule to make sure it
>    reflects a trylock acquire.

This change should not introduce any new solflockup. By other words,
if we see a softlockup with this patch then it was possible even before.

conosle_trylock_spinning() does two things:

  1. It call console_trylock(). On success, it has always cleared
     @console_may_schedule.

  2. As a fallback, it tries to take over the cosnole_lock() from
     the current owner. On success, it should clear
     @console_may_schedule like the plain console_trylock().

     This code path has an effect only when another CPU is just
     emitting messages on the console (calling con->write()).
     It might happen only when there is a flood of messages.

The bug was that conosle_trylock_spinning() did not clear
@console_may_schedule in the fallback path.

Note that conosle_trylock_spinning() must always clear
@console_may_schedule. It is used only in printk() which might
be called in atomic context.


> > rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> > rcu:    1-...!: (1 ticks this GP) idle=9bf4/1/0x4000000000000000 softirq=6591/6591 fqs=5
> > rcu:    (detected by 0, t=10502 jiffies, g=7873, q=65 ncpus=2)
> > Sending NMI from CPU 0 to CPUs 1:
> > NMI backtrace for cpu 1
> > CPU: 1 PID: 28 Comm: kauditd Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
> > RIP: 0010:write_comp_data+0x0/0x90 kernel/kcov.c:230
> > Code: 48 8b 05 13 e2 76 7e 48 8b 80 08 16 00 00 c3 cc cc cc cc 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <49> 89 d2 49 89 f8 49 89 f1 65 48 8b 15 df e1 76 7e 65 8b 05 e0 e1
> > RSP: 0018:ffffc90000a08d78 EFLAGS: 00000046
> > RAX: 0000000000000001 RBX: 0000000000000001 RCX: ffffffff88e73a44
> > RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000005
> > RBP: 000000000003d3cc R08: 0000000000000005 R09: 0000000000000000
> > R10: 0000000000000001 R11: 0000000000000002 R12: ffff8880b952cac0
> > R13: ffff88802abeb340 R14: ffff88802abeb340 R15: ffffffff88e73220
> > FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000555582f0dca8 CR3: 000000002bcea000 CR4: 00000000003506f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <NMI>
> >  </NMI>
> >  <IRQ>
> >  advance_sched+0x824/0xc60 net/sched/sch_taprio.c:925
> >  __run_hrtimer kernel/time/hrtimer.c:1692 [inline]
> >  __hrtimer_run_queues+0x20c/0xc20 kernel/time/hrtimer.c:1756
> >  hrtimer_interrupt+0x31b/0x800 kernel/time/hrtimer.c:1818
> >  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
> >  __sysvec_apic_timer_interrupt+0x10f/0x410 arch/x86/kernel/apic/apic.c:1049
> >  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
> >  sysvec_apic_timer_interrupt+0x90/0xb0 arch/x86/kernel/apic/apic.c:1043

I wonder what this timer does and if it might get stuck and cause
the lockup.

> >  </IRQ>
> >  <TASK>
> >  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
> > RIP: 0010:console_flush_all+0xa19/0xd70 kernel/printk/printk.c:2979
> > Code: e8 9c dd 25 00 9c 5b 81 e3 00 02 00 00 31 ff 48 89 de e8 0a c9 1e 00 48 85 db 0f 85 8b 01 00 00 e8 ec cd 1e 00 fb 48 8b 04 24 <4c> 89 fa 83 e2 07 0f b6 00 38 d0 7f 08 84 c0 0f 85 a9 02 00 00 41
> > RSP: 0018:ffffc90000a47a98 EFLAGS: 00000293
> > RAX: fffff52000148f7a RBX: 0000000000000000 RCX: ffffffff816e2ab6
> > RDX: ffff888018ee9e00 RSI: ffffffff816e2ac4 RDI: 0000000000000007
> > RBP: dffffc0000000000 R08: 0000000000000007 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000003 R12: 0000000000000200
> > R13: ffffffff8e3995f8 R14: ffffffff8e3995a0 R15: ffffc90000a47bd0
> >  console_unlock+0xae/0x290 kernel/printk/printk.c:3042
> >  vprintk_emit kernel/printk/printk.c:2342 [inline]
> >  vprintk_emit+0x11a/0x5a0 kernel/printk/printk.c:2297
> >  vprintk+0x7f/0xa0 kernel/printk/printk_safe.c:45
> >  _printk+0xc8/0x100 kernel/printk/printk.c:2367
> >  kauditd_printk_skb kernel/audit.c:546 [inline]
> >  kauditd_hold_skb+0x1fb/0x240 kernel/audit.c:581
> >  kauditd_send_queue+0x236/0x290 kernel/audit.c:766
> >  kauditd_thread+0x61e/0xa80 kernel/audit.c:890
> >  kthread+0x2c1/0x3a0 kernel/kthread.c:388
> >  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
> >  </TASK>
> > INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 2.415 msecs
> > rcu: rcu_preempt kthread starved for 10491 jiffies! g7873 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
> > rcu:    Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
> > rcu: RCU grace-period kthread stack dump:
> > task:rcu_preempt     state:R  running task     stack:28304 pid:16    tgid:16    ppid:2      flags:0x00004000
> > Call Trace:
> >  <TASK>
> >  context_switch kernel/sched/core.c:5409 [inline]
> >  __schedule+0xf15/0x5c70 kernel/sched/core.c:6736
> >  __schedule_loop kernel/sched/core.c:6813 [inline]
> >  schedule+0xe7/0x350 kernel/sched/core.c:6828
> >  schedule_timeout+0x136/0x2a0 kernel/time/timer.c:2572
> >  rcu_gp_fqs_loop+0x1eb/0xb00 kernel/rcu/tree.c:1663
> >  rcu_gp_kthread+0x271/0x380 kernel/rcu/tree.c:1862
> >  kthread+0x2c1/0x3a0 kernel/kthread.c:388
> >  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
> >  </TASK>
> > rcu: Stack dump where RCU GP kthread last ran:
> > CPU: 0 PID: 43 Comm: kworker/u8:3 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
> > Workqueue: events_unbound toggle_allocation_gate
> > RIP: 0010:csd_lock_wait kernel/smp.c:311 [inline]
> > RIP: 0010:smp_call_function_many_cond+0x4e7/0x1590 kernel/smp.c:855
> > Code: 0c 00 85 ed 74 4d 48 b8 00 00 00 00 00 fc ff df 4d 89 f4 4c 89 f5 49 c1 ec 03 83 e5 07 49 01 c4 83 c5 03 e8 4b 05 0c 00 f3 90 <41> 0f b6 04 24 40 38 c5 7c 08 84 c0 0f 85 5d 0e 00 00 8b 43 08 31
> > RSP: 0018:ffffc90000b37910 EFLAGS: 00000293
> > RAX: 0000000000000000 RBX: ffff8880b9544380 RCX: ffffffff8180f38b
> > RDX: ffff8880192f0000 RSI: ffffffff8180f365 RDI: 0000000000000005
> > RBP: 0000000000000003 R08: 0000000000000005 R09: 0000000000000000
> > R10: 0000000000000001 R11: 0000000000000006 R12: ffffed10172a8871
> > R13: 0000000000000001 R14: ffff8880b9544388 R15: ffff8880b943f840
> > FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 000055e176bb4000 CR3: 000000000d57a000 CR4: 00000000003506f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <IRQ>
> >  </IRQ>
> >  <TASK>
> >  on_each_cpu_cond_mask+0x40/0x90 kernel/smp.c:1023
> >  on_each_cpu include/linux/smp.h:71 [inline]
> >  text_poke_sync arch/x86/kernel/alternative.c:2086 [inline]

I guess that this wants to run something on each CPU before
it continues. It would block this CPU when the other CPU gets stuck.

> >  text_poke_bp_batch+0x22b/0x760 arch/x86/kernel/alternative.c:2296
> >  text_poke_flush arch/x86/kernel/alternative.c:2487 [inline]
> >  text_poke_flush arch/x86/kernel/alternative.c:2484 [inline]
> >  text_poke_finish+0x30/0x40 arch/x86/kernel/alternative.c:2494
> >  arch_jump_label_transform_apply+0x1c/0x30 arch/x86/kernel/jump_label.c:146
> >  jump_label_update+0x1d7/0x400 kernel/jump_label.c:829
> >  static_key_enable_cpuslocked+0x1b7/0x270 kernel/jump_label.c:205
> >  static_key_enable+0x1a/0x20 kernel/jump_label.c:218
> >  toggle_allocation_gate mm/kfence/core.c:826 [inline]
> >  toggle_allocation_gate+0xf8/0x250 mm/kfence/core.c:818
> >  process_one_work+0x9a9/0x1a60 kernel/workqueue.c:3254
> >  process_scheduled_works kernel/workqueue.c:3335 [inline]
> >  worker_thread+0x6c8/0xf70 kernel/workqueue.c:3416
> >  kthread+0x2c1/0x3a0 kernel/kthread.c:388
> >  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
> >  </TASK>
> > watchdog: BUG: soft lockup - CPU#0 stuck for 246s! [kworker/u8:3:43]

It is interesting that it took 246s. AFAIK, the default watchdog
thresh is much sorter (like 20s). Well, I havn't checked setting
used for this test.

> > Modules linked in:
> > irq event stamp: 519008
> > hardirqs last  enabled at (519007): [<ffffffff8ad251cb>] irqentry_exit+0x3b/0x90 kernel/entry/common.c:351
> > hardirqs last disabled at (519008): [<ffffffff8ad239ae>] sysvec_apic_timer_interrupt+0xe/0xb0 arch/x86/kernel/apic/apic.c:1043
> > softirqs last  enabled at (519006): [<ffffffff8ad63156>] softirq_handle_end kernel/softirq.c:400 [inline]
> > softirqs last  enabled at (519006): [<ffffffff8ad63156>] __do_softirq+0x596/0x8de kernel/softirq.c:583
> > softirqs last disabled at (518991): [<ffffffff8151a149>] invoke_softirq kernel/softirq.c:428 [inline]
> > softirqs last disabled at (518991): [<ffffffff8151a149>] __irq_exit_rcu kernel/softirq.c:633 [inline]
> > softirqs last disabled at (518991): [<ffffffff8151a149>] irq_exit_rcu+0xb9/0x120 kernel/softirq.c:645
> > CPU: 0 PID: 43 Comm: kworker/u8:3 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
> > Workqueue: events_unbound toggle_allocation_gate
> > RIP: 0010:preempt_count arch/x86/include/asm/preempt.h:26 [inline]
> > RIP: 0010:check_kcov_mode kernel/kcov.c:173 [inline]
> > RIP: 0010:write_comp_data+0x11/0x90 kernel/kcov.c:236
> > Code: cc cc 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 49 89 d2 49 89 f8 49 89 f1 65 48 8b 15 df e1 76 7e <65> 8b 05 e0 e1 76 7e a9 00 01 ff 00 74 0f f6 c4 01 74 59 8b 82 14
> > RSP: 0018:ffffc90000b37908 EFLAGS: 00000202
> > RAX: 0000000000000001 RBX: ffff8880b9544380 RCX: ffffffff8180f38b
> > RDX: ffff8880192f0000 RSI: 0000000000000000 RDI: 0000000000000005
> > RBP: 0000000000000003 R08: 0000000000000005 R09: 0000000000000000
> > R10: 0000000000000001 R11: 0000000000000006 R12: ffffed10172a8871
> > R13: 0000000000000001 R14: ffff8880b9544388 R15: ffff8880b943f840
> > FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 000055e176bb4000 CR3: 000000000d57a000 CR4: 00000000003506f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <IRQ>
> >  </IRQ>
> >  <TASK>
> >  csd_lock_wait kernel/smp.c:311 [inline]
> >  smp_call_function_many_cond+0x50b/0x1590 kernel/smp.c:855
> >  on_each_cpu_cond_mask+0x40/0x90 kernel/smp.c:1023
> >  on_each_cpu include/linux/smp.h:71 [inline]

It seems that this is really stuck because it is not able to
run something on the other CPU.

IMHO, the primary problem is in the code proceed by the hrtimer.
Adding networking people into Cc.

Best Regards,
Petr

> >  text_poke_sync arch/x86/kernel/alternative.c:2086 [inline]
> >  text_poke_bp_batch+0x22b/0x760 arch/x86/kernel/alternative.c:2296
> >  text_poke_flush arch/x86/kernel/alternative.c:2487 [inline]
> >  text_poke_flush arch/x86/kernel/alternative.c:2484 [inline]
> >  text_poke_finish+0x30/0x40 arch/x86/kernel/alternative.c:2494
> >  arch_jump_label_transform_apply+0x1c/0x30 arch/x86/kernel/jump_label.c:146
> >  jump_label_update+0x1d7/0x400 kernel/jump_label.c:829
> >  static_key_enable_cpuslocked+0x1b7/0x270 kernel/jump_label.c:205
> >  static_key_enable+0x1a/0x20 kernel/jump_label.c:218
> >  toggle_allocation_gate mm/kfence/core.c:826 [inline]
> >  toggle_allocation_gate+0xf8/0x250 mm/kfence/core.c:818
> >  process_one_work+0x9a9/0x1a60 kernel/workqueue.c:3254
> >  process_scheduled_works kernel/workqueue.c:3335 [inline]
> >  worker_thread+0x6c8/0xf70 kernel/workqueue.c:3416
> >  kthread+0x2c1/0x3a0 kernel/kthread.c:388
> >  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
> >  </TASK>
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >
> > If the report is already addressed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> >
> > If you want syzbot to run the reproducer, reply with:
> > #syz test: git://repo/address.git branch-or-commit-hash
> > If you attach or paste a git patch, syzbot will apply it before testing.
> >
> > If you want to overwrite report's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> >
> > If the report is a duplicate of another one, reply with:
> > #syz dup: exact-subject-of-another-report
> >
> > If you want to undo deduplication, reply with:
> > #syz undup
> 
> 
> 
> -- 
> paul-moore.com

