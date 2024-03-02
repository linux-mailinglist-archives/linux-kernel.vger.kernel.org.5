Return-Path: <linux-kernel+bounces-89251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F3586ED40
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 01:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6EF31F227AD
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 00:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6CE6AAD;
	Sat,  2 Mar 2024 00:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tl6JB+Za"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7F5382;
	Sat,  2 Mar 2024 00:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709338310; cv=none; b=CWM8hCrUyVtKp88mvx562MDkK/TAI/5ZRfT+D9g2Kqi4pxU/9MyQKkWSLGPH09EAcibWbEwY+CyM7u950R/uABH7Gy8NjqvPgoskOdPRzQpnHnkjShIFVexWtfXgDPFflaXlzL6DEoTAZClWxssPg49mAg6mGpLwc78vbo0BEVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709338310; c=relaxed/simple;
	bh=KYpc/jxsvmGHz+6mGByWMc9jyRrSfv4k7YqceZKkURA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jZ5yMTKIV2QKXO49k+M/2/R+8jSy+hnuqjngsUKyw1T1b6MsWhiFzo+1w8Wvf1GsdfQov4J8yptnSnZwg1Gr6NrHpgL3BLdfPmKjFx3PaMpRFTkCeEVzQhOlBVrm9VL1Whop3EMGWHHDWqOvsKWn9JSKilNxoZk7axqhvbF5M1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tl6JB+Za; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709338308; x=1740874308;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KYpc/jxsvmGHz+6mGByWMc9jyRrSfv4k7YqceZKkURA=;
  b=Tl6JB+Za4YmhMDkP6MaMrTV1tdF5T6PCDmBmmWPziiQ3ZQ4qBeWLf9kf
   4dRWsaSB5mQdGlAi61TwafoRCxIsqHDKfcLyLYwdR7JCP1AfkouRIqtkm
   36VEHkcQ8lj0TqcV5dj3npJDiAk1aydCGzpHb9Wl+kvAb/nvtaV/cGEII
   Rx3MiFVV9tiWVGDRhho6vRF1OJfViyurgFQKdES9yKEaZnYEIEQYZlYqo
   E76+GX8X7BaAM5oQaVC6faTS/S3bMdkur5O/eygkF5p8793rRhbLwrjb1
   VkQn4JZSpOjAaXgaFkF+/5Olxh2pGfnm9bErPZUX9mf/7Fd68vXRBIEe1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="4476136"
X-IronPort-AV: E=Sophos;i="6.06,197,1705392000"; 
   d="scan'208";a="4476136"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 16:11:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,197,1705392000"; 
   d="scan'208";a="13054633"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by orviesa005.jf.intel.com with ESMTP; 01 Mar 2024 16:11:45 -0800
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
Subject: [RFC PATCH v3 1/6] perf stat: Parse and find tpebs events when parsing metrics to prepare for perf record sampling
Date: Fri,  1 Mar 2024 19:11:33 -0500
Message-ID: <20240302001139.604829-2-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240302001139.604829-1-weilin.wang@intel.com>
References: <20240302001139.604829-1-weilin.wang@intel.com>
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
 tools/perf/builtin-stat.c     | 38 +++++++++++++---
 tools/perf/util/metricgroup.c | 81 +++++++++++++++++++++++++++++------
 tools/perf/util/metricgroup.h | 10 ++++-
 tools/perf/util/stat.h        |  2 +
 4 files changed, 112 insertions(+), 19 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 6bba1a89d030..5a3093541cff 100644
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
@@ -2106,7 +2122,9 @@ static int add_default_attributes(void)
 						stat_config.metric_no_threshold,
 						stat_config.user_requested_cpu_list,
 						stat_config.system_wide,
-						&stat_config.metric_events);
+						&stat_config.metric_events,
+						&stat_config.tpebs_events,
+						&stat_config.tpebs_event_size);
 	}
 
 	if (smi_cost) {
@@ -2139,7 +2157,9 @@ static int add_default_attributes(void)
 						stat_config.metric_no_threshold,
 						stat_config.user_requested_cpu_list,
 						stat_config.system_wide,
-						&stat_config.metric_events);
+						&stat_config.metric_events,
+						&stat_config.tpebs_events,
+						&stat_config.tpebs_event_size);
 	}
 
 	if (topdown_run) {
@@ -2173,7 +2193,9 @@ static int add_default_attributes(void)
 						/*metric_no_threshold=*/true,
 						stat_config.user_requested_cpu_list,
 						stat_config.system_wide,
-						&stat_config.metric_events) < 0)
+						&stat_config.metric_events,
+						&stat_config.tpebs_events,
+						&stat_config.tpebs_event_size) < 0)
 			return -1;
 	}
 
@@ -2214,7 +2236,9 @@ static int add_default_attributes(void)
 							/*metric_no_threshold=*/true,
 							stat_config.user_requested_cpu_list,
 							stat_config.system_wide,
-							&stat_config.metric_events) < 0)
+							&stat_config.metric_events,
+							/*&stat_config.tpebs_events=*/NULL,
+							/*stat_config.tpebs_event_size=*/0) < 0)
 				return -1;
 
 			evlist__for_each_entry(metric_evlist, metric_evsel) {
@@ -2736,6 +2760,8 @@ int cmd_stat(int argc, const char **argv)
 		}
 	}
 
