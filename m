Return-Path: <linux-kernel+bounces-137862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4776889E86B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 05:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B347A1F23077
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 03:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC978F6C;
	Wed, 10 Apr 2024 03:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qqXEqrBv"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2113.outbound.protection.outlook.com [40.107.15.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C26C144;
	Wed, 10 Apr 2024 03:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712719512; cv=fail; b=Um0EYlQ/TCClrHjtYSa67sHEjnMSdJUI7yh6acaCSbcjOubbfqDC4Dndl0WIuiBnRY7iXs9AzA79g5UR1wqic30Ha0r6aseG0loezXYWLi5bwuEUsAEZEg/94XGVgOa3ziR77F/dxuKl0yPydyU4RmZwKNhxrDO0dfL/XHeNcvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712719512; c=relaxed/simple;
	bh=W0ot4/S5G9ZyU2z2TFcSUG2Li1SjQT8omxmbq4LcZnM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bxJNUb5hukr+QiWKr10TAqHF08rovoCuZ+Jt0qr9yP0TNJnclYSbk9LFizJ+TatpvTdTAZkqzVSxjU6bohOZORd8mbNMW+hkYFpmkozxDHikyco0uv+etdW7Hjopd75CfXOw3mRFy76uf2Uy4blT8C/8OppAkINABho8XSFV58I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=qqXEqrBv; arc=fail smtp.client-ip=40.107.15.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iPGTlLTtY2MKBJPOicwy5IPCdl0GaVEhFTkR/FVxYKCqt1YoJOuXFz4u3A1TrQotyfWRqgbHbE4WpTKhBCz2JedYx7avSpudnNaCD7TE8xlbYjjwVq2GKlTLxBbdEMPiq0n3s0f5Ph+Kq/8QsWC3k1ZsP5HD/ZmF36qO5P4FGmdQGRMwPQYFaHf6k9tXeMXQhCyVmYk+rOfcpndiZOB2E4X7cXN2jhCXNDwljb0r2U4LeYjJkmFKBUgplV0pf6cZ8dz4jLATEls9zRdkPrM2EaLt2zwkYcysBZwCMWjWxPGhjiTRXUWrD1ZFMhLr2YQ0xfLD+Iht3juLDRqS4M9Hbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=chue6IZW3eyhjecTP6Gal8RcLbH98tLq6aNsfnPVf6A=;
 b=DWnC9lm96RnjBMiAauJz0ugcqEsvhZ/Ht5XMmtHxHDpxhBdJnWdwA2aS/MFQ/ZYJNum4onKJblQmGJq5731p7t28iqzlXRVOJryRm7WIfgT/DnBRmHgFbDCiQibR339OS17P0aVMWUT/aRAJQy5BOy6c+PfMwFxoMz6Kw/4NwQ4a1mgcufdININFhte6PX/FcbCQGAcTXaU6T/5sgS+fWqcsRxj1Uj9dOmRJwXc9rYkW1JeBIbN8+FvqyvQ0P1ISVcTO1u6ER8HTOHH9qJwTcNu6EnDAfKN6PGIVjibjTdGy1eQd+cE16Tp9Or5HDVBlzQEegFh0a/rH7wolg88Uvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chue6IZW3eyhjecTP6Gal8RcLbH98tLq6aNsfnPVf6A=;
 b=qqXEqrBvDTwQr13BQKtH8lUuJOVzFc3fwdGtNghYlaOmmq5M+iKCpuFlcjFOPcV//bNJs7NVUEEYlxm7HLhzxrP0vZ0SRYXbrdHYIaiNze+VoFhNLQsa4HeKn3b//cegRfHzxHpXShN1FvUggazhcfHn8FzRFUClpHdAipxOMz0=
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by AM9PR04MB8684.eurprd04.prod.outlook.com (2603:10a6:20b:43f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 03:25:07 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba%7]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 03:25:07 +0000
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
Subject: [PATCH v2 1/1] arm64: dts: imx93-11x11-evk: add rtc PCF2131 support
Date: Wed, 10 Apr 2024 11:32:56 +0800
Message-Id: <20240410033256.1341662-2-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240410033256.1341662-1-joy.zou@nxp.com>
References: <20240410033256.1341662-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0039.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::8)
 To AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|AM9PR04MB8684:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	q4hZqI8QbFrieM10G35zbZb0SSoGJ3ud4LE5PJ+jmaCqdAYv8FgCYJ1uvU4Hwl/qz7IuzodmVfnOzQetWP79E+/lqgNbFbNGHpd+4+JCXF0uV+F+3OsX1d1h/J8m7303NDJEx8A7HMElvZp0hwVoPsHM4vkGnZXFEgxtV7V48Qx2pDzgmhxRM8o4f+kZTlZoYOtLKqYKlSkMijZUL/RvwF08zpBpXhb7bd3+HzTpxO7EvZ2De9VDeKtXwgS9kBSNsc7jXHsZ/8C8gTmjpd180YILS2aAO+zfxPza1cnZog4k3ey3zUQ0UF7qkdedAcjfH4wRI5gnx9TUbsbGeoPqUKQpaHmQLs3rNLFunW/9mpkwlZH3ANVyiWvdnGd1DlF2EhdU+5SpmTpCZG6yvJv3eOWB8TWz09BEEor26cZwkfq7bd3set5Ct/xE8uuTkV/rqeTvIJoD6GeBTHtbvvWYGhDQlDHDD36Ym64MqhZ8nAzqoFS4M1Hnw3/Qgq7ehyRhMZCyUIPaBuNsbFTbbsGDleAKNMocIglG3KxhTljMoVjolar3mBAMNH0dLy/i6TUb7bJBExHbJ1EtlLtvxA4JTPnGeKgb1mzXBBYp3yCSxlasU8HSF6QbojY6MDcWNpzjv6+5ZlG2jw15nPWPQl8b07bQuThEq5d7YUWcb+ICCMYW8DDdb0UkLFtfLDAG6rlDr2UX7ICLD83D0RTdzdQoGA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(52116005)(376005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vUuB6iMHGz0dn8PVoQtdkPjcpCJ+4RBnp+e3fIGy6XiwpQGwhS8net0VAGvz?=
 =?us-ascii?Q?VHsf9vBdHWbOX0Kdl5R7bni7Q3OA2UYHJ3E3ochECju8m8i7IPjt9pJ8UC0i?=
 =?us-ascii?Q?SrBibP7o9EM2xC/wr0Yt8myZZsW6za6HDsBwbpMXRmxk0c9mluRgmgAHP88S?=
 =?us-ascii?Q?M9pdWr6wFs/kAgwxLhLIWJHRPE7xuabmdF8vOcuGd+LL1U/NBd2po4h1IPWD?=
 =?us-ascii?Q?cNBBMyA4VeeJOf5X3/GCRjLXlkAHBJ46iwA+mVNqbYWo4YCup99CVVdv88QW?=
 =?us-ascii?Q?7av3PRQN7ARh77zA2wnPiO+kh8Adc5PHKBAsKpRv27a3mjPjjvDvBDq1Q/S9?=
 =?us-ascii?Q?3qZu4LmGoZJ41yoG4bU07un5MMXfjHUvtfEzEs6Tmu8QsWQwIV+j1Vvy61FC?=
 =?us-ascii?Q?OlujYWH/LTmEvLLLk8NvJfRRtmVhXO3wnaOckkQH8hzCDvKs36zdxSMJ3ZP2?=
 =?us-ascii?Q?EtKNiL1jj7aSy+VAuTpPZnlk5yLBLyBXV5hbTyWYuzCFgzEgNu9BumBYxeij?=
 =?us-ascii?Q?GbHh4o0XSovcOLr4Yk2XSgamSB0D/esL8bxNs0lNF0IyuDL4rh7vbXVAlYLv?=
 =?us-ascii?Q?pwYd/QWhTy5gp1GHn3AXQ8BvgzxoNgAboZRs3ZFBnk5nJJuBcIiBf8GdKQ98?=
 =?us-ascii?Q?AvYfnDlzdcG+MDwi/7kPpYq6Wu6IyIs9cw0fLr05+GMoiSUoti+J72oBQ20y?=
 =?us-ascii?Q?TDQVchzRxgh2vCSKrz0xP2LP8LD3KUa4ano51sQYXIeGzrbJbr1etEXX7PST?=
 =?us-ascii?Q?YR0NYBjJrJ/+5sAI8yANDaAlWUIMQb1rzfquhl915hYaDfhAtbYAC5UA6aty?=
 =?us-ascii?Q?af4P+LUqHL+jH9Di3gNOs9hlgHwyEFya2BJpvZ09bVHXca4p665OxLGG9kuf?=
 =?us-ascii?Q?qLVp4dpWXu9exTKBChu9ZcFDGtVOR7JkeDKPgC/nxRiHcZvAblwPCsRiMXOI?=
 =?us-ascii?Q?N4n0O214G7kZMPm/pfS9/x/2MHmQvj6+KsElSJZAahdsms4TW/yfGEZo+omf?=
 =?us-ascii?Q?8So0qyoaQSVutGq94n3bLTOUNEiOGHoiE9XVY/G73tH8GyFyfnjvwkJIYhHJ?=
 =?us-ascii?Q?9m1u+UcvF6U+SvijYfH7FXKhs3IPq8SZxUPp7LH35NZei96/eWQdskwTKtmq?=
 =?us-ascii?Q?Y1Hv4P331SDjHoETjQ7qvuoEX1V0mnwtJK3fofSpDYQqY6Px857Vl3vE0WL3?=
 =?us-ascii?Q?+zjVBgIbha5+Yib+cUsvi7vLQSpYcDvM6J+8v+J7ZvKzgwpIsqmUsL2vqOi8?=
 =?us-ascii?Q?H+aj456G1Z+013hDMxAkgJ9OPy00pe0MY7aIGp/3RXYN0nh5PYMztH1sUW7K?=
 =?us-ascii?Q?Z0ZKmqKLxM0ZLNLk7nEpaEfq2Dgas8gJRJ0Tum3iWrXmIAQsI6tyS54f7Vxz?=
 =?us-ascii?Q?iTTIbL3RFRT1uYjkfZxbvrj1J7kGzZWBQy8P0PnxWyBmbWD+4bifJFzFkrd8?=
 =?us-ascii?Q?CyZGC6uaqzr8lEiMOoF2KAglmlDpegQFGrMYFg3Ik42Itog8MbAZ7Luo/tD9?=
 =?us-ascii?Q?ERJIAQm5GeZMoyPkheXMtBRuIPvi6gL6vC++kw+/ffhydmHvQ1uOgXSYhklX?=
 =?us-ascii?Q?S4L3HDlM4n2CN2+Q6+ZNeADg/g7TaRCDlcoCv7AT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75ce8b3e-0e9e-41a5-3374-08dc590dd212
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 03:25:07.5024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bP8LGCZbTpNpyVGp8xP39mRfCRilEBpyNBXuQ9f4eVljoWlpG3WQA6klvLDr+K0M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8684

Support rtc PCF2131 on imx93-11x11-evk.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
Changes in v2:
1. remove unnecessary status property.
---
 .../boot/dts/freescale/imx93-11x11-evk.dts    | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index 07e85a30a25f..e66723ed25c2 100644
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
+			compatible = "nxp,pcf2131";
+			reg = <0x53>;
+			interrupt-parent = <&pcal6524>;
+			interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
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


