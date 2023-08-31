Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCC278F111
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 18:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345809AbjHaQSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 12:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbjHaQSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 12:18:30 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4869ECDB;
        Thu, 31 Aug 2023 09:18:16 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57F1BC15;
        Thu, 31 Aug 2023 09:18:55 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A9F9E3F8C6;
        Thu, 31 Aug 2023 09:18:13 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org
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
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nick Forrington <nick.forrington@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] perf vendor events arm64: Add V1 metrics using Arm telemetry repo
Date:   Thu, 31 Aug 2023 17:15:32 +0100
Message-Id: <20230831161618.134738-3-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831161618.134738-1-james.clark@arm.com>
References: <20230831161618.134738-1-james.clark@arm.com>
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

Metrics for V1 weren't previously included in the Perf Jsons, so add
them using the telemetry source [1].

After generation any parts identical to the default metrics in sbsa.json
were manually removed.

[1]: https://gitlab.arm.com/telemetry-solution/telemetry-solution/-/blob/main/data/pmu/cpu/neoverse/neoverse-v1.json
Signed-off-by: James Clark <james.clark@arm.com>
---
 .../arch/arm64/arm/neoverse-v1/metrics.json   | 233 ++++++++++++++++++
 1 file changed, 233 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/metrics.json

diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/metrics.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/metrics.json
new file mode 100644
index 000000000000..3fd8fefec46a
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/metrics.json
@@ -0,0 +1,233 @@
+[
+    {
+        "ArchStdEvent": "backend_bound"
+    },
+    {
+        "MetricName": "backend_stalled_cycles",
+        "MetricExpr": "((STALL_BACKEND / CPU_CYCLES) * 100)",
+        "BriefDescription": "This metric is the percentage of cycles that were stalled due to resource constraints in the backend unit of the processor.",
+        "MetricGroup": "Cycle_Accounting",
+        "ScaleUnit": "1percent of cycles"
+    },
+    {
+        "ArchStdEvent": "bad_speculation",
+        "MetricExpr": "(100 * (((1 - (OP_RETIRED / OP_SPEC)) * (1 - (STALL_SLOT / (CPU_CYCLES * 8)))) + ((BR_MIS_PRED * 4) / CPU_CYCLES)))"
+    },
+    {
+        "MetricName": "branch_misprediction_ratio",
+        "MetricExpr": "(BR_MIS_PRED_RETIRED / BR_RETIRED)",
+        "BriefDescription": "This metric measures the ratio of branches mispredicted to the total number of branches architecturally executed. This gives an indication of the effectiveness of the branch prediction unit.",
+        "MetricGroup": "Miss_Ratio;Branch_Effectiveness",
+        "ScaleUnit": "1per branch"
+    },
+    {
+        "MetricName": "branch_mpki",
+        "MetricExpr": "((BR_MIS_PRED_RETIRED / INST_RETIRED) * 1000)",
+        "BriefDescription": "This metric measures the number of branch mispredictions per thousand instructions executed.",
+        "MetricGroup": "MPKI;Branch_Effectiveness",
+        "ScaleUnit": "1MPKI"
+    },
+    {
+        "MetricName": "branch_percentage",
+        "MetricExpr": "(((BR_IMMED_SPEC + BR_INDIRECT_SPEC) / INST_SPEC) * 100)",
+        "BriefDescription": "This metric measures branch operations as a percentage of operations speculatively executed.",
+        "MetricGroup": "Operation_Mix",
+        "ScaleUnit": "1percent of operations"
+    },
+    {
+        "MetricName": "crypto_percentage",
+        "MetricExpr": "((CRYPTO_SPEC / INST_SPEC) * 100)",
+        "BriefDescription": "This metric measures crypto operations as a percentage of operations speculatively executed.",
+        "MetricGroup": "Operation_Mix",
+        "ScaleUnit": "1percent of operations"
+    },
+    {
+        "MetricName": "dtlb_mpki",
+        "MetricExpr": "((DTLB_WALK / INST_RETIRED) * 1000)",
+        "BriefDescription": "This metric measures the number of data TLB Walks per thousand instructions executed.",
+        "MetricGroup": "MPKI;DTLB_Effectiveness",
+        "ScaleUnit": "1MPKI"
+    },
+    {
+        "MetricName": "dtlb_walk_ratio",
+        "MetricExpr": "(DTLB_WALK / L1D_TLB)",
+        "BriefDescription": "This metric measures the ratio of data TLB Walks to the total number of data TLB accesses. This gives an indication of the effectiveness of the data TLB accesses.",
+        "MetricGroup": "Miss_Ratio;DTLB_Effectiveness",
+        "ScaleUnit": "1per TLB access"
+    },
+    {
+        "ArchStdEvent": "frontend_bound",
+        "MetricExpr": "(100 * ((STALL_SLOT_FRONTEND / (CPU_CYCLES * 8)) - ((BR_MIS_PRED * 4) / CPU_CYCLES)))"
+    },
+    {
+        "MetricName": "frontend_stalled_cycles",
+        "MetricExpr": "((STALL_FRONTEND / CPU_CYCLES) * 100)",
+        "BriefDescription": "This metric is the percentage of cycles that were stalled due to resource constraints in the frontend unit of the processor.",
+        "MetricGroup": "Cycle_Accounting",
+        "ScaleUnit": "1percent of cycles"
+    },
+    {
+        "MetricName": "integer_dp_percentage",
+        "MetricExpr": "((DP_SPEC / INST_SPEC) * 100)",
+        "BriefDescription": "This metric measures scalar integer operations as a percentage of operations speculatively executed.",
+        "MetricGroup": "Operation_Mix",
+        "ScaleUnit": "1percent of operations"
+    },
+    {
+        "MetricName": "ipc",
+        "MetricExpr": "(INST_RETIRED / CPU_CYCLES)",
+        "BriefDescription": "This metric measures the number of instructions retired per cycle.",
+        "MetricGroup": "General",
+        "ScaleUnit": "1per cycle"
+    },
+    {
+        "MetricName": "itlb_mpki",
+        "MetricExpr": "((ITLB_WALK / INST_RETIRED) * 1000)",
+        "BriefDescription": "This metric measures the number of instruction TLB Walks per thousand instructions executed.",
+        "MetricGroup": "MPKI;ITLB_Effectiveness",
+        "ScaleUnit": "1MPKI"
+    },
+    {
+        "MetricName": "itlb_walk_ratio",
+        "MetricExpr": "(ITLB_WALK / L1I_TLB)",
+        "BriefDescription": "This metric measures the ratio of instruction TLB Walks to the total number of instruction TLB accesses. This gives an indication of the effectiveness of the instruction TLB accesses.",
+        "MetricGroup": "Miss_Ratio;ITLB_Effectiveness",
+        "ScaleUnit": "1per TLB access"
+    },
+    {
+        "MetricName": "l1d_cache_miss_ratio",
+        "MetricExpr": "(L1D_CACHE_REFILL / L1D_CACHE)",
+        "BriefDescription": "This metric measures the ratio of level 1 data cache accesses missed to the total number of level 1 data cache accesses. This gives an indication of the effectiveness of the level 1 data cache.",
+        "MetricGroup": "Miss_Ratio;L1D_Cache_Effectiveness",
+        "ScaleUnit": "1per cache access"
+    },
+    {
+        "MetricName": "l1d_cache_mpki",
+        "MetricExpr": "((L1D_CACHE_REFILL / INST_RETIRED) * 1000)",
+        "BriefDescription": "This metric measures the number of level 1 data cache accesses missed per thousand instructions executed.",
+        "MetricGroup": "MPKI;L1D_Cache_Effectiveness",
+        "ScaleUnit": "1MPKI"
+    },
+    {
+        "MetricName": "l1d_tlb_miss_ratio",
+        "MetricExpr": "(L1D_TLB_REFILL / L1D_TLB)",
+        "BriefDescription": "This metric measures the ratio of level 1 data TLB accesses missed to the total number of level 1 data TLB accesses. This gives an indication of the effectiveness of the level 1 data TLB.",
+        "MetricGroup": "Miss_Ratio;DTLB_Effectiveness",
+        "ScaleUnit": "1per TLB access"
+    },
+    {
+        "MetricName": "l1d_tlb_mpki",
+        "MetricExpr": "((L1D_TLB_REFILL / INST_RETIRED) * 1000)",
+        "BriefDescription": "This metric measures the number of level 1 instruction TLB accesses missed per thousand instructions executed.",
+        "MetricGroup": "MPKI;DTLB_Effectiveness",
+        "ScaleUnit": "1MPKI"
+    },
+    {
+        "MetricName": "l1i_cache_miss_ratio",
+        "MetricExpr": "(L1I_CACHE_REFILL / L1I_CACHE)",
+        "BriefDescription": "This metric measures the ratio of level 1 instruction cache accesses missed to the total number of level 1 instruction cache accesses. This gives an indication of the effectiveness of the level 1 instruction cache.",
+        "MetricGroup": "Miss_Ratio;L1I_Cache_Effectiveness",
+        "ScaleUnit": "1per cache access"
+    },
+    {
+        "MetricName": "l1i_cache_mpki",
+        "MetricExpr": "((L1I_CACHE_REFILL / INST_RETIRED) * 1000)",
+        "BriefDescription": "This metric measures the number of level 1 instruction cache accesses missed per thousand instructions executed.",
+        "MetricGroup": "MPKI;L1I_Cache_Effectiveness",
+        "ScaleUnit": "1MPKI"
+    },
+    {
+        "MetricName": "l1i_tlb_miss_ratio",
+        "MetricExpr": "(L1I_TLB_REFILL / L1I_TLB)",
+        "BriefDescription": "This metric measures the ratio of level 1 instruction TLB accesses missed to the total number of level 1 instruction TLB accesses. This gives an indication of the effectiveness of the level 1 instruction TLB.",
+        "MetricGroup": "Miss_Ratio;ITLB_Effectiveness",
+        "ScaleUnit": "1per TLB access"
+    },
+    {
+        "MetricName": "l1i_tlb_mpki",
+        "MetricExpr": "((L1I_TLB_REFILL / INST_RETIRED) * 1000)",
+        "BriefDescription": "This metric measures the number of level 1 instruction TLB accesses missed per thousand instructions executed.",
+        "MetricGroup": "MPKI;ITLB_Effectiveness",
+        "ScaleUnit": "1MPKI"
+    },
+    {
+        "MetricName": "l2_cache_miss_ratio",
+        "MetricExpr": "(L2D_CACHE_REFILL / L2D_CACHE)",
+        "BriefDescription": "This metric measures the ratio of level 2 cache accesses missed to the total number of level 2 cache accesses. This gives an indication of the effectiveness of the level 2 cache, which is a unified cache that stores both data and instruction. Note that cache accesses in this cache are either data memory access or instruction fetch as this is a unified cache.",
+        "MetricGroup": "Miss_Ratio;L2_Cache_Effectiveness",
+        "ScaleUnit": "1per cache access"
+    },
+    {
+        "MetricName": "l2_cache_mpki",
+        "MetricExpr": "((L2D_CACHE_REFILL / INST_RETIRED) * 1000)",
+        "BriefDescription": "This metric measures the number of level 2 unified cache accesses missed per thousand instructions executed. Note that cache accesses in this cache are either data memory access or instruction fetch as this is a unified cache.",
+        "MetricGroup": "MPKI;L2_Cache_Effectiveness",
+        "ScaleUnit": "1MPKI"
+    },
+    {
+        "MetricName": "l2_tlb_miss_ratio",
+        "MetricExpr": "(L2D_TLB_REFILL / L2D_TLB)",
+        "BriefDescription": "This metric measures the ratio of level 2 unified TLB accesses missed to the total number of level 2 unified TLB accesses. This gives an indication of the effectiveness of the level 2 TLB.",
+        "MetricGroup": "Miss_Ratio;ITLB_Effectiveness;DTLB_Effectiveness",
+        "ScaleUnit": "1per TLB access"
+    },
+    {
+        "MetricName": "l2_tlb_mpki",
+        "MetricExpr": "((L2D_TLB_REFILL / INST_RETIRED) * 1000)",
+        "BriefDescription": "This metric measures the number of level 2 unified TLB accesses missed per thousand instructions executed.",
+        "MetricGroup": "MPKI;ITLB_Effectiveness;DTLB_Effectiveness",
+        "ScaleUnit": "1MPKI"
+    },
+    {
+        "MetricName": "ll_cache_read_hit_ratio",
+        "MetricExpr": "((LL_CACHE_RD - LL_CACHE_MISS_RD) / LL_CACHE_RD)",
+        "BriefDescription": "This metric measures the ratio of last level cache read accesses hit in the cache to the total number of last level cache accesses. This gives an indication of the effectiveness of the last level cache for read traffic. Note that cache accesses in this cache are either data memory access or instruction fetch as this is a system level cache.",
+        "MetricGroup": "LL_Cache_Effectiveness",
+        "ScaleUnit": "1per cache access"
+    },
+    {
+        "MetricName": "ll_cache_read_miss_ratio",
+        "MetricExpr": "(LL_CACHE_MISS_RD / LL_CACHE_RD)",
+        "BriefDescription": "This metric measures the ratio of last level cache read accesses missed to the total number of last level cache accesses. This gives an indication of the effectiveness of the last level cache for read traffic. Note that cache accesses in this cache are either data memory access or instruction fetch as this is a system level cache.",
+        "MetricGroup": "Miss_Ratio;LL_Cache_Effectiveness",
+        "ScaleUnit": "1per cache access"
+    },
+    {
+        "MetricName": "ll_cache_read_mpki",
+        "MetricExpr": "((LL_CACHE_MISS_RD / INST_RETIRED) * 1000)",
+        "BriefDescription": "This metric measures the number of last level cache read accesses missed per thousand instructions executed.",
+        "MetricGroup": "MPKI;LL_Cache_Effectiveness",
+        "ScaleUnit": "1MPKI"
+    },
+    {
+        "MetricName": "load_percentage",
+        "MetricExpr": "((LD_SPEC / INST_SPEC) * 100)",
+        "BriefDescription": "This metric measures load operations as a percentage of operations speculatively executed.",
+        "MetricGroup": "Operation_Mix",
+        "ScaleUnit": "1percent of operations"
+    },
+    {
+        "ArchStdEvent": "retiring"
+    },
+    {
+        "MetricName": "scalar_fp_percentage",
+        "MetricExpr": "((VFP_SPEC / INST_SPEC) * 100)",
+        "BriefDescription": "This metric measures scalar floating point operations as a percentage of operations speculatively executed.",
+        "MetricGroup": "Operation_Mix",
+        "ScaleUnit": "1percent of operations"
+    },
+    {
+        "MetricName": "simd_percentage",
+        "MetricExpr": "((ASE_SPEC / INST_SPEC) * 100)",
+        "BriefDescription": "This metric measures advanced SIMD operations as a percentage of total operations speculatively executed.",
+        "MetricGroup": "Operation_Mix",
+        "ScaleUnit": "1percent of operations"
+    },
+    {
+        "MetricName": "store_percentage",
+        "MetricExpr": "((ST_SPEC / INST_SPEC) * 100)",
+        "BriefDescription": "This metric measures store operations as a percentage of operations speculatively executed.",
+        "MetricGroup": "Operation_Mix",
+        "ScaleUnit": "1percent of operations"
+    }
+]
-- 
2.34.1

