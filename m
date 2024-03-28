Return-Path: <linux-kernel+bounces-122450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB62188F7AB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1C86295D5C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 06:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE7D4E1D3;
	Thu, 28 Mar 2024 06:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rfrotVmA"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2082.outbound.protection.outlook.com [40.107.13.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED46314277;
	Thu, 28 Mar 2024 06:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711606081; cv=fail; b=ig/PpWgoPDc8fImby/6Nsh+WThuSrUzenGLMEg9udrcRvkEj8/bwv7fIhg5lDqO10LJcPsLi0X4Dpj648XujJLM5rCQFfoN8VBDdxExs5/zf3UVWYPHV9yz63oTuUfL/0ZJXDglO5nqFhrzbHml945SYvQmqqNg3PlFn1pCabx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711606081; c=relaxed/simple;
	bh=rBbpoXuMVYYSUIMhZvuHFDq4aGvFphTZw+UbkIZ6z7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Uj1QeUZ9KPLsTXS6liRQ2Y+L3q3EqifNf/pb03iSacdVXv9uOjWcqwcdo6AeHpd1CMqmOvUeKUw8LZXgmr311CxJsJfpCqEo7MN83wPb6e7oguRFRVNV3LUvIK0aBw8uo13wYqkJUuAIkMSG8MYH2yyxPdx5vYTy3COKGyOwZhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=rfrotVmA; arc=fail smtp.client-ip=40.107.13.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQ1W/EmhZIJcZHMcqk6DPakHjcqbwpbjXJPxTOOI63/i8JX+YvVELos44xCIkKx0jZX+DCS0g0blWefCS1TXAcjbKHc7xE2J3O35GzhOVDu5yy3cPrEzipEmFAmGepV1eFu4XqhIi8SH1SfDYCx7EbgDnG/9L/tF+d5if38MSCeXYkcPQDfRaaOyYLY5nV4pbk/97YEPf+XjYkQAArzDe2niNrFMtwhXb5CL4UK5Q70j7gzMqHKooz1KUWPWr+EG568YI8Vv2oiq+8X3Qfd2u0a/TgFo2sax4G9CSNRCiTEA+xuHifUJ62US4ibemLWavLNwn/aiO+0yKfacky/vFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YwYPEPDwuI5/b1TfFZjFqFPV4pENOxNmLQ8B+tPP1lM=;
 b=RuItE+06a6JHAs5AEYYrb4eXHzIqo1F2f045HpcMdMAxBbadkgD1+g9loId6mv6Q9vqA8LHapkWsYtO5hfyLCsf+N069cgIrqkkKYGKvz9C3eGcqPxpt8ucxOsgRMMuizWB0GagkN0rrZWwhwPZgQKM5PzEM4BgMVttLDhg6//5vSnrFh8I22wUo6AVfS6Okr/w3/8JyLpuiUddC44kP5+x0fkKCD3jjiU5M/+VP4j2JfJHEZxH0gMSA88wYk6tChRqozGsvM3hrZDBXUoB2Tw0fuGAZg+IXzyE31AXt+S9zE8V04MYis1we8nh7ycowdyv3yfPSZY+4sXT/vV48DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YwYPEPDwuI5/b1TfFZjFqFPV4pENOxNmLQ8B+tPP1lM=;
 b=rfrotVmApv8CMI0/WNX6MvSJ/J/vGS1yMi/oeO1363nVaeur2rI2sRqxJt3LpMFvXCp1xDq6878lU/mR2/HTQDBa/rPxVvwGCHFFejpOtS72n+BZ9oAeNy4fsRnkDhOxtyZGOZaFFomgefCx4KS1dw4KEYN1vCVJ6ORg2u1ryMI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by PAXPR04MB8109.eurprd04.prod.outlook.com (2603:10a6:102:1c2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 06:07:55 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::86d4:a13c:3595:727c]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::86d4:a13c:3595:727c%2]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 06:07:55 +0000
