Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A2079ED25
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjIMPev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjIMPer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:34:47 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 22B131BEB;
        Wed, 13 Sep 2023 08:34:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0726B1FB;
        Wed, 13 Sep 2023 08:35:19 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DA03C3F5A1;
        Wed, 13 Sep 2023 08:34:36 -0700 (PDT)
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
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Haixin Yu <yuhaixin.yhx@linux.alibaba.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] perf pmus: Simplify perf_pmus__find_core_pmu()
Date:   Wed, 13 Sep 2023 16:33:49 +0100
Message-Id: <20230913153355.138331-3-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230913153355.138331-1-james.clark@arm.com>
References: <20230913153355.138331-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the while loop always either exits on the first iteration with
a core PMU, or exits with NULL on heterogeneous systems or when not all
CPUs are online.

Both of the latter behaviors are undesirable for platforms other than
Arm so simplify it to always return the first core PMU, or NULL if none
exist.

This behavior was depended on by the Arm version of
pmu_metrics_table__find(), so the logic has been moved there instead.

Suggested-by: Ian Rogers <irogers@google.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/arch/arm64/util/pmu.c |  8 +++++++-
 tools/perf/util/pmus.c           | 14 +-------------
 2 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/tools/perf/arch/arm64/util/pmu.c b/tools/perf/arch/arm64/util/pmu.c
index 3d9330feebd2..3099f5f448ba 100644
--- a/tools/perf/arch/arm64/util/pmu.c
+++ b/tools/perf/arch/arm64/util/pmu.c
@@ -10,8 +10,14 @@
 
 const struct pmu_metrics_table *pmu_metrics_table__find(void)
 {
-	struct perf_pmu *pmu = perf_pmus__find_core_pmu();
+	struct perf_pmu *pmu;
+
+	/* Metrics aren't currently supported on heterogeneous Arm systems */
+	if (perf_pmus__num_core_pmus() > 1)
+		return NULL;
 
+	/* Doesn't matter which one here because they'll all be the same */
+	pmu = perf_pmus__find_core_pmu();
 	if (pmu)
 		return perf_pmu__find_metrics_table(pmu);
 
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index cec869cbe163..64e798e68a2d 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -596,17 +596,5 @@ struct perf_pmu *evsel__find_pmu(const struct evsel *evsel)
 
 struct perf_pmu *perf_pmus__find_core_pmu(void)
 {
-	struct perf_pmu *pmu = NULL;
-
-	while ((pmu = perf_pmus__scan_core(pmu))) {
-		/*
-		 * The cpumap should cover all CPUs. Otherwise, some CPUs may
-		 * not support some events or have different event IDs.
-		 */
-		if (RC_CHK_ACCESS(pmu->cpus)->nr != cpu__max_cpu().cpu)
-			return NULL;
-
-		return pmu;
-	}
-	return NULL;
+	return perf_pmus__scan_core(NULL);
 }
-- 
2.34.1

