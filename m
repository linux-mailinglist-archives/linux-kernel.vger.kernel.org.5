Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8686D7727A6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbjHGO0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 10:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbjHGO0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:26:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 23F91E79;
        Mon,  7 Aug 2023 07:26:13 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C17A31FB;
        Mon,  7 Aug 2023 07:26:55 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B51B33F64C;
        Mon,  7 Aug 2023 07:26:09 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org, irogers@google.com,
        john.g.garry@oracle.com, renyu.zj@linux.alibaba.com
Cc:     James Clark <james.clark@arm.com>, Will Deacon <will@kernel.org>,
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
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Nick Forrington <nick.forrington@arm.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Subject: [PATCH v4 5/6] perf vendor events arm64: Update stall_slot workaround for N2 r0p3
Date:   Mon,  7 Aug 2023 15:20:49 +0100
Message-Id: <20230807142138.288713-6-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807142138.288713-1-james.clark@arm.com>
References: <20230807142138.288713-1-james.clark@arm.com>
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

N2 r0p3 doesn't require the workaround [1], so gating on (#slots - 5) no
longer works because all N2s have 5 slots. Add a new expression builtin
that identifies the need for the workaround correctly.

[1]: https://gitlab.arm.com/telemetry-solution/telemetry-solution/-/blob/main/data/pmu/cpu/neoverse/neoverse-n2-r0p3.json
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/arch/arm64/util/pmu.c              | 21 +++++++++++++++++++
 .../arm64/arm/neoverse-n2-v2/metrics.json     |  8 +++----
 tools/perf/util/expr.c                        |  4 ++++
 tools/perf/util/pmu.c                         |  6 ++++++
 tools/perf/util/pmu.h                         |  1 +
 5 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/tools/perf/arch/arm64/util/pmu.c b/tools/perf/arch/arm64/util/pmu.c
index 561de0cb6b95..30e2385a83cf 100644
--- a/tools/perf/arch/arm64/util/pmu.c
+++ b/tools/perf/arch/arm64/util/pmu.c
@@ -2,6 +2,7 @@
 
 #include <internal/cpumap.h>
 #include "../../../util/cpumap.h"
+#include "../../../util/header.h"
 #include "../../../util/pmu.h"
 #include "../../../util/pmus.h"
 #include <api/fs/fs.h>
@@ -62,3 +63,23 @@ double perf_pmu__cpu_slots_per_cycle(void)
 
 	return slots ? (double)slots : NAN;
 }
+
+double perf_pmu__no_stall_errata(void)
+{
+	struct perf_pmu *pmu = pmu__find_core_pmu();
+	char *cpuid = perf_pmu__getcpuid(pmu);
+	bool n2_r0p3_plus;
+	bool not_n2;
+
+	if (!cpuid)
+		return NAN;
+
+	/* N2 r0p3+ doesn't need CPU_CYCLES to be subtracted from slots. */
+	n2_r0p3_plus = !strcmp_cpuid_str("0x00000000410fd493", cpuid);
+
+	/* Anything other than N2 doesn't need the workaround either */
+	not_n2 = strcmp_cpuid_str("0x00000000410fd490", cpuid);
+
+	free(cpuid);
+	return n2_r0p3_plus || not_n2;
+}
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/metrics.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/metrics.json
index 8ad15b726dca..9b912a9427f6 100644
--- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/metrics.json
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/metrics.json
@@ -1,15 +1,15 @@
 [
     {
         "ArchStdEvent": "FRONTEND_BOUND",
-        "MetricExpr": "((stall_slot_frontend) if (#slots - 5) else (stall_slot_frontend - cpu_cycles)) / (#slots * cpu_cycles)"
+        "MetricExpr": "((stall_slot_frontend) if (#no_stall_errata) else (stall_slot_frontend - cpu_cycles)) / (#slots * cpu_cycles)"
     },
     {
         "ArchStdEvent": "BAD_SPECULATION",
-        "MetricExpr": "(1 - op_retired / op_spec) * (1 - (stall_slot if (#slots - 5) else (stall_slot - cpu_cycles)) / (#slots * cpu_cycles))"
+        "MetricExpr": "(1 - op_retired / op_spec) * (1 - (stall_slot if (#no_stall_errata) else (stall_slot - cpu_cycles)) / (#slots * cpu_cycles))"
     },
     {
         "ArchStdEvent": "RETIRING",
-        "MetricExpr": "(op_retired / op_spec) * (1 - (stall_slot if (#slots - 5) else (stall_slot - cpu_cycles)) / (#slots * cpu_cycles))"
+        "MetricExpr": "(op_retired / op_spec) * (1 - (stall_slot if (#no_stall_errata) else (stall_slot - cpu_cycles)) / (#slots * cpu_cycles))"
     },
     {
         "ArchStdEvent": "BACKEND_BOUND"
@@ -201,7 +201,7 @@
         "ScaleUnit": "100%"
     },
     {
-        "MetricExpr": "OP_RETIRED / OP_SPEC * (1 - (STALL_SLOT if (#slots - 5) else (STALL_SLOT - CPU_CYCLES)) / (#slots * CPU_CYCLES))",
+        "MetricExpr": "OP_RETIRED / OP_SPEC * (1 - (STALL_SLOT if (#no_stall_errata) else (STALL_SLOT - CPU_CYCLES)) / (#slots * CPU_CYCLES))",
         "BriefDescription": "The truly effective ratio of micro-operations executed by the CPU, which means that misprediction and stall are not included",
         "MetricGroup": "PEutilization",
         "MetricName": "cpu_utilization",
diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 7410a165f68b..3bae19785796 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -465,6 +465,10 @@ double expr__get_literal(const char *literal, const struct expr_scanner_ctx *ctx
 		result = perf_pmu__cpu_slots_per_cycle();
 		goto out;
 	}
+	if (!strcmp("#no_stall_errata", literal)) {
+		result = perf_pmu__no_stall_errata();
+		goto out;
+	}
 	if (!strcmp("#has_pmem", literal)) {
 		result = has_pmem();
 		goto out;
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index b6654b9f55d2..d37dc7202ddb 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1779,3 +1779,9 @@ void perf_pmu__delete(struct perf_pmu *pmu)
 	zfree(&pmu->alias_name);
 	free(pmu);
 }
+
+__weak double perf_pmu__no_stall_errata(void)
+{
+	/* Only exists on Arm */
+	return NAN;
+}
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 203b92860e3c..57c002308f9a 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -288,5 +288,6 @@ int perf_pmu__pathname_fd(int dirfd, const char *pmu_name, const char *filename,
 struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char *lookup_name);
 struct perf_pmu *perf_pmu__create_placeholder_core_pmu(struct list_head *core_pmus);
 void perf_pmu__delete(struct perf_pmu *pmu);
+double perf_pmu__no_stall_errata(void);
 
 #endif /* __PMU_H */
-- 
2.34.1

