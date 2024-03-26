Return-Path: <linux-kernel+bounces-119919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7B688CEF3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4842C3409F4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915CF13F014;
	Tue, 26 Mar 2024 20:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Im8aBC0n"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A04F13E89C;
	Tue, 26 Mar 2024 20:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711484976; cv=none; b=Hk95rFrRM7idDvtesY0s63pR0dmDvYrwfmwkId//kX8z9hdw4QchQNKbxAZVJQ2qb0Z08TBA5GYrz+6mfrD/exaKtKjmFdz+4Z/4FL0jIti9g8lZxRnRbVP84ZNs5pkz/yctxy+q7K1nlAkX33/VvE/q3TZ1Xp7P6kur37IWPOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711484976; c=relaxed/simple;
	bh=J13VmURiiNTORSB+guGyg+TlES2kTP6wTgLMxrN+wOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bg4yjpG28C5TgZrmOVpfZVClGfG2M8ZaICVigb9HTp4JBEh6qS/kx5GtAA4EWPf+Zj7aAIy9mHPBODAXrrKE6JRV+uXO4i9r+PKeOfuauYQzdPCMTR8t6hb4/QY5/8VsnFD/hPEhbMvxI7UkAh5zZKJhowWSGGmrbZrLsfyVIw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Im8aBC0n; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711484975; x=1743020975;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J13VmURiiNTORSB+guGyg+TlES2kTP6wTgLMxrN+wOg=;
  b=Im8aBC0ngIfjAimYYKjK8g2jK+ncaHXA2fJsxhgvsIA3WykdPSaSA+z+
   LmIgoJurRZKUuazF4kjGJmN3BTU2N0itmE+NMpRgXZbPAQFAvZXc+wkxd
   WXrGdR2GdsoZoInPkJo+JDUiNLLRPC+SpKd9//9TD897l5OUno/6H5FrH
   RWax95ckljyNZ3IdQqVSxLUTFb1XNbgU+PEl2isLpCBfHqq6QhS6b2iIk
   gYxuoByAAZ+hQ2hh8u5O/BzZBKn6h9upNaCHdfr+9kHa4bdnmmy1izbtv
   7j+AM2WeXm1QRLTq8awFQ9naBgjmTrrch5kbNB/2cI4SU9x4XcJX0Ltv4
   A==;
X-CSE-ConnectionGUID: 32pTqn67SaCwtu4kAtRbFQ==
X-CSE-MsgGUID: Riyi8/HjQk2WOGw+7Ld6lA==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="24049087"
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="24049087"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 13:29:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="16163010"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by fmviesa008.fm.intel.com with ESMTP; 26 Mar 2024 13:29:32 -0700
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
Subject: [RFC PATCH v5 3/6] perf stat: Add retire latency values into the expr_parse_ctx to prepare for final metric calculation
Date: Tue, 26 Mar 2024 16:28:56 -0400
Message-ID: <20240326202859.960577-4-weilin.wang@intel.com>
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
index fb08cef42d95..fc887d9aaa66 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -786,6 +786,7 @@ static int process_sample_event(struct perf_tool *tool __maybe_unused,
 		if (!strcmp(evname, t->event.name)) {
 			t->count += 1;
 			t->sum += sample->retire_lat;
+			t->val = (double) t->sum / t->count;
 			break;
 		}
 	}
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index e5bafb45d4d9..b073682b4067 100644
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


