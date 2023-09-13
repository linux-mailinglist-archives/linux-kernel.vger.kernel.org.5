Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D714479F59E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 01:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbjIMXlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 19:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233242AbjIMXlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 19:41:12 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2138.outbound.protection.outlook.com [40.107.223.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E7910C3;
        Wed, 13 Sep 2023 16:41:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VwGqfdeb3BE/qCIaUvcZ9UIVuEYq/sfChjACkCxZoQxd8las6S6U9XY+UQ7A3X6QYdRkux2YfBnx21489C6FwU1EN1nfQ31eAuOqZZr2sBQzrj/XyhlLJgrQM0TSW5pdlAPabe0uhlmvvlc98ASWzS/ZxgAQUQberm7oCcI9EhAN2jY0NoQocEZUZnaDEWiNXg2g5T72FlNQJU6UAiXHIX4OZ5wDK4HAwQ432Qjtsho8LkmxZkoDuWm+RiwS32cnljMn97fCh/oZuzv0oOngxBKNRQ4uRU1HSC4ueXFu6KEhVgPTunaIRD82RP6J8ItESHoqm0Nfc1WL+3c5tyl2OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JN/E/G70Gd6mDcRg+xCz/uoaSHCPJHhx4CO+EseFoi0=;
 b=kBc0jfc2M6+YlkUL7gl3VFjF4ho6/JgEEc8meHMcnhPwYQZnFR3x9gzqIN0/oT/u/b2OH5IrhGVcbeRC0uJqzRlu7ahlsGfxPCOhPfODpb5mDwFs6yLzFulctpACjh4KvxQaHLgfXz/i7bjRRhjbyj6VehNHVy8Q7ta82x7keM7tpuJPYAqW5nL5HkHhPoIU+QriSZedk/XOQ+XJHWk6AvYR6A5GEjTY0a3rRaDJmy3TdJe6fd7G9xb5Ni55PwHzCcHBk0fW/DdihBz2rbPX51+zMT+GXcexAaHgjRnBH02UH7F6+8KWxfH8/3NNWcxlsSZpniq2uHKaYB7Pa1lL0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JN/E/G70Gd6mDcRg+xCz/uoaSHCPJHhx4CO+EseFoi0=;
 b=KKLCL0y8n4MbuJHT5uJp1d9BIYerAv5SDWb4ICH3kJbY2qTXRcsDxQDTXM+PvlLgiNGfZTs6tAp3lI0G9GkUxB2VjgI5zzqG75FsiFW5ESAd/ZO7RN61EyMM106CY+jJM2/nmYVSyQYAFpzRCYDhqe5UfJHhLiPaVARvNaW+IXQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 MW4PR01MB6241.prod.exchangelabs.com (2603:10b6:303:64::7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.19; Wed, 13 Sep 2023 23:41:04 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::bfa4:8250:f526:5015]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::bfa4:8250:f526:5015%6]) with mapi id 15.20.6792.019; Wed, 13 Sep 2023
 23:41:04 +0000
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Besar Wicaksono <bwicaksono@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v7 2/4] perf: arm_cspmu: Support implementation specific filters
Date:   Wed, 13 Sep 2023 16:39:39 -0700
Message-Id: <20230913233941.9814-3-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230913233941.9814-1-ilkka@os.amperecomputing.com>
References: <20230913233941.9814-1-ilkka@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR18CA0040.namprd18.prod.outlook.com
 (2603:10b6:610:55::20) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|MW4PR01MB6241:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ce0f04d-3ae0-4ecb-ecfc-08dbb4b2e4db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ziR7Zs5+sAWC3mhTOtDjnPffDQuzlCpr2w8fA6d3uYCB8F7E+UCf9llM0s+lhlTU+6Ediz0Z062vH1QrCgQpM0xYJYRWVaNP0IKuMl3bIn/bKQDyKT6ohtpVKS5D9rvx/+CmWbj6NZHVvRnfq2A8F3TBnRabvRhJ18FRIvLAZuHeePnd02ZGN3Pq9YsdHaIDzkMdQirJunBQYnojUuGSdb94+4OTpvmdpyKKlEX7suAwi/TZ8cubDSQ4S3FygebC+osF6vJFdPgQDgy1FCSJU8kZrNI4YY8NfICBc9XkH+qVoJHSt+a16ojf5gvbWnuwyfsyg6N5k3BT0KJRTd1PZVlsBCmayCUmHiOBMk1IeTtg+/NM/c0C0vFFykaPVGP8SY6P1ClS93kmWOytGc7/9vXtcmYZ7jMsf+jf6h7nrV5DG3hZmK5N9jhYs7xoXGFaV+0PSGpckQSMsoz48ZvW5iNcJwRfQgkbbmq+n2tnpOfzvBRkR4SGlOmg3y+DZ25NVNIPvLKV3/BuFI51avz91TWfWVx9lY1Mrjo6DmxskT/nTpGAd1RwZsKpwyjshWbAOzFBJuRBHXqzcA26n0vfEmYOvQqAAJ7gDm36c3ZRF0M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(39850400004)(136003)(376002)(1800799009)(451199024)(186009)(7049001)(52116002)(6486002)(6512007)(6506007)(6666004)(966005)(478600001)(38100700002)(38350700002)(2906002)(2616005)(1076003)(7416002)(316002)(83380400001)(26005)(86362001)(66946007)(66476007)(66556008)(110136005)(41300700001)(8936002)(4326008)(5660300002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fK1skDFDya8V9Hq8JsW25MkkwJ8l2dtLuP0Ynx6Pwgk29i8cexanugtbZZwI?=
 =?us-ascii?Q?O7rntfHdomkS7KoqY6OKWbezFxqhvz5URDSxP1olKEoAwoKwnq/w0AgJj3wd?=
 =?us-ascii?Q?UoJprCEFfMqMTURv0IZ9Oon1/A7Pwv296o8odKIrVsIdyLOLJf+sHre2xBUY?=
 =?us-ascii?Q?vdXvn4zPG/yxSzekcCEQ+SO16y/1TiwwjCBqhTqF1rYoNjo3ZRkr5y4tDSZL?=
 =?us-ascii?Q?+4ZyqsFEImwg0PucbYw6aBPkcU4KblvW+WidrXeKvSGNNL/3bwPb31rmlPMa?=
 =?us-ascii?Q?vDhhqHPjBvZRgZuWaIPiBAajybTv7i31+QpM53ZT9ukXZqanpR5w94Xbmpzs?=
 =?us-ascii?Q?FslbyfuV1OT/6w++X6+aCsG7dTI8Oy8AZxcKjdoS7RVGirLUZxasipmV9Cls?=
 =?us-ascii?Q?nU/cdfyXR4cf5oVmmHo/YyBV492XglXINxB7BWgbdh8dgA58l0jXD8hHik0G?=
 =?us-ascii?Q?Kui99BCmN9S8LLboeUJSXO6HJ9CVZNYYnNm43opLGb0Gmn8Yyn0Ifob1Oh4A?=
 =?us-ascii?Q?+u2WAN3gzmIve0+ZIV+dUtphGT+E/ls7MMc+gKsVf6yqamrxkjKFx5ZWkANf?=
 =?us-ascii?Q?AqMgVRuvfxt2MF9P8A34nlgya+MqJjiHKprkTScIS+UqzU2kHvtpFtfnPb1s?=
 =?us-ascii?Q?rev5kB2EulMC+/zFc+L9oWR8FEZHGfWGFtN7RMaGdmlkCdj9BxPSWoQ8144r?=
 =?us-ascii?Q?X53AFWwQ0GKKCw2VacfOZGlzGY9wbWWbsP4BLmR9CEGB3ptsV6+ORBqQ1plb?=
 =?us-ascii?Q?Zx8TwyM59vDGz0DVlB2wO0YespVi1/oATSg0yeuwjltE+DLHlrydCB2n27an?=
 =?us-ascii?Q?dH4Sw2Rv0RH4/xSt3vbYyuwhjrB1aoshTOGW43RepF2DMpreXSxBMynp1T3I?=
 =?us-ascii?Q?7560QkN6Qfu6qn46bqUUGkDA8f5mptAAMxgXC3vKtGes8SYV4lmYP9+vQ1QR?=
 =?us-ascii?Q?BsoTdWHid/HlHpetwHtSz6LzMRp/oV7XnBJZSIl4tuT9/e46vbFsfSxqoVxL?=
 =?us-ascii?Q?hXdLNgCySabOI7az7rzdII1HXx4DWCoIp9vJKVqfLaoYqCC5GGh2V8FMISkJ?=
 =?us-ascii?Q?UYgHhuJSv33HQrq3jVK4TYhAVWNPk03BWEL/5933YmgU/lCvZUwFfy+auBdT?=
 =?us-ascii?Q?0cPGta3MzCoMMALzF+PXR72nmP1GeekaaBR/QIuYlZ7Brooa7MqMrZKyts8/?=
 =?us-ascii?Q?CcO661+ddcKatUaRCwe5yE2FsXYRM3CYpmXUM/36uzBjDAJjtpFRND1dhe7L?=
 =?us-ascii?Q?Kn0va6rsOiCFoxIRFK8QooOQv1jYvRuPr7aZS6OnsGhk+XkqpPHVaRmrGCrM?=
 =?us-ascii?Q?3fERUP+dBKZet2vCtgWgg3OMmSjNYr8nO32FBs1EN/dn3nbJ2w9wB82gOECM?=
 =?us-ascii?Q?ZMQqmKmrIsdWCBeAwTnE48LJsCq9Z2JgshSSV4UrBciurPVgw6PCHamRwKN6?=
 =?us-ascii?Q?IFGRcNNs37lIhatIPK5aP/n33tJNLZB2EvcpdLdRRlBqWrULqKrH5oWKk32B?=
 =?us-ascii?Q?ehrw8PIqYEK+4qkOV1QXBCVsYBS6zL1x4gUUMIlP697UUvWATXrKJdjIoOo4?=
 =?us-ascii?Q?bk8CtHeJDwQF5j+Tbt1X+rZzmiice0UqQMRfMWPX2sHo9t9N9aFXQIz/yQJM?=
 =?us-ascii?Q?UetbdD9kL191IIiY5dpNbXk=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ce0f04d-3ae0-4ecb-ecfc-08dbb4b2e4db
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 23:41:04.0700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1OOXT+NLBKjwvGbEQ7HFa/rdCHZDD1/pKPdiX8hdgX5WvKpZp++DMmnCdagNjrG74XlnEz8rGEubXdyvPlehtVZWLNdUfm3QsuNeHXYkbpTCIn4LwOvWVEb5+IJ6RWjb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6241
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
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/perf/arm_cspmu/arm_cspmu.c | 12 ++++++++----
 drivers/perf/arm_cspmu/arm_cspmu.h |  3 +++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index 5f4f04135a22..2ecbf8d7714b 100644
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
@@ -454,6 +457,7 @@ static int arm_cspmu_init_impl_ops(struct arm_cspmu *cspmu)
 	CHECK_DEFAULT_IMPL_OPS(impl_ops, event_type);
 	CHECK_DEFAULT_IMPL_OPS(impl_ops, event_filter);
 	CHECK_DEFAULT_IMPL_OPS(impl_ops, event_attr_is_visible);
+	CHECK_DEFAULT_IMPL_OPS(impl_ops, set_ev_filter);
 
 	return 0;
 }
@@ -815,9 +819,9 @@ static inline void arm_cspmu_set_event(struct arm_cspmu *cspmu,
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
 
@@ -849,7 +853,7 @@ static void arm_cspmu_start(struct perf_event *event, int pmu_flags)
 		arm_cspmu_set_cc_filter(cspmu, filter);
 	} else {
 		arm_cspmu_set_event(cspmu, hwc);
-		arm_cspmu_set_ev_filter(cspmu, hwc, filter);
+		cspmu->impl.ops.set_ev_filter(cspmu, hwc, filter);
 	}
 
 	hwc->state = 0;
diff --git a/drivers/perf/arm_cspmu/arm_cspmu.h b/drivers/perf/arm_cspmu/arm_cspmu.h
index 7936a90ded7f..e0cca5b4aab9 100644
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
2.40.1

