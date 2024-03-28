Return-Path: <linux-kernel+bounces-119917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C009B88CEF2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3AE21C66DFB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B714813E8B9;
	Tue, 26 Mar 2024 20:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GfwXsMD7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F7713D602;
	Tue, 26 Mar 2024 20:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711484975; cv=none; b=Zm0SnvOP5NeFqBMEw9iAyNOLW3aplFZ6kLh4rhGCd+cjolZax3EAkKl4KvUm7Al1LbIdADAF8rAf2+fzz5oNMc0iPNUOWTm3/06SZziz41fAG4bMONObY9CovZGJXmpL6L4Tu9WaKO5jZ47zfhmFqmTs0pHh/FRTsv2gdvWbFd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711484975; c=relaxed/simple;
	bh=UgfoIXqnRwrmaR9OS/LAEB/kYreYjGKWTpYP32HzAKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OvcndeLbwbWbHa7KBF/O9HUC7pr5HjIE//4cCHWDMqjZA5pWL/2KI5HTySECxlEO5a9jymbkmHiByQ0kKJYzRmSM1XWP4fEPgmKAwrGoWMNI7oi/j94BAhxLrqTETDn+Rn/ty/5C2VXyCdy8KODJOn4kXfAduqdNmszJ5609WIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GfwXsMD7; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711484973; x=1743020973;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UgfoIXqnRwrmaR9OS/LAEB/kYreYjGKWTpYP32HzAKU=;
  b=GfwXsMD7tcUa5W+vr2O1DRH5oTL2BXYT+omGVelbfBmsnDN7t2IcHreA
   A1Z6eB069w+s7p6Og8bbxLw/pYgWGKVMiVMcZb37VnefPAtvyXXlOtkWL
   +y3IEdCdL93Se8M+R45DK7EUaLDwToqoq0y8pIYOjIjKoqinAAuuRkIdc
   wn0u/CIL1e6akuJVsJM8QYT7K5hTpZ7PUjEiPKBvvcUrWcmxagkoqMWKT
   //Pyw4OfyGEf3ylXlhNv28P/gJolQKbR/2680NQqOCi4kz1u5YQYanKnW
   dW6NRRkBFDAuLQONTsGT8LENfjF6mKcAidfqL5WcG21vSbckWFTGvD0/d
   Q==;
X-CSE-ConnectionGUID: Aib4WjKLShCgd+0qCN0TCw==
X-CSE-MsgGUID: Y3PoytTqTGeZLZ/KVve5Mw==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="24049076"
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="24049076"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 13:29:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="16162999"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by fmviesa008.fm.intel.com with ESMTP; 26 Mar 2024 13:29:31 -0700
From: weilin.wang@intel.com
To: weilin.wang@intel.com,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>
Subject: [RFC PATCH v5 1/6] perf stat: Parse and find tpebs events when parsing metrics to prepare for perf record sampling
Date: Tue, 26 Mar 2024 16:28:54 -0400
Message-ID: <20240326202859.960577-2-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240326202859.960577-1-weilin.wang@intel.com>
References: <20240326202859.960577-1-weilin.wang@intel.com>
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
Reviewed-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c     | 38 +++++++++++++--
 tools/perf/util/metricgroup.c | 88 +++++++++++++++++++++++++++++------
 tools/perf/util/metricgroup.h | 10 +++-
 tools/perf/util/stat.h        |  2 +
 4 files changed, 119 insertions(+), 19 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 6bba1a89d030..6291e1e24535 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -162,6 +162,7 @@ static struct perf_stat_config stat_config = {
 	.ctl_fd			= -1,
 	.ctl_fd_ack		= -1,
 	.iostat_run		= false,
+	.tpebs_events		= LIST_HEAD_INIT(stat_config.tpebs_events),
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
@@ -703,6 +710,16 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	int err;
 	bool second_pass = false;
 
+	/* Prepare perf record for sampling event retire_latency before fork and
+	 * prepare workload */
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
@@ -2106,7 +2123,9 @@ static int add_default_attributes(void)
 						stat_config.metric_no_threshold,
 						stat_config.user_requested_cpu_list,
 						stat_config.system_wide,
-						&stat_config.metric_events);
+						&stat_config.metric_events,
+						&stat_config.tpebs_events,
+						&stat_config.tpebs_event_size);
 	}
 
 	if (smi_cost) {
@@ -2139,7 +2158,9 @@ static int add_default_attributes(void)
 						stat_config.metric_no_threshold,
 						stat_config.user_requested_cpu_list,
 						stat_config.system_wide,
-						&stat_config.metric_events);
+						&stat_config.metric_events,
+						&stat_config.tpebs_events,
+						&stat_config.tpebs_event_size);
 	}
 
 	if (topdown_run) {
@@ -2173,7 +2194,9 @@ static int add_default_attributes(void)
 						/*metric_no_threshold=*/true,
 						stat_config.user_requested_cpu_list,
 						stat_config.system_wide,
-						&stat_config.metric_events) < 0)
+						&stat_config.metric_events,
+						&stat_config.tpebs_events,
+						&stat_config.tpebs_event_size) < 0)
 			return -1;
 	}
 