From: carlos.song@nxp.com
To: shawnguo@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: frank.li@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: lx2160a: add pinmux and i2c gpio to support bus recovery
Date: Thu, 28 Mar 2024 14:14:19 +0800
Message-Id: <20240328061419.1956329-1-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0025.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::10) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5005:EE_|PAXPR04MB8109:EE_
X-MS-Office365-Filtering-Correlation-Id: db311c57-e74d-4dde-f4c8-08dc4eed687d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HBOA8eWTrYvzXYplBkirngLi7K1xmy2TcJFhpOZxUGmaj5lB9B1TnI4RIIix93wPbIIO/WM/hjmz/UhDZl+uifaSevCxbaQ/jzk/feI/KR8wUVIp5MQZ3DarYD8YEij5fA4Vj2nVUdOCmS+z2nbyAKtYNKKYvkriM9+BA53WQUrxwMh1f5/KGvgml5+7R1ncjjjXzSt2NEObN9vTacuCQO5IgISvxFpJYB+CUx9vWTz9In7DgxpEmWHo0A0KB+Ue1pwqSBLTZZ428F4gQDTAYXghJKcnPLNHeHOnJDNCz+r0mu1BoYEenAxoADn8oSF+s/XGt/AOaha7tcL4/1nG+DipAIbPNAosnsxb0D3X+z83ks1AbcX7VPSQjB37Gy32VVtKW5GGrawOsUYLHUmobTVvUf6wZcJ0aUIV+lP2DaJSQGd2gM5OVzjuClt6RrEJuUnLWVAr9KNwEMyYfSZnhSPeQ2u8gpQYw/fZNdKAUspkEBra03THPMUrrR4IFBLZ65BFm8GTHH3dXvbWUU/pUcYNrDboSQHeXMY4QSz2ZIzlxDp3Me2+gRmSuhOJuzKMvt5qSfiQFnY7xlJ+gP315jEYcnmq+5Ff2hJzUhlYK99lIsNz1gkusMhqrQdIuVYS9+1sejj7dv0SfTiZF+8vTDqTPmEc9bmP9NlYPoYSMciM0jsJ1qQcY1UUDwcJTgL6ngUHUEqrC0pTSdRtwq7ShAHovr5MX7YaHEE7V80H/Ao=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z4Dpg3Apdeg98ofOluae8qTK37+nURgX7f3tevXqlDUhWgIewxOx6jKWPWaz?=
 =?us-ascii?Q?IbYXSleva+O/Vo79Ox6R9qUUM2ThWzX0epRh0AjG6MAiMdYy7VDSYtbJEHpf?=
 =?us-ascii?Q?oT5OkW/8fMr/kqdmj4BoIZWORZJiVbX/E+U9Ek4UobBasr6Z2wNcmcooTWgD?=
 =?us-ascii?Q?hvngVnrsKrLFpV5NJWflqIE/831i+w+hZW4IqGjeGOdGLXfKXYz8sQi998KR?=
 =?us-ascii?Q?cKBTdp/F4OsQYfNg0IkE3XSUQvftdIP5K4uc8w/C0YetgJy8JlTrtx+4gYSb?=
 =?us-ascii?Q?lKaovRa1TjfbsAi3Io3hIycNUW9c5/3nP268r9RhH4LpwTFTD/RMe/X18WTX?=
 =?us-ascii?Q?1Vw2ke6isEzxdT5YXX6oT4+LBlWVfoSn9G40LXcR3cZacqymKi0XYACnRUEH?=
 =?us-ascii?Q?EeWivMKdhdzu5dyUySq75AxNgdov0CoWOLXpvkj9xnuuz4adAsEBXKDT2413?=
 =?us-ascii?Q?njUOo90m2/ZHvZ+R41UNMKwT6lYeW3PwVp4LHz2EKCOA0D+dvLMB+Cr5bF78?=
 =?us-ascii?Q?+V5ReDD8o4Zqb7zI/2lq0QetNwavidN+WesFBZB/MGNwMjMQ0JH5LBkBnDPX?=
 =?us-ascii?Q?7SUBNVnIgm0q2oVyev33ZryEjd0LpZ2je6cjcPP7TRdEPq0qK6H/z14gWTCd?=
 =?us-ascii?Q?hs8G5WLFhDBrVw4t/SDEs9ofx7KRdW36vVb4kx88CigPErVcp7v9RMNA4NgU?=
 =?us-ascii?Q?qpIOA65h7jeyDtKswiF7u7+G14CijStKh1zC/YCttjISmcsmH6lRH1LFO/QX?=
 =?us-ascii?Q?qglU0Q4k1nWb3+ZWf42Z/jl8WtPYB+IDaUf1w30w8Zl2cQAPBFSqrotGL022?=
 =?us-ascii?Q?j0yPAgS/2Uovwi5Ttp2xgX3ye4KJLhuGSLHXBWleQjG7vQdHQJEtFKTieOLL?=
 =?us-ascii?Q?LUxogo8A9YabC0tinrtlAGraEQFoyeG2Gu32GfQgSQtxXv2tF9QrgvTOnfPs?=
 =?us-ascii?Q?XDytBjeZhsdGMxb8odNJK6h9zY5kEyRy77IIAPkqKSF32RtnYH5Z68+pP7WJ?=
 =?us-ascii?Q?xaYodhu0YxWKRmHi64WPsuPokYM9e7ycXOee28kjeOsG/DzBfRYKMjXx5BG6?=
 =?us-ascii?Q?MndQlaYCQABhBEwrOGJT18SG9JF0Y4SAFhwDbbrt1dPpvgpTMEMOIPKctBHg?=
 =?us-ascii?Q?EpS7Iw2oc3A0A4bOClw0/etBdDLG/Fafx6fxLuc0t8JXdzN1FXakgsknDAEP?=
 =?us-ascii?Q?jvHnFyFOHFm+Zm7dpGeMPT1eqlFn4cjlMzlYUajb7zqXrwq2xIe/NZ3ESNwH?=
 =?us-ascii?Q?khRohfKFfQvOrRgyOQnH2zz4cLEI7/SVo1U8jUobb6gFpGdtyENCIOc8UOQ2?=
 =?us-ascii?Q?IviD5nVIDYM0dER2ADgn/jpJEe5NPInXzJjOFNwvcRbe5X9QFieSlWzJTYzZ?=
 =?us-ascii?Q?ndbFxqElM2fd5Du4u+J5+rN4pd72FmyIBEezbKn4EnLYwGFQD5gOdeZ5QA2B?=
 =?us-ascii?Q?M4hrgvK+uo1CmuRMSZvsW97l4eegzQV54F6q2Eo71braa91EpGJznTBTLQQU?=
 =?us-ascii?Q?u56jOk88eqMVG8nR+pKwjIlt3iHen8lblZ3AJg4rrzLX8wrlQoDoBhIqxPRn?=
 =?us-ascii?Q?ZHS1B8JsJAtMJodnt5MJ6ddxhB+o9w7QExi2rhpq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db311c57-e74d-4dde-f4c8-08dc4eed687d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 06:07:55.3380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7tyS6uo2LD8VWiFaJBPdwA2FI9POfF67b8UolbnccQXX4GPtRJYbCq8XJ4PLtFSV4vmhV8Q8zaxKM33m7VAbnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8109

