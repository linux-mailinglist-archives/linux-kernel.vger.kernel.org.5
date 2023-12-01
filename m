Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86DFD80017A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 03:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376729AbjLACQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 21:16:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjLACQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 21:16:21 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2092.outbound.protection.outlook.com [40.107.94.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4BB131;
        Thu, 30 Nov 2023 18:16:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTyn5TvkVVyAgLnvV/ktPJMLlJ7vuNik2Iia9b529xOUMRKJTRZqzSZBOmY1tHPHXPMkPOaegU5n4ozDvCGFs3O59q7GzMLr8ICe3OTOfPX+jJWOmC0dciw8qT7H8hMeBB18hDK2WMc/OeEDPT96Mo1r6ZWBy7Vxvg1AxduH7ZvoacaWCxIAKNznHLXK8stlTzM0RL613j4WJLwhzU91nf9tZ6JmQGshNqKgMCWKUmingmciP6AX4JkHQHdouJXG5gng+NZTovKKNgywQ4/EufGFaxbQnRRZP7SJt45A+UNMz+fWQwKs2KnU9PDRamSbULoDIrHffwoYQhTqEE6HvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIL/FN43oocE4n6Xw3nZtui6M8Uk0Sc2EwkmHIPi2HA=;
 b=icX4n8rZfs9JsHWw5/VUo1NZpopZcW+FQGMW82TrWcf5QNkLksTqDcVgwPhL/Zlba5kM1j2s5coy0UU0+HuCuDjx8B9RSKuFxvkO9lmpJ9MVpQsxvPlyNGI/CpN/Ifnfu+9ZZPtggVAiGO/2WQsBKcD7bndi2iKNLu/kzjINfp8gbwQaBA5ETE33+HAOfzDv4aZVUL+lFzwTAVsqGpncPYA9HB7+upg4eu3nhC6dcuvqLOtFnbcENjgLuMYFf124G2bwql+up1eDr5so1iMPtK8qaxYAqaoKKvFRqHlFxJamZxARQuCLelKqTywVxiPd21wwoD6jqPdMhoeewoZ8XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIL/FN43oocE4n6Xw3nZtui6M8Uk0Sc2EwkmHIPi2HA=;
 b=Za4+8o9LudQUbr1xbcwcT5m28WCBTwB0tJK1oMlQlqoHKv2h04NkjUI68F7AMXzE4aJj0zYGm3cXMkL6W69vyc7TfTmuhmsunhitBdWayFR/IrxCJUX5ecLwSei15PuQ8YjmQjqEILEd1YFVQBKg9cH1xCCrOjYMIJUzZJqCSWw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 MW4PR01MB6196.prod.exchangelabs.com (2603:10b6:303:71::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.24; Fri, 1 Dec 2023 02:16:24 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::49fa:8dc0:6fd1:72e6]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::49fa:8dc0:6fd1:72e6%4]) with mapi id 15.20.7046.024; Fri, 1 Dec 2023
 02:16:24 +0000
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
Subject: [PATCH 1/3] perf vendor events arm64: AmpereOne: Add missing DefaultMetricgroupName fields
Date:   Thu, 30 Nov 2023 18:15:48 -0800
Message-ID: <20231201021550.1109196-2-ilkka@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9e91845d-8331-404e-89db-08dbf213849c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FClBCqeTigeMOe5m8aaDQTGmeS0QZumY2i22TUHWzzU5nDlTO6Du118X1k9eRkvx/ga6Ll57DJRIIxFbDIYiEBu/9pWXH6Btpz+S8AL1/1JIGgC5ai+o5QX7JqEiu61YlNBifXLJhMbfqjudM21z9U2QueDlhfRJHZgLBduyo4fEf28hcc3GvXYZWtup5diN9VPfkTLx0OTcGK7GorI6VgpVnxraD9A/e8REHgPQsI4qxGOqBdICZ43bdi9qikA+64topwaLmUGnYzBK7bamOdtf3Wofvmc7RKSpvwFcqKMfFqoJtylhz/0WqiHyh795cULFt6FHq6opJrKE6AKyDldVSd8coe7aWd8r49NsijiTY4gEOpgB+BDlWSgBb4BvRPNoNsiBbmx/o2HFcFgfva4VEsUAjPr4/NZSaSqZKd/vI+763f8Fxq2PMWzURsdqBKQxl0RBVWY6OXgjZmQJViSrvH9uOp90ZVrwM/azCy/EPKMeTO/Se3rk2okbzc08PPE587YxdJIR2s7xCZHZVp/bShUUkRymFk/T5Alz9Xd1ucRdjPSJQRakP40ydvYRqu0Tg+tZuF3gZ/pPU5VTfKpKAb4GQJ+XZOkT86+CzGLhaLBIXG7Hb+onoHlncumKNMnfB/k/Wu25r/fDzYYwtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39850400004)(376002)(396003)(366004)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(1076003)(921008)(26005)(38350700005)(38100700002)(41300700001)(7049001)(52116002)(6512007)(2616005)(6666004)(6486002)(5660300002)(2906002)(7416002)(316002)(6506007)(66556008)(110136005)(66476007)(66946007)(478600001)(86362001)(8936002)(8676002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qll1no8fdODESlL3dttyxFi67d4wkq/fKodC4lk3bC76b1SkYnjvmTHY9SSS?=
 =?us-ascii?Q?mcIWqJlPzqg5DpSG4/Rqqf1wqSVt6p7k7YHdM6zFA2ZBlFsNu35bQCtVAlUM?=
 =?us-ascii?Q?DjRy7ntPwH9unUw4on5RqB9bz7/pSTW2pN0WHKS4LOAq7mSaACc8j6/O4ahs?=
 =?us-ascii?Q?IL16FJaDpd3pQ24bjLknsuZEBFYG9RGvUeexu7gQ7ujvBPKBijuctewyVCmJ?=
 =?us-ascii?Q?O5kAoC7YN926RZjyGdYhcKAIVqpgOxfcgNqIGd7V1E9kTNimfUZnqpOjL4SR?=
 =?us-ascii?Q?jkjrJlNNvjndCICcfizzxkyEKN1zY1DT0Pb6+SuyZf2d5Z7w1V1BU/Ie+Wzp?=
 =?us-ascii?Q?V/XOTViawBYlZ8M678tzwvsgp8DcOM89q/o3nM3MrnWekYMuSPUGwH1zcJLj?=
 =?us-ascii?Q?QLfud7LjDHufKWCF8aRzEs+QqxzGsyzFtu9Kb9TUSTqYU00Grcl+NP6ai8vS?=
 =?us-ascii?Q?885gbNQ99oe1x8S5vR+lCaCtJLP0BatQXilT4r9Lo8PeOvcwTsKpY9V6mnvd?=
 =?us-ascii?Q?Iir34+SYEZk6HZ3hO/rPPzjggPzgkVM8Q1i1c/d1+NydtFGuPg9j0M3eIRpY?=
 =?us-ascii?Q?IrN3I6IKR491/wlLhKqapeDX/kJn7X1J5dDLPjdpcZwxZ37y28IlhGaLqPpl?=
 =?us-ascii?Q?dmP66DpMYkf9lfT6WfsMoYNu4isSRxo9Sxo6qHghNIbn72uS3BJWrk5UkeLy?=
 =?us-ascii?Q?fegKZ5cQ+3VdypHlRAIVJFczz7RFJ+q4ehGQVF4Bdd2/VVkjrXJYn0ebC2Cm?=
 =?us-ascii?Q?5Kzoo1XEIXvDdmZKLQXyL7hsLO8PP+Dq6ZVIL8Foz++Zt+m4+1oAG1Ip6xty?=
 =?us-ascii?Q?nKFk5ul8E59elSMdc7IT0t39mDuEKhwDK8OC8OeVqDE+DdSbUf8EAWzh2l5J?=
 =?us-ascii?Q?bTyfTFiC4BvHwgPN57g58FmIAdk98HzQ4Sibb3X4/+Q0/naPw4e8niAT11Ha?=
 =?us-ascii?Q?nbtUp9+Kk5mHNoLO7ybKaLrNiKORb8jfk3yz4JCuv6LUwjLElsrIGwKegjug?=
 =?us-ascii?Q?75pJpHNOnm/ae7u6iOfQQgDVfQHlGCcJ9zlrFAqeGBrVvrNfzLTwn8fIxEc1?=
 =?us-ascii?Q?AznUdg0suNtPMoLfVCTGWHmbkU1hQT1TuhXhX2BQEAX8d6gGQSMvCmvgSRcI?=
 =?us-ascii?Q?rNLjFZa8etI47248j6S60ER/zJp/pLyotfsVfikgVGPii2a4HliciAXYW6Va?=
 =?us-ascii?Q?ktMYSHjBQVFCCtiwzCHinW2FpBPT80u0pBwpyWFIn5W+kuTC8gwD3Zo9dmrb?=
 =?us-ascii?Q?BDFl53xhWOKUZYIftpcSfLrus6CN72poJ894HoxjuP5FdJGbcLeoPuAWUTGU?=
 =?us-ascii?Q?OnhTKvTpqeaZWVbY3ro6OzPF3URxQs9rSaTVpCXvBKlRoovwyLh0PearT8nc?=
 =?us-ascii?Q?cdoAsi7gXNch66xIgfi34PdzkZHkNfiKOViK89q69ZTPvkCGttpAsDxol0Cr?=
 =?us-ascii?Q?QLTorl0BvQjbUpJkgHcxiEr2u69jklGsxZ9GBmVWjmBIhrGzWfkbe2drNbn3?=
 =?us-ascii?Q?fPc9bP/8rC70ZK07HgCFqMFv+gR6zZSZWvlC3O1ZRW9GqbSjiBN8/HH8UZpT?=
 =?us-ascii?Q?5B7Ij3UdDP7PFxp4vylqJY+9eHgQj79M3F3I/f+wmvlBGi72vGdv9S8WMCgF?=
 =?us-ascii?Q?JuNzyxYEGiRUUvzs86n4zNo=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e91845d-8331-404e-89db-08dbf213849c
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 02:16:24.7427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wmsdV52D7z5M+ZXal6/4Zd3FuZ86pMSvQATP5S58bUPxC64MjZAuaoGUMh8iK5Il5gGN9tN1P3JVoRSspcO4Zxf21i3XO5Suj0k9ygSxotobM8cXiLY+x347eqeeTFVO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6196
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AmpereOne metrics were missing DefaultMetricgroupName from metrics with
"Default" in group name resulting perf to segfault. Add the missing
field to address the issue.

Fixes: 59faeaf80d02 ("perf vendor events arm64: Fix for AmpereOne metrics")
Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json
index e2848a9d4848..afcdad58ef89 100644
--- a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json
+++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json
@@ -231,6 +231,7 @@
         "MetricName": "slots_lost_misspeculation_fraction",
         "MetricExpr": "100 * ((OP_SPEC - OP_RETIRED) / (CPU_CYCLES * #slots))",
         "BriefDescription": "Fraction of slots lost due to misspeculation",
+        "DefaultMetricgroupName": "TopdownL1",
         "MetricGroup": "Default;TopdownL1",
         "ScaleUnit": "1percent of slots"
     },
@@ -238,6 +239,7 @@
         "MetricName": "retired_fraction",
         "MetricExpr": "100 * (OP_RETIRED / (CPU_CYCLES * #slots))",
         "BriefDescription": "Fraction of slots retiring, useful work",
+        "DefaultMetricgroupName": "TopdownL1",
         "MetricGroup": "Default;TopdownL1",
 	"ScaleUnit": "1percent of slots"
     },
-- 
2.41.0

