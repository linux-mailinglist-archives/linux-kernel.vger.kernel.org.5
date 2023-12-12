Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C644280EB4B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 13:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346419AbjLLMOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 07:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjLLMOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 07:14:02 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F26AF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 04:14:07 -0800 (PST)
Date:   Tue, 12 Dec 2023 13:14:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702383246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+nscTcQLqzuv9Vo3oyPSvp/PJhtQsJ0QUOs81Z6V7WM=;
        b=MyUY9h4ykCwod4XgY4mZSNhE5dq4vTGCTjsi1By9OsQ0206HfYj3GbW27oaFzPpTcI4yRM
        3ImK5Qi8N53NyKELFQFb49f07B5NJf9crmHxgsMrzgvY9p+rB57698/j0cwCwOpWmIVVwE
        62qoG+ZAUnl8hdlZwbn36WOXAwtxGCrzBQKgsTi1Tl8BIeUpWcO/M+xYPllTABONpjLu0W
        CQY6tIUnX2GseMHXUpd7rRotRz34DiP/jMmPxcfI/Z8bjVyVGb4A/IlYCr38R75kQglvzE
        Pjxuadm+hVpYW8n716YHyPTeYBQlopjyLVnQVRGEYA45JXdT3GxCW0u+MXNolA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702383246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+nscTcQLqzuv9Vo3oyPSvp/PJhtQsJ0QUOs81Z6V7WM=;
        b=sbJF089ljWf954Xr+TKPPGJ04JtCRKujugIaiemAjimYXPHsZSN5PezkAO18yUtyPCwFSJ
        U7jcR7W+0ZYfBFAA==
From:   Sebastian Siewior <bigeasy@linutronix.de>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v9 30/32] timers: Implement the hierarchical pull model
Message-ID: <20231212121404.C2R9VWj1@linutronix.de>
References: <20231201092654.34614-1-anna-maria@linutronix.de>
 <20231201092654.34614-31-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231201092654.34614-31-anna-maria@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-12-01 10:26:52 [+0100], Anna-Maria Behnsen wrote:
> diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
> new file mode 100644
> index 000000000000..05cd8f1bc45d
> --- /dev/null
> +++ b/kernel/time/timer_migration.c
> @@ -0,0 +1,1636 @@
=E2=80=A6
> +static int __init tmigr_init(void)
> +{
> +	unsigned int cpulvl, nodelvl, cpus_per_node, i;
> +	unsigned int nnodes =3D num_possible_nodes();
> +	unsigned int ncpus =3D num_possible_cpus();
> +	int ret =3D -ENOMEM;
> +
> +	/* Nothing to do if running on UP */
> +	if (ncpus =3D=3D 1)
> +		return 0;
> +
> +	/*
> +	 * Calculate the required hierarchy levels. Unfortunately there is no
> +	 * reliable information available, unless all possible CPUs have been
> +	 * brought up and all numa nodes are populated.
NUMA

> +	 *
> +	 * Estimate the number of levels with the number of possible nodes and
> +	 * the number of possible CPUs. Assume CPUs are spread evenly across
> +	 * nodes. We cannot rely on cpumask_of_node() because there only already
> +	 * online CPUs are considered.
> +	 */

    We cannot rely on cpumask_of_node() because it only works for online
    CPUs.

> +	cpus_per_node =3D DIV_ROUND_UP(ncpus, nnodes);
> +
> +	/* Calc the hierarchy levels required to hold the CPUs of a node */
> +	cpulvl =3D DIV_ROUND_UP(order_base_2(cpus_per_node),
> +			      ilog2(TMIGR_CHILDREN_PER_GROUP));
> +
> +	/* Calculate the extra levels to connect all nodes */
> +	nodelvl =3D DIV_ROUND_UP(order_base_2(nnodes),
> +			       ilog2(TMIGR_CHILDREN_PER_GROUP));
> +
> +	tmigr_hierarchy_levels =3D cpulvl + nodelvl;
> +
> +	/*
> +	 * If a numa node spawns more than one CPU level group then the next
NUMA

> +	 * level(s) of the hierarchy contains groups which handle all CPU groups
> +	 * of the same numa node. The level above goes across numa nodes. Store
NUMA

> +	 * this information for the setup code to decide when node matching is
> +	 * not longer required.
s/not longer/no longer ?

> +	 */
> +	tmigr_crossnode_level =3D cpulvl;
> +
> +	tmigr_level_list =3D kcalloc(tmigr_hierarchy_levels, sizeof(struct list=
_head), GFP_KERNEL);
> +	if (!tmigr_level_list)
> +		goto err;
> +
> +	for (i =3D 0; i < tmigr_hierarchy_levels; i++)
> +		INIT_LIST_HEAD(&tmigr_level_list[i]);
> +
> +	pr_info("Timer migration: %d hierarchy levels; %d children per group;"
> +		" %d crossnode level\n",
> +		tmigr_hierarchy_levels, TMIGR_CHILDREN_PER_GROUP,
> +		tmigr_crossnode_level);
> +
> +	ret =3D cpuhp_setup_state(CPUHP_AP_TMIGR_ONLINE, "tmigr:online",
> +				tmigr_cpu_online, tmigr_cpu_offline);
> +	if (ret)
> +		goto err;
> +
> +	return 0;
> +
> +err:
> +	pr_err("Timer migration setup failed\n");
> +	return ret;
> +}
> +late_initcall(tmigr_init);
> diff --git a/kernel/time/timer_migration.h b/kernel/time/timer_migration.h
> new file mode 100644
> index 000000000000..260b87e5708d
> --- /dev/null
> +++ b/kernel/time/timer_migration.h
> @@ -0,0 +1,144 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef _KERNEL_TIME_MIGRATION_H
> +#define _KERNEL_TIME_MIGRATION_H
> +
> +/* Per group capacity. Must be a power of 2! */
> +#define TMIGR_CHILDREN_PER_GROUP 8

