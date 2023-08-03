Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E4476F484
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 23:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbjHCVOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 17:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjHCVOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 17:14:30 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DCE211E;
        Thu,  3 Aug 2023 14:14:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E1yvcKsScEWc8DEnfci170o6udQ3o66wHdG+K604lp9ChCpG+gRBsnb48N9Punzt4KG6/8HeDTNhcZcHtNqwzf17gRpQ7hvO5RaBwOhvyHqvV6t4E/jZOz8z07blGUsTVm5cWh3ybk/+nPtaepVLSK8oUgaS/KnQDnGgsdKtQK5FUIHUF6F25N7DXR5aDBzUDCEfEe8PvKszzkKvj/vh4nu8mMeKhH/0IItN1rd/xOHyOQMz51Pow0HZ7d5c/TpxzP9h5DySiQDRDoxpT98PhdE8VePSooXbEFj3WcTxURlIVZIRRPRIfXE0y6DAMmOI7uZ3fH9qDem+Oi44Dqc/RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+noMXr/uwU33h6hP/EjN9EZSjDbRJo9mpYzNp13WN0=;
 b=VycSRnxDHXEh+eLLhzlFnzNala1nS0uXgZzbsB2rrRLTOCJWmUjxWnkvGPPh3nvNnwivRqnBOAS7wTbuwDLEdo0TGDPKgVrDVrbyBCFKUXOMX8pagbHTJ2p2vFLXLAnHfn1RuMUP3+Tz3IjFqEvlQePhvgmt4X2AH+XImEOGbKv+lGMEkhF2/4dcRuQz8gxjs1zOQzFLdos5QN3+rW7s8Sy9YUsYpcGjqMmVviMWzZAh3arkIN0w36i4g+UEY7TUv+cL8GCUOKOPAkWl5n8kB7AcfEvAPx8G9UEXjsqD1c7BrSaVEz8V77C5zhjs/CwD9o+IpiuvYBg7hYfNQJhFog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+noMXr/uwU33h6hP/EjN9EZSjDbRJo9mpYzNp13WN0=;
 b=i/jk6ZmNsFOIe7fXrOwyClArZweT8smcYeDA59Uk+RV3FqGwm/4LsvnrtPx5rGha4prHqf+OOG7gdODNE/2slpdTrchlbJnlulAtUMidNimJ2RtCAXxm3cm0bkJ98+FmuTqvY6YybU092K3Ysg4Ec/A908RrwbKb1SfwJKqBhMw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 SA3PR01MB8502.prod.exchangelabs.com (2603:10b6:806:39f::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.47; Thu, 3 Aug 2023 21:14:26 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::4e0f:49b:ee39:f08e]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::4e0f:49b:ee39:f08e%6]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 21:14:26 +0000
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
Subject: [PATCH 1/4] perf vendor events arm64: Remove L1D_CACHE_LMISS from AmpereOne list
Date:   Thu,  3 Aug 2023 14:13:28 -0700
Message-Id: <20230803211331.140553-2-ilkka@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5f8f917b-25cb-4cfb-bd57-08db94669e43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BMpCub7a0PSMjSGHPQI+0p1kyIRoEXYypeIlsrp27hF9gYd71StYvZ7hHM8r5BrVAt7P7QRExvb3Afc0FoIhIQ97U4tnjGpbnugpAGmh6GxOATU7q1yZX0sj8sYkQ2mQdsicbyG+zxzBEm8JLgfBr9XyrUM8/5jb0tTVv2V/1rZ0AQjgAxmy0QTepjwyz/xde1SPGDptvGOjJAcOKWpatgfpvLx5ItxIS+v348jEOcVrPcSz5cbgI5kstlCYWlk0UeDDDcUKFIzAS+cyHrjhxe++cX8RgxBP5JgKb0a6rsFI0RcQG3DF0KViGRuREINw2yeEyBvLix+ERIzeaq4McsHaPUPhoS45/EEap/SXH2eCfQ2dMA5ZFVIh0pcClSEjYOd0qNjIayip8T3Cb9NJDDvepKrgmclSpWUQypJ690K0qqhHkaUZzfPFGThRq9q6hoRjGtdJttmQI6OC6eb7mvT3bwPztKU0vjqq/fQVuxJGVsMvfDRCXvUynrUjml3Q9BDEhT+f8V8HVyh+A4ra+QCuxjMfLbz6BmE+YLIiMDCNgyHTaLoszbpVervbTb1VEG6QWCeCYNE+/ILlsh9fjS11bcnlrFJ8t8Kjc6p725k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(396003)(366004)(376002)(136003)(346002)(186005)(451199021)(86362001)(52116002)(54906003)(478600001)(110136005)(38100700002)(38350700002)(8676002)(1076003)(2616005)(6506007)(83380400001)(26005)(41300700001)(7416002)(8936002)(6486002)(6512007)(966005)(2906002)(316002)(66556008)(66476007)(5660300002)(4326008)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/Q0jBy+1xxmyhqiW7vSx2v7c9wi5lnoCpjfl/kEXz1Cu37jdZhFfx5lK9pj5?=
 =?us-ascii?Q?HsNWXxACMOM/PxOmg3TPlx0T7QQZ3L+Qjj5Mm+CM7au7e0Se8KYxv7fr2Sg0?=
 =?us-ascii?Q?wzykrNwGGMu0NVbMNmy7E0YAJ9aJs9kfkG3hPwBYip08WgsOR4bOmWWKLNml?=
 =?us-ascii?Q?5+A1Fa3LWMf9bY1RiLfs61UbsvQ+BW/rZtzn8aTFEUpF6G5GEOqaeL92mMSt?=
 =?us-ascii?Q?o9mqweYrfRI7HQv5+7ECEQS1xKoW6KO+nkygOClwnEkW8OiX7AG8SgstAwiR?=
 =?us-ascii?Q?yQgpHcAgYOqrjt8+4ZcJqP88jgZ2wu7p2cQFChdCYtW4+4lTnDHJPX9ptdV1?=
 =?us-ascii?Q?g723s6QL8XyG49B7tDOyBuLN11eSP7PNjP00niTjS5p++HGajrWFcXMXnAVn?=
 =?us-ascii?Q?feVgt4YiSzFjmV5Y8ZbymvYGogVaqvEMoCr20N7d8ft+2Sc9pH2+0zGZr/+Z?=
 =?us-ascii?Q?ofeaGiYA2OEiKuPEzz4jiM67rltpOynmKZJH7Rf/xcWHieddvN5AgoQ6F7HY?=
 =?us-ascii?Q?9z+wyOfk6L9tCHBWjyS/WSrub8CHd/yJEtJ9gLgPKmYzIQ+SUSFIvlAs0cBU?=
 =?us-ascii?Q?AZo/YfBZseq+8eEv9GqAzaQm3/q5o7ePZQIS9qMUdZTDCfcB/G69hTZDTsOZ?=
 =?us-ascii?Q?dwYAHALxYA7uzOvmSENc1obuuOwTgb+/VfxkHJtTXSVyHDfb10iPlM65R720?=
 =?us-ascii?Q?D9lO5QAKZnOuvZ+qfoPTDPej+3cLQ6wHUY8dcsjqkR30mWrLIHL0MKjelPYg?=
 =?us-ascii?Q?Tu+B8I4Ue0q++7BpzZ2rfRGieml4FnHAY8j8XPLdcX+uYnnA4SX9ITcTm9qk?=
 =?us-ascii?Q?OQNmPMJBhXovZpI/J1UW7//zSWA+HLS34YTLOUwUAtpdMSN+/JPI8q3LCqin?=
 =?us-ascii?Q?9/GcEeBxacDHCP8lD5xvvyglw1zic6gpfzMpcXTvGd3hXlnBhixSZdGMKc+G?=
 =?us-ascii?Q?5vt2bNOp1fP41jzBL6cCBb4wdBl6H0L6TX/LaZMLNPXopWAjqPkCnaApuXuc?=
 =?us-ascii?Q?NgtHAdUX+XLtpRy8DEdLGtHTq8nv8/Jbeb6mfojt4nsQypNEC1piEVhFVP6T?=
 =?us-ascii?Q?ool9zQ15M/UXHfwpSiLZoUCKKKL+DQiUhIOrDr1sBSr91Z5ll1YaVfkU72A+?=
 =?us-ascii?Q?OnQ9ZkESrGaMTerIpOrcK3qR7fiOO2UoZfILZt6UH0LkI+xO8dyC7HrKe5wG?=
 =?us-ascii?Q?HR/VMCL2lICpBfh8JpjFn1oY7zP9LfT8KCo8K/oPCxS7bmk5BMELB3oagO5d?=
 =?us-ascii?Q?E6TW5U0NI6asJVfC1kdq5CEQqks4Jd/gj7VZ7xV8lbTVYbxVb7hWzquOLgY4?=
 =?us-ascii?Q?LLDmg2JVTjZg0Ggks3Ts9Q3bx+0HVUn790JR6x7w7EFXhNNFk5E5TlqWA7tX?=
 =?us-ascii?Q?MLZ7vjCjM2hDR2iIrmQAEshz9nGEPS/ZHK3/+p9i/QCt1rMeMkkxxtO4y+OY?=
 =?us-ascii?Q?ap4DfDjCkinK5sGyLf2IUsIxjQh0VKTUng6dAAGu9rhbDPUp3EO1bbnVMXXi?=
 =?us-ascii?Q?0bMLGWjdDf5BbWGBHouEUdcT3SopISfH9vVLK/jK+CXh0numEbVtWCH4svfA?=
 =?us-ascii?Q?S1U7ISwu25IQpEiWP13m/skVn7mjABJZ/eD7uOxYaxGwLvOqKfCn4uzgH6wQ?=
 =?us-ascii?Q?1Q=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f8f917b-25cb-4cfb-bd57-08db94669e43
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 21:14:26.7395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bMeyP6hxOpk0z7PVgWfP4FBa1SXrHL9oNGOxkRSyf/p4x3dLEEtWpY8qld1NO9+YYsvl/6F4J1DlTJlFataHetJySv703+U9dVOfy0yI6URnuhJij/qyjfsZZFjGOnAI
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

amperene/cache.json file tried to include L1D_CACHE_LMISS while it
doesn't exist in common-and-microarch.json. While this bug doesn't seem to
cause issue in newer kernels with jevents.py script, it prevents building
older perf tools with the backported patch.

Fixes: a9650b7f6fc0 ("perf vendor events arm64: Add AmpereOne core PMU events")
Reported-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Closes: https://lore.kernel.org/all/76bb2e47-ce44-76ae-838e-53279047084d@oracle.com/
Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 tools/perf/pmu-events/arch/arm64/ampere/ampereone/cache.json | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/cache.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/cache.json
index fc0633054211..7a2b7b200f14 100644
--- a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/cache.json
+++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/cache.json
@@ -92,9 +92,6 @@
     {
         "ArchStdEvent": "L1D_CACHE_LMISS_RD"
     },
-    {
-        "ArchStdEvent": "L1D_CACHE_LMISS"
-    },
     {
         "ArchStdEvent": "L1I_CACHE_LMISS"
     },
-- 
2.40.1

