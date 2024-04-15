Return-Path: <linux-kernel+bounces-144572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D908A47E0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C263F1F2288E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 06:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF99F17736;
	Mon, 15 Apr 2024 06:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="diT3bGTM"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2057.outbound.protection.outlook.com [40.107.7.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BFF2374E;
	Mon, 15 Apr 2024 06:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713161614; cv=fail; b=EPiH6zr5Nj84ZLzJeTt0DhZhGP/l0nw/SpiRYXntdsijZdzbxBNFJEKnLZtItdbTtUWHhWWoV6tldUTyN16a3dmHFJRrcw/aglAIYCut3+54mo4vQRnMo3WEieKnUciw7UXsTpy4RYSN6E3do9IqsH0R0R1+5SBWpmiakEWiCJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713161614; c=relaxed/simple;
	bh=t6zWxcVt/AgrDMGULoaZPotSadblOiBXFNsjTrPGIDs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GLLRxNd2lWSix6Ogr6L4PCEIJWWP+8W7egkLzK/DtdKmaKCg3rf1YJCnT4bKpgs3uKlXLiwRmnnOSAKMh9bKS56G9+F19YkNvST9/MdQoAjPlKN9kmCtjqjskHZme3OUsFc0rkxV+pvmv/quwW7aWC0xz/IFfB6ZzMKM3j09AxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=diT3bGTM; arc=fail smtp.client-ip=40.107.7.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VHTz+r5/0TivSkirTBMLq4AFPmJ7LPB+2rrTrpmtymG5AjI+7Hc3qCH7U52HowLBgqx0XbECekFUkQY1Uys2SzAWW0iHZG0gg+A95AWGQm7VzpPGz2qfFAq3y+BtGXBflGQnymDV8+K0BftISUh81vVsL9Oaj962J/TVDaRzRhAMZuOVk9p7LzlsAw+wMxkNySvzLYZ88Xfwfnzusi3jRvESfZl1JR9MtZ8pNmFOW/FOZioba2SzVuKae1EKcxQQgdz4a+IMBGUt2vGdmdAC9FAigsRc6WTW9My5Vr+76Lvo6eypH+LMxAdIybLm+NmlVfSfKwUFV8VyDNvGpzzC8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9pm34x0EXhKCN49EklYNIaJSmOw6/RsKCfVpTwGXX6M=;
 b=do+lJzBckeca9KwV1feBBd1XFmV3oIHasyYJJbrJ7hw8xGthZDyVc73sYSUg6Xrm2Pznh+ainnZwRdtD9UiM1VqCHZQNN0mNAJ0Vkro+TdQsvLG/FtPEEoGO8SH6cYpuo6C2cJ33OqJ0m9DI/6FViLludmLrVxz6epU5yvC1grzAJNt+i4HiNw1G5uXvn0PDtaixtvIBKkiBhflwvCYzBG6MxH3xrpV43kVHV9JUaTGqp6oQNH+Eflai8d5ahWw44w1bKMe09dvtPmNFrOO+6tjhU6Ho3KaGLONSbInCNZztxBmCluc4yc3AzCfcXwYEaMIr+pKIEq4manmdOS2S5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pm34x0EXhKCN49EklYNIaJSmOw6/RsKCfVpTwGXX6M=;
 b=diT3bGTMJMpl6zsu/B2Agp7HRO90xHUrcB2COjuFlgiW76vSvP/12ZNaOHgNHriaWNtMhg1bbaJy6jFEMD3HENQt+CZhMCu+fvQahDOsc/386O3R8Y4vf+ryYt32UELgKis0lAGJ7TxMZ4leyy7SPGpYUtGGUhTF4vG4Yc3Njvo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by PA1PR04MB10117.eurprd04.prod.outlook.com (2603:10a6:102:454::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.43; Mon, 15 Apr
 2024 06:13:29 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f%6]) with mapi id 15.20.7452.046; Mon, 15 Apr 2024
 06:13:29 +0000
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
Subject: [PATCH v10 7/8] perf vendor events arm64:: Add i.MX95 DDR Performance Monitor metrics
Date: Mon, 15 Apr 2024 14:13:19 +0800
Message-Id: <20240415061320.3948707-7-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240415061320.3948707-1-xu.yang_2@nxp.com>
References: <20240415061320.3948707-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:3:18::22) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|PA1PR04MB10117:EE_
X-MS-Office365-Filtering-Correlation-Id: 3127847b-3fdf-43d9-b571-08dc5d132ae9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xdoDjSJdJ81Ot1WZEFjkoUxxjofRn/NDjMjRyCbz94kfXlB22TCrCTdIui+3IsXTHRe/k2hTDJzYthdxMdUk8/s3VnYPvEuHOo3JJmXQOawEts3oyVNnKtW0VMvklYu3GGGX/mwg34rALqT7gnD09eJhk49zRJJrDI23DaamO1BsNG2QsmDqL9cVl3DqFkGOoWwBuhv6hbcQZ3OQJeWruXjfLvRESyvRXqiiylPQrxQdFxKrx1as3TnUN0WIz8ZIqpjXhnNhoJKmD/OqCyLJ5nGKcd92SB7QU6UkzfSg8mOIqDD8xtAplqCK31sfV7+8PcXFOzOZpmNJrrbnksy/6YIPLxIHZNXeMr20kPSyfBr0vfRbblBjvEUvXNkiQPdlNogJCQTi7swAnjV6wPDBVZQvAM7NpO/gjStwQq2YRBrBe2uezawBqPefoaMljoFsYblPSNyA+Ogj0F/7q312DJ/5WQCHiNEDOs8bWS+fyK/ddAQZCZgznI2GCwByFFRIX97sbnnWuO5jzW0cMUQzBYUTe1uDBwv89ez2Dvxuo7IV4jWhJhH1gSonhIUnUGwpCBKrFqQoC50WQGxnXchMsSCBZDzlgQsRqyC27uJ3meSlWzzaSs6FVsg/8KLxPzZQzZSw/c/CRZ66gAjlo5bsxRrY/2JRh2JxuOC2WcGcOMzcXvh6P9rWLrk9apGiSovGF+XCnO/LhliKpTIy61J6xT04INjMY7Jep8DbJ1BSod4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(7416005)(1800799015)(366007)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QaLsbgStUyAvZIYbBPrQNvO5eyTdOPD5e5Mp+AQe7kd1D2d7emgOIDD7ll63?=
 =?us-ascii?Q?Xl1zGWO3zGDzEA06LFvkLFEMvUnwV0liCgWVjEwWDq2RJokfi6DC69a7vQ0e?=
 =?us-ascii?Q?fFLpMkMCpAWSzoJXnfU+Jhm8URz9uACezzkqN7P2GZj2wGOYOYNDwtt/3o22?=
 =?us-ascii?Q?m5REDszQTYbaM+8IXsqttGwU8saU6dM5V+zITfx6dSpvi7rYo9F7xGVkSXM3?=
 =?us-ascii?Q?2+q0q7/IOGIJXrK/hxNtM17rydjBpIMCcawH9fnvZg23KcidvbKPoiz+LVfH?=
 =?us-ascii?Q?Fu3wtlwyzqHiAVRKgwRH1UfSoFR+L6i3js/eFuHdUx1k68i/NXfDkapga/9g?=
 =?us-ascii?Q?tuF8yBrMJNSWhU14sJBqn6+oEBThiWkCWipPTWYVdpaFdl4jnPAFGmyAd1Io?=
 =?us-ascii?Q?sUVKyC2E/6ZzW27Mw9nFn45wmQPXBTtWf8BgJ5WrgDytCItoL07FjIVzRuOq?=
 =?us-ascii?Q?rKrnMiGSwNk+S+u6i51ZPLIGhmy+x/BC+7XSnGDqyu/eZhnGbNzh4DcBPiIb?=
 =?us-ascii?Q?KYjIUYZBOVGslA075rQqcUzn6PubJZ6UaIWBUqpo8ViwLuD+tV9aCNtfHzCb?=
 =?us-ascii?Q?7xfhzjQJN8WW4QmNTIVPC0q/7bE5opmHOofPQYDNDSHuSZqpiYIeq0uc9t+I?=
 =?us-ascii?Q?ULzftd+3sp9BFLOss+nXGmuBTCPar/ZAHf6yWtcYIMZBXgH1/z3lV62GtGzo?=
 =?us-ascii?Q?bIC5L4YhIAqXwehD6R0ys7QA+tytMGtgIJ7dwnru3XdhqeQch4joRFtjJvqs?=
 =?us-ascii?Q?SCbfX6lxk11NeE0zLhR3bgL0eMyRV3vA4DBgNqycr2oSsJAE0UwQBSS7NAm5?=
 =?us-ascii?Q?na9ybupgyMY+W9ezGodn1RDqhGnGVdXr9LLmiHHDB4UE7ONcJArY05UIRUAx?=
 =?us-ascii?Q?YljhyFONFIrX3fpLsU599m6eL0T6WeYyXDffpLNNuea3N2+qdT5Cw4uuzxIg?=
 =?us-ascii?Q?xvUvAvh/bsrSI/Jzwyim0vQTYLe+dl9Ex6rEFaHXOzmZi8X/4h0OLXlmFLqg?=
 =?us-ascii?Q?+1ZaX6BdZ2ZLWpBuC/uyfYsIFCVgq2yDgX1DC5b8xEV/f6bzWTwJTpFmRelG?=
 =?us-ascii?Q?Ck7RKMpueCtL1zux6OvLx3TB3fflndz0MO6iohUegQkqUYxH4hQ5waiEXcmF?=
 =?us-ascii?Q?/42Q9QRas7bMg6MKG9kuJog2xxWaLT/s9iPEZjlZVFOSNY5idOVjYQmWEXPs?=
 =?us-ascii?Q?ZOWM2CKCjpnPG+LcFAphHYfORTmX0+kOZFeksTIey6wfCpgdj13a42FoBXfQ?=
 =?us-ascii?Q?5Nm8ixJkxbAQyZz8fburbiPifgXHU4cSh5p+od3sfPu2VAVldVM14uzg2ZHm?=
 =?us-ascii?Q?YQvIWJC5L45UTdE0S7icWAT/9bWx5Zf2jJ+HdyYJpXLa/yf3OxTHmAAe+3LR?=
 =?us-ascii?Q?RbbKV5cASofkhyfzct/OF8eFfRxUn1gBbHmTfvf7L7SxfNIcomx9kzdcF5h4?=
 =?us-ascii?Q?4RdrSO/1ywp4BpKm2BQvwsFXmuEQZvpwRHIm7lXtRoB61JBc5PHo0A4dDkPa?=
 =?us-ascii?Q?lG53Jb+rqpfUNecjHZulF60Y/m4ZF9haGUXHHUj3CuXAb1FNZqdpSmlOvdnl?=
 =?us-ascii?Q?t3sEQyJbTsdcxvU/y5YqABGejhbowvXng7K0H3rg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3127847b-3fdf-43d9-b571-08dc5d132ae9
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 06:13:28.9800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RhV7stdeOUlzpRa7AXcI8Shkyl/KvSZIiWP99qJA1w2gpTB0vzReZpqPsFvDih9SfV+vx8BDQH+RXQeNWS3I3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10117

