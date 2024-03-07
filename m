Return-Path: <linux-kernel+bounces-95282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1CF874BB2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 183CA1C20F6D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B86884FD3;
	Thu,  7 Mar 2024 09:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fVC+mX3m"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2081.outbound.protection.outlook.com [40.107.104.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AC912A14D;
	Thu,  7 Mar 2024 09:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709805470; cv=fail; b=uKnWJaaOXtHW518gCftlLCuQIoSPL5FHKvrnyIO9YCguXsEkCi0spr/nZIxZtPJWb37LtODa+vL1Y9WRRR9F7d7Ul+fYhKLZC4PyLbmO/1+WWP+GtCGp8y9J6+rd4zn8v4/9Y0+NF+un2qqheEqc6M9YQ1lKZgx3GGxzvUagX+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709805470; c=relaxed/simple;
	bh=ZJMyBQ30Z1VEPdI1egHx4gZmI6MQkz/u4UsGEKgJDEA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EzAMQt/Z2HDsPxzVE6yeR2qRGjYOJvYQVwPkyfxu/iS3BDz7TEiUSZpr7T6OMtMdcgfKR0wIvlmUvHhhfMfZsrQ1mh0fP7tarBpn5M2trgUXiYOENJB8l91Q8TA4+NLSmoeOglRlsi426f+CXaMl+TX7E6wFOJARH2BmDiznty8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=fVC+mX3m; arc=fail smtp.client-ip=40.107.104.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ApgJcrp3KWXAGjtipsEvW7vUaP1mPWW2zr9VYxkewazqBDNbbCgNdqvoE1/ubi3tz9lgA2IqPUbGbzwYIOCBSLNhu1K2YQE/AhqtX7MIl7Cf/LBS70zIpgbYSHadp1dL8OGzZBb9IX/7paHfS3NUnjVSpq2PZWvBZ/2rAXuO+dUuj4v5z6R5fbv0ywKIwiacyMo5hQ8QuVm5bIoyk8IKP6VkYKrqxAjmkMkeX6Km7ldRTqOg95eEZMJL5jVozSWN5vDbHAzzy0uXDtro0osuWjFiR1r7x9N3P3mbm2fQeHkL8t+EC/VG8RU4dWQMPOO+dgd7zz57ph+xFjIS1sZUjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q2aVeCE8HCIRl3T+2BvJ3i58qAnIyEyLLUM5Z0Z84AE=;
 b=VaeNZ+BQabDF8eqqA4tvLVZDDJOxNR5J1Ji1s8/mOvKt0Oo87/EDClySI1AtS8HR1y8m6HuR9Q1R3X5r10GH3SsIg73poRSqbEDy1cbj64yJTTm2XcLKBnIMxVLrYs/AL805OAKo+RuVpxY1R+W/5bXmk3FpbmM7oXYxgJI9JXwRYZ2lRbmfitHy7KhoMny/E/UmdugrCkRmQ1ZGuwmSGm0kikzybAtuzhdTuYd8X+lovdf6eUEeAzwuAV5s/1ThVKDQ4e5bgcktkJMubHVzeU1tpEh6+nalp0//5P8UDab/CvBSIa1ejGo/I0zI1ipDTY/6UdektgRjlS2DJHVPag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2aVeCE8HCIRl3T+2BvJ3i58qAnIyEyLLUM5Z0Z84AE=;
 b=fVC+mX3my1/9ddGYeePvln57/uAcIN6NF8THGW97qyxmfJaoVztMAAsljquFGn3+zQZOVompIIzZ6bv88AbNuQdoJkE1w1C+gcliAWlcvwpVGOTvLXx6Lh3QRYW9YLEazsUv+GHrfh5Kc6X0K1/gtKVBl2mW6F/CyRAgwvnZUa4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DU2PR04MB8504.eurprd04.prod.outlook.com (2603:10a6:10:2d3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Thu, 7 Mar
 2024 09:57:45 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7339.035; Thu, 7 Mar 2024
 09:57:45 +0000
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
Subject: [PATCH v6 4/7] perf: imx_perf: refactor driver for imx93
Date: Thu,  7 Mar 2024 17:57:27 +0800
Message-Id: <20240307095730.3792680-4-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240307095730.3792680-1-xu.yang_2@nxp.com>
References: <20240307095730.3792680-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0212.apcprd06.prod.outlook.com
 (2603:1096:4:68::20) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|DU2PR04MB8504:EE_
X-MS-Office365-Filtering-Correlation-Id: fcb989cd-d345-4614-5c0e-08dc3e8d0993
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mj5tce7/kxkMER286AIKQbIbQDu5pChbSiO5Gft1fJ0t7nAC4h913Eq2YoPSMCwaqN41PUe1rnBwWMSTXEqMsSXqa4jf+4XhP23AFhGdiWyWlwPwq9h9MDv3GaZuCp5L71yKFC2z1B74VIhVDrZeZ8GaVUm/Zbw76wnwI/oJ7p2Q14orL6460096M0+Mr87c6gJbar9bDaQQbWO0gB9I3Gd33dNQx4JEXdLvzTsQ+CqX34s2x7HeinGXWaTuWrxniIc4O3RdAaaxhRWlWhzqfhuHLR/kHB6Gq84Z9Y8oCT4zHXrexu6+dooCqBDewkcurkFRJT/V8HP7XEozHiz3RYuoT1KW+yigGx+p3wJmGTW7tGRAUnvpG3FiLBl1rsxuRVXLNQ+J/C6krSSgKFtfCFZ0oI3Oj085Ld1LqxJImSRawIKy7CuV/+kVRR29B8hcUUNhIs6v5+Tc6SIJtM0aEd6rZMBredvfcTNf4P+dxlSAFRIGqwJbVI6QutqnZnO/PkXjN1KlCfXGFz7A2d4U6/T2ZA30yVzAO9iLs34AnT2CGE2EjnFOVxp9Pj8PtH1rXPosdL7L5ayyGuL2JZ7o2Oc5wuBE2mHJzdCuYZioYvfykJLM7dgnaxepaDq4w8C6TUClc9yPwKH1HBoETCLpbKpKHc5Jv8ynHxQQ8f/0BvmMEEpnAIi5TA6BjP7S4YY8FBVrhrbxIeQIP4JFJfZ5aa4X27uvmy6hWFFhqtLuLqA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QTEtxcpYs5CaGBkWmDBTmtrxFRBY2SJcrUREp3I4EkRRyfkQn3E8Q69j0mT/?=
 =?us-ascii?Q?bAtnVWjgNE+gLB8hayyISGGFFmrQLqfKjoTP/kKfcmFmi1PSqb5A4BnG5EII?=
 =?us-ascii?Q?rXBn2SkSqFpwFoPIGxjj23eaBpqP9qNVhiklOS5FBgGUreZVReDYk8fBhEi9?=
 =?us-ascii?Q?XPrqxLiPziIMZUKzZfKpqRJOYNCGAPRLKhKq/3lx9UcDpPdTWQcn70VIBlul?=
 =?us-ascii?Q?bdJ1riVsD9dXSvPGlKKwWNxp98usUwlPjL4JsDGS38JCAerFsc+ZfeUcgbeV?=
 =?us-ascii?Q?XSgBtBLOUmEB3RYjWmwSzyODfmFMbATk5HO3N63S8erwiue1Xz1m3zSCWGrw?=
 =?us-ascii?Q?54TG3I0530Ha5DCnhPxGQ+hRw89cT7MIpadEAHzWnEfsejYBMjBMx4SOS+F8?=
 =?us-ascii?Q?TI4tmshEsquaiVIy8i5IUPOU7xDRfeQP1bD1DSno5Kc68YL+bKpnIiBavAZw?=
 =?us-ascii?Q?Lmx08Ye3/mJvl2C/F8RMORVgwmTswAW6uTq4/p0KeVDovuYBCep+oZL7r3fb?=
 =?us-ascii?Q?NzNGd6U7HBNMHErhahsrlQ+D9fQskzCYSX0nbDyk1mNjuhvcg+6qZZaoZ8AH?=
 =?us-ascii?Q?VS3tPQD20mbd1LnQfQhXOnMlcbHsy95DPNSCGT0DFLKexZYqiUHnIJrPfyCg?=
 =?us-ascii?Q?Z1WCvUI7+XETNPn3xcrTJCf7vfRIVcBDOATu136ZUjdTBFVLtKS1rzWWABz0?=
 =?us-ascii?Q?G3ZNHxoc4j+SzQ5ctfRNOIz16cmdEd6GM3+PfmKWiY2r6Q7TNa6e7bC6fhgR?=
 =?us-ascii?Q?b1eRckzQBtKvbi65/hHoUjFk7pE2HGA9M42oeEVXHGPgH2dZlN65l/r/Z/mS?=
 =?us-ascii?Q?vr4EjnwYdFjlKbREJJI3Z+PvpvNYFhe/IfhqDt/gvGmnf2KVHhXnWqrxOVtr?=
 =?us-ascii?Q?szPFx5KI8qYAtefaYm66ax5T5jyjO3tuux6CQ4gQHFbLlPm7bB/7ewytr0i7?=
 =?us-ascii?Q?699n+XIlCs64jsgzTD5u4pONSrFCiXmxvIdvOn7cEy7B7I/KMm95FiPTcTM6?=
 =?us-ascii?Q?6B5ZK/Q3lcqAUTmjxI3FHnfCGpd5RkMRcgVI9PInMwtRhrIVHRCJX+MwNdLh?=
 =?us-ascii?Q?Fp1GkBgS1SnIeU3e4RHrXzsfxNqTWVUcje1ASEG7lrAfSyPpwaUAQ2o7QNZl?=
 =?us-ascii?Q?SmMtQ9fu+KZl5NnScMbEtrKv0JYhLg174KVPD3DYRRKafkq3bj+/DTep7uEA?=
 =?us-ascii?Q?pGQt8c1bbO5tBw0C9IaNfOt5JB/FDmNyam6lCALp3m7CimgrhIStzJk2+gob?=
 =?us-ascii?Q?iEIRvUi7AyNok5tz4aPnUaiu0gdzyT1Gr3tw2yAUkIKy//8SQ3A3N78g8ym9?=
 =?us-ascii?Q?afM7FNETJk6hz/MDj/IZWjQlH112j0HvzXa13L7JmcAKr5llTwGn3dl0AUev?=
 =?us-ascii?Q?13phnBlQ+3xE7vtbJz3g/mscQB9wgZ7w8FzMxObvz/X9/5HAzIt5HPM5addD?=
 =?us-ascii?Q?IEPSMN9aZR8JsYRXEdvALGH/V4Qw6mdYQ+FUivLeVqLsgoqwIh4p03czbZ9b?=
 =?us-ascii?Q?zosHc9EEooCOfNaWM92tBSwuCVjVoH8ZZLOvF3kKDIrAXiKojr71HQ++C3PM?=
 =?us-ascii?Q?SDueVV0H7GYabcY/d7R3/NNlvUB3SaUB1Tjb+8Ni?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb989cd-d345-4614-5c0e-08dc3e8d0993
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 09:57:45.3517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tb3aWXArgbZQj0V/VV9f+kr4GIRgy41X8f82afIn4eS3uJGXxjHQDSBHvjZGJxF/wocOoBjBnP7Pi9pIejsm8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8504

This driver is initinally used to support imx93 Soc and now it's time to
add support for imx95 Soc. However, some macro definitions and events are
different on these two Socs. For preparing imx95 supports, this will
refactor driver for imx93.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v4:
 - new patch
Changes in v5:
 - use is_visible to hide unwanted attributes as suggested by Will
Changes in v6:
 - improve imx93_ddr_perf_monitor_config()
---
 drivers/perf/fsl_imx9_ddr_perf.c | 99 +++++++++++++++++++++-----------
 1 file changed, 66 insertions(+), 33 deletions(-)

diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
index 8d85b4d98544..4e8a3a4349c5 100644
--- a/drivers/perf/fsl_imx9_ddr_perf.c
+++ b/drivers/perf/fsl_imx9_ddr_perf.c
@@ -11,14 +11,14 @@
 #include <linux/perf_event.h>
 
 /* Performance monitor configuration */
-#define PMCFG1  			0x00
-#define PMCFG1_RD_TRANS_FILT_EN 	BIT(31)
-#define PMCFG1_WR_TRANS_FILT_EN 	BIT(30)
-#define PMCFG1_RD_BT_FILT_EN 		BIT(29)
-#define PMCFG1_ID_MASK  		GENMASK(17, 0)
+#define PMCFG1				0x00
+#define MX93_PMCFG1_RD_TRANS_FILT_EN	BIT(31)
+#define MX93_PMCFG1_WR_TRANS_FILT_EN	BIT(30)
+#define MX93_PMCFG1_RD_BT_FILT_EN	BIT(29)
+#define MX93_PMCFG1_ID_MASK		GENMASK(17, 0)
 
-#define PMCFG2  			0x04
-#define PMCFG2_ID			GENMASK(17, 0)
+#define PMCFG2				0x04
+#define MX93_PMCFG2_ID			GENMASK(17, 0)
 
 /* Global control register affects all counters and takes priority over local control registers */
 #define PMGC0		0x40
@@ -77,6 +77,11 @@ static const struct imx_ddr_devtype_data imx93_devtype_data = {
 	.identifier = "imx93",
 };
 
+static inline bool is_imx93(struct ddr_pmu *pmu)
+{
+	return pmu->devtype_data == &imx93_devtype_data;
+}
+
 static const struct of_device_id imx_ddr_pmu_dt_ids[] = {
 	{.compatible = "fsl,imx93-ddr-pmu", .data = &imx93_devtype_data},
 	{ /* sentinel */ }
@@ -186,7 +191,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_6, ID(2, 70)),
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_7, ID(2, 71)),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_empty, ID(2, 72)),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_trans_filt, ID(2, 73)),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_trans_filt, ID(2, 73)),	/* imx93 specific*/
 
 	/* counter3 specific events */
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_0, ID(3, 64)),
@@ -198,7 +203,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_6, ID(3, 70)),
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_7, ID(3, 71)),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_full, ID(3, 72)),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_trans_filt, ID(3, 73)),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_trans_filt, ID(3, 73)),	/* imx93 specific*/
 
 	/* counter4 specific events */
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_0, ID(4, 64)),
@@ -210,7 +215,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_6, ID(4, 70)),
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_7, ID(4, 71)),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq2_rmw, ID(4, 72)),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt, ID(4, 73)),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt, ID(4, 73)),	/* imx93 specific*/
 
 	/* counter5 specific events */
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_0, ID(5, 64)),
@@ -245,9 +250,26 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	NULL,
 };
 
