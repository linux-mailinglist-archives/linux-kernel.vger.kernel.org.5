Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8388E7915AB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 12:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350221AbjIDKY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 06:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352745AbjIDJyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 05:54:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 24C57CC5;
        Mon,  4 Sep 2023 02:53:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC4A3143D;
        Mon,  4 Sep 2023 02:54:33 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 76E9D3F793;
        Mon,  4 Sep 2023 02:53:52 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org, irogers@google.com
Cc:     James Clark <james.clark@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Haixin Yu <yuhaixin.yhx@linux.alibaba.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 7/7] perf pmu: Remove unused function
Date:   Mon,  4 Sep 2023 10:50:49 +0100
Message-Id: <20230904095104.1162928-8-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230904095104.1162928-1-james.clark@arm.com>
References: <20230904095104.1162928-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pmu_events_table__find() is no longer used so remove it and its Arm
specific version.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/arch/arm64/util/pmu.c | 10 ----------
 tools/perf/util/pmu.c            |  5 -----
 tools/perf/util/pmu.h            |  1 -
 3 files changed, 16 deletions(-)

diff --git a/tools/perf/arch/arm64/util/pmu.c b/tools/perf/arch/arm64/util/pmu.c
index 3099f5f448ba..2a4eab2d160e 100644
--- a/tools/perf/arch/arm64/util/pmu.c
+++ b/tools/perf/arch/arm64/util/pmu.c
@@ -24,16 +24,6 @@ const struct pmu_metrics_table *pmu_metrics_table__find(void)
 	return NULL;
 }
 
-const struct pmu_events_table *pmu_events_table__find(void)
-{
-	struct perf_pmu *pmu = perf_pmus__find_core_pmu();
-
-	if (pmu)
-		return perf_pmu__find_events_table(pmu);
-
-	return NULL;
-}
-
 double perf_pmu__cpu_slots_per_cycle(void)
 {
 	char path[PATH_MAX];
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 0a4080ca7949..311195e9688a 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -775,11 +775,6 @@ char *perf_pmu__getcpuid(struct perf_pmu *pmu)
 	return cpuid;
 }
 
-__weak const struct pmu_events_table *pmu_events_table__find(void)
-{
-	return perf_pmu__find_events_table(NULL);
-}
-
 __weak const struct pmu_metrics_table *pmu_metrics_table__find(void)
 {
 	return perf_pmu__find_metrics_table(NULL);
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 45079f26abf6..4b9386534d2a 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -238,7 +238,6 @@ void pmu_add_cpu_aliases_table(struct perf_pmu *pmu,
 			       const struct pmu_events_table *table);
 
 char *perf_pmu__getcpuid(struct perf_pmu *pmu);
-const struct pmu_events_table *pmu_events_table__find(void);
 const struct pmu_metrics_table *pmu_metrics_table__find(void);
 
 int perf_pmu__convert_scale(const char *scale, char **end, double *sval);
-- 
2.34.1

