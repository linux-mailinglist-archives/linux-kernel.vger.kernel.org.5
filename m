Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651D17898CC
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 21:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjHZTYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 15:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjHZTY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 15:24:27 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2100.outbound.protection.outlook.com [40.107.96.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFFBE79;
        Sat, 26 Aug 2023 12:24:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzEqhHF4lccn0Drjsvboo+uM0lSSQLhyZIh2c1YPhvq0W2ui7LRvXG4rj+st/P3aHY7APrKJXx3Fo8awpdWse9G+DDUDAcegl6bUlqDvSkzs+8wRow8gf+owrUtNOgwX+Zr2nt7189wbreDkJ2t9YXMdGssZCeADPQQv6MaUXxTP81EiiU4rwl8Lxd3zqdOZSf3gEr7RNra8x6dzqg4N9cw9Ge62cMCapm12XF5gkcLLpvBHthFK5R00VDsdlHQEutViwkF3KkC6CdrrV4sJ8UIrb0sHJq1OR9bMA8dl32A25DagALuR1xaDQQx7ZycV1dWUFy985nb++lCna/bwrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZtoEhzOlhTkcT2V+6CLrg9MxY3YQJg27f4DiP43uQBg=;
 b=Zuu5C4WSQRCGuNRAKlyHjFqwoNprz5Xishthbdj7V+8j7tOOykw+j1Jc5UWQByBNuCWSMGrcV5K77M4Vji9PvLrYp181eeu7e6RHVRiAGHXBJyXR948ddW/XpRoHwMPTwRxkInPD7s8tChvsHxVyEsWra/osch/Jr5szh65WAFKE+DCEERGEy78KvvlOP3dT2b9ehIAC1Z+sZMsNJkhLI23S1Wt4uhqLy+83ZT6Uc68xXB+/0CLU6p7OHkSA7e0vnvALaZ6RHWlw70SXAJJUWcQYExG05ZB5JxcVpVD7S5H2pGoGJo86CrUKsKg2cZ6+IzXH2yzwuxuAqTEbJF2BGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZtoEhzOlhTkcT2V+6CLrg9MxY3YQJg27f4DiP43uQBg=;
 b=akBcQFIVo6wE5nUNXO3J0hQF5FD/2dA+oE8NRwWhB7cGr6Ii8OKy2ikw1vBJ2zsMLALoUMs6B3PClXLQOuucq39SVtBTHrB6dy9O0oh8bbWxUqrCQD+o01IPNaZaYszpIYs5l1dh26FR6N/6x33qMBb1y3szTbV4ORKgplzW8/0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 SA3PR01MB7941.prod.exchangelabs.com (2603:10b6:806:316::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.34; Sat, 26 Aug 2023 19:24:18 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::bfa4:8250:f526:5015]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::bfa4:8250:f526:5015%5]) with mapi id 15.20.6699.028; Sat, 26 Aug 2023
 19:24:18 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc:     Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH v2] perf vendor events arm64: Add AmpereOne metrics
