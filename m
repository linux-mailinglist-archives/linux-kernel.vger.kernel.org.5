Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD11880FAF7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 00:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235265AbjLLXEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 18:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377958AbjLLXDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 18:03:44 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3752D101;
        Tue, 12 Dec 2023 15:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702422213; x=1733958213;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qnCrj0BETPuHi8W8gnPanU69Q8x6K39Z1fpI00xOF3g=;
  b=HnWGJ+eLjBl8B9j2kU0+hIeTqpEybKIlMrhta1gLTv427Lb6Pu7EHE9m
   SZ17o1jlzL9wfrDNrZaGOrgqn172xEtkBKTil13ZBmhvc+5LkViZzRsJ0
   FTyPHDVXPI6Godj/MHrvpLu6GY5I7a94M8I9cd4v8ph3plPydLh1N6aT0
   iK5Sm+nYZW286d44j1elYcNVeB/cBfHNy0j57zOlEk76Fxir1zqrYCGZj
   Xq+KCp4iR8+LyDaJIynmHSPaln1ijpAQLdY3Q9Can4F5kb72eVzdmVNdU
   /z3CLkkySOYHFc8C/FtLAChYELeV/Qnua01xN0OWrTImeBlHLWqvdbLP+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="392055993"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="392055993"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 15:02:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="864392020"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="864392020"
Received: from node-10329.jf.intel.com ([10.54.34.22])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Dec 2023 15:02:54 -0800
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
Subject: [RFC PATCH v3 11/18] perf stat: Add function to handle special events in hardware-grouping
Date:   Tue, 12 Dec 2023 15:02:17 -0800
Message-Id: <20231212230224.1473300-13-weilin.wang@intel.com>
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

There are some special events like topdown events and TSC that are not
decribed in pmu-event JSON files. Add support to handle this type of
events. This should be considered as a temporary solution because including
these events in JSON files would be a better solution.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/util/metricgroup.c | 25 +++++++++++++++++++++++--
 tools/perf/util/metricgroup.h | 15 +++++++++++++++
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 5d9ed22963be..03383f820e06 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -2023,6 +2023,15 @@ static int create_grouping(struct list_head *pmu_info_list,
 	return ret;
 };
 
+static bool is_special_event(const char *id)
+{
+	for (int i = 0; i < SPECIAL_EVENT_MAX; i++) {
+		if (!strncmp(id, special_event_names[i], strlen(special_event_names[i])))
+			return true;
+	}
+	return false;
+}
+
 /**
  * hw_aware_build_grouping - Build event groupings by reading counter
  * requirement of the events and counter available on the system from
@@ -2047,7 +2056,17 @@ static int hw_aware_build_grouping(struct expr_parse_ctx *ctx __maybe_unused,
 	hashmap__for_each_entry(ctx->ids, cur, bkt) {
 		const char *id = cur->pkey;
 
-		pr_debug("found event %s\n", id);
+		if (is_special_event(id)) {
+			struct metricgroup__event_info *event;
+
+			event = event_info__new(id, "default_core", "0",
+						/*free_counter=*/true);
+			if (!event)
+				goto err_out;
+
+			list_add(&event->nd, &event_info_list);
+			continue;
+		}
 		ret = get_metricgroup_events(id, etable, &event_info_list);
 		if (ret)
 			goto err_out;
@@ -2519,8 +2538,10 @@ int metricgroup__parse_groups(struct evlist *perf_evlist,
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
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index 51596e4b4341..37fdf8c5ba77 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -79,6 +79,21 @@ struct metric_expr {
 #define TRANSFER_FIRST_BYTE(pos) (7 - pos)
 #define TRANSFER_SEC_BYTE(pos) (23 - pos)
 
+/* Special events that are not described in pmu-event JSON files.
+ * topdown-* and TSC use dedicated registers, set as free
+ * counter for grouping purpose
+ */
+enum special_events {
+	TOPDOWN	= 0,
+	TSC	= 1,
+	SPECIAL_EVENT_MAX,
+};
+
+static const char *const special_event_names[SPECIAL_EVENT_MAX] = {
+	"topdown-",
+	"TSC",
+};
+
 /**
  * An event used in a metric. This info is for metric grouping.
  */
-- 
2.39.3

