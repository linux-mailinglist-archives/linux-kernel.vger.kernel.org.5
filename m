Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55BAC758A02
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 02:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjGSATB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 20:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjGSAS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 20:18:56 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90611715
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 17:18:47 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-576d63dfc1dso57087077b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 17:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689725927; x=1692317927;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=89xDhKy5l7vxo2+qhhUkXKLJEl4EKrwY/Qi9H8xXUCI=;
        b=gIdel0GCvcaHSKraw2i4Ivn7O4LlQ53nZfo/62RYSLb9hMhmWLLBmY5vgEMRZ1W84V
         GDUp6U2HyeWbRMzIzEIuPP1dgdIUtGMFxHLUSCZ9MnsaA8aPsyVFeKUQIIIHLJ8nibbF
         97J9BjhQV0UOl2G8j1YHlOuAHAaUYvzW/240+X+easGP1/F9W28wH0OHj3LbUU5dOckM
         tZ/aABv4+IsNlyymFk7Nsb4bLSZaYCii5N9Pdae9s642k9L6XmhCZExo8rSeeuK/o2U7
         uXdecNsbnNwl9mOBJhcgrbARAm6cOL6/TSxiRPKcKQ0A4wakbnmd2tYNyl/NIPwWXLxl
         PB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689725927; x=1692317927;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=89xDhKy5l7vxo2+qhhUkXKLJEl4EKrwY/Qi9H8xXUCI=;
        b=IdchERoJs1duICyXRqRnLFkDBWMpi4SIFaMFMWmCZQjOzU+vJNbte/ByDVx6aAAOYa
         ANYyMSgeHcr8CXDUG8k+lV8nPNz4uTGP2L8dkozQWms0DBigI7YY0UYRssLtlzgsCxG+
         /qzUfzE88YumxaPMdDgbYieio4TbW2CvVebJwbGja0DQAL6SbRTcKpG4BKmWQu1nfaMp
         x3TtbY0PnsBGzTr04YJ3dUSqtutRmXdlMgvDQJP3ogLlUFCpypkQA0z4PCmPXynSR+AM
         oTcy4/SFPjDttwK30/uvoypcnvdpqUSW78vXMU9Ok7bTdr7dq2Dy/OfWiZsCT+5W6vH2
         CMgQ==
X-Gm-Message-State: ABy/qLYAR6aWRg7ST6gxG6Eza06rlNuYb4b2non9d2r63GObPsAhFlk/
        hsPL2ZEn+UxYYUMxbgr55eaGLBVMUmo3
X-Google-Smtp-Source: APBJJlEZo5YGpbD1/T9izHzifiGUeb7YSYDppowvL6xFHVvRkp2RNkGHGeZXSc1tFNcU61fSVlU1AAMB1GK1
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:c587:348f:a079:d876])
 (user=irogers job=sendgmr) by 2002:a81:d447:0:b0:577:3b0c:5b85 with SMTP id
 g7-20020a81d447000000b005773b0c5b85mr19547ywl.0.1689725927086; Tue, 18 Jul
 2023 17:18:47 -0700 (PDT)
Date:   Tue, 18 Jul 2023 17:18:36 -0700
In-Reply-To: <20230719001836.198363-1-irogers@google.com>
Message-Id: <20230719001836.198363-4-irogers@google.com>
Mime-Version: 1.0
References: <20230719001836.198363-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Subject: [PATCH v1 3/3] perf parse-events: Only move force grouped evsels when sorting
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prior to this change, events without a group would be sorted as if
they were from the location of the first event without a group. For
example instructions and cycles are without a group:

instructions,{imc_free_running/data_read/,imc_free_running/data_write/},cycles

parse events would create an eventual evlist like:

instructions,cycles,{uncore_imc_free_running_0/data_read/,uncore_imc_free_running_1/data_read/,uncore_imc_free_running_0/data_write/,uncore_imc_free_running_1/data_write/}

This is done so that perf metric events, that must always be in a
group, will be adjacent and so can be forced into a group.

This change modifies the sorting so that only force grouped events,
like perf metrics, are sorted and all other events keep their position
with respect to groups in the evlist. The location of the force
grouped event is chosen to match the first force grouped event.

For architectures without force grouped events, ie anything not Intel
Icelake or newer, this should mean sorting and fixing doesn't modify
the event positions except when fixing the grouping for PMUs of things
like uncore events.

Reported-by: Andi Kleen <ak@linux.intel.com>
Fixes: 347c2f0a0988 ("perf parse-events: Sort and group parsed events")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 39 ++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 4a36ce60c7dd..e63fc40efea5 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2092,16 +2092,16 @@ __weak int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs)
 	return lhs->core.idx - rhs->core.idx;
 }
 
