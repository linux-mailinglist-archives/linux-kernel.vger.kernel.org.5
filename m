Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D532280FAFE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 00:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377989AbjLLXE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 18:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235334AbjLLXEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 18:04:23 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580E71704;
        Tue, 12 Dec 2023 15:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702422245; x=1733958245;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fETq5AdND9wjaev3rV22iysiP7uaRlJ1rv6ZEULKZsQ=;
  b=LHYb8kfOcdodBJDIqI8gXkYUjmfr2XS6vN9+N5W6DWAqmp10wKiI4I86
   9q6NXhu8FvRe/XBUmLsVbWGrmPCXqJvm7KagE7bsVJ8TijNJxgpI8eiQh
   KV+0/l5mx1fgj/hq1YLiqC7VxgPPIXhSB4GtRXhUF3ZJfOlkLiFEm4A9k
   OvV9XiXJVpzAZiRyVI6bsZ5JvbawMxDnxMxDeRe2vaJRwrZRgBMnLuUoa
   PjrTc7ba265YTMr43ogCoYhwgTKKfyfA21oBuiN0W84tHHEs0TyL6+sl9
   Pep2DMFNsFvJJClqvQRMTQCz+F0XwEJw/ktoQ1Y04UPWVc8RyBhdpCFpP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="392056040"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="392056040"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 15:02:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="864392039"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="864392039"
Received: from node-10329.jf.intel.com ([10.54.34.22])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Dec 2023 15:02:58 -0800
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
Subject: [RFC PATCH v3 16/18] perf stat: Add tool events support in hardware-grouping
Date:   Tue, 12 Dec 2023 15:02:22 -0800
Message-Id: <20231212230224.1473300-18-weilin.wang@intel.com>
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

Add tool events into default_core grouping strings if find tool events so
that metrics use tool events could be correctly calculated. Need this step
to support TopdownL4-L5.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/util/metricgroup.c | 49 ++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index f0ef0c2ed860..dc21a8255d82 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1391,6 +1391,35 @@ static void find_tool_events(const struct list_head *metric_list,
 	}
 }
 
+/**
+ * get_tool_event_str - Generate and return a string with all the used tool
+ * event names.
+ */
+static int get_tool_event_str(struct strbuf *events,
+			      const bool tool_events[PERF_TOOL_MAX],
+			      bool *has_tool_event)
+{
+	int i = 0;
+	int ret;
+
+	perf_tool_event__for_each_event(i) {
+		if (tool_events[i]) {
+			const char *tmp = strdup(perf_tool_event__to_str(i));
+
+			if (!tmp)
+				return -ENOMEM;
+			*has_tool_event = true;
+			ret = strbuf_addstr(events, ",");
+			if (ret)
+				return ret;
+			ret = strbuf_addstr(events, tmp);
+			if (ret)
+				return ret;
+		}
+	}
+	return 0;
+}
+
 /**
  * build_combined_expr_ctx - Make an expr_parse_ctx with all !group_events
  *                           metric IDs, as the IDs are held in a set,
@@ -1954,6 +1983,7 @@ static int assign_event_grouping(struct metricgroup__event_info *e,
 
 static int hw_aware_metricgroup__build_event_string(struct list_head *group_strs,
 					   const char *modifier,
+					   const bool tool_events[PERF_TOOL_MAX],
 					   struct list_head *groups)
 {
 	struct metricgroup__pmu_group_list *p;
@@ -1961,8 +1991,12 @@ static int hw_aware_metricgroup__build_event_string(struct list_head *group_strs
 	struct metricgroup__group_events *ge;
 	bool no_group = true;
 	int ret = 0;
+	struct strbuf tool_event_str = STRBUF_INIT;
+	bool has_tool_event = false;
 
 #define RETURN_IF_NON_ZERO(x) do { if (x) return x; } while (0)
+	ret = get_tool_event_str(&tool_event_str, tool_events, &has_tool_event);
+	RETURN_IF_NON_ZERO(ret);
 
 	list_for_each_entry(p, groups, nd) {
 		list_for_each_entry(g, &p->group_head, nd) {
@@ -2034,6 +2068,12 @@ static int hw_aware_metricgroup__build_event_string(struct list_head *group_strs
 			}
 			ret = strbuf_addf(events, "}:W");
 			RETURN_IF_NON_ZERO(ret);
+
+			if (!strcmp(p->pmu_name, "default_core") && has_tool_event) {
+				ret = strbuf_addstr(events, tool_event_str.buf);
+				RETURN_IF_NON_ZERO(ret);
+			}
+
 			pr_debug("events-buf: %s\n", events->buf);
 			list_add_tail(&new_group_str->nd, group_strs);
 		}
@@ -2119,6 +2159,7 @@ static int hw_aware_build_grouping(struct expr_parse_ctx *ctx,
 		if (ret)
 			goto err_out;
 	}
+
 	ret = get_pmu_counter_layouts(&pmu_info_list, ltable);
 	if (ret)
 		goto err_out;
@@ -2164,6 +2205,7 @@ static void metricgroup__free_grouping_strs(struct list_head
  */
 static int hw_aware_parse_ids(struct perf_pmu *fake_pmu,
 			     struct expr_parse_ctx *ids, const char *modifier,
+			     const bool tool_events[PERF_TOOL_MAX],
 			     struct evlist **out_evlist)
 {
 	struct parse_events_error parse_error;
@@ -2177,7 +2219,8 @@ static int hw_aware_parse_ids(struct perf_pmu *fake_pmu,
 	ret = hw_aware_build_grouping(ids, &grouping);
 	if (ret)
 		goto out;
-	ret = hw_aware_metricgroup__build_event_string(&grouping_str, modifier, &grouping);
+	ret = hw_aware_metricgroup__build_event_string(&grouping_str, modifier,
+						      tool_events, &grouping);
 	if (ret)
 		goto out;
 
@@ -2312,6 +2355,7 @@ static int hw_aware_parse_groups(struct evlist *perf_evlist,
 	struct evlist *combined_evlist = NULL;
 	LIST_HEAD(metric_list);
 	struct metric *m;
+	bool tool_events[PERF_TOOL_MAX] = {false};
 	int ret;
 	bool metric_no_group = false;
 	bool metric_no_merge = false;
@@ -2330,11 +2374,14 @@ static int hw_aware_parse_groups(struct evlist *perf_evlist,
 	if (!metric_no_merge) {
 		struct expr_parse_ctx *combined = NULL;
 
+		find_tool_events(&metric_list, tool_events);
+
 		ret = hw_aware_build_combined_expr_ctx(&metric_list, &combined);
 
 		if (!ret && combined && hashmap__size(combined->ids)) {
 			ret = hw_aware_parse_ids(fake_pmu, combined,
 						/*modifier=*/NULL,
+						tool_events,
 						&combined_evlist);
 		}
 
-- 
2.39.3

