Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9427AD009
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 08:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbjIYGV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 02:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbjIYGUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 02:20:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68C1127;
        Sun, 24 Sep 2023 23:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695622809; x=1727158809;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HSVcQCsEs+cq3MBrBOv3aGr6miQQ/ewQSBJV5aYalwQ=;
  b=ZzjRSLNJ1ASt9wua36TSSqWCAjeC6lgtJwpN9WkEoL+AzrD845MrmfgF
   voIs/YdGDkgOQ+8dCaimdJsg8xk51jbejMVZD3C3dnOs5TP1NmPHpFcuY
   +43LxUPBFpe77VjClLZ0lA2+/xGGx4IezvqCDbBj0iAxBszkUncAeunTR
   cHMDNTw1n5nmPp6pfpSSAPDWmrZTIEaT7kDFg87cfPfzB84gQh6Hnc1NE
   J3035i5iprbLRRjp+kpGcqa0DvmsV0bEUS8rMIS/8Mb8SXghSNCgRNsNc
   378f3jva6gkcvlz6o74ZD0PP0YotGnicXpWDX50FasqgJvwBlBH836tjG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="445279560"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="445279560"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2023 23:19:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="818494435"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="818494435"
Received: from b49691a75598.jf.intel.com ([10.54.34.22])
  by fmsmga004.fm.intel.com with ESMTP; 24 Sep 2023 23:19:24 -0700
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
Subject: [RFC PATCH 22/25] perf stat: Add TSC support in hardware-grouping
Date:   Sun, 24 Sep 2023 23:18:21 -0700
Message-Id: <20230925061824.3818631-23-weilin.wang@intel.com>
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

Add TSC check and create new event for it the same way as how we handle
topdown-* for now since it is not listed in an event json file either. Need
TSC to support TopdownL4-L5.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/util/metricgroup.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index d10f6afb0..07a82fa21 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -321,6 +321,14 @@ static int setup_metric_events(const char *pmu, struct hashmap *ids,
 		}
 	}
 	if (matched_events < ids_size) {
+		struct hashmap_entry *cur;
+		size_t bkt;
+
+		hashmap__for_each_entry(ids, cur, bkt) {
+			const char *id = cur->pkey;
+
+			pr_debug("Need event %s\n", id);
+		}
 		free(metric_events);
 		return -EINVAL;
 	}
@@ -2106,11 +2114,16 @@ static int hw_aware_build_grouping(struct expr_parse_ctx *ctx,
 #define RETURN_IF_NON_ZERO(x) do { if (x) return x; } while (0)
 	hashmap__for_each_entry(ctx->ids, cur, bkt) {
 		const char *id = cur->pkey;
-		const char *special_pattern = "topdown-";
+		const char *pattern1 = "topdown-";
+		const char *pattern2 = "TSC";
 
 		pr_debug("found event %s\n", id);
-		if (!strncmp(id, special_pattern, strlen(special_pattern))) {
+		if (!strncmp(id, pattern1, strlen(pattern1)) ||
+		    !strncmp(id, pattern2, strlen(pattern2))) {
 			struct metricgroup__event_info *event;
+			/* topdown-* and TSC use dedicated registers, set as free
+			 * counter here for grouping
+			 */
 			event = event_info__new(id, "default_core", "0", false,
 						/*free_counter=*/true);
 			if (!event) {
@@ -2602,8 +2615,10 @@ int metricgroup__parse_groups(struct evlist *perf_evlist,
 		ret = hw_aware_parse_groups(perf_evlist, pmu, str,
 			    metric_no_threshold, user_requested_cpu_list, system_wide,
 			    /*fake_pmu=*/NULL, metric_events, table);
-		if (!ret)
+		if (!ret) {
+			pr_info("Hardware aware grouping completed\n");
 			return 0;
+		}
 	}
 
 	return parse_groups(perf_evlist, pmu, str, metric_no_group, metric_no_merge,
-- 
2.39.3

