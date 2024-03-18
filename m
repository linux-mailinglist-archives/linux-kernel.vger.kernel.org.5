Return-Path: <linux-kernel+bounces-105905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 554D087E640
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6D09B20A6C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287E52E642;
	Mon, 18 Mar 2024 09:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WwFFUJmj"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2077.outbound.protection.outlook.com [40.107.13.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F932C84C;
	Mon, 18 Mar 2024 09:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710755338; cv=fail; b=hTpEd1tYK1n0y3+E/wmHYuDn3nZdtRLvKh3hc/+l2L+Wc4XSxoW8PWoIjeisUT2729oWyysal8BXYCaZAaibVdMrfczPEett+gaMmmqDX7t/t6SLPCn6/ZGW2p9EGm7RMk47tbLBW/5d4sqqhebpb1Cig7z8TP271nV8xxEZmuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710755338; c=relaxed/simple;
	bh=s2nH3UqW9kYFNerETvcHX0g2q8Amp7yRFNfV9rBx5kc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MnThDhyACv3tMrq+ziXz2jTGdfkJwf+5+w4qaW3sR6CkI5XrYd6hL1tPT/wjO31pZGi7z/4ZLIYbJZwDpFIsxgHvmYQZyqq+bdYoWwh3FFBKZS9mBuYdPPYL2uyr0iBB6/yE1zU68Y/uTJH2yFpJgKFSkzynarD3OdU4MK3xYRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=WwFFUJmj; arc=fail smtp.client-ip=40.107.13.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QjjgLXrkLS7IE/ENlXCwMIU3CuoR+vAUuWGM43zdmzrUO/2rXYRmil02HU/0CSJo4Lk85SOYl+EHolcRs30VMqLJzaDYsq6momO6DXYbcCmyxQDp2CL7VU2H21bmW0lW1j7Q1HgyUFYJ6KRW6kAbq1f8iU2dEcpbiLgXlsZRozKabnZPRgWU7au9EaMusqUsrginrdUXq4ZN8wsWVfki+3gxAcXIc5oup9y7mCtkGwrYarfORBu5aembDrCsAwq8SPZFFQA0ta/mPUifdG1duB+atFy8DAk5UXTfdigjRyCZLH7gfjjcKZRWfEi6JPrREYYwngPSVXxuft4Bj+VJvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmAVGc5sVLAp2q+kXlRMubSP+Jhbn1vzo3R9teb5aoc=;
 b=QQTM7/4XwwDGpX3AULH669IrGTYrl7gzrzX9Jw9BoOUjvuDT1mDm/uSNXLPJBOElz/qPpj9jfzqMH/WSngm6Dd1ZW6NXvpe5EKg1Q2DBoXdaeKcVk7D61NOrKRH/EPAH8nxVo1E3yCINVLX/lw7p4k5feHyeLaww+C9DmSgq/N2Qy/B6Z7ZxCShn38qLONYvg2VMaZXSs4kHF4SbsVFyAPaXYyy1kDW8H8iu84sREI4+SA3LAernmpX6ZFy0JUc2HYAIP+d2B23IyNj1/dNVIjyMWaKHhbgnSHXx7Wpmjb2q0s62IGI1CsfpLL0AQ7NHaV5l6yhXeSCL9RTxkmyXUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmAVGc5sVLAp2q+kXlRMubSP+Jhbn1vzo3R9teb5aoc=;
 b=WwFFUJmjND0xxRYEif9ImQXeRbIQPsbOkf1cDEmEJxBaEW5wU5cFckKpr9T/478yaror9KIwruEryxQeyQvq0X05PkpCrEHtMzd71nOxvRwR4ZMTXgWeiCgcR+ZuvAZx2CuvwMtmdAH5dNyqSx6l76pHFppnKtgbfVIBkVJsCKg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com (2603:10a6:102:2aa::7)
 by AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.25; Mon, 18 Mar
 2024 09:48:52 +0000
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::688c:22a3:9638:9ded]) by PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::688c:22a3:9638:9ded%5]) with mapi id 15.20.7386.023; Mon, 18 Mar 2024
 09:48:52 +0000
