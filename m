Return-Path: <linux-kernel+bounces-104224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E241887CAE8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EF4E1C2030F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D694C18651;
	Fri, 15 Mar 2024 09:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="F7mNGyQV"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2053.outbound.protection.outlook.com [40.107.21.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FF318645;
	Fri, 15 Mar 2024 09:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710496562; cv=fail; b=FFiDA159y9KrJ/R3PwMnDhp9XEJ3YOMEXDRQgjwxBjT4/QwCVEVwng+ee8dLe+p/G+dL0Ul+xBl9LMcEq0wu7WMSCDTaawdg+oVJ+fTSI999+BmnAfXudQjNrRq3UCPvsmSPSCwiGMblZTF2A04/Ft8s2vxKUJ8FOtJoCzjvPEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710496562; c=relaxed/simple;
	bh=6zSZ/maewa0RwDr4V6E/CL+v7Swwr//ooZLaF8b9ubY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JKuPYG2WqVAAkmcWJfdoXa1zxj4RyIKdnk9tO63S2QpWPEtgWsoBEdfyDGXH6btzpPLVgxIWmhoGzNnGZFtW48FjaN/a5E5EL+0ys/sx7OnK622AFWGlXzkCvxedI/rC6XR88bJYgyuYPcgPghc6jpsk8N5CVaKJgQ8tNHVcJB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=F7mNGyQV; arc=fail smtp.client-ip=40.107.21.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zv3jiU47P9L/yiTQqybb6tmwMKjbL/rlIodLpXuDGMFKr+eSA/Mp2wUABw2c0fwwwBaftrS1++0VoSUcX1i8hGbDVvG45KGgmKnYrAwM+Squhr67KoZP7tNNZtEmT6PJz9rc3oP2cJvs9hE7y/QEzPEMFrTxHBlLiZyM9ObBBwdb4lpQV0KMhxtUUPLZHGhZYHg5fBDZkGdrg+DoTEv/Cnry7PAKI//KbjFPW23puNqiqt1WBlBB2rmMtd77wT8klB7CRlUWUtLU+jWRnt77j5T0k7YvYJB+ZnUp4HaLr8eE6vENv1h1aSASoTvIT5u99lexTrsx/kQoLHFqmrDTEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ffTZDzbMFHQIg3K3oeKZ2q6kpHrWK2hPLvIiKWHN970=;
 b=d3Tqr50ftQSzLd3yMGvd0xVHhZ+gcXUiWtt/hCrv0fRKjSEMIttct2GOii57H7LqC9YAWx9NHlPcignnjqCGcVohcDc+odtY4OcboPWgRGT20MHN4Lfrhu40lrmvE7K1Oox35aDejMOBF8MCtAwjsBpQGDEaW2h0Bw84GEzRu4hMFFi/4m5wSH6Kzqx/Cy8mEkHMBy789YYZZOjYnFOJ5MnRalTWBwhzekPTqA0PLJkdWf+Z3JHg8IFb96d1sZbuJCMIiif3DGi0jkNVYWHEHCBMlNg1uEGOajvde5wwQHP5cwsOx0iyU6eOSKOTxILfW87s3KBA6Hb5isnWcIVkTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffTZDzbMFHQIg3K3oeKZ2q6kpHrWK2hPLvIiKWHN970=;
 b=F7mNGyQVdmFLEnDRk4Y6CReOwQP7XAbitLDCQyJRo8sJukYnycsTmgZGCzFH/J/ELCBVPfXqr1uV4BTCjZfCca479NLLjAh3U6qOOtH8cmD4oaUlby4Ov0CnsYeUrTHI6wBFWpByyL+KuhJvEUlwfa7ob+AZAsB+mYIkCvCmpUE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AM8PR04MB7444.eurprd04.prod.outlook.com (2603:10a6:20b:1de::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Fri, 15 Mar
 2024 09:55:57 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7386.021; Fri, 15 Mar 2024
 09:55:57 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: Frank.li@nxp.com,
	will@kernel.org,
	mark.rutland@arm.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	john.g.garry@oracle.com,
	jolsa@kernel.org,
	namhyung@kernel.org,
	irogers@google.com
Cc: mike.leach@linaro.org,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	alexander.shishkin@linux.intel.com,
	adrian.hunter@intel.com,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v7 3/8] perf: imx_perf: let the driver manage the counter usage rather the user
Date: Fri, 15 Mar 2024 17:55:50 +0800
Message-Id: <20240315095555.2628684-3-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240315095555.2628684-1-xu.yang_2@nxp.com>
References: <20240315095555.2628684-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:195::6) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AM8PR04MB7444:EE_
X-MS-Office365-Filtering-Correlation-Id: ec50a88d-7398-4416-e670-08dc44d61c3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mkZIq9qoTPYobUMcAQjMD0pSnoSW/zJ7UestCuDgDwoHaSPAoKFwFAYIeKsVLdbBKJJ8BJVT1L5QBqf0pAwBXWJIXfAfGsfr0UbU0NSetZA6z63CokHCTIFY6OeX61h2yvjpZGgTD2yxMoGXrLuGHG3Y8nXehq430E6565NgQxhSAJLvUkKOF40JOPenY1/5rDiNrFGK8/GXQYG2nPdenggY6ZnMf2C9XD4Ip1neFd+4jYYSKIBWCb4fe4kgzO+xLKmwDzcNSBvXcy+CfqB1ZQ9fy7syf1au95XrWORe0aBLoEwdAqwbzoFsyDtRP96PA3y7P5isKaaLtYgnK7q+p0Zx0MYiNheV5R5I7uxe5Nn2YqomjOXEomG5vZN8SIAretuE0mH8tZ7S92/TMFzOxZwL8kg8YgAFXkMu5RPx1js2cYqhMUbBR2WK+gWMMD+JxgUxWYm1HSYrkwwQIfmVbjHuCfdef9o3TEMbThlspp+9qFTIDXZIcovJc3D4FUXwCHzbeZ2WwaiNjOgTtO5lyKJ82sW0G40486Ie7OsDjlB2gVQNeFXi8HwIl3548yw+NDhkMS6TAncT1FkfvXOD+edV5a0S8q1EEzbUfgBDEMsPSGuDoBmfxN/I21AqXFQ42wwDdNzuZfY155jJUiROPJasxG+JzDs6K6kS2ghBKrhRZciHn9Lbu2cBEp+6Ebpr96lo1KAsdOuOOZ2wiLBoj3/kdY7rnPNIWDHxj2ULRNE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005)(52116005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?grLNbizSy5xWR57bf5Ic6O3QzDD5ZjDqp1QpPD7PXfGOOHZveoHpJxgqzyT0?=
 =?us-ascii?Q?In0wCr9ZJqAxYRRxykJtGjv6kxDXEhuNDsQKvbz8iMFwHlAvFmd6R9cEiohu?=
 =?us-ascii?Q?U7zcCsqUe6C4uJpIlw1NFvZbPH/ZWR8dqi/mKXVJgzI9mpGgtFxT1PZVPnvl?=
 =?us-ascii?Q?anRNhClEPrRg4flSie/x+8LsUvv1lCzWue3wMjpW014Ht7eWBFnlsYa8Q0kF?=
 =?us-ascii?Q?lRPv7eDliVQa4UgoMPUROppFPqahKIyWwfIV+Dhml9A6MJQP1na9jgec9fUR?=
 =?us-ascii?Q?R6E9/l7xsL627/9b72XEBhmE5NClizz/BPNdBRJCrtV4AS0p3y1JCCfrVkzE?=
 =?us-ascii?Q?Ywzap93F1d0fh+bGEjIf6zB6YgQFqQCyBXZRMoaUdLE2S28++m6Q2PTrze71?=
 =?us-ascii?Q?/1YgUGvmZgVYbZ/S3IwkMV23/FzvFRvWw9RYe5ERmo3bUQZOLzp3YAlS0fO5?=
 =?us-ascii?Q?4f3Hen6qeRnFV0wTkgWqnbqFbGisxt5C3MCvPAtGwiVqIMEeLvCq9e6Zqg0O?=
 =?us-ascii?Q?d+up0II4TvWpXTQFL7COhRQIAvvF6iZab54FkNmHn1mHblORRGd4ntBc8f91?=
 =?us-ascii?Q?dGS2WtUh4E8mSn3e8qF8yMsq39EtCofIjhqQXJ4kzwfmlv2fKtxrBOMoE3zs?=
 =?us-ascii?Q?8sjFXz7xjfWe9RXCc2Lu7UPOMHsEOAABlZL0tIu70DaBpxZSxzaRl/Eb2RBg?=
 =?us-ascii?Q?XCh0cFL75wky7j2UZ3k9v441U5BmbPGV6xlKQpJhgjG3IrXsKlOQ4DCVhSDl?=
 =?us-ascii?Q?ELVIypZwZnTIY0K3OWAHiXSuyHe7YpOq8KG+6ItBkPue9QkC26ZTN+1kamsK?=
 =?us-ascii?Q?SDyVC886mxfZGKJYhugnGVf1eSq+5hltu5xBM5IVw3Kj6ANa2SNduwT8LDLa?=
 =?us-ascii?Q?edd5EtHhUD9pLQrZ23vFZNek5JC79h63t74Gq9IRawCNM9QVfZZ/xb4Ha6e2?=
 =?us-ascii?Q?zpOfqddQ3YXBJ2h6rtzUdN4xP+m23IGkjP+x77zFbZFozfgBS3Bzj0nDUjiI?=
 =?us-ascii?Q?JdGQjKOQgU+1HOA4T1TYhTkKACTKXBS4BV8qKOfLncejKKBHbzQsy9W77zZd?=
 =?us-ascii?Q?PwbCCPOf4nHW/skT3ZXJ34A3a2XN/VTmexBM42aCa/QdJml0pi8qCohUaQaR?=
 =?us-ascii?Q?0NVbV06RgcnrQGprsouWW4E+25faq7q14yCZCHvcnXlti/PexI3Z6gb1ISDD?=
 =?us-ascii?Q?wkt4Uu0xlrPF+wLyK+zuZ0v9GWqvSKqnWFPzy3Z9tSVYH3vC+Y/7Iytxo9oT?=
 =?us-ascii?Q?1vJaENbqiIJt8+xBmcQ/5xN1nEc51hmCwwdDrezXh8hriBamedCiBfz4N289?=
 =?us-ascii?Q?B67jdmznQJgD8xlrD/HVSQhcdgWcmiz8LR/LQ1DEhX7DH5YBCmvMScz0vYlW?=
 =?us-ascii?Q?oRXB805KOCoFoo6CKFXG2KBVtBFq+MYw6yeYIoo2sMFAhbyW9gJEJKSGsCch?=
 =?us-ascii?Q?sIQtFPHLVovW07EKK+Br0ftMENGI4b5K6PmEHdIbyJI9NQLoKPWddKYIEIxA?=
 =?us-ascii?Q?OnZI2JiJPzU71pPR+G8fUal4UYfMMAj0bvR+SozcPwWN8v97kI6/hn4H3qpv?=
 =?us-ascii?Q?AFm6yadgsTg5hPeM8go6sz3Z60lB8RjPzWI/AsxM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec50a88d-7398-4416-e670-08dc44d61c3f
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 09:55:56.9256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5HAEkAEMxea/ocMyC6BqieYUt+03NepSM4jEZ/OgFKDwEew+71XK4Q416UyesWwNYrMiEt9qGFLu6NaCtCBlHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7444

In current design, the user of perf app needs to input counter ID to count
events. However, this is not user-friendly since the user needs to lookup
the map table to find the counter. Instead of letting the user to input
the counter, let this driver to manage the counters in this patch.

This will be implemented by:
 1. allocate counter 0 for cycle event.
 2. find unused counter from 1-10 for reference events.
 3. allocate specific counter for counter-specific events.

In this patch, counter attribute is removed too. To mark counter-specific
events, counter ID will be encoded into perf_pmu_events_attr.id.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v6:
 - new patch
Changes in v7:
 - no changes
---
 drivers/perf/fsl_imx9_ddr_perf.c | 168 ++++++++++++++++++-------------
 1 file changed, 99 insertions(+), 69 deletions(-)

diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
index 4ec70775d1f0..4fdf8bcf6646 100644
--- a/drivers/perf/fsl_imx9_ddr_perf.c
+++ b/drivers/perf/fsl_imx9_ddr_perf.c
@@ -41,9 +41,11 @@
 
 #define NUM_COUNTERS		11
 #define CYCLES_COUNTER		0
+#define CYCLES_EVENT_ID		0
 
 #define CONFIG_EVENT		GENMASK(7, 0)
 #define CONFIG_COUNTER		GENMASK(15, 8)
+#define CONFIG_COUNTER_OFFSET	8
 
 #define to_ddr_pmu(p)		container_of(p, struct ddr_pmu, pmu)
 
@@ -130,6 +132,8 @@ static ssize_t ddr_pmu_event_show(struct device *dev,
 	return sysfs_emit(page, "event=0x%02llx\n", pmu_attr->id);
 }
 
+#define ID(counter, id) ((counter << CONFIG_COUNTER_OFFSET) | id)
+
 #define IMX9_DDR_PMU_EVENT_ATTR(_name, _id)				\
 	(&((struct perf_pmu_events_attr[]) {				\
 		{ .attr = __ATTR(_name, 0444, ddr_pmu_event_show, NULL),\
@@ -162,81 +166,81 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_pm_29, 63),
 
 	/* counter1 specific events */
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_0, 64),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_1, 65),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_2, 66),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_3, 67),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_4, 68),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_5, 69),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_6, 70),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_7, 71),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_0, ID(1, 64)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_1, ID(1, 65)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_2, ID(1, 66)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_3, ID(1, 67)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_4, ID(1, 68)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_5, ID(1, 69)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_6, ID(1, 70)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_riq_7, ID(1, 71)),
 
 	/* counter2 specific events */
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_0, 64),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_1, 65),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_2, 66),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_3, 67),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_4, 68),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_5, 69),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_6, 70),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_7, 71),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_empty, 72),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_trans_filt, 73),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_0, ID(2, 64)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_1, ID(2, 65)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_2, ID(2, 66)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_3, ID(2, 67)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_4, ID(2, 68)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_5, ID(2, 69)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_6, ID(2, 70)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_7, ID(2, 71)),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_empty, ID(2, 72)),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_trans_filt, ID(2, 73)),
 
 	/* counter3 specific events */
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_0, 64),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_1, 65),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_2, 66),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_3, 67),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_4, 68),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_5, 69),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_6, 70),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_7, 71),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_full, 72),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_trans_filt, 73),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_0, ID(3, 64)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_1, ID(3, 65)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_2, ID(3, 66)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_3, ID(3, 67)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_4, ID(3, 68)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_5, ID(3, 69)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_6, ID(3, 70)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_7, ID(3, 71)),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_full, ID(3, 72)),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_trans_filt, ID(3, 73)),
 
 	/* counter4 specific events */
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_0, 64),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_1, 65),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_2, 66),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_3, 67),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_4, 68),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_5, 69),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_6, 70),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_7, 71),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq2_rmw, 72),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt, 73),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_0, ID(4, 64)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_1, ID(4, 65)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_2, ID(4, 66)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_3, ID(4, 67)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_4, ID(4, 68)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_5, ID(4, 69)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_6, ID(4, 70)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_7, ID(4, 71)),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq2_rmw, ID(4, 72)),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt, ID(4, 73)),
 
 	/* counter5 specific events */
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_0, 64),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_1, 65),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_2, 66),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_3, 67),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_4, 68),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_5, 69),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_6, 70),
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_7, 71),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq1, 72),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_0, ID(5, 64)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_1, ID(5, 65)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_2, ID(5, 66)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_3, ID(5, 67)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_4, ID(5, 68)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_5, ID(5, 69)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_6, ID(5, 70)),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_7, ID(5, 71)),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq1, ID(5, 72)),
 
 	/* counter6 specific events */
