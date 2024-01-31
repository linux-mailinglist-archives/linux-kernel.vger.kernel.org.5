Return-Path: <linux-kernel+bounces-45792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E7B84364C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 06:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56F261C254CA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 05:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2D24120F;
	Wed, 31 Jan 2024 05:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ggtziJzB"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2084.outbound.protection.outlook.com [40.107.20.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495643FB1E;
	Wed, 31 Jan 2024 05:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706680350; cv=fail; b=l1515bx0rSjHxaFb7Zmdm7TQT2KikvJ3WKzdpd1yuZADo/rMW6UAFZ78pJFQ8pLmCnP4yWIgDTzUO6tq9a3vE+fMPh02d7bqUhk0PNDcyW8ochbXns96r/QT7pCVIXIdTkPqnLmdJvpKCgGiLrO36qXxLIPBR/0DBbQY9jdVK7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706680350; c=relaxed/simple;
	bh=DfA9jboq5OtzVjI4FFTRm8NHeDr0ag/yhpEkOeVMRcY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W2L9jbu7phJM1eWfQLHiplquTNq1SDwO6jyIWalygmxeVB6Jv/BGW0pC5AvJJbxwEDpxBMlY7550/yXo7s1SXGxx43HDeA5XW0lEQbHcxQAj0f8mKTDCQaO4/NgK2Ld9OhvP7RrMcSoPfzJrhxIGqqfCsAjKgxTGv4cnEiMGwr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ggtziJzB; arc=fail smtp.client-ip=40.107.20.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7w9SdIq0e7EEWy15DDxG9ZkXGf9Y5O4er6C/dyXWR4REvZYcLip5kyffqX3GqcvmgxoHQHcAXgdsY8D6Tuj6Fau2+VZPgKMc6J1ux89BKodpcwdoClL31tkIVbyFrJP2bF4jB5nug0oDvaTG/XAc5Ex+/wwZLnJS1pO9Gsi9UWRdxB1pNO3x9nVJieviGL84QqaDOfDql+MGOwO+MHalv4bUDGFuy7+vJptKynipLMnYqw8WxZ3aKMWbCC6Gkn05qrJztoeksNVEv2iUJ0QuqOEfhyEOOXMHybmDY6pS1kN3RUB3uafX58Il5UgXpkhEJIpUqU1V3ZiHWAoabUsWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ijqBS53jpwxQuBaklaWWA+q8qcJ7hUt2ppkqyFKfgOM=;
 b=RgzrwKtmGd2Z7/xOBaF1aOEQYbSBXFp11sIJph0+w7oXs6mQjXxMFy8MtmP7krOitkwe9VIW0k2l+r8C8kq+Y6NUtJxHaizbC/7NaIzenNvG8YTmf5jdS2Ux9QSB0LC0A3yFSVUbLUMc7SThLzVwxZ9HvcKO/TAM8JYBpZ4xhYY0FZhSR5pQbpuAJylgOQEejr1SQC1p51dp3SoxhU8X25LqkmfesU1lZyWLyW77Uow0DSzjhizDPN14DtfucNQqZIaOnWZhVvUjpi2+dvTkz0ms2KYcVwkzDKf5zoniClBHp9tLUcsAvblmYgI0Tno0Q/mRwErzahePqoPOmayNsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijqBS53jpwxQuBaklaWWA+q8qcJ7hUt2ppkqyFKfgOM=;
 b=ggtziJzBs8+VIwPuYC8IblfG6wKkv5637zoFk4ZyuscKZJ79vF6tBUyZpSRWoYA1Xe1epvQxnBEtmGVloPM3Qd/sionrvSsHYtDtVX5an+UpxWOca5Qnvdsh1QYbit+MGAJLHZv2Ux0pkPVTwl7FidvfSqCIBoU40/6hRK1Wj78=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DU2PR04MB8917.eurprd04.prod.outlook.com (2603:10a6:10:2e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Wed, 31 Jan
 2024 05:52:23 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 05:52:23 +0000
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
Cc: linux-imx@nxp.com,
	mike.leach@linaro.org,
	leo.yan@linaro.org,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	alexander.shishkin@linux.intel.com,
	adrian.hunter@intel.com,
	xu.yang_2@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v4 6/6] perf vendor events arm64:: Add i.MX95 DDR Performane Monitor metrics
