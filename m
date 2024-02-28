Return-Path: <linux-kernel+bounces-84919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7281086ADB6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE3BA1F2BA2B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F77114AD08;
	Wed, 28 Feb 2024 11:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="E1CnPt1y"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2072.outbound.protection.outlook.com [40.107.14.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9560370CC3;
	Wed, 28 Feb 2024 11:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119853; cv=fail; b=crJlKtUwdMdF17QlulPr5o/LxDvGORk3cm2r01mUSBeVzOAhT8LRhbjt0jteoXFxFfa96lCpF7olYfFunsrpChXIm76Knd1ak4TxAm6Wm0WNalgRax92ghl74FJWTReTB8LGr18yqtPgcMovplwLV6fsbb01PLXOLeZJqMvxc+o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119853; c=relaxed/simple;
	bh=FY3gArXzmHZzXbT8e54tUTAygK4gjeLi7pLDOa5ItLI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I386n8/aSqjtnUkep/5XUp87p/HddN8i/wmBwWCcprOKHxrJdw+0VPjNJYljqW36XBZV/B5NNmtpYIpCqv2BoxLeRqfsDG1X1VdQ5e7DRJzXn+ROFzfz5s/balkeOCSGQ/WtzkQH2F5f8xo3GhazfK5vhYo9YgYcQVX+YL3t7U8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=E1CnPt1y; arc=fail smtp.client-ip=40.107.14.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/h6LS2JH4Vh0BH6JQPBHaklO3aj6g8YZJeErzfQiW5lcOOVGVooNh9ZQnEQmfc3I5T3hb3kq+OtUKeIaFFxKDZiSzZKSNccU0BDBuvWT03P+ZdphKqJcY2C09dUIW/mVOmyzyBH4QMau2FsW34j/FV00JQR7aIkC6MkceVLL+f4223qBSJUoBXP8QV10vBvE3ofmmaR4R3MPt6YyXzxG4jATLl4qGsyYsKDKE1vIXNmTFnQM4gthLvzl142qmsV/chZw2E6hb7xh684FnziNMbs3BCTF44pQj2quXzhAYlzEr3rZBrTAGe41fK2qCHBW9zQ4JYJwyQjjNLIzyjHgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fpbEWmXoKTECCjCNvb+E/fRwkolLemItLbhoREClVz4=;
 b=XUsVd/+Ujp1EeRWoQuiMH6KA+krNNtW299ychzM9Li4FatoXq6MeacUto2CsZRYzFjajqPQrGZGeklvrXwmDMbmou9jrr7oKvgiUAWg6WEVgLT4YJUSCZqSUgRfZo2TUsh8h3Eg1lQxGgdbBmcYo/HQSrZGwzL49yImePOvJSlrnZz0uAARFcmBuIfyFL5YCFMKiNdIZXvP6L0g4jJylguWKocy/W16NtAVusEXdIj/7yPWBav2FrlA0mPfKAAOV9d4OHK6rwC0318F/Lxjeo28gvEK+YBthS72TLQl0oH2Gmcf/paypl9aM/ube4rSJny/OvY3aPrPQebLyM6YyZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fpbEWmXoKTECCjCNvb+E/fRwkolLemItLbhoREClVz4=;
 b=E1CnPt1y5OcrQBYOfzdFaK6t6UAhIaKsOHliDvp8U3AZ81dp/0+eCYWhTZNoS230ARMU8y+5uMBY153x6WGAdZ8NJG/XM36f9svKsMy2Qs6PGINsCU1xQTChDFxwsFkEuz6Zg6T1sfiS4OlkIzguFFVTL6Rc0qMhchcxiHfK1kc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS8PR04MB8466.eurprd04.prod.outlook.com (2603:10a6:20b:349::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 11:30:48 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7316.034; Wed, 28 Feb 2024
 11:30:48 +0000
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
Subject: [PATCH v7 10/11] arm64: dts: imx93-11x11-evk: enable usb and typec nodes
Date: Wed, 28 Feb 2024 19:30:03 +0800
Message-Id: <20240228113004.918205-10-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228113004.918205-1-xu.yang_2@nxp.com>
References: <20240228113004.918205-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0185.apcprd06.prod.outlook.com (2603:1096:4:1::17)
 To DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AS8PR04MB8466:EE_
X-MS-Office365-Filtering-Correlation-Id: 669ec3dd-83b6-4a3b-74d6-08dc3850b64b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IBdmasOsQdrwt1y6lgdAPRJK/Dodp9e8O0F9nH1z00FzNVYergE0jZWFCMn+enMHZi08DAYdqM1VrkfjtLbALFdkfwzRNGmuWzR66F6rvMfoKE8eUnheDL5/pdygLeS8Wrv6+lrgdgGnBQqeBnFfpO7KWInZU6p8qi4/VOCsGE0PjI2FNx54TXFERLwNWT/P6BH0PEhCqjtF+TlCbIiPayy96FhdHFMFjmncn4UyAN4gJ431n8FlnVtxC6yngMOQcTaNFq9WJdTrB/xYZMvqdJ/j/90bzYbVTanGpbywnTpc3ExOqiooIy5LzlZnsZaOBVU0z8fjov64PNyThy/eviJxg5b3idNB49WrZhWedaba0ew5XmvquM8xgw0PyuyymE0XN9TU3mKppeKIMSEQNkarbXltUg/4d2Ffe1qQzf7GHSUsT2/5dMlz56ISHrdLH0jpQjPw/QFuvGjLxFCvJoDV96x6CBUsYqDNOuY5TS0x+XdC33oG35YcHcnaLx7IjXIjYYnkmyvkoYJXx5PhzEZOVmko/LJL1YCdH217NFeq7wfTUHzQPCWClbDW3CLja0gVOC6AOipRY1KhhVxy6kL/X9AUFnr5wXQa6BMeCtmGhDVfZxObDlVq7GWvwy1R24PcwWZErxkaARy9eABlN+4ojuwXcIcxZcldpG4HXCUwBYWq+54TVRcpnmAyOjH6AHhtEGh6IpK0MrlzAhuT8Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yAlkYv5QhTCVjWgggailh+FAp6LHF9z7GbO3QlN7p33KNNYcXPTKi2TnqOKt?=
 =?us-ascii?Q?SCFDFsq8lcwi4LgTs3ZIrpS2JWho28ojUdotIu/CXkXwnKHmc/h0B/ajtiRy?=
 =?us-ascii?Q?Ft6uWuga69aTi64d3yVshFRAo0hpFLq/OOCvRIDDYYlIJvkMqWEoEa5xdbaH?=
 =?us-ascii?Q?V00LvbfRKa7krfnch03UEueQRu8Y++up3HCCKpWUmU0EF5frIjdL2vxBZ+Yc?=
 =?us-ascii?Q?vZQkSjCwLIIohunG4C7Z6u44Ga6WdtjweFb9D5Uhb1/2M/qz+JoDrRDpKZMW?=
 =?us-ascii?Q?QCpMy8sFdoGiMTpqgPXPRceWAtGeSrQYLAoYaha1RAM2nRbI3wj8X3uOQooH?=
 =?us-ascii?Q?uKLPfz5HhjOuATwmnJdueAw9W94k5jJDV6/n7Zgn9oJkJ6EDtsoR87eNLPnd?=
 =?us-ascii?Q?8JQrlBP3Epr8m/iQ7S0cF7q76KzRakuZTyG9Kx1bachxEfGQrlXmrRStDaUz?=
 =?us-ascii?Q?wZz6GYmtDVKxw6NqFtNBeeCgllLn/T4lFtb5/c8Ie6jRqErXIC8Bm5Zd+BMI?=
 =?us-ascii?Q?WnRxCfDzvN2lJwc8+0klm5MrrPXQGcWpOQkymbot5eyQhUC2XYRBmdxBPEaB?=
 =?us-ascii?Q?gn5IstWvcwPc7Rvu5oGEeUCapYY9lew4af8HLdeVs6Pc0W/6nioSDx0ezGaR?=
 =?us-ascii?Q?nNZcuMQjMdHtDj4TdKTa62Z0AlbaVx9HnHBrv0NeyGui0AbC+30TYfsSsn9z?=
 =?us-ascii?Q?YkPl3zg7b3rG0dO1BcxNvvgiDQNekKkARM7h2jCzzTJZP4/tmqYu1QmGWjWe?=
 =?us-ascii?Q?7OBiiwLJHUY2o7jV19YZspatpyk/gAny9VjfUBZR8ZEx+upv6biPSy2rm8VQ?=
 =?us-ascii?Q?VOjuR1ZOk/XS5FmB9QngxX3ZcMaQ3EIjFlueHopp2Zwoh+01c+j5yQBiLPJi?=
 =?us-ascii?Q?XtNCh41P+eGPFvSZCbuRid6HV5Z/bObaYnkiWykyD33mKoIPw7fuliP0xKqB?=
 =?us-ascii?Q?JS//SPi2C7YvbrRsrzhQ1sOr0eBZq4RPv+rOCGy38wiU1aZr1XJuXUB0d5yd?=
 =?us-ascii?Q?w+UpXJqCgwRnoxE/l1YGUny0SRkpiZlfIbE4MqQIoUq7l6GzC138doo14bPL?=
 =?us-ascii?Q?bcEHox80pD7+uCOXBMSX92tdvQorqE04POmFP3A1XWDiaWXsoQmPNvxO0JnL?=
 =?us-ascii?Q?zoIvWQ5EZBQWloDmPGUy07jlR8fRmU5sM98jbn4iREPhNMOIM5Zz2TWf4hv+?=
 =?us-ascii?Q?yiUar+AN65aSZiPajn+4pCEQY6kczaf0WpbVwpnKg+Ve6bS8/mj01C5nnW+A?=
 =?us-ascii?Q?NJLPE1bnyxPJN1fq/1ZVovMZgn4hCyRCrTw7zvA3Bj8Yq392Fvah9hyQAaQG?=
 =?us-ascii?Q?FkGQ3NvxZBlfo+O9+qeQiyJeB9ooXYsLJ7h941nFHXkmtFNVVVPx/qaEvzO/?=
 =?us-ascii?Q?KKgKogww6iUnT6fzbmDPfgiYu67Sz68tIN0fT9WX5uLXNpnOX9fLpRjYvtYO?=
 =?us-ascii?Q?VvQnY3C7sgba7YXEL06yoGagLa/MTsqr3ohHCP82enQVR1CzIENrjDhicNqm?=
 =?us-ascii?Q?5fOXWkNUfh/xC4EoK0bU1LEo9v7UbOOxH2Zv+x7Z2p+IsEn/YivamKhHy84T?=
 =?us-ascii?Q?MGFqjYtBYRRt9h9stBPAOasy2vERncs8gz2HxJIA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 669ec3dd-83b6-4a3b-74d6-08dc3850b64b
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 11:30:48.8761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7z2l9qXDd3L/8yphfyUBzlznduSdUZBuPcdlipeoSCLVi2kfKZw6mmVP2LmewYdUYSuFtb8s3Bd/qX0dXyhs8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8466

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


