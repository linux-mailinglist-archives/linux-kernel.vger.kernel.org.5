Return-Path: <linux-kernel+bounces-129387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEAF8969F6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90C1E1C23209
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B7C7E0E5;
	Wed,  3 Apr 2024 09:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XB109Sn0"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2139.outbound.protection.outlook.com [40.107.247.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF19B7A15C;
	Wed,  3 Apr 2024 09:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712135076; cv=fail; b=Q8P7JtB4DMjnTlhejg7gonFWek6X+2LdwFg7g1Uacs1jg0X2xtDC4/KVneS6jQEMlAXMdlLC/W6bHWkqfO0KqmIB75jNp7JPboMDN4V1ZqelGNhFtMCCnUYvJLwIAPFKn/lBmiHK5Gn5qSgaMqyPZbQWTZZn3lntJ9msNoZffM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712135076; c=relaxed/simple;
	bh=jRQ8peKDZdjN6OANph4ZA0J4XROMrHYV0jy3CW2lTd8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JltNDZSuWMDEyMUN/htU8HUIU5CeGrHaf5FqVvy5tcFSdW1S+pMqThJm/sJliNIiveSyIOpkfeGhFmPrc+aczVpNb+E5ayQvm/BV6JvBQyKGa+odTz7d1Nvnuox8VoHBFPHLtOuwOkaWga4vs0Wdv2zb+YOh6zm5D4cvMe/KpG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=XB109Sn0; arc=fail smtp.client-ip=40.107.247.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AJl1iDVsUXs+c99YQcCR7Ne+jArAuPbK2yEL2AwOu/nCHs5vdc9sY9NAPb5ls4NFSXrtAaagJv0o6TVOEl1ps3IVqoNxUAcz3/AEjN9iSP8l2Y+9cQgJeYJAJHJvDbPiCCm6k6/hNuiEhPSCCeFY+NCmtDQMXc0iWI3oxzEii1Xbm6I3rFD2o9qTR7YdklhZNio+FPn8NFNy4mgvgfV9qIThawhoVvceDBQNMzTuT/vDGAkBZ5UvIAlwuUYhCQPaqHvouQFe5FYX5YgrUn1vk+VBJs9xkUpdkO0yLy6IhmdCjoHZeuyTUuQL1su2rNrPcEQ3pi5PkoJCSD+2kGwWng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z7t54zBF8z6qRoLk4QldhE9ihVK84l/DV5cMv3wboBw=;
 b=Rw5LlLOk63jlpTinsXPekw71zwClL8RRyMnejkV3wAVL6Ymeyfdov8oOW7I/2Ik6xb5L9rLCzX14T+5umaplN8+WQlXNuLQcxAPxOaSX5lJwCC0ledqdfRdoHNByRxChi8ZKG2rbTWZbSsa9yvTUhPQU0njyGC9LFePDRDuYBtdNq21Iupdlv2j4/S7qsB5+2053c04difA7Jz4aNSP13He2qQb0iz58TFt/1u18oR46P3qTwjjW2aD/dOqHpeQ8YPOE3ssPXSaxpPdlufP1f6bEy8ikSJqa2TeRcPlMDeW76hQok4kl/BmbV/QMl5ic4/pjlP/N0OffKfFFHQ7nVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7t54zBF8z6qRoLk4QldhE9ihVK84l/DV5cMv3wboBw=;
 b=XB109Sn0XM0ubfCWoXm2WrNWrg9LMHIzcertNODI9zHnnFbDue5OVKEvyIKDP9D54UOpRlcEqSE+nl6bd42x4lvpd7Vt6RA8BCfoCpJkfmx5kR5nzFnjsxe7lDvfvLhMSsIhRgjo/8tTM32d404jnoMUpB3pSGyOH+75iUXV1AY=
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS8PR04MB8216.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 09:04:31 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f%5]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 09:04:31 +0000
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
Subject: [PATCH v11 5/7] arm64: dts: imx93: add usb nodes
Date: Wed,  3 Apr 2024 17:04:36 +0800
Message-Id: <20240403090438.583326-5-xu.yang_2@nxp.com>
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
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AS8PR04MB8216:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	L92aX6ULznmyJ0aFawMx6xt41UWknucclNctgHM+tSIIfkApZ9/13CFD7D7/j2FjQZzJ4Mf5Wim5wycSosqRgbYUjhdvdp9Q21Z3/pgxglpl6p2vcr3hx2+rBlIR5Qq4NskgPtiB9iqdFRvPBGoKS+d5yNzrb3UMMvG42LkyaJKDmM1AaCWHzj5ify6QJ4gmStg9+Ogn0/o+joN1yzy6AS0/eVltnQEzst0GJ5WSyw7OzbQPtTzuKTmb7KS3UTO2L0wI8K49EDYmA9Fkq35cdcC5jffO8aCuJylnKjVNVGD+5yjsTNI7XPSHVTOdUWRqKReqRrQJhy2q8zwXBw4dItiu2M6vX6nQ6QhDQ+D39NjUJETvCSj2eWwU4w9GAyKPu3jrIpqlFmvoRjz9fR1j6xXOevebpwMlZPOviwchRdWF9DJ7fThRz6+Ywr6GNWUWp/MXOsXhYUvXC/bXP2WO1L0PEc+AV7venWf7crUAfIjmkViqfceB3e/lNpaEo+yC3ZSQrIrNYNdCIhALY+2HlcPfuN4dfHghd6lkj/JkiV+02YxB+6DKT1UZ8wcbGXZehKTYncQ7sFrPu8im7vOaxb2afvr3SFNVFvyT5CJzz3tLLWHRqNxepIR+8Bn8ji2ZPe9CD39o6vm9sZqV6CY15j1oQQPaV+j/urdVYLpnZNkKLOYSToeCBgSzXozVaGSCJxyXyAHNxRLhwU6Neo8uEAd/it9quPXSmI0ojf8OHvY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(7416005)(366007)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NcF6jWYCQmyQFAw2GfYVoA46+vteq9bMT7wqv4uq3DhPyUcAEeZLuD/1Qhkp?=
 =?us-ascii?Q?MgRIXrCHF4blKh37XViJI9t2ozEfYsONEuhmyLOSs9yYUxo2uKHnBMhaNfu+?=
 =?us-ascii?Q?sbK/3cKKFPO0pCqX/vIyL5uxhIi/fZa9fQqffUKcaoO7pgbgBXcak4J1iwYe?=
 =?us-ascii?Q?x535HibFt6fRk0uzL8aJS7UVCaR6+TezF3akvG6hNKe6UJTAoRb5v+jTKYQv?=
 =?us-ascii?Q?33Qse3Wmoq7VYhCnM+CG1/SiuaCRuh+32qAGeYllAPRE4Ja4aXalu4Kl6J41?=
 =?us-ascii?Q?6GvmhKoDTnrlTlvXYpp6XAjsoNmJbimMz2vyZohXsRUBq8kMdNv4BMhHpEhs?=
 =?us-ascii?Q?+l2R6oaxbRhSknfJuJhC7z7t74WSCfkOM8wOgrxoKsebiybc4fOJjUH396+p?=
 =?us-ascii?Q?zlFMSSnRd2xDdXbSDcuWEd7cJYwQqrFtpXWxR8Y2CtrSafoEVevE+q/aSeq+?=
 =?us-ascii?Q?WO6oJUkPICFCI8JP/vUiWy1YoxGPV23l94vxny7t6uX2ckgIZY2KUz7ruaxr?=
 =?us-ascii?Q?1UobKcIzPs0ZN+MjaSP99WrEesVD0yq6ZVLXwv7hz1Nmy6YcsjzOmGXOR9Nd?=
 =?us-ascii?Q?XFItCLvkKCM4rJK05tebU+nbCPpxuwdKXdG8zPyy6jo1E1hquBiq5qrBjUdG?=
 =?us-ascii?Q?SpL98PhjQZ9t39/fYynpyr+cAWw0s3dz6KrKvf9Se5CbSV92u9ZDFTgzidMd?=
 =?us-ascii?Q?sdhy8McUfkwMWDuQWYUYVBHETJp1qVKJNVQBq1yWGKzIzWYxe3aEhElaS9zd?=
 =?us-ascii?Q?GkRdsTI1bu1cERQz2wjaOCR8RDwujIloy59qWHhfGe6xvl8JmNdWRa3UhwwO?=
 =?us-ascii?Q?D3m+0NHgoFA2zEbn0B9P7P2mTRPcSEdaD3EXeOa6gnBCwvfLh6JmNeR6KLg0?=
 =?us-ascii?Q?0wjfhBTsDLt8QZBUvixmSd8Kx4jDZeB3k8kwbdJIzTshIdqvD+TsT+ihRd+s?=
 =?us-ascii?Q?k6HQhvJryzn4TE/wWniHBkdwpxYCPpys1jOpyUgfLc/zk5pkuxJExnOf8L+h?=
 =?us-ascii?Q?DDlr1Qo+qtKKgwVB7y85wm5Nh6jYoFSBFbxxM0ZyShNOHkrzWlI2rTal76S8?=
 =?us-ascii?Q?J4BHkpXc+P5YPuOukWEP04Fkf0m1enGfLq00BsvDF/lWTrHxzYGeLYrS+9Ox?=
 =?us-ascii?Q?boK1kK31Qb3BlweCo2A85pzvBYjhk4UYaxE+HD8E5k9rF96c8HuVm7S0Dctx?=
 =?us-ascii?Q?NUEetaXueCJ5HMODhx4iOTBEU6bT0P/07OptpCOSZS2uZjSShlLcORK652pQ?=
 =?us-ascii?Q?3FCIdJowg4IkwDrsweuDqniTVY01r1UBIzUNWvGyA9UzJXc/HSlCfAa97HiQ?=
 =?us-ascii?Q?LmxFaApr/W3SXbY16wB8P2uOA92tjpM4T3QmkfPxm/vvbgLXGmFz4MCZJYyc?=
 =?us-ascii?Q?xG8W/gIlci0Ns74q7krWUbBwSd7kfECUnRr/7qsJoHb5UcX+Qnf+3HUHpmIe?=
 =?us-ascii?Q?XY/1+5mbzpQKLO3YZOuXuP3oT1nDe9PC2db1XFPD3Rci/Mj7mr+bcmiGEPMz?=
 =?us-ascii?Q?hBwOBUTQNVrmcAi4jYNIE7hPSxSv0XZ39kFuaG9ncTSsQslhygerzvlxKGjf?=
 =?us-ascii?Q?R52yTAFDlo4uNsy8p6RgeKOlqh4h9RktTUSbiRdg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b12cc39c-be53-40b5-be94-08dc53bd12bb
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 09:04:31.1185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 00iMqp53pKVEDwmzy195K/n5ZUgdvSjaXnM0meKMgC3wJttpbZZygR24f2GqSBSR0SimTL4+YdtZn9m4TJI4UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8216

