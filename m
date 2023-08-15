Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36AC77C7F0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 08:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235229AbjHOGhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 02:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjHOGgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 02:36:14 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2092.outbound.protection.outlook.com [40.107.223.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA69213E;
        Mon, 14 Aug 2023 23:36:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xc+T3Gx5RyeFs/x4SphTC1RyVsnyIvPT9rt+z48rUfxWNgLn6iR6clvzf5ybZmvSYVZ0S7Muha5hZXzJVqWHhHqQCHdjJaM4jTyDhfpgw9H692IdZdB/FdjIX6kx9dg73DBp8HJvgZdh4hqRpaxmq0oNPDpY3GFv8Dp4tIYcIf8qPOQdVoZ/OKRkjMECkibFc3WTyfKkL+JeLs7uK3fguxj4AVffeUKlxV8YFkN+CZlW96Gm4x/QxHe24ZpCrlSPnkAlH9eyVMFuW5JNEQk0+b+rgb9W/KBO52yWnyFOoYfo5ku/888ItDJ5n2iyAohDAbp4oggquqxgGGmAERAeJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TSRfxB/5GagZGbWxpD+pn3TDmA3gAEjU0nN/sZ2jhwA=;
 b=d/9GGBKPE9+I9vpxbATswisTVhW5VoH1WeWpGkpE55O1byjfGJTpm1C2e8mFtEKgJ6bLpdf1CV2EU/Jdt2D/XciVEqXJkc5xZDRY4o1OrWTdnt3x/qaQUf4qdDj9mFipHocVTHctXlVz0pBp9en/Dl0yqMWpKjGWaxK01BF3cw4mpPI1bFE6gXKWJhg9LBQUIXeEySMNaFszhaWqRDrRa/f27GiBuZtEuahR0IEZ6F5JOjo0/CvCaDYwGQj+7BQnwNRd+pFvP/KOHhuxeS+7Q6P/Mypx0xlhv304L7VlfGqfLV5EZxyGvZSovjO1Ee/u4+i+GaMo+Z2dTwAeDChsnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TSRfxB/5GagZGbWxpD+pn3TDmA3gAEjU0nN/sZ2jhwA=;
 b=pKpDwHNFfltkbLTwVLajN5z0Gm/d4DoT9YrFi1GiU1yt46t1t3MHfNhFH4aNBIZjIdlgU2QDmzevteZvwW9Sop/y1tuzW7FqEEnOmvs0K07WInnqMssFiaQGwSeWpAARrrNHi7RVNIhe75NItWtaCbhHHbjGBs8ZlfheZ3+WgH0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 PH0PR01MB6117.prod.exchangelabs.com (2603:10b6:510:9::18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.26; Tue, 15 Aug 2023 06:36:09 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::ed8c:18b8:dac:2331]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::ed8c:18b8:dac:2331%4]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 06:36:09 +0000
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
Subject: [PATCH v6 2/4] perf: arm_cspmu: Support implementation specific filters
Date:   Mon, 14 Aug 2023 23:35:24 -0700
Message-ID: <20230815063526.9022-3-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230815063526.9022-1-ilkka@os.amperecomputing.com>
References: <20230815063526.9022-1-ilkka@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0359.namprd03.prod.outlook.com
 (2603:10b6:610:11a::19) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|PH0PR01MB6117:EE_
