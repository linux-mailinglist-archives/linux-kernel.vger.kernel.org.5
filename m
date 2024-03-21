Return-Path: <linux-kernel+bounces-109772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D71FB885584
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FDA61F20FB6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39ABF79DDD;
	Thu, 21 Mar 2024 08:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IL+l6nqz"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2045.outbound.protection.outlook.com [40.107.21.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7295279DAB;
	Thu, 21 Mar 2024 08:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711008916; cv=fail; b=gwzMRQE6CWHqlczcVmi34lnpHkBKe5acwM1XkwUFGYt9FSr8WWCFAJh5C/fCLGjOuJ2k48/56LLpqT8QLSZ/69shv98jrf7dDOxo2U7XHeK9lihNuLaBERGe1kmjhl21hUUPrMzeMx75voeDX0eO+pYm+qms9zAxX8g1IO3sUDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711008916; c=relaxed/simple;
	bh=7c1NqT2qP6FX9Izn0sJ3JIxQQm1H7bAxh7a0+r4SiP0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rBg+kC4ucr158gmIsgEZJGJGrnLwRcB6K4DfTguottJiDzkISkCF83IZSOpZcyNJP4mA/gC7oJ+wnZG/kecV0H4VBRnceGqZmBOJ2NY+1KedL1atsrhRsMs9Ja9lV2ImpJMicvpjgvrXhR2yISc7JCZDEPXQSTtir1nrvKNHwfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=IL+l6nqz; arc=fail smtp.client-ip=40.107.21.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZWBT/xuijGE/KbqQ9NL21U6a30aInpZTM3FhWyDknnS7o/gHsOJvq3hDkf1/d4kA2K499OaoU3i+NmkyjCpBhCt9V/Ev3EGE2BYBD5WsILqrw/U7A+ozSXQ26vkIdcno6bw20A4HD6fW6yQOTBWMiGXg0IhQ2S5pqj7m5ATQ9S4NUThLuQOQkUhsAeugLHf7eN3iIxsuGDN7GzTlpig09E+9HPQ0vl5eQMXzicEqmtFNSg3Ku/dwAlnqAnGJUeNourUrsz7S2rie84zDO28qlAFQW3psyUMxJiLKMlyxVZpfDnpxGDPRztqWqo5iQd1bSQHg1Jl3cRA5LMGoIskeSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pG0qlEMSEOmcRC9a9Jw7LGTbB+CaauetehWKf0sB9pA=;
 b=nen8GJHZw7VtHKdd1nIp+hZuxNkFcnFDVkZlZ468QruJt+yKgJBxX5+EoE6Vz9OkXkFjEdYAbUXY6KezFb1GcBLaS1hQZc8ewi5Mchdv/QuMeKA5KyaiSp5FjUYIOhTAC9jJupgrSaOilfs8ny0omAL+ZXJQWxmVbsHUh//fNk+qDRZCkKzYBhwufKXYRltAgikp8ONzp+uxIABwRg0N4iCHp0sofQ27J5AyGV6U6PzYf4o4fxmPixlS101oWJFQtyfkYVwg0Pd0P5gD5qYqeDaa9Z8vCbzTk3+jeAinyu91UeAYHKi2z5UWsPIrMTXxPfrbzOIHp2GjN3Afm3d8Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pG0qlEMSEOmcRC9a9Jw7LGTbB+CaauetehWKf0sB9pA=;
 b=IL+l6nqzb6O8AtOIuNOuiMP4Sq5mm8/r6y8ymfk9Uz0BZdMziUFFqf25Sns9wHb1x7u+d9FIzvvs4sK+ddYnijddrUmv9icJov7rJfYasjMHL2mSxNR9xKBNY2EJTCcij87PyrC0oJKv7Qk9rIW9Schcz1ujEHMoz/cbW1N70l4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS8PR04MB9191.eurprd04.prod.outlook.com (2603:10a6:20b:44e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Thu, 21 Mar
 2024 08:15:12 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7386.023; Thu, 21 Mar 2024
 08:15:11 +0000
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
Subject: [PATCH v10 10/11] arm64: dts: imx8m* remove clock-names property from usb controller node
Date: Thu, 21 Mar 2024 16:14:38 +0800
Message-Id: <20240321081439.541799-10-xu.yang_2@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: c62b52ed-af14-4658-cb64-08dc497f078a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	M/7WPOPSeC4o5OvJsUYF+L6KStQ+Osq4wmY7v3Mka4/rdXwTLKDdoRy9yP6saW9WleG138q3vbgZHSzvSRwpUByaGgQLi2IWFoVfL6J9ycE8iqr+ExhXT/3AtK/kYAH9AMa6FpdNc53nr6sJsClddMMZBPYhJB+ft83mVnDXNODnZF1s5lMQVYIT4pUwn0bTXgZoVbk9tKTPCLBHSo6NvGBv+Uu3X8a7i+AlAT8H4Ss59dDj94sToAcRANfqNTeXHg6V2lbtNN98rIZtqsR+NYBNB2uNSPT99Fn+Bf5QHSTtS1q5a0iVtSW7DDP247ruBjDhsE3u8TWE3YNPPpCqx1sdXuf0uboXp9eRP51cwBvKst2HDJdRhWXPvb8EE7V5T91cEmm/mgl872IsPIOwElt6vQn7R+Deu2Q/Fkzg9CfOClQDkZy7CRMooFhO/ef2uMyodDx1MUXMBwjlaCt4VbFpMTdXyxRuidhVxHmFoXROF1qCsyUSSrGv7yMVTQ3WoeyGPumXhnjiNPm5ReOhBrShpWJSxTz2K73KusOBf/tL7QNATXNfQk5LsWcmNHt1+QXYuuxtmSZXop6qW5biVBAMNmPe0IVrad+4XXGuHDU7Thiic6Rulzab6PdY1c86/5c6YWTzR+iqjpR23ejr8onFIBw+K/9AtdUItCGd3cpmROS6v+wfGvbTq9DIQVnPmMdcraAEIoM/QCEJSLD0VC50pHpwB8SkfDbrJwzA16k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(7416005)(366007)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3Q4wL0EFx3eLKRdMuLNw9jo+3Lz4silMh2bg8dWNWQEolcq8tZyJodypIDkb?=
 =?us-ascii?Q?80OoJRDg6jmOQRa8ZE2roTajklmIqhH3l6odOe5VLhmmklKXGCgmaae0XgG3?=
 =?us-ascii?Q?IjnS1NGPoMnuPE50Y4lpFzeP3qVQHH2tr4EGN77MauTsBWtkcZibAAfIheOT?=
 =?us-ascii?Q?9Hvwmcju1H9jREnU9voCNRhvimTcoCcdgRBwhvndEhSMGH6e1ahrM1Pyb389?=
 =?us-ascii?Q?WHgC0Z8mtbYPa1GK3U8SzS09jkg5uw0zE6l1xfCOmjhqiGvIE1CAOPDiQr3+?=
 =?us-ascii?Q?77YfWDss/2/prffKngpq70/JaAsdjsMCIKKLe3+PBJ4PwMOja5S1R+U7Vyci?=
 =?us-ascii?Q?7eCO1kU2pLypVLlSdrGSsbFqyQ+WSF8dIbgmzFVTuhrsFpCTwMDAGOqhgXVz?=
 =?us-ascii?Q?54lPBLskZO9B4aQWsksyPnz/iz9Vn4puiKBn15U4hUfi1IXy/BB7zEZBmzaq?=
 =?us-ascii?Q?Yc1bRkaxra/lNmPDDVuLS8auBHEfqSU/h9JuKB3XJxLJsE4VsG0NOzPL5EnB?=
 =?us-ascii?Q?sfAJYUcDMwwcnS7Tv8HrUAMiDp+/3uz0uu8H5h3V3TPa042sTT1YQPJmdp8g?=
 =?us-ascii?Q?nPDj0doNoHAXTaje/VM6IWPoJOEH1od1yEvfDzlL1YkcVYoMKkTb6keBjqjN?=
 =?us-ascii?Q?O5Mk915OF6lVyPzxe8vgoFR3DfAmI1wnFr/8Rboo3DP8OnMTkesJOgmS8fBW?=
 =?us-ascii?Q?WbRC0xLaNiVlJL85PIS95l0cZOrZsekPtTNk5EZoUUwZtXqmQtU0+ZUnzqJa?=
 =?us-ascii?Q?dvy8mHdemSooq9AVbdWWRYTsKAXN+Kvm0jvvP+bI5eC78utoA3UJC/PTEH6h?=
 =?us-ascii?Q?Ebc0rfNLzFyEWhoJ8+IrSLxZhDzLF2npja9Xk84ZX6Ai2Mf6blwrmIcWkc4p?=
 =?us-ascii?Q?CxHT4RJSQKy2IW46CcEUvRSgMsIuo62pY8QurFEwHT6lkSzLOdkxMlGS0qxQ?=
 =?us-ascii?Q?kiXnAB1BEYKaSwpFSAU+13CMGsHQIJJikFhsjVsGsXGlvgvzc5iYWlCLchBe?=
 =?us-ascii?Q?exRXVLdkvDKhiXKB9YYF6i/8W4FOUQ0huXV+soefX5kfwi36OMpPKNYGutth?=
 =?us-ascii?Q?5o1QRE+vJkWRlYzYEC3hg2w1y2LYwvNq5X+zyZvDJWX2eZ6/0STG1jJiil7i?=
 =?us-ascii?Q?tNSPYBus8yYIDiswwOjB39dChHHQXn6FtStEItSknd3v65oFauXJV2R9kgSs?=
 =?us-ascii?Q?ZggOJqtE3e1Y872iBz/LIxAsEdzX/UGnEODy6Kg+IGhazehA/MwiCjUDhwyg?=
 =?us-ascii?Q?dLeTwJBHBeFoHkGZLwAaFUIatvR6203wiuwJmOeMXlmYmEIp9o9MjmRh/vtz?=
 =?us-ascii?Q?u01I8tCHV8q9/YSumMLZWLt+ZZ63nNvuqEYmCzGedMAX2AMXkE5HowW3NLYp?=
 =?us-ascii?Q?gnRVekot5wD8wMc+oU+du7lVvpvDaYRHAmVBIVy7h2fFGY8PB8P6Vs1sqr0b?=
 =?us-ascii?Q?u2/StKAi2DSqyAHid2/8lfRbMhyaBoOZ58V9NvOWumIy1d8iDFxJsVd2uDjG?=
 =?us-ascii?Q?Ts/7dqWmuK6OygcWjiGNQm65grVMmzPQWCIk7spG6y6kNRKN2g8fQCPqx8qA?=
 =?us-ascii?Q?uYb6WnMrut29KYJg90wp3frzIbd742TG77UWiIKn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c62b52ed-af14-4658-cb64-08dc497f078a
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 08:15:11.8719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u2HfenfNIR3Vl0yEaV4+NHCjcT7pNe8lrL5pVZya4DlEGm3htlBC5MULlX5JhVsqVwUdFc1/0rcx5wGuV23ZzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9191

The clock-names property is not needed by usb controller node on imx8mm/n.
This will remove it.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v9:
 - new patch
Changes in v10:
 - no changes
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 2 --
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 1 -
 2 files changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 8a1b42b94dce..696e96b15585 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -1253,7 +1253,6 @@ usbotg1: usb@32e40000 {
 				reg = <0x32e40000 0x200>;
 				interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX8MM_CLK_USB1_CTRL_ROOT>;
-				clock-names = "usb1_ctrl_root_clk";
 				assigned-clocks = <&clk IMX8MM_CLK_USB_BUS>;
 				assigned-clock-parents = <&clk IMX8MM_SYS_PLL2_500M>;
 				phys = <&usbphynop1>;
@@ -1274,7 +1273,6 @@ usbotg2: usb@32e50000 {
 				reg = <0x32e50000 0x200>;
 				interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX8MM_CLK_USB1_CTRL_ROOT>;
-				clock-names = "usb1_ctrl_root_clk";
 				assigned-clocks = <&clk IMX8MM_CLK_USB_BUS>;
 				assigned-clock-parents = <&clk IMX8MM_SYS_PLL2_500M>;
 				phys = <&usbphynop2>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index 136e75c51251..f67816758b21 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -1213,7 +1213,6 @@ usbotg1: usb@32e40000 {
 				reg = <0x32e40000 0x200>;
 				interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX8MN_CLK_USB1_CTRL_ROOT>;
-				clock-names = "usb1_ctrl_root_clk";
 				assigned-clocks = <&clk IMX8MN_CLK_USB_BUS>;
 				assigned-clock-parents = <&clk IMX8MN_SYS_PLL2_500M>;
 				phys = <&usbphynop1>;
-- 
2.34.1


