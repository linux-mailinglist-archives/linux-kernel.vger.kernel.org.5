Return-Path: <linux-kernel+bounces-111792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5BF88710F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F6641C214F9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04D95674C;
	Fri, 22 Mar 2024 16:42:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316215A11D;
	Fri, 22 Mar 2024 16:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711125772; cv=none; b=V6IXMflnYM5It1J4FYmHX1DSoSLDCX3I0AJM2Tf7mCT3UIk8fE8dCm6fCaqozfmB8oi49h1aMlsVij6qsHJ7yXXgE9gL+cV1yaKFGBszokBQP0cHlQOkazwzj28J8wbvIsBJ1kRAiwm1UDTOObdl8US8e8/5Sjb3VcKqUvkseZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711125772; c=relaxed/simple;
	bh=EK8nvo4TRweQgyliYjiBd+AvfZpo6ofH+nQNVcwGxD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oKYOnTPJ6k4j7U+VhwnVE4WruxOwk+0AXb5P1hkqtk0U2B6dcyNAdPSKigP71ozvn2ULNLnJuJQI81IeXhkAjU1OjQl/JIlbPS8B2y09n3OG1YzNoTTzocs5QFCPJY3hnR0ecIP4f97XlJLGMK78fYAbrxxFen2uzok8SxHfyRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFA8E1007;
	Fri, 22 Mar 2024 09:43:23 -0700 (PDT)
Received: from e126817.cambridge.arm.com (e126817.cambridge.arm.com [10.2.3.5])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C03983F762;
	Fri, 22 Mar 2024 09:42:47 -0700 (PDT)
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
Subject: [PATCH v4 1/4] perf: Support PERF_SAMPLE_READ with inherit_stat
Date: Fri, 22 Mar 2024 16:42:34 +0000
Message-ID: <20240322164237.203358-2-ben.gainey@arm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322164237.203358-1-ben.gainey@arm.com>
References: <20240322164237.203358-1-ben.gainey@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change allows events to use PERF_SAMPLE READ with inherit
so long as both inherit_stat and PERF_SAMPLE_TID are set.

In this configuration, an event will be inherited into any
child processes / threads, allowing convenient profiling of a
multiprocess or multithreaded application, whilst allowing
profiling tools to collect per-thread samples, in particular
of groups of counters.

Signed-off-by: Ben Gainey <ben.gainey@arm.com>
---
 include/linux/perf_event.h |  1 +
 kernel/events/core.c       | 62 +++++++++++++++++++++++++++++---------
 2 files changed, 48 insertions(+), 15 deletions(-)

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
index f0f0f71213a1..870a7dbd8d5f 100644
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
@@ -1795,8 +1807,11 @@ list_add_event(struct perf_event *event, struct perf_event_context *ctx)
 	ctx->nr_events++;
 	if (event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT)
 		ctx->nr_user++;
-	if (event->attr.inherit_stat)
+	if (event->attr.inherit_stat) {
 		ctx->nr_stat++;
+		if (perf_event_has_inherit_and_sample_read(event))
+			ctx->nr_stat_read++;
+	}
 
 	if (event->state > PERF_EVENT_STATE_OFF)
 		perf_cgroup_event_enable(event, ctx);
@@ -2019,8 +2034,11 @@ list_del_event(struct perf_event *event, struct perf_event_context *ctx)
 	ctx->nr_events--;
 	if (event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT)
 		ctx->nr_user--;
-	if (event->attr.inherit_stat)
+	if (event->attr.inherit_stat) {
 		ctx->nr_stat--;
+		if (perf_event_has_inherit_and_sample_read(event))
+			ctx->nr_stat_read--;
+	}
 
 	list_del_rcu(&event->event_entry);
 
@@ -3529,11 +3547,19 @@ perf_event_context_sched_out(struct task_struct *task, struct task_struct *next)
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
+				 * Likewise, when a context contains inherit +
+				 * inherit_stat + SAMPLE_READ events they
+				 * should be switched out using the slow path
+				 * so that they are treated as if they were
+				 * distinct contexts.
 				 */
 				raw_spin_unlock(&next_ctx->lock);
 				rcu_read_unlock();
