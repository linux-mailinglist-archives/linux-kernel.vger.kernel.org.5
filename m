Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F02D7AD00D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 08:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbjIYGVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 02:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbjIYGUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 02:20:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE6B10B;
        Sun, 24 Sep 2023 23:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695622806; x=1727158806;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=muM7uZMr//PCO+KA31xv1iKaa858JTpwH1cfwEAPiCk=;
  b=myA9M9qgT0WJBsYnhbnF7BUne/embUOsnXniwvC7JcSUrNwdipL87QGZ
   /2C6nfYvMMkiJhuzlFeOdBjdE3mDTKK3QEhsD98qYFNGga+kt3Djdstos
   nJ2QTfwLUwaQCTH2+by/cmGX5M0gN/t3SICKS0wUu5rYOxaEgQ8CkATpl
   nuG0XbODIrv72e8ZRoiWNVST7zjGiIEQgU34bnGlB2FtsuFM4MFIwq96u
   Q4xxTdRA0B79VLY8PhD7eGyoUoXVjCoKkdEGVMCmiGYV+uYc8k48qdHtX
   evqYU/QvD0NPQplUq6GQilCA89AIbxl0CEJG//zFXUzvXeoWyVxE2MSF1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="445279540"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="445279540"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2023 23:19:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="818494410"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="818494410"
Received: from b49691a75598.jf.intel.com ([10.54.34.22])
  by fmsmga004.fm.intel.com with ESMTP; 24 Sep 2023 23:19:22 -0700
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
Subject: [RFC PATCH 19/25] perf stat: Handle grouping method fall back in hardware-grouping
Date:   Sun, 24 Sep 2023 23:18:18 -0700
Message-Id: <20230925061824.3818631-20-weilin.wang@intel.com>
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

Add fall back to normal grouping when hardware aware grouping return with
err so that perf stat still executes and returns with correct result.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/util/metricgroup.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 1086da84c..c027c0351 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -2054,7 +2054,7 @@ static int create_grouping(struct list_head *pmu_info_list,
 	LIST_HEAD(groups);
 	char *bit_buf = malloc(NR_COUNTERS);
 
-	//TODO: for each new core group, we should consider to add events that uses fixed counters
+	//TODO: for each new core group, we could consider to add events that uses fixed counters
 	list_for_each_entry(e, event_info_list, nd) {
 		bitmap_scnprintf(e->counters, NR_COUNTERS, bit_buf, NR_COUNTERS);
 		pr_debug("Event name %s, [pmu]=%s, [counters]=%s, [taken_alone]=%d\n",
@@ -2573,13 +2573,15 @@ int metricgroup__parse_groups(struct evlist *perf_evlist,
 	if (!table)
 		return -EINVAL;
 	if (hardware_aware_grouping) {
+		int ret;
 		pr_debug("Use hardware aware grouping instead of traditional metric grouping method\n");
-		return hw_aware_parse_groups(perf_evlist, pmu, str,
+		ret = hw_aware_parse_groups(perf_evlist, pmu, str,
 			    metric_no_threshold, user_requested_cpu_list, system_wide,
 			    /*fake_pmu=*/NULL, metric_events, table);
+		if (!ret)
+			return 0;
 	}
 
-
 	return parse_groups(perf_evlist, pmu, str, metric_no_group, metric_no_merge,
 			    metric_no_threshold, user_requested_cpu_list, system_wide,
 			    /*fake_pmu=*/NULL, metric_events, table);
-- 
2.39.3

