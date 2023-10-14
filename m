Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086AC7C9229
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 03:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbjJNBw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 21:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbjJNBwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 21:52:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16797C2;
        Fri, 13 Oct 2023 18:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697248339; x=1728784339;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7XqP6SyggdnemV9DhcZdlkFXAm0Nusd1RKnygUt9iRQ=;
  b=EluK0MZ++iay80xRTm81wo+yi1WJkpSVwbrFNw81tDT/XPbdqBR8pOAV
   kx8L1c1Q6ErEtFem3594iKlTytGC/oUFr6Uk5lphbpnaq/aGae5SfsgpZ
   ksS3/VwC5AIAnV3hADrLcqKGdz/leEISyCjOQe5mjt7KJKiCbWjDy5qPq
   weoXqIVWZVl56NnPJT/P00dyOt7KchZlDIS0lvrnsCUjJ1JMgO+wZNnkD
   Q+3CxIg4BXev1JV1V5KyZ+RpokVaFYJN7s3iOs3OTwol/OL4JIPijGixw
   TDBUEWPlEjtZAfp0P6O3BJwGhSa3s7WxOpID13XHI28ZNuG9a9n8llSVD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="389154670"
X-IronPort-AV: E=Sophos;i="6.03,223,1694761200"; 
   d="scan'208";a="389154670"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 18:52:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="731565654"
X-IronPort-AV: E=Sophos;i="6.03,223,1694761200"; 
   d="scan'208";a="731565654"
Received: from b49691a75598.jf.intel.com ([10.54.34.22])
  by orsmga006.jf.intel.com with ESMTP; 13 Oct 2023 18:52:15 -0700
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
Subject: [RFC PATCH v2 01/17] perf stat: Add hardware-grouping cmd option to perf stat
Date:   Fri, 13 Oct 2023 18:51:46 -0700
Message-Id: <20231014015202.1175377-2-weilin.wang@intel.com>
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

