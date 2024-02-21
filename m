Return-Path: <linux-kernel+bounces-74279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECB285D1FF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7210B1C23F14
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D0E3C46C;
	Wed, 21 Feb 2024 08:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="N8TVby92"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2088.outbound.protection.outlook.com [40.107.14.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118823C063;
	Wed, 21 Feb 2024 08:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708502572; cv=fail; b=Eo4Um9NVevluKeVOXxWo+iCWwu8QBs/SrrYR1gdmh3+4niSeK7YweZZ1ce6GuAUnF6vB2iHKQDRCROGTsqFK1hOIXWS7FmCjHxp3D4pZA26wc0X6go3ppY2LMbxclSn28p3dZ+27u87fYsRIA7UJPASR8VeDZa/ydKFeQtyK148=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708502572; c=relaxed/simple;
	bh=ip3NRcBjJBYZQAjTt8tdTZ8nyIXPf/o9InNMQ3QIVE4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Npbf7o72qhNcnlrlq4a7fFD0rdAXqdTg/U3qKBMVGJQVvSUOzz5CGDeSJwApALmC4+4bdSc0d6I2SxO8qfEldGcQzm+HD+GH2XynWxEjOY6Di+DfdU5mTT/2oWgDVaYSS08S2A/9Fv+wVh0Vtu4AmRitLdZVaYd3Okzd4cp+nuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=N8TVby92; arc=fail smtp.client-ip=40.107.14.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QTX/HYc3JazezoD1IIv9t3TMj9jqkLBJrO7Au8rvgtzP15LHXQ9v+W04r2J8+FfsAMsh7MAwGDIKLsuU0e+JwGbVz0BRzskszI84YLT9yYjyKbisp4YiAM5qg9hGN8gTskVu42MuRhERx4l4o4MfA+dnRts3e8rFONVFWM7O+uRcyXqZ2zItgVb4ImRFT9K78xw2cu6jSRAKEMgt+QtlpTcyqEbqm5vsc5Cc184kbNQo1/9zPSNn3d2YcGe8FjOVnTXaPjxcYDqxEV8oVd15OofGaCygOK59LUitJ3sDHKVUoaQty6D8YSnFGGZltXyHdI87QGMm1Bbb/6Up3OV45A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3DUPiZyCIF0dCjWANuXzOz5GbsYzZUw6r+jJ0bIXTw=;
 b=eaLwR0GASAlIyP+Zg3za0ln/sUCpk4HXyxQYgVJmgfBYDiDisiYfV4y16kqiiR8q8d/J0g/jT5ApmV2x9lUwILB3s6KdBSUJvprkcel4ao4A2j/XKoEmHbmXnjHfodbL7xfjCxAqsN1nZStpc+H+1jtVkdhiY1D7R03fBw/vj95H0hODLu6EFcEEcIgWh+SQuLIPXIwL/3W6Xol4n0IHuZQgTkDBi20T7Vvq5eTl96k+RaCaFMBPBxz3YyWacAuw+VxQDkdJv7gI4zey23opV/roA0vTu+LumTnHkwqA/r7tJZ5qH7ky7MW2WY5G28fZdC4HFabPPZUPCfnVXFijgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3DUPiZyCIF0dCjWANuXzOz5GbsYzZUw6r+jJ0bIXTw=;
 b=N8TVby92fCHet0R3uruRtXOJOGwz2z/9Kha7E2RvKrqinUj17FD7sGx0JqrQ9Ep2ZXn1XCMVzaUtnhWQYmujCNyNWF9xSIganwSOJL3u3eBkcMY43ciOUNC8P3kYlIVlPLg9qrYN5vyLTkHeKzw65au/2m0oebJwVB9FCi7LtjI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS5PR04MB9770.eurprd04.prod.outlook.com (2603:10a6:20b:654::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Wed, 21 Feb
 2024 08:02:48 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7292.029; Wed, 21 Feb 2024
 08:02:48 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: gregkh@linuxfoundation.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	shawnguo@kernel.org,
	conor+dt@kernel.org
Cc: s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	peter.chen@kernel.org,
	xu.yang_2@nxp.com,
	jun.li@nxp.com,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND v6 2/9] arm64: dts: imx8ulp: add usb nodes
Date: Wed, 21 Feb 2024 16:02:31 +0800
Message-Id: <20240221080238.1615536-2-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240221080238.1615536-1-xu.yang_2@nxp.com>
References: <20240221080238.1615536-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:4:197::15) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AS5PR04MB9770:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e9afd1f-815c-4f30-6fc5-08dc32b37e6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tYxIG9zILQOMiVOWX/lAa73Dk42FzHwJ3D3S7p6JMQzwXMrd202VuzwawUaH+5JAvm6Xtpcmx269DI73xSNu8sTfd/t7wHZo1Ay+ekbPv56KCOTO3DJ1B3f7A+jRE/pUtjb5CE9OlMaOnkYFSwcFgjMfTeo9uBr0kDTCMonE6yNr48h2iheKwwhEWyBl4FOIIBgjwmKKXwwwVOPY4/GbBXmMfsP2mrF5y9BAWjhVyWzpyrEYNhWyfGpoZGY/9hKZBs58jQUOjnFGQ0pucx5a0IBZmpuTHpEX8bNlQDeed//zqgVTkgAzlalgiRf/x8Zr6TGoRhEdi43G9+rypx6skwphjC1PuZ2RtujqphaFZeOlNTF3AJ/20HbVSQuXK8UriH7CzLsMEUydkOPeKl5As1hOhE/GWl6mB0ip7VYOL6G0Lse059YIUxfweOpn74LnwgVQIMude1zOMCTY7uHN0W+n2HAwSQ/PmsGAZdWE9hlaErcLPjhxkhEISBHFI6MuK0MGD6RNyP32c8mWeBkRbYIq0Vm+vRIXvz9NZXdizfCrQ5ZrwUuk2bzLM6RYqxVgDZpSd/GXZgsUvpT7h6rmjgNJ5C3YwrswFLGUJoWaAMBZa8KhM8r8qPLYqFaH7k2D
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gqAoTTUtHRRQWQSpu5cccimp8j5la14c54q5KNVXRCcgzR+Azmk1/YKmcUEZ?=
 =?us-ascii?Q?ToHF32KQZ4iBjyAAqIFHl7KM2/h0oB473mKcw9SqXyh9aqtIVaF+qJ1PC1D2?=
 =?us-ascii?Q?TMein9MHiMYTd1QEI9yofzin6ptTl2YME8s3X06IAALJcRVekVaGn8q391/B?=
 =?us-ascii?Q?sVa202u0FfdfDQaTCpbfKSUKLq8nlPaFUunSNMxZ3BGxNw9UO8oPmbL2aEPe?=
 =?us-ascii?Q?elyvUWGREpPbXvMCId84+N4wWmc+Mzmts8/tDpVZB7Hyvh6s0D8E7DCFqzxa?=
 =?us-ascii?Q?XqHwpe7vfo67n9O360VeR7VaexKTqy5Khst/lir7/20YC1hgPM57DlxXP4Ta?=
 =?us-ascii?Q?Vmrue3uEtYTcRFCAVzkmJM4Yu93cGexFPsCYTTwhV7TC0gZgti9frm53wJ3P?=
 =?us-ascii?Q?y0y+PKVdR6b4OTWKarhtuyLf+S6n+flQp0WSxi23XwoLaROMy2OqQ/NRNeGg?=
 =?us-ascii?Q?U9rppOmzZQUur0oIgWcz7wt4rZf5wIEI7HFf+fJjQSuurBd7rADXmbC5lUgS?=
 =?us-ascii?Q?gPFNgO0VOPn73/tBIlTDNeJ1FapcKY0ukR4Dow0W/+Y6UlB37j2HLZcxOWL+?=
 =?us-ascii?Q?9iczrL1BbuGnBVaqkzTg37ynZvBVskESqrSqGw7xrh6NTnlGZ0uPfJ1Vu+KB?=
 =?us-ascii?Q?PFiVmHD7JxLPxfTlAuQU6x7pyukkoQ7SzfW39X48Z0k8/ZPE4YXNwgAt9IV7?=
 =?us-ascii?Q?Ry4o30Kv3iFWFiKDfdyfjGtfUKOW9uvCzszl+YujY/ef7Cl2DoYTtpNYAZyS?=
 =?us-ascii?Q?mYwo6iF0BF1UNDEO8ovDDaFjPIxeuhiDHeAGeyoB+RS1EbPICaxktGkGcyNT?=
 =?us-ascii?Q?9B4jYLVL1SyXQ61cZcCg4qJi34FRl9zzXHVzJSMAyST0CJgtx8aJghlswD1x?=
 =?us-ascii?Q?pOVPacSM7Gm0idkLohSQicJF5mNsMQe0dG3K2WvlonOmNK21tVwZXrtqaWNL?=
 =?us-ascii?Q?JtvpsRmM4v+so0XYY/1O1DO6u5uMsunwNyzrPrGJT8G5nRDcy62tUHlJNel8?=
 =?us-ascii?Q?MGDmnZqZPCygdzwTfdHWv4q7B0ngT6rqcPTTX+qnMZsqr+VC0QebgXl6a60E?=
 =?us-ascii?Q?nAEL00CQgcezsrbNvkCq+PQjWQIT6JyLR8k+cjydJhxzDrW0EI6N2ui21mlI?=
 =?us-ascii?Q?k067N2a9STKP9EJ54vrxMcHoKsogONvXr5HNVtGBikP7oQnIpdKwqKf06JRE?=
 =?us-ascii?Q?X2k5ZL1THcazSvVTVjVUBbARDab8CXH8nYr/dsShiAVJVk9r8A/4A1r9KruC?=
 =?us-ascii?Q?MDkIHflHx2JirlA2zErVr6EZcyYKPHpJ6lCHm4TdODK3qjuaruGKfaiE9gMo?=
 =?us-ascii?Q?M9FSQff1vVuEGAO8gWjPvLGnV55Hn7tcwhjj4XfHP0c94FqG2zp4cT0WyPUV?=
 =?us-ascii?Q?GzbYoVETVQPThlg+47dkM4+8pSr6+4cXzBMjDzLB/v30HmvyGlPYf0gmVM2t?=
 =?us-ascii?Q?6TpinURQKJXuWpilhY6XdBhHLACBwKZC2xp2PkY2sVE0UiIBR+aYY8KO74i4?=
 =?us-ascii?Q?EUDSqB6DsX53cYgEndDmRMq5GTXJ0fH4a8OzYUi9mZSV+dxJ6BpLdxJIc2Z0?=
 =?us-ascii?Q?mCCLBS/Ul59JATbomd/fuVWc4yBzh0vNVc0AFMiv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e9afd1f-815c-4f30-6fc5-08dc32b37e6e
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 08:02:48.3085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3T/QKwYwowmg2KbTe25oNCdE/H8o1hOpz53P06VaUf1s7aqLYnQX8L5cHPRCzdUEmbNz9AF+dCgOiZLgEXL2pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9770

