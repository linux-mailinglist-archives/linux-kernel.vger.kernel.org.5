Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79FA87C922B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 03:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbjJNBwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 21:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232824AbjJNBwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 21:52:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597F0116;
        Fri, 13 Oct 2023 18:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697248355; x=1728784355;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hFwGUjeSEwV3M8jNdW1cuoi8OgD2wUFllwc1RJBRXBA=;
  b=Nyl1hKVwHx0eHUdm8dk8S/H9N4a50493wzh3PFN9TwMNF15bVx/tXSOz
   cp4LdGMVUqHCpxbCqy47A4ejtJoOBIHNUEnreLBq7yQ4EQpy/QVkKrJdQ
   nU4HrJ/gornpHA6K86T4umsVtrIjlDz91rPu8+l5bVVPG54YTo3mE1BVX
   CIKOmmrMbKjkF4s4WFi0xwUMhT5RH9WWJunJ2T5Dg+a7VNVKg+JAO/OZC
   yuJOtrS+V+TwKeYM3Z0HKcAOEpc0C9ihoFDbGT7t2JuzWcJl2Ww0EtDWB
   v4AdlqQlU8WFhOKeQ9QGgQhpMN4Hjy2mzS+B1rwi7e1EIBvDVIhTKpItO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="389154719"
X-IronPort-AV: E=Sophos;i="6.03,223,1694761200"; 
   d="scan'208";a="389154719"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 18:52:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="731565680"
X-IronPort-AV: E=Sophos;i="6.03,223,1694761200"; 
   d="scan'208";a="731565680"
Received: from b49691a75598.jf.intel.com ([10.54.34.22])
  by orsmga006.jf.intel.com with ESMTP; 13 Oct 2023 18:52:19 -0700
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
Subject: [RFC PATCH v2 08/17] perf stat: Add functions to get counter info
Date:   Fri, 13 Oct 2023 18:51:53 -0700
Message-Id: <20231014015202.1175377-9-weilin.wang@intel.com>
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

Add data structure metricgroup__pmu_counters to represent hardware counters
available in the system.

Add functions to parse pmu-events and create the list of pmu_info_list to
hold the counter information of the system.

Add functions to free pmu_info_list and event_info_list before exit
grouping for hardware-grouping method

This method would fall back to normal grouping when event json files do not
support hardware aware grouping.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/util/metricgroup.c | 85 +++++++++++++++++++++++++++++++++--
 tools/perf/util/metricgroup.h | 15 +++++++
 tools/perf/util/pmu.c         |  5 +++
 tools/perf/util/pmu.h         |  1 +
 4 files changed, 103 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 6af8a7341..75257b68b 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1507,6 +1507,27 @@ static int parse_counter(const char *counter,
 	return 0;
 }
 
+static void metricgroup__free_event_info(struct list_head
+					*event_info_list)
+{
+	struct metricgroup__event_info *e, *tmp;
+
+	list_for_each_entry_safe(e, tmp, event_info_list, nd) {
+		list_del_init(&e->nd);
+		free(e);
+	}
+}
+
+static void metricgroup__free_pmu_info(struct list_head *pmu_info_list)
+{
+	struct metricgroup__pmu_counters *p, *tmp;
+
+	list_for_each_entry_safe(p, tmp, pmu_info_list, nd) {
+		list_del_init(&p->nd);
+		free(p);
+	}
+}
+
 static struct metricgroup__event_info *event_info__new(const char *name,
 						      const char *pmu_name,
 						      const char *counter,
@@ -1525,7 +1546,7 @@ static struct metricgroup__event_info *event_info__new(const char *name,
 
 	e->name = name;
 	e->free_counter = free_counter;
-	e->pmu_name = strdup(pmu_name);
+	e->pmu_name = pmu_name;
 	if (free_counter) {
 		ret = set_counter_bitmap(0, e->counters);
 		if (ret)
@@ -1560,6 +1581,8 @@ static int metricgroup__add_metric_event_callback(const struct pmu_event *pe,
 	struct metricgroup__add_metric_event_data *d = data;
 
 	if (!strcasecmp(pe->name, d->event_name)) {
+		if (!pe->counter)
+			return -EINVAL;
 		event = event_info__new(d->event_id, pe->pmu, pe->counter, /*free_counter=*/false);
 		if (!event)
 			return -ENOMEM;
@@ -1599,7 +1622,7 @@ static int get_metricgroup_events(const char *full_id,
 			.event_name = id,
 			.event_id = full_id,
 		};
-		ret = pmu_events_table_for_each_event(table,
+		ret = pmu_events_table__for_each_event(table, /*pmu=*/NULL,
 				metricgroup__add_metric_event_callback, &data);
 	}
 
@@ -1608,6 +1631,57 @@ static int get_metricgroup_events(const char *full_id,
 	return ret;
 }
 
+static struct metricgroup__pmu_counters *pmu_layout__new(const struct pmu_layout *pl)
+{
+	struct metricgroup__pmu_counters *l;
+
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
@@ -1626,6 +1700,7 @@ static int hw_aware_build_grouping(struct expr_parse_ctx *ctx __maybe_unused,
 	LIST_HEAD(event_info_list);
 	size_t bkt;
 	const struct pmu_events_table *etable = pmu_events_table__find();
+	const struct pmu_layouts_table *ltable = pmu_layouts_table__find();
 
 #define RETURN_IF_NON_ZERO(x) do { if (x) return x; } while (0)
 	hashmap__for_each_entry(ctx->ids, cur, bkt) {
@@ -1635,9 +1710,13 @@ static int hw_aware_build_grouping(struct expr_parse_ctx *ctx __maybe_unused,
 
 		ret = get_metricgroup_events(id, etable, &event_info_list);
 		if (ret)
-			return ret;
+			goto err_out;
 	}
+	ret = get_pmu_counter_layouts(&pmu_info_list, ltable);
 
+err_out:
+	metricgroup__free_event_info(&event_info_list);
+	metricgroup__free_pmu_info(&pmu_info_list);
 	return ret;
 #undef RETURN_IF_NON_ZERO
 }
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index 3704545c9..802ca15e7 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -94,6 +94,21 @@ struct metricgroup__event_info {
 	DECLARE_BITMAP(counters, NR_COUNTERS);
 };
 
+/**
+ * A node is the counter availability of a pmu.
+ * This info is built up at the beginning from JSON file and
+ * used as a reference in metric grouping process.
+ */
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

