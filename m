Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56F5779DA49
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 22:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbjILUxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 16:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjILUxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 16:53:05 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FDD199;
        Tue, 12 Sep 2023 13:53:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eul5Jmre/FqNAlwMoVHxIEw7oXRu/9an1A8bybpQhrMQZZNOJy1fL2ur8/unkusBuNGvirT2A99YV0P08GiZ4rcYGdzj2QnrmO+FRzwzGUwHAnDeeod66c5HykhvwiT3vRmUJH55VSsGgHMvL5X/aVyHgxj2zCac33/F9JYq2/jdCuBi7Biw8NEzMSMHMprDn+92bXi0y9Rk/oaVRoeRhmsHqzFtKPmSkyxvxUujpeAHyofDx9dFf0e+if9bkxicjigEUxGhX2oAasNHtPCu4WK+8hnpUccehuHoIwWTqqys54EC3HGnoKOnG2B+N5wn/sajQ0ITLD3P9O9Tc6IUQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y9H0QK3LwofR9C0D2qrsY7KOaVTaTFL6nHG8T70RBEU=;
 b=XCSM0aAc3oB+a4Q1BBYn8BD/9UR464oeM3uzBps4Ggi4YLo/IAZlpyLHe1wMDgnB/X7oSuefbnbVE+ShftSgEfMDvxf5V9/Iu+GWbZHGn5Y7dNkINwaAvrtHblHsE8i2ONkv0AbjSyHnROez3RTRM2661/tHiGz82FQ7zF0UQHQvOCfb9Y9sQvlmKHzMljVUVkAjRTDRfH6u6/6mmzXdwSyJWWqc641xjctBJ2aU0V4XueeupeXSL7rw0zM3TqMlN8qG3CfbbHUYHgYJaSM9xrK4H6pufucKBh/AQReSyPce5O4OgOxzZzTIcBqKP1ouubj+c1vxRRHlbkc0Y5PEqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9H0QK3LwofR9C0D2qrsY7KOaVTaTFL6nHG8T70RBEU=;
 b=aRVzgwsEuo/1rTRgSHDnK/Uv1oy8v1p3X6uh82Dgk6dvmwlHI8ge8Gb8wVj7tOvU6c+EgM9qfVzgD3Yqn7qn1ZldF5g/vibQL91k3MXBI6CqR6vT6xSi04fur6fYr9E54IKmYjAhNWUbWBp8WDRhdRc1Z6k9UAeNiU3/xN+84qM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 SJ0PR01MB7477.prod.exchangelabs.com (2603:10b6:a03:3e2::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.37; Tue, 12 Sep 2023 20:52:53 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::bfa4:8250:f526:5015]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::bfa4:8250:f526:5015%6]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 20:52:53 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     James Clark <james.clark@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc:     Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf vendor events arm64: Fix for AmpereOne metrics
