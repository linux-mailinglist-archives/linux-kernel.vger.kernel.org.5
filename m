Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16DD77A72B6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 08:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbjITGTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 02:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233174AbjITGTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 02:19:47 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2130.outbound.protection.outlook.com [40.107.237.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3C5A1;
        Tue, 19 Sep 2023 23:19:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mGEsE6d4DacTOJLLMisZhiHCYq2FmSoOXBx2ctvGViD51+8TvTjQI0sbtq1lrqwViJjM/cue5zATu2VrmSxgF7uE9tq0MHrBjBPWTblUfweKjj9J2ue5E8Q65ogBY1vInR2v/+qJuOBIr0Om+cdWBgNhq/GfyX6LWuSKKh+8nOEegBGpm3Qncg8X179SAPz36xMEzLOcvnQ2wtqW0ju2tX+1SrNP/atyXx0dd+SpLcafoqvEzZvlcoNPmrLFZjo7fJPvwUpjoO5Pqk2ElleIwfEzzLWCQghLPNLL17SjwDF4hineq8DIC3Ds8lk0vNRrcQg2EosHeNjSFF/GVWT2NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bq+n/3d5A+JaKTad/kJZXGrRevhBzuByM/PGWpLtlbI=;
 b=WcUYm9YnrXlK8Y4QHOxwarrg11ex/2BIjZaqFSePltyai8mLQIL6cxr1ntmJ8K7l2bPg1/Fc7MSVSvgKeUD44fKg5UPWF9EMR/xUriz88xcSJ5Gk+cdMNAaeSoMZhZ5yN0XUThLKMOHIRdiLXw9z7Ywf/ki9n8cTogLyKguQh4aDgImmGnhstY2TBObsyMrPLtIxL9wPSOhbh9leECayDaoXInGu7/MDTPib4t9ZJhRfkRTtRoPRfjFpkCA5D7en0L0Qf+x7RMdXc9rS+ymSkDENi0E1QHiJ8LlSHNC7Nv1rngv1lpQZuWtIGqh+H6UH/oWlbYnP6kGHJz3IjgVunQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bq+n/3d5A+JaKTad/kJZXGrRevhBzuByM/PGWpLtlbI=;
 b=iz0U+KuSt0c2cF3wNpTamMaNVwRljou7qAhOElQ/EF100cfgNLuDcip4krPBX+yAmVQamMR8Cl8dPGoNyS4bY1wZL7CoQJQMjrcyA3rp/4yh6brCtYSlHDXkifLmNGyoHUCW4cnIbfp61JYZIu+jynlRURKmoUn6LBWxBjLe2vs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 BL1PR01MB7818.prod.exchangelabs.com (2603:10b6:208:39a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.21; Wed, 20 Sep 2023 06:19:10 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::bfa4:8250:f526:5015]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::bfa4:8250:f526:5015%6]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 06:19:10 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     James Clark <james.clark@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Will Deacon <will@kernel.org>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        D Scott Phillips <scott@os.amperecomputing.com>
