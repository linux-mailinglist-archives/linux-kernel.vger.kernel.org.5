Return-Path: <linux-kernel+bounces-58972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A40E84EF4F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 04:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73A381F22781
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 03:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB2414A92;
	Fri,  9 Feb 2024 03:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WrddKb/4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6810E611E;
	Fri,  9 Feb 2024 03:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707448494; cv=none; b=UtAeKyECutJ/PpqFDGxWn7LRPhuVJ6fPJvN08UEEfqYYpFRPEwkXQNkRe+qbioYzmkqAdlt5wEtylPTgO6IszVU4gx64Q++v03VnEcmm/HX/33fckmDpfO8hEYQQy5bGctGPc9q1C8lKxHnOqGIMADavfd8xW/6ZO8MEF86sOCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707448494; c=relaxed/simple;
	bh=Ptn1JpRP3StyuOfIWKSzj6sKJoeJjAtlLJUNbm0+pS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sVe/Sbr5XQjX4IrJSmot5k/NJw1EH3JT3uPagMZGzNilidYRYIesyCSs4BsCLUQqy9Pm4iw3pCUrQaTFv/HGiRa8TnnAF1f3TejANvzD2N6n2XW/QSmiMKZe1QBoYk70nqDx2yShoaoz5G9hEV5W+9obCH5PB0L+0DDzlGoLE6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WrddKb/4; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707448493; x=1738984493;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ptn1JpRP3StyuOfIWKSzj6sKJoeJjAtlLJUNbm0+pS8=;
  b=WrddKb/4rSojKTkCLJ5XBYuTuEUd2qohsIjSPd31BdD5Poais91vEMKy
   eA6EsC52iI2mvlEJNcNyG/kJdAgrtk7af8DJTHz+qMabCZNTH5rp8YGxh
   5GNuMsRMvjvOvuvcR0Do00HyMfO5e3yUoC7gi/3E9WJIVoEP8MoHCg3gm
   LQ9T6W89Vc5Nati46u4zKM/9XT0iqWqrNYPGJiCW5Q4Ey9i6BVg6F767R
   /eTJOkeUd8cT/iF32zNL2B34CdYzeSD3zBOjF/MhwcySMrKssBeeUCyZ0
   MiQhBKWLwUoS0MO2VfWp5y2zkQ1T6ANoa8zm0oUP7Wj2NNNdxml9lsJdP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1257909"
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="1257909"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 19:14:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="32631428"
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
Subject: [RFC PATCH v4 06/15] perf stat: Add functions to get counter info
Date: Thu,  8 Feb 2024 19:14:32 -0800
Message-ID: <20240209031441.943012-7-weilin.wang@intel.com>
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
 tools/perf/util/metricgroup.c | 101 ++++++++++++++++++++++++++++++++--
 1 file changed, 97 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 2a917220fb34..9061ed4ca015 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -179,6 +179,20 @@ struct metricgroup__event_info {
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
+	/** The number of gp counters in the pmu. */
+	size_t num_counters;
+	size_t num_fixed_counters;
+};
+
 /**
  * Each group is one node in the group string list.
  */
@@ -1530,6 +1544,27 @@ static int parse_counter(const char *counter,
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
@@ -1548,7 +1583,7 @@ static struct metricgroup__event_info *event_info__new(const char *name,
 
 	e->name = name;
 	e->free_counter = free_counter;
-	e->pmu_name = strdup(pmu_name);
+	e->pmu_name = pmu_name;
 	if (free_counter) {
 		ret = set_counter_bitmap(0, e->counters);
 		if (ret)
@@ -1583,7 +1618,9 @@ static int metricgroup__add_metric_event_callback(const struct pmu_event *pe,
 	struct metricgroup__add_metric_event_data *d = data;
 
 	if (!strcasecmp(pe->name, d->event_name)) {
-		event = event_info__new(d->event_id, pe->pmu, pe->counter, /*free_counter=*/false);
+		if (!pe->counters)
+			return -EINVAL;
+		event = event_info__new(d->event_id, pe->pmu, pe->counters, /*free_counter=*/false);
 		if (!event)
 			return -ENOMEM;
 		list_add(&event->nd, d->list);
@@ -1622,7 +1659,7 @@ static int get_metricgroup_events(const char *full_id,
 			.event_name = id,
 			.event_id = full_id,
 		};
-		ret = pmu_events_table_for_each_event(table,
+		ret = pmu_events_table__for_each_event(table, /*pmu=*/NULL,
 				metricgroup__add_metric_event_callback, &data);
 	}
 
@@ -1631,6 +1668,57 @@ static int get_metricgroup_events(const char *full_id,
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
+	l->num_counters = pl->num_counters;
+	l->num_fixed_counters = pl->num_fixed_counters;
+	pr_debug("create new pmu_layout: [pmu]=%s, [gp_size]=%ld, [fixed_size]=%ld\n",
+		l->name, l->num_counters, l->num_fixed_counters);
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
@@ -1649,6 +1737,7 @@ static int hw_aware_build_grouping(struct expr_parse_ctx *ctx __maybe_unused,
 	LIST_HEAD(event_info_list);
 	size_t bkt;
 	const struct pmu_events_table *etable = perf_pmu__find_events_table(NULL);
+	const struct pmu_layouts_table *ltable = perf_pmu__find_layouts_table(NULL);
 
 #define RETURN_IF_NON_ZERO(x) do { if (x) return x; } while (0)
 	hashmap__for_each_entry(ctx->ids, cur, bkt) {
@@ -1658,9 +1747,13 @@ static int hw_aware_build_grouping(struct expr_parse_ctx *ctx __maybe_unused,
 
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
-- 
2.42.0


