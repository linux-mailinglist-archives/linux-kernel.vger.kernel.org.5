Return-Path: <linux-kernel+bounces-109763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF858885564
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2E061C2112A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E566A8A1;
	Thu, 21 Mar 2024 08:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WdGpXvNX"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2061.outbound.protection.outlook.com [40.107.21.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDF55914C;
	Thu, 21 Mar 2024 08:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711008875; cv=fail; b=b6QgsKzs+flU/79lS0zWISwEFM6+3bABYO5VxS47wGYKXYiDC/tjXarxn7IkmTJ/YLHFBmqDj0prZVTh2RaZzCtaFGWX/dstyDnqWoynEN0J8v67jfagg6+YnTccjbU2S7HmFcbUNECUHJPbZjwDlFYX4xw8RWxkF63Z6RSa8+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711008875; c=relaxed/simple;
	bh=mj7Jod5VgWg+5Qfi4yt+jJmMpo66kz0Afxa6XoX5Sn4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oQATVsXEq1jE/2YLHQSN3nwvxbadLt/zE3vSu5+CNU1fnz9am9CWTNgVZuT2ZyBcPeZXO8e8ZH9ctJ55w6tBbP22b9ablosXDA1ibiGTQipkZQuR8ausYWlVz7IE2QwtnS5QF5Zmi0H+Ign/Ky2fv1b6tSlCwh0mrCQF+UwR1JE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=WdGpXvNX; arc=fail smtp.client-ip=40.107.21.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LbSay+ta143LlPrgDa0HA6q9cPwa8erg6JcR6LacuVxZfr0/iUjeF/i1qjXH5rewNzUluTys8VBoGDqRtwjptKS9OxPJ83ZLim6wb/kt90s0OZE9iYT0BiCd+Wmg7hmUkgJwXe8wyywU0CFK0xWpbnaki78X5RcDaiGiodZcf11bsWeT7TEbTQWpUGGosY+OpoBMvD0P2/d/rii+g9kIb9anOgQT5639JizdMlFEFT1UNJhMz3xgC5tM2YH/gCVv0vG0UUCGoxkJfwpLc6CHrEmcLQWeUCEKP5ybNDL7b5HCY+vF80kH36FtYHSHvEjHQJFcO8V7wQXMmiJlu2wV0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vs3IWFlHAeQjdwI+RIRAzqhsLWHAwyXuUQtDz06h+ck=;
 b=YJd9hu6jcpqDyFGIi4rSiQOzElMrc2Jcl2qsIczyXfGGnDq4gy31scxMOzHOu+A+T/Ds8C7lovEENFNuca8LaHbAz48L97xNCperCU996Koy8WlUkQavLgu+ePxuGye4bZ2rPd86yG42pO9MV33IRdYGW9wJMfP4IzEzk8de9N6L/Dk+OnKGdNZ/DNUnhzxR7rlq1EUBU0TjTs9c0USKSvbs+mqGd/kBH50YO4k+72B0sKwmqb9q7gnWauW53GOLfGLe8GDM3ZITT29Sv5t6c8g3Uhp+D64Xi8Ge5UhPuG6/InGK6CzxruSAYtsw4tEeTfMXf5LarGy+hvOPSAmO0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vs3IWFlHAeQjdwI+RIRAzqhsLWHAwyXuUQtDz06h+ck=;
 b=WdGpXvNXxKTL/W+evZuap3A/SgU/YmnY1uy74WRTTD+NAx5tYeMQ2+7Bf4ejXsCO8OZFrwAgav+bd2MYSoE68zRHL4pzVIYikhLf33iREGy9MVUEktv/b4tkGaAoulqp4aymWQJ5iC11lUzpPwa2PvtzUXM+FgrA4MN1kg6hO0I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS8PR04MB9191.eurprd04.prod.outlook.com (2603:10a6:20b:44e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Thu, 21 Mar
 2024 08:14:30 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7386.023; Thu, 21 Mar 2024
 08:14:30 +0000
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
Subject: [PATCH v10 02/11] arm64: dts: imx8ulp: add usb nodes
Date: Thu, 21 Mar 2024 16:14:30 +0800
Message-Id: <20240321081439.541799-2-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240321081439.541799-1-xu.yang_2@nxp.com>
References: <20240321081439.541799-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:3:17::34) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AS8PR04MB9191:EE_
X-MS-Office365-Filtering-Correlation-Id: 01220e29-dd22-445b-f264-08dc497eee9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3GzUmBBFTDTPSxFzB6PNwWAwj2VIhzI72uTvVoYw/aUZKoMAHrz6DeiYT0SwYe/yJCy2/mPl3W8tZEmpYTNbHQijJ85fFnBup/VVvtTPDR/NXtQYZp3r/MrboRY4/0zVdyLO5DB3uWFeBdVbIIlDIG890NjwW91ETG55pi2BsOoUTMSGgqVYApIP5bex/Rl+4AodSrdXXH+2hH/HF2RNNvONByhjIZUaXozU1TDAMZ7JVOYItCiaQGnvA/MqhvRzNedKMD2wSJcYborRT99I4v3ToAMoFOq15UdNl1oD4KwHqT2zzmzP0twpCb1BzzjeAl2CIxskRLxz9Ud+2QqgJLbxJ3qvR5tzSvdHhqvk/0Yuice4quYbAEyEEJXAgoB/xrh0n5XCefjCWRMEXS7Ugppvz6ObsdTKJB3wcRvrRbiG3PXvQL7H1hIKplQM+C1eklO9xQOJgMb7kv2JsHeEjJ0iHiLUMMQc+k1hJGhwXmJjWztz+t+ZmKZdhc/OIMAu2wKu/N0cuoZGUOak+wKvg/IwwYUG/p1GTxG6gz81vXWkrBptjjbjZOsGhKHLmWNNWrmn9FAr8Cqk+Jg5X6mVBSBZmP1JiwoEtc6qYiJwaFP1hub+2BbYDx2f+dXZMhIhQYOu/0WGx6TxHX30dNjKRP6KwcRXPtIg2oyXyOot2BQIsGT2rN+1KgtT8tV8xrvKMNZWhXqqrNyHSlxe+0QAng==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(7416005)(366007)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TboYQNoVLDuLMFeeLMns0pJyOSMJPAHDYaKghqvQF3jdE9HZN2+m1v3LZdCj?=
 =?us-ascii?Q?n+nkA1wvHYnfTpDeQWVRyuQnrPmjHIoDVMaVXuQh2zW6hcUhqp+cGt7R36hw?=
 =?us-ascii?Q?PMjLdfx8O8IX8l321EfnRNTnNeO5G667sYB6Lk45WViwbS5DSDOuEIPJPqrv?=
 =?us-ascii?Q?OAhX2NSdXp76wxpNWTjs7MbgqIuIbH+bAGDl70IxQGgQwvSbmSMSNc/2ssKZ?=
 =?us-ascii?Q?1dPFzdHFy7w0l9hkzhKEvE2IDpegmUIrIX0Abrx17NhF6xYQ6EDC5o9DAKLe?=
 =?us-ascii?Q?jjb/k1gaFg/L2M66yx8O8VXlR+8753+4wnAuO/G4m2nZjQ/SllAB26Wy82dg?=
 =?us-ascii?Q?9kiegYbysUznTumd2iIOYtFOCLyw0QAdJai2tM1/5b4TWDaSGY2TXeth2Z7W?=
 =?us-ascii?Q?8UZjPtv4VbKq/cubimGqJS7YkzRtZ6UvxdhIa4HcNdyYwh9NKv0FW/f6hlK/?=
 =?us-ascii?Q?HfDxUWzmBwebBlTqyYDOInPTTS/587suWBYqIW5YgvDFm/AbUD3pp4EGbrno?=
 =?us-ascii?Q?hYyE4ntYrfAkC3ZPIpbFAtOBsFf+r2CNL4KToK6k+tt4dzRikOlz1mETbUmU?=
 =?us-ascii?Q?WElBfnJF+hwO6++KZAsOghVJYLwMY84QobtMGsktsptEcVk7w8pPT8K1/IKJ?=
 =?us-ascii?Q?P5D8EaZtSda0P50mh2/lmNr6aRVZIa9Rg7dPdcU0XiNe7TmNuZgUeRVxPgYu?=
 =?us-ascii?Q?h+RnDAK9LFw55tOcAbXOaRTWbjTaSPfShGJUmc08eGYezg/iy5VbDA2TF2St?=
 =?us-ascii?Q?sqCBeZAlOAdDA7WMjSeOv6o9Lcrp+wxuemYPqzc5H8kC+hriq9aoR8gRNFIm?=
 =?us-ascii?Q?UyLWgUam4Zty08uO0kNj1YWvvvKZbE7Kt6EpaNVa5+X8vERt5YlkHR0KjVDB?=
 =?us-ascii?Q?2l7U8eZO6CShqQPs0hkm9am4PqG5fww9md4x2kueVQUH6F2oBZtitJetdwFD?=
 =?us-ascii?Q?IG9oTfdXMHgRh8QZvzQcIDOJ5wa2wrHYHMJgHvSB4xvZYL6x6ASCImtRekd6?=
 =?us-ascii?Q?6BaliAKBByOuozMzsVUDV9HUeJfUOPen7wyGvJmiv6WwoGIeYP925Y+MeGfM?=
 =?us-ascii?Q?BsDVosqt/2Zoa+MEyBh0U8h6Lbt4M3LnDQ+KTeTQ/sMuisJconNsrKd/9/Xs?=
 =?us-ascii?Q?2/WWpCeXFcHnAG1Jyb5OjZXteXKEzb0WDm3J2Mw/rXe58nyp6ZfXkKbVcnRE?=
 =?us-ascii?Q?HpVp+IR2YduvRNl1y9p//R3mClEj/ZSdXHK1MbcxOUJ0vfVs1oh2WeFdv5e4?=
 =?us-ascii?Q?HawZ8w7TfyD0Ltkxyf7fwAdesk1BkWuTJIld7LLRc00g0yBqjWy8aDYO0wF+?=
 =?us-ascii?Q?uzWA94O9ck1GOb/9ijQutn2T2dDEHJMfWoBKsmv1TDKhpLTTQBG/y9bSq8GZ?=
 =?us-ascii?Q?lS/H2eIBh/3Wyyvnczn4ZIR58Co00FMANRIwnMLIeRkdj+XVwlJlAdTvHnTh?=
 =?us-ascii?Q?Jpinv8ILOH+0xqSZUTW4uLDcpRMn6P2np51/sJ0nCrMCsn2K6S9pduJchldt?=
 =?us-ascii?Q?zsPglG4CtwV81SXUiKB1Dczww8dm9DrsQgf8S+/t8FFAjHUHCAFa3IHMEcIV?=
 =?us-ascii?Q?85ATRJ2bjv1qzo33sabWytNbCUNTvQFJYBY5jb8Q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01220e29-dd22-445b-f264-08dc497eee9f
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 08:14:29.9777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ZUP+Mieg8/S0r0MOXEd+QrcYAlY5choPAX10fD0YHz5QLr9MFyVh1rpE/rwX8cuh0oniy7kryXcIoqfV1fFSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9191

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
Changes in v7:
 - no changes
Changes in v8:
 - no changes
Changes in v9:
 - no changes
Changes in v10:
 - no changes
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


