Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC37752E6A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 03:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbjGNBCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 21:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234623AbjGNBCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 21:02:42 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232F72D6B;
        Thu, 13 Jul 2023 18:02:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fHeU2yNLQDMVsU6RgKmeoOMkijXIkLhVg2rCgH75qH+xg1d/Vol6fL7kqn+eCyBS+ua4HWDJpy4z3QOpHonWSD4aXFs+iyl7b++phSWfuKX8Ubb4Wt4ofW8SGB2duHXpqkdFcAVGSgYVFSfgXx/cculF1oOlQbWGQecj9pO3KTskkjA7TDBhUuxxG+ecVLAUM+yBfgwQ7Gk/TE0bW3i+V5yOP3T0mPgMutKlxNPXZlBBr+neXkDV9DDf7Sfgt6Czsf9FNlPtPimoQaV7tl3sOgh3s0BoqtjkCeQlhNsWgmdRyEwbxhvwn/OXfd/VdZ6gFBUdFAm/moSNT4DlbvhjHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qoqy0gmISfnAljfEMv75zDnA84+ti8B1BA7M8aLiHP0=;
 b=JTeonWsYPwZ9gGlm9+kfV9XeU16G829FanVORThq+RLCKfhCzkF78dY3dd3RMSQO3VOKXetwtjE3U/PFz3naboIKxnKAvjJ39U0etW3oHhJsjuDs7MZjSB8KwyXhsE3mBWilNzegif+t37h9WvzG5eCf8f+gxw9jI1j2PunoribPzmQ6Dxdl7ZQrUKOw4bXfNKwUz7UZ0HuBQnJBrMPUfV+2rVePs92WkUUFn0XpscrcimV5MDkbGHcARaGLY5WQ4nc+89ajsFJ5JvKMlIvzb6P5pMuz4RdfJPAOwbIk6Z/QKGWLfKD6HWtPVf2sJeCSOPYBC6UvE9VlPl//1wOM9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qoqy0gmISfnAljfEMv75zDnA84+ti8B1BA7M8aLiHP0=;
 b=HNuVm+K1RvW/QGsC3Jhp9OV+/GKIAcWTorNfpvWH5+18F+YlRDKlcpTTby+ck3u6QrMgQ81fItd05mBSxK26TlydASVmmmpI5lvTf9Cnh3H+iikztYU3VzEBLQQ1Onufp68NDna+GJiwA0dgnpCdDEmkyVbp5bjR+aRTBl+YIbg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 BY3PR01MB6611.prod.exchangelabs.com (2603:10b6:a03:36a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.27; Fri, 14 Jul 2023 01:02:29 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::235a:622:9239:3963]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::235a:622:9239:3963%7]) with mapi id 15.20.6588.017; Fri, 14 Jul 2023
 01:02:28 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Besar Wicaksono <bwicaksono@nvidia.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v5 2/4] perf: arm_cspmu: Support implementation specific filters
