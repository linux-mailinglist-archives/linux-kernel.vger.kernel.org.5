Return-Path: <linux-kernel+bounces-83935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B763186A040
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C0A1285175
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7678914939C;
	Tue, 27 Feb 2024 19:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="om43j2Kg"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2052.outbound.protection.outlook.com [40.107.21.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B126A14900A;
	Tue, 27 Feb 2024 19:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709062277; cv=fail; b=fmEoOsE3XR2a4YBPe6aOGrqDNDwgXq7NcUZHkeJyaMtX25aVFJnIEnyfpXP6z0gIiMmnLNgy1Sd3VoqZCGFRWHbLob+6ottie/0UJeJ/rmX+SxYjdEWXJSejij4c945s28/nNpzrXEB9NjOjqDcFGSQmjswrNiRJP/YEIvpwaWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709062277; c=relaxed/simple;
	bh=+wseBTlpnPrjswo5b2561s+EapgVyK/Xp4y6z+dDaiU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VKusOzwtiqhw7nAKq25zAqdNo2ePZqm/V38jVDF656ntDAzUgb5YbEIRKh4YUVQUrtSzJ59SM3xHFWbogrblmXHQvsxYgF+l+h6XH17v1nxRDu4RCx71KktLJCFy4bskIRpIGSx1MmDtOE8hGH6aoTliEKLH3sUi1OXbJq3RAdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=om43j2Kg; arc=fail smtp.client-ip=40.107.21.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=occfNMNsuQ3ZV4gB135ZaTu2dIod2KH56bSWESx9nSDPQKv2oesU9TR7lhUi1In6HAWCXDUp5TymTvi3VhYicXPozqpacj5xItuUZq3RDFI4Hgb+DDScOk4RqIVUbVqLCDS/eroFJOxyQX+/PmPc4eeuhK1TONCb6ingRNDhOuenGabi1ZjOlxdQa5JBe3RJzU6b9Q8nXyYW7xJF8X3d5k16iDd6zOgjKtRv3tK1wnLvB7VAwi7ZXMTb5krVgKgArc2j0kJq4PHK90BWWv+7t3cqws4EuMU1cID66GNmPDSz1Sb/wDi3ygbBPGFFg+gFdN/FWFi+gs5F544VVXXFKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=En3DJakeUn6x/tBA5jMtPHbdJDMvB93OvXU+bO31jE0=;
 b=Ss8YyhQ0nVM/yS5OSucV+v0vx0F6oeBMo1VeJjHbktkyMOETHBMMDklbgSFEeJuefILXOUjYGbBZvpu9CJkQ8gkncjBZ6T3R9Efh0qxNKTlzYT57BY1RRqJAUk74NXGiU6IaxLSWqO7EbZDTNivC0hT1LzLRNDSdFrCnD6rrdBYaM6gi407zb7R4H0MSHYOEmx4Ou5SfdHA4IR1u0DjfU7MCoTisZvNb1Irt7Ddo7PEgd1iVJwnbfSfv6/uUtFqqISLiH65pWuN8g56QU78HeLwupRkXUx4VoHTvSPbJP4nuyw+Xp232H7KcaZRarPWSx5m7DUXa2ZKdDdswDVLRPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=En3DJakeUn6x/tBA5jMtPHbdJDMvB93OvXU+bO31jE0=;
 b=om43j2Kgt3gvdVElfCneDcy3BWIH11iVHUsCqkEOQBmqT8Z4DQlzWE25XPWqVTx1duOPdbpdSTGCP8QJj1wfufCzzOenKlZbSlyxlX7N055KWD1bVHQfmoUlgPyf86PYSUIS/pk3QCLoezCSk5mxkSadYTVeCd9ULvH4dhmKPh4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB10283.eurprd04.prod.outlook.com (2603:10a6:102:463::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Tue, 27 Feb
 2024 19:31:15 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 19:31:15 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 3/3] arm64: dts: imx8qm-mek: add flexspi0 support
Date: Tue, 27 Feb 2024 14:30:48 -0500
Message-Id: <20240227193049.457426-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227193049.457426-1-Frank.Li@nxp.com>
References: <20240227193049.457426-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0056.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB10283:EE_
X-MS-Office365-Filtering-Correlation-Id: 19d49b5a-e74e-433d-9c97-08dc37caa9a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hZYyKkYc9iFe8DKfp1nA+w1FS6xxZX1qTuX7/zdeXv++ab1422oShuqJPCcMP0zjQjili2dZ913hMyqF6tGpyKyisF3jEwkDQWy2FdRsnHyrzKEknyDhnkZ1FKaScaO3rpclvMkIWPrZUcqjON+SY2B8sjL4ueMxLZMnI4HX67V/4Fg43Br1HYWQ/Pgy7otylCi6NfNAxikQCOobW4hl03GEPvcTgnQlUdltYmcoiJW6kGR4iZOQHt0UVbCb60efndBTLYi0zw3DLuaL71lrLBHGudbQlf2PRI0YOWyx3m2DNr0RLBi2rn1fKJloZL5u5YPLQ3gasuB8g7xxU/j30l8V7uYarGMKacQoy3E9BBU1J3ru6rVaLeJ8xH3pspr7VwT/wG3Myqtr2vbVm8SiHvX+BHzgvMi6ejYtXACl4DQ/pomgbs4oEswYJovso9BrIgMjUwvsdNh6MsvoMo7giXiydkiI36l0aJYc24B60qxNlh1Rr96RvY5/+oWxdXjmUGcp+Gpd1qeyFSaepsYOi/EoWSBzrU+qoAFqCK6J2c15xRWTWMYfrE1jUy8eo8sa8n72vtQ+momBHKObWJmf2JweDhssnRMxz/twfEVDqxHSsnGVuNwBcxehd9/Megv7hwShqslKzh5kWHJ3SPuomYU2nsovYfGM2NAbFfuSX7q07e/M3/oyD+cA0N7piI/IPYimNF0dG1XWpPFnVti29GdE9aHja9ILBPWhS+Z/kQI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8i2jeggvOlqjzYkNjAFOw6zGloPoLYnm1PNZXmptSz3pmbvG8dk1PNLkVsVc?=
 =?us-ascii?Q?KFKZB6o8Ve4RhSGN0BvKZG7+J/VlTT4omv7ZC9u6CEPJJFPXoDvpYPsb7oul?=
 =?us-ascii?Q?Y3PSKNnjMLVMf7RAObSjRBjAqSPnljPmJp64D8a/uy1ChKcYa7uFHt6HFJI/?=
 =?us-ascii?Q?ubtqy2oHAUwrcEEk9vOdRx/FGWmloPdDYbuqG//QVBUgvFMSRWTh7gjAXN1a?=
 =?us-ascii?Q?EatfcptfIqHLHzYVi5KC7zfOp74Yq+rSiD124lfB8Z+176BfpoEi0XpGiZ7H?=
 =?us-ascii?Q?6M94KY6bqZqtD5YMjfC1S40524wExiZwbuLEMeigVGV6fYdhY8+jznri+t3d?=
 =?us-ascii?Q?bsf8I/bRR2yKF5v6MKyYd134oO8/IYIlfBzQoK2A+vPXtihA72CSXY1RwzRN?=
 =?us-ascii?Q?Xdu0EqAgtNTpOSqbEmVeAotaS6BzRkIAFqjzFXbXWkQl7CAmxTBNAEO+vozy?=
 =?us-ascii?Q?nMQEi5Hs+5AkbT3ghmS/+s2G/PMQrarDaUpaZyYXYOKc6Q9059vwjcgBEXQW?=
 =?us-ascii?Q?KQZITurEp3wcTI3fniN2K3WhUUUqqmt7LXOBuv2aCfhstTlYgu3qb06NadsO?=
 =?us-ascii?Q?OSKD0GuKqEDShGMueolytzaQ8W9ekMXUiLO8qN/tndxheoFrVNcZLtjqzPGY?=
 =?us-ascii?Q?rIBjESP3wl2ujC5NHYMsfVSwKzaSf+lhcG2BgJgOgsEeM6LgFX8RF9GJ4Z6a?=
 =?us-ascii?Q?GtK5sGPjgBIJiIsLlzzSDm0KhKQwRoOLikUJq/dFaPYWTAHAACvglWozz41H?=
 =?us-ascii?Q?D9TNAlDZT9++8IAD2fhmiCBo0kYy/R2+HjSexbabJXxYJDFaoSRgy0kIWkZW?=
 =?us-ascii?Q?R0KycAIlwrLdYHeINCAFnyKZUfkKpkQXq72efFCqC8ag93+c+Xcmfhun7fRC?=
 =?us-ascii?Q?eKLdtYBx1obVNOCYHd57JPIppxHNjFRM+KoEw1uvWUH/9pE4AyT2MTvPXF29?=
 =?us-ascii?Q?AHUHuKrwPoi1zEC4iQhPS1w32d1I4XCQQw8DN2oknePkGS8lLmQ/smlfDRMC?=
 =?us-ascii?Q?TtzbgcrRJsVG1fh8SHTq7/+7OKtCIwgCDwLKr1psrAn1Cdifm38ddnzOkF2t?=
 =?us-ascii?Q?kYB+7lDE+TYqXgNor0sUWipH4akb0ccI1shtRjDp+VnhnM25Ii8ogLV+KjzU?=
 =?us-ascii?Q?/th+MnxtgZNzDLplbYXny81WvzLpWtWhfb7N3jEPq0Uy5gxlkTW+7iT1O4g1?=
 =?us-ascii?Q?SqxbiTJJ/t9NbiJrbWQJyhaibN6NJlN0k2OgeMdpNcJNHZl4aIJ2wDm+iNPm?=
 =?us-ascii?Q?opO4jY6exBqfg+UZso/zeJDSECZoEw7NZLAbZtMn3OdDRdFj2ri8pE9wdjYj?=
 =?us-ascii?Q?2MZxXc4noPBYSoPaIJkSVgCeobSI1o3cx0Uh/dLu9DglHSRybOIc6gy8CIWk?=
 =?us-ascii?Q?I2rNfebXAN2WUsj0+43Y0pTRVF2Y+ksAi/VSSw3G1orIw9Yg3Uggxg/jIgq2?=
 =?us-ascii?Q?PWg4KsLZmphdad6fABCLuN5sFo55A22zDxni1zEwwfy6WtAUkWaiH0WNuYYF?=
 =?us-ascii?Q?NV2VhOwm6ish+eleTqjB+k/f3lmDotzQP7eI7T3KLXxBnkqIEV63ny479gFk?=
 =?us-ascii?Q?bWZXhE2IfPuooosQeSHjA4ZYo68jCsK3ysHYvB3U?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19d49b5a-e74e-433d-9c97-08dc37caa9a5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 19:31:15.0258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: coUiz6ixloBAjHm7mtUefrkoqu0Tz6jQh/zw45bFGvsU06k7ZWVbuPgsfjHhNPojr+Z6iWNB3LQ5XH2mmbW1qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10283

Add flexspi0 support for imx8qm-mek board.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v2
    - use flash to fixed dtb_check warning
    - remove usued property nxp,fspi-dll-slvdly = <4>;

 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 37 ++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index 66e0400d7bf8a..5c6b39c6933fc 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -100,6 +100,22 @@ spidev0: spi@0 {
 	};
 };
 
