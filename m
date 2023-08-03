Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57AA276F485
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 23:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjHCVOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 17:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjHCVOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 17:14:33 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D4426A0;
        Thu,  3 Aug 2023 14:14:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=famxl+p1BA78/WQbM2ntTed117x/hSygpDxK4L1ubSLrooXqVM+XvjVOFv7Wl5IYdWPVyK8N02NbbG++WIckl9lGQ3SH1cSjwUPONpsYwpVQfGGeYzdzTXid8j+3EqNA2koD5AmmMTnIc8zjrLEAUfKes5VvkYv15fgl6qIFLCMuXfPsxnRQtUsasrLgWaxNrNoZlzNwrZmO2PEaF7aQIwKbMHGwwHb/b45RKVTlxNn38gR7RjmZkIJTYFmwNognI/qyCbNb7WyvKIMpxx54rHXYo+5r10frZvRnRjPv1/2d5MbKUQP8cPMs0ga1uYQGOw2ER9GD7w1s1K0Wd6UB0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZ9nVi/nQybEaUJ3rIvf1+6iPaw0gj7xaLmG0L2IcJk=;
 b=LoFjl2UrozCCzCvZICi2tm9t3zzw38LiYx8VUPo7PM680x867lQ0TUK2tabWQFCNu1kYpd0OmyCs+soNm316lCa4zipNdN7FhTPfsGPJhP2IR8RLI/WfCQXgPvUfeIre6APwT+S+mW7dZx+5RtV2siPH4biCHgacEY5ObLc1A30et0OHtHt6mrelMUSuVHmm8VHg675PmUMwFUZDyd5rYSXq2zSWlLOWZLT6iIaPVgNyfP/DdY4DqS0+0kYzFI0ooJXLC/sMrvsi9kAwDIFMSkM11PX/zDUa13c7p7CXOUOPMbjJlBvrj+y+qNvaXIBTtm9xqB1hzVJAyb7OFqbxvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZ9nVi/nQybEaUJ3rIvf1+6iPaw0gj7xaLmG0L2IcJk=;
 b=j8I8Vb5l6G3/zmQN0rK3w0+IJSwWWof1CMOCJR3K7IzmVYgcXuuAUotrVM4yArj8Yw2y8bDKM0e/GrJg6t3kYHJKYJJRT/KKVkQbXsmV9OCTA+W8Tzf4zBL4m5nDqXt42HOYhdPVoU65eu8jIMHMNhtFsaUA8w67M1gv4gHh3jE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 SA3PR01MB8502.prod.exchangelabs.com (2603:10b6:806:39f::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.47; Thu, 3 Aug 2023 21:14:29 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::4e0f:49b:ee39:f08e]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::4e0f:49b:ee39:f08e%6]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 21:14:29 +0000
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
Subject: [PATCH 2/4] perf vendor events arm64: AmpereOne: Mark affected STALL_* events impacted by errata
Date:   Thu,  3 Aug 2023 14:13:29 -0700
Message-Id: <20230803211331.140553-3-ilkka@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0e00ca48-a099-40f5-cc2c-08db94669fdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 50mH6WjJ567yzn/ea8l+24q5R2wRR0OiRcJJqaGuWDXgJmMmLp6luvZnOlq7Qe2OSmVkj5ppJxXqluBFwM1oFQFemlZdvW6GrzcnZaPnCj4RqqF9C87Cow/hQRRGLRf/fz7y5Gsqd5d4SvCuNCrczNFUahbnJxWfadfg1DjH6ceuAH4kOUFG/MEFyXTRdWtx1hXoXfOY4GaQEhCCuqp0NWCO2n9R1t4ywUCkYGNmanmq3BYCCSFyhjSaTE6883oWp87GiwzslCBzJauORLLZyyKZDkkv2lynF0mOSLbl29sB6c0JSRDn6ERffjQAh/LnOdK18AYT4KOJWSsa2OKZFzIbIamQkOyrkviVSuGL693RBlfgSttjNZjgw3iGcZbUMRL+e9j8KPgW0V5ORIqphodSAPQLMEBz56Do6e81S+00Avfr21WWkUgvnQxgdz0g9T0aVxOR3fYwjoK5NBwnLFP6OeUwfNZnqCM4f0JzBGYPFb/6hfRo+E50twMiVEk0lwYm6PR7phRjOF5+3u5VA/51/4puWzdmV4QTmvDUXgjjNLXgNij0hQFxLcaaXnYwiRM6/cmorRSJxpweizDIxSjXJ1hBB/EBGsKIKH201VQuzev0RsyjMic3GOKPt0GO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(396003)(366004)(376002)(136003)(346002)(186005)(451199021)(86362001)(52116002)(54906003)(478600001)(110136005)(38100700002)(38350700002)(8676002)(1076003)(2616005)(6506007)(83380400001)(26005)(41300700001)(7416002)(8936002)(6486002)(6512007)(2906002)(316002)(66556008)(66476007)(5660300002)(4326008)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OjQdgp6OimcL9dGuDwoZNuW6kcmBR4/9WRuyn2KL9NzcG2ajuiXeGebR7pAT?=
 =?us-ascii?Q?BsaclU/bjWvufZdAY+F4pOLGJKq9x7wDHnVfczYxQNnydcF8gn8vIQa8BqYu?=
 =?us-ascii?Q?VTEqMElAxTs8lDwYCllp/HfwwnNkUUiaK69BunKVerlZ0KUQkj6ojp+/+wH6?=
 =?us-ascii?Q?hQaKvND6NVsdzIrnVzjWYgMhO9w6lT1Tr8od2x2yzdXz7XLbRylQqpyq+qzU?=
 =?us-ascii?Q?b1Q6KV+VJd8/ifEBdDbU8zJxif1B7ZbmLSjePLsvXpZQRVWMwq07ZklEwjCA?=
 =?us-ascii?Q?Zrb/zwQj+ZG4jJZn1NtxojVP37u5BoDG2ToIQGAop0plk5edcKO6UsjNNOQh?=
 =?us-ascii?Q?598g2OTy/F9wHwd/akJHIfH7hj7LEtij1wvwK/8zlMq0MdDKAhq9SX8p/Wzq?=
 =?us-ascii?Q?B77gcqtEFWY769SROkGt1CvW3+yCjTid5AbDgAFicro6tb2PaqywK649d0P0?=
 =?us-ascii?Q?nVxoZ9j+7nOaXrUldLZo2sm5ND8xxSxDpH1d/IvvkAwn+1gZYKfRRJ1TxR0y?=
 =?us-ascii?Q?YrL+OzffDL6mdIpE/JTtDYkH272pmSrFxy4+3vw9oa9rFoPAHDfOLKG1bEFq?=
 =?us-ascii?Q?Q7NmAI9tP5ErluqT4nFZwIAbYJ9ge9YN5ID5yS6sU56PCaa6m7a9N8In9JCv?=
 =?us-ascii?Q?WaEM6hK3bOXakusql9+pcCd+7LHxPbzrjvJfzwQ58YYk4buEMGeCMJR4yD+E?=
 =?us-ascii?Q?gd0Oowdo0hV0m5pwZ3QThVnbL/4xmvDzW6V2EZotlkznAWSDWPpl3gwaNBl4?=
 =?us-ascii?Q?/e37RlwojS0rByUNL8HCVJBp0sfREeUC62Qr2sUeaTmj7OWBacEMSJr5OoSn?=
 =?us-ascii?Q?FijCW+MHMdr3lehx/jT7FQ2lg1IjJQkmFPqQ4ZEa+Hz1RgjEr4FgOgH1jEIU?=
 =?us-ascii?Q?6GnN36JU6o0W7VWpIlaC9C23bjnMFk75OIqndyk8h/Z0s8fDyTzxbKRKVMa6?=
 =?us-ascii?Q?g9SzVNhcQGA0OKbtZlqNG+javTGcs/SX6gi6Z1N9Oc8NU6s7ynFFo3oH6yNs?=
 =?us-ascii?Q?+mHl1Z2FSSQitRqp46nuigPBP153xGh8YerieHynLldlpJlGt3JJtebFL6wz?=
 =?us-ascii?Q?5z/mZ66cBfAsPcynh/iX2YugZYJQn3eMQ1zgFZXIfrZ5Loys5N6ht2JyPb/X?=
 =?us-ascii?Q?ba/8ploNeV4kUZjuuDcPaZ23+MIEogaf9RsxSQBq+5cxMTkwJTpg+ylPiRxW?=
 =?us-ascii?Q?luSeCVLE+9QCvBISa8ykapdEsg4436GQyjPulM3yiDzDiRNPvZ4vZxCBn2Dh?=
 =?us-ascii?Q?jlPwDyT/KvWyotkSCztXClskF5cywdoEz3HLNXgKx+8X6mAX8WrbKTyUJoQw?=
 =?us-ascii?Q?VZwX9VlNVz7rA8jiRiPQ9nCbJ9EHazyio1GwBL8ZyWrenYHu9TJ5tOR+5Far?=
 =?us-ascii?Q?N7+Z5AhBkAU7xVavj5+tvOzQ4GGpeIdi+5vDTdZ/4bwtQvDF4q3X+ENOPz0k?=
 =?us-ascii?Q?A1Mr6oLv3noww5Kzf3j8iwdihXg1R75kWcjIhK/NitRawdOIFUHgAu8bE4eY?=
 =?us-ascii?Q?C1/IBjY9qBIFn4Vg1Uc/4NsFFptL2fHNezvJFIEJO4LCNWEoztd0nr6v5RKM?=
 =?us-ascii?Q?ut36clmyFNACKnvt2wv2hGOltqD5EkqkmjME8swgSQDB5BJpbEXLmPMRvw8k?=
 =?us-ascii?Q?XA=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e00ca48-a099-40f5-cc2c-08db94669fdd
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 21:14:29.6774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 62tDwYs24tIcbsOYgQkwTk5fJo/FMcom4xzc7hwvm7X82t3t5h6+kuX5+G4qdmHvTE2iObi0hNUWWVNwwSRW9pGd6ifMUFGEhJcLK7L9JZokEtkaQuWEbiLXzfns29+s
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

