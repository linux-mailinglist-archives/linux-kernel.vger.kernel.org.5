Return-Path: <linux-kernel+bounces-31063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF2D832838
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 11:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EC991F218FF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349754C3CD;
	Fri, 19 Jan 2024 10:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zgccc3lJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637B237140;
	Fri, 19 Jan 2024 10:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705661604; cv=none; b=jg/cBa9tIW3MUI9MsQXJiNNRyE76/wNxNGmfOHpAz5z1NIZe3Woai8KSan12/dFiK48ipxTGXq1C91cm5jQTh5B3IWYBJx32N8ryt9k2eFIj5eF0cY62Vkwux4QkQSJ+71kkLZZ6lRcPYGPj3ihGqxU7c0Aa9ISvC7K6LXQ4TM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705661604; c=relaxed/simple;
	bh=Mxlek2OcZc5MOxfxdA6PCxCO13PphNkAbiyjwjOP3n4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4LQQQdGwOH3u101eRLPGS3X8C0j7pzj1wN6EuCJ98EDXuNmIXG3hijy1W/JOSqQF22vNjHCg3002EhQ6KQlJbMGzqMqRaUiY6F52kslNnjR+NiNNqbXrVhGrgkPHA0aIWEL2r0MCRC8Vy0dB6cQMsWJeEM0mhj6pH+aEwMCQSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zgccc3lJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC28C433F1;
	Fri, 19 Jan 2024 10:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705661603;
	bh=Mxlek2OcZc5MOxfxdA6PCxCO13PphNkAbiyjwjOP3n4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Zgccc3lJJoTASngAWnHQZtNX0yxhbJXzxkKeqOV6fOANxe/S/Cs1XsUHaq1TdR+by
	 I+tMS/bYViVVAnBrSstu+XCL9uhuuWIk57ifydnss08BhMxcJTFmfVZBl/i+ajSdoc
	 oFvHikGHs3rblgvT+aB/h/qTOao48Bc4ORnsqWdzSal1+hHR8VAUDAHquJAKEBRQDw
	 PBd0yR/jg4KXynaQcXIz37Ot+koc4z5g1BPIz6ccfw4NBGKY8jHFLpagb/HwwCNp0p
	 /Hwk+o6zAjVmoORm4VOk873P/BGIovG6PqbzW1f9LI2m1lhlyVtSdn3ItY0qYugxmw
	 iAtaeKs8iczOg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6B747CE114A; Fri, 19 Jan 2024 02:53:23 -0800 (PST)
Date: Fri, 19 Jan 2024 02:53:23 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Chen Zhongjin <chenzhongjin@huawei.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, yangjihong1@huawei.com,
	naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
	davem@davemloft.net, mhiramat@kernel.org, akpm@linux-foundation.org,
	tglx@linutronix.de, peterz@infradead.org, pmladek@suse.com,
	dianders@chromium.org, npiggin@gmail.com, mpe@ellerman.id.au,
	jkl820.git@gmail.com, juerg.haefliger@canonical.com,
	rick.p.edgecombe@intel.com, eric.devolder@oracle.com,
	mic@digikod.net
Subject: Re: [PATCH v2] kprobes: Use synchronize_rcu_tasks_rude in
 kprobe_optimizer
Message-ID: <6d405c7c-2ad1-499a-b609-a7fbf34a8f5e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240118021842.290665-1-chenzhongjin@huawei.com>
 <20240117212646.5f0ddf0c@gandalf.local.home>
 <47e87ff3-2925-4671-89a6-067f36f25d19@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47e87ff3-2925-4671-89a6-067f36f25d19@paulmck-laptop>