Date:   Sat, 26 Aug 2023 12:23:52 -0700
Message-Id: <20230826192352.3043220-1-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR10CA0024.namprd10.prod.outlook.com
 (2603:10b6:610:4c::34) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|SA3PR01MB7941:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aee1fce-e843-42c1-97d2-08dba66a0a81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hP5aDg41lADg2DVZ5xqKuy6nJhYE+UVXZtre9Lxvth58X4QqSQZs0UaHz2egNBlqgH5mSnnhC4scY2WS56zRGYJ22KJ5ZvmF6fMgEygxo/lTrbLNrledvmkK6odZMGF6bbGwql2TuawwtDTdF/lIXzcBmYuphVHh0qO+oemOC+nk90i/WYtd8H6N10Al4DO8mJKmDa3i9vyV9DyKJjt+n8QIj3j68AiN6tqh/mGrm6b7c9fHpHG9oD7ur0ZfguD6dvmO5mXHxTuJs7q/dpEump74+SYlKxZE+xxIVxPG+VKiBy2TrPV4SGliLNTP762uEKdmwEufFzlvYKCK+OXvdMiSUrouwgOJcnoz940KNQHxngeqvTF84HZGzJg+ZB4vinsBEd4N/AAXiAH8gmeZYaWRZdUgDDAZR27hGfUllv+DPkQnbIdtdQJNUbNkoG2W58fdxCySclR2MpuvcXJqGTiQEOr50O2OgB0y1ECE6kpsp2CosAa84XcoVE8+ZGKeXy0sVNIxSIs+Y/ssbebNqwKh6V2MuOKgbHp9jgaCqhG36xAh+GSRMhLon/Pk4eb02dnSYGMJJ3kxjWWUsdEa4fMHhw706YMKQf39Pzo4tBOa9VGkie5qGr3NZoqD7Vrc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39850400004)(396003)(136003)(346002)(1800799009)(186009)(451199024)(6666004)(52116002)(6506007)(6486002)(2616005)(1076003)(6512007)(110136005)(7416002)(2906002)(30864003)(5660300002)(86362001)(54906003)(4326008)(38100700002)(8676002)(8936002)(41300700001)(66946007)(66556008)(66476007)(38350700002)(316002)(478600001)(83380400001)(26005)(7049001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?odEqQXNBiV/LaehOQpELVFEa+xe6MPmER7RWrizXzgRwyGJV+Dvee3poVj87?=
 =?us-ascii?Q?HC2ruC0cbBEF445G6eqO10PLlGlM6MrZVignF90K8xKaoh8X1ABYU1qPNXvv?=
 =?us-ascii?Q?xUBjE80/QwXdC1N7Qx6L4EJG0WDIOBvG5FQhbogDzOdR5JamrYJG5jooIjqq?=
 =?us-ascii?Q?CrbO9BlVRZli7ntwadmsIW7J7VxnWnKdo6x54A9bh2/7tFVSPt7pBzbTPPZp?=
 =?us-ascii?Q?CFN13JghA2tceNm9lp1LbuehsJCypAI10+C8+u5ut08ZnleGaGWafDaUkrL7?=
 =?us-ascii?Q?lDxclDPb1ZLdtDLY43sKCLBYC2aIoh2O+fTRQxZKGThAcRXk1epYfxLUjk13?=
 =?us-ascii?Q?cmvtSpqRjyZ6pYDnCMHcTdv/pGNxWALtR7MoqRevrHvT4YUIoymUkOMNj1rf?=
 =?us-ascii?Q?aiyexv/U9oT0xnz9EysHO6QVZRe1vG4y5ndYzj3puyKv/JDIKH7dAZZSGh8v?=
 =?us-ascii?Q?gu+AbTtzGMfaIHpxSKRX3PzMeVo7yArgW4fTX/qtZkxKctYIjoBVyX/gLhLE?=
 =?us-ascii?Q?fMhkNC5Q8OdSGe+PlTx0SsEzjE8iZacVo78rA2vucCTnQFFVNMK2vkyBy1Sy?=
 =?us-ascii?Q?+ll9iYHaMXgyB0kU09dtuX+Ue1BNO/jB63ulupecp3sjDxbdOmym3PVM0vcN?=
 =?us-ascii?Q?6T/gHqVsqHuPk0bkAbJJuNcJxHTW3ZpiN8RvXTEhrkx92YCzErsjbPn7FxAP?=
 =?us-ascii?Q?5MSp4AKlrd2CDnA8MunFb7Yuc5O3OMho9U9hcnxF4K1GJGuDSSEnXjEN3bi1?=
 =?us-ascii?Q?eExPkFUPK291DPoVF89TNtWfGNm+jqaS/BiV7tvNU8aja9Yu/GzK7lTtf1q2?=
 =?us-ascii?Q?b8q3N7FctEn+yID3hM227aMc/MZNACijqOGBUYJ0+9S1n+rY86l8I2mT1fc6?=
 =?us-ascii?Q?nbkC2iSPeyBcQw5vQ+Cxb7lU2B3rdqxNCgBhwsRmXiSSXnez4IycAGtR0NHh?=
 =?us-ascii?Q?ca3CHIp8JrhMnMU4gKHf8RmS6Zn/IVc6c2JXc5elw/qg+OyjLWL6WCWAn63Z?=
 =?us-ascii?Q?YHy7AZXSDRNopvpkY1+spDDqos0fdht2OYgSabwViqLSBkASKlyx+7J778jf?=
 =?us-ascii?Q?u2fooTh78cH7EtbnZUPQRxX/oGL3ib3YDn3MWSjDzq3j/0AJsFC4C2n8UMr4?=
 =?us-ascii?Q?FkdeAfjEC/ppq3LMrix6uSCrL3rhakc0y4WZcDoa20Ovnf+/X3D5Ash0g10p?=
 =?us-ascii?Q?t78k6mS0uB0WnUixmVbBNIf5UF8BTpph6wfJUigin4PoIohUGdWfeiIdEppl?=
 =?us-ascii?Q?AknRbvXm5FBrpqH3gfdMUbnUZOpqZeQLSVYZqrUswHVHAPmVtpo9vS1tYYEP?=
 =?us-ascii?Q?8Im2+Q8AQGgEB+Z/ap5X84E7I+ZtevNmb/0x52oB7bwVD/Ubi19c6I50KH0J?=
 =?us-ascii?Q?WZHQKvcSY/ZyyCL9v3T5nDEguHkdMpIuAwWdkWW1WTmBK/OcdWyo1zzNENpt?=
 =?us-ascii?Q?WvnZ+A5Teq1gyw5MHJ5qA60zYiYvmed5mEG0LCNob3EieFkF0IjGtfzi2pMm?=
 =?us-ascii?Q?ZZQEPpVT3DPnnnx1ftQy+cHGzNJzmValzgChv8MLrRo7EjUvtO68lt1Y4wAT?=
 =?us-ascii?Q?VxH7pnQmE0Jh3301+bxPkqRMmg2T9eAB+X0hSG61+iq11XW8B90VXKt9a8Dw?=
 =?us-ascii?Q?5zAGMq4Q3KddkClFyQ/cVH4=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aee1fce-e843-42c1-97d2-08dba66a0a81
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2023 19:24:17.9276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dOnlcfdKfJzceNu9taatS85d1Tw7Lbz5dGD8Ja8iuTtfX9Ed0+Y8KTbQacw6k3g74+eNLcfHx4EXkaQ5R0M9Y7irmwdE23rfgZ3dZPdtQeWRQpDvUX/cxnR6iqpAvyY4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR01MB7941
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds AmpereOne metrics. The metrics also work around
the issue related to some of the events.

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 .../arch/arm64/ampere/ampereone/metrics.json  | 396 ++++++++++++++++++
 1 file changed, 396 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json

diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json
new file mode 100644
index 000000000000..b623d8a9e3dc
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json
@@ -0,0 +1,396 @@
+[
+    {
+	"MetricExpr": "BR_MIS_PRED / BR_PRED",
+	"BriefDescription": "Branch predictor misprediction rate. May not count branches that are never resolved because they are in the misprediction shadow of an earlier branch",
+	"MetricGroup": "branch",
+	"MetricName": "branch_miss_pred_rate",
+        "ScaleUnit": "100%"
+    },
+    {
+	"MetricExpr": "BUS_ACCESS / (BUS_CYCLES * 1)",
+	"BriefDescription": "Core-to-uncore bus utilization",
+	"MetricGroup": "Bus",
+	"MetricName": "bus_utilization",
+        "ScaleUnit": "100%"
+    },
+    {
+	"MetricExpr": "L1D_CACHE_REFILL / L1D_CACHE",
+        "BriefDescription": "The rate of L1 D-Cache misses to the overall L1 D-Cache",
+        "MetricGroup": "Cache",
+        "MetricName": "l1d_cache_miss_rate",
+        "ScaleUnit": "100%"
+    },
+    {
+	"MetricExpr": "L1D_CACHE_LMISS_RD / L1D_CACHE_RD",
+	"BriefDescription": "L1D cache read miss rate",
+	"MetricGroup": "Cache",
+	"MetricName": "l1d_cache_read_miss",
+        "ScaleUnit": "100%"
+    },
+    {
+	"MetricExpr": "L1I_CACHE_REFILL / L1I_CACHE",
+        "BriefDescription": "The rate of L1 D-Cache misses to the overall L1 D-Cache",
+        "MetricGroup": "Cache",
+        "MetricName": "l1i_cache_miss_rate",
+        "ScaleUnit": "100%"
+    },
+    {
+	"MetricExpr": "L2D_CACHE_REFILL / L2D_CACHE",
+        "BriefDescription": "The rate of L2 D-Cache misses to the overall L2 D-Cache",
+        "MetricGroup": "Cache",
+        "MetricName": "l2d_cache_miss_rate",
+        "ScaleUnit": "100%"
+    },
+    {
+	"MetricExpr": "L1I_CACHE_LMISS / L1I_CACHE",
+	"BriefDescription": "L1I cache read miss rate",
+	"MetricGroup": "Cache",
+	"MetricName": "l1i_cache_read_miss_rate",
+        "ScaleUnit": "100%"
+    },
+    {
+	"MetricExpr": "L2D_CACHE_LMISS_RD / L2D_CACHE_RD",
+	"BriefDescription": "L2 cache read miss rate",
+	"MetricGroup": "Cache",
+	"MetricName": "l2d_cache_read_miss_rate",
+        "ScaleUnit": "100%"
+    },
+    {
+	"MetricExpr": "(L1D_CACHE_LMISS_RD * 1e3) / INST_RETIRED",
+	"BriefDescription": "Misses per thousand instructions (data)",
+	"MetricGroup": "Cache",
+	"MetricName": "l1d_cache_miss_mpki"
+    },
+    {
+	"MetricExpr": "(L1I_CACHE_LMISS * 1e3) / INST_RETIRED",
+	"BriefDescription": "Misses per thousand instructions (instruction)",
+	"MetricGroup": "Cache",
+	"MetricName": "l1i_cache_miss_mpki"
+    },
+    {
+        "MetricExpr": "ASE_SPEC / INST_SPEC",
+        "BriefDescription": "The rate of advanced SIMD instructions speculatively executed to overall instructions speclatively executed",
+        "MetricGroup": "InstructionMix",
+        "MetricName": "advanced_simd_spec_rate",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "CRYPTO_SPEC / INST_SPEC",
+        "BriefDescription": "The rate of crypto instructions speculatively executed to overall instructions speclatively executed",
+        "MetricGroup": "InstructionMix",
+        "MetricName": "crypto_spec_rate",
+        "ScaleUnit": "100%"
+    },
+    {
+	"MetricExpr": "VFP_SPEC / (duration_time * 1e9)",
+	"BriefDescription": "Giga-floating point operations per second",
+	"MetricGroup": "InstructionMix",
+	"MetricName": "gflops"
+    },
+    {
+        "MetricExpr": "DP_SPEC / INST_SPEC",
+        "BriefDescription": "The rate of integer data-processing instructions speculatively executed to overall instructions speclatively executed",
+        "MetricGroup": "InstructionMix",
+        "MetricName": "data_process_spec_rate",
+        "ScaleUnit": "100%"
+    },
+    {
+	"MetricExpr": "INST_RETIRED / CPU_CYCLES",
+        "BriefDescription": "Architecturally executed Instructions Per Cycle (IPC)",
+        "MetricGroup": "PEutilization",
+        "MetricName": "retired_ipc"
+    },
+    {
+        "MetricExpr": "LD_SPEC / INST_SPEC",
+        "BriefDescription": "The rate of load instructions speculatively executed to overall instructions speclatively executed",
+        "MetricGroup": "InstructionMix",
+        "MetricName": "load_spec_rate",
+        "ScaleUnit": "100%"
+    },
+    {
+	"MetricExpr": "LDST_SPEC / INST_SPEC",
+	"BriefDescription": "The rate of load or store instructions speculatively executed to overall instructions speclatively executed",
+	"MetricGroup": "InstructionMix",
+	"MetricName": "load_store_spec_rate",
+        "ScaleUnit": "100%"
+    },
+    {
+	"MetricExpr": "INST_RETIRED / (duration_time * 1e6)",
+	"BriefDescription": "Millions of instructions per second",
+	"MetricGroup": "InstructionMix",
+	"MetricName": "retired_mips"
+    },
+    {
+	"MetricExpr": "INST_SPEC / (duration_time * 1e6)",
+	"BriefDescription": "Millions of instructions per second",
+	"MetricGroup": "PEutilization",
+	"MetricName": "spec_utilization_mips"
+    },
+    {
+	"MetricExpr": "PC_WRITE_SPEC / INST_SPEC",
+	"BriefDescription": "The rate of software change of the PC speculatively executed to overall instructions speclatively executed",
+	"MetricGroup": "InstructionMix",
+	"MetricName": "pc_write_spec_rate",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "ST_SPEC / INST_SPEC",
+        "BriefDescription": "The rate of store instructions speculatively executed to overall instructions speclatively executed",
+        "MetricGroup": "InstructionMix",
+        "MetricName": "store_spec_rate",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "VFP_SPEC / INST_SPEC",
+        "BriefDescription": "The rate of floating point instructions speculatively executed to overall instructions speclatively executed",
+        "MetricGroup": "InstructionMix",
+        "MetricName": "float_point_spec_rate",
+        "ScaleUnit": "100%"
+    },
+    {
+	"MetricExpr": "1 - (OP_RETIRED / (CPU_CYCLES * 4))",
+        "BriefDescription": "Of all the micro-operations issued, what proportion are lost",
+	"MetricGroup": "PEutilization",
+	"MetricName": "wasted",
+	"ScaleUnit": "100%"
+    },
+    {
+	"MetricExpr": "OP_RETIRED / (CPU_CYCLES * 4)",
+	"BriefDescription": "Proportion of slots retiring",
+	"BriefDescription": "Of all the micro-operations issued, what proportion are retired",
+	"MetricGroup": "PEutilization",
+	"MetricName": "retired_proportion",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "1 - OP_RETIRED / OP_SPEC",
+        "BriefDescription": "Of all the micro-operations issued, what percentage are not retired(committed)",
+        "MetricGroup": "PEutilization",
+        "MetricName": "wasted_rate",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "OP_RETIRED / OP_SPEC",
+        "BriefDescription": "Of all the micro-operations issued, what percentage are retired(committed)",
+        "MetricGroup": "PEutilization",
+        "MetricName": "retired_rate",
+        "ScaleUnit": "100%"
+    },
+    {
+	"MetricExpr": "STALL_BACKEND_CACHE / CPU_CYCLES",
+	"BriefDescription": "Proportion of cycles stalled and no operations issued to backend and cache miss",
+	"MetricGroup": "Stall",
+	"MetricName": "stall_backend_cache_rate",
+        "ScaleUnit": "100%"
+    },
+    {
+	"MetricExpr": "STALL_BACKEND_RESOURCE / CPU_CYCLES",
+	"BriefDescription": "Proportion of cycles stalled and no operations issued to backend and resource full",
+	"MetricGroup": "Stall",
+	"MetricName": "stall_backend_resource_rate",
+        "ScaleUnit": "100%"
+    },
+    {
+	"MetricExpr": "STALL_BACKEND_TLB / CPU_CYCLES",
+	"BriefDescription": "Proportion of cycles stalled and no operations issued to backend and TLB miss",
+	"MetricGroup": "Stall",
+	"MetricName": "stall_backend_tlb_rate",
+        "ScaleUnit": "100%"
+    },
+    {
+	"MetricExpr": "STALL_FRONTEND_CACHE / CPU_CYCLES",
+	"BriefDescription": "Proportion of cycles stalled and no ops delivered from frontend and cache miss",
+	"MetricGroup": "Stall",
+	"MetricName": "stall_frontend_cache_rate",
+        "ScaleUnit": "100%"
+    },
+    {
+	"MetricExpr": "STALL_FRONTEND_TLB / CPU_CYCLES",
+	"BriefDescription": "Proportion of cycles stalled and no ops delivered from frontend and TLB miss",
+	"MetricGroup": "Stall",
+	"MetricName": "stall_frontend_tlb_rate",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "DTLB_WALK / L1D_TLB",
+        "BriefDescription": "The rate of DTLB Walks to the overall L1D TLB lookups",
+        "MetricGroup": "TLB",
+        "MetricName": "dtlb_walk_rate",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "ITLB_WALK / L1I_TLB",
+        "BriefDescription": "The rate of ITLB Walks to the overall L1I TLB lookups",
+        "MetricGroup": "TLB",
+        "MetricName": "itlb_walk_rate",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "STALL_SLOT_BACKEND / (CPU_CYCLES * 4)",
+        "BriefDescription": "Fraction of slots backend bound",
+        "MetricGroup": "Default;TopDownL1",
+        "MetricName": "backend_bound",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "1 - (retired_fraction + slots_lost_misspeculation_fraction + backend_bound)",
+        "BriefDescription": "Fraction of slots frontend bound",
+        "MetricGroup": "Default;TopDownL1",
+        "MetricName": "frontend_bound",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "(OP_SPEC - OP_RETIRED) / (CPU_CYCLES * 4)",
+        "BriefDescription": "Fraction of slots lost due to misspeculation",
+        "MetricGroup": "Default;TopDownL1",
+        "MetricName": "slots_lost_misspeculation_fraction",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "OP_RETIRED / (CPU_CYCLES * 4)",
+        "BriefDescription": "Fraction of slots retiring, useful work",
+        "MetricGroup": "Default;TopDownL1",
+        "MetricName": "retired_fraction",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "backend_bound - backend_memory",
+        "BriefDescription": "Fraction of slots the CPU was stalled due to backend non-memory subsystem issues",
+        "MetricGroup": "TopDownL2",
+        "MetricName": "backend_core",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "(STALL_BACKEND_TLB + STALL_BACKEND_CACHE) / CPU_CYCLES",
+        "BriefDescription": "Fraction of slots the CPU was stalled due to backend memory subsystem issues (cache/tlb miss)",
+        "MetricGroup": "TopDownL2",
+        "MetricName": "backend_memory",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "(BR_MIS_PRED_RETIRED / GPC_FLUSH) * slots_lost_misspeculation_fraction",
+        "BriefDescription": "Fraction of slots lost due to branch misprediciton",
+        "MetricGroup": "TopDownL2",
+        "MetricName": "branch_mispredict",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "frontend_bound - frontend_latency",
+        "BriefDescription": "Fraction of slots the CPU did not dispatch at full bandwidth - able to dispatch partial slots only (1, 2, or 3 uops)",
+        "MetricGroup": "TopDownL2",
+        "MetricName": "frontend_bandwidth",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "(STALL_FRONTEND - ((STALL_SLOT_FRONTEND - (frontend_bound * CPU_CYCLES * 4)) / 4)) / CPU_CYCLES",
+        "BriefDescription": "Fraction of slots the CPU was stalled due to frontend latency issues (cache/tlb miss); nothing to dispatch",
+        "MetricGroup": "TopDownL2",
+        "MetricName": "frontend_latency",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "slots_lost_misspeculation_fraction - branch_mispredict",
+        "BriefDescription": "Fraction of slots lost due to other/non-branch misprediction misspeculation",
+        "MetricGroup": "TopDownL2",
+        "MetricName": "other_miss_pred",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "(IXU_NUM_UOPS_ISSUED + FSU_ISSUED) / (CPU_CYCLES * 6)",
+        "BriefDescription": "Fraction of execute slots utilized",
+        "MetricGroup": "TopDownL2",
+        "MetricName": "pipe_utilization",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "STALL_BACKEND_MEM / CPU_CYCLES",
+        "BriefDescription": "Fraction of cycles the CPU was stalled due to data L2 cache miss",
+        "MetricGroup": "TopDownL3",
+        "MetricName": "d_cache_l2_miss_rate",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "STALL_BACKEND_CACHE / CPU_CYCLES",
+        "BriefDescription": "Fraction of cycles the CPU was stalled due to data cache miss",
+        "MetricGroup": "TopDownL3",
+        "MetricName": "d_cache_miss_rate",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "STALL_BACKEND_TLB / CPU_CYCLES",
+        "BriefDescription": "Fraction of cycles the CPU was stalled due to data TLB miss",
+        "MetricGroup": "TopDownL3",
+        "MetricName": "d_tlb_miss_rate",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "FSU_ISSUED / (CPU_CYCLES * 2)",
+        "BriefDescription": "Fraction of FSU execute slots utilized",
+        "MetricGroup": "TopDownL3",
+        "MetricName": "fsu_pipe_utilization",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "STALL_FRONTEND_CACHE / CPU_CYCLES",
+        "BriefDescription": "Fraction of cycles the CPU was stalled due to instruction cache miss",
+        "MetricGroup": "TopDownL3",
+        "MetricName": "i_cache_miss_rate",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "STALL_FRONTEND_TLB / CPU_CYCLES",
+        "BriefDescription": "Fraction of cycles the CPU was stalled due to instruction TLB miss",
+        "MetricGroup": "TopDownL3",
+        "MetricName": "i_tlb_miss_rate",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "IXU_NUM_UOPS_ISSUED / (CPU_CYCLES * 4)",
+        "BriefDescription": "Fraction of IXU execute slots utilized",
+        "MetricGroup": "TopDownL3",
+        "MetricName": "ixu_pipe_utilization",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "IDR_STALL_FLUSH / CPU_CYCLES",
+        "BriefDescription": "Fraction of cycles the CPU was stalled due to flush recovery",
+        "MetricGroup": "TopDownL3",
+        "MetricName": "stall_recovery_rate",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "IDR_STALL_FSU_SCHED / CPU_CYCLES",
+        "BriefDescription": "Fraction of cycles the CPU was stalled and FSU was full",
+        "MetricGroup": "TopDownL4",
+        "MetricName": "stall_fsu_sched_rate",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "IDR_STALL_IXU_SCHED / CPU_CYCLES",
+        "BriefDescription": "Fraction of cycles the CPU was stalled and IXU was full",
+        "MetricGroup": "TopDownL4",
+        "MetricName": "stall_ixu_sched_rate",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "IDR_STALL_LOB_ID / CPU_CYCLES",
+        "BriefDescription": "Fraction of cycles the CPU was stalled and LOB was full",
+        "MetricGroup": "TopDownL4",
+        "MetricName": "stall_lob_id_rate",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "IDR_STALL_ROB_ID / CPU_CYCLES",
+        "BriefDescription": "Fraction of cycles the CPU was stalled and ROB was full",
+        "MetricGroup": "TopDownL4",
+        "MetricName": "stall_rob_id_rate",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricExpr": "IDR_STALL_SOB_ID / CPU_CYCLES",
+        "BriefDescription": "Fraction of cycles the CPU was stalled and SOB was full",
+        "MetricGroup": "TopDownL4",
+        "MetricName": "stall_sob_id_rate",
+        "ScaleUnit": "100%"
+    }
+]
-- 
2.40.1