Cc:     Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linaro.org>,
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
Subject: [PATCH v2] perf vendor events arm64: Fix for AmpereOne metrics
Date:   Tue, 19 Sep 2023 23:18:39 -0700
Message-Id: <20230920061839.2437413-1-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0P220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::18) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|BL1PR01MB7818:EE_
X-MS-Office365-Filtering-Correlation-Id: 61682014-06bf-41ce-9da7-08dbb9a1804e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t3mtJu30d13xixbPb93Jgl8qrAxGsq7qAyoM3NqU8PneuiIH+/T+ScONuRv3Td09/Vek7AELLrgdSPj4Ads7IU/yae5rsH1ZxZTprkKUnypBRZ1U/9mksNtAFMartfe7tGHa2RIx2T+Lg/jBVPeHgxvJBSzPXZel+UI3EfY2p+O/Oj0BMSyRvy9oz8Pg8ZPX4PfTCa89BHLbQmoz+HcIqeEg9aVBwjhWgv7fLwV1B7BdPCHSl9dA1eSyqzlDs/D+2MlUczs1WFTWXJxQ3yni2wYa6ir4LlnM0BzU8ZkIWAF5aQ1P/iVHY8Rrnvjld8IxbeScxFDQ5pVTsDpQ98bE56RbUUGyVxql//5UZGFQCzZqz3etm0Y9VKxFGOOFaxcG1B0lHTiRP/rNIT9doAfdhAz5YIn/IcNISEqGmQbpvWhflzMXCJZykIcr8YnVm6KJA7cCHcGL85IPfth+YC9E9Ape6tiy8yg2o1okyqnD3299v4D951JeJdJfi3LfJ1ttRva5xq7maitVw34fWq4FlkMCHkVCIGk1VS3p/tLUxZbWkX5ONMICvDbYNotBZVXfP3zJtgqbQm9x2ssD2HCatT42+hkkjBPhHjAkSta4H8k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(376002)(346002)(39850400004)(1800799009)(186009)(451199024)(66556008)(54906003)(66476007)(110136005)(5660300002)(66946007)(8676002)(41300700001)(8936002)(83380400001)(316002)(38350700002)(6486002)(6512007)(966005)(6666004)(478600001)(38100700002)(6506007)(52116002)(6636002)(26005)(4326008)(1076003)(2906002)(30864003)(7416002)(86362001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FHI9DffbC9gaXoZKQfS0/mVYmNi4x2fZ9p/stXUKZXkJ/zIImEigj+ID+hEJ?=
 =?us-ascii?Q?JqadpR6SRqmWyLIiNYhCbqUrmsyIUAWToY89gz7/SOnKoEST+MDpNmaRg6EQ?=
 =?us-ascii?Q?VVxzXytgltBd6TCS2fi96wbA599J+gViSZ6S0me47kxE4+Nkusedsbr/84Lv?=
 =?us-ascii?Q?n+DNpkHnfCRMRt2dkVog3kjZAaX+Td8hI4ouoyTjCczKK77RzxcjKk0Qm0Gb?=
 =?us-ascii?Q?tSli3VfDFDmZQWCT+GVDwG7IPACsA/NtSXtZKBbHTrcmNugG82HzN488H0H/?=
 =?us-ascii?Q?CLoTtmrFDfcI0f9n6TFCXEl4MhY8Z0tpCRsrtglk0Pp6KZtW9/rMgKjfyQcf?=
 =?us-ascii?Q?RuhvbNmIDD/qjUYthMfHXpdcESPQ7BT+OK0Mj7xDn5l+idD/AIzGSMTGKbPF?=
 =?us-ascii?Q?01WhIQNOyF/kiKWrN9tkGz1sVsefyh8TLdQZxRJqh8kI3V4a8dT1phmRv0T+?=
 =?us-ascii?Q?dZFJk78a8ySX3pIehstj0NXaGq4ruwqM0mxilYi2+TAsWPVIYEB6tHi5yDqm?=
 =?us-ascii?Q?Ixg3fd70u+23Zd6/1wjvS9iPHxDgE27a+uL9Nid/Y4yDV9VH3f6I5DnjJ2QV?=
 =?us-ascii?Q?NG6M81dBi5eLYU1VQFHr5isC1Y+8umj+E+PYqtJxeyeUwT8pJDplbUb1WqhZ?=
 =?us-ascii?Q?oBedDuJxTgpSPy2aL+EKelD9MC93dV+FJfRNW2trk+TKuZpTpzh41D28232X?=
 =?us-ascii?Q?K2jaD8ueMf3YGnfJ6dMc8f4tA/OH1FloU67qc1q07Ys4LiVO3nCvZj9MPhm3?=
 =?us-ascii?Q?Ah1IYDk/TcUSrdulEkkxhba5gD31dSb1nibuNyoa/f6s101N982CEiTElnR+?=
 =?us-ascii?Q?0yg2axjlxAMVs1nB9vFLZqz6orbR2GzgKO1FXED9bclzlK41/+jqzFtxMGyj?=
 =?us-ascii?Q?hht+J4M0P42fmxCp7Bw7lk/zxXU1l8isLSHX8Jd7prLCS7Jm+x36W2QVYur9?=
 =?us-ascii?Q?RQzmQytIq2t7Qp41lbmIxPPa0hjd9izdYCUO1i42MvNmcvFZM0+U5FyE04Nu?=
 =?us-ascii?Q?+YsM7pNnLQVWK4vs1R4+NGeiqXe5SlIDQyayu4mPOpeuXFWXclGmuwh9s4Jd?=
 =?us-ascii?Q?03Brxq2CDK0Xq+DxtuDoaKWzQ8RFYqjbbNnXlqOaYvqLRW3hZLB6Fmlh+ZYl?=
 =?us-ascii?Q?rmVx1eFHYzn6AqTLeN5jTIIOgHFz7NTv3WiSXP70gXQL202NVR4K3QKMgvUS?=
 =?us-ascii?Q?At7jlrzDa02kLNfx1GEelXD9/bZtG9VYUKrN6U2YrQ0g25mzv39yBWuNHH/k?=
 =?us-ascii?Q?Tr4RFxKSHDaP4uIW1pa1AxJPbTbzQ882FkoJqDtQNjtWbrLqnJhHmMznZLH6?=
 =?us-ascii?Q?4Hxs4ruLPKmfwMTt9EjxIYB5d9YQXxYRK45t+6fddVqFQQqWnEA9wDdkvGx8?=
 =?us-ascii?Q?6dQpoD0KfqtT2pWb0LJNKdeN+nNanIQJCg6seFE0MYvWvjShoNWAZ/e9gNkY?=
 =?us-ascii?Q?JnFlFb9G2dtMrfrNWoONLq6bzW2d2keXNpnQTBFY+xARqpy6LAbfKS25EHB4?=
 =?us-ascii?Q?tPPqSsMA2d+x07xri28aYF5BQXceKc0Oxuj7MRWrANPJgLlYcWGJkEhNooD+?=
 =?us-ascii?Q?t+jPTJM4eluCbqmtsLwBDGppj0cLAlvnyFLp8kW/w2QNQAfsm5GE6Sl+7j53?=
 =?us-ascii?Q?d3/1GEuejhaokTf4LAkZZAI=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61682014-06bf-41ce-9da7-08dbb9a1804e
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 06:19:10.2985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RiNdkKBrv+xIqbeH66weD+zJ2p9atQ/KO2Ufwcsimr1ihBEINeEyZs+SHUAFppKZMHV9AFIRZW3JwrCWGOpN03fCTS2eeXNITTBvMlEPvXvVvAxj4pNdpCHSDrCVUbly
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR01MB7818
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch addresses review comments that were given for
705ed549148f ("perf vendor events arm64: Add AmpereOne metrics")
but didn't make it to the original patch [1][2]

