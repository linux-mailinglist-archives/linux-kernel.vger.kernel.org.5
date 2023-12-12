Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE7180FAF9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 00:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378007AbjLLXE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 18:04:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378009AbjLLXEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 18:04:07 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980B7183;
        Tue, 12 Dec 2023 15:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702422230; x=1733958230;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HOyOzk0+wNdz1WzmnRxxfaKj7IPbOKpt9kNKcGEtJHc=;
  b=avP/fPAOdtWmbyQphOliWqClgISSQNywF65CTl3Xc23t/M8aijuuv0JM
   D1MhcQ/CP0UQSxeFUq5K2wwBff2R/FMGjtro6S8SjoKRTVA6jwLXTLuyb
   c2f910jh+o7MiAtNDR1q0WqVYkL/25oUrUpw9uJspjXgH9y8uInKOHLuz
   kBYBgXdWSBCX4gxTfzMrrVsciENVedqK6FJrEHGInYVl7rSfRnqh11rz9
   tM+0kOf+Dr9xwSCf4tmotniuyyQCq/4kzU5GDoyYEJQ8/Uko/pQ397Hjq
   QeND1oTZAKST7+SkLuc3wJ9mxt3Qhc2ybf7quWt19e41yHWkNcCYTED2p
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="392056003"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="392056003"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 15:02:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="864392024"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="864392024"
Received: from node-10329.jf.intel.com ([10.54.34.22])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Dec 2023 15:02:55 -0800
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
        Mark Rutland <mark.rutland@arm.com>,
        Yang Jihong <yangjihong1@huawei.com>
Subject: [RFC PATCH v3 12/18] perf stat: Add function to combine metrics for hardware-grouping
Date:   Tue, 12 Dec 2023 15:02:18 -0800
Message-Id: <20231212230224.1473300-14-weilin.wang@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231212230224.1473300-1-weilin.wang@intel.com>
References: <20231212230224.1473300-1-weilin.wang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weilin Wang <weilin.wang@intel.com>

This function is very similar to the existing build_combined_expr_ctx().
Should be able to reuse current function instead of adding a new one. Will
fix this later.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/util/metricgroup.c | 51 +++++++++++++++++++++++++++++++----
 1 file changed, 46 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 03383f820e06..016ea949ba5d 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1432,10 +1432,50 @@ static int build_combined_expr_ctx(const struct list_head *metric_list,
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
- * 8th bit and GP7 is the 1st bit in this 16-bits bitmap. It is helpful for
- * assigning GP4-7 before GP0-3 because some events can be collected using GP0-3
+ * 8th bit and GP7 is the 1st bit in this 16-bits bitmap.  The is helpful to
+ * assign GP4-7 before GP0-3 because some events can be collected using GP0-3
  * only on some platforms.
  */
 static int set_counter_bitmap(int pos, unsigned long *bitmap)
@@ -1722,8 +1762,7 @@ static int metricgroup__add_pmu_layout_callback(const struct pmu_layout *pl,
  * @table: pmu_layouts table that is searched for counter info.
  */
 static int get_pmu_counter_layouts(struct list_head *pmu_info_list,
-				   const struct pmu_layouts_table
-				   *table)
+				   const struct pmu_layouts_table *table)
 {
 	LIST_HEAD(list);
 	int ret;
@@ -2155,6 +2194,8 @@ static int hw_aware_parse_ids(struct perf_pmu *fake_pmu,
 	*out_evlist = parsed_evlist;
 	parsed_evlist = NULL;
 err_out:
+	parse_events_error__exit(&parse_error);
+	evlist__delete(parsed_evlist);
 	metricgroup__free_grouping_strs(&groupings);
 	return ret;
 }
@@ -2277,7 +2318,7 @@ static int hw_aware_parse_groups(struct evlist *perf_evlist,
 	if (!metric_no_merge) {
 		struct expr_parse_ctx *combined = NULL;
 
-		ret = build_combined_expr_ctx(&metric_list, &combined);
+		ret = hw_aware_build_combined_expr_ctx(&metric_list, &combined);
 
 		if (!ret && combined && hashmap__size(combined->ids)) {
 			ret = hw_aware_parse_ids(fake_pmu, combined,
-- 
2.39.3

