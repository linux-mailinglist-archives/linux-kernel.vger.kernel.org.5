Return-Path: <linux-kernel+bounces-57786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F72884DD6C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D67E91F24B40
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5526BB5B;
	Thu,  8 Feb 2024 09:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4QUWqg/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A484E6BFC2;
	Thu,  8 Feb 2024 09:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707386176; cv=none; b=XcpGc01KrwX8MinADVI+qJFqXuzV7cll84j4FxpgWlahq4MluQhy1iUyYZxQzN6W3kl7GbwV74EqwzIGkuq3VQuHYWxXNvkWdaUB1tSD545eJPoW2i+kUfGyTcgmOIapC+LPzs9sSKIMHPYPXE/wCfWZb8OhL/sPMi2vFWa1als=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707386176; c=relaxed/simple;
	bh=pI96dSbkNKLYSAg0+ABcQxmr+LG94uf+cIdsQ/kLDNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYDDzA5PiRItZAEDrEejLaLrszXCrnwXUcSnU3yu3XQewt8TXtzZ0jjhCn8RhChVwIBanQOdqPgoqw7EiXF4ryZDQdEMZRypIDN9HyHPVQpivlJpYTThv2Z4YTHy2gQnWIRgdVBb3APaDnlJ+fm68v6BmDyB+5vevsAg8w4pDQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j4QUWqg/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03CC9C433C7;
	Thu,  8 Feb 2024 09:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707386176;
	bh=pI96dSbkNKLYSAg0+ABcQxmr+LG94uf+cIdsQ/kLDNU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=j4QUWqg/dV79oP672v3MjWMvIEJaCzuUCrdwE8uZantuURqnvfJ9NxElFqQqkcapj
	 ROmegF3zQmbWl9hBGrhQgECJOcDsQp9NfyF7NOl2jZ20M+8f12YljwWVOV5kIDgW9C
	 WOth72NFCrDe2y31DPV2vFnJaku+30owqyNNeHOfegYezy3aX69Tu7qag9BRm68bLv
	 2Lch8pz1siC+LGe7+gnWOB8C51TVcJE9XlzynSlXO4DPISjtrCU/2Sd3/2ENos57Pb
	 loiy9yi9eZoE92UP4GBzEtRSvjFDkV358PdITAMjbjChH46CPaJEAlRSxOxLv+NKiB
	 7ybRrWet+WteA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4FA5DCE14F0; Thu,  8 Feb 2024 01:56:10 -0800 (PST)
Date: Thu, 8 Feb 2024 01:56:10 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org, linux-doc@vger.kernel.org,
	Chen Zhongjin <chenzhongjin@huawei.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Heiko Carstens <hca@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
	Oleg Nesterov <oleg@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Mike Christie <michael.christie@oracle.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Peng Zhang <zhangpeng.00@bytedance.com>
Subject: Re: [PATCH 2/2] rcu-tasks: Eliminate deadlocks involving do_exit()
 and RCU tasks
Message-ID: <cc25e968-6f43-453e-be9e-2851db39218f@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240129225730.3168681-1-boqun.feng@gmail.com>
 <20240129225730.3168681-3-boqun.feng@gmail.com>
 <ZcQJ2Vec1_b5ooS_@pavilion.home>
 <ZcQzyhcaRUSRo8a9@pavilion.home>
 <ZcQ4GMEbLFtkCZXw@pavilion.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZcQ4GMEbLFtkCZXw@pavilion.home>

