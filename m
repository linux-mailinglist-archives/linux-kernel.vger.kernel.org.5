Return-Path: <linux-kernel+bounces-125316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EB68923E8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 419B8B22009
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22DC13A3E7;
	Fri, 29 Mar 2024 19:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tuj18CtB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BB213341C;
	Fri, 29 Mar 2024 19:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711739571; cv=none; b=AenzbodDUnqejLvR7pL0AKsd3QjxcW+bNzEryE7ZE/BBeqZ8M0cuVjk7ueEK0GWqOjVrDcnW/XIfw0FIjsme0SzUA35ISGs2RTB4yndT7PsL6cNGV4Q3Y6Tctri425dqBvnv7YJfsVI1QBZq9o9B8YZ1s8i1+kFQm2exjpY5I4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711739571; c=relaxed/simple;
	bh=L/5UeazAsJm7bglEGwbz66njR+zWH7rL/SjzIqmB8T0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dW3pDp5nMO+pYWl0evJypRsCJyXLy5l/MwR33TSS84JzPSGR8L9ZegQ/GsQwWmWrcUnU2UMYlfkz4fl5kTeN+yHKSMMYMKNentOSDjMLtJOUBo8Z9yq6uInym9lRFAZfMaFzy6oBN3Nrxh3+FXTKh00MZo4mUsU5sJtAZI46B+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tuj18CtB; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711739570; x=1743275570;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L/5UeazAsJm7bglEGwbz66njR+zWH7rL/SjzIqmB8T0=;
  b=Tuj18CtByWC/MWI+O3QayDvbzeEbq8bvR9sMwnQhMvSzpX5Q9BFhl+9U
   rhmT0QLGpYZGxPscZsf2v5C+TQC64LIYSTYiKnndXJzj/KKjmxFJ8O9F6
   PgW2Mv6/gvrrjVRHkFdAHnrrgrQfrr32u2BHKvqkHW2m1GK3VWwVnHyrZ
   /qaaAjdy2BPLbPDccpKkVuoSkHfCr/sX40j9Kk6WR55LBoeesv8OlviZA
   CYdkRYn2oLHIybt+HWQ98dQI+bGkINmRgU6qYrC4BfDeh3X0BxPmvMnph
   FAIsa9qJSrhN9Sf2uFs8hbrPgADSYR+J2xKRTSF6+r4Nio1Z7/ml+xyEX
   w==;
X-CSE-ConnectionGUID: 0oioObHLSWO5YCj3vOzRvw==
X-CSE-MsgGUID: F0IUjxLRQwWkKBEOa0IxDA==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="7531727"
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="7531727"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 12:12:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="54506859"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by orviesa001.jf.intel.com with ESMTP; 29 Mar 2024 12:12:46 -0700
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
Subject: [RFC PATCH v6 3/5] perf stat: Add retire latency values into the expr_parse_ctx to prepare for final metric calculation
Date: Fri, 29 Mar 2024 15:12:22 -0400
Message-ID: <20240329191224.1046866-4-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329191224.1046866-1-weilin.wang@intel.com>
References: <20240329191224.1046866-1-weilin.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weilin Wang <weilin.wang@intel.com>

Retire latency values of events are used in metric formulas. This update adds
code to process data from perf record for required retire latency values.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
Reviewed-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c     |  1 +
 tools/perf/util/metricgroup.h |  4 ++++
 tools/perf/util/stat-shadow.c | 19 +++++++++++++++++++
 3 files changed, 24 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 7fbe47b0c44c..4954ff84c407 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -798,6 +798,7 @@ static int process_sample_event(struct perf_tool *tool __maybe_unused,
 		if (!strcmp(evname, t->event.name)) {
 			t->count += 1;
 			t->sum += sample->retire_lat;
+			t->val = (double) t->sum / t->count;
 			break;
 		}
 	}
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index ae788edef30f..d63209b29bf1 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -76,8 +76,12 @@ struct tpebs_event {
 
 struct tpebs_retire_lat {
 	struct tpebs_event event;
+	/* Count of retire_latency values found in sample data */
 	size_t count;
+	/* Sum of all the retire_latency values in sample data */
 	int sum;
+	/* Average of retire_latency, val = sum / count */
+	double val;
 };
 
 struct metric_event *metricgroup__lookup(struct rblist *metric_events,
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 3466aa952442..bc77e9e02892 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -355,6 +355,20 @@ static void print_nsecs(struct perf_stat_config *config,
 		print_metric(config, ctxp, NULL, NULL, "CPUs utilized", 0);
 }
 
+static int prepare_retire_lat(struct expr_parse_ctx *pctx,
+			     struct list_head *retire_lats)
+{
+	int ret = 0;
+	struct tpebs_retire_lat *t;
+
+	list_for_each_entry(t, retire_lats, event.nd) {
+		ret = expr__add_id_val(pctx, strdup(t->event.tpebs_name), t->val);
+		if (ret < 0)
+			return ret;
+	}
+	return ret;
+}
+
 static int prepare_metric(const struct metric_expr *mexp,
 			  const struct evsel *evsel,
 			  struct expr_parse_ctx *pctx,
@@ -486,6 +500,11 @@ static void generic_metric(struct perf_stat_config *config,
 		pctx->sctx.user_requested_cpu_list = strdup(config->user_requested_cpu_list);
 	pctx->sctx.runtime = runtime;
 	pctx->sctx.system_wide = config->system_wide;
+	i = prepare_retire_lat(pctx, &config->tpebs_results);
+	if (i < 0) {
+		expr__ctx_free(pctx);
+		return;
+	}
 	i = prepare_metric(mexp, evsel, pctx, aggr_idx);
 	if (i < 0) {
 		expr__ctx_free(pctx);
-- 
2.43.0


