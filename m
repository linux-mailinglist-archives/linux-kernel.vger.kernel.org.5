Return-Path: <linux-kernel+bounces-85336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6C586B463
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E52DB29607
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDFB15E5C8;
	Wed, 28 Feb 2024 16:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d6K3fTGS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67FA15E5DE;
	Wed, 28 Feb 2024 16:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709136763; cv=none; b=YECAaQMWtyaqWEzkQmN3mUKBEmg4tQL6sP7U4jTR/cEvs2e/8wWfIwM+o85O1ghZNuZm1Ru0yFDtYuZE4IW+pdbA6sGiwZ5LBtR+XtJhZv6PRhx0/TSnzDloO3WCK/W84kqUXcQ/A3yoEv3rtlOx8YH70Ds4WGOrBQwN8cNGsy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709136763; c=relaxed/simple;
	bh=6wo/+6fc+LTd+YM3oQ6kkcsi6l7BgZUng26rp9OSpk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JzAVJi21fPz+D0qbxVQM2iptbPfOKuD+qNOS1YTbdGWO7nAMRiKbnoxM2qcvnfFpba8rmMjfbjYB//RVbltJ1Yibzo/9MWWjLkDBMUePRsiVbtN1pfYtWcWGBUBgc4tJhDoNoEtgIyB/mci4Zm9BJjllaVvR2qNb3TFJnKB7qrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d6K3fTGS; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709136761; x=1740672761;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6wo/+6fc+LTd+YM3oQ6kkcsi6l7BgZUng26rp9OSpk8=;
  b=d6K3fTGSlb6V+GYse0vM0JYKMykx/JGlrRuupyV9EXaPvy/7FKCquKLJ
   7jQI6z23EBOfMFoXRtCt+JYlP8panHNBu7yrndWOAPo5hWaC70hC414ai
   Y5KQE7iXJdfHdzBjKa1qbiz60F6KEFmpsl45w3xfCRQyIDXWPKLzNPb70
   Wq0DuEtf8rl4kLZ8y8UqnVEE2rWyz2K0qV02Zradgq/hoXpnu1vfJioyT
   Z4Pb3ear68q0OOsjDRo2NPb5GcWo9XByH/RKjw/u2NvSH8dVNzsTwSlgQ
   9UcgM0ppYGXPs0KJN43uWgMiGVCdEzgx9pPpV3vgDFRGXx81AO06Ggfly
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="14185456"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="14185456"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 08:12:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="7418096"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by orviesa010.jf.intel.com with ESMTP; 28 Feb 2024 08:12:37 -0800
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
Subject: [RFC PATCH v2 3/6] perf stat: Add retire latency values into the expr_parse_ctx to prepare for final metric calculation
Date: Wed, 28 Feb 2024 11:12:24 -0500
Message-ID: <20240228161227.484886-4-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240228161227.484886-1-weilin.wang@intel.com>
References: <20240228161227.484886-1-weilin.wang@intel.com>
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
---
 tools/perf/builtin-stat.c     |  1 +
 tools/perf/util/metricgroup.h |  1 +
 tools/perf/util/stat-shadow.c | 18 ++++++++++++++++++
 3 files changed, 20 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 3890a579349e..3e5865572266 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -792,6 +792,7 @@ static int process_sample_event(struct perf_tool *tool,
 		if (!strcmp(evname, t->name)) {
 			t->count += 1;
 			t->sum += sample->retire_lat;
+			t->val = t->count > 0 ? t->sum/t->count : 0;
 			break;
 		}
 	}
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index 1fa12cc3294e..08af0f447550 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -77,6 +77,7 @@ struct tpebs_retire_lat {
 	const char *tpebs_name;
 	size_t count;
 	int sum;
+	double val;
 };
 
 struct metric_event *metricgroup__lookup(struct rblist *metric_events,
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 3466aa952442..c63ba52004fc 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -355,6 +355,19 @@ static void print_nsecs(struct perf_stat_config *config,
 		print_metric(config, ctxp, NULL, NULL, "CPUs utilized", 0);
 }
 
+static int prepare_retire_lat(struct expr_parse_ctx *pctx,
+			     struct list_head *retire_lats)
+{
+	int ret = 0;
+	struct tpebs_retire_lat *t;
+	list_for_each_entry(t, retire_lats, nd) {
+		ret = expr__add_id_val(pctx, strdup(t->tpebs_name), t->val);
+		if (ret < 0)
+			return ret;
+	}
+	return ret;
+}
+
 static int prepare_metric(const struct metric_expr *mexp,
 			  const struct evsel *evsel,
 			  struct expr_parse_ctx *pctx,
@@ -486,6 +499,11 @@ static void generic_metric(struct perf_stat_config *config,
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


