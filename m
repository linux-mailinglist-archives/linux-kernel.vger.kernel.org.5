Return-Path: <linux-kernel+bounces-58976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECD384EF55
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 04:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83BBCB21583
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 03:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60999210FA;
	Fri,  9 Feb 2024 03:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dIHfv6p6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C77A12E52;
	Fri,  9 Feb 2024 03:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707448496; cv=none; b=Gnk0PSvnW25q6CvsIbjvuURYKkWW07UCVaN0LKoqjbQ270IS80SKfNk2dsUX3hlH3SskwyS+z7/Ld1wCvTaiShE7UWarZnT4n4HNtj1k3bY3n1qwP6eZK2xs8xd3rjg+8UtE9N37+Pvuh9Wv3UaTyGRHHzvTylE5qxaQH4JD+vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707448496; c=relaxed/simple;
	bh=iGYgMhf+uN2QB4bkriW/0fEdhb3pg3tSD8oxatmuXLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lSuCsbV2w9avXM7bo6Pn6JDOuw1M6eY1yNYicrm+O+itbLQQZVQ2M4A9SGe4kizHsU6kQveuQQOEhGo0II1fsIL83EbcIN5rlkc7BEUab4pNb0OJfXNcXvTeUXYrBOfMmxoJT8QxzpozTDxNF3xxoERPkfPR333mFrg1Tb7/grE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dIHfv6p6; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707448495; x=1738984495;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iGYgMhf+uN2QB4bkriW/0fEdhb3pg3tSD8oxatmuXLQ=;
  b=dIHfv6p6e47SA/Yv1vmjZzsSp0HV3KJTK0NTy3LbvnFYIE91VbOKr7FK
   oK9iuEEAYC6CTC8GdBBwd9bdU0ISP9PITtn85m9PZfYYsE2CboYA39tir
   +urUoqx6zzQQbWUwD5QpkA4whS37zsrmziDXC+2CBEMoP8Usjign3j13X
   boR8OJf2ll2S0zQTIdrWErublOvHuJBRyXOhhETJHrG3ayRbLvcB5kHB3
   Rf+cPBfj1vqbjpFhf6gacqFxOstuCZcPMMIG83hlLi1Wdej42a43MYg7B
   SPNmMsH+w4iX+878wxgyj/pO8+s7XilYiL8OHq2QxIQyYY/2yD2mDR4aM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1257934"
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="1257934"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 19:14:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="32631443"
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
Subject: [RFC PATCH v4 10/15] perf stat: Add function to combine metrics for hardware-grouping
Date: Thu,  8 Feb 2024 19:14:36 -0800
Message-ID: <20240209031441.943012-11-weilin.wang@intel.com>
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

This function is very similar to the existing build_combined_expr_ctx().
Should be able to reuse current function instead of adding a new one. Will
fix this later.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/util/metricgroup.c | 47 ++++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index a0579b0f81e5..fe115f0880f9 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1525,6 +1525,46 @@ static int build_combined_expr_ctx(const struct list_head *metric_list,
 	return ret;
 }
 
+/**
+ * hw_aware_build_combined_expr_ctx - Make an expr_parse_ctx with all !group_events
+ *                           metric IDs, as the IDs are held in a set,
+ *                           duplicates will be removed.
+ * @metric_list: List to take metrics from.
+ * @combined: Out argument for result.
+ */
+static int hw_aware_build_combined_expr_ctx(const struct list_head *metric_list,
+				   struct expr_parse_ctx **combined)
+{
+	struct hashmap_entry *cur;
+	size_t bkt;
+	struct metric *m;
+	char *dup;
+	int ret;
+
+	*combined = expr__ctx_new();
+	if (!*combined)
+		return -ENOMEM;
+
+	list_for_each_entry(m, metric_list, nd) {
+		hashmap__for_each_entry(m->pctx->ids, cur, bkt) {
+			pr_debug2("metric: %s\n", m->metric_name);
+			dup = strdup(cur->pkey);
+			if (!dup) {
+				ret = -ENOMEM;
+				goto err_out;
+			}
+			ret = expr__add_id(*combined, dup);
+			if (ret)
+				goto err_out;
+		}
+	}
+	return 0;
+err_out:
+	expr__ctx_free(*combined);
+	*combined = NULL;
+	return ret;
+}
+
 /**
  * set_counter_bitmap - The counter bitmap: [0-15].
  */
@@ -1815,8 +1855,7 @@ static int metricgroup__add_pmu_layout_callback(const struct pmu_layout *pl,
  * @table: pmu_layouts table that is searched for counter info.
  */
 static int get_pmu_counter_layouts(struct list_head *pmu_info_list,
-				   const struct pmu_layouts_table
-				   *table)
+				   const struct pmu_layouts_table *table)
 {
 	LIST_HEAD(list);
 	int ret;
@@ -2248,6 +2287,8 @@ static int hw_aware_parse_ids(struct perf_pmu *fake_pmu,
 	*out_evlist = parsed_evlist;
 	parsed_evlist = NULL;
 err_out:
+	parse_events_error__exit(&parse_error);
+	evlist__delete(parsed_evlist);
 	metricgroup__free_grouping_strs(&groupings);
 	return ret;
 }
@@ -2370,7 +2411,7 @@ static int hw_aware_parse_groups(struct evlist *perf_evlist,
 	if (!metric_no_merge) {
 		struct expr_parse_ctx *combined = NULL;
 
-		ret = build_combined_expr_ctx(&metric_list, &combined);
+		ret = hw_aware_build_combined_expr_ctx(&metric_list, &combined);
 
 		if (!ret && combined && hashmap__size(combined->ids)) {
 			ret = hw_aware_parse_ids(fake_pmu, combined,
-- 
2.42.0


