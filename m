Return-Path: <linux-kernel+bounces-138033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 588C089EB4E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CD78B24568
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4C613AA4F;
	Wed, 10 Apr 2024 06:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EQgM8Ntn"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2115.outbound.protection.outlook.com [40.107.6.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF114D59F;
	Wed, 10 Apr 2024 06:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712732027; cv=fail; b=Z6/Ym1XuBWpqWzz93qQ2G2RqNwYoMJKtqLmgtRcjnmwXd5DT18cMfn2kR5zD/C9eY+xJtv3m94TIA0MnoHlEYUZ9si4FS4jtS7p3Ox4SKbuQAkZeZIhR16rXcBCNSTOahLqvlgAgkMhUnAtyqNoGCMd9yILN8HEeqnfWmC/8TkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712732027; c=relaxed/simple;
	bh=+TqHMhgDfv2rebdUrBo6CccG47NOugClAQaQySAwipc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eX1DxG49PK25193KocsYuaW0OwMLI2mfaxxQy4LhAH2WAOqT+XnminVFxH/jltzMFRi8WT6X4Y/JmTVfK/A6kbj6w22GwuBHtwlikQ1jFzTYuBnTTEaf9vCcuOep4z8m7+U/57Ntw6xPEN9ojxBioNe8bF7Ll4/blYxJTlX1hUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=EQgM8Ntn; arc=fail smtp.client-ip=40.107.6.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bUE0z8wDC3Ayr0ZgDREy8rzvgkstQ2iAf6N/zIm5L2Uq3A4X9vwEX+KLi3FUvZ6AFRf7JoqgihsxCcAFBsKCwIFpCcniXG6v4DvsJ1oNBVb1J4r+nZMLTJkouqeyZBzfDc42xdiMhsrpaOshnYplzP1opRA6g9BbbHxA5tkeMSxlM6F/JpJfZU4xd+EOBaLqVgxCkQA/aKp1Yh7DywbuQ+JjJ0HJ3rcjxBKblosuKYR/faX/3BuDpgGBlJTv7DHFcP+Qg3Z0Pzv4s8xBxQaxW6aceEliuHp5Zp5u3qd9KTSaz/+ldBU/YX0ZJ9BsRJmaah0kptXszbJY8g1G4gpqTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dxl7/m0qUNhnY6R72lpDaaF3WX6gYKYl9vpO6j519K0=;
 b=ZtvqN0ouNSSFINZ8BZub8bHYDCX4lS6bW2z2LPCWmhgweRyevv+eYW2EIOaZEOeH+b6IKATfICZe7EtRGV2oTcucvga6nYKB2hZn+Lgc9ZtLHXs7j+UOJ+TaBwSYUoocaxwYTLaaZ8UL+oNqKcSyFSGURK9qlN3TH9J3TQmEW/lEiuJJJlmHUp+XnFAxMeRjKjbX44bBIxJl/c5bja6zNcuubSMUcFtt+RnOtp0jy7kdo5t6BAqQMN54KTsTlrC/URKI4sCCpM08iSzlQ5Q8GeAyM0aGxQVhcW0iOBmtx3gJPTWfls0A0i/yxYcoN6hF8iwiiGlcwvG7AwkopsAhQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dxl7/m0qUNhnY6R72lpDaaF3WX6gYKYl9vpO6j519K0=;
 b=EQgM8NtnyoR4sdW4hT41dAfrjTY+aE80JC+9H6Z2STSsm+eVAFPUOBlwxMXNJnhmpPwnlvVoHHGsg0ic+SleiD0wz1IGKZ5BYkWLTkHQjtPEFWbp0+s6vwedFSjvfh77lCmBRcE00IYNVTlg25TSm2c9WiXfscQ/c3IfgOng8AA=
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by DBBPR04MB8010.eurprd04.prod.outlook.com (2603:10a6:10:1f1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Wed, 10 Apr
 2024 06:53:39 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba%7]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 06:53:39 +0000
