Return-Path: <linux-kernel+bounces-109770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1DF88557C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 903E828198E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49A179B91;
	Thu, 21 Mar 2024 08:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gCpuwP8C"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2049.outbound.protection.outlook.com [40.107.8.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF58A79B7E;
	Thu, 21 Mar 2024 08:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711008906; cv=fail; b=sG2Ky4V8OnU5vO+LB20XWOEXW2tyvxg1AU57cSQlEMFP6Vk0pTMg8FX1iVmKiHC9cL4QF/OB1swsEVY5K+7uQLYjN8njQ2YgXD5FDlaA0EI2K+A/L6yXNUWxda0/MxhmecBLTuz1NfY9w1JXDPvh3A/4L52thjXVl2Nb5RFX/mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711008906; c=relaxed/simple;
	bh=CLBT9WXLucH4usShiSy7Zb7fSeuONUMgyzhuonBNv18=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gteJjDi89wzwHApgkvaepp2RGqfzjqzdmtYkI9ODjObj3XmwA60tWNNQ1M+EdVQS4f22JyjzUsQlJsjQSv3MKT5xiKreRHXoqYXJHwgBAJ7lgj0rnDDDuZOgcapn4BG1thcF3umXla8ZYdqFOo17Owutte26SsiofXuXEHHeRMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=gCpuwP8C; arc=fail smtp.client-ip=40.107.8.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KtSsKaBkUydFBFcvcOY5sR0OAB20mk5Awq3KWVRHSInhXbCF8KmDV+3fYQDvRf/Ek8UP6YQ+By31KZhGMAK5ftgEvf1CgznFELUspcI2zdvjva88zr0EDjw34PZplbI8pM2quI1zPqCGfKCvN6mGu29Lxqyc7J5jyBT9P+qkLIbKHmViUFbr4EqWJdwDhz6JB6yy8mtdo5Cmnx6Z/BDylNY/W/IF9uaKTpDz5tLn4PVj0vOR4n8AY6Djz7rcs32X9MScpjJf6oeUDPX1P0Rksh861S1l4aNBlVp4bG6d8zptO5MU5OKlcagzCkEoXm9PZrdrx1nyo5D1787M1lso8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DyaFjk4ORhLue+UMhi/1xvr1aXaGp8ppDKrS2iT3QcU=;
 b=bHfYi1bInewhN9tE136geiWlkNLP3qwavIjsteeYr8TxZ4acai7F8Q02f9SRM+5PKIApRLJJHPF/loNyToqJFB9cauwUHbGISYY20YvnPZydz/nS7E3f9T4aWRLIgV8VmAHI5oYqVyVkAriD9gPwmTHy4SOVkeyhcnb0lpPzTPI5AQx/QNqv+pApJ/qud0sW1yD2oJbsAdh3U830CRbjDDICxZfZ2vcdtmuSG9aYAiihHDZmyWlLPBEf230dmx8tvdef01fAW4RyppKRkxZT+S4srDGhtn1xZszJsNRbDZGpz+LgjD5EPO7mWr2/KJltZ8H8ZvpQ5SLRFCOMSe8CpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DyaFjk4ORhLue+UMhi/1xvr1aXaGp8ppDKrS2iT3QcU=;
 b=gCpuwP8CB2ZJVyP8/DwSntldQXUa+3P4XgyMWDcWWE8JgVwFMLlr/HvjSTnvKbWpReT2qBzS8/ZYSGAv2sVYGIu+BKywTpM6YqmmtDP9/dvYjuQEeYRg8liRIBidDcy8BdvmBeQv23+B+uy0MSdgw4OPQP5Av+QIxFv3JclI4Ak=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS8PR04MB9191.eurprd04.prod.outlook.com (2603:10a6:20b:44e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Thu, 21 Mar
 2024 08:15:01 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7386.023; Thu, 21 Mar 2024
 08:15:01 +0000
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
Subject: [PATCH v10 08/11] arm64: dts: imx93: add usb nodes
Date: Thu, 21 Mar 2024 16:14:36 +0800
Message-Id: <20240321081439.541799-8-xu.yang_2@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: a0606714-29ca-424a-eecd-08dc497f0174
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1SvixgA+iLkBosWP2K08T76cbEP7kF8up0XH3OOL1oaEqM+L+j2qBO4uwUZ2/pIenXezTfacblyZLDT1VxjIAfRts37iLndDo1ZMZksVdEmQMWYZ2SPh0WNicDUIo0+caO04ega4kI9IqB9s3F/YJ7ot+hxiTaUdQKUq5N5OJsZRc5xVL/7GAEnK36ou4AU1ssozf5gcvLn+MgYKinVoHO0tzmrguagaiYnu2h3UInajwumPTmOFYXeLQwbJQzfYJOUH0g4rsz4QShIhRmZ13+3F9J7jB4YKOOPJQg33DQu8UlGAGjQDOYOyaLsxAysDi1dhGzvBOhi3NGW169FfiLWV94SkOKIZq9tBKcPmD+HWAzXisoqt6RwcgdPjhAOvVN5wc0v4lhjqSzFOTJI/aQSTJiP1E1jzEOTbUF8q7NYLiE5dl/CTwLavJDkyLBFIH9wrIxf5/j5RJUUy9TgF2mnsneWtYh1uXgLnUzamb4OO5UiNmgoWLNR6cSnDgZdRg/iwd9aE8q/jsB1Cex7QF3xn7FwTgPq/C3NeWvcrUhPGc1S/lvne6/KyGgZlR5IYBMWXdRD2hjeObsQIWVSZwEHreqjb9ua/Jm5Y7kABgelMuMfGzwv9xh71O8ptvk0GDxBXvI7bbgVZb+12teT28Wqh9FuHIdyizhaCYe1+LG8HP9avoEO/UJ6k6AOw1Q40nbiC2OpGYi81IxQsRrWw01gF2ZpC6x0JLVWjW7MY8pQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(7416005)(366007)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jpjd5/ZJ5HW2/yPt/WXe42RgM9FoOx5c+5PnBF70lB7BHB+3cTIIDeoVRhtr?=
 =?us-ascii?Q?m4R6EplSfGMj/FofaIDojrHU3XMo2uXP9lix2gHKQzeaSSm7yKhet/Wj35CF?=
 =?us-ascii?Q?4s6Krfl+N59dgUPHXVgNPFqaz/2xEOaOYWE+zAvxIPrzlvRzkNR7pM6WNe23?=
 =?us-ascii?Q?NYyzO8nRa5s4984WLZ9t1/4X3KK8zcFAq6+GdOV03aCeag++e3cw15HZbypL?=
 =?us-ascii?Q?i3SyKRQbqhyyPnXB0wnN9BGQLnzwKhVp+ALvl0a3dfGAvAc5/aNQBDUpvPpz?=
 =?us-ascii?Q?qquAmWRrFspb1n5eSlM0/vIh7serzdHGg9+tHNIRoO0tmglMK4cXs6GbdTVP?=
 =?us-ascii?Q?TFWe7aTDYxY/IouV7Nn43Jz+DWKTQafOPISfO9B7pkNqc92SFQvW7QEtekfe?=
 =?us-ascii?Q?/xC0a2IFZHkm9cGTJNCzZKW2PuAGIRvehZtfljDfGsYjyPS/3L6yAJWQbxN7?=
 =?us-ascii?Q?f5k/W7nCFAFCD8UlpPA4xSlyMrGStBdPASzXyGj/7ObreZuzlODdkn8n+yOj?=
 =?us-ascii?Q?Rn2AGl+vanbsPZX8Znu74tSEcIKoj3KJfRyeGWvnMb9uvj98B8Pj9GgjLmFq?=
 =?us-ascii?Q?tuaSXvZn9dYR5v7NmgrlZPUvffnpJad2PdkOq3iuHlxmEV74SjCOfINce47L?=
 =?us-ascii?Q?vYicqB3ZzYywRlcJwj9mVowVgRMXvWRt45g/wo+BUrnTAmgUOQQ7M7JYkI3m?=
 =?us-ascii?Q?9SI3oNdnlMuoRt0LuyHNmvmDYLVyfnwYl10cfr9kObpu5D7wibNUvqmhb3YK?=
 =?us-ascii?Q?Vfbbf64V0ReP6lJ21LUJ6AgRSIkIriMVBZ93K3/q6oBCnGN4u6dy/JKdTj7n?=
 =?us-ascii?Q?B+dP1JocuEU05nZbLqPLdVNalNnMztE4nIB2zuCV7Jy0CHl+qA/Lij5dqakN?=
 =?us-ascii?Q?FFMP9hl1V5yz1Bq50KaNjQJl+W6NKZsR0d6gJWy9qjD6G36OKOmvQBdwy77y?=
 =?us-ascii?Q?dgf0zjkuphmq/e+A+otBYVrSQJSZ4RMxXPPOiIVWj+yEdSOljvDRHvwe3I6l?=
 =?us-ascii?Q?eiZxw+fnCksrnA8qLciA4/Hii30BKIiAftlucUgfNLsb6GJfnw8ZIohApMZc?=
 =?us-ascii?Q?0LoiAxiKtonEIyRkr+4R+Mg4GCeu1WI6wwjzPY0UZPFbz+oXYYctx9oCdceX?=
 =?us-ascii?Q?29c1VySOGVp0dY9Ee93tmsb5aHZDrhE0JA4W+H75e8R25VMSBCHNNOcgRFLC?=
 =?us-ascii?Q?JT0dSKIUMlPGps2b503SRhMydzosotGkqAUgpbdLad5OmElwetCTGQHx8Y4e?=
 =?us-ascii?Q?DkGLKj6BYPXDUNAXbU6T/r3EUG52xFVYASIPSiRAY8ZsSVYAoxcmNK6MMWhY?=
 =?us-ascii?Q?FN6hy7B+yfMS0uNSWTqwT+XMzdkSSPSJYVIqVe/ZGRnFc2lZPNhmj6cJVzDH?=
 =?us-ascii?Q?JI7giTtfSk/uKv83NdAzVk5iUA4jfTCsd3ZFNuoeVtAY2BPaj2Rt5pjHGvQn?=
 =?us-ascii?Q?4vgGzMDIr861d1fDCV+xAUfbpHeirCOakqgOIxdaRT6y0dSyCEBEIJ1C9aUm?=
 =?us-ascii?Q?knWkmyzWdcFEUqAQyAwpaLPGl5EzRau897PqU1ut8yMgd0qSj8CfmfINZj2W?=
 =?us-ascii?Q?wzfGRsxfgKoNNamYpqR/ebOGSr8bbfbhLl0OPta3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0606714-29ca-424a-eecd-08dc497f0174
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 08:15:01.5768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: We+kjPznVd0eku9nxGehQNBMsRsv0mN9yF4m5EZbh5oe250YuMYsLFbg7Cn0yiZn+tkw/NSWih6Njyz6VruYxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9191

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
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 58 ++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 8f2e7c42ad6e..4a7efccb4f67 100644
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


