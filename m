Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B9E80017D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 03:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbjLACQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 21:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbjLACQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 21:16:33 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2112.outbound.protection.outlook.com [40.107.94.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3C7D7D;
        Thu, 30 Nov 2023 18:16:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RCgPCeOcpsJYIMNX+ezl0qb0soB7e2ndJ2XAd8DfTbnXBtkbbmunEMR8Nm+lVy3XDTsmWdUxgzP0Jvqv9QdBJK1Qt/vifsVobRA58T13NwKpUxFQnb2Mz0+fBQkmHGVakIjKihw0sjObm4OokfFMZhvGkOmnR3GGJaBQeFRfhOfBCB+aHmnz5TGqFqSlwv4ALGgmq49BaIMhZsAdf6M6pz/7IoROQfTZLfvvO9ZLEUHbpNiuabEyMlq/LW7NzoPxauVdkzE0psOC5XqiggbgSztebNqPYKFCYYQY/X+rAzRP8QumfXn5ORtJyGbaXfSfJpFN5Jvt+K7Fm3TtOm9dHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eOvfmRsFILgq934CZ+Lb9UvsHva/nuthOgEUdZm4kOQ=;
 b=P85gT4hW/ja4CtSC2vH7h5LoZRBreBREoF3BYXTuJCGqp+YM2sJIlFwsRgXfcKVxrXE8+ZBhdE2OhFbCfOOAd0Ss6DA5Y9Frr82QqSRMjPyKygxCGANM4wFrjE7CH5Xf49tYZllU/q0VhsZDj6jS4/VGuX36Z++dlAswYsflM7IML3A2GWJZPfOAGd8fDUHQBf2NTHd6WtIcUc8MAhmfg5T23lcozU+904del+wJ9VuJWvWNH6ckY/+2S6RKk3ZS1Fz2rC6OR+xz2Ei9tYCiD3+/IUheOvWki4Uoe0IAQGHGn5PlqbS/xTG0btdDeJt4vPtrUXE22FT2QosIBrlhdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOvfmRsFILgq934CZ+Lb9UvsHva/nuthOgEUdZm4kOQ=;
 b=Y2yumIzCG11pKF7NYyNWhDnCx1p6kow+wetzxiWwhCUjOGTNmgdXzKs2otY9aX15v7T7e/r6XZQKnOrfaEEe80ZSGiefNHIF84YuoS2AU1vehDku6/9vUQqc4XYUVR36ff0n9+eKKwH4pDoe4pvwJpr/PtvZsNtFYXkApH5E4m0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 MW4PR01MB6196.prod.exchangelabs.com (2603:10b6:303:71::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.24; Fri, 1 Dec 2023 02:16:31 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::49fa:8dc0:6fd1:72e6]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::49fa:8dc0:6fd1:72e6%4]) with mapi id 15.20.7046.024; Fri, 1 Dec 2023
 02:16:31 +0000
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
Subject: [PATCH 2/3] perf vendor events arm64: AmpereOne: Rename BPU_FLUSH_MEM_FAULT to GPC_FLUSH_MEM_FAULT
Date:   Thu, 30 Nov 2023 18:15:49 -0800
Message-ID: <20231201021550.1109196-3-ilkka@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1b17375a-07d6-43ef-d58b-08dbf2138853
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GuZCGlA5HVgJw9VJSHmnt7fgYx4gNtHIcB3RQb8uJPOHQdAT1duGX/38UaHNQrMq5ifI5KfIG40OTdLlR68P5WKELwkzMCk5XYFBCwdIHd0MiJcsNKIQS9OXIIMejl4H1yel9cxmyqLuaBmYiejrmeiYUIyho2M0gpBQigzgF0KamuYiYb6ONTUK71o9ZTHswsdu/Re/2qMU0rh1FNCeEfJjd3+1PwP+Yz4+8RvXJGQTUyLMv8KcZOIEh2xYqMdyB3lR5cXBenD3dtKv1t7zC3iQtwWpD8sKPSgasu7w64/Ou81aPy6mITL5pq1VqfPlTjWDWKJTSRfm8QtnFvsVNqng9ov38a8mxl1OYwSQ8MQGG4RiRQ3MPXB/VjtKTT2Z1fW7bcBvYZ6gbD2vlwpmi//tA+D41lmk5DzmccSkU7azFsz4wXUI3lBt7gSAeHD7nIZMZziltTjac7s2fJoAr6yPZJehmIqeE/bpZwrfWewwYb/VyFYEhBpAdsbmFPVtxr/vNJKCk5bZs824wvMZt1/qWe5KQ4kOGbK+Jj+TkolhTq4cgPRDnfAtxuIABpoPv0eVdl7fQjzdVafXr9hpyXVWR+dBsFmwQAe3q13GiCKJ1fNR9r2Rc1pgeW+E1iDdimfPnPPgaVnnZz5W8xLTZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39850400004)(376002)(396003)(366004)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(1076003)(921008)(83380400001)(26005)(38350700005)(38100700002)(41300700001)(7049001)(52116002)(6512007)(2616005)(6666004)(4744005)(6486002)(5660300002)(2906002)(7416002)(316002)(6506007)(66556008)(110136005)(66476007)(66946007)(478600001)(86362001)(8936002)(8676002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?An4VYaeIWpLGXzc/rXlWsFJn//nxviSFLYysAnpEuS5jgymUXgzmVMb5Y74j?=
 =?us-ascii?Q?F91+gZPmuOxp+x1b5j18YDmrEOLCw08Fr2QctWxwCOnDgtxw83aCtnVKNhm2?=
 =?us-ascii?Q?8H/9+aj5yVQzv2/N+DqqCkL+6tOW/RciEVZoanwV9oDRMpEC6wlQQLqnuUMO?=
 =?us-ascii?Q?5xF2SEam+ZJBJqod0UnLCNLUfzhd/pkfkcvU4ngxxj2G/Qj7TYNDyvu6F9SH?=
 =?us-ascii?Q?/pLobSJkMOVbz9bUB8YTDxJMCIvDEL9Fubh2i8BeGLgLIkA5e9rENEa2FD0Y?=
 =?us-ascii?Q?quhsqPPWGNe4MGYGsfvU73e2OD7kwS5NyTGVlP0d61els4JZD2iZnbpSSOfE?=
 =?us-ascii?Q?Pl4wJ8BtdWY00OgOVbt8NkuyQqrkbfXgiUAdtDVTiIJuZB98Mm2RRAF4z7lq?=
 =?us-ascii?Q?9Tdu0c8FiiOx4rXNZs7YVDlWPfqWss20+/wPwBAuH81JJcCb2EebjfeahY2N?=
 =?us-ascii?Q?nRhDPJgh0SgQveOkmzMp7oOr0PXqUH4I35Iyj2sG14ZvPuZ0lLJ3/o2UVuMW?=
 =?us-ascii?Q?7opn+zOSPLHYHs9v+oMbC1lYbqOI4YwN5pGNLsIcr16fU4Ch+Hk3Z+Zw1E7f?=
 =?us-ascii?Q?wIjXd/jF9+LhGWXD13e94T9Sf6csAYRxY06LA2R7m5Zw8hv4H2GystfY757t?=
 =?us-ascii?Q?GPBzQiTK58Eb38xNVh4LUk2fL4LUpBmcoZyyziWZnnF+M5XjvXN62miHCTfo?=
 =?us-ascii?Q?VXqZjVYHrbl7zK6K7JamkWtbjYx5aHHyR9OJPvFrqF34sMXafPa/inKlDmqh?=
 =?us-ascii?Q?9b1np54QOP3935YOT6/BbMB7Km1upIaqHG7V9draBwtw4EbKrEESjqp4OnaO?=
 =?us-ascii?Q?v4DhjPVY1ZvxOn+8HN1c/8UIHybvRHZuW5CUEJFqwhEzdrxXZ1ZT5zx+rYE3?=
 =?us-ascii?Q?TBn4/qaI4QPWnEk3/3K5HvBzp1FR20QGG6ag/54RMcS+PAQTNV43Fs18VaVF?=
 =?us-ascii?Q?NlpjpAl1rE6gEl/tFUdD7Ir3gbOvs3zIxtq0e5EHLJufFA3soUvsMnCqKWQ1?=
 =?us-ascii?Q?muaW9AKPeQhsjZdHwHeuqC32/InJXgE0EOrWmG+uoEXSmKeKDeiEYj/oz+Tc?=
 =?us-ascii?Q?q0TqpRNOBWcybsl3MxMAfcsLNE8donYownw0xAQoq1QvPhQMnr9AXnOkr3WC?=
 =?us-ascii?Q?gVTkzMYe/ZexQu0Axi5eYk8JSGc2i6H/skJnWwNMy40aTphXFRBDZEyQsH4m?=
 =?us-ascii?Q?Y/mEMws7p4u/kDTi6c7mUOJlkDAbvjr90Yl8MBem19MARC3jze7uP6aWi2w+?=
 =?us-ascii?Q?JprN7UChIT6O2n1unYTE1OR8851y+KqSMsfN8ufgKqP9b6rpqgNkPfu8xfZl?=
 =?us-ascii?Q?3n6xpSaFkPo02urqM+o3voI7aRZ/u3YoR+WCgwS6VlgihO2EJwxumpsVZU6d?=
 =?us-ascii?Q?iKCx0SowOd1/nZSYgGu9IfhLZkv41oaOhpCkNxVR+4ms2jJl5PAqF/kB/02M?=
 =?us-ascii?Q?Q8WqYky7u7ZGsWQ/ZMYRI4SJYjM8Q7klPXqxpQalS8SyjW4nMiUm4C4cKoqe?=
 =?us-ascii?Q?Nj4SA9YNLH7H5Sy6nxZbhcZI2QeSxEfCdgTUmblbIRk5NSrLWyHXYEn17KgY?=
 =?us-ascii?Q?T4LhvKjtlysVmG5zZ2B2YeHuxmClcEVD+QWT0/NHSaoVQkOIBMxrmtqVdZR+?=
 =?us-ascii?Q?VVQjf+YmQ62Hd7fpPwndBqc=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b17375a-07d6-43ef-d58b-08dbf2138853
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 02:16:31.0473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mf5TYkwzdpgPVmw9XSuuqrYgIXE14275hrxE/WIOpp4gAHRdZaUuCEa+MvFLi1ike8lFtJa5tDwsi/8Gmuq15f1aLT7nXmm4SllUoauDGrqmJG7LqKZUzwMuYTTSTrmC
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

The documentation wrongly called the event as BPU_FLUSH_MEM_FAULT and now
has been fixed. Correct the name in the perf tool as well.

Fixes: a9650b7f6fc0 ("perf vendor events arm64: Add AmpereOne core PMU events")
Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 .../pmu-events/arch/arm64/ampere/ampereone/core-imp-def.json    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/core-imp-def.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/core-imp-def.json
index 88b23b85e33c..879ff21e0b17 100644
--- a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/core-imp-def.json
+++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/core-imp-def.json
@@ -110,7 +110,7 @@
     {
         "PublicDescription": "Flushes due to memory hazards",
         "EventCode": "0x121",
-        "EventName": "BPU_FLUSH_MEM_FAULT",
+        "EventName": "GPC_FLUSH_MEM_FAULT",
         "BriefDescription": "Flushes due to memory hazards"
     },
     {
-- 
2.41.0

