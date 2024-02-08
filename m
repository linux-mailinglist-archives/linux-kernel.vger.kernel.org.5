Return-Path: <linux-kernel+bounces-58130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7AB84E1BE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE60E1F24315
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FBA7868F;
	Thu,  8 Feb 2024 13:11:17 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0793443ACD;
	Thu,  8 Feb 2024 13:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707397877; cv=none; b=dTxAjvIIxrSQ7e3OrGgX0EBs+nPxf/GNmhEIRfqsTY94cLYALPv4xjFaH1Eh43jeHGeuZhoy2bFYWj0kaVcqrMR7QXjGAYMID/p8j0neZ9wX6CVnfmEB7g0HkKQMn+WW+cOsyonNer+Vp2Y9uHu3+C93DzmOjzJjTfiKJQhpzLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707397877; c=relaxed/simple;
	bh=fqu6mN5K4lFFy3zTNhV7f/rrnImkgY46BLOzGCAKBEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qg9kTAHLm9Kn6l1Jr7vezyRqSg5p/+N4lAyOAgU9cK9clPWNUYsqahjb4zYbqoieyTWJ/IdijL2a9mp4WXEX14LwX4RrPO2/puMta60xHxQ/zY4a0JjxD9XTRPYTnxDwF7Y7kz0cJ6aadh6qmkPOIBUoU+5y48JHGJWo5Eygqo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3FD0DA7;
	Thu,  8 Feb 2024 05:11:56 -0800 (PST)
Received: from e126817.cambridge.arm.com (e126817.cambridge.arm.com [10.2.3.5])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B1CE03F5A1;
	Thu,  8 Feb 2024 05:11:12 -0800 (PST)
From: Ben Gainey <ben.gainey@arm.com>
To: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@arm.com,
	Ben Gainey <ben.gainey@arm.com>
Subject: [PATCH v2 1/4] perf: Support PERF_SAMPLE_READ with inherit_stat
Date: Thu,  8 Feb 2024 13:10:47 +0000
Message-ID: <20240208131050.2406183-2-ben.gainey@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240208131050.2406183-1-ben.gainey@arm.com>
References: <20240208131050.2406183-1-ben.gainey@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change allows events to use PERF_SAMPLE READ with inherit
so long as both inherit_stat and PERF_SAMPLE_TID are set.

In this configuration, and event will be inherited into any
child processes / threads, allowing convenient profiling of a
multiprocess or multithreaded application, whilst allowing
profiling tools to collect per-thread samples, in particular
of groups of counters.

