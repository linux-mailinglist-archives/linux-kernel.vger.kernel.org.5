Return-Path: <linux-kernel+bounces-78284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C86C186115A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E1F4286F63
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AA87BAE3;
	Fri, 23 Feb 2024 12:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pxxS1kyc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B46A2E417;
	Fri, 23 Feb 2024 12:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708690637; cv=none; b=W1d8LSTJVyNc1uV1cN23nzG5nppNYDHrHuml3S6EWiJsMYKFt2GdzYfE5EjRCujJPW5Fhs1OT+uzYGYvxAm4gXFBN8U7UVgK+GjmQM649QBOiCfLdjiQszIhFBMilMZ0WFcrCmXRzMpUkSZy+OZi/A5qCwbjkkQLEYrhr9xU8jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708690637; c=relaxed/simple;
	bh=dD+Amox90za99RFzb8DfVKU4tgSGxx3W9Z7qT51AAcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0Dolhad35Y147fDfApe2SqJ7V9iAEZ5GTne0urUPgIISJgUeVaNMIenp3u9kA+FbJ2tcs9GFwy54DmNVOAVZOTXF9EIEfSKOIqEKVPOLJqASV8mQGEMh2/RTwOyMmlWLkDDG79wrrph1wK5GEK4zsfaKkcNBQTX7EnGkXesUfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pxxS1kyc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05A0C433C7;
	Fri, 23 Feb 2024 12:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708690637;
	bh=dD+Amox90za99RFzb8DfVKU4tgSGxx3W9Z7qT51AAcI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pxxS1kycaZswlj15eFxU59COD51PSZN2AXkjIUp8pTrNIf+p05WWq4T3No8ZuytQE
	 S4rQrVDbJwPYHOde4GIgWD763DBD9v/zJZVH1Zo36B6Hrzkosc4Fyywo/kW1731sWb
	 YV42CAn+KSrrxLaXVRHSR6gHm7/9Cpu8sZGMmoi0X0qWg+fXpJ0EdV6dbervfMTd1O
	 nzCF9n7oaYWOiq5tnFQUM4+SpguW9DgKj7GX9Xo0Hn+9pG8ytEY5QcAwxBLqPpAQcF
	 6wYBwzGJ2Yggj/Z67/xWqa/YaoXRa2lTS8Yn9pzMCDZcuoaft5cVMyfSKvaFQvs65N
	 GYiWHUQbxU8mQ==
Date: Fri, 23 Feb 2024 13:17:14 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
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
Message-ID: <ZdiMympnNOo6e+5T@lothringen>
References: <20240217012745.3446231-1-boqun.feng@gmail.com>
 <20240217012745.3446231-7-boqun.feng@gmail.com>
 <ZdeI_-RfdLR8jlsm@localhost.localdomain>
 <e0472956-1b18-4a22-be6e-5dbbc11141eb@paulmck-laptop>
 <9a27f638-4eb0-42b3-b8a3-201d6ed9406b@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a27f638-4eb0-42b3-b8a3-201d6ed9406b@paulmck-laptop>

