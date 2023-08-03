Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF51076F487
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 23:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbjHCVOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 17:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjHCVOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 17:14:38 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144462D43;
        Thu,  3 Aug 2023 14:14:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XzGLWUAZWGyoE+sPwsmnIaViIdS3aewJjJYC85b01oTaZ7vgNKDx7nTUVv2qnVw6W03GWS6MNZYmDyq+dqID3C0dQiSM21+fVII4D6d7iioT6mG2i0Gr+Wp9U1BPVuBv5aGzUlUiBhiC1TBlmMbyjJ/3az/drIzd4NxfzlOoPD7l3xO7RLFEtmej2tQR71EZAv9ZzAJHoOKqJ+pjOvrQ9eIkceLRrDdfBOGIq2k/VuLOBEo2zC2h3sVibGfOLcIN7TyD7APvskwQE7YU+BIvcrvhr/pICpSGs/pemhyVwsTnjfEKHzlTWuactLVC+l33CHwyBtg4EnWAMqGhHxi+Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NiN4aH0GHIR8aHZlBG4D1+YKJZO+xrmuq/QgXmKqykg=;
 b=LwYotApUIW78XYGrKf6A2LyjH/jYuk20hsgfVaJP3FQsND0OajedL+60ReYZNWrGKwfwzhXAD5kUzmG7/mPC94Ib9ePIjCx5orc30GdYuRoxSKry1K+19TcOA79uvsrcHj1B/fEtZ/LqtsFqUyuoZFhNpXdNd94SovfUv0IjZ+Wg7fr9V8FmAWTRispxWZ/VVYC+cUpTg9jvVwxQwJo3Gjx6UwKIh7m3ixUKIACMdQAZXq5DCW+mm+1lIXQ+0ylvsn6MDL/sd00Oxy3IO93IEAKe/YX+IG4aslOIkB1izH1ibL+Y9CoRdkiUBbHUJj9LxYKROfpMk1BF2vl7kTFfTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NiN4aH0GHIR8aHZlBG4D1+YKJZO+xrmuq/QgXmKqykg=;
 b=lqhhq00m8ZpIkrB5GCyNvvF8adj/d35UE8lu2rDtKgL5C8r2xIZzZGWo24vYsWgCBbR3VEC+GSHSjb/D+XVpveJuXhc2fDZt5/a5H/uxqq8x7JPPEJbb2vwD+23zTGMQSAAxwN62d0kzWQt9tjGebX+g1l0NuJlnkHfQvVyVCVI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 SA3PR01MB8502.prod.exchangelabs.com (2603:10b6:806:39f::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.47; Thu, 3 Aug 2023 21:14:33 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::4e0f:49b:ee39:f08e]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::4e0f:49b:ee39:f08e%6]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 21:14:33 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Dave Kleikamp <dave.kleikamp@oracle.com>
Subject: [PATCH 3/4] perf vendor events arm64: Add AmpereOne metrics
Date:   Thu,  3 Aug 2023 14:13:30 -0700
Message-Id: <20230803211331.140553-4-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230803211331.140553-1-ilkka@os.amperecomputing.com>
References: <20230803211331.140553-1-ilkka@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR15CA0006.namprd15.prod.outlook.com
 (2603:10b6:610:51::16) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|SA3PR01MB8502:EE_
