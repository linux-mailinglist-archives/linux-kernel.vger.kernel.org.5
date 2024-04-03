Return-Path: <linux-kernel+bounces-129388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A9E8969F9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B2E61C25CF1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B5080611;
	Wed,  3 Apr 2024 09:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DPhC+Fyv"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2091.outbound.protection.outlook.com [40.107.8.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C1971B48;
	Wed,  3 Apr 2024 09:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712135083; cv=fail; b=nZ5gbxYdY9ZFBdTCVy4dM5scEFUYnYmy46J8Mhv97sDK2ZG34CUrOBZoevt2tx7W7xCFHDu8mEsFqXjrbDaXjdpmx73j82IZLyWPMFFbdvQ/kl0fXYe6vPB7sxB27HlskkC2syC3duhESLsGUW+pAYVGgn7m/n8bJawIC3iBz70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712135083; c=relaxed/simple;
	bh=5U03UW0/meDNyhG1i/Rp2iU01HQGQLKZq7BHzsXZgdw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r1fGPxk6uwHz1Wf73m45AvBhyct/DdZsns8di9OM7YQg9oeehO0WtTAHOxw/CkJrd/NGSCjNCWjyEiEg8zYKlFz0LTAQeRVBjsVmoawrOKRnHM48+m48TMbdTbg99pUottr9xaCQMPiqBmbZIPRdfIMg2Z+y/IDUVEnXxEXPYFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=DPhC+Fyv; arc=fail smtp.client-ip=40.107.8.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B2S75def9JMBpaRdqXO+yn8xStPBm9hZh0GJWtclJv2dQsa4B6S0gSifIYj6TD00h952jHXwEaoYapT0LGASyy+sUeh8jajbhbYLHhzy7S5OyYgJTUJmtDJ/qydx37f5z9nEpt+IE+4hfBY7lb3fNqIHcOPjyoDH8mCUP2MhSC7gpLFX4xvYRwkb6cQPVFd4YEFKWctMbCgE0flqgL8TD/mn8XNouH3GF/+39twTdkxEeEzkBEjJEMfOTkLUbai1XcST3b5bqNivuVBXcL995hGv7qHXNLFd/dgxLlpZkhfEidzvqTTHkMkAyyMJ//bgUyGQIrNMycodDDqNns5PAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1GYXPb4oEGHOYLFxWywsebm6S2zpOGtk6O3FtrN0T4=;
 b=kbm6jVWnvu2Miku+9tjHqw7d9iiiztenZdjHPlLzy2vsu/NBEBaSl2QZRGAIT2tfTD5hhnV3gRLs+Zbj34DkjIeLpZ/Ym89MSzWk9sL7z+at+MuZziDwW7gToQSdL4iobQFVGVSNP7dFQO7Vok6eYsF54mSO3f2KCudq2fmM0GbclwOp0dPM6bvoQLqatnumaP9dma6bbkQTACk+t5PaNAfMkHpRKeOt5OvVdH0di/0qzhBr4aQ9fTZZifGDvKJ6lkOcRdBfneLnSkUNHGFdyenBYRj5kZH9EZT5HXNRUq5XdZ0tU8jApb/FMcL1xXsJhbcCdFE/Izxqv8U4OGU3Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1GYXPb4oEGHOYLFxWywsebm6S2zpOGtk6O3FtrN0T4=;
 b=DPhC+FyvLsBsbupt0Hry1t/FM0tsiLUqAbwfhtfbi/a7ZtG2x1+X9j1/YCTwCmyXn1c9V3vqNGdtV911nIlCLPP1zBxawSR/p34yVZrjL1VExJuESdRlmcdBzFpSJQ02MAw0GDKqTPX6FIQeYDajGj1RLHWm1wrvEtgte1c93RU=
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DB9PR04MB8169.eurprd04.prod.outlook.com (2603:10a6:10:25d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 09:04:38 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f%5]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 09:04:38 +0000
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
	jun.li@nxp.com,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v11 6/7] arm64: dts: imx93-11x11-evk: enable usb and typec nodes
