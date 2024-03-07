Return-Path: <linux-kernel+bounces-94887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA75874656
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 611A7283A32
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5162F1BC31;
	Thu,  7 Mar 2024 02:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oAIrfNTm"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2067.outbound.protection.outlook.com [40.107.22.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3321BC3E;
	Thu,  7 Mar 2024 02:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709779713; cv=fail; b=KPMKLkQ5/zSRiJzebeUlk9+ucFQAv4PTNH1g0eT8Grqkh3D/eTRdayIZEavfKSJgS8jvlBma1F7aIEQobgUonjqOGa3Ab8oxH6ZL+SUjWtf2o36w1nqiEziFjfvXw1fi+uAVnT7e55BZnZrjY9261YxmLDphoZEQUyuxiLok5Ug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709779713; c=relaxed/simple;
	bh=iDV3y/glH7dC+JhGKc7P8BpueSQgEPcxQLdT2uA/e3M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h0WZxI68Ksa5NCz3ZYQnZNIXPrOdHrBYuQ0Pvwu0In90diqfnvH9MHEw3JPwGjQvGj0xh7C7A4NHUqh5f08qGrf0J8URZ+0Lneks0aI17KkSP97VOWcb17PrI3/+q8XvPV7+cm7H2wc33Bnc/NF67jvyyuctd9spCFs18Q4npP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=oAIrfNTm; arc=fail smtp.client-ip=40.107.22.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gw5ZPn6xFm7/TvYgiqK8jCKZ/6VMo0RYdNWb1gpyrZoF8h+AFrcqIPpmjgD6mC+meSQ3hbJ5acspp6YnUw7eK5quAMaehIABma6X8RzsbgItRN/ZLa/ZtCTKWwxRYMc0yWvlm92XucXre+1V8CgA7hVxodmTKMDBnGxGwcKz39YuCqomfkEWgjLT8PytEPmmGM11A7SSX83ffZTLUuxQnxCeIZK4qbxfnfUYRYIOFGQQEzWsyPVvIGmg23kWP2U+DSSaL+MsNnKuI6daUbaY9EI5TLWceN0W/zFXnMBm3yddMQTwoA38ssgx9I7fhEH3wm2Gx5jD7bZHcgFS1b5b5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vby4bES25ZKfNpHmOX6CnqgorAfp6JG7dUM0VFPZ82Y=;
 b=At5J4+bDeB1IIa9or5gF3lc1xgMLQi2wb3U7V6heuBMm59nfJFc1YGX5FOn978lDaAHQNkCXolURTNXtOaTZ8guzTdPDK+u7/WrEtyM/Fe7+Xlf6pAu/FD+rAOj07Xsmp8hiWjhkGQnK8YaUsImm2GYOC5dFojnGZFa2KeUQelgM5+1sBB5hoFgSPIoneDGAecWHaiLZ9EBjZqBwqEaGz38JssF9JHGZ5iYY19uTzIL+naE+L7DoFemncam2kpoMh+J7/5cYw/j68GGGatikMinVonHBW5asGmNSuIrdNlWzUDZU5HrI37XCBSNKLFrqr9vBu+LmgZ7byB58Eh4v2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vby4bES25ZKfNpHmOX6CnqgorAfp6JG7dUM0VFPZ82Y=;
 b=oAIrfNTmkcTdH7Qh78THywkFqVOHB9bcBnKre/7SgOLv9WHZJ3P2x+F7IifxjgscK6qzHGNRUEm6e378A8Ap9H+UEubZr8CW2mGj0+nY9hGfhD8Bdo6iLiCSrugiKZWU/8RZ4Ojk1EfrlxObXTuDCmt6Sd07cJBCFxGmrFncvV8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS8PR04MB8022.eurprd04.prod.outlook.com (2603:10a6:20b:28a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Thu, 7 Mar
 2024 02:48:28 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7339.035; Thu, 7 Mar 2024
 02:48:28 +0000
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
Subject: [PATCH v5 5/7] perf: imx_perf: add support for i.MX95 platform
Date: Thu,  7 Mar 2024 10:47:52 +0800
Message-Id: <20240307024754.3469810-5-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240307024754.3469810-1-xu.yang_2@nxp.com>
References: <20240307024754.3469810-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:196::8) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AS8PR04MB8022:EE_
X-MS-Office365-Filtering-Correlation-Id: efcfd9fe-882d-4e83-097b-08dc3e51116b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Yq6LB1HWztYUQkt1TwRMYSODMkFA6I6omvtJdX+tzQHgHuPPdVcV0tu0ENTWw187cbFwmhPUBS9AwRgEIVfzzUUsoffrHM3Ficzv/wWyaaEddoIAH8s4fOZ8MZuLJxn/1K9sorNhokx8fW52+S2JH7jW1yjMi2zfM8kM5iSno3+nz5IPHBX6uCMyqL35m5bVn3IPsUXgtD7gJXQ61W74VXIIZUTPjn2wIwjFfPpo3mXKW3+ndf7QgfNW6+Uh4Sob58N0+uMIIflp1vQGBxWSfE0YFY3H6y9n6tm7kQj87sHzybOsTvbZA/4RZLYl7uguNre3V4ZBjOkMTjYmj8GKUN9RsTjyhC9frCJbE5UBWdmH7jxIbd3kyv7KtI/A70O+2cOr4ZUQ7AGHqgwH6rxIkf3RjfODtCiKg1junU7IxJF5nqyoeaNVBFSWUNn204k3KbB3Lq+EPA59mHRwtgDGdPxNDAq8+SfhSJwmqfQ/lh+5DjVChFfcpH8lpwdB/9tGVMNZXZ7JBtheaDScgloO5K+0tjmqhPOLDDnc0deoazpQH+Y/ZxL82GmbyJaSvP4O+zr3qsVBOBTgyzJEOm1tq/tbb7jci7u5SDX8qk5WlfLQMKCTrzK+VETPoox0+2LyhWSVDedQJJHkNWXwCm95t91E7hbGZpgTDqffiK0ODpC6b+w9vSRI2mLr78m9i7fxcfNZj5O8QiyMHcbZRad05I+DedZVGOmXa0X4L1FGHwk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uyKC4Zg2yP6ZmDQBP0udh2AWzqKWenN4KPWooVxMeYmOxziRYxMlOFwflcZP?=
 =?us-ascii?Q?1JcOEFDPOsVudh1lkhKGslEOHRwi88yHbr6h3CQeg3vk7NpDaSJUikwvaUxf?=
 =?us-ascii?Q?ceMohOJW3f0o1tHY3JHK3WeUpU/q6dUGr8r9IeXtjn8zjIa5wKrzZeMMxfUu?=
 =?us-ascii?Q?EicPmXcni0VgTSfB0K9hVPmf/d99SRietIJ6HtOsrUHDw0tAVB664VW64zJk?=
 =?us-ascii?Q?/aXzx0F23RIv3b2W8MfcAPYPhMd1Aj/E+TYAjxLMpQOsmUslxdcG4loxQvxV?=
 =?us-ascii?Q?Crdp/xOnFAwwPoHZGU52nSzoo9igUk5uWqjXO+theeLb/cetaJUT0Y+xqecb?=
 =?us-ascii?Q?hV7CRzMpz2hB3hwHo6LOE3MbgNLubXBR7Lz5tXOKBNyPHanOPx3QjzOpJPSV?=
 =?us-ascii?Q?8EtFkbYGm9o6yGoiZSHu9NsiaSUmVj3K3CnfmrFl0nsPznjPfO5PApjdE+Gs?=
 =?us-ascii?Q?bFwZ+eVUDtigXlXV90QSAxgcF8tMOJQyCJLfPMeNWvzDUOrya8uk+ZfRC9O5?=
 =?us-ascii?Q?Ce9WiRWju7CQHfen8DEVciaHjW//TdILdf3Ln8YmkvrvVKSzHODrKbc0BPW+?=
 =?us-ascii?Q?sUYD1u3p8hqBhQuT+i+l77ELzVbjWr7zXOEKD7lPJ+YpdzZTC4CIJPwsH1uC?=
 =?us-ascii?Q?GnIXOaoBoKy1jUKONBH6+rdd727GFn9Th81A+oefTLw9nk6M6sSvy7onhX8N?=
 =?us-ascii?Q?KX936e3RPyzIElUTDeQLSo/fZP4nO2LHNjhID8dmh3gDAi72Y3dLBwjBjahD?=
 =?us-ascii?Q?TgG4whQWucMCrz1Rrq/gDr2yE77Rc6+b0kIxZt7DpixSLaZLzJo0Xp1yajN8?=
 =?us-ascii?Q?2q1NEqS+LnpcMFZjeblQiSVSwlHvFc92GJy+nQDd5ibGDSB4FyknVquDP3Mg?=
 =?us-ascii?Q?+KOms8Hsbej8UMQI8ikdt3CYxe5v2J2uUr9UPRLWEgVEnJu14CfJFh5Wn66A?=
 =?us-ascii?Q?KwG5k5l0P+ju6xcL5RxF+3OpZPBcxFm2dA/K0LYhohOmr/lv+Siw11B1kdfC?=
 =?us-ascii?Q?nT1pkMjOXfPndy9q4cy289B547X80z72bjubfIVukCQKTeD1AhsAtoAalDi2?=
 =?us-ascii?Q?6HiZCEMkrs5P8E00Hgd8OBPVzhUl4WklV74iHK4bmDTQXq9Yt/3YmWajJPfN?=
 =?us-ascii?Q?Y5wJjC9hQTJeznczNE7Cw5DGEXzVhg5rLd3siZR3GiuUWfGxprdK6tFDJgoa?=
 =?us-ascii?Q?UcLbiY1oabLqtFd7J24TRrjalKjCPeo7mjhJiE7adZ39af6xAVXtiMbLgVLV?=
 =?us-ascii?Q?0iDjeOY5dZJaij2Cfv3CEyaj7rHST6QD6Lyc9r652KF+YbotD0wFlDUDxLg/?=
 =?us-ascii?Q?3sQ0Y0ecsratq1d4q7CQwVlVr9nL1GVveR7GHvjXg4hyUBKUp7h/peFji+OJ?=
 =?us-ascii?Q?wjf/SB5Xkmb8oWMBw2WaMxzzbPcAUs7sZlk+sflLNQM0Md7UFNtCuGutKZqk?=
 =?us-ascii?Q?pz85aiWSf9FDQJxib2PZbiG1BIBbLyaz+Bef3edv7b8RRgGujyad/rSGrQoz?=
 =?us-ascii?Q?xnzuL3G2dAbLfG0VAMkmmPJp9ed4m+IEDe5IcEm6IK6D+cVFh6UO+QcTvHfH?=
 =?us-ascii?Q?In0QouWpIvN0Qelk2cPZhN4Uzx4oSVJLP/yHZ6I+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efcfd9fe-882d-4e83-097b-08dc3e51116b
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 02:48:28.7032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WyfVU+3WBW7KOCXan+CpqNM1VQrFReZR705XRn0Q28mKssVUVN3JZOL6vGorr7ryqxdkf39EvFmi5Ff/2vdALA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8022