Changes include: A fix for backend_memory formula, use of standard metrics
when possible, using #slots, renaming metrics to avoid spaces in the names,
and cleanup.

[1] https://lore.kernel.org/linux-perf-users/e9bdacb-a231-36af-6a2e-6918ee7effa@os.amperecomputing.com/
[2] https://lore.kernel.org/linux-perf-users/20230826192352.3043220-1-ilkka@os.amperecomputing.com/

Fixes: 705ed549148f ("perf vendor events arm64: Add AmpereOne metrics")
Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
Fixed the scaling issues on some of the metrics in v1.

I'll be offline for a couple of weeks but Scott can address any review
comments meanwhile.

Cheers, Ilkka

.../arch/arm64/ampere/ampereone/metrics.json  | 418 +++++++++---------
 1 file changed, 220 insertions(+), 198 deletions(-)

diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json
index 1e7e8901a445..e2848a9d4848 100644
--- a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json
+++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json
@@ -1,362 +1,384 @@
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
+    },
+    {
+        "MetricName": "l1i_cache_miss_ratio",
+        "MetricExpr": "(L1I_CACHE_REFILL / L1I_CACHE)",
+        "BriefDescription": "This metric measures the ratio of level 1 instruction cache accesses missed to the total number of level 1 instruction cache accesses. This gives an indication of the effectiveness of the level 1 instruction cache.",
+        "MetricGroup": "Miss_Ratio;L1I_Cache_Effectiveness",
+        "ScaleUnit": "1per cache access"
     },
     {
+	"MetricName": "Miss_Ratio;l1d_cache_read_miss",
 	"MetricExpr": "L1D_CACHE_LMISS_RD / L1D_CACHE_RD",
 	"BriefDescription": "L1D cache read miss rate",
 	"MetricGroup": "Cache",
-	"MetricName": "L1D cache read miss"
+        "ScaleUnit": "1per cache read access"
     },
     {
-	"MetricExpr": "L1I_CACHE_REFILL / L1I_CACHE",
-	"BriefDescription": "L1I cache miss rate",
-	"MetricGroup": "Cache",
-	"MetricName": "L1I cache miss"
-    },
-    {
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
+	"MetricName": "gflops",
+	"MetricExpr": "VFP_SPEC / (duration_time * 1e9)",
 	"BriefDescription": "Giga-floating point operations per second",
-	"MetricGroup": "Instruction",
-	"MetricName": "GFLOPS_ISSUED"
+	"MetricGroup": "InstructionMix"
     },
     {
-	"MetricExpr": "DP_SPEC / OP_SPEC",
-	"BriefDescription": "Proportion of integer data processing operations",
-	"MetricGroup": "Instruction",
-	"MetricName": "Integer mix"
+        "MetricName": "integer_dp_percentage",
+        "MetricExpr": "((DP_SPEC / INST_SPEC) * 100)",
+        "BriefDescription": "This metric measures scalar integer operations as a percentage of operations speculatively executed.",
+        "MetricGroup": "Operation_Mix",
+        "ScaleUnit": "1percent of operations"
     },
     {
-	"MetricExpr": "INST_RETIRED / CPU_CYCLES",
-	"BriefDescription": "Instructions per cycle",
-	"MetricGroup": "Instruction",
-	"MetricName": "IPC"
+        "MetricName": "ipc",
+        "MetricExpr": "(INST_RETIRED / CPU_CYCLES)",
+        "BriefDescription": "This metric measures the number of instructions retired per cycle.",
+        "MetricGroup": "General",
+        "ScaleUnit": "1per cycle"
     },
     {
-	"MetricExpr": "LD_SPEC / OP_SPEC",
-	"BriefDescription": "Proportion of load operations",
-	"MetricGroup": "Instruction",
-	"MetricName": "Load mix"
+        "MetricName": "load_percentage",
+        "MetricExpr": "((LD_SPEC / INST_SPEC) * 100)",
+        "BriefDescription": "This metric measures load operations as a percentage of operations speculatively executed.",
+        "MetricGroup": "Operation_Mix",
+        "ScaleUnit": "1percent of operations"
     },
     {
-	"MetricExpr": "LDST_SPEC/ OP_SPEC",
-	"BriefDescription": "Proportion of load & store operations",
-	"MetricGroup": "Instruction",
-	"MetricName": "Load-store mix"
+	"MetricName": "load_store_spec_rate",
+	"MetricExpr": "((LDST_SPEC / INST_SPEC) * 100)",
+	"BriefDescription": "The rate of load or store instructions speculatively executed to overall instructions speclatively executed",
+        "MetricGroup": "Operation_Mix",
+        "ScaleUnit": "1percent of operations"
     },
     {
-	"MetricExpr": "INST_RETIRED / (duration_time * 1000000)",
+	"MetricName": "retired_mips",
+	"MetricExpr": "INST_RETIRED / (duration_time * 1e6)",
 	"BriefDescription": "Millions of instructions per second",
-	"MetricGroup": "Instruction",
-	"MetricName": "MIPS_RETIRED"
+	"MetricGroup": "InstructionMix"
     },
     {
-	"MetricExpr": "INST_SPEC / (duration_time * 1000000)",
+	"MetricName": "spec_utilization_mips",
+	"MetricExpr": "INST_SPEC / (duration_time * 1e6)",
 	"BriefDescription": "Millions of instructions per second",
-	"MetricGroup": "Instruction",
-	"MetricName": "MIPS_UTILIZATION"
-    },
-    {
-	"MetricExpr": "PC_WRITE_SPEC / OP_SPEC",
-	"BriefDescription": "Proportion of software change of PC operations",
-	"MetricGroup": "Instruction",
-	"MetricName": "PC write mix"
+	"MetricGroup": "PEutilization"
     },
     {
-	"MetricExpr": "ST_SPEC / OP_SPEC",
-	"BriefDescription": "Proportion of store operations",
-	"MetricGroup": "Instruction",
-	"MetricName": "Store mix"
+	"MetricName": "pc_write_spec_rate",
+	"MetricExpr": "((PC_WRITE_SPEC / INST_SPEC) * 100)",
+	"BriefDescription": "The rate of software change of the PC speculatively executed to overall instructions speclatively executed",
+        "MetricGroup": "Operation_Mix",
+        "ScaleUnit": "1percent of operations"
     },
     {
-	"MetricExpr": "VFP_SPEC / OP_SPEC",
-	"BriefDescription": "Proportion of FP operations",
-	"MetricGroup": "Instruction",
-	"MetricName": "VFP mix"
+        "MetricName": "store_percentage",
+        "MetricExpr": "((ST_SPEC / INST_SPEC) * 100)",
+        "BriefDescription": "This metric measures store operations as a percentage of operations speculatively executed.",
+        "MetricGroup": "Operation_Mix",
+        "ScaleUnit": "1percent of operations"
     },
     {
-	"MetricExpr": "1 - (OP_RETIRED/ (CPU_CYCLES * 4))",
-	"BriefDescription": "Proportion of slots lost",
-	"MetricGroup": "Speculation / TDA",
-	"MetricName": "CPU lost"
+        "MetricName": "scalar_fp_percentage",
+        "MetricExpr": "((VFP_SPEC / INST_SPEC) * 100)",
+        "BriefDescription": "This metric measures scalar floating point operations as a percentage of operations speculatively executed.",
+        "MetricGroup": "Operation_Mix",
+        "ScaleUnit": "1percent of operations"
     },
     {
-	"MetricExpr": "OP_RETIRED/ (CPU_CYCLES * 4)",
-	"BriefDescription": "Proportion of slots retiring",
-	"MetricGroup": "Speculation / TDA",
-	"MetricName": "CPU utilization"
+        "MetricName": "retired_rate",
+        "MetricExpr": "OP_RETIRED / OP_SPEC",
+        "BriefDescription": "Of all the micro-operations issued, what percentage are retired(committed)",
+        "MetricGroup": "General",
+        "ScaleUnit": "100%"
     },
     {
-	"MetricExpr": "OP_RETIRED - OP_SPEC",
-	"BriefDescription": "Operations lost due to misspeculation",
-	"MetricGroup": "Speculation / TDA",
-	"MetricName": "Operations lost"
+	"MetricName": "wasted",
+	"MetricExpr": "1 - (OP_RETIRED / (CPU_CYCLES * #slots))",
+        "BriefDescription": "Of all the micro-operations issued, what proportion are lost",
+	"MetricGroup": "General",
+	"ScaleUnit": "100%"
     },
     {
-	"MetricExpr": "1 - (OP_RETIRED / OP_SPEC)",
-	"BriefDescription": "Proportion of operations lost",
-	"MetricGroup": "Speculation / TDA",
-	"MetricName": "Operations lost (ratio)"
+        "MetricName": "wasted_rate",
+        "MetricExpr": "1 - OP_RETIRED / OP_SPEC",
+        "BriefDescription": "Of all the micro-operations issued, what percentage are not retired(committed)",
+        "MetricGroup": "General",
+        "ScaleUnit": "100%"
     },
     {
-	"MetricExpr": "OP_RETIRED / OP_SPEC",
-	"BriefDescription": "Proportion of operations retired",
-	"MetricGroup": "Speculation / TDA",
-	"MetricName": "Operations retired"
-    },
-    {
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
+        "MetricExpr": "100 - (retired_fraction + slots_lost_misspeculation_fraction + backend_bound)"
     },
     {
-        "MetricExpr": "((OP_SPEC - OP_RETIRED) / (CPU_CYCLES * 4))",
+        "MetricName": "slots_lost_misspeculation_fraction",
+        "MetricExpr": "100 * ((OP_SPEC - OP_RETIRED) / (CPU_CYCLES * #slots))",
         "BriefDescription": "Fraction of slots lost due to misspeculation",
-        "MetricGroup": "TopDownL1",
-        "MetricName": "lost"
+        "MetricGroup": "Default;TopdownL1",
+        "ScaleUnit": "1percent of slots"
     },
     {
-        "MetricExpr": "(OP_RETIRED / (CPU_CYCLES * 4))",
+        "MetricName": "retired_fraction",
+        "MetricExpr": "100 * (OP_RETIRED / (CPU_CYCLES * #slots))",
         "BriefDescription": "Fraction of slots retiring, useful work",
-        "MetricGroup": "TopDownL1",
-        "MetricName": "retiring"
+        "MetricGroup": "Default;TopdownL1",
+	"ScaleUnit": "1percent of slots"
     },
     {
-        "MetricExpr": "backend - backend_memory",
+        "MetricName": "backend_core",
+        "MetricExpr": "(backend_bound / 100) - backend_memory",
         "BriefDescription": "Fraction of slots the CPU was stalled due to backend non-memory subsystem issues",
-        "MetricGroup": "TopDownL2",
-        "MetricName": "backend_core"
+        "MetricGroup": "TopdownL2",
+        "ScaleUnit": "100%"
     },
     {
-        "MetricExpr": "(STALL_BACKEND_TLB + STALL_BACKEND_CACHE + STALL_BACKEND_MEM) / CPU_CYCLES ",
+        "MetricName": "backend_memory",
+        "MetricExpr": "(STALL_BACKEND_TLB + STALL_BACKEND_CACHE) / CPU_CYCLES",
         "BriefDescription": "Fraction of slots the CPU was stalled due to backend memory subsystem issues (cache/tlb miss)",
-        "MetricGroup": "TopDownL2",
-        "MetricName": "backend_memory"
+        "MetricGroup": "TopdownL2",
+        "ScaleUnit": "100%"
     },
     {
-        "MetricExpr": " (BR_MIS_PRED_RETIRED / GPC_FLUSH) * lost",
+        "MetricName": "branch_mispredict",
+        "MetricExpr": "(BR_MIS_PRED_RETIRED / GPC_FLUSH) * slots_lost_misspeculation_fraction",
         "BriefDescription": "Fraction of slots lost due to branch misprediciton",
-        "MetricGroup": "TopDownL2",
-        "MetricName": "branch_mispredict"
+        "MetricGroup": "TopdownL2",
+        "ScaleUnit": "1percent of slots"
     },
     {
-        "MetricExpr": "frontend - frontend_latency",
+        "MetricName": "frontend_bandwidth",
+        "MetricExpr": "frontend_bound - frontend_latency",
         "BriefDescription": "Fraction of slots the CPU did not dispatch at full bandwidth - able to dispatch partial slots only (1, 2, or 3 uops)",
-        "MetricGroup": "TopDownL2",
-        "MetricName": "frontend_bandwidth"
+        "MetricGroup": "TopdownL2",
+        "ScaleUnit": "1percent of slots"
     },
     {
-        "MetricExpr": "(STALL_FRONTEND - ((STALL_SLOT_FRONTEND - (frontend * CPU_CYCLES * 4)) / 4)) / CPU_CYCLES",
+        "MetricName": "frontend_latency",
+        "MetricExpr": "((STALL_FRONTEND - ((STALL_SLOT_FRONTEND - ((frontend_bound / 100) * CPU_CYCLES * #slots)) / #slots)) / CPU_CYCLES) * 100",
         "BriefDescription": "Fraction of slots the CPU was stalled due to frontend latency issues (cache/tlb miss); nothing to dispatch",
-        "MetricGroup": "TopDownL2",
-        "MetricName": "frontend_latency"
+        "MetricGroup": "TopdownL2",
+        "ScaleUnit": "1percent of slots"
     },
     {
-        "MetricExpr": "lost - branch_mispredict",
+        "MetricName": "other_miss_pred",
+        "MetricExpr": "slots_lost_misspeculation_fraction - branch_mispredict",
         "BriefDescription": "Fraction of slots lost due to other/non-branch misprediction misspeculation",
-        "MetricGroup": "TopDownL2",
-        "MetricName": "other_clears"
+        "MetricGroup": "TopdownL2",
+        "ScaleUnit": "1percent of slots"
     },
     {
-        "MetricExpr": "(IXU_NUM_UOPS_ISSUED + FSU_ISSUED) / (CPU_CYCLES * 6)",
+        "MetricName": "pipe_utilization",
+        "MetricExpr": "100 * ((IXU_NUM_UOPS_ISSUED + FSU_ISSUED) / (CPU_CYCLES * 6))",
         "BriefDescription": "Fraction of execute slots utilized",
-        "MetricGroup": "TopDownL2",
-        "MetricName": "pipe_utilization"
+        "MetricGroup": "TopdownL2",
+        "ScaleUnit": "1percent of slots"
     },
     {
-        "MetricExpr": "STALL_BACKEND_MEM / CPU_CYCLES",
+        "MetricName": "d_cache_l2_miss_rate",
+        "MetricExpr": "((STALL_BACKEND_MEM / CPU_CYCLES) * 100)",
         "BriefDescription": "Fraction of cycles the CPU was stalled due to data L2 cache miss",
-        "MetricGroup": "TopDownL3",
-        "MetricName": "d_cache_l2_miss"
+        "MetricGroup": "TopdownL3",
+        "ScaleUnit": "1percent of cycles"
     },
     {
-        "MetricExpr": "STALL_BACKEND_CACHE / CPU_CYCLES",
+        "MetricName": "d_cache_miss_rate",
+        "MetricExpr": "((STALL_BACKEND_CACHE / CPU_CYCLES) * 100)",
         "BriefDescription": "Fraction of cycles the CPU was stalled due to data cache miss",
-        "MetricGroup": "TopDownL3",
-        "MetricName": "d_cache_miss"
+        "MetricGroup": "TopdownL3",
+        "ScaleUnit": "1percent of cycles"
     },
     {
-        "MetricExpr": "STALL_BACKEND_TLB / CPU_CYCLES",
+        "MetricName": "d_tlb_miss_rate",
+        "MetricExpr": "((STALL_BACKEND_TLB / CPU_CYCLES) * 100)",
         "BriefDescription": "Fraction of cycles the CPU was stalled due to data TLB miss",
-        "MetricGroup": "TopDownL3",
-        "MetricName": "d_tlb_miss"
+        "MetricGroup": "TopdownL3",
+        "ScaleUnit": "1percent of cycles"
     },
     {
-        "MetricExpr": "FSU_ISSUED / (CPU_CYCLES * 2)",
+        "MetricName": "fsu_pipe_utilization",
+        "MetricExpr": "((FSU_ISSUED / (CPU_CYCLES * 2)) * 100)",
         "BriefDescription": "Fraction of FSU execute slots utilized",
-        "MetricGroup": "TopDownL3",
-        "MetricName": "fsu_pipe_utilization"
+        "MetricGroup": "TopdownL3",
+        "ScaleUnit": "1percent of slots"
     },
     {
-        "MetricExpr": "STALL_FRONTEND_CACHE / CPU_CYCLES",
+        "MetricName": "i_cache_miss_rate",
+        "MetricExpr": "((STALL_FRONTEND_CACHE / CPU_CYCLES) * 100)",
         "BriefDescription": "Fraction of cycles the CPU was stalled due to instruction cache miss",
-        "MetricGroup": "TopDownL3",
-        "MetricName": "i_cache_miss"
+        "MetricGroup": "TopdownL3",
+        "ScaleUnit": "1percent of slots"
     },
     {
-        "MetricExpr": " STALL_FRONTEND_TLB / CPU_CYCLES ",
+        "MetricName": "i_tlb_miss_rate",
+        "MetricExpr": "((STALL_FRONTEND_TLB / CPU_CYCLES) * 100)",
         "BriefDescription": "Fraction of cycles the CPU was stalled due to instruction TLB miss",
-        "MetricGroup": "TopDownL3",
-        "MetricName": "i_tlb_miss"
+        "MetricGroup": "TopdownL3",
+        "ScaleUnit": "1percent of slots"
     },
     {
-        "MetricExpr": "IXU_NUM_UOPS_ISSUED / (CPU_CYCLES / 4)",
+        "MetricName": "ixu_pipe_utilization",
+        "MetricExpr": "((IXU_NUM_UOPS_ISSUED / (CPU_CYCLES * #slots)) * 100)",
         "BriefDescription": "Fraction of IXU execute slots utilized",
-        "MetricGroup": "TopDownL3",
-        "MetricName": "ixu_pipe_utilization"
+        "MetricGroup": "TopdownL3",
+        "ScaleUnit": "1percent of slots"
     },
     {
-        "MetricExpr": "IDR_STALL_FLUSH / CPU_CYCLES",
+        "MetricName": "stall_recovery_rate",
+        "MetricExpr": "((IDR_STALL_FLUSH / CPU_CYCLES) * 100)",
         "BriefDescription": "Fraction of cycles the CPU was stalled due to flush recovery",
-        "MetricGroup": "TopDownL3",
-        "MetricName": "recovery"
-    },
-    {
-        "MetricExpr": "STALL_BACKEND_RESOURCE / CPU_CYCLES",
-        "BriefDescription": "Fraction of cycles the CPU was stalled due to core resource shortage",
-        "MetricGroup": "TopDownL3",
-        "MetricName": "resource"
+        "MetricGroup": "TopdownL3",
+        "ScaleUnit": "1percent of slots"
     },
     {
-        "MetricExpr": "IDR_STALL_FSU_SCHED / CPU_CYCLES ",
+        "MetricName": "stall_fsu_sched_rate",
+        "MetricExpr": "((IDR_STALL_FSU_SCHED / CPU_CYCLES) * 100)",
         "BriefDescription": "Fraction of cycles the CPU was stalled and FSU was full",
-        "MetricGroup": "TopDownL4",
-        "MetricName": "stall_fsu_sched"
+        "MetricGroup": "TopdownL4",
+        "ScaleUnit": "1percent of cycles"
     },
     {
-        "MetricExpr": "IDR_STALL_IXU_SCHED / CPU_CYCLES ",
+        "MetricName": "stall_ixu_sched_rate",
+        "MetricExpr": "((IDR_STALL_IXU_SCHED / CPU_CYCLES) * 100)",
         "BriefDescription": "Fraction of cycles the CPU was stalled and IXU was full",
-        "MetricGroup": "TopDownL4",
-        "MetricName": "stall_ixu_sched"
+        "MetricGroup": "TopdownL4",
+        "ScaleUnit": "1percent of cycles"
     },
     {
-        "MetricExpr": "IDR_STALL_LOB_ID / CPU_CYCLES ",
+        "MetricName": "stall_lob_id_rate",
+        "MetricExpr": "((IDR_STALL_LOB_ID / CPU_CYCLES) * 100)",
         "BriefDescription": "Fraction of cycles the CPU was stalled and LOB was full",
-        "MetricGroup": "TopDownL4",
-        "MetricName": "stall_lob_id"
+        "MetricGroup": "TopdownL4",
+        "ScaleUnit": "1percent of cycles"
     },
     {
-        "MetricExpr": "IDR_STALL_ROB_ID / CPU_CYCLES",
+        "MetricName": "stall_rob_id_rate",
+        "MetricExpr": "((IDR_STALL_ROB_ID / CPU_CYCLES) * 100)",
         "BriefDescription": "Fraction of cycles the CPU was stalled and ROB was full",
-        "MetricGroup": "TopDownL4",
-        "MetricName": "stall_rob_id"
+        "MetricGroup": "TopdownL4",
+        "ScaleUnit": "1percent of cycles"
     },
     {
-        "MetricExpr": "IDR_STALL_SOB_ID / CPU_CYCLES ",
+        "MetricName": "stall_sob_id_rate",
+        "MetricExpr": "((IDR_STALL_SOB_ID / CPU_CYCLES) * 100)",
         "BriefDescription": "Fraction of cycles the CPU was stalled and SOB was full",
-        "MetricGroup": "TopDownL4",
-        "MetricName": "stall_sob_id"
+        "MetricGroup": "TopdownL4",
+        "ScaleUnit": "1percent of cycles"
     }
 ]
-- 
2.40.1

