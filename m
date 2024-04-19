Return-Path: <linux-kernel+bounces-151088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 829D18AA8EB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 187DE1F22881
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 07:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6033E494;
	Fri, 19 Apr 2024 07:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5f2ubKi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D682F5A
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 07:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713510725; cv=none; b=rvuoELoT0+RtxOl9uuRoDOVJBN7hH7G4znrBZdgNX2AbxJK0r/n3DAIDED8LrWCOdDW3UCohyAOxZk6um0yItR0+6GglbCJ7+F988VnTjsMrWzpjZ2ey2isQcB00z+G4H8SNaXqMORUbvyEXnc1hr3E+CVY3/4v4kGQb/MRvlJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713510725; c=relaxed/simple;
	bh=vZGVwDLxL47r3oyR1gF3iVLdSKh7EUd7uTdkvh1tgSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oucUhHGHzEMjlS69CgV9fpN6mXuJgXW4CzCJulhNeSaJbj3GUW7hnOVWF2v9RWIR7Zks5M+K2tYgP0l6WObUL6Ukn5PIq6MUHbJ2Qfm+lAe5NK6+0ksLxq8DaLwtn5tAPnUfs8sfqWQj22PiY3FqrcUKta2PJxzOMWXTOndQ9IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5f2ubKi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C231C072AA;
	Fri, 19 Apr 2024 07:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713510724;
	bh=vZGVwDLxL47r3oyR1gF3iVLdSKh7EUd7uTdkvh1tgSA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=b5f2ubKir+tBkP1Ksmzanm6+73tEOaj+kKMiiDztzkrfJb6jRv8lUby6M71bSuwMl
	 ofVe8JGJF9/w1/qpZnBMtG6Fxmot7jGCn49Q1dpFo9xxIH11nm/FXjKSTy7FN2QK6k
	 EK/DcJleHhamf0iBkTVmjcpC/FCRD35n7vJqdoqPKQY5ElFfccPV344bFU3scn+Lca
	 okP7BV6dcirIwalyjZsmetk9uuqADRli7mGoVhUqNVyUbGsa87ROA/HhQWvE6Z5OZF
	 g8eN8XPDEWJqA5dzcUp6xAA4cMGxCHWezzfVN07KOKzRCYg7RffhQ2BgKzCTBXwHPX
	 18P6TPXG8KMqg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BE845CE077D; Fri, 19 Apr 2024 00:12:00 -0700 (PDT)
Date: Fri, 19 Apr 2024 00:12:00 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Z qiang <qiang.zhang1211@gmail.com>
Cc: syzbot <syzbot+dce04ed6d1438ad69656@syzkaller.appspotmail.com>,
	linux-kernel@vger.kernel.org, peterz@infradead.org,
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Subject: Re: [syzbot] [kernel?] WARNING: suspicious RCU usage in __do_softirq
Message-ID: <9e12bfe8-a3c2-47b2-8a3f-5b61b0bd5c08@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <000000000000b24903061520f3e9@google.com>
 <CALm+0cWx1kYtftE4nj7Jjgx2_bmNmSrBAgd36ksSvxJtNVhxHg@mail.gmail.com>
 <CALm+0cWRC1kqLJvmEqda4O97PZ-n0R0UQ35=fi6oA3rLsPoUSQ@mail.gmail.com>
 <8f281a10-b85a-4586-9586-5bbc12dc784f@paulmck-laptop>
 <CALm+0cWN0+cCsYddBUefya3aUw9c9Xn89GVV=Ys1_UPjS19WrQ@mail.gmail.com>
 <4c09abb6-4f6e-42d7-9944-c5da995649cb@paulmck-laptop>
 <CALm+0cVaLfE2ieK9aqh9yHkPDyO7zWbMe9K6WjTUgm4t9SnSFQ@mail.gmail.com>
 <ac7bf2c3-c752-46db-a5c8-0c55a1af8561@paulmck-laptop>
 <CALm+0cXGBPWxiNOkAoQG4hdnKCeVVR-APbfBPk9OGeU2RW+bKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALm+0cXGBPWxiNOkAoQG4hdnKCeVVR-APbfBPk9OGeU2RW+bKA@mail.gmail.com>

