Return-Path: <linux-kernel+bounces-30219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B2E831BAD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEEC7B21E88
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 14:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EB31DA29;
	Thu, 18 Jan 2024 14:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OmfPqywr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DD2646;
	Thu, 18 Jan 2024 14:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705589095; cv=none; b=XjHO98/vVqsB8VTqXEskc8BXj1r8ygmUkyAlHvnEDMkL+X3Md3paN58zjxBdwRj1PrtCT/vJcJZORsgVCv+Fz++7oCZDs5XzMOlUJTx1icB1U+fXHIdSuUlU6rTI93FLZx5Z8pcRsxQxw1v3BOxrhB0WVcJWutVojKnZchme96k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705589095; c=relaxed/simple;
	bh=FIWDXh4TMq/7lMeI0IsyQDpPlkd6cnqeXUZhP3qX+A4=;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:Reply-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rPkS8VEk9xFotx7xJCr1tDhS6u2xcGdUZOSZv61tiuJS8SaSv0FVB7aCkaAwi14nNTRns9RJhNN0hmW8s1+Ge3gGZCLyMwVvkkbjFDKB6WIIV7YL6Mzu3GDpT891Qk5LuPaq7wrPq/tVuTvohh+fEo6fUOuJAWDcC3HPz+fOJ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OmfPqywr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA55C433C7;
	Thu, 18 Jan 2024 14:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705589094;
	bh=FIWDXh4TMq/7lMeI0IsyQDpPlkd6cnqeXUZhP3qX+A4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=OmfPqywrN5vo9zYO6l/kHSO0GOcSt6zCu+Wvibnqme2XW7kQSLfgRs0oWVczAxoXe
	 d6NWhfOKeQzHtrGjDkmxJlAEDlDzn3aD8aNL9vRJZEm0SjDI+MQR6heyuF2Kv6CW7I
	 773MMllTjQ9wrci5Imq1JsL9U1M5cYXzd6kpocvZLYQDtVCWtxChhMg/+ixVvuyszl
	 kvdhYJNQgYKH9322x923TgetLy3Ir43rUh4POtkDWjS+AUPtvnW4hZb6NEV/nwBkaV
	 tNYjpb78YnDRALYsi4jarc2aLh02j7nV1vdnmHF+qZRk/fceXJFO19DW67eglBw8bc
	 zbcaUrPpDWnew==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 50520CE0546; Thu, 18 Jan 2024 06:44:54 -0800 (PST)
Date: Thu, 18 Jan 2024 06:44:54 -0800
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
Message-ID: <47e87ff3-2925-4671-89a6-067f36f25d19@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240118021842.290665-1-chenzhongjin@huawei.com>
 <20240117212646.5f0ddf0c@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117212646.5f0ddf0c@gandalf.local.home>

On Wed, Jan 17, 2024 at 09:26:46PM -0500, Steven Rostedt wrote:
> On Thu, 18 Jan 2024 02:18:42 +0000
> Chen Zhongjin <chenzhongjin@huawei.com> wrote:
> 
> > There is a deadlock scenario in kprobe_optimizer():
> > 
> > pid A				pid B			pid C
> > kprobe_optimizer()		do_exit()		perf_kprobe_init()
> > mutex_lock(&kprobe_mutex)	exit_tasks_rcu_start()	mutex_lock(&kprobe_mutex)
> > synchronize_rcu_tasks()		zap_pid_ns_processes()	// waiting kprobe_mutex
> > // waiting tasks_rcu_exit_srcu	kernel_wait4()
> > 				// waiting pid C exit
> > 
> > To avoid this deadlock loop, use synchronize_rcu_tasks_rude() in kprobe_optimizer()
> > rather than synchronize_rcu_tasks(). synchronize_rcu_tasks_rude() can also promise
> > that all preempted tasks have scheduled, but it will not wait tasks_rcu_exit_srcu.
> > 
> 
> Did lockdep detect this? If not, we should fix that.
> 
> I'm also thinking if we should find another solution, as this seems more of
> a work around than a fix.

My suggestion is at 526b12e4-4bb0-47b1-bece-66b47bfc0a92@paulmck-laptop.

Better suggestions are of course welcome.  ;-)

> > Fixes: a30b85df7d59 ("kprobes: Use synchronize_rcu_tasks() for optprobe with CONFIG_PREEMPT=y")
> > Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
> > ---
> > v1 -> v2: Add Fixes tag
> > ---
> >  arch/Kconfig     | 2 +-
> >  kernel/kprobes.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index f4b210ab0612..dc6a18854017 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -104,7 +104,7 @@ config STATIC_CALL_SELFTEST
> >  config OPTPROBES
> >  	def_bool y
> >  	depends on KPROBES && HAVE_OPTPROBES
> > -	select TASKS_RCU if PREEMPTION
> > +	select TASKS_RUDE_RCU
> 
> Is this still a bug if PREEMPTION is not enabled?

Both "select" clauses would be needed for this patch, if I understand
correctly.

							Thanx, Paul

> -- Steve
> 
> >  
> >  config KPROBES_ON_FTRACE
> >  	def_bool y
> > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > index d5a0ee40bf66..09056ae50c58 100644
> > --- a/kernel/kprobes.c
> > +++ b/kernel/kprobes.c
> > @@ -623,7 +623,7 @@ static void kprobe_optimizer(struct work_struct *work)
> >  	 * Note that on non-preemptive kernel, this is transparently converted
> >  	 * to synchronoze_sched() to wait for all interrupts to have completed.
> >  	 */
> > -	synchronize_rcu_tasks();
> > +	synchronize_rcu_tasks_rude();
> >  
> >  	/* Step 3: Optimize kprobes after quiesence period */
> >  	do_optimize_kprobes();
> 