From: Joy Zou <joy.zou@nxp.com>
To: frank.li@nxp.com,
	ping.bai@nxp.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v5 2/3] regulator: pca9450: add pca9451a support
Date: Mon, 18 Mar 2024 17:56:32 +0800
Message-Id: <20240318095633.4079027-3-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240318095633.4079027-1-joy.zou@nxp.com>
References: <20240318095633.4079027-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0016.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::20) To PA4PR04MB9367.eurprd04.prod.outlook.com
 (2603:10a6:102:2aa::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9367:EE_|AM9PR04MB8938:EE_
X-MS-Office365-Filtering-Correlation-Id: 686d1b49-7b14-4e99-1ad6-08dc47309e58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ABv7QdgvO9VsgllmcVuc1NLfZlfxch5rJDuYQIfit9TN+Y4bG6GsHCjJ5rQg6M+7qNc8UWd7mC9nELfakNvnxfXHfZVFpIooEVellfGFzN2U9pjXuq7BWGKugpcZfhXY9IUwH2GPq/berEoBu2gMsqFuV6rEwuE5t5DDIHB7ThMFloC4auh8RU0DW0MRKLkhy4M4qqNt2ovbPLvvFC9av2iEindouICAzt2+JAb+70zBIq/7qtcs5C92DSwhYYmC7XHEjGLzVkAp90Th0Jpfe5885I46NmxR9es0QFD5ZwkDS9EwWpXHjGiKSSIodrp/rcOidfnocVfhYLJtJw0AI9+ZNAkWaRR27hxj2dD2oAvZwqvHLnq1rJzpNEpuqP7irf5y4lJp2nGv9rYGi3jM7IpXWVYmDoq2LZz+dmRzClf/mL++VmsML+zhA76j/mPQUYjxI249VIkjRL1NT4SQkGmbMsRuUcIlU4wRmvONs/ytIlt4gfvtmxfHLw+kw/1DM1N1TY6W+mmXlpSn6bAH+AENglhkdOsjWR5iC5IR3vL+8Wy40Fm9+cvIa97tTcNKYvXSwYE9pLVrK67NxkfBXi1T4Kk/8soCd5bzsLWSeKf3HkstrHgZi7v0Z7l+/p1kJQ+i/aFx4mEhby4ACmpcOC4xaFg5097CHMiF3dgpF6FpUy/mN4fDhepM/Z8TbmgZeQRgz4XnwogLnKN9HSrLMV5yCHqtQPO9avbKe3GiVxc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9367.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(52116005)(366007)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Uu7Rzsx8iXsCJpjavf4mCQ4q2gXngOlR38Afdp/iatFR+4DzLffOOnX/csz/?=
 =?us-ascii?Q?RdjW3rHVaNsw9VjEAM77KVURilRN6QNc4y0p99AnweVWqaIKwPnufWoH1fpe?=
 =?us-ascii?Q?zmlLCAExJE015BEzdGIuwCugn7anB4ct7CuvqIoAFmAbqnoTnMZj6UhRhoWG?=
 =?us-ascii?Q?Tpu3aakuTod8GP8nzApps4abvLwXYaLloXreefB1mN892Ks5R0sFiGNRvh2l?=
 =?us-ascii?Q?PRIzViaoznII7AQXaIqzA0+wvg0rUGxhlvKWk8y1jRYBxnga3n3jL5re0JRI?=
 =?us-ascii?Q?069gBW7DPVlc2S34RqywJViZfG51Tvr4uFtc1a/dG+76GQqbA/oBBzpubrLa?=
 =?us-ascii?Q?WkiqlKxtTh79xSxaKicfm//RdSx3hQdDpgLpWUcv2k7Z2N912+aB6xgwzAuX?=
 =?us-ascii?Q?hYOgDKVmYWiXqsJCKQcdvDl57/ywgrjUCt3VVGCciaK2aKonTvsRvPxBSmA3?=
 =?us-ascii?Q?K3xWpG3IlW74WKIWD/P58Mo1mrJ1+X8rLxQ1hTS11eYj9vPaN6n1f3oKB5TC?=
 =?us-ascii?Q?65rTuyXFuUGwEIJkraumc7NktrqRFX9TZOFHDWaImu63GSuDUJZxq5bblZPG?=
 =?us-ascii?Q?IJSMk8M6Tp7N8SVM2LHN8RvED5PwQrDFvz7AKWQUD+mAU116DkgfgKMrunj9?=
 =?us-ascii?Q?nhTTGgo6NU8duO8UOU2m/gKGYdn7aeOEKYecKxCX1L2hFpoV7IAsIEfpTP7F?=
 =?us-ascii?Q?EZ3x5f1JdIqleNobfhPLdz8UA93jq00HxyDP0tjZ9NL29pJv8s+DGsf3b89y?=
 =?us-ascii?Q?03dqkOQLVx8O4UdYjVTdB9yt6pDP0z0tm41dYGUz/0CqCjtEizvYjCvdkgfW?=
 =?us-ascii?Q?0Z0pQXCY30kH+SfXR4RtUkayIiHetSOYem7oblF1lryahL+kDi2Nh+mpK/Vx?=
 =?us-ascii?Q?OxSG5/B7JKh63fhAf1op2dT0f0DCOQiv2rBEmo03l1ZegV04JmsocaPLBBc/?=
 =?us-ascii?Q?h6x3Od1f8PKWP18bnewQIQQJBwFzqVnidgfPB9wfzshPWZ9LK7zPSvLvA35x?=
 =?us-ascii?Q?+bzxljl/a2ovoCSHziSR3GnWayvrGv/X+956oHKo3Kwo7N9W0qr25tTk6nkO?=
 =?us-ascii?Q?AUHk+SplAKJ4IrlkUZSdFw6UeH2IS/Qk7SuPjoSX3z+wgni9YxqKBv4w2oG9?=
 =?us-ascii?Q?TQ2NsJiWf2Xn7AB2gPI+P1EaEJts3rXv8s/XmS77iZ5Tqd5vV+qhAVLArxXQ?=
 =?us-ascii?Q?CiSvcKyFyuyInx2MW4K1mlKU4MWp2/bBuyepuffApwTmrYP/+XnfHTfJepV+?=
 =?us-ascii?Q?JqwjWiDQOahMjokKJYZ9LAKykZbJU6lnljXlW+O237fCaMT1kGHx5dQqf5YT?=
 =?us-ascii?Q?/aFL5XP8tbKqdwKGid6pqNJurlYT44FEir8drfhuu6VPmyhsp4KL7UOULXBq?=
 =?us-ascii?Q?ed9kZtBgasNxYK5BigT6bXW01WGzciowfv26m+kuqGSJqSYZeXSkU91D/VHl?=
 =?us-ascii?Q?CRsyFm2/2uPl1Txm8xU/85LtRE4hsMzJ/u0MshI2s09UlMZFnVEQlDAZI26R?=
 =?us-ascii?Q?WYyaIRZHcysvDFy0kuwkT+x2bWY7TEXsBpNifhqEn3wPomcqC9PWNYyN+aYi?=
 =?us-ascii?Q?QJ1GeD6f6wKdfg59D8Kgp/iML3TCo9r2rAitXQfs?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 686d1b49-7b14-4e99-1ad6-08dc47309e58
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9367.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 09:48:52.4410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AmIVb3EGcxAbHgKdwR38hjQC7pdJGckyL+Cy8lUEJ4btWvAfnVLqLkEEKE1SEO/m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8938

Adding support for new pmic pca9451a.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes in v3:
1. remove not related change.
2. delete unnecessary empty line.
3. modify commit message.

Changes in v2:
1. remove the old part support because the old part only is used for sample
and is diffcult to distinguish old and new part. so drop old part.
2. remove the unnecessary marco definition in the file pca9450.h.
---
 drivers/regulator/pca9450-regulator.c | 194 +++++++++++++++++++++++++-
 include/linux/regulator/pca9450.h     |   1 +
 2 files changed, 193 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/pca9450-regulator.c b/drivers/regulator/pca9450-regulator.c
index 2ab365d2749f..242ff25f5b83 100644
--- a/drivers/regulator/pca9450-regulator.c
+++ b/drivers/regulator/pca9450-regulator.c
@@ -106,6 +106,14 @@ static const struct linear_range pca9450_dvs_buck_volts[] = {
 	REGULATOR_LINEAR_RANGE(600000,  0x00, 0x7F, 12500),
 };
 
+/*
+ * BUCK1/3
+ * 0.65 to 2.2375V (12.5mV step)
+ */
+static const struct linear_range pca9451a_dvs_buck_volts[] = {
+	REGULATOR_LINEAR_RANGE(650000, 0x00, 0x7F, 12500),
+};
+
 /*
  * BUCK4/5/6
  * 0.6V to 3.4V (25mV step)
@@ -662,6 +670,178 @@ static const struct pca9450_regulator_desc pca9450bc_regulators[] = {
 	},
 };
 
+static const struct pca9450_regulator_desc pca9451a_regulators[] = {
+	{
+		.desc = {
+			.name = "buck1",
+			.of_match = of_match_ptr("BUCK1"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PCA9450_BUCK1,
+			.ops = &pca9450_dvs_buck_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PCA9450_BUCK1_VOLTAGE_NUM,
+			.linear_ranges = pca9451a_dvs_buck_volts,
+			.n_linear_ranges = ARRAY_SIZE(pca9451a_dvs_buck_volts),
+			.vsel_reg = PCA9450_REG_BUCK1OUT_DVS0,
+			.vsel_mask = BUCK1OUT_DVS0_MASK,
+			.enable_reg = PCA9450_REG_BUCK1CTRL,
+			.enable_mask = BUCK1_ENMODE_MASK,
+			.enable_val = BUCK_ENMODE_ONREQ,
+			.ramp_mask = BUCK1_RAMP_MASK,
+			.ramp_delay_table = pca9450_dvs_buck_ramp_table,
+			.n_ramp_values = ARRAY_SIZE(pca9450_dvs_buck_ramp_table),
+			.owner = THIS_MODULE,
+			.of_parse_cb = pca9450_set_dvs_levels,
+		},
+		.dvs = {
+			.run_reg = PCA9450_REG_BUCK1OUT_DVS0,
+			.run_mask = BUCK1OUT_DVS0_MASK,
+			.standby_reg = PCA9450_REG_BUCK1OUT_DVS1,
+			.standby_mask = BUCK1OUT_DVS1_MASK,
+		},
+	},
+	{
+		.desc = {
+			.name = "buck2",
+			.of_match = of_match_ptr("BUCK2"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PCA9450_BUCK2,
+			.ops = &pca9450_dvs_buck_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PCA9450_BUCK2_VOLTAGE_NUM,
+			.linear_ranges = pca9450_dvs_buck_volts,
+			.n_linear_ranges = ARRAY_SIZE(pca9450_dvs_buck_volts),
+			.vsel_reg = PCA9450_REG_BUCK2OUT_DVS0,
+			.vsel_mask = BUCK2OUT_DVS0_MASK,
+			.enable_reg = PCA9450_REG_BUCK2CTRL,
+			.enable_mask = BUCK2_ENMODE_MASK,
+			.enable_val = BUCK_ENMODE_ONREQ_STBYREQ,
+			.ramp_mask = BUCK2_RAMP_MASK,
+			.ramp_delay_table = pca9450_dvs_buck_ramp_table,
+			.n_ramp_values = ARRAY_SIZE(pca9450_dvs_buck_ramp_table),
+			.owner = THIS_MODULE,
+			.of_parse_cb = pca9450_set_dvs_levels,
+		},
+		.dvs = {
+			.run_reg = PCA9450_REG_BUCK2OUT_DVS0,
+			.run_mask = BUCK2OUT_DVS0_MASK,
+			.standby_reg = PCA9450_REG_BUCK2OUT_DVS1,
+			.standby_mask = BUCK2OUT_DVS1_MASK,
+		},
+	},
+	{
+		.desc = {
+			.name = "buck4",
+			.of_match = of_match_ptr("BUCK4"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PCA9450_BUCK4,
+			.ops = &pca9450_buck_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PCA9450_BUCK4_VOLTAGE_NUM,
+			.linear_ranges = pca9450_buck_volts,
+			.n_linear_ranges = ARRAY_SIZE(pca9450_buck_volts),
+			.vsel_reg = PCA9450_REG_BUCK4OUT,
+			.vsel_mask = BUCK4OUT_MASK,
+			.enable_reg = PCA9450_REG_BUCK4CTRL,
+			.enable_mask = BUCK4_ENMODE_MASK,
+			.enable_val = BUCK_ENMODE_ONREQ,
+			.owner = THIS_MODULE,
+		},
+	},
+	{
+		.desc = {
+			.name = "buck5",
+			.of_match = of_match_ptr("BUCK5"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PCA9450_BUCK5,
+			.ops = &pca9450_buck_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PCA9450_BUCK5_VOLTAGE_NUM,
+			.linear_ranges = pca9450_buck_volts,
+			.n_linear_ranges = ARRAY_SIZE(pca9450_buck_volts),
+			.vsel_reg = PCA9450_REG_BUCK5OUT,
+			.vsel_mask = BUCK5OUT_MASK,
+			.enable_reg = PCA9450_REG_BUCK5CTRL,
+			.enable_mask = BUCK5_ENMODE_MASK,
+			.enable_val = BUCK_ENMODE_ONREQ,
+			.owner = THIS_MODULE,
+		},
+	},
+	{
+		.desc = {
+			.name = "buck6",
+			.of_match = of_match_ptr("BUCK6"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PCA9450_BUCK6,
+			.ops = &pca9450_buck_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PCA9450_BUCK6_VOLTAGE_NUM,
+			.linear_ranges = pca9450_buck_volts,
+			.n_linear_ranges = ARRAY_SIZE(pca9450_buck_volts),
+			.vsel_reg = PCA9450_REG_BUCK6OUT,
+			.vsel_mask = BUCK6OUT_MASK,
+			.enable_reg = PCA9450_REG_BUCK6CTRL,
+			.enable_mask = BUCK6_ENMODE_MASK,
+			.enable_val = BUCK_ENMODE_ONREQ,
+			.owner = THIS_MODULE,
+		},
+	},
+	{
+		.desc = {
+			.name = "ldo1",
+			.of_match = of_match_ptr("LDO1"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PCA9450_LDO1,
+			.ops = &pca9450_ldo_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PCA9450_LDO1_VOLTAGE_NUM,
+			.linear_ranges = pca9450_ldo1_volts,
+			.n_linear_ranges = ARRAY_SIZE(pca9450_ldo1_volts),
+			.vsel_reg = PCA9450_REG_LDO1CTRL,
+			.vsel_mask = LDO1OUT_MASK,
+			.enable_reg = PCA9450_REG_LDO1CTRL,
+			.enable_mask = LDO1_EN_MASK,
+			.owner = THIS_MODULE,
+		},
+	},
+	{
+		.desc = {
+			.name = "ldo4",
+			.of_match = of_match_ptr("LDO4"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PCA9450_LDO4,
+			.ops = &pca9450_ldo_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PCA9450_LDO4_VOLTAGE_NUM,
+			.linear_ranges = pca9450_ldo34_volts,
+			.n_linear_ranges = ARRAY_SIZE(pca9450_ldo34_volts),
+			.vsel_reg = PCA9450_REG_LDO4CTRL,
+			.vsel_mask = LDO4OUT_MASK,
+			.enable_reg = PCA9450_REG_LDO4CTRL,
+			.enable_mask = LDO4_EN_MASK,
+			.owner = THIS_MODULE,
+		},
+	},
+	{
+		.desc = {
+			.name = "ldo5",
+			.of_match = of_match_ptr("LDO5"),
+			.regulators_node = of_match_ptr("regulators"),
+			.id = PCA9450_LDO5,
+			.ops = &pca9450_ldo_regulator_ops,
+			.type = REGULATOR_VOLTAGE,
+			.n_voltages = PCA9450_LDO5_VOLTAGE_NUM,
+			.linear_ranges = pca9450_ldo5_volts,
+			.n_linear_ranges = ARRAY_SIZE(pca9450_ldo5_volts),
+			.vsel_reg = PCA9450_REG_LDO5CTRL_H,
+			.vsel_mask = LDO5HOUT_MASK,
+			.enable_reg = PCA9450_REG_LDO5CTRL_H,
+			.enable_mask = LDO5H_EN_MASK,
+			.owner = THIS_MODULE,
+		},
+	},
+};
+
 static irqreturn_t pca9450_irq_handler(int irq, void *data)
 {
 	struct pca9450 *pca9450 = data;
@@ -729,6 +909,10 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
 		regulator_desc = pca9450bc_regulators;
 		pca9450->rcnt = ARRAY_SIZE(pca9450bc_regulators);
 		break;
+	case PCA9450_TYPE_PCA9451A:
+		regulator_desc = pca9451a_regulators;
+		pca9450->rcnt = ARRAY_SIZE(pca9451a_regulators);
+		break;
 	default:
 		dev_err(&i2c->dev, "Unknown device type");
 		return -EINVAL;
@@ -755,7 +939,8 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
 
 	/* Check your board and dts for match the right pmic */
 	if (((device_id >> 4) != 0x1 && type == PCA9450_TYPE_PCA9450A) ||
-	    ((device_id >> 4) != 0x3 && type == PCA9450_TYPE_PCA9450BC)) {
+	    ((device_id >> 4) != 0x3 && type == PCA9450_TYPE_PCA9450BC) ||
+	    ((device_id >> 4) != 0x9 && type == PCA9450_TYPE_PCA9451A)) {
 		dev_err(&i2c->dev, "Device id(%x) mismatched\n",
 			device_id >> 4);
 		return -EINVAL;
@@ -846,7 +1031,8 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
 	}
 
 	dev_info(&i2c->dev, "%s probed.\n",
-		type == PCA9450_TYPE_PCA9450A ? "pca9450a" : "pca9450bc");
+		type == PCA9450_TYPE_PCA9450A ? "pca9450a" :
+		(type == PCA9450_TYPE_PCA9451A ? "pca9451a" : "pca9450bc"));
 
 	return 0;
 }
@@ -864,6 +1050,10 @@ static const struct of_device_id pca9450_of_match[] = {
 		.compatible = "nxp,pca9450c",
 		.data = (void *)PCA9450_TYPE_PCA9450BC,
 	},
+	{
+		.compatible = "nxp,pca9451a",
+		.data = (void *)PCA9450_TYPE_PCA9451A,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, pca9450_of_match);
diff --git a/include/linux/regulator/pca9450.h b/include/linux/regulator/pca9450.h
index 505c908dbb81..243633c8dceb 100644
--- a/include/linux/regulator/pca9450.h
+++ b/include/linux/regulator/pca9450.h
@@ -9,6 +9,7 @@
 enum pca9450_chip_type {
 	PCA9450_TYPE_PCA9450A = 0,
 	PCA9450_TYPE_PCA9450BC,
+	PCA9450_TYPE_PCA9451A,
 	PCA9450_TYPE_AMOUNT,
 };
 
-- 
2.37.1