i.MX95 has a DDR PMU which is almostly same as i.MX93, it now supports
read beat and write beat filter capabilities. This will add support for
i.MX95 and enhance the driver to support specific filter handling for it.

Usage:

For read beat:
~# perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_beat_filt2,counter=3,axi_mask=ID_MASK,axi_id=ID/
~# perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_beat_filt1,counter=4,axi_mask=ID_MASK,axi_id=ID/
~# perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_beat_filt0,counter=5,axi_mask=ID_MASK,axi_id=ID/
eg: For edma2: perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_beat_filt0,counter=5,axi_mask=0x00f,axi_id=0x00c/

For write beat:
~# perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_wr_beat_filt,counter=2,axi_mask=ID_MASK,axi_id=ID/
eg: For edma2: perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_wr_beat_filt,counter=2,axi_mask=0x00f,axi_id=0x00c/

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v2:
 - put soc spefific axi filter events to drvdata according
   to franks suggestions.
 - adjust pmcfg axi_id and axi_mask config
Changes in v3:
 - no changes
Changes in v4:
 - only contain imx95 parts
Changes in v5:
 - improve imx95_ddr_perf_monitor_config()
 - use write_relaxed to pair read_relaxed
---
 drivers/perf/fsl_imx9_ddr_perf.c | 96 +++++++++++++++++++++++++++++++-
 1 file changed, 93 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