+	INIT_LIST_HEAD(&stat_config.tpebs_events);
+
 	/*
 	 * Metric parsing needs to be delayed as metrics may optimize events
 	 * knowing the target is system-wide.
@@ -2748,7 +2774,9 @@ int cmd_stat(int argc, const char **argv)
 						stat_config.metric_no_threshold,
 						stat_config.user_requested_cpu_list,
 						stat_config.system_wide,
-						&stat_config.metric_events);
+						&stat_config.metric_events,
+						&stat_config.tpebs_events,
+						&stat_config.tpebs_event_size);
 
 		zfree(&metrics);
 		if (ret) {
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index b24a1c177a80..5ee96d2f16c9 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -277,7 +277,8 @@ static bool contains_metric_id(struct evsel **metric_events, int num_events,
  */
 static int setup_metric_events(const char *pmu, struct hashmap *ids,
 			       struct evlist *metric_evlist,
-			       struct evsel ***out_metric_events)
+			       struct evsel ***out_metric_events,
+			       size_t tpebs_event_size)
 {
 	struct evsel **metric_events;
 	const char *metric_id;
@@ -286,7 +287,7 @@ static int setup_metric_events(const char *pmu, struct hashmap *ids,
 	bool all_pmus = !strcmp(pmu, "all") || perf_pmus__num_core_pmus() == 1 || !is_pmu_core(pmu);
 
 	*out_metric_events = NULL;
-	ids_size = hashmap__size(ids);
+	ids_size = hashmap__size(ids) - tpebs_event_size;
 
 	metric_events = calloc(ids_size + 1, sizeof(void *));
 	if (!metric_events)
@@ -323,6 +324,7 @@ static int setup_metric_events(const char *pmu, struct hashmap *ids,
 		}
 	}
 	if (matched_events < ids_size) {
+		pr_debug("Error: matched_events = %lu, ids_size = %lu\n", matched_events, ids_size);
 		free(metric_events);
 		return -EINVAL;
 	}
@@ -670,7 +672,9 @@ static int decode_all_metric_ids(struct evlist *perf_evlist, const char *modifie
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
@@ -683,8 +687,47 @@ static int metricgroup__build_event_string(struct strbuf *events,
 	hashmap__for_each_entry(ctx->ids, cur, bkt) {
 		const char *sep, *rsep, *id = cur->pkey;
 		enum perf_tool_event ev;
+		char *p = strstr(id, ":R");
+		char *p1 = strstr(id, "@R");
+
+		if (p == NULL && p1) {
+			p = strstr(p1+1, "@R");
+			if (p == NULL)
+				p = p1;
+			p = p+1;
+		}
+
+		if (p) {
+			struct tpebs_event *new_event = malloc(sizeof(struct tpebs_event));
+			char *name;
+			char *at;
 
-		pr_debug("found event %s\n", id);
+			pr_debug("event name %s\n", id);
+			new_event->tpebs_name = strdup(id);
+			*p = '\0';
+			name = malloc(strlen(id) + 2);
+			if (!name)
+				return -ENOMEM;
+
+			at = strchr(id, '@');
+			if (at != NULL) {
+				pr_debug("tpebs name %s\n", id);
+				*at = '/';
+				at = strchr(id, '@');
+				*at = '/';
+				strcpy(name, id);
+				strcat(name, "p");
+			} else {
+				strcpy(name, id);
+				strcat(name, ":p");
+			}
+			new_event->name = name;
+			*tpebs_event_size += 1;
+			pr_debug("retire_latency required, tpebs_event_size=%lu, new_event=%s\n",
+			*tpebs_event_size, new_event->name);
+			list_add_tail(&new_event->nd, tpebs_events);
+			continue;
+		}
 
 		/* Always move tool events outside of the group. */
 		ev = perf_tool_event__from_str(id);
@@ -1449,7 +1492,8 @@ static int build_combined_expr_ctx(const struct list_head *metric_list,
 static int parse_ids(bool metric_no_merge, struct perf_pmu *fake_pmu,
 		     struct expr_parse_ctx *ids, const char *modifier,
 		     bool group_events, const bool tool_events[PERF_TOOL_MAX],
-		     struct evlist **out_evlist)
+		     struct evlist **out_evlist, struct list_head *tpebs_events,
+		     size_t *tpebs_event_size)
 {
 	struct parse_events_error parse_error;
 	struct evlist *parsed_evlist;
@@ -1492,7 +1536,7 @@ static int parse_ids(bool metric_no_merge, struct perf_pmu *fake_pmu,
 		}
 	}
 	ret = metricgroup__build_event_string(&events, ids, modifier,
-					      group_events);
+					      group_events, tpebs_events, tpebs_event_size);
 	if (ret)
 		return ret;
 
@@ -1531,7 +1575,9 @@ static int parse_groups(struct evlist *perf_evlist,
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
@@ -1563,7 +1609,8 @@ static int parse_groups(struct evlist *perf_evlist,
 					/*modifier=*/NULL,
 					/*group_events=*/false,
 					tool_events,
-					&combined_evlist);
+					&combined_evlist,
+					tpebs_events, tpebs_event_size);
 		}
 		if (combined)
 			expr__ctx_free(combined);
@@ -1618,14 +1665,15 @@ static int parse_groups(struct evlist *perf_evlist,
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
@@ -1692,16 +1740,21 @@ int metricgroup__parse_groups(struct evlist *perf_evlist,
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
@@ -1715,7 +1768,9 @@ int metricgroup__parse_groups_test(struct evlist *evlist,
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
index d6e5c8787ba2..b987960df3c5 100644
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


