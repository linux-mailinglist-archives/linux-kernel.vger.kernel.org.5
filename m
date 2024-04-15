Return-Path: <linux-kernel+bounces-144744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FDC8A4A21
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73C811F22853
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77743F9D4;
	Mon, 15 Apr 2024 08:15:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490FA3BBD9;
	Mon, 15 Apr 2024 08:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713168902; cv=none; b=aZTfyzdUpkYcp38m542j8bAy2Ocq6hRbS9Eslo9tAgTa9YQzUndromo1VXQP9OU3hHSlgFHU7lQN43xI3qvi4XwA7JJOfzamKVPRlim8kc3SL3bEAc1idMji6yKUueSiZ+3w17i595g4hqhziwEbBWcog9HBAwPYqfuBoWcP1aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713168902; c=relaxed/simple;
	bh=1vW++xN8zF1A0z3Y8yp49FhFAPI2if6N2fDvYtR7R4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KmRAFrl5JjAYs7qR0jLJ6U/lMK5HqvrOUUb8LDUehiE+9CnlHBLuImzsIcadsH23Ir3AXgZ8Lskb/+PQr/ptGz0gjm41pBC3JGoWROwsUDhCknloT6a3b9z+DPY4fBaQEnPDa+OM8e5dfpIIKmtMXZd3uLvGFkMs/hde0rGrvqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 170D81476;
	Mon, 15 Apr 2024 01:15:28 -0700 (PDT)
Received: from e126817.cambridge.arm.com (e126817.cambridge.arm.com [10.2.3.5])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 14AAF3F64C;
	Mon, 15 Apr 2024 01:14:57 -0700 (PDT)
From: Ben Gainey <ben.gainey@arm.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: james.clark@arm.com,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ben Gainey <ben.gainey@arm.com>
Subject: [PATCH v5 1/4] perf: Support PERF_SAMPLE_READ with inherit
Date: Mon, 15 Apr 2024 09:14:45 +0100
Message-ID: <20240415081448.123789-2-ben.gainey@arm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240415081448.123789-1-ben.gainey@arm.com>
References: <20240415081448.123789-1-ben.gainey@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change allows events to use PERF_SAMPLE READ with inherit
so long as PERF_SAMPLE_TID is also set.

In this configuration, an event will be inherited into any
child processes / threads, allowing convenient profiling of a
multiprocess or multithreaded application, whilst allowing
profiling tools to collect per-thread samples, in particular
of groups of counters.

The read_format field of both PERF_RECORD_READ and PERF_RECORD_SAMPLE
are changed by this new configuration, but calls to `read()` on the same
event file descriptor are unaffected and continue to return the
cumulative total.

Signed-off-by: Ben Gainey <ben.gainey@arm.com>
---
 include/linux/perf_event.h |  1 +
 kernel/events/core.c       | 82 ++++++++++++++++++++++++++++----------
 2 files changed, 62 insertions(+), 21 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index d2a15c0c6f8a..e7eed33c50f1 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -932,6 +932,7 @@ struct perf_event_context {
 
 	int				nr_task_data;
 	int				nr_stat;
+	int				nr_inherit_read;
 	int				nr_freq;
 	int				rotate_disable;
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 724e6d7e128f..bf0639a2e2b1 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1767,6 +1767,18 @@ perf_event_groups_next(struct perf_event *event, struct pmu *pmu)
 		event = rb_entry_safe(rb_next(&event->group_node),	\
 				typeof(*event), group_node))
 
+/*
+ * Does the event attribute request inherit with PERF_SAMPLE_READ
+ */
+#define perf_attr_has_inherit_and_sample_read(attr)			\
+	((attr)->inherit && ((attr)->sample_type & PERF_SAMPLE_READ))
+
+/*
+ * Does the event request an attribte that requests inherit with PERF_SAMPLE_READ
+ */
+#define perf_event_has_inherit_and_sample_read(event)			\
+	perf_attr_has_inherit_and_sample_read(&((event)->attr))
+
 /*
  * Add an event from the lists for its context.
  * Must be called with ctx->mutex and ctx->lock held.
@@ -1797,6 +1809,8 @@ list_add_event(struct perf_event *event, struct perf_event_context *ctx)
 		ctx->nr_user++;
 	if (event->attr.inherit_stat)
 		ctx->nr_stat++;
+	if (perf_event_has_inherit_and_sample_read(event))
+		ctx->nr_inherit_read++;
 
 	if (event->state > PERF_EVENT_STATE_OFF)
 		perf_cgroup_event_enable(event, ctx);
@@ -2021,6 +2035,8 @@ list_del_event(struct perf_event *event, struct perf_event_context *ctx)
 		ctx->nr_user--;
 	if (event->attr.inherit_stat)
 		ctx->nr_stat--;
+	if (perf_event_has_inherit_and_sample_read(event))
+		ctx->nr_inherit_read--;
 
 	list_del_rcu(&event->event_entry);
 
@@ -3529,11 +3545,18 @@ perf_event_context_sched_out(struct task_struct *task, struct task_struct *next)
 			perf_ctx_disable(ctx, false);
 
 			/* PMIs are disabled; ctx->nr_pending is stable. */
