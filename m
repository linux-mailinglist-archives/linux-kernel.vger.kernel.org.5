Return-Path: <linux-kernel+bounces-24056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C0282B62A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 21:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0916286C9C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 20:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73E758115;
	Thu, 11 Jan 2024 20:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwIz6VS7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AAE58106
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 20:43:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 392CAC433F1;
	Thu, 11 Jan 2024 20:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705005829;
	bh=NFzE+YKtLawiYu/E3lJ0ILwG7y45U80IPhIyV+2Ckc4=;
	h=From:To:Cc:Subject:Date:From;
	b=EwIz6VS79VhNeHrc0JxJYi+IJU+lFqjzZcHuu908VtZ2hi/tEZVBH5cuVuhEd8Ko2
	 3wRfg3cIGskirNe//STy5A3LuwI3s4s5OAIYlRuBw95wRNVepJWJhMlFoLRIUYh//x
	 wAE/xQrtkOyxe0iyRo5O5KDut85MgjbkLltabldbbOg/3EMzkKbZk8TsK2DufBeyXo
	 mY89XQFJcnFmxuAtEt0x3kGBzsAVhLLCBVpRkW/7evMGUK5nu8OfrCqLw4vHZ9BFag
	 eOKwcr+fUDDoy4Y+44aJH4fVnSGM8J359SekOevwUPY5U85Y2VjwexcoZsU07pHw5B
	 xxP44xjj31s4Q==
From: namhyung@kernel.org
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Mingwei Zhang <mizhang@google.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH v2 1/2] perf/core: Update perf_adjust_freq_unthr_context()
Date: Thu, 11 Jan 2024 12:43:47 -0800
Message-ID: <20240111204348.669673-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Namhyung Kim <namhyung@kernel.org>

It was unnecessarily disabling and enabling PMUs for each event.  It
should be done at PMU level, otherwise it'd increase the interrupt
latency when there are slow (uncore or virtual) PMUs and lots of events
on the PMUs.

Add pmu_ctx->nr_freq counter to check it at each PMU.  As pmu context
has separate active lists for pinned group and flexible group, factor
out a new function to do the job.  Also it can skip pmu contexts with
no active events (due to multiplexing or hybrid PMUs).

Another minor optimization is that it can skip PMUs w/ CAP_NO_INTERRUPT
even if it needs to unthrottle sampling events.