index 35e422083948..f25f55126004 100644
--- a/drivers/perf/fsl_imx9_ddr_perf.c
+++ b/drivers/perf/fsl_imx9_ddr_perf.c
@@ -17,9 +17,19 @@
 #define MX93_PMCFG1_RD_BT_FILT_EN	BIT(29)
 #define MX93_PMCFG1_ID_MASK		GENMASK(17, 0)
 
+#define MX95_PMCFG1_WR_BEAT_FILT_EN	BIT(31)
+#define MX95_PMCFG1_RD_BEAT_FILT_EN	BIT(30)
+
 #define PMCFG2				0x04
 #define MX93_PMCFG2_ID			GENMASK(17, 0)
 
+#define PMCFG3				0x08
+#define PMCFG4				0x0C
+#define PMCFG5				0x10
+#define PMCFG6				0x14
+#define MX95_PMCFG_ID_MASK		GENMASK(9, 0)
+#define MX95_PMCFG_ID			GENMASK(25, 16)
+
 /* Global control register affects all counters and takes priority over local control registers */
 #define PMGC0		0x40
 /* Global control register bits */
@@ -76,13 +86,23 @@ static const struct imx_ddr_devtype_data imx93_devtype_data = {
 	.identifier = "imx93",
 };
 
+static const struct imx_ddr_devtype_data imx95_devtype_data = {
+	.identifier = "imx95",
+};
+
 static inline bool is_imx93(struct ddr_pmu *pmu)
 {
 	return pmu->devtype_data == &imx93_devtype_data;
 }
 
