Return-Path: <linux-kernel+bounces-57378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2FA84D7A8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 02:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B07DB1F2317F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 01:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C681E87F;
	Thu,  8 Feb 2024 01:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLxvjOWv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028771E496;
	Thu,  8 Feb 2024 01:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707357135; cv=none; b=GtoR+qsA7xMl8SMe+l9cUjcb1NhVdXMTesuW2EtOhHTnFCsx5WPoKsMt17+QEu3inPBCrpOAysVg8svSzVdhf3sL4cpCFFH6u3fxOj+1jNdWTnuG5v1xby8biji3YHNUf9aVWJBiWA6i7WIX61wJaGf0RjZoS/rDGGHz+LyouTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707357135; c=relaxed/simple;
	bh=n7BA4BZPXal7vWu1sbB/Hxn9hEcUjcEYTqUwvp4f39Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GLgad8iUFoqbZXCWs9dNQ4Ltg+qiZOCHxfVqFETVkKOntEshRwqL8pfEDY1OjFM7OX+fJNeuRHTOcjmpBkc3rZ6oOH7fS2iURIUzKphQM41QgEi6qrtF7OLI+oi5bJG88Kp5D8M9SLqVnPPzyPf5ehN87UVWm6LBs3oWrXgjyiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLxvjOWv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9BD4C433C7;
	Thu,  8 Feb 2024 01:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707357134;
	bh=n7BA4BZPXal7vWu1sbB/Hxn9hEcUjcEYTqUwvp4f39Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mLxvjOWvpGkvNnEtVm7ryPX9EuoYGz1Y4fz/Uzc4XBhYHZUJZPmgSJ1z3mz37HV27
	 btszq1aO1e+OXQORqsS06n4sRzgNVSl3dLD+2Bc+3aq8MZOsumj97pmY2DBPsp3xEP
	 ufVU218tsQf/OOt+hPD+tI/Uo6wOwcfUe/5ms7kh2mpjATMdM3Yl2KLIlJky7pVXI3
	 lLPbhsxsojOJSQJsebedfb5fzgn9llQzykcqDN1lAUX+MuNyAmRXmxfVfZETEZ40Le
	 nDgbd4Opo/gq31FZC5tNizRiAoRmt6GF68ejGP1WEV79JTeexiZy3oKECNo50ZCXYF
	 Fvvy6agik+t5A==
Date: Thu, 8 Feb 2024 02:52:10 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	linux-doc@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
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
Message-ID: <ZcQzyhcaRUSRo8a9@pavilion.home>
References: <20240129225730.3168681-1-boqun.feng@gmail.com>
 <20240129225730.3168681-3-boqun.feng@gmail.com>
 <ZcQJ2Vec1_b5ooS_@pavilion.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZcQJ2Vec1_b5ooS_@pavilion.home>

Le Wed, Feb 07, 2024 at 11:53:13PM +0100, Frederic Weisbecker a écrit :
> Le Mon, Jan 29, 2024 at 02:57:27PM -0800, Boqun Feng a écrit :
> > From: "Paul E. McKenney" <paulmck@kernel.org>
> > 
> > Holding a mutex across synchronize_rcu_tasks() and acquiring
> > that same mutex in code called from do_exit() after its call to
> > exit_tasks_rcu_start() but before its call to exit_tasks_rcu_stop()
> > results in deadlock.  This is by design, because tasks that are far
> > enough into do_exit() are no longer present on the tasks list, making
> > it a bit difficult for RCU Tasks to find them, let alone wait on them
> > to do a voluntary context switch.  However, such deadlocks are becoming
> > more frequent.  In addition, lockdep currently does not detect such
> > deadlocks and they can be difficult to reproduce.
> > 
> > In addition, if a task voluntarily context switches during that time
> > (for example, if it blocks acquiring a mutex), then this task is in an
> > RCU Tasks quiescent state.  And with some adjustments, RCU Tasks could
> > just as well take advantage of that fact.
> > 
> > This commit therefore eliminates these deadlock by replacing the
> > SRCU-based wait for do_exit() completion with per-CPU lists of tasks
> > currently exiting.  A given task will be on one of these per-CPU lists for
> > the same period of time that this task would previously have been in the
> > previous SRCU read-side critical section.  These lists enable RCU Tasks
> > to find the tasks that have already been removed from the tasks list,
> > but that must nevertheless be waited upon.
> > 
> > The RCU Tasks grace period gathers any of these do_exit() tasks that it
> > must wait on, and adds them to the list of holdouts.  Per-CPU locking
> > and get_task_struct() are used to synchronize addition to and removal
> > from these lists.
> > 
> > Link: https://lore.kernel.org/all/20240118021842.290665-1-chenzhongjin@huawei.com/
> > 
> > Reported-by: Chen Zhongjin <chenzhongjin@huawei.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> With that, I think we can now revert 28319d6dc5e2 (rcu-tasks: Fix
> synchronize_rcu_tasks() VS zap_pid_ns_processes()). Because if the task
> is in rcu_tasks_exit_list, it's treated just like the others and must go
> through check_holdout_task(). Therefore and unlike with the previous srcu thing,
> a task sleeping between exit_tasks_rcu_start() and exit_tasks_rcu_finish() is
> now a quiescent state. And that kills the possible deadlock.
> 
> > -void exit_tasks_rcu_start(void) __acquires(&tasks_rcu_exit_srcu)
> > +void exit_tasks_rcu_start(void)
> >  {
> > -	current->rcu_tasks_idx = __srcu_read_lock(&tasks_rcu_exit_srcu);
> > +	unsigned long flags;
> > +	struct rcu_tasks_percpu *rtpcp;
> > +	struct task_struct *t = current;
> > +
> > +	WARN_ON_ONCE(!list_empty(&t->rcu_tasks_exit_list));
> > +	get_task_struct(t);
> 
> Is this get_task_struct() necessary?
> 
> > +	preempt_disable();
> > +	rtpcp = this_cpu_ptr(rcu_tasks.rtpcpu);
> > +	t->rcu_tasks_exit_cpu = smp_processor_id();
> > +	raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
> 
> Do we really need smp_mb__after_unlock_lock() ?

Or maybe it orders add into rtpcp->rtp_exit_list VS
main tasklist's removal? Such that:

synchronize_rcu_tasks()                       do_exit()
----------------------                        ---------
//for_each_process_thread()
READ tasklist                                 WRITE rtpcp->rtp_exit_list
LOCK rtpcp->lock                              UNLOCK rtpcp->lock
smp_mb__after_unlock_lock()                   WRITE tasklist //unhash_process()
READ rtpcp->rtp_exit_list

Does this work? Hmm, I'll play with litmus once I have a fresh brain...

Thanks.

