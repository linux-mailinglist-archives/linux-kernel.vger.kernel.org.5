Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C18B80FAEC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 00:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235266AbjLLXCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 18:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377895AbjLLXCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 18:02:38 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23145B2;
        Tue, 12 Dec 2023 15:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702422164; x=1733958164;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iu38UN4mzyt8FPw4e1GPzXUYjNeQwCPMA4Vfk8L0sHQ=;
  b=Odt6MTcDSHY4mfRYm0w3noCfK+SVWCb8PzCy9605doIk2p9fZBZz5JDI
   aZS+NxpZRwV4kwdoyNKh4WKOeySVX7wBJVGELIrrn15q+5C4gQTGv70GX
   SEOPMr6l5srBBCBFEvrNKGjcIRbwlVAYTdJ0rHvlvdYQLngfrDmUlS8yO
   URcpq6gumtJEC0V8n4aoCT5RCVJPg3xvsoNjY/a3+OehPMLmyJod7DzOA
   ZQk2B5Re10H/v95k9vbFoIB6vCVKuUAbamv7QM1qL+rbChdAwWnm5SBjl
   19SF96vWzUkjyWh3Plbnu8cFOq7+FizZ+nCSQCk0KV6LCSE08sAmBb3Sn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="392055890"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="392055890"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 15:02:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="864391958"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="864391958"
Received: from node-10329.jf.intel.com ([10.54.34.22])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Dec 2023 15:02:42 -0800
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
Subject: [RFC PATCH v3 02/18] perf stat: Add basic functions for the hardware-grouping stat cmd option
Date:   Tue, 12 Dec 2023 15:02:08 -0800
Message-Id: <20231212230224.1473300-4-weilin.wang@intel.com>
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

Add the first set of functions for the hardware-grouping method. Function
hw_awre_parse_groups() is the entry point of this metric grouping method.
It does metric grouping on a combined list of events and will create a list
of grouping strings as final results of the grouping method. These grouping
strings will be used in the same mannor as existing metric grouping
process.

This method will fall back to normal grouping when hardware aware grouping
return with err so that perf stat still executes and returns with correct
result.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/util/metricgroup.c | 210 +++++++++++++++++++++++++++++++++-
 tools/perf/util/metricgroup.h |   9 ++
 2 files changed, 218 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index dfbcdb517b78..8d1143ee898c 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1432,6 +1432,101 @@ static int build_combined_expr_ctx(const struct list_head *metric_list,
 	return ret;
 }
 
