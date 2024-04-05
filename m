Return-Path: <linux-kernel+bounces-132885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B46899B90
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32D1AB23DF9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DDD16C430;
	Fri,  5 Apr 2024 11:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ISYk+F8U"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E060116D4D4
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 11:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712315052; cv=none; b=SRlv1PS+Fmwc5wZ2tMVAWx94m4B5RrmfwZF19KylUlE50kW/OQA/+zKfvULdE4UcwmLd50TQPE0xifVjoE3CHfuOzE1r6e7lZ7AkpcK/ddUNbrzCJFFTxn2AX3Lis/3LmnVzJxHIvWwWvOanbviQpaDh/fsh/e99+k/ZBB3DjEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712315052; c=relaxed/simple;
	bh=5Y2fyNUHD/NYL9OTkH1o2QuB1uTrify2VwkvSF8Fd+8=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=I0ybOIERuDdIQN+YBoeE1IWyjjmf8ZNpVgYPVm0yh3Kbr9IOmXiLyuC616M3gaCA432CgdEKd/5o/dmEL4BY8eTdkEbo1Nlwuv0+v7uFVGnGE6KIleI5iavxaU5Y8k0VkTlp1Kz+W7ZLpUDAYCmWgmzU9wEvNrotkZU3vnNbhnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ISYk+F8U; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=grzrP4wXEBMeBZEyaJ+pITjDHDMxy2pyhIBAHe0RxZc=; b=ISYk+F8UgOTBeA9cgGR62fREyK
	exLG0xM1sEM+BpXyrNR3ZhzZB2NkG14elrR6CrarQqe7wK8FnjdzgzQYSqqXSmkFqHGN/jkZeD+h2
	PrVRC9XdkqQFWNFcWQnrfG3zFodgb0EU+6QMdOHH10Xti2VYXveIOibmJzWGU82X8xsMleCvUpXx4
	zbzRzPwU/8Wc100yjSe9Y68e97NWO93xyDMLYfEfUveXId6znmiP99rle/5jDVQxyo/FOzNxH7y6O
	OXzOEQkrrMG4+5HziisJGFKYn9Md/hCyK3+O/Uhzso0urX29Hn78DpK2xVwHcKz7EBVQSvXrZApRl
	Q2n0StYw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rshMH-00000005Z8l-4A7Z;
	Fri, 05 Apr 2024 11:03:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id A75A1302DD3; Fri,  5 Apr 2024 13:03:44 +0200 (CEST)
Message-Id: <20240405110010.934104715@infradead.org>
User-Agent: quilt/0.65
Date: Fri, 05 Apr 2024 12:28:04 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@redhat.com,
 peterz@infradead.org,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 bristot@redhat.com,
 vschneid@redhat.com,
 linux-kernel@vger.kernel.org
Cc: kprateek.nayak@amd.com,
 wuyun.abel@bytedance.com,
 tglx@linutronix.de,
 efault@gmx.de
Subject: [RFC][PATCH 10/10] sched/eevdf: Use sched_attr::sched_runtime to set request/slice suggestion
References: <20240405102754.435410987@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Allow applications to directly set a suggested request/slice length using
sched_attr::sched_runtime.

The implementation clamps the value to: 0.1[ms] <= slice <= 100[ms]
which is 1/10 the size of HZ=1000 and 10 times the size of HZ=100.

Applications should strive to use their periodic runtime at a high
confidence interval (95%+) as the target slice. Using a smaller slice
will introduce undue preemptions, while using a larger value will
increase latency.

For all the following examples assume a scheduling quantum of 8, and for
consistency all examples have W=4:

  {A,B,C,D}(w=1,r=8):

  ABCD...
  +---+---+---+---

  t=0, V=1.5				t=1, V=3.5
  A  |------<				A          |------<
  B   |------<				B   |------<
  C    |------<				C    |------<
  D     |------<			D     |------<
  ---+*------+-------+---		---+--*----+-------+---

  t=2, V=5.5				t=3, V=7.5
  A          |------<			A          |------<
  B           |------<			B           |------<
  C    |------<				C            |------<
  D     |------<			D     |------<
  ---+----*--+-------+---		---+------*+-------+---

Note: 4 identical tasks in FIFO order

~~~

  {A,B}(w=1,r=16) C(w=2,r=16)

  AACCBBCC...
  +---+---+---+---

  t=0, V=1.25				t=2, V=5.25
  A  |--------------<                   A                  |--------------<
  B   |--------------<                  B   |--------------<
  C    |------<                         C    |------<
  ---+*------+-------+---               ---+----*--+-------+---

  t=4, V=8.25				t=6, V=12.25
  A                  |--------------<   A                  |--------------<
  B   |--------------<                  B                   |--------------<
  C            |------<                 C            |------<
  ---+-------*-------+---               ---+-------+---*---+---