Date: Wed, 31 Jan 2024 13:58:11 +0800
Message-Id: <20240131055811.3035741-6-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131055811.3035741-1-xu.yang_2@nxp.com>
References: <20240131055811.3035741-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:196::20) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|DU2PR04MB8917:EE_
X-MS-Office365-Filtering-Correlation-Id: e65eb295-f083-4715-f032-08dc2220cbc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9Svdu25oPHoB9eifaXIhzq/iMlx9M3xiQkPBksd+QAS/9xW6l8rFZTqRuEbnzj4uytFqlQeo4O0ndpO3Vx41TFO9dE5dZ97iUBINkLuwiikLNRTMO99MdZDK74ZbA003MELlHUBMGHSmtHxrxQrT1cxaIfFbyoRh1O/Ui3SFRplHfWT7m7TNNa9s3DbdxdsvfODuxFC/2CCbW2ArjYHpid/iQgPio3L1Zk44OBYAPEBDD/08N2zqYOondvQgyq+iZvpg197cWntF1e+Cetw+1nSB8BTTK1D9MxTHIBb82J7B8dxTCOM44AeYgeLbU38UnOaHUQQNWMKXS1T3X5BTYZbNnjGyIjqrg68iwuzi+H8BlIGl0ZsyAimu1ttiphP1WgCwnat5/9c4E4WJyNhDZkEHuiUEFIQPUibJfKMtED9k6dCzFqXo4UwaT037wwZdG/MyecbotFd2HVxUHWz8OAVWXpigs7NuyUVCG8MuGzBixwMxwPJlBOTv+hnJcKOuoPiU+hUXkZ/J+SRkH5Ll3dscOB6kh673+Diee5ZVtSaQVxEgd5hZqIbcJmwl7ILFcqqMmNEWGS1sD7qmXfqRaQHaXW4XQE0+1EZuvouDOZ089wuPOATv/U+1iQsjbui/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(396003)(366004)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(38350700005)(30864003)(2906002)(36756003)(41300700001)(921011)(66946007)(66556008)(66476007)(316002)(86362001)(6666004)(2616005)(1076003)(6512007)(52116002)(6506007)(26005)(478600001)(6486002)(5660300002)(38100700002)(8936002)(8676002)(7416002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xt/ggXHRuVOsaluPyXefUZ+t909EkSXEIamGSdg66eEMXkmu4xsIoo5gxTnN?=
 =?us-ascii?Q?ECJaisJ971xTQgjeMhlWsikF25OXNNaFzV6GPZrlf/2aMBcuNGaM9FUeHITK?=
 =?us-ascii?Q?6gIPxKn6N/MiFw3Ck/wzAMht80C1mQVxoKKq3v8ZL0XdwUrSuh+wL+o5alqi?=
 =?us-ascii?Q?6RaW4PJ6u4vvKj2rx0IpK8uOmgj6yaRM6+hSZWFGGoKkF7kYK4FT6ENhaYVd?=
 =?us-ascii?Q?I2xPuNS322dyFL0N53EWxGIWH2w9BcFQI6K+yeTZ01EC98+e02mZ1SgGE0as?=
 =?us-ascii?Q?+GfVhXLp395iFlCLoy+ka94dwLAcF574MCMThV/7RyE36XhSeFNDdFxEaAbY?=
 =?us-ascii?Q?8LqY5V2xF70qGEalUNJYr8sjQczPbl64kLfyP7/x4KndG5eQOVe6a5u4eNv2?=
 =?us-ascii?Q?aR5LL8YW8GauX3q8VQazESJ50napAjkWMSRXmxNJVGPLaI7cocx8WkRyPezr?=
 =?us-ascii?Q?asl4eijoLcQ/1ayb27y6+if0/s8dzOzLmmal+RuF9h7FO0zVDiKOocMG2fga?=
 =?us-ascii?Q?2/cN+2ALQzKMm58kP3YywesSxdIAG6K1vr+zkUwodW7WMuvUofgQfCB7dGsC?=
 =?us-ascii?Q?BciES06h2tDbIUrtCqHNX/wIXwkmnUF7GBcQ7A9EghrJXKNfyQ88rs43ahbz?=
 =?us-ascii?Q?Gi6M2MVFLoJpc+SQ1GrTtKfblQsOlkT1fxesxCk4Sf/LdjOFsdWLC2ePmA5n?=
 =?us-ascii?Q?ThFjv7XyfGKXWjgAEbNjPTqyS1+h8UgauqxaWO68ytMdqUCy9mFGg1JFUgzE?=
 =?us-ascii?Q?DId2KIHl+HYAHOXMkwXSI7JNntWinn6rEXKeyqfEQFhzi6YB4pbe83Ef0xra?=
 =?us-ascii?Q?h3f98WPmEmVgH3Ji4XgUr1wpacV5WvaYzbw74jGHwmdSPjJe6CMwuod48PUY?=
 =?us-ascii?Q?uaaSMMOyKLed6/HdUAkRjPyVJYYcQkmEz0CYS2uIAnXVsK8NBTy5yfrHC/EI?=
 =?us-ascii?Q?B+CFksT3l0CftojPmjZocoR8JYivTYUDqeewe6JJuDgrn+vAzK7495zCWBIa?=
 =?us-ascii?Q?Fo6XYe98hS9L9+ihAcZQKZMBer0KZPi77nhuQjB4FEiiJarqiFGqehfivhXV?=
 =?us-ascii?Q?iYbU6MoDHWckD0Y92hUHWqqKTaLjhRgNU/dHgLy4kXs36v7z8nhhPZcpgIDk?=
 =?us-ascii?Q?w1W5kQotsRbdqX9jS0OogC/GTw74YhWDzj24RNuXTWnE480U8ug+Hw1FiRdb?=
 =?us-ascii?Q?3kI79S8WqOyFzxZjXDqRk2EwnPZ4v0k20zgh70aQYZ8fGIvhegVOiMvoI2r8?=
 =?us-ascii?Q?HnKu6AfB7oobEk/P89ivpGVNkhhfk4lzm50eaOQ4isElAxalCiOWENzONE41?=
 =?us-ascii?Q?+OQHMSoVe+0jXluIErlExxzA/jOxHn2RGLr6IYEhVrQREmAyptR675hwVYTJ?=
 =?us-ascii?Q?id71UMQmwFhJO6ck2UbaxKTrTk1RRs2AwGtEXyzzKVjynpWSjoftKPtVEz+u?=
 =?us-ascii?Q?ewwWGCBKimz3c2jxktP86DKkYP/ZhOv5GCDQbCdwMxmB/KO4ZK2KxkYhi1RY?=
 =?us-ascii?Q?plgzVrFWF7dqHOlTD6cLNw1ap5ghvur/EUp7y/B9R5ZMpFBiQqD39TYWd6Qz?=
 =?us-ascii?Q?t1EZ2k3g/fdJepsZH4TQnfl3ThxTXHMZ9XTaxbyO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e65eb295-f083-4715-f032-08dc2220cbc2
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 05:52:23.6188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LIyDZyWXP92yl5jlrynHlLT6x8VD7jJdrGhaWhWWqxmxf1v99nZ23+awSwWkSOqdxB0tDoGlYVTf8i6fsNdMvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8917

Add JSON metrics for i.MX95 DDR Performane Monitor.

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
index 000000000000..2bfcd4d574a8
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/freescale/imx95/sys/metrics.json
@@ -0,0 +1,778 @@
+[
+	{
+		"BriefDescription": "bandwidth usage for lpddr5 evk board",
+		"MetricName": "imx95_bandwidth_usage.lpddr5",
+		"MetricExpr": "(( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x000\\,axi_id\\=0x000@ + imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x000\\,axi_id\\=0x000@ ) * 32 / duration_time) / (6400 * 1000000 * 4)",
+		"ScaleUnit": "1e2%",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all masters read from ddr",
+		"MetricName": "imx95_ddr_read.all",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x000\\,axi_id\\=0x000@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all masters write to ddr",
+		"MetricName": "imx95_ddr_write.all",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x000\\,axi_id\\=0x000@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all a55 read from ddr",
+		"MetricName": "imx95_ddr_read.a55_all",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x3fc\\,axi_id\\=0x000@ + imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,counter\\=4\\,axi_mask\\=0x3fe\\,axi_id\\=0x004@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all a55 write to ddr (part1)",
+		"MetricName": "imx95_ddr_write.a55_all_1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3fc\\,axi_id\\=0x000@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all a55 write to ddr (part2)",
+		"MetricName": "imx95_ddr_write.a55_all_2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3fe\\,axi_id\\=0x004@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 0 read from ddr",
+		"MetricName": "imx95_ddr_read.a55_0",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x3ff\\,axi_id\\=0x000@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 0 write to ddr",
+		"MetricName": "imx95_ddr_write.a55_0",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3ff\\,axi_id\\=0x000@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 1 read from ddr",
+		"MetricName": "imx95_ddr_read.a55_1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,counter\\=4\\,axi_mask\\=0x00f\\,axi_id\\=0x001@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 1 write to ddr",
+		"MetricName": "imx95_ddr_write.a55_1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x00f\\,axi_id\\=0x001@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 2 read from ddr",
+		"MetricName": "imx95_ddr_read.a55_2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,counter\\=3\\,axi_mask\\=0x00f\\,axi_id\\=0x002@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 2 write to ddr",
+		"MetricName": "imx95_ddr_write.a55_2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x00f\\,axi_id\\=0x002@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 3 read from ddr",
+		"MetricName": "imx95_ddr_read.a55_3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x00f\\,axi_id\\=0x003@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 3 write to ddr",
+		"MetricName": "imx95_ddr_write.a55_3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x00f\\,axi_id\\=0x003@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 4 read from ddr",
+		"MetricName": "imx95_ddr_read.a55_4",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,counter\\=4\\,axi_mask\\=0x00f\\,axi_id\\=0x004@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 4 write to ddr",
+		"MetricName": "imx95_ddr_write.a55_4",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x00f\\,axi_id\\=0x004@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 5 read from ddr",
+		"MetricName": "imx95_ddr_read.a55_5",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,counter\\=3\\,axi_mask\\=0x00f\\,axi_id\\=0x005@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of a55 core 5 write to ddr",
+		"MetricName": "imx95_ddr_write.a55_5",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x00f\\,axi_id\\=0x005@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of Cortex-A DSU L3 evicted/ACP transactions read from ddr",
+		"MetricName": "imx95_ddr_read.cortexa_dsu_l3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x00f\\,axi_id\\=0x007@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of Cortex-A DSU L3 evicted/ACP transactions write to ddr",
+		"MetricName": "imx95_ddr_write.cortexa_dsu_l3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x00f\\,axi_id\\=0x007@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of m33 read from ddr",
+		"MetricName": "imx95_ddr_read.m33",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x00f\\,axi_id\\=0x008@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of m33 write to ddr",
+		"MetricName": "imx95_ddr_write.m33",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x00f\\,axi_id\\=0x008@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of m7 read from ddr",
+		"MetricName": "imx95_ddr_read.m7",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,counter\\=4\\,axi_mask\\=0x00f\\,axi_id\\=0x009@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of m7 write to ddr",
+		"MetricName": "imx95_ddr_write.m7",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x00f\\,axi_id\\=0x009@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of sentinel read from ddr",
+		"MetricName": "imx95_ddr_read.sentinel",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,counter\\=3\\,axi_mask\\=0x00f\\,axi_id\\=0x00a@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of sentinel write to ddr",
+		"MetricName": "imx95_ddr_write.sentinel",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x00f\\,axi_id\\=0x00a@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of edma1 read from ddr",
+		"MetricName": "imx95_ddr_read.edma1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x00f\\,axi_id\\=0x00b@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of edma1 write to ddr",
+		"MetricName": "imx95_ddr_write.edma1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x00f\\,axi_id\\=0x00b@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of edma2 read from ddr",
+		"MetricName": "imx95_ddr_read.edma2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,counter\\=4\\,axi_mask\\=0x00f\\,axi_id\\=0x00c@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of edma2 write to ddr",
+		"MetricName": "imx95_ddr_write.edma2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x00f\\,axi_id\\=0x00c@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of netc read from ddr",
+		"MetricName": "imx95_ddr_read.netc",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,counter\\=3\\,axi_mask\\=0x00f\\,axi_id\\=0x00d@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of netc write to ddr",
+		"MetricName": "imx95_ddr_write.netc",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x00f\\,axi_id\\=0x00d@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of npu read from ddr",
+		"MetricName": "imx95_ddr_read.npu",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x3f0\\,axi_id\\=0x010@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of npu write to ddr",
+		"MetricName": "imx95_ddr_write.npu",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3f0\\,axi_id\\=0x010@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of gpu read from ddr",
+		"MetricName": "imx95_ddr_read.gpu",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,counter\\=4\\,axi_mask\\=0x3f0\\,axi_id\\=0x020@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of gpu write to ddr",
+		"MetricName": "imx95_ddr_write.gpu",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3f0\\,axi_id\\=0x020@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of usdhc1 read from ddr",
+		"MetricName": "imx95_ddr_read.usdhc1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,counter\\=3\\,axi_mask\\=0x3f0\\,axi_id\\=0x0b0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of usdhc1 write to ddr",
+		"MetricName": "imx95_ddr_write.usdhc1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3f0\\,axi_id\\=0x0b0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of usdhc2 read from ddr",
+		"MetricName": "imx95_ddr_read.usdhc2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x3f0\\,axi_id\\=0x0c0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of usdhc2 write to ddr",
+		"MetricName": "imx95_ddr_write.usdhc2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3f0\\,axi_id\\=0x0c0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of usdhc3 read from ddr",
+		"MetricName": "imx95_ddr_read.usdhc3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,counter\\=4\\,axi_mask\\=0x3f0\\,axi_id\\=0x0d0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of usdhc3 write to ddr",
+		"MetricName": "imx95_ddr_write.usdhc3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3f0\\,axi_id\\=0x0d0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of xspi read from ddr",
+		"MetricName": "imx95_ddr_read.xspi",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,counter\\=3\\,axi_mask\\=0x3f0\\,axi_id\\=0x0f0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of xspi write to ddr",
+		"MetricName": "imx95_ddr_write.xspi",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3f0\\,axi_id\\=0x0f0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of pcie1 read from ddr",
+		"MetricName": "imx95_ddr_read.pcie1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x3f0\\,axi_id\\=0x100@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of pcie1 write to ddr",
+		"MetricName": "imx95_ddr_write.pcie1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3f0\\,axi_id\\=0x100@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of pcie2 read from ddr",
+		"MetricName": "imx95_ddr_read.pcie2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,counter\\=4\\,axi_mask\\=0x00f\\,axi_id\\=0x006@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of pcie2 write to ddr",
+		"MetricName": "imx95_ddr_write.pcie2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x00f\\,axi_id\\=0x006@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of pcie3 read from ddr",
+		"MetricName": "imx95_ddr_read.pcie3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,counter\\=3\\,axi_mask\\=0x3f0\\,axi_id\\=0x120@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of pcie3 write to ddr",
+		"MetricName": "imx95_ddr_write.pcie3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3f0\\,axi_id\\=0x120@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of pcie4 read from ddr",
+		"MetricName": "imx95_ddr_read.pcie4",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x3f0\\,axi_id\\=0x130@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of pcie4 write to ddr",
+		"MetricName": "imx95_ddr_write.pcie4",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3f0\\,axi_id\\=0x130@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of usb1 read from ddr",
+		"MetricName": "imx95_ddr_read.usb1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,counter\\=4\\,axi_mask\\=0x3f0\\,axi_id\\=0x140@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of usb1 write to ddr",
+		"MetricName": "imx95_ddr_write.usb1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3f0\\,axi_id\\=0x140@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of usb2 read from ddr",
+		"MetricName": "imx95_ddr_read.usb2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,counter\\=3\\,axi_mask\\=0x3f0\\,axi_id\\=0x150@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of usb2 write to ddr",
+		"MetricName": "imx95_ddr_write.usb2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3f0\\,axi_id\\=0x150@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of vpu codec primary bus read from ddr",
+		"MetricName": "imx95_ddr_read.vpu_primy",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x3f0\\,axi_id\\=0x180@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of vpu codec primary bus write to ddr",
+		"MetricName": "imx95_ddr_write.vpu_primy",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3f0\\,axi_id\\=0x180@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of vpu codec secondary bus read from ddr",
+		"MetricName": "imx95_ddr_read.vpu_secndy",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,counter\\=4\\,axi_mask\\=0x3f0\\,axi_id\\=0x190@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of vpu codec secondary bus write to ddr",
+		"MetricName": "imx95_ddr_write.vpu_secndy",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3f0\\,axi_id\\=0x190@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of jpeg decoder read from ddr",
+		"MetricName": "imx95_ddr_read.jpeg_dec",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,counter\\=3\\,axi_mask\\=0x3f0\\,axi_id\\=0x1a0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of jpeg decoder write to ddr",
+		"MetricName": "imx95_ddr_write.jpeg_dec",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3f0\\,axi_id\\=0x1a0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of jpeg encoder read from ddr",
+		"MetricName": "imx95_ddr_read.jpeg_dec",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x3f0\\,axi_id\\=0x1b0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of jpeg encoder write to ddr",
+		"MetricName": "imx95_ddr_write.jpeg_enc",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3f0\\,axi_id\\=0x1b0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all vpu submodules read from ddr",
+		"MetricName": "imx95_ddr_read.vpu_all",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,counter\\=4\\,axi_mask\\=0x380\\,axi_id\\=0x180@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all vpu submodules write to ddr",
+		"MetricName": "imx95_ddr_write.vpu_all",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x380\\,axi_id\\=0x180@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of cortex m0+ read from ddr",
+		"MetricName": "imx95_ddr_read.m0",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,counter\\=3\\,axi_mask\\=0x3f0\\,axi_id\\=0x200@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of cortex m0+ write to ddr",
+		"MetricName": "imx95_ddr_write.m0",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3f0\\,axi_id\\=0x200@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of camera edma read from ddr",
+		"MetricName": "imx95_ddr_read.camera_edma",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x3f0\\,axi_id\\=0x210@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of camera edma write to ddr",
+		"MetricName": "imx95_ddr_write.camera_edma",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3f0\\,axi_id\\=0x210@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isi rd read from ddr",
+		"MetricName": "imx95_ddr_read.isi_rd",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,counter\\=4\\,axi_mask\\=0x3f0\\,axi_id\\=0x220@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isi rd write to ddr",
+		"MetricName": "imx95_ddr_write.isi_rd",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3f0\\,axi_id\\=0x220@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isi wr y read from ddr",
+		"MetricName": "imx95_ddr_read.isi_wr_y",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,counter\\=3\\,axi_mask\\=0x3f0\\,axi_id\\=0x230@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isi wr y write to ddr",
+		"MetricName": "imx95_ddr_write.isi_wr_y",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3f0\\,axi_id\\=0x230@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isi wr u read from ddr",
+		"MetricName": "imx95_ddr_read.isi_wr_u",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x3f0\\,axi_id\\=0x240@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isi wr u write to ddr",
+		"MetricName": "imx95_ddr_write.isi_wr_u",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3f0\\,axi_id\\=0x240@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isi wr v read from ddr",
+		"MetricName": "imx95_ddr_read.isi_wr_v",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,counter\\=4\\,axi_mask\\=0x3f0\\,axi_id\\=0x250@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isi wr v write to ddr",
+		"MetricName": "imx95_ddr_write.isi_wr_v",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3f0\\,axi_id\\=0x250@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isp input dma1 read from ddr",
+		"MetricName": "imx95_ddr_read.isp_in_dma1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,counter\\=3\\,axi_mask\\=0x3f0\\,axi_id\\=0x260@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isp input dma1 write to ddr",
+		"MetricName": "imx95_ddr_write.isp_in_dma1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3f0\\,axi_id\\=0x260@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isp input dma2 read from ddr",
+		"MetricName": "imx95_ddr_read.isp_in_dma2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x3f0\\,axi_id\\=0x270@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isp input dma2 write to ddr",
+		"MetricName": "imx95_ddr_write.isp_in_dma2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3f0\\,axi_id\\=0x270@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isp output dma1 read from ddr",
+		"MetricName": "imx95_ddr_read.isp_out_dma1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,counter\\=4\\,axi_mask\\=0x3f0\\,axi_id\\=0x280@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isp output dma1 write to ddr",
+		"MetricName": "imx95_ddr_write.isp_out_dma1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3f0\\,axi_id\\=0x280@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isp output dma2 read from ddr",
+		"MetricName": "imx95_ddr_read.isp_out_dma2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,counter\\=3\\,axi_mask\\=0x3f0\\,axi_id\\=0x290@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of isp output dma2 write to ddr",
+		"MetricName": "imx95_ddr_write.isp_out_dma2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3f0\\,axi_id\\=0x290@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all camera submodules read from ddr",
+		"MetricName": "imx95_ddr_read.camera_all",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x380\\,axi_id\\=0x200@ + imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,counter\\=4\\,axi_mask\\=0x3f0\\,axi_id\\=0x280@ + imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,counter\\=3\\,axi_mask\\=0x3f0\\,axi_id\\=0x290@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all camera submodules write to ddr (part1)",
+		"MetricName": "imx95_ddr_write.camera_all_1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x380\\,axi_id\\=0x200@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all camera submodules write to ddr (part2)",
+		"MetricName": "imx95_ddr_write.camera_all_2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3f0\\,axi_id\\=0x280@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all camera submodules write to ddr (part3)",
+		"MetricName": "imx95_ddr_write.camera_all_3",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3f0\\,axi_id\\=0x290@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of display blitter store read from ddr",
+		"MetricName": "imx95_ddr_read.disp_blit",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x3f0\\,axi_id\\=0x2a0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of display blitter write to ddr",
+		"MetricName": "imx95_ddr_write.disp_blit",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3f0\\,axi_id\\=0x2a0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of display command sequencer read from ddr",
+		"MetricName": "imx95_ddr_read.disp_cmd",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,counter\\=4\\,axi_mask\\=0x3f0\\,axi_id\\=0x2b0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of display command sequencer write to ddr",
+		"MetricName": "imx95_ddr_write.disp_cmd",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3f0\\,axi_id\\=0x2b0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all display submodules read from ddr",
+		"MetricName": "imx95_ddr_read.disp_all",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,counter\\=5\\,axi_mask\\=0x300\\,axi_id\\=0x300@ + imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,counter\\=4\\,axi_mask\\=0x3a0\\,axi_id\\=0x2a0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all display submodules write to ddr (part1)",
+		"MetricName": "imx95_ddr_write.disp_all_1",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x300\\,axi_id\\=0x300@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	},
+	{
+		"BriefDescription": "bytes of all display submodules write to ddr (part2)",
+		"MetricName": "imx95_ddr_write.disp_all_2",
+		"MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,counter\\=2\\,axi_mask\\=0x3a0\\,axi_id\\=0x2a0@ ) * 32",
+		"ScaleUnit": "9.765625e-4KB",
+		"Unit": "imx9_ddr",
+		"Compat": "imx95"
+	}
+]
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 53ab050c8fa4..be4b541a0820 100755
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