On Thu, Feb 22, 2024 at 02:56:46PM -0800, Paul E. McKenney wrote:
> On Thu, Feb 22, 2024 at 12:52:24PM -0800, Paul E. McKenney wrote:
> > > > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > > > index 4dc355b2ac22..866743e0796f 100644
> > > > --- a/kernel/rcu/tasks.h
> > > > +++ b/kernel/rcu/tasks.h
> > > > @@ -971,13 +971,32 @@ static void rcu_tasks_postscan(struct list_head *hop)
> > > >  	 */
> > > >  
> > > >  	for_each_possible_cpu(cpu) {
> > > > +		unsigned long j = jiffies + 1;
> > > >  		struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rcu_tasks.rtpcpu, cpu);
> > > >  		struct task_struct *t;
> > > > +		struct task_struct *t1;
> > > > +		struct list_head tmp;
> > > >  
> > > >  		raw_spin_lock_irq_rcu_node(rtpcp);
> > > > -		list_for_each_entry(t, &rtpcp->rtp_exit_list, rcu_tasks_exit_list)
> > > > +		list_for_each_entry_safe(t, t1, &rtpcp->rtp_exit_list, rcu_tasks_exit_list) {
> > > >  			if (list_empty(&t->rcu_tasks_holdout_list))
> > > >  				rcu_tasks_pertask(t, hop);
> > > > +
> > > > +			// RT kernels need frequent pauses, otherwise
> > > > +			// pause at least once per pair of jiffies.
> > > > +			if (!IS_ENABLED(CONFIG_PREEMPT_RT) && time_before(jiffies, j))
> > > > +				continue;
> > > > +
> > > > +			// Keep our place in the list while pausing.
> > > > +			// Nothing else traverses this list, so adding a
> > > > +			// bare list_head is OK.
> > > > +			list_add(&tmp, &t->rcu_tasks_exit_list);
> > > 
> > > I'm a bit confused about what this does...

Oh, ok now I see what you're doing! My fear was that t goes off but doesn't
remove itself and then the list_del() crashes. But no actually tmp places itself
after t and then if t exits, it removes itself before tmp and that's fine.

> > > 
> > > > +			raw_spin_unlock_irq_rcu_node(rtpcp);
> > > > +			cond_resched(); // For CONFIG_PREEMPT=n kernels
> > > > +			raw_spin_lock_irq_rcu_node(rtpcp);
> > > > +			list_del(&tmp);
> > > 
> > > Isn't there a risk that t is reaped by then? If it was not observed on_rq
> > > while calling rcu_tasks_pertask() then there is no get_task_struct.
> > 
> > That is OK, courtesy of the _safe in list_for_each_entry_safe().
> > 
> > > And what about t1? Can't it be reaped as well?
> > 
> > It can, and that is a problem, good catch!
> > 
> > My current thought is to add this before the list_del(), which is
> > admittedly a bit crude:
> > 
> > 			t1 = tmp.next;
> 
> OK, OK...  ;-)
> 
> 			t1 = list_entry(tmp.next, struct task_struct, rcu_tasks_exit_list);
> 
> Is there still a better way?

That should work.

An (untested) alternative that fiddles a bit less with list internals could look like this:

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 866743e0796f..0ff2b554f5b5 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -973,12 +973,13 @@ static void rcu_tasks_postscan(struct list_head *hop)
 	for_each_possible_cpu(cpu) {
 		unsigned long j = jiffies + 1;
 		struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rcu_tasks.rtpcpu, cpu);
-		struct task_struct *t;
-		struct task_struct *t1;
-		struct list_head tmp;
 
 		raw_spin_lock_irq_rcu_node(rtpcp);
-		list_for_each_entry_safe(t, t1, &rtpcp->rtp_exit_list, rcu_tasks_exit_list) {
+		while (!list_empty(&rtpcp->rtp_exit_list)) {
+			struct task_struct *t;
+			t = list_first_entry(&rtpcp->rtp_exit_list, typeof(*t), rcu_tasks_exit_list);
+			list_del_init(&t->rcu_tasks_exit_list);
+
 			if (list_empty(&t->rcu_tasks_holdout_list))
 				rcu_tasks_pertask(t, hop);
 
@@ -987,14 +988,9 @@ static void rcu_tasks_postscan(struct list_head *hop)
 			if (!IS_ENABLED(CONFIG_PREEMPT_RT) && time_before(jiffies, j))
 				continue;
 
-			// Keep our place in the list while pausing.
-			// Nothing else traverses this list, so adding a
-			// bare list_head is OK.
-			list_add(&tmp, &t->rcu_tasks_exit_list);
 			raw_spin_unlock_irq_rcu_node(rtpcp);
 			cond_resched(); // For CONFIG_PREEMPT=n kernels
 			raw_spin_lock_irq_rcu_node(rtpcp);
-			list_del(&tmp);
 			j = jiffies + 1;
 		}
 		raw_spin_unlock_irq_rcu_node(rtpcp);
@@ -1219,7 +1215,6 @@ void exit_tasks_rcu_stop(void)
 	struct rcu_tasks_percpu *rtpcp;
 	struct task_struct *t = current;
 
-	WARN_ON_ONCE(list_empty(&t->rcu_tasks_exit_list));
 	rtpcp = per_cpu_ptr(rcu_tasks.rtpcpu, t->rcu_tasks_exit_cpu);
 	raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
 	list_del_init(&t->rcu_tasks_exit_list);

