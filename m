Return-Path: <linux-kernel+bounces-104108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D1B87C90C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 08:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92D3B1F22561
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 07:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7868317543;
	Fri, 15 Mar 2024 07:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OSw/0hap"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2054.outbound.protection.outlook.com [40.107.6.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A67F13ADA;
	Fri, 15 Mar 2024 07:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710487496; cv=fail; b=F5KW2udrv1AdR12J/GKFE0auWrqX9nXpPqxPfhTrMdO/qsaeZ2aTaif3pO9cfgGC+cNIDQ/KTPz2Z4bjvQHyTMI6DXlzSDo8mHwH7ddFOVMq5dedWG8UhMEuxgVUMoDHVPWWb97nXWITaOZDACSDcCJwE1fEVmmlvvVO4nWugxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710487496; c=relaxed/simple;
	bh=nZwonckBn+oXRdd0znDDxJqdMhnUe+7z1w8v6ImmzPM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=USH92HWKGbF2C/zvi0DKMt8+EhrcPYelTopTIF90L0Ti+S/7C8B6OtsBe4YyANvYQQQ+T6ZpwBKNd8AvcqK/f4QCgx4o3Bz7Y3pD44+Pwp76IfIKmmDB94BClzilfSdE59RwYA1gpLIDCrmNLvS6UKoTj7ILVy9hOxk8rGGXV10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=OSw/0hap; arc=fail smtp.client-ip=40.107.6.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZYI/+4p/tPuedPB9c4wXz0horjEP885RdGcP/zpJ5IOLKBK1aQ1w4//OWFqRk24VEJNXH4BG1n06/TcV5LlJEsWF1u2GudmRuiJ7ZiMEvQ02xipUBOM+TeLP0e+qDFFMBcyBfAUX6U44IYnDjOugJPl85kJ9fquNNop4oP+7aDoY6AR60PaU3JzQqBOm1/8kYVOLcreUwfEcepux2aPGn4H4/4mbFRI81dAQLOotlDcVtOH8XsWEphgPORKDbIfOqiGU1wcqdnaagqnr8z3yXS5pKza3T8YDnbEyN2AVP00B20g6l2wij1Npr0SC8NzvblBrc063K+zfQWvmcmk7pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbsVE+m0WfV6UaryDu1wPnTOZrhWmV8LcnRTSbkfBEg=;
 b=HaA13qnLCEzklt0R5KAq46bRRv2yvvalR1tgMFTIkjMNG2Ud+dEDhyHYdBNItsEnyyNPYGTrKFLJ2XRBOyu6qdPXhob7J5nI5NKqWsLSiw6KZ0APAnED8r+zpvt/xfTBDD1locHecDzQtjucovt/8K5QYDgPHZBrSWWC5NryFk1DMnSNDaFOmznCEwRM0njCPerf7Z1FHIGumDthtTtlizqmLzeMe3DcmvcZWF327TFlFHClM2LkIcmHE3lpHPMVK+I3m/Nw3bJqONzVG4DSR626KjYQ82ej8apFTM0yRazDuviLRZ5XxFq74quIxz24Qhs4bpShGKB6+iYVSnBvbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbsVE+m0WfV6UaryDu1wPnTOZrhWmV8LcnRTSbkfBEg=;
 b=OSw/0hapaEPfkmiwR9OokrqVoOAb0LEDEePn8edh7dI/e7sA5/XhIxHkemNX8C2NgfC23LXZqM9iOViSsZgvIXxvQwzGoBAvRSy6ZUnxYeTCIaqKlIBtSYXBFR7NDL7Ob283IXO0uaZwBESeN0bJcplp9KFXkPNQJGmrIvMYiO8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DB9PR04MB8332.eurprd04.prod.outlook.com (2603:10a6:10:24f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Fri, 15 Mar
 2024 07:24:53 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7386.021; Fri, 15 Mar 2024
 07:24:53 +0000
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
Subject: [PATCH v9 03/11] arm64: dts: imx8ulp-evk: enable usb nodes and add ptn5150 nodes
Date: Fri, 15 Mar 2024 15:24:47 +0800
Message-Id: <20240315072455.2481613-3-xu.yang_2@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: bb29d3d3-8a16-4eea-8fc8-08dc44c101c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	O4ayipuJcaTb2AcrSshwUJIrQtWHpmde4NP6lBRVyPU0mJ1nBuJEHrfOwjyvIcZG9eDtihuUY8xAGormtRkcHMQG3L4+RNe/HthaRbFpaoTThEeSIUXPNmUt4nTx1Oyg0y++JbieDmm+W7jbsgJ1tsR+OczMxv5RaCXbYU3/K3bBepmR6yGrx+BNz/aB/mGw5OdUt1eyCohcPnkwwm5B85WdWKqGrmYxP/tQqlyRRNqGv8nR8v8waNbj/ibLPocDj2J6gvXl1eag/eJ0cmNPJakMUq/BrdLgYBwNI7Ry08oxkoco30eXM0zhY2VeqsfhAM+P+mGPCT2QN4UXrzx/JXu+7TDGAm8VxOyLZH7clJNXn6l4fvHa6Hk6bogZB/U+tuSY3xZ+bJ1b06OQGIwqOPogRb9zqrwsf88dRNTHCflnOno9muBmDj64au+6OeWk0sIfsU9y2tAD6sLCN/1d0lbDuPgXjydY+KOyifj8pDDwFQ91Nu0fR/7ihNB9hJKe0PAZknqrYro/YbKFWM+1/QJqqdhKxOgEqc2p9+TDDiRwR5LMVogGsHe0+d/QTvhFD/cReKKoMLbvIFep0dZE0FnYDl6xLvdAOXSzx3eoHqmxJPmeoOWO+1MEyvlsy8Q9095fojGHW0wYb0q9gdkIER9EeW9Z79amLp8X0pvSZabn0H4bCu4XlK8cuFRnaaqQ/9DX7sVzZDAjQaBlefjMrQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(7416005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cb6zw+Tq5AIiN7E122HwRY0EhoeaQ+b+/CcZiW1rrj/SQx4A98Mqot7r9tFW?=
 =?us-ascii?Q?795OcrFAzcpu7q2IiuJdTceX58vWGY/lyDDI8mWntWaX+lL0D/v64UF3r4le?=
 =?us-ascii?Q?L6n092OauDMyT2VsKTAry3BDmUhUDlFoW1Bz5Ge6IIAXW8rniwNERUy6Vm7l?=
 =?us-ascii?Q?mQKKNznzjtAefcqX1lv95nbSEUjmk58q2wjAvy/tj7oT8mX9l1za2Jc4grCX?=
 =?us-ascii?Q?tWqjuPw5MVJNFDXGhCl04aqEUW9fftDiQetnJElNMy/eVB1UZ+Yuq5B+2nR+?=
 =?us-ascii?Q?S/xARFbSOGtMKPH3BZdWIUpg1TSrkbCBiS9INA8k0UTBqT4Fs+GPo2P/drRS?=
 =?us-ascii?Q?68z3C1qmkNeeLcigf5uAFo/C7qpMmhGliyJ3hHls6wSK7Jgr982wzleyNrxr?=
 =?us-ascii?Q?8Jb9N9Y4ykVgTS7XzeMYqdoO+cse8pczIjZUG5fk0DWmyheAN5AjzWTyutTd?=
 =?us-ascii?Q?z9qqaYEFz6XH5NiOm1sIwoYPTv07gtMgsJtC6CgOdYsESV5tFHL686Q0Wqim?=
 =?us-ascii?Q?JVZ0Fes8CfL+R09dNvn2YhveTf2mGRem5V9GxYDze0g8pUqIUbHWCqR9LuUn?=
 =?us-ascii?Q?2+xMlY5tbL1Nik6O6SH20TsGZuvaoAAyLyu8AXBxB6IIQ8Q+nyftdZCG1FGC?=
 =?us-ascii?Q?xtyokhhLH4TJ4Z5d6kCCBsaWvj8SEtAkm6zLlMjzPlNhTVKTlQJmZRpoRuxJ?=
 =?us-ascii?Q?/k/5pMnw4zz8cAaexk6NDIN2ODAo6E7F7SnVENoKUVU8wh32uUaDvvPR/bmu?=
 =?us-ascii?Q?D/pF3a96aortY7TxrdF4bdSKdbb50FNy/etmIkaxCuSTXSHefnNFaFcQCmlD?=
 =?us-ascii?Q?eWVN1kKndiRtsdXoR/jhKnIo1awzO4ZAQD3ybWCCp+woMu0pJWqx9XTvH7th?=
 =?us-ascii?Q?blzUgP+tg/BWGeckatsODL9cJ/LDrlb1TSYZ3xvrRsoZcFfZdXCangV3rQa6?=
 =?us-ascii?Q?cY05dfhCaXszf/iIFsRxzXkRmf10IJ6Fjo2gfB5itj7BRTQSJgiKdjlaWwls?=
 =?us-ascii?Q?Of+FQNif487UQJUs0A8NQnBz8nhHS+F3sJUrcWAVgM0wBQu4mx9LWYbG7eOU?=
 =?us-ascii?Q?grLUyhlEJ51m+KWHryrM9ZfXXmHteuOGiWKC3q0N9LLTWu0sb9ikxRXI5p4G?=
 =?us-ascii?Q?/J9FpWO8fRIFjRuK8u106hVeYADCSrjHbihtMIj/Ze6Gyr+UlMrK4SHtoPWn?=
 =?us-ascii?Q?ygwGMHQbapbf9A5CZ8BNy0oJmuU9aUE4ctRaVS2j7cuoc+s3KLwh8U1Zb+wC?=
 =?us-ascii?Q?L826eevatECGnGEagRvPcPlkqmEAAulFTGtX6YqnXNer822KothrEKHCmN72?=
 =?us-ascii?Q?58V72smnz017hh5MFz0gMuj7Cq/z8xbpjvLLtwC8PJeqocZAJBC6Jke8izZb?=
 =?us-ascii?Q?L/BMjkSQYW9s2H+vP6Q9suN+n0dzES2BMJyEM8YlhBPCxFyN7WbKySV7yEih?=
 =?us-ascii?Q?YkfWhkanBNyCN0YNsNYLD4bhj6aQSIcKT+OsEz4wm5sGgx4VlJ7nW9oRnoPJ?=
 =?us-ascii?Q?NUKWN42UO+U/5MRWrBjG+LvvXZgse/yLfoCg2+D/KjFlgVPBGUKk69Ed7dz6?=
 =?us-ascii?Q?pKt55PNTwbN+OEIbM6rpQvbWSUIytUgn19Crk4r9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb29d3d3-8a16-4eea-8fc8-08dc44c101c8
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 07:24:53.1486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g8qU3kc1ZPf7ALA7O2hWVAsQh9fGjYfsFZgCsPkHFW4YUgXrEkIW9mH70O7SzBCmIMOehwk2d8zI5uQ0b0bHkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8332

Enable 2 USB nodes and add 2 PTN5150 nodes on i.MX8ULP evk board.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v2:
 - fix format as suggusted by Fabio
 - add PTN5150 nodes
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
 - no changes
---
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts | 84 +++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
index 69dd8e31027c..bf418af31039 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
@@ -133,6 +133,64 @@ pcal6408: gpio@21 {
 		gpio-controller;
 		#gpio-cells = <2>;
 	};
+
+	ptn5150_1: typec@1d {
+		compatible = "nxp,ptn5150";
+		reg = <0x1d>;
+		int-gpios = <&gpiof 3 IRQ_TYPE_EDGE_FALLING>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_typec1>;
+		status = "disabled";
+	};
+
+	ptn5150_2: typec@3d {
+		compatible = "nxp,ptn5150";
+		reg = <0x3d>;
+		int-gpios = <&gpiof 5 IRQ_TYPE_EDGE_FALLING>;
+			pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_typec2>;
+		status = "disabled";
+	};
+};
+
+&usbotg1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb1>;
+	dr_mode = "otg";
+	hnp-disable;
+	srp-disable;
+	adp-disable;
+	over-current-active-low;
+	status = "okay";
+};
+
+&usbphy1 {
+	fsl,tx-d-cal = <110>;
+	status = "okay";
+};
+
+&usbmisc1 {
+	status = "okay";
+};
+
+&usbotg2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb2>;
+	dr_mode = "otg";
+	hnp-disable;
+	srp-disable;
+	adp-disable;
+	over-current-active-low;
+	status = "okay";
+};
+
+&usbphy2 {
+	fsl,tx-d-cal = <110>;
+	status = "okay";
+};
+
+&usbmisc2 {
+	status = "okay";
 };
 
 &usdhc0 {
@@ -224,6 +282,32 @@ MX8ULP_PAD_PTE13__LPI2C7_SDA	0x20
 		>;
 	};
 
+	pinctrl_typec1: typec1grp {
+		fsl,pins = <
+			MX8ULP_PAD_PTF3__PTF3           0x3
+		>;
+	};
+
+	pinctrl_typec2: typec2grp {
+		fsl,pins = <
+			MX8ULP_PAD_PTF5__PTF5           0x3
+		>;
+	};
+
+	pinctrl_usb1: usb1grp {
+		fsl,pins = <
+			MX8ULP_PAD_PTF2__USB0_ID	0x10003
+			MX8ULP_PAD_PTF4__USB0_OC	0x10003
+		>;
+	};
+
+	pinctrl_usb2: usb2grp {
+		fsl,pins = <
+			MX8ULP_PAD_PTD23__USB1_ID	0x10003
+			MX8ULP_PAD_PTF6__USB1_OC	0x10003
+		>;
+	};
+
 	pinctrl_usdhc0: usdhc0grp {
 		fsl,pins = <
 			MX8ULP_PAD_PTD1__SDHC0_CMD	0x3
-- 
2.34.1