+static inline bool is_imx95(struct ddr_pmu *pmu)
+{
+	return pmu->devtype_data == &imx95_devtype_data;
+}
+
 static const struct of_device_id imx_ddr_pmu_dt_ids[] = {
-	{.compatible = "fsl,imx93-ddr-pmu", .data = &imx93_devtype_data},
+	{ .compatible = "fsl,imx93-ddr-pmu", .data = &imx93_devtype_data },
+	{ .compatible = "fsl,imx95-ddr-pmu", .data = &imx95_devtype_data },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, imx_ddr_pmu_dt_ids);
@@ -189,6 +209,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_7, 71),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_empty, 72),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_trans_filt, 73),	/* imx93 specific*/
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_beat_filt, 73),	/* imx95 specific*/
 
 	/* counter3 specific events */
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_0, 64),
@@ -201,6 +222,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_7, 71),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_full, 72),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_trans_filt, 73),	/* imx93 specific*/
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt2, 73),	/* imx95 specific*/
 
 	/* counter4 specific events */
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_0, 64),
@@ -213,6 +235,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_7, 71),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq2_rmw, 72),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt, 73),	/* imx93 specific*/
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt1, 73),	/* imx95 specific*/
 
 	/* counter5 specific events */
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_0, 64),
@@ -224,6 +247,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_6, 70),
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_7, 71),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq1, 72),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt0, 73),	/* imx95 specific*/
 
 	/* counter6 specific events */
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_end_0, 64),
@@ -260,6 +284,13 @@ ddr_perf_events_attrs_is_visible(struct kobject *kobj,
 		!is_imx93(ddr_pmu))
 		return 0;
 
