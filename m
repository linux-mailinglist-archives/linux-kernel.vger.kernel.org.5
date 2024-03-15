Return-Path: <linux-kernel+bounces-104114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8422E87C91E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 08:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00DBA1F2265F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 07:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F64319474;
	Fri, 15 Mar 2024 07:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CPbdWo1t"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2042.outbound.protection.outlook.com [40.107.6.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBB318EA1;
	Fri, 15 Mar 2024 07:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710487528; cv=fail; b=kZwzVKF7ViBHmyaeW57ZHo2D9+/lbkm0Tava2KXoWq+UonnwhqD4ZSizDqhK06Y4oJvRnnj/tdgIjBFpuRzNAxsaDvsidyClGaKSG/GCMc0CXxT1SpCBAnGb9HmK0KxyM1cWvbg2Ejq+OnEByotumLfkwjJ/z/dCIX0ARty+e5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710487528; c=relaxed/simple;
	bh=fV/GYzwyWQiQ/Z/1vWPCydiLRmY61cmgrZZP9UD9Zpo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Di6YGIOsh9g1LN7BGc9sZieH8fidvU8lq5GxnDENIMIxPxnFDfH/0jtDdcAVSUAz140Kbr/g6Man8YlUk/gwomDvxUdYmNWdqnlZi6fZ14uNilpr7Eg9cWdASnt4aKxOwmkxxv8DjMhaK7M5lovkvmdb+Yzv8wRWOdA0nJyeIV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=CPbdWo1t; arc=fail smtp.client-ip=40.107.6.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TdnpQMQUL1r/7+BNYsHW3rKyXBss577HMbs9ZvUXcLD7TwOvmjYUOJYP/pErV37m4Ag7dYcs60P1XQ1mWx4oWDolQOrXv+WzPELmE3qrV1YCSmvKAHMnA32n8DcxRM4nQCWJF3CpdcGbzWRiqYKPHJK0pi3dmY0JQ6NXpIUwvHClffooO90m01PAR16nfzfdRk0V2Xo83cx03bw1AcqvBvLS7/wbu7fiO/uqdeJFLvL9zZJ4nc7/nXpHczmejFc80t5yP+1WZsRNtPkTAO1QmEEYsMyJctmUP2FaZHuQQKJoI6NpwNU8LkhRqxB8ZzccgxMbdMUDw7ykILvDM3pNMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CKMjy7qroyuInmFdmbha+UmMdcVhlljvkwHsHvqiK0I=;
 b=JcddRtne+1WFdUzu/DhoWycKChZ91wkbgr6Nwa1rhNtGnMTOZi4Kt+ffpqdfCyUzfopITNmQx0gGT+6FAFljdMRDXMQ0VOd9aLsbvqgVCRHbVf1+uF1iIzO0zKtj+Y2A/v/Yj/HKsVTNV3/S9Kc8xywjpOTcheWtBejeiot3QOtXuYHgbLgRrZWGUdE2/9cvfyuvwgMejypYBjpymlN8LtgYD0CUYXKlaTbpK74Q6989LKF3ovSmlp7XlGRq19G3mymmLdRxVmK/Ex8ElOyi4jXJwBBZLWScJ3nq/oBk9eImgvyrlWldt8p4wfEbyCCOuBf8fy3RSypUCThKaywDnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKMjy7qroyuInmFdmbha+UmMdcVhlljvkwHsHvqiK0I=;
 b=CPbdWo1txh5skf1mjq3J7pkwmfDWqri0uRl1wiBtyc7T4Hhp+SUXIapApst881821U5z5yDOSY7xjtY1L3rARiIfzvpVanc/DitxaECLIF+OGIXvKniHvdwUxRSLFpdcKnbCBwvzKETl6PLEEbH7rZZZfInlkG+qBfoieWBaG20=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DB9PR04MB8332.eurprd04.prod.outlook.com (2603:10a6:10:24f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Fri, 15 Mar
 2024 07:25:23 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7386.021; Fri, 15 Mar 2024
 07:25:23 +0000
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
Subject: [PATCH v9 09/11] arm64: dts: imx93-11x11-evk: enable usb and typec nodes
Date: Fri, 15 Mar 2024 15:24:53 +0800
Message-Id: <20240315072455.2481613-9-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240315072455.2481613-1-xu.yang_2@nxp.com>
References: <20240315072455.2481613-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0043.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::12)
 To DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|DB9PR04MB8332:EE_
