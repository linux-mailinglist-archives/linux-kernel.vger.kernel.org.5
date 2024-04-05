Return-Path: <linux-kernel+bounces-133455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B067889A3ED
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 20:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B588B21B1B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5192A172769;
	Fri,  5 Apr 2024 18:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t5nZBAPp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380E3171085;
	Fri,  5 Apr 2024 18:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712340781; cv=none; b=srFLwGx1P/b0X/mcrDdfjgsuemwMzGNc2bNj6UUhx5MHJMsG/iWHBP4pAfQnoYNkPpGi+I9B0frK4B26CNMQHeC/r3+4mCjDgECs2IKY7M0E1IHt+yhVF5AjQYbTxWHMMw/qFG0UMkv/bZYQiN53E6/Oqsvk0M9DA/q3liswPSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712340781; c=relaxed/simple;
	bh=Qk6MaV3BTwsT/DH2zdulQrDAO811Y7rsOBeA1xQ8Ndo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+HHp3aext5x579PE6mtSpcIbVrXxCqGPOMg5mkOfX6rpIEX7TuQpw+xRkHntXIUQKigThhNXyYujJ3r77m4+HoNy+r9NOCOUlWq9h8DyXgGaT9r0jg2U2ND37CdfCyswnhdaDEzd940GSt3j9RJxG9biovKjglmDoGYUaviZz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t5nZBAPp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9281C433F1;
	Fri,  5 Apr 2024 18:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712340780;
	bh=Qk6MaV3BTwsT/DH2zdulQrDAO811Y7rsOBeA1xQ8Ndo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=t5nZBAPpgWgN9vnhf9sX290ojlxCEtvxlJtCpkSJ2RbjTXOTuaXrOqdNOk6x6H21i
	 sYWWwhkmfYtsnnWTcbhgTtJ4+h0+PHApGJCISBvGKMnaKjw4FbM3AesPkmQLP6N/CF
	 ez+cm+NQTqHshRb3yftKm+DzUee2YxuiX3iGsOrjW2Q32Lrza1lONOZYKDvM+ajz3H
	 wc8qEYdgJYOs+qB2Ti1OrdXLPDAqIahgOpx0EahMwWXh+5CEZiQnkyR3ksER4c8XtB
	 nF8fjmL4T+1iwTo2zLPHE2cRwYY7IUkjRfvny7GRSR8ywr/bbkeLVzYbYGXLw1Xntm
	 Ifyxowevs9v+w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 41C18CE11CE; Fri,  5 Apr 2024 11:13:00 -0700 (PDT)
Date: Fri, 5 Apr 2024 11:13:00 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Yan Zhai <yan@cloudflare.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Coco Li <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>,
	Alexander Duyck <alexanderduyck@fb.com>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	bpf@vger.kernel.org, kernel-team@cloudflare.com,
	Joel Fernandes <joel@joelfernandes.org>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>, mark.rutland@arm.com,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5 net 1/3] rcu: add a helper to report consolidated
 flavor QS
Message-ID: <b543d436-be5f-45f2-a89d-0de33e3da058@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <cover.1710877680.git.yan@cloudflare.com>
 <90431d46ee112d2b0af04dbfe936faaca11810a5.1710877680.git.yan@cloudflare.com>
 <20240322112413.1UZFdBq5@linutronix.de>
 <123ca494-dc8c-47cc-a6d5-3c529bc7f549@paulmck-laptop>
 <CAO3-PbqRztEC1JFg3SrgUi9a404Xpou_Xx9_mxXoZVY-KVkyGg@mail.gmail.com>
 <20240405134946.NzqmEyX1@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240405134946.NzqmEyX1@linutronix.de>

On Fri, Apr 05, 2024 at 03:49:46PM +0200, Sebastian Andrzej Siewior wrote:
> On 2024-03-22 21:02:02 [-0500], Yan Zhai wrote:
> > On Fri, Mar 22, 2024 at 4:31 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Fri, Mar 22, 2024 at 12:24:13PM +0100, Sebastian Andrzej Siewior wrote:
> > > > On 2024-03-19 13:44:34 [-0700], Yan Zhai wrote:
> > > > > + * The macro is not needed when CONFIG_PREEMPT_RT is defined. RT kernels would
> > > > > + * have more chance to invoke schedule() calls and provide necessary quiescent
> > > > > + * states. As a contrast, calling cond_resched() only won't achieve the same
> > > > > + * effect because cond_resched() does not provide RCU-Tasks quiescent states.
> > > > > + */
> > > >
> > > > Paul, so CONFIG_PREEMPTION is affected but CONFIG_PREEMPT_RT is not.
> > > > Why does RT have more scheduling points?
> > >
> > > In RT, isn't BH-disabled code preemptible?  But yes, this would not help
> > > RCU Tasks.
> Yes, it is but why does it matter? This is used in the NAPI thread which
> fully preemptible and does cond_resched(). This should be enough.

