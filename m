Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002D076F488
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 23:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbjHCVPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 17:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbjHCVOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 17:14:43 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE57B30F1;
        Thu,  3 Aug 2023 14:14:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q9KKzvVCEGoXFvWnbr7G/d2zNu7uAnWnO2+djT/kWvctR+mOQqAoce08GOowp8lR6LlK4T3E8eoSFKUoLpyey+D/bwXWTfvm+oHEzYVSLeB8t6JYscJBTjfUZ53evZUV2UGaMzQOHAjVnazzJJq3F/JCBeaKOZyxzyPcnhO33aVqukJQbTGjJxLO3dtGvOi5UxGH2d+cCJ/CWXzHl+d5gYdz9R/T+eWcQ+fxVk8JG9SjJmwiQ68lMiUDd8s+u7OtuteOWK7pVlxqBF3idSa1WiOWVveQXW374RQO6CjeJhx62MCEx/kqK723JaK14n7x14LdSG+XXt9MajI1GRwfjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NmURnsdEISgfZCIhNt+ekSWF8TMap142MoW3bRsj7TI=;
 b=jvPYv6AgEWSlzktf6TQDSHC6ifFEGpPqCzEAeSxR/yDZX0kxVAJaJL9VdjpP8sfj+NDsRncm7GKGNj6+FGUjPeQqdfZfJ7MhVqHkBoFOWm5IRYvRrzdCx5WSB5JJ+s8eFnLcZD/aXq/JAdPhNKgoRqEqj4PwhYwXNAqZ5sXTS2zJjV/fIV9EHCW/QouzpX5hk5mUdZYbTD5cOiCOaK9vihPQ1BLwLIg4YuX5w4t4CANf6FzQisRDwyR3IXbwOeAmfg2dhaoT7GasUzWo9t2hT41n7EX1Gu+qNosTUfTaM3gPSPg05oDi/XdUKS6IKbwJsNYAqNJxacl6vGWSCj5I3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmURnsdEISgfZCIhNt+ekSWF8TMap142MoW3bRsj7TI=;
 b=ncfNagmn8AglpnUviBBuU1/t4NEmaKW7qt8SHJ55y/2ita09prqst5uEkPm9gr4K6CGxacN6BHkHYGBzOeM33eqTgaKtEi3R4IF7bQL/NPS3gLs322s17Z6zA2TLUr3/r7lWzVEmPodJl1AO4L3L1K5MXkhBvCRtRz81FOPVqqw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 SA3PR01MB8502.prod.exchangelabs.com (2603:10b6:806:39f::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.47; Thu, 3 Aug 2023 21:14:37 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::4e0f:49b:ee39:f08e]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::4e0f:49b:ee39:f08e%6]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 21:14:37 +0000
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
Subject: [PATCH 4/4] perf vendor events arm64: AmpereOne: Remove unsupported events
Date:   Thu,  3 Aug 2023 14:13:31 -0700
Message-Id: <20230803211331.140553-5-ilkka@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: 95582e19-4872-4b03-bf1b-08db9466a491
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 57FYMErhU7ZTt43hORoR+0nrk/wW/Ekv12Pkq/CUs9YqtUcJkPtk8M/u2SDJga1stMD/x7dhnwJmkHRTRKaYBmMmsCRBUDE6ky8OacrTEOftEUI2AqefGUL21mjO+7qWoohG0UDRpkL2AVPJa9I7IWCIeRssGIfqjTBQbI4vD9dKaD/q1eUj3N9le6zbIj9dinULJSx4zsPz1nvDpy5WPv+DHJ5weTKu4CVGDLmmHm9t6Dh4j6k4lR12s+LynOHR96ZCcSaQn9olxJqtXwsbV9m+lTvtY+poCQ8FAuDIzrfYnCkP8k5wK7/sT8SUoAWraH03dSjZc47EKRgQetOEaVivuv8Q2y+gzl9LlSvIih4Lgohib6rZo0bBiPAB5Qg2bBJNkqkWC7HRr6PmQMKjXIPMjZu3hDrpAXrHe3A8SS2ANX5Hk0sF3R/+gSsOJe5M6ysCNjTpM6K0N0LHd0U18Po3JeCM+TwBGbx3fy/F54aQVe/2q1Gt/+OTyK2BA1rky0BSCDAnY72Gck3keIQ7UuBF0BBW6Q0U+u2CNcGKWtfixc7UhpuD595WBkppoIGPnXXVt0RiYu7oDRIU3ImAAKnPPrmZR9CYUosOnvjmoE/f8gnp3CWnKe3LTANXmI55
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(396003)(366004)(376002)(136003)(346002)(186005)(451199021)(86362001)(52116002)(54906003)(478600001)(110136005)(38100700002)(38350700002)(8676002)(1076003)(2616005)(6506007)(83380400001)(26005)(41300700001)(7416002)(8936002)(6486002)(6512007)(6666004)(2906002)(316002)(66556008)(66476007)(5660300002)(4326008)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yRMGg3zN9MU/zdSaBPMwnulXHglV3DVS3yNqlJnSnPrs877XIXvW1aTLySMh?=
 =?us-ascii?Q?PoHCj6I13EKFfq2VAjFke2jPRbDDiXHAQxIWNcLlptL6fCxc0keRUnhbiaQe?=
 =?us-ascii?Q?Nz9yytAVHO70abB3+VP2aC2b6/CS2L4ftxWWLWhpBxcX2To/Q75krrg3tjv9?=
 =?us-ascii?Q?VWlOHA0HyYlJEq6pSyZe1gfsGw4vBPPNhO7tv3LkNGH27zbVzeEdK8eMuCvk?=
 =?us-ascii?Q?9+IZaoPgAxreQvlzBkB+8YkMx0KTZDuUcnCs8CeiDQnwLCvSwi6sHjhLrxYb?=
 =?us-ascii?Q?j3r14ojmqLD/VGQzcirZ8kATdkk/hjyP+UiUm3OhxSGXQEZqdyOM7YCTwOhA?=
 =?us-ascii?Q?HIpgW22qgt6o8wEy2PH7HzZFfXo263Szb9sGgHK9Jv+FIMbhM7HfN2dRcvrt?=
 =?us-ascii?Q?VwYxERKp6pK8/Fokg9g3klh2av7JsvFajSauZqFk3mBwQQYVU8OcLGQd7v6U?=
 =?us-ascii?Q?cKaXf6Ry2F6XMsHazejgoHOO3K/ihXaFCAE+QBjzXvVuPoPlYDsvswe6pf4g?=
 =?us-ascii?Q?frupEOQa1e+6nrQRGKyfMUfAgK90SvUMKkKbN1czrFkoL4mTWA/RUzM4PxWF?=
 =?us-ascii?Q?8jKLF6E7xvvfU3Pw+2Z7Ar/kGxgk2o31WHhralg718PT3LBKwZky/6eRXYxV?=
 =?us-ascii?Q?Tn5RWKXM+AfcqYAC7h+DFqVloMPffWW42ZmueP/hYZwSs8pgEIsNan5l/wmh?=
 =?us-ascii?Q?sFflvkPhymEKkqSEDBlv4RDY+LWdP9z7NDcAIShfW3QBUvJ+Pl4lAFJIS7mp?=
 =?us-ascii?Q?mzcNKcXzaSTXCp0r1XuHF6wo8a/71vHfvkevbp81UsnDwo6PXKP+qvQkEfy6?=
 =?us-ascii?Q?P26OG93d6NKw+VeHutDQ9611EZWmbgs60RAG8iipjndHWAAWFumIGG/PCTE8?=
 =?us-ascii?Q?7bMH2XatNj+7cmDCZ0xNKjYKrb6h7hWlbwdgdExdPyCwo5jag1pta+a8Vc4i?=
 =?us-ascii?Q?flf2JjCfg947+dCIQVL7xkSjE5IMPlVksuAxOJVJiq6yquvQmbLod8HbWz0h?=
 =?us-ascii?Q?tIg3HSy73V9hMjFvhTU+EP+mIdC8cDzpmeSg+vx6BeVxlTzmc3K00jSABMAw?=
 =?us-ascii?Q?iXnm0lzUDPnd0JnP+zBygteyaLN9FATnkOmahdBdcfU1k1XRq74R4zLrQBNF?=
 =?us-ascii?Q?8PsdFQzNw7UuMuFfEEBRojGJl5/O14JhD9bLqh+Qcvb5OBHmfj67KyWVvqos?=
 =?us-ascii?Q?lcT7nTnMTsh1DrQ2RrAtVPw+Wym+zWJ077/xxKVNPZgUTuj8KiWtao+Du0G7?=
 =?us-ascii?Q?ppr8eSMlIc2xeHg46rpC/6y0+CvdbZOOdScWjZA+hqFNrrSXf5BfT40EcUJn?=
 =?us-ascii?Q?2Hmw9ddh+ubO6IzbGh/5ySYKlddNUQegSl9IeudeSSXexiomS1OR6sa0YzQP?=
 =?us-ascii?Q?TZOQTj+x5ofLDVHL+3WuGHfbR22/Qr51Pb+vnZ1G/P8ExvEYPErf2iv+xlHA?=
 =?us-ascii?Q?kUkXe+7tXSu/iCH3VlfHSA2VWSey6KdSeKXqBh9zkyhFFcV+js2d0A4vIzBk?=
 =?us-ascii?Q?W39qtmk/gwkUDcAyVcx8N+Z7PUkZbe26X4aTJ4NkxBKzXyWjVMKkqB5HOpST?=
 =?us-ascii?Q?kxn4pHPq05gsmhkS4upZYxKC9m/ssiqVWtQs8yuo+wPgeAfIuFR9Z1Qm/NSS?=
 =?us-ascii?Q?bQ=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95582e19-4872-4b03-bf1b-08db9466a491
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 21:14:37.3048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k8Vp8qQSDrggy+4k0OVNEkgQf7iayETMTy+Bk2AGj6SQvMNpsdriLE28NJVcjuDrOIA6WBo1ruT1JEW071msV+YOjARagL5gq65Rr2OEwZFA4bjyocjLjvddq+KgnY27
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