+static umode_t
+ddr_perf_events_attrs_is_visible(struct kobject *kobj,
+				       struct attribute *attr, int unused)
+{
+	struct pmu *pmu = dev_get_drvdata(kobj_to_dev(kobj));
+	struct ddr_pmu *ddr_pmu = to_ddr_pmu(pmu);
+
+	if ((!strcmp(attr->name, "eddrtq_pm_rd_trans_filt") ||
+		!strcmp(attr->name, "eddrtq_pm_wr_trans_filt") ||
+		!strcmp(attr->name, "eddrtq_pm_rd_beat_filt")) &&
+		!is_imx93(ddr_pmu))
+		return 0;
+
+	return attr->mode;
+}
+
 static const struct attribute_group ddr_perf_events_attr_group = {
 	.name = "events",
 	.attrs = ddr_perf_events_attrs,
+	.is_visible = ddr_perf_events_attrs_is_visible,
 };
 
 PMU_FORMAT_ATTR(event, "config:0-15");
@@ -369,36 +391,47 @@ static void ddr_perf_counter_local_config(struct ddr_pmu *pmu, int config,
 	}
 }
 
-static void ddr_perf_monitor_config(struct ddr_pmu *pmu, int event,
-				    int counter, int axi_id, int axi_mask)
+static void imx93_ddr_perf_monitor_config(struct ddr_pmu *pmu, int event,
+					  int counter, int axi_id, int axi_mask)
 {
 	u32 pmcfg1, pmcfg2;
 
 	pmcfg1 = readl_relaxed(pmu->base + PMCFG1);
 
-	if (counter == 2 && event == 73)
-		pmcfg1 |= PMCFG1_RD_TRANS_FILT_EN;
-	else if (counter == 2 && event != 73)
-		pmcfg1 &= ~PMCFG1_RD_TRANS_FILT_EN;
-
-	if (counter == 3 && event == 73)
-		pmcfg1 |= PMCFG1_WR_TRANS_FILT_EN;
-	else if (counter == 3 && event != 73)
-		pmcfg1 &= ~PMCFG1_WR_TRANS_FILT_EN;
-
-	if (counter == 4 && event == 73)
-		pmcfg1 |= PMCFG1_RD_BT_FILT_EN;
-	else if (counter == 4 && event != 73)
-		pmcfg1 &= ~PMCFG1_RD_BT_FILT_EN;
+	if (event == 73) {
+		switch (counter) {
+		case 2:
+			pmcfg1 |= MX93_PMCFG1_RD_TRANS_FILT_EN;
+			break;
+		case 3:
+			pmcfg1 |= MX93_PMCFG1_WR_TRANS_FILT_EN;
+			break;
+		case 4:
+			pmcfg1 |= MX93_PMCFG1_RD_BT_FILT_EN;
+			break;
+		}
+	} else {
+		switch (counter) {
+		case 2:
+			pmcfg1 &= ~MX93_PMCFG1_RD_TRANS_FILT_EN;
+			break;
+		case 3:
+			pmcfg1 &= ~MX93_PMCFG1_WR_TRANS_FILT_EN;
+			break;
+		case 4:
+			pmcfg1 &= ~MX93_PMCFG1_RD_BT_FILT_EN;
+			break;
+		}
+	}
 
-	pmcfg1 &= ~FIELD_PREP(PMCFG1_ID_MASK, 0x3FFFF);
-	pmcfg1 |= FIELD_PREP(PMCFG1_ID_MASK, axi_mask);
-	writel(pmcfg1, pmu->base + PMCFG1);
+	pmcfg1 &= ~FIELD_PREP(MX93_PMCFG1_ID_MASK, 0x3FFFF);
+	pmcfg1 |= FIELD_PREP(MX93_PMCFG1_ID_MASK, axi_mask);
+	writel_relaxed(pmcfg1, pmu->base + PMCFG1);
 
 	pmcfg2 = readl_relaxed(pmu->base + PMCFG2);
-	pmcfg2 &= ~FIELD_PREP(PMCFG2_ID, 0x3FFFF);
-	pmcfg2 |= FIELD_PREP(PMCFG2_ID, axi_id);
-	writel(pmcfg2, pmu->base + PMCFG2);
+	pmcfg2 &= ~FIELD_PREP(MX93_PMCFG2_ID, 0x3FFFF);
+	pmcfg2 |= FIELD_PREP(MX93_PMCFG2_ID, axi_id);
+	writel_relaxed(pmcfg2, pmu->base + PMCFG2);
 }
 
 static void ddr_perf_event_update(struct perf_event *event)
@@ -514,7 +547,7 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
 		ddr_perf_event_start(event, flags);
 
 	/* read trans, write trans, read beat */
-	ddr_perf_monitor_config(pmu, event_id, counter, cfg1, cfg2);
+	imx93_ddr_perf_monitor_config(pmu, event_id, counter, cfg1, cfg2);
 
 	return 0;
 }
-- 
2.34.1


