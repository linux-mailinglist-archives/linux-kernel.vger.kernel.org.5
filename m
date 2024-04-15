Return-Path: <linux-kernel+bounces-144471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FD88A46BF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 04:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41DD61F2203A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 02:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85E2208C1;
	Mon, 15 Apr 2024 02:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UW2dpk//"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2076.outbound.protection.outlook.com [40.107.105.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A886322612;
	Mon, 15 Apr 2024 02:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713146640; cv=fail; b=iALvlkLoDWNBZmYGblFNS+bXksvQTiGSkB06UvXma3w7wvU52+Ts4UdE1N80xIdYNIViRiNHd57YCeSIk2g5SnJigevsPTSo3SQTqFWLbKBCmF4d3jv+rNUHoyI4fw2UhR4WOUncRlBG0eD2pXmk7vn6jmPmWQ1Uq0trRhbUNBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713146640; c=relaxed/simple;
	bh=kEzhNYmmaHKjrQMOAkAuQQ93Sx7mvQ6H+sJVivcpK4I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mcxHOVjU3FVQqbUWXxgLk+3n7o3z/6hANW+kuhAMryUoVkziyK+mWos0S+1TWPPTrFTFZXw8UJ+zmMadi8ImKtJhTuuDjbi0LwWy+2pWaPwY0u/XVL7yU4ldqoGaGFPfoTOM5zSYkFD/U92EF0twD5c9+fDvl1F6rueoqssIAPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=UW2dpk//; arc=fail smtp.client-ip=40.107.105.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gByOVL2MetEwng15qYdkmfHL8BvQgL6Fwf9KAj/bXDBlhclbcvIVAqcT3w37dIv0Pu02RgIwBr5BmKHtXN4vt6Iz51Hdzvzs58SaqxVnq3HMUOrC5IHceA5qYcDIIYeqV1NjrlJwQNnt5dsFDTXZz8TKmPNWL0e1+ywLAhq9P1rT+vldvq2DBn/jFy4dxa/Gjge4vBiDtAuO/1G9WOaALeN40h7gYwFN+q4mksLpY2YgOYOfKVkb3SZp7myTDyRjjt2BANJ9H/ua3XKTP2ZY6wysP9GWSpniD3rZxiddA7/UHrOYuZkPsE5hEYh43f2+sJp8DUyziEPQiT31x/x/yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0eouDKYcVC603PhagIIyqYZwkoFF+vmymnFtqIKfp5w=;
 b=fsSx1gKWiXpEgMkXNGrMB31gXtTtvn7PrloGkrm2KukMxfLyx2JIMBzKIjkNsBos2ytKqqEBZYwgDIiCAAfJCgc33V0c7PkdiF2+98aXGusSwOLl7FBOHepq9Xg7bK3PVV0v1/JXW+PApanJ5KL59oMPI6fyDOUZlp7lEtJY2sQUENQjhH0VO7edClNzZ5ljyUVrtyurCMBObUPghYROMjkBUSguYEXC91mYv3YtzFYzu1AA9KJ22bvPNvUPBJgePTp6snsSIolTd2Tf4ciGOyE5+X17veFbOVfQFlHlL00t+srcL1w1KMsnCBVYEtQGKXYgsc0iKl61//K/nsVImw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0eouDKYcVC603PhagIIyqYZwkoFF+vmymnFtqIKfp5w=;
 b=UW2dpk//MFyQOS50OaPFMgkpI0cz9BxeS7cSI+xv/Zy+XZWAKA+M4s/0RpNNm4kWWLF8Ycbqkpqcd2jcUR/6n0JdGDQ14ZGCvGgNpqfwfI2rmdoNDWpMtG2ryl4Z9glwmLxuPig49k94Mpwuh3kqVXDhYJlf2kCiYO3kcTjca8k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DB9PR04MB9233.eurprd04.prod.outlook.com (2603:10a6:10:361::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 15 Apr
 2024 02:03:56 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f%6]) with mapi id 15.20.7452.046; Mon, 15 Apr 2024
 02:03:56 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: frank.li@nxp.com,
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
Subject: [PATCH v9 6/8] perf: imx_perf: add support for i.MX95 platform
Date: Mon, 15 Apr 2024 10:03:51 +0800
Message-Id: <20240415020353.3833367-6-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240415020353.3833367-1-xu.yang_2@nxp.com>
References: <20240415020353.3833367-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:195::19) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|DB9PR04MB9233:EE_
X-MS-Office365-Filtering-Correlation-Id: f8be5d70-db14-4be7-d65e-08dc5cf04e61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	R0VI/4XeV1NC/3dnSMcHcSm90YVrBB7iC8b2Ox4pNZOf3RlVK+6nYdw2uk2TXqtfhjTFBr+/VlnY7uf0Zy5qqOH/VXlChAD6UhSPdJyvN0sJHUsNOVAcSt/dEFcpHyAMo85+rTR5szs1nISu/QB1zmC754w+R7kWBUyDEP90Zf8GMhU6A22lNWcrMwOE9hwWYyWcExdqOXR4UenYtTYeLmYEnyQ63+fYHcgFKdVUa7KxAEft4UFkZCS1pW3BaNM2p0beWckJAcM7AUy59nFtkN1Px7PI/YZpYPCFvVPK8gt//gdt2rvQeENRm4udDL8AQ4IPKaxN9yf87mMFhdh519oE83npTcrBd8TO8Jm1RAWiHJbCpTfMNTTbog4GHtAGn+vgw6kmGPWtDMkPvzvYr3S5mRXmHIDF1O3xMQR4mZODm3DL++wCU78f7YdgJljQHGYBSV+KKJ5OsFigy6pJrWWMbXhp9Ngaq7shCS6EA9JCjKQqG83mWdBNcc3XGq3tPkcXZcLJYwY+HU3A3q1qMP6VTdAza4OTO/tcOnpvuaYG/kuYGjmVMBIyIxU14bzyqoufuhI+VmiAJEQPz8ivFetV/Pnx1O3lq9/63oF8yLp3J0yEj+eDcnwftiAvzGdH5hRFZRMIv5K5729a0Oc8j1q0qUOeUtrmYM7G7RXn0A2j9ybT8GnHZ5vyBeHSf6H/JGzhgKS4lsAUux5IvDCzPrjpM6z0zi0i/kFPDUtwg/A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(7416005)(366007)(376005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c9Qcrrw+sKLFV/QiisoSCVaozuvbrIDxqm6fTAt6MJvHQ+x8tySxkRVu6992?=
 =?us-ascii?Q?ZMPUhY7oMnT9uJzMEuLFNQ5y5YEKM1M1qUgCe2vZtD31VUbtTWY6rJbI7IbE?=
 =?us-ascii?Q?NJI6bSPuxQQPtCMHhwkbokb/Dn53xki1xsa/RpIoaR4L9tJXu6ija6RyuYOd?=
 =?us-ascii?Q?+ixNIq6+XaYSUmFXJPs+7asZaphZy2MAQxzcI3+fcRkCkToKtYxIOCVXMEoi?=
 =?us-ascii?Q?jKVz6mx1cB7hVm5BYfs5uT6dsqn1s367q8/hWpvY0H577LDfANTJ/HCjrYJ8?=
 =?us-ascii?Q?SydtVJQguM4g/G0a8IHNWVMP3VvwhjCCHq9m6/HBSHpaQmJ7rwILMa9a5Vlv?=
 =?us-ascii?Q?4NCw2czcqFYr4IFQ5DlklpNkMUb1zufzPvoHhYyjfSnSl+9q59wI019+pcaa?=
 =?us-ascii?Q?r8IoFPmhO3BKI3yL2uTtRYiyTEwlbG58LVIjlFs91CfZqwqlpPWdg5EiNUzs?=
 =?us-ascii?Q?EXStzwOptrJrwMhONByN5ksXqemx/VMovJLbUdw3qKlAHbmesoFoZvwg9rxQ?=
 =?us-ascii?Q?3oRRovkTpb9Tm8wk4pKxCb4dngAd60p1PziqvQ0ivcQL/GEu4fSiajVAStMv?=
 =?us-ascii?Q?0XkDGcjx7t+bws5Ya8vb0CHSKdqu67RYx7gmhtTjcG6fruIzj+vyZHleFOKS?=
 =?us-ascii?Q?ylR2qO34BGdd+ZcJMOjs9lV5dA73Ga2y34iyN+FE6BiBKp3H1EQRiDZoFz4w?=
 =?us-ascii?Q?nkvwQRzOwkBdsTOE57DP/bWlsRV3QkXVxzQ2SggnObPykPrYrIVD9CR2BpAl?=
 =?us-ascii?Q?TLv8xroqb0kGSaivzUo0uqbD4eLOL7G3aywLGKHAedZ+CLvtuSKRTLBoOjBV?=
 =?us-ascii?Q?XEDcJAThCWxkzh2PFgbj+g4X9oddIhUcAJ0hG6Ekzk+yvgsVzSL7xM2Fvokb?=
 =?us-ascii?Q?rmEUQ/SLbhBfQY3jSENPctEKYwbfPhyFIU3ZR8fcfRFNVvv/LaWyNaudJ4TO?=
 =?us-ascii?Q?No4DOm/wFzI+inOSgJ6Aji07b004clOPJgbgnaQ9yqqq5JxlAx91Hayqghj7?=
 =?us-ascii?Q?5NZCkxwR0jADk0Qv9NukcsvmZzTnat8M57U2YNSgFmphKlzCfB30dCrJD5dh?=
 =?us-ascii?Q?P/9gvZdebqa4bOr5Dyk28jDVaNSyuomFwb7ccusNOAm8xzNGWp8wL4/JhAD5?=
 =?us-ascii?Q?6+17YBIaGsaH8l+CA2+CKwbwsVD+rarswEBmGQedDkLXYrPR1YXFmh7MQaGz?=
 =?us-ascii?Q?rx570Q0UTo7orYxsyrW+mLH5+WjhOdYIW4c1Dcun3F6eq4GFLu6wHKPcxdT7?=
 =?us-ascii?Q?XnR+pEKEIwXVqqToTwkzygyCpUd9mxvx/UqZ3wEJ1EqYgjesljCVjhZKK9Zw?=
 =?us-ascii?Q?anukORH9N0+cBFfB5hg1x4NCL4Jf0PR/egcq5kjYie65MYIySMn/OfP7VcX6?=
 =?us-ascii?Q?rnA7BWhc1zsb06pkyzubCcFk/y3IWndP/UPJTqQSUqBWsxmmisXDrE5fXuV/?=
 =?us-ascii?Q?zPBbHLv/kQNhMQ0JTRa9MWN2DzxpB047HsCRVved+E+koNxlKV8UPbTmP3Y6?=
 =?us-ascii?Q?AXNESEOvDlgAccK7tCxbX+sURiVwBUHB/1JHaZoZ5Nwta6XRHpNJGfDCAVpD?=
 =?us-ascii?Q?UBG9d4iZXtzOH3W4I2eqmB4m5VTROoweBgsrrCIQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8be5d70-db14-4be7-d65e-08dc5cf04e61
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 02:03:55.9456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MhIvayDUHmFFudbtas2xnG41ULFz+wvONrirJfdqwE/SJGW7yfFusrjsHTjrRMbcrdVIMHkV12aD9ehFLbVx7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9233

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

