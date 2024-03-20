Return-Path: <linux-kernel+bounces-108493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4C6880B31
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B066B1F22D59
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 06:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D77C1802E;
	Wed, 20 Mar 2024 06:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bDqFRv9f"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2062.outbound.protection.outlook.com [40.107.6.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E756F2134B;
	Wed, 20 Mar 2024 06:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710915823; cv=fail; b=WTC0151Xi/HVKf3IpMSzNevJFCMPt3XvQ4gJJf9RG5yGWuDWPkSleV5atdLVTiyU4nw+mdsWIA6MkJiqmfIm5YaQkHii0k6tNbDNw3aItnmV3Xgii3tnRa5E4MY12r/2lu2HqJz2ys6Vr7EvSwTxrHoJNf7VHPf/x0OSDjCU4LI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710915823; c=relaxed/simple;
	bh=s2nH3UqW9kYFNerETvcHX0g2q8Amp7yRFNfV9rBx5kc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RIrbS8B7lW0XW+rQxF/tlhbTXvYyWmtW94pitOaQ6IcDYnJbUsEQsbXZLwYWow1PMHj6dCmkEHh9BBDfdq8iPtImlvbz1nyHMiLbu4CRIU97n6bmpxALNT92BkaXcwVENyhuARhHcvg5eJWBa/wNliJI9nH/6ZxvmiUy2p9HSps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=bDqFRv9f; arc=fail smtp.client-ip=40.107.6.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dqVFbd7OKhas1XHGnQruqDngxD+cM3y+5fxHs8AnF22CkFFMTpM1/37gEsnEoiehe47wC4kvnT/0MxldSut/vpCJr61lagk7LL/GS7r6e70y/QIvpM3OiYWCXjEvsNRw3PjSRMRWS2kC+mPR4nCLCk94yvkcKPMFN5gAa/kh/8VD0p6l2we97i45tuoRTZAaKX1+JCn8OpzmyyMelp73vuYNXsjo36fbKAWH1bxM8pq0LHoUbnSDYwY0AaV9RE0bxyDPBXNRZ96oxflkJzyHbMsk0E1fib38K5j45mW9RGwxIoXgBDN9jUy1Y0T5LlRNJ/P5W20S/eHoZDGkjO59fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmAVGc5sVLAp2q+kXlRMubSP+Jhbn1vzo3R9teb5aoc=;
 b=Y1EQZdXbgXbRiYM0gb/GxzrAq9f+7GqYXWULA3Xy8vopFF7KUr/rMymdV/h72gZKl5pZMn6yMOvCB3gnQZtrV+6wN2l8HY6cYJzpEfmNFipIk+cuuCVQzujvqg2OLI7/eU+F7TSfDMLQpmbihpcdT5bbC5PLyWQMgXyzMam5bJ0KvKBeUrl+Yv0v+ChoWSXxsvNBMQn4pVhtV/KE8RSyDW9JonmSwTJ9Wbh/5pvcQ1mubFtWtSlb4zylwByQDTz2YzmS0MrP8K8ljGMjbr2KJxsKDsCRTiCxUwXc0FrcZVPaT5sX1GAjxEfh/8JGoJEohHHw8BOWef+TDP6Ct/Oqiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmAVGc5sVLAp2q+kXlRMubSP+Jhbn1vzo3R9teb5aoc=;
 b=bDqFRv9fJ28kCUWlbyASjiKB5LiqeIkibbXlIq2JyAV6Aiu4OdYXyLY9tPfouB4Fn+zvY3wI4XuQ/fIU57y8+q8XCq6mI+CxDp8sm9ZiU/ATPrdM4q5pPIflbqtPxqPO42N410FX4G8EhGrnQfKC6Y5Gd4YSo9pc23iERc9xrqw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com (2603:10a6:102:2aa::7)
 by GVXPR04MB9879.eurprd04.prod.outlook.com (2603:10a6:150:11c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Wed, 20 Mar
 2024 06:23:38 +0000
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::688c:22a3:9638:9ded]) by PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::688c:22a3:9638:9ded%5]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 06:23:38 +0000
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
Subject: [PATCH v6 2/3] regulator: pca9450: add pca9451a support
Date: Wed, 20 Mar 2024 14:28:48 +0800
Message-Id: <20240320062849.1321423-3-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240320062849.1321423-1-joy.zou@nxp.com>
References: <20240320062849.1321423-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::20) To PA4PR04MB9367.eurprd04.prod.outlook.com
 (2603:10a6:102:2aa::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9367:EE_|GVXPR04MB9879:EE_
X-MS-Office365-Filtering-Correlation-Id: 77fadab2-e4b7-4057-b855-08dc48a6474c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xdjaOzUexz9mkRkDxEJkIHJtzsMZpbI8varglTRDL1t+lI9fgpQh9xLMPuxFpKz7OXaWerNf6BJIJJqYPRSmqqUKS+aGlI0/Nv7ZJ5bisl4/0IgHW/kXdLsJpueK+8kqCBKbVGSmB5qCnDI2bggBJG9MHR5ve8h/FYcsKo9jcjN+GvI5WEzGoDYv+UMZYzCfga90VH2AgAdC/k7x5tbxn0sPPQIeYgY40mW9bdZYW0xjcQg5sJSEzmg33lfJVLLOIaW6L5K92+6PNQQoP1ntZPvUnCB+QaJiv5JREx/YAx3Biqhp2T91Ao00WV10Fe02cKHArMP1HvFWeHra+PHgUaywyt2eKF86bxjBhDH73Uv6XmJ5/lw6kGHUSFtFcfn+ldmt8d5YKubRKLA3ug0ogZ+DytPvI/oRrtfZ1GSy5Aum2KVTTNulCISBpKiR6QWVGEAC4IEseSRUBvF1LZ0Lq6oTYboePCdzHk7DLuT2mCkDnXwdDp8vcmWZW1GJYtaWxPBM31wULxhQ5E9tWPJUbjQvt3/HIflAjj0GRbp2R/yAMigG06o0i8NUtzyshLOKL+dAxCKwlMDrn4+FFTzXRMnEOuZQBfR93a7Q8xMYV3qjh1/JIw6Jz9U2z8nD2vua9ZZ96eofTc2O0AnZK0TWzByIk/CA/YCDk/H772IzgcjO03MZOI7GCeCWKIhNZrO7aCLf/B2+D+oxDEUKnFgP+H4CMuFcL5TW1K0dQmMUvMw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9367.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HX90vJu410k9QG0Q9hNFovlLUufUqPBn/fEcI/v8eLfTAa6hLa9s6GM80Bqn?=
 =?us-ascii?Q?PzDXIwrnK2J9HmfeU6Mx7pQTKZToEiADeShZ36/hbB1JNDNsEZNQJQnAkgaO?=
 =?us-ascii?Q?jkwj7AdLhl0fQ1Y1OPxNPOotzkJKXJoJ9SJtRI3uIfQL483smyKU+7xJPWfA?=
 =?us-ascii?Q?RboU1YiRjGhHAGdQLUUXA4101MheTRqunCIBL8ASE1pHZuo/Xaurjd2/Fb2g?=
 =?us-ascii?Q?FkKxRa6K0sUCjEuKZ+7TGvZnmVDDfWuQH4pFKBIWu5c9aeLNUNlbIwdVrCRd?=
 =?us-ascii?Q?Lbf8P3MnchZlul5pfrWSwiGmwyqVk5FxnrdUftQIggTVm22033XUcaD+4vB5?=
 =?us-ascii?Q?itMfwJB1YK0Oqo38hzpbQJeBldGDzPJytOv2N/n/k1BANNBkdTqLyOh/W8Zd?=
 =?us-ascii?Q?vbrQrvQAXP0K/pB0zqk9hCYsjpyVW5Eow/VacdWSH7sVW509s06I1Roja8X7?=
 =?us-ascii?Q?nty4JpZCG364rsG17fIHvugJE7S0DHUGUPMmYXft/VZByfc5AtD9XpligJ+/?=
 =?us-ascii?Q?cjweQ/Ca/ur6TDwdQ5139neSlv9S4iy+zfUgCQLsADR4NkxVgUJ9F4wpJJZg?=
 =?us-ascii?Q?NbKLk4hniP0tfCuwwSkbfIFoxnc+Dkwzb9se6kCvvFEHl8FgP1qxQnrKSI9c?=
 =?us-ascii?Q?1lZBK/06MThwaHXE6YB0SsbNsEwrOEuL/nSLMCslyeWrNQ7DQvFSwAbeOoR1?=
 =?us-ascii?Q?556PKKCl+/+BFmeDuva+yQqobzRKKDHz3ZYQNHIgWNdQMBTc8s6vYXqx5hHo?=
 =?us-ascii?Q?oeRXSdx+pZuwhjiJYZzwHzXxU5h3b7E5DN6Gh037560kOWVYimtrhMLKGWl3?=
 =?us-ascii?Q?ulOyfA81RKeONubFlJilIBF4xpGLDPtSyrW8yZpy143x72Fhn3/LonuzBelb?=
 =?us-ascii?Q?ax+v+MYoBmGj8XSmNDxFI4d3Hc++uk1Ul3vPrXMuZ7CxLM6AwMO5pcEiVzpk?=
 =?us-ascii?Q?lIakb+y3cc3lHoJtmuQUC/iImjd+z7WVZ8p8EkZbFkps31rAhIvqJGhdtW07?=
 =?us-ascii?Q?UhXQvFG8PA7Cv/eey2lTgwWBxowMdfpV0xJ/hP2wRHgKClhT/bLC7I6e3ujv?=
 =?us-ascii?Q?iVtvE/6TdXmy0WAzHVYd5iXEJb67yrnGkP0j8f5LwB0Q44+VmJywc5GYdNa+?=
 =?us-ascii?Q?Wzyq3qTFBqC9RDqNzjgTjDKMyts0jMaPDIqmSTh7ZOoUC9bDC+/qpYvnJqyi?=
 =?us-ascii?Q?Czbl7nlqodVSLVJvD8NK3577b+0r3uSI6O5q3yYqE0931xHkvresOvw1KdXR?=
 =?us-ascii?Q?Ie0y5h8QsdRK3pfeviM4oSaUFSxXwgBzrtzy3h2+W21D/AzaD0286vrbJ07L?=
 =?us-ascii?Q?ZZs+O32kzrem6V391EQqCw34HAuHJc071U68szW8/cwX7cpFNikDiSZTIb0l?=
 =?us-ascii?Q?Kk4bUV6vOtAAu0u5HizBUVxoREVKR02SC8OymuofBWOuxGQJQfsf3YvH6icH?=
 =?us-ascii?Q?p3sOyamoBv+Sdc9KdJxFA3cSd14WF1+M/j/VeRzirGzTgPaMrF6T/VMUh2j2?=
 =?us-ascii?Q?I3OckKUr/H/HbECmgGLsiICXwNOMv7rXCUzHNE9rCOAnREtlUwvYs3mwxN2S?=
 =?us-ascii?Q?ud8p/uq+PWODEdB9wK0knzzwO3WjB+dFRvlB3QXl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77fadab2-e4b7-4057-b855-08dc48a6474c
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9367.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 06:23:38.0253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4mfy9gb6Kp1TkJaHzg1ewCfXFTNBMX3/6lkfV7E7VPxSxAXCx1+DSTecL3U0Oo4s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9879

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