On Fri, Apr 19, 2024 at 01:50:02PM +0800, Z qiang wrote:
> >
> > On Thu, Apr 18, 2024 at 05:49:38PM +0800, Z qiang wrote:
> > > >
> > > > On Wed, Apr 17, 2024 at 10:25:01AM +0800, Z qiang wrote:
> > > > > >
> > > > > > On Tue, Apr 16, 2024 at 04:44:54PM +0800, Z qiang wrote:
> > > > > > > On Tue, Apr 16, 2024 at 4:10 PM Z qiang <qiang.zhang1211@gmail.com> wrote:
> > > > > > > >
> > > > > > > > Cc: Paul
> > > > > > > > >
> > > > > > > > > Hello,
> > > > > > > > >
> > > > > > > > > syzbot found the following issue on:
> > > > > > > > >
> > > > > > > > > HEAD commit:    c0b832517f62 Add linux-next specific files for 20240402
> > > > > > > > > git tree:       linux-next
> > > > > > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=15f64776180000
> > > > > > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=afcaf46d374cec8c
> > > > > > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=dce04ed6d1438ad69656
> > > > > > > > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > > > > > > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10f00471180000
> > > > > > > > >
> > > > > > > > > Downloadable assets:
> > > > > > > > > disk image: https://storage.googleapis.com/syzbot-assets/0d36ec76edc7/disk-c0b83251.raw.xz
> > > > > > > > > vmlinux: https://storage.googleapis.com/syzbot-assets/6f9bb4e37dd0/vmlinux-c0b83251.xz
> > > > > > > > > kernel image: https://storage.googleapis.com/syzbot-assets/2349287b14b7/bzImage-c0b83251.xz
> > > > > > > > >
> > > > > > > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > > > > > > Reported-by: syzbot+dce04ed6d1438ad69656@syzkaller.appspotmail.com
> > > > > > > > >
> > > > > > > > > =============================
> > > > > > > > > WARNING: suspicious RCU usage
> > > > > > > > > 6.9.0-rc2-next-20240402-syzkaller #0 Not tainted
> > > > > > > > > -----------------------------
> > > > > > > > > kernel/rcu/tree.c:276 Illegal rcu_softirq_qs() in RCU read-side critical section!
> > > > > > > > >
> > > > > > > > > other info that might help us debug this:
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > rcu_scheduler_active = 2, debug_locks = 1
> > > > > > > > > 1 lock held by ksoftirqd/0/16:
> > > > > > > > >  #0: ffffffff8e334d20 (rcu_read_lock_sched){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
> > > > > > > > >  #0: ffffffff8e334d20 (rcu_read_lock_sched){....}-{1:2}, at: rcu_read_lock_sched include/linux/rcupdate.h:933 [inline]
> > > > > > > > >  #0: ffffffff8e334d20 (rcu_read_lock_sched){....}-{1:2}, at: pfn_valid include/linux/mmzone.h:2019 [inline]
> > > > > > > > >  #0: ffffffff8e334d20 (rcu_read_lock_sched){....}-{1:2}, at: __virt_addr_valid+0x183/0x520 arch/x86/mm/physaddr.c:65
> > > > > > > > >
> > > > > > > > > stack backtrace:
> > > > > > > > > CPU: 0 PID: 16 Comm: ksoftirqd/0 Not tainted 6.9.0-rc2-next-20240402-syzkaller #0
> > > > > > > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
> > > > > > > > > Call Trace:
> > > > > > > > >  <IRQ>
> > > > > > > > >  __dump_stack lib/dump_stack.c:88 [inline]
> > > > > > > > >  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
> > > > > > > > >  lockdep_rcu_suspicious+0x221/0x340 kernel/locking/lockdep.c:6712
> > > > > > > > >  rcu_softirq_qs+0xd9/0x370 kernel/rcu/tree.c:273
> > > > > > > > >  __do_softirq+0x5fd/0x980 kernel/softirq.c:568
> > > > > >
> > > > > > Huh.  This statement is supposed to prevent this call to __do_softirq()
> > > > > > from interrupt exit::
> > > > > >
> > > > > >         if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
> > > > > >             __this_cpu_read(ksoftirqd) == current)
> > > > > >
> > > > > > So was the ksoftirqd kthread interrupted at a point where it happens to
> > > > > > have softirq enabled?
> > > > >
> > > > > It should look like this:
> > > > > schedule()
> > > > > switch_to ksoftirqd/0
> > > > > finish_task_switch
> > > >
> > > > So this CPU's ksoftirqd task is running.
> > > >
> > > > > ->put_task_struct_rcu_user
> > > > >    ->call_rcu(&task->rcu, delayed_put_task_struct)
> > > > >       ->__kasan_record_aux_stack
> > > > >          ->pfn_valid
> > > > >             ->rcu_read_lock_sched
> > > > >                 <interrupt>
> > > > >                  __irq_exit_rcu
> > > > >                  ->__do_softirq
> > > > >                     -> if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
> > > > >                              __this_cpu_read(ksoftirqd) == current)
> > > >
> > > > But we are also running __do_softirq() from return from interrupt.  While
> > > > running in this mode, we are not supposed to invoke rcu_softirq_qs().
> > > > But the "__this_cpu_read(ksoftirqd) == current" check yields "true",
> > > > so we do call rcu_softirq_qs() anyway.  That is a bug.
> > > >
> > > > We need to upgrade or replace that check to something that returns true
> > > > only if called at process level from ksoftirqd.
> > > >
> > > > Any thoughts on a good way to do that?  For example, would adding "&&
> > > > in_task()" do the trick, or are there other unfortunate corner cases?
> > >
> > > The rcu_softirq_qs() is invoked in softirq_handle_begin/end() critical section,
> > > in softirqd/0 task context,  the "in_task()" should return false, will miss
> > > qs report in softirqd/0 task context.
> > >
> > > diff --git a/kernel/softirq.c b/kernel/softirq.c
> > > index b315b21fb28c..9b8f0c0f7675 100644
> > > --- a/kernel/softirq.c
> > > +++ b/kernel/softirq.c
> > > @@ -563,10 +563,6 @@ asmlinkage __visible void __softirq_entry
> > > __do_softirq(void)
> > >                 pending >>= softirq_bit;
> > >         }
> > >
> > > -       if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
> > > -           __this_cpu_read(ksoftirqd) == current)
> > > -               rcu_softirq_qs();
> > > -
> > >         local_irq_disable();
> > >
> > >         pending = local_softirq_pending();
> > > @@ -915,6 +911,8 @@ static int ksoftirqd_should_run(unsigned int cpu)
> > >
> > >  static void run_ksoftirqd(unsigned int cpu)
> > >  {
> > > +       unsigned long last_qs = jiffies;
> > > +
> > >         ksoftirqd_run_begin();
> > >         if (local_softirq_pending()) {
> > >                 /*
> > > @@ -923,6 +921,7 @@ static void run_ksoftirqd(unsigned int cpu)
> > >                  */
> > >                 __do_softirq();
> > >                 ksoftirqd_run_end();
> > > +               rcu_softirq_qs_periodic(last_qs);
> >
> > Unfortunately, we need the quiescent state to be within __do_softirq().
> >
> > >                 cond_resched();
> > >                 return;
> > >         }
> > >
> > > Any thoughts?
> >
> > Can we mask the return value from preempt_count(), for example, as shown
> > in the CONFIG_PREEMPTION=n version of rcu_flavor_sched_clock_irq()?
> >
> > The trick is that we should be able to ignore SOFTIRQ_MASK because
> > __do_softirq() should not be invoked when softirqs are disabled.
> > Emphasis on "should".  ;-)
> 
> 
> 
> Does it mean this?
> 
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index b315b21fb28c..315b717ec944 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -517,6 +517,8 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
>         bool in_hardirq;
>         __u32 pending;
>         int softirq_bit;
> +       bool preempt_enabled = (IS_ENABLED(CONFIG_PREEMPT_COUNT) &&
> +                                       !(preempt_count() & PREEMPT_MASK));
> 
>         /*
>          * Mask out PF_MEMALLOC as the current task context is borrowed for the
> @@ -564,7 +566,8 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
>         }
> 
>         if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
> -           __this_cpu_read(ksoftirqd) == current)
> +           __this_cpu_read(ksoftirqd) == current &&
> +           preempt_enabled && !rcu_preempt_depth())
>                 rcu_softirq_qs();
> 
>         local_irq_disable();
> 
> For built with CONFIG_PREEMPTION=n and CONFIG_COUNT=n kernels,
> the preempt_enabled is always  false.

Assuming that this works, it is preferred over the next one.

							Thanx, Paul

> or how about this?
> 
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index b315b21fb28c..80b9fb4ee562 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -66,6 +66,8 @@ const char * const softirq_to_name[NR_SOFTIRQS] = {
>         "TASKLET", "SCHED", "HRTIMER", "RCU"
>  };
> 
> +static DEFINE_PER_CPU(bool, ksoftirqd_work);
> +
>  /*
>   * we cannot loop indefinitely here to avoid userspace starvation,
>   * but we also don't want to introduce a worst case 1/HZ latency
> @@ -404,10 +406,12 @@ static inline void softirq_handle_end(void)
>  static inline void ksoftirqd_run_begin(void)
>  {
>         local_irq_disable();
> +       per_cpu(ksoftirqd_work, smp_processor_id()) = true;
>  }
> 
>  static inline void ksoftirqd_run_end(void)
>  {
> +       per_cpu(ksoftirqd_work, smp_processor_id()) = false;
>         local_irq_enable();
>  }
> 
> @@ -564,7 +568,7 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
>         }
> 
>         if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
> -           __this_cpu_read(ksoftirqd) == current)
> +           __this_cpu_read(ksoftirqd) == current && ksoftirqd_work)
>                 rcu_softirq_qs();
> 
>         local_irq_disable();
> @@ -970,6 +974,10 @@ static struct smp_hotplug_thread softirq_threads = {
> 
>  static __init int spawn_ksoftirqd(void)
>  {
> +       int cpu;
> +
> +       for_each_possible_cpu(cpu)
> +               per_cpu(ksoftirqd_work, cpu) = false;
>         cpuhp_setup_state_nocalls(CPUHP_SOFTIRQ_DEAD, "softirq:dead", NULL,
>                                   takeover_tasklets);
>         BUG_ON(smpboot_register_percpu_thread(&softirq_threads));
> 
> 
> Thanks
> Zqiang
> 
> 
> 
> >
> >                                                         Thanx, Paul
> >
> > > Thanks
> > > Zqiang
> > >
> > >
> > > >
> > > > (And good job tracking this down, by the way!)
> > > >
> > > >                                                         Thanx, Paul
> > > >
> > > > >                               rcu_softirq_qs
> > > > >                                ->
> > > > > RCU_LOCKDEP_WARN(lock_is_held(&rcu_sched_lock_map))
> > > > >
> > > > > Thanks
> > > > > Zqiang
> > > > >
> > > > >
> > > > > >
> > > > > >                                                         Thanx, Paul
> > > > > >
> > > > > > > > >  invoke_softirq kernel/softirq.c:428 [inline]
> > > > > > > > >  __irq_exit_rcu+0xf2/0x1c0 kernel/softirq.c:633
> > > > > > > > >  irq_exit_rcu+0x9/0x30 kernel/softirq.c:645
> > > > > > > > >  instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
> > > > > > > > >  sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
> > > > > > > > >  </IRQ>
> > > > > > > > >  <TASK>
> > > > > > > > >  asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
> > > > > > > > > RIP: 0010:debug_lockdep_rcu_enabled+0xd/0x40 kernel/rcu/update.c:320
> > > > > > > > > Code: f5 90 0f 0b 90 90 90 eb c6 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 31 c0 83 3d c7 0f 28 04 00 <74> 1e 83 3d 26 42 28 04 00 74 15 65 48 8b 0c 25 c0 d3 03 00 31 c0
> > > > > > > > > RSP: 0018:ffffc90000157a50 EFLAGS: 00000202
> > > > > > > > > RAX: 0000000000000000 RBX: 00000000000000a0 RCX: 0000000000000001
> > > > > > > > > RDX: dffffc0000000000 RSI: ffffffff8bcae740 RDI: ffffffff8c1f7ec0
> > > > > > > > > RBP: dffffc0000000000 R08: ffffffff92f3a527 R09: 1ffffffff25e74a4
> > > > > > > > > R10: dffffc0000000000 R11: fffffbfff25e74a5 R12: 0000000029373578
> > > > > > > > > R13: 1ffff9200002af64 R14: ffffffff814220f3 R15: ffff88813fff90a0
> > > > > > > > >  rcu_read_lock_sched include/linux/rcupdate.h:934 [inline]
> > > > > > > > >  pfn_valid include/linux/mmzone.h:2019 [inline]
> > > > > > > > >  __virt_addr_valid+0x1a9/0x520 arch/x86/mm/physaddr.c:65
> > > > > > > > >  kasan_addr_to_slab+0xd/0x80 mm/kasan/common.c:37
> > > > > > > > >  __kasan_record_aux_stack+0x11/0xc0 mm/kasan/generic.c:526
> > > > > > > >
> > > > > > > >
> > > > > > > > This should be caused by the following commit:
> > > > > > > > d818cc76e2b4 ("kasan: Record work creation stack trace with interrupts enabled")
> > > > > > > >
> > > > > > > > Is it possible to make the rcu_softirq_qs() run only in ksoftirqd task?
> > > > > > >
> > > > > > > use rcu_softirq_qs_periodic() in run_ksoftirqd().
> > > > > > >
> > > > > > > >
> > > > > > > > Thanks
> > > > > > > > Zqiang
> > > > > > > >
> > > > > > > > >  __call_rcu_common kernel/rcu/tree.c:3096 [inline]
> > > > > > > > >  call_rcu+0x167/0xa70 kernel/rcu/tree.c:3200
> > > > > > > > >  context_switch kernel/sched/core.c:5412 [inline]
> > > > > > > > >  __schedule+0x17f0/0x4a50 kernel/sched/core.c:6746
> > > > > > > > >  __schedule_loop kernel/sched/core.c:6823 [inline]
> > > > > > > > >  schedule+0x14b/0x320 kernel/sched/core.c:6838
> > > > > > > > >  smpboot_thread_fn+0x61e/0xa30 kernel/smpboot.c:160
> > > > > > > > >  kthread+0x2f0/0x390 kernel/kthread.c:388
> > > > > > > > >  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
> > > > > > > > >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
> > > > > > > > >  </TASK>
> > > > > > > > > ----------------
> > > > > > > > > Code disassembly (best guess):
> > > > > > > > >    0:   f5                      cmc
> > > > > > > > >    1:   90                      nop
> > > > > > > > >    2:   0f 0b                   ud2
> > > > > > > > >    4:   90                      nop
> > > > > > > > >    5:   90                      nop
> > > > > > > > >    6:   90                      nop
> > > > > > > > >    7:   eb c6                   jmp    0xffffffcf
> > > > > > > > >    9:   0f 1f 40 00             nopl   0x0(%rax)
> > > > > > > > >    d:   90                      nop
> > > > > > > > >    e:   90                      nop
> > > > > > > > >    f:   90                      nop
> > > > > > > > >   10:   90                      nop
> > > > > > > > >   11:   90                      nop
> > > > > > > > >   12:   90                      nop
> > > > > > > > >   13:   90                      nop
> > > > > > > > >   14:   90                      nop
> > > > > > > > >   15:   90                      nop
> > > > > > > > >   16:   90                      nop
> > > > > > > > >   17:   90                      nop
> > > > > > > > >   18:   90                      nop
> > > > > > > > >   19:   90                      nop
> > > > > > > > >   1a:   90                      nop
> > > > > > > > >   1b:   90                      nop
> > > > > > > > >   1c:   90                      nop
> > > > > > > > >   1d:   f3 0f 1e fa             endbr64
> > > > > > > > >   21:   31 c0                   xor    %eax,%eax
> > > > > > > > >   23:   83 3d c7 0f 28 04 00    cmpl   $0x0,0x4280fc7(%rip)        # 0x4280ff1
> > > > > > > > > * 2a:   74 1e                   je     0x4a <-- trapping instruction
> > > > > > > > >   2c:   83 3d 26 42 28 04 00    cmpl   $0x0,0x4284226(%rip)        # 0x4284259
> > > > > > > > >   33:   74 15                   je     0x4a
> > > > > > > > >   35:   65 48 8b 0c 25 c0 d3    mov    %gs:0x3d3c0,%rcx
> > > > > > > > >   3c:   03 00
> > > > > > > > >   3e:   31 c0                   xor    %eax,%eax
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > ---
> > > > > > > > > This report is generated by a bot. It may contain errors.
> > > > > > > > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > > > > > > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > > > > > > > >
> > > > > > > > > syzbot will keep track of this issue. See:
> > > > > > > > > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > > > > > > > >
> > > > > > > > > If the report is already addressed, let syzbot know by replying with:
> > > > > > > > > #syz fix: exact-commit-title
> > > > > > > > >
> > > > > > > > > If you want syzbot to run the reproducer, reply with:
> > > > > > > > > #syz test: git://repo/address.git branch-or-commit-hash
> > > > > > > > > If you attach or paste a git patch, syzbot will apply it before testing.
> > > > > > > > >
> > > > > > > > > If you want to overwrite report's subsystems, reply with:
> > > > > > > > > #syz set subsystems: new-subsystem
> > > > > > > > > (See the list of subsystem names on the web dashboard)
> > > > > > > > >
> > > > > > > > > If the report is a duplicate of another one, reply with:
> > > > > > > > > #syz dup: exact-subject-of-another-report
> > > > > > > > >
> > > > > > > > > If you want to undo deduplication, reply with:
> > > > > > > > > #syz undup
> > > > > > > > >

