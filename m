Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18F07ACFA9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 07:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbjIYF6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 01:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjIYF6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 01:58:37 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF32EE;
        Sun, 24 Sep 2023 22:58:30 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0Vsl7J2W_1695621507;
Received: from srmbuffer011165236051.sqa.net(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0Vsl7J2W_1695621507)
          by smtp.aliyun-inc.com;
          Mon, 25 Sep 2023 13:58:27 +0800
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
Subject: [PATCH v10 4/7] perf test: Make matching_pmu effective
Date:   Mon, 25 Sep 2023 13:57:21 +0800
Message-Id: <1695621444-56530-5-git-send-email-renyu.zj@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1695621444-56530-1-git-send-email-renyu.zj@linux.alibaba.com>
References: <1695621444-56530-1-git-send-email-renyu.zj@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The perf_pmu_test_event.matching_pmu didn't work. No matter what its
value is, it does not affect the test results. So let matching_pmu be
used for matching perf_pmu_test_pmu.pmu.name.

Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
Reviewed-by: John Garry <john.g.garry@oracle.com>
---
 tools/perf/tests/pmu-events.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
index f5321fb..0cf572f 100644
--- a/tools/perf/tests/pmu-events.c
+++ b/tools/perf/tests/pmu-events.c
@@ -245,7 +245,7 @@ struct perf_pmu_test_pmu {
 	},
 	.alias_str = "event=0x2b",
 	.alias_long_desc = "ddr write-cycles event",
-	.matching_pmu = "uncore_sys_ddr_pmu",
+	.matching_pmu = "uncore_sys_ddr_pmu0",
 };
 
 static const struct perf_pmu_test_event sys_ccn_pmu_read_cycles = {
@@ -259,7 +259,7 @@ struct perf_pmu_test_pmu {
 	},
 	.alias_str = "config=0x2c",
 	.alias_long_desc = "ccn read-cycles event",
-	.matching_pmu = "uncore_sys_ccn_pmu",
+	.matching_pmu = "uncore_sys_ccn_pmu4",
 };
 
 static const struct perf_pmu_test_event *sys_events[] = {
@@ -615,6 +615,12 @@ static int __test_uncore_pmu_event_aliases(struct perf_pmu_test_pmu *test_pmu)
 			.count = &matched_count,
 		};
 
+		if (strcmp(pmu_name, test_event.matching_pmu)) {
+			pr_debug("testing aliases uncore PMU %s: mismatched matching_pmu, %s vs %s\n",
+					pmu_name, test_event.matching_pmu, pmu_name);
+			return -1;
+		}
+
 		err = perf_pmu__find_event(pmu, event->name, &args,
 					   test_core_pmu_event_aliases_cb);
 		if (err) {
-- 
1.8.3.1

