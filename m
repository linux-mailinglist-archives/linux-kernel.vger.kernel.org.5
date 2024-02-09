Return-Path: <linux-kernel+bounces-58979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA58084EF58
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 04:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E3EF1F2156C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 03:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A5438DD1;
	Fri,  9 Feb 2024 03:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JohPDLCg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD97117BC8;
	Fri,  9 Feb 2024 03:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707448500; cv=none; b=YzdRlW44EiA7EqkxrSv9D1fqoa13lhsrECxNsgpvWMRCe7Vz14vZO+a3ZUe2GRmF59W2gxW9+ySeJ+I7dwcYMfwce3kLa1elNsOOY/OMqbWm6OaxN7ZjyeUk3HTgF2bzgAd4tWGn3uXrKZ9u9Zbo4jIY4w3lZAg41PAU+Qyg6oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707448500; c=relaxed/simple;
	bh=vOPR8LxQn3WFF9Ql8k9wlrgDI26EFBXQsZ+EoLn19bY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LBKoshao74JjdfzhATgzKZFmFnbZTZ+crjNgxtc7BQnfysXtx+OufoXv1sjFiH7K4UvcG5dtttxTPfxry5Zgka+sZapfJrsVeDHhjVloi8mgQhVHsk4YKvsQZAjLhRDzA2GSm5Br6RgX/10lbLfhrKqmkXHHn2h6U+HDAI/yd34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JohPDLCg; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707448499; x=1738984499;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vOPR8LxQn3WFF9Ql8k9wlrgDI26EFBXQsZ+EoLn19bY=;
  b=JohPDLCgpzm4TsCU0oLQP7vwSbhqTbKm3ZVSGIJI1LCnhba8Ef+PsI1c
   OgG/J9KXdTYKPtdV5prmSettj8rjbEabGiIN1+JQj26hShThU1FTPwW/C
   a3QnQVeoeJd3hgre6h8nDWcFk8YM/boNAEUF+0r+w8Xyz/ef49O67XViV
   q47XO5grPHSJINMrZUdOUVEIHaui0irK9jGJzjK9N2IYYl0sBD5K9FHJo
   N4rJ7GOwPGacSex6/SLMCtso/Kakoz4aeQiMVfhteqVH1YYlIloAB84n3
   560VYjipKK1omzGRb5jqZgCNwCIQ5TsEDOyc3SGOtwSdeeuBex8rUG3vY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1257952"
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="1257952"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 19:14:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="32631461"
Received: from b49691a74b80.jf.intel.com ([10.165.54.183])
  by orviesa002.jf.intel.com with ESMTP; 08 Feb 2024 19:14:48 -0800
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
Subject: [RFC PATCH v4 14/15] perf stat: Add tool events support in hardware-grouping
Date: Thu,  8 Feb 2024 19:14:40 -0800
Message-ID: <20240209031441.943012-15-weilin.wang@intel.com>
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

Add tool events into default_core grouping strings if find tool events so
that metrics use tool events could be correctly calculated. Need this step
to support TopdownL4-L5.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/util/metricgroup.c | 49 ++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index cfdbb5f7fb77..e5b8456d0405 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1486,6 +1486,35 @@ static void find_tool_events(const struct list_head *metric_list,
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
@@ -2049,6 +2078,7 @@ static int assign_event_grouping(struct metricgroup__event_info *e,
 
 static int hw_aware_metricgroup__build_event_string(struct list_head *group_strs,
 					   const char *modifier,
+					   const bool tool_events[PERF_TOOL_MAX],
 					   struct list_head *groups)
 {
 	struct metricgroup__pmu_group_list *p;
@@ -2056,8 +2086,12 @@ static int hw_aware_metricgroup__build_event_string(struct list_head *group_strs
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
@@ -2129,6 +2163,12 @@ static int hw_aware_metricgroup__build_event_string(struct list_head *group_strs
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
@@ -2214,6 +2254,7 @@ static int hw_aware_build_grouping(struct expr_parse_ctx *ctx,
 		if (ret)
 			goto err_out;
 	}
+
 	ret = get_pmu_counter_layouts(&pmu_info_list, ltable);
 	if (ret)
 		goto err_out;
@@ -2259,6 +2300,7 @@ static void metricgroup__free_grouping_strs(struct list_head
  */
 static int hw_aware_parse_ids(struct perf_pmu *fake_pmu,
 			     struct expr_parse_ctx *ids, const char *modifier,
+			     const bool tool_events[PERF_TOOL_MAX],
 			     struct evlist **out_evlist)
 {
 	struct parse_events_error parse_error;
@@ -2272,7 +2314,8 @@ static int hw_aware_parse_ids(struct perf_pmu *fake_pmu,
 	ret = hw_aware_build_grouping(ids, &grouping);
 	if (ret)
 		goto out;
-	ret = hw_aware_metricgroup__build_event_string(&grouping_str, modifier, &grouping);
+	ret = hw_aware_metricgroup__build_event_string(&grouping_str, modifier,
+						      tool_events, &grouping);
 	if (ret)
 		goto out;
 
@@ -2407,6 +2450,7 @@ static int hw_aware_parse_groups(struct evlist *perf_evlist,
 	struct evlist *combined_evlist = NULL;
 	LIST_HEAD(metric_list);
 	struct metric *m;
+	bool tool_events[PERF_TOOL_MAX] = {false};
 	int ret;
 	bool metric_no_group = false;
 	bool metric_no_merge = false;
@@ -2425,11 +2469,14 @@ static int hw_aware_parse_groups(struct evlist *perf_evlist,
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
2.42.0


