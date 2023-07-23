Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852BD75E07D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 10:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjGWIWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 04:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjGWIWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 04:22:38 -0400
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5428C10EC;
        Sun, 23 Jul 2023 01:22:32 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0Vnzn8WJ_1690100545;
Received: from srmbuffer011165236051.sqa.net(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0Vnzn8WJ_1690100545)
          by smtp.aliyun-inc.com;
          Sun, 23 Jul 2023 16:22:26 +0800
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
To:     John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>
Subject: [PATCH v4 4/4] perf vendor events: Add metrics for Arm CMN
Date:   Sun, 23 Jul 2023 16:21:53 +0800
Message-Id: <1690100513-61165-5-git-send-email-renyu.zj@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1690100513-61165-1-git-send-email-renyu.zj@linux.alibaba.com>
References: <1690100513-61165-1-git-send-email-renyu.zj@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add JSON metrics for Arm CMN. Currently just add part of CMN PMU
metrics which are general and compatible for any SoC with CMN-ANY.

Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
---
 .../pmu-events/arch/arm64/arm/cmn/sys/metric.json  | 74 ++++++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cmn/sys/metric.json

diff --git a/tools/perf/pmu-events/arch/arm64/arm/cmn/sys/metric.json b/tools/perf/pmu-events/arch/arm64/arm/cmn/sys/metric.json
new file mode 100644
index 0000000..64db534
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cmn/sys/metric.json
@@ -0,0 +1,74 @@
+[
+	{
+		"MetricName": "slc_miss_rate",
+		"BriefDescription": "The system level cache miss rate.",
+		"MetricGroup": "cmn",
+		"MetricExpr": "hnf_cache_miss / hnf_slc_sf_cache_access",
+		"ScaleUnit": "100%",
+		"Unit": "arm_cmn",
+		"Compat": "434*;436*;43c*;43a*"
+	},
+	{
+		"MetricName": "hnf_message_retry_rate",
+		"BriefDescription": "HN-F message retry rate indicates whether a lack of credits is causing the bottlenecks.",
+		"MetricGroup": "cmn",
+		"MetricExpr": "hnf_pocq_retry / hnf_pocq_reqs_recvd",
+		"ScaleUnit": "100%",
+		"Unit": "arm_cmn",
+		"Compat": "434*;436*;43c*;43a*"
+	},
+	{
+		"MetricName": "sf_hit_rate",
+		"BriefDescription": "Snoop filter hit rate can be used to measure the snoop filter efficiency.",
+		"MetricGroup": "cmn",
+		"MetricExpr": "hnf_sf_hit / hnf_slc_sf_cache_access",
+		"ScaleUnit": "100%",
+		"Unit": "arm_cmn",
+		"Compat": "434*;436*;43c*;43a*"
+	},
+	{
+		"MetricName": "mc_message_retry_rate",
+		"BriefDescription": "The memory controller request retries rate indicates whether the memory controller is the bottleneck.",
+		"MetricGroup": "cmn",
+		"MetricExpr": "hnf_mc_retries / hnf_mc_reqs",
+		"ScaleUnit": "100%",
+		"Unit": "arm_cmn",
+		"Compat": "434*;436*;43c*;43a*"
+	},
+	{
+		"MetricName": "rni_actual_read_bandwidth.all",
+		"BriefDescription": "This event measure the actual bandwidth that RN-I bridge sends to the interconnect.",
+		"MetricGroup": "cmn",
+		"MetricExpr": "rnid_rxdat_flits * 32 / 1e6 / duration_time",
+		"ScaleUnit": "1MB/s",
+		"Unit": "arm_cmn",
+		"Compat": "434*;436*;43c*;43a*"
+	},
+	{
+		"MetricName": "rni_actual_write_bandwidth.all",
+		"BriefDescription": "This event measures the actual write bandwidth at RN-I bridges.",
+		"MetricGroup": "cmn",
+		"MetricExpr": "rnid_txdat_flits * 32 / 1e6 / duration_time",
+		"ScaleUnit": "1MB/s",
+		"Unit": "arm_cmn",
+		"Compat": "434*;436*;43c*;43a*"
+	},
+	{
+		"MetricName": "rni_retry_rate",
+		"BriefDescription": "RN-I bridge retry rate indicates whether the memory controller is the bottleneck.",
+		"MetricGroup": "cmn",
+		"MetricExpr": "rnid_txreq_flits_retried / rnid_txreq_flits_total",
+		"ScaleUnit": "100%",
+		"Unit": "arm_cmn",
+		"Compat": "434*;436*;43c*;43a*"
+	},
+	{
+		"MetricName": "sbsx_actual_write_bandwidth.all",
+		"BriefDescription": "sbsx actual write bandwidth.",
+		"MetricGroup": "cmn",
+		"MetricExpr": "sbsx_txdat_flitv * 32 / 1e6 / duration_time",
+		"ScaleUnit": "1MB/s",
+		"Unit": "arm_cmn",
+		"Compat": "434*;436*;43c*;43a*"
+	}
+]
-- 
1.8.3.1