On Thu, Jan 18, 2024 at 06:44:54AM -0800, Paul E. McKenney wrote:
> On Wed, Jan 17, 2024 at 09:26:46PM -0500, Steven Rostedt wrote:
> > On Thu, 18 Jan 2024 02:18:42 +0000
> > Chen Zhongjin <chenzhongjin@huawei.com> wrote:
> > 
> > > There is a deadlock scenario in kprobe_optimizer():
> > > 
> > > pid A				pid B			pid C
> > > kprobe_optimizer()		do_exit()		perf_kprobe_init()
> > > mutex_lock(&kprobe_mutex)	exit_tasks_rcu_start()	mutex_lock(&kprobe_mutex)
> > > synchronize_rcu_tasks()		zap_pid_ns_processes()	// waiting kprobe_mutex
> > > // waiting tasks_rcu_exit_srcu	kernel_wait4()
> > > 				// waiting pid C exit
> > > 
> > > To avoid this deadlock loop, use synchronize_rcu_tasks_rude() in kprobe_optimizer()
> > > rather than synchronize_rcu_tasks(). synchronize_rcu_tasks_rude() can also promise
> > > that all preempted tasks have scheduled, but it will not wait tasks_rcu_exit_srcu.
> > > 
> > 
> > Did lockdep detect this? If not, we should fix that.
> > 
> > I'm also thinking if we should find another solution, as this seems more of
> > a work around than a fix.
> 
> My suggestion is at 526b12e4-4bb0-47b1-bece-66b47bfc0a92@paulmck-laptop.
> 
> Better suggestions are of course welcome.  ;-)
> 
> > > Fixes: a30b85df7d59 ("kprobes: Use synchronize_rcu_tasks() for optprobe with CONFIG_PREEMPT=y")
> > > Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
> > > ---
> > > v1 -> v2: Add Fixes tag
> > > ---
> > >  arch/Kconfig     | 2 +-
> > >  kernel/kprobes.c | 2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/Kconfig b/arch/Kconfig
> > > index f4b210ab0612..dc6a18854017 100644
> > > --- a/arch/Kconfig
> > > +++ b/arch/Kconfig
> > > @@ -104,7 +104,7 @@ config STATIC_CALL_SELFTEST
> > >  config OPTPROBES
> > >  	def_bool y
> > >  	depends on KPROBES && HAVE_OPTPROBES
> > > -	select TASKS_RCU if PREEMPTION
> > > +	select TASKS_RUDE_RCU
> > 
> > Is this still a bug if PREEMPTION is not enabled?
> 
> Both "select" clauses would be needed for this patch, if I understand
> correctly.
> 
> 							Thanx, Paul
> 
> > -- Steve
> > 
> > >  
> > >  config KPROBES_ON_FTRACE
> > >  	def_bool y
> > > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > > index d5a0ee40bf66..09056ae50c58 100644
> > > --- a/kernel/kprobes.c
> > > +++ b/kernel/kprobes.c
> > > @@ -623,7 +623,7 @@ static void kprobe_optimizer(struct work_struct *work)
> > >  	 * Note that on non-preemptive kernel, this is transparently converted
> > >  	 * to synchronoze_sched() to wait for all interrupts to have completed.
> > >  	 */
> > > -	synchronize_rcu_tasks();
> > > +	synchronize_rcu_tasks_rude();

The full comment reads as follows:

	/*
	 * Step 2: Wait for quiesence period to ensure all potentially
	 * preempted tasks to have normally scheduled. Because optprobe
	 * may modify multiple instructions, there is a chance that Nth
	 * instruction is preempted. In that case, such tasks can return
	 * to 2nd-Nth byte of jump instruction. This wait is for avoiding it.
	 * Note that on non-preemptive kernel, this is transparently converted
	 * to synchronoze_sched() to wait for all interrupts to have completed.
	 */

Except that synchronize_rcu_tasks_rude() isn't going to wait for any
preempted tasks.  It instead waits only for regions of code that have
disabled preemption (or interrrupts or ...).  So either the above comment
is wrong and needs to be fixed, or this change breaks kprobes.  Last
I knew, the comment was correct.

So I still like the idea of using non-preemptability to wait for tasks
near the end of do_exit(), but unless I am missing something, this patch
as written is inserting a rare but real bug.

Steve,thoughts?

							Thanx, Paul

> > >  	/* Step 3: Optimize kprobes after quiesence period */
> > >  	do_optimize_kprobes();
> > 

