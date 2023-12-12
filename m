Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55F380FAFD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 00:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377973AbjLLXEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 18:04:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235322AbjLLXEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 18:04:23 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEE410FF;
        Tue, 12 Dec 2023 15:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702422243; x=1733958243;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NDQRlSFja+26nRaijwaZ1XVDslKm6YUyEUuwUoijWyc=;
  b=WuytAoLvti72TMsn8181fy/EL5Zq+OXhwlqvkfyFcdctLpIvNgD/o1aC
   m6f0v/8a0gIYHJDvV0OG8gyFLn327Mv9JSKktaMovbo+LN7szBJyiCeSp
   yDf88QxYwQBsLa97lYJ4QtQdlDc6xT82/Lw+t0QNPTsRkuWOpbZvNolI8
   +brr4os6wTATsPcEscr0pWbsTnaySehifj3kMylV9Hxq05eKOjX/9/vqJ
   1GMrSBUQIh4vhw9aUXOxjXzJZNCb1OLmJzp7PiY7m6PAILDCD2/ZblWEO
   +iH4+KFeeJnmFVNSujcAyxFiF4sN3pn4i83hnNlrn7w1DAg3GNTjXUjTk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="392056033"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="392056033"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 15:02:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="864392035"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="864392035"
Received: from node-10329.jf.intel.com ([10.54.34.22])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Dec 2023 15:02:57 -0800
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
        Mark Rutland <mark.rutland@arm.com>,
        Yang Jihong <yangjihong1@huawei.com>
Subject: [RFC PATCH v3 15/18] perf stat: Code refactoring in hardware-grouping
Date:   Tue, 12 Dec 2023 15:02:21 -0800
Message-Id: <20231212230224.1473300-17-weilin.wang@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231212230224.1473300-1-weilin.wang@intel.com>
References: <20231212230224.1473300-1-weilin.wang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weilin Wang <weilin.wang@intel.com>

Decouple the step to generate final grouping strings out from the
build_grouping step so that we could do single metric grouping and then
merge groups if needed later.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/util/metricgroup.c | 50 +++++++++++++++++------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 4df04d14d602..f0ef0c2ed860 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1801,9 +1801,10 @@ static int find_and_set_counters(struct metricgroup__event_info *e,
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
@@ -1922,7 +1923,8 @@ static int assign_event_grouping(struct metricgroup__event_info *e,
 
 	list_for_each_entry(g, groups, nd) {
 		if (!strcasecmp(g->pmu_name, e->pmu_name)) {
-			pr_debug("found group for event %s in pmu %s\n", e->name, g->pmu_name);
+			pr_debug("found group header for event %s in pmu %s\n",
+				e->name, g->pmu_name);
 			pmu_group_head = g;
 			break;
 		}
@@ -2051,26 +2053,22 @@ static int hw_aware_metricgroup__build_event_string(struct list_head *group_strs
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
 
-	//TODO: for each new core group, we should consider to add events that uses fixed counters
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
 
@@ -2091,9 +2089,8 @@ static bool is_special_event(const char *id)
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
@@ -2125,8 +2122,7 @@ static int hw_aware_build_grouping(struct expr_parse_ctx *ctx __maybe_unused,
 	ret = get_pmu_counter_layouts(&pmu_info_list, ltable);
 	if (ret)
 		goto err_out;
-	ret = create_grouping(&pmu_info_list, &event_info_list, groupings,
-			     modifier);
+	ret = create_grouping(&pmu_info_list, &event_info_list, grouping);
 
 err_out:
 	metricgroup__free_event_info(&event_info_list);
@@ -2172,23 +2168,25 @@ static int hw_aware_parse_ids(struct perf_pmu *fake_pmu,
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
+		goto out;
+	ret = hw_aware_metricgroup__build_event_string(&grouping_str, modifier, &grouping);
+	if (ret)
+		goto out;
 
 	parsed_evlist = evlist__new();
 	if (!parsed_evlist) {
 		ret = -ENOMEM;
 		goto err_out;
 	}
-	list_for_each_entry(group, &groupings, nd) {
+	list_for_each_entry(group, &grouping_str, nd) {
 		struct strbuf *events = &group->grouping_str;
 
 		pr_debug("Parsing metric events '%s'\n", events->buf);
@@ -2208,7 +2206,9 @@ static int hw_aware_parse_ids(struct perf_pmu *fake_pmu,
 err_out:
 	parse_events_error__exit(&parse_error);
 	evlist__delete(parsed_evlist);
-	metricgroup__free_grouping_strs(&groupings);
+out:
+	metricgroup__free_group_list(&grouping);
+	metricgroup__free_grouping_strs(&grouping_str);
 	return ret;
 }
 
-- 
2.39.3

