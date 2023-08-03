Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A828776F483
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 23:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjHCVO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 17:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjHCVOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 17:14:25 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2139.outbound.protection.outlook.com [40.107.220.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4C4173F;
        Thu,  3 Aug 2023 14:14:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CSwvwqb7HX6tUixy+wuIjYRkOqU5ZYLjfFY/hqkccl5H/MxcD2TdexnCEHQGW651gKZ3u3yx0EDX2knuGaZvCkfHUWS1qK2tAXI3pkzT3QHVgsK/GXDOvXB5OY3BTKiUCG00mPqvGZtIVPfVxysA0LD3BQJexMZeu8qgbR0+RdbH0iyxnw2E++tv8cn6UlszPVl/MyNW6r5RKic8Aff0kfGxenBX6ISynSDmL9cQ0vSqPJkl7uTf2lcTqP8NVhbL2YP4f0l5fATo30uKQfSUIvd15+vSMFmHo+WJD/G18zwSpQVaP7HK44jZiarkp5WNHKcZwGmDC0kU4ZHbhtIXAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rL64l4QdrXHdn1BYeJSdvI2KRibSdLhjRW81HML++I4=;
 b=H4u/mck+vkdnVt6YPI9a7TnXtOZtvOM/Cuv1gJM8pwLqBvoB5IgO4VuphzkoEfntzDQMbIN3V+KlRRDqP8OG8QBl30oQFlwD0YUzmczV4+SQ8P0Chhm+OmgFfXMEbNWUI/+KKkRIVrwVFIJ6piyfrp1RQfLp16diCFoKehx5HtWMJR7+yuWfSIZ4gHcfUccsqvZ1a9Dr/8cIywHDVScPpn5EVR4sxFxy/5JOgJvtsuGcP414+p3UUEHJmg942XGkBSHaiAepEVV9v9w/vBGAb9//1tsvlypaeYfrHqN6gE8hERcxL78CaAcGbcLiZLqK7C0ycYPzfP47a112ilb47A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rL64l4QdrXHdn1BYeJSdvI2KRibSdLhjRW81HML++I4=;
 b=sClznVyX9az65m3tnawsEGEeRxEgJQKp+J96ktFg/GF1wxZ7namOJq04r1uMUC3lal5IAQ2JZzpcoZWM8g6UIHiMOmblVcHgcz6cB7ZpRLh2eaTgeCpdVM9hgp7rvUBHlHA/hXrffNzITa6pxuRGrR5SfVCWSPOhMPc/z99XOTY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 SA3PR01MB8502.prod.exchangelabs.com (2603:10b6:806:39f::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.47; Thu, 3 Aug 2023 21:14:21 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::4e0f:49b:ee39:f08e]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::4e0f:49b:ee39:f08e%6]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 21:14:21 +0000
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
Subject: [PATCH 0/4] perf vendor events arm64: AmpereOne: Core PMU event update and metrics
Date:   Thu,  3 Aug 2023 14:13:27 -0700
Message-Id: <20230803211331.140553-1-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR15CA0006.namprd15.prod.outlook.com
 (2603:10b6:610:51::16) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|SA3PR01MB8502:EE_