Note: 1 heavy task -- because q=8, double r such that the deadline of the w=2
      task doesn't go below q.

Note: observe the full schedule becomes: W*max(r_i/w_i) = 4*2q = 8q in length.

Note: the period of the heavy task is half the full period at:
      W*(r_i/w_i) = 4*(2q/2) = 4q

~~~

  {A,C,D}(w=1,r=16) B(w=1,r=8):

  BAACCBDD...
  +---+---+---+---

  t=0, V=1.5				t=1, V=3.5
  A  |--------------<			A  |---------------<
  B   |------<				B           |------<
  C    |--------------<			C    |--------------<
  D     |--------------<		D     |--------------<
  ---+*------+-------+---		---+--*----+-------+---

  t=3, V=7.5				t=5, V=11.5
  A                  |---------------<  A                  |---------------<
  B           |------<                  B           |------<
  C    |--------------<                 C                    |--------------<
  D     |--------------<                D     |--------------<
  ---+------*+-------+---               ---+-------+--*----+---

  t=6, V=13.5
  A                  |---------------<
  B                   |------<
  C                    |--------------<
  D     |--------------<
  ---+-------+----*--+---

Note: 1 short task -- again double r so that the deadline of the short task
      won't be below q. Made B short because its not the leftmost task, but is
      eligible with the 0,1,2,3 spread.

Note: like with the heavy task, the period of the short task observes:
      W*(r_i/w_i) = 4*(1q/1) = 4q

~~~

  A(w=1,r=16) B(w=1,r=8) C(w=2,r=16)

  BCCAABCC...
  +---+---+---+---

  t=0, V=1.25				t=1, V=3.25
  A  |--------------<                   A  |--------------<
  B   |------<                          B           |------<
  C    |------<                         C    |------<
  ---+*------+-------+---               ---+--*----+-------+---

  t=3, V=7.25				t=5, V=11.25
  A  |--------------<                   A                  |--------------<
  B           |------<                  B           |------<
  C            |------<                 C            |------<
  ---+------*+-------+---               ---+-------+--*----+---

  t=6, V=13.25
  A                  |--------------<
  B                   |------<
  C            |------<
  ---+-------+----*--+---

Note: 1 heavy and 1 short task -- combine them all.

Note: both the short and heavy task end up with a period of 4q

~~~

  A(w=1,r=16) B(w=2,r=16) C(w=1,r=8)

  BBCAABBC...
  +---+---+---+---

  t=0, V=1				t=2, V=5
  A  |--------------<                   A  |--------------<
  B   |------<                          B           |------<
  C    |------<                         C    |------<
  ---+*------+-------+---               ---+----*--+-------+---

  t=3, V=7				t=5, V=11
  A  |--------------<                   A                  |--------------<
  B           |------<                  B           |------<
  C            |------<                 C            |------<
  ---+------*+-------+---               ---+-------+--*----+---

  t=7, V=15
  A                  |--------------<
  B                   |------<
  C            |------<
  ---+-------+------*+---

Note: as before but permuted

~~~