-	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_end_0, 64),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq2, 72),
+	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_end_0, ID(6, 64)),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq2, ID(6, 72)),
 
 	/* counter7 specific events */
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_1_2_full, 64),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_wrq0, 65),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_1_2_full, ID(7, 64)),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_wrq0, ID(7, 65)),
 
 	/* counter8 specific events */
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_bias_switched, 64),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_1_4_full, 65),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_bias_switched, ID(8, 64)),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_1_4_full, ID(8, 65)),
 
 	/* counter9 specific events */
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_wrq1, 65),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_3_4_full, 66),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_wrq1, ID(9, 65)),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_3_4_full, ID(9, 66)),
 
 	/* counter10 specific events */
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_misc_mrk, 65),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq0, 66),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_misc_mrk, ID(10, 65)),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq0, ID(10, 66)),
 	NULL,
 };
 
@@ -245,14 +249,12 @@ static const struct attribute_group ddr_perf_events_attr_group = {
 	.attrs = ddr_perf_events_attrs,
 };
 
-PMU_FORMAT_ATTR(event, "config:0-7");
-PMU_FORMAT_ATTR(counter, "config:8-15");
+PMU_FORMAT_ATTR(event, "config:0-15");
 PMU_FORMAT_ATTR(axi_id, "config1:0-17");
 PMU_FORMAT_ATTR(axi_mask, "config2:0-17");
 
 static struct attribute *ddr_perf_format_attrs[] = {
 	&format_attr_event.attr,
-	&format_attr_counter.attr,
 	&format_attr_axi_id.attr,
 	&format_attr_axi_mask.attr,
 	NULL,
@@ -366,13 +368,10 @@ static void ddr_perf_counter_local_config(struct ddr_pmu *pmu, int config,
 	}
 }
 
