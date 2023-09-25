Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5AAC7ACFF0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 08:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbjIYGTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 02:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbjIYGTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 02:19:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D13CE;
        Sun, 24 Sep 2023 23:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695622750; x=1727158750;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7XqP6SyggdnemV9DhcZdlkFXAm0Nusd1RKnygUt9iRQ=;
  b=TeMs5/vA93UvAuFgto94bpKUDVE9w+BrGPMObrJWiHxwEEntC4d5VB+v
   z9gL9VhkvZU/9+qBCkFD0j+mFt/o8P//XuXhSmHf/vwF5/FFEpSSqHxkb
   jeP93O9aNM8OMgpXBt8LCItHZ1N5gfWN9SGf+GtdhWWyu0XMG9XhH9pod
   9VNGjuQK2jocudjktMfpJb6QnJQ6jU+5xuhfo4ynTCTz2K7cjGENr0UdH
   U+jX+Ei0q+vubqJu+e8V4dG4si7XQBteqgrxjg2DkC4DCvertY1hgpJts
   EJQLS62eZkGBEXt1cEHpocJFZnlkFnW58GN5UwN/TiXWM942R0Y0fUQez
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="445279373"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="445279373"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2023 23:19:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="818494309"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="818494309"
Received: from b49691a75598.jf.intel.com ([10.54.34.22])
  by fmsmga004.fm.intel.com with ESMTP; 24 Sep 2023 23:19:08 -0700
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
Subject: [RFC PATCH 01/25] perf stat: Add hardware-grouping cmd option to perf stat
Date:   Sun, 24 Sep 2023 23:18:00 -0700
Message-Id: <20230925061824.3818631-2-weilin.wang@intel.com>
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

Hardware counter and event information could be used to help creating event
groups that better utilize hardware counters and improve multiplexing.

Add a cmd option to allow user to choose this new metric grouping method.

$ perf stat -M TopdownL1 -a --hardware-grouping

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/builtin-stat.c     | 7 +++++++
 tools/perf/util/metricgroup.c | 5 +++++
 tools/perf/util/metricgroup.h | 1 +
 tools/perf/util/stat.h        | 1 +
 4 files changed, 14 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 07b48f6df..1a7dbfff5 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1256,6 +1256,8 @@ static struct option stat_options[] = {
 		       "don't try to share events between metrics in a group"),
 	OPT_BOOLEAN(0, "metric-no-threshold", &stat_config.metric_no_threshold,
 		       "don't try to share events between metrics in a group  "),
+	OPT_BOOLEAN(0, "hardware-grouping", &stat_config.hardware_aware_grouping,
+		   "Use hardware aware metric grouping method"),
 	OPT_BOOLEAN(0, "topdown", &topdown_run,
 			"measure top-down statistics"),
 	OPT_UINTEGER(0, "td-level", &stat_config.topdown_level,
@@ -2061,6 +2063,7 @@ static int add_default_attributes(void)
 						stat_config.metric_no_threshold,
 						stat_config.user_requested_cpu_list,
 						stat_config.system_wide,
+						stat_config.hardware_aware_grouping,
 						&stat_config.metric_events);
 	}
 
@@ -2094,6 +2097,7 @@ static int add_default_attributes(void)
 						stat_config.metric_no_threshold,
 						stat_config.user_requested_cpu_list,
 						stat_config.system_wide,
+						stat_config.hardware_aware_grouping,
 						&stat_config.metric_events);
 	}
 
@@ -2128,6 +2132,7 @@ static int add_default_attributes(void)
 						/*metric_no_threshold=*/true,
 						stat_config.user_requested_cpu_list,
 						stat_config.system_wide,
+						stat_config.hardware_aware_grouping,
 						&stat_config.metric_events) < 0)
 			return -1;
 	}
@@ -2169,6 +2174,7 @@ static int add_default_attributes(void)
 							/*metric_no_threshold=*/true,
 							stat_config.user_requested_cpu_list,
 							stat_config.system_wide,
+							stat_config.hardware_aware_grouping,
 							&stat_config.metric_events) < 0)
 				return -1;
 
@@ -2702,6 +2708,7 @@ int cmd_stat(int argc, const char **argv)
 					stat_config.metric_no_threshold,
 					stat_config.user_requested_cpu_list,
 					stat_config.system_wide,
+					stat_config.hardware_aware_grouping,
 					&stat_config.metric_events);
 		zfree(&metrics);
 	}
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 6231044a4..b08af6860 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1690,12 +1690,17 @@ int metricgroup__parse_groups(struct evlist *perf_evlist,
 			      bool metric_no_threshold,
 			      const char *user_requested_cpu_list,
 			      bool system_wide,
+			      bool hardware_aware_grouping,
 			      struct rblist *metric_events)
 {
 	const struct pmu_metrics_table *table = pmu_metrics_table__find();
 
 	if (!table)
 		return -EINVAL;
+	if (hardware_aware_grouping) {
+		pr_debug("Use hardware aware grouping instead of traditional metric grouping method\n");
+	}
+
 
 	return parse_groups(perf_evlist, pmu, str, metric_no_group, metric_no_merge,
 			    metric_no_threshold, user_requested_cpu_list, system_wide,
diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
index d5325c6ec..779f6ede1 100644
--- a/tools/perf/util/metricgroup.h
+++ b/tools/perf/util/metricgroup.h
@@ -77,6 +77,7 @@ int metricgroup__parse_groups(struct evlist *perf_evlist,
 			      bool metric_no_threshold,
 			      const char *user_requested_cpu_list,
 			      bool system_wide,
+			      bool hardware_aware_grouping,
 			      struct rblist *metric_events);
 int metricgroup__parse_groups_test(struct evlist *evlist,
 				   const struct pmu_metrics_table *table,
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 325d0fad1..f97d6282b 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -87,6 +87,7 @@ struct perf_stat_config {
 	bool			 metric_no_group;
 	bool			 metric_no_merge;
 	bool			 metric_no_threshold;
+	bool			 hardware_aware_grouping;
 	bool			 stop_read_counter;
 	bool			 iostat_run;
 	char			 *user_requested_cpu_list;
-- 
2.39.3