Signed-off-by: Ben Gainey <ben.gainey@arm.com>
---
 include/linux/perf_event.h |  1 +
 kernel/events/core.c       | 53 ++++++++++++++++++++++++++------------
 2 files changed, 37 insertions(+), 17 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index d2a15c0c6f8a..7d405dff6694 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -932,6 +932,7 @@ struct perf_event_context {
 
 	int				nr_task_data;
 	int				nr_stat;
+	int				nr_stat_read;
 	int				nr_freq;
 	int				rotate_disable;
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index f0f0f71213a1..dac7093b3608 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1795,8 +1795,11 @@ list_add_event(struct perf_event *event, struct perf_event_context *ctx)
 	ctx->nr_events++;
 	if (event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT)
 		ctx->nr_user++;
-	if (event->attr.inherit_stat)
+	if (event->attr.inherit_stat) {
 		ctx->nr_stat++;
+		if (event->attr.inherit && (event->attr.sample_type & PERF_SAMPLE_READ))
+			ctx->nr_stat_read++;
+	}
 
 	if (event->state > PERF_EVENT_STATE_OFF)
 		perf_cgroup_event_enable(event, ctx);
@@ -2019,8 +2022,11 @@ list_del_event(struct perf_event *event, struct perf_event_context *ctx)
 	ctx->nr_events--;
 	if (event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT)
 		ctx->nr_user--;
-	if (event->attr.inherit_stat)
+	if (event->attr.inherit_stat) {
 		ctx->nr_stat--;
+		if (event->attr.inherit && (event->attr.sample_type & PERF_SAMPLE_READ))
+			ctx->nr_stat_read--;
+	}
 
 	list_del_rcu(&event->event_entry);
 
@@ -3529,11 +3535,17 @@ perf_event_context_sched_out(struct task_struct *task, struct task_struct *next)
 			perf_ctx_disable(ctx, false);
 
 			/* PMIs are disabled; ctx->nr_pending is stable. */
-			if (local_read(&ctx->nr_pending) ||
+			if (ctx->nr_stat_read ||
+			    next_ctx->nr_stat_read ||
+			    local_read(&ctx->nr_pending) ||
 			    local_read(&next_ctx->nr_pending)) {
 				/*
 				 * Must not swap out ctx when there's pending
 				 * events that rely on the ctx->task relation.
+				 *
+				 * Likewise, when a context contains inherit+inherit_stat+SAMPLE_READ
+				 * events they should be switched out using the slow path
+				 * so that they are treated as if they were distinct contexts.
 				 */
 				raw_spin_unlock(&next_ctx->lock);
 				rcu_read_unlock();
@@ -3545,6 +3557,7 @@ perf_event_context_sched_out(struct task_struct *task, struct task_struct *next)
 
 			perf_ctx_sched_task_cb(ctx, false);
 			perf_event_swap_task_ctx_data(ctx, next_ctx);
+			perf_event_sync_stat(ctx, next_ctx);
 
 			perf_ctx_enable(ctx, false);
 
@@ -3559,8 +3572,6 @@ perf_event_context_sched_out(struct task_struct *task, struct task_struct *next)
 			RCU_INIT_POINTER(next->perf_event_ctxp, ctx);
 
 			do_switch = 0;
-
-			perf_event_sync_stat(ctx, next_ctx);
 		}
 		raw_spin_unlock(&next_ctx->lock);
 		raw_spin_unlock(&ctx->lock);
@@ -4533,8 +4544,13 @@ static void __perf_event_read(void *info)
 	raw_spin_unlock(&ctx->lock);
 }
 
-static inline u64 perf_event_count(struct perf_event *event)
+static inline u64 perf_event_count(struct perf_event *event, bool from_sample)
 {
+	if (from_sample && event->attr.inherit &&
+       event->attr.inherit &&
+       (event->attr.sample_type & PERF_SAMPLE_TID)) {
+		return local64_read(&event->count);
+	}
 	return local64_read(&event->count) + atomic64_read(&event->child_count);
 }
 
@@ -5454,7 +5470,7 @@ static u64 __perf_event_read_value(struct perf_event *event, u64 *enabled, u64 *
 	mutex_lock(&event->child_mutex);
 
 	(void)perf_event_read(event, false);
-	total += perf_event_count(event);
+	total += perf_event_count(event, false);
 
 	*enabled += event->total_time_enabled +
 			atomic64_read(&event->child_total_time_enabled);
@@ -5463,7 +5479,7 @@ static u64 __perf_event_read_value(struct perf_event *event, u64 *enabled, u64 *
 
 	list_for_each_entry(child, &event->child_list, child_list) {
 		(void)perf_event_read(child, false);
-		total += perf_event_count(child);
+		total += perf_event_count(child, false);
 		*enabled += child->total_time_enabled;
 		*running += child->total_time_running;
 	}
@@ -5545,14 +5561,14 @@ static int __perf_read_group_add(struct perf_event *leader,
 	/*
 	 * Write {count,id} tuples for every sibling.
 	 */
-	values[n++] += perf_event_count(leader);
+	values[n++] += perf_event_count(leader, false);
 	if (read_format & PERF_FORMAT_ID)
 		values[n++] = primary_event_id(leader);
 	if (read_format & PERF_FORMAT_LOST)
 		values[n++] = atomic64_read(&leader->lost_samples);
 
 	for_each_sibling_event(sub, leader) {
-		values[n++] += perf_event_count(sub);
+		values[n++] += perf_event_count(sub, false);
 		if (read_format & PERF_FORMAT_ID)
 			values[n++] = primary_event_id(sub);
 		if (read_format & PERF_FORMAT_LOST)
@@ -6132,7 +6148,7 @@ void perf_event_update_userpage(struct perf_event *event)
 	++userpg->lock;
 	barrier();
 	userpg->index = perf_event_index(event);
-	userpg->offset = perf_event_count(event);
+	userpg->offset = perf_event_count(event, false);
 	if (userpg->index)
 		userpg->offset -= local64_read(&event->hw.prev_count);
 
@@ -7200,7 +7216,7 @@ static void perf_output_read_one(struct perf_output_handle *handle,
 	u64 values[5];
 	int n = 0;
 
-	values[n++] = perf_event_count(event);
+	values[n++] = perf_event_count(event, true);
 	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED) {
 		values[n++] = enabled +
 			atomic64_read(&event->child_total_time_enabled);
@@ -7245,7 +7261,7 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 	    (leader->state == PERF_EVENT_STATE_ACTIVE))
 		leader->pmu->read(leader);
 
-	values[n++] = perf_event_count(leader);
+	values[n++] = perf_event_count(leader, true);
 	if (read_format & PERF_FORMAT_ID)
 		values[n++] = primary_event_id(leader);
 	if (read_format & PERF_FORMAT_LOST)
@@ -7260,7 +7276,7 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 		    (sub->state == PERF_EVENT_STATE_ACTIVE))
 			sub->pmu->read(sub);
 
-		values[n++] = perf_event_count(sub);
+		values[n++] = perf_event_count(sub, false);
 		if (read_format & PERF_FORMAT_ID)
 			values[n++] = primary_event_id(sub);
 		if (read_format & PERF_FORMAT_LOST)
@@ -12010,10 +12026,13 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	local64_set(&hwc->period_left, hwc->sample_period);
 
 	/*
-	 * We currently do not support PERF_SAMPLE_READ on inherited events.
+	 * We do not support PERF_SAMPLE_READ on inherited events unless
+	 * inherit_stat and PERF_SAMPLE_TID are also selected, which allows
+	 * inherited events to collect per-thread samples.
 	 * See perf_output_read().
 	 */
-	if (attr->inherit && (attr->sample_type & PERF_SAMPLE_READ))
+	if (attr->inherit && (attr->sample_type & PERF_SAMPLE_READ)
+		&& !(attr->inherit_stat && (attr->sample_type & PERF_SAMPLE_TID)))
 		goto err_ns;
 
 	if (!has_branch_stack(event))
@@ -13037,7 +13056,7 @@ static void sync_child_event(struct perf_event *child_event)
 			perf_event_read_event(child_event, task);
 	}
 
-	child_val = perf_event_count(child_event);
+	child_val = perf_event_count(child_event, false);
 
 	/*
 	 * Add back the child's count to the parent's count:
-- 
2.43.0


