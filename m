Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2367ACFFB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 08:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbjIYGUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 02:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbjIYGUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 02:20:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0007D120;
        Sun, 24 Sep 2023 23:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695622786; x=1727158786;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7e9wQj2WA71mq/iJI8NeRrmr4krAfSIj4xsh0x+V4bc=;
  b=GuXUXsnlh/nKXn41JfOYpeIf06g5NbF4OkMR9UHhiFJK5457eFDQQRAx
   S29NlTgTxoHZRFhtXg0KSt2cEnkFreKT5A6ocanv8B8NXkbhi2YhLYchy
   sV8j2JMPJintIZBRDpnTQgtx7KnJvGv8+b/beAT7rhdYau8xqeVVAC8wv
   F5ANs8OOuexnnTIQp7IMTHd3bQJRZCQcBZKoAH4CwpFd9sNL1NBw9r7+R
   QXJIgBA9bFHjDE36dEpZq5BVyXlaCUwrgDMpxMhTmfW8b42lNSXfcyPy/
   BOmLeoR/YSLwiRkPwbxj6IpZ1i2YiDtb+djJXvy1hofwv7rxIaxVm5/pz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="445279440"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="445279440"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2023 23:19:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="818494353"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="818494353"
Received: from b49691a75598.jf.intel.com ([10.54.34.22])
  by fmsmga004.fm.intel.com with ESMTP; 24 Sep 2023 23:19:15 -0700
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
Subject: [RFC PATCH 09/25] perf stat: Add helper functions for hardware-grouping method
Date:   Sun, 24 Sep 2023 23:18:08 -0700
Message-Id: <20230925061824.3818631-10-weilin.wang@intel.com>
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

Add functions to free pmu_info_list and event_info_list before exit
grouping

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/util/metricgroup.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index feb5dab26..0ca885a42 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1507,6 +1507,27 @@ static int parse_counter(const char *counter,
 	return 0;
 }
 
+static void metricgroup__free_event_info(struct list_head
+					*event_info_list)
+{
+	struct metricgroup__event_info *e, *tmp;
+
+	list_for_each_entry_safe(e, tmp, event_info_list, nd) {
+		list_del_init(&e->nd);
+		free(e);
+	}
+}
+
+static void metricgroup__free_pmu_info(struct list_head *pmu_info_list)
+{
+	struct metricgroup__pmu_counters *p, *tmp;
+
+	list_for_each_entry_safe(p, tmp, pmu_info_list, nd) {
+		list_del_init(&p->nd);
+		free(p);
+	}
+}
+
 static struct metricgroup__event_info *event_info__new(const char *name,
 						      const char *pmu_name,
 						      const char *counter,
@@ -1524,7 +1545,8 @@ static struct metricgroup__event_info *event_info__new(const char *name,
 	}
 	e->name = name;
 	e->free_counter = free_counter;
-	e->pmu_name = strdup(pmu_name);
+	//e->pmu_name = strdup(pmu_name);
+	e->pmu_name = pmu_name;
 	if (free_counter) {
 		ret = set_counter_bitmap(0, e->counters);
 		if (ret)
@@ -1687,13 +1709,15 @@ static int hw_aware_build_grouping(struct expr_parse_ctx *ctx __maybe_unused,
 
 		ret = get_metricgroup_events(id, etable, &event_info_list);
 		if (ret)
-			return ret;
+			goto err_out;
 	}
 	ret = get_pmu_counter_layouts(&pmu_info_list, ltable);
 	if (ret)
-		return ret;
-
+		goto err_out;
 
+err_out:
+	metricgroup__free_event_info(&event_info_list);
+	metricgroup__free_pmu_info(&pmu_info_list);
 	return ret;
 #undef RETURN_IF_NON_ZERO
 }
-- 
2.39.3