Date: Wed,  3 Apr 2024 17:04:37 +0800
Message-Id: <20240403090438.583326-6-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240403090438.583326-1-xu.yang_2@nxp.com>
References: <20240403090438.583326-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:3:17::32) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|DB9PR04MB8169:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3/cDjLB0+fli9P0jeqn+NowacjPNmTKSwDtK2f37Bjuop79FHPFGs/beWvRTqGi+EEuk8E6ChjSNIQbjXMNBZRJjedqK/0aJE1wUJAdbGWhgokitgbh1fToDHuIJNvqD6aln2pppb6P67yZaOdqgT16zbsjtUVyehCi3tqHyoDym1G+0JjlxmzMFitlj3R8WkK3G3IKec3w6mEUmFxCgE4fZ/e5P7pRC/0i8Gm4flIpIhl/YLrIk5QI1yRSGWTHsgVgFexFVaZ8zJCujLLidfIsCuP+2JFyAskW9B5l74l2eZkq7bsAgW01dLKB7AzEo/4Y5fvBcKMqp9T3oVKvh9pBpa+y1fE5VwJkO95p9MqzuVtFO1i1VdUuMdNgwLKk07tFXtHU9jwfE3jBgOQufUQxIjZu1hv39tMYLCqw8O1MLQKoxoqZO7UuJdnZPso3K6ERnaJ2KoHba4E8rd4264rZX3EdK9Kzt64gneykdLYtnm/fMjdiADUCguG0rV2kIzR3ZFdKPfNEhKRO/CQMqHw3WGTVhiLGLiAtjpLQWc3C7zCQT1mz5Wio2ncPeoLdQH9QBdYrn5+lxmKIq/HP5KwnGfap+MuFkLO9ySBVPkqUW+CBYQ3PMbKXwC9ltmlNKwYjUP8tTVraX+9mkOgblur+7i5sUY/cpms7T2V5LBeIYHpYY/5MZoyeBwriuNO7wLd/ZZC1+8aHlqw2Jua6VEg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z/vkNWbjBLSgVHiviwZxXEaWiqOkgmKUHqheKPCuDIIrLLpiUiOrgU3zr7pm?=
 =?us-ascii?Q?Ch9td7ONFUkczYCN+9wjmJD7dgj05AE/7pDNAufA8bFHSoVQAL1NNr2z4wM2?=
 =?us-ascii?Q?Cw+9VEusI//5i0hXOsb+FrRkVrMcFx0irKOhiCII+MLbXhEGckrGx3gHyOXJ?=
 =?us-ascii?Q?tfAZQy7aZQD9JT4cyhgEyQUZqbBYWXkEKgeFQ0zEQzyENiRwC3pxk9APuIv7?=
 =?us-ascii?Q?LTzzvOKzsOa28uQIpZh/9uf5Ao7p5Hu5jH+LfTReEzb5RAps863P8Bhj8eeb?=
 =?us-ascii?Q?4vEniS3YMS2AsVxymvAD+LZGfD2jrPAXEoXiByhZYRMVchY0zajqU07sPhwa?=
 =?us-ascii?Q?D5s2oEHIuSe0Hq3yw+2hEJpdn71g/ayVAxOQ8hEj/I5ovB2fq//hKuIiAn1q?=
 =?us-ascii?Q?bDH5qUAkD14RCSfJCfMo3KBmVMalpdAWvZkXunS3bOlOS7iZbNObk90qbQCd?=
 =?us-ascii?Q?IejenTi+sYnNeasqeKW21fMb1/xiN8/DNcV/rBE6jh107ZezIERFyc8VISbg?=
 =?us-ascii?Q?eu4FdP5ClVPjEZ+GP/Hvh41vf4IScCqnFwHAFuNOZLcCn2h1fAv2fzIOAn7Q?=
 =?us-ascii?Q?VodQXTr5vb8M1403q1l4mxCmdrokNFU+gKOsJHG4ywe8lB6BfJeCyPlRIn9c?=
 =?us-ascii?Q?lruCvwFzKIQRq0Wl/bA5j+jcADjmeC/yCMRh5HLL31uRESaLcFG6s6Y1S1oq?=
 =?us-ascii?Q?BFfISH2GVg/Wfq3ug4EK4Q4HTohw8aqdeJPi+Z/ooERv5eR2lkMPCG4sx8Nw?=
 =?us-ascii?Q?2VoHo7BDLBPVDu/wefvwjaMsMV3O8VD1xuV/5XpH7SlYqr3X+FHIgMA0PzNq?=
 =?us-ascii?Q?H72hilpcjiteDPtlCQqCzWhp8trWBcb7RX1PUBZqpnRa1efSDH003KOl3xLv?=
 =?us-ascii?Q?KFY/AVRovc4e0/RddR2lS90h9DXqbN7pcnYf2X667sW2k7sTBQ6/zOS5XYfw?=
 =?us-ascii?Q?bSvffUv9e3FGZpjfkGoWA1P8Q+fPkDkLR2wCX7x09THFvATM3FVkqxvIOw7p?=
 =?us-ascii?Q?J2hFqG9WrMDYybJBmYIoPvbbUsljsURvCPVUCk8U/uLFTh3M7c1bhWq14jlJ?=
 =?us-ascii?Q?CM1C37L0RGmrnq8e+sKFHKFn5PzM+nVXKOZKfgI2kBjXOkMDW/Q67gmOPpAQ?=
 =?us-ascii?Q?PVrQ1aMPh4Ejb+f00BLcMQylw6OJ5lyFFcXdcMro1tqYYmndZFrJKcIFde1v?=
 =?us-ascii?Q?YJDwMy8IjrkwGVLL7ACcoQv/rwTob1wiYIvsI1Dz7e+9qORYM0fZs5p9jBHH?=
 =?us-ascii?Q?e4wpHDKscR4/JmIfHM3m/jCKOjNrMw8T38L3N8OB74wBKH7KY7Wf0rI0B8wn?=
 =?us-ascii?Q?4dhMwAGPFh/zEWA+apPaWNm8Yokt+j83aRvHTGFOKdMv0Rgw6YHeqCl/kE6P?=
 =?us-ascii?Q?iZRIZ9Wo0yeLEjM+l3p4HXmmIyq+IdFJrxOM3jeU139+SPk0dlT80POV1eUC?=
 =?us-ascii?Q?A+S1dfE6kO0NGQebo01+mGbQyQ8wrDlYDRbgsMa2gWIYTQyr1gRhu8DaHvvm?=
 =?us-ascii?Q?ZxrHUlWHbjouAxv8+Zn4d10oxqDhZWNyeQS2BtmcINf79tkutcJSr4DtERuv?=
 =?us-ascii?Q?fnX/LRbzrQ1PMl5GTB5sF97nkQ9egTZvO26uY6Zp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70303895-5aea-4651-4ca4-08dc53bd1594
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 09:04:37.9232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kWFSss58Ae3SR4td0rqIFVVQNz0UYzVBdJ2+TCFnukD9q+YzrV4MmTjbroji30x/pj3tjErys7lRfT2m6Rspeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8169

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
Changes in v9:
 - use compatible "nxp,ptn5110", "tcpci"
Changes in v10:
 - no changes
Changes in v11:
 - remove "sleep" pinctrl state
 - add newline
---
 .../boot/dts/freescale/imx93-11x11-evk.dts    | 119 ++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index 9921ea13ab48..fc340d4573ce 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -5,6 +5,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/usb/pd.h>
 #include "imx93.dtsi"
 
 / {
@@ -104,6 +105,81 @@ &mu2 {
 	status = "okay";
 };
 
+&lpi2c3 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lpi2c3>;
+	status = "okay";
+
+	ptn5110: tcpc@50 {
+		compatible = "nxp,ptn5110", "tcpci";
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
+
+					typec1_dr_sw: endpoint {
+						remote-endpoint = <&usb1_drd_sw>;
+					};
+				};
+			};
+		};
+	};
+
+	ptn5110_2: tcpc@51 {
+		compatible = "nxp,ptn5110", "tcpci";
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
+
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
@@ -156,6 +232,42 @@ &lpuart5 {
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
@@ -222,6 +334,13 @@ MX93_PAD_ENET2_TX_CTL__ENET1_RGMII_TX_CTL	0x57e
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