Reviewed-by: Frank Li <Frank.Li@nxp.com>
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
Changes in v7:
 - no changes
Changes in v8:
 - add definition IMX95_DDR_PMU_EVENT_ATTR
Changes in v9:
 - add Rb tag
---
 drivers/perf/fsl_imx9_ddr_perf.c | 89 ++++++++++++++++++++++++++++++--
 1 file changed, 86 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
index 910fda7eb2c6..30c2a3aeed2d 100644
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
@@ -158,6 +178,9 @@ static ssize_t ddr_pmu_event_show(struct device *dev,
 #define IMX93_DDR_PMU_EVENT_ATTR(_name, _id)				\
 	DDR_PMU_EVENT_ATTR_COMM(_name, _id, &imx93_devtype_data)
 
+#define IMX95_DDR_PMU_EVENT_ATTR(_name, _id)				\
+	DDR_PMU_EVENT_ATTR_COMM(_name, _id, &imx95_devtype_data)
+
 static struct attribute *ddr_perf_events_attrs[] = {
 	/* counter0 cycles event */
 	IMX9_DDR_PMU_EVENT_ATTR(cycles, 0),
@@ -204,6 +227,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_7, ID(2, 71)),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_empty, ID(2, 72)),
 	IMX93_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_trans_filt, ID(2, 73)),	/* imx93 specific*/