X-MS-Office365-Filtering-Correlation-Id: f972a901-5d12-4c8a-cfdc-08db9466a231
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1UtkV8qanHgf5lObtgQQriLcOnrIBAG4dxs0Owkte1agcZ5Loau50QbcNiDZVxcqTYp9EVXfq+Estoyh4X+iCQ8echo4ojLGCJ7SQHgWcmer0wKhYu7socbWA1uaZTIMXzEweiKDtiOGSGxOdRUVTh8ReebwZltyhPLtUrqf30Iv/z5vewaCJwAzsqVSwWK/iGF/KTViC+xnC4ZTyXBb6fZ8sAlrgrofjZ/X98ye+oLuLekdOJ2iWgVKTIApjXYbgbhOtx+osmTOGvmeQ4vFxhGZN+JEJGT11/tBJckNE2i16A+wrbofpO448JDiG6oo7FgOgMMHsk23tBIW/JLWgKeERI4WjqnBobJzKtWNEISBWjx9AvK0ExX4HBYrwYkfKg5xWJ5xGh2hd8LIIEInKFFhrmkiunn0K1Mx6rIPXtzpI/FqMJztqtNHBhWAE6kS1Mz6dwcNhu9guYMVtkjccsYS4Zh/gZzRv5RF5eJmhY2ohaD+cr3vnla6u8qlnKHPskL9f5yTrbOScZS99MeGTVFZUXc4sE95H4ByZSa/CWPGbWo9953y4G9/Asnb9jXajouEVovb8nAlfoAWjhKTX3etMWhx2qJ3K0pgTUxcYWE1opQWhGzbaSYVoxgLFHvr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(396003)(366004)(376002)(136003)(346002)(186005)(451199021)(86362001)(52116002)(54906003)(478600001)(110136005)(38100700002)(38350700002)(8676002)(1076003)(2616005)(6506007)(83380400001)(26005)(41300700001)(7416002)(8936002)(6486002)(6512007)(2906002)(316002)(66556008)(30864003)(66476007)(5660300002)(4326008)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zvNb2XkB+Eo1bIRn/iOf4tPB+0V5MgA+GI/udqBJiAgN+Ia1Vy0eINVpD/C0?=
 =?us-ascii?Q?JWS/S3JTBAmzvmwti5bPd30e2+sdtEu8s+Kw7HEjIpWkXAfDZdEUSB9RDAlF?=
 =?us-ascii?Q?CFKtCx9Y1dc137V2K2xnrxdGkWnWnGzJkLF+82z/d8pv8eUXybuZC9gIpqsy?=
 =?us-ascii?Q?KxGKBgrcG2ZqLDVB6GRtno4LMaCY7A+zMAYBuEguoA+rbUN4xoo6vnVOcIlF?=
 =?us-ascii?Q?cEebUtCqBdM0lcO9pgddkVtU0lQPYeq5dzDpCq1nqlIuxvZkUI4AZFAP1Juk?=
 =?us-ascii?Q?7F26AzSXScY1U0/TR49CdTIaDSJUW9PUTRhzYKnvc07iBUD/qA1kmyDafY0m?=
 =?us-ascii?Q?+0vjv8FQX6akXBxVRVQyYgaUTleZegVJexi2tmHutC3tSE9N+9XLPoYo5lrs?=
 =?us-ascii?Q?Y7qm4q+GQqn3ReOeBinyTRj3/p3NvMKTsZpITKTlwhDCviXbfvNAIJPdLd8R?=
 =?us-ascii?Q?SjTA3oDEL/nmhpLIqoO3+1Byx95lrTfzdAYwl4a5CQHyFZdFBdCXGjiKkl9D?=
 =?us-ascii?Q?ltqrD1Pik6kbZpmyWhkyHTIfZvrugmSR4uf71+I+q1pIxzMTDkEYgXULoEh2?=
 =?us-ascii?Q?wMmEvp5ztCFkJF2K/EUwRtyBsokLLsCDqdem0aMAIx4POtXvicHthGleTCDg?=
 =?us-ascii?Q?yi7kdwxYBLH7rLp5oTM8aQuZQqkGOM3q1bZUahQEELNJHuYak/XsU3tuTbeZ?=
 =?us-ascii?Q?rpCbHTyOUoUJ7T81b/OT/sDLJ1O0oRZqNH79UKKaTzE45prFfKJdjZH6Ktk6?=
 =?us-ascii?Q?q+dekjSV4QmDg0nrv/oH27EFDUG1+X/HJy3S+TRx8GIawSLZGufzR178EYf0?=
 =?us-ascii?Q?wOMf9uhj3kYJj0n3DZrrjeEcyu2/WuA19PM+qgfYt/uSMDq5zYC19661fxtd?=
 =?us-ascii?Q?cXTWIMCX00fpbjpQO46LopQPDFbFsSpxdE/TPdj2u/mBq5eIeQVP+p6orqte?=
 =?us-ascii?Q?TjePAuLoEZcwpemIb/I0tsPpUbDkz5XZYjBRRizGXEQw99GCxqOsAYz+1SAg?=
 =?us-ascii?Q?Agp71zWzL6yY2E6QiFMnqCocfyIv6vj1/vseqrbA6kztMmG+h+RnZ4W2Mbwe?=
 =?us-ascii?Q?xfTcPVRkdcls28NKzdlDYTBjH7Wp23FM2Zh0zlHQO7NCMOgmHNWhESsOzgGH?=
 =?us-ascii?Q?BdXMVvvz0jH4RLsRus/Yd7ZNPP0HYT2M3dMucKmfe/Ya8SGO14cpld/JuGtK?=
 =?us-ascii?Q?bvXrIoRPsttRc+YzGobVRSidWwXbVsc3i5GCEtQ6X5NURHuG/ibZXbNKZ4yB?=
 =?us-ascii?Q?j5r+TZ5tgVMaV842X/RzL8SkUgPR4pmL+djIZUnQtdgo/DdZUWerwbcSa9W6?=
 =?us-ascii?Q?G6LqJpiPisN1jPv/hPAdtTu6ogOHucGBxq74cIOPpXhDBedmYzwFINRbPy3A?=
 =?us-ascii?Q?V5sVZt8Z/17h/dAfg68nnhgm9bnbigduGvcbpPoqwvwAHNR1nniMw68lV+tR?=
 =?us-ascii?Q?9xJaeLqjer76TFOoEsnxPbb6db3wODC+L/vQZg1nRR6/T0LBf1Z2V1+x8qSx?=
 =?us-ascii?Q?X4+UQIxgw47Y2G/Tt7t/dEeiWk7I3r+HS0uB3IGVG/OjdrGAECh5lQQhUqgR?=
 =?us-ascii?Q?pluqCd5w4p+9Xg4k32ZeltV+n5hlrQBUIejJs+pYfQXaziONNrwlMupzokN7?=
 =?us-ascii?Q?Ug=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f972a901-5d12-4c8a-cfdc-08db9466a231
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 21:14:33.3368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zjzv/ub6FLDbO0DHk5Ng+4X5dN1LRbAIGE+wzLbHosZEHdo2U0vVz/d6ZXvwUuTbCnWIAeVcpS0YNrQxegY3t/Evb+zccm+FO6s7LYR9iiOxvcSiwPjHDTalsQzWWqqN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR01MB8502
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds AmpereOne metrics. The metrics also work around
the issue related to some of the events.

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 .../arch/arm64/ampere/ampereone/metrics.json  | 362 ++++++++++++++++++
 1 file changed, 362 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json

diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json
new file mode 100644
index 000000000000..1e7e8901a445
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json
@@ -0,0 +1,362 @@
+[
+    {
+	"MetricExpr": "BR_MIS_PRED / BR_PRED",
+	"BriefDescription": "Branch predictor misprediction rate. May not count branches that are never resolved because they are in the misprediction shadow of an earlier branch",
+	"MetricGroup": "Branch Prediction",
+	"MetricName": "Misprediction"
+    },
+    {
+	"MetricExpr": "BR_MIS_PRED_RETIRED / BR_RETIRED",
+	"BriefDescription": "Branch predictor misprediction rate",
+	"MetricGroup": "Branch Prediction",
+	"MetricName": "Misprediction (retired)"
+    },
+    {
+	"MetricExpr": "BUS_ACCESS / ( BUS_CYCLES * 1)",
+	"BriefDescription": "Core-to-uncore bus utilization",
+	"MetricGroup": "Bus",
+	"MetricName": "Bus utilization"
+    },
+    {
+	"MetricExpr": "L1D_CACHE_REFILL / L1D_CACHE",
+	"BriefDescription": "L1D cache miss rate",
+	"MetricGroup": "Cache",
+	"MetricName": "L1D cache miss"
+    },
+    {
+	"MetricExpr": "L1D_CACHE_LMISS_RD / L1D_CACHE_RD",
+	"BriefDescription": "L1D cache read miss rate",
+	"MetricGroup": "Cache",
+	"MetricName": "L1D cache read miss"
+    },
+    {
+	"MetricExpr": "L1I_CACHE_REFILL / L1I_CACHE",
+	"BriefDescription": "L1I cache miss rate",
+	"MetricGroup": "Cache",
+	"MetricName": "L1I cache miss"
+    },
+    {
+	"MetricExpr": "L2D_CACHE_REFILL / L2D_CACHE",
+	"BriefDescription": "L2 cache miss rate",
+	"MetricGroup": "Cache",
+	"MetricName": "L2 cache miss"
+    },
+    {
+	"MetricExpr": "L1I_CACHE_LMISS / L1I_CACHE",
+	"BriefDescription": "L1I cache read miss rate",
+	"MetricGroup": "Cache",
+	"MetricName": "L1I cache read miss"
+    },
+    {
+	"MetricExpr": "L2D_CACHE_LMISS_RD / L2D_CACHE_RD",
+	"BriefDescription": "L2 cache read miss rate",
+	"MetricGroup": "Cache",
+	"MetricName": "L2 cache read miss"
+    },
+    {
+	"MetricExpr": "(L1D_CACHE_LMISS_RD * 1000) / INST_RETIRED",
+	"BriefDescription": "Misses per thousand instructions (data)",
+	"MetricGroup": "Cache",
+	"MetricName": "MPKI data"
+    },
+    {
+	"MetricExpr": "(L1I_CACHE_LMISS * 1000) / INST_RETIRED",
+	"BriefDescription": "Misses per thousand instructions (instruction)",
+	"MetricGroup": "Cache",
+	"MetricName": "MPKI instruction"
+    },
+    {
+	"MetricExpr": "ASE_SPEC / OP_SPEC",
+	"BriefDescription": "Proportion of advanced SIMD data processing operations (excluding DP_SPEC/LD_SPEC) operations",
+	"MetricGroup": "Instruction",
+	"MetricName": "ASE mix"
+    },
+    {
+	"MetricExpr": "CRYPTO_SPEC / OP_SPEC",
+	"BriefDescription": "Proportion of crypto data processing operations",
+	"MetricGroup": "Instruction",
+	"MetricName": "Crypto mix"
+    },
+    {
+	"MetricExpr": "VFP_SPEC / (duration_time *1000000000)",
+	"BriefDescription": "Giga-floating point operations per second",
+	"MetricGroup": "Instruction",
+	"MetricName": "GFLOPS_ISSUED"
+    },
+    {
+	"MetricExpr": "DP_SPEC / OP_SPEC",
+	"BriefDescription": "Proportion of integer data processing operations",
+	"MetricGroup": "Instruction",
+	"MetricName": "Integer mix"
+    },
+    {
+	"MetricExpr": "INST_RETIRED / CPU_CYCLES",
+	"BriefDescription": "Instructions per cycle",
+	"MetricGroup": "Instruction",
+	"MetricName": "IPC"
+    },
+    {
+	"MetricExpr": "LD_SPEC / OP_SPEC",
+	"BriefDescription": "Proportion of load operations",
+	"MetricGroup": "Instruction",
+	"MetricName": "Load mix"
+    },
+    {
+	"MetricExpr": "LDST_SPEC/ OP_SPEC",
+	"BriefDescription": "Proportion of load & store operations",
+	"MetricGroup": "Instruction",
+	"MetricName": "Load-store mix"
+    },
+    {
+	"MetricExpr": "INST_RETIRED / (duration_time * 1000000)",
+	"BriefDescription": "Millions of instructions per second",
+	"MetricGroup": "Instruction",
+	"MetricName": "MIPS_RETIRED"
+    },
+    {
+	"MetricExpr": "INST_SPEC / (duration_time * 1000000)",
+	"BriefDescription": "Millions of instructions per second",
+	"MetricGroup": "Instruction",
+	"MetricName": "MIPS_UTILIZATION"
+    },
+    {
+	"MetricExpr": "PC_WRITE_SPEC / OP_SPEC",
+	"BriefDescription": "Proportion of software change of PC operations",
+	"MetricGroup": "Instruction",
+	"MetricName": "PC write mix"
+    },
+    {
+	"MetricExpr": "ST_SPEC / OP_SPEC",
+	"BriefDescription": "Proportion of store operations",
+	"MetricGroup": "Instruction",
+	"MetricName": "Store mix"
+    },
+    {
+	"MetricExpr": "VFP_SPEC / OP_SPEC",
+	"BriefDescription": "Proportion of FP operations",
+	"MetricGroup": "Instruction",
+	"MetricName": "VFP mix"
+    },
+    {
+	"MetricExpr": "1 - (OP_RETIRED/ (CPU_CYCLES * 4))",
+	"BriefDescription": "Proportion of slots lost",
+	"MetricGroup": "Speculation / TDA",
+	"MetricName": "CPU lost"
+    },
+    {
+	"MetricExpr": "OP_RETIRED/ (CPU_CYCLES * 4)",
+	"BriefDescription": "Proportion of slots retiring",
+	"MetricGroup": "Speculation / TDA",
+	"MetricName": "CPU utilization"
+    },
+    {
+	"MetricExpr": "OP_RETIRED - OP_SPEC",
+	"BriefDescription": "Operations lost due to misspeculation",
+	"MetricGroup": "Speculation / TDA",
+	"MetricName": "Operations lost"
+    },
+    {
+	"MetricExpr": "1 - (OP_RETIRED / OP_SPEC)",
+	"BriefDescription": "Proportion of operations lost",
+	"MetricGroup": "Speculation / TDA",
+	"MetricName": "Operations lost (ratio)"
+    },
+    {
+	"MetricExpr": "OP_RETIRED / OP_SPEC",
+	"BriefDescription": "Proportion of operations retired",
+	"MetricGroup": "Speculation / TDA",
+	"MetricName": "Operations retired"
+    },
+    {
+	"MetricExpr": "STALL_BACKEND_CACHE / CPU_CYCLES",
+	"BriefDescription": "Proportion of cycles stalled and no operations issued to backend and cache miss",
+	"MetricGroup": "Stall",
+	"MetricName": "Stall backend cache cycles"
+    },
+    {
+	"MetricExpr": "STALL_BACKEND_RESOURCE / CPU_CYCLES",
+	"BriefDescription": "Proportion of cycles stalled and no operations issued to backend and resource full",
+	"MetricGroup": "Stall",
+	"MetricName": "Stall backend resource cycles"
+    },
+    {
+	"MetricExpr": "STALL_BACKEND_TLB / CPU_CYCLES",
+	"BriefDescription": "Proportion of cycles stalled and no operations issued to backend and TLB miss",
+	"MetricGroup": "Stall",
+	"MetricName": "Stall backend tlb cycles"
+    },
+    {
+	"MetricExpr": "STALL_FRONTEND_CACHE / CPU_CYCLES",
+	"BriefDescription": "Proportion of cycles stalled and no ops delivered from frontend and cache miss",
+	"MetricGroup": "Stall",
+	"MetricName": "Stall frontend cache cycles"
+    },
+    {
+	"MetricExpr": "STALL_FRONTEND_TLB / CPU_CYCLES",
+	"BriefDescription": "Proportion of cycles stalled and no ops delivered from frontend and TLB miss",
+	"MetricGroup": "Stall",
+	"MetricName": "Stall frontend tlb cycles"
+    },
+    {
+	"MetricExpr": "DTLB_WALK / L1D_TLB",
+	"BriefDescription": "D-side walk per d-side translation request",
+	"MetricGroup": "TLB",
+	"MetricName": "DTLB walks"
+    },
+    {
+	"MetricExpr": "ITLB_WALK / L1I_TLB",
+	"BriefDescription": "I-side walk per i-side translation request",
+	"MetricGroup": "TLB",
+	"MetricName": "ITLB walks"
+    },
+    {
+        "MetricExpr": "STALL_SLOT_BACKEND / (CPU_CYCLES * 4)",
+        "BriefDescription": "Fraction of slots backend bound",
+        "MetricGroup": "TopDownL1",
+        "MetricName": "backend"
+    },
+    {
+        "MetricExpr": "1 - (retiring + lost + backend)",
+        "BriefDescription": "Fraction of slots frontend bound",
+        "MetricGroup": "TopDownL1",
+        "MetricName": "frontend"
+    },
+    {
+        "MetricExpr": "((OP_SPEC - OP_RETIRED) / (CPU_CYCLES * 4))",
+        "BriefDescription": "Fraction of slots lost due to misspeculation",
+        "MetricGroup": "TopDownL1",
+        "MetricName": "lost"
+    },
+    {
+        "MetricExpr": "(OP_RETIRED / (CPU_CYCLES * 4))",
+        "BriefDescription": "Fraction of slots retiring, useful work",
+        "MetricGroup": "TopDownL1",
+        "MetricName": "retiring"
+    },
+    {
+        "MetricExpr": "backend - backend_memory",
+        "BriefDescription": "Fraction of slots the CPU was stalled due to backend non-memory subsystem issues",
+        "MetricGroup": "TopDownL2",
+        "MetricName": "backend_core"
+    },
+    {
+        "MetricExpr": "(STALL_BACKEND_TLB + STALL_BACKEND_CACHE + STALL_BACKEND_MEM) / CPU_CYCLES ",
+        "BriefDescription": "Fraction of slots the CPU was stalled due to backend memory subsystem issues (cache/tlb miss)",
+        "MetricGroup": "TopDownL2",
+        "MetricName": "backend_memory"
+    },
+    {
+        "MetricExpr": " (BR_MIS_PRED_RETIRED / GPC_FLUSH) * lost",
+        "BriefDescription": "Fraction of slots lost due to branch misprediciton",
+        "MetricGroup": "TopDownL2",
+        "MetricName": "branch_mispredict"
+    },
+    {
+        "MetricExpr": "frontend - frontend_latency",
+        "BriefDescription": "Fraction of slots the CPU did not dispatch at full bandwidth - able to dispatch partial slots only (1, 2, or 3 uops)",
+        "MetricGroup": "TopDownL2",
+        "MetricName": "frontend_bandwidth"
+    },
+    {
+        "MetricExpr": "(STALL_FRONTEND - ((STALL_SLOT_FRONTEND - (frontend * CPU_CYCLES * 4)) / 4)) / CPU_CYCLES",
+        "BriefDescription": "Fraction of slots the CPU was stalled due to frontend latency issues (cache/tlb miss); nothing to dispatch",
+        "MetricGroup": "TopDownL2",
+        "MetricName": "frontend_latency"
+    },
+    {
+        "MetricExpr": "lost - branch_mispredict",
+        "BriefDescription": "Fraction of slots lost due to other/non-branch misprediction misspeculation",
+        "MetricGroup": "TopDownL2",
+        "MetricName": "other_clears"
+    },
+    {
+        "MetricExpr": "(IXU_NUM_UOPS_ISSUED + FSU_ISSUED) / (CPU_CYCLES * 6)",
+        "BriefDescription": "Fraction of execute slots utilized",
+        "MetricGroup": "TopDownL2",
+        "MetricName": "pipe_utilization"
+    },
+    {
+        "MetricExpr": "STALL_BACKEND_MEM / CPU_CYCLES",
+        "BriefDescription": "Fraction of cycles the CPU was stalled due to data L2 cache miss",
+        "MetricGroup": "TopDownL3",
+        "MetricName": "d_cache_l2_miss"
+    },
+    {
+        "MetricExpr": "STALL_BACKEND_CACHE / CPU_CYCLES",
+        "BriefDescription": "Fraction of cycles the CPU was stalled due to data cache miss",
+        "MetricGroup": "TopDownL3",
+        "MetricName": "d_cache_miss"
+    },
+    {
+        "MetricExpr": "STALL_BACKEND_TLB / CPU_CYCLES",
+        "BriefDescription": "Fraction of cycles the CPU was stalled due to data TLB miss",
+        "MetricGroup": "TopDownL3",
+        "MetricName": "d_tlb_miss"
+    },
+    {
+        "MetricExpr": "FSU_ISSUED / (CPU_CYCLES * 2)",
+        "BriefDescription": "Fraction of FSU execute slots utilized",
+        "MetricGroup": "TopDownL3",
+        "MetricName": "fsu_pipe_utilization"
+    },
+    {
+        "MetricExpr": "STALL_FRONTEND_CACHE / CPU_CYCLES",
+        "BriefDescription": "Fraction of cycles the CPU was stalled due to instruction cache miss",
+        "MetricGroup": "TopDownL3",
+        "MetricName": "i_cache_miss"
+    },
+    {
+        "MetricExpr": " STALL_FRONTEND_TLB / CPU_CYCLES ",
+        "BriefDescription": "Fraction of cycles the CPU was stalled due to instruction TLB miss",
+        "MetricGroup": "TopDownL3",
+        "MetricName": "i_tlb_miss"
+    },
+    {
+        "MetricExpr": "IXU_NUM_UOPS_ISSUED / (CPU_CYCLES / 4)",
+        "BriefDescription": "Fraction of IXU execute slots utilized",
+        "MetricGroup": "TopDownL3",
+        "MetricName": "ixu_pipe_utilization"
+    },
+    {
+        "MetricExpr": "IDR_STALL_FLUSH / CPU_CYCLES",
+        "BriefDescription": "Fraction of cycles the CPU was stalled due to flush recovery",
+        "MetricGroup": "TopDownL3",
+        "MetricName": "recovery"
+    },
+    {
+        "MetricExpr": "STALL_BACKEND_RESOURCE / CPU_CYCLES",
+        "BriefDescription": "Fraction of cycles the CPU was stalled due to core resource shortage",
+        "MetricGroup": "TopDownL3",
+        "MetricName": "resource"
+    },
+    {
+        "MetricExpr": "IDR_STALL_FSU_SCHED / CPU_CYCLES ",
+        "BriefDescription": "Fraction of cycles the CPU was stalled and FSU was full",
+        "MetricGroup": "TopDownL4",
+        "MetricName": "stall_fsu_sched"
+    },
+    {
+        "MetricExpr": "IDR_STALL_IXU_SCHED / CPU_CYCLES ",
+        "BriefDescription": "Fraction of cycles the CPU was stalled and IXU was full",
+        "MetricGroup": "TopDownL4",
+        "MetricName": "stall_ixu_sched"
+    },
+    {
+        "MetricExpr": "IDR_STALL_LOB_ID / CPU_CYCLES ",
+        "BriefDescription": "Fraction of cycles the CPU was stalled and LOB was full",
+        "MetricGroup": "TopDownL4",
+        "MetricName": "stall_lob_id"
+    },
+    {
+        "MetricExpr": "IDR_STALL_ROB_ID / CPU_CYCLES",
+        "BriefDescription": "Fraction of cycles the CPU was stalled and ROB was full",
+        "MetricGroup": "TopDownL4",
+        "MetricName": "stall_rob_id"
+    },
+    {
+        "MetricExpr": "IDR_STALL_SOB_ID / CPU_CYCLES ",
+        "BriefDescription": "Fraction of cycles the CPU was stalled and SOB was full",
+        "MetricGroup": "TopDownL4",
+        "MetricName": "stall_sob_id"
+    }
+]
-- 
2.40.1

