Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78EF578F016
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 17:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346508AbjHaPSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 11:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243146AbjHaPSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 11:18:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6ECA7E6A;
        Thu, 31 Aug 2023 08:18:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A90AC15;
        Thu, 31 Aug 2023 08:18:56 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C726D3F64C;
        Thu, 31 Aug 2023 08:18:13 -0700 (PDT)
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
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Haixin Yu <yuhaixin.yhx@linux.alibaba.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 5/7] perf pmu: Move pmu__find_core_pmu() to pmus.c
Date:   Thu, 31 Aug 2023 16:16:16 +0100
Message-Id: <20230831151632.124985-6-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831151632.124985-1-james.clark@arm.com>
References: <20230831151632.124985-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pmu__find_core_pmu() more logically belongs in pmus.c because it
iterates over all PMUs, so move it to pmus.c

At the same time rename it to perf_pmus__find_core_pmu() to match the
naming convention in this file.

Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/arch/arm64/util/pmu.c |  6 +++---
 tools/perf/tests/expr.c          |  2 +-
 tools/perf/util/expr.c           |  2 +-
 tools/perf/util/pmu.c            | 17 -----------------
 tools/perf/util/pmu.h            |  2 +-
 tools/perf/util/pmus.c           | 18 ++++++++++++++++++
 6 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/tools/perf/arch/arm64/util/pmu.c b/tools/perf/arch/arm64/util/pmu.c
index 615084eb88d8..3d9330feebd2 100644
--- a/tools/perf/arch/arm64/util/pmu.c
+++ b/tools/perf/arch/arm64/util/pmu.c
@@ -10,7 +10,7 @@
 
 const struct pmu_metrics_table *pmu_metrics_table__find(void)
 {
-	struct perf_pmu *pmu = pmu__find_core_pmu();
+	struct perf_pmu *pmu = perf_pmus__find_core_pmu();
 
 	if (pmu)
 		return perf_pmu__find_metrics_table(pmu);
@@ -20,7 +20,7 @@ const struct pmu_metrics_table *pmu_metrics_table__find(void)
 
 const struct pmu_events_table *pmu_events_table__find(void)
 {
-	struct perf_pmu *pmu = pmu__find_core_pmu();
+	struct perf_pmu *pmu = perf_pmus__find_core_pmu();
 
 	if (pmu)
 		return perf_pmu__find_events_table(pmu);
@@ -32,7 +32,7 @@ double perf_pmu__cpu_slots_per_cycle(void)
 {
 	char path[PATH_MAX];
 	unsigned long long slots = 0;
-	struct perf_pmu *pmu = pmu__find_core_pmu();
+	struct perf_pmu *pmu = perf_pmus__find_core_pmu();
 
 	if (pmu) {
 		perf_pmu__pathname_scnprintf(path, sizeof(path),
diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index 78544092ef0c..e3aa9d4fcf3a 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -76,7 +76,7 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
 	struct expr_parse_ctx *ctx;
 	bool is_intel = false;
 	char strcmp_cpuid_buf[256];
-	struct perf_pmu *pmu = pmu__find_core_pmu();
+	struct perf_pmu *pmu = perf_pmus__find_core_pmu();
 	char *cpuid = perf_pmu__getcpuid(pmu);
 	char *escaped_cpuid1, *escaped_cpuid2;
 
diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 4488f306de78..7be23b3ac082 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -509,7 +509,7 @@ double expr__strcmp_cpuid_str(const struct expr_parse_ctx *ctx __maybe_unused,
 		       bool compute_ids __maybe_unused, const char *test_id)
 {
 	double ret;
-	struct perf_pmu *pmu = pmu__find_core_pmu();
+	struct perf_pmu *pmu = perf_pmus__find_core_pmu();
 	char *cpuid = perf_pmu__getcpuid(pmu);
 
 	if (!cpuid)
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 152cda84f273..8213e26783a1 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -2049,20 +2049,3 @@ void perf_pmu__delete(struct perf_pmu *pmu)
 	zfree(&pmu->id);
 	free(pmu);
 }
-
-struct perf_pmu *pmu__find_core_pmu(void)
-{
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
-}
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 6a4e170c61d6..45079f26abf6 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -264,6 +264,6 @@ int perf_pmu__pathname_fd(int dirfd, const char *pmu_name, const char *filename,
 struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char *lookup_name);
 struct perf_pmu *perf_pmu__create_placeholder_core_pmu(struct list_head *core_pmus);
 void perf_pmu__delete(struct perf_pmu *pmu);
-struct perf_pmu *pmu__find_core_pmu(void);
+struct perf_pmu *perf_pmus__find_core_pmu(void);
 
 #endif /* __PMU_H */
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 6631367c756f..032ce57d2b8e 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -10,6 +10,7 @@
 #include <pthread.h>
 #include <string.h>
 #include <unistd.h>
+#include "cpumap.h"
 #include "debug.h"
 #include "evsel.h"
 #include "pmus.h"
@@ -592,3 +593,20 @@ struct perf_pmu *evsel__find_pmu(const struct evsel *evsel)
 	}
 	return pmu;
 }
+
+struct perf_pmu *perf_pmus__find_core_pmu(void)
+{
+	struct perf_pmu *pmu = NULL;
+
+	while ((pmu = perf_pmus__scan_core(pmu))) {
+		/*
+		 * The cpumap should cover all CPUs. Otherwise, some CPUs may
+		 * not support some events or have different event IDs.
+		 */
+		if (RC_CHK_ACCESS(pmu->cpus)->nr != cpu__max_cpu().cpu)
+			return NULL;
+
+		return pmu;
+	}
+	return NULL;
+}
-- 
2.34.1

