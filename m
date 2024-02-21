Return-Path: <linux-kernel+bounces-74211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A1085D131
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 541DE1F269B9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A623BB34;
	Wed, 21 Feb 2024 07:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mxLHbQ66"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B83F3A8E8;
	Wed, 21 Feb 2024 07:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708500084; cv=none; b=WHnO636iSKI/tTny5g0dPwsJnrYOsAJnchDqTc+gh8+RboGJM5JVuOvh9nWXYYCu4QbSDlG43X95uTFYqUb4kB8QjFqgfKEa5WpgVdCsikv9VCaTojhlg1YiO1DF1yYjphwqyDoCf5Dc2GZV37rw6WsF4XOXG1NRIBUp8oHgqxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708500084; c=relaxed/simple;
	bh=v9JpIlTbfilCLtSnEYmK6CXSd5owEWcVt9Imm/BLSs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G+zzlY6YmcdukVtV7JOw5L/JjsJWu08eDrg7bjaWzw3N6RrSrV58KEhSq1Y0ADpXkmzxyadr6cwoz2wZK/7goI+gFbapVn0nyF+Ic/52TZa1SU7/DGALglspuedW/9lWH1u4u4t0sC+6NMCpEEmDgR7JYv672dNU59dKL5NTM1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mxLHbQ66; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708500082; x=1740036082;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v9JpIlTbfilCLtSnEYmK6CXSd5owEWcVt9Imm/BLSs4=;
  b=mxLHbQ66mfzc4FWUSN/drAECmB9LxC/+5BqM+LYP0UDr8uEz5GHkGOxf
   Jw+1RAGLKaIMIxxYCt4tsOIO5ib6+YrypRmoXbyVfvI4B/L0slhHTNEEc
   iyRsGfPhalUuThfY2de6zv0h0QpSwTpawqT/4DgPdkLAw7I/wac2HHIXd
   0tRkTtOn/jQwFbvy57AU0JHQR4MJw43vCklXSarWH+CGtY5gDiKpWYFHt
   OHluBrPlmhTeJZvwOGnPgI94IFrtoUo/EtgQAYzk5LUoYigsoJMKocthV
   7DnZn7Olzba18ThaDgUD2Zb5FnjSym5dmzCqQyxJ5TOleQClQ9hHT8QK4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2529996"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="2529996"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 23:21:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="5017433"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by fmviesa010.fm.intel.com with ESMTP; 20 Feb 2024 23:21:20 -0800
From: weilin.wang@intel.com
To: weilin.wang@intel.com,
	Ian Rogers <irogers@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>
Subject: [RFC PATCH v1 1/5] perf stat: Parse and find tpebs events when parsing metrics to prepare for perf record sampling
Date: Wed, 21 Feb 2024 02:20:55 -0500
Message-ID: <20240221072100.412939-2-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240221072100.412939-1-weilin.wang@intel.com>
References: <20240221072100.412939-1-weilin.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weilin Wang <weilin.wang@intel.com>

Metrics that use tpebs values would use the :retire_latency keyword in
formulas. We put all these events into a list and pass the list to perf
record to collect their retire latency value.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/builtin-stat.c     | 38 +++++++++++++++++++++----
 tools/perf/util/metricgroup.c | 52 +++++++++++++++++++++++++++--------
 tools/perf/util/metricgroup.h | 10 ++++++-
 tools/perf/util/stat.h        |  2 ++
 4 files changed, 84 insertions(+), 18 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 07b48f6df48e..93a7cba30f12 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -162,6 +162,7 @@ static struct perf_stat_config stat_config = {
 	.ctl_fd			= -1,
 	.ctl_fd_ack		= -1,
 	.iostat_run		= false,
+	.tpebs_event_size = 0,
 };
 
 static bool cpus_map_matched(struct evsel *a, struct evsel *b)