+/**
+ * hw_aware_build_grouping - Build event groupings by reading counter
+ * requirement of the events and counter available on the system from
+ * pmu-events.
+ * @ctx: the event identifiers parsed from metrics.
+ * @groupings: header to the list of final event grouping.
+ * @modifier: any modifiers added to the events.
+ */
+static int hw_aware_build_grouping(struct expr_parse_ctx *ctx __maybe_unused,
+				  struct list_head *groupings __maybe_unused,
+				  const char *modifier __maybe_unused)
+{
+	int ret = 0;
+
+	pr_debug("This is a placeholder\n");
+	return ret;
+}
+
+static void group_str_free(struct metricgroup__group_strs *g)
+{
+	if (!g)
+		return;
+
+	strbuf_release(&g->grouping_str);
+	free(g);
+}
+
+static void metricgroup__free_grouping_strs(struct list_head
+					   *grouping_strs)
+{
+	struct metricgroup__group_strs *g, *tmp;
+
+	list_for_each_entry_safe(g, tmp, grouping_strs, nd) {
+		list_del_init(&g->nd);
+		group_str_free(g);
+	}
+}
+
+/**
+ * hw_aware_parse_ids - Build the event string for the ids and parse them
+ * creating an evlist. The encoded metric_ids are decoded. Events are placed
+ * into groups based on event counter requirements and counter availabilities of
+ * the system.
+ * @metric_no_merge: is metric sharing explicitly disabled.
+ * @fake_pmu: used when testing metrics not supported by the current CPU.
+ * @ids: the event identifiers parsed from a metric.
+ * @modifier: any modifiers added to the events.
+ * @out_evlist: the created list of events.
+ */
+static int hw_aware_parse_ids(struct perf_pmu *fake_pmu,
+			     struct expr_parse_ctx *ids, const char *modifier,
+			     struct evlist **out_evlist)
+{
+	struct parse_events_error parse_error;
+	struct evlist *parsed_evlist;
+	LIST_HEAD(groupings);
+	struct metricgroup__group_strs *group;
+	int ret;
+
+	*out_evlist = NULL;
+	ret = hw_aware_build_grouping(ids, &groupings, modifier);
+	if (ret) {
+		metricgroup__free_grouping_strs(&groupings);
+		return ret;
+	}
+
+	parsed_evlist = evlist__new();
+	if (!parsed_evlist) {
+		ret = -ENOMEM;
+		goto err_out;
+	}
+	list_for_each_entry(group, &groupings, nd) {
+		struct strbuf *events = &group->grouping_str;
+
+		pr_debug("Parsing metric events '%s'\n", events->buf);
+		parse_events_error__init(&parse_error);
+		ret = __parse_events(parsed_evlist, events->buf, /*pmu_filter=*/NULL,
+				    &parse_error, fake_pmu, /*warn_if_reordered=*/false);
+		if (ret) {
+			parse_events_error__print(&parse_error, events->buf);
+			goto err_out;
+		}
+		ret = decode_all_metric_ids(parsed_evlist, modifier);
+		if (ret)
+			goto err_out;
+	}
+	*out_evlist = parsed_evlist;
+	parsed_evlist = NULL;
+err_out:
+	parse_events_error__exit(&parse_error);
+	evlist__delete(parsed_evlist);
+	metricgroup__free_grouping_strs(&groupings);
+	return ret;
+}
+
 /**
  * parse_ids - Build the event string for the ids and parse them creating an
  *             evlist. The encoded metric_ids are decoded.
@@ -1520,6 +1615,114 @@ static int parse_ids(bool metric_no_merge, struct perf_pmu *fake_pmu,
 	return ret;
 }
 
+static int hw_aware_parse_groups(struct evlist *perf_evlist,
+				const char *pmu, const char *str,
+				bool metric_no_threshold,
+				const char *user_requested_cpu_list,
+				bool system_wide,
+				struct perf_pmu *fake_pmu,
+				struct rblist *metric_events_list,
+				const struct pmu_metrics_table *table)
+{
+	struct evlist *combined_evlist = NULL;
+	LIST_HEAD(metric_list);
+	struct metric *m;
+	int ret;
+	bool metric_no_group = false;
+	bool metric_no_merge = false;
+
+	if (metric_events_list->nr_entries == 0)
+		metricgroup__rblist_init(metric_events_list);
+	ret = metricgroup__add_metric_list(pmu, str, metric_no_group, metric_no_threshold,
+					   user_requested_cpu_list,
+					   system_wide, &metric_list, table);
+	if (ret)
+		goto out;
+
+	/* Sort metrics from largest to smallest. */
+	list_sort(NULL, &metric_list, metric_list_cmp);
+
+	if (!metric_no_merge) {
+		struct expr_parse_ctx *combined = NULL;
+
+		ret = build_combined_expr_ctx(&metric_list, &combined);
+
+		if (!ret && combined && hashmap__size(combined->ids)) {
+			ret = hw_aware_parse_ids(fake_pmu, combined,
+						/*modifier=*/NULL,
+						&combined_evlist);
+		}
+
+		if (ret)
+			goto out;
+
+		if (combined)
+			expr__ctx_free(combined);
+	}
+
+	list_for_each_entry(m, &metric_list, nd) {
+		struct metric_expr *expr;
+		struct metric_event *me;
+		struct evsel **metric_events;
+
+		ret = setup_metric_events(fake_pmu ? "all" : m->pmu, m->pctx->ids,
+					 combined_evlist, &metric_events);
+		if (ret) {
+			pr_debug("Cannot resolve IDs for %s: %s\n",
+				m->metric_name, m->metric_expr);
+			goto out;
+		}
+
+		me = metricgroup__lookup(metric_events_list, metric_events[0], true);
+
+		expr = malloc(sizeof(struct metric_expr));
+		if (!expr) {
+			ret = -ENOMEM;
+			free(metric_events);
+			goto out;
+		}
+
+		expr->metric_refs = m->metric_refs;
+		m->metric_refs = NULL;
+		expr->metric_expr = m->metric_expr;
+		if (m->modifier) {
+			char *tmp;
+
+			if (asprintf(&tmp, "%s:%s", m->metric_name, m->modifier) < 0)
+				expr->metric_name = NULL;
+			else
+				expr->metric_name = tmp;
+		} else {
+			expr->metric_name = strdup(m->metric_name);
+		}
+
+		if (!expr->metric_name) {
+			ret = -ENOMEM;
+			free(metric_events);
+			goto out;
+		}
+		expr->metric_threshold = m->metric_threshold;
+		expr->metric_unit = m->metric_unit;
+		expr->metric_events = metric_events;
+		expr->runtime = m->pctx->sctx.runtime;
+		list_add(&expr->nd, &me->head);
+	}
+
+	if (combined_evlist) {
+		evlist__splice_list_tail(perf_evlist, &combined_evlist->core.entries);
+		evlist__delete(combined_evlist);
+	}
+
+	list_for_each_entry(m, &metric_list, nd) {
+		if (m->evlist)
+			evlist__splice_list_tail(perf_evlist, &m->evlist->core.entries);
+	}
+
+out:
+	metricgroup__free_metrics(&metric_list);
+	return ret;
+}
+
 static int parse_groups(struct evlist *perf_evlist,
 			const char *pmu, const char *str,
 			bool metric_no_group,
@@ -1698,10 +1901,15 @@ int metricgroup__parse_groups(struct evlist *perf_evlist,
 	if (!table)
 		return -EINVAL;
 	if (hardware_aware_grouping) {
+		int ret;
 		pr_debug("Use hardware aware grouping instead of traditional metric grouping method\n");
+		ret = hw_aware_parse_groups(perf_evlist, pmu, str,
+			    metric_no_threshold, user_requested_cpu_list, system_wide,
+			    /*fake_pmu=*/NULL, metric_events, table);
+		if (!ret)
+			return 0;
 	}
 
-
 	return parse_groups(perf_evlist, pmu, str, metric_no_group, metric_no_merge,
 			    metric_no_threshold, user_requested_cpu_list, system_wide,
 			    /*fake_pmu=*/NULL, metric_events, table);
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index 779f6ede1b51..89809df85644 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -6,6 +6,7 @@
 #include <linux/rbtree.h>
 #include <stdbool.h>
 #include "pmu-events/pmu-events.h"
+#include "strbuf.h"
 
 struct evlist;
 struct evsel;
@@ -66,6 +67,14 @@ struct metric_expr {
 	int runtime;
 };
 
+/**
+ * Each group is one node in the group string list.
+ */
+struct metricgroup__group_strs {
+	struct list_head nd;
+	struct strbuf grouping_str;
+};
+
 struct metric_event *metricgroup__lookup(struct rblist *metric_events,
 					 struct evsel *evsel,
 					 bool create);
-- 
2.39.3