Add JSON metrics for i.MX95 DDR Performance Monitor.

Reviewed-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v2:
 - fix wrong AXI_MASK setting
 - remove unnecessary metrics
 - add bandwidth_usage, camera_all, disp_all metrics
Changes in v3:
 - no changes
Changes in v4:
 - add Reviewed-by tag
Changes in v5:
 - fix typo
Changes in v6:
 - remove "counter=X" from each metric
Changes in v7:
 - add RB tag
Changes in v8:
 - no changes
Changes in v9:
 - no changes
Changes in v10:
 - no changes
---
 .../arch/arm64/freescale/imx95/sys/ddrc.json  |   9 +
 .../arm64/freescale/imx95/sys/metrics.json    | 778 ++++++++++++++++++
 tools/perf/pmu-events/jevents.py              |   1 +
 3 files changed, 788 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx95/sys/ddrc.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx95/sys/metrics.json

diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx95/sys/ddrc.json b/tools/perf/pmu-events/arch/arm64/freescale/imx95/sys/ddrc.json
new file mode 100644
index 000000000000..4dc9d2968bdc
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/freescale/imx95/sys/ddrc.json
@@ -0,0 +1,9 @@
+[
+   {
+           "BriefDescription": "ddr cycles event",
+           "EventCode": "0x00",
+           "EventName": "imx95_ddr.cycles",
+           "Unit": "imx9_ddr",
+           "Compat": "imx95"
+   }
+]
diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx95/sys/metrics.json b/tools/perf/pmu-events/arch/arm64/freescale/imx95/sys/metrics.json
new file mode 100644
index 000000000000..a3ae787d448c
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/freescale/imx95/sys/metrics.json
@@ -0,0 +1,778 @@
+[
+	{
+		"BriefDescription": "bandwidth usage for lpddr5 evk board",
+		"MetricName": "imx95_bandwidth_usage.lpddr5",
+		"MetricExpr": "(( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x000\\,axi_id\\=0x000@ + imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x000\\,axi_id\\=0x000@ ) * 32 / duration_time) / (6400 * 1000000 * 4)",
+		"ScaleUnit": "1e2%",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all masters read from ddr",
+		"MetricName": "imx95_ddr_read.all",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x000\\,axi_id\\=0x000@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all masters write to ddr",
+		"MetricName": "imx95_ddr_write.all",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x000\\,axi_id\\=0x000@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all a55 read from ddr",
+		"MetricName": "imx95_ddr_read.a55_all",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3fc\\,axi_id\\=0x000@ + imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x3fe\\,axi_id\\=0x004@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all a55 write to ddr (part1)",
+		"MetricName": "imx95_ddr_write.a55_all_1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3fc\\,axi_id\\=0x000@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all a55 write to ddr (part2)",
+		"MetricName": "imx95_ddr_write.a55_all_2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3fe\\,axi_id\\=0x004@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 0 read from ddr",
+		"MetricName": "imx95_ddr_read.a55_0",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3ff\\,axi_id\\=0x000@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 0 write to ddr",
+		"MetricName": "imx95_ddr_write.a55_0",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3ff\\,axi_id\\=0x000@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 1 read from ddr",
+		"MetricName": "imx95_ddr_read.a55_1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x00f\\,axi_id\\=0x001@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 1 write to ddr",
+		"MetricName": "imx95_ddr_write.a55_1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x001@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 2 read from ddr",
+		"MetricName": "imx95_ddr_read.a55_2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x00f\\,axi_id\\=0x002@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 2 write to ddr",
+		"MetricName": "imx95_ddr_write.a55_2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x002@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 3 read from ddr",
+		"MetricName": "imx95_ddr_read.a55_3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x00f\\,axi_id\\=0x003@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 3 write to ddr",
+		"MetricName": "imx95_ddr_write.a55_3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x003@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 4 read from ddr",
+		"MetricName": "imx95_ddr_read.a55_4",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x00f\\,axi_id\\=0x004@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 4 write to ddr",
+		"MetricName": "imx95_ddr_write.a55_4",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x004@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 5 read from ddr",
+		"MetricName": "imx95_ddr_read.a55_5",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x00f\\,axi_id\\=0x005@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 5 write to ddr",
+		"MetricName": "imx95_ddr_write.a55_5",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x005@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of Cortex-A DSU L3 evicted/ACP transactions read from ddr",
+		"MetricName": "imx95_ddr_read.cortexa_dsu_l3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x00f\\,axi_id\\=0x007@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of Cortex-A DSU L3 evicted/ACP transactions write to ddr",
+		"MetricName": "imx95_ddr_write.cortexa_dsu_l3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x007@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of m33 read from ddr",
+		"MetricName": "imx95_ddr_read.m33",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x00f\\,axi_id\\=0x008@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of m33 write to ddr",
+		"MetricName": "imx95_ddr_write.m33",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x008@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of m7 read from ddr",
+		"MetricName": "imx95_ddr_read.m7",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x00f\\,axi_id\\=0x009@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of m7 write to ddr",
+		"MetricName": "imx95_ddr_write.m7",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x009@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of sentinel read from ddr",
+		"MetricName": "imx95_ddr_read.sentinel",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x00f\\,axi_id\\=0x00a@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of sentinel write to ddr",
+		"MetricName": "imx95_ddr_write.sentinel",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x00a@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of edma1 read from ddr",
+		"MetricName": "imx95_ddr_read.edma1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x00f\\,axi_id\\=0x00b@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of edma1 write to ddr",
+		"MetricName": "imx95_ddr_write.edma1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x00b@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of edma2 read from ddr",
+		"MetricName": "imx95_ddr_read.edma2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x00f\\,axi_id\\=0x00c@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of edma2 write to ddr",
+		"MetricName": "imx95_ddr_write.edma2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x00c@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of netc read from ddr",
+		"MetricName": "imx95_ddr_read.netc",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x00f\\,axi_id\\=0x00d@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of netc write to ddr",
+		"MetricName": "imx95_ddr_write.netc",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x00d@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of npu read from ddr",
+		"MetricName": "imx95_ddr_read.npu",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3f0\\,axi_id\\=0x010@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of npu write to ddr",
+		"MetricName": "imx95_ddr_write.npu",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x010@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of gpu read from ddr",
+		"MetricName": "imx95_ddr_read.gpu",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x3f0\\,axi_id\\=0x020@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of gpu write to ddr",
+		"MetricName": "imx95_ddr_write.gpu",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x020@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of usdhc1 read from ddr",
+		"MetricName": "imx95_ddr_read.usdhc1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x3f0\\,axi_id\\=0x0b0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of usdhc1 write to ddr",
+		"MetricName": "imx95_ddr_write.usdhc1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x0b0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of usdhc2 read from ddr",
+		"MetricName": "imx95_ddr_read.usdhc2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3f0\\,axi_id\\=0x0c0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of usdhc2 write to ddr",
+		"MetricName": "imx95_ddr_write.usdhc2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x0c0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of usdhc3 read from ddr",
+		"MetricName": "imx95_ddr_read.usdhc3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x3f0\\,axi_id\\=0x0d0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of usdhc3 write to ddr",
+		"MetricName": "imx95_ddr_write.usdhc3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x0d0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of xspi read from ddr",
+		"MetricName": "imx95_ddr_read.xspi",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x3f0\\,axi_id\\=0x0f0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of xspi write to ddr",
+		"MetricName": "imx95_ddr_write.xspi",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x0f0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of pcie1 read from ddr",
+		"MetricName": "imx95_ddr_read.pcie1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3f0\\,axi_id\\=0x100@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of pcie1 write to ddr",
+		"MetricName": "imx95_ddr_write.pcie1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x100@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of pcie2 read from ddr",
+		"MetricName": "imx95_ddr_read.pcie2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x00f\\,axi_id\\=0x006@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of pcie2 write to ddr",
+		"MetricName": "imx95_ddr_write.pcie2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x00f\\,axi_id\\=0x006@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of pcie3 read from ddr",
+		"MetricName": "imx95_ddr_read.pcie3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x3f0\\,axi_id\\=0x120@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of pcie3 write to ddr",
+		"MetricName": "imx95_ddr_write.pcie3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x120@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of pcie4 read from ddr",
+		"MetricName": "imx95_ddr_read.pcie4",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3f0\\,axi_id\\=0x130@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of pcie4 write to ddr",
+		"MetricName": "imx95_ddr_write.pcie4",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x130@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of usb1 read from ddr",
+		"MetricName": "imx95_ddr_read.usb1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x3f0\\,axi_id\\=0x140@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of usb1 write to ddr",
+		"MetricName": "imx95_ddr_write.usb1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x140@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of usb2 read from ddr",
+		"MetricName": "imx95_ddr_read.usb2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x3f0\\,axi_id\\=0x150@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of usb2 write to ddr",
+		"MetricName": "imx95_ddr_write.usb2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x150@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of vpu codec primary bus read from ddr",
+		"MetricName": "imx95_ddr_read.vpu_primy",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3f0\\,axi_id\\=0x180@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of vpu codec primary bus write to ddr",
+		"MetricName": "imx95_ddr_write.vpu_primy",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x180@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of vpu codec secondary bus read from ddr",
+		"MetricName": "imx95_ddr_read.vpu_secndy",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x3f0\\,axi_id\\=0x190@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of vpu codec secondary bus write to ddr",
+		"MetricName": "imx95_ddr_write.vpu_secndy",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x190@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of jpeg decoder read from ddr",
+		"MetricName": "imx95_ddr_read.jpeg_dec",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x3f0\\,axi_id\\=0x1a0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of jpeg decoder write to ddr",
+		"MetricName": "imx95_ddr_write.jpeg_dec",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x1a0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of jpeg encoder read from ddr",
+		"MetricName": "imx95_ddr_read.jpeg_dec",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3f0\\,axi_id\\=0x1b0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of jpeg encoder write to ddr",
+		"MetricName": "imx95_ddr_write.jpeg_enc",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x1b0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all vpu submodules read from ddr",
+		"MetricName": "imx95_ddr_read.vpu_all",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x380\\,axi_id\\=0x180@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all vpu submodules write to ddr",
+		"MetricName": "imx95_ddr_write.vpu_all",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x380\\,axi_id\\=0x180@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of cortex m0+ read from ddr",
+		"MetricName": "imx95_ddr_read.m0",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x3f0\\,axi_id\\=0x200@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of cortex m0+ write to ddr",
+		"MetricName": "imx95_ddr_write.m0",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x200@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of camera edma read from ddr",
+		"MetricName": "imx95_ddr_read.camera_edma",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3f0\\,axi_id\\=0x210@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of camera edma write to ddr",
+		"MetricName": "imx95_ddr_write.camera_edma",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x210@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isi rd read from ddr",
+		"MetricName": "imx95_ddr_read.isi_rd",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x3f0\\,axi_id\\=0x220@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isi rd write to ddr",
+		"MetricName": "imx95_ddr_write.isi_rd",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x220@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isi wr y read from ddr",
+		"MetricName": "imx95_ddr_read.isi_wr_y",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x3f0\\,axi_id\\=0x230@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isi wr y write to ddr",
+		"MetricName": "imx95_ddr_write.isi_wr_y",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x230@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isi wr u read from ddr",
+		"MetricName": "imx95_ddr_read.isi_wr_u",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3f0\\,axi_id\\=0x240@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isi wr u write to ddr",
+		"MetricName": "imx95_ddr_write.isi_wr_u",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x240@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isi wr v read from ddr",
+		"MetricName": "imx95_ddr_read.isi_wr_v",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x3f0\\,axi_id\\=0x250@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isi wr v write to ddr",
+		"MetricName": "imx95_ddr_write.isi_wr_v",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x250@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isp input dma1 read from ddr",
+		"MetricName": "imx95_ddr_read.isp_in_dma1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x3f0\\,axi_id\\=0x260@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isp input dma1 write to ddr",
+		"MetricName": "imx95_ddr_write.isp_in_dma1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x260@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isp input dma2 read from ddr",
+		"MetricName": "imx95_ddr_read.isp_in_dma2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3f0\\,axi_id\\=0x270@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isp input dma2 write to ddr",
+		"MetricName": "imx95_ddr_write.isp_in_dma2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x270@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isp output dma1 read from ddr",
+		"MetricName": "imx95_ddr_read.isp_out_dma1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x3f0\\,axi_id\\=0x280@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isp output dma1 write to ddr",
+		"MetricName": "imx95_ddr_write.isp_out_dma1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x280@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isp output dma2 read from ddr",
+		"MetricName": "imx95_ddr_read.isp_out_dma2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x3f0\\,axi_id\\=0x290@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isp output dma2 write to ddr",
+		"MetricName": "imx95_ddr_write.isp_out_dma2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x290@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all camera submodules read from ddr",
+		"MetricName": "imx95_ddr_read.camera_all",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x380\\,axi_id\\=0x200@ + imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x3f0\\,axi_id\\=0x280@ + imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_mask\\=0x3f0\\,axi_id\\=0x290@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all camera submodules write to ddr (part1)",
+		"MetricName": "imx95_ddr_write.camera_all_1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x380\\,axi_id\\=0x200@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all camera submodules write to ddr (part2)",
+		"MetricName": "imx95_ddr_write.camera_all_2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x280@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all camera submodules write to ddr (part3)",
+		"MetricName": "imx95_ddr_write.camera_all_3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x290@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of display blitter store read from ddr",
+		"MetricName": "imx95_ddr_read.disp_blit",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x3f0\\,axi_id\\=0x2a0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of display blitter write to ddr",
+		"MetricName": "imx95_ddr_write.disp_blit",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x2a0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of display command sequencer read from ddr",
+		"MetricName": "imx95_ddr_read.disp_cmd",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x3f0\\,axi_id\\=0x2b0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of display command sequencer write to ddr",
+		"MetricName": "imx95_ddr_write.disp_cmd",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3f0\\,axi_id\\=0x2b0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all display submodules read from ddr",
+		"MetricName": "imx95_ddr_read.disp_all",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_mask\\=0x300\\,axi_id\\=0x300@ + imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_mask\\=0x3a0\\,axi_id\\=0x2a0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all display submodules write to ddr (part1)",
+		"MetricName": "imx95_ddr_write.disp_all_1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x300\\,axi_id\\=0x300@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all display submodules write to ddr (part2)",
+		"MetricName": "imx95_ddr_write.disp_all_2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_mask\\=0x3a0\\,axi_id\\=0x2a0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	}
+]
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index e42efc16723e..ac9b7ca41856 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -284,6 +284,7 @@ class JsonEvent:
           'hisi_sccl,hha': 'hisi_sccl,hha',
           'hisi_sccl,l3c': 'hisi_sccl,l3c',
           'imx8_ddr': 'imx8_ddr',
+          'imx9_ddr': 'imx9_ddr',
           'L3PMC': 'amd_l3',
           'DFPMC': 'amd_df',
           'UMCPMC': 'amd_umc',
-- 
2.34.1


