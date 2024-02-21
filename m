Return-Path: <linux-kernel+bounces-75638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5F285EC99
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5340282CAE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D86127B57;
	Wed, 21 Feb 2024 23:15:28 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47F985268
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 23:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708557327; cv=none; b=ShtyZAwLGJZpsLeLOp+n5GzhzmMXpoVrzvxRa3S4NBbfyapBk/FsoURfRB3SRO6fPaO4EdHgae8jVQt7eyqOhUz0YuCz8uNVnzNxbS0o7KBKI5YO6ViGyezyAWyLEeBVul0LLzfSpfOtjr2t7V5odLJB3DcWkvAaanl1wCK7GGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708557327; c=relaxed/simple;
	bh=PASu4t2rYovLjssJl3r/y3MJM44QJFipAJ0uuNsaxOU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eLYYt+SSQggqx2tzzdpZwtwGfDQKodgIyrzRIhosbzbO+aYP3afwoGmLlu8khr7C3/IEFx5XR78u1SIDXNA5qwKbNkd6ZUnFw11vRVZbPiKJ73KLqUFJQGgTHEZ4iW2E7lS5ivEU6xC2xXiaJklbf1R74n29r0geX5QK8jeZDwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD4DC433F1;
	Wed, 21 Feb 2024 23:15:25 +0000 (UTC)
Date: Wed, 21 Feb 2024 18:17:13 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Eric Dumazet <edumazet@google.com>, "Rafael J . Wysocki"
 <rafael.j.wysocki@intel.com>, Arjan van de Ven <arjan@infradead.org>, "Paul
 E . McKenney" <paulmck@kernel.org>, Frederic Weisbecker
 <frederic@kernel.org>, Rik van Riel <riel@surriel.com>, Sebastian Siewior
 <bigeasy@linutronix.de>, Giovanni Gherdovich <ggherdovich@suse.cz>, Lukasz
 Luba <lukasz.luba@arm.com>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Srinivas Pandruvada <srinivas.pandruvada@intel.com>, K Prateek Nayak
 <kprateek.nayak@amd.com>, Christian Loehle <christian.loehle@arm.com>
Subject: Re: [PATCH v11 19/20] timer_migration: Add tracepoints
Message-ID: <20240221181713.12f530cb@gandalf.local.home>
In-Reply-To: <20240221090548.36600-20-anna-maria@linutronix.de>
References: <20240221090548.36600-1-anna-maria@linutronix.de>
	<20240221090548.36600-20-anna-maria@linutronix.de>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Feb 2024 10:05:47 +0100
Anna-Maria Behnsen <anna-maria@linutronix.de> wrote:

> diff --git a/include/trace/events/timer_migration.h b/include/trace/events/timer_migration.h
> new file mode 100644
> index 000000000000..3f6e9502c41e
> --- /dev/null
> +++ b/include/trace/events/timer_migration.h
> @@ -0,0 +1,297 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +

