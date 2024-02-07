Return-Path: <linux-kernel+bounces-55970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C6B84C44A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 06:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AA901F2299A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 05:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEC41CAB7;
	Wed,  7 Feb 2024 05:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xsui2B8z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EF41AAA5
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 05:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707282348; cv=none; b=dMRLh3G+JN6oD3TALcoAU7GhcCNvMDuK9L+5UypcZbN9s8vxoEoqjkw+UfgC0xoTzET+tZZ9awpMg+wJUNyNTOmO/YosK6xPoVDMZIMalDSfxzs9xWKyDq5ZaAd7T5f3hkaWHPPBrrg/UA3c0o44purvWQWgkY7BE9MjebYafY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707282348; c=relaxed/simple;
	bh=KO8aCqFSDUR/kXIhzYaIU5Xdq8meb2AOBlSD7gNJRzM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=syoTWPFqjmAz6TEg3iG93CfZpDfpLgdFFtsIcVkRVrSQgzFenT/Z8ZMBjznkFA1Ycq0oj75+cxCefvBRGRsFeiU4zmUAMaXNH0IRUNML5GJKF7RBighITNN2j9c2gx9wMRaXm2A9q6ETV+GUIr3U1Vg87NhvyzA/2Q+tszU8HOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xsui2B8z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 269F6C43390;
	Wed,  7 Feb 2024 05:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707282347;
	bh=KO8aCqFSDUR/kXIhzYaIU5Xdq8meb2AOBlSD7gNJRzM=;
	h=From:To:Cc:Subject:Date:From;
	b=Xsui2B8zeKksF5RoXhLUKtZLmLE2+Z8YUqqUVlvDF4L+YwhQ4Ea6fGlhURSVaJKtn
	 fm/gizNluTnfdYWj6cNKTZiqn6ASQNe+mAHqNESbzrJ0h9ei2biDUE/pywUlqcOXMf
	 ypFx/heuXNhFdxaCmR4Ir8RMNxllWeN+SahTsczK/bS0XUol7WmNJ8QbblHZWKWd7T
	 NSFn1mc4v4AsxClRRl4iVv7FFCYdqhAxDA3G0ctEVic6n79Ty99drb0KfsXoLrD8WC
	 /6q5TNBYbCyAdQlHFxXe8r+QG1+Auam7Oip09Vs9tgbZDfzyCAI6rubUPjNyKV5Dt8
	 4w/Cm10nYt0EQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Mingwei Zhang <mizhang@google.com>
Subject: [PATCH v3 1/2] perf/core: Update perf_adjust_freq_unthr_context()
Date: Tue,  6 Feb 2024 21:05:44 -0800
Message-ID: <20240207050545.2727923-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It was unnecessarily disabling and enabling PMUs for each event.  It
should be done at PMU level.  Add pmu_ctx->nr_freq counter to check it
at each PMU.  As pmu context has separate active lists for pinned group
and flexible group, factor out a new function to do the job.

Another minor optimization is that it can skip PMUs w/ CAP_NO_INTERRUPT
even if it needs to unthrottle sampling events.

Reviewed-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Tested-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
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
2.43.0.594.gd9cf4e227d-goog