Date:   Thu, 13 Jul 2023 18:01:39 -0700
Message-Id: <20230714010141.824226-3-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230714010141.824226-1-ilkka@os.amperecomputing.com>
References: <20230714010141.824226-1-ilkka@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0P223CA0013.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::30) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|BY3PR01MB6611:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d4e5565-fa4b-4140-e6ec-08db8405fe6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: blLD09utF7Y4Q84tvg5mA0Pa+ug8T5C1vuxOzC2305qBuxWOUg+J88j/GOuBBUmuSu2xKlGAIR3i1FhAzjIZFotdb3cbS+FPBAZ461bsfCZEnGl6a/jD7YU3GqtmazUB/BTohQxGDZO71ztNSu91A0C2H5nrbBrtADVaAFq/kzOamYbsNh6oKqL+5bftM0gT9eRntxKN7hjPK0ys+Hs/GX3f66JniIjppTJWzE+BbcY8jha3PpZMG3fIaJn9mTpt6lIOwx9akhME+/q9OIHALo+FEwPCkEX86l+5LKSX+JNGwdbYU5j6DpkW9TjVQUcOmEHuc9bxbbCDFug+sm+dAREq4LpJTX3889L6ZieFDb8V9Y7iVRtCK1naH2kb4DK4+6lxO/yWIlfoCmqDCijkMao6Rz/ZZ98lyGGBJ/VbHxD7aHNd+4vePRNTO9xoUQbHZsFHVamozeDESC6/n65SzBGdtJKpO8fU+j6aPaQjTr0fGRVTdDcgtt/jWna2t/gMFHSrdgb2wX9HMRst+WD0Zc3leFUBC2b+teaSrHuMyfNvgP8H88O6LB5l579V1dz9nLdbhGAhM2y5afKYb/dxnnvQo5sadBYxVeCW5hShg3Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(136003)(39850400004)(376002)(451199021)(2906002)(38100700002)(966005)(38350700002)(6512007)(83380400001)(186003)(2616005)(26005)(1076003)(86362001)(6506007)(5660300002)(8676002)(8936002)(7416002)(110136005)(478600001)(6486002)(52116002)(6666004)(41300700001)(66946007)(66556008)(66476007)(316002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aAiIPmHOdsrvaWZkkgRuoExrV2NXHE+sTjPLOgEHhJGEDrDr1+BpSDZCFnXe?=
 =?us-ascii?Q?Bps+FIHL0Ol5CYYLeVYIB/R6xLWpYSept0hxLfhqzXgEs+xD26ckok6XEJwf?=
 =?us-ascii?Q?5F8KFCJWNnGCuGu3ZGGNfREtw/LYHGRY+PZsJPu8Lcll8rPD5DYFJJnVBsqZ?=
 =?us-ascii?Q?ZejaHGJjCuBXnzTluV/jbP4GBFRPztjOOCxiMt2hIkxDosFNVm3pVSfGrTsS?=
 =?us-ascii?Q?Pioqyh5wb8JJ9T6m+KkoGg26eBvAZfUrGTD1MimJyMdyQCITVInUxKedAgBF?=
 =?us-ascii?Q?yMogl41leql9tM2NroRZnBMhpErvncvMxb92xa54w2YNc54YlYwxxlCYV47d?=
 =?us-ascii?Q?JOv0E9rGeyBHyZ0xlXlJoAORShUIGkOATxVaf4Wtjpp9/y+cA9Y+u4o6xW8K?=
 =?us-ascii?Q?HI9sKxrWy8UF8Cr1irojdyIY5gCvP1mGeOukVFvz3/DNFpxxZC6WB+2AR1Qc?=
 =?us-ascii?Q?RMC82/9ZXYblVFlMhFNzx63lQkOgptwMlyaYRA8pLQu/+hZeFNPW3vst9crM?=
 =?us-ascii?Q?v1Y49NftLJkxa62G2z8xOId9lQ92ZG6Ag8djENzJa2SIf4WQZsQU6nr2w9JR?=
 =?us-ascii?Q?/qGsNG3ld4rRbrLGvw9lMujTA9OLLdzJ1uCyXFPnYXiKiP+YE2eWxyeWGZ24?=
 =?us-ascii?Q?utKJeHn2mafMBbJPTzSbjw4XFfBaLA6pu2tLz3+pwElDCAkXTImz5aBe2kbw?=
 =?us-ascii?Q?h4ToZVS66k+6ZlIwPlMxsdz93b90FZUvqvLX6xiMAcX4+CUW71v4lZsbHb7U?=
 =?us-ascii?Q?hcGh7uxVddTOCsZgPGgFC0V0Sk3XnJ27RTxkABtfURP5f5BRnK/eBjuwrDKH?=
 =?us-ascii?Q?9c5GqHd35fTshCV5ieAqTkZMjIVoEm+laT2JyPAarigvJAcpWF8JwJsWCFsp?=
 =?us-ascii?Q?60Xqahxx7EiLpwIeVdq2ad6QS9feRLWQHFFtq3DWbLxcd3VXt//aXInvwEaF?=
 =?us-ascii?Q?L+uNicBpPRJemZUDTde+G6FloMJ5wcKmn4OvxL5rR9GfNWE1OmfraQoGDbLN?=
 =?us-ascii?Q?Z8dvO5ru0Z7hZWpSY/FuuUjvMJv+qmbPySelisa2kCV/Yx4bp6ooz2HB8T64?=
 =?us-ascii?Q?NoTG8OKJ5PxAdObOs4fN8j70F5JBTAnBSH/+Z0PxKQC/7QA1aQ5N46zlDHOg?=
 =?us-ascii?Q?VpNKQSnvfDy4Ex3jDKPLixInwNEsvVudpHllDuPZnCmS1DCQGoDcu196PqMZ?=
 =?us-ascii?Q?VeOIwgs1FW0HAK+9phB791T1k3lF/+inz0Y++7Gf7QjecRbgVHbKS0U4nUMh?=
 =?us-ascii?Q?2JPgWCAGZ/ZxEykpC8cxqqbKhcYWLycaznSWS4H2DbiFOYaFlOqivm8sow1I?=
 =?us-ascii?Q?lWikOWUovJGOlECzidhIeGtWmpP21AIuMFktN8K955sMnWtkJpeFIFVXD5sA?=
 =?us-ascii?Q?rCtoH+lJ80joqBsryoDwiB1cnOzPXp+RcO5gLbcTMBswvIj1x7Lgl2upHDdU?=
 =?us-ascii?Q?O3sespab4OaUgmWvT/GI0JcSJOAdoqwCeYBDbC8grS4TL4S441jxC5z+gqY0?=
 =?us-ascii?Q?fEpXx3H8LbN5nuqJNnJmSvAf4vmB5AaIvGmxxPPL/7VP8LaA0RVL8S+AI83v?=
 =?us-ascii?Q?orW9sqDu38aQc7pHcTkbiLYcsOPHaBYwI38wTxIMl0zDaG6LSjVCb8ZIiOFt?=
 =?us-ascii?Q?OA=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d4e5565-fa4b-4140-e6ec-08db8405fe6f
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 01:02:28.3131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0r5Na3f7pflSwPBg19EXTN0hoi8jCjxaIe/1ZLQis4y4IMMll4xudE6oxnPiC2tQfGar8xIAE6aJjAFOYn0UQe7MAhUFq0Z2/OX5wsyRyZ96di49QOct+uGLCq0i9qq5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR01MB6611
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARM Coresight PMU architecture specification [1] defines PMEVTYPER and
PMEVFILT* registers as optional in Chapter 2.1. Moreover, implementers may
choose to use PMIMPDEF* registers (offset: 0xD80-> 0xDFF) to filter the
events. Add support for those by adding implementation specific filter
callback function.

[1] https://developer.arm.com/documentation/ihi0091/latest

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Reviewed-by: Besar Wicaksono <bwicaksono@nvidia.com>
---
 drivers/perf/arm_cspmu/arm_cspmu.c | 8 ++++++--
 drivers/perf/arm_cspmu/arm_cspmu.h | 3 +++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index 0f517152cb4e..fafd734c3218 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -117,6 +117,9 @@
 
 static unsigned long arm_cspmu_cpuhp_state;
 
+static void arm_cspmu_set_ev_filter(struct arm_cspmu *cspmu,
+				    struct hw_perf_event *hwc, u32 filter);
+
 static struct acpi_apmt_node *arm_cspmu_apmt_node(struct device *dev)
 {
 	return *(struct acpi_apmt_node **)dev_get_platdata(dev);
@@ -426,6 +429,7 @@ static int arm_cspmu_init_impl_ops(struct arm_cspmu *cspmu)
 	CHECK_DEFAULT_IMPL_OPS(impl_ops, event_type);
 	CHECK_DEFAULT_IMPL_OPS(impl_ops, event_filter);
 	CHECK_DEFAULT_IMPL_OPS(impl_ops, event_attr_is_visible);
+	CHECK_DEFAULT_IMPL_OPS(impl_ops, set_ev_filter);
 
 	return 0;
 }
@@ -792,7 +796,7 @@ static inline void arm_cspmu_set_event(struct arm_cspmu *cspmu,
 	writel(hwc->config, cspmu->base0 + offset);
 }
 
-static inline void arm_cspmu_set_ev_filter(struct arm_cspmu *cspmu,
+static void arm_cspmu_set_ev_filter(struct arm_cspmu *cspmu,
 					   struct hw_perf_event *hwc,
 					   u32 filter)
 {
@@ -826,7 +830,7 @@ static void arm_cspmu_start(struct perf_event *event, int pmu_flags)
 		arm_cspmu_set_cc_filter(cspmu, filter);
 	} else {
 		arm_cspmu_set_event(cspmu, hwc);
-		arm_cspmu_set_ev_filter(cspmu, hwc, filter);
+		cspmu->impl.ops.set_ev_filter(cspmu, hwc, filter);
 	}
 
 	hwc->state = 0;
diff --git a/drivers/perf/arm_cspmu/arm_cspmu.h b/drivers/perf/arm_cspmu/arm_cspmu.h
index 83df53d1c132..d6d88c246a23 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.h
+++ b/drivers/perf/arm_cspmu/arm_cspmu.h
@@ -101,6 +101,9 @@ struct arm_cspmu_impl_ops {
 	u32 (*event_type)(const struct perf_event *event);
 	/* Decode filter value from configs */
 	u32 (*event_filter)(const struct perf_event *event);
+	/* Set event filter */
+	void (*set_ev_filter)(struct arm_cspmu *cspmu,
+			      struct hw_perf_event *hwc, u32 filter);
 	/* Hide/show unsupported events */
 	umode_t (*event_attr_is_visible)(struct kobject *kobj,
 					 struct attribute *attr, int unused);
-- 
2.40.1

