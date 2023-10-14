Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58E27C9239
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 03:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbjJNByW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 21:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbjJNBxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 21:53:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A744E3;
        Fri, 13 Oct 2023 18:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697248397; x=1728784397;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Dp5/KruilQ9oVO0UatjNLb9jKGIJP0G6bCTahKja4Zo=;
  b=fiorwB/O+3h7MO8QXxAvXkkI9r54HlKhlhhdEieT0I36lyKUUg2lAbPa
   ftR6wP3npHcUTIIKs5WSjCC4211Yrqynhsh3VAgbf/n4eYZOjTQxoC9Mr
   +6DVwMTjIl3FQ5+HBbJQg5QvMdpkJbfrpU9CMpC3YvJ68LaZqZG99rgKZ
   6u0YnPSVhy7hpgAbV0KhUg8OzL2kCrj3i4eCD/RamfF9e5W4iWWPRy/oB
   FYFUTzBT0Rp55Prd5u6NUBe+bZQkXR1c6j0B5MGSmKkN/6sL8qj/AcDYr
   YZiZIJ0fPvEkZzy2JQs4XBiAU2M0bj5vczUDzeabqOPKboGs9/VugrGmN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="389154774"
X-IronPort-AV: E=Sophos;i="6.03,223,1694761200"; 
   d="scan'208";a="389154774"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 18:52:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="731565703"
X-IronPort-AV: E=Sophos;i="6.03,223,1694761200"; 
   d="scan'208";a="731565703"
Received: from b49691a75598.jf.intel.com ([10.54.34.22])
  by orsmga006.jf.intel.com with ESMTP; 13 Oct 2023 18:52:20 -0700
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
Subject: [RFC PATCH v2 15/17] perf stat: Code refactoring in hardware-grouping
Date:   Fri, 13 Oct 2023 18:52:00 -0700
Message-Id: <20231014015202.1175377-16-weilin.wang@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231014015202.1175377-1-weilin.wang@intel.com>
References: <20231014015202.1175377-1-weilin.wang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
index 7da91cbd3..1222cff8d 100644
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

