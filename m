Return-Path: <linux-kernel+bounces-95284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1206F874BB8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3603F1C20C90
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7DB12B172;
	Thu,  7 Mar 2024 09:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kfA7OovW"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2041.outbound.protection.outlook.com [40.107.7.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1320C12BE8A;
	Thu,  7 Mar 2024 09:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709805485; cv=fail; b=O0VHrb6I1Nn/Y4NqvvJEJFmWKc7BWdQlfNUBIWFeg+wcuukhUauN5z3TxJXCqi3WRf0O2hsMkHloAki8RwHrmLvZ65CZ6+cfdf1te7mzHoLft1NjvhvRMaIULRxsjv6Fw0FrcSF6xy6Bil6LVaIpxqUwvIFx/qKr5C80mNor0L8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709805485; c=relaxed/simple;
	bh=RbXnBSQMG36BsaE76Nmc2umxgS1/mRM6Nny4U9hZbHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ABOIO0ol9wYxHooQgiz/pZ5ckbwHcFtbIvT5gB8KRkfVUJKvsrr1X957ik5o7pToOHKjezrsliE+acu2rplWDNMrroKQIh1OD2oRz50vUq6c+e9cVLHeFyy3Zc/d0JYIvM2axysmMkvg2lYMFG1fQK6uJqM7tbxg5euHsM8MQmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=kfA7OovW; arc=fail smtp.client-ip=40.107.7.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJ8imZU88O09xReud/n79uvjORADMC/0Z2O6VrrsARjZoLydv8JZL8XnbiqSjbOsevvcNnhYjCpxg+pyJxTDJBK5rh2iV/o2AgIKMbBBMISxJp0A9ukthvxn32zYmM+ChwhIzZAT1kIPnaMQlbCsS3u8yOzFDfqXiS38PP0uVAeATe8TWV6CAvqJI0yVMjTyIaUZMNPKtN5lMOlU8ByngTHnI5DNQvpnZKS83WKFi6flCn0mh6hj7VW9X6EdEzBflzHKW64H0w8qP99hQefhOMp1ZQSrLCjuko/H9jG8ostfz9fJMzJchVUukuzqVpIbKxi9zVouReg460mdOeVRjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3IHUN1dZWeSD1VqIASpk0MIY4pEIaQDpx/0rjsrEY9c=;
 b=YuhD0Yt9kXNTyNN2PdwSZl9Fbe0bu5iDnX4KbDpI0JaaCBiZ5IRLiD9T9whFUEdyhK9BIUpXc5VEkwEmmevuXPQZIheq+6RzzM56XfWR7jJpa5yvM2nOGLlKy81jNdRDNyX+620ok6BXuxYfMmVCCfYahHE394bzpHfeOfaykYWtFSrnx5lynGXENCiGCjtJNLOi2fkBEv1A8ctPz33XYuRpHeQv6Idrp+ZElGrMDU+Ee0S5hZ7VA0lDgkCVuonVBMYeHyGP22N39syBM5Dj+6EuOS5lhjUVm/5KrQMWEzfS00JLisMySBe81Kh5mkq4MpQlAktXU+K9tZyvJfpM3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IHUN1dZWeSD1VqIASpk0MIY4pEIaQDpx/0rjsrEY9c=;
 b=kfA7OovW4816C/fId6+eqqavaOnvyNIuaEZLIMp0lV9epbagaxS6Yr1aWWco9OSl8QHGax8syRoRQTcqSv2SyArvT+pMWppIEYWR9uKJlalAOIHlEq07okaqxGvBobadhm+g3rla4oMNfocN56yVrY1vfaaEgnZdQQ3Tvt5e1lc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AM8PR04MB7812.eurprd04.prod.outlook.com (2603:10a6:20b:245::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 09:58:00 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7339.035; Thu, 7 Mar 2024
 09:57:59 +0000
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
Subject: [PATCH v6 6/7] perf: imx_perf: add support for i.MX95 platform
Date: Thu,  7 Mar 2024 17:57:29 +0800
Message-Id: <20240307095730.3792680-6-xu.yang_2@nxp.com>
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
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AM8PR04MB7812:EE_
X-MS-Office365-Filtering-Correlation-Id: f1d888b8-fdd4-4558-d6c1-08dc3e8d1232
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8xl+Ys6obZOuXcoYpQ9IjY5PB7YngRz5/GJEanFkAsdX7rkzNKwuUpYjIpAr/a8Br+Yk9DGoOfwcnCaaURkxGhW39ToWSPFctHhJ0pNXMf9633ZYq9uLcX7rkgQLhZLK/eMtIDCOLW3wwtbj11wFaB8gPXwUDm66sfrtj7JewpXDMJ5VOzuAZw1CHrTdbcitwKGP6+ZJ6dXD+b7ZWOwZrzpJxTdQzRq1Inw4cDtYNL47dckTYE9wX0r4SOO2bKZ2cvyxFTpZfwjpAmlXcFBYeyfH6psjAx0WQVFenG6idAEDBPlgHKeGI+9LKLTyJXGcz7KRoXo1k3YKog++02kCHTVEcv1ZPm/BelxggDpPJ0c1mkmTAYCw/apJDyu6FgtuMxME1QXC5aP4FdpHnDKsjGmNxsOuGZXNpUKndU4X6EmurbmfKWdE4lCb/3MuEENa2gphKP0CidqiAtpGgVUXS1F9cY4GLYZ2nyU/SJIAr4PFMbAnWUyEH/ohIBtnsL8m/dOyZe4+rmevPtkU/7fPlcwl/Jj+jdsAGx+HlSyFO4PzKprHG59Bb7B3UEWGdx5a/MPV379dVwpH1sbZwCU2Qd0KNr9dnSO7Cjm4Lgcxf6MApInW8I9fH3J9RcEMweSgQMawIEdBgQpu2508/89m1DEbKXwaWvD7SH9NwFRCgN4OvWpZjagjtsfVatkFdGLZm+TNt0oFfhgKMoKObDADyFsVSe6n60mF/OVmSr6aDu4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FSPk5CEK838zDG30DaqzAKyof89LOiRDKLwJ+QK39KSbwzZOE6uwqQDxd2rS?=
 =?us-ascii?Q?8+L61GyrVmczgECgpUSx0ysodqTHXk4tcLa4fo91GYRLYsXcOBBcyFpa6PMt?=
 =?us-ascii?Q?h5DvqPpeEKsAHv/Vxno6B2lZ61g0W/radD3p1GpGr0KJeYG7359m14A3yDpJ?=
 =?us-ascii?Q?WNz32r938pwbZTK+0mKofrqCsWNneJFwhu3rwIE1xqlDwThpFuQ/T5qI4oXT?=
 =?us-ascii?Q?e1Ngzi3qxw9P2yXfLIQoY4KuXDPpDhiMOxsTbAd9Xc+eyzgbj6PMuXvWfvpJ?=
 =?us-ascii?Q?nDb4WVnN92s4qwaktOK11XvpRx8qdVLVrCijUtJrQgCCXdc0+gi0PsW/fcMg?=
 =?us-ascii?Q?U1BpoJtAY+9F3X6N7veMFQqovaCCobnLN3gH5+7WpqHQD9B548QawgDRFAKg?=
 =?us-ascii?Q?XjRV2Qu62W9EM/5HQFcrFXTNWXgFz6Rre2CLKgKlqlje17bZepy58Jv4K+A5?=
 =?us-ascii?Q?/+OSnELkifpCB+8HZQAW7qS6i2jAiSW3iMbIiMzE38sRQ58VmmYx0oYveT2x?=
 =?us-ascii?Q?Q76NvAiDDKo/92B2Z7r4bt+yojo8ugE1Bg40ay71jH5x2Gkg7X6PTwI6am9M?=
 =?us-ascii?Q?9YlvQL6/jwvJMmebKMs4+kEipPuuJzxz0xLAHBpEnqHtzTFcdkr5Z7Yv2JlT?=
 =?us-ascii?Q?qDafSkgKcHXBymaT1LAGESkXdizCIJJ/WhHGKsnAnn7Tn3I6ut42UGiwB0VU?=
 =?us-ascii?Q?eum9apYMwXn7XLzjdQOHMTdoXZc6Gw0viaYzplGCtxh7uhScWLU9eJSf83cK?=
 =?us-ascii?Q?42G3yCxBInwpeAwsypahQjGYB8c7oGTiCKGq0JyAAN0xTdXg+qrnYWawCq72?=
 =?us-ascii?Q?09L9zE8BnO3C5CF+aiHKjsqCwXqTs5xzZ94hW7ugFLkQzn4HYwh6N55DcNSI?=
 =?us-ascii?Q?LTkWWzBbtsfG+aLCVk34is6kth9L+zlBknW2P9MLfXjGJcUjwz0B6PFrQZSf?=
 =?us-ascii?Q?Mm2VcRBArPesGaNj6kOve7DtaiFPjpb6QArSmuCrXA/0Ko69fsq21jZXR63L?=
 =?us-ascii?Q?twdmld5IH+bhyiMiP/JY4urcmSgQSoplUzqOPqWqcszrIrILuDbukjOG9zCs?=
 =?us-ascii?Q?hI6PNevBuRO10d2AbH7ARoZ3Z/ffP6+ccjLd7B/5L9Yc9OKWgSfx93m5poFd?=
 =?us-ascii?Q?4B4z8LDRut1Wkdw5dNJAA+MGGyfSSQHBvsmsrUz2UpF6xdtJt5/kayeiJsrs?=
 =?us-ascii?Q?CKTVOLdSylkLvG8wW3FxYIDN9LPXfBOrYpIrM+tQtQYuCWogjI/zNFGYQcIn?=
 =?us-ascii?Q?4JgUs5HwYGfTyiqnDnBLa20kNNY4Ftxm/9NBpPgZU9qO9wpJDeXhfHARWLUS?=
 =?us-ascii?Q?cEj8PWy9ds3cAweSZgNLnGw3HglA52Bfdo38pYZ8oq/+46t9CGza49g7LR7D?=
 =?us-ascii?Q?JxNSaktl0+9Z1yKRFXm5yvqDENclBtsANxecZc3mbZz5Vc5pHwSaCC3e5fw6?=
 =?us-ascii?Q?c3INHoxhB810E3XeAyXXbFIEr8NhmlkIv0TVBcstbUcxA9lTVX9u2GJoXMqN?=
 =?us-ascii?Q?RvZShXrM5OkZIxWEBMA4OgS29qAlJQdsJcANBolzKWgOOEeex9X5Xvg2GxeJ?=
 =?us-ascii?Q?+9bK/sfci1UX6+IASz5vJ0A9/6UaiZq654Ideo35?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d888b8-fdd4-4558-d6c1-08dc3e8d1232
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 09:57:59.8391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 403lGvEof0ZVPKWKC1oPxkd0jL/MHB6VY7GrghUFBc0fu/CKG5e02JZtNE+xP9cWnUMN7SvLxfsdG4rqpRTRHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7812

i.MX95 has a DDR PMU which is almostly same as i.MX93, it now supports
read beat and write beat filter capabilities. This will add support for
i.MX95 and enhance the driver to support specific filter handling for it.

Usage:

For read beat:
~# perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_beat_filt2,axi_mask=ID_MASK,axi_id=ID/
~# perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_beat_filt1,axi_mask=ID_MASK,axi_id=ID/
~# perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_beat_filt0,axi_mask=ID_MASK,axi_id=ID/
eg: For edma2: perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_rd_beat_filt0,axi_mask=0x00f,axi_id=0x00c/

For write beat:
~# perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_wr_beat_filt,axi_mask=ID_MASK,axi_id=ID/
eg: For edma2: perf stat -a -I 1000 -e imx9_ddr0/eddrtq_pm_wr_beat_filt,axi_mask=0x00f,axi_id=0x00c/

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
Changes in v6:
 - no changes
---
 drivers/perf/fsl_imx9_ddr_perf.c | 93 ++++++++++++++++++++++++++++++--
 1 file changed, 90 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
index 52234b97d0cb..a91267e2f5d8 100644
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
@@ -77,13 +87,23 @@ static const struct imx_ddr_devtype_data imx93_devtype_data = {
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
@@ -192,6 +212,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_7, ID(2, 71)),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_empty, ID(2, 72)),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_trans_filt, ID(2, 73)),	/* imx93 specific*/
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_beat_filt, ID(2, 73)),	/* imx95 specific*/
 
 	/* counter3 specific events */
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_0, ID(3, 64)),
@@ -204,6 +225,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_7, ID(3, 71)),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_full, ID(3, 72)),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_trans_filt, ID(3, 73)),	/* imx93 specific*/
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt2, ID(3, 73)),	/* imx95 specific*/
 
 	/* counter4 specific events */
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_0, ID(4, 64)),
@@ -216,6 +238,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_7, ID(4, 71)),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq2_rmw, ID(4, 72)),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt, ID(4, 73)),	/* imx93 specific*/
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt1, ID(4, 73)),	/* imx95 specific*/
 
 	/* counter5 specific events */
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_0, ID(5, 64)),
@@ -227,6 +250,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_6, ID(5, 70)),
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_7, ID(5, 71)),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq1, ID(5, 72)),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt0, ID(5, 73)),	/* imx95 specific*/
 
 	/* counter6 specific events */
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_end_0, ID(6, 64)),
@@ -263,6 +287,13 @@ ddr_perf_events_attrs_is_visible(struct kobject *kobj,
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
 
@@ -434,6 +465,57 @@ static void imx93_ddr_perf_monitor_config(struct ddr_pmu *pmu, int event,
 	writel_relaxed(pmcfg2, pmu->base + PMCFG2);
 }
 
+static void imx95_ddr_perf_monitor_config(struct ddr_pmu *pmu, int event,
+					  int counter, int axi_id, int axi_mask)
+{
+	u32 pmcfg1, pmcfg, offset = 0;
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
+		pmcfg |= (FIELD_PREP(MX95_PMCFG_ID_MASK, axi_mask) |
+			  FIELD_PREP(MX95_PMCFG_ID, axi_id));
+		writel_relaxed(pmcfg, pmu->base + offset);
+	}
+}
+
 static void ddr_perf_event_update(struct perf_event *event)
 {
 	struct ddr_pmu *pmu = to_ddr_pmu(event->pmu);
@@ -543,8 +625,13 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
 	hwc->idx = counter;
 	hwc->state |= PERF_HES_STOPPED;
 
-	/* read trans, write trans, read beat */
-	imx93_ddr_perf_monitor_config(pmu, event_id, counter, cfg1, cfg2);
+	if (is_imx93(pmu))
+		/* read trans, write trans, read beat */
+		imx93_ddr_perf_monitor_config(pmu, event_id, counter, cfg1, cfg2);
+
+	if (is_imx95(pmu))
+		/* write beat, read beat2, read beat1, read beat */
+		imx95_ddr_perf_monitor_config(pmu, event_id, counter, cfg1, cfg2);
 
 	if (flags & PERF_EF_START)
 		ddr_perf_event_start(event, flags);
-- 
2.34.1