@@ -2214,7 +2237,9 @@ static int add_default_attributes(void)
 							/*metric_no_threshold=*/true,
 							stat_config.user_requested_cpu_list,
 							stat_config.system_wide,
-							&stat_config.metric_events) < 0)
+							&stat_config.metric_events,
+							/*&stat_config.tpebs_events=*/NULL,
+							/*stat_config.tpebs_event_size=*/0) < 0)
 				return -1;
 
 			evlist__for_each_entry(metric_evlist, metric_evsel) {
@@ -2736,6 +2761,7 @@ int cmd_stat(int argc, const char **argv)
 		}
 	}
 
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
index 79ef6095ab28..6dcf94c07dd1 100644
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
@@ -681,8 +685,56 @@ static int metricgroup__build_event_string(struct strbuf *events,
 	hashmap__for_each_entry(ctx->ids, cur, bkt) {
 		const char *sep, *rsep, *id = cur->pkey;
 		enum perf_tool_event ev;
+		/*
+		 * Parse and search for event name with retire_latency modifier.
+		 * If found, put event name into the tpebs_events list. This list
+		 * of events will be passed to perf record for sampling to get
+		 * their reitre_latency value.
+		 * Search for ":R" in event name without "@". Search for the
+		 * last "@R" in event name with "@".
+		 */
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
+			char *name;
+			char *at;
+			struct tpebs_event *new_event = malloc(sizeof(struct tpebs_event));
 
-		pr_debug("found event %s\n", id);
+			if (!new_event)
+				return -ENOMEM;
+
+			new_event->tpebs_name = strdup(id);
+			*p = '\0';
+			name = malloc(strlen(id) + 2);
+			if (!name)
+				return -ENOMEM;
+
+			at = strchr(id, '@');
+			if (at != NULL) {
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
+				*tpebs_event_size, new_event->name);
+			list_add_tail(&new_event->nd, tpebs_events);
+			continue;
+		}
 
 		/* Always move tool events outside of the group. */
 		ev = perf_tool_event__from_str(id);
@@ -1447,7 +1499,8 @@ static int build_combined_expr_ctx(const struct list_head *metric_list,
 static int parse_ids(bool metric_no_merge, struct perf_pmu *fake_pmu,
 		     struct expr_parse_ctx *ids, const char *modifier,
 		     bool group_events, const bool tool_events[PERF_TOOL_MAX],
-		     struct evlist **out_evlist)
+		     struct evlist **out_evlist, struct list_head *tpebs_events,
+		     size_t *tpebs_event_size)
 {
 	struct parse_events_error parse_error;
 	struct evlist *parsed_evlist;
@@ -1490,7 +1543,7 @@ static int parse_ids(bool metric_no_merge, struct perf_pmu *fake_pmu,
 		}
 	}
 	ret = metricgroup__build_event_string(&events, ids, modifier,
-					      group_events);
+					      group_events, tpebs_events, tpebs_event_size);
 	if (ret)
 		return ret;
 
@@ -1529,7 +1582,9 @@ static int parse_groups(struct evlist *perf_evlist,
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
@@ -1561,7 +1616,8 @@ static int parse_groups(struct evlist *perf_evlist,
 					/*modifier=*/NULL,
 					/*group_events=*/false,
 					tool_events,
-					&combined_evlist);
+					&combined_evlist,
+					tpebs_events, tpebs_event_size);
 		}
 		if (combined)
 			expr__ctx_free(combined);
@@ -1616,14 +1672,15 @@ static int parse_groups(struct evlist *perf_evlist,
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
@@ -1690,7 +1747,9 @@ int metricgroup__parse_groups(struct evlist *perf_evlist,
 			      bool metric_no_threshold,
 			      const char *user_requested_cpu_list,
 			      bool system_wide,
-			      struct rblist *metric_events)
+			      struct rblist *metric_events,
+			      struct list_head *tpebs_events,
+			      size_t *tpebs_event_size)
 {
 	const struct pmu_metrics_table *table = pmu_metrics_table__find();
 
@@ -1699,7 +1758,8 @@ int metricgroup__parse_groups(struct evlist *perf_evlist,
 
 	return parse_groups(perf_evlist, pmu, str, metric_no_group, metric_no_merge,
 			    metric_no_threshold, user_requested_cpu_list, system_wide,
-			    /*fake_pmu=*/NULL, metric_events, table);
+			    /*fake_pmu=*/NULL, metric_events, table, tpebs_events,
+			    tpebs_event_size);
 }
 
 int metricgroup__parse_groups_test(struct evlist *evlist,
@@ -1713,7 +1773,9 @@ int metricgroup__parse_groups_test(struct evlist *evlist,
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