+	IMX95_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_beat_filt, ID(2, 73)),	/* imx95 specific*/
 
 	/* counter3 specific events */
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_0, ID(3, 64)),
@@ -216,6 +240,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_7, ID(3, 71)),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_full, ID(3, 72)),
 	IMX93_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_trans_filt, ID(3, 73)),	/* imx93 specific*/
+	IMX95_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt2, ID(3, 73)),	/* imx95 specific*/
 
 	/* counter4 specific events */
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_0, ID(4, 64)),
@@ -228,6 +253,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_7, ID(4, 71)),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq2_rmw, ID(4, 72)),
 	IMX93_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt, ID(4, 73)),	/* imx93 specific*/
+	IMX95_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt1, ID(4, 73)),	/* imx95 specific*/
 
 	/* counter5 specific events */
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_0, ID(5, 64)),
@@ -239,6 +265,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_6, ID(5, 70)),
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_7, ID(5, 71)),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq1, ID(5, 72)),
+	IMX95_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt0, ID(5, 73)),	/* imx95 specific*/
 
 	/* counter6 specific events */
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_end_0, ID(6, 64)),
@@ -432,6 +459,57 @@ static void imx93_ddr_perf_monitor_config(struct ddr_pmu *pmu, int event,
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
@@ -541,8 +619,13 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
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


