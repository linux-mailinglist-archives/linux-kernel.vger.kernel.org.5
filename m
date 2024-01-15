Return-Path: <linux-kernel+bounces-26114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 553C682DB82
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FC4AB2135F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC5C1863F;
	Mon, 15 Jan 2024 14:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2DRMDITF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/JAX5835"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E605B1944E
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 14:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705329494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cm9ubgE2S8LXnJlXOk04it5H/fBOtaMthr0f/KhtUW4=;
	b=2DRMDITF5UybmTlVWk6gbbm2t4vIeSkHOcUurkwV7YpktOGCzTlCCh3ZAah2BOvxVTUt35
	s28u+l2Nrdf6OH/dTiqHMdDtApojeHNR8tEdP4EEjc9WmAj0c1nRb37CoJvBmAR9+QZPCQ
	AJKy7Y2RUQA3Wjg+wCxwDOXlCbsGsrBrLTlcQKkVZk8G55+a4YZWnSuYCE298sEJ7xguEY
	KtQ6k3Bc/bpXxzQcqx/zM6a/72kN+plAJb4LwA54rg983xVVT3YFlA4NpxUzI9clEKLmiO
	75jmtz7pr9fX3V4CW/P5tS2eloK8OybLJCefsfsAOJ+zITWAlZGHX9MpbnQ5Xw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705329494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cm9ubgE2S8LXnJlXOk04it5H/fBOtaMthr0f/KhtUW4=;
	b=/JAX58356Wn3eGipK9Y6eLDwDlXr1PO6NkOuv8E/VD2z6yhBY067mF9p0EwSdbiStsl2A5
	p0stlNxo5CzdW+Cg==
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Dumazet <edumazet@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Arjan van de Ven <arjan@infradead.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Rik van Riel <riel@surriel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Siewior <bigeasy@linutronix.de>,
	Giovanni Gherdovich <ggherdovich@suse.cz>,
	Lukasz Luba <lukasz.luba@arm.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH v10 19/20] timer_migration: Add tracepoints
Date: Mon, 15 Jan 2024 15:37:42 +0100
Message-Id: <20240115143743.27827-20-anna-maria@linutronix.de>
In-Reply-To: <20240115143743.27827-1-anna-maria@linutronix.de>
References: <20240115143743.27827-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The timer pull logic needs proper debugging aids. Add tracepoints so the
hierarchical idle machinery can be diagnosed.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
v10: Make an entry in MAINTAINERS file

v9: Add tmigr_cpu_new_timer_idle tracepoint

v8: Add wakeup value to tracepoints
---
---
 MAINTAINERS                            |   1 +
 include/trace/events/timer_migration.h | 297 +++++++++++++++++++++++++
 kernel/time/timer_migration.c          |  26 +++
 3 files changed, 324 insertions(+)
 create mode 100644 include/trace/events/timer_migration.h

diff --git a/MAINTAINERS b/MAINTAINERS
index a7c4cf8201e0..9f9f2a695082 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17244,6 +17244,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
 F:	fs/timerfd.c
 F:	include/linux/time_namespace.h
 F:	include/linux/timer*