-static int evlist__cmp(void *state, const struct list_head *l, const struct list_head *r)
+static int evlist__cmp(void *_fg_idx, const struct list_head *l, const struct list_head *r)
 {
 	const struct perf_evsel *lhs_core = container_of(l, struct perf_evsel, node);
 	const struct evsel *lhs = container_of(lhs_core, struct evsel, core);
 	const struct perf_evsel *rhs_core = container_of(r, struct perf_evsel, node);
 	const struct evsel *rhs = container_of(rhs_core, struct evsel, core);
-	int *leader_idx = state;
-	int lhs_leader_idx = *leader_idx, rhs_leader_idx = *leader_idx, ret;
+	int *force_grouped_idx = _fg_idx;
+	int lhs_sort_idx, rhs_sort_idx, ret;
 	const char *lhs_pmu_name, *rhs_pmu_name;
-	bool lhs_has_group = false, rhs_has_group = false;
+	bool lhs_has_group, rhs_has_group;
 
 	/*
 	 * First sort by grouping/leader. Read the leader idx only if the evsel
@@ -2113,15 +2113,25 @@ static int evlist__cmp(void *state, const struct list_head *l, const struct list
 	 */
 	if (lhs_core->leader != lhs_core || lhs_core->nr_members > 1) {
 		lhs_has_group = true;
-		lhs_leader_idx = lhs_core->leader->idx;
+		lhs_sort_idx = lhs_core->leader->idx;
+	} else {
+		lhs_has_group = false;
+		lhs_sort_idx = *force_grouped_idx != -1 && arch_evsel__must_be_in_group(lhs)
+			? *force_grouped_idx
+			: lhs_core->idx;
 	}
 	if (rhs_core->leader != rhs_core || rhs_core->nr_members > 1) {
 		rhs_has_group = true;
-		rhs_leader_idx = rhs_core->leader->idx;
+		rhs_sort_idx = rhs_core->leader->idx;
+	} else {
+		rhs_has_group = false;
+		rhs_sort_idx = *force_grouped_idx != -1 && arch_evsel__must_be_in_group(rhs)
+			? *force_grouped_idx
+			: rhs_core->idx;
 	}
 
-	if (lhs_leader_idx != rhs_leader_idx)
-		return lhs_leader_idx - rhs_leader_idx;
+	if (lhs_sort_idx != rhs_sort_idx)
+		return lhs_sort_idx - rhs_sort_idx;
 
 	/* Group by PMU if there is a group. Groups can't span PMUs. */
 	if (lhs_has_group && rhs_has_group) {
@@ -2138,7 +2148,7 @@ static int evlist__cmp(void *state, const struct list_head *l, const struct list
 
 static int parse_events__sort_events_and_fix_groups(struct list_head *list)
 {
-	int idx = 0, unsorted_idx = -1;
+	int idx = 0, force_grouped_idx = -1;
 	struct evsel *pos, *cur_leader = NULL;
 	struct perf_evsel *cur_leaders_grp = NULL;
 	bool idx_changed = false, cur_leader_force_grouped = false;
@@ -2166,12 +2176,14 @@ static int parse_events__sort_events_and_fix_groups(struct list_head *list)
 		 */
 		pos->core.idx = idx++;
 
-		if (unsorted_idx == -1 && pos == pos_leader && pos->core.nr_members < 2)
-			unsorted_idx = pos->core.idx;
+		/* Remember an index to sort all forced grouped events together to. */
+		if (force_grouped_idx == -1 && pos == pos_leader && pos->core.nr_members < 2 &&
+		    arch_evsel__must_be_in_group(pos))
+			force_grouped_idx = pos->core.idx;
 	}
 
 	/* Sort events. */
-	list_sort(&unsorted_idx, list, evlist__cmp);
+	list_sort(&force_grouped_idx, list, evlist__cmp);
 
 	/*
 	 * Recompute groups, splitting for PMUs and adding groups for events
@@ -2182,7 +2194,8 @@ static int parse_events__sort_events_and_fix_groups(struct list_head *list)
 		const struct evsel *pos_leader = evsel__leader(pos);
 		const char *pos_pmu_name = pos->group_pmu_name;
 		const char *cur_leader_pmu_name;
-		bool pos_force_grouped = arch_evsel__must_be_in_group(pos);
+		bool pos_force_grouped = force_grouped_idx != -1 &&
+			arch_evsel__must_be_in_group(pos);
 
 		/* Reset index and nr_members. */
 		if (pos->core.idx != idx)
-- 
2.41.0.487.g6d72f3e995-goog

