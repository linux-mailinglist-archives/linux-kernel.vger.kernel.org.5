Return-Path: <linux-kernel+bounces-110019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A500C8858F7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A3CEB2275F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 12:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B02A762FA;
	Thu, 21 Mar 2024 12:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="NW+GZeoH"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F7E224F2
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 12:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711023645; cv=none; b=O/A7kPOHKPP4YWBuqZ5KQLddd0iuvtSj8cDlH9TzdinOeZtBJdR3cYNEzdmewFzSQkoeMXJ4jMGQlWej+ypMRnsvYooXcInb3/OH6hNFXMiw2wcRsA343NdnWEwZOg0kxhjoPdHiSgcdv7AjtcDnEIXDpuVJNtxbK9DlGG7Txbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711023645; c=relaxed/simple;
	bh=z7LDdfllwJu48JaZ/Nej+e7s/IT8dLpUv6vXI1KXRW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGclxkkkdVTvBw82LPRLFPYwp7QFZW2p4/9OhOGdDQvpRaXqS0p2xpeXadcXDY1LrFSMembmQaPkAbgJU6YNcwZnWmwlwNvaqxFrWC8c1UO6K97wwjG0WgRDaYdPQ98RdnQbF0IWn4+xpdEnVem42wkW5gUvwPU3wtonrFjo3Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=NW+GZeoH; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4146e9eadfaso6389925e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 05:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1711023641; x=1711628441; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xkT9rhjSnIvGD86mWzv33h0PkVQc3TF175cE9CIKu4c=;
        b=NW+GZeoHxWPGcPYTEwPygU8R9Y7GzAeuC+P+Bmr26mZvQHT9ulYINaX4X9o4Ei3i4Z
         UoYxzllNSMkMzOXPoF2jyF0c5fp/lQg0uBcqeAoC94R4cBY5/r9DR4rRWJWHm+XLGJjB
         /7N+frqOFGAcZH5DzhDuRY5tCawFSt/9H5T8l0xO5svkF8h81+moZyBNFiQ/4Ryw51uQ
         jiLmQBbR4uJxTbJqDAXWEZhMUC/fWYehlyd8IVwCzMLvqxfV1wr2GyNSkn6VpnuI08N3
         PUbe11Qlq8nMKKTVmgPx6/vClB/TdwczsnLrKmUM+JVc85ey1r8uKFUbyd9Q49tKxcqy
         5gmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711023641; x=1711628441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xkT9rhjSnIvGD86mWzv33h0PkVQc3TF175cE9CIKu4c=;
        b=rn7xfucYKFWdkbgGa81s5N8An5WganitDgX2v0HRUvBKE4jxW6lu/8mXANLR22VzEO
         AMyB5LS7h81A4zbEScozLk7Dc3zb6UrCfjTe3rSAfr4g09u5Or5Qi3bXkx12/o43yVFm
         t1yg16bdTzJ74MWzF4lCWSJu3QAKkPNE7FQNhPOylVHQCy+iX8sBxnCZ3Uct0x7L1TpS
         q99yzvikKVvllNrUjMxnbx35aNmdOLfJgAPh9ss/2C3qX1rHBWrdmai6IybZaTYRfOAo
         syOI5LHl/AVeKSje+m9rOQ+H26HztAxHnxZLjaqrtBZh741hseOhHfUe7AUbC1otH1yk
         Q8Ag==
X-Forwarded-Encrypted: i=1; AJvYcCX7V3TK0dHZJSKTeNrkDlH0+CPfecbDLMpdn99Ccj1WfFezc0BWqo2+gonz6DMAWXEr+CUenb1zf56mXl7n88zJsOCZ0KihdbArY74k
X-Gm-Message-State: AOJu0Yx/W9bDal82l1h6tn25KdJsdrz93XNjCMe+NMCh2mcVThbq/i3Q
	KzlpionvXxYPnxUKrCPVsijUJcn2aXNSYEfXvXu/F8I7UJSLK57lJkH/x3F7mdQ=
