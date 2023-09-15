Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3C67A1F30
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 14:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235156AbjIOMt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 08:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235106AbjIOMtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:49:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06861713
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 05:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=vvyr4ysvwC+14BCIXh6MvqNIHme9hgsvbApmalFbkI0=; b=N8lNK7E8zBEG2Ps40TqsaN6Deo
        fR5P+iReWILYXPBmkceH+fy5ncSWpVFxz6r0p8PqU03z7fk/wPr1KnEqpjb0sDT7LihOoZLyZfREB
        f2+4tnghqhbHA3HnjRPmhcF1rIJYqsR/a75/ZgMIXKqOlQXBJcodFCo0LRH951t54Z2rMkZIQuWIu
        OkAhlSW0fuYYLfymlHK6BkieIkwTbJGtSLf62603/LcLM9iukvM+m0orSpeeFASFGO/NMzEdF56E7
        C82LgyTkndjZvRGMfzUqT0dng+j4DBzak6GrsCsZp7WRYx53/gRsfMnvcP20d/dO0zFZ3hE8zCLFx
        AzBsPUoA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qh8Ft-009kyL-PT; Fri, 15 Sep 2023 12:49:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
        id 69EAB30067B; Fri, 15 Sep 2023 14:49:05 +0200 (CEST)
Message-Id: <20230915124822.956946622@noisy.programming.kicks-ass.net>
User-Agent: quilt/0.65
Date:   Fri, 15 Sep 2023 14:43:56 +0200
From:   peterz@infradead.org
To:     mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        vincent.guittot@linaro.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, corbet@lwn.net,
        qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, joshdon@google.com,
        timj@gnu.org, kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org, efault@gmx.de,
        tglx@linutronix.de, daniel.m.jordan@oracle.com
Subject: [PATCH 2/2] sched/eevdf: Use sched_attr::sched_runtime to set request/slice suggestion
References: <20230915124354.416936110@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-sched_attr-runtime.patch
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 include/linux/sched.h |    3 +++
 kernel/sched/core.c   |   33 ++++++++++++++++++++++++++-------
 kernel/sched/fair.c   |    6 ++++--
 3 files changed, 33 insertions(+), 9 deletions(-)

Index: linux-2.6/include/linux/sched.h
===================================================================
--- linux-2.6.orig/include/linux/sched.h
+++ linux-2.6/include/linux/sched.h
@@ -555,6 +555,9 @@ struct sched_entity {
 	struct list_head		group_node;
 	unsigned int			on_rq;
 
+	unsigned int			custom_slice : 1;
+					/* 31 bits hole */
+
 	u64				exec_start;
 	u64				sum_exec_runtime;
 	u64				prev_sum_exec_runtime;
Index: linux-2.6/kernel/sched/core.c
===================================================================
--- linux-2.6.orig/kernel/sched/core.c
+++ linux-2.6/kernel/sched/core.c
@@ -4501,7 +4501,6 @@ static void __sched_fork(unsigned long c
 	p->se.nr_migrations		= 0;
 	p->se.vruntime			= 0;
 	p->se.vlag			= 0;
-	p->se.slice			= sysctl_sched_base_slice;
 	INIT_LIST_HEAD(&p->se.group_node);
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
@@ -4755,6 +4754,8 @@ int sched_fork(unsigned long clone_flags
 
 		p->prio = p->normal_prio = p->static_prio;
 		set_load_weight(p, false);
+		p->se.custom_slice = 0;
+		p->se.slice = sysctl_sched_base_slice;
 
 		/*
 		 * We don't need the reset flag anymore after the fork. It has
@@ -7552,10 +7553,20 @@ static void __setscheduler_params(struct
 
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
@@ -7740,7 +7751,9 @@ recheck:
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
@@ -7886,6 +7899,9 @@ static int _sched_setscheduler(struct ta
 		.sched_nice	= PRIO_TO_NICE(p->static_prio),
 	};
 
+	if (p->se.custom_slice)
+		attr.sched_runtime = p->se.slice;
+
 	/* Fixup the legacy SCHED_RESET_ON_FORK hack. */
 	if ((policy != SETPARAM_POLICY) && (policy & SCHED_RESET_ON_FORK)) {
 		attr.sched_flags |= SCHED_FLAG_RESET_ON_FORK;
@@ -8062,12 +8078,14 @@ err_size:
 
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
@@ -10086,6 +10104,7 @@ void __init sched_init(void)
 	}
 
 	set_load_weight(&init_task, false);
+	init_task.se.slice = sysctl_sched_base_slice,
 
 	/*
 	 * The boot idle thread does lazy MMU switching as well:
Index: linux-2.6/kernel/sched/fair.c
===================================================================
--- linux-2.6.orig/kernel/sched/fair.c
+++ linux-2.6/kernel/sched/fair.c
@@ -974,7 +974,8 @@ static void update_deadline(struct cfs_r
 	 * nice) while the request time r_i is determined by
 	 * sysctl_sched_base_slice.
 	 */
-	se->slice = sysctl_sched_base_slice;
+	if (!se->custom_slice)
+		se->slice = sysctl_sched_base_slice;
 
 	/*
 	 * EEVDF: vd_i = ve_i + r_i / w_i
@@ -4922,7 +4923,8 @@ place_entity(struct cfs_rq *cfs_rq, stru
 	u64 vslice, vruntime = avg_vruntime(cfs_rq);
 	s64 lag = 0;
 
-	se->slice = sysctl_sched_base_slice;
+	if (!se->custom_slice)
+		se->slice = sysctl_sched_base_slice;
 	vslice = calc_delta_fair(se->slice, se);
 
 	/*


