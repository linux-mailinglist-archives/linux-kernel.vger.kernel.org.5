Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36D680017E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 03:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376928AbjLACQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 21:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbjLACQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 21:16:39 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2097.outbound.protection.outlook.com [40.107.94.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F311731;
        Thu, 30 Nov 2023 18:16:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mHDJi9tRMg5dl7HWt0o28rDlVws4T5tRAaFHMl41EZhQBIuJrEwN8Qilr9I+/WT/Zbly3v4Jx20bT6IzFcXPFx30hScfWJXGyob9lL2R3D+ExWxtOFRataOcoMELNtqjZRep8gtI23ZsrJTVRmOCecOYfRFbn8O9aZmaSUtGyWrD+KUUAZddrzXrf3T651l4c0pzvVEIi9yNp/VtfmFqvpbJYWForoxdNPyIcsTzsfCa6xCUh7Z7VhZJkIdiPg6VZ0yrFvv4OuRiTWNZOZW20sZVjGfLXxLsJHuJCa5HQrsI6NBuB6La1vH5pPv2v8OIxEmFid3muJ9jpqEPQ07QHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LPL8D43rDS/OihtroU8nZHzF7cewXKpAta5oCqUbrX8=;
 b=Tv2RSiQL7FIlc+T2zL7PO33Q35olIOSlTzH6DbBA52vSbEqZrFERoniGkfSLBMhuJr8+zq6GisWHFBWSX+dUK99HyoSpr4Yhn54y4sumZZqVm9qN/+tA96OzUus2sep5dJTBXHStbqIrS/KwA9QmbCmy4mcFn9P09/iTQDqV+WpyDuaBmhThqRWPaFRELmL7pliRIGzqWS2rW5bKdx2ybtWohRg6zP8FHNMEwgVKmUW+Qa24h+gCcv43zPuARSspBay0oFXNGHvcO746USLgu/7bYFLP95gHTZYoWyfzUPt7yVxCy/1DoALv+xBclKv98HCF7tVDkP6QvjGOemmMAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPL8D43rDS/OihtroU8nZHzF7cewXKpAta5oCqUbrX8=;
 b=Maf4OyLH1+YXdSlKJRTOvX6ZKXvROPuWMlazAwlIQa+hqiCiuEUE46JWosaAg1svrw59Aa/u5As6xsU/UQ813x9Uf92JYFB8bIxV4Y0W7fzhmBJ/xyhkMEmF9n+riN4t1rUDtWBJSTYkguCyHTgE04c0gsFhauNqfCGXSK3w7X8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 MW4PR01MB6196.prod.exchangelabs.com (2603:10b6:303:71::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.24; Fri, 1 Dec 2023 02:16:35 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::49fa:8dc0:6fd1:72e6]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::49fa:8dc0:6fd1:72e6%4]) with mapi id 15.20.7046.024; Fri, 1 Dec 2023
 02:16:35 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
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
        Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 3/3] perf vendor events arm64: AmpereOneX: Add core PMU events and metrics