From: Carlos Song <carlos.song@nxp.com>

I2C bus recovery need a pinmux and gpio. So i2c driver can switch
gpio mode to toggle scl to recovery bus.

Add pinctrl-single node to every i2c bus on fsl-ls2160 layerscape
platform.

Signed-off-by: Carlos Song <carlos.song@nxp.com>
Reviewed-by: Frank Li <frank.li@nxp.com>

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index e665c629e1a1..96055593204a 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -748,7 +748,10 @@ i2c0: i2c@2000000 {
 			clock-names = "i2c";
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(16)>;
-			scl-gpios = <&gpio2 15 GPIO_ACTIVE_HIGH>;
+			pinctrl-names = "default", "gpio";
+			pinctrl-0 = <&i2c0_scl>;
+			pinctrl-1 = <&i2c0_scl_gpio>;
+			scl-gpios = <&gpio0 3 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 			status = "disabled";
 		};
 
@@ -761,6 +764,10 @@ i2c1: i2c@2010000 {
 			clock-names = "i2c";
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(16)>;
+			pinctrl-names = "default", "gpio";
+			pinctrl-0 = <&i2c1_scl>;
+			pinctrl-1 = <&i2c1_scl_gpio>;
+			scl-gpios = <&gpio0 31 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 			status = "disabled";
 		};
 
@@ -773,6 +780,10 @@ i2c2: i2c@2020000 {
 			clock-names = "i2c";
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(16)>;
+			pinctrl-names = "default", "gpio";
+			pinctrl-0 = <&i2c2_scl>;
+			pinctrl-1 = <&i2c2_scl_gpio>;
+			scl-gpios = <&gpio0 29 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 			status = "disabled";
 		};
 
@@ -785,6 +796,10 @@ i2c3: i2c@2030000 {
 			clock-names = "i2c";
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(16)>;
+			pinctrl-names = "default", "gpio";
+			pinctrl-0 = <&i2c3_scl>;
+			pinctrl-1 = <&i2c3_scl_gpio>;
+			scl-gpios = <&gpio0 27 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 			status = "disabled";
 		};
 
@@ -797,7 +812,10 @@ i2c4: i2c@2040000 {
 			clock-names = "i2c";
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(16)>;
-			scl-gpios = <&gpio2 16 GPIO_ACTIVE_HIGH>;
+			pinctrl-names = "default", "gpio";
+			pinctrl-0 = <&i2c4_scl>;
+			pinctrl-1 = <&i2c4_scl_gpio>;
+			scl-gpios = <&gpio0 25 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 			status = "disabled";
 		};
 
