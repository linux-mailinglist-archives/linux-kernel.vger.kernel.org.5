Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFFB07ACFF7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 08:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbjIYGTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 02:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbjIYGTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 02:19:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C15C6;
        Sun, 24 Sep 2023 23:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695622775; x=1727158775;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ecghSVgOnRb/io0CAxu9t2Iy1WVDvqy9G8dVCxNXugg=;
  b=PTfn/y6nh5cXVsYlUKCb7Juoe8McC9csRZr32Fitd6AA2OyTleB2ZbtM
   PCvQnuAEdHAW0dIPeydnw7p73i4ioZMzNyL+bCsAvbkuh9ErDKGZlxepy
   qgqAuYfj8i1sQJXMkZufNEstbI3UBkRMmyjl0eTIhn9y5Sr9h1DSK5/hY
   G71pXbDzktOm5gV5jEJjRu2wawXmhsrOb53BPZZPCq9im07mopnksYW1X
   QOAArIBWtJQZeRb2cm6BtnlWMDhGSJ+z9w184Qf64A/EDAVPD42yQVIOI
   A8tpj8K+cJc6lBFynMnqt8B84l+rICULKbTtVxLFE78Q79xKqX+qFtCSg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="445279437"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="445279437"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2023 23:19:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="818494350"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="818494350"
Received: from b49691a75598.jf.intel.com ([10.54.34.22])
  by fmsmga004.fm.intel.com with ESMTP; 24 Sep 2023 23:19:15 -0700
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
Subject: [RFC PATCH 08/25] perf stat: Add functions to get counter info
Date:   Sun, 24 Sep 2023 23:18:07 -0700
Message-Id: <20230925061824.3818631-9-weilin.wang@intel.com>
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

Add data structure metricgroup__pmu_counters to represent hardware counters
available in the system.

Add functions to parse pmu-events and create the list of pmu_info_list to
hold the counter information of the system.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/util/metricgroup.c | 59 +++++++++++++++++++++++++++++++++--
 tools/perf/util/metricgroup.h | 15 +++++++++
 tools/perf/util/pmu.c         |  5 +++
 tools/perf/util/pmu.h         |  1 +
 4 files changed, 78 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 7f2c1b017..feb5dab26 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1598,8 +1598,8 @@ static int get_metricgroup_events(const char *full_id,
 			.event_name = id,
 			.event_id = full_id,
 		};
-		ret = pmu_events_table_for_each_event(table,
-				metricgroup__add_metric_event_callback, &data);
+		ret = pmu_events_table__for_each_event(table, /*pmu=*/NULL,
+						      metricgroup__add_metric_event_callback, &data);
 		if (ret)
 			goto out;
 	}
@@ -1609,6 +1609,56 @@ static int get_metricgroup_events(const char *full_id,
 	return ret;
 }
 
+static struct metricgroup__pmu_counters *pmu_layout__new(const struct pmu_layout *pl)
+{
+	struct metricgroup__pmu_counters *l;
+	l = zalloc(sizeof(*l));
+
+	if (!l)
+		return NULL;
+
+	l->name = pl->pmu;
+	l->size = pl->size;
+	l->fixed_size = pl->fixed_size;
+	pr_debug("create new pmu_layout: [pmu]=%s, [gp_size]=%ld, [fixed_size]=%ld\n",
+		l->name, l->size, l->fixed_size);
+	return l;
+}
+
+static int metricgroup__add_pmu_layout_callback(const struct pmu_layout *pl,
+						void *data)
+{
+	struct metricgroup__pmu_counters *pmu;
+	struct list_head *d = data;
+	int ret = 0;
+
+	pmu = pmu_layout__new(pl);
+	if (!pmu)
+		return -ENOMEM;
+	list_add(&pmu->nd, d);
+	return ret;
+}
+
+/**
+ * get_pmu_counter_layouts - Find counter info of the architecture from
+ * the pmu_layouts table
+ * @pmu_info_list: the list that the new counter info of a pmu is added to.
+ * @table: pmu_layouts table that is searched for counter info.
+ */
+static int get_pmu_counter_layouts(struct list_head *pmu_info_list,
+				   const struct pmu_layouts_table
+				   *table)
+{
+	LIST_HEAD(list);
+	int ret;
+
+	ret = pmu_layouts_table__for_each_layout(table,
+						metricgroup__add_pmu_layout_callback, &list);
+
+	list_splice(&list, pmu_info_list);
+	return ret;
+}
+
 /**
  * hw_aware_build_grouping - Build event groupings by reading counter
  * requirement of the events and counter available on the system from
@@ -1627,6 +1677,7 @@ static int hw_aware_build_grouping(struct expr_parse_ctx *ctx __maybe_unused,
 	LIST_HEAD(event_info_list);
 	size_t bkt;
 	const struct pmu_events_table *etable = pmu_events_table__find();
+	const struct pmu_layouts_table *ltable = pmu_layouts_table__find();
 
 #define RETURN_IF_NON_ZERO(x) do { if (x) return x; } while (0)
 	hashmap__for_each_entry(ctx->ids, cur, bkt) {
@@ -1638,6 +1689,10 @@ static int hw_aware_build_grouping(struct expr_parse_ctx *ctx __maybe_unused,
 		if (ret)
 			return ret;
 	}
+	ret = get_pmu_counter_layouts(&pmu_info_list, ltable);
+	if (ret)
+		return ret;
+
 
 	return ret;
 #undef RETURN_IF_NON_ZERO
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index e493f6965..8ee7b434e 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -85,6 +85,21 @@ struct metricgroup__event_info {
 	DECLARE_BITMAP(counters, NR_COUNTERS);
 };
 
+/**
+ * A node is the counter availability of a pmu.
+ * This info is built up at the beginning from JSON file and
+ * used as a reference in metric grouping process.
+*/
+struct metricgroup__pmu_counters {
+	struct list_head nd;
+	/** The name of the pmu the event collected on. */
+	const char *name;
+	//DECLARE_BITMAP(counter_bits, NR_COUNTERS);
+	/** The number of gp counters in the pmu. */
+	size_t size;
+	size_t fixed_size;
+};
+
 /**
  * Each group is one node in the group string list.
  */
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index cde33e019..af4056a88 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -813,6 +813,11 @@ __weak const struct pmu_metrics_table *pmu_metrics_table__find(void)
 	return perf_pmu__find_metrics_table(NULL);
 }
 
+__weak const struct pmu_layouts_table *pmu_layouts_table__find(void)
+{
+	return perf_pmu__find_layouts_table(NULL);
+}
+
 /**
  * perf_pmu__match_ignoring_suffix - Does the pmu_name match tok ignoring any
  *                                   trailing suffix? The Suffix must be in form
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 6a4e170c6..3e9243e00 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -240,6 +240,7 @@ void pmu_add_cpu_aliases_table(struct perf_pmu *pmu,
 char *perf_pmu__getcpuid(struct perf_pmu *pmu);
 const struct pmu_events_table *pmu_events_table__find(void);
 const struct pmu_metrics_table *pmu_metrics_table__find(void);
+const struct pmu_layouts_table *pmu_layouts_table__find(void);
 
 int perf_pmu__convert_scale(const char *scale, char **end, double *sval);
 
-- 
2.39.3

