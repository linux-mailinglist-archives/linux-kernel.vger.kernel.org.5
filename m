Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71367AD00C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 08:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbjIYGVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 02:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbjIYGUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 02:20:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E29E120;
        Sun, 24 Sep 2023 23:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695622809; x=1727158809;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=efXWrTzJnuX21IoXyjVBzf+uIVRK9N90p2tyWHMS/Os=;
  b=eJ0Gylxg0otU+RQzpzaa+7fKdgvAqs2zhMpKXbjXqQaLSC6eCp0d7Ttr
   Ldo8wm7do9SWGzAe3xTslEgQo/y14vtzx7CchKylYAmmLEiFqtT4KtIhj
   Z4lBGT0F5mqCGDICv6Wn0OjKTeGBp3uSgejCgs/09q/aPdJPWLFba0fpr
   UbqJGx9xAu2ILj9bVek4gluZ5rq3GMnvp4fa8OchyZP2KrVB4n8yrltSJ
   MzVrhkgBRMn10tvZMaaRISEhZ9VBgA9Hao+/dklVptePunPw9U78lYa1c
   QlLJueX3Mw22pLhzcWWDpB8lZQ7xmlf0R5O1dAak3Ip+Q5r3IXMcAsz8E
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="445279545"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="445279545"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2023 23:19:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="818494414"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="818494414"
Received: from b49691a75598.jf.intel.com ([10.54.34.22])
  by fmsmga004.fm.intel.com with ESMTP; 24 Sep 2023 23:19:22 -0700
From:   weilin.wang@intel.com
To:     weilin.wang@intel.com, Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [RFC PATCH 20/25] perf stat: Code refactoring in hardware-grouping
Date:   Sun, 24 Sep 2023 23:18:19 -0700
Message-Id: <20230925061824.3818631-21-weilin.wang@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230925061824.3818631-1-weilin.wang@intel.com>
References: <20230925061824.3818631-1-weilin.wang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weilin Wang <weilin.wang@intel.com>

Decouple the step to generate final grouping strings out from the
build_grouping step so that we could do single metric grouping and then merge
groups if needed later.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/util/metricgroup.c | 49 +++++++++++++++++------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index c027c0351..3c569d838 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1799,9 +1799,10 @@ static int find_and_set_counters(struct metricgroup__event_info *e,
 {
 	int ret;
 	unsigned long find_bit = 0;
-
-	if (e->taken_alone && current_group->taken_alone)
+	if (e->taken_alone && current_group->taken_alone) {
+		pr_debug("current group with taken alone event already\n");
 		return -ENOSPC;
+	}
 	if (e->free_counter)
 		return 0;
 	if (e->fixed_counter) {
@@ -1919,7 +1920,8 @@ static int assign_event_grouping(struct metricgroup__event_info *e,
 
 	list_for_each_entry(g, groups, nd) {
 		if (!strcasecmp(g->pmu_name, e->pmu_name)) {
-			pr_debug("found group for event %s in pmu %s\n", e->name, g->pmu_name);
+			pr_debug("found group header for event %s in pmu %s\n",
+				e->name, g->pmu_name);
 			pmu_group_head = g;
 			break;
 		}
@@ -2046,26 +2048,22 @@ static int hw_aware_metricgroup__build_event_string(struct list_head *group_strs
  */
 static int create_grouping(struct list_head *pmu_info_list,
 			  struct list_head *event_info_list,
-			  struct list_head *groupings,
-			  const char *modifier)
+			  struct list_head *grouping)
 {
 	int ret = 0;
 	struct metricgroup__event_info *e;
-	LIST_HEAD(groups);
 	char *bit_buf = malloc(NR_COUNTERS);
 
-	//TODO: for each new core group, we could consider to add events that uses fixed counters
+	//TODO: for each new core group, we could consider to add events that
+	//uses fixed counters
 	list_for_each_entry(e, event_info_list, nd) {
 		bitmap_scnprintf(e->counters, NR_COUNTERS, bit_buf, NR_COUNTERS);
 		pr_debug("Event name %s, [pmu]=%s, [counters]=%s, [taken_alone]=%d\n",
 			e->name, e->pmu_name, bit_buf, e->taken_alone);
-		ret = assign_event_grouping(e, pmu_info_list, &groups);
+		ret = assign_event_grouping(e, pmu_info_list, grouping);
 		if (ret)
-			goto out;
+			return ret;
 	}
-	ret = hw_aware_metricgroup__build_event_string(groupings, modifier, &groups);
-out:
-	metricgroup__free_group_list(&groups);
 	return ret;
 };
 
@@ -2077,9 +2075,8 @@ static int create_grouping(struct list_head *pmu_info_list,
  * @groupings: header to the list of final event grouping.
  * @modifier: any modifiers added to the events.
  */
-static int hw_aware_build_grouping(struct expr_parse_ctx *ctx __maybe_unused,
-				  struct list_head *groupings __maybe_unused,
-				  const char *modifier __maybe_unused)
+static int hw_aware_build_grouping(struct expr_parse_ctx *ctx,
+				   struct list_head *grouping)
 {
 	int ret = 0;
 	struct hashmap_entry *cur;
@@ -2112,8 +2109,7 @@ static int hw_aware_build_grouping(struct expr_parse_ctx *ctx __maybe_unused,
 	ret = get_pmu_counter_layouts(&pmu_info_list, ltable);
 	if (ret)
 		goto err_out;
-	ret = create_grouping(&pmu_info_list, &event_info_list, groupings,
-			     modifier);
+	ret = create_grouping(&pmu_info_list, &event_info_list, grouping);
 
 err_out:
 	metricgroup__free_event_info(&event_info_list);
@@ -2159,23 +2155,25 @@ static int hw_aware_parse_ids(struct perf_pmu *fake_pmu,
 {
 	struct parse_events_error parse_error;
 	struct evlist *parsed_evlist;
-	LIST_HEAD(groupings);
+	LIST_HEAD(grouping_str);
+	LIST_HEAD(grouping);
 	struct metricgroup__group_strs *group;
 	int ret;
 
 	*out_evlist = NULL;
-	ret = hw_aware_build_grouping(ids, &groupings, modifier);
-	if (ret) {
-		metricgroup__free_grouping_strs(&groupings);
-		return ret;
-	}
+	ret = hw_aware_build_grouping(ids, &grouping);
+	if (ret)
+		goto err_out;
+	ret = hw_aware_metricgroup__build_event_string(&grouping_str, modifier, &grouping);
+	if (ret)
+		goto err_out;
 
 	parsed_evlist = evlist__new();
 	if (!parsed_evlist) {
 		ret = -ENOMEM;
 		goto err_out;
 	}
-	list_for_each_entry(group, &groupings, nd) {
+	list_for_each_entry(group, &grouping_str, nd) {
 		struct strbuf *events = &group->grouping_str;
 
 		pr_debug("Parsing metric events '%s'\n", events->buf);
@@ -2193,9 +2191,10 @@ static int hw_aware_parse_ids(struct perf_pmu *fake_pmu,
 	*out_evlist = parsed_evlist;
 	parsed_evlist = NULL;
 err_out:
+	metricgroup__free_group_list(&grouping);
+	metricgroup__free_grouping_strs(&grouping_str);
 	parse_events_error__exit(&parse_error);
 	evlist__delete(parsed_evlist);
-	metricgroup__free_grouping_strs(&groupings);
 	return ret;
 }
 
-- 
2.39.3

