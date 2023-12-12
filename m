Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F80580FAEB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 00:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377934AbjLLXCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 18:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbjLLXCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 18:02:36 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0315EAA;
        Tue, 12 Dec 2023 15:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702422163; x=1733958163;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Mg+P2jY7Sr7zhOxLFP+JV08Ptf4BsGSYsE7b4VU9GGU=;
  b=hQmXu4sycG4/DtD6XGocoKYTLbgzwR/UcrC70LG3QKF6miBwon9K+iBY
   2ZHWyYB6/PwOaDMfSnkVmm10+zPekQn83lTxKBCdkwesUeeWWpSm/Rugf
   xUqtpr9lsDjV5hriGXwjLwnAspaND5KUCb8guKDiuyxknP25JYbCjEAYy
   kvs3ucI6vxrGbm2sdnWb8LHBI2HD+P7/azBBJh/HAnE5RV/SygLl1lhqf
   YTq/2y/fQU9O+mYCFdRTskpCbkvOz8XiF8OFh/aWkb949U4O2oz1JyL7L
   lMxAaPVt7GdWJwVf66FxNc9Wbwehsjolr6VScLPDSCgIZ+ukPtV4kBTXG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="392055871"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="392055871"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 15:02:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="864391944"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="864391944"
Received: from node-10329.jf.intel.com ([10.54.34.22])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Dec 2023 15:02:41 -0800
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
Subject: [RFC PATCH v3 01/18] perf stat: Add new field in stat_config to enable hardware aware grouping.
Date:   Tue, 12 Dec 2023 15:02:06 -0800
Message-Id: <20231212230224.1473300-2-weilin.wang@intel.com>
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

Hardware counter and event information could be used to help creating event
groups that better utilize hardware counters and improve multiplexing.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/builtin-stat.c     | 8 ++++++++
 tools/perf/util/metricgroup.c | 5 +++++
 tools/perf/util/metricgroup.h | 1 +
 tools/perf/util/stat.h        | 1 +
 4 files changed, 15 insertions(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index d8e5d6f7a87a..a7a8018c3511 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2061,6 +2061,7 @@ static int add_default_attributes(void)
 						stat_config.metric_no_threshold,
 						stat_config.user_requested_cpu_list,
 						stat_config.system_wide,
+						stat_config.hardware_aware_grouping,
 						&stat_config.metric_events);
 	}
 
@@ -2094,6 +2095,7 @@ static int add_default_attributes(void)
 						stat_config.metric_no_threshold,
 						stat_config.user_requested_cpu_list,
 						stat_config.system_wide,
+						stat_config.hardware_aware_grouping,
 						&stat_config.metric_events);
 	}
 
@@ -2128,6 +2130,7 @@ static int add_default_attributes(void)
 						/*metric_no_threshold=*/true,
 						stat_config.user_requested_cpu_list,
 						stat_config.system_wide,
+						stat_config.hardware_aware_grouping,
 						&stat_config.metric_events) < 0)
 			return -1;
 	}
@@ -2169,6 +2172,7 @@ static int add_default_attributes(void)
 							/*metric_no_threshold=*/true,
 							stat_config.user_requested_cpu_list,
 							stat_config.system_wide,
+							stat_config.hardware_aware_grouping,
 							&stat_config.metric_events) < 0)
 				return -1;
 
@@ -2502,6 +2506,9 @@ int cmd_stat(int argc, const char **argv)
 					(const char **) stat_usage,
 					PARSE_OPT_STOP_AT_NON_OPTION);
 
+	/* Set hardware_aware_grouping to false on default before completely enable it.*/
+	stat_config.hardware_aware_grouping = false;
+
 	if (stat_config.csv_sep) {
 		stat_config.csv_output = true;
 		if (!strcmp(stat_config.csv_sep, "\\t"))
@@ -2702,6 +2709,7 @@ int cmd_stat(int argc, const char **argv)
 					stat_config.metric_no_threshold,
 					stat_config.user_requested_cpu_list,
 					stat_config.system_wide,
+					stat_config.hardware_aware_grouping,
 					&stat_config.metric_events);
 		zfree(&metrics);
 	}
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 0484736d9fe4..dfbcdb517b78 100644
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
index d5325c6ec8e1..779f6ede1b51 100644
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
index 325d0fad1842..f97d6282ba3d 100644
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