Some of the events included in the ampereone/core-imp-def are not
supported on AmpereOne, remove them.

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 .../arm64/ampere/ampereone/core-imp-def.json  | 120 ------------------
 1 file changed, 120 deletions(-)

diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/core-imp-def.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/core-imp-def.json
index 95c30243f2b2..88b23b85e33c 100644
--- a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/core-imp-def.json
+++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/core-imp-def.json
@@ -533,66 +533,6 @@
         "EventName": "MMU_D_OTB_ALLOC",
         "BriefDescription": "L2D OTB allocate"
     },
-    {
-        "PublicDescription": "DTLB Translation cache hit on S1L2 walk cache entry",
-        "EventCode": "0xD801",
-        "EventName": "MMU_D_TRANS_CACHE_HIT_S1L2_WALK",
-        "BriefDescription": "DTLB Translation cache hit on S1L2 walk cache entry"
-    },
-    {
-        "PublicDescription": "DTLB Translation cache hit on S1L1 walk cache entry",
-        "EventCode": "0xD802",
-        "EventName": "MMU_D_TRANS_CACHE_HIT_S1L1_WALK",
-        "BriefDescription": "DTLB Translation cache hit on S1L1 walk cache entry"
-    },
-    {
-        "PublicDescription": "DTLB Translation cache hit on S1L0 walk cache entry",
-        "EventCode": "0xD803",
-        "EventName": "MMU_D_TRANS_CACHE_HIT_S1L0_WALK",
-        "BriefDescription": "DTLB Translation cache hit on S1L0 walk cache entry"
-    },
-    {
-        "PublicDescription": "DTLB Translation cache hit on S2L2 walk cache entry",
-        "EventCode": "0xD804",
-        "EventName": "MMU_D_TRANS_CACHE_HIT_S2L2_WALK",
-        "BriefDescription": "DTLB Translation cache hit on S2L2 walk cache entry"
-    },
-    {
-        "PublicDescription": "DTLB Translation cache hit on S2L1 walk cache entry",
-        "EventCode": "0xD805",
-        "EventName": "MMU_D_TRANS_CACHE_HIT_S2L1_WALK",
-        "BriefDescription": "DTLB Translation cache hit on S2L1 walk cache entry"
-    },
-    {
-        "PublicDescription": "DTLB Translation cache hit on S2L0 walk cache entry",
-        "EventCode": "0xD806",
-        "EventName": "MMU_D_TRANS_CACHE_HIT_S2L0_WALK",
-        "BriefDescription": "DTLB Translation cache hit on S2L0 walk cache entry"
-    },
-    {
-        "PublicDescription": "D-side S1 Page walk cache lookup",
-        "EventCode": "0xD807",
-        "EventName": "MMU_D_S1_WALK_CACHE_LOOKUP",
-        "BriefDescription": "D-side S1 Page walk cache lookup"
-    },
-    {
-        "PublicDescription": "D-side S1 Page walk cache refill",
-        "EventCode": "0xD808",
-        "EventName": "MMU_D_S1_WALK_CACHE_REFILL",
-        "BriefDescription": "D-side S1 Page walk cache refill"
-    },
-    {
-        "PublicDescription": "D-side S2 Page walk cache lookup",
-        "EventCode": "0xD809",
-        "EventName": "MMU_D_S2_WALK_CACHE_LOOKUP",
-        "BriefDescription": "D-side S2 Page walk cache lookup"
-    },
-    {
-        "PublicDescription": "D-side S2 Page walk cache refill",
-        "EventCode": "0xD80A",
-        "EventName": "MMU_D_S2_WALK_CACHE_REFILL",
-        "BriefDescription": "D-side S2 Page walk cache refill"
-    },
     {
         "PublicDescription": "D-side Stage1 tablewalk fault",
         "EventCode": "0xD80B",
@@ -617,66 +557,6 @@
         "EventName": "MMU_I_OTB_ALLOC",
         "BriefDescription": "L2I OTB allocate"
     },
