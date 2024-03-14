Return-Path: <linux-kernel+bounces-102743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C376B87B6CC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 04:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78E9A286050
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 03:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850625382;
	Thu, 14 Mar 2024 03:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nyBVioGh"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2086.outbound.protection.outlook.com [40.107.249.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336A7C2D0;
	Thu, 14 Mar 2024 03:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710386502; cv=fail; b=A8oi4jF/TV82MHTb3kes8yUDkUUj6jjFy4ecK7Vmg4len9CZOr4ioouLnNx30pwzWo/6dAfIYcTIMJSkqqGtUYeY4RkvebvPsfMxA7erp1GEdbsx/rvVq1z3IaQspTVx2Tnd62gLCzPFEOArJEjl+WoaV4y2EEwR8Sbr5YJ9CO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710386502; c=relaxed/simple;
	bh=s2nH3UqW9kYFNerETvcHX0g2q8Amp7yRFNfV9rBx5kc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OeLkoWnRrnY4KVfeYjMEr245sylMClMASMkQD+O4Y0x62TpMWdfb9DCCCanDFFDCwYOWGgafz1QN9Z/pNveV153lg7MdFp4356yMB2OYwZ6F2Tld+YI50wQo0oW77q0Ng3jcdBiuX+Fnspwin4uCHfzdJ5lYS1JSdF9AL4sX3M8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=nyBVioGh; arc=fail smtp.client-ip=40.107.249.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQZNzoc9QKQt/i6BcT3L0TEMhHm7W3yLbKJrlK/8S2O7krapfTvVcx09lzx1QJ/t6hSnO9Zm3w7qalFhGJn2wOZCj2tShPMVl0CzmNMPT+M+gqd/TPcHjk+lEn6IjioBXobrxKJnms6IHYNOHpUr/w3gM0woyIMWv8/hCEj4oUeUiViPg2gWB8eQUC8MwT8Fv6rvp5YE5RzH7zrBPDPF4LA79pCbOjUF/nvQ2JxwE7iYjYChiAXe10ZEAjhwmIBk6N8JQDD+IbySOW4H91pkuI4EwmwVMjqmMh0/rN1reypy0tyitULioQlf3+6+lzPVs+V10A7KJ8xQjKpbNdQo5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmAVGc5sVLAp2q+kXlRMubSP+Jhbn1vzo3R9teb5aoc=;
 b=c0KAN2rrVBVBEJBrU7QqGUqgXQ1f4YbxnRxVVus1NXjcFSLX/a5HMsMaQNVLEyWgDvmqWkCF8gjwgxqS+ccbV6FwLUsUBY8aunHm3tc0y3g9zOC9G4Y4DdO8tRrzusYpqNpXNz9qzTe+tbcDUs3mT5HbREilzUik1Yv5M2wHgmogqojnb66jHmQZTrFb/Sl2tX2jKrn6QwW+EK+qJkCAckKFoboGv8p2tj94nZFxlPgzLS4fj5FAbODzH4WTK/tvjbMe58QE7ZpEGzxB7gN4LkeTU9EVcNn2K/F6gtZFQpN0mRWHndLnuohPcMRunWdi7SfZcxlE883owfzmJI3Ptg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmAVGc5sVLAp2q+kXlRMubSP+Jhbn1vzo3R9teb5aoc=;
 b=nyBVioGhHmlZh5wqaadKxBJi4jzWKPReGrHNLAUm8QkO/fXOoAAuMOYFBMw1MdbMLhIqfq7NbZshYJnBl4sfq2lHZU5CQcLjmBRKxdRb8s5dTezEI+LvntQbGakuwQ2rnrrP5/rt0I1Oxu+Hkx1ELj+NcPzp+lSDBzdsXddv84Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9377.eurprd04.prod.outlook.com (2603:10a6:10:36b::13)
 by AM9PR04MB7570.eurprd04.prod.outlook.com (2603:10a6:20b:281::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Thu, 14 Mar
 2024 03:21:37 +0000
Received: from DB9PR04MB9377.eurprd04.prod.outlook.com
 ([fe80::b3d4:17c4:91b7:101d]) by DB9PR04MB9377.eurprd04.prod.outlook.com
 ([fe80::b3d4:17c4:91b7:101d%5]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 03:21:37 +0000
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
Subject: [PATCH v4 2/3] regulator: pca9450: add pca9451a support
Date: Thu, 14 Mar 2024 11:29:22 +0800
Message-Id: <20240314032923.2360248-3-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240314032923.2360248-1-joy.zou@nxp.com>
References: <20240314032923.2360248-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:195::7) To DB9PR04MB9377.eurprd04.prod.outlook.com
 (2603:10a6:10:36b::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9377:EE_|AM9PR04MB7570:EE_
X-MS-Office365-Filtering-Correlation-Id: e300080c-04df-4075-0c8d-08dc43d5db81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+4ywlP358wSN649xhyZlElklVj04aKM9nNroOUxUKbFqydpK1+lZ96TenNAszZwRvB7Lh2V9A0i5zfNesVRm0QtDPCiV45mo9xTcH2BP5xQ1wMFuRxG2FHG/ck21/94nCh9EWxUyw8AQg8f7JESHTzxPQHGdRA49TIYcdmLp0xhiKXAWFN47jHkWlBOlMJGurJGTUVKKhloIz+c3L4YlJ3un8Xf/MsNH7YyXBYL3jXW50DdmLg+x85ispdMrLUZ36fLXC7fUAZctikg3/p2qwqPT7YwPeuAN1cahjig4THcLnZ+zEmTdKGwS6qu+HQELrIHJ59ThhHPtZ3nsRMw5Po8OSZdKKgDOhozOFYbazUI30Jpz8azrRyAul0kMH9CNu6KjD9TehgAlCCFXaN89btbGnpvECokFjNVyw1xSH8FKmxUOjmKVRfmNZExTLkEClmIxxRRyTsdkUAD3u9O/+XrRX/U9qlX11rcTgg5IoBVG6oORg9hjzD5L2fp1zZZlE4i7HcWws1I7FicHWulH+oojItlwMrz4UZPARyAmlsHmcTV5bzpTFb9GSf2fiL8pqjZrSsm+elxBYNegi8gwMRR7hPGnME/95knN8Hw8DjR5BHaZV8eFlyDtN3Sghi9YjxeaabXDmyeimwfyq2x4HWL8P9e7pUwKT+Xhbynf51pRItYXi7TGPDkhDWTD+208HSH1m/PqJ65GdLbKkJUbLu9vmHZJSTP+xeslY7sSJsg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9377.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(52116005)(7416005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YSGHZfI9Mq2zH0WEtZQovWlCIGFr3WvL/ii/ydzk+ShG9ppXBGyGasuUdRM2?=
 =?us-ascii?Q?iWzhsp5ssk5lMGjvWyYpzcMxA5gP+vkVKw+1Cl7DptjaFzVTfaDW9JGYEtSo?=
 =?us-ascii?Q?KL5BO+tJ+CePR4SiP2HJw3bOfxihrcqTmk5bzfeAQo3C6DU893qGk6SwORkB?=
 =?us-ascii?Q?7MDqNjRDEUz7Th58221qBAs9RQDZJAwbJYzTS7TzyMqROvuKKJoTDEYC4JGs?=
 =?us-ascii?Q?LtnK89DC/f2cGsNoG1IUX4jXzrl+2h0tR0Wf3GFlzPoKxRIBVEnAMVs1OBd4?=
 =?us-ascii?Q?0YBQR8qzVPPBxOPQ3RZ+E4WjqVFKt1WDBwnaGjIg4yqPs2dTOfxqa3oMFwwG?=
 =?us-ascii?Q?nXNtzEk5N9O+LQMJ1jST3Xwc8fDYbR1XdBNHJrlKFWuk0oV0Mbhbt/65ZLxe?=
 =?us-ascii?Q?NMbLCJ7fVF19VPowsCMf/BObGWHDqhtSxopBkkW8YrNlcR/tNwws6Q1ntBZ7?=
 =?us-ascii?Q?HkxZEZWtUh2Dczey99LUaCcrvAm/3u9hX4b+SQpI22gX9jWCbBjC0Kty0P9a?=
 =?us-ascii?Q?1VnpNImjxzZ2SsDop038rp6bPsT1A41MtkM9tF+JGRIDbsKRv6dulCQuMajH?=
 =?us-ascii?Q?2i8BJqXf+Z5y4k6Se8iGyBygyVi+2IJOTVwxkqFDxiE9iCWTUvmekGz98Tm5?=
 =?us-ascii?Q?ofNhpSwo8LCCcIOzt7ifEt03lU/qnmd+M0vx29XoDSsQ5N96DgoTlYOXq/hI?=
 =?us-ascii?Q?AokC5Sq8c84tQhc0dnCcSCdh2s9ziPzfE3MTxLXL5WvHoW3LhH/I/yATkMAh?=
 =?us-ascii?Q?7hZ1tmw4o8MYGwpPRAoHBlwjbwwtNkTpbAErx0/YcXgMRHadPeJNdN706PlV?=
 =?us-ascii?Q?qw3+cyeAcrht87iPGG/iJfTpN8SjHa35NEVEeHw0r1vEmboe+iMT4VgE1SCF?=
 =?us-ascii?Q?6s7lIO68fLhFTOiQa8xEdjkW1pNtgSelzX27g5KCEcMTDQDNadnGDHP0MwG7?=
 =?us-ascii?Q?pbYxJZ5YS1vnr+5KQacWNZrp0qW+4/whyd9lMx/Jjyb/uq3BXhB/Q+74/IbS?=
 =?us-ascii?Q?3qZpWEsbijqiUD66B3K6v9UyyCL3TiX43GGX2xT/qXp6Agty1rCRYiroxH/7?=
 =?us-ascii?Q?7NLvtgSoehxQAVPBNBynF0N6V06KwrMLKFmC+lze8OPVznXSMp6nYCrWPJQf?=
 =?us-ascii?Q?ccXuBR37l+S70MLysNpRnuQmnTmqcUyzzOK0nd/mP4BIIy7nJT/8HkyR1haU?=
 =?us-ascii?Q?YN2DwR1rqTvXa4ICfs474+7R9Tb2AbhdQ2zcyZv5r04wHyGtNix58W1ya4Py?=
 =?us-ascii?Q?WhxL9uxQWAYr8BcfcIZPg3gFXcKE58gu6TVyuVZ9FkT4ffHe2pqTScvC1bmT?=
 =?us-ascii?Q?05JwY/OMgjL4jTNNDjSthbjJdC/D0nSPSw7E0DCyTooSjtR7L0qyRTxhXNdH?=
 =?us-ascii?Q?S5xtsSzgGqC14pXobx0hMzCsjtr2IBac84DGeUEy55ILnUzr/RzMqDl2aKBz?=
 =?us-ascii?Q?kMPeRW2ARce7uVXD9Ja1Yzfwar5eFytiS3zFFKK2biKyp9vAvjPUTTNlF4L6?=
 =?us-ascii?Q?DoL5e94H1acLG/FklG8YSl6P44RQNf3F+0RGX5cnwtjiCy4ImNyt9R+myByC?=
 =?us-ascii?Q?jZr5EdllwoN7NJ0J+xm9IhcEZU5jRsoFH2qnPg4/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e300080c-04df-4075-0c8d-08dc43d5db81
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9377.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 03:21:37.2416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 48oeRQTjG3n7UY+xeu/YEJw6mTT0+PkVmhID3Wl4EZb7cRuyufXMKz3MifG0NT0y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7570

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


