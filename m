Return-Path: <linux-kernel+bounces-104228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B11D487CAF0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4FB51C22023
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6119718624;
	Fri, 15 Mar 2024 09:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PGaTpbOY"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2053.outbound.protection.outlook.com [40.107.21.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BA31B597;
	Fri, 15 Mar 2024 09:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710496585; cv=fail; b=Cpz4MrkrIKd4lEHI2oBUwRG7xlXXPUxG0onTRlsEvEGgzBag7d448BLLRSjV+g1Kv5WTf305QnEkK6icKmLnkgbmUwHjZFrFxKi0FXk4GuILhS35jxFPM//G5qe/OiAVjuI/fVDlhAWKMUUJ30gfc+LJcuU0ZDiwM3QwHa95Ahk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710496585; c=relaxed/simple;
	bh=xbFNVITbmd1tzj8lANbiUA9dzJ7KbSb0NICDz3cEPyI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dPs7/wrrBpuZgcjY9jtwGzqMs9HMC5egUezy5wAWA+LIkvGdL5hj0up6I9B4pznAS7xL4GwCBUzKk6PR6wwbwQL+3s4wP7xkjQXzVDH97xmgBqp6MJ7td9UWsyaiYHm3lJRiblpYMFS910BY118foqFMOpkJcwBu5i9geytHzYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=PGaTpbOY; arc=fail smtp.client-ip=40.107.21.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZAgOJVOjuQgfxj/AYgXiiLGMQHfh4EjNYzZpHnt92jwJXZ9hyEessQxAEdyJ2RO0DuY4rSK96r3vG73dt9mf3wgn3nciO9lp8qtq8n3BhwNtwiZeOG91yU+xzlcvdLHKdGSN9rAAXNevcnHrwlZBhNX0ts7shA5XjErWEzDBZ2qmIdyR21EAkXcmzUNLl4bmsnCWTmSMSskVVnZrglzilOW+ZBhCyv/KzjWzkTSY2b451fe3jFVrcitrZBu7HbxdEsKOdv/EZUyhk2NA/AP0r2BwVZS8gkwndCvHU80Z1SCm9iwenWn/H89sbPF4HGMHAFKZlF1XHJ6jsTy71jxHKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NN2dPQSVYZ16l0Ek6H80W/jszQp+QmiMrvz2VJqKC8c=;
 b=fZe9RScF2SRBzX2vVKH0GFSpyPcVgwgkKJhYU0SHWiXHHwOFnd7y/s+KhIoo4q2NaVGAVT+hsprBMWHfS8gWr9m8nLPHbmCKjJbGg13c3mt3tE9q842O9fTCaFFDr9V7fZD+0MdCH/XfgNNDLnXoVJ7eTxwaNU2xZjSwGOlUnAXAFMOZ1Oidd+TQgnSAmTDN/8RoYFySsEsByiKfCWfBGTwAwRQGnMRc/dLQx9r6dJjiuLn+ozAc/SwbSRaDyPzdAMRaEPxs3dWhbyUoQzyLVPAzslEBvtnpyECTWcp+pXW17n+L1mGhPcV+ChXQmk1dmqYj31BaEMyR5cQFl/nrXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NN2dPQSVYZ16l0Ek6H80W/jszQp+QmiMrvz2VJqKC8c=;
 b=PGaTpbOYn5OJg4IZ4uWLjiRSWfZcFw6E0XMmbkNAX2VrQMuTpdyLJGYwr3JzG5zLSb5deorKRCFpZQny3mlBNDWaIACnRWJ4m7upVvB2J66pYCsrOvIC8dp3kNzRogasLviBrcEDaUYsyJjrAgdp69Wg0p/c4PLIur4SrFYx0U4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AM8PR04MB7444.eurprd04.prod.outlook.com (2603:10a6:20b:1de::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Fri, 15 Mar
 2024 09:56:20 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7386.021; Fri, 15 Mar 2024
 09:56:20 +0000
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
Subject: [PATCH v7 6/8] perf: imx_perf: add support for i.MX95 platform
Date: Fri, 15 Mar 2024 17:55:53 +0800
Message-Id: <20240315095555.2628684-6-xu.yang_2@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3351a12f-c169-4e74-b1b1-08dc44d62a24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wUQmysr0gmpYHDfwqT/ormktyNo+ii4DNoT1WLB4CU8nEMptoGbNbDwoRXmpclxSuy+JqIk6Lc0iHdPjIxkSzCJHf/A8C/8FSlHZFkO4z6y8OBGWwL2qFic9NHvRIutGL7OfInDOzVK2kH+lBnhOnPArq6hyEFz8nlzX2MAohmdr7tp/eJ1lbLDx7OeIUcBLIesoD/y+JB4FytYUD0rP7D2N5ZUMLlxK+GBTO7WPE4KBpMW6GMZPXFIrd0qjxAHcFLX5S0oTRIAEsCT10eeqZGHvilz4mRcQkGD9EAkxHojdr2wyAEBh2ZY0+1OBq3ZbmZVkecLh4v1Zu7kx7Gq6FlJRvblZ90p8CWLYTMG2tcuy+T7yzH0cQ4XQYhk8mG/DxrA2RJbvKgSwm/J5rPKK8DTxCmLxk6ZfJX3NnD7Msz0NNI6ozSi9c2rQQf9vZEu39h0u39GWSYfL+PSCBm3pAEswbwOo9HyoRNvbNqVy5R6T5k5OSSVJKNPf/xfPFAAA+QqqzpLuYkZTYCcZ5N3Ls6NdrzbYJpVZoZ5vGRq9oOUGaAQ3Vr+Dj6CBnCyg91QpnfopAHLQEz88z/14sY413ypbFir0MS8WrYE38PTfBL9JKLkRTzCcgaz8wOC05PlOmkkwUaPYFEZpNqcjIvrKnJanjnRiE9aS2HcLmrJA6uUR9CYN6S1c1HfiwXSTwaYjOroA45eJ0nDpwQknZAVhvQczz03ZUZ44xPFeFMh+xto=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005)(52116005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QWxfA6VkVF+TafexAV57TC8bLo4AxaTAmD2cM/WnMTOahXbb0upwHbNhkuls?=
 =?us-ascii?Q?2XQxJXG2C5epGhgtQrSAPXr+Dbb8dhSI7jlT4iCfFAyASpa3FXPui/IXdr/m?=
 =?us-ascii?Q?PdyBWB6xet5w1NLwmK88PzGJpQ3hFEyptbT6HYjGzBjq4RUDI4bXkEPRWYzD?=
 =?us-ascii?Q?/p0bxeNJ3jKEsgam4jkYx/XTvK+xdOyYJ9mHMYqwkwV04kLP4gru/wTRpSzs?=
 =?us-ascii?Q?GZECgYUFUvPGh/C6m9MhqMvRS8TDHQNsY+dR0CBhu+SRFw6xq1jtWx7Zu12N?=
 =?us-ascii?Q?rBPmMt5821Zc0cAV4TmxGSa5H808KV2LS4i/ll6/sPF7LadLOg6iEIoyXZpY?=
 =?us-ascii?Q?dWsQwcVRCxk2bxtX2h0XZz91TdX5sQm+RHwLPVSE83gNbfpNEz3B4bqW2/MR?=
 =?us-ascii?Q?NsHsCMIhA7mLLPBXwkgB23SXWWJRp1GnGJmbLu1jLqhbruOaS8R1QvJ44CWl?=
 =?us-ascii?Q?i5zuGeBol31oc8GU7yzQOHlo17Jljw3GZMuurxmykxgmsGi8vg44lx7ZMAcC?=
 =?us-ascii?Q?ik141m0Y0lmDODyY7kx7z+/f25ktCbLcPRBmtIyjHhBq1TtYAyU00LwwEgzJ?=
 =?us-ascii?Q?wh1SdBEdYQEgfn9L8HpIVcWZWDsUGKIc1FfFjcTd18DlIp32WJXK1erFkawP?=
 =?us-ascii?Q?IxGtXpgWbnnVfyNg0hk+2GKOJ3MNViOY65UPgnLw3fv/KUIQvx/awXweV/C9?=
 =?us-ascii?Q?X64HNczf/hpKqQnjFgpRreNKozV59Pofp3NYeYaMzcON+dD+hW3AuW/UoXN4?=
 =?us-ascii?Q?fHmWxNXAx++8c5Aumn++vkzpl0ZrqIN+JlqpuReWhNoAsjODAfpb6DTs3yZ2?=
 =?us-ascii?Q?wvmLHF6gaf89fgYyarqvoX2mVhIkyJH6XgAlHvw/gOr9e+lawYKtFa/D6pys?=
 =?us-ascii?Q?Dr9q7otUtwbRUkf9ZY8gNFfOvm81JAjkZ8VIBrhX1mppd8QwHPnaSL1+naDg?=
 =?us-ascii?Q?VIhcUo+5CP2FH37q1W3QWqulmRmBa0Guj84V/tKN1utSsh7bo4RjaXc/hP6s?=
 =?us-ascii?Q?2JKWpwTgCKJ1LyYAjNq5cIxEmbGIRl6tpviYuEIQGgeJVMzg2IcqU3rK2RTt?=
 =?us-ascii?Q?i8Y0kJkjHV42EpsHNxpshiy8Z4X2mzfdx+9/zDwexcWrBA4ysCqblP4ZhTTv?=
 =?us-ascii?Q?vhwjZnBG/JSghqcMk2x43PjD14nikqGNJPlcR/3Tgwr0ulDWKTSG8hgLOg8C?=
 =?us-ascii?Q?kg79xiEGlFMq7iQUvqn7273cEO2O3ywGWJbseRMU23YwiZlX/RGozRbUlhKm?=
 =?us-ascii?Q?e7zkQSqRODqBu5ND3Z3yMHDQu8UvqKmmBwGscDf6BEhJdG8RygIkay2KHZvl?=
 =?us-ascii?Q?iApDQGBOGqh9L/eaxuSIdOXioifm/P5+tNUZi3MRcJs6jgJti0OVgV32yk4m?=
 =?us-ascii?Q?RNQx4f0SdV0kKuRrygM2ZpqEHkGfqBlH6aPdWyvqb+zeYNC8SQ0vPxH61CO+?=
 =?us-ascii?Q?O+q2fTie9AqexfPIaHhucKWz8hiJ5msiD2Myc0zzFc5RM2694mqv1HnU+zmn?=
 =?us-ascii?Q?XuX5b6j7Dfnud90kRvFUdk2DclwxdmOuaZHHA+QS6TC65Z8YfCYeeiIHVQ2L?=
 =?us-ascii?Q?RY6h5XJC1dLJAUafjzvm/NVK4vfXn8fSNy+zwspM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3351a12f-c169-4e74-b1b1-08dc44d62a24
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 09:56:20.2327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wz1c8cetM5PxN1sA7sZ3ygB4vwCBAucnBfx5+4aOP1aEEAmV79uoCl1W2rvXdb+0GH30ff7QTHAobSL40EEtmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7444

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
Changes in v7:
 - no changes
---
 drivers/perf/fsl_imx9_ddr_perf.c | 93 ++++++++++++++++++++++++++++++--
 1 file changed, 90 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
index c99c43b214cb..bf654e458322 100644
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
@@ -191,6 +211,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_ld_wiq_7, ID(2, 71)),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_empty, ID(2, 72)),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_trans_filt, ID(2, 73)),	/* imx93 specific*/
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_beat_filt, ID(2, 73)),	/* imx95 specific*/
 
 	/* counter3 specific events */
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_0, ID(3, 64)),
@@ -203,6 +224,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_collision_7, ID(3, 71)),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_full, ID(3, 72)),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_wr_trans_filt, ID(3, 73)),	/* imx93 specific*/
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt2, ID(3, 73)),	/* imx95 specific*/
 
 	/* counter4 specific events */
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_0, ID(4, 64)),
@@ -215,6 +237,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_row_open_7, ID(4, 71)),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq2_rmw, ID(4, 72)),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt, ID(4, 73)),	/* imx93 specific*/
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt1, ID(4, 73)),	/* imx95 specific*/
 
 	/* counter5 specific events */
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_0, ID(5, 64)),
@@ -226,6 +249,7 @@ static struct attribute *ddr_perf_events_attrs[] = {
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_6, ID(5, 70)),
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_start_7, ID(5, 71)),
 	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pmon_ld_rdq1, ID(5, 72)),
+	IMX9_DDR_PMU_EVENT_ATTR(eddrtq_pm_rd_beat_filt0, ID(5, 73)),	/* imx95 specific*/
 
 	/* counter6 specific events */
 	IMX9_DDR_PMU_EVENT_ATTR(ddrc_qx_valid_end_0, ID(6, 64)),
@@ -262,6 +286,13 @@ ddr_perf_events_attrs_is_visible(struct kobject *kobj,
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
 
@@ -414,6 +445,57 @@ static void imx93_ddr_perf_monitor_config(struct ddr_pmu *pmu, int event,
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
@@ -523,8 +605,13 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
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