Per errata AC03_CPU_29, STALL_SLOT_FRONTEND, STALL_FRONTEND, and STALL
events are not counting as expected. The follow up metrics patch will
include correct way to calculate the impacted events.

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 .../arch/arm64/ampere/ampereone/pipeline.json        | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/pipeline.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/pipeline.json
index f9fae15f7555..711028377f3e 100644
--- a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/pipeline.json
+++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/pipeline.json
@@ -1,18 +1,24 @@
 [
     {
-        "ArchStdEvent": "STALL_FRONTEND"
+        "ArchStdEvent": "STALL_FRONTEND",
+        "Errata": "Errata AC03_CPU_29",
+        "BriefDescription": "Impacted by errata, use metrics instead -"
     },
     {
         "ArchStdEvent": "STALL_BACKEND"
     },
     {
-        "ArchStdEvent": "STALL"
+        "ArchStdEvent": "STALL",
+        "Errata": "Errata AC03_CPU_29",
+        "BriefDescription": "Impacted by errata, use metrics instead -"
     },
     {
         "ArchStdEvent": "STALL_SLOT_BACKEND"
     },
     {
-        "ArchStdEvent": "STALL_SLOT_FRONTEND"
+        "ArchStdEvent": "STALL_SLOT_FRONTEND",
+        "Errata": "Errata AC03_CPU_29",
+        "BriefDescription": "Impacted by errata, use metrics instead -"
     },
     {
         "ArchStdEvent": "STALL_SLOT"
-- 
2.40.1