X-MS-Office365-Filtering-Correlation-Id: e8008f31-30d7-4896-521c-08db9d59e8f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EBVrstl9qhQ4lMCIE6eGcUsIL5iK5Scx0qS9/m5MaGdrl/l31qROQduXoFyRTAfUSyIG4a5pWjqkb2xBWpwlyQJHk1CMc6ZObqLUhIGSUdeMb3CXGljQh+0EWwNnwHuF7GabfyIT3IyBn/ge29Agdr5gfRkPtOBonu0JnjJb+vK3aSGDiLmlQR2KWvhyKawWOuK8/lY6PYA77NhZvhbgoGH+CBf1r10LFUOto9ERiONMtvUu2g7H7/EEe4qdKG7+kr7mV4WDgsvmBaQu0rEi/E+PsCE0XZbrBsTp2pm8zYJxOcWjdPUZXQcOJ5yXbnp7Nwr5r3ddAARzNfw493giKoJjgpT1q84stTjgFuvrrzLrjcW7eQEb00MWv6oW/prYcA30ufTc57NDfFcht36YLuNEC5J+uLi0UEPNLYZ9dw8cc9DRPOteaPzxcET79bdAgwuaqNXcVpdBO1QOK7+mG0LjDHLvxSSChA8W1fAY5v13Yn1S/5CVugENl9wNnIaxqrC3hQqvWXupNzdTRcW/EId1mlKnXRRDfmg95jKHlhq1ug6Oc8B1LdzaAK3Vx2yNgwPO9M9wSTQSKm8Z4kpat2kEunUZXq1IDbYo9z4Up+w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(136003)(346002)(396003)(39850400004)(451199021)(186006)(1800799006)(110136005)(86362001)(478600001)(966005)(52116002)(6486002)(6512007)(6666004)(41300700001)(5660300002)(4326008)(66556008)(38350700002)(316002)(38100700002)(66946007)(66476007)(2906002)(8676002)(8936002)(7416002)(1076003)(26005)(6506007)(83380400001)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zX9AaEbi6FSPFIYiiAdLu8TGwK66MYIKC2XIWb6IsBVU2M1th34aPaWQgCil?=
 =?us-ascii?Q?2cwKRZchWVLDXm4kVy0vTm21YJvE5Y4838AU4vknF7yqhcbnwrC/gz8G8Xoa?=
 =?us-ascii?Q?bQnjTZv5QO84H0yIIo/Tzv0Tj2JoLBWrLCVO+v2oU6DoMCl/Dypmr2YYJKb4?=
 =?us-ascii?Q?RVCXDqx9dkbS5PjeG+VOoe50kfa584pPTgmjm8E2fFwoi/AfI9n/NRIRxhSw?=
 =?us-ascii?Q?dqZGFzWDLx5mmgU5qBCoES+C08yyS05GTbTw4XM0h4zhurM7r2HYpGSf1m+n?=
 =?us-ascii?Q?VBAXR3MbE4CotaXtoj7Trdzag7AkfhnkB8wruc4RG32XZcav9pXHDxVkBdqh?=
 =?us-ascii?Q?WJFTzYrDe8WzocZfMfeyVIDY99OA4jWbVXX3nE9nAo04G+2jR3BXokNBD7XK?=
 =?us-ascii?Q?gGt0BzMUTQsjeZ6py/529TmVBwVwujTJHfx4MoaYEU45K5sFL0bZPpgSFh/u?=
 =?us-ascii?Q?NSFNC+JtgITrEkGI92L1pYBX2cMcxoBrTcgfkZIb0WeEtOD7FCIp2qosfZBo?=
 =?us-ascii?Q?ymtKyguIDoDMqoTTP49ZAc978udQijukuvb3z8RGlWCRuSi1n9HYD+MGJZSx?=
 =?us-ascii?Q?s5hy7/wQDnQTzjuxffIoKrMJH7p6T6U+vzRoArHPI27ov2Ivjlug+OpyxqhG?=
 =?us-ascii?Q?hCEZJlD58SbZkuqXPqEyV/mb8V3vIq98MMLWy9XuQVGGEL4ipsgydFEBelfv?=
 =?us-ascii?Q?MBh4YohUQK/HTj4wQGGf/uKJsbjaSkXMQRG/94W699C6I/9XbQyD02I4xq5K?=
 =?us-ascii?Q?5b/1If6CYVdJrIWwaPws34k5oQvpxrN+1MXlwdrz734GlxpzRWhWT8FJQPIt?=
 =?us-ascii?Q?nFDduBWUupuyzs8Ruk+Iu+CTa9uGzvnHTyjnkLlYGH5Z9cbb7LPlfQB01tfJ?=
 =?us-ascii?Q?EeoWtRVQdrs+UzqgpyWrPJtcGwsajmPX0uBcfEWdo2B96MndrZnXEepxEjXU?=
 =?us-ascii?Q?LB5F9HryNzv2aS1ZPo/NOVWRVyNIb7ftHH7dEAjqntuEJNWt4fB6oj0Kbj4B?=
 =?us-ascii?Q?1yceQmuxNHKE8XyHIHcFLVcRtHdPxRWUk3T6m50c33LAay4jIzWlyVhnyccL?=
 =?us-ascii?Q?9M9wtEGuKHhtbrjhNC5dL+J2kdMRYkC4WYhwrmlzd/6uk2DZDeL2he5y2FH2?=
 =?us-ascii?Q?Teqylnr7tgrOXTKNqmskaoS+7qtV3NpHq4IYE9PLf6SkeqGv/8yef6/SXolS?=
 =?us-ascii?Q?G7nhsDJsp4+PR5xOtvhy9XMXLYuLEp+KEw4BBj/h+Z9jcl7ydLJfrBphNWIy?=
 =?us-ascii?Q?b6PEkRhL1sSnhA1HIvF3QjZwAH4yXEG3R7cOgTfNE6yJzzna6X+zlRu8DA+x?=
 =?us-ascii?Q?+bnAF+rem7PrNPVFD9Rhd8ihZshXBY1Lr0UnVRsPdkqOj0HDur7Gl7rCair1?=
 =?us-ascii?Q?BiVo4Mn+dP+vXiZa171kVAflckbMvkA8CfNt9k2LHWv3TH85+KvSsa/lhuk+?=
 =?us-ascii?Q?YU4Nb3ehaImg6T6E8lzC8/dEBYrec0xeeipG03hAn/heliHsLva6H6V8AUju?=
 =?us-ascii?Q?AXWaS+ThMIg5X7KkDVu+fnj64zaAzUJ5k7lLmiXZ2SDRbfjPIhktbJyEVHgO?=
 =?us-ascii?Q?EXFDIoXNYITzjhGBgj/0XgLETbD9o1cpxkSFQJr/ttEmQ5XdLid6G5b+QKOm?=
 =?us-ascii?Q?VQ=3D=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8008f31-30d7-4896-521c-08db9d59e8f2
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 06:36:09.0101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 17nOJTGo2MM76xYjDtnGmHbMPdo0KczfCh2DqtT9c+3EUGHhmLwcGqLAO3kMbVetUVclzVYmjCwtOhLwPl9LJTa/n6HRht1QuN1Wur3CAZoJMAYRgwmU6YxhyTYI12Gf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6117
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
 drivers/perf/arm_cspmu/arm_cspmu.c | 12 ++++++++----
 drivers/perf/arm_cspmu/arm_cspmu.h |  3 +++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index 6387cbad7a7d..94f6856ec786 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -116,6 +116,9 @@ static unsigned long arm_cspmu_cpuhp_state;
 
 static DEFINE_MUTEX(arm_cspmu_lock);
 
