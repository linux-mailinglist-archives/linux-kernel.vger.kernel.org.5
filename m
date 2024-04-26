Return-Path: <linux-kernel+bounces-159914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A47A58B361B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F83A2836DB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4421448DA;
	Fri, 26 Apr 2024 10:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o7I7amxj"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9421442E8
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 10:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714128986; cv=none; b=noqAPeljinqQGB8ALclJRVg/DmYNS9ixYLHQ+O6Rra62E46jGlOIrJ6fo87hE3yHfdnhR5VoHy8f0YJR2N4gk5ewStmG7fpxPbyfQV8Rzj1NbIXjPafJKsnwGOK1pHc5WTwY7MlXLw7MAqfU9SQVl/KOXvvsBqrPVsEOHGKYrNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714128986; c=relaxed/simple;
	bh=+rxS8mFuJsj+zibyLrkWSQYzT3KkC9lXrTGuUkFPBh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dkxmswdeJp4Tn5q8ICewZ3E9DFbPwZg0KvA/+LpUlDiP9U9jH9jOgusMclfre9rqxQbEpBQop5AZJ4reNnYYKE6ineLhbBbt4euAndomqEfRvG2liZwSZLqP2XVWY42QxHOH7Bbvr/XB0W/PvcS4OuARSQH4BRuvK2kDuDMNSqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=o7I7amxj; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HIJVNue7WTCe5tgDHMAvFG1PdM9WUeLajLXx6n3t/MM=; b=o7I7amxjjfQJPf0v4ITzeln87h
	IlljTTKFISnbV5THlm54s+kQZdlid8o+Fr46+3WtrF2Gv0+9p85GMR+WQqx/t4EVIuBZZDkOfOtAO
	8BrDVa46I07VasCN8jhXa9xLwhxqEafXkEA/uvHY5VZRyw0e0XsT2dUUtiPiZnT3b7ugbxTRTXGJI
	qsbPwAVw0fUyvF4sd4HujqSbnfqe6JJr26VTZP1lZFyWVfHOiDZun0JuVvgak9C+7KysYTomVucXm
	a8JE9+I72W/OCBP5mkEVpxPAmFO8lgVedjnZci4W7lsb4y77HflFEvTPkdQAI59trvjIPfCiil/h/
	0s4rAUBA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0JFP-000000053Pt-26wM;
	Fri, 26 Apr 2024 10:56:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2947C3003EA; Fri, 26 Apr 2024 12:56:07 +0200 (CEST)
Date: Fri, 26 Apr 2024 12:56:07 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mike Galbraith <efault@gmx.de>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	linux-kernel@vger.kernel.org, wuyun.abel@bytedance.com,
	tglx@linutronix.de, Chen Yu <yu.c.chen@intel.com>,
	Oliver Sang <oliver.sang@intel.com>
Subject: Re: [RFC][PATCH 08/10] sched/fair: Implement delayed dequeue
Message-ID: <20240426105607.GK12673@noisy.programming.kicks-ass.net>
References: <20240405102754.435410987@infradead.org>
 <20240405110010.631664251@infradead.org>
 <557be85d-e1c1-0835-eebd-f76e32456179@amd.com>
 <ec6f811b9977eeef1b3f1b3fb951fda066fd95f5.camel@gmx.de>
 <14330cf4-8d9e-1e55-7717-653b800e5cee@amd.com>
 <747627a1414f1f33d0c237f555494149d6937800.camel@gmx.de>
 <2b9f7617f2b2130bb6270504ec3858f15d463f1d.camel@gmx.de>
 <20240425112855.GF21980@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425112855.GF21980@noisy.programming.kicks-ass.net>

On Thu, Apr 25, 2024 at 01:28:55PM +0200, Peter Zijlstra wrote:
> On Thu, Apr 18, 2024 at 06:24:59PM +0200, Mike Galbraith wrote:
> > The root cause seems to be doing the delay dequeue business on
> > exiting tasks. 
> 
> > ---
> >  kernel/sched/fair.c |    5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -5374,6 +5374,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, st
> >  		update_curr(cfs_rq);
> > 
> >  		if (sched_feat(DELAY_DEQUEUE) && sleep &&
> > +		    !(entity_is_task(se) && (task_of(se)->flags & PF_EXITING)) &&
> >  		    !entity_eligible(cfs_rq, se)) {
> >  			if (cfs_rq->next == se)
> >  				cfs_rq->next = NULL;
> 
> So I think this can be easier done in dequeue_task_fair(), where we
> still know this is a task.
> 
> Perhaps something like (I'll test later):
> 
> 	if (p->flags & PF_EXITING)
> 		flags &= ~DEQUEUE_SLEEP;
> 
> But now I need to go think about the case of removing a cgroup...
> *urgh*.

I ended up with the below instead; lemme go run this unixbench spawn on it.

---
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 95666034e76c..b5918fa9a0f0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8429,7 +8431,20 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
 
 static void task_dead_fair(struct task_struct *p)
 {
-	remove_entity_load_avg(&p->se);
+	struct sched_entity *se = &p->se;
+
+	if (p->se.sched_delayed) {
+		struct rq_flags rf;
+		struct rq *rq;
+
+		rq = task_rq_lock(p, &rf);
+		update_rq_clock(rq);
+		if (se->sched_delayed)
+			dequeue_entities(rq, se, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
+		task_rq_unlock(rq, p, &rf);
+	}
+
+	remove_entity_load_avg(se);
 }
 
 /*
@@ -13089,28 +13104,34 @@ void online_fair_sched_group(struct task_group *tg)
 
 void unregister_fair_sched_group(struct task_group *tg)
 {
-	unsigned long flags;
-	struct rq *rq;
 	int cpu;
 
 	destroy_cfs_bandwidth(tg_cfs_bandwidth(tg));
 
 	for_each_possible_cpu(cpu) {
-		if (tg->se[cpu])
-			remove_entity_load_avg(tg->se[cpu]);
+		struct cfs_rq *cfs_rq = tg->cfs_rq[cpu];
+		struct sched_entity *se = tg->se[cpu];
+		struct rq *rq = cpu_rq(cpu);
+
+		if (se) {
+			if (se->sched_delayed) {
+				guard(rq_lock_irqsave)(rq);
+				update_rq_clock(rq);
+				if (se->sched_delayed)
+					dequeue_entities(rq, se, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
+				list_del_leaf_cfs_rq(cfs_rq);
+			}
+			remove_entity_load_avg(se);
+		}
 
 		/*
 		 * Only empty task groups can be destroyed; so we can speculatively
 		 * check on_list without danger of it being re-added.
 		 */
-		if (!tg->cfs_rq[cpu]->on_list)
-			continue;
-
-		rq = cpu_rq(cpu);
-
-		raw_spin_rq_lock_irqsave(rq, flags);
-		list_del_leaf_cfs_rq(tg->cfs_rq[cpu]);
-		raw_spin_rq_unlock_irqrestore(rq, flags);
+		if (cfs_rq->on_list) {
+			guard(rq_lock_irqsave)(rq);
+			list_del_leaf_cfs_rq(cfs_rq);
+		}
 	}
 }
 