X-MS-Office365-Filtering-Correlation-Id: 13f58e91-259d-44d2-2e93-08db94669abc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eqcRdVYHptrV0r+opxlGmDw/MeOTynhf1kZg7zs85l6BMfRIKW4bZVqA+BCeIR+D/1F8f1vpxHHcl4ICvFwzu8AGy3D4T1SiZJ4Qt17S1UI0qO0gXXf7y1JGgB/vHi3MwO9TnoDbl7wm7wxUW61SbNA4L5RHphMSBGPN8eEw/o5o3XXeYtu64m8GRHEWwjD7JaflPQxDOJdV/QAd+mOr5zydiscq/zyvaGAjPoVCM9n798YhdcsXF7Xl9skvbo1258a3W7paWFAE/atSZQsShY0DgvryeWyo48rAPSZl+LTzKNpjca6eNN3h3i1Yn6mZWslK83e1b1LTzeZgH3JrxjtAxTHwcyOaLwqkNjJJ12pOuPU3y2OS2ZYZL1mxCwRjA6k1BLa/9lkA7isxHTJLZBL+E4cRu0zwGKyGhJnM49Ecrz889A3+wZZ6bSjIQ35WhsJGeDCTkFJZHxu7BdP9nOB1o2gPfs52EZE2rSvAgfVML6uFrrGTANpdz5lfcaQQJkX7kEP0u8HERxxqC5Xnd9FJfN52A0ZWcjbEp4xYu7/Hvbgy0O0aagoj7MfcjhswE+D8PKNPNhp1vLiDNRzTViB8TJ/IaUkoL1LR6urk5lHZazHtoImLA0DFjpCGZ+OK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(396003)(366004)(376002)(136003)(346002)(186005)(451199021)(86362001)(52116002)(54906003)(478600001)(110136005)(38100700002)(38350700002)(8676002)(1076003)(2616005)(6506007)(83380400001)(26005)(4744005)(41300700001)(7416002)(8936002)(6486002)(6512007)(2906002)(316002)(66556008)(66476007)(5660300002)(4326008)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+7VQP1ZsNdnxnDnudfb3WqxSXrXHx4WRLRCCV1/+g/BhgLbkJoM5/gnLAt51?=
 =?us-ascii?Q?9uMaz1odkj9uuvAl/CFe1+7LiIaKtezEoEMqJoQQjgtLzZityPh/ljzbPPMu?=
 =?us-ascii?Q?uZlNswg8pfPmSShWoNIdOkyoH+Th0ckNLgF0gtKvU9Rh8K+0u0uB9EDLbglc?=
 =?us-ascii?Q?IKLyVVf1FAzCjTCp9ci2lOsZPsgx7YudSt/G4+hMxDKHxLkAUUlUx9EOlLY5?=
 =?us-ascii?Q?YXzNq0cQtPPe0P8uUZaarJphsI6TOPB1DR+w9Fws33pX8T61eYGCPy/UPEAP?=
 =?us-ascii?Q?Ztt3jev3K+RYmX+95JOEsc2ZX87NrO0WDv+BKkezU2bAgS+p/4nbHd3HtxRf?=
 =?us-ascii?Q?JiVmbhmSmBmI60rAwq0G3q3vwC0K++Xg57fqowwemE+SLlN5qHhIT0xaeGII?=
 =?us-ascii?Q?4L27AdwYDSjGhMTUpwx11xVLJH2Dxh75LjDSmCwMmXgfbj8w0VPznNX2PhkZ?=
 =?us-ascii?Q?vmX4D92wPlFb6TRvo2Lz7IMg6nOq8sCOhiJEqtEJEYZG5Ux9YtnNlRvxYGkm?=
 =?us-ascii?Q?rcAZOj80RYwuDKS1gfcu2z9ocOqmpllY/RfuyPcw4P7iTI19lwRv3jmxJHHB?=
 =?us-ascii?Q?SnX3E5dL1fAqa+GaEYqMgR/fmttNszfcSWMCm8k1Lc4Cs2+LbxnPSA1gKcFK?=
 =?us-ascii?Q?w5aqOwSYcex9yxGt9BvxhgmNwRx3CfsYC1QlQD4XCNZyco3/uCPM9OiYjdsE?=
 =?us-ascii?Q?Vh7iWuSnarAd61v9fL7p9+SKi2LSk1GWoRuxoeektJAWozCA5EsVPX/Xzi85?=
 =?us-ascii?Q?EkADL5gGFSz0BwTRLCBYi2lRIsIKiWvW3HWA01UA69U0bJi5/DHb2VC7A+ve?=
 =?us-ascii?Q?AEnySdLJoBA3aCNMuFf8RNuzUHWKARwMBYBQZJxcxp82iyvp3Ut2zVXob7jf?=
 =?us-ascii?Q?JYZVI8Tp5DB/Og5UtUGBz0y0PIPkW+oAZaRJGD5wRkqM1FKvw2Bdu0rfsv1I?=
 =?us-ascii?Q?eLCey1mu5MnjIkkXUWo/4Zw0Z/os0T0lRny02kkkFj3uAGb2ZHdL0O+tfxur?=
 =?us-ascii?Q?w+lGEmOY9x/lYOKRJ1/WhFXi87Cj6lUy3TMtYwESJWMku8VtF2NOcrObXAf6?=
 =?us-ascii?Q?Y/pwx/O7ebF0EVBeUQ/0+VCAM1viM+CxgC3DGSZINxVULnkIUkUd1tmfCv/L?=
 =?us-ascii?Q?BhyqR7XVVh6t5gLbS4krEEfz14CnDnRhMWPiH2DnWQWZrE1t4kIOFWYaU6ba?=
 =?us-ascii?Q?q3MXEnxa4KO8p0Dgt6nyJyUmyJN1EgNQpjCo5v7O0cbNd8mCZb7F/SHaUT8O?=
 =?us-ascii?Q?rCxvUxY3I879HDl/Kdg/mqdqkqqGJS+3rgQ/MdKO2dw6Mn5CIRNs8/ERzY7d?=
 =?us-ascii?Q?pUeNUAWQAU8dj4thrkFF5xzwQKuZs56hgO9gZUi17lX4ZwsXpm1UGZNlhWBf?=
 =?us-ascii?Q?2KEz60fn8GtF5FuzyOy9pH7MPb552OScpTzGy59HgJ+CRas/ksn4Sg2HB3HR?=
 =?us-ascii?Q?gdzzunhV0/EYboDzk7OuAgSbZNZkIQPsOzj2aIM6626p/XNwfBwBftvvpuWn?=
 =?us-ascii?Q?1kV3+tsrII4H+WMY63N5EODPIBasCN/VVL9r7GAOtCYSIl8ukVRvb5tf4pFG?=
 =?us-ascii?Q?jj07I+rPz+dQFfhjq4+m5vDa0L8w6gfMwce7AoJT0ZE2dKCdqP6sNDpeFtbS?=
 =?us-ascii?Q?VQ=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f58e91-259d-44d2-2e93-08db94669abc
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 21:14:20.8529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AJ7BljK4E/M65eYt2f+g0BVoZQk4Uy+S4E5z/XAeRjlmkR7uQ3pZIZFbGHY01a0xOkNQVm/14SWK8a3Qym8a6QmEwrbLyZTAzsNFD3vQGfHYfikffO0LyU77RBn+i/0W
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

AmpereOne Core PMU documentation had unsupported events listed, which have
been removed since. In addition, certain STALL_* events have a bug and,
thus, the errata number is added for reference. Finally, metrics are added
for AmpereOne.

Ilkka Koskinen (4):
  perf vendor events arm64: Remove L1D_CACHE_LMISS from AmpereOne list
  perf vendor events arm64: AmpereOne: Mark affected STALL_* events
    impacted by errata
  perf vendor events arm64: Add AmpereOne metrics
  perf vendor events arm64: AmpereOne: Remove unsupported events

 .../arch/arm64/ampere/ampereone/cache.json    |   3 -
 .../arm64/ampere/ampereone/core-imp-def.json  | 120 ------
 .../arch/arm64/ampere/ampereone/metrics.json  | 362 ++++++++++++++++++
 .../arch/arm64/ampere/ampereone/pipeline.json |  12 +-
 4 files changed, 371 insertions(+), 126 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json

-- 
2.40.1

