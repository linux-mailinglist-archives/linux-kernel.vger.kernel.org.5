Return-Path: <linux-kernel+bounces-84918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F46486ADB2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FBDA1C20A78
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D028570CB6;
	Wed, 28 Feb 2024 11:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PHhfi2W3"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2079.outbound.protection.outlook.com [40.107.14.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E9D14C581;
	Wed, 28 Feb 2024 11:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119848; cv=fail; b=h9iBRr+2ffOvADWeNm3AzUPhmrOAjywQvwuktnxE7f3sCrH2/6DTP4jBX0PLf4f0BGCwGXajq+BoR3qU56GvxBtvZiSSh3IgM6cAhoClq0nIDW1JxNeLRqsrRw8dUKrPlLL4rij09YR/Hhl8l5yHrUtQjC9nu1LYXVitYrPvBCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119848; c=relaxed/simple;
	bh=X2Owj8+UlinqjZXu2SiS83MOGk/KGU3kn7pIBg2qMOU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IDnC3zcy409MFpF+egmcV5ZAb0XpTK2jvWePEZuMofTytZS7b2tLsg+U6O1bWk3GV4IZIpy3R1Gj2tpAXQNPCz8g1BUk8DbyExVWVqYLVJKuXjmzeWu/WAGKbeoRYT8pTTdlpiEEEXmpjiN218trGiex4sV85OjEVSNKxEMXNQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=PHhfi2W3; arc=fail smtp.client-ip=40.107.14.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXOwCguIGX1qPwTEuCYYwcfFq7F/xRoK+1k8AvMDCMjs84CetAbd1AgeXI4znVL5t35Kr0XcwvODZzhLvNGL0Y/42nJKUMCJNYqr/Nfh4hMPtUdWg2u/m7XDxdM6N/xQLPUytECcJiINOtlTo2DuDKaE4ZgndDHsb0Y2oX7lN7SOrGU4is919bOD7IRiDW38veqBP4V+CrE/KYgg3BzpcFTphDqxjmza+0q6nBDyMr9JGj6O+lEVk/RsKPpqvXbpLwWowrtjOCx+1yyoTlo1fzUbXgAkAE4Sbhpzak4LBQnrN47GKqMaMlgeIjvOTH+5K8zKb+1gl/FwOZDfFDttKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eqjyacs9y7ubo7PjDdOpN4CgLBeWEd8txf81+nJNz4M=;
 b=mKM/9dCvGRo+7bwYfpdNvoGu9Pgx6Sf6SefKM5TXLBGuEccmwawI1Rx5ARgQPvoJI8sd8alOARGVGmPv+gXtNh6LJM/yMV4iIIK9iZoHGSTCdyhinki5ERSYrnHm8FUKoq57uRyLNvd4nK9xnN43uCn+Qng3ER0lNosb4HHIwicDc++QZ1I35AiQWz4bpMNH/EI1nyFxSohz7xaGsXNYiJErzJ44bOrgTezJ61dqb6m4XDgbWOq3S9uoEBKQ7anQo7FjCI5qGnBda5febAHyL0ohbPgd9fAUgJCtDk8iA4e6v2VDMBaQHhWuS2upN97pw/hbwu4wPJvl7QWUl4QH2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eqjyacs9y7ubo7PjDdOpN4CgLBeWEd8txf81+nJNz4M=;
 b=PHhfi2W3eqN/umXMqtAd4R5cbomGRx20/8bXJlaVYU1gPt0DtOZhCn/sOJfeQl2J6FWs/j731Sag9k1BrLcaJ96oquAcUwaYZfRi/V/9tLE5n0OD1LdbfFwJJFCfnrqm3fC/bypjt+5+dkF2AHFRrd2SdWRteb0jjUY6beTUnm4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS8PR04MB8466.eurprd04.prod.outlook.com (2603:10a6:20b:349::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 11:30:44 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7316.034; Wed, 28 Feb 2024
 11:30:44 +0000
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
Subject: [PATCH v7 09/11] arm64: dts: imx93: add usb nodes
Date: Wed, 28 Feb 2024 19:30:02 +0800
Message-Id: <20240228113004.918205-9-xu.yang_2@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: d0d7f892-4ce6-45d0-daee-08dc3850b369
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ylnX+1vic8uZ13XMVDSHqctMK4ocJUNrB2DVzSYEu5eaPE+BWgrnF1mI52VT0kolOvO9/x0T4ixroXtZN2N4bkBohpuRjFHwOfniYgZeudflOAxoE4CDiYGRdy9/hWuYNa17Sl9CAI23GXMqotH7en7g8ER9hg3MHdipqg8gA3vrK6Kg5u8/xBqdkhXiypx53LoBXhE5Ia2A8KlnJoj9BIkFlYksPw21MMplERQvnfhBsHJA3HEvuujZN35rZb7oorohRp2QxlmZtbRDQ75DP3WCp29b1GsOA9Bhv9GM0PqMnrrGMaSYxlFdA919AyCT6LBnDbhxo54Ym2/5G39PQkit+pWMewXc2inR6d+beAXI0wlK4f9nAd5d42iYfvU7frXhkOwKBGRPyiG6lL8CJUvWIit9qgsU0oUUkKyfpYZA3TPMY5M/xI7HC3R0p5k0b9uMjHGHDY99ngp28SnZxo0x4z6RtsGp183WAB79b/WYFU4hOzMAqp+HK+7oC35PKa9XvnXuCYWu7JZl9eMLz4YMb6U3goYSuSQHSo7qyXXZucPuzNCvg+un+ROeh1hurSMvxHknIq4TqknK3vPxeDYd3roRjqehaPNMqgtfHfWY/HwkP6EBIQACAXpsEbfBcviHJs4Jqq4Emw951no9e8EMGSZtgwip8KuX996MRqZwaXw6/dMF2lm0dNnN/VPaKB9Ad36PooXRODQSDH9s2TrCrpryvL9+3DdeHxeEMd0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SsLrOe5Gl/C2J+xN+A7QYHfYtDselLORNu6+eg8lI11iqnHfgMlUPUe77NXE?=
 =?us-ascii?Q?faQohiIp8eKBD3+PhJwwqbYZPiiiLYG+4mOylawWTiudyn7flAvMqmiRDMF2?=
 =?us-ascii?Q?RdrrCupy+8Y9AbQRcYGiqJl00NcEmfvB8YUCCSxdI59HX+rGxim0u4r4pgvY?=
 =?us-ascii?Q?aFlS3xK42z9PgsvsIIM8GfTixStQG8mH0syvOgqqrM9j3exxP4GeHkyybpsU?=
 =?us-ascii?Q?evsCtU4cP1OL1yX9c/9eWf0XMwODHlPd/LTi6KAs8GS/wVeWaNTihW9kbrym?=
 =?us-ascii?Q?66Zt6K8Xh7Ra52uq5BOeYVAG8DEIhrWpqu2KtqsCUAWkpsnmkgR01io6Xpzi?=
 =?us-ascii?Q?0Dd4WOESoMdAk4Dol0QABrdtZeoXdPMG+XD1tUoBBHIFs/rGraM03YVrrxmf?=
 =?us-ascii?Q?YTCi1e1BTpDhlRueAz37uZ6UavkmRIu/CdF9pQ7jxD+gAW4iqOSt7JzBD0aq?=
 =?us-ascii?Q?RHy3+rAjhaa/OioI4GzhpnTKmxK3HWu8rloMHUqA+4fqhTiKZcIl4wdKEPzS?=
 =?us-ascii?Q?WxffTl/9usGUFh2Rq4O1zoEZC9WIe9gvP73dnD/ZnaUzqfy7jUVNlRDdQlN9?=
 =?us-ascii?Q?l4Btc3TKU3p8c9yOgagUsTfmOCvi1wkjE82N8GJGTxYHawp1dDkagxNj3PAR?=
 =?us-ascii?Q?vLDhdh9Mpt+e0rnlTiO7rh66opk+WoPymjKQft2YMnPqw0J2qinmAt9xz3zq?=
 =?us-ascii?Q?rxzdosto7VG9S1ILyeknW1WzTX35vUvh8KTICUlGOT0aUeLNL52eURi5Sgbh?=
 =?us-ascii?Q?rrJI0ISvnhH1a35tzIMI9XOMxCyS2iyyXWFRRcyrsMw3K2CjCl8YuUnZyb/A?=
 =?us-ascii?Q?lrnZEcR4AE+YqZiQUdW+JGwH5+Nr9V3GZ0XrpMvCJqthdLiPnjbZa803aKSI?=
 =?us-ascii?Q?JP7+KHy4AFONuZtIwYFh+T1TvF4gOCyXoDYIxSh3Xf8RWN+P2Wegm/TPa4pg?=
 =?us-ascii?Q?0+GODI3uw5xiWYRqqPa4TPPgobKOskZ6mpKnRxeLqgRO5xMieUAeiPWuzKPX?=
 =?us-ascii?Q?YvRaDT9FSOg7YLdp67FzJM33kV9p68At1xMjwet1o1YtYpyfTHby6fOY/tfA?=
 =?us-ascii?Q?l1UH4c7Y3UhOecHaVZjrSP06msmWvWOZKdBzYMqNhx7QFYGyIWDR3jb0WScJ?=
 =?us-ascii?Q?BCzNZPL/owHfYvdcePR4WC8EzAaaMkfmABI/5MQ8fntXO/CfGuaTc+X8t1x5?=
 =?us-ascii?Q?MtpL5JxqQMn32mIMci8B+RDQ5Y7ohVPOtOxnFt8xW9Zz7wG09y5HA90FKnfa?=
 =?us-ascii?Q?T52ooGaNpuBaUljowJrUgr52px5CYNSRpZT9FATpwTQK3lkSTaVKDcfbkeGw?=
 =?us-ascii?Q?1XfAj4ttjJ1khzPIw4qxYSjDzOmS9Sz6oCRNPCzoVcT+Ok+/UrKFH5+6QYTE?=
 =?us-ascii?Q?szZO+rW+w3Xzbhw1LCydWhwfiJ2r+2gwGAJB+XckKmHzV0ObuxV9ftfv864W?=
 =?us-ascii?Q?Crkf8Q8j3KHtCv3evN0+PH9rSb9rsb8dcvziZgL9HVh3ayCxv7cyHVtJMs0c?=
 =?us-ascii?Q?NINTV/+Nej4uMXjsE127o6PwbjNYdCMRGW1zodaBQ7HdgVj5yZB+lXOD1IY4?=
 =?us-ascii?Q?TMZI9pAWARU3zwIMUy1ybcv0OPIJu3uj0UqOgfYE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0d7f892-4ce6-45d0-daee-08dc3850b369
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 11:30:44.0274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EOtLhSBZx3sraowacDd0zaFDA5iBN5l7ooazOJC5z7LlrkQaa3RpTANrjcZ9wKrLcKLe8aQIsbPznBjNJPUALw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8466

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


