Return-Path: <linux-kernel+bounces-100933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF42879FCB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 00:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEDBB28352A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5356850A88;
	Tue, 12 Mar 2024 23:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EnqiXsaU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F338D481AB;
	Tue, 12 Mar 2024 23:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710287377; cv=none; b=nZAaSQzgemGZQoK7V94c51Vz0+XgBVB6hqB7qjSMlB35Y9ws5+LOUq8QBkNPWmnFDwoGgfVGg1z3a99BWwQzG0sHwRizsu4eQ7k/tVHMjfkTk0Edvh0cEv6fTDA19+fNxGnf44JWCPdhTVhas2OAX2AJ4PCu8S4ZX/AgXJIMBZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710287377; c=relaxed/simple;
	bh=sk3JbX6PBhz/acDUmi4GyK48cKZZGnT2//5KEDwyXIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MbCghFC5f+PW4SoB2UAfgUZvayXbO9Ej5H04VJRB471pNWjTIpxbOMo3IJ0V5SrujHJ89wACcMSfz6g8eMMiYmz+E4o9bQmAVuassS+Ya6Enlij3OIRIBXB/SAxzBMWpyKhMm0RwBb84IiO1nLGswftU7eanhjKA6MeJgW9+eQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EnqiXsaU; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710287376; x=1741823376;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sk3JbX6PBhz/acDUmi4GyK48cKZZGnT2//5KEDwyXIQ=;
  b=EnqiXsaUbR3Kuocr6pt6yot04eqKX4Zr4Bj79SXX6AkQ7KSfV2wzSaVm
   CcIf2VL3XrTWhZ/eKZlx+vM6PgFZS0KbaPZ4g5YcUVihpoAW8hBOB6N7G
   DKuSv+nX1aMvTtgqkh3meB22H1BIZQO9RS8NexaV7u7NSwX3MirGDssjA
   tDv49CrGSORQi3/JooocKwmjF7DQj+5OdMDcZnx55smjk+sGfPjHAofvk
   SxYii8T698cm8tx/5pzFaxOBnQteT4g5Aiu+DSMJy22ItOgNfOO1Ngga3
   akvuh5DkkG8dumJmswHqVNRhMVSS7xeJ2aYmq9MQNpu1a0CFcyr/c89+s
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="8847699"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="8847699"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 16:49:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="42715681"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by fmviesa001.fm.intel.com with ESMTP; 12 Mar 2024 16:49:34 -0700
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
Subject: [RFC PATCH v4 3/6] perf stat: Add retire latency values into the expr_parse_ctx to prepare for final metric calculation
Date: Tue, 12 Mar 2024 19:49:18 -0400
Message-ID: <20240312234921.812685-4-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240312234921.812685-1-weilin.wang@intel.com>
References: <20240312234921.812685-1-weilin.wang@intel.com>
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
 tools/perf/util/stat-shadow.c | 19 +++++++++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 4e92e73cbeaf..a479b21874b0 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -786,6 +786,7 @@ static int process_sample_event(struct perf_tool *tool __maybe_unused,
 		if (!strcmp(evname, t->name)) {
 			t->count += 1;
 			t->sum += sample->retire_lat;
+			t->val = (double) t->sum / t->count;
 			break;
 		}
 	}
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index 3c37d80c4d34..38f9134d8b54 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -82,6 +82,7 @@ struct tpebs_retire_lat {
 	const char *tpebs_name;
 	size_t count;
 	int sum;
+	double val;
 };
 
 struct metric_event *metricgroup__lookup(struct rblist *metric_events,
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 3466aa952442..8fc3415de106 100644
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


