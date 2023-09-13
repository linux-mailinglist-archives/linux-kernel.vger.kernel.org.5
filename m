Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1671B79ED24
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjIMPe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjIMPez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:34:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EE23FCCD;
        Wed, 13 Sep 2023 08:34:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 945511FB;
        Wed, 13 Sep 2023 08:35:28 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C1C753F5A1;
        Wed, 13 Sep 2023 08:34:47 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org, irogers@google.com,
        acme@kernel.org
Cc:     James Clark <james.clark@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Haixin Yu <yuhaixin.yhx@linux.alibaba.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] perf pmu: Remove unused function
Date:   Wed, 13 Sep 2023 16:33:50 +0100
Message-Id: <20230913153355.138331-4-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230913153355.138331-1-james.clark@arm.com>
References: <20230913153355.138331-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index f50a5636633f..0d81c059c91c 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -776,11 +776,6 @@ char *perf_pmu__getcpuid(struct perf_pmu *pmu)
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
index d7b46085642d..04b317b17d66 100644
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