There are 2 USB controllers on i.MX93. Add them.

Acked-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com> # TQMa9352LA/CA
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v2:
 - fix format as suggested by Alexander
 - change compatible from fsl,imx8mm-usb to fsl,imx93-usb
Changes in v3:
 - replace deprecated fsl,usbphy with phys as suggested by Alexander
 - reorder nodes
Changes in v4:
 - fix the alignment
Changes in v5:
 - rename usb_wakeup_clk to usb_wakeup
Changes in v6:
 - rename usb_ctrl_root_clk to usb_ctrl_root
Changes in v7:
 - no changes
Changes in v8:
 - no changes
Changes in v9:
 - no changes
Changes in v10:
 - no changes
Changes in v11:
 - no changes
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 58 ++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 601c94e1fac8..77b3009b048e 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -183,6 +183,20 @@ mqs2: mqs2 {
 		status = "disabled";
 	};
 
+	usbphynop1: usbphynop1 {
+		compatible = "usb-nop-xceiv";
+		#phy-cells = <0>;
+		clocks = <&clk IMX93_CLK_USB_PHY_BURUNIN>;
+		clock-names = "main_clk";
+	};
+
+	usbphynop2: usbphynop2 {
+		compatible = "usb-nop-xceiv";
+		#phy-cells = <0>;
+		clocks = <&clk IMX93_CLK_USB_PHY_BURUNIN>;
+		clock-names = "main_clk";
+	};
+
 	soc@0 {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -1167,6 +1181,50 @@ media_blk_ctrl: system-controller@4ac10000 {
 			status = "disabled";
 		};
 
+		usbotg1: usb@4c100000 {
+			compatible = "fsl,imx93-usb", "fsl,imx7d-usb", "fsl,imx27-usb";
+			reg = <0x4c100000 0x200>;
+			interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk IMX93_CLK_USB_CONTROLLER_GATE>,
+				 <&clk IMX93_CLK_HSIO_32K_GATE>;
+			clock-names = "usb_ctrl_root", "usb_wakeup";
+			assigned-clocks = <&clk IMX93_CLK_HSIO>;
+			assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>;
+			assigned-clock-rates = <133000000>;
+			phys = <&usbphynop1>;
+			fsl,usbmisc = <&usbmisc1 0>;
+			status = "disabled";
+		};
+
+		usbmisc1: usbmisc@4c100200 {
+			compatible = "fsl,imx8mm-usbmisc", "fsl,imx7d-usbmisc",
+				     "fsl,imx6q-usbmisc";
+			reg = <0x4c100200 0x200>;
+			#index-cells = <1>;
+		};
+
+		usbotg2: usb@4c200000 {
+			compatible = "fsl,imx93-usb", "fsl,imx7d-usb", "fsl,imx27-usb";
+			reg = <0x4c200000 0x200>;
+			interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk IMX93_CLK_USB_CONTROLLER_GATE>,
+				 <&clk IMX93_CLK_HSIO_32K_GATE>;
+			clock-names = "usb_ctrl_root", "usb_wakeup";
+			assigned-clocks = <&clk IMX93_CLK_HSIO>;
+			assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>;
+			assigned-clock-rates = <133000000>;
+			phys = <&usbphynop2>;
+			fsl,usbmisc = <&usbmisc2 0>;
+			status = "disabled";
+		};
+
+		usbmisc2: usbmisc@4c200200 {
+			compatible = "fsl,imx8mm-usbmisc", "fsl,imx7d-usbmisc",
+				     "fsl,imx6q-usbmisc";
+			reg = <0x4c200200 0x200>;
+			#index-cells = <1>;
+		};
+
 		ddr-pmu@4e300dc0 {
 			compatible = "fsl,imx93-ddr-pmu";
 			reg = <0x4e300dc0 0x200>;
-- 
2.34.1