@@ -686,6 +687,12 @@ static enum counter_recovery stat_handle_error(struct evsel *counter)
 	return COUNTER_FATAL;
 }
 
+static int __run_perf_record(void)
+{
+	pr_debug("Prepare perf record for retire_latency\n");
+	return 0;
+}
+
 static int __run_perf_stat(int argc, const char **argv, int run_idx)
 {
 	int interval = stat_config.interval;
@@ -703,6 +710,15 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	int err;
 	bool second_pass = false;
 
+	//Prepare perf record for sampling event retire_latency before fork and prepare workload
+	if (stat_config.tpebs_event_size > 0) {
+		int ret;
+
+		ret = __run_perf_record();
+		if (ret)
+			return ret;
+	}
+
 	if (forks) {
 		if (evlist__prepare_workload(evsel_list, &target, argv, is_pipe, workload_exec_failed_signal) < 0) {
 			perror("failed to prepare workload");
@@ -2061,7 +2077,9 @@ static int add_default_attributes(void)
 						stat_config.metric_no_threshold,
 						stat_config.user_requested_cpu_list,
 						stat_config.system_wide,
-						&stat_config.metric_events);
+						&stat_config.metric_events,
+						&stat_config.tpebs_events,
+						&stat_config.tpebs_event_size);
 	}
 
 	if (smi_cost) {
@@ -2094,7 +2112,9 @@ static int add_default_attributes(void)
 						stat_config.metric_no_threshold,
 						stat_config.user_requested_cpu_list,
 						stat_config.system_wide,
-						&stat_config.metric_events);
+						&stat_config.metric_events,
+						&stat_config.tpebs_events,
+						&stat_config.tpebs_event_size);
 	}
 
 	if (topdown_run) {
@@ -2128,7 +2148,9 @@ static int add_default_attributes(void)
 						/*metric_no_threshold=*/true,
 						stat_config.user_requested_cpu_list,
 						stat_config.system_wide,
-						&stat_config.metric_events) < 0)
+						&stat_config.metric_events,
+						&stat_config.tpebs_events,
+						&stat_config.tpebs_event_size) < 0)
 			return -1;
 	}
 
@@ -2169,7 +2191,9 @@ static int add_default_attributes(void)
 							/*metric_no_threshold=*/true,
 							stat_config.user_requested_cpu_list,
 							stat_config.system_wide,
-							&stat_config.metric_events) < 0)
+							&stat_config.metric_events,
+							/*&stat_config.tpebs_events=*/NULL,
+							/*stat_config.tpebs_event_size=*/0) < 0)
 				return -1;
 
 			evlist__for_each_entry(metric_evlist, metric_evsel) {
@@ -2689,6 +2713,8 @@ int cmd_stat(int argc, const char **argv)
 		}
 	}
 
