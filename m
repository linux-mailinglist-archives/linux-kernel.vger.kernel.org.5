Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA747C9233
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 03:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbjJNBxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 21:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbjJNBxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 21:53:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E678511D;
        Fri, 13 Oct 2023 18:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697248373; x=1728784373;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hGzeLeDXJBlYc55eMx1ZtOX5cNrHpYcS8zLTIIs6dJE=;
  b=eM6J6+2ZAH4DhK9P/+/QRCWrDk3ylt4AxtI0MsF2gfNwZl6WVRt4y+oD
   iMNjj6BQ00yvOZEkTH15+CS5WjlxSln9kXJIx8EJlHda7wxzBNkswfuNg
   HKgTNp8o62S/947C6AKGE5UJnwafsD9+gydKo3nnSU4NM6JD2i6Bp9y/E
   6In5E0N7JPHpu5s/9IZzjFV1yDqKy4w7/7PFszgc1rkO36kPdtnchBrvT
   zxogBaKn8SCpnsiB9JDVIEKhJxxh7NKvj8rgtPwyELkBA7LX5wRXLOZZh
   1YIwi8GFv0hQdJSesfknA86kTsADVlh52922av/SQ5xaYa2UoS2fJNY4l
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="389154750"
X-IronPort-AV: E=Sophos;i="6.03,223,1694761200"; 
   d="scan'208";a="389154750"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 18:52:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="731565693"
X-IronPort-AV: E=Sophos;i="6.03,223,1694761200"; 
   d="scan'208";a="731565693"
Received: from b49691a75598.jf.intel.com ([10.54.34.22])
  by orsmga006.jf.intel.com with ESMTP; 13 Oct 2023 18:52:20 -0700
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
Subject: [RFC PATCH v2 12/17] perf stat: Add function to combine metrics for hardware-grouping
Date:   Fri, 13 Oct 2023 18:51:57 -0700
Message-Id: <20231014015202.1175377-13-weilin.wang@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231014015202.1175377-1-weilin.wang@intel.com>
References: <20231014015202.1175377-1-weilin.wang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
index fd92e9283..9211e8c09 100644
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

