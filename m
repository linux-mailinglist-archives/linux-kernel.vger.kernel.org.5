Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C2377921F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 16:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234298AbjHKOpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 10:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjHKOpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 10:45:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6E3432702;
        Fri, 11 Aug 2023 07:45:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FDA4113E;
        Fri, 11 Aug 2023 07:46:03 -0700 (PDT)
Received: from e127643.broadband (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 00E043F64C;
        Fri, 11 Aug 2023 07:45:17 -0700 (PDT)
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
        Kan Liang <kan.liang@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Nick Forrington <nick.forrington@arm.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Sohom Datta <sohomdatta1@gmail.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Subject: [PATCH v5 5/6] perf vendor events arm64: Update stall_slot workaround for N2 r0p3
Date:   Fri, 11 Aug 2023 15:39:22 +0100
Message-Id: <20230811144017.491628-6-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811144017.491628-1-james.clark@arm.com>
References: <20230811144017.491628-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

N2 r0p3 doesn't require the workaround [1], so gating on (#slots - 5) no
longer works because all N2s have 5 slots. Add a new expression builtin
that allows calling strcmp_cpuid_str() and comparing CPUIDs in metric
formulas.

In this case, the commented formula looks like this:

  strcmp_cpuid_str(0x410fd493)        # greater than or equal to N2 r0p3
  | strcmp_cpuid_str(0x410fd490) ^ 1  # OR NOT any version of N2

[1]: https://gitlab.arm.com/telemetry-solution/telemetry-solution/-/blob/main/data/pmu/cpu/neoverse/neoverse-n2-r0p3.json
Signed-off-by: James Clark <james.clark@arm.com>
---
 tools/perf/arch/arm64/util/pmu.c               | 18 +-----------------
 .../arch/arm64/arm/neoverse-n2-v2/metrics.json |  8 ++++----
 tools/perf/pmu-events/metric.py                | 17 +++++++++++++++--
 tools/perf/util/expr.c                         | 18 ++++++++++++++++++
 tools/perf/util/expr.h                         |  1 +
 tools/perf/util/expr.l                         |  1 +
 tools/perf/util/expr.y                         |  8 +++++++-
 tools/perf/util/pmu.c                          | 17 +++++++++++++++++
 tools/perf/util/pmu.h                          |  1 +
 9 files changed, 65 insertions(+), 24 deletions(-)

diff --git a/tools/perf/arch/arm64/util/pmu.c b/tools/perf/arch/arm64/util/pmu.c
index 561de0cb6b95..3f3c6c691ea5 100644
--- a/tools/perf/arch/arm64/util/pmu.c
+++ b/tools/perf/arch/arm64/util/pmu.c
@@ -2,28 +2,12 @@
 
 #include <internal/cpumap.h>
 #include "../../../util/cpumap.h"
+#include "../../../util/header.h"
 #include "../../../util/pmu.h"
 #include "../../../util/pmus.h"
 #include <api/fs/fs.h>
 #include <math.h>
 
-static struct perf_pmu *pmu__find_core_pmu(void)
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
-
 const struct pmu_metrics_table *pmu_metrics_table__find(void)
 {
 	struct perf_pmu *pmu = pmu__find_core_pmu();
diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/metrics.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/metrics.json
index 8ad15b726dca..9757cc178bdf 100644
--- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/metrics.json
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2-v2/metrics.json
@@ -1,15 +1,15 @@
 [
     {
         "ArchStdEvent": "FRONTEND_BOUND",
-        "MetricExpr": "((stall_slot_frontend) if (#slots - 5) else (stall_slot_frontend - cpu_cycles)) / (#slots * cpu_cycles)"
+        "MetricExpr": "((stall_slot_frontend) if (strcmp_cpuid_str(0x410fd493) | strcmp_cpuid_str(0x410fd490) ^ 1) else (stall_slot_frontend - cpu_cycles)) / (#slots * cpu_cycles)"
     },
     {
         "ArchStdEvent": "BAD_SPECULATION",
-        "MetricExpr": "(1 - op_retired / op_spec) * (1 - (stall_slot if (#slots - 5) else (stall_slot - cpu_cycles)) / (#slots * cpu_cycles))"
+        "MetricExpr": "(1 - op_retired / op_spec) * (1 - (stall_slot if (strcmp_cpuid_str(0x410fd493) | strcmp_cpuid_str(0x410fd490) ^ 1) else (stall_slot - cpu_cycles)) / (#slots * cpu_cycles))"
     },
     {
         "ArchStdEvent": "RETIRING",
-        "MetricExpr": "(op_retired / op_spec) * (1 - (stall_slot if (#slots - 5) else (stall_slot - cpu_cycles)) / (#slots * cpu_cycles))"
+        "MetricExpr": "(op_retired / op_spec) * (1 - (stall_slot if (strcmp_cpuid_str(0x410fd493) | strcmp_cpuid_str(0x410fd490) ^ 1) else (stall_slot - cpu_cycles)) / (#slots * cpu_cycles))"
     },
     {
         "ArchStdEvent": "BACKEND_BOUND"
@@ -201,7 +201,7 @@
         "ScaleUnit": "100%"
     },
     {
-        "MetricExpr": "OP_RETIRED / OP_SPEC * (1 - (STALL_SLOT if (#slots - 5) else (STALL_SLOT - CPU_CYCLES)) / (#slots * CPU_CYCLES))",
+        "MetricExpr": "OP_RETIRED / OP_SPEC * (1 - (STALL_SLOT if (strcmp_cpuid_str(0x410fd493) | strcmp_cpuid_str(0x410fd490) ^ 1) else (STALL_SLOT - CPU_CYCLES)) / (#slots * CPU_CYCLES))",
         "BriefDescription": "The truly effective ratio of micro-operations executed by the CPU, which means that misprediction and stall are not included",
         "MetricGroup": "PEutilization",
         "MetricName": "cpu_utilization",
diff --git a/tools/perf/pmu-events/metric.py b/tools/perf/pmu-events/metric.py
index 85a3545f5b6a..0e9ec65d92ae 100644
--- a/tools/perf/pmu-events/metric.py
+++ b/tools/perf/pmu-events/metric.py
@@ -413,6 +413,10 @@ def has_event(event: Event) -> Function:
   # pylint: disable=invalid-name
   return Function('has_event', event)
 
+def strcmp_cpuid_str(event: str) -> Function:
+  # pylint: disable=redefined-builtin
+  # pylint: disable=invalid-name
+  return Function('strcmp_cpuid_str', event)
 
 class Metric:
   """An individual metric that will specifiable on the perf command line."""
@@ -541,14 +545,23 @@ def ParsePerfJson(orig: str) -> Expression:
   """
   # pylint: disable=eval-used
   py = orig.strip()
+  # First try to convert everything that looks like a string (event name) into Event(r"EVENT_NAME").
+  # This isn't very selective so is followed up by converting some unwanted conversions back again
   py = re.sub(r'([a-zA-Z][^-+/\* \\\(\),]*(?:\\.[^-+/\* \\\(\),]*)*)',
               r'Event(r"\1")', py)
+  # If it started with a # it should have been a literal, rather than an event name
   py = re.sub(r'#Event\(r"([^"]*)"\)', r'Literal("#\1")', py)
+  # Convert accidentally converted hex constants ("0Event(r"xDEADBEEF)"") back to a constant,
+  # but keep it wrapped in Event(), otherwise Python drops the 0x prefix and it gets interpreted as
+  # a double by the Bison parser
+  py = re.sub(r'0Event\(r"[xX]([0-9a-fA-F]*)"\)', r'Event("0x\1")', py)
+  # Convert accidentally converted scientific notation constants back
   py = re.sub(r'([0-9]+)Event\(r"(e[0-9]+)"\)', r'\1\2', py)
-  keywords = ['if', 'else', 'min', 'max', 'd_ratio', 'source_count', 'has_event']
+  # Convert all the known keywords back from events to just the keyword
+  keywords = ['if', 'else', 'min', 'max', 'd_ratio', 'source_count', 'has_event', 'strcmp_cpuid_str',
+              'cpuid_not_more_than']
   for kw in keywords:
     py = re.sub(rf'Event\(r"{kw}"\)', kw, py)
-
   try:
     parsed = ast.parse(py, mode='eval')
   except SyntaxError as e:
diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 7410a165f68b..0985a3cbc6f9 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -13,6 +13,8 @@
 #include <util/expr-bison.h>
 #include <util/expr-flex.h>
 #include "util/hashmap.h"
+#include "util/header.h"
+#include "util/pmu.h"
 #include "smt.h"
 #include "tsc.h"
 #include <api/fs/fs.h>
@@ -495,3 +497,19 @@ double expr__has_event(const struct expr_parse_ctx *ctx, bool compute_ids, const
 	evlist__delete(tmp);
 	return ret;
 }
+
+double expr__strcmp_cpuid_str(const struct expr_parse_ctx *ctx __maybe_unused,
+		       bool compute_ids __maybe_unused, const char *test_id)
+{
+	double ret;
+	struct perf_pmu *pmu = pmu__find_core_pmu();
+	char *cpuid = perf_pmu__getcpuid(pmu);
+
+	if (!cpuid)
+		return NAN;
+
+	ret = !strcmp_cpuid_str(test_id, cpuid);
+
+	free(cpuid);
+	return ret;
+}
diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index 3c1e49b3e35d..c0cec29ddc29 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -55,5 +55,6 @@ double expr_id_data__value(const struct expr_id_data *data);
 double expr_id_data__source_count(const struct expr_id_data *data);
 double expr__get_literal(const char *literal, const struct expr_scanner_ctx *ctx);
 double expr__has_event(const struct expr_parse_ctx *ctx, bool compute_ids, const char *id);
+double expr__strcmp_cpuid_str(const struct expr_parse_ctx *ctx, bool compute_ids, const char *id);
 
 #endif
diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
index dbb117414710..0feef0726c48 100644
--- a/tools/perf/util/expr.l
+++ b/tools/perf/util/expr.l
@@ -114,6 +114,7 @@ if		{ return IF; }
 else		{ return ELSE; }
 source_count	{ return SOURCE_COUNT; }
 has_event	{ return HAS_EVENT; }
+strcmp_cpuid_str	{ return STRCMP_CPUID_STR; }
 {literal}	{ return literal(yyscanner, sctx); }
 {number}	{ return value(yyscanner); }
 {symbol}	{ return str(yyscanner, ID, sctx->runtime); }
diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index 65d54a6f29ad..6c93b358cc2d 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -39,7 +39,7 @@ int expr_lex(YYSTYPE * yylval_param , void *yyscanner);
 	} ids;
 }
 
-%token ID NUMBER MIN MAX IF ELSE LITERAL D_RATIO SOURCE_COUNT HAS_EVENT EXPR_ERROR
+%token ID NUMBER MIN MAX IF ELSE LITERAL D_RATIO SOURCE_COUNT HAS_EVENT STRCMP_CPUID_STR EXPR_ERROR
 %left MIN MAX IF
 %left '|'
 %left '^'
@@ -207,6 +207,12 @@ expr: NUMBER
 	$$.ids = NULL;
 	free($3);
 }
+| STRCMP_CPUID_STR '(' ID ')'
+{
+	$$.val = expr__strcmp_cpuid_str(ctx, compute_ids, $3);
+	$$.ids = NULL;
+	free($3);
+}
 | expr '|' expr
 {
 	if (is_const($1.val) && is_const($3.val)) {
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index b6654b9f55d2..b6948021fe29 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1779,3 +1779,20 @@ void perf_pmu__delete(struct perf_pmu *pmu)
 	zfree(&pmu->alias_name);
 	free(pmu);
 }
+
+struct perf_pmu *pmu__find_core_pmu(void)
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
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 203b92860e3c..580b8d65bd65 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -288,5 +288,6 @@ int perf_pmu__pathname_fd(int dirfd, const char *pmu_name, const char *filename,
 struct perf_pmu *perf_pmu__lookup(struct list_head *pmus, int dirfd, const char *lookup_name);
 struct perf_pmu *perf_pmu__create_placeholder_core_pmu(struct list_head *core_pmus);
 void perf_pmu__delete(struct perf_pmu *pmu);
+struct perf_pmu *pmu__find_core_pmu(void);
 
 #endif /* __PMU_H */
-- 
2.34.1

