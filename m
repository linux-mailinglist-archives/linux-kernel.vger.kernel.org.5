Return-Path: <linux-kernel+bounces-74284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA28D85D20E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE419B243A0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3093D3BA;
	Wed, 21 Feb 2024 08:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YVBWheho"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2059.outbound.protection.outlook.com [40.107.8.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588943C06B;
	Wed, 21 Feb 2024 08:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708502600; cv=fail; b=gzDn49/KZ1HmHStYIu6JGhkG/VaNEinJ6/qata84OLHoQeUNwBxOh1tEktfP5KxDcR8kH5oqQ1DNrTXXTz2AfzlaVZyiHSlERw5UMRd5Rt3MlKTfsPBy/4Js0YnPo9RERj/yfMFCTMY1l+OLFtCVzIoCNdpwvg8jzKojgwJeKUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708502600; c=relaxed/simple;
	bh=jmsEIIrxVlsX8CR5LTLM+eaREHvOtDv5OZFe5RyBabA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jPHO2KqIapWw6d1eXph+2eyJxf+HxoWNK8tU3KdC3JXunPgMi9gGnDnYNHgCbtftXrg3tdp9/6tIEJMkiqZ8KeSg1KNadG2yVuItCmTynC9VBpqhPWTlOebB7fP0/gWuYVCEVzCRSpheQG7PmI7i4mxN35zAq3Vc+ompZMex2WY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=YVBWheho; arc=fail smtp.client-ip=40.107.8.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5uqCqTK7eInEmEP9kPtAeQmhMI/tnBChQt/PVENFP55S44S1whDnkQYWowP5uzksE2MmdsPycY6pu1uCKojq7PG9k+opOU9UK9cSmvb8nc110vO/hRof5dbvisF5R1OsaBQfTjv1PecFLRtb+H3r4X4YufKoaZIaW5+qw9UAtku52iVphUAQQYXfaeTpMPGT66ahmy4PiLs3bAbPFuhO3mA7d6yecjJKu0RQyfqFgC5AZRf8rsaDJAGX8mVYig7UK3y6GqFghYHxMUd6fiDaLxCoSClWpZbfTLZRMsUD2sK3IzMQQhg+5uz52PINTmfvbXN6kg9Fz2u+pUsgDMFkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CZk5CIesGMDmmmZaQzckc0HoESG5V5PKQKLRWtDUAh4=;
 b=VUtftz+ZxvCO2hg7G/yIYkfWD/b1MUK7/bP0dZxQCgucqbjFQMjxLK+AFhWFhHKdoflPqinfGdwCMKjCJb4m/Cl2NCbTbQ9kUXkKobEkuLU5AmEh/oVQCvwFqZHWKgsTkDbTFAJ4C9NGvE95EQZ6h8T8wIeyRyDSb751V3V/xTGg1+FxH36V7RjwwXQhXy14zIxYu51voy9Gpj3EJOgGkcdiYyXY9OAD32hKa7wv8mYYbFlQeeao7bwxFLlUJe9J+obAlVlkB9mIkN42HclESJ8mBRxvzsnmB4QOXZwreVSdsvI6BmvqH93dpyCmB3HsUGOOnJyytlInitv+IQtSig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZk5CIesGMDmmmZaQzckc0HoESG5V5PKQKLRWtDUAh4=;
 b=YVBWhehoLzhU29PqYV4rfZEWOHaeEcoAuwrObU2YyFUcJNKh8tUgX2W7KQcc6EBM264vcltCZZKE53A0pHK3Q72wY+VJchaVesBBXDBaWKArqrLsXz3hChM4v2MlotQnIXDp1mOgis4i5Gt8bM+krcXXM//QDXeDsvfhZnLwaaE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS5PR04MB9770.eurprd04.prod.outlook.com (2603:10a6:20b:654::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Wed, 21 Feb
 2024 08:03:14 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7292.029; Wed, 21 Feb 2024
 08:03:12 +0000
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
Subject: [RESEND v6 7/9] arm64: dts: imx93: add usb nodes
Date: Wed, 21 Feb 2024 16:02:36 +0800
Message-Id: <20240221080238.1615536-7-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240221080238.1615536-1-xu.yang_2@nxp.com>
References: <20240221080238.1615536-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:4:197::15) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AS5PR04MB9770:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a14803a-5d2c-4b97-9941-08dc32b38d07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GdcHGLeXfrZp2hAbFn9XhMS7JlH0BRaMb7V4IRPzELO6G5s3Y78aPaF8TYobd47R7UhKbSMZlGA05v/yC9YKmpZXxRHndnpLm3vnDd5HcU+BK8NF3K8yCcM9fe6C3wBl6Yo/kZy+7iNIyUPPX8/lxNeCr3jPHPEOd/+ioUJG9WFxHdP/LudE6QLtk0NbmyxfldY5xxhknQYJTbzetbcMbrCa1JpS7JjZvwAlscHCSuGICw1GCNqDP2pvE4nSDMTGWtUmwgF+n+PQDpO8B858k4kc8eMJYcZN5mgO4ytSBqTqArZNnChaWHn17JdL4zFv2G5ZOkHId+G//XPn9EGiIeSco39Hb8JxcH5s2BV36vF865VzU8/OFpvj2LGtTsUNt6aPXEXQBr1F4Yk7ZeZlWcHxYMjAOGVMJXR5lInMT+iKgXzviwMLk9zR6P1e8GagGr1X0sU+p4AOSyzn5Sb8FV9N5uZP8nnH3CD9SzBFgqs3XEuPLRDYgiTboMQYyk/oo2WvX2EHyZUcNoZZhgLY4nlX1wSPJqxCdFZXkhjAv+qg1voMFwfN8EKlcbH1+4a7wuqDWyLcsW64rXBhENnxTqjhB7rYOm83fEVVhkBw6WBYq7Rxi7/12hYsmbJS58n0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mr1Gfb3TVS0aSAxGqa4iMA03DkqUsAqN975jAC14AVqA2mZumJ5T7qsjX0qe?=
 =?us-ascii?Q?+vgW0viZSjzsn66RJ7nreZVWtZW0rm5BjljCD1JJVVA08lpKHNc7W7E/yGch?=
 =?us-ascii?Q?dCjvkralB9Ehkzb3pO14OUicC9cJOMU378HTBTD1Yv/aA85bKZJM0lPw91Gt?=
 =?us-ascii?Q?egu7NlUU5O1bmqcnUoKtUcnDtiKLdhLQs9eG5pq6M960n0yT4JKdtlgDfNJa?=
 =?us-ascii?Q?8SVDYeirh7hFy2280waAp6Mx3m7o1+HwSKDZMg+o0NsGAoxpCcCYmwX9zvq0?=
 =?us-ascii?Q?d0dQIctqLv3Yy08cUNbcedjNKzzRkK792e14Yo4opwcpgUCL2trh59Ix90BU?=
 =?us-ascii?Q?/9gJJo0c1GCzB6cF9VC7sDTKFn/KIDqarQNoqF96hhY0UQ0Aw/cqRDfxkl0Q?=
 =?us-ascii?Q?UtZKNDHEeUdzpkxIRVr3W3JoCuAbwoyUT7EB3CdydxohqyU+ExsDisd0h5oM?=
 =?us-ascii?Q?+R7pfbx9uZUojgbvXzYVzmAGcfCkleNJV+zWbpI2y9ir4M+j520Umm3XU1F5?=
 =?us-ascii?Q?GhYrv0AtUWfHx8S99nkNb67p2UYev1WmpAvQ5HjRN7W91uJkHQE67YywMQYF?=
 =?us-ascii?Q?ZABbwAIif4W1w+AVGnkce37JzckvrfjCuoCouDt3ppcYaIgYdnwAhwc2704s?=
 =?us-ascii?Q?LcwoCtH2aEzuegP32U/iflO31ZC8msypClwoKYWxBcTbY2GGYtW4xoCBW75t?=
 =?us-ascii?Q?+uEDrw+qMRDEzpYb3ghNs8nzQ96+mmBgD/BheS59s4den/cK0lycPZEHWnqU?=
 =?us-ascii?Q?OtiCd4ik1wHEH3YZM9BFEX+liuXz52nLZGIME5xhTO6bPiaqFAP34vLQTk8K?=
 =?us-ascii?Q?NuxwirL50fGtR2BsfhLBwegrp4y3Okwt7wqFo6fsx5iriLFKrDAyo059Uh67?=
 =?us-ascii?Q?bTLnDj2+YToK6NHTkQFAyzrgqO6umVO7od87aOVXucHGFD2KxGzYUsU04AUc?=
 =?us-ascii?Q?cgJA1nt6w+9OmIN4U+svd7E2qy+cqMRqk3qUXqrFGQ4TenTp0AJGAKouJ2mI?=
 =?us-ascii?Q?grwXUvPD+K8WZSEToTwXt1iWlp+EYHxHAv1ikTykySuoAbAT/hQjGotl6h0m?=
 =?us-ascii?Q?oZDH/ofsVEqHIWuCrkB8InSYiZah/uvejo51FimxnOT5mpl9sDaQu9s+kjJv?=
 =?us-ascii?Q?F6Ixo8T/F0mbmJNxWYQjLihWG12S2pVJfaYDWFkMS2X8vZJEQnxB7acN7K3w?=
 =?us-ascii?Q?/mSaGSclHkkXO9KDdjzCicAESqBYLPa9rnbjtIKM64frslW6cMlp5Xi6orL/?=
 =?us-ascii?Q?L9QyTuKboWgod/nw57oYrnmilzKMF6+N3wlEbpQK2pDc9tKp+IJyJUpD1O+y?=
 =?us-ascii?Q?YKKh0HTXiyX7Yf47XbkNb6OemHMQtQDzCEkm0nQR1+EmCQAtrooE1j0+xyJL?=
 =?us-ascii?Q?k9YqeqatZrWxol9dbd67zwAAnVaXCFUaOMXFWSGiibZLEre5khVb3IHQ3sAK?=
 =?us-ascii?Q?PNRIiLaLRb0dQL4L5hYI03+Y984aeM6H56nRmyqxakmlAJKrj5uAWF3L2J9s?=
 =?us-ascii?Q?rvcCP6wnS7ZyLKCjcYEeNqW8YsodLUzDT8wHGTt3Y0tLesIpL44q88kDExF/?=
 =?us-ascii?Q?KtXIs0BxoIJcZJNe68/Pj2LYhpoJz9tzew96FWux?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a14803a-5d2c-4b97-9941-08dc32b38d07
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 08:03:12.7935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 97FkrNPvAOsodikS74G4YoPxfd7/LB6XsXIvIZ+w8V6ph1RIGFfqR4gcggk0vWYAb77Y/Gri80d+Rm1CgtdhxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9770

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