@@ -810,6 +828,10 @@ i2c5: i2c@2050000 {
 			clock-names = "i2c";
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(16)>;
+			pinctrl-names = "default", "gpio";
+			pinctrl-0 = <&i2c5_scl>;
+			pinctrl-1 = <&i2c5_scl_gpio>;
+			scl-gpios = <&gpio0 23 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 			status = "disabled";
 		};
 
@@ -822,6 +844,10 @@ i2c6: i2c@2060000 {
 			clock-names = "i2c";
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(16)>;
+			pinctrl-names = "default", "gpio";
+			pinctrl-0 = <&i2c6_scl>;
+			pinctrl-1 = <&i2c6_scl_gpio>;
+			scl-gpios = <&gpio1 16 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 			status = "disabled";
 		};
 
@@ -834,6 +860,10 @@ i2c7: i2c@2070000 {
 			clock-names = "i2c";
 			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
 					    QORIQ_CLK_PLL_DIV(16)>;
+			pinctrl-names = "default", "gpio";
+			pinctrl-0 = <&i2c7_scl>;
+			pinctrl-1 = <&i2c7_scl_gpio>;
+			scl-gpios = <&gpio1 18 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 			status = "disabled";
 		};
 
@@ -1669,6 +1699,80 @@ pcs18: ethernet-phy@0 {
 			};
 		};
 
+		pinmux_i2crv: pinmux@70010012c {
+			compatible = "pinctrl-single";
+			reg = <0x00000007 0x0010012c 0x0 0xc>;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			pinctrl-single,bit-per-mux;
+			pinctrl-single,register-width = <32>;
+			pinctrl-single,function-mask = <0x7>;
+
+			i2c1_scl: i2c1-scl-pins {
+				pinctrl-single,bits = <0x0 0 0x7>;
+			};
+
+			i2c1_scl_gpio: i2c1-scl-gpio-pins {
+				pinctrl-single,bits = <0x0 0x1 0x7>;
+			};
+
+			i2c2_scl: i2c2-scl-pins {
+				pinctrl-single,bits = <0x0 0 (0x7 << 3)>;
+			};
+
+			i2c2_scl_gpio: i2c2-scl-gpio-pins {
+				pinctrl-single,bits = <0x0 (0x1 << 3) (0x7 << 3)>;
+			};
+
+			i2c3_scl: i2c3-scl-pins {
+				pinctrl-single,bits = <0x0 0 (0x7 << 6)>;
+			};
+
+			i2c3_scl_gpio: i2c3-scl-gpio-pins {
+				pinctrl-single,bits = <0x0 (0x1 << 6) (0x7 << 6)>;
+			};
+
+			i2c4_scl: i2c4-scl-pins {
+				pinctrl-single,bits = <0x0 0 (0x7 << 9)>;
+			};
+
+			i2c4_scl_gpio: i2c4-scl-gpio-pins {
+				pinctrl-single,bits = <0x0 (0x1 << 9) (0x7 << 9)>;
+			};
+
+			i2c5_scl: i2c5-scl-pins {
+				pinctrl-single,bits = <0x0 0 (0x7 << 12)>;
+			};
+
+			i2c5_scl_gpio: i2c5-scl-gpio-pins {
+				pinctrl-single,bits = <0x0 (0x1 << 12) (0x7 << 12)>;
+			};
+
+			i2c6_scl: i2c6-scl-pins {
+				pinctrl-single,bits = <0x4 0x2 0x7>;
+			};
+
+			i2c6_scl_gpio: i2c6-scl-gpio-pins {
+				pinctrl-single,bits = <0x4 0x1 0x7>;
+			};
+
+			i2c7_scl: i2c7-scl-pins {
+				pinctrl-single,bits = <0x4 0x2 0x7>;
+			};
+
+			i2c7_scl_gpio: i2c7-scl-gpio-pins {
+				pinctrl-single,bits = <0x4 0x1 0x7>;
+			};
+
+			i2c0_scl: i2c0-scl-pins {
+				pinctrl-single,bits = <0x8 0 (0x7 << 10)>;
+			};
+
+			i2c0_scl_gpio: i2c0-scl-gpio-pins {
+				pinctrl-single,bits = <0x8 (0x1 << 10) (0x7 << 10)>;
+			};
+		};
+
 		fsl_mc: fsl-mc@80c000000 {
 			compatible = "fsl,qoriq-mc";
 			reg = <0x00000008 0x0c000000 0 0x40>,
-- 
2.34.1