>From all this it can be deduced that, for the steady state:

 - the total period (P) of a schedule is:	W*max(r_i/w_i)
 - the average period of a task is:		W*(r_i/w_i)
 - each task obtains the fair share:		w_i/W of each full period P

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched.h |    5 ++++-
 kernel/sched/core.c   |   33 ++++++++++++++++++++++++++-------
 kernel/sched/debug.c  |    3 ++-
 kernel/sched/fair.c   |    6 ++++--
 4 files changed, 36 insertions(+), 11 deletions(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -542,7 +542,10 @@ struct sched_entity {
 
 	struct list_head		group_node;
 	unsigned int			on_rq;
-	unsigned int			sched_delayed;
+
+	unsigned char			sched_delayed;
+	unsigned char			custom_slice;
+					/* 2 byte hole */
 
 	u64				exec_start;
 	u64				sum_exec_runtime;
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4550,7 +4550,6 @@ static void __sched_fork(unsigned long c
 	p->se.nr_migrations		= 0;
 	p->se.vruntime			= 0;
 	p->se.vlag			= 0;
-	p->se.slice			= sysctl_sched_base_slice;
 	INIT_LIST_HEAD(&p->se.group_node);
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
@@ -4801,6 +4800,8 @@ int sched_fork(unsigned long clone_flags
 
 		p->prio = p->normal_prio = p->static_prio;
 		set_load_weight(p, false);
+		p->se.custom_slice = 0;
+		p->se.slice = sysctl_sched_base_slice;
 
 		/*
 		 * We don't need the reset flag anymore after the fork. It has
@@ -7627,10 +7628,20 @@ static void __setscheduler_params(struct
 
 	p->policy = policy;
 
-	if (dl_policy(policy))
+	if (dl_policy(policy)) {
 		__setparam_dl(p, attr);
-	else if (fair_policy(policy))
+	} else if (fair_policy(policy)) {
 		p->static_prio = NICE_TO_PRIO(attr->sched_nice);
+		if (attr->sched_runtime) {
+			p->se.custom_slice = 1;
+			p->se.slice = clamp_t(u64, attr->sched_runtime,
+					      NSEC_PER_MSEC/10,   /* HZ=1000 * 10 */
+					      NSEC_PER_MSEC*100); /* HZ=100  / 10 */
+		} else {
+			p->se.custom_slice = 0;
+			p->se.slice = sysctl_sched_base_slice;
+		}
+	}
 
 	/*
 	 * __sched_setscheduler() ensures attr->sched_priority == 0 when
@@ -7812,7 +7823,9 @@ static int __sched_setscheduler(struct t
 	 * but store a possible modification of reset_on_fork.
 	 */
 	if (unlikely(policy == p->policy)) {
-		if (fair_policy(policy) && attr->sched_nice != task_nice(p))
+		if (fair_policy(policy) &&
+		    (attr->sched_nice != task_nice(p) ||
+		     (attr->sched_runtime && attr->sched_runtime != p->se.slice)))
 			goto change;
 		if (rt_policy(policy) && attr->sched_priority != p->rt_priority)
 			goto change;
@@ -7958,6 +7971,9 @@ static int _sched_setscheduler(struct ta
 		.sched_nice	= PRIO_TO_NICE(p->static_prio),
 	};
 
+	if (p->se.custom_slice)
+		attr.sched_runtime = p->se.slice;
+
 	/* Fixup the legacy SCHED_RESET_ON_FORK hack. */
 	if ((policy != SETPARAM_POLICY) && (policy & SCHED_RESET_ON_FORK)) {
 		attr.sched_flags |= SCHED_FLAG_RESET_ON_FORK;
@@ -8124,12 +8140,14 @@ static int sched_copy_attr(struct sched_
 
 static void get_params(struct task_struct *p, struct sched_attr *attr)
 {
-	if (task_has_dl_policy(p))
+	if (task_has_dl_policy(p)) {
 		__getparam_dl(p, attr);
-	else if (task_has_rt_policy(p))
+	} else if (task_has_rt_policy(p)) {
 		attr->sched_priority = p->rt_priority;
-	else
+	} else {
 		attr->sched_nice = task_nice(p);
+		attr->sched_runtime = p->se.slice;
+	}
 }
 
 /**
@@ -10084,6 +10102,7 @@ void __init sched_init(void)
 	}
 
 	set_load_weight(&init_task, false);
+	init_task.se.slice = sysctl_sched_base_slice,
 
 	/*
 	 * The boot idle thread does lazy MMU switching as well:
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -579,11 +579,12 @@ print_task(struct seq_file *m, struct rq
 	else
 		SEQ_printf(m, " %c", task_state_to_char(p));
 
-	SEQ_printf(m, "%15s %5d %9Ld.%06ld %c %9Ld.%06ld %9Ld.%06ld %9Ld.%06ld %9Ld %5d ",
+	SEQ_printf(m, "%15s %5d %9Ld.%06ld %c %9Ld.%06ld %c %9Ld.%06ld %9Ld.%06ld %9Ld %5d ",
 		p->comm, task_pid_nr(p),
 		SPLIT_NS(p->se.vruntime),
 		entity_eligible(cfs_rq_of(&p->se), &p->se) ? 'E' : 'N',
 		SPLIT_NS(p->se.deadline),
+		p->se.custom_slice ? 'S' : ' ',
 		SPLIT_NS(p->se.slice),
 		SPLIT_NS(p->se.sum_exec_runtime),
 		(long long)(p->nvcsw + p->nivcsw),
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -984,7 +984,8 @@ static void update_deadline(struct cfs_r
 	 * nice) while the request time r_i is determined by
 	 * sysctl_sched_base_slice.
 	 */
-	se->slice = sysctl_sched_base_slice;
+	if (!se->custom_slice)
+		se->slice = sysctl_sched_base_slice;
 
 	/*
 	 * EEVDF: vd_i = ve_i + r_i / w_i
@@ -5169,7 +5170,8 @@ place_entity(struct cfs_rq *cfs_rq, stru
 	u64 vslice, vruntime = avg_vruntime(cfs_rq);
 	s64 lag = 0;
 
-	se->slice = sysctl_sched_base_slice;
+	if (!se->custom_slice)
+		se->slice = sysctl_sched_base_slice;
 	vslice = calc_delta_fair(se->slice, se);
 
 	/*