@@ -4533,8 +4559,11 @@ static void __perf_event_read(void *info)
 	raw_spin_unlock(&ctx->lock);
 }
 
-static inline u64 perf_event_count(struct perf_event *event)
+static inline u64 perf_event_count(struct perf_event *event, bool self_value_only)
 {
+	if (self_value_only && perf_event_has_inherit_and_sample_read(event))
+		return local64_read(&event->count);
+
 	return local64_read(&event->count) + atomic64_read(&event->child_count);
 }
 
@@ -5454,7 +5483,7 @@ static u64 __perf_event_read_value(struct perf_event *event, u64 *enabled, u64 *
 	mutex_lock(&event->child_mutex);
 
 	(void)perf_event_read(event, false);
-	total += perf_event_count(event);
+	total += perf_event_count(event, false);
 
 	*enabled += event->total_time_enabled +
 			atomic64_read(&event->child_total_time_enabled);
@@ -5463,7 +5492,7 @@ static u64 __perf_event_read_value(struct perf_event *event, u64 *enabled, u64 *
 
 	list_for_each_entry(child, &event->child_list, child_list) {
 		(void)perf_event_read(child, false);
-		total += perf_event_count(child);
+		total += perf_event_count(child, false);
 		*enabled += child->total_time_enabled;
 		*running += child->total_time_running;
 	}
@@ -5545,14 +5574,14 @@ static int __perf_read_group_add(struct perf_event *leader,
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
@@ -6132,7 +6161,7 @@ void perf_event_update_userpage(struct perf_event *event)
 	++userpg->lock;
 	barrier();
 	userpg->index = perf_event_index(event);
-	userpg->offset = perf_event_count(event);
+	userpg->offset = perf_event_count(event, false);
 	if (userpg->index)
 		userpg->offset -= local64_read(&event->hw.prev_count);
 
@@ -7200,7 +7229,7 @@ static void perf_output_read_one(struct perf_output_handle *handle,
 	u64 values[5];
 	int n = 0;
 
-	values[n++] = perf_event_count(event);
+	values[n++] = perf_event_count(event, true);
 	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED) {
 		values[n++] = enabled +
 			atomic64_read(&event->child_total_time_enabled);
@@ -7245,7 +7274,7 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 	    (leader->state == PERF_EVENT_STATE_ACTIVE))
 		leader->pmu->read(leader);
 
-	values[n++] = perf_event_count(leader);
+	values[n++] = perf_event_count(leader, true);
 	if (read_format & PERF_FORMAT_ID)
 		values[n++] = primary_event_id(leader);
 	if (read_format & PERF_FORMAT_LOST)
@@ -7260,7 +7289,7 @@ static void perf_output_read_group(struct perf_output_handle *handle,
 		    (sub->state == PERF_EVENT_STATE_ACTIVE))
 			sub->pmu->read(sub);
 
-		values[n++] = perf_event_count(sub);
+		values[n++] = perf_event_count(sub, false);
 		if (read_format & PERF_FORMAT_ID)
 			values[n++] = primary_event_id(sub);
 		if (read_format & PERF_FORMAT_LOST)
@@ -12010,10 +12039,13 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	local64_set(&hwc->period_left, hwc->sample_period);
 
 	/*
-	 * We currently do not support PERF_SAMPLE_READ on inherited events.
+	 * We do not support PERF_SAMPLE_READ on inherited events unless
+	 * inherit_stat and PERF_SAMPLE_TID are also selected, which allows
+	 * inherited events to collect per-thread samples.
 	 * See perf_output_read().
 	 */
-	if (attr->inherit && (attr->sample_type & PERF_SAMPLE_READ))
+	if (perf_attr_has_inherit_and_sample_read(attr)
+		&& !(attr->inherit_stat && (attr->sample_type & PERF_SAMPLE_TID)))
 		goto err_ns;
 
 	if (!has_branch_stack(event))
@@ -13037,7 +13069,7 @@ static void sync_child_event(struct perf_event *child_event)
 			perf_event_read_event(child_event, task);
 	}
 
-	child_val = perf_event_count(child_event);
+	child_val = perf_event_count(child_event, false);
 
 	/*
 	 * Add back the child's count to the parent's count:
-- 
2.44.0