From: Joy Zou <joy.zou@nxp.com>
To: ping.bai@nxp.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/1] arm64: dts: imx93-11x11-evk: add rtc PCF2131 support
Date: Wed, 10 Apr 2024 15:01:28 +0800
Message-Id: <20240410070128.1506555-2-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240410070128.1506555-1-joy.zou@nxp.com>
References: <20240410070128.1506555-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::20)
 To AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|DBBPR04MB8010:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	olKe6vhXYenghbEMCkfM9oo80tHPDOCObhBF9wVQsl2SiK1eAy9IEDTQrxYSKSuQF171kdSB/KpxCYfgJopjAnUGSq0QFg950PmTOB7KHyMuwyMgPY+xuN639HIYlpNHIVDSBGScQwNPA+h9Wm9kHk3sFomRKeTEDqsRXl3wZ9ahLAslfbwkskDQVr3Ur1lIs0/cebCtqc3LbNDtrZM6UzLCj41gDNc0sdeDpr9rmIuG1kriomzuWgRcYUtGQ+myRGhzT+1QswvtRUNwHMEkT7uWMFLiBaxbwy0LWsHhslgWZmeYE9EBMmB2vCW9ycLJfBgLyVDasWMHdw/7Pkvr8Gx3eAhrlzZUzUlf8hKxjNElJiSDeGp7LOVlrtEB1BPLd6ZLGPCL3TuvnGnsLgnD6gtI2HK/xrD53Y8K5Y9zmfD3/JcPNTTrHE+f8FOQ26ZL11Z2QGvjUT7Spw7nTvJy5rKHgL49DyWr+NWtQZ3SaPmTuIx8J0zgRRaS6hMrYmG0YOw+kyoREn3WOXtRMMArc1+eO0DzPk/pQmhv4BV0rhZ24a4AJHUG5yS/phTx0kI00C395r29Jr64FzlZOS2J8ReozK3QBwKXXxz2IoBk9Lp5wEn31A6lL2Opi2lHy2QJCKflo8+/OYehzv+ADZpoOd2L9fC14/y5vSFDQgP8iDu1v7RJXqBo/GPqF/FQrsZPGDFgj0AeRgukg1czJRTWoQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w1ZiKl5VK83LA4r4XC/hOAfV2YHg2TdJNq/K0r9tdiSmabG/EjVN6Vay/xw/?=
 =?us-ascii?Q?/2Pk9UJk5rycPLDktTcGCNpiA1FlMZoTj6KupAL26DICWI25Lt5vjoaH8cSD?=
 =?us-ascii?Q?VuaP3fYfALe7iTdF9MJAHXhh/B873twQBXjAnjE7Iyf49r35WCofKOuE8wAY?=
 =?us-ascii?Q?JN38e8Qzh7iJ4cMj/t0qdPRdgtawNHZmjnli8XHjv7YUJzJAG0zWJz+mV+rh?=
 =?us-ascii?Q?zfck/Da46rM9kUOXT27/EqLXQiNMV5tNAvVRidaw/JB+bRQ1PUCtEWe/XvYH?=
 =?us-ascii?Q?5Uwat0AodTfOivqWUASgV0TgHD2Q/0hY7i5ew4RR9UGYlu1YkNNfmeZ6hEkQ?=
 =?us-ascii?Q?xTLnbcEEtxphNrf75esnMrh5dB9U0Lt6E9Ys5v+NQ8N3ctovCGl23oNXdJfo?=
 =?us-ascii?Q?zLlfFKuwXFlL8Cyeqf3vDF1wgXd90GYCRuug2vtlXK4ItD48XQkTUzLeZkbf?=
 =?us-ascii?Q?G5HNei8fgAMZaaM7Xomd480rflvb2qajbE/qTyH7Y4POU93/FbZ5OS5wy3+4?=
 =?us-ascii?Q?UzcCBYPMTZtNH4rH6DlDmrX/QA512Z0lqf7+4Av/lDfONSlCMHHdBBYjyTUG?=
 =?us-ascii?Q?gkqlEWLaaW50rJzfiRaZkGIAysI31RAtVf2Htqq8y4HV3H3rEkbAQBFcNMyt?=
 =?us-ascii?Q?aQ76zSRcNVselYDK8Tzz0DLy+1d68rnbIcYrzgUAuCn4ZoxDAJAy+eqPkZwx?=
 =?us-ascii?Q?MXBG/YPNvEWZ/YpwVNgNnbhjyy9uz0DxmPKy81iOnY8RtSfnvHE5uesyJeqJ?=
 =?us-ascii?Q?bekf7iascglUjVs34Vjw9n8dTq9MpG9Q42pxngJPlrvlo5mtIRKBDHk+nbqs?=
 =?us-ascii?Q?UWDFBEzenkKDolsrnWeqaWUqpaedH2Vsgda4CtPrpJn2YVgqGm8HIdf1WUUk?=
 =?us-ascii?Q?77t54B+OT/6txmaGQSYRgbWsy7V2VSjO+4TVG8ftltc4MPKL2g+YZZyY7sht?=
 =?us-ascii?Q?Jyy1heL3z09BV9AYinb0kWQAExJlWB1k7T1pZ6njUAVy1lS9U/TPfNayI55s?=
 =?us-ascii?Q?qvJFqeu8+Ug9rhzN9V2oX5551GwwILhYxqW5phqJb20kCqq+BOcFLxkw0Ihv?=
 =?us-ascii?Q?kroj4y/5RCzGdLrr7bbHanNPBuN0Af5jU7xmxRrdYSSgG4mlwxGBje6rx69Q?=
 =?us-ascii?Q?uU5kPlMI65V8fuLrhGcDDW/q57rYfqftfKLKhra+pyCmAHun0XlKg0w0z5zt?=
 =?us-ascii?Q?zT37oZJWDXcexTcmjQa5m1f9Yasl+KW9CzzzpZtPykn1OzbYfLpyOa1HusOC?=
 =?us-ascii?Q?2De0ZrGEgMKrAdLzm+jb83Z7c18aNCN0tZBemQ0te6GTjjKzymf5099onAaK?=
 =?us-ascii?Q?/i7yPH3kZSRSQA0wFbYvFA5NZ5optuTMdsoMMQ3IrxIx0pkn+ZXlAb0Tqecw?=
 =?us-ascii?Q?f/SWsuyliSPrySn6uU/8NamU1Rk7Vb0IC7nuCD/IGfQNPjYYgApP8l/xZgYF?=
 =?us-ascii?Q?tFb28SkBz5EIk7NXjvt1ni9E3Oa7wHmFOQhFPnp4NOQZGJ+NE2shQArn+lW9?=
 =?us-ascii?Q?iaKCnm3zC4AxblSXQdEJ2WK7WPnjD1OsPWEU7yQO7h3/1kt3wYcvaDAkg3cn?=
 =?us-ascii?Q?eJGvvPrTSx+R8EPvC5moxugQygfwNPLZmQiq5qEG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40124464-8a20-427c-9567-08dc592af3de
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 06:53:39.6619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mG7cgLITdjBgF0TPClahZ6ThvzLw9cdDX/IcucK1+CEQOIiQISWbcYBf7WKecx93
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8010