+F:	include/trace/events/timer*
 F:	kernel/time/*timer*
 F:	kernel/time/namespace.c
 
diff --git a/include/trace/events/timer_migration.h b/include/trace/events/timer_migration.h
new file mode 100644
index 000000000000..a2e7e32058f8
--- /dev/null
+++ b/include/trace/events/timer_migration.h
@@ -0,0 +1,297 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM timer_migration
+
+#if !defined(_TRACE_TIMER_MIGRATION_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_TIMER_MIGRATION_H
+
+#include <linux/tracepoint.h>
+
+/* Group events */
+TRACE_EVENT(tmigr_group_set,
+
+	TP_PROTO(struct tmigr_group *group),
+
+	TP_ARGS(group),
+
+	TP_STRUCT__entry(
+		__field( void *,	group		)
+		__field( unsigned int,	lvl		)
+		__field( unsigned int,	numa_node	)
+	),
+
+	TP_fast_assign(
+		__entry->group		= group;
+		__entry->lvl		= group->level;
+		__entry->numa_node	= group->numa_node;
+	),
+
+	TP_printk("group=%p lvl=%d numa=%d",
+		  __entry->group, __entry->lvl, __entry->numa_node)
+);
+
+TRACE_EVENT(tmigr_connect_child_parent,
+
+	TP_PROTO(struct tmigr_group *child),
+
+	TP_ARGS(child),
+
+	TP_STRUCT__entry(
+		__field( void *,	child		)
+		__field( void *,	parent		)
+		__field( unsigned int,	lvl		)
+		__field( unsigned int,	numa_node	)
+		__field( unsigned int,	num_children	)
+		__field( u32,		childmask	)
+	),
+
+	TP_fast_assign(
+		__entry->child		= child;
+		__entry->parent		= child->parent;
+		__entry->lvl		= child->parent->level;
+		__entry->numa_node	= child->parent->numa_node;
+		__entry->numa_node	= child->parent->num_children;
+		__entry->childmask	= child->childmask;
+	),
+
+	TP_printk("group=%p childmask=%0x parent=%p lvl=%d numa=%d num_children=%d",
+		  __entry->child,  __entry->childmask, __entry->parent,
+		  __entry->lvl, __entry->numa_node, __entry->num_children)
+);
+
+TRACE_EVENT(tmigr_connect_cpu_parent,
+
+	TP_PROTO(struct tmigr_cpu *tmc),
+
+	TP_ARGS(tmc),
+
+	TP_STRUCT__entry(
+		__field( void *,	parent		)
+		__field( unsigned int,	cpu		)
+		__field( unsigned int,	lvl		)
+		__field( unsigned int,	numa_node	)
+		__field( unsigned int,	num_children	)
+		__field( u32,		childmask	)
+	),
+
+	TP_fast_assign(
+		__entry->parent		= tmc->tmgroup;
+		__entry->cpu		= tmc->cpuevt.cpu;
+		__entry->lvl		= tmc->tmgroup->level;
+		__entry->numa_node	= tmc->tmgroup->numa_node;
+		__entry->numa_node	= tmc->tmgroup->num_children;
+		__entry->childmask	= tmc->childmask;
+	),
+
+	TP_printk("cpu=%d childmask=%0x parent=%p lvl=%d numa=%d num_children=%d",
+		  __entry->cpu,	 __entry->childmask, __entry->parent,
+		  __entry->lvl, __entry->numa_node, __entry->num_children)
+);
+
+DECLARE_EVENT_CLASS(tmigr_group_and_cpu,
+
+	TP_PROTO(struct tmigr_group *group, union tmigr_state state, u32 childmask),
+
+	TP_ARGS(group, state, childmask),
+
+	TP_STRUCT__entry(
+		__field( void *,	group		)
+		__field( void *,	parent		)
+		__field( unsigned int,	lvl		)
+		__field( unsigned int,	numa_node	)
+		__field( u8,		active		)
+		__field( u8,		migrator	)
+		__field( u32,		childmask	)
+	),
+
+	TP_fast_assign(
+		__entry->group		= group;
+		__entry->parent		= group->parent;
+		__entry->lvl		= group->level;
+		__entry->numa_node	= group->numa_node;
+		__entry->active		= state.active;
+		__entry->migrator	= state.migrator;
+		__entry->childmask	= childmask;
+	),
+
+	TP_printk("group=%p lvl=%d numa=%d active=%0x migrator=%0x "
+		  "parent=%p childmask=%0x",
+		  __entry->group, __entry->lvl, __entry->numa_node,
+		  __entry->active, __entry->migrator,
+		  __entry->parent, __entry->childmask)
+);
+
+DEFINE_EVENT(tmigr_group_and_cpu, tmigr_group_set_cpu_inactive,
+
+	TP_PROTO(struct tmigr_group *group, union tmigr_state state, u32 childmask),
+
+	TP_ARGS(group, state, childmask)
+);
+
+DEFINE_EVENT(tmigr_group_and_cpu, tmigr_group_set_cpu_active,
+
+	TP_PROTO(struct tmigr_group *group, union tmigr_state state, u32 childmask),
+
+	TP_ARGS(group, state, childmask)
+);
+
+/* CPU events*/
+DECLARE_EVENT_CLASS(tmigr_cpugroup,
+
+	TP_PROTO(struct tmigr_cpu *tmc),
+
+	TP_ARGS(tmc),
+
+	TP_STRUCT__entry(
+		__field( void *,	parent)
+		__field( unsigned int,	cpu)
+		__field( u64,		wakeup)
+	),
+
+	TP_fast_assign(
+		__entry->cpu		= tmc->cpuevt.cpu;
+		__entry->parent		= tmc->tmgroup;
+		__entry->wakeup		= tmc->wakeup;
+	),
+
+	TP_printk("cpu=%d parent=%p wakeup=%llu", __entry->cpu, __entry->parent, __entry->wakeup)
+);
+
+DEFINE_EVENT(tmigr_cpugroup, tmigr_cpu_new_timer,
+
+	TP_PROTO(struct tmigr_cpu *tmc),
+
+	TP_ARGS(tmc)
+);
+
+DEFINE_EVENT(tmigr_cpugroup, tmigr_cpu_active,
+
+	TP_PROTO(struct tmigr_cpu *tmc),
+
+	TP_ARGS(tmc)
+);
+
+DEFINE_EVENT(tmigr_cpugroup, tmigr_cpu_online,
+
+	TP_PROTO(struct tmigr_cpu *tmc),
+
+	TP_ARGS(tmc)
+);
+
+DEFINE_EVENT(tmigr_cpugroup, tmigr_cpu_offline,
+
+	TP_PROTO(struct tmigr_cpu *tmc),
+
+	TP_ARGS(tmc)
+);
+
+DEFINE_EVENT(tmigr_cpugroup, tmigr_handle_remote_cpu,
+
+	TP_PROTO(struct tmigr_cpu *tmc),
+
+	TP_ARGS(tmc)
+);
+
+DECLARE_EVENT_CLASS(tmigr_idle,
+
+	TP_PROTO(struct tmigr_cpu *tmc, u64 nextevt),
+
+	TP_ARGS(tmc, nextevt),
+
+	TP_STRUCT__entry(
+		__field( void *,	parent)
+		__field( unsigned int,	cpu)
+		__field( u64,		nextevt)
+		__field( u64,		wakeup)
+	),
+
+	TP_fast_assign(
+		__entry->cpu		= tmc->cpuevt.cpu;
+		__entry->parent		= tmc->tmgroup;
+		__entry->nextevt	= nextevt;
+		__entry->wakeup		= tmc->wakeup;
+	),
+
+	TP_printk("cpu=%d parent=%p nextevt=%llu wakeup=%llu",
+		  __entry->cpu, __entry->parent, __entry->nextevt, __entry->wakeup)
+);
+
+DEFINE_EVENT(tmigr_idle, tmigr_cpu_idle,
+
+	TP_PROTO(struct tmigr_cpu *tmc, u64 nextevt),
+
+	TP_ARGS(tmc, nextevt)
+);
+
+DEFINE_EVENT(tmigr_idle, tmigr_cpu_new_timer_idle,
+
+	TP_PROTO(struct tmigr_cpu *tmc, u64 nextevt),
+
+	TP_ARGS(tmc, nextevt)
+);
+
+TRACE_EVENT(tmigr_update_events,
+
+	TP_PROTO(struct tmigr_group *child, struct tmigr_group *group,
+		 union tmigr_state childstate,	union tmigr_state groupstate,
+		 u64 nextevt),
+
+	TP_ARGS(child, group, childstate, groupstate, nextevt),
+
+	TP_STRUCT__entry(
+		__field( void *,	child			)
+		__field( void *,	group			)
+		__field( u64,		nextevt			)
+		__field( u64,		group_next_expiry	)
+		__field( unsigned int,	group_lvl		)
+		__field( u8,		child_active		)
+		__field( u8,		group_active		)
+		__field( unsigned int,	child_evtcpu		)
+		__field( u64,		child_evt_expiry	)
+	),
+
+	TP_fast_assign(
+		__entry->child			= child;
+		__entry->group			= group;
+		__entry->nextevt		= nextevt;
+		__entry->group_next_expiry	= group->next_expiry;
+		__entry->group_lvl		= group->level;
+		__entry->child_active		= childstate.active;
+		__entry->group_active		= groupstate.active;
+		__entry->child_evtcpu		= child ? child->groupevt.cpu : 0;
+		__entry->child_evt_expiry	= child ? child->groupevt.nextevt.expires : 0;
+	),
+
+	TP_printk("child=%p group=%p group_lvl=%d child_active=%0x group_active=%0x "
+		  "nextevt=%llu next_expiry=%llu child_evt_expiry=%llu child_evtcpu=%d",
+		  __entry->child, __entry->group, __entry->group_lvl, __entry->child_active,
+		  __entry->group_active,
+		  __entry->nextevt, __entry->group_next_expiry, __entry->child_evt_expiry,
+		  __entry->child_evtcpu)
+);
+
+TRACE_EVENT(tmigr_handle_remote,
+
+	TP_PROTO(struct tmigr_group *group),
+
+	TP_ARGS(group),
+
+	TP_STRUCT__entry(
+		__field( void * ,	group	)
+		__field( unsigned int ,	lvl	)
+	),
+
+	TP_fast_assign(
+		__entry->group		= group;
+		__entry->lvl		= group->level;
+	),
+
+	TP_printk("group=%p lvl=%d",
+		   __entry->group, __entry->lvl)
+);
+
+#endif /*  _TRACE_TIMER_MIGRATION_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index de1905b0bae7..d3b7200a9f4a 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -14,6 +14,9 @@
 #include "timer_migration.h"
 #include "tick-internal.h"
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/timer_migration.h>
+
 /*
  * The timer migration mechanism is built on a hierarchy of groups. The
  * lowest level group contains CPUs, the next level groups of CPU groups
@@ -537,6 +540,8 @@ static bool tmigr_active_up(struct tmigr_group *group,
 	 */
 	group->groupevt.ignore = true;
 