By the time it gets to RCU, a cond_resched()-induced context switch looks
like a preemption.  This is fine for normal RCU, but Tasks RCU needs
a voluntary context switch for a quiescent state.  Which makes sense,
given that code running in a trampoline that is invoked from preemptible
code can itself be preempted.

So that additional call to rcu_softirq_qs() is needed.  (Which invokes
rcu_tasks_qs() which in turn invokes rcu_tasks_classic_qs().

And maybe it is also needed for RT.  The argument against would be that
RT applications have significant idle time on the one hand or spend lots
of time in nohz_full userspace on the other, both of which are quiescent
states for RCU Tasks.  But you tell me!

> > By "more chance to invoke schedule()", my thought was that
> > cond_resched becomes no op on RT or PREEMPT kernel. So it will not
> > call __schedule(SM_PEREEMPT), which clears the NEED_RESCHED flag. On a
> It will nop cond_resched(), correct. However once something sends
> NEED_RESCHED then the receiver of this flag will __schedule(SM_PEREEMPT)
> as soon as possible. That is either because the scheduler sends an IPI
> and the CPU will do it in the irq-exit path _or_ the thread does
> preempt_enable() (which includes local_bh_enable()) and the counter hits
> zero at which point the same context switch happens.
> 
> Therefore I don't see a difference between CONFIG_PREEMPT and
> CONFIG_PREEMPT_RT.

True, but again RCU Tasks needs a voluntary context switch and the
resulting preemption therefore does not qualify.

> > normal irq exit like timer, when NEED_RESCHED is on,
> > schedule()/__schedule(0) can be called time by time then.
> 
> This I can not parse. __schedule(0) means the task gives up on its own
> and goes to sleep. This does not happen for the NAPI-thread loop,
> kworker loop or any other loop that consumes one work item after the
> other and relies on cond_resched() in between.
> 
> > __schedule(0) is good for RCU tasks, __schedule(SM_PREEMPT) is not.
> Okay and that is why? This means you expect that every thread gives up
> on its own which may take some time depending on the workload. This
> should not matter.
> 
> If I see this right, the only difference is rcu_tasks_classic_qs() and I
> didn't figure out yet what it does.

It marks the task as having passed through a Tasks RCU quiescent state.
Which works because this is called from task level (as opposed to from
irq, softirq, or NMI), so it cannot be returning to a trampoline that
is protected by Tasks RCU.

Later on, the Tasks RCU grace-period kthread will see the marking, and
remove this task from the list that is blocking the current Tasks-RCU
grace period.

> > But I think this code comment does not take into account frequent
> > preempt_schedule and irqentry_exit_cond_resched on a PREEMPT kernel.
> > When returning to these busy kthreads, irqentry_exit_cond_resched is
> > in fact called now, not schedule(). So likely __schedule(PREEMPT) is
> > still called frequently, or even more frequently. So the code comment
> > looks incorrect on the RT argument part. We probably should remove the
> > "IS_ENABLED" condition really. Paul and Sebastian, does this sound
> > reasonable to you?
> 
> Can you walk me through it? Why is it so important for a task to give up
> voluntary? There is something wrong here with how RCU tasks works.
> We want to get rid of the sprinkled cond_resched(). This looks like a
> another variant of it that might be required in places with no
> explanation except it takes too long. 

Hmmm...  I would normally point you at the Requirements.rst [1] document
for a walkthrough, but it does not cover all of this.

How about the upgrade shown below?

I agree that it would be nice if Tasks RCU did not have to depend on
voluntary context switches.  In theory, one alternative would be to
examine each task's stack, looking for return addresses in trampolines.
In practice, we recently took a look at this and other alternatives,
but none were feasible [2].  If you know of a better way, please do not
keep it a secret!

Note that kernel live patching has similar needs, and may need
similar annotations/innovations.

							Thanx, Paul

[1] Documentation/RCU/Design/Requirements/Requirements.rst
[2] https://docs.google.com/document/d/1kZY6AX-AHRIyYQsvUX6WJxS1LsDK4JA2CHuBnpkrR_U/edit?usp=sharing

------------------------------------------------------------------------
As written:
------------------------------------------------------------------------

Tasks RCU
~~~~~~~~~

Some forms of tracing use “trampolines” to handle the binary rewriting
required to install different types of probes. It would be good to be
able to free old trampolines, which sounds like a job for some form of
RCU. However, because it is necessary to be able to install a trace
anywhere in the code, it is not possible to use read-side markers such
as rcu_read_lock() and rcu_read_unlock(). In addition, it does
not work to have these markers in the trampoline itself, because there
would need to be instructions following rcu_read_unlock(). Although
synchronize_rcu() would guarantee that execution reached the
rcu_read_unlock(), it would not be able to guarantee that execution
had completely left the trampoline. Worse yet, in some situations
the trampoline's protection must extend a few instructions *prior* to
execution reaching the trampoline.  For example, these few instructions
might calculate the address of the trampoline, so that entering the
trampoline would be pre-ordained a surprisingly long time before execution
actually reached the trampoline itself.

The solution, in the form of `Tasks
RCU <https://lwn.net/Articles/607117/>`__, is to have implicit read-side
critical sections that are delimited by voluntary context switches, that
is, calls to schedule(), cond_resched(), and
synchronize_rcu_tasks(). In addition, transitions to and from
userspace execution also delimit tasks-RCU read-side critical sections.
Idle tasks are ignored by Tasks RCU, and Tasks Rude RCU may be used to
interact with them.

Note well that involuntary context switches are *not* Tasks-RCU quiescent
states.  After all, in preemptible kernels, a task executing code in a
trampoline might be preempted.  In this case, the Tasks-RCU grace period
clearly cannot end until that task resumes and its execution leaves that
trampoline.  This means, among other things, that cond_resched() does
not provide a Tasks RCU quiescent state.  (Instead, use rcu_softirq_qs()
from softirq or rcu_tasks_classic_qs() otherwise.)

The tasks-RCU API is quite compact, consisting only of
call_rcu_tasks(), synchronize_rcu_tasks(), and
rcu_barrier_tasks(). In ``CONFIG_PREEMPTION=n`` kernels, trampolines
cannot be preempted, so these APIs map to call_rcu(),
synchronize_rcu(), and rcu_barrier(), respectively. In
``CONFIG_PREEMPTION=y`` kernels, trampolines can be preempted, and these
three APIs are therefore implemented by separate functions that check
for voluntary context switches.

------------------------------------------------------------------------
As patch:
------------------------------------------------------------------------

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index cccafdaa1f849..f511476b45506 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -2357,6 +2357,7 @@ section.
 #. `Sched Flavor (Historical)`_
 #. `Sleepable RCU`_
 #. `Tasks RCU`_
+#. `Tasks Trace RCU`_
 
 Bottom-Half Flavor (Historical)
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -2610,6 +2611,16 @@ critical sections that are delimited by voluntary context switches, that
 is, calls to schedule(), cond_resched(), and
 synchronize_rcu_tasks(). In addition, transitions to and from
 userspace execution also delimit tasks-RCU read-side critical sections.
+Idle tasks are ignored by Tasks RCU, and Tasks Rude RCU may be used to
+interact with them.
+
+Note well that involuntary context switches are *not* Tasks-RCU quiescent
+states.  After all, in preemptible kernels, a task executing code in a
+trampoline might be preempted.  In this case, the Tasks-RCU grace period
+clearly cannot end until that task resumes and its execution leaves that
+trampoline.  This means, among other things, that cond_resched() does
+not provide a Tasks RCU quiescent state.  (Instead, use rcu_softirq_qs()
+from softirq or rcu_tasks_classic_qs() otherwise.)
 
 The tasks-RCU API is quite compact, consisting only of
 call_rcu_tasks(), synchronize_rcu_tasks(), and
@@ -2632,6 +2643,11 @@ moniker.  And this operation is considered to be quite rude by real-time
 workloads that don't want their ``nohz_full`` CPUs receiving IPIs and
 by battery-powered systems that don't want their idle CPUs to be awakened.
 
+Once kernel entry/exit and deep-idle functions have been properly tagged
+``noinstr``, Tasks RCU can start paying attention to idle tasks (except
+those that are idle from RCU's perspective) and then Tasks Rude RCU can
+be removed from the kernel.
+
 The tasks-rude-RCU API is also reader-marking-free and thus quite compact,
 consisting of call_rcu_tasks_rude(), synchronize_rcu_tasks_rude(),
 and rcu_barrier_tasks_rude().