X-Google-Smtp-Source: AGHT+IHmMVmlqsSK4TLXXcmzZvH4LX+tgd9+MIRj5i5/5UISfx2wxl+m8i9Bb/pir8kpc6qTyxqj/g==
X-Received: by 2002:a05:600c:2116:b0:413:1741:28b5 with SMTP id u22-20020a05600c211600b00413174128b5mr6024252wml.9.1711023641234;
        Thu, 21 Mar 2024 05:20:41 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id l5-20020a05600c1d0500b004146a1bf590sm5460721wms.32.2024.03.21.05.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 05:20:40 -0700 (PDT)
Date: Thu, 21 Mar 2024 12:20:39 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	Pierre Gondois <Pierre.Gondois@arm.com>
Subject: Re: [PATCH v6 2/4] sched/fair: Check a task has a fitting cpu when
 updating misfit
Message-ID: <20240321122039.7gk2mc3syvkrvhjz@airbuntu>
References: <20240220225622.2626569-1-qyousef@layalina.io>
 <20240220225622.2626569-3-qyousef@layalina.io>
 <d6699c3a-3df6-46a3-98db-e07c8722f106@arm.com>
 <20240303174416.7m3gv5wywcmedov4@airbuntu>
 <20240306214704.uditboboedut2lm2@airbuntu>
 <CAKfTPtBLUkZ0hEd8K=e9wjg+zn9N5jgia-7wwLa3jaeYK+qkCw@mail.gmail.com>
 <20240307103527.y5zrnkjvwoqhtyll@airbuntu>
 <c39352f3-6018-49c5-b413-b8da1b601d65@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c39352f3-6018-49c5-b413-b8da1b601d65@arm.com>