+static void arm_cspmu_set_ev_filter(struct arm_cspmu *cspmu,
+				    struct hw_perf_event *hwc, u32 filter);
+
 static struct acpi_apmt_node *arm_cspmu_apmt_node(struct device *dev)
 {
 	return *(struct acpi_apmt_node **)dev_get_platdata(dev);
@@ -450,6 +453,7 @@ static int arm_cspmu_init_impl_ops(struct arm_cspmu *cspmu)
 	CHECK_DEFAULT_IMPL_OPS(impl_ops, event_type);
 	CHECK_DEFAULT_IMPL_OPS(impl_ops, event_filter);
 	CHECK_DEFAULT_IMPL_OPS(impl_ops, event_attr_is_visible);
+	CHECK_DEFAULT_IMPL_OPS(impl_ops, set_ev_filter);
 
 	return 0;
 }
@@ -811,9 +815,9 @@ static inline void arm_cspmu_set_event(struct arm_cspmu *cspmu,
 	writel(hwc->config, cspmu->base0 + offset);
 }
 
-static inline void arm_cspmu_set_ev_filter(struct arm_cspmu *cspmu,
-					   struct hw_perf_event *hwc,
-					   u32 filter)
+static void arm_cspmu_set_ev_filter(struct arm_cspmu *cspmu,
+					struct hw_perf_event *hwc,
+					u32 filter)
 {
 	u32 offset = PMEVFILTR + (4 * hwc->idx);
 
@@ -845,7 +849,7 @@ static void arm_cspmu_start(struct perf_event *event, int pmu_flags)
 		arm_cspmu_set_cc_filter(cspmu, filter);
 	} else {
 		arm_cspmu_set_event(cspmu, hwc);
-		arm_cspmu_set_ev_filter(cspmu, hwc, filter);
+		cspmu->impl.ops.set_ev_filter(cspmu, hwc, filter);
 	}
 
 	hwc->state = 0;
diff --git a/drivers/perf/arm_cspmu/arm_cspmu.h b/drivers/perf/arm_cspmu/arm_cspmu.h
index e5c6dff2ce7f..274ca3d10578 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.h
+++ b/drivers/perf/arm_cspmu/arm_cspmu.h
@@ -104,6 +104,9 @@ struct arm_cspmu_impl_ops {
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
2.41.0