+&flexspi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexspi0>;
+	status = "okay";
+
+	flash0: flash@0 {
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "jedec,spi-nor";
+		spi-max-frequency = <133000000>;
+		spi-tx-bus-width = <8>;
+		spi-rx-bus-width = <8>;
+	};
+};
+
 &fec1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_fec1>;
@@ -198,6 +214,27 @@ IMX8QM_SPI2_CS0_LSIO_GPIO3_IO10		0x21
 		>;
 	};
 
+	pinctrl_flexspi0: flexspi0grp {
+		fsl,pins = <
+			IMX8QM_QSPI0A_DATA0_LSIO_QSPI0A_DATA0     0x06000021
+			IMX8QM_QSPI0A_DATA1_LSIO_QSPI0A_DATA1     0x06000021
+			IMX8QM_QSPI0A_DATA2_LSIO_QSPI0A_DATA2     0x06000021
+			IMX8QM_QSPI0A_DATA3_LSIO_QSPI0A_DATA3     0x06000021
+			IMX8QM_QSPI0A_DQS_LSIO_QSPI0A_DQS         0x06000021
+			IMX8QM_QSPI0A_SS0_B_LSIO_QSPI0A_SS0_B     0x06000021
+			IMX8QM_QSPI0A_SS1_B_LSIO_QSPI0A_SS1_B     0x06000021
+			IMX8QM_QSPI0A_SCLK_LSIO_QSPI0A_SCLK       0x06000021
+			IMX8QM_QSPI0B_SCLK_LSIO_QSPI0B_SCLK       0x06000021
+			IMX8QM_QSPI0B_DATA0_LSIO_QSPI0B_DATA0     0x06000021
+			IMX8QM_QSPI0B_DATA1_LSIO_QSPI0B_DATA1     0x06000021
+			IMX8QM_QSPI0B_DATA2_LSIO_QSPI0B_DATA2     0x06000021
+			IMX8QM_QSPI0B_DATA3_LSIO_QSPI0B_DATA3     0x06000021
+			IMX8QM_QSPI0B_DQS_LSIO_QSPI0B_DQS         0x06000021
+			IMX8QM_QSPI0B_SS0_B_LSIO_QSPI0B_SS0_B     0x06000021
+			IMX8QM_QSPI0B_SS1_B_LSIO_QSPI0B_SS1_B     0x06000021
+		>;
+	};
+
 	pinctrl_lpuart0: lpuart0grp {
 		fsl,pins = <
 			IMX8QM_UART0_RX_DMA_UART0_RX				0x06000020
-- 
2.34.1


