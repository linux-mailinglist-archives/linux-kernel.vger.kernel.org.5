Return-Path: <linux-kernel+bounces-104226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C6487CAEB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 264EC283B01
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5066518041;
	Fri, 15 Mar 2024 09:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="R6YhVhAS"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2069.outbound.protection.outlook.com [40.107.21.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0968218EB8;
	Fri, 15 Mar 2024 09:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710496569; cv=fail; b=jldWBoAZWGTL9KcrzGbwAnA6Vs7+UQABvKbnx4DWGA9tMbXLBay1XwCeQnbSIDBR6tw2uorJ49Mg0LzhSxbzt8nYa9GMGgB5gbWIQHwnNLBaT57f2f1ScyriGfOaWQiyjQFMNbEBM+CYw8fK/SWh6YSSTnGWsYeFccBgt1y9DhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710496569; c=relaxed/simple;
	bh=dLvJ1CFC1By3jHdssQGqd0cAHlyvcXj6hyAA4sT61os=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ifbu5J83cra/09hW4uZkgQ3ZWKm2/a/lIvWVB8RWSJsqVg3qw9SfHU89XQUwxfAntKN8Vl1naCICz4E33eIUk0YKioAwUKDIyYKzsHH6WHMBWZl6j3JputKEXdnZo0uKPVJRZd3RioYnOHWwjl6wG6Kz1BVgK5Lfs+fkgD8hIg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=R6YhVhAS; arc=fail smtp.client-ip=40.107.21.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MPGbBiqlZf5OEGzP7+Ce6ECjhiFWl5xRSKAzRXtnnNUxmAhRRqhV4AM+WXqoUfWQiMpKRDt5vYMvsChbXuDRzXa/+hPWH67awF7MSqkppQ9RdfSlhziRjbzvAye2O1v1LMSFWMB3OXk2Su19fmvV/y2AEOaX2RiGoHDtaRBwcMV3TK3Dh5iIvzoMDw+zYGtRmfI5r92cJk6v+IUE4BzU7jUQXHVmOhdI3FF4ayUlMSJofBYllLeEuYr6hkPjwUVFHkZHjyGg7e0IqI/eBysiE9xibMTAeL6dPqv1VyrclDnjpaP6CHpEqv+ujytvk8mNhDsRa0SqSPa7akIGpOfvEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9Yqjr1dejZhmLuzqaNbEmKwMZNV6BNYxmUx8Nnvylg=;
 b=ezyZ2EVq2bQ6dw6oO1/ur3Sg/TDCAq5QHLUGIBlT2et0G87PNgb2uxw1VlRaGoBBYfLAZZz9ZrtmZait/ToWXgusr6RrNHvK4G4t77dXGRTPuu31DMs54oBvbPt9iqliY1JOTkA3G4nkDgrrTQQoVR1R6n1GRORkQF9MaaxqY8KBqiRihrKf7SIkd1lrstpdbiYUfloXwrn39Ma7eoO7GR4nr+QQLaoOTo2AID9qM2BumCh//MgallpbI9T30xjovRN5sNIL5EcEmtBQgkv5kbMQ8enBgjo2T+zB/s2TLpa0KScg83fefnyts8tTMJvN1LvWWYTFgM6WQg2/Q0xZOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9Yqjr1dejZhmLuzqaNbEmKwMZNV6BNYxmUx8Nnvylg=;
 b=R6YhVhAS1lL6223abTnLZWOFU5SNv6e+1jzImwIqsrtWH/K+gGm+Se1sZ0cpW1lgvI51PYCa7dq5in+0ohU3ACtTXvoOahhxJ4VIJ80fpp5blqQqkCi2eM4xcVAagbaigWOZTpC087FFEQXb3LiqUw9k1euFx2j+uglxawDgINM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AM8PR04MB7444.eurprd04.prod.outlook.com (2603:10a6:20b:1de::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Fri, 15 Mar
 2024 09:56:04 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7386.021; Fri, 15 Mar 2024
 09:56:03 +0000
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
Subject: [PATCH v7 4/8] perf: imx_perf: refactor driver for imx93
Date: Fri, 15 Mar 2024 17:55:51 +0800
Message-Id: <20240315095555.2628684-4-xu.yang_2@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: c7f3b15a-b677-4483-8cde-08dc44d6206f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9U/G0oHKGBGMKkA/RyNY8V7U/s1h71BcPcXB1jFUjNWqUsXTodpZzVPwYxCWUQ5iQKbMCBfd6U+9CFbH3HvHTh9NkyoZRnoCETIu/XgrPJgeEbr/wPffoiLa7Leus2zym6GnI+A67p/zUjRZe4qcAR7py1zoJz7WjulpBmQteBEWBudPltk8vkcWBmH3x7nZzESpoDNWLV4BG9n9Qzmib2iaT1lXsdP8MqSnIqfz4N+pnJdXbn38PPft+zMWZR2Ay7fMGQguzJQrU1WYxeK7DhrN3zcTlKkNJ2p4H+aCjvaIjJbl3B0HhtJz4AoVmpua/liWD3VyTLZrSsX/hYyyoM2nL+chPP7LGyOWjuhXr52m3f6XMHowkcTOtAEvvpqYp2Ey0YJ1Nk0nfCNialfgPo0iotzFxBgEpWqE6u0Pwz8M38MT8P+XxSDNKt6s02rF7B4/HFTRyBmgn4ljgeKal4PLMweWyfTo3O/BW2XmyNzkbWEJ0FD6o6l0xYTb1l6OO5cVwtFDSqS1WMCUahi2vl+IcwD6Dg+gIZAupJWu5bKuEnENrsK9BIfgpOQNzGXjchCwABkUKvTZe8crj5WpjXgCHtk3E1Oy0naCZ0R3RWIQRxm5wkQiodpdIfg8f87ezWYdmZgtR00U2urBlIi1OGhf9LcJneciBet2dElO0ohXIUmxuQT1LZSQ34Lyn5bF+T7xHe8QFIm3R4w9KxZFDwVqRXKC8qAFOXEOXJrX6Oc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005)(52116005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E0x1+g/yezzJDS0x61cXEEidF1rkzeCXvhGW6+CFBvuP7ilo4XvEY6ifDI5U?=
 =?us-ascii?Q?p7h0LkW2A5CEwA1vjTaL/jeQPRwo+7y/UeApu+ifIp8K6gADKWoShhs8ypzR?=
 =?us-ascii?Q?tmStywPiS0g/vfDRrXEFDOKN7/rGMxNIlKigqY/NRPcQMQRppJAIn0nIQdJE?=
 =?us-ascii?Q?AEu/y3UaU6fv3b74O75iTWtuEEYDZTEiCGrR6A91+VvGgCeSO/TrOZgeD5+A?=
 =?us-ascii?Q?aK+qBMA7PRbh5YbdlQL4s1QBQfdrSm6h0GaW95Vdl45GTCGHMU5Jsf2czWqF?=
 =?us-ascii?Q?SBMpTcjJA+FpynfbtsICrVT+h+SqRE81nPpMwCHEkO6Y/OrmDti3j98wtN/Q?=
 =?us-ascii?Q?dD0bZRqHvKD9njaJbC9Oofp3kDgWVzy9rO063MNeB4vTuTkJqymzNLSGG6Dw?=
 =?us-ascii?Q?VRw0VQTbuOvxw8LoyfEbmhAXYlRihaGpPf3d98hQvrR66Me/V1ZmvXPS2Dhi?=
 =?us-ascii?Q?KOTR3R7foMSeW9+XizfXsEYEdfVXGk3UoSpT0xRdL5i0usgWQPds4Md/uXMc?=
 =?us-ascii?Q?3ZAbErTdibGpxuVqlFlfYR0Zl4iS8yLlw8mXwu/tkVjLkpsEtpBYyplG70pg?=
 =?us-ascii?Q?rvX4okac15X1pAGs3AqUI2Wq6pvTmqWD30Hc9Vsgs77k7jSNnxiGiJ/DP5tS?=
 =?us-ascii?Q?ZSROP6WrNNAMvL9kXAZRRSsQ5jvWjLWdXrY3wwJjH/FLucYsPRqiF9bDGrp6?=
 =?us-ascii?Q?rW4/uwfd4TFBDVu5HphmnVlov5NMo/50PIxLCmS4qJy4YWM1wXI3ZA0tTVtT?=
 =?us-ascii?Q?lhBwdsxWUqr0/Jvrtv3QKC4wrmMyIMbDG5NPHD1RtwpIF9lKdmXtso3skAsF?=
 =?us-ascii?Q?NPLH3FSrV+QMRB3BG6H/WcEkK/xAdkJa0m1OQ79OWp6VBFx6nFmU4jXME8b6?=
 =?us-ascii?Q?JUs9N4dykHYM2HUXDQ3AyN0+CGqQ+Nr5RtyPJ5aKEZCzAAiJOaGKZKzfo5Qz?=
 =?us-ascii?Q?i92gEwtpcx1cyQUUc27j3KdkQSqB9oIRiLbykNOxQ3P88BnwvGI73WOD+HzN?=
 =?us-ascii?Q?n3oTqMLDpGvwKoRlUY4ehmRQTwTHAgfw+nROIExuIcM3A9miinw8hA1MLM6h?=
 =?us-ascii?Q?pAWPdgaOsRacgX7BIjViJx4TEBw9ar5P3sfo4l5s1uxMRB8/79nlqc4bmbn3?=
 =?us-ascii?Q?CxWaPD/m0oc43zBKDOoR/d+u+VAKvQK8uHdx3h6nJxUc5ZLYZfrfCnJ5KN76?=
 =?us-ascii?Q?wfpiA0ULL51g971R4IxACM+UIkC65rJ5IRreilRoBWl+XWcOPGWJJ3ZRaTB5?=
 =?us-ascii?Q?RXz7ozAzy8vEkWNxH4MKfFjTFo5omzXaQNgjI/qtFJkUgtvppCF1eZg8PQnK?=
 =?us-ascii?Q?Bfy6LQYWz8E2p0CnoymG6WgDG6iYQA8ivWcYa7zQ/MS2OZSkYFJZdZlsXWr9?=
 =?us-ascii?Q?yQR5bxIDIPmuwXVoeY/oZTvqzI+e3rITcp9MqShICVRHrI8mHpr/olUJJh5r?=
 =?us-ascii?Q?tbP1TfLJ3FhJ3GJrjVx/mELTf7wpAUl0z+oy4pEuHt6ZCsHJk3plp26DZ0mn?=
 =?us-ascii?Q?BibzUdmTgzlE2oGxHzlTU4UqbEQAdoJxcvKZ0rb5d4Kc7D7xLecvJYIXpo+c?=
 =?us-ascii?Q?zz+mvsvgxL7852K7Ynj7t1VluN+KVzdJ6PArY+0c?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f3b15a-b677-4483-8cde-08dc44d6206f
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 09:56:03.9542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t7O0jOiS30DgdrsxSvlZTrOXIYsquQz4DEE+GWOiFzjSIKJfW7DBInMmrD+w3rXuLrs6nOmTTD2dRcKMRqqRdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7444

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
Changes in v7:
 - improve imx93_ddr_perf_monitor_config() as suggested by Frank
---
 drivers/perf/fsl_imx9_ddr_perf.c | 80 +++++++++++++++++++-------------
 1 file changed, 47 insertions(+), 33 deletions(-)

diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
index 4fdf8bcf6646..5537f4e07852 100644
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
@@ -76,6 +76,11 @@ static const struct imx_ddr_devtype_data imx93_devtype_data = {
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
@@ -185,7 +190,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_6, ID(2, 70)),
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_7, ID(2, 71)),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_empty, ID(2, 72)),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_trans_filt, ID(2, 73)),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_trans_filt, ID(2, 73)),	/* imx93 specific*/
 
 	/* counter3 specific events */
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_0, ID(3, 64)),
@@ -197,7 +202,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_6, ID(3, 70)),
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_7, ID(3, 71)),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_full, ID(3, 72)),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_trans_filt, ID(3, 73)),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_trans_filt, ID(3, 73)),	/* imx93 specific*/
 
 	/* counter4 specific events */
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_0, ID(4, 64)),
@@ -209,7 +214,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_6, ID(4, 70)),
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_7, ID(4, 71)),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq2_rmw, ID(4, 72)),
-	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt, ID(4, 73)),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt, ID(4, 73)),	/* imx93 specific*/
 
 	/* counter5 specific events */
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_0, ID(5, 64)),
@@ -244,9 +249,26 @@ static struct attribute *ddr_perf_events_attrs[] = {
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
@@ -368,36 +390,28 @@ static void ddr_perf_counter_local_config(struct ddr_pmu *pmu, int config,
 	}
 }
 
-static void ddr_perf_monitor_config(struct ddr_pmu *pmu, int event,
-				    int counter, int axi_id, int axi_mask)
+static void imx93_ddr_perf_monitor_config(struct ddr_pmu *pmu, int event,
+					  int counter, int axi_id, int axi_mask)
 {
 	u32 pmcfg1, pmcfg2;
+	u32 mask[] = {  MX93_PMCFG1_RD_TRANS_FILT_EN,
+			MX93_PMCFG1_WR_TRANS_FILT_EN,
+			MX93_PMCFG1_RD_BT_FILT_EN };
 
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
+	if (counter >= 2 && counter <= 4)
+		pmcfg1 = event == 73 ? pmcfg1 | mask[counter - 2] :
+				pmcfg1 & ~mask[counter - 2];
 
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
@@ -513,7 +527,7 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
 		ddr_perf_event_start(event, flags);
 
 	/* read trans, write trans, read beat */
-	ddr_perf_monitor_config(pmu, event_id, counter, cfg1, cfg2);
+	imx93_ddr_perf_monitor_config(pmu, event_id, counter, cfg1, cfg2);
 
 	return 0;
 }
-- 
2.34.1