Date:   Thu, 30 Nov 2023 18:15:50 -0800
Message-ID: <20231201021550.1109196-4-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231201021550.1109196-1-ilkka@os.amperecomputing.com>
References: <20231201021550.1109196-1-ilkka@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH3P221CA0024.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1e7::33) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|MW4PR01MB6196:EE_
X-MS-Office365-Filtering-Correlation-Id: 88e163ef-4ea1-43cb-67a2-08dbf2138b0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z8/VeG3loGM5BfniPwV4Fdfktk2JW8CfkbF3B+s54hwhpHGuCcGTqaxx7Wa/u2D7jIb5eifo75g9NYk4GVHdQyrAZkFhLXiC8N7tdNcmTKsRxLODwfmd2v+3AUoghUnUOIsYk1aOIJVEo3PWYdrLwDORPunkGx8MCpXqd/AlzSi+h2C57a+D64Y3R9pInrvp2UGztUgM2p1HCJkNiVAJ5COtxWCfGoVRiuIOvpDgw34A1Y1pFvRaOAHdD5pFA21C1XVSM5OUrXBgBTmYDixF2zsWUekqfiNXV0Tb8XAH6O44gShx14sRbvaTMUNK4sNXIgIkr9j8DmYTHSo3ygKasYU7dG82Jn1No8XlSnaxysRmXQkZveRElc9TPFvgXobncl4q4Ib52MzN40Jrs5IzM38gBSKk0DKR6mbM/pSVPgNxRqry6WVEJDA2A3HiSMFqmCVerhJaAHlbnzdNaZCHR0S8gx7z8Y7Jk/SoYq26ge66wWIDQ8fS9FAag0UaW756DXmqhDjZ21xJ1+CE8GqaOuw1WF4Zo+yaxIMfAFnOKo3lpi+hI0lNmf0+sDUH4XbCkrimcGNquR838+YkTqQ1Bf/G8nkv0aA+8b9Fm5uvpl/dPlviI5X9Y3pKwzYruSTUR9KTG7q1rfONamYRO4fDmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39850400004)(376002)(396003)(366004)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(1076003)(921008)(83380400001)(26005)(38350700005)(38100700002)(41300700001)(7049001)(52116002)(6512007)(2616005)(6666004)(6486002)(30864003)(5660300002)(2906002)(7416002)(316002)(6506007)(66556008)(110136005)(66476007)(66946007)(478600001)(86362001)(8936002)(8676002)(4326008)(559001)(579004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j80E+uVwf0VlDBQmo8RzaW1iq2lrGDnomUslm24X+fD0U3euwQYo7kJGkepj?=
 =?us-ascii?Q?SGEOHYDtKr4+HQ7wuP3bELEaDL6Csu6ZAAEjPbCiKdSK1bH6s6Wd9rmbi9W8?=
 =?us-ascii?Q?ws/0CdKWrYLVPK7y555kuvgTcPkuXT9h/pp5+6gPtKwzeeYhXbp3+kfrfABb?=
 =?us-ascii?Q?lu93YzD5flwLWK7TOtCgvI6GZXfQA7XHcVzEm66fgjflF1RuKGnEAYuJgGCn?=
 =?us-ascii?Q?MUe81xdmZneyEudG6s2Vjxsaz62/bOpttS7GLK5i3/B+pFI+0aScHnu/Q9LX?=
 =?us-ascii?Q?6py8ZhSjoynT4OsSrrVx//wZSYjiwQ5Vty8v1HpJx8iMqdhoLUN2l/gGNaat?=
 =?us-ascii?Q?n0OxfsX5xkaNdysbKIdR12PBqC02uVt8NvsIEwesZfAp7h9IprRAqzA9RMZ5?=
 =?us-ascii?Q?X8X/HhwVWDN6xAAuD9i8VQtg9BOgYdjKkGs4Wdd7SsWLbt6ZhIeLEbx6tm/3?=
 =?us-ascii?Q?1fGFgCMqXSFGuac5ApHBs3U5qm+9VCj3llOciZwhT2AobgBch3xjDMQonCnD?=
 =?us-ascii?Q?gusQ6RRNUN8H4hrf8Ljgls+aYbfu29Lgr0kG3Qf5LvhjPJ7dDFnZdik43U/9?=
 =?us-ascii?Q?HIBuF8PTNuFZ3kSbTGnPQvjuvpuWmVP4K0GMoIp0ZIjPaNVHkATXeThEJias?=
 =?us-ascii?Q?J6M+0Z7xNYPrUvmAt0b0Hd/n2T+q41dGJJLgSzWqK9JwLWWkLV1zNqCRdnm2?=
 =?us-ascii?Q?214jJlVIDEWNQ5G57nfg5/LZShE6LPBK6NN8AUaxJToxTEQm6RaON+uCMZZz?=
 =?us-ascii?Q?+dEFE0qE8Xw0UTS6UKTJo7n7UMsJEZSVJQao1BHOBDH7oL+UyPQwQGrcjF+9?=
 =?us-ascii?Q?Jkr+Di47CiMsT3af7ZUTBU0NN4rritNQonoB5z/i7v09EUJxy3g0O2tgAmwH?=
 =?us-ascii?Q?RKTvrtVk54zM7h6Hw2bVYsr7jkImzSJlkzDSQbg58RbcRCxJW+hi5FZuL3ZO?=
 =?us-ascii?Q?+nKmcHh01qs3uA8FjsXGnA5Q/qSLQUe0Q4PZVUS3sBEn4yCvlfz0S94F713q?=
 =?us-ascii?Q?3KBbiH3QF7OxoqMFPrIVBvozjnraNveMKDeHRwQJt9j4LvyMO6J1fpcFK30H?=
 =?us-ascii?Q?ObSuDwQuC5EOCP3NaPMdnsi+NwpXbZl78SkGT/9BZd6akk3RHt0qkUqioTnu?=
 =?us-ascii?Q?eIkm+hAnM5XyQm+AID2Kbpvxf780xi2kf73LeVgnUv8Ja4bZ/xLDmCcjyGVY?=
 =?us-ascii?Q?zqcGl7VO/Ru3rXFK0GgExCIrOg/uYjx76c48QtkQ9DZHBHKoeZ7Xur9MMHrO?=
 =?us-ascii?Q?aP53h6IBa+OkfnOgK2k7fggcroa+soT3ULZTjZ1+vuMzlWiNuNGYskSQwWNr?=
 =?us-ascii?Q?7phUf7whoy8tSCxkWc0mM85uOjFJmzAfpy+qaPI8LhML9+14eVwmx5zn1fZI?=
 =?us-ascii?Q?D1PNzY79P4rV2SBgJSv+ecgOR94/D9MiGN671Q8iHNVJj6aFJb1Qxu2VlDfb?=
 =?us-ascii?Q?QU36WPhHT1yvuQK3Y1iVeF95q98bO7NyoRc/GCq4X4ImqsfoXJO+oZK0/MTJ?=
 =?us-ascii?Q?ye6H2qy8+oDN9LhZd+7wQvJk9LbNHXk7oioHLZ/+VdA2jcuH4oxv38xvdYFl?=
 =?us-ascii?Q?Gfe3MKCMFIcBh4f1A2sq0e7m7vQFwtfjVsiCqKgTBNUdhvL4Z6GvJg87Gyom?=
 =?us-ascii?Q?a1RW2YyMKSFf/7kMnvp6nAc=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88e163ef-4ea1-43cb-67a2-08dbf2138b0e
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 02:16:35.7026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lfmL6PQiB7kbKW3ySiKME5+X1rGfLQgOYyBdS7/6GjRRIYD8S//Qtd6M+TV+telyqSTI1B9te4dNG2507ER3WDezfuSlk6Bt1MEJeSAE6LRoc31WYPTITgbvyQ7M2kqK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6196
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add JSON files for AmpereOneX core PMU events and metrics.

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 .../arch/arm64/ampere/ampereonex/branch.json  | 125 +++++
 .../arch/arm64/ampere/ampereonex/bus.json     |  20 +
 .../arch/arm64/ampere/ampereonex/cache.json   | 206 ++++++++
 .../arm64/ampere/ampereonex/core-imp-def.json | 464 ++++++++++++++++++
 .../arm64/ampere/ampereonex/exception.json    |  47 ++
 .../arm64/ampere/ampereonex/instruction.json  | 128 +++++
 .../arm64/ampere/ampereonex/intrinsic.json    |  14 +
 .../arch/arm64/ampere/ampereonex/memory.json  |  41 ++
 .../arch/arm64/ampere/ampereonex/metrics.json | 442 +++++++++++++++++
 .../arch/arm64/ampere/ampereonex/mmu.json     | 170 +++++++
 .../arm64/ampere/ampereonex/pipeline.json     |  41 ++
 .../arch/arm64/ampere/ampereonex/spe.json     |  14 +
 tools/perf/pmu-events/arch/arm64/mapfile.csv  |   1 +
 13 files changed, 1713 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereonex/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereonex/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereonex/cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereonex/core-imp-def.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereonex/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereonex/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereonex/intrinsic.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereonex/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereonex/mmu.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereonex/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereonex/spe.json

diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/branch.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/branch.json
new file mode 100644
index 000000000000..a632755fc086
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/branch.json
@@ -0,0 +1,125 @@
+[
+    {
+        "ArchStdEvent": "BR_IMMED_SPEC"
+    },
+    {
+        "ArchStdEvent": "BR_RETURN_SPEC"
+    },
+    {
+        "ArchStdEvent": "BR_INDIRECT_SPEC"
+    },
+    {
+        "ArchStdEvent": "BR_MIS_PRED"
+    },
+    {
+        "ArchStdEvent": "BR_PRED"
+    },
+    {
+        "PublicDescription": "Instruction architecturally executed, branch not taken",
+        "EventCode": "0x8107",
+        "EventName": "BR_SKIP_RETIRED",
+        "BriefDescription": "Instruction architecturally executed, branch not taken"
+    },
+    {
+        "PublicDescription": "Instruction architecturally executed, immediate branch taken",
+        "EventCode": "0x8108",
+        "EventName": "BR_IMMED_TAKEN_RETIRED",
+        "BriefDescription": "Instruction architecturally executed, immediate branch taken"
+    },
+    {
+        "PublicDescription": "Instruction architecturally executed, indirect branch excluding return retired",
+        "EventCode": "0x810c",
+        "EventName": "BR_INDNR_TAKEN_RETIRED",
+        "BriefDescription": "Instruction architecturally executed, indirect branch excluding return retired"
+    },
+    {
+        "PublicDescription": "Instruction architecturally executed, predicted immediate branch",
+        "EventCode": "0x8110",
+        "EventName": "BR_IMMED_PRED_RETIRED",
+        "BriefDescription": "Instruction architecturally executed, predicted immediate branch"
+    },
+    {
+        "PublicDescription": "Instruction architecturally executed, mispredicted immediate branch",
+        "EventCode": "0x8111",
+        "EventName": "BR_IMMED_MIS_PRED_RETIRED",
+        "BriefDescription": "Instruction architecturally executed, mispredicted immediate branch"
+    },
+    {
+        "PublicDescription": "Instruction architecturally executed, predicted indirect branch",
+        "EventCode": "0x8112",
+        "EventName": "BR_IND_PRED_RETIRED",
+        "BriefDescription": "Instruction architecturally executed, predicted indirect branch"
+    },
+    {
+        "PublicDescription": "Instruction architecturally executed, mispredicted indirect branch",
+        "EventCode": "0x8113",
+        "EventName": "BR_IND_MIS_PRED_RETIRED",
+        "BriefDescription": "Instruction architecturally executed, mispredicted indirect branch"
+    },
+    {
+        "PublicDescription": "Instruction architecturally executed, predicted procedure return",
+        "EventCode": "0x8114",
+        "EventName": "BR_RETURN_PRED_RETIRED",
+        "BriefDescription": "Instruction architecturally executed, predicted procedure return"
+    },
+    {
+        "PublicDescription": "Instruction architecturally executed, mispredicted procedure return",
+        "EventCode": "0x8115",
+        "EventName": "BR_RETURN_MIS_PRED_RETIRED",
+        "BriefDescription": "Instruction architecturally executed, mispredicted procedure return"
+    },
+    {
+        "PublicDescription": "Instruction architecturally executed, predicted indirect branch excluding return",
+        "EventCode": "0x8116",
+        "EventName": "BR_INDNR_PRED_RETIRED",
+        "BriefDescription": "Instruction architecturally executed, predicted indirect branch excluding return"
+    },
+    {
+        "PublicDescription": "Instruction architecturally executed, mispredicted indirect branch excluding return",
+        "EventCode": "0x8117",
+        "EventName": "BR_INDNR_MIS_PRED_RETIRED",
+        "BriefDescription": "Instruction architecturally executed, mispredicted indirect branch excluding return"
+    },
+    {
+        "PublicDescription": "Instruction architecturally executed, predicted branch, taken",
+        "EventCode": "0x8118",
+        "EventName": "BR_TAKEN_PRED_RETIRED",
+        "BriefDescription": "Instruction architecturally executed, predicted branch, taken"
+    },
+    {
+        "PublicDescription": "Instruction architecturally executed, mispredicted branch, taken",
+        "EventCode": "0x8119",
+        "EventName": "BR_TAKEN_MIS_PRED_RETIRED",
+        "BriefDescription": "Instruction architecturally executed, mispredicted branch, taken"
+    },
+    {
+        "PublicDescription": "Instruction architecturally executed, predicted branch, not taken",
+        "EventCode": "0x811a",
+        "EventName": "BR_SKIP_PRED_RETIRED",
+        "BriefDescription": "Instruction architecturally executed, predicted branch, not taken"
+    },
+    {
+        "PublicDescription": "Instruction architecturally executed, mispredicted branch, not taken",
+        "EventCode": "0x811b",
+        "EventName": "BR_SKIP_MIS_PRED_RETIRED",
+        "BriefDescription": "Instruction architecturally executed, mispredicted branch, not taken"
+    },
+    {
+        "PublicDescription": "Instruction architecturally executed, predicted branch",
+        "EventCode": "0x811c",
+        "EventName": "BR_PRED_RETIRED",
+        "BriefDescription": "Instruction architecturally executed, predicted branch"
+    },
+    {
+        "PublicDescription": "Instruction architecturally executed, indirect branch",
+        "EventCode": "0x811d",
+        "EventName": "BR_IND_RETIRED",
+        "BriefDescription": "Instruction architecturally executed, indirect branch"
+    },
+    {
+        "PublicDescription": "Branch Record captured.",
+        "EventCode": "0x811f",
+        "EventName": "BRB_FILTRATE",
+        "BriefDescription": "Branch Record captured."
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/bus.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/bus.json
new file mode 100644
index 000000000000..2aeb9907831d
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/bus.json
@@ -0,0 +1,20 @@
+[
+    {
+        "ArchStdEvent": "CPU_CYCLES"
+    },
+    {
+        "ArchStdEvent": "BUS_CYCLES"
+    },
+    {
+        "ArchStdEvent": "BUS_ACCESS_RD"
+    },
+    {
+        "ArchStdEvent": "BUS_ACCESS_WR"
+    },
+    {
+        "ArchStdEvent": "BUS_ACCESS"
+    },
+    {
+        "ArchStdEvent": "CNT_CYCLES"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/cache.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/cache.json
new file mode 100644
index 000000000000..c50d8e930b05
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/cache.json
@@ -0,0 +1,206 @@
+[
+    {
+        "ArchStdEvent": "L1D_CACHE_RD"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_WR"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL_RD"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_INVAL"
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_REFILL_RD"
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_REFILL_WR"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_RD"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_WR"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_REFILL_RD"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_REFILL_WR"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_WB_VICTIM"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_WB_CLEAN"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_INVAL"
+    },
+    {
+        "ArchStdEvent": "L1I_CACHE_REFILL"
+    },
+    {
+        "ArchStdEvent": "L1I_TLB_REFILL"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE"
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_REFILL"
+    },
+    {
+        "ArchStdEvent": "L1I_CACHE"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_REFILL"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_WB"
+    },
+    {
+        "ArchStdEvent": "L1D_TLB"
+    },
+    {
+        "ArchStdEvent": "L1I_TLB"
+    },
+    {
+        "ArchStdEvent": "L2D_TLB_REFILL"
+    },
+    {
+        "ArchStdEvent": "L2I_TLB_REFILL"
+    },
+    {
+        "ArchStdEvent": "L2D_TLB"
+    },
+    {
+        "ArchStdEvent": "L2I_TLB"
+    },
+    {
+        "ArchStdEvent": "DTLB_WALK"
+    },
+    {
+        "ArchStdEvent": "ITLB_WALK"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL_WR"
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_LMISS_RD"
+    },
+    {
+        "ArchStdEvent": "L1I_CACHE_LMISS"
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_LMISS_RD"
+    },
+    {
+        "PublicDescription": "Level 1 data or unified cache demand access",
+        "EventCode": "0x8140",
+        "EventName": "L1D_CACHE_RW",
+        "BriefDescription": "Level 1 data or unified cache demand access"
+    },
+    {
+        "PublicDescription": "Level 1 data or unified cache preload or prefetch",
+        "EventCode": "0x8142",
+        "EventName": "L1D_CACHE_PRFM",
+        "BriefDescription": "Level 1 data or unified cache preload or prefetch"
+    },
+    {
+        "PublicDescription": "Level 1 data or unified cache refill, preload or prefetch",
+        "EventCode": "0x8146",
+        "EventName": "L1D_CACHE_REFILL_PRFM",
+        "BriefDescription": "Level 1 data or unified cache refill, preload or prefetch"
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_RD"
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_WR"
+    },
+    {
+        "ArchStdEvent": "L2D_TLB_REFILL_RD"
+    },
+    {
+        "ArchStdEvent": "L2D_TLB_REFILL_WR"
+    },
+    {
+        "ArchStdEvent": "L2D_TLB_RD"
+    },
+    {
+        "ArchStdEvent": "L2D_TLB_WR"
+    },
+    {
+        "PublicDescription": "L1D TLB miss",
+        "EventCode": "0xD600",
+        "EventName": "L1D_TLB_MISS",
+        "BriefDescription": "L1D TLB miss"
+    },
+    {
+        "PublicDescription": "Level 1 prefetcher, load prefetch requests generated",
+        "EventCode": "0xd606",
+        "EventName": "L1_PREFETCH_LD_GEN",
+        "BriefDescription": "Level 1 prefetcher, load prefetch requests generated"
+    },
+    {
+        "PublicDescription": "Level 1 prefetcher, load prefetch fills into the level 1 cache",
+        "EventCode": "0xd607",
+        "EventName": "L1_PREFETCH_LD_FILL",
+        "BriefDescription": "Level 1 prefetcher, load prefetch fills into the level 1 cache"
+    },
+    {
+        "PublicDescription": "Level 1 prefetcher, load prefetch to level 2 generated",
+        "EventCode": "0xd608",
+        "EventName": "L1_PREFETCH_L2_REQ",
+        "BriefDescription": "Level 1 prefetcher, load prefetch to level 2 generated"
+    },
+    {
+        "PublicDescription": "L1 prefetcher, distance was reset",
+        "EventCode": "0xd609",
+        "EventName": "L1_PREFETCH_DIST_RST",
+        "BriefDescription": "L1 prefetcher, distance was reset"
+    },
+    {
+        "PublicDescription": "L1 prefetcher, distance was increased",
+        "EventCode": "0xd60a",
+        "EventName": "L1_PREFETCH_DIST_INC",
+        "BriefDescription": "L1 prefetcher, distance was increased"
+    },
+    {
+        "PublicDescription": "Level 1 prefetcher, table entry is trained",
+        "EventCode": "0xd60b",
+        "EventName": "L1_PREFETCH_ENTRY_TRAINED",
+        "BriefDescription": "Level 1 prefetcher, table entry is trained"
+    },
+    {
+        "PublicDescription": "L1 data cache refill - Read or Write",
+        "EventCode": "0xd60e",
+        "EventName": "L1D_CACHE_REFILL_RW",
+        "BriefDescription": "L1 data cache refill - Read or Write"
+    },
+    {
+        "PublicDescription": "Level 2 cache refill from instruction-side miss, including IMMU refills",
+        "EventCode": "0xD701",
+        "EventName": "L2C_INST_REFILL",
+        "BriefDescription": "Level 2 cache refill from instruction-side miss, including IMMU refills"
+    },
+    {
+        "PublicDescription": "Level 2 cache refill from data-side miss, including DMMU refills",
+        "EventCode": "0xD702",
+        "EventName": "L2C_DATA_REFILL",
+        "BriefDescription": "Level 2 cache refill from data-side miss, including DMMU refills"
+    },
+    {
+        "PublicDescription": "Level 2 cache prefetcher, load prefetch requests generated",
+        "EventCode": "0xD703",
+        "EventName": "L2_PREFETCH_REQ",
+        "BriefDescription": "Level 2 cache prefetcher, load prefetch requests generated"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/core-imp-def.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/core-imp-def.json
new file mode 100644
index 000000000000..eb5a2208d260
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/core-imp-def.json
@@ -0,0 +1,464 @@
+[
+    {
+        "PublicDescription": "Level 2 prefetch requests, refilled to L2 cache",
+        "EventCode": "0x10A",
+        "EventName": "L2_PREFETCH_REFILL",
+        "BriefDescription": "Level 2 prefetch requests, refilled to L2 cache"
+    },
+    {
+        "PublicDescription": "Level 2 prefetch requests, late",
+        "EventCode": "0x10B",
+        "EventName": "L2_PREFETCH_UPGRADE",
+        "BriefDescription": "Level 2 prefetch requests, late"
+    },
+    {
+        "PublicDescription": "Predictable branch speculatively executed that hit any level of BTB",
+        "EventCode": "0x110",
+        "EventName": "BPU_HIT_BTB",
+        "BriefDescription": "Predictable branch speculatively executed that hit any level of BTB"
+    },
+    {
+        "PublicDescription": "Predictable conditional branch speculatively executed that hit any level of BTB",
+        "EventCode": "0x111",
+        "EventName": "BPU_CONDITIONAL_BRANCH_HIT_BTB",
+        "BriefDescription": "Predictable conditional branch speculatively executed that hit any level of BTB"
+    },
+    {
+        "PublicDescription": "Predictable taken branch speculatively executed that hit any level of BTB that access the indirect predictor",
+        "EventCode": "0x112",
+        "EventName": "BPU_HIT_INDIRECT_PREDICTOR",
+        "BriefDescription": "Predictable taken branch speculatively executed that hit any level of BTB that access the indirect predictor"
+    },
+    {
+        "PublicDescription": "Predictable taken branch speculatively executed that hit any level of BTB that access the return predictor",
+        "EventCode": "0x113",
+        "EventName": "BPU_HIT_RSB",
+        "BriefDescription": "Predictable taken branch speculatively executed that hit any level of BTB that access the return predictor"
+    },
+    {
+        "PublicDescription": "Predictable unconditional branch speculatively executed that did not hit any level of BTB",
+        "EventCode": "0x114",
+        "EventName": "BPU_UNCONDITIONAL_BRANCH_MISS_BTB",
+        "BriefDescription": "Predictable unconditional branch speculatively executed that did not hit any level of BTB"
+    },
+    {
+        "PublicDescription": "Predictable branch speculatively executed, unpredicted",
+        "EventCode": "0x115",
+        "EventName": "BPU_BRANCH_NO_HIT",
+        "BriefDescription": "Predictable branch speculatively executed, unpredicted"
+    },
+    {
+        "PublicDescription": "Predictable branch speculatively executed that hit any level of BTB that mispredict",
+        "EventCode": "0x116",
+        "EventName": "BPU_HIT_BTB_AND_MISPREDICT",
+        "BriefDescription": "Predictable branch speculatively executed that hit any level of BTB that mispredict"
+    },
+    {
+        "PublicDescription": "Predictable conditional branch speculatively executed that hit any level of BTB that (direction) mispredict",
+        "EventCode": "0x117",
+        "EventName": "BPU_CONDITIONAL_BRANCH_HIT_BTB_AND_MISPREDICT",
+        "BriefDescription": "Predictable conditional branch speculatively executed that hit any level of BTB that (direction) mispredict"
+    },
+    {
+        "PublicDescription": "Predictable taken branch speculatively executed that hit any level of BTB that access the indirect predictor that mispredict",
+        "EventCode": "0x118",
+        "EventName": "BPU_INDIRECT_BRANCH_HIT_BTB_AND_MISPREDICT",
+        "BriefDescription": "Predictable taken branch speculatively executed that hit any level of BTB that access the indirect predictor that mispredict"
+    },
+    {
+        "PublicDescription": "Predictable taken branch speculatively executed that hit any level of BTB that access the return predictor that mispredict",
+        "EventCode": "0x119",
+        "EventName": "BPU_HIT_RSB_AND_MISPREDICT",
+        "BriefDescription": "Predictable taken branch speculatively executed that hit any level of BTB that access the return predictor that mispredict"
+    },
+    {
+        "PublicDescription": "Predictable taken branch speculatively executed that hit any level of BTB that access the overflow/underflow return predictor that mispredict",
+        "EventCode": "0x11a",
+        "EventName": "BPU_MISS_RSB_AND_MISPREDICT",
+        "BriefDescription": "Predictable taken branch speculatively executed that hit any level of BTB that access the overflow/underflow return predictor that mispredict"
+    },
+    {
+        "PublicDescription": "Predictable branch speculatively executed, unpredicted, that mispredict",
+        "EventCode": "0x11b",
+        "EventName": "BPU_NO_PREDICTION_MISPREDICT",
+        "BriefDescription": "Predictable branch speculatively executed, unpredicted, that mispredict"
+    },
+    {
+        "PublicDescription": "Preditable branch update the BTB region buffer entry",
+        "EventCode": "0x11c",
+        "EventName": "BPU_BTB_UPDATE",
+        "BriefDescription": "Preditable branch update the BTB region buffer entry"
+    },
+    {
+        "PublicDescription": "Count predict pipe stalls due to speculative return address predictor full",
+        "EventCode": "0x11d",
+        "EventName": "BPU_RSB_FULL_STALL",
+        "BriefDescription": "Count predict pipe stalls due to speculative return address predictor full"
+    },
+    {
+        "PublicDescription": "Macro-ops speculatively decoded",
+        "EventCode": "0x11f",
+        "EventName": "ICF_INST_SPEC_DECODE",
+        "BriefDescription": "Macro-ops speculatively decoded"
+    },
+    {
+        "PublicDescription": "Flushes",
+        "EventCode": "0x120",
+        "EventName": "GPC_FLUSH",
+        "BriefDescription": "Flushes"
+    },
+    {
+        "PublicDescription": "Flushes due to memory hazards",
+        "EventCode": "0x121",
+        "EventName": "GPC_FLUSH_MEM_FAULT",
+        "BriefDescription": "Flushes due to memory hazards"
+    },
+    {
+        "PublicDescription": "ETM extout bit 0",
+        "EventCode": "0x141",
+        "EventName": "MSC_ETM_EXTOUT0",
+        "BriefDescription": "ETM extout bit 0"
+    },
+    {
+        "PublicDescription": "ETM extout bit 1",
+        "EventCode": "0x142",
+        "EventName": "MSC_ETM_EXTOUT1",
+        "BriefDescription": "ETM extout bit 1"
+    },
+    {
+        "PublicDescription": "ETM extout bit 2",
+        "EventCode": "0x143",
+        "EventName": "MSC_ETM_EXTOUT2",
+        "BriefDescription": "ETM extout bit 2"
+    },
+    {
+        "PublicDescription": "ETM extout bit 3",
+        "EventCode": "0x144",
+        "EventName": "MSC_ETM_EXTOUT3",
+        "BriefDescription": "ETM extout bit 3"
+    },
+    {
+        "PublicDescription": "Bus request sn",
+        "EventCode": "0x156",
+        "EventName": "L2C_SNOOP",
+        "BriefDescription": "Bus request sn"
+    },
+    {
+        "PublicDescription": "L2 TXDAT LCRD blocked",
+        "EventCode": "0x169",
+        "EventName": "L2C_DAT_CRD_STALL",
+        "BriefDescription": "L2 TXDAT LCRD blocked"
+    },
+    {
+        "PublicDescription": "L2 TXRSP LCRD blocked",
+        "EventCode": "0x16a",
+        "EventName": "L2C_RSP_CRD_STALL",
+        "BriefDescription": "L2 TXRSP LCRD blocked"
+    },
+    {
+        "PublicDescription": "L2 TXREQ LCRD blocked",
+        "EventCode": "0x16b",
+        "EventName": "L2C_REQ_CRD_STALL",
+        "BriefDescription": "L2 TXREQ LCRD blocked"
+    },
+    {
+        "PublicDescription": "Early mispredict",
+        "EventCode": "0xD100",
+        "EventName": "ICF_EARLY_MIS_PRED",
+        "BriefDescription": "Early mispredict"
+    },
+    {
+        "PublicDescription": "FEQ full cycles",
+        "EventCode": "0xD101",
+        "EventName": "ICF_FEQ_FULL",
+        "BriefDescription": "FEQ full cycles"
+    },
+    {
+        "PublicDescription": "Instruction FIFO Full",
+        "EventCode": "0xD102",
+        "EventName": "ICF_INST_FIFO_FULL",
+        "BriefDescription": "Instruction FIFO Full"
+    },
+    {
+        "PublicDescription": "L1I TLB miss",
+        "EventCode": "0xD103",
+        "EventName": "L1I_TLB_MISS",
+        "BriefDescription": "L1I TLB miss"
+    },
+    {
+        "PublicDescription": "ICF sent 0 instructions to IDR this cycle",
+        "EventCode": "0xD104",
+        "EventName": "ICF_STALL",
+        "BriefDescription": "ICF sent 0 instructions to IDR this cycle"
+    },
+    {
+        "PublicDescription": "PC FIFO Full",
+        "EventCode": "0xD105",
+        "EventName": "ICF_PC_FIFO_FULL",
+        "BriefDescription": "PC FIFO Full"
+    },
+    {
+        "PublicDescription": "Stall due to BOB ID",
+        "EventCode": "0xD200",
+        "EventName": "IDR_STALL_BOB_ID",
+        "BriefDescription": "Stall due to BOB ID"
+    },
+    {
+        "PublicDescription": "Dispatch stall due to LOB entries",
+        "EventCode": "0xD201",
+        "EventName": "IDR_STALL_LOB_ID",
+        "BriefDescription": "Dispatch stall due to LOB entries"
+    },
+    {
+        "PublicDescription": "Dispatch stall due to SOB entries",
+        "EventCode": "0xD202",
+        "EventName": "IDR_STALL_SOB_ID",
+        "BriefDescription": "Dispatch stall due to SOB entries"
+    },
+    {
+        "PublicDescription": "Dispatch stall due to IXU scheduler entries",
+        "EventCode": "0xD203",
+        "EventName": "IDR_STALL_IXU_SCHED",
+        "BriefDescription": "Dispatch stall due to IXU scheduler entries"
+    },
+    {
+        "PublicDescription": "Dispatch stall due to FSU scheduler entries",
+        "EventCode": "0xD204",
+        "EventName": "IDR_STALL_FSU_SCHED",
+        "BriefDescription": "Dispatch stall due to FSU scheduler entries"
+    },
+    {
+        "PublicDescription": "Dispatch stall due to ROB entries",
+        "EventCode": "0xD205",
+        "EventName": "IDR_STALL_ROB_ID",
+        "BriefDescription": "Dispatch stall due to ROB entries"
+    },
+    {
+        "PublicDescription": "Dispatch stall due to flush",
+        "EventCode": "0xD206",
+        "EventName": "IDR_STALL_FLUSH",
+        "BriefDescription": "Dispatch stall due to flush"
+    },
+    {
+        "PublicDescription": "Dispatch stall due to WFI",
+        "EventCode": "0xD207",
+        "EventName": "IDR_STALL_WFI",
+        "BriefDescription": "Dispatch stall due to WFI"
+    },
+    {
+        "PublicDescription": "Number of SWOB drains triggered by timeout",
+        "EventCode": "0xD208",
+        "EventName": "IDR_STALL_SWOB_TIMEOUT",
+        "BriefDescription": "Number of SWOB drains triggered by timeout"
+    },
+    {
+        "PublicDescription": "Number of SWOB drains triggered by system register or special-purpose register read-after-write or specific special-purpose register writes that cause SWOB drain",
+        "EventCode": "0xD209",
+        "EventName": "IDR_STALL_SWOB_RAW",
+        "BriefDescription": "Number of SWOB drains triggered by system register or special-purpose register read-after-write or specific special-purpose register writes that cause SWOB drain"
+    },
+    {
+        "PublicDescription": "Number of SWOB drains triggered by system register write when SWOB full",
+        "EventCode": "0xD20A",
+        "EventName": "IDR_STALL_SWOB_FULL",
+        "BriefDescription": "Number of SWOB drains triggered by system register write when SWOB full"
+    },
+    {
+        "PublicDescription": "Dispatch stall due to L1 instruction cache miss",
+        "EventCode": "0xD20B",
+        "EventName": "STALL_FRONTEND_CACHE",
+        "BriefDescription": "Dispatch stall due to L1 instruction cache miss"
+    },
+    {
+        "PublicDescription": "Dispatch stall due to L1 data cache miss",
+        "EventCode": "0xD20D",
+        "EventName": "STALL_BACKEND_CACHE",
+        "BriefDescription": "Dispatch stall due to L1 data cache miss"
+    },
+    {
+        "PublicDescription": "Dispatch stall due to lack of any core resource",
+        "EventCode": "0xD20F",
+        "EventName": "STALL_BACKEND_RESOURCE",
+        "BriefDescription": "Dispatch stall due to lack of any core resource"
+    },
+    {
+        "PublicDescription": "Instructions issued by the scheduler",
+        "EventCode": "0xD300",
+        "EventName": "IXU_NUM_UOPS_ISSUED",
+        "BriefDescription": "Instructions issued by the scheduler"
+    },
+    {
+        "PublicDescription": "Any uop issued was canceled for any reason",
+        "EventCode": "0xD301",
+        "EventName": "IXU_ISSUE_CANCEL",
+        "BriefDescription": "Any uop issued was canceled for any reason"
+    },
+    {
+        "PublicDescription": "A load wakeup to the scheduler has been canceled",
+        "EventCode": "0xD302",
+        "EventName": "IXU_LOAD_CANCEL",
+        "BriefDescription": "A load wakeup to the scheduler has been canceled"
+    },
+    {
+        "PublicDescription": "The scheduler had to cancel one slow Uop due to resource conflict",
+        "EventCode": "0xD303",
+        "EventName": "IXU_SLOW_CANCEL",
+        "BriefDescription": "The scheduler had to cancel one slow Uop due to resource conflict"
+    },
+    {
+        "PublicDescription": "Uops issued by the scheduler on IXA",
+        "EventCode": "0xD304",
+        "EventName": "IXU_IXA_ISSUED",
+        "BriefDescription": "Uops issued by the scheduler on IXA"
+    },
+    {
+        "PublicDescription": "Uops issued by the scheduler on IXA Par 0",
+        "EventCode": "0xD305",
+        "EventName": "IXU_IXA_PAR0_ISSUED",
+        "BriefDescription": "Uops issued by the scheduler on IXA Par 0"
+    },
+    {
+        "PublicDescription": "Uops issued by the scheduler on IXA Par 1",
+        "EventCode": "0xD306",
+        "EventName": "IXU_IXA_PAR1_ISSUED",
+        "BriefDescription": "Uops issued by the scheduler on IXA Par 1"
+    },
+    {
+        "PublicDescription": "Uops issued by the scheduler on IXB",
+        "EventCode": "0xD307",
+        "EventName": "IXU_IXB_ISSUED",
+        "BriefDescription": "Uops issued by the scheduler on IXB"
+    },
+    {
+        "PublicDescription": "Uops issued by the scheduler on IXB Par 0",
+        "EventCode": "0xD308",
+        "EventName": "IXU_IXB_PAR0_ISSUED",
+        "BriefDescription": "Uops issued by the scheduler on IXB Par 0"
+    },
+    {
+        "PublicDescription": "Uops issued by the scheduler on IXB Par 1",
+        "EventCode": "0xD309",
+        "EventName": "IXU_IXB_PAR1_ISSUED",
+        "BriefDescription": "Uops issued by the scheduler on IXB Par 1"
+    },
+    {
+        "PublicDescription": "Uops issued by the scheduler on IXC",
+        "EventCode": "0xD30A",
+        "EventName": "IXU_IXC_ISSUED",
+        "BriefDescription": "Uops issued by the scheduler on IXC"
+    },
+    {
+        "PublicDescription": "Uops issued by the scheduler on IXC Par 0",
+        "EventCode": "0xD30B",
+        "EventName": "IXU_IXC_PAR0_ISSUED",
+        "BriefDescription": "Uops issued by the scheduler on IXC Par 0"
+    },
+    {
+        "PublicDescription": "Uops issued by the scheduler on IXC Par 1",
+        "EventCode": "0xD30C",
+        "EventName": "IXU_IXC_PAR1_ISSUED",
+        "BriefDescription": "Uops issued by the scheduler on IXC Par 1"
+    },
+    {
+        "PublicDescription": "Uops issued by the scheduler on IXD",
+        "EventCode": "0xD30D",
+        "EventName": "IXU_IXD_ISSUED",
+        "BriefDescription": "Uops issued by the scheduler on IXD"
+    },
+    {
+        "PublicDescription": "Uops issued by the scheduler on IXD Par 0",
+        "EventCode": "0xD30E",
+        "EventName": "IXU_IXD_PAR0_ISSUED",
+        "BriefDescription": "Uops issued by the scheduler on IXD Par 0"
+    },
+    {
+        "PublicDescription": "Uops issued by the scheduler on IXD Par 1",
+        "EventCode": "0xD30F",
+        "EventName": "IXU_IXD_PAR1_ISSUED",
+        "BriefDescription": "Uops issued by the scheduler on IXD Par 1"
+    },
+    {
+        "PublicDescription": "Uops issued by the FSU scheduler",
+        "EventCode": "0xD400",
+        "EventName": "FSU_ISSUED",
+        "BriefDescription": "Uops issued by the FSU scheduler"
+    },
+    {
+        "PublicDescription": "Uops issued by the scheduler on FSX",
+        "EventCode": "0xD401",
+        "EventName": "FSU_FSX_ISSUED",
+        "BriefDescription": "Uops issued by the scheduler on FSX"
+    },
+    {
+        "PublicDescription": "Uops issued by the scheduler on FSY",
+        "EventCode": "0xD402",
+        "EventName": "FSU_FSY_ISSUED",
+        "BriefDescription": "Uops issued by the scheduler on FSY"
+    },
+    {
+        "PublicDescription": "Uops issued by the scheduler on FSZ",
+        "EventCode": "0xD403",
+        "EventName": "FSU_FSZ_ISSUED",
+        "BriefDescription": "Uops issued by the scheduler on FSZ"
+    },
+    {
+        "PublicDescription": "Uops canceled (load cancels)",
+        "EventCode": "0xD404",
+        "EventName": "FSU_CANCEL",
+        "BriefDescription": "Uops canceled (load cancels)"
+    },
+    {
+        "PublicDescription": "Count scheduler stalls due to divide/sqrt",
+        "EventCode": "0xD405",
+        "EventName": "FSU_DIV_SQRT_STALL",
+        "BriefDescription": "Count scheduler stalls due to divide/sqrt"
+    },
+    {
+        "PublicDescription": "Number of SWOB drains",
+        "EventCode": "0xD500",
+        "EventName": "GPC_SWOB_DRAIN",
+        "BriefDescription": "Number of SWOB drains"
+    },
+    {
+        "PublicDescription": "GPC detected a Breakpoint instruction match",
+        "EventCode": "0xD501",
+        "EventName": "BREAKPOINT_MATCH",
+        "BriefDescription": "GPC detected a Breakpoint instruction match"
+    },
+    {
+        "PublicDescription": "Core progress monitor triggered",
+        "EventCode": "0xd502",
+        "EventName": "GPC_CPM_TRIGGER",
+        "BriefDescription": "Core progress monitor triggered"
+    },
+    {
+        "PublicDescription": "Fill buffer full",
+        "EventCode": "0xD601",
+        "EventName": "OFB_FULL",
+        "BriefDescription": "Fill buffer full"
+    },
+    {
+        "PublicDescription": "Load satisified from store forwarded data",
+        "EventCode": "0xD605",
+        "EventName": "LD_FROM_ST_FWD",
+        "BriefDescription": "Load satisified from store forwarded data"
+    },
+    {
+        "PublicDescription": "Store retirement pipe stall",
+        "EventCode": "0xD60C",
+        "EventName": "LSU_ST_RETIRE_STALL",
+        "BriefDescription": "Store retirement pipe stall"
+    },
+    {
+        "PublicDescription": "LSU detected a Watchpoint data match",
+        "EventCode": "0xD60D",
+        "EventName": "WATCHPOINT_MATCH",
+        "BriefDescription": "LSU detected a Watchpoint data match"
+    },
+    {
+        "PublicDescription": "Counts cycles that MSC is telling GPC to stall commit due to ETM ISTALL feature",
+        "EventCode": "0xda00",
+        "EventName": "MSC_ETM_COMMIT_STALL",
+        "BriefDescription": "Counts cycles that MSC is telling GPC to stall commit due to ETM ISTALL feature"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/exception.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/exception.json
new file mode 100644
index 000000000000..bd59ba7b74e4
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/exception.json
@@ -0,0 +1,47 @@
+[
+    {
+        "ArchStdEvent": "EXC_UNDEF"
+    },
+    {
+        "ArchStdEvent": "EXC_SVC"
+    },
+    {
+        "ArchStdEvent": "EXC_PABORT"
+    },
+    {
+        "ArchStdEvent": "EXC_DABORT"
+    },
+    {
+        "ArchStdEvent": "EXC_IRQ"
+    },
+    {
+        "ArchStdEvent": "EXC_FIQ"
+    },
+    {
+        "ArchStdEvent": "EXC_HVC"
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_PABORT"
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_DABORT"
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_OTHER"
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_IRQ"
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_FIQ"
+    },
+    {
+        "ArchStdEvent": "EXC_TAKEN"
+    },
+    {
+        "ArchStdEvent": "EXC_RETURN"
+    },
+    {
+        "ArchStdEvent": "EXC_SMC"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/instruction.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/instruction.json
new file mode 100644
index 000000000000..a6a20f541e33
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/instruction.json
@@ -0,0 +1,128 @@
+[
+    {
+        "ArchStdEvent": "SW_INCR"
+    },
+    {
+        "ArchStdEvent": "ST_RETIRED"
+    },
+    {
+        "ArchStdEvent": "LD_SPEC"
+    },
+    {
+        "ArchStdEvent": "ST_SPEC"
+    },
+    {
+        "ArchStdEvent": "LDST_SPEC"
+    },
+    {
+        "ArchStdEvent": "DP_SPEC"
+    },
+    {
+        "ArchStdEvent": "ASE_SPEC"
+    },
+    {
+        "ArchStdEvent": "VFP_SPEC"
+    },
+    {
+        "ArchStdEvent": "PC_WRITE_SPEC"
+    },
+    {
+        "ArchStdEvent": "BR_IMMED_RETIRED"
+    },
+    {
+        "ArchStdEvent": "BR_RETURN_RETIRED"
+    },
+    {
+        "ArchStdEvent": "CRYPTO_SPEC"
+    },
+    {
+        "ArchStdEvent": "ISB_SPEC"
+    },
+    {
+        "ArchStdEvent": "DSB_SPEC"
+    },
+    {
+        "ArchStdEvent": "DMB_SPEC"
+    },
+    {
+        "ArchStdEvent": "RC_LD_SPEC"
+    },
+    {
+        "ArchStdEvent": "RC_ST_SPEC"
+    },
+    {
+        "ArchStdEvent": "INST_RETIRED"
+    },
+    {
+        "ArchStdEvent": "CID_WRITE_RETIRED"
+    },
+    {
+        "ArchStdEvent": "PC_WRITE_RETIRED"
+    },
+    {
+        "ArchStdEvent": "INST_SPEC"
+    },
+    {
+        "ArchStdEvent": "TTBR_WRITE_RETIRED"
+    },
+    {
+        "ArchStdEvent": "BR_RETIRED"
+    },
+    {
+        "ArchStdEvent": "BR_MIS_PRED_RETIRED"
+    },
+    {
+        "ArchStdEvent": "OP_RETIRED"
+    },
+    {
+        "ArchStdEvent": "OP_SPEC"
+    },
+    {
+        "PublicDescription": "Operation speculatively executed - ASE Scalar",
+        "EventCode": "0xd210",
+        "EventName": "ASE_SCALAR_SPEC",
+        "BriefDescription": "Operation speculatively executed - ASE Scalar"
+    },
+    {
+        "PublicDescription": "Operation speculatively executed - ASE Vector",
+        "EventCode": "0xd211",
+        "EventName": "ASE_VECTOR_SPEC",
+        "BriefDescription": "Operation speculatively executed - ASE Vector"
+    },
+    {
+        "PublicDescription": "Barrier speculatively executed, CSDB",
+        "EventCode": "0x7f",
+        "EventName": "CSDB_SPEC",
+        "BriefDescription": "Barrier speculatively executed, CSDB"
+    },
+    {
+        "PublicDescription": "Prefetch sent to L2.",
+        "EventCode": "0xd106",
+        "EventName": "ICF_PREFETCH_DISPATCH",
+        "BriefDescription": "Prefetch sent to L2."
+    },
+    {
+        "PublicDescription": "Prefetch response received but was dropped since we don't support inflight upgrades.",
+        "EventCode": "0xd107",
+        "EventName": "ICF_PREFETCH_DROPPED_NO_UPGRADE",
+        "BriefDescription": "Prefetch response received but was dropped since we don't support inflight upgrades."
+    },
+    {
+        "PublicDescription": "Prefetch request missed TLB.",
+        "EventCode": "0xd108",
+        "EventName": "ICF_PREFETCH_DROPPED_TLB_MISS",
+        "BriefDescription": "Prefetch request missed TLB."
+    },
+    {
+        "PublicDescription": "Prefetch request dropped since duplicate was found in TLB.",
+        "EventCode": "0xd109",
+        "EventName": "ICF_PREFETCH_DROPPED_DUPLICATE",
+        "BriefDescription": "Prefetch request dropped since duplicate was found in TLB."
+    },
+    {
+        "PublicDescription": "Prefetch request dropped since it was found in cache.",
+        "EventCode": "0xd10a",
+        "EventName": "ICF_PREFETCH_DROPPED_CACHE_HIT",
+        "BriefDescription": "Prefetch request dropped since it was found in cache."
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/intrinsic.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/intrinsic.json
new file mode 100644
index 000000000000..7ecffb989ae0
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/intrinsic.json
@@ -0,0 +1,14 @@
+[
+    {
+        "ArchStdEvent": "LDREX_SPEC"
+    },
+    {
+        "ArchStdEvent": "STREX_PASS_SPEC"
+    },
+    {
+        "ArchStdEvent": "STREX_FAIL_SPEC"
+    },
+    {
+        "ArchStdEvent": "STREX_SPEC"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/memory.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/memory.json
new file mode 100644
index 000000000000..a211d94aacde
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/memory.json
@@ -0,0 +1,41 @@
+[
+    {
+        "ArchStdEvent": "LD_RETIRED"
+    },
+    {
+        "ArchStdEvent": "MEM_ACCESS_RD"
+    },
+    {
+        "ArchStdEvent": "MEM_ACCESS_WR"
+    },
+    {
+        "ArchStdEvent": "LD_ALIGN_LAT"
+    },
+    {
+        "ArchStdEvent": "ST_ALIGN_LAT"
+    },
+    {
+        "ArchStdEvent": "MEM_ACCESS"
+    },
+    {
+        "ArchStdEvent": "MEMORY_ERROR"
+    },
+    {
+        "ArchStdEvent": "LDST_ALIGN_LAT"
+    },
+    {
+        "ArchStdEvent": "MEM_ACCESS_CHECKED"
+    },
+    {
+        "ArchStdEvent": "MEM_ACCESS_CHECKED_RD"
+    },
+    {
+        "ArchStdEvent": "MEM_ACCESS_CHECKED_WR"
+    },
+    {
+        "PublicDescription": "Flushes due to memory hazards",
+        "EventCode": "0x121",
+        "EventName": "BPU_FLUSH_MEM_FAULT",
+        "BriefDescription": "Flushes due to memory hazards"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json
new file mode 100644
index 000000000000..c5d1d22bd034
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json
@@ -0,0 +1,442 @@
+[
+    {
+        "MetricName": "branch_miss_pred_rate",
+        "MetricExpr": "BR_MIS_PRED / BR_PRED",
+        "BriefDescription": "Branch predictor misprediction rate. May not count branches that are never resolved because they are in the misprediction shadow of an earlier branch",
+        "MetricGroup": "branch",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricName": "bus_utilization",
+        "MetricExpr": "BUS_ACCESS / (BUS_CYCLES * 1)",
+        "BriefDescription": "Core-to-uncore bus utilization",
+        "MetricGroup": "Bus",
+        "ScaleUnit": "100percent of bus cycles"
+    },
+    {
+        "MetricName": "l1d_cache_miss_ratio",
+        "MetricExpr": "L1D_CACHE_REFILL / L1D_CACHE",
+        "BriefDescription": "This metric measures the ratio of level 1 data cache accesses missed to the total number of level 1 data cache accesses. This gives an indication of the effectiveness of the level 1 data cache.",
+        "MetricGroup": "Miss_Ratio;L1D_Cache_Effectiveness",
+        "ScaleUnit": "1per cache access"
+    },
+    {
+        "MetricName": "l1i_cache_miss_ratio",
+        "MetricExpr": "L1I_CACHE_REFILL / L1I_CACHE",
+        "BriefDescription": "This metric measures the ratio of level 1 instruction cache accesses missed to the total number of level 1 instruction cache accesses. This gives an indication of the effectiveness of the level 1 instruction cache.",
+        "MetricGroup": "Miss_Ratio;L1I_Cache_Effectiveness",
+        "ScaleUnit": "1per cache access"
+    },
+    {
+        "MetricName": "Miss_Ratio;l1d_cache_read_miss",
+        "MetricExpr": "L1D_CACHE_LMISS_RD / L1D_CACHE_RD",
+        "BriefDescription": "L1D cache read miss rate",
+        "MetricGroup": "Cache",
+        "ScaleUnit": "1per cache read access"
+    },
+    {
+        "MetricName": "l2_cache_miss_ratio",
+        "MetricExpr": "L2D_CACHE_REFILL / L2D_CACHE",
+        "BriefDescription": "This metric measures the ratio of level 2 cache accesses missed to the total number of level 2 cache accesses. This gives an indication of the effectiveness of the level 2 cache, which is a unified cache that stores both data and instruction. Note that cache accesses in this cache are either data memory access or instruction fetch as this is a unified cache.",
+        "MetricGroup": "Miss_Ratio;L2_Cache_Effectiveness",
+        "ScaleUnit": "1per cache access"
+    },
+    {
+        "MetricName": "l1i_cache_read_miss_rate",
+        "MetricExpr": "L1I_CACHE_LMISS / L1I_CACHE",
+        "BriefDescription": "L1I cache read miss rate",
+        "MetricGroup": "Cache",
+        "ScaleUnit": "1per cache access"
+    },
+    {
+        "MetricName": "l2d_cache_read_miss_rate",
+        "MetricExpr": "L2D_CACHE_LMISS_RD / L2D_CACHE_RD",
+        "BriefDescription": "L2 cache read miss rate",
+        "MetricGroup": "Cache",
+        "ScaleUnit": "1per cache read access"
+    },
+    {
+        "MetricName": "l1d_cache_miss_mpki",
+        "MetricExpr": "(L1D_CACHE_LMISS_RD * 1e3) / INST_RETIRED",
+        "BriefDescription": "Misses per thousand instructions (data)",
+        "MetricGroup": "Cache",
+        "ScaleUnit": "1MPKI"
+    },
+    {
+        "MetricName": "l1i_cache_miss_mpki",
+        "MetricExpr": "(L1I_CACHE_LMISS * 1e3) / INST_RETIRED",
+        "BriefDescription": "Misses per thousand instructions (instruction)",
+        "MetricGroup": "Cache",
+        "ScaleUnit": "1MPKI"
+    },
+    {
+        "MetricName": "simd_percentage",
+        "MetricExpr": "ASE_SPEC / INST_SPEC",
+        "BriefDescription": "This metric measures advanced SIMD operations as a percentage of total operations speculatively executed.",
+        "MetricGroup": "Operation_Mix",
+        "ScaleUnit": "100percent of operations"
+    },
+    {
+        "MetricName": "crypto_percentage",
+        "MetricExpr": "CRYPTO_SPEC / INST_SPEC",
+        "BriefDescription": "This metric measures crypto operations as a percentage of operations speculatively executed.",
+        "MetricGroup": "Operation_Mix",
+        "ScaleUnit": "100percent of operations"
+    },
+    {
+        "MetricName": "gflops",
+        "MetricExpr": "VFP_SPEC / (duration_time * 1e9)",
+        "BriefDescription": "Giga-floating point operations per second",
+        "MetricGroup": "InstructionMix"
+    },
+    {
+        "MetricName": "integer_dp_percentage",
+        "MetricExpr": "DP_SPEC / INST_SPEC",
+        "BriefDescription": "This metric measures scalar integer operations as a percentage of operations speculatively executed.",
+        "MetricGroup": "Operation_Mix",
+        "ScaleUnit": "100percent of operations"
+    },
+    {
+        "MetricName": "ipc",
+        "MetricExpr": "INST_RETIRED / CPU_CYCLES",
+        "BriefDescription": "This metric measures the number of instructions retired per cycle.",
+        "MetricGroup": "General",
+        "ScaleUnit": "1per cycle"
+    },
+    {
+        "MetricName": "load_percentage",
+        "MetricExpr": "LD_SPEC / INST_SPEC",
+        "BriefDescription": "This metric measures load operations as a percentage of operations speculatively executed.",
+        "MetricGroup": "Operation_Mix",
+        "ScaleUnit": "100percent of operations"
+    },
+    {
+        "MetricName": "load_store_spec_rate",
+        "MetricExpr": "LDST_SPEC / INST_SPEC",
+        "BriefDescription": "The rate of load or store instructions speculatively executed to overall instructions speclatively executed",
+        "MetricGroup": "Operation_Mix",
+        "ScaleUnit": "100percent of operations"
+    },
+    {
+        "MetricName": "retired_mips",
+        "MetricExpr": "INST_RETIRED / (duration_time * 1e6)",
+        "BriefDescription": "Millions of instructions per second",
+        "MetricGroup": "InstructionMix"
+    },
+    {
+        "MetricName": "spec_utilization_mips",
+        "MetricExpr": "INST_SPEC / (duration_time * 1e6)",
+        "BriefDescription": "Millions of instructions per second",
+        "MetricGroup": "PEutilization"
+    },
+    {
+        "MetricName": "pc_write_spec_rate",
+        "MetricExpr": "PC_WRITE_SPEC / INST_SPEC",
+        "BriefDescription": "The rate of software change of the PC speculatively executed to overall instructions speclatively executed",
+        "MetricGroup": "Operation_Mix",
+        "ScaleUnit": "100percent of operations"
+    },
+    {
+        "MetricName": "store_percentage",
+        "MetricExpr": "ST_SPEC / INST_SPEC",
+        "BriefDescription": "This metric measures store operations as a percentage of operations speculatively executed.",
+        "MetricGroup": "Operation_Mix",
+        "ScaleUnit": "100percent of operations"
+    },
+    {
+        "MetricName": "scalar_fp_percentage",
+        "MetricExpr": "VFP_SPEC / INST_SPEC",
+        "BriefDescription": "This metric measures scalar floating point operations as a percentage of operations speculatively executed.",
+        "MetricGroup": "Operation_Mix",
+        "ScaleUnit": "100percent of operations"
+    },
+    {
+        "MetricName": "retired_rate",
+        "MetricExpr": "OP_RETIRED / OP_SPEC",
+        "BriefDescription": "Of all the micro-operations issued, what percentage are retired(committed)",
+        "MetricGroup": "General",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricName": "wasted",
+        "MetricExpr": "1 - (OP_RETIRED / (CPU_CYCLES * #slots))",
+        "BriefDescription": "Of all the micro-operations issued, what proportion are lost",
+        "MetricGroup": "General",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricName": "wasted_rate",
+        "MetricExpr": "1 - OP_RETIRED / OP_SPEC",
+        "BriefDescription": "Of all the micro-operations issued, what percentage are not retired(committed)",
+        "MetricGroup": "General",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricName": "stall_backend_cache_rate",
+        "MetricExpr": "STALL_BACKEND_CACHE / CPU_CYCLES",
+        "BriefDescription": "Proportion of cycles stalled and no operations issued to backend and cache miss",
+        "MetricGroup": "Stall",
+        "ScaleUnit": "100percent of cycles"
+    },
+    {
+        "MetricName": "stall_backend_resource_rate",
+        "MetricExpr": "STALL_BACKEND_RESOURCE / CPU_CYCLES",
+        "BriefDescription": "Proportion of cycles stalled and no operations issued to backend and resource full",
+        "MetricGroup": "Stall",
+        "ScaleUnit": "100percent of cycles"
+    },
+    {
+        "MetricName": "stall_backend_tlb_rate",
+        "MetricExpr": "STALL_BACKEND_TLB / CPU_CYCLES",
+        "BriefDescription": "Proportion of cycles stalled and no operations issued to backend and TLB miss",
+        "MetricGroup": "Stall",
+        "ScaleUnit": "100percent of cycles"
+    },
+    {
+        "MetricName": "stall_frontend_cache_rate",
+        "MetricExpr": "STALL_FRONTEND_CACHE / CPU_CYCLES",
+        "BriefDescription": "Proportion of cycles stalled and no ops delivered from frontend and cache miss",
+        "MetricGroup": "Stall",
+        "ScaleUnit": "100percent of cycles"
+    },
+    {
+        "MetricName": "stall_frontend_tlb_rate",
+        "MetricExpr": "STALL_FRONTEND_TLB / CPU_CYCLES",
+        "BriefDescription": "Proportion of cycles stalled and no ops delivered from frontend and TLB miss",
+        "MetricGroup": "Stall",
+        "ScaleUnit": "100percent of cycles"
+    },
+    {
+        "MetricName": "dtlb_walk_ratio",
+        "MetricExpr": "DTLB_WALK / L1D_TLB",
+        "BriefDescription": "This metric measures the ratio of data TLB Walks to the total number of data TLB accesses. This gives an indication of the effectiveness of the data TLB accesses.",
+        "MetricGroup": "Miss_Ratio;DTLB_Effectiveness",
+        "ScaleUnit": "1per TLB access"
+    },
+    {
+        "MetricName": "itlb_walk_ratio",
+        "MetricExpr": "ITLB_WALK / L1I_TLB",
+        "BriefDescription": "This metric measures the ratio of instruction TLB Walks to the total number of instruction TLB accesses. This gives an indication of the effectiveness of the instruction TLB accesses.",
+        "MetricGroup": "Miss_Ratio;ITLB_Effectiveness",
+        "ScaleUnit": "1per TLB access"
+    },
+    {
+        "ArchStdEvent": "backend_bound"
+    },
+    {
+        "ArchStdEvent": "frontend_bound",
+        "MetricExpr": "100 - (retired_fraction + slots_lost_misspeculation_fraction + backend_bound)"
+    },
+    {
+        "MetricName": "slots_lost_misspeculation_fraction",
+        "MetricExpr": "(OP_SPEC - OP_RETIRED) / (CPU_CYCLES * #slots)",
+        "BriefDescription": "Fraction of slots lost due to misspeculation",
+        "DefaultMetricgroupName": "TopdownL1",
+        "MetricGroup": "Default;TopdownL1",
+        "ScaleUnit": "100percent of slots"
+    },
+    {
+        "MetricName": "retired_fraction",
+        "MetricExpr": "OP_RETIRED / (CPU_CYCLES * #slots)",
+        "BriefDescription": "Fraction of slots retiring, useful work",
+        "DefaultMetricgroupName": "TopdownL1",
+        "MetricGroup": "Default;TopdownL1",
+        "ScaleUnit": "100percent of slots"
+    },
+    {
+        "MetricName": "backend_core",
+        "MetricExpr": "(backend_bound / 100) - backend_memory",
+        "BriefDescription": "Fraction of slots the CPU was stalled due to backend non-memory subsystem issues",
+        "MetricGroup": "TopdownL2",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricName": "backend_memory",
+        "MetricExpr": "(STALL_BACKEND_TLB + STALL_BACKEND_CACHE) / CPU_CYCLES",
+        "BriefDescription": "Fraction of slots the CPU was stalled due to backend memory subsystem issues (cache/tlb miss)",
+        "MetricGroup": "TopdownL2",
+        "ScaleUnit": "100%"
+    },
+    {
+        "MetricName": "branch_mispredict",
+        "MetricExpr": "(BR_MIS_PRED_RETIRED / GPC_FLUSH) * slots_lost_misspeculation_fraction",
+        "BriefDescription": "Fraction of slots lost due to branch misprediciton",
+        "MetricGroup": "TopdownL2",
+        "ScaleUnit": "1percent of slots"
+    },
+    {
+        "MetricName": "frontend_bandwidth",
+        "MetricExpr": "frontend_bound - frontend_latency",
+        "BriefDescription": "Fraction of slots the CPU did not dispatch at full bandwidth - able to dispatch partial slots only (1, 2, or 3 uops)",
+        "MetricGroup": "TopdownL2",
+        "ScaleUnit": "1percent of slots"
+    },
+    {
+        "MetricName": "frontend_latency",
+        "MetricExpr": "(STALL_FRONTEND - ((STALL_SLOT_FRONTEND - ((frontend_bound / 100) * CPU_CYCLES * #slots)) / #slots)) / CPU_CYCLES",
+        "BriefDescription": "Fraction of slots the CPU was stalled due to frontend latency issues (cache/tlb miss); nothing to dispatch",
+        "MetricGroup": "TopdownL2",
+        "ScaleUnit": "100percent of slots"
+    },
+    {
+        "MetricName": "other_miss_pred",
+        "MetricExpr": "slots_lost_misspeculation_fraction - branch_mispredict",
+        "BriefDescription": "Fraction of slots lost due to other/non-branch misprediction misspeculation",
+        "MetricGroup": "TopdownL2",
+        "ScaleUnit": "1percent of slots"
+    },
+    {
+        "MetricName": "pipe_utilization",
+        "MetricExpr": "100 * ((IXU_NUM_UOPS_ISSUED + FSU_ISSUED) / (CPU_CYCLES * 6))",
+        "BriefDescription": "Fraction of execute slots utilized",
+        "MetricGroup": "TopdownL2",
+        "ScaleUnit": "1percent of slots"
+    },
+    {
+        "MetricName": "d_cache_l2_miss_rate",
+        "MetricExpr": "STALL_BACKEND_MEM / CPU_CYCLES",
+        "BriefDescription": "Fraction of cycles the CPU was stalled due to data L2 cache miss",
+        "MetricGroup": "TopdownL3",
+        "ScaleUnit": "100percent of cycles"
+    },
+    {
+        "MetricName": "d_cache_miss_rate",
+        "MetricExpr": "STALL_BACKEND_CACHE / CPU_CYCLES",
+        "BriefDescription": "Fraction of cycles the CPU was stalled due to data cache miss",
+        "MetricGroup": "TopdownL3",
+        "ScaleUnit": "100percent of cycles"
+    },
+    {
+        "MetricName": "d_tlb_miss_rate",
+        "MetricExpr": "STALL_BACKEND_TLB / CPU_CYCLES",
+        "BriefDescription": "Fraction of cycles the CPU was stalled due to data TLB miss",
+        "MetricGroup": "TopdownL3",
+        "ScaleUnit": "100percent of cycles"
+    },
+    {
+        "MetricName": "fsu_pipe_utilization",
+        "MetricExpr": "FSU_ISSUED / (CPU_CYCLES * 2)",
+        "BriefDescription": "Fraction of FSU execute slots utilized",
+        "MetricGroup": "TopdownL3",
+        "ScaleUnit": "100percent of slots"
+    },
+    {
+        "MetricName": "i_cache_miss_rate",
+        "MetricExpr": "STALL_FRONTEND_CACHE / CPU_CYCLES",
+        "BriefDescription": "Fraction of cycles the CPU was stalled due to instruction cache miss",
+        "MetricGroup": "TopdownL3",
+        "ScaleUnit": "100percent of slots"
+    },
+    {
+        "MetricName": "i_tlb_miss_rate",
+        "MetricExpr": "STALL_FRONTEND_TLB / CPU_CYCLES",
+        "BriefDescription": "Fraction of cycles the CPU was stalled due to instruction TLB miss",
+        "MetricGroup": "TopdownL3",
+        "ScaleUnit": "100percent of slots"
+    },
+    {
+        "MetricName": "ixu_pipe_utilization",
+        "MetricExpr": "IXU_NUM_UOPS_ISSUED / (CPU_CYCLES * #slots)",
+        "BriefDescription": "Fraction of IXU execute slots utilized",
+        "MetricGroup": "TopdownL3",
+        "ScaleUnit": "100percent of slots"
+    },
+    {
+        "MetricName": "stall_recovery_rate",
+        "MetricExpr": "IDR_STALL_FLUSH / CPU_CYCLES",
+        "BriefDescription": "Fraction of cycles the CPU was stalled due to flush recovery",
+        "MetricGroup": "TopdownL3",
+        "ScaleUnit": "100percent of slots"
+    },
+    {
+        "MetricName": "stall_fsu_sched_rate",
+        "MetricExpr": "IDR_STALL_FSU_SCHED / CPU_CYCLES",
+        "BriefDescription": "Fraction of cycles the CPU was stalled and FSU was full",
+        "MetricGroup": "TopdownL4",
+        "ScaleUnit": "100percent of cycles"
+    },
+    {
+        "MetricName": "stall_ixu_sched_rate",
+        "MetricExpr": "IDR_STALL_IXU_SCHED / CPU_CYCLES",
+        "BriefDescription": "Fraction of cycles the CPU was stalled and IXU was full",
+        "MetricGroup": "TopdownL4",
+        "ScaleUnit": "100percent of cycles"
+    },
+    {
+        "MetricName": "stall_lob_id_rate",
+        "MetricExpr": "IDR_STALL_LOB_ID / CPU_CYCLES",
+        "BriefDescription": "Fraction of cycles the CPU was stalled and LOB was full",
+        "MetricGroup": "TopdownL4",
+        "ScaleUnit": "100percent of cycles"
+    },
+    {
+        "MetricName": "stall_rob_id_rate",
+        "MetricExpr": "IDR_STALL_ROB_ID / CPU_CYCLES",
+        "BriefDescription": "Fraction of cycles the CPU was stalled and ROB was full",
+        "MetricGroup": "TopdownL4",
+        "ScaleUnit": "100percent of cycles"
+    },
+    {
+        "MetricName": "stall_sob_id_rate",
+        "MetricExpr": "IDR_STALL_SOB_ID / CPU_CYCLES",
+        "BriefDescription": "Fraction of cycles the CPU was stalled and SOB was full",
+        "MetricGroup": "TopdownL4",
+        "ScaleUnit": "100percent of cycles"
+    },
+    {
+        "MetricName": "l1d_cache_access_demand",
+        "MetricExpr": "L1D_CACHE_RW / L1D_CACHE",
+        "BriefDescription": "L1D cache access - demand",
+        "MetricGroup": "Cache",
+        "ScaleUnit": "100percent of cache acceses"
+    },
+    {
+        "MetricName": "l1d_cache_access_prefetces",
+        "MetricExpr": "L1D_CACHE_PRFM / L1D_CACHE",
+        "BriefDescription": "L1D cache access - prefetch",
+        "MetricGroup": "Cache",
+        "ScaleUnit": "100percent of cache acceses"
+    },
+    {
+        "MetricName": "l1d_cache_demand_misses",
+        "MetricExpr": "L1D_CACHE_REFILL_RW / L1D_CACHE",
+        "BriefDescription": "L1D cache demand misses",
+        "MetricGroup": "Cache",
+        "ScaleUnit": "100percent of cache acceses"
+    },
+    {
+        "MetricName": "l1d_cache_demand_misses_read",
+        "MetricExpr": "L1D_CACHE_REFILL_RD / L1D_CACHE",
+        "BriefDescription": "L1D cache demand misses - read",
+        "MetricGroup": "Cache",
+        "ScaleUnit": "100percent of cache acceses"
+    },
+    {
+        "MetricName": "l1d_cache_demand_misses_write",
+        "MetricExpr": "L1D_CACHE_REFILL_WR / L1D_CACHE",
+        "BriefDescription": "L1D cache demand misses - write",
+        "MetricGroup": "Cache",
+        "ScaleUnit": "100percent of cache acceses"
+    },
+    {
+        "MetricName": "l1d_cache_prefetch_misses",
+        "MetricExpr": "L1D_CACHE_REFILL_PRFM / L1D_CACHE",
+        "BriefDescription": "L1D cache prefetch misses",
+        "MetricGroup": "Cache",
+        "ScaleUnit": "100percent of cache acceses"
+    },
+    {
+        "MetricName": "ase_scalar_mix",
+        "MetricExpr": "ASE_SCALAR_SPEC / OP_SPEC",
+        "BriefDescription": "Proportion of advanced SIMD data processing operations (excluding DP_SPEC/LD_SPEC) scalar operations",
+        "MetricGroup": "Instructions",
+        "ScaleUnit": "100percent of cache acceses"
+    },
+    {
+        "MetricName": "ase_vector_mix",
+        "MetricExpr": "ASE_VECTOR_SPEC / OP_SPEC",
+        "BriefDescription": "Proportion of advanced SIMD data processing operations (excluding DP_SPEC/LD_SPEC) vector operations",
+        "MetricGroup": "Instructions",
+        "ScaleUnit": "100percent of cache acceses"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/mmu.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/mmu.json
new file mode 100644
index 000000000000..66d83b680651
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/mmu.json
@@ -0,0 +1,170 @@
+[
+    {
+        "PublicDescription": "Level 2 data translation buffer allocation",
+        "EventCode": "0xD800",
+        "EventName": "MMU_D_OTB_ALLOC",
+        "BriefDescription": "Level 2 data translation buffer allocation"
+    },
+    {
+        "PublicDescription": "Data TLB translation cache hit on S1L2 walk cache entry",
+        "EventCode": "0xd801",
+        "EventName": "MMU_D_TRANS_CACHE_HIT_S1L2_WALK",
+        "BriefDescription": "Data TLB translation cache hit on S1L2 walk cache entry"
+    },
+    {
+        "PublicDescription": "Data TLB translation cache hit on S1L1 walk cache entry",
+        "EventCode": "0xd802",
+        "EventName": "MMU_D_TRANS_CACHE_HIT_S1L1_WALK",
+        "BriefDescription": "Data TLB translation cache hit on S1L1 walk cache entry"
+    },
+    {
+        "PublicDescription": "Data TLB translation cache hit on S1L0 walk cache entry",
+        "EventCode": "0xd803",
+        "EventName": "MMU_D_TRANS_CACHE_HIT_S1L0_WALK",
+        "BriefDescription": "Data TLB translation cache hit on S1L0 walk cache entry"
+    },
+    {
+        "PublicDescription": "Data TLB translation cache hit on S2L2 walk cache entry",
+        "EventCode": "0xd804",
+        "EventName": "MMU_D_TRANS_CACHE_HIT_S2L2_WALK",
+        "BriefDescription": "Data TLB translation cache hit on S2L2 walk cache entry"
+    },
+    {
+        "PublicDescrition": "Data TLB translation cache hit on S2L1 walk cache entry",
+        "EventCode": "0xd805",
+        "EventName": "MMU_D_TRANS_CACHE_HIT_S2L1_WALK",
+        "BriefDescription": "Data TLB translation cache hit on S2L1 walk cache entry"
+    },
+    {
+        "PublicDescrition": "Data TLB translation cache hit on S2L0 walk cache entry",
+        "EventCode": "0xd806",
+        "EventName": "MMU_D_TRANS_CACHE_HIT_S2L0_WALK",
+        "BriefDescription": "Data TLB translation cache hit on S2L0 walk cache entry"
+    },
+    {
+        "PublicDescrition": "Data-side S1 page walk cache lookup",
+        "EventCode": "0xd807",
+        "EventName": "MMU_D_S1_WALK_CACHE_LOOKUP",
+        "BriefDescription": "Data-side S1 page walk cache lookup"
+    },
+    {
+        "PublicDescrition": "Data-side S1 page walk cache refill",
+        "EventCode": "0xd808",
+        "EventName": "MMU_D_S1_WALK_CACHE_REFILL",
+        "BriefDescription": "Data-side S1 page walk cache refill"
+    },
+    {
+        "PublicDescrition": "Data-side S2 page walk cache lookup",
+        "EventCode": "0xd809",
+        "EventName": "MMU_D_S2_WALK_CACHE_LOOKUP",
+        "BriefDescription": "Data-side S2 page walk cache lookup"
+    },
+    {
+        "PublicDescrition": "Data-side S2 page walk cache refill",
+        "EventCode": "0xd80a",
+        "EventName": "MMU_D_S2_WALK_CACHE_REFILL",
+        "BriefDescription": "Data-side S2 page walk cache refill"
+    },
+    {
+        "PublicDescription": "Data-side S1 table walk fault",
+        "EventCode": "0xD80B",
+        "EventName": "MMU_D_S1_WALK_FAULT",
+        "BriefDescription": "Data-side S1 table walk fault"
+    },
+    {
+        "PublicDescription": "Data-side S2 table walk fault",
+        "EventCode": "0xD80C",
+        "EventName": "MMU_D_S2_WALK_FAULT",
+        "BriefDescription": "Data-side S2 table walk fault"
+    },
+    {
+        "PublicDescription": "Data-side table walk steps or descriptor fetches",
+        "EventCode": "0xD80D",
+        "EventName": "MMU_D_WALK_STEPS",
+        "BriefDescription": "Data-side table walk steps or descriptor fetches"
+    },
+    {
+        "PublicDescription": "Level 2 instruction translation buffer allocation",
+        "EventCode": "0xD900",
+        "EventName": "MMU_I_OTB_ALLOC",
+        "BriefDescription": "Level 2 instruction translation buffer allocation"
+    },
+    {
+        "PublicDescrition": "Instruction TLB translation cache hit on S1L2 walk cache entry",
+        "EventCode": "0xd901",
+        "EventName": "MMU_I_TRANS_CACHE_HIT_S1L2_WALK",
+        "BriefDescription": "Instruction TLB translation cache hit on S1L2 walk cache entry"
+    },
+    {
+        "PublicDescrition": "Instruction TLB translation cache hit on S1L1 walk cache entry",
+        "EventCode": "0xd902",
+        "EventName": "MMU_I_TRANS_CACHE_HIT_S1L1_WALK",
+        "BriefDescription": "Instruction TLB translation cache hit on S1L1 walk cache entry"
+    },
+    {
+        "PublicDescrition": "Instruction TLB translation cache hit on S1L0 walk cache entry",
+        "EventCode": "0xd903",
+        "EventName": "MMU_I_TRANS_CACHE_HIT_S1L0_WALK",
+        "BriefDescription": "Instruction TLB translation cache hit on S1L0 walk cache entry"
+    },
+    {
+        "PublicDescrition": "Instruction TLB translation cache hit on S2L2 walk cache entry",
+        "EventCode": "0xd904",
+        "EventName": "MMU_I_TRANS_CACHE_HIT_S2L2_WALK",
+        "BriefDescription": "Instruction TLB translation cache hit on S2L2 walk cache entry"
+    },
+    {
+        "PublicDescrition": "Instruction TLB translation cache hit on S2L1 walk cache entry",
+        "EventCode": "0xd905",
+        "EventName": "MMU_I_TRANS_CACHE_HIT_S2L1_WALK",
+        "BriefDescription": "Instruction TLB translation cache hit on S2L1 walk cache entry"
+    },
+    {
+        "PublicDescrition": "Instruction TLB translation cache hit on S2L0 walk cache entry",
+        "EventCode": "0xd906",
+        "EventName": "MMU_I_TRANS_CACHE_HIT_S2L0_WALK",
+        "BriefDescription": "Instruction TLB translation cache hit on S2L0 walk cache entry"
+    },
+    {
+        "PublicDescrition": "Instruction-side S1 page walk cache lookup",
+        "EventCode": "0xd907",
+        "EventName": "MMU_I_S1_WALK_CACHE_LOOKUP",
+        "BriefDescription": "Instruction-side S1 page walk cache lookup"
+    },
+    {
+        "PublicDescrition": "Instruction-side S1 page walk cache refill",
+        "EventCode": "0xd908",
+        "EventName": "MMU_I_S1_WALK_CACHE_REFILL",
+        "BriefDescription": "Instruction-side S1 page walk cache refill"
+    },
+    {
+        "PublicDescrition": "Instruction-side S2 page walk cache lookup",
+        "EventCode": "0xd909",
+        "EventName": "MMU_I_S2_WALK_CACHE_LOOKUP",
+        "BriefDescription": "Instruction-side S2 page walk cache lookup"
+    },
+    {
+        "PublicDescrition": "Instruction-side S2 page walk cache refill",
+        "EventCode": "0xd90a",
+        "EventName": "MMU_I_S2_WALK_CACHE_REFILL",
+        "BriefDescription": "Instruction-side S2 page walk cache refill"
+    },
+    {
+        "PublicDescription": "Instruction-side S1 table walk fault",
+        "EventCode": "0xD90B",
+        "EventName": "MMU_I_S1_WALK_FAULT",
+        "BriefDescription": "Instruction-side S1 table walk fault"
+    },
+    {
+        "PublicDescription": "Instruction-side S2 table walk fault",
+        "EventCode": "0xD90C",
+        "EventName": "MMU_I_S2_WALK_FAULT",
+        "BriefDescription": "Instruction-side S2 table walk fault"
+    },
+    {
+        "PublicDescription": "Instruction-side table walk steps or descriptor fetches",
+        "EventCode": "0xD90D",
+        "EventName": "MMU_I_WALK_STEPS",
+        "BriefDescription": "Instruction-side table walk steps or descriptor fetches"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/pipeline.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/pipeline.json
new file mode 100644
index 000000000000..2fb2d1f183fc
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/pipeline.json
@@ -0,0 +1,41 @@
+[
+    {
+        "ArchStdEvent": "STALL_FRONTEND",
+        "Errata": "Errata AC03_CPU_29",
+        "BriefDescription": "Impacted by errata, use metrics instead -"
+    },
+    {
+        "ArchStdEvent": "STALL_BACKEND"
+    },
+    {
+        "ArchStdEvent": "STALL",
+        "Errata": "Errata AC03_CPU_29",
+        "BriefDescription": "Impacted by errata, use metrics instead -"
+    },
+    {
+        "ArchStdEvent": "STALL_SLOT_BACKEND"
+    },
+    {
+        "ArchStdEvent": "STALL_SLOT_FRONTEND",
+        "Errata": "Errata AC03_CPU_29",
+        "BriefDescription": "Impacted by errata, use metrics instead -"
+    },
+    {
+        "ArchStdEvent": "STALL_SLOT"
+    },
+    {
+        "ArchStdEvent": "STALL_BACKEND_MEM"
+    },
+    {
+        "PublicDescription": "Frontend stall cycles, TLB",
+        "EventCode": "0x815c",
+        "EventName": "STALL_FRONTEND_TLB",
+        "BriefDescription": "Frontend stall cycles, TLB"
+    },
+    {
+        "PublicDescription": "Backend stall cycles, TLB",
+        "EventCode": "0x8167",
+        "EventName": "STALL_BACKEND_TLB",
+        "BriefDescription": "Backend stall cycles, TLB"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/spe.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/spe.json
new file mode 100644
index 000000000000..20f2165c85fe
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/spe.json
@@ -0,0 +1,14 @@
+[
+    {
+        "ArchStdEvent": "SAMPLE_POP"
+    },
+    {
+        "ArchStdEvent": "SAMPLE_FEED"
+    },
+    {
+        "ArchStdEvent": "SAMPLE_FILTRATE"
+    },
+    {
+        "ArchStdEvent": "SAMPLE_COLLISION"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
index 32674ddd2b63..d286354d8753 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -42,3 +42,4 @@
 0x00000000480fd010,v1,hisilicon/hip08,core
 0x00000000500f0000,v1,ampere/emag,core
 0x00000000c00fac30,v1,ampere/ampereone,core
+0x00000000c00fac40,v1,ampere/ampereonex,core
-- 
2.41.0

