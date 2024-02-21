Return-Path: <linux-kernel+bounces-74167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9595D85D0A4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35C561F23E24
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B987D364BC;
	Wed, 21 Feb 2024 06:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="A9Mlz7fT"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2046.outbound.protection.outlook.com [40.107.21.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B1B3A1DC;
	Wed, 21 Feb 2024 06:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708498304; cv=fail; b=ju8SdiQqQjnjRVQ+aZ1zzewMSDsF99M1M6D200dvmpS2Mqik0y8fM21rKRtNSVruXXqoIROGbgOM7BWS1w1yhOCWaRIWdc46JLQbphcx4sq4ISYQfQydPKxAHqGTBPM5Df1XSBXz+I2f/6xgRAh3CJaM1GtI9kN9E9rXnDc0sJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708498304; c=relaxed/simple;
	bh=ip3NRcBjJBYZQAjTt8tdTZ8nyIXPf/o9InNMQ3QIVE4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tvlwj2MFip/RAIO7yO4D/v8FqkGhydf08AgANXIr+zKXN0oA5feF2LqfoEPfq6bQv8GKBG1PkBKqMLJ2x+H5EnmayZ8VhvoB6MyuJc7wv25wEzqsucBOXcQxbtKp8evyf1oUeQgghfwheZcXjNgGpHbzn/2I/wm8eb0wWV/5IeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=A9Mlz7fT; arc=fail smtp.client-ip=40.107.21.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jmotrnNs28Ey3beio//2/fdlo2I3a8nKAzEsuuB1KJM+wpiYs5hu92e133prtk8YQVroKxwfsEOhtr3jwpJbOn9xmwrcXHDlfiMszANwOGipaa6prjtjN9XuLTK8LYokF1+nBZ7CoWHISZkVNc0gL+bvAB/NsA3ZSfgPBtIBk04+WE3Uathy6X9z2J+veEtgHilL9bzqi3MjnFJjZuEfgLg7GcfG4YwKV21WvlCQs0YIfttmK5PurHr7SfojTqllnuZqYzcbqmn+mUSC7HTafPTgXcxGiOeNwxNiereQY2/DrgYmzIis5pxG2MLTtrCmE1IRLmjZg2D191YV8+Ku/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+3DUPiZyCIF0dCjWANuXzOz5GbsYzZUw6r+jJ0bIXTw=;
 b=DYk77QPS0mtvmJAbXscsQSBIzMs2RmBDC/5DJPqmH8+dOVnmoyBWnVWdh62PFpVwbpdH7tNsVo/bzTvlb2hDY54JPVeuQpvkglXRN91icXqTD8tsCIoT1/OSnRLX61a+bAvVIjutI/XfkA+NOCjvC64aN0VoJg9WLwSKXLJQ1j8Yfd0B0TEULq1F4LwPCPEJl2VwyMPbHfF1jXmE+Ic1ulkPqjqA386UDjg2uSqS6P+p1RalvAiIY/7DKaH7tMft6GV219jvP5MieIPtkWl7tR4h9vP4+8cc9AjOHz+AfFPwpz4je93LTLBSQ3+Kzu4I3nRPxnIIT+HACm56nLBo4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+3DUPiZyCIF0dCjWANuXzOz5GbsYzZUw6r+jJ0bIXTw=;
 b=A9Mlz7fTslTsdYMYG695feUMu8vCwNwEsVz9qy82lt/37DKIXz2Kjk1cWFXXjzINeeNHDPSbWm8iDHO0W09BoEAYKA37o1I6Gk2qOunprEuUAyapBb2YkqxXVlAsbxozOetsW3VEAVXuOA/6gmS4Qp8mCQyXv6IUB7tVqlmY4nk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by PAXPR04MB9304.eurprd04.prod.outlook.com (2603:10a6:102:2b6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 06:51:40 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7292.029; Wed, 21 Feb 2024
 06:51:40 +0000
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
Subject: [PATCH v6 2/9] arm64: dts: imx8ulp: add usb nodes
Date: Wed, 21 Feb 2024 22:58:39 +0800
Message-Id: <20240221145846.1611627-2-xu.yang_2@nxp.com>
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
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|PAXPR04MB9304:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c0ccf0e-6ea1-4f9f-02f7-08dc32a98e66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CYM2MsFKAQpYnPgDVNihnJOJtxRNJcRrMXVZCBcvhGoMlNvs2V0piLItt5CSwhFV2+3lehlpbELc9TXkJdT4oAA4f8q9mkMZRSLDRJb4Yx+dyfkdKrKu1D1VgG9NOIJAKRESfblHxyfH6EVnZMMlmcsjMa2n5HiE0XuJrtUrp/8QQr5wxP3HKNhRkU4quJtAqOlsnObiSSUNO+H87hCW0aZLm/YGWqpUu9pv9z0l0njjqyFgy4FAWIEm5EhWdTwJD3dLVencn/AKX++OuiqrUSVC79NocvOc5o0ejJOCdynJbRIyqvN+8RI+gtB2fhqzMRgjmSf1a3VPidLFJ6m36XsICsbPQgfmOuk+OBvCbI6ziqN8WIWyCXQqY+hIDMTz52+a/SyjCnDMHX8InT5qbaCzlWe3Bl6Pet3q7otHLAGdSUe6WbwHpe6AFjZ7bEctw3SDx057dnvlXRwpBS6TPt6JXgDc3Th//RKU+HQlK3YV2+x+juSmWkCRh2iLRaid6i8XYvGyjX7mLid+pn8SA48NqZiIKJklm7ccwnAQ1GqC/3wvvC1LjXpcoxvt6gr7iRxEzuEKdFUmrgykiqic24jgNqFsyeJXGQJt+DBqRa/ykiCxrA4blfo+UfmUO3kl
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Swx8PeLUDFHFZWPUIuBC8Rst3OOK2Ef7pg7Ca1ZgNMODquaTW4x/qRXUI0IV?=
 =?us-ascii?Q?YNPK7b7e+Uo+Hp/lKb2LqoNXKQz51MaCCk0QOHzo6RfqQhPoXWgGQNWWhXSt?=
 =?us-ascii?Q?/Z9raSdRzVFjjTEFP5skYWzxP2wuEtilKBDpmk63LrafFgfWIhu2T4mZGN5O?=
 =?us-ascii?Q?GTSVh5jCX1My/vpHTAcU0Fjo6RYT427WP9Kzq/EsiDARgw/14xmfkk4Y3IxE?=
 =?us-ascii?Q?+MWMkTYYsE6qwT+5heWB7FIHo3eEqDFBRLPcAUqqsQFHnk1hFd2PM+x+jpsV?=
 =?us-ascii?Q?y3MWVsYYytfQXoxK9bT4/Asg13WI/Ex6CPICExH699vOV2zK5doO8NSU4ymJ?=
 =?us-ascii?Q?bwpDNFFCl+7xNKhugfJQcMCI+BwqWmZrKyPuHuicSGP79U6MBImSbEs74gUH?=
 =?us-ascii?Q?YopJ0fPsrBTaWVxsPs27c/+OkuGjSaOuprYH40BogJG2AI7vLL7RAkDFMXae?=
 =?us-ascii?Q?e8ldiMBOeuKB7sGTO7K204a22ET11CvlYGALIgDiUwoHpdDiTteCJwedbrxj?=
 =?us-ascii?Q?IEk10M9eACDt7y4105ysE1rHcjLyFboJrpRIPZ7nZuEGpR81Jvs2HOZP9Ylu?=
 =?us-ascii?Q?9mFTVWj/Hrkxo5HnTSWkv0dFWmGkt6Akl/gvu2Hvnwjkj0jOBKefmMgERXgk?=
 =?us-ascii?Q?1Ao7uXwvjkghL8EbDL0KqtS2v39/SSm6iJHoZXNcdfa3sFpzchUexxu1GDEN?=
 =?us-ascii?Q?jvCUpXutoxL9t2p1EoZLkhsZH5NwCtiSJ7kp1VknsUlccP85lqMcppn8K1Mw?=
 =?us-ascii?Q?HDRGH/Rfj4YuXCOwupNspr81CozpxgRrVRtq7Y0ZJQ3JKLWwn4GWXi6dde25?=
 =?us-ascii?Q?iJuX8aRr1BVZqep2yG1Wdi8R7vDLuJmpmxuzh3b+W0LuhsICmQgNRSx4mcYH?=
 =?us-ascii?Q?fZ0BebSqu9gh7Wd4Y/frOF4b+p3e8yo4+gC3Io7JmKIuNBgwgjoGnU+Cxkm6?=
 =?us-ascii?Q?xv0v9PPL6qWlCKENxAcGwoJ0jNvSzj+1+0dekdPoqnP4nWyrD9hQNubDMp0W?=
 =?us-ascii?Q?Ql6XTT+UpQ/broJCyz8x8Q24R3BCv/WY7oXDNNzBefHYqcxdUI2niNwGemEX?=
 =?us-ascii?Q?YwTzj3Z41UwfJfMj2RlRqayMIF9XJGwZz22uSlVb6fLKnUQ0oArYFY+XebUc?=
 =?us-ascii?Q?u3dKINelkQTHrqKp0f2WjX/UP5AY2wCMYV8W9sn76uCsoU11KLNmdBH0bRfI?=
 =?us-ascii?Q?uezDEIthlXIx71E/Nd0MfJov/GecFXOBRAzRHepdGEKfSvcfM4sjS7D5kMOc?=
 =?us-ascii?Q?/cgtDzyacgXy3RtiG/otGjc4aag+v0vRHVjrzKWtdQjGLWTt6pdtlEaIYUTQ?=
 =?us-ascii?Q?I+dYZxLVlGkgK6ENzS1h05bnwr0rCSBjKppOdo2Ulfe/yzKMyJGC8aDQvk+/?=
 =?us-ascii?Q?42zHUH7QEXPDZRIr86B4b1OHgjLnyqPTeqefZMSujrssU4fOMDic4ZWNgHzH?=
 =?us-ascii?Q?ou2qG47mKAQo8T+IY3kTHOhwYaOYWGmbXrfMCyL2YTexUdGcd9fqa0lsUIMH?=
 =?us-ascii?Q?2hQXZ9JZ5LokFVuNMGWO6mKmnOZ0z1G8M3BY3KozGqMp5k9dRzKdM0zO8HNg?=
 =?us-ascii?Q?uQV5lly06EQb+mcwvg72/m89OVrtqGDdY9GZoLn9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c0ccf0e-6ea1-4f9f-02f7-08dc32a98e66
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 06:51:40.1682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MQpkZZZMMwmNBi9o8swei+7GKaokkTrXtOBV0q3HH0r09PLcUqkNGHCewoS73+z/m74t+ZWXAR10NI6sOk+iAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9304

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


