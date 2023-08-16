Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277AC77E0EF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 13:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244871AbjHPLyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 07:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245003AbjHPLys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 07:54:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2DE842690;
        Wed, 16 Aug 2023 04:54:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C65F01063;
        Wed, 16 Aug 2023 04:54:27 -0700 (PDT)
Received: from e127643.arm.com (unknown [10.57.4.137])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3854E3F6C4;
        Wed, 16 Aug 2023 04:53:43 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-perf-users@vger.kernel.org, irogers@google.com,
        john.g.garry@oracle.com, renyu.zj@linux.alibaba.com,
        acme@kernel.org
Cc:     James Clark <james.clark@arm.com>, Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Haixin Yu <yuhaixin.yhx@linux.alibaba.com>,
        Nick Forrington <nick.forrington@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Sohom Datta <sohomdatta1@gmail.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 5/6] perf vendor events arm64: Update stall_slot workaround for N2 r0p3
Date:   Wed, 16 Aug 2023 12:47:47 +0100
Message-Id: <20230816114841.1679234-6-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816114841.1679234-1-james.clark@arm.com>
References: <20230816114841.1679234-1-james.clark@arm.com>
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
longer works because all N2s have 5 slots. Use the new expression
builtin that allows calling strcmp_cpuid_str() and comparing CPUIDs in
metric formulas.

In this case, the commented formula looks like this:

  strcmp_cpuid_str(0x410fd493)        # greater than or equal to N2 r0p3
  | strcmp_cpuid_str(0x410fd490) ^ 1  # OR NOT any version of N2

[1]: https://gitlab.arm.com/telemetry-solution/telemetry-solution/-/blob/main/data/pmu/cpu/neoverse/neoverse-n2-r0p3.json
Signed-off-by: James Clark <james.clark@arm.com>
---
 .../pmu-events/arch/arm64/arm/neoverse-n2-v2/metrics.json | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

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
-- 
2.34.1

