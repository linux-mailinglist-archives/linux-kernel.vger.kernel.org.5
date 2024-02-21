Return-Path: <linux-kernel+bounces-74213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C59EA85D133
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80091283629
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774E93C47C;
	Wed, 21 Feb 2024 07:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Npx7Ky7F"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E13B3AC1B;
	Wed, 21 Feb 2024 07:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708500084; cv=none; b=jaVkXgMjC71ezH/Hb41mwvm8UT7ypLhtg5sk5BuMZbctJdRCjCwdAsO4BQf6gafdNImhveL0DvVugL6c76RLnibSbfjdXhaNOPmIBKnsJYgCzoks67u/Pf1JW26RL9VIekkB3b/QqyhB9ab9Bb6mQfL6IiHKrY+5NKMCpsdw1dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708500084; c=relaxed/simple;
	bh=pBmDQG90CSvCkfKWC4qRQdDiK4qAtYJT4uG6gsEtW/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TxpUQS3Qktux386fhFIPfzTlslpAx8LUqnfxY6ePIAreyMlVdBsXkJ47bkinB7LEgl7Jtm8kKjIWMCRZNdHKTvDzQNhCaRbmFqw6eS0qFben8lpPsODX9CsM/Nct6/NRkWWSgNQdu0PlDbymTuLQ12CYp2nevZtuFKXdSg/ap6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Npx7Ky7F; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708500083; x=1740036083;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pBmDQG90CSvCkfKWC4qRQdDiK4qAtYJT4uG6gsEtW/0=;
  b=Npx7Ky7Fb/sCATN7vrkTiWjxIiGflN4jxyinzaaKKLH/hHVH/S/fkvqZ
   kRhAEUL8CH+QBAHB2s/rWoiagIzJcqpnclIMqSfZs3NLoO940y48Z/1c6
   7H/A7D86okzGoTBkFBV/E+gAy9ZSM4j4Y3Znl1dU5fjznJ2psX2gkYfaT
   5im1nVbKjX5GXv4P7tmUAwOF3wwjGWOX0KX7oPxWLsGJF7ZTi6hD02AZ4
   a4S3uXjKFRnb3gSzUV8HuzXykwrTyludFsA1qNhMKuXEloy4gRSpQNukE
   YYF/6PoMJqXiaPiOXEwB8g+ogxPATfjJANS8sb7BrITNMFmFPGM2PfAxy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2530010"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="2530010"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 23:21:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="5017442"
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
Subject: [RFC PATCH v1 3/5] perf stat: Add retire latency values into the expr_parse_ctx to prepare for final metric calculation
Date: Wed, 21 Feb 2024 02:20:57 -0500
Message-ID: <20240221072100.412939-4-weilin.wang@intel.com>
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

Retire latency values of events are used in metric formulas. This update adds
code to process data from perf record for required retire latency values.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/builtin-stat.c     |  1 +
 tools/perf/util/metricgroup.h |  1 +
 tools/perf/util/stat-shadow.c | 18 ++++++++++++++++++
 3 files changed, 20 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index e03665af9da2..948caab9ea91 100644
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
index 1c5c3eeba4cf..262a6960b461 100644
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
 static int prepare_metric(struct evsel **metric_events,
 			  struct metric_ref *metric_refs,
 			  struct expr_parse_ctx *pctx,
@@ -467,6 +480,11 @@ static void generic_metric(struct perf_stat_config *config,
 		pctx->sctx.user_requested_cpu_list = strdup(config->user_requested_cpu_list);
 	pctx->sctx.runtime = runtime;
 	pctx->sctx.system_wide = config->system_wide;
+	i = prepare_retire_lat(pctx, &config->tpebs_results);
+	if (i < 0) {
+		expr__ctx_free(pctx);
+		return;
+	}
 	i = prepare_metric(metric_events, metric_refs, pctx, aggr_idx);
 	if (i < 0) {
 		expr__ctx_free(pctx);
-- 
2.43.0


