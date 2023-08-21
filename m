Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5543782599
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 10:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234067AbjHUIgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 04:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbjHUIgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 04:36:39 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D59EC2;
        Mon, 21 Aug 2023 01:36:35 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VqEq8Dh_1692606991;
Received: from srmbuffer011165236051.sqa.net(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VqEq8Dh_1692606991)
          by smtp.aliyun-inc.com;
          Mon, 21 Aug 2023 16:36:32 +0800
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
To:     John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>
Cc:     Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>
Subject: [PATCH v7 6/8] perf test: Add pmu-event test for "Compat" and new event_field.
Date:   Mon, 21 Aug 2023 16:36:15 +0800
Message-Id: <1692606977-92009-7-git-send-email-renyu.zj@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1692606977-92009-1-git-send-email-renyu.zj@linux.alibaba.com>
References: <1692606977-92009-1-git-send-email-renyu.zj@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new event test for uncore system event which is used to verify the
functionality of "Compat" matching multiple identifiers and the new event
fields "EventIdCode" and "Type".

Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
---
 .../pmu-events/arch/test/test_soc/sys/uncore.json  |  8 ++++
 tools/perf/pmu-events/empty-pmu-events.c           |  8 ++++
 tools/perf/tests/pmu-events.c                      | 55 ++++++++++++++++++++++
 3 files changed, 71 insertions(+)

diff --git a/tools/perf/pmu-events/arch/test/test_soc/sys/uncore.json b/tools/perf/pmu-events/arch/test/test_soc/sys/uncore.json
index c7e7528..06b886d 100644
--- a/tools/perf/pmu-events/arch/test/test_soc/sys/uncore.json
+++ b/tools/perf/pmu-events/arch/test/test_soc/sys/uncore.json
@@ -12,5 +12,13 @@
            "EventName": "sys_ccn_pmu.read_cycles",
            "Unit": "sys_ccn_pmu",
            "Compat": "0x01"
+   },
+   {
+           "BriefDescription": "Counts total cache misses in first lookup result (high priority).",
+           "NodeType": "0x05",
+           "EventIdCode": "0x01",
+           "EventName": "sys_cmn_pmu.hnf_cache_miss",
+           "Unit": "sys_cmn_pmu",
+           "Compat": "434*;436*;43c*;43a01"
    }
 ]
diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
index e74defb..25be18a 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -245,6 +245,14 @@ struct pmu_events_map {
 		.pmu = "uncore_sys_ccn_pmu",
 	},
 	{
+		.name = "sys_cmn_pmu.hnf_cache_miss",
+		.event = "type=0x05,eventid=0x01",
+		.desc = "Counts total cache misses in first lookup result (high priority). Unit: uncore_sys_cmn_pmu ",
+		.compat = "434*;436*;43c*;43a01",
+		.topic = "uncore",
+		.pmu = "uncore_sys_cmn_pmu",
+	},
+	{
 		.name = 0,
 		.event = 0,
 		.desc = 0,
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index 3204252..79fb3e2 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -255,9 +255,24 @@ struct perf_pmu_test_pmu {
 	.matching_pmu = "uncore_sys_ccn_pmu4",
 };
 
+static const struct perf_pmu_test_event sys_cmn_pmu_hnf_cache_miss = {
+	.event = {
+		.name = "sys_cmn_pmu.hnf_cache_miss",
+		.event = "type=0x05,eventid=0x01",
+		.desc = "Counts total cache misses in first lookup result (high priority). Unit: uncore_sys_cmn_pmu ",
+		.topic = "uncore",
+		.pmu = "uncore_sys_cmn_pmu",
+		.compat = "434*;436*;43c*;43a01",
+	},
+	.alias_str = "type=0x5,eventid=0x1",
+	.alias_long_desc = "Counts total cache misses in first lookup result (high priority). Unit: uncore_sys_cmn_pmu ",
+	.matching_pmu = "uncore_sys_cmn_pmu0",
+};
+
 static const struct perf_pmu_test_event *sys_events[] = {
 	&sys_ddr_pmu_write_cycles,
 	&sys_ccn_pmu_read_cycles,
+	&sys_cmn_pmu_hnf_cache_miss,
 	NULL
 };
 
@@ -704,6 +719,46 @@ static int __test_uncore_pmu_event_aliases(struct perf_pmu_test_pmu *test_pmu)
 			&sys_ccn_pmu_read_cycles,
 		},
 	},
+	{
+		.pmu = {
+			.name = (char *)"uncore_sys_cmn_pmu0",
+			.is_uncore = 1,
+			.id = (char *)"43401",
+		},
+		.aliases = {
+			&sys_cmn_pmu_hnf_cache_miss,
+		},
+	},
+	{
+		.pmu = {
+			.name = (char *)"uncore_sys_cmn_pmu0",
+			.is_uncore = 1,
+			.id = (char *)"43602",
+		},
+		.aliases = {
+			&sys_cmn_pmu_hnf_cache_miss,
+		},
+	},
+	{
+		.pmu = {
+			.name = (char *)"uncore_sys_cmn_pmu0",
+			.is_uncore = 1,
+			.id = (char *)"43c03",
+		},
+		.aliases = {
+			&sys_cmn_pmu_hnf_cache_miss,
+		},
+	},
+	{
+		.pmu = {
+			.name = (char *)"uncore_sys_cmn_pmu0",
+			.is_uncore = 1,
+			.id = (char *)"43a01",
+		},
+		.aliases = {
+			&sys_cmn_pmu_hnf_cache_miss,
+		},
+	}
 };
 
 /* Test that aliases generated are as expected */
-- 
1.8.3.1

