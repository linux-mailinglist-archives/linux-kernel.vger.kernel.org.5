Return-Path: <linux-kernel+bounces-5119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C75908186BA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBB481C23A9B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D985418E20;
	Tue, 19 Dec 2023 11:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sUoBuG6g"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B0818B04;
	Tue, 19 Dec 2023 11:56:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2799C433C8;
	Tue, 19 Dec 2023 11:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702987013;
	bh=zHISBvsIcJR3OT2FDj6duE1bfStgYazzhYoF/8iQEvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sUoBuG6ga2p+k2lnkG33dKZ6x5zB4zLfgae7TsCT/D3yYb4nUX7+uXuej/GaO6H4G
	 xABOiYmHr2G8gP57997/aN5aA9Hi/YG3xyENJXKvZ1SufFx80IgGipzwdiZxCey61w
	 GKfGGugatD9/KLoXpvXtCfml5yj+yanI8Ga3PZWcFfyERm3BTni+6z+Fjh5WpI8tEN
	 ILyb/O2dBjM7FmPI05QSNnvL6YCEvvwqyJGwNhu/jO6cc4JH9KQsnznRbF+Yvg1HLO
	 9os382r35AvC3X7DB4SMfbwZ6FXSgDY3+nWE3ef90jnU7crClhxLMRCjcft9Wqd0/+
	 W5rOlz/Pz8Vpg==
Date: Tue, 19 Dec 2023 12:56:50 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/3] rcu: Defer RCU kthreads wakeup when CPU is dying
Message-ID: <ZYGFAtLNQsLUWGPr@lothringen>
References: <20231218231916.11719-1-frederic@kernel.org>
 <20231218231916.11719-3-frederic@kernel.org>
 <65811051.d40a0220.75c79.66cf@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65811051.d40a0220.75c79.66cf@mx.google.com>

On Mon, Dec 18, 2023 at 10:38:52PM -0500, Joel Fernandes wrote:
> On Tue, Dec 19, 2023 at 12:19:15AM +0100, Frederic Weisbecker wrote:
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 3ac3c846105f..157f3ca2a9b5 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -1013,6 +1013,38 @@ static bool rcu_future_gp_cleanup(struct rcu_node *rnp)
> >  	return needmore;
> >  }
> >  
> > +static void swake_up_one_online_ipi(void *arg)
> > +{
> > +	struct swait_queue_head *wqh = arg;
> > +
> > +	swake_up_one(wqh);
> > +}
> 
> Speaking of, the scheduler refuses to do remote-IPI-style wakeups
> (TTWU_QUEUE) whenever the destination CPU is in a hotplug state.
> 
> static inline bool ttwu_queue_cond(struct task_struct *p, int cpu)
> {
> 	/*
> 	 * Do not complicate things with the async wake_list while the CPU is
> 	 * in hotplug state.
> 	 */
> 	if (!cpu_active(cpu))
> 		return false;
> 	...
> }

Yes, because all irrelevant tasks must be migrated out upon
CPUHP_AP_SCHED_WAIT_EMPTY, thanks to balance_push_set().

(Though right now I'm missing the flush_smp_call_function_queue() call that flushes
the ttwu queue between sched_cpu_deactivate() and sched_cpu_wait_empty())

> 
> Along these lines, I wonder if, it is safe to do a wakeup in this fashion (as
> done by this patch) if the destination CPU was also going down.
> 
> Also the same ttwu_queue_cond() checks for CPU affinities before deciding to
> not do the IPI-style queue.
> 
> 	/* Ensure the task will still be allowed to run on the CPU. */
> 	if (!cpumask_test_cpu(cpu, p->cpus_ptr))
> 		return false;
> 
> Not that anyone should be changing RCU thread priorities around while the IPI
> is in flight, but...
> 
> I wonder if the reason TTWU is excessively paranoid is that the IPI can be
> delayed for example, leading to race conditions.

It's because nothing irrelevant must be queued after sched_cpu_wait_empty().

But note this patch does something different, it doesn't defer the runqueue
enqueue like ttwu queue does. It defers the whole actual wakeup. This means that the
decision as to where to queue the task is delegated to an online CPU. So it's
not the same constraints. Waking up a task _from_ a CPU that is active or not but
at least online is supposed to be fine.

Thanks.

