Return-Path: <linux-kernel+bounces-58969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05EB284EF4C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 04:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B12E8284DFF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 03:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3FEDDC3;
	Fri,  9 Feb 2024 03:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b0P4bLkC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495A64C92;
	Fri,  9 Feb 2024 03:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707448492; cv=none; b=mwDqDLchTHinZDaWv7Pq04b5FGXuefc4dqUI4+ywNBaMJPlsp6me7iAyVCwji3SpWd+tpVMGM0su1c+7K+Fj48q+pHQxzOd6CyQcktqPDqylHcpibdasFyD8e5G6E7bLD6l7Umdkjr6xgHjCcs/pgIkPMTN4C/wHao2l3ytAUhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707448492; c=relaxed/simple;
	bh=YkcdAzNWIFPX0/ELSP1ZgYTdwPdrUl8xdN68jdAHQys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dSCbA+XPy4pR2xf9vISr1tElG5r9PfAqiGbJNZp7usoj+hKskXbqlfQdO2xjr2pDb4EYOXafcU+Lr/bKXlorURm3tWITyoI9Ak0xbwNJx+6vuKo62bUnP07ykTIOpPjkILVUvW9tzgKT1NTtuo0fRdAyTZ/yiW7ChrWUt10ydg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b0P4bLkC; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707448491; x=1738984491;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YkcdAzNWIFPX0/ELSP1ZgYTdwPdrUl8xdN68jdAHQys=;
  b=b0P4bLkCijz+Xq4gOXhXDcvDJI2hbTEoBUYwpxT0ErIGpErFUbMGv0ot
   4DNAvZpGM7JZFja8qyYA9/5dG0IctDexUduDVQb7zVhIRNE9bSI4P7xxH
   cjfwfesrj1eb+KsSwC0bVgVaXHdRROE9zY97mrI9CgbX8u+cKmZGN8OIQ
   yu/uPI2t3eTxcgqV6bXyChBRM1RQ4u6QGSHgRQlzNnOmKhM+zwUvMfxAO
   cWtW8HhTBmX/KpMU7f9r2IU7TWi9Ho2i3XyhuSRHuXhJnYyZAaySLVCOY
   rGmF1SpgNM6X3TbSA5ySfEDyqSpNBlhAdYNI9652BkeRABkv68ITbEVqv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1257881"
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="1257881"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 19:14:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="32631409"
Received: from b49691a74b80.jf.intel.com ([10.165.54.183])
  by orviesa002.jf.intel.com with ESMTP; 08 Feb 2024 19:14:47 -0800
From: weilin.wang@intel.com
To: weilin.wang@intel.com,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [RFC PATCH v4 02/15] perf stat: Add basic functions for the hardware aware grouping
Date: Thu,  8 Feb 2024 19:14:28 -0800
Message-ID: <20240209031441.943012-3-weilin.wang@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240209031441.943012-1-weilin.wang@intel.com>
References: <20240209031441.943012-1-weilin.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weilin Wang <weilin.wang@intel.com>

Add the first set of functions for the hardware aware grouping method. Function
hw_aware_parse_groups() is the entry point of this metric grouping method.  It
does metric grouping on a combined list of events and will create a list of
grouping strings as final results of the grouping method. These grouping strings
will be used in the same manner as existing metric grouping process.

This method will fall back to normal grouping when hardware aware grouping
return with err so that perf stat still executes and returns with correct
result.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/util/metricgroup.c | 218 +++++++++++++++++++++++++++++++++-
 1 file changed, 217 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 18df1af4bdd3..ee638578afdd 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -157,6 +157,14 @@ struct metric {
 	struct evlist *evlist;
 };
 
+/**
+ * Each group is one node in the group string list.
+ */
+struct metricgroup__group_strs {
+	struct list_head nd;
+	struct strbuf grouping_str;
+};
+
 static void metric__watchdog_constraint_hint(const char *name, bool foot)
 {
 	static bool violate_nmi_constraint;
@@ -1432,6 +1440,101 @@ static int build_combined_expr_ctx(const struct list_head *metric_list,
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
@@ -1520,6 +1623,114 @@ static int parse_ids(bool metric_no_merge, struct perf_pmu *fake_pmu,
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
@@ -1698,10 +1909,15 @@ int metricgroup__parse_groups(struct evlist *perf_evlist,
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
-- 
2.42.0