+	trace_tmigr_group_set_cpu_active(group, newstate, childmask);
+
 	return walk_done;
 }
 
@@ -546,6 +551,8 @@ static void __tmigr_cpu_activate(struct tmigr_cpu *tmc)
 
 	data.childmask = tmc->childmask;
 
+	trace_tmigr_cpu_active(tmc);
+
 	tmc->cpuevt.ignore = true;
 	WRITE_ONCE(tmc->wakeup, KTIME_MAX);
 	tmc->wakeup_recalc = false;
@@ -703,6 +710,9 @@ bool tmigr_update_events(struct tmigr_group *group, struct tmigr_group *child,
 		data->firstexp = tmigr_next_groupevt_expires(group);
 	}
 
+	trace_tmigr_update_events(child, group, childstate, groupstate,
+				  nextexp);
+
 unlock:
 	raw_spin_unlock(&group->lock);
 
@@ -745,6 +755,8 @@ static u64 tmigr_new_timer(struct tmigr_cpu *tmc, u64 nextexp)
 	if (tmc->remote)
 		return KTIME_MAX;
 
+	trace_tmigr_cpu_new_timer(tmc);
+
 	tmc->cpuevt.ignore = false;
 	data.remote = false;
 
@@ -787,6 +799,8 @@ static u64 tmigr_handle_remote_cpu(unsigned int cpu, u64 now,
 		return next;
 	}
 