+	INIT_LIST_HEAD(&stat_config.tpebs_events);
+
 	/*
 	 * Metric parsing needs to be delayed as metrics may optimize events
 	 * knowing the target is system-wide.
@@ -2702,7 +2728,9 @@ int cmd_stat(int argc, const char **argv)
 					stat_config.metric_no_threshold,
 					stat_config.user_requested_cpu_list,
 					stat_config.system_wide,
-					&stat_config.metric_events);
+					&stat_config.metric_events,
+					&stat_config.tpebs_events,
+					&stat_config.tpebs_event_size);
 		zfree(&metrics);
 	}
 
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 6231044a491e..6c16e5a0b1fc 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -275,7 +275,8 @@ static bool contains_metric_id(struct evsel **metric_events, int num_events,
  */
 static int setup_metric_events(const char *pmu, struct hashmap *ids,
 			       struct evlist *metric_evlist,
-			       struct evsel ***out_metric_events)
+			       struct evsel ***out_metric_events,
+			       size_t tpebs_event_size)
 {
 	struct evsel **metric_events;
 	const char *metric_id;
@@ -284,7 +285,7 @@ static int setup_metric_events(const char *pmu, struct hashmap *ids,
 	bool all_pmus = !strcmp(pmu, "all") || perf_pmus__num_core_pmus() == 1 || !is_pmu_core(pmu);
 
 	*out_metric_events = NULL;
-	ids_size = hashmap__size(ids);
+	ids_size = hashmap__size(ids) - tpebs_event_size;
 
 	metric_events = calloc(sizeof(void *), ids_size + 1);
 	if (!metric_events)
@@ -321,6 +322,7 @@ static int setup_metric_events(const char *pmu, struct hashmap *ids,
 		}
 	}
 	if (matched_events < ids_size) {
+		pr_debug("Error: matched_events = %lu, ids_size = %lu\n", matched_events, ids_size);
 		free(metric_events);
 		return -EINVAL;
 	}
@@ -668,7 +670,9 @@ static int decode_all_metric_ids(struct evlist *perf_evlist, const char *modifie
 static int metricgroup__build_event_string(struct strbuf *events,
 					   const struct expr_parse_ctx *ctx,
 					   const char *modifier,
-					   bool group_events)
+					   bool group_events,
+					   struct list_head *tpebs_events __maybe_unused,
+					   size_t *tpebs_event_size)
 {
 	struct hashmap_entry *cur;
 	size_t bkt;
@@ -681,9 +685,21 @@ static int metricgroup__build_event_string(struct strbuf *events,
 	hashmap__for_each_entry(ctx->ids, cur, bkt) {
 		const char *sep, *rsep, *id = cur->pkey;
 		enum perf_tool_event ev;
+		char *p = strstr(id, ":retire_latency");
 
 		pr_debug("found event %s\n", id);
 
+		if (p) {
+			struct tpebs_event *new_event = malloc(sizeof(struct tpebs_event));
+			*p = '\0';
+			new_event->tpebs_name = strdup(id);
+			*tpebs_event_size += 1;
+			pr_debug("retire_latency required, tpebs_event_size=%lu, new_event=%s\n",
+			*tpebs_event_size, new_event->name);
+			list_add_tail(&new_event->nd, tpebs_events);
+			continue;
+		}
+
 		/* Always move tool events outside of the group. */
 		ev = perf_tool_event__from_str(id);
 		if (ev != PERF_TOOL_NONE) {
@@ -1447,7 +1463,8 @@ static int build_combined_expr_ctx(const struct list_head *metric_list,
 static int parse_ids(bool metric_no_merge, struct perf_pmu *fake_pmu,
 		     struct expr_parse_ctx *ids, const char *modifier,
 		     bool group_events, const bool tool_events[PERF_TOOL_MAX],
-		     struct evlist **out_evlist)
+		     struct evlist **out_evlist, struct list_head *tpebs_events,
+		     size_t *tpebs_event_size)
 {
 	struct parse_events_error parse_error;
 	struct evlist *parsed_evlist;
@@ -1490,7 +1507,7 @@ static int parse_ids(bool metric_no_merge, struct perf_pmu *fake_pmu,
 		}
 	}
 	ret = metricgroup__build_event_string(&events, ids, modifier,
-					      group_events);
+					      group_events, tpebs_events, tpebs_event_size);
 	if (ret)
 		return ret;
 
@@ -1529,7 +1546,9 @@ static int parse_groups(struct evlist *perf_evlist,
 			bool system_wide,
 			struct perf_pmu *fake_pmu,
 			struct rblist *metric_events_list,
-			const struct pmu_metrics_table *table)
+			const struct pmu_metrics_table *table,
+			struct list_head *tpebs_events,
+			size_t *tpebs_event_size)
 {
 	struct evlist *combined_evlist = NULL;
 	LIST_HEAD(metric_list);
@@ -1561,7 +1580,8 @@ static int parse_groups(struct evlist *perf_evlist,
 					/*modifier=*/NULL,
 					/*group_events=*/false,
 					tool_events,
-					&combined_evlist);
+					&combined_evlist,
+					tpebs_events, tpebs_event_size);
 		}
 		if (combined)
 			expr__ctx_free(combined);
@@ -1616,14 +1636,15 @@ static int parse_groups(struct evlist *perf_evlist,
 		}
 		if (!metric_evlist) {
 			ret = parse_ids(metric_no_merge, fake_pmu, m->pctx, m->modifier,
-					m->group_events, tool_events, &m->evlist);
+					m->group_events, tool_events, &m->evlist,
+					tpebs_events, tpebs_event_size);
 			if (ret)
 				goto out;
 
 			metric_evlist = m->evlist;
 		}
 		ret = setup_metric_events(fake_pmu ? "all" : m->pmu, m->pctx->ids,
-					  metric_evlist, &metric_events);
+					  metric_evlist, &metric_events, *tpebs_event_size);
 		if (ret) {
 			pr_err("Cannot resolve IDs for %s: %s\n",
 				m->metric_name, m->metric_expr);
@@ -1690,16 +1711,21 @@ int metricgroup__parse_groups(struct evlist *perf_evlist,
 			      bool metric_no_threshold,
 			      const char *user_requested_cpu_list,
 			      bool system_wide,
-			      struct rblist *metric_events)
+			      struct rblist *metric_events,
+			      struct list_head *tpebs_events,
+			      size_t *tpebs_event_size)
 {
 	const struct pmu_metrics_table *table = pmu_metrics_table__find();
 
+	pr_debug("Test debugging\n");
+
 	if (!table)
 		return -EINVAL;
 
 	return parse_groups(perf_evlist, pmu, str, metric_no_group, metric_no_merge,
 			    metric_no_threshold, user_requested_cpu_list, system_wide,
-			    /*fake_pmu=*/NULL, metric_events, table);
+			    /*fake_pmu=*/NULL, metric_events, table, tpebs_events,
+			    tpebs_event_size);
 }
 
 int metricgroup__parse_groups_test(struct evlist *evlist,
@@ -1713,7 +1739,9 @@ int metricgroup__parse_groups_test(struct evlist *evlist,
 			    /*metric_no_threshold=*/false,
 			    /*user_requested_cpu_list=*/NULL,
 			    /*system_wide=*/false,
-			    &perf_pmu__fake, metric_events, table);
+			    &perf_pmu__fake, metric_events, table,
+			    /*tpebs_events=*/NULL,
+			    /*tpebs_event_size=*/0);
 }
 
 struct metricgroup__has_metric_data {
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index d5325c6ec8e1..7c24ed768ff3 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -66,6 +66,12 @@ struct metric_expr {
 	int runtime;
 };
 
+struct tpebs_event {
+	struct list_head nd;
+	const char *name;
+	const char *tpebs_name;
+};
+
 struct metric_event *metricgroup__lookup(struct rblist *metric_events,
 					 struct evsel *evsel,
 					 bool create);
@@ -77,7 +83,9 @@ int metricgroup__parse_groups(struct evlist *perf_evlist,
 			      bool metric_no_threshold,
 			      const char *user_requested_cpu_list,
 			      bool system_wide,
-			      struct rblist *metric_events);
+			      struct rblist *metric_events,
+			      struct list_head *tpebs_events,
+			      size_t *tpebs_event_size);
 int metricgroup__parse_groups_test(struct evlist *evlist,
 				   const struct pmu_metrics_table *table,
 				   const char *str,
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 325d0fad1842..9d0186316b29 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -109,6 +109,8 @@ struct perf_stat_config {
 	struct cpu_aggr_map	*cpus_aggr_map;
 	u64			*walltime_run;
 	struct rblist		 metric_events;
+	struct list_head	 tpebs_events;
+	size_t			 tpebs_event_size;
 	int			 ctl_fd;
 	int			 ctl_fd_ack;
 	bool			 ctl_fd_close;
-- 
2.43.0


