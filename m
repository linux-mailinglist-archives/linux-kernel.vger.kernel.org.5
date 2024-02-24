Return-Path: <linux-kernel+bounces-79358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EA186212A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 01:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9805EB21CFE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 00:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A1715B7;
	Sat, 24 Feb 2024 00:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AenSVfPd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBDD64A;
	Sat, 24 Feb 2024 00:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708734211; cv=none; b=E7/h8EklqhyiGbwq7OUCh1RyhiTFGDyJh78sAd7DjFikEMMEzk3s50VHm6A4viBse8V78MHPAZTAYQqlGns1uVoFVSSxSF5xB3GpCv31cK2Qdn9y5/w93b/sTFltu566Ixb/q0xXM4lEg2SDOY3gmjEZMcny6BbB/8taZb1EG7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708734211; c=relaxed/simple;
	bh=PSIjkioZV1XuZZmMdkSlReJ4zGEasuPJXjKQZZQaDp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EmNnxNa6+7UNXDKM3LVPsn3z7gXvV/7bbO2upTIZbADFZK6QtrH1I6F/xw8mR9+yRWlgOACLqDAbMItCbC78/mjCBrV/A7goTw+BOhuUqg9iMR084jx8uJrm88/B2Xbh2GFSnbCqfw4sdwuzebbewbyFWP4wPRyUi65L2IF8D+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AenSVfPd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F04BC433F1;
	Sat, 24 Feb 2024 00:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708734210;
	bh=PSIjkioZV1XuZZmMdkSlReJ4zGEasuPJXjKQZZQaDp0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=AenSVfPdBJqMSgmAINEhFiTWpP8PJMsi4E7o3cfmhEn0aLupM8N1hOzNx3uZAEOrJ
	 ma7+b3yoqyW0+hLocVPVJqXKg4rlZDgE04LMk5eKIf/CjYih/pU90dP02yPGzQONyq
	 hk8M2WM15wNw8joXbyRltfO3AFbRov8aBufj+caf+gJo+zLDIYQzCmqUdM7tTQ/Hiv
	 wE+KYFdI2ESRuW7QuNXenCbgxM6zRwiXFPwyuYCS06qfl0E8UEVxhIqO8qI+9dpS+j
	 D460uXA7woSJfx3oBfn2xA4tInb/Aj90ZMk427PRO2JrM0G6OMnivnYWg5ytWCrTpb
	 r+7lGfA0f/S3Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 26D75CE1113; Fri, 23 Feb 2024 16:23:30 -0800 (PST)
Date: Fri, 23 Feb 2024 16:23:30 -0800
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
Message-ID: <4741400a-b8e9-452c-a9a9-3a539868f1ef@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240217012745.3446231-1-boqun.feng@gmail.com>
 <20240217012745.3446231-7-boqun.feng@gmail.com>
 <ZdeI_-RfdLR8jlsm@localhost.localdomain>
 <e0472956-1b18-4a22-be6e-5dbbc11141eb@paulmck-laptop>
 <9a27f638-4eb0-42b3-b8a3-201d6ed9406b@paulmck-laptop>
 <ZdiMympnNOo6e+5T@lothringen>
 <Zdi2aXbgKdsmP/1O@lothringen>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zdi2aXbgKdsmP/1O@lothringen>

On Fri, Feb 23, 2024 at 04:14:49PM +0100, Frederic Weisbecker wrote:
> On Fri, Feb 23, 2024 at 01:17:14PM +0100, Frederic Weisbecker wrote:
> > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > index 866743e0796f..0ff2b554f5b5 100644
> > --- a/kernel/rcu/tasks.h
> > +++ b/kernel/rcu/tasks.h
> > @@ -973,12 +973,13 @@ static void rcu_tasks_postscan(struct list_head *hop)
> >  	for_each_possible_cpu(cpu) {
> >  		unsigned long j = jiffies + 1;
> >  		struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rcu_tasks.rtpcpu, cpu);
> > -		struct task_struct *t;
> > -		struct task_struct *t1;
> > -		struct list_head tmp;
> >  
> >  		raw_spin_lock_irq_rcu_node(rtpcp);
> > -		list_for_each_entry_safe(t, t1, &rtpcp->rtp_exit_list, rcu_tasks_exit_list) {
> > +		while (!list_empty(&rtpcp->rtp_exit_list)) {
> > +			struct task_struct *t;
> > +			t = list_first_entry(&rtpcp->rtp_exit_list, typeof(*t), rcu_tasks_exit_list);
> > +			list_del_init(&t->rcu_tasks_exit_list);
> 
> Oh no! The task has to stay in the list for subsequent grace periods! Please
> forget that suggestion... Yours looks good!

You had me going for a bit, and I do know that feeling!  ;-)

							Thanx, Paul

> Thanks.
> 
> > +
> >  			if (list_empty(&t->rcu_tasks_holdout_list))
> >  				rcu_tasks_pertask(t, hop);
> >  
> > @@ -987,14 +988,9 @@ static void rcu_tasks_postscan(struct list_head *hop)
> >  			if (!IS_ENABLED(CONFIG_PREEMPT_RT) && time_before(jiffies, j))
> >  				continue;
> >  
> > -			// Keep our place in the list while pausing.
> > -			// Nothing else traverses this list, so adding a
> > -			// bare list_head is OK.
> > -			list_add(&tmp, &t->rcu_tasks_exit_list);
> >  			raw_spin_unlock_irq_rcu_node(rtpcp);
> >  			cond_resched(); // For CONFIG_PREEMPT=n kernels
> >  			raw_spin_lock_irq_rcu_node(rtpcp);
> > -			list_del(&tmp);
> >  			j = jiffies + 1;
> >  		}
> >  		raw_spin_unlock_irq_rcu_node(rtpcp);
> > @@ -1219,7 +1215,6 @@ void exit_tasks_rcu_stop(void)
> >  	struct rcu_tasks_percpu *rtpcp;
> >  	struct task_struct *t = current;
> >  
> > -	WARN_ON_ONCE(list_empty(&t->rcu_tasks_exit_list));
> >  	rtpcp = per_cpu_ptr(rcu_tasks.rtpcpu, t->rcu_tasks_exit_cpu);
> >  	raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
> >  	list_del_init(&t->rcu_tasks_exit_list);
> > 