On 03/07/24 18:54, Dietmar Eggemann wrote:
> On 07/03/2024 11:35, Qais Yousef wrote:
> > On 03/07/24 10:14, Vincent Guittot wrote:
> >> On Wed, 6 Mar 2024 at 22:47, Qais Yousef <qyousef@layalina.io> wrote:
> >>>
> >>> On 03/03/24 17:44, Qais Yousef wrote:
> >>>
> >>>>       diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >>>>       index 174687252e1a..b0e60a565945 100644
> >>>>       --- a/kernel/sched/fair.c
> >>>>       +++ b/kernel/sched/fair.c
> >>>>       @@ -8260,6 +8260,8 @@ static void set_task_max_allowed_capacity(struct task_struct *p)
> >>>>                       cpumask_t *cpumask;
> >>>>
> >>>>                       cpumask = cpu_capacity_span(entry);
> >>>>       +               if (!cpumask_intersects(cpu_active_mask, cpumask))
> >>>>       +                       continue;
> >>>>                       if (!cpumask_intersects(p->cpus_ptr, cpumask))
> >>>>                               continue;
> >>>>
> >>>>       @@ -8269,6 +8271,53 @@ static void set_task_max_allowed_capacity(struct task_struct *p)
> >>>>               rcu_read_unlock();
> >>>>        }
> >>>>
> >>>>       +static void __update_tasks_max_allowed_capacity(unsigned long capacity)
> >>>>       +{
> >>>>       +       struct task_struct *g, *p;
> >>>>       +
> >>>>       +       for_each_process_thread(g, p) {
> >>>>       +               if (fair_policy(p->policy) && p->max_allowed_capacity == capacity)
> >>>
> >>> This condition actually not good enough. We need to differentiate between going
> >>> online/offline. I didn't want to call set_task_max_allowed_capacity()
> >>> unconditionally and make hotplug even slower.
> >>
> >> But should we even try to fix this ? hotplugging a cpu is a special
> >> case and with patch 4 you will not increase lb_interval anymore
> > 
> > I don't care to be honest and this was my first reaction, but I couldn't ignore
> > the report.
> 
> Seeing a 'max_allowed_capacity' on the task which is not achievable
> anymore due to CPU hp will still cause MF activity. So it's a special
> case but CPU hp is part of mainline ... ?

We shouldn't leave anything broken for sure. What's the failure mode you're
worrying about? The side effect is that we'll do unnecessary misfit load
balance. The biggest impact I see is that if we have true imbalance, then
because misfit_lb type is more important of other ones then we can end up
delaying the other type of lb. But we won't drive the balance_interval etc high
anymore.

> 
> > I will need to do something to handle the dynamic EM changing capacities anyway
> > after 6.9 merge window. Or maybe now; I still haven't thought about it. I am
> 
> Do you think about the case that the reloadable EM contains a
> 'table[ highest OPP].performance' value which is different to
> arch_scale_cpu_capacity()?

Yeah, this is supported right?

> 
> Can we reject those EM reloads to avoid this mismatch?

This would defeat the purpose of updating the EM though?

> 
> > hoping I can trigger the update somewhere from the topology code. Maybe that
> > work will make handling hotplug easier than the approach I've taken now on
> > rq_online/offline.
> > 
> > FWIW, I have a working patch that solves the problem. The only drawback is that
> > rq_online/offline() are not only called from sched_cpu_activate/deactivate()
> > path but from build_sched_domains() path which for some reasons ends up calling
> > rq_offline/online() for each cpu in the map.  To be even more efficient I need
> 
> This can be avoided IMHO when you do this only for 'cpu_of(rq) ==
> smp_processor_id()'.

It feels hacky, but probably the more straightforward way to do it. I was
thinking we can refactor to be more specific when rq_offline() is done due to
hotplug or not.

> 
> For off-lining there will be only one such call to rq_offline_fair()
> (from sched_cpu_deactivate()) but for on-lining there are still 2 such
> calls to rq_online_fair() (from sched_cpu_activate() and rq_attach_root()).
> 
> > to teach rq_offline/online() to differentiate between the two. Or refactor the
> > code. Which if you don't think it's important too I'd be happy to drop this and
> > replace it with a comment to see if someone cares. Only testing and dev could
> > end up using hotplug; so there could be a difference in behavior in regards how
> > often misfit migration can kick. But as you said hopefully with these fixes
> > it'd just end up being unnecessary work. The only potential problem maybe is
> > that misfit lb has a precedence over other types of lb types; so we could
> > end up delaying load imbalance if there's a pointless misfit lb?
> > 
> > I'm happy to follow the crowd. But it'd be nice if this series can be made
> > mergeable with follow up work. It'd make life much easier for me.
> 
> Or is the plan to only go with '[PATCH v6 4/4] sched/fair: Don't double
> balance_interval for migrate_misfit' ?

Yeah I think this is enough as hotplug operations to make a whole capacity
level disappear is not a normal operation even during testing and development
which. Systems with a single big core could easily lead to this situation, but
if someone is testing with this, then the perf impact of losing this whole
capacity level is more impactful than the minor sub optimality we have here.
Load balance should not be delayed, but could kick off unnecessarily.

I think we can skip the handling unless someone comes up with a stronger reason
to care, but for the record here's a working patch. Unless I hear strong
opinions it is worth it, I'll send v8 to address your other comments.


Thanks!

--
Qais Yousef


--->8---


From b350e1abd7006873336c35005adfa6b3d8c807bf Mon Sep 17 00:00:00 2001
From: Qais Yousef <qyousef@layalina.io>
Date: Mon, 5 Feb 2024 02:08:25 +0000
Subject: [PATCH 2/4] sched/fair: Check a task has a fitting cpu when updating
 misfit

If a misfit task is affined to a subset of the possible cpus, we need to
verify that one of these cpus can fit it. Otherwise the load balancer
code will continuously trigger needlessly leading the balance_interval
to increase in return and eventually end up with a situation where real
imbalances take a long time to address because of this impossible
imbalance situation.

This can happen in Android world where it's common for background tasks
to be restricted to little cores.

Similarly if we can't fit the biggest core, triggering misfit is
pointless as it is the best we can ever get on this system.

To be able to detect that; we use asym_cap_list to iterate through
capacities in the system to see if the task is able to run at a higher
capacity level based on its p->cpus_ptr. We do that when the affinity
change, a fair task is forked, or when a task switched to fair policy.
We store the max_allowed_capacity in task_struct to allow for cheap
comparison in the fast path.

If cpu hotplug causes a capacity level to disappear, we will update the
max_allowed_capacity accordingly.

Improve check_misfit_status() function by removing redundant checks.
misfit_task_load will be 0 if the task can't move to a bigger CPU. And
nohz_balancer_kick() already checks for cpu_check_capacity() before
calling check_misfit_status().

Test:
=====

Add

	trace_printk("balance_interval = %lu\n", interval)

in get_sd_balance_interval().

run
	if [ "$MASK" != "0" ]; then
		adb shell "taskset -a $MASK cat /dev/zero > /dev/null"
	fi
	sleep 10
	// parse ftrace buffer counting the occurrence of each valaue

Where MASK is either:

	* 0: no busy task running
	* 1: busy task is pinned to 1 cpu; handled today to not cause
	  misfit
	* f: busy task pinned to little cores, simulates busy background
	  task, demonstrates the problem to be fixed

Results:
========

Note how occurrence of balance_interval = 128 overshoots for MASK = f.

BEFORE
------

	MASK=0

		   1 balance_interval = 175
		 120 balance_interval = 128
		 846 balance_interval = 64
		  55 balance_interval = 63
		 215 balance_interval = 32
		   2 balance_interval = 31
		   2 balance_interval = 16
		   4 balance_interval = 8
		1870 balance_interval = 4
		  65 balance_interval = 2

	MASK=1

		  27 balance_interval = 175
		  37 balance_interval = 127
		 840 balance_interval = 64
		 167 balance_interval = 63
		 449 balance_interval = 32
		  84 balance_interval = 31
		 304 balance_interval = 16
		1156 balance_interval = 8
		2781 balance_interval = 4
		 428 balance_interval = 2

	MASK=f

		   1 balance_interval = 175
		1328 balance_interval = 128
		  44 balance_interval = 64
		 101 balance_interval = 63
		  25 balance_interval = 32
		   5 balance_interval = 31
		  23 balance_interval = 16
		  23 balance_interval = 8
		4306 balance_interval = 4
		 177 balance_interval = 2

AFTER
-----

Note how the high values almost disappear for all MASK values. The
system has background tasks that could trigger the problem without
simulate it even with MASK=0.

	MASK=0

		 103 balance_interval = 63
		  19 balance_interval = 31
		 194 balance_interval = 8
		4827 balance_interval = 4
		 179 balance_interval = 2

	MASK=1

		 131 balance_interval = 63
		   1 balance_interval = 31
		  87 balance_interval = 8
		3600 balance_interval = 4
		   7 balance_interval = 2

	MASK=f

		   8 balance_interval = 127
		 182 balance_interval = 63
		   3 balance_interval = 31
		   9 balance_interval = 16
		 415 balance_interval = 8
		3415 balance_interval = 4
		  21 balance_interval = 2

Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 include/linux/sched.h |   1 +
 init/init_task.c      |   1 +
 kernel/sched/fair.c   | 134 +++++++++++++++++++++++++++++++++++++-----
 3 files changed, 120 insertions(+), 16 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index ffe8f618ab86..774cddbeab09 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -835,6 +835,7 @@ struct task_struct {
 #endif
 
 	unsigned int			policy;
+	unsigned long			max_allowed_capacity;
 	int				nr_cpus_allowed;
 	const cpumask_t			*cpus_ptr;
 	cpumask_t			*user_cpus_ptr;
diff --git a/init/init_task.c b/init/init_task.c
index 7ecb458eb3da..b3dbab4c959e 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -77,6 +77,7 @@ struct task_struct init_task __aligned(L1_CACHE_BYTES) = {
 	.cpus_ptr	= &init_task.cpus_mask,
 	.user_cpus_ptr	= NULL,
 	.cpus_mask	= CPU_MASK_ALL,
+	.max_allowed_capacity	= SCHED_CAPACITY_SCALE,
 	.nr_cpus_allowed= NR_CPUS,
 	.mm		= NULL,
 	.active_mm	= &init_mm,
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8e30e2bb77a0..9a9ddf611ffe 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5092,15 +5092,19 @@ static inline int task_fits_cpu(struct task_struct *p, int cpu)
 
 static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
 {
+	int cpu = cpu_of(rq);
+
 	if (!sched_asym_cpucap_active())
 		return;
 
-	if (!p || p->nr_cpus_allowed == 1) {
-		rq->misfit_task_load = 0;
-		return;
-	}
+	/*
+	 * Affinity allows us to go somewhere higher?  Or are we on biggest
+	 * available CPU already? Or do we fit into this CPU ?
+	 */
+	if (!p || (p->nr_cpus_allowed == 1) ||
+	    (arch_scale_cpu_capacity(cpu) == p->max_allowed_capacity) ||
+	    task_fits_cpu(p, cpu)) {
 
-	if (task_fits_cpu(p, cpu_of(rq))) {
 		rq->misfit_task_load = 0;
 		return;
 	}
@@ -8241,6 +8245,100 @@ static void task_dead_fair(struct task_struct *p)
 	remove_entity_load_avg(&p->se);
 }
 
+/*
+ * Set the max capacity the task is allowed to run at for misfit detection.
+ */
+static void set_task_max_allowed_capacity(struct task_struct *p, bool hotplug)
+{
+	struct asym_cap_data *entry;
+
+	if (!hotplug && !sched_asym_cpucap_active())
+		return;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(entry, &asym_cap_list, link) {
+		cpumask_t *cpumask;
+
+		cpumask = cpu_capacity_span(entry);
+		if (!cpumask_intersects(cpu_active_mask, cpumask))
+			continue;
+		if (!cpumask_intersects(p->cpus_ptr, cpumask))
+			continue;
+
+		p->max_allowed_capacity = entry->capacity;
+		break;
+	}
+	rcu_read_unlock();
+}
+
+static void __update_tasks_max_allowed_capacity(unsigned long capacity,
+						cpumask_t *cpumask,
+						bool online)
+{
+	struct task_struct *g, *p;
+
+	for_each_process_thread(g, p) {
+		if (p->sched_class != &fair_sched_class)
+			continue;
+
+		if (!cpumask_intersects(p->cpus_ptr, cpumask))
+			continue;
+
+		/*
+		 * Should we expand if a capacity level re-appeared?
+		 * Or should we shrink if a capacity level disappeared?
+		 */
+		if ((online && p->max_allowed_capacity < capacity) ||
+		    (!online && p->max_allowed_capacity == capacity))
+			set_task_max_allowed_capacity(p, true);
+	}
+}
+
+/*
+ * Handle a cpu going online/offline changing the available capacity levels.
+ */
+static void update_tasks_max_allowed_capacity(int cpu, bool online)
+{
+	struct asym_cap_data *entry;
+	bool do_update = false;
+	cpumask_t *cpumask;
+
+	/*
+	 * We can't check for sched_asym_cpucap_active() here as we can't
+	 * differentiate when an online operation will enable the key.
+	 */
+
+	if (cpuhp_tasks_frozen)
+		return;
+
+	rcu_read_lock();
+	/* Did a capacity level appear/disappear? */
+	list_for_each_entry_rcu(entry, &asym_cap_list, link) {
+		unsigned int nr_active;
+
+		cpumask = cpu_capacity_span(entry);
+
+		if (!cpumask_test_cpu(cpu, cpumask))
+			continue;
+
+		nr_active = cpumask_weight_and(cpu_active_mask, cpumask);
+		if (online)
+			do_update = nr_active == 1;
+		else
+			do_update = !nr_active;
+		break;
+	}
+	if (do_update)
+		__update_tasks_max_allowed_capacity(entry->capacity, cpumask, online);
+	rcu_read_unlock();
+}
+
+static void set_cpus_allowed_fair(struct task_struct *p, struct affinity_context *ctx)
+{
+	set_cpus_allowed_common(p, ctx);
+	set_task_max_allowed_capacity(p, false);
+}
+
 static int
 balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
@@ -8249,6 +8347,8 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 	return newidle_balance(rq, rf) != 0;
 }
+#else
+static inline void set_task_max_allowed_capacity(struct task_struct *p, bool hotplug) {}
 #endif /* CONFIG_SMP */
 
 static void set_next_buddy(struct sched_entity *se)
@@ -9601,16 +9701,10 @@ check_cpu_capacity(struct rq *rq, struct sched_domain *sd)
 				(arch_scale_cpu_capacity(cpu_of(rq)) * 100));
 }
 
-/*
- * Check whether a rq has a misfit task and if it looks like we can actually
- * help that task: we can migrate the task to a CPU of higher capacity, or
- * the task's current CPU is heavily pressured.
- */
-static inline int check_misfit_status(struct rq *rq, struct sched_domain *sd)
+/* Check if the rq has a misfit task */
+static inline bool check_misfit_status(struct rq *rq)
 {
-	return rq->misfit_task_load &&
-		(arch_scale_cpu_capacity(rq->cpu) < rq->rd->max_cpu_capacity ||
-		 check_cpu_capacity(rq, sd));
+	return rq->misfit_task_load;
 }
 
 /*
@@ -11922,7 +12016,7 @@ static void nohz_balancer_kick(struct rq *rq)
 		 * When ASYM_CPUCAPACITY; see if there's a higher capacity CPU
 		 * to run the misfit task on.
 		 */
-		if (check_misfit_status(rq, sd)) {
+		if (check_misfit_status(rq)) {
 			flags = NOHZ_STATS_KICK | NOHZ_BALANCE_KICK;
 			goto unlock;
 		}
@@ -12461,6 +12555,8 @@ static void rq_online_fair(struct rq *rq)
 	update_sysctl();
 
 	update_runtime_enabled(rq);
+
+	update_tasks_max_allowed_capacity(cpu_of(rq), true);
 }
 
 static void rq_offline_fair(struct rq *rq)
@@ -12472,6 +12568,8 @@ static void rq_offline_fair(struct rq *rq)
 
 	/* Ensure that we remove rq contribution to group share: */
 	clear_tg_offline_cfs_rqs(rq);
+
+	update_tasks_max_allowed_capacity(cpu_of(rq), false);
 }
 
 #endif /* CONFIG_SMP */
@@ -12645,6 +12743,8 @@ static void task_fork_fair(struct task_struct *p)
 	rq_lock(rq, &rf);
 	update_rq_clock(rq);
 
+	set_task_max_allowed_capacity(p, false);
+
 	cfs_rq = task_cfs_rq(current);
 	curr = cfs_rq->curr;
 	if (curr)
@@ -12768,6 +12868,8 @@ static void switched_to_fair(struct rq *rq, struct task_struct *p)
 {
 	attach_task_cfs_rq(p);
 
+	set_task_max_allowed_capacity(p, false);
+
 	if (task_on_rq_queued(p)) {
 		/*
 		 * We were most likely switched from sched_rt, so
@@ -13139,7 +13241,7 @@ DEFINE_SCHED_CLASS(fair) = {
 	.rq_offline		= rq_offline_fair,
 
 	.task_dead		= task_dead_fair,
-	.set_cpus_allowed	= set_cpus_allowed_common,
+	.set_cpus_allowed	= set_cpus_allowed_fair,
 #endif
 
 	.task_tick		= task_tick_fair,
-- 
2.34.1


