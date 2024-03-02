Return-Path: <linux-kernel+bounces-89252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7680A86ED3E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 01:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EA091F22044
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 00:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983235680;
	Sat,  2 Mar 2024 00:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HgHB9W6q"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42207A48;
	Sat,  2 Mar 2024 00:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709338310; cv=none; b=MVoHzN0m3DsoHEvUm86QbvURSeRUgrduK9xwPVPS0GOyceDlWIhsjOP2uzejVePiEkcpBXVnyNfSIsa8RTxe08Ztaw8sG9NcIFfFqtyu6aMHafDaS2tgH79e47GHeDhd2mh6TCUioM9fitkZiQyusb0Wc1gAY+lZ4RCiPgxnpcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709338310; c=relaxed/simple;
	bh=6wo/+6fc+LTd+YM3oQ6kkcsi6l7BgZUng26rp9OSpk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c4lkNAaPw4tRTlsMBJX7OBa0irxv94GQr+0KINP1xXS/Aoo3/Mj3aA1CZp/lUluVJ0CulNZdUHWVcwJ0K3W2WG8WolSmAs7SlYrGCDVyboEnAqmnnffbq0ZYQYyhCUZAyW2aS+PVT23Oeq2w6e7BZFIv7APqZl5JUUaugMgiS+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HgHB9W6q; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709338309; x=1740874309;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6wo/+6fc+LTd+YM3oQ6kkcsi6l7BgZUng26rp9OSpk8=;
  b=HgHB9W6qxZSeo/ZNmUhChY2WRkRrAnH1Ew2+pUAyCf8rflLek/78sgoa
   aXZGnXaK7smj8K7xmnfTmlnTJXq4R/ii9r2PbfgqylslW1MOzD66zCsaY
   W2UuDSPBPrLsHO8miN9Egz1HVs3Ss0rIdIj8MXUCkxEfPqXsat15zZFK7
   6N/pwILUlBqHoGy+gCRYNac4mqJkUGQcpWp4wKXkkruOGxniNlMVwYHz4
   imQGIJZqA4wDXmdy+kRM+2ZZ6n8nuBJSaRRQpVwrtvoUZV+zp/N8+vh2C
   vc7rgHJIaE/M1cu/FEtuL+5FHQ7lyx5bWXBQt278OcKyM/DO9Fkb7rswn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="4476148"
X-IronPort-AV: E=Sophos;i="6.06,197,1705392000"; 
   d="scan'208";a="4476148"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 16:11:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,197,1705392000"; 
   d="scan'208";a="13054641"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by orviesa005.jf.intel.com with ESMTP; 01 Mar 2024 16:11:46 -0800
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
Subject: [RFC PATCH v3 3/6] perf stat: Add retire latency values into the expr_parse_ctx to prepare for final metric calculation
Date: Fri,  1 Mar 2024 19:11:35 -0500
Message-ID: <20240302001139.604829-4-weilin.wang@intel.com>
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