-static void ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg, int cfg1, int cfg2)
+static void ddr_perf_monitor_config(struct ddr_pmu *pmu, int event,
+				    int counter, int axi_id, int axi_mask)
 {
 	u32 pmcfg1, pmcfg2;
-	int event, counter;
-
-	event = FIELD_GET(CONFIG_EVENT, cfg);
-	counter = FIELD_GET(CONFIG_COUNTER, cfg);
 
 	pmcfg1 = readl_relaxed(pmu->base + PMCFG1);
 
@@ -392,12 +391,12 @@ static void ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg, int cfg1, int
 		pmcfg1 &= ~PMCFG1_RD_BT_FILT_EN;
 
 	pmcfg1 &= ~FIELD_PREP(PMCFG1_ID_MASK, 0x3FFFF);
-	pmcfg1 |= FIELD_PREP(PMCFG1_ID_MASK, cfg2);
+	pmcfg1 |= FIELD_PREP(PMCFG1_ID_MASK, axi_mask);
 	writel(pmcfg1, pmu->base + PMCFG1);
 
 	pmcfg2 = readl_relaxed(pmu->base + PMCFG2);
 	pmcfg2 &= ~FIELD_PREP(PMCFG2_ID, 0x3FFFF);
-	pmcfg2 |= FIELD_PREP(PMCFG2_ID, cfg1);
+	pmcfg2 |= FIELD_PREP(PMCFG2_ID, axi_id);
 	writel(pmcfg2, pmu->base + PMCFG2);
 }
 