+	trace_tmigr_handle_remote_cpu(tmc);
+
 	tmc->remote = true;
 	WRITE_ONCE(tmc->wakeup, KTIME_MAX);
 
@@ -872,6 +886,7 @@ static bool tmigr_handle_remote_up(struct tmigr_group *group,
 
 	childmask = data->childmask;
 
+	trace_tmigr_handle_remote(group);
 again:
 	/*
 	 * Handle the group only if @childmask is the migrator or if the
@@ -1140,6 +1155,7 @@ u64 tmigr_cpu_new_timer(u64 nextexp)
 	 */
 	WRITE_ONCE(tmc->wakeup, ret);
 
+	trace_tmigr_cpu_new_timer_idle(tmc, nextexp);
 	raw_spin_unlock(&tmc->lock);
 	return ret;
 }
@@ -1243,6 +1259,8 @@ static bool tmigr_inactive_up(struct tmigr_group *group,
 		}
 	}
 
+	trace_tmigr_group_set_cpu_inactive(group, newstate, childmask);
+
 	return walk_done;
 }
 
@@ -1295,6 +1313,7 @@ u64 tmigr_cpu_deactivate(u64 nextexp)
 	 */
 	WRITE_ONCE(tmc->wakeup, ret);
 
+	trace_tmigr_cpu_idle(tmc, nextexp);
 	raw_spin_unlock(&tmc->lock);
 	return ret;
 }
@@ -1407,6 +1426,7 @@ static struct tmigr_group *tmigr_get_group(unsigned int cpu, int node,
 
 	/* Setup successful. Add it to the hierarchy */
 	list_add(&group->list, &tmigr_level_list[lvl]);
+	trace_tmigr_group_set(group);
 	return group;
 }
 
@@ -1424,6 +1444,8 @@ static void tmigr_connect_child_parent(struct tmigr_group *child,
 	raw_spin_unlock(&parent->lock);
 	raw_spin_unlock_irq(&child->lock);
 
+	trace_tmigr_connect_child_parent(child);
+
 	/*
 	 * To prevent inconsistent states, active children need to be active in
 	 * the new parent as well. Inactive children are already marked inactive
@@ -1504,6 +1526,8 @@ static int tmigr_setup_groups(unsigned int cpu, unsigned int node)
 
 			raw_spin_unlock_irq(&group->lock);
 
+			trace_tmigr_connect_cpu_parent(tmc);
+
 			/* There are no children that need to be connected */
 			continue;
 		} else {
@@ -1571,6 +1595,7 @@ static int tmigr_cpu_online(unsigned int cpu)
 		WRITE_ONCE(tmc->wakeup, KTIME_MAX);
 	}
 	raw_spin_lock_irq(&tmc->lock);
+	trace_tmigr_cpu_online(tmc);
 	tmc->idle = timer_base_is_idle();
 	if (!tmc->idle)
 		__tmigr_cpu_activate(tmc);
@@ -1592,6 +1617,7 @@ static int tmigr_cpu_offline(unsigned int cpu)
 	 * offline; Therefore nextevt value is set to KTIME_MAX
 	 */
 	__tmigr_cpu_deactivate(tmc, KTIME_MAX);
+	trace_tmigr_cpu_offline(tmc);
 	raw_spin_unlock_irq(&tmc->lock);
 
 	return 0;
-- 
2.39.2


