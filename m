Return-Path: <linux-kernel+bounces-100007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9444887909A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4983028604F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F3B7C088;
	Tue, 12 Mar 2024 09:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kjRZIuVI"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2051.outbound.protection.outlook.com [40.107.7.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D437829C;
	Tue, 12 Mar 2024 09:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710235065; cv=fail; b=MVYbs0bCbPrMgkXHJYR2/DzaHT08CXkzD7febKMfYwnOqAIHAutgDRcCCRNymiH6aloQSl3pdqXaqv7IzYLAqYrD/GuE9ALvsAm4BabidCGxfqQzosZWqc6ivyhIXK2Zzi/uKjUFfkMFaTpQYfwzRVay/DTQbas0XW8jn2G8YM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710235065; c=relaxed/simple;
	bh=7RF82zvR1IR2iWHB/oaA6/EwU4te+vtObwzoeFF+ZdU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HlOflkSUQmUNDAQlbJSoPe4VxMNQwGi4rxu1B9dLGRXEU/BC6bwDG84b2Fl4ZE9cAMQpE2dN0P1x8T8s/8VFnlsPAX9yLsuPCufo/X3IIfSS3/1Cn42u2elh75H7FA+D1z+fWUneYPPJjMVEWILXD1SJK2C8XcLCy/6A6+ZmooI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=kjRZIuVI; arc=fail smtp.client-ip=40.107.7.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YrZ8vqpObPf3T/IVnFETGoza8X0wQazgWc0oLSts3GcIDTrcEJmBRl/lpUETSjkAP139ui0MNGoq02pJVnKHSbEuaIS42IGU5RmHSpd3Gyy+PC9iX50i58mhWgQred2HW3SNWzrIgWbIUMn0vOzCQ12rNq4I3PHzGYAM+ro9NLo5ipJuvum2gTZeYLhJ/jVAtMy9Pr8lt2OyQS5vEeD84PiBvRaiQVPpkDvKIaDDS+s76ndcVp75ag4+jzLqaxa7C2Cngjrqh7BBKsHA13GHN2OfuM1tTroe1fxP9rTO86w9+zrCQrvx4OH2vZJ51CRtUzsiqXDDcEbzeZhNerMZMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=icitpbtTVTwDtf5CBbXpw0brep0b92LylCCF/4gH8wc=;
 b=WAQX/+Lcz5vliVQw2LXDwK7flNxQLhHLeGOe7biX3gAx9CyoIV/GF2fDFh8ayvpw3+wTWFvldpEU5c1GQbdDEu5GpYLG0M4FtCWBJXLjuIwOBCvVnzmwPfGe55LDRPOPa8MQPZa05+pnHMTJ8ZjWOeI6BLvGR+R7KdPTTJT42aPIYydtIgxfXZHkrvXfaYL0jYAwLDIYnkKqaT3muvl81I1i7+1loLHxriHZMT7cZydfyjXHKnE6Z9i0DdfCJanSCF4wKca+MfIoJikUjmICBUvZnTOwlRJwYlQKr4tV+7Jc1EP0TLZfzQTi6M/XiMLjqq6542lMWBQ3b16mHylkhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icitpbtTVTwDtf5CBbXpw0brep0b92LylCCF/4gH8wc=;
 b=kjRZIuVIupp3rTNPTCfc1RT3Cz4ZUk6mQ7c4WCZAKgdFZbKmzUSgTa5OaQczD/ml2nnBaCyXOYjayswMEUbZqfbl/H4uKw2ZHW0fOfyT2h2YdJBvmFmOvoMvQrkkDkJcOGCeDUq+Ov8fgEDUSr+4DYF3uDgzzhRstodipGI4Tvo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DB9PR04MB9676.eurprd04.prod.outlook.com (2603:10a6:10:308::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 09:17:37 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 09:17:37 +0000
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
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 09/10] arm64: dts: imx93-11x11-evk: enable usb and typec nodes
Date: Tue, 12 Mar 2024 17:17:02 +0800
Message-Id: <20240312091703.1220649-9-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312091703.1220649-1-xu.yang_2@nxp.com>
References: <20240312091703.1220649-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:195::19) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|DB9PR04MB9676:EE_
X-MS-Office365-Filtering-Correlation-Id: b3118d1b-5734-4560-ba61-08dc42754228
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	E2oshqFR1KKxKJvkYs4W5WXLTb0ijG2xHERY5xBmpFlGlByjloED1fb+udeFi2CEuCqqyLl2ogTPWNVa0pk7CY+QsPAvu31B3iOIIcSaHvS7ZMCAQKKjrsBgPFgpHYeG9aWXwkKW2K0SuKBbNKuJq+/XUsKHtXohy28gPYRNRAdOsGtqHeA6X4LGEBjzh65yohe6uZHNKQZ59Nt7NPPlQoFgQoOKcg7kxcfF5XL96U6x+mJyV8PuT+tS/HhhW6accoPHDOoAqFm5AjFAf32O8HxGiqYC2QKR1FCuttGiVDgBRuw0aYZZ5qZ2ikkskdvSsxa0LKepDKanrL3GsbDMQwmLAIkdzzqDmBgdelkw15JD/TntoADNCPl9zD+bc10yuVe0UvDrb7KLfII/GjmFoXfY0w1p/fglK1UQN3GfwoYOiJA+QSDPdE9WPdDHP9pVJgX4n8XK+WczMJpcKS3qtsVfUXUznypHooZoQ3pKrHa3zM1D1eY1RJD515hC+2/VZHr5S6L0Dgfl2sO9oSMldzrnJQBfXEFFk6ztOvQTSzp0uT7OulZ2tMIClrwnvfFpGtJ43GocPutKVpFldDdAp2Mvl8mO7LycK3OPjKVJVjwNDtwfMm7VYVBEJ+968yAhyNvQ71XqazIbU2f9Bs0YHsoCGal9fhwESFhmCJ5DhE/0Uu7Ag5KD2pEM14JmpdIgG3vOKskNLhFfTsWYQ8KKQg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GuwlZ2dHwpRc+G/2V/Vstfk07NwO4m0snQAFPaoyYwvVU3rptBlma0poCvcp?=
 =?us-ascii?Q?0tgTEekcNV2mM9uYkPua2I/EZa01S83O2T1t7bGZOXRdbuW1FBVETHIRC/Ik?=
 =?us-ascii?Q?37aVeYGBhTYugiSDAQUawr924J6INy+yTOZzn6IOfztH4E01D9dEzws8fP30?=
 =?us-ascii?Q?UZvuKgg+lYm9Uykjbl4csdmdPWbIDnwWWI+7VvroCq5xqKDuf9IXKTltKs0l?=
 =?us-ascii?Q?1zklWsFiJrxlzzC9Aot2Djwl065oaSsOyENH0rfxCghmXWv1bxqxGvsr0Gky?=
 =?us-ascii?Q?s/v+8eHdn7Bj7nrgK2TZrj7nJB77m6Gr/JmDIi0eLwvS8/k6wDCIj8nC11+F?=
 =?us-ascii?Q?iE5ijlhvXfFSeZKT18qSn9IkuFkNhINdIBjlOwfOr6sChKV44BnGBkh4z06C?=
 =?us-ascii?Q?+QL8P04dbGvpWuD+/9CVRa9opJ9qgQMH3M6k8YRn0F2Kzlx9nD1nkvgFgeX5?=
 =?us-ascii?Q?gmH/oxCcUrY9EcPW8rQZOXKBvyXX1HrtJN6QNXfw0r65Dajn38RI6ZoF7yZx?=
 =?us-ascii?Q?vJgyokhlVH0IhmHWUk7VbtApyVBLc0Y8PybDNtreWCR1vYr4N9MdlygvnCz3?=
 =?us-ascii?Q?0V9fppuhHM/Qg8Rjgx2FAhc2rh2cSmJzqGt8wLImxYYkkaqOPKArNhLSxy+j?=
 =?us-ascii?Q?WREIdHsTmDWXeJhyc5j6zPfeUMGPVgKyhcW34hSiP01Vkgyarc86xMTqDGLV?=
 =?us-ascii?Q?+456Rox2HHkoY3MSd+6qUCqI1Dgg+IAq7avcxT81QBJNcqP6F8AzrTQy+7Ry?=
 =?us-ascii?Q?Syh7SiTgTOgeOIBzTwH0ILxsDZXD9ma/Ep95P2cBqtzRxSJGMJDguqUDbbGF?=
 =?us-ascii?Q?ZRMBkc3/xuf3ylitUqfegNO2yq4TWt0rmZwcSF/PFgDMGXlAXTNrA19vjEAs?=
 =?us-ascii?Q?5/vax08ePVpoQtAU05JNPiUMyiWL1VsIlY2o1KkI2Wpe45WZ2dF1awe0nT7c?=
 =?us-ascii?Q?IrsFbtu6Eqi8qVmc7aI+c0s4Og7yXOS7DnEMzu224Z+fcdkIocHwf7PTMMNu?=
 =?us-ascii?Q?5r/ELM8SQld3wMVdJPHk3oil8iefbhoU41kqnDI1yRPUyYkjd90c5NUrZMcD?=
 =?us-ascii?Q?53RZjWWyoFUIL+bilnA1w+5krcl3XoL2tev/gDAP58qQFqGlsvx3AUiGBurv?=
 =?us-ascii?Q?sdoT5gxnoM2Zf5WxK1w7lgeRI49O+RXM+lW7VuFZJFzEbVkcFc1+vQMxyNEO?=
 =?us-ascii?Q?RAMgDGwQ6tyXVLlVyylSc/yQn84of/jiy4zvqSE0QbWZKQaqVJVwRGWcGTKO?=
 =?us-ascii?Q?zVry2NaPK63BrK4fx/WeTEZts2pUBFSqfn1jOD6RpOxP0zGvbtUTYsdY1KBG?=
 =?us-ascii?Q?FxKD0C6MsE2ixsHAECiG+PrL3wpAcehsbvPQAACq/4f4eqFPScJxYSGZQNDh?=
 =?us-ascii?Q?q1xB1oelnBXYBn0QOxoeqs3tozkMu0/C1a4NgU24drlmi3LJyvSL2k0hL420?=
 =?us-ascii?Q?vg/LIxP/xCz4XcE5FaRcPhpn8V4x5qF++NZA/3STJ3EPI9w3oSzOxo3Ej9Ia?=
 =?us-ascii?Q?cnfgsKbhOc/HWLMNJLBylnj3TnQ+ZE5V8v26gMV+cxlPXMybB7I3qxAX+uys?=
 =?us-ascii?Q?rWDrRouAT24JWMR1JrBxkSN/xo0dzGA2AgImdDDG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3118d1b-5734-4560-ba61-08dc42754228
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 09:17:37.0772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iGPFvUZ8aAGJPW+7s0Rm4yTJq5g9oKdW7ehAZb9s6aWKZs9fWIucXO9jwKr7gEgI+55YbMqpcelc+sD34e2CMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9676

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
Changes in v7:
 - no changes
Changes in v8:
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


