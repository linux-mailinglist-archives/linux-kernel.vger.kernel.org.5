Return-Path: <linux-kernel+bounces-6107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7858194B1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D66F1F253D6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 23:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B671D40BE9;
	Tue, 19 Dec 2023 23:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pc9pAhDv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD2040BE4
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 23:42:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 037CEC433C7;
	Tue, 19 Dec 2023 23:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703029347;
	bh=aEx6B6Q64Y892F9XBs5+b2dv64GtALZwtZNoKj2mxyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pc9pAhDvK/Lql88r/Us7KeJ/DRr+/CGI+F30ltXhtn8EhwXW9dpSTtyPwMhJT7z9+
	 3T8MQhrG3D7QgLxJ1+WGzpdXvnmb0ChhUxE78aVZjuhIEdtjdsovVqFhdpZL2GdgKl
	 /7nXGRQ5TDGFmEDxhigQneFEHeXkhNDRPbWBHK28SgpRk32HdT1yMNvjA4LjjvUfN7
	 evagLYeW/iRWuJTvpM3NLSgoK0OBdQekEjmZqxpzt0TwAAV14CoalPsWzXMNhQSoRs
	 BoqzPk7f5SWL4t0Yt1JZma2avRKzfdnnEkIkE9zDjB6nnUY3sJ9LCc06YVghPqMtse
	 rqZLFi4amlRTA==
Date: Wed, 20 Dec 2023 00:42:24 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Hillf Danton <hdanton@sina.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/3] rcu: Defer RCU kthreads wakeup when CPU is dying
Message-ID: <ZYIqYEW/m5SyyFq8@lothringen>
References: <20231218231916.11719-1-frederic@kernel.org>
 <20231219044247.1708-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219044247.1708-1-hdanton@sina.com>

On Tue, Dec 19, 2023 at 12:42:47PM +0800, Hillf Danton wrote:
> On Tue, 19 Dec 2023 00:19:15 +0100 Frederic Weisbecker <frederic@kernel.org>
> > +static void swake_up_one_online(struct swait_queue_head *wqh)
> > +{
> > +	int cpu = get_cpu();
> > +
> > +	/*
> > +	 * If called from rcutree_report_cpu_starting(), wake up
> > +	 * is dangerous that late in the CPU-down hotplug process. The
> > +	 * scheduler might queue an ignored hrtimer. Defer the wake up
> > +	 * to an online CPU instead.
> > +	 */
> 
> But why is scheduler having any interest selecting a dying CPU for
> adding a hrtimer on at the first place?

So indeed that timer could be unpinned. But we tried that and it's not
enough. If we want to make hrtimers and nohz infrastructure aware of
the fact the current CPU is offline when it queues an hrtimer, we must
face the ugliness below. And still it's hacky because we must also find an
online target whose earliest deadline is below/equal the scheduler hrtimer
we are trying to enqueue. And that requires even more ugliness that isn't
handled below.

So for now I assume that queuing a timer after hrtimers_cpu_dying() is
unreasonable and that RCU is the only candidate trying that. If there are
more to be reported, we shall see...

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index f2044d5a652b..9eac39fad31c 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -234,6 +234,7 @@ struct hrtimer_cpu_base {
 	struct hrtimer			*next_timer;
 	ktime_t				softirq_expires_next;
 	struct hrtimer			*softirq_next_timer;
+	int online;
 	struct hrtimer_clock_base	clock_base[HRTIMER_MAX_CLOCK_BASES];
 } ____cacheline_aligned;
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a708d225c28e..83c75768f290 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1088,7 +1088,7 @@ int get_nohz_timer_target(void)
 	struct sched_domain *sd;
 	const struct cpumask *hk_mask;
 
-	if (housekeeping_cpu(cpu, HK_TYPE_TIMER)) {
+	if (housekeeping_cpu(cpu, HK_TYPE_TIMER) && cpu_online(cpu)) {
 		if (!idle_cpu(cpu))
 			return cpu;
 		default_cpu = cpu;
@@ -1109,7 +1109,8 @@ int get_nohz_timer_target(void)
 	}
 
 	if (default_cpu == -1)
-		default_cpu = housekeeping_any_cpu(HK_TYPE_TIMER);
+		default_cpu = cpumask_any_and(housekeeping_cpumask(HK_TYPE_TIMER),
+					      cpu_online_mask);
 
 	return default_cpu;
 }
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 6aaf0a3d6081..26cb9455272a 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -118,7 +118,7 @@ static inline void do_start_rt_bandwidth(struct rt_bandwidth *rt_b)
 		 */
 		hrtimer_forward_now(&rt_b->rt_period_timer, ns_to_ktime(0));
 		hrtimer_start_expires(&rt_b->rt_period_timer,
-				      HRTIMER_MODE_ABS_PINNED_HARD);
+				      HRTIMER_MODE_ABS_HARD);
 	}
 	raw_spin_unlock(&rt_b->rt_runtime_lock);
 }
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 760793998cdd..82f9ace2e4fd 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -36,6 +36,7 @@
 #include <linux/sched/sysctl.h>
 #include <linux/sched/rt.h>
 #include <linux/sched/deadline.h>
+#include <linux/sched/isolation.h>
 #include <linux/sched/nohz.h>
 #include <linux/sched/debug.h>
 #include <linux/timer.h>
@@ -206,6 +207,12 @@ struct hrtimer_cpu_base *get_target_base(struct hrtimer_cpu_base *base,
 #if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
 	if (static_branch_likely(&timers_migration_enabled) && !pinned)
 		return &per_cpu(hrtimer_bases, get_nohz_timer_target());
+#else
+	if (!base->online) {
+		int cpu = cpumask_any_and(housekeeping_cpumask(HK_TYPE_TIMER),
+					  cpu_online_mask);
+		base = &per_cpu(hrtimer_bases, cpu);
+	}
 #endif
 	return base;
 }
@@ -254,7 +261,13 @@ switch_hrtimer_base(struct hrtimer *timer, struct hrtimer_clock_base *base,
 		raw_spin_lock(&new_base->cpu_base->lock);
 
 		if (new_cpu_base != this_cpu_base &&
-		    hrtimer_check_target(timer, new_base)) {
+		    hrtimer_check_target(timer, new_base) &&
+		    /*
+		     * Crude hack and buggy: if this CPU is offline and
+		     * the timer is the earliest on the remote target, the timer
+		     * will expire late...
+		     */
+		    this_cpu_base->online) {
 			raw_spin_unlock(&new_base->cpu_base->lock);
 			raw_spin_lock(&base->cpu_base->lock);
 			new_cpu_base = this_cpu_base;
@@ -2183,6 +2196,7 @@ int hrtimers_prepare_cpu(unsigned int cpu)
 	cpu_base->softirq_next_timer = NULL;
 	cpu_base->expires_next = KTIME_MAX;
 	cpu_base->softirq_expires_next = KTIME_MAX;
+	cpu_base->online = 1;
 	hrtimer_cpu_base_init_expiry_lock(cpu_base);
 	return 0;
 }
@@ -2248,7 +2262,7 @@ int hrtimers_cpu_dying(unsigned int dying_cpu)
 	__hrtimer_get_next_event(new_base, HRTIMER_ACTIVE_SOFT);
 	/* Tell the other CPU to retrigger the next event */
 	smp_call_function_single(ncpu, retrigger_next_event, NULL, 0);
-
+	old_base->online = 0;
 	raw_spin_unlock(&new_base->lock);
 	raw_spin_unlock(&old_base->lock);
 