+	if ((!strcmp(attr->name, "eddrtq_pm_wr_beat_filt") ||
+		!strcmp(attr->name, "eddrtq_pm_rd_beat_filt2") ||
+		!strcmp(attr->name, "eddrtq_pm_rd_beat_filt1") ||
+		!strcmp(attr->name, "eddrtq_pm_rd_beat_filt0")) &&
+		!is_imx95(ddr_pmu))
+		return 0;
+
 	return attr->mode;
 }
 
@@ -425,6 +456,60 @@ static void imx93_ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg, int cfg1
 	writel(pmcfg2, pmu->base + PMCFG2);
 }
 
+static void imx95_ddr_perf_monitor_config(struct ddr_pmu *pmu, int cfg, int cfg1, int cfg2)
+{
+	u32 pmcfg1, pmcfg, offset = 0;
+	int event, counter;
+
+	event = (cfg & CONFIG_EVENT_MASK) >> CONFIG_EVENT_OFFSET;
+	counter = (cfg & CONFIG_COUNTER_MASK) >> CONFIG_COUNTER_OFFSET;
+
+	pmcfg1 = readl_relaxed(pmu->base + PMCFG1);
+
+	if (event == 73) {
+		switch (counter) {
+		case 2:
+			pmcfg1 |= MX95_PMCFG1_WR_BEAT_FILT_EN;
+			offset = PMCFG3;
+			break;
+		case 3:
+			pmcfg1 |= MX95_PMCFG1_RD_BEAT_FILT_EN;
+			offset = PMCFG4;
+			break;
+		case 4:
+			pmcfg1 |= MX95_PMCFG1_RD_BEAT_FILT_EN;
+			offset = PMCFG5;
+			break;
+		case 5:
+			pmcfg1 |= MX95_PMCFG1_RD_BEAT_FILT_EN;
+			offset = PMCFG6;
+			break;
+		}
+	} else {
+		switch (counter) {
+		case 2:
+			pmcfg1 &= ~MX95_PMCFG1_WR_BEAT_FILT_EN;
+			break;
+		case 3:
+		case 4:
+		case 5:
+			pmcfg1 &= ~MX95_PMCFG1_RD_BEAT_FILT_EN;
+			break;
+		}
+	}
+
+	writel_relaxed(pmcfg1, pmu->base + PMCFG1);
+
+	if (offset) {
+		pmcfg = readl_relaxed(pmu->base + offset);
+		pmcfg &= ~(FIELD_PREP(MX95_PMCFG_ID_MASK, 0x3FF) |
+			   FIELD_PREP(MX95_PMCFG_ID, 0x3FF));
+		pmcfg |= (FIELD_PREP(MX95_PMCFG_ID_MASK, cfg2) |
+			  FIELD_PREP(MX95_PMCFG_ID, cfg1));
+		writel_relaxed(pmcfg, pmu->base + offset);
+	}
+}
+
 static void ddr_perf_event_update(struct perf_event *event)
 {
 	struct ddr_pmu *pmu = to_ddr_pmu(event->pmu);
@@ -505,8 +590,13 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
 	hwc->idx = counter;
 	hwc->state |= PERF_HES_STOPPED;
 
-	/* read trans, write trans, read beat */
-	imx93_ddr_perf_monitor_config(pmu, cfg, cfg1, cfg2);
+	if (is_imx93(pmu))
+		/* read trans, write trans, read beat */
+		imx93_ddr_perf_monitor_config(pmu, cfg, cfg1, cfg2);
+
+	if (is_imx95(pmu))
+		/* write beat, read beat2, read beat1, read beat */
+		imx95_ddr_perf_monitor_config(pmu, cfg, cfg1, cfg2);
 
 	if (flags & PERF_EF_START)
 		ddr_perf_event_start(event, flags);
-- 
2.34.1