Add USB nodes on i.MX8ULP platform which has 2 USB controllers.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v2:
 - no changes
Changes in v3:
 - no changes
Changes in v4:
 - no changes
Changes in v5:
 - no changes
Changes in v6:
 - drop usbphy aliases
---
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 62 ++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index c4a0082f30d3..7da9461a5745 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -472,6 +472,68 @@ usdhc2: mmc@298f0000 {
 				status = "disabled";
 			};
 
+			usbotg1: usb@29900000 {
+				compatible = "fsl,imx8ulp-usb", "fsl,imx7ulp-usb", "fsl,imx6ul-usb";
+				reg = <0x29900000 0x200>;
+				interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&pcc4 IMX8ULP_CLK_USB0>;
+				power-domains = <&scmi_devpd IMX8ULP_PD_USB0>;
+				phys = <&usbphy1>;
+				fsl,usbmisc = <&usbmisc1 0>;
+				ahb-burst-config = <0x0>;
+				tx-burst-size-dword = <0x8>;
+				rx-burst-size-dword = <0x8>;
+				status = "disabled";
+			};
+
+			usbmisc1: usbmisc@29900200 {
+				compatible = "fsl,imx8ulp-usbmisc", "fsl,imx7d-usbmisc",
+						"fsl,imx6q-usbmisc";
+				#index-cells = <1>;
+				reg = <0x29900200 0x200>;
+				status = "disabled";
+			};
+
+			usbphy1: usb-phy@29910000 {
+				compatible = "fsl,imx8ulp-usbphy", "fsl,imx7ulp-usbphy";
+				reg = <0x29910000 0x10000>;
+				interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&pcc4 IMX8ULP_CLK_USB0_PHY>;
+				#phy-cells = <0>;
+				status = "disabled";
+			};
+
+			usbotg2: usb@29920000 {
+				compatible = "fsl,imx8ulp-usb", "fsl,imx7ulp-usb", "fsl,imx6ul-usb";
+				reg = <0x29920000 0x200>;
+				interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&pcc4 IMX8ULP_CLK_USB1>;
+				power-domains = <&scmi_devpd IMX8ULP_PD_USDHC2_USB1>;
+				phys = <&usbphy2>;
+				fsl,usbmisc = <&usbmisc2 0>;
+				ahb-burst-config = <0x0>;
+				tx-burst-size-dword = <0x8>;
+				rx-burst-size-dword = <0x8>;
+				status = "disabled";
+			};
+
+			usbmisc2: usbmisc@29920200 {
+				compatible = "fsl,imx8ulp-usbmisc", "fsl,imx7d-usbmisc",
+						"fsl,imx6q-usbmisc";
+				#index-cells = <1>;
+				reg = <0x29920200 0x200>;
+				status = "disabled";
+			};
+
+			usbphy2: usb-phy@29930000 {
+				compatible = "fsl,imx8ulp-usbphy", "fsl,imx7ulp-usbphy";
+				reg = <0x29930000 0x10000>;
+				interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&pcc4 IMX8ULP_CLK_USB1_PHY>;
+				#phy-cells = <0>;
+				status = "disabled";
+			};
+
 			fec: ethernet@29950000 {
 				compatible = "fsl,imx8ulp-fec", "fsl,imx6ul-fec", "fsl,imx6q-fec";
 				reg = <0x29950000 0x10000>;
-- 
2.34.1


