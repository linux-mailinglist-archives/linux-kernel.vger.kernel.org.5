Return-Path: <linux-kernel+bounces-74285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F9485D211
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A08501F2757A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF0B3D566;
	Wed, 21 Feb 2024 08:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WzzKs0e9"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2052.outbound.protection.outlook.com [40.107.105.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B093D3B1;
	Wed, 21 Feb 2024 08:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708502602; cv=fail; b=GSFV1kDGxSsvCU9xe4OyAWmk4i/oH6IXR07xmmLGwxvsd+Pittmser9y33K02SqxlRNr8d9z9aJqo4jH0f7q2KbIR0zTp6S2wggYSNkW0kkgO8HmEHeVKPrc3iv74cpHS6dX9/rbJRs2fgjkDCvQptIKCl9saBp1CHioFa6Ie5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708502602; c=relaxed/simple;
	bh=Qx86eHCjg1cF/7o2AvTnfgbgk+3N+N5s4LS0sX8x8Xw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iKh5t7kimxuBZBDDMuJ6azpo5F+Szayq9lGK5TSI5s5cLG1Vj1m9k7VTQ/ei622NnDNZQp5840aUaSR6DHeVmaCdIPfMZIe/yZWcxzngWm4v837jEdvUrymPUx7/7LOAABYiE3kaPk3X2kRPo/2b0EJRaP1BNk+IwZdzak3oj64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=WzzKs0e9; arc=fail smtp.client-ip=40.107.105.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AbWIC946xP7SY1MSeU++/MK31EYsQkKS5HXFz5TqiZbpIyToL2JfPd5drDZ+jMKkFlTeHVg92ObYoBDZbIyydQ4WdXuwmV/8z62Lbr+Pf1hptPaVdoXsa3gb35m0HDF19o5c4ssX1t0273+CDzLb/Ye61iHWQgDe/FrFzuNEsas/2pcsW80TPNZCBf9+oKgDBfX7UEo2OgKNCgEjqB0bHMPIMwAsrZ+thbVxAkZ+S1LXsKv8DocjrFrCI9RIPtUDXiDoXhDzEYksh8sL8dxcFKn1N31Jvae2IlR/a1jCe5ru8dzWMcueCOAGXp739weoojoLSapL/mnnPiXY2tc5eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wY9dqhfR6wgdb/jnJT0Pv4zgG36U8S0PrQH+Y8xtoAU=;
 b=jW31FQeiGs2lie7KCPxL7J+WNLtYzXFKH/kX3qwxujGm7eVZr+Ke1sQhYu3iQYbfBhFh+kG3+ZHntTxS0km8INTXH/4rsx5AojHDW47XiYm6H3KajMTJDOGY0dNTJtQ3i+fDbNggNCREEBf2M6MOTvXGSo9dytn9XgjWX77UQ1LPmOfbnS3CMQcy+DR+tuxe2Ho+KuGbldR2T3Vlk+ut30BtwsXfswPsH6f0gcFppbzENncKPQJL8DlKVxbdEoVacsWOsKRY/kXrdS0+DyVM0NcYDTjIpZTug1CandTAZMPh2WKi5VXIM6GuIzDa2QW8Lzn1qtd6wnGuIo7jtOWx5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wY9dqhfR6wgdb/jnJT0Pv4zgG36U8S0PrQH+Y8xtoAU=;
 b=WzzKs0e9PLy+XrKS2hFQgnvnz1ysRIfr9A9rlgEnBGONKtyzkSH0EXUZFa4yOSoVt8Nb0NknHb2d6t4NhputEv8Eq8sSLypImNEQK867HCNpEKNr633t/esrr0MMSp6QLVtZJ6RdGVJtBz8n3nDMgKjCxDIl70U0OrrqPIH7xM0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AM7PR04MB6997.eurprd04.prod.outlook.com (2603:10a6:20b:10d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.37; Wed, 21 Feb
 2024 08:03:17 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7292.029; Wed, 21 Feb 2024
 08:03:17 +0000
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
Subject: [RESEND v6 8/9] arm64: dts: imx93-11x11-evk: enable usb and typec nodes
Date: Wed, 21 Feb 2024 16:02:37 +0800
Message-Id: <20240221080238.1615536-8-xu.yang_2@nxp.com>
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
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AM7PR04MB6997:EE_
X-MS-Office365-Filtering-Correlation-Id: 089ed0d9-9030-4a81-21c9-08dc32b38fd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jrHolMGQNTmjFECPUYc9WZk0hxwceT4CvxeCvq+fSVhCaJlrbtatO+uhZDkPpIFdZtbSjYycdYEiAiOLOIMjhL0sNbAH1SB4wKGEW3NWx6Qag9wRa6B0TgxI1XV9TCJ1RiKTuolrdyGEFplKjloLg4XBgl6220GTprvEVnasZAZz4rU/tMuT//7/AUEwE9VayOU3O8fYlPdZgTtLdED+e2b8bx8S+QYDEa77rceVH6QAjf6QDljpHWMwfCtWJ3neubCkt7ud4/ZskCHLjqqIHTeP1XuBpuf4nKFcHXME3VDSPWMNC4F+ZqaWXdHUZB/JmaJoeskXDmDf1CAX1PuKQeQIBE6gwYyWVuzHKxTUVMSrQFiqLBpXNaVhZ4suCXzaLzzF7oRwnVoHm3lP+teKa3PxU2zj+mp+CuDoIkY6Sra9t5Ei0jMul0YUr5KnxQBJAJbSieBYlQWsaSpp6QhgJ/hsQk4zSOrait27zE5L1mD4TzasCFgLVuA2rt0GXj6jyMTJyoLXSZ9cB6qG7kq1aCr3qfXOGvIm6aaTIv2Vsb+JIIQtZBqSq/YklRjbGGXNzdK2Xvy6ytkt+qyB3TJmlOvfPUt48vF5VMQB69LztQk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H/AfYXwsYHAEsv6sMhqhUwaT0xpA2zX2gGtBQ4h2op6WiAvf7Tbx+YMMZQPR?=
 =?us-ascii?Q?6eofpXPCTYbfgL4d0CLsw76RAYlfGMUxxAt3oknSmWyRQDoP+Z63AwF3pNbG?=
 =?us-ascii?Q?LRkPDyvdvGlSh2imbm1NLIWrTlvUPbUa42qC7O2YWryShISWQE2NvajBvdwD?=
 =?us-ascii?Q?i7eUivGflLbz6Mk59Ca1wIMjKGSJp0mhs8HmvEwtTXJkeg83szi9dW1kdDGj?=
 =?us-ascii?Q?uakcpWKhe7InIrjdL8FvbqROXdtune76qGw5qlVgoYHSRXyceptZayQ3WsMR?=
 =?us-ascii?Q?N1tIk23P8uVp+qdZX0CgogWKAAQLpUhApbf4TQuldJagWvXh50P6B4Qcxlsj?=
 =?us-ascii?Q?HpjNcX729vLkhy/0/dyb/ams5B62kc+dANdpyZIokz5N93VEqPHlib1er6oI?=
 =?us-ascii?Q?BtbKh8sfzxibDB0vi4zrRhGJftLy4ZKF8yzDydS3TfchER//VMNr+H663f4W?=
 =?us-ascii?Q?CJbckTB0XZLNmrh0Hq/nw6SCwPUPyV8tbP/3kb1aRTI2zpKlyo/oT1FqLySB?=
 =?us-ascii?Q?M8Al/stCNHgHd8I6P4jCtsMEVtwEfmEuOEYlY6TpB6KxrslKagjhT9URoBqx?=
 =?us-ascii?Q?HMt42J8fR0wngIjK2bRaSivvVM51ptVlpEinAKD7BXm0RD+JbFLm/0A3ytHI?=
 =?us-ascii?Q?h8qvNPunm/K3lIo6LqqDgQvKH3gQK/VJGsAdRWNIZfLR9WsRcg5bY3eQkVrZ?=
 =?us-ascii?Q?8KPd6hL87u0rfOL2fOBZH3P2X1fU+snSRIFOj1pnyL3YMX1jv05ba+Z3Bzoe?=
 =?us-ascii?Q?LP62z+Zg5UCYWAFRkpjaO74doZ3A5hrIDsSwNsuWerRxnXiAc6x1aopYHfwg?=
 =?us-ascii?Q?ZCPI29IkGnXZ9NwNCr4kO/LQTlAR/dkkmDDXgnb0HXdWvyII4/B++zn/ZfNI?=
 =?us-ascii?Q?/4SsrfhTXJ71ghr9EXLomEwsf7wj9LcHSCFzJMTwGlw90VaDAMIUgDYKRP4p?=
 =?us-ascii?Q?pX35IB0y+p3wvBNNM0a5ptN4nUwWmlOtp9DHZ9Fwll1ZKN+WfD55+jDTerT3?=
 =?us-ascii?Q?NYUmgISSwynu8VpLJsv50r34iQLYgn0ODLvsvSXIQKc6GyodFAFmsyh1pwtP?=
 =?us-ascii?Q?0OUFpk3FCbE9Qxzu3ESjcUNoGA+lqHeU2O8JeLgnDfGkiKWpSFOvSkV4DFo+?=
 =?us-ascii?Q?ARGnZy7iQ+fpwDJ6JpHdC8ZobGf4RUE1B3hKCC04a+KhhPuXNm8b+AjzfLJa?=
 =?us-ascii?Q?1Sz12nn1KjCG7zC9JpfJTdVaHhkfBHTNqNSvwaMyDN+E2yI06g0meYXoa3RB?=
 =?us-ascii?Q?gRIbbhK/DKbG+JaU+xHwdEx2kIifc6MFK00OwkHlhPVUIoFqpChyOWPBcfdE?=
 =?us-ascii?Q?2t7gnTYqd19lBbfr6Fubgk9fvPhZ5heR1AqII7cR2zXVItz58c8T3rVtzdxM?=
 =?us-ascii?Q?ap2n2avIhAk8WaVnel50Ph+MFNYyKxQtpoIfIEUnHcOTOWzVAPFPMAS3zMHv?=
 =?us-ascii?Q?ebqQfUarhjFAHB96Q4hX16omFhns8Rc6GnijmPGNbIdS6VJ6R1317jAYNEn/?=
 =?us-ascii?Q?zWjqpilIjZai2O37erQfJqMvFFJz2HOq7q7xqB00qChfmuje4BLpwc12e2x0?=
 =?us-ascii?Q?4wtHkTDsw+MAefhGPlHe2iAZ3UtsBRugtGc7JYEy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 089ed0d9-9030-4a81-21c9-08dc32b38fd6
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 08:03:17.4885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c7raNiXKQoiV6yefeSJ9FVEhhwgs3Devs6SMMLRf4xDsrmcJ4ulMfYWAvQezgNJPR0EmnXHeIrmdXzU4J/tPSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6997

There are 2 Type-C ports and 2 USB controllers on i.MX93. Enable them.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v2:
 - remove status property in ptn5110 nodes
 - fix dt-schema warnings
Changes in v3:
 - no changes
Changes in v4:
 - no changes
Changes in v5:
 - no changes
Changes in v6:
 - no changes
---
 .../boot/dts/freescale/imx93-11x11-evk.dts    | 118 ++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index 9921ea13ab48..ec4cb50445fc 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -5,6 +5,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/usb/pd.h>
 #include "imx93.dtsi"
 
 / {
@@ -104,6 +105,80 @@ &mu2 {
 	status = "okay";
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
+	ptn5110: tcpc@50 {
+		compatible = "nxp,ptn5110";
+		reg = <0x50>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
+
+		typec1_con: connector {
+			compatible = "usb-c-connector";
+			label = "USB-C";
+			power-role = "dual";
+			data-role = "dual";
+			try-power-role = "sink";
+			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
+				     PDO_VAR(5000, 20000, 3000)>;
+			op-sink-microwatt = <15000000>;
+			self-powered;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					typec1_dr_sw: endpoint {
+						remote-endpoint = <&usb1_drd_sw>;
+					};
+				};
+			};
+		};
+	};
+
+	ptn5110_2: tcpc@51 {
+		compatible = "nxp,ptn5110";
+		reg = <0x51>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
+
+		typec2_con: connector {
+			compatible = "usb-c-connector";
+			label = "USB-C";
+			power-role = "dual";
+			data-role = "dual";
+			try-power-role = "sink";
+			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+			sink-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)
+				     PDO_VAR(5000, 20000, 3000)>;
+			op-sink-microwatt = <15000000>;
+			self-powered;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					typec2_dr_sw: endpoint {
+						remote-endpoint = <&usb2_drd_sw>;
+					};
+				};
+			};
+		};
+	};
+};
+
 &eqos {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_eqos>;
@@ -156,6 +231,42 @@ &lpuart5 {
 	status = "okay";
 };
 
+&usbotg1 {
+	dr_mode = "otg";
+	hnp-disable;
+	srp-disable;
+	adp-disable;
+	usb-role-switch;
+	disable-over-current;
+	samsung,picophy-pre-emp-curr-control = <3>;
+	samsung,picophy-dc-vol-level-adjust = <7>;
+	status = "okay";
+
+	port {
+		usb1_drd_sw: endpoint {
+			remote-endpoint = <&typec1_dr_sw>;
+		};
+	};
+};
+
+&usbotg2 {
+	dr_mode = "otg";
+	hnp-disable;
+	srp-disable;
+	adp-disable;
+	usb-role-switch;
+	disable-over-current;
+	samsung,picophy-pre-emp-curr-control = <3>;
+	samsung,picophy-dc-vol-level-adjust = <7>;
+	status = "okay";
+
+	port {
+		usb2_drd_sw: endpoint {
+			remote-endpoint = <&typec2_dr_sw>;
+		};
+	};
+};
+
 &usdhc1 {
 	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc1>;
@@ -222,6 +333,13 @@ MX93_PAD_ENET2_TX_CTL__ENET1_RGMII_TX_CTL	0x57e
 		>;
 	};
 
+	pinctrl_lpi2c3: lpi2c3grp {
+		fsl,pins = <
+			MX93_PAD_GPIO_IO28__LPI2C3_SDA			0x40000b9e
+			MX93_PAD_GPIO_IO29__LPI2C3_SCL			0x40000b9e
+		>;
+	};
+
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			MX93_PAD_UART1_RXD__LPUART1_RX			0x31e
-- 
2.34.1


