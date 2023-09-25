Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9D17AD005
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 08:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbjIYGUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 02:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbjIYGUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 02:20:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADB3CE3;
        Sun, 24 Sep 2023 23:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695622800; x=1727158800;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0xC131Oh4Qjyne36ypPcfEUbG1xnpBZEfzwnpQGq7AA=;
  b=Tj3v2jMD3fRtZczBhmfruDyWgdX7U+Kfv3y4xW3gFRD4KjYojbwG5IAp
   Wr41PS0djQbwigKiJVeGl8AnclkF6zbV13qNRq7wMtft+/eZf6gHFt2gm
   MC5p71jeOcPqcA9Y1l2um0fd9+Hm1Ixda9c0yO5W8B6T17pgQszbvPtcY
   cpXWj8D9yc7xdXVEHoDcNZbJHyTG0AdOwZ1JFYt0JkPDRPnMNz+MD3PyR
   kJyAPdnywulzPJJxC6bl1+thfVwuB3F8KLD9IMfRaV1yPo7Gb6VTb3Stt
   E82DnBsvuH0xFav8vykZ7NaIUFaniuRhTZz2i0o3P8fvEeSCRjyqSwA1r
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="445279488"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="445279488"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2023 23:19:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="818494387"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="818494387"
Received: from b49691a75598.jf.intel.com ([10.54.34.22])
  by fmsmga004.fm.intel.com with ESMTP; 24 Sep 2023 23:19:19 -0700
From:   weilin.wang@intel.com
To:     weilin.wang@intel.com, Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [RFC PATCH 15/25] perf stat: Add function to combine metrics for hardware-grouping
Date:   Sun, 24 Sep 2023 23:18:14 -0700
Message-Id: <20230925061824.3818631-16-weilin.wang@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230925061824.3818631-1-weilin.wang@intel.com>
References: <20230925061824.3818631-1-weilin.wang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weilin Wang <weilin.wang@intel.com>

This function is very similar to the existing build_combined_expr_ctx(). Should
be able to reuse current function instead of adding a new one. Will fix this
later.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/util/metricgroup.c | 49 ++++++++++++++++++++++++++++++++---
 1 file changed, 45 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 797f831e1..2e7a8e315 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1432,9 +1432,49 @@ static int build_combined_expr_ctx(const struct list_head *metric_list,
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
  * set_counter_bitmap - The counter bit mapping: [8-15,0-7], e.g. the GP0 is the
- * 8th bit and GP7 is the 1st bit in this 16-bits bitmap. The is helpful to
+ * 8th bit and GP7 is the 1st bit in this 16-bits bitmap.  The is helpful to
  * assign GP4-7 before GP0-3 because some events can be collected using GP0-3
  * only on some platforms.
  */
@@ -1721,8 +1761,7 @@ static int metricgroup__add_pmu_layout_callback(const struct pmu_layout *pl,
  * @table: pmu_layouts table that is searched for counter info.
  */
 static int get_pmu_counter_layouts(struct list_head *pmu_info_list,
-				   const struct pmu_layouts_table
-				   *table)
+				   const struct pmu_layouts_table *table)
 {
 	LIST_HEAD(list);
 	int ret;
@@ -2142,6 +2181,8 @@ static int hw_aware_parse_ids(struct perf_pmu *fake_pmu,
 	*out_evlist = parsed_evlist;
 	parsed_evlist = NULL;
 err_out:
+	parse_events_error__exit(&parse_error);
+	evlist__delete(parsed_evlist);
 	metricgroup__free_grouping_strs(&groupings);
 	return ret;
 }
@@ -2264,7 +2305,7 @@ static int hw_aware_parse_groups(struct evlist *perf_evlist,
 	if (!metric_no_merge) {
 		struct expr_parse_ctx *combined = NULL;
 
-		ret = build_combined_expr_ctx(&metric_list, &combined);
+		ret = hw_aware_build_combined_expr_ctx(&metric_list, &combined);
 
 		if (!ret && combined && hashmap__size(combined->ids)) {
 			ret = hw_aware_parse_ids(fake_pmu, combined,
-- 
2.39.3