Date:   Tue, 12 Sep 2023 13:52:12 -0700
Message-Id: <20230912205212.1281958-1-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR04CA0022.namprd04.prod.outlook.com
 (2603:10b6:610:52::32) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|SJ0PR01MB7477:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a30470e-588f-4f65-1590-08dbb3d23baa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hzP2l3nrznbG4slTcf+/e/k5oKIZJkwWx9U23yoAXtMZv6c3upNdt9MpIP0zHTF/meyyXiyqepbJapE/YdhzoAqpRiP4xxA+4FvnDa5HmhqOL1huYRS7t7LBqcNCs1uVITc/JcUbYHcW0rR8Z7OGWYIUxVh8hvqndvUAG8BqRvb4hRF+e+KRjW1FstB4ToWpM1CV6ZCyZkFsx6qVhMs0MamyhxOiPUTgTccxMljp0jzddYa7we8kD83ChYtBYMENI1y3hpguD1mZrIvA+h61xIthvzxujD8qJfMi0+oiH9qkhOkCEDV/UeqixukfE6jFRM4mJO9/GE/wd7wURI4km2gSiRm9FCjA/dZBD21TMURPQB8V2WSviuyH6vtdRILZR6AW26e5TkRrEnmxi3lLNj3Gi/eVjzfwRn+HZirLhY0thbMjv7Kbq+5FnZUIezSH74EcvtdJ5uHNpL7kTElZjy8URfN8tkW5eVHjWted8eZtjBBR5itl/bGTzNwrLMOHtDHK0Pf0MR/iaoBW/byUqyTNdBslzaLWJG7OQnAcJH9zSkgcHh6P3PGA0Lgxy8XZIzENII2G6Fe2dCe4oqFzuP95qxnjBfYEfsifguXbosbG7IdOoFDZk0hlJVx7zgYR2oLdx9O0xkv1B9CrvohXxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(39850400004)(136003)(376002)(451199024)(186009)(1800799009)(7049001)(6512007)(52116002)(6486002)(6506007)(1076003)(6666004)(2616005)(41300700001)(26005)(66556008)(66476007)(110136005)(316002)(5660300002)(8676002)(8936002)(4326008)(38100700002)(38350700002)(966005)(478600001)(54906003)(66946007)(83380400001)(30864003)(2906002)(7416002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6kSyL42lrxvHPF314GjI5TrT56IsC5jKtCiOw9aIdJttvEmG3M4VRQwj/tDP?=
 =?us-ascii?Q?ygt5LJk+qopP2bpZP7naLuKIblH42dIKbI3Qqobjzpp/eal6pi+KcXsCM3Di?=
 =?us-ascii?Q?rDFOsxoMijy/2WDLXu13837ef5y0mnJeBIofZpcwbTpEhufEWikeI3DUaus/?=
 =?us-ascii?Q?HMS2wGzBfkMw88QwYuAvPCmh21kHeXfBx3wU7jWp5K0DS/Q/A8f+NkAbrT4n?=
 =?us-ascii?Q?1sIGUZT2ru2JvQ5okkFoRY/YcZdwrjwVsUgAqixfMLXWd82wSE96iYkcUkNS?=
 =?us-ascii?Q?bHFsAUPSXLaSPwevsVQiky2H0sC7MMiTyxOiI1l3LKCvZZtARi3t7FyP+zpk?=
 =?us-ascii?Q?cpUskDbkU3mi/YT2aCtnaD4tvc76aU9T11bWdioAQGtPbBktvdaNMbGmZ921?=
 =?us-ascii?Q?M/MUGpjSwXYbF07RvSoTG3wf3vJAatfHK8JLwr7p3e9EW62CZT+Sznzp3Y5R?=
 =?us-ascii?Q?MM3Brqgbv1d3g7iM5j83cFWfhywbDdW9v8r7jJIGlTSnUSp4xw8M9lwgv8wO?=
 =?us-ascii?Q?Eq7gC9snGfqv+efQg+XPj8OQC7eSrIv/CqDHLN75Kq8d8v90USy0LI2vLSTF?=
 =?us-ascii?Q?UUF2eocMjPnp7JPztm8JzjpJMywwTxk9pQDAmQfPcm9vJEIaItQynvucXpRd?=
 =?us-ascii?Q?gKERqhQbxWDYtkf6D4UM327DspfNzptdWjkXQWOLuDMwyUz17fhoUty6fmXE?=
 =?us-ascii?Q?tJ1lnjhkqmeB3m5FOLeuDP55oX2pASFA9PZswK2A9yeRaQu+iW0hr9wIECnj?=
 =?us-ascii?Q?w0NISvq++GSd0td2FCHs+qcBrwuLjZkxScdRleU6H0DaH5DvJRb6rWZL3mX2?=
 =?us-ascii?Q?7U5W00NdaYANCuZ07bPCxZJASOdLzy08ko6zGNrDOPYAab848YcHhTAfXQ00?=
 =?us-ascii?Q?tho+d1jEGdNHe/WIgX8XMpBFDetxM6dNX6Q597pQ7rq7yXvzBdeLHHNn66Dy?=
 =?us-ascii?Q?9nwcusLSe+C4fa84ewGCEfLk1aim8eMRiNow+K+BvNP5cgLWfOObf8vko4G5?=
 =?us-ascii?Q?a7ekpcmMTEIMgVwySijP5NnEVV8ErEr74zwWHvRNsRMtoyRDuJ/YkhxoXHDD?=
 =?us-ascii?Q?vd9FvcFE9XM4t48Egal3ZTTlKx30fjTIcTwI8mctirujrlEobO2Ho+R3/M/I?=
 =?us-ascii?Q?KO01bM7jn2cp+Orz9nr5q90qbSQnCTqYUO9IwXPy/k7klRoJpzGUCD+GlnsI?=
 =?us-ascii?Q?tNA1ZDHWBEQHWPi9gvLPmnPwV6t8QrjlbrOxKJ9MxpzCHznY9CZYlrqVXea/?=
 =?us-ascii?Q?tCd+OJLpMaXIY+qlxHqZNtiI3IAvWrw3Q2iWlskLvkafK/RwGjeN41qsmd1W?=
 =?us-ascii?Q?5IjkgaIiS27UabTdJd72QSmXNtl8RAUCvFBBhIL4chxCm1t7/Kkdc16rOggQ?=
 =?us-ascii?Q?+Xq9+0bnRVQphI7yTbb9kwCYhr5bZgEwQWb8W8XlgKnKKImGhPRKjuP+YZdo?=
 =?us-ascii?Q?mmxwC/aa/cj9Tb2Y3YgfSUVN4U9sizJJJXEFSowyWoQRIGBAsJqyyGhKPqMs?=
 =?us-ascii?Q?AfvLv8Iy5hXaDVGgElQcYoSY80EWztaQdH9/UD/fax7BZcU4pMCMASpUYPLm?=
 =?us-ascii?Q?bCRJVSImZfJnruneqYr5rzyZBfNsqLzALa8UIFjzllBRN4wKP6ON+2254D8o?=
 =?us-ascii?Q?ifN5Hg/tu8/5TyazlGmgvN4=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a30470e-588f-4f65-1590-08dbb3d23baa
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 20:52:53.1099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hRwWHN7emsr1eVk/qLIqu3NP4FRCuoQFeyP2+mgHrdGbXBO8Buc3VhzR2J2mdLbnCV00p9yZ+r27NXYcVL6MWOB2p6Ject5tkLH+Du4Qg3dGkLUqcoeXOb7OTAKGX5RO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB7477
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch addresses review comments that were given for
'commit 705ed549148f ("perf vendor events arm64: Add AmpereOne metrics")'
but didn't make it to the original patch [1][2]

Changes include: A fix for backend_memory formula, use of standard metrics
when possible, using #slots, renaming metrics to avoid spaces in the names,
and cleanup.

[1] https://lore.kernel.org/linux-perf-users/e9bdacb-a231-36af-6a2e-6918ee7effa@os.amperecomputing.com/
[2] https://lore.kernel.org/linux-perf-users/20230826192352.3043220-1-ilkka@os.amperecomputing.com/

Fixes: 705ed549148f ("perf vendor events arm64: Add AmpereOne metrics")
Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 .../arch/arm64/ampere/ampereone/metrics.json  | 385 ++++++++++--------
 1 file changed, 207 insertions(+), 178 deletions(-)

diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json
index 1e7e8901a445..c3f9e03c338e 100644
--- a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json
+++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json
@@ -1,362 +1,391 @@
 [
     {
+	"MetricName": "branch_miss_pred_rate",
 	"MetricExpr": "BR_MIS_PRED / BR_PRED",
 	"BriefDescription": "Branch predictor misprediction rate. May not count branches that are never resolved because they are in the misprediction shadow of an earlier branch",
-	"MetricGroup": "Branch Prediction",
-	"MetricName": "Misprediction"
+	"MetricGroup": "branch",
+        "ScaleUnit": "100%"
     },
     {
-	"MetricExpr": "BR_MIS_PRED_RETIRED / BR_RETIRED",
-	"BriefDescription": "Branch predictor misprediction rate",
-	"MetricGroup": "Branch Prediction",
-	"MetricName": "Misprediction (retired)"
-    },
-    {
-	"MetricExpr": "BUS_ACCESS / ( BUS_CYCLES * 1)",
+	"MetricName": "bus_utilization",
+	"MetricExpr": "((BUS_ACCESS / (BUS_CYCLES * 1)) * 100)",
 	"BriefDescription": "Core-to-uncore bus utilization",
 	"MetricGroup": "Bus",
-	"MetricName": "Bus utilization"
+        "ScaleUnit": "1percent of bus cycles"
     },
     {
-	"MetricExpr": "L1D_CACHE_REFILL / L1D_CACHE",
-	"BriefDescription": "L1D cache miss rate",
-	"MetricGroup": "Cache",
-	"MetricName": "L1D cache miss"
+        "MetricName": "l1d_cache_miss_ratio",
+        "MetricExpr": "(L1D_CACHE_REFILL / L1D_CACHE)",
+        "BriefDescription": "This metric measures the ratio of level 1 data cache accesses missed to the total number of level 1 data cache accesses. This gives an indication of the effectiveness of the level 1 data cache.",
+        "MetricGroup": "Miss_Ratio;L1D_Cache_Effectiveness",
+        "ScaleUnit": "1per cache access"
     },
     {
-	"MetricExpr": "L1D_CACHE_LMISS_RD / L1D_CACHE_RD",
-	"BriefDescription": "L1D cache read miss rate",
-	"MetricGroup": "Cache",
-	"MetricName": "L1D cache read miss"
+        "MetricName": "l1i_cache_miss_ratio",
+        "MetricExpr": "(L1I_CACHE_REFILL / L1I_CACHE)",
+        "BriefDescription": "This metric measures the ratio of level 1 instruction cache accesses missed to the total number of level 1 instruction cache accesses. This gives an indication of the effectiveness of the level 1 instruction cache.",
+        "MetricGroup": "Miss_Ratio;L1I_Cache_Effectiveness",
+        "ScaleUnit": "1per cache access"
     },
     {
-	"MetricExpr": "L1I_CACHE_REFILL / L1I_CACHE",
-	"BriefDescription": "L1I cache miss rate",
+	"MetricName": "Miss_Ratio;l1d_cache_read_miss",
+	"MetricExpr": "L1D_CACHE_LMISS_RD / L1D_CACHE_RD",
+	"BriefDescription": "L1D cache read miss rate",
 	"MetricGroup": "Cache",
-	"MetricName": "L1I cache miss"
+        "ScaleUnit": "1per cache read access"
     },
     {
-	"MetricExpr": "L2D_CACHE_REFILL / L2D_CACHE",
-	"BriefDescription": "L2 cache miss rate",
-	"MetricGroup": "Cache",
-	"MetricName": "L2 cache miss"
+        "MetricName": "l2_cache_miss_ratio",
+        "MetricExpr": "(L2D_CACHE_REFILL / L2D_CACHE)",
+        "BriefDescription": "This metric measures the ratio of level 2 cache accesses missed to the total number of level 2 cache accesses. This gives an indication of the effectiveness of the level 2 cache, which is a unified cache that stores both data and instruction. Note that cache accesses in this cache are either data memory access or instruction fetch as this is a unified cache.",
+        "MetricGroup": "Miss_Ratio;L2_Cache_Effectiveness",
+        "ScaleUnit": "1per cache access"
     },
     {
+	"MetricName": "l1i_cache_read_miss_rate",
 	"MetricExpr": "L1I_CACHE_LMISS / L1I_CACHE",
 	"BriefDescription": "L1I cache read miss rate",
 	"MetricGroup": "Cache",
-	"MetricName": "L1I cache read miss"
+        "ScaleUnit": "1per cache access"
     },
     {
+	"MetricName": "l2d_cache_read_miss_rate",
 	"MetricExpr": "L2D_CACHE_LMISS_RD / L2D_CACHE_RD",
 	"BriefDescription": "L2 cache read miss rate",
 	"MetricGroup": "Cache",
-	"MetricName": "L2 cache read miss"
+        "ScaleUnit": "1per cache read access"
     },
     {
-	"MetricExpr": "(L1D_CACHE_LMISS_RD * 1000) / INST_RETIRED",
+	"MetricName": "l1d_cache_miss_mpki",
+	"MetricExpr": "(L1D_CACHE_LMISS_RD * 1e3) / INST_RETIRED",
 	"BriefDescription": "Misses per thousand instructions (data)",
 	"MetricGroup": "Cache",
-	"MetricName": "MPKI data"
+        "ScaleUnit": "1MPKI"
     },
     {
-	"MetricExpr": "(L1I_CACHE_LMISS * 1000) / INST_RETIRED",
+	"MetricName": "l1i_cache_miss_mpki",
+	"MetricExpr": "(L1I_CACHE_LMISS * 1e3) / INST_RETIRED",
 	"BriefDescription": "Misses per thousand instructions (instruction)",
 	"MetricGroup": "Cache",
-	"MetricName": "MPKI instruction"
+        "ScaleUnit": "1MPKI"
     },
     {
-	"MetricExpr": "ASE_SPEC / OP_SPEC",
-	"BriefDescription": "Proportion of advanced SIMD data processing operations (excluding DP_SPEC/LD_SPEC) operations",
-	"MetricGroup": "Instruction",
-	"MetricName": "ASE mix"
+        "MetricName": "simd_percentage",
+        "MetricExpr": "((ASE_SPEC / INST_SPEC) * 100)",
+        "BriefDescription": "This metric measures advanced SIMD operations as a percentage of total operations speculatively executed.",
+        "MetricGroup": "Operation_Mix",
+        "ScaleUnit": "1percent of operations"
     },
     {
-	"MetricExpr": "CRYPTO_SPEC / OP_SPEC",
-	"BriefDescription": "Proportion of crypto data processing operations",
-	"MetricGroup": "Instruction",
-	"MetricName": "Crypto mix"
+        "MetricName": "crypto_percentage",
+        "MetricExpr": "((CRYPTO_SPEC / INST_SPEC) * 100)",
+        "BriefDescription": "This metric measures crypto operations as a percentage of operations speculatively executed.",
+        "MetricGroup": "Operation_Mix",
+        "ScaleUnit": "1percent of operations"
     },
     {
-	"MetricExpr": "VFP_SPEC / (duration_time *1000000000)",
-	"BriefDescription": "Giga-floating point operations per second",
-	"MetricGroup": "Instruction",
-	"MetricName": "GFLOPS_ISSUED"
+        "MetricName": "scalar_fp_percentage",
+        "MetricExpr": "((VFP_SPEC / INST_SPEC) * 100)",
+        "BriefDescription": "This metric measures scalar floating point operations as a percentage of operations speculatively executed.",
+        "MetricGroup": "Operation_Mix",
+        "ScaleUnit": "1percent of operations"
     },
     {
-	"MetricExpr": "DP_SPEC / OP_SPEC",
-	"BriefDescription": "Proportion of integer data processing operations",
-	"MetricGroup": "Instruction",
-	"MetricName": "Integer mix"
+	"MetricName": "gflops",
+	"MetricExpr": "VFP_SPEC / (duration_time * 1e9)",
+	"BriefDescription": "Giga-floating point operations per second",
+	"MetricGroup": "InstructionMix"
     },
     {
-	"MetricExpr": "INST_RETIRED / CPU_CYCLES",
-	"BriefDescription": "Instructions per cycle",
-	"MetricGroup": "Instruction",
-	"MetricName": "IPC"
+        "MetricName": "integer_dp_percentage",
+        "MetricExpr": "((DP_SPEC / INST_SPEC) * 100)",
+        "BriefDescription": "This metric measures scalar integer operations as a percentage of operations speculatively executed.",
+        "MetricGroup": "Operation_Mix",
+        "ScaleUnit": "1percent of operations"
     },
     {
-	"MetricExpr": "LD_SPEC / OP_SPEC",
-	"BriefDescription": "Proportion of load operations",
-	"MetricGroup": "Instruction",
-	"MetricName": "Load mix"
+        "MetricName": "ipc",
+        "MetricExpr": "(INST_RETIRED / CPU_CYCLES)",
+        "BriefDescription": "This metric measures the number of instructions retired per cycle.",
+        "MetricGroup": "General",
+        "ScaleUnit": "1per cycle"
     },
     {
-	"MetricExpr": "LDST_SPEC/ OP_SPEC",
-	"BriefDescription": "Proportion of load & store operations",
-	"MetricGroup": "Instruction",
-	"MetricName": "Load-store mix"
+        "MetricName": "load_percentage",
+        "MetricExpr": "((LD_SPEC / INST_SPEC) * 100)",
+        "BriefDescription": "This metric measures load operations as a percentage of operations speculatively executed.",
+        "MetricGroup": "Operation_Mix",
+        "ScaleUnit": "1percent of operations"
     },
     {
-	"MetricExpr": "INST_RETIRED / (duration_time * 1000000)",
-	"BriefDescription": "Millions of instructions per second",
-	"MetricGroup": "Instruction",
-	"MetricName": "MIPS_RETIRED"
+	"MetricName": "load_store_spec_rate",
+	"MetricExpr": "((LDST_SPEC / INST_SPEC) * 100)",
+	"BriefDescription": "The rate of load or store instructions speculatively executed to overall instructions speclatively executed",
+        "MetricGroup": "Operation_Mix",
+        "ScaleUnit": "1percent of operations"
     },
     {
-	"MetricExpr": "INST_SPEC / (duration_time * 1000000)",
+	"MetricName": "retired_mips",
+	"MetricExpr": "INST_RETIRED / (duration_time * 1e6)",
 	"BriefDescription": "Millions of instructions per second",
-	"MetricGroup": "Instruction",
-	"MetricName": "MIPS_UTILIZATION"
-    },
-    {
-	"MetricExpr": "PC_WRITE_SPEC / OP_SPEC",
-	"BriefDescription": "Proportion of software change of PC operations",
-	"MetricGroup": "Instruction",
-	"MetricName": "PC write mix"
+	"MetricGroup": "InstructionMix"
     },
     {
-	"MetricExpr": "ST_SPEC / OP_SPEC",
-	"BriefDescription": "Proportion of store operations",
-	"MetricGroup": "Instruction",
-	"MetricName": "Store mix"
+	"MetricName": "spec_utilization_mips",
+	"MetricExpr": "INST_SPEC / (duration_time * 1e6)",
+	"BriefDescription": "Millions of instructions per second",
+	"MetricGroup": "PEutilization"
     },
     {
-	"MetricExpr": "VFP_SPEC / OP_SPEC",
-	"BriefDescription": "Proportion of FP operations",
-	"MetricGroup": "Instruction",
-	"MetricName": "VFP mix"
+	"MetricName": "pc_write_spec_rate",
+	"MetricExpr": "((PC_WRITE_SPEC / INST_SPEC) * 100)",
+	"BriefDescription": "The rate of software change of the PC speculatively executed to overall instructions speclatively executed",
+        "MetricGroup": "Operation_Mix",
+        "ScaleUnit": "1percent of operations"
     },
     {
-	"MetricExpr": "1 - (OP_RETIRED/ (CPU_CYCLES * 4))",
-	"BriefDescription": "Proportion of slots lost",
-	"MetricGroup": "Speculation / TDA",
-	"MetricName": "CPU lost"
+        "MetricName": "store_percentage",
+        "MetricExpr": "((ST_SPEC / INST_SPEC) * 100)",
+        "BriefDescription": "This metric measures store operations as a percentage of operations speculatively executed.",
+        "MetricGroup": "Operation_Mix",
+        "ScaleUnit": "1percent of operations"
     },
     {
-	"MetricExpr": "OP_RETIRED/ (CPU_CYCLES * 4)",
-	"BriefDescription": "Proportion of slots retiring",
-	"MetricGroup": "Speculation / TDA",
-	"MetricName": "CPU utilization"
+        "MetricName": "scalar_fp_percentage",
+        "MetricExpr": "((VFP_SPEC / INST_SPEC) * 100)",
+        "BriefDescription": "This metric measures scalar floating point operations as a percentage of operations speculatively executed.",
+        "MetricGroup": "Operation_Mix",
+        "ScaleUnit": "1percent of operations"
     },
     {
-	"MetricExpr": "OP_RETIRED - OP_SPEC",
-	"BriefDescription": "Operations lost due to misspeculation",
-	"MetricGroup": "Speculation / TDA",
-	"MetricName": "Operations lost"
+        "MetricName": "retired_rate",
+        "MetricExpr": "OP_RETIRED / OP_SPEC",
+        "BriefDescription": "Of all the micro-operations issued, what percentage are retired(committed)",
+        "MetricGroup": "General",
+        "ScaleUnit": "100%"
     },
     {
-	"MetricExpr": "1 - (OP_RETIRED / OP_SPEC)",
-	"BriefDescription": "Proportion of operations lost",
-	"MetricGroup": "Speculation / TDA",
-	"MetricName": "Operations lost (ratio)"
+	"MetricName": "wasted",
+	"MetricExpr": "1 - (OP_RETIRED / (CPU_CYCLES * #slots))",
+        "BriefDescription": "Of all the micro-operations issued, what proportion are lost",
+	"MetricGroup": "General",
+	"ScaleUnit": "100%"
     },
     {
-	"MetricExpr": "OP_RETIRED / OP_SPEC",
-	"BriefDescription": "Proportion of operations retired",
-	"MetricGroup": "Speculation / TDA",
-	"MetricName": "Operations retired"
+        "MetricName": "wasted_rate",
+        "MetricExpr": "1 - OP_RETIRED / OP_SPEC",
+        "BriefDescription": "Of all the micro-operations issued, what percentage are not retired(committed)",
+        "MetricGroup": "General",
+        "ScaleUnit": "100%"
     },
     {
-	"MetricExpr": "STALL_BACKEND_CACHE / CPU_CYCLES",
+	"MetricName": "stall_backend_cache_rate",
+	"MetricExpr": "((STALL_BACKEND_CACHE / CPU_CYCLES) * 100)",
 	"BriefDescription": "Proportion of cycles stalled and no operations issued to backend and cache miss",
 	"MetricGroup": "Stall",
-	"MetricName": "Stall backend cache cycles"
+        "ScaleUnit": "1percent of cycles"
     },
     {
-	"MetricExpr": "STALL_BACKEND_RESOURCE / CPU_CYCLES",
+	"MetricName": "stall_backend_resource_rate",
+	"MetricExpr": "((STALL_BACKEND_RESOURCE / CPU_CYCLES) * 100)",
 	"BriefDescription": "Proportion of cycles stalled and no operations issued to backend and resource full",
 	"MetricGroup": "Stall",
-	"MetricName": "Stall backend resource cycles"
+        "ScaleUnit": "1percent of cycles"
     },
     {
-	"MetricExpr": "STALL_BACKEND_TLB / CPU_CYCLES",
+	"MetricName": "stall_backend_tlb_rate",
+	"MetricExpr": "((STALL_BACKEND_TLB / CPU_CYCLES) * 100)",
 	"BriefDescription": "Proportion of cycles stalled and no operations issued to backend and TLB miss",
 	"MetricGroup": "Stall",
-	"MetricName": "Stall backend tlb cycles"
+        "ScaleUnit": "1percent of cycles"
     },
     {
-	"MetricExpr": "STALL_FRONTEND_CACHE / CPU_CYCLES",
+	"MetricName": "stall_frontend_cache_rate",
+	"MetricExpr": "((STALL_FRONTEND_CACHE / CPU_CYCLES) * 100)",
 	"BriefDescription": "Proportion of cycles stalled and no ops delivered from frontend and cache miss",
 	"MetricGroup": "Stall",
-	"MetricName": "Stall frontend cache cycles"
+        "ScaleUnit": "1percent of cycles"
     },
     {
-	"MetricExpr": "STALL_FRONTEND_TLB / CPU_CYCLES",
+	"MetricName": "stall_frontend_tlb_rate",
+	"MetricExpr": "((STALL_FRONTEND_TLB / CPU_CYCLES) * 100)",
 	"BriefDescription": "Proportion of cycles stalled and no ops delivered from frontend and TLB miss",
 	"MetricGroup": "Stall",
-	"MetricName": "Stall frontend tlb cycles"
+        "ScaleUnit": "1percent of cycles"
     },
     {
-	"MetricExpr": "DTLB_WALK / L1D_TLB",
-	"BriefDescription": "D-side walk per d-side translation request",
-	"MetricGroup": "TLB",
-	"MetricName": "DTLB walks"
+        "MetricName": "dtlb_walk_ratio",
+        "MetricExpr": "(DTLB_WALK / L1D_TLB)",
+        "BriefDescription": "This metric measures the ratio of data TLB Walks to the total number of data TLB accesses. This gives an indication of the effectiveness of the data TLB accesses.",
+        "MetricGroup": "Miss_Ratio;DTLB_Effectiveness",
+        "ScaleUnit": "1per TLB access"
     },
     {
-	"MetricExpr": "ITLB_WALK / L1I_TLB",
-	"BriefDescription": "I-side walk per i-side translation request",
-	"MetricGroup": "TLB",
-	"MetricName": "ITLB walks"
+        "MetricName": "itlb_walk_ratio",
+        "MetricExpr": "(ITLB_WALK / L1I_TLB)",
+        "BriefDescription": "This metric measures the ratio of instruction TLB Walks to the total number of instruction TLB accesses. This gives an indication of the effectiveness of the instruction TLB accesses.",
+        "MetricGroup": "Miss_Ratio;ITLB_Effectiveness",
+        "ScaleUnit": "1per TLB access"
     },
     {
-        "MetricExpr": "STALL_SLOT_BACKEND / (CPU_CYCLES * 4)",
-        "BriefDescription": "Fraction of slots backend bound",
-        "MetricGroup": "TopDownL1",
-        "MetricName": "backend"
+        "ArchStdEvent": "backend_bound"
     },
     {
-        "MetricExpr": "1 - (retiring + lost + backend)",
-        "BriefDescription": "Fraction of slots frontend bound",
-        "MetricGroup": "TopDownL1",
-        "MetricName": "frontend"
+        "ArchStdEvent": "frontend_bound",
+        "MetricExpr": "1 - (retired_fraction + slots_lost_misspeculation_fraction + backend_bound)"
     },
     {
-        "MetricExpr": "((OP_SPEC - OP_RETIRED) / (CPU_CYCLES * 4))",
+        "MetricName": "slots_lost_misspeculation_fraction",
+        "MetricExpr": "100 * ((OP_SPEC - OP_RETIRED) / (CPU_CYCLES * #slots))",
         "BriefDescription": "Fraction of slots lost due to misspeculation",
-        "MetricGroup": "TopDownL1",
-        "MetricName": "lost"
+        "MetricGroup": "Default;TopDownL1",
+        "ScaleUnit": "1percent of slots"
     },
     {
-        "MetricExpr": "(OP_RETIRED / (CPU_CYCLES * 4))",
+        "MetricName": "retired_fraction",
+        "MetricExpr": "100 * (OP_RETIRED / (CPU_CYCLES * #slots))",
         "BriefDescription": "Fraction of slots retiring, useful work",
-        "MetricGroup": "TopDownL1",
-        "MetricName": "retiring"
+        "MetricGroup": "Default;TopDownL1",
+	"ScaleUnit": "1percent of slots"
     },
     {
-        "MetricExpr": "backend - backend_memory",
+        "MetricName": "backend_core",
+        "MetricExpr": "backend_bound - backend_memory",
         "BriefDescription": "Fraction of slots the CPU was stalled due to backend non-memory subsystem issues",
         "MetricGroup": "TopDownL2",
-        "MetricName": "backend_core"
+        "ScaleUnit": "100%"
     },
     {
-        "MetricExpr": "(STALL_BACKEND_TLB + STALL_BACKEND_CACHE + STALL_BACKEND_MEM) / CPU_CYCLES ",
+        "MetricName": "backend_memory",
+        "MetricExpr": "(STALL_BACKEND_TLB + STALL_BACKEND_CACHE) / CPU_CYCLES",
         "BriefDescription": "Fraction of slots the CPU was stalled due to backend memory subsystem issues (cache/tlb miss)",
         "MetricGroup": "TopDownL2",
-        "MetricName": "backend_memory"
+        "ScaleUnit": "100%"
     },
     {
-        "MetricExpr": " (BR_MIS_PRED_RETIRED / GPC_FLUSH) * lost",
+        "MetricName": "branch_mispredict",
+        "MetricExpr": "(BR_MIS_PRED_RETIRED / GPC_FLUSH) * slots_lost_misspeculation_fraction",
         "BriefDescription": "Fraction of slots lost due to branch misprediciton",
         "MetricGroup": "TopDownL2",
-        "MetricName": "branch_mispredict"
+        "ScaleUnit": "1percent of slots"
     },
     {
-        "MetricExpr": "frontend - frontend_latency",
+        "MetricName": "frontend_bandwidth",
+        "MetricExpr": "frontend_bound - frontend_latency",
         "BriefDescription": "Fraction of slots the CPU did not dispatch at full bandwidth - able to dispatch partial slots only (1, 2, or 3 uops)",
         "MetricGroup": "TopDownL2",
-        "MetricName": "frontend_bandwidth"
+        "ScaleUnit": "1percent of slots"
     },
     {
-        "MetricExpr": "(STALL_FRONTEND - ((STALL_SLOT_FRONTEND - (frontend * CPU_CYCLES * 4)) / 4)) / CPU_CYCLES",
+        "MetricName": "frontend_latency",
+        "MetricExpr": "(STALL_FRONTEND - ((STALL_SLOT_FRONTEND - (frontend_bound * CPU_CYCLES * #slots)) / #slots)) / CPU_CYCLES",
         "BriefDescription": "Fraction of slots the CPU was stalled due to frontend latency issues (cache/tlb miss); nothing to dispatch",
         "MetricGroup": "TopDownL2",
-        "MetricName": "frontend_latency"
+        "ScaleUnit": "1percent of slots"
     },
     {
-        "MetricExpr": "lost - branch_mispredict",
+        "MetricName": "other_miss_pred",
+        "MetricExpr": "slots_lost_misspeculation_fraction - branch_mispredict",
         "BriefDescription": "Fraction of slots lost due to other/non-branch misprediction misspeculation",
         "MetricGroup": "TopDownL2",
-        "MetricName": "other_clears"
+        "ScaleUnit": "1percent of slots"
     },
     {
-        "MetricExpr": "(IXU_NUM_UOPS_ISSUED + FSU_ISSUED) / (CPU_CYCLES * 6)",
+        "MetricName": "pipe_utilization",
+        "MetricExpr": "100 * ((IXU_NUM_UOPS_ISSUED + FSU_ISSUED) / (CPU_CYCLES * 6))",
         "BriefDescription": "Fraction of execute slots utilized",
         "MetricGroup": "TopDownL2",
-        "MetricName": "pipe_utilization"
+        "ScaleUnit": "1percent of slots"
     },
     {
-        "MetricExpr": "STALL_BACKEND_MEM / CPU_CYCLES",
+        "MetricName": "d_cache_l2_miss_rate",
+        "MetricExpr": "((STALL_BACKEND_MEM / CPU_CYCLES) * 100)",
         "BriefDescription": "Fraction of cycles the CPU was stalled due to data L2 cache miss",
         "MetricGroup": "TopDownL3",
-        "MetricName": "d_cache_l2_miss"
+        "ScaleUnit": "1percent of cycles"
     },
     {
-        "MetricExpr": "STALL_BACKEND_CACHE / CPU_CYCLES",
+        "MetricName": "d_cache_miss_rate",
+        "MetricExpr": "((STALL_BACKEND_CACHE / CPU_CYCLES) * 100)",
         "BriefDescription": "Fraction of cycles the CPU was stalled due to data cache miss",
         "MetricGroup": "TopDownL3",
-        "MetricName": "d_cache_miss"
+        "ScaleUnit": "1percent of cycles"
     },
     {
-        "MetricExpr": "STALL_BACKEND_TLB / CPU_CYCLES",
+        "MetricName": "d_tlb_miss_rate",
+        "MetricExpr": "((STALL_BACKEND_TLB / CPU_CYCLES) * 100)",
         "BriefDescription": "Fraction of cycles the CPU was stalled due to data TLB miss",
         "MetricGroup": "TopDownL3",
-        "MetricName": "d_tlb_miss"
+        "ScaleUnit": "1percent of cycles"
     },
     {
-        "MetricExpr": "FSU_ISSUED / (CPU_CYCLES * 2)",
+        "MetricName": "fsu_pipe_utilization",
+        "MetricExpr": "((FSU_ISSUED / (CPU_CYCLES * 2)) * 100)",
         "BriefDescription": "Fraction of FSU execute slots utilized",
         "MetricGroup": "TopDownL3",
-        "MetricName": "fsu_pipe_utilization"
+        "ScaleUnit": "1percent of slots"
     },
     {
-        "MetricExpr": "STALL_FRONTEND_CACHE / CPU_CYCLES",
+        "MetricName": "i_cache_miss_rate",
+        "MetricExpr": "((STALL_FRONTEND_CACHE / CPU_CYCLES) * 100)",
         "BriefDescription": "Fraction of cycles the CPU was stalled due to instruction cache miss",
         "MetricGroup": "TopDownL3",
-        "MetricName": "i_cache_miss"
+        "ScaleUnit": "1percent of slots"
     },
     {
-        "MetricExpr": " STALL_FRONTEND_TLB / CPU_CYCLES ",
+        "MetricName": "i_tlb_miss_rate",
+        "MetricExpr": "((STALL_FRONTEND_TLB / CPU_CYCLES) * 100)",
         "BriefDescription": "Fraction of cycles the CPU was stalled due to instruction TLB miss",
         "MetricGroup": "TopDownL3",
-        "MetricName": "i_tlb_miss"
+        "ScaleUnit": "1percent of slots"
     },
     {
-        "MetricExpr": "IXU_NUM_UOPS_ISSUED / (CPU_CYCLES / 4)",
+        "MetricName": "ixu_pipe_utilization",
+        "MetricExpr": "((IXU_NUM_UOPS_ISSUED / (CPU_CYCLES * #slots)) * 100)",
         "BriefDescription": "Fraction of IXU execute slots utilized",
         "MetricGroup": "TopDownL3",
-        "MetricName": "ixu_pipe_utilization"
+        "ScaleUnit": "1percent of slots"
     },
     {
-        "MetricExpr": "IDR_STALL_FLUSH / CPU_CYCLES",
+        "MetricName": "stall_recovery_rate",
+        "MetricExpr": "((IDR_STALL_FLUSH / CPU_CYCLES) * 100)",
         "BriefDescription": "Fraction of cycles the CPU was stalled due to flush recovery",
         "MetricGroup": "TopDownL3",
-        "MetricName": "recovery"
-    },
-    {
-        "MetricExpr": "STALL_BACKEND_RESOURCE / CPU_CYCLES",
-        "BriefDescription": "Fraction of cycles the CPU was stalled due to core resource shortage",
-        "MetricGroup": "TopDownL3",
-        "MetricName": "resource"
+        "ScaleUnit": "1percent of slots"
     },
     {
-        "MetricExpr": "IDR_STALL_FSU_SCHED / CPU_CYCLES ",
+        "MetricName": "stall_fsu_sched_rate",
+        "MetricExpr": "((IDR_STALL_FSU_SCHED / CPU_CYCLES) * 100)",
         "BriefDescription": "Fraction of cycles the CPU was stalled and FSU was full",
         "MetricGroup": "TopDownL4",
-        "MetricName": "stall_fsu_sched"
+        "ScaleUnit": "1percent of cycles"
     },
     {
-        "MetricExpr": "IDR_STALL_IXU_SCHED / CPU_CYCLES ",
+        "MetricName": "stall_ixu_sched_rate",
+        "MetricExpr": "((IDR_STALL_IXU_SCHED / CPU_CYCLES) * 100)",
         "BriefDescription": "Fraction of cycles the CPU was stalled and IXU was full",
         "MetricGroup": "TopDownL4",
-        "MetricName": "stall_ixu_sched"
+        "ScaleUnit": "1percent of cycles"
     },
     {
-        "MetricExpr": "IDR_STALL_LOB_ID / CPU_CYCLES ",
+        "MetricName": "stall_lob_id_rate",
+        "MetricExpr": "((IDR_STALL_LOB_ID / CPU_CYCLES) * 100)",
         "BriefDescription": "Fraction of cycles the CPU was stalled and LOB was full",
         "MetricGroup": "TopDownL4",
-        "MetricName": "stall_lob_id"
+        "ScaleUnit": "1percent of cycles"
     },
     {
-        "MetricExpr": "IDR_STALL_ROB_ID / CPU_CYCLES",
+        "MetricName": "stall_rob_id_rate",
+        "MetricExpr": "((IDR_STALL_ROB_ID / CPU_CYCLES) * 100)",
         "BriefDescription": "Fraction of cycles the CPU was stalled and ROB was full",
         "MetricGroup": "TopDownL4",
-        "MetricName": "stall_rob_id"
+        "ScaleUnit": "1percent of cycles"
     },
     {
-        "MetricExpr": "IDR_STALL_SOB_ID / CPU_CYCLES ",
+        "MetricName": "stall_sob_id_rate",
+        "MetricExpr": "((IDR_STALL_SOB_ID / CPU_CYCLES) * 100)",
         "BriefDescription": "Fraction of cycles the CPU was stalled and SOB was full",
         "MetricGroup": "TopDownL4",
-        "MetricName": "stall_sob_id"
+        "ScaleUnit": "1percent of cycles"
     }
 ]
-- 
2.40.1