On Thu, Feb 08, 2024 at 03:10:32AM +0100, Frederic Weisbecker wrote:
> Le Thu, Feb 08, 2024 at 02:52:10AM +0100, Frederic Weisbecker a écrit :
> > Le Wed, Feb 07, 2024 at 11:53:13PM +0100, Frederic Weisbecker a écrit :
> > > Le Mon, Jan 29, 2024 at 02:57:27PM -0800, Boqun Feng a écrit :
> > > > From: "Paul E. McKenney" <paulmck@kernel.org>
> > > > 
> > > > Holding a mutex across synchronize_rcu_tasks() and acquiring
> > > > that same mutex in code called from do_exit() after its call to
> > > > exit_tasks_rcu_start() but before its call to exit_tasks_rcu_stop()
> > > > results in deadlock.  This is by design, because tasks that are far
> > > > enough into do_exit() are no longer present on the tasks list, making
> > > > it a bit difficult for RCU Tasks to find them, let alone wait on them
> > > > to do a voluntary context switch.  However, such deadlocks are becoming
> > > > more frequent.  In addition, lockdep currently does not detect such
> > > > deadlocks and they can be difficult to reproduce.
> > > > 
> > > > In addition, if a task voluntarily context switches during that time
> > > > (for example, if it blocks acquiring a mutex), then this task is in an
> > > > RCU Tasks quiescent state.  And with some adjustments, RCU Tasks could
> > > > just as well take advantage of that fact.
> > > > 
> > > > This commit therefore eliminates these deadlock by replacing the
> > > > SRCU-based wait for do_exit() completion with per-CPU lists of tasks
> > > > currently exiting.  A given task will be on one of these per-CPU lists for
> > > > the same period of time that this task would previously have been in the
> > > > previous SRCU read-side critical section.  These lists enable RCU Tasks
> > > > to find the tasks that have already been removed from the tasks list,
> > > > but that must nevertheless be waited upon.
> > > > 
> > > > The RCU Tasks grace period gathers any of these do_exit() tasks that it
> > > > must wait on, and adds them to the list of holdouts.  Per-CPU locking
> > > > and get_task_struct() are used to synchronize addition to and removal
> > > > from these lists.
> > > > 
> > > > Link: https://lore.kernel.org/all/20240118021842.290665-1-chenzhongjin@huawei.com/
> > > > 
> > > > Reported-by: Chen Zhongjin <chenzhongjin@huawei.com>
> > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > 
> > > With that, I think we can now revert 28319d6dc5e2 (rcu-tasks: Fix
> > > synchronize_rcu_tasks() VS zap_pid_ns_processes()). Because if the task
> > > is in rcu_tasks_exit_list, it's treated just like the others and must go
> > > through check_holdout_task(). Therefore and unlike with the previous srcu thing,
> > > a task sleeping between exit_tasks_rcu_start() and exit_tasks_rcu_finish() is
> > > now a quiescent state. And that kills the possible deadlock.
> > > 
> > > > -void exit_tasks_rcu_start(void) __acquires(&tasks_rcu_exit_srcu)
> > > > +void exit_tasks_rcu_start(void)
> > > >  {
> > > > -	current->rcu_tasks_idx = __srcu_read_lock(&tasks_rcu_exit_srcu);
> > > > +	unsigned long flags;
> > > > +	struct rcu_tasks_percpu *rtpcp;
> > > > +	struct task_struct *t = current;
> > > > +
> > > > +	WARN_ON_ONCE(!list_empty(&t->rcu_tasks_exit_list));
> > > > +	get_task_struct(t);
> > > 
> > > Is this get_task_struct() necessary?

Now that you mention it, I think not!

Each task will remove itself from this list before going away, and if
we put it on the holdout list (where it might stay for longer), there
will be a get_task_struct() there.

Good catch, thank you!

> > > > +	preempt_disable();
> > > > +	rtpcp = this_cpu_ptr(rcu_tasks.rtpcpu);
> > > > +	t->rcu_tasks_exit_cpu = smp_processor_id();
> > > > +	raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
> > > 
> > > Do we really need smp_mb__after_unlock_lock() ?

Not on this acquisition we don't.  But each lock must be all one way
or the other.  Yes, extra overhead on PowerPC, but this is nowhere near
a fastpath.

The needed ordering is provided by simple locking.

> > Or maybe it orders add into rtpcp->rtp_exit_list VS
> > main tasklist's removal? Such that:

This ordering is not needed.  The lock orders addition to this
list against removal from tasklist.  If we hold this lock, either
the task is already on this list or our holding this lock prevents
it from removing itself from the tasklist.

We have already scanned the task list, and we have already done
whatever update we are worried about.

So, if the task was on the tasklist when we scanned, well and
good.  If the task was created after we scanned the tasklist,
then it cannot possibly access whatever we removed.

But please double-check!!!

> > synchronize_rcu_tasks()                       do_exit()
> > ----------------------                        ---------
> > //for_each_process_thread()
> > READ tasklist                                 WRITE rtpcp->rtp_exit_list
> > LOCK rtpcp->lock                              UNLOCK rtpcp->lock
> > smp_mb__after_unlock_lock()                   WRITE tasklist //unhash_process()
> > READ rtpcp->rtp_exit_list
> > 
> > Does this work? Hmm, I'll play with litmus once I have a fresh brain...

First, thank you very much for the review!!!

> ie: does smp_mb__after_unlock_lock() order only what precedes the UNLOCK with
> the UNLOCK itself? (but then the UNLOCK itself can be reordered with anything
> that follows)? Or does it also order what follows the UNLOCK with the UNLOCK
> itself? If both, then it looks ok, otherwise...

If you have this:

	earlier_accesses();
	spin_lock(...);
	ill_considered_memory_accesses();
	smp_mb__after_unlock_lock();
	later_accesses();

Then earlier_accesses() will be ordered against later_accesses(), but
ill_considered_memory_accesses() won't necessarily be ordered.  Also,
any accesses before any prior release of that same lock will be ordered
against later_accesses().

(In real life, ill_considered_memory_accesses() will be fully ordered
against either spin_lock() on the one hand or smp_mb__after_unlock_lock()
on the other, with x86 doing the first and PowerPC doing the second.
So please try to avoid any ill_considered_memory_accesses().)

> Also on the other end, does LOCK/smp_mb__after_unlock_lock() order against what
> precedes the LOCK? That also is necessary for the above to work.

It looks like an smp_mb__after_spinlock() would also be needed, for
example, on ARMv8.

> Of course by the time I'm writing this email, litmus would have told me
> already...

;-) ;-) ;-)

But I believe that simple locking covers this case.  Famous last words...

							Thanx, Paul

