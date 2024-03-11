Return-Path: <linux-kernel+bounces-98545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2179877BCE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5952F2811D1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 08:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D54A12B7D;
	Mon, 11 Mar 2024 08:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ekaotkkA"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2047.outbound.protection.outlook.com [40.107.7.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D6117996;
	Mon, 11 Mar 2024 08:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710146418; cv=fail; b=odAIIektosZvNzNlsJ4fbNZRatW+sq5scCyWfVIZ94zWu4kKbpgUQzQJV8s8g2oFAKNJ2iRtTCmnEX4oPtSY0p5UVaHouWf/ZHX+nDN3S6u+EbaOV0jrr5vRcvMJZk8iiN0kSmogP6fc7WEXdkSZDJN7KSxofWyKrbWsREzPJ+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710146418; c=relaxed/simple;
	bh=GH1qB4u2ZjthsNHReQFP0NYpV6kZ6Y4VqqZY602C+yk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IPgD2B+Qh1jELKMGZdZmJh8kYCGUR9e6uEq4t799lz9UCkfK4f1X1R007X4Ox5ucju86qNhW1WXSd6nG2T1wAo9ZMfM9QDOW07QARk7o2K8KNSQltrsHivC8SHKJFUlk+/8EC0dhEVvDyJuIt9fLzbQmCh2rcmuY/HkQHAvRt2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ekaotkkA; arc=fail smtp.client-ip=40.107.7.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Celf/rCbqTz4OWhriQ7DomrgPQVHW2eK3YX+1dJuIzUrhO8qqgk+mA7cdR2Z56QXfV8whsziUU2WGgubENuOJCA/Cddo5zDhC3p5UE6PKaHiKt6tsS8KtimNFPUEfogV3Ja6u9STwXEpxoCwCXWCIUEWKFAijPeJbdTKMnslxmJB4XSQ9J4gXzDfeidYvRye63bLuTYHqHhu+3WVBeuoqGAil93Et7Z5siDx6V0FpBoD0o10Bgh10715aEz3JVGvdBLDkYfyh19lS2G6/gAvp8mTMU7Jok5/vtaQJAoTTdl35doO+K2ChfO9O0gvYpKhjzVo4kdPK4iEKTc1xIIelw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/us7hW5vGU6NFXFzOAeKyJVZiQcuWMf0Od7NfGdGs6Y=;
 b=QaNDY5cyyMlJdBbpaAmRH0NRhbMkeoDzJJSoIx6gDu5rqq2Cshf29iosOCdsG+tWFKqrK1fxWtLGaJyYwQpwuV4+Iubw5JfgR6OxWvaa7GERiJ4O9NwFHfmjePH11MEgzbD5wG3OCjH3+Z5KT10Q6ZyBHRKDVLGOU97c3umFkg58OM0uUvmVEX8xYjt7zlDqVnGh9IkrHwYeFt5eaig75hPFxNCgTi4wwRv4ri9Y6YPvtguDXSysTPjWzQnTVqMQD/qoSE0Xj/hRFdySemZsMYCMtySR1rj/FqD6PhMSvI1bIYcwLU+1O9aJ0EJr7aTpnVSwfc1xoEp87sSPzM/xXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/us7hW5vGU6NFXFzOAeKyJVZiQcuWMf0Od7NfGdGs6Y=;
 b=ekaotkkA9uPupasB5YNP7gMYLdraRtp5Tw1VU8ju5RK6+I3Kz3dRuL38AhQUDFFwstXLsp2q+1PFOhTbBLiRhvfpqWe9Tn+WDkf8csFoJiYuYJ86sB2HG8dlrm6/OBUigec1VDLy0bETVJOwiCO0TXeiDUBn++lppeoyOv1yKQs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9377.eurprd04.prod.outlook.com (2603:10a6:10:36b::13)
 by AM9PR04MB7602.eurprd04.prod.outlook.com (2603:10a6:20b:2db::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Mon, 11 Mar
 2024 08:40:12 +0000
Received: from DB9PR04MB9377.eurprd04.prod.outlook.com
 ([fe80::b3d4:17c4:91b7:101d]) by DB9PR04MB9377.eurprd04.prod.outlook.com
 ([fe80::b3d4:17c4:91b7:101d%5]) with mapi id 15.20.7362.024; Mon, 11 Mar 2024
 08:40:12 +0000
From: Joy Zou <joy.zou@nxp.com>
To: ping.bai@nxp.com,
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
Subject: [PATCH v2 2/3] regulator: pca9450: add pca9451a support
Date: Mon, 11 Mar 2024 16:47:56 +0800
Message-Id: <20240311084758.377889-3-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240311084758.377889-1-joy.zou@nxp.com>
References: <20240311084758.377889-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0196.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::23) To DB9PR04MB9377.eurprd04.prod.outlook.com
 (2603:10a6:10:36b::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9377:EE_|AM9PR04MB7602:EE_
X-MS-Office365-Filtering-Correlation-Id: c6100331-fac2-47ba-9bf7-08dc41a6de0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	z4RwacpHG1/D42A3lpj6c2/ODTtuZc6e05Zpap14ApauA0LCOJcQ01eRsZvtlJp8pkTpTvELaZIjTCDvcvP0/HePOOWxE5czIL19J3EbrO0tIvnmCdKxze+xhNi1ZkBSJ9OZCFmAui+661iwrdcNBY6FyuSt/MjA9UZ2sBfHejnB1r5i+DjT3OUBjjQMNmRSAA3zMgrxVgx3F09zJ8eKIbrPdxa+A4P7n/MXxV/xvjvNyDyoaUe9NBcXjvlmmNwT4aC79qeRDlJIvDj1TcWrVwHf3oCMugFpqMMiRkZrl9nsYDZUut/3LJmvdVurCv/g7bb4ipaG8S8XOW2zVIiimAv+dxCRAbM19i+MGbO7eoMge2lPfXlb0sNDmOE2us6T+nt64QR8iRwz7lGvZhrvE2RURtuHouDrackOXfYLfh53cUvV8r8bVXnbnRdImZCnPPhYu8KOZkXTdVjzrqjKNwH2clNdeWWWgt9Q8eInVe5rG/dr0x1A7gYV4LRqy/EfQrWWaUzjlAr50rXnQP4gIhj7hVzCUJORktv9AiWpRbsdx5ItBrfmYkEEROZMfPXJRFQJ7T1WF4qr3emOUzvb7lgFVijK6VOU7QoLMSmx3Zkl9sqpLfvUhbpHQ7RmIhV/hd6oCOOXrx1CD2fEJuBzQvPJ9V32WY/Mq27oF2jTtMsLkaNcpdICDNYhcGHwCbWUsvHUcWQ1MJ8SYnbFPP+9vdFHBDzX06c1RTuk8VO2Z/s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9377.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(7416005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AHtbkbgSf0VACbrUwdaYcd2CYdO5nmWOwHEH0h/V66gfoNUwoX/qw86p8xdQ?=
 =?us-ascii?Q?I2iw82vXMVz0brBVZse1tMPuxbjHVTW6RXwkSUA8hUyuz9+Ow91S+hzWNtc0?=
 =?us-ascii?Q?WnefdyW9P1XoVMH/wnIn8EHSSB10S6qHcWNLJVVcPky4+2+FJ0iQHiGCHC4V?=
 =?us-ascii?Q?maiJZrAla3y/MO4fMO/hKMjtFgmxFhb7TFqMpjl9U4EdcOWKcBsNDnPIyfvc?=
 =?us-ascii?Q?/Hk51gtdHrfu1Szqn0n2ypjzJ8ExNY6Xy9Kzpe8QXXp7qRphr4W4bW1s4G4Z?=
 =?us-ascii?Q?kSqgPyk95CAFG6xDsGIYfzIUBFmhzF1IONPpi50MYNZlR2wN4FnWT+EWIaE/?=
 =?us-ascii?Q?Djq2LTBfaZlzJk2ilh1W9+G7m7nyBsACbR3qFV/3GsC9ue/RN/xCZzxW3Yae?=
 =?us-ascii?Q?koEdkeVslZZeq22Wvo8pSQpJALx5+ZlAlhv+W4NDB4feOOaQIr6zP9f/Sm1j?=
 =?us-ascii?Q?1804oXP97b4ziAJAf5XumrAYTzqgiWWFpM2KefV1ELmUWpYI8eBF0uVhuYzM?=
 =?us-ascii?Q?t9rnLpYQpRz11zXlh3irF4ZAmABQtgXl9InoORlK8ZFnAmUtpXTG3hUNF4PN?=
 =?us-ascii?Q?ROBaw4Gr3qjWRPlCSq+iLS12kb5Fq8FabQR1ZU7dzhcR+lpzR9OYks35NV+y?=
 =?us-ascii?Q?DH0U60A4jJGCbS7UQWK0QcDwVbwQSu+Qs6eSUZuAC959UQnyUNgOT+KZTFgN?=
 =?us-ascii?Q?3SqKcPDWLW9xaVgyO+mRTkgHqg40U99llSZfNhqUYZ/UC5lCwM059WOs/yYF?=
 =?us-ascii?Q?O58wnn+Fa4Ii+GbzRNc3y+wnEq63Ta5BkqrhIL/zRLQD8+CIQ2WixekKqMyY?=
 =?us-ascii?Q?t+FgJ5gY1nj0W6utHRDFKQoOkLRHeWS2oK8+CI6yf1p2ttNYd/PHCmkc5XUg?=
 =?us-ascii?Q?8DyxfaWLnKOzjYf2z65OHXYpr4EvtCSlca/8eOoEpgmXRMqrtrqAh0Dq8HvJ?=
 =?us-ascii?Q?bzEl8OItt8keFqQ4BCItGyrx2NcL0GGFkBaFV8QklRnwO7TZkEXlghxo6dBO?=
 =?us-ascii?Q?qihhGhp52cLyDHpEyw5am75h7lFAQpbqF7DnJ2yhnsfgXNyBPFd3l7bES68A?=
 =?us-ascii?Q?49hzQF5ICin3VHm8XmKv62NSBvP27q/EGbjBPRHEFY+DJEVSmri6LHcWlX4k?=
 =?us-ascii?Q?n4Xk9A7zsbL0ycS8SrNTobDlWDEXx99rMUj+4+Ae6GJNcL25dwlw+53qXxNh?=
 =?us-ascii?Q?1xzUvZIdTBY08RJ6KaDrniwPL4OCtkejv43aOMakzlEErvtOqG6jVZ6JjtRw?=
 =?us-ascii?Q?3yHm1SuF+pGvQy9wjD9BJvD1yylhKf82qs71Pqda6KA0XSVMmlxkGoggDy5U?=
 =?us-ascii?Q?1wrn6XwIbgw5IONpqG9oAqcXvjNGa3vuDBb9LeLAg3M4HXNWFQ2FQkYPxyMu?=
 =?us-ascii?Q?LxuH2ydRA3ZIYWnh55B1nv1Rz4OzJf9POA4qI4Ie0i7f7VqaLk7hUarFGZWY?=
 =?us-ascii?Q?3I+JzWtIzADfFJdEpGCaUlwNxB7Uhb68mf/OIT2V63fRs/WlpyQT01LLe0At?=
 =?us-ascii?Q?hfJh4sJ5wMrspCc6IUHN34EI+QdQerxykI/7yqXDJouq4s86j7TpEVpRgnaW?=
 =?us-ascii?Q?GHFIhawf5LHzt2KzXcOszQe0u07ptObsAWqsWQtC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6100331-fac2-47ba-9bf7-08dc41a6de0d
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9377.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 08:40:12.8149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jH4P8X6xt50If6fGKcXASuDQWuNdqd3sU8K05cY9g9x0RoPtOJwzX/DSgDekDZrD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7602

Adding support for pmic pca9451a.

This patch support old and new pmic pca9451a. The new pmic trimed BUCK1.
The default value of Toff_Deb is used to distinguish the old and new pmic.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes in v2:
1. remove the old part support because the old part only is used for sample
and is diffcult to distinguish old and new part. so drop old part.
2. remove the unnecessary marco definition in the file pca9450.h.
---
 drivers/regulator/pca9450-regulator.c | 197 +++++++++++++++++++++++++-
 include/linux/regulator/pca9450.h     |   1 +
 2 files changed, 195 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/pca9450-regulator.c b/drivers/regulator/pca9450-regulator.c
index 2ab365d2749f..50c324e275b5 100644
--- a/drivers/regulator/pca9450-regulator.c
+++ b/drivers/regulator/pca9450-regulator.c
@@ -103,7 +103,15 @@ static const struct regulator_ops pca9450_ldo_regulator_ops = {
  * 0.60 to 2.1875V (12.5mV step)
  */
 static const struct linear_range pca9450_dvs_buck_volts[] = {
-	REGULATOR_LINEAR_RANGE(600000,  0x00, 0x7F, 12500),
+	REGULATOR_LINEAR_RANGE(600000, 0x00, 0x7F, 12500),
+};
+
+/*
+ * BUCK1/3
+ * 0.65 to 2.2375V (12.5mV step)
+ */
+static const struct linear_range pca9451a_dvs_buck_volts[] = {
+	REGULATOR_LINEAR_RANGE(650000, 0x00, 0x7F, 12500),
 };
 
 /*
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
@@ -767,6 +952,7 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
 		const struct pca9450_regulator_desc *r;
 
 		r = &regulator_desc[i];
+
 		desc = &r->desc;
 
 		config.regmap = pca9450->regmap;
@@ -846,7 +1032,8 @@ static int pca9450_i2c_probe(struct i2c_client *i2c)
 	}
 
 	dev_info(&i2c->dev, "%s probed.\n",
-		type == PCA9450_TYPE_PCA9450A ? "pca9450a" : "pca9450bc");
+		type == PCA9450_TYPE_PCA9450A ? "pca9450a" :
+		(type == PCA9450_TYPE_PCA9451A ? "pca9451a" : "pca9450bc"));
 
 	return 0;
 }
@@ -864,6 +1051,10 @@ static const struct of_device_id pca9450_of_match[] = {
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


