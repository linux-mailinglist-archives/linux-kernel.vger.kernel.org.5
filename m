Return-Path: <linux-kernel+bounces-74173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DB985D0B6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 573EC28356E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69B03C493;
	Wed, 21 Feb 2024 06:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="M7LJhhxS"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2042.outbound.protection.outlook.com [40.107.20.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17753C46C;
	Wed, 21 Feb 2024 06:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708498333; cv=fail; b=aTgcTrOdPtVS8cEG71kHpA3fZQD5GqwDSUHhM0vfhk0BcdU6PpRI08YeJ7eyF8WrtXxoKmfPbGP54Fj5b12iWTiwqpHGotKpHNQR8/VXICw1CEs39dp9jvkPJl9kzSaoNOaEev2VDJLlq+wRgn6qiINX/IjKlbsfPgis2nVMUZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708498333; c=relaxed/simple;
	bh=Qx86eHCjg1cF/7o2AvTnfgbgk+3N+N5s4LS0sX8x8Xw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XS9Hcn5v6ILmqzdQ1Iq1FtLyiLYnoSUDwfVspUI81t19csoCJJpKBJ0vJnNAiHVP+njJLRwUyBCK9GYJbAetQhcXkZcKzoyvCeLFbSS/Qy5sJQnLgO++EmmbCl1eh19uFAGU16O2ONjAdQc8tpufoQMC/usmNVZsfWNSX5PISCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=M7LJhhxS; arc=fail smtp.client-ip=40.107.20.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EymkLCK4rDvLfHKlTyDzfGGqZipiQybShwa9PZXM8Z9Qf+6eme6iUmQmjb8HHW313Wj2Un8eWrOC3dSZrutxf2PX+ExXJ4ObscEWwjRUlSFhYj+04bDDAyL/ogqKKKfu+n3d9o5lgW1illDf8m/wa8n3/UoeM3e6rEAMvyZWtNnxdYB0C/nCYvx4wGOSapvZSfkQuU5aj/4Two9tzXwsfNhdIPl+uKZBvAAjbTVZz5L5o6V4d5haFyhluYFcpLkFw1yBq4OrdXM7od2sApf7RIai9Qq7Y1x3EZx8Qjda8EW6VZ9+s3TcjNRGQldcOSa06igP/y41nDuJHU6JoJg+jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wY9dqhfR6wgdb/jnJT0Pv4zgG36U8S0PrQH+Y8xtoAU=;
 b=UpIGLz+5dfgB3iXhpOY4DmFtJI1mxVN2UC8ReoBhNmmhGFQvOsFVQrtjtA8nHdOziyLgu8mWLYsxMmz0by2UXtvHcPcLYdueL9dJaludBHKz8MHx9V41TeUKd732BrZpGNN7ODj1IBOm/ZP3JYyhlS/ZnK6vY8SVpmbUVcVrBb94WRQ0Mo/Zz9NFO6vEyp2pWppA2+HfCV2LsyfkF6HACBl79S5glw59NSt7Md1saV12oDxbeMfXfD1ih6sFfaVySGm6q6xUSYgjqJyMa/yuYuqfdw7x7p5Qr0d13OxDHpEMMO3qdA/OItI56ra17tGnuAwXciF6xGrqx51UXGu6Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wY9dqhfR6wgdb/jnJT0Pv4zgG36U8S0PrQH+Y8xtoAU=;
 b=M7LJhhxSEP7JFCaBlFZOTRto8o+INBiQ1C8Ms3rX9OqLTCR72JyQZ5WlFSvuBVsqw1Im+tA2RmaLGs+oviDTBOej1PvP2c9mj4L7SHpUyGmN7l+GcX+e7VhEE+GlyVinue3ORYoxm3u6C+qCGIyaumAFqeGNV1DlH4p6KiEQPlY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by PAXPR04MB8476.eurprd04.prod.outlook.com (2603:10a6:102:1df::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Wed, 21 Feb
 2024 06:52:09 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7292.029; Wed, 21 Feb 2024
 06:52:09 +0000
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
Subject: [PATCH v6 8/9] arm64: dts: imx93-11x11-evk: enable usb and typec nodes
Date: Wed, 21 Feb 2024 22:58:45 +0800
Message-Id: <20240221145846.1611627-8-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240221145846.1611627-1-xu.yang_2@nxp.com>
References: <20240221145846.1611627-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::6)
 To DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|PAXPR04MB8476:EE_
X-MS-Office365-Filtering-Correlation-Id: fcff1eff-b26b-419e-2e4e-08dc32a99fcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HNotIHtAM2lIz0a6TdvimBoVDOallLSy6TTMF+6gM8ddFjsMVNOFzbRWWiXWK53D6+ljrzrXFcXFdNaJRVqqZAciLCrEnbMdxjyXtVgJqUBzXg8+OQN4UKsAPPAlWOETNCxHDyMmUuXSY+UdzUTkRN19rdCb3MD+Hp6Qn1Z6OaJzzdr/bKNdTR90G1+b9lzBZ6BjXMrs5PYJfPAcu3dgjNwj3TfvbzLjJEeFW4MYmF5PwoyxO3ols6gfGGR76yvig8Qmzn6ysI8mvG1Pof9S6q/FkIsj0laCBV0mVuZ/2VlB8Ulb6Q/CKMCly6PJ231uSS2LCRehoNg5Nou8vAZbIepe5puyXsacC8HYwoPTTz8FtcXavfa1Aqal8xH38GIvU+b7Q4aKv7MkDmc2lsXk8Toi6gy0dT6gKizGaLP6nimYAm7zklA+tRDvAgBHwcisWCiWVuExoGWyFnb6rVd3AcqEPWqattVhneUbj2nrl524yHPPvSQZVdYGjYOEFkwaUIekF34ClDHh9KzCYRXsQXa8m+HQfBbYV/mBvJx6NAKfQxZjimvD8OL5++FtRnOTZcHBPxm3RSQCAUDvx3b7EAoBbs5edLXA54eI8/qqLOA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9IgAzmPTJfsNdbOf9fUiFffzdhcVkx5Ll9BLrhqE3Eotx63DTupm7mSwc0ZD?=
 =?us-ascii?Q?kpwuLy8TNRZqEkD0IZxXG6HrefcoEyMl4AUj3N01OpmhTCmLDczY1Kt83aBB?=
 =?us-ascii?Q?J7ycpRRaCxMuX+jrT4YT4jy0Zkr1EsFZXT5kEk3DyXOnBmTvW4FXouxrHRua?=
 =?us-ascii?Q?cs8Ao2X3w3Xf1OXweJb2CDoNwPkOQaNV31TkhtkShAHzjEXkxqePn8Tp2a5P?=
 =?us-ascii?Q?EmQpTOgs2mEWKkYMtUJ42fLZ7ZCcm58jL9cSvM9dcgCotpu8ljp1ve0ZjQBt?=
 =?us-ascii?Q?O6KedVzPgQggPWQBbMYJqsiNpq+f+ZOYQlPzUQwZO5H7Iwpatxu1WYkA2HP+?=
 =?us-ascii?Q?oUn524fDAxD7bJawcNaZ1aOSg1ZXxQJ51XJS/+bTyvJIJDxqm0aWkbutafJ3?=
 =?us-ascii?Q?RkhVuL0JsotWPhc0fsQh5ULLnMo8Uxsap5nBu5TIO1GPJkGuex32bQi82iiB?=
 =?us-ascii?Q?Z5nfeldZ9/8rjKRUzs40ak8i/heq3ux3CPyOPd/acVinOICLxF5i9ms01ZCI?=
 =?us-ascii?Q?zgu9LuAzq6Y87dLR6b/NTMXhV7xVzOnsHj2VCJGRZsYpCxaIH3vvJiLonFsm?=
 =?us-ascii?Q?yqhmHleqUwWIIQK7QVxbrz9irNZY1CZ5MOyl/gDqFOtgOljKXHboJziOJ0E5?=
 =?us-ascii?Q?h9wJFy0CuJ0eVPlW47r9qMRMl+zCESLHJOIt51RO4+DHobvH39Sv0RFO7QaT?=
 =?us-ascii?Q?qfsLwPysjU9YsFmpTNxBJ3dTOkCDKEPfvTWe7zmi2QwgkAhi+ZoUWYz81F+J?=
 =?us-ascii?Q?sPd8kmXLvZ8gMGKVeEWHj1atBxjN7urlRPkmuef4dEDCQZdtBqc/gFA9Kq9j?=
 =?us-ascii?Q?4ILXBP9OK2PsHTmGS5v/sAhfEfKyXDcua6KjjU3mr1XTrfq6mIkgqva5wsDL?=
 =?us-ascii?Q?U2paoblIRCTICcSHUC1A0QIKNgOwrltaFraNj7zXVe4Lx4JoG30z7ysR6qWR?=
 =?us-ascii?Q?k2COZ2SgM7odmfMMrvsKAmWe1aoX4TA2tPsTLQFEZyIiavmdCyzoFh0z0nEd?=
 =?us-ascii?Q?JrnX6WC84umj8PPBtOGMtSAVWTl8XO0MOveqSlkTz6V+B1uIC0CKkEXHsZub?=
 =?us-ascii?Q?uXM3AKWw3OYTZL2pgWXqK/TF/ODTMSCgmnj/oyEJmvYI5MsFrchsDLI89Thy?=
 =?us-ascii?Q?F4hdzJ96Exfbc/zONBRKVOVXeGEMc9AqCRsQsnSoKJxGtNbx5tVd/TPEzlXc?=
 =?us-ascii?Q?xOtJKQK2jbGE1dU+gojhy5YB3govEl1LrVI1oJvmZvk9Acq8shcgsM1sMDXQ?=
 =?us-ascii?Q?dmxyoFZB4P2RxJgnF9GFxy4ilhu4+rflNFkiKx60jo66BtnqJs4tSPUaqi+l?=
 =?us-ascii?Q?cZCPU6TrZNPzOhySz8hhfvjpLogBhFJeE6a/D6rSxXC9Rl43vT3c5DresWRX?=
 =?us-ascii?Q?v6uJrwgvhMCJYVCJIvISKGTvkoZPCHSUHHs83uSURXq9X1YYAaVuFYZL3KVR?=
 =?us-ascii?Q?vI6WriC+tW+zpGd7u9iTRB1CLlrM7Qa6b+tDyRZtBrP1whM/GanyXeQDfqEZ?=
 =?us-ascii?Q?BPFR26vZj1Hz64dkCpWB0mkJOL/mOboVsqjr5xjt9ZTceHOGdaYg2AOmjUI4?=
 =?us-ascii?Q?sDsuKeRYXxEuPFipz7P2AJjwoqEwcYOygviW1W09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcff1eff-b26b-419e-2e4e-08dc32a99fcf
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 06:52:09.3375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RvMYd3beogvGFXwyVI8rALSgSf+zXSOoUiNnLxsmTLeEyjrTPu3XSuhGdoF07IWjUr6EHtFAZvhGf1+gehQ7sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8476

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