-			if (local_read(&ctx->nr_pending) ||
+			if (ctx->nr_inherit_read ||
+			    next_ctx->nr_inherit_read ||
+			    local_read(&ctx->nr_pending) ||
 			    local_read(&next_ctx->nr_pending)) {
 				/*
 				 * Must not swap out ctx when there's pending
 				 * events that rely on the ctx->task relation.
+				 *
+				 * Likewise, when a context contains inherit +
+				 * SAMPLE_READ events they should be switched
+				 * out using the slow path so that they are
+				 * treated as if they were distinct contexts.
 				 */
 				raw_spin_unlock(&next_ctx->lock);
 				rcu_read_unlock();
@@ -4533,11 +4556,19 @@ static void __perf_event_read(void *info)
 	raw_spin_unlock(&ctx->lock);
 }
 
-static inline u64 perf_event_count(struct perf_event *event)
+static inline u64 perf_event_count_cumulative(struct perf_event *event)
 {
 	return local64_read(&event->count) + atomic64_read(&event->child_count);
 }
 
+static inline u64 perf_event_count(struct perf_event *event, bool self_value_only)
+{
+	if (self_value_only && perf_event_has_inherit_and_sample_read(event))
+		return local64_read(&event->count);
+
+	return perf_event_count_cumulative(event);
+}
+
 static void calc_timer_values(struct perf_event *event,
 				u64 *now,
 				u64 *enabled,
@@ -5454,7 +5485,7 @@ static u64 __perf_event_read_value(struct perf_event *event, u64 *enabled, u64 *
 	mutex_lock(&event->child_mutex);
 
 	(void)perf_event_read(event, false);
-	total += perf_event_count(event);
+	total += perf_event_count_cumulative(event);
 
 	*enabled += event->total_time_enabled +
 			atomic64_read(&event->child_total_time_enabled);
@@ -5463,7 +5494,7 @@ static u64 __perf_event_read_value(struct perf_event *event, u64 *enabled, u64 *
 
 	list_for_each_entry(child, &event->child_list, child_list) {
 		(void)perf_event_read(child, false);
-		total += perf_event_count(child);
+		total += perf_event_count_cumulative(child);
 		*enabled += child->total_time_enabled;
 		*running += child->total_time_running;
 	}
@@ -5545,14 +5576,14 @@ static int __perf_read_group_add(struct perf_event *leader,
 	/*
 	 * Write {count,id} tuples for every sibling.
 	 */
-	values[n++] += perf_event_count(leader);
+	values[n++] += perf_event_count_cumulative(leader);
 	if (read_format & PERF_FORMAT_ID)
 		values[n++] = primary_event_id(leader);
 	if (read_format & PERF_FORMAT_LOST)
 		values[n++] = atomic64_read(&leader->lost_samples);
 
 	for_each_sibling_event(sub, leader) {
-		values[n++] += perf_event_count(sub);
+		values[n++] += perf_event_count_cumulative(sub);
 		if (read_format & PERF_FORMAT_ID)
 			values[n++] = primary_event_id(sub);
 		if (read_format & PERF_FORMAT_LOST)
@@ -6132,7 +6163,7 @@ void perf_event_update_userpage(struct perf_event *event)
 	++userpg->lock;
 	barrier();
 	userpg->index = perf_event_index(event);
-	userpg->offset = perf_event_count(event);
+	userpg->offset = perf_event_count_cumulative(event);
 	if (userpg->index)
 		userpg->offset -= local64_read(&event->hw.prev_count);
 
@@ -7194,13 +7225,14 @@ void perf_event__output_id_sample(struct perf_event *event,
 
 static void perf_output_read_one(struct perf_output_handle *handle,
 				 struct perf_event *event,
-				 u64 enabled, u64 running)
+				 u64 enabled, u64 running,
+				 bool from_sample)
 {
 	u64 read_format = event->attr.read_format;
 	u64 values[5];
 	int n = 0;
 
-	values[n++] = perf_event_count(event);
+	values[n++] = perf_event_count(event, from_sample);
 	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED) {
 		values[n++] = enabled +
 			atomic64_read(&event->child_total_time_enabled);
@@ -7218,8 +7250,9 @@ static void perf_output_read_one(struct perf_output_handle *handle,
 }
 
 static void perf_output_read_group(struct perf_output_handle *handle,
-			    struct perf_event *event,
-			    u64 enabled, u64 running)
+				   struct perf_event *event,
+				   u64 enabled, u64 running,
+				   bool from_sample)
 {
 	struct perf_event *leader = event->group_leader, *sub;
 	u64 read_format = event->attr.read_format;
@@ -7245,7 +7278,7 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 	    (leader->state == PERF_EVENT_STATE_ACTIVE))
 		leader->pmu->read(leader);
 
-	values[n++] = perf_event_count(leader);
+	values[n++] = perf_event_count(leader, from_sample);
 	if (read_format & PERF_FORMAT_ID)
 		values[n++] = primary_event_id(leader);
 	if (read_format & PERF_FORMAT_LOST)
@@ -7260,7 +7293,7 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 		    (sub->state == PERF_EVENT_STATE_ACTIVE))
 			sub->pmu->read(sub);
 
-		values[n++] = perf_event_count(sub);
+		values[n++] = perf_event_count(sub, from_sample);
 		if (read_format & PERF_FORMAT_ID)
 			values[n++] = primary_event_id(sub);
 		if (read_format & PERF_FORMAT_LOST)
@@ -7281,9 +7314,14 @@ static void perf_output_read_group(struct perf_output_handle *handle,
  * The problem is that its both hard and excessively expensive to iterate the
  * child list, not to mention that its impossible to IPI the children running
  * on another CPU, from interrupt/NMI context.
+ *
+ * Instead the combination of PERF_SAMPLE_READ and inherit will track per-thread
+ * counts rather than attempting to accumulate some value across all children on
+ * all cores.
  */
 static void perf_output_read(struct perf_output_handle *handle,
-			     struct perf_event *event)
+			     struct perf_event *event,
+			     bool from_sample)
 {
 	u64 enabled = 0, running = 0, now;
 	u64 read_format = event->attr.read_format;
@@ -7301,9 +7339,9 @@ static void perf_output_read(struct perf_output_handle *handle,
 		calc_timer_values(event, &now, &enabled, &running);
 
 	if (event->attr.read_format & PERF_FORMAT_GROUP)
-		perf_output_read_group(handle, event, enabled, running);
+		perf_output_read_group(handle, event, enabled, running, from_sample);
 	else
-		perf_output_read_one(handle, event, enabled, running);
+		perf_output_read_one(handle, event, enabled, running, from_sample);
 }
 
 void perf_output_sample(struct perf_output_handle *handle,
@@ -7343,7 +7381,7 @@ void perf_output_sample(struct perf_output_handle *handle,
 		perf_output_put(handle, data->period);
 
 	if (sample_type & PERF_SAMPLE_READ)
-		perf_output_read(handle, event);
+		perf_output_read(handle, event, true);
 
 	if (sample_type & PERF_SAMPLE_CALLCHAIN) {
 		int size = 1;
@@ -7944,7 +7982,7 @@ perf_event_read_event(struct perf_event *event,
 		return;
 
 	perf_output_put(&handle, read_event);
-	perf_output_read(&handle, event);
+	perf_output_read(&handle, event, false);
 	perf_event__output_id_sample(event, &handle, &sample);
 
 	perf_output_end(&handle);
@@ -12006,10 +12044,12 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	local64_set(&hwc->period_left, hwc->sample_period);
 
 	/*
-	 * We currently do not support PERF_SAMPLE_READ on inherited events.
+	 * We do not support PERF_SAMPLE_READ on inherited events unless
+	 * PERF_SAMPLE_TID is also selected, which allows inherited events to
+	 * collect per-thread samples.
 	 * See perf_output_read().
 	 */
-	if (attr->inherit && (attr->sample_type & PERF_SAMPLE_READ))
+	if (perf_attr_has_inherit_and_sample_read(attr) && !(attr->sample_type & PERF_SAMPLE_TID))
 		goto err_ns;
 
 	if (!has_branch_stack(event))
@@ -13033,7 +13073,7 @@ static void sync_child_event(struct perf_event *child_event)
 			perf_event_read_event(child_event, task);
 	}
 
-	child_val = perf_event_count(child_event);
+	child_val = perf_event_count_cumulative(child_event);
 
 	/*
 	 * Add back the child's count to the parent's count:
-- 
2.44.0