> +DECLARE_EVENT_CLASS(tmigr_group_and_cpu,
> +
> +	TP_PROTO(struct tmigr_group *group, union tmigr_state state, u32 childmask),
> +
> +	TP_ARGS(group, state, childmask),
> +
> +	TP_STRUCT__entry(
> +		__field( void *,	group		)
> +		__field( void *,	parent		)
> +		__field( unsigned int,	lvl		)
> +		__field( unsigned int,	numa_node	)
> +		__field( u8,		active		)
> +		__field( u8,		migrator	)
> +		__field( u32,		childmask	)

Could you move the two u8 after the u32? Although it probably doesn't
matter for the actual size, I prefer to keep holes from inside the
structure. The above will create a two byte hole between the two u8 and the
u32.

> +	),
> +
> +	TP_fast_assign(
> +		__entry->group		= group;
> +		__entry->parent		= group->parent;
> +		__entry->lvl		= group->level;
> +		__entry->numa_node	= group->numa_node;
> +		__entry->active		= state.active;
> +		__entry->migrator	= state.migrator;
> +		__entry->childmask	= childmask;
> +	),
> +
> +	TP_printk("group=%p lvl=%d numa=%d active=%0x migrator=%0x "
> +		  "parent=%p childmask=%0x",
> +		  __entry->group, __entry->lvl, __entry->numa_node,
> +		  __entry->active, __entry->migrator,
> +		  __entry->parent, __entry->childmask)
> +);
> +
> +DEFINE_EVENT(tmigr_group_and_cpu, tmigr_group_set_cpu_inactive,
> +
> +	TP_PROTO(struct tmigr_group *group, union tmigr_state state, u32 childmask),
> +
> +	TP_ARGS(group, state, childmask)
> +);
> +
> +DEFINE_EVENT(tmigr_group_and_cpu, tmigr_group_set_cpu_active,
> +
> +	TP_PROTO(struct tmigr_group *group, union tmigr_state state, u32 childmask),
> +
> +	TP_ARGS(group, state, childmask)
> +);
> +
> +/* CPU events*/
> +DECLARE_EVENT_CLASS(tmigr_cpugroup,
> +
> +	TP_PROTO(struct tmigr_cpu *tmc),
> +
> +	TP_ARGS(tmc),
> +
> +	TP_STRUCT__entry(
> +		__field( void *,	parent)
> +		__field( unsigned int,	cpu)
> +		__field( u64,		wakeup)

Please put the u64 first. That way on 32 bit machines, parent and cpu will
fit together and on 64 bit machines, there will not be a hole between cpu
and wakeup.

> +	),
> +
> +	TP_fast_assign(
> +		__entry->cpu		= tmc->cpuevt.cpu;
> +		__entry->parent		= tmc->tmgroup;
> +		__entry->wakeup		= tmc->wakeup;
> +	),
> +
> +	TP_printk("cpu=%d parent=%p wakeup=%llu", __entry->cpu, __entry->parent, __entry->wakeup)
> +);
> +
> +DEFINE_EVENT(tmigr_cpugroup, tmigr_cpu_new_timer,
> +
> +	TP_PROTO(struct tmigr_cpu *tmc),
> +
> +	TP_ARGS(tmc)
> +);
> +
> +DEFINE_EVENT(tmigr_cpugroup, tmigr_cpu_active,
> +
> +	TP_PROTO(struct tmigr_cpu *tmc),
> +
> +	TP_ARGS(tmc)
> +);
> +
> +DEFINE_EVENT(tmigr_cpugroup, tmigr_cpu_online,
> +
> +	TP_PROTO(struct tmigr_cpu *tmc),
> +
> +	TP_ARGS(tmc)
> +);
> +
> +DEFINE_EVENT(tmigr_cpugroup, tmigr_cpu_offline,
> +
> +	TP_PROTO(struct tmigr_cpu *tmc),
> +
> +	TP_ARGS(tmc)
> +);
> +
> +DEFINE_EVENT(tmigr_cpugroup, tmigr_handle_remote_cpu,
> +
> +	TP_PROTO(struct tmigr_cpu *tmc),
> +
> +	TP_ARGS(tmc)
> +);
> +
> +DECLARE_EVENT_CLASS(tmigr_idle,
> +
> +	TP_PROTO(struct tmigr_cpu *tmc, u64 nextevt),
> +
> +	TP_ARGS(tmc, nextevt),
> +
> +	TP_STRUCT__entry(
> +		__field( void *,	parent)
> +		__field( unsigned int,	cpu)
> +		__field( u64,		nextevt)
> +		__field( u64,		wakeup)

Please put parent and cpu after wakeup so that there will not be a hole
around cpu.

> +	),
> +
> +	TP_fast_assign(
> +		__entry->cpu		= tmc->cpuevt.cpu;
> +		__entry->parent		= tmc->tmgroup;
> +		__entry->nextevt	= nextevt;
> +		__entry->wakeup		= tmc->wakeup;
> +	),
> +
> +	TP_printk("cpu=%d parent=%p nextevt=%llu wakeup=%llu",
> +		  __entry->cpu, __entry->parent, __entry->nextevt, __entry->wakeup)
> +);
> +
> +DEFINE_EVENT(tmigr_idle, tmigr_cpu_idle,
> +
> +	TP_PROTO(struct tmigr_cpu *tmc, u64 nextevt),
> +
> +	TP_ARGS(tmc, nextevt)
> +);
> +
> +DEFINE_EVENT(tmigr_idle, tmigr_cpu_new_timer_idle,
> +
> +	TP_PROTO(struct tmigr_cpu *tmc, u64 nextevt),
> +
> +	TP_ARGS(tmc, nextevt)
> +);
> +
> +TRACE_EVENT(tmigr_update_events,
> +
> +	TP_PROTO(struct tmigr_group *child, struct tmigr_group *group,
> +		 union tmigr_state childstate,	union tmigr_state groupstate,
> +		 u64 nextevt),
> +
> +	TP_ARGS(child, group, childstate, groupstate, nextevt),
> +
> +	TP_STRUCT__entry(
> +		__field( void *,	child			)
> +		__field( void *,	group			)
> +		__field( u64,		nextevt			)
> +		__field( u64,		group_next_expiry	)
> +		__field( unsigned int,	group_lvl		)
> +		__field( u8,		child_active		)
> +		__field( u8,		group_active		)
> +		__field( unsigned int,	child_evtcpu		)
> +		__field( u64,		child_evt_expiry	)

Please put child_evt_expiry after group_next_expiry. Have group_lvl next to
child_evtcpu and the two u8 fields at the end.

Thanks!

-- Steve


> +	),
> +
> +	TP_fast_assign(
> +		__entry->child			= child;
> +		__entry->group			= group;
> +		__entry->nextevt		= nextevt;
> +		__entry->group_next_expiry	= group->next_expiry;
> +		__entry->group_lvl		= group->level;
> +		__entry->child_active		= childstate.active;
> +		__entry->group_active		= groupstate.active;
> +		__entry->child_evtcpu		= child ? child->groupevt.cpu : 0;
> +		__entry->child_evt_expiry	= child ? child->groupevt.nextevt.expires : 0;
> +	),
> +
> +	TP_printk("child=%p group=%p group_lvl=%d child_active=%0x group_active=%0x "
> +		  "nextevt=%llu next_expiry=%llu child_evt_expiry=%llu child_evtcpu=%d",
> +		  __entry->child, __entry->group, __entry->group_lvl, __entry->child_active,
> +		  __entry->group_active,
> +		  __entry->nextevt, __entry->group_next_expiry, __entry->child_evt_expiry,
> +		  __entry->child_evtcpu)
> +);
> +
> +TRACE_EVENT(tmigr_handle_remote,
> +
> +	TP_PROTO(struct tmigr_group *group),
> +
> +	TP_ARGS(group),
> +
> +	TP_STRUCT__entry(
> +		__field( void * ,	group	)
> +		__field( unsigned int ,	lvl	)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->group		= group;
> +		__entry->lvl		= group->level;
> +	),
> +
> +	TP_printk("group=%p lvl=%d",
> +		   __entry->group, __entry->lvl)
> +);
> +