@@ -465,6 +464,28 @@ static void ddr_perf_event_start(struct perf_event *event, int flags)
 	hwc->state = 0;
 }
 
+static int ddr_perf_alloc_counter(struct ddr_pmu *pmu, int event, int counter)
+{
+	int i;
+
+	if (event == CYCLES_EVENT_ID) {
+		// Cycles counter is dedicated for cycle event.
+		if (pmu->events[CYCLES_COUNTER] == NULL)
+			return CYCLES_COUNTER;
+	} else if (counter != 0) {
+		// Counter specific event use specific counter.
+		if (pmu->events[counter] == NULL)
+			return counter;
+	} else {
+		// Auto allocate counter for referene event.
+		for (i = 1; i < NUM_COUNTERS; i++)
+			if (pmu->events[i] == NULL)
+				return i;
+	}
+
+	return -ENOENT;
+}
+
 static int ddr_perf_event_add(struct perf_event *event, int flags)
 {
 	struct ddr_pmu *pmu = to_ddr_pmu(event->pmu);
@@ -472,10 +493,17 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
 	int cfg = event->attr.config;
 	int cfg1 = event->attr.config1;
 	int cfg2 = event->attr.config2;
-	int counter;
+	int event_id, counter;
 
+	event_id = FIELD_GET(CONFIG_EVENT, cfg);
 	counter = FIELD_GET(CONFIG_COUNTER, cfg);
 
+	counter = ddr_perf_alloc_counter(pmu, event_id, counter);
+	if (counter < 0) {
+		dev_dbg(pmu->dev, "There are not enough counters\n");
+		return -EOPNOTSUPP;
+	}
+
 	pmu->events[counter] = event;
 	pmu->active_events++;
 	hwc->idx = counter;
@@ -485,7 +513,7 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
 		ddr_perf_event_start(event, flags);
 
 	/* read trans, write trans, read beat */
-	ddr_perf_monitor_config(pmu, cfg, cfg1, cfg2);
+	ddr_perf_monitor_config(pmu, event_id, counter, cfg1, cfg2);
 
 	return 0;
 }
@@ -506,9 +534,11 @@ static void ddr_perf_event_del(struct perf_event *event, int flags)
 {
 	struct ddr_pmu *pmu = to_ddr_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
+	int counter = hwc->idx;
 
 	ddr_perf_event_stop(event, PERF_EF_UPDATE);
 
+	pmu->events[counter] = NULL;
 	pmu->active_events--;
 	hwc->idx = -1;
 }
-- 
2.34.1