Reviewed-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Tested-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
v2: Check if pmu context is active  (Mark)

 include/linux/perf_event.h |  6 ++++
 kernel/events/core.c       | 70 ++++++++++++++++++++++++--------------
 2 files changed, 50 insertions(+), 26 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index d2a15c0c6f8a..3e33b366347a 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -883,6 +883,7 @@ struct perf_event_pmu_context {
 
 	unsigned int			nr_events;
 	unsigned int			nr_cgroups;
+	unsigned int			nr_freq;
 
 	atomic_t			refcount; /* event <-> epc */
 	struct rcu_head			rcu_head;
@@ -897,6 +898,11 @@ struct perf_event_pmu_context {
 	int				rotate_necessary;
 };
 
+static inline bool perf_pmu_ctx_is_active(struct perf_event_pmu_context *epc)
+{
+	return !list_empty(&epc->flexible_active) || !list_empty(&epc->pinned_active);
+}
+
 struct perf_event_groups {
 	struct rb_root	tree;
 	u64		index;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 59b332cce9e7..e9ce79c8c145 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2277,8 +2277,10 @@ event_sched_out(struct perf_event *event, struct perf_event_context *ctx)
 
 	if (!is_software_event(event))
 		cpc->active_oncpu--;
-	if (event->attr.freq && event->attr.sample_freq)
+	if (event->attr.freq && event->attr.sample_freq) {
 		ctx->nr_freq--;
+		epc->nr_freq--;
+	}
 	if (event->attr.exclusive || !cpc->active_oncpu)
 		cpc->exclusive = 0;
 
@@ -2533,9 +2535,10 @@ event_sched_in(struct perf_event *event, struct perf_event_context *ctx)
 
 	if (!is_software_event(event))
 		cpc->active_oncpu++;
-	if (event->attr.freq && event->attr.sample_freq)
+	if (event->attr.freq && event->attr.sample_freq) {
 		ctx->nr_freq++;
-
+		epc->nr_freq++;
+	}
 	if (event->attr.exclusive)
 		cpc->exclusive = 1;
 
@@ -4098,30 +4101,14 @@ static void perf_adjust_period(struct perf_event *event, u64 nsec, u64 count, bo
 	}
 }
 
-/*
- * combine freq adjustment with unthrottling to avoid two passes over the
- * events. At the same time, make sure, having freq events does not change
- * the rate of unthrottling as that would introduce bias.
- */
-static void
-perf_adjust_freq_unthr_context(struct perf_event_context *ctx, bool unthrottle)
+static void perf_adjust_freq_unthr_events(struct list_head *event_list)
 {
 	struct perf_event *event;
 	struct hw_perf_event *hwc;
 	u64 now, period = TICK_NSEC;
 	s64 delta;
 
-	/*
-	 * only need to iterate over all events iff:
-	 * - context have events in frequency mode (needs freq adjust)
-	 * - there are events to unthrottle on this cpu
-	 */
-	if (!(ctx->nr_freq || unthrottle))
-		return;
-
-	raw_spin_lock(&ctx->lock);
-
-	list_for_each_entry_rcu(event, &ctx->event_list, event_entry) {
+	list_for_each_entry(event, event_list, active_list) {
 		if (event->state != PERF_EVENT_STATE_ACTIVE)
 			continue;
 
@@ -4129,8 +4116,6 @@ perf_adjust_freq_unthr_context(struct perf_event_context *ctx, bool unthrottle)
 		if (!event_filter_match(event))
 			continue;
 
-		perf_pmu_disable(event->pmu);
-
 		hwc = &event->hw;
 
 		if (hwc->interrupts == MAX_INTERRUPTS) {
@@ -4140,7 +4125,7 @@ perf_adjust_freq_unthr_context(struct perf_event_context *ctx, bool unthrottle)
 		}
 
 		if (!event->attr.freq || !event->attr.sample_freq)
-			goto next;
+			continue;
 
 		/*
 		 * stop the event and update event->count
@@ -4162,8 +4147,41 @@ perf_adjust_freq_unthr_context(struct perf_event_context *ctx, bool unthrottle)
 			perf_adjust_period(event, period, delta, false);
 
 		event->pmu->start(event, delta > 0 ? PERF_EF_RELOAD : 0);
-	next:
-		perf_pmu_enable(event->pmu);
+	}
+}
+
+/*
+ * combine freq adjustment with unthrottling to avoid two passes over the
+ * events. At the same time, make sure, having freq events does not change
+ * the rate of unthrottling as that would introduce bias.
+ */
+static void
+perf_adjust_freq_unthr_context(struct perf_event_context *ctx, bool unthrottle)
+{
+	struct perf_event_pmu_context *pmu_ctx;
+
+	/*
+	 * only need to iterate over all events iff:
+	 * - context have events in frequency mode (needs freq adjust)
+	 * - there are events to unthrottle on this cpu
+	 */
+	if (!(ctx->nr_freq || unthrottle))
+		return;
+
+	raw_spin_lock(&ctx->lock);
+
+	list_for_each_entry(pmu_ctx, &ctx->pmu_ctx_list, pmu_ctx_entry) {
+		if (!(pmu_ctx->nr_freq || unthrottle))
+			continue;
+		if (!perf_pmu_ctx_is_active(pmu_ctx))
+			continue;
+		if (pmu_ctx->pmu->capabilities & PERF_PMU_CAP_NO_INTERRUPT)
+			continue;
+
+		perf_pmu_disable(pmu_ctx->pmu);
+		perf_adjust_freq_unthr_events(&pmu_ctx->pinned_active);
+		perf_adjust_freq_unthr_events(&pmu_ctx->flexible_active);
+		perf_pmu_enable(pmu_ctx->pmu);
 	}
 
 	raw_spin_unlock(&ctx->lock);
-- 
2.43.0.275.g3460e3d667-goog