-    {
-        "PublicDescription": "ITLB Translation cache hit on S1L2 walk cache entry",
-        "EventCode": "0xD901",
-        "EventName": "MMU_I_TRANS_CACHE_HIT_S1L2_WALK",
-        "BriefDescription": "ITLB Translation cache hit on S1L2 walk cache entry"
-    },
-    {
-        "PublicDescription": "ITLB Translation cache hit on S1L1 walk cache entry",
-        "EventCode": "0xD902",
-        "EventName": "MMU_I_TRANS_CACHE_HIT_S1L1_WALK",
-        "BriefDescription": "ITLB Translation cache hit on S1L1 walk cache entry"
-    },
-    {
-        "PublicDescription": "ITLB Translation cache hit on S1L0 walk cache entry",
-        "EventCode": "0xD903",
-        "EventName": "MMU_I_TRANS_CACHE_HIT_S1L0_WALK",
-        "BriefDescription": "ITLB Translation cache hit on S1L0 walk cache entry"
-    },
-    {
-        "PublicDescription": "ITLB Translation cache hit on S2L2 walk cache entry",
-        "EventCode": "0xD904",
-        "EventName": "MMU_I_TRANS_CACHE_HIT_S2L2_WALK",
-        "BriefDescription": "ITLB Translation cache hit on S2L2 walk cache entry"
-    },
-    {
-        "PublicDescription": "ITLB Translation cache hit on S2L1 walk cache entry",
-        "EventCode": "0xD905",
-        "EventName": "MMU_I_TRANS_CACHE_HIT_S2L1_WALK",
-        "BriefDescription": "ITLB Translation cache hit on S2L1 walk cache entry"
-    },
-    {
-        "PublicDescription": "ITLB Translation cache hit on S2L0 walk cache entry",
-        "EventCode": "0xD906",
-        "EventName": "MMU_I_TRANS_CACHE_HIT_S2L0_WALK",
-        "BriefDescription": "ITLB Translation cache hit on S2L0 walk cache entry"
-    },
-    {
-        "PublicDescription": "I-side S1 Page walk cache lookup",
-        "EventCode": "0xD907",
-        "EventName": "MMU_I_S1_WALK_CACHE_LOOKUP",
-        "BriefDescription": "I-side S1 Page walk cache lookup"
-    },
-    {
-        "PublicDescription": "I-side S1 Page walk cache refill",
-        "EventCode": "0xD908",
-        "EventName": "MMU_I_S1_WALK_CACHE_REFILL",
-        "BriefDescription": "I-side S1 Page walk cache refill"
-    },
-    {
-        "PublicDescription": "I-side S2 Page walk cache lookup",
-        "EventCode": "0xD909",
-        "EventName": "MMU_I_S2_WALK_CACHE_LOOKUP",
-        "BriefDescription": "I-side S2 Page walk cache lookup"
-    },
-    {
-        "PublicDescription": "I-side S2 Page walk cache refill",
-        "EventCode": "0xD90A",
-        "EventName": "MMU_I_S2_WALK_CACHE_REFILL",
-        "BriefDescription": "I-side S2 Page walk cache refill"
-    },
     {
         "PublicDescription": "I-side Stage1 tablewalk fault",
         "EventCode": "0xD90B",
-- 
2.40.1

