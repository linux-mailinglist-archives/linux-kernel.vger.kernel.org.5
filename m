Return-Path: <linux-kernel+bounces-104113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B92FC87C91B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 08:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5736E28122E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 07:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A73318B1A;
	Fri, 15 Mar 2024 07:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cEjZMB1I"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2054.outbound.protection.outlook.com [40.107.7.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2ED18641;
	Fri, 15 Mar 2024 07:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710487523; cv=fail; b=X6YDS+D8Xq0O5eLk1q91oSqt+HNsIjo2oQbOn9U0sSa5Svd5Hp4gUhRgIElnc42tMO8hxAltrpCNo/t2QJy4+gfVIRdITu1J/J3rjojhU39gVe+mhsB8Pix0ff/nHsBto21YgRT+b+pYZW4ObDOhQkrP5ydWN0LqdfgETvGsfuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710487523; c=relaxed/simple;
	bh=fa/YBworeohzz/UXthZEE06XYs/pp4XQt0lkKQIXlAI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E53tThP9WMnrF6EL/PoVK2afib/29+xcf/k/Q0disHMs7NCHyLlhstyEaL7Fvt3thgFKVuWPJljIdapQ9AAperUiFF8stmFAXq3rxOehu1gh+p93chP8pSMZgnM8QG73hJ0za38/HW6ESwAQqeAtIi02G3hS1uh+3yMp9PQjuKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=cEjZMB1I; arc=fail smtp.client-ip=40.107.7.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K01pD9Utbc/vpoTfrW1jmsMJ2WCYhIGWSbozzdJewWC2Nit5oxf0xn78n62CXhWpxghNO4iafhrzpLBJ2Y1rCIX/W8aCzWHfvm7DN6onsbaWeRLrRkIZgtj4mPRethpPb2kyrtJa+RzMfRX6nnjy9Im5WDcBT+NqrwESGyf1Epk7KoMexWhLWczftKHAGw2LLLenSNxptJpDwjKOys8OR+2PFHn7EtmFjuc491i906LSd4ohbX8tQtqHPGJj0FkNmfbQUcTI5lDqJpHdKZmWcwU2F7Hf0wQEwXZ0VVu0At4AChUYgxLY9SG+snaSnmhx/tp5j3LkQLqWSLqE+fkLGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P8av7aGXGHjCKGNHRyn9BMYV1P78j7/mePouOMnbsuE=;
 b=hEcfCrvv3hAaQkf7yHvFhxKPZic/KPTN9IsPRjNWWcgSdLjFWaefMaeIS2o9FVrH4UseWGgCPoTOzhOWEK7/tp8PKZRVkvvwfbGlf/qrITZ8ysd+DTcG1F3fCvBgiMoMvkh3oMO+/2h2iKzCOROiACKOM53ZrycAcnez/qWwz/npIpO+n58mgv2G1++ep5h7rk1p7XyKPXuUSSfcWtkZ0hYyNQLISItcOYzHfAUgKwScVjhhI0JxIbyyrhhEzgDWJvcsxCjgAVy8Qs0BF1QvXXjdvIEXFM6eALqBgf2oGtjCOfOt3Nq6ua3sDs5xlpHiMdeuHjR9cIFBJWM8kE6e5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P8av7aGXGHjCKGNHRyn9BMYV1P78j7/mePouOMnbsuE=;
 b=cEjZMB1Ib0CRPSJywb2SNcw3vmp5Swl1JU4asFxVsiPHJgHBVQQxCtKgVJRlqFUJKtjRqflH0RTIhc0RAKEIyLx703lCTUiXZueUVMJ+jB/FsewwtafyWSCT7mN1Sf5ibGH2mnVEAS7Nt9myCU1roZISCEQGygE3kpUv5Hwy9MU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DB9PR04MB8332.eurprd04.prod.outlook.com (2603:10a6:10:24f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Fri, 15 Mar
 2024 07:25:18 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7386.021; Fri, 15 Mar 2024
 07:25:18 +0000
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
Subject: [PATCH v9 08/11] arm64: dts: imx93: add usb nodes
Date: Fri, 15 Mar 2024 15:24:52 +0800
Message-Id: <20240315072455.2481613-8-xu.yang_2@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 57d480a2-e02f-4ffb-8dce-08dc44c110f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YbU5a3HUZ6eO2g4aImAsMCZZ1Oj99woDru6/zcwoFrIOYoGqwKcbH4iELlLeQ5vXop/O3R2hrnvs0Thwqrs/tL3gIrlpVPpxH8ZZbrowLleY6jdObyCyPcsyS1U3h/ORtAYATSQQFoDmaLKzuUDFQEwp1DwSDfZwn2H9n4p45hoKTeFqBij7xorw+2XxUkWaSP+YVLxRuYLG4m40AsNLvlrSozh1v85WCCQNe02/khrYyVYdZrSe2tTWXoqoGTQsObGqxYZqVqBPjNi249njoOxtsFLxOlphDCjbYjeX64zn07DiS3coRCq4KAbbXIQwUGlPjW75p9mABoYQq5RluY+zhp2+R8i03qVW+gNofFa/ZKiqpC6ad2CQyPMY/becidcr6gZIUI/vBCOfNttgVMcm8utvqpmhv9DvzIL8HIqw5xwBsbEkBdkEwcT4f3B6OBV65W89KVCcriSye/mhVRsoE17S1jZ9PuS4K8m9o//v09XxiDPlBBeou/nTB9narSfTyH3103C1JwiIvKuPVcigu/FdtrHOpOIDmfqGJE7yVd7fpYh3jNIcBPshldBQYkdE17MKHPOqqRRN9qQ+X2Gqdi0yRslkNdow6SoHaZy7lMVKdbMhR9wtoD7aOh6DyzNZHS4TroafdMeI0TViIxRxN8/EuH6oGBAA3rFNuP1v1iqG+aqVcyXFv1qEbf2QWs4sdKbElJILYTuGV6m5jUCORYsebr/yXB9c/I4Md/E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(7416005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZlpspriULixnux8OYMsBS7SYpspX2abqjyvEMcqXh159U2Ht0ySVsxGEC38n?=
 =?us-ascii?Q?SY/vgo+0xTIkNIJMiOLHUpelt4+7bQhaJ8LrY7uAsrn/cHq9laH0rh1/rj+L?=
 =?us-ascii?Q?le7ghaRi+0Gyu8SeS1FZ0Y7KYmIkRjeNBftET3XO2IZnNaAMcInYvKkxUq3Q?=
 =?us-ascii?Q?Vqn00wmuvCBrpW/qDFdSL579hVt4xY54X940vh3Lraab2d8Npcb3B9mLoUUN?=
 =?us-ascii?Q?cpz4PMfUinCYS7jaOfDIw3yG+JNxx1eBHdW9EmTc7cBcnSvW5VvVU3SaBNAi?=
 =?us-ascii?Q?T0dMH+Ac79uidC0SnmU0zcsd0lVJ67Az2tNGo2aCcubxJGrj/yeyZaaZsIOX?=
 =?us-ascii?Q?45X6Kth9WUcErV0j8h37hKLxzuOz3zBV8p/XVtbN7ZoqHiNAWGo+jMBUA9TM?=
 =?us-ascii?Q?Ha6AgXZLdYSZbqEDRi0BbbkCd4Qrq2rChVD+XhHsFSji/uRfaI88MjaiQBcD?=
 =?us-ascii?Q?ftpjWTvUoPZ5dhv2BeuZ3/jBnW0RB7EOxF6Qkwm3uetFmCPnOUKQQSFwd9/5?=
 =?us-ascii?Q?KowwOnQrn3BFf6MxMA0xW1C/InXKZd2P836IUvCO+Ovrbe6MS6Q6v8KgmB63?=
 =?us-ascii?Q?5nI3UdXY4Z6OHFc63H9KmeLaCplHIFMJnWVvvzCSB39Yi7WiTba+GmddXsUw?=
 =?us-ascii?Q?x+xxPT+lYmesuRABuiEv1kkVEKOD8BWjy4T8wIcPcvqBmJrhm4v0KaqSxXPQ?=
 =?us-ascii?Q?Im1a1VM2dszV2ZaVyV4TL34uYOPZRIuD6FsFDOGcpODfAfvV4/H31vXbWIiw?=
 =?us-ascii?Q?neHgDB6aw1AFqi4xQAA0k8gbTiknULTKrQ2IymS0IOkGEYUJzEW4juE+LQQt?=
 =?us-ascii?Q?wbn/kdfwWudjxyT7w68SotHPSqdNb9aAsYZHtjfY0sHRjTX4gQRX8v1jLfbI?=
 =?us-ascii?Q?/eRf8P1MyDiSpNkbJTLk4k6JkgN55pkZZq9L2CZwti24pg+pumQ9yIKwmc+G?=
 =?us-ascii?Q?zAZKkAf5WWBdY2i7oVkmWj5vLmycgwz5TZ75DrdMmkbFJiB4zl290qHr2vMY?=
 =?us-ascii?Q?giY4A5FjTct7YygbAfTHyvSLgbfRNKuWXJUNs51dakQJdrA0vqx1VjJ8Abba?=
 =?us-ascii?Q?Tt0oj7zmXl4TBgmnFvjZyQvCQ10Rj85fgt24b5hUfH7mLf5/mZ3SHMByZjwr?=
 =?us-ascii?Q?wT4at6hYZCM40lF54UWyAuikOHPMRCG+p4ttXxwHmwHYgqqpgSIWVXPSbv/L?=
 =?us-ascii?Q?TIpOJwkUTZBrMB3HZJ/hlPq8+mgaTz8Uc3THhkITnazQYzi411xxug80mkLW?=
 =?us-ascii?Q?YXGUuBrbVv14J42AksoAsVrLN8nyhJpIB2GzWAV54qLFmt4pPX9hlivGmtxt?=
 =?us-ascii?Q?UMg4jen4A6DLvlygqNyW7J+N57vn6mMPDDnx7jbRJTjIq6VTZTwMJhSrBPJa?=
 =?us-ascii?Q?ORkJVV5RDUf+isZZR0j4IE69FWs69FDlayYK4PNDS/h+V9g+euRVKmmziZG6?=
 =?us-ascii?Q?aPpwlMh8gakTwwZLtEdsIL/P6e+TbcicSA7JLTD9r2Ul4JYkSztBGKbupBYb?=
 =?us-ascii?Q?MyM21Hbdm7iVKq3OSN2uLrANiafcyOOz7N+aN/h7HZW7Ux9UBATzjHrOJlzg?=
 =?us-ascii?Q?IGxhxyjHHb1uk4YjQFwjqMQLmpqyxGSdkOZlTdpd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57d480a2-e02f-4ffb-8dce-08dc44c110f3
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 07:25:18.5156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cpmUfkYfCCJKvAfgrEmVK1RGRg3K2cv7ZBoR6OgAV+pvWyB1EJcmsOq2qHDGzSKe9VDDn/9mQLJT+O5xVm44SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8332

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


