Return-Path: <linux-kernel+bounces-77339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CFC860404
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B028BB280EA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2731E71743;
	Thu, 22 Feb 2024 20:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kg9QWm/Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649313B287;
	Thu, 22 Feb 2024 20:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708635145; cv=none; b=lLtGx7PSaY3ECdBfV85QsnD22ki6+MWswME+/EMIDin6fu1aKlcY8P/tyS7Pi1hR2GtnfngqEw3zFuOrzso/4yJKUttlFhpVVAaiiTpS5Hm/WvNhvyKqph1eFtPlDyzMhXAjon+0bW/gS3BxsECnDp5p2GcWDMt6zAFFoIBzm1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708635145; c=relaxed/simple;
	bh=Dj91tEjYg1HwOX4bOyYfGvqwGe/rZ6inH+dk/+Q5E6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXIOPn/RsSyDWPVkYLIv19AXUQD65Hbz8z02qPHk1SCHUu2Hi150l3s/q9LMx4MtUmqFTUNoIHKMNCXYZVa+xkDw8vZjdJjn53ix5TfF8zRSJ/7L+kJH28q/YOud7qVLymXKZ+ebLCCKccPfO3mzS0YCX2PODVZ1yHw0njpKZ/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kg9QWm/Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B00C433F1;
	Thu, 22 Feb 2024 20:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708635145;
	bh=Dj91tEjYg1HwOX4bOyYfGvqwGe/rZ6inH+dk/+Q5E6o=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Kg9QWm/YJD+wqSMopR7fRh/JVnJ5hjUXvR1O0mubZ1K5CQCTOYkVIpWsB/JFRl4DD
	 Uu2FsYoU1vjlo2KVnvk/UapsyqEul8stWRn9oF1rvpEFm/Oq8HPZLRg3OeY2WmY0a0
	 DmUYk1g6wk31/9jZZRFBNCrxWKI+BP3ZEXvtueS3/lK+7tqSjAIyXerK3Sr0eCO9ND
	 I4Ht3fHsr2VlPRrdRGhbkL9fqJKufTerO8weZEQc8gnvtCq2oJ7vwCZo5QXcQz1D1/
	 RGubazq/XupENbYyD1Rz2LhTjrEk0mBKnQrE0zc5kXVgpOIgaZ99LYW//Q8pu20Zci
	 Ukoeplc+neVWw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id AE215CE0738; Thu, 22 Feb 2024 12:52:24 -0800 (PST)
Date: Thu, 22 Feb 2024 12:52:24 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Siewior <bigeasy@linutronix.de>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH v2 6/6] rcu-tasks: Maintain real-time response in
 rcu_tasks_postscan()
Message-ID: <e0472956-1b18-4a22-be6e-5dbbc11141eb@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240217012745.3446231-1-boqun.feng@gmail.com>
 <20240217012745.3446231-7-boqun.feng@gmail.com>
 <ZdeI_-RfdLR8jlsm@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZdeI_-RfdLR8jlsm@localhost.localdomain>

On Thu, Feb 22, 2024 at 06:48:47PM +0100, Frederic Weisbecker wrote:
> Le Fri, Feb 16, 2024 at 05:27:41PM -0800, Boqun Feng a écrit :
> > From: "Paul E. McKenney" <paulmck@kernel.org>
> > 
> > The current code will scan the entirety of each per-CPU list of exiting
> > tasks in ->rtp_exit_list with interrupts disabled.  This is normally just
> > fine, because each CPU typically won't have very many tasks in this state.
> > However, if a large number of tasks block late in do_exit(), these lists
> > could be arbitrarily long.  Low probability, perhaps, but it really
> > could happen.
> > 
> > This commit therefore occasionally re-enables interrupts while traversing
> > these lists, inserting a dummy element to hold the current place in the
> > list.  In kernels built with CONFIG_PREEMPT_RT=y, this re-enabling happens
> > after each list element is processed, otherwise every one-to-two jiffies.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Sebastian Siewior <bigeasy@linutronix.de>
> > Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > ---
> >  kernel/rcu/tasks.h | 21 ++++++++++++++++++++-
> >  1 file changed, 20 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > index 4dc355b2ac22..866743e0796f 100644
> > --- a/kernel/rcu/tasks.h
> > +++ b/kernel/rcu/tasks.h
> > @@ -971,13 +971,32 @@ static void rcu_tasks_postscan(struct list_head *hop)
> >  	 */
> >  
> >  	for_each_possible_cpu(cpu) {
> > +		unsigned long j = jiffies + 1;
> >  		struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rcu_tasks.rtpcpu, cpu);
> >  		struct task_struct *t;
> > +		struct task_struct *t1;
> > +		struct list_head tmp;
> >  
> >  		raw_spin_lock_irq_rcu_node(rtpcp);
> > -		list_for_each_entry(t, &rtpcp->rtp_exit_list, rcu_tasks_exit_list)
> > +		list_for_each_entry_safe(t, t1, &rtpcp->rtp_exit_list, rcu_tasks_exit_list) {
> >  			if (list_empty(&t->rcu_tasks_holdout_list))
> >  				rcu_tasks_pertask(t, hop);
> > +
> > +			// RT kernels need frequent pauses, otherwise
> > +			// pause at least once per pair of jiffies.
> > +			if (!IS_ENABLED(CONFIG_PREEMPT_RT) && time_before(jiffies, j))
> > +				continue;
> > +
> > +			// Keep our place in the list while pausing.
> > +			// Nothing else traverses this list, so adding a
> > +			// bare list_head is OK.
> > +			list_add(&tmp, &t->rcu_tasks_exit_list);
> 
> I'm a bit confused about what this does...
> 
> > +			raw_spin_unlock_irq_rcu_node(rtpcp);
> > +			cond_resched(); // For CONFIG_PREEMPT=n kernels
> > +			raw_spin_lock_irq_rcu_node(rtpcp);
> > +			list_del(&tmp);
> 
> Isn't there a risk that t is reaped by then? If it was not observed on_rq
> while calling rcu_tasks_pertask() then there is no get_task_struct.

That is OK, courtesy of the _safe in list_for_each_entry_safe().

> And what about t1? Can't it be reaped as well?

It can, and that is a problem, good catch!

My current thought is to add this before the list_del(), which is
admittedly a bit crude:

			t1 = tmp.next;

Is there a better way?

							Thanx, Paul

> Thanks.
> 
> 
> > +			j = jiffies + 1;
> > +		}
> >  		raw_spin_unlock_irq_rcu_node(rtpcp);
> >  	}
> >  
> > -- 
> > 2.43.0
> > 

