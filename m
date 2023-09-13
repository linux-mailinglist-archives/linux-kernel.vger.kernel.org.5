Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C96E79DE41
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 04:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238163AbjIMCVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 22:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238153AbjIMCVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 22:21:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147A3170A;
        Tue, 12 Sep 2023 19:20:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD12C433C9;
        Wed, 13 Sep 2023 02:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694571658;
        bh=Ux09g9gvrxiM7e96gBaO1VxVbWHC7sVtSUZj+woij6E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MWIXfpIYm9NEP1OadcLcMILX/yRVtaPGkZh+pKnN+/VGHmrzOeD87gZ9c50xSCL8T
         8eeLui/pnMGyuouBdR24HUhiq47J7olFaCqiix8Kq4z/bAX4LnLOjmPKCHsgwkMHef
         4vIcYFP6dYIErFnn1lFSQTnvXscr8IxyU4/DwmPe4YKJO9t+KHzR+SqXuFkaTXctaQ
         C7W+xMCx27zSpzYth6tRXZLtIyQRmZqV9TEcus8xqCmCTqqdJA1Drt/Q0F1eBMDPne
         jqOat7YDtf5VopmWMc2o5kWXNq+AEu4tnoYc2vCsMDbgqBzP1vYASGCIzoaHADaXz3
         SWxmmlSa9FS4Q==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v2 1/2] mm/damon/core: add a tracepoint for damos apply target regions
Date:   Wed, 13 Sep 2023 02:20:49 +0000
Message-Id: <20230913022050.2109-2-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230913022050.2109-1-sj@kernel.org>
References: <20230913022050.2109-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DAMON provides damon_aggregated tracepoint, which exposes details of
each region and its access monitoring results.  It is useful for
getting whole monitoring results, e.g., for recording purposes.

For investigations of DAMOS, DAMON Sysfs interface provides DAMOS
statistics and tried_regions directory.  But, those provides only
statistics and snapshots.  If the scheme is frequently applied and if
the user needs to know every detail of DAMOS behavior, the
snapshot-based interface could be insufficient and expensive.

As a last resort, userspace users need to record the all monitoring
results via damon_aggregated tracepoint and simulate how DAMOS would
worked.  It is unnecessarily complicated.  DAMON kernel API users,
meanwhile, can do that easily via before_damos_apply() callback field of
'struct damon_callback', though.

Add a tracepoint that will be called just after before_damos_apply()
callback for more convenient investigations of DAMOS.  The tracepoint
exposes all details about each regions, similar to damon_aggregated
tracepoint.

Please note that DAMOS is currently not only for memory management but
also for query-like efficient monitoring results retrievals (when 'stat'
action is used).  Until now, only statistics or snapshots were
supported.  Addition of this tracepoint allows efficient full recording
of DAMOS-based filtered monitoring results.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/trace/events/damon.h | 39 ++++++++++++++++++++++++++++++++++++
 mm/damon/core.c              | 32 ++++++++++++++++++++++++++++-
 2 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
index 0b8d13bde17a..19930bb7af9a 100644
--- a/include/trace/events/damon.h
+++ b/include/trace/events/damon.h
@@ -9,6 +9,45 @@
 #include <linux/types.h>
 #include <linux/tracepoint.h>
 
+TRACE_EVENT_CONDITION(damos_before_apply,
+
+	TP_PROTO(unsigned int context_idx, unsigned int scheme_idx,
+		unsigned int target_idx, struct damon_region *r,
+		unsigned int nr_regions, bool do_trace),
+
+	TP_ARGS(context_idx, target_idx, scheme_idx, r, nr_regions, do_trace),
+
+	TP_CONDITION(do_trace),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, context_idx)
+		__field(unsigned int, scheme_idx)
+		__field(unsigned long, target_idx)
+		__field(unsigned long, start)
+		__field(unsigned long, end)
+		__field(unsigned int, nr_accesses)
+		__field(unsigned int, age)
+		__field(unsigned int, nr_regions)
+	),
+
+	TP_fast_assign(
+		__entry->context_idx = context_idx;
+		__entry->scheme_idx = scheme_idx;
+		__entry->target_idx = target_idx;
+		__entry->start = r->ar.start;
+		__entry->end = r->ar.end;
+		__entry->nr_accesses = r->nr_accesses;
+		__entry->age = r->age;
+		__entry->nr_regions = nr_regions;
+	),
+
+	TP_printk("ctx_idx=%u scheme_idx=%u target_idx=%lu nr_regions=%u %lu-%lu: %u %u",
+			__entry->context_idx, __entry->scheme_idx,
+			__entry->target_idx, __entry->nr_regions,
+			__entry->start, __entry->end,
+			__entry->nr_accesses, __entry->age)
+);
+
 TRACE_EVENT(damon_aggregated,
 
 	TP_PROTO(unsigned int target_id, struct damon_region *r,
diff --git a/mm/damon/core.c b/mm/damon/core.c
index ca631dd88b33..3ca34a252a3c 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -950,6 +950,33 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 	struct timespec64 begin, end;
 	unsigned long sz_applied = 0;
 	int err = 0;
+	/*
+	 * We plan to support multiple context per kdamond, as DAMON sysfs
+	 * implies with 'nr_contexts' file.  Nevertheless, only single context
+	 * per kdamond is supported for now.  So, we can simply use '0' context
+	 * index here.
+	 */
+	unsigned int cidx = 0;
+	struct damos *siter;		/* schemes iterator */
+	unsigned int sidx = 0;
+	struct damon_target *titer;	/* targets iterator */
+	unsigned int tidx = 0;
+	bool do_trace = false;
+
+	/* get indices for trace_damos_before_apply() */
+	if (trace_damos_before_apply_enabled()) {
+		damon_for_each_scheme(siter, c) {
+			if (siter == s)
+				break;
+			sidx++;
+		}
+		damon_for_each_target(titer, c) {
+			if (titer == t)
+				break;
+			tidx++;
+		}
+		do_trace = true;
+	}
 
 	if (c->ops.apply_scheme) {
 		if (quota->esz && quota->charged_sz + sz > quota->esz) {
@@ -964,8 +991,11 @@ static void damos_apply_scheme(struct damon_ctx *c, struct damon_target *t,
 		ktime_get_coarse_ts64(&begin);
 		if (c->callback.before_damos_apply)
 			err = c->callback.before_damos_apply(c, t, r, s);
-		if (!err)
+		if (!err) {
+			trace_damos_before_apply(cidx, sidx, tidx, r,
+					damon_nr_regions(t), do_trace);
 			sz_applied = c->ops.apply_scheme(c, t, r, s);
+		}
 		ktime_get_coarse_ts64(&end);
 		quota->total_charged_ns += timespec64_to_ns(&end) -
 			timespec64_to_ns(&begin);
-- 
2.25.1