BUILD_BUG_ON_NOT_POWER_OF_2(TMIGR_CHILDREN_PER_GROUP)

Maybe in the .c file.

> +/**
> + * struct tmigr_event - a timer event associated to a CPU
> + * @nextevt:	The node to enqueue an event in the parent group queue
> + * @cpu:	The CPU to which this event belongs
> + * @ignore:	Hint whether the event could be ignored; it is set when
> + *		CPU or group is active;
> + */
> +struct tmigr_event {
> +	struct timerqueue_node	nextevt;
> +	unsigned int		cpu;
> +	bool			ignore;
> +};
> +
> +/**
> + * struct tmigr_group - timer migration hierarchy group
> + * @lock:		Lock protecting the event information and group hierarchy
> + *			information during setup
> + * @migr_state:		State of the group (see union tmigr_state)

So the lock does not protect migr_state? Mind moving it a little down the
road? Not only would it be more obvious what is protected by the lock
but it would also move migr_state in another/ later cache line.

> + * @parent:		Pointer to the parent group
> + * @groupevt:		Next event of the group which is only used when the
> + *			group is !active. The group event is then queued into
> + *			the parent timer queue.
> + *			Ignore bit of @groupevt is set when the group is active.
> + * @next_expiry:	Base monotonic expiry time of the next event of the
> + *			group; It is used for the racy lockless check whether a
> + *			remote expiry is required; it is always reliable
> + * @events:		Timer queue for child events queued in the group
> + * @childmask:		childmask of the group in the parent group; is set
> + *			during setup and will never change; could be read

_can_ be read lockless.

> + *			lockless
> + * @level:		Hierarchy level of the group; Required during setup
> + * @list:		List head that is added to the per level
> + *			tmigr_level_list; is required during setup when a
> + *			new group needs to be connected to the existing
> + *			hierarchy groups
> + * @numa_node:		Is set to numa node when level < tmigr_crossnode_level;
NUMA

   (as long as the group level is per NUMA node).

> + *			otherwise it is set to NUMA_NO_NODE; Required for
> + *			setup only to make sure CPUs and groups are per
> + *			numa node as long as level < tmigr_crossnode_level

    =E2=80=A6 to make sure CPU and group information is NUMA local. This is
    true until the top most hierarchy level (level <
    tmigr_crossnode_level).

> + * @num_children:	Counter of group children to make sure the group is on=
ly
> + *			filled with TMIGR_CHILDREN_PER_GROUP; Required for setup
> + *			only
> + */
> +struct tmigr_group {
> +	raw_spinlock_t		lock;
> +	atomic_t		migr_state;
> +	struct tmigr_group	*parent;
> +	struct tmigr_event	groupevt;
> +	u64			next_expiry;
> +	struct timerqueue_head	events;
> +	u8			childmask;
> +	unsigned int		level;
> +	struct list_head	list;
> +	int			numa_node;
> +	unsigned int		num_children;
> +};
> +
> +/**
> + * struct tmigr_cpu - timer migration per CPU group
> + * @lock:		Lock protecting the tmigr_cpu group information
> + * @online:		Indicates whether the CPU is online; In deactivate path
> + *			it is required to know whether the migrator in the top
> + *			level group is on the way to go offline when a timer is

   level group, which is to be set offline, while a timer is pending.


> + *			pending. Then another online CPU needs to be rescheduled
> + *			to make sure the timers are handled properly;

   Then another online CPU needs to be notified to take over the
   migrator role.

The "rescheduled" part sounds like the current implementation.

> + *			Furthermore the information is required in CPU hotplug
> + *			path as the CPU is able to go idle before the timer
> + *			migration hierarchy hotplug AP is reached. During this
> + *			phase, the CPU has to handle the global timers by its

s/by its own/on its own/

> + *			own and does not act as a migrator.

s/does not/must not

> + * @idle:		Indicates whether the CPU is idle in the timer migration
> + *			hierarchy
> + * @remote:		Is set when timers of the CPU are expired remote

s/remote/remotely

> + * @wakeup_recalc:	Indicates, whether a recalculation of the @wakeup val=
ue
> + *			is required. It is only used when the CPU is marked idle
> + *			in the timer migration hierarchy.

What does `It' refer to? Is it `wakeup_recalc' or `wakeup' ?

> + * @tmgroup:		Pointer to the parent group
> + * @childmask:		childmask of tmigr_cpu in the parent group
> + * @wakeup:		Stores the first timer when the timer migration
> + *			hierarchy is completely idle and remote expiry was done;
> + *			is returned to timer code in the idle path; it is only

   is used in the idle path only (what is the idle path (probably
   obvious))

> + *			valid, when @wakeup_recalc is not set
> + * @cpuevt:		CPU event which could be queued into the parent group

I don't know why but it feels like s/queued/enqueued/g
But it might be a British vs American thing.

Sebastian