Support rtc PCF2131 on imx93-11x11-evk.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes in v3:
1.adjust the indentation.

Changes in v2:
1. remove unnecessary status property.
---
 .../boot/dts/freescale/imx93-11x11-evk.dts    | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index 07e85a30a25f..73e0bca36b81 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -281,6 +281,23 @@ ldo5: LDO5 {
 	};
 };
 
+&lpi2c3 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <400000>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_lpi2c3>;
+	pinctrl-1 = <&pinctrl_lpi2c3>;
+	status = "okay";
+
+	pcf2131: rtc@53 {
+		compatible = "nxp,pcf2131";
+		reg = <0x53>;
+		interrupt-parent = <&pcal6524>;
+		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
+	};
+};
+
 &iomuxc {
 	pinctrl_eqos: eqosgrp {
 		fsl,pins = <
@@ -343,6 +360,13 @@ MX93_PAD_I2C2_SDA__LPI2C2_SDA			0x40000b9e
 		>;
 	};
 
+	pinctrl_lpi2c3: lpi2c3grp {
+		fsl,pins = <
+			MX93_PAD_GPIO_IO28__LPI2C3_SDA			0x40000b9e
+			MX93_PAD_GPIO_IO29__LPI2C3_SCL			0x40000b9e
+		>;
+	};
+
 	pinctrl_pcal6524: pcal6524grp {
 		fsl,pins = <
 			MX93_PAD_CCM_CLKO2__GPIO3_IO27			0x31e
-- 
2.37.1