X-MS-Office365-Filtering-Correlation-Id: c94cfe1b-e3a4-4a37-56c3-08dc44c113ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FTrWoYY7/LgaCiQsNM2N/FSRpZJR293j1HhTyrHmMWV2Hxfe6h08z9yLpubTkHZ9jXNZ1p5VPeYNw74Y0GRUEtTqLy44lOdF93icQnyCbR5NG5Uuh401n7wBBHd5AFp/+SVykTqiZ3S46SSGNE//G7D3m06gCUKkcCdG7cZE8xAxL1XdVwP3Bqfhe8A67p/Hey41w0TWAB9esz16nuIqyyfSVk0PnAtuXibhAmVjtmvDg3gOnuJYSwpI5fzG94k9UDtZo59UvqUP/5OkLg5Uz8pO2MtsZ4XuWc1TX4/nrHcNfD8zy+k188luzevJOfKPTTfhsy5OSn3YRMa3OppmOFTkkQiLkRoiMXDqN0ZklMBdZwHqbdEY9aBGwvUzmGBwT7qjXcmpQ/1g5KHUjciS+Rqu9yOCSf0OEo68tZL2t24tSqnWmP8VCs6MRjX3pfq3DuGP32z0zj0M9SUQ4X9upHi3RbejBReoQFvttHE/pws/P9U16w7c9OWrpaHkeZpBBmVGAcAX5LTk6b2LEEI6Gb2kQrgk+gtZ/3SE1CvJ4Upups68oyZAynrC/htLK2OSNC9z8qRA4cB7HGpo0ksDFmMkak/pLfRu8tihNv2JbapZbQNDXjVRz8bp7jdEv9r9yCiLBRfUEHPuqtlR0GF/24NgYtvaQEFiEOwxpzsdp+vqXTJAHy4i0uw0jytdlPpYFUeU1TMFALF1Sin9GeKdSA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(7416005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t605OjHlWXGwG/LSzF7E4pVFnOjKA/ENqSKLS2DHQEiP57dzhVdIq8Y5RTTp?=
 =?us-ascii?Q?h2ylRMeAl92MQ4dPc8KG3J8vjeyoS//v2AlGeziiaMpQqtvaDipZq1pVtadj?=
 =?us-ascii?Q?/YohEq6e2/CLAa4340oxv/qxzt+Us9QFv00P3xZ2i50DeEvP8eAaLj2WXFi+?=
 =?us-ascii?Q?Rbj+qP0b5goWML2coE9ucHSKMJ+TWib2Mu7CAyUHElb8G6QLcLn/w7ID8TC8?=
 =?us-ascii?Q?uLfvN5nbJmuMhkZOHITlmf1Dt+pKKYygvienOYg7jQdGSWWYZF+bj2I2f9aV?=
 =?us-ascii?Q?cu+Fu11h3R7RlKNjkGcc9gIidMavmEZN+A5P+8vb+KAOk4FUE38rd44NhksR?=
 =?us-ascii?Q?bwzQ7IxZDsOAnlsQWxO69EeWivShxTSOoNHzXT57iSI78UOjSjix7GNnTJQQ?=
 =?us-ascii?Q?LqJxVwDvkWxoc7hwE+obPWQrQsMgbfJU2wOAky4pQYtbblG4wbB+PzS5Vzux?=
 =?us-ascii?Q?BQuxDPW6X/V7wC+i/K5tjjSrmL7k6jTLdvloYMNJFpboUTexmI1H8Whb1zD8?=
 =?us-ascii?Q?yltrRniezot+ndMtpSW/Yul3CjrohLMDTMC+Q2FFkc/ZEuy8nkQ8+OnL37Ad?=
 =?us-ascii?Q?PodNY3RBxIPfde1/0p2pZI6KAdVGTttvsbQ1Db1WcmwNz0LpJ3iDrsWlbLcv?=
 =?us-ascii?Q?rfid9yll0RQm2UJtik09rsO59v8MDOB0WLPKohZxgXo1iI8r0UVjyW3bbXRs?=
 =?us-ascii?Q?cQYP3c8qbflmd6D/cgQbaZOziCphKn0SvLU5Vey2bpRRdObRVn0XD273qnUn?=
 =?us-ascii?Q?6EV+SzYpxtLfNnPrPK3/iTZxZWO0nzBVMGpF0nV8WjHg3hClbAaWs0mx/wrK?=
 =?us-ascii?Q?6vLlaE6bCOuvIvCkqNakokE+PTAaKXElTM4vGFmwUMVbXflD3RS0xlB9PtuB?=
 =?us-ascii?Q?Sy3i69JMv+lGh7p3VYvMsa66PNXChaGLFMNuMWBuTxuwqUb4N5euC2nBpkca?=
 =?us-ascii?Q?CMVhNjahnVNrPtzduHpO52QF1hnQB/vu+WWc0l4DOEEIOi+s9ZyhrgzVs5bi?=
 =?us-ascii?Q?hO8rySruq++Wxc7XJqkYEi0oqEpBXm4vCsmCicginNicoM/OZG25ZCvpbiUJ?=
 =?us-ascii?Q?92473WtZFGPPXizeU9OSkWQOGU9O6HWKfeSJbOKuurpn6Rrbm/0k7KwmEpRD?=
 =?us-ascii?Q?0aq2flrsH/vbA7Xl0z0Zohido0FbP9Lur0xp5Mvk4TiiKtgA70SixNiRXIUC?=
 =?us-ascii?Q?eboz2YTVvWriCIbzta3ibOSV+ICPGImDzcQb8+JmJ2L3t1GWWHxufdxRCzir?=
 =?us-ascii?Q?e06y0NqwQ7AEZcJCUvjdQq4lYLKFI4h9BD3+g6hZ0fFBrChPp2DGNngCUu64?=
 =?us-ascii?Q?+we/tN0k1J8zepNpTEPY6lm7WdeOU4ekBWcW8Ms5E/f56Xp5cRfCuEZpZov4?=
 =?us-ascii?Q?Nb4JFd2b3mT12B84LWw1EDUfFV+wdV0xn9Bf3nKkZCd3Ba/N+IPjStVENYxL?=
 =?us-ascii?Q?Ey9I4m/fEb0ML5ilLijbeQoJFl5j8UqoRpvav1O20FY2TvruHOKThPL6IlwP?=
 =?us-ascii?Q?nAHzGgRD4bEF/vc7bx50180zZAB2I3G+day14/m3CN/JWCde7jDYknEiIhnG?=
 =?us-ascii?Q?Cc+9B3PfEdIc56lhjbNxLSbmiXalp1UWMCY58iYP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c94cfe1b-e3a4-4a37-56c3-08dc44c113ec
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 07:25:23.5041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iTQM5MfRSi4aDNPjd3D2sxe/S4CL10xKAhVO8V/2B8ZOjw36qS2B8Ige/8lXCfHhm85SRIP6IbQdTouVVborRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8332

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
---
 .../boot/dts/freescale/imx93-11x11-evk.dts    | 118 ++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index 9921ea13ab48..ecc01d872e95 100644
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


