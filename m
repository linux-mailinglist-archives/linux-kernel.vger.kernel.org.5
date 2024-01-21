Return-Path: <linux-kernel+bounces-32055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C882F8355CA
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 13:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED88F1C20A69
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 12:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A157381B2;
	Sun, 21 Jan 2024 12:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="RRN+kwsv"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2014.outbound.protection.outlook.com [40.92.107.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D67374DA;
	Sun, 21 Jan 2024 12:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.107.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705841029; cv=fail; b=O858QcBF6/4e549xMjB35oHHQXIJquPSdpD6PEhQUzqEKRK/UyYP+Z/W1qr0GPuursqi6zyGwlE5BeGcZp8IUB+EsGdtwVg5pxE7Z/tys00rRCGRvJmC8IZlJ4+PpeHTlvP0IevFPYtXhlolyAQ+nea58iGdAxDCSlA8inEqT8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705841029; c=relaxed/simple;
	bh=PP6yNIgQ3dF7FGK1gylBrsUtEAf8XdY5N816IMYpj04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V7xm9juseiJ3gb8dB2EpZ4cemztOpQPtC9OsT3pU0jixcRpqzp7fxVXCf2fRtzUVI6TBFE64W+D0b+naX2Fk2n2nyuq3VXufoDk6h4hr7/1qHZK7VrbUf8AErnHdW3YaRB/aA9BoV2ss+9eo3AnFq73kqXLwiGwbGMhD3lckcVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=RRN+kwsv; arc=fail smtp.client-ip=40.92.107.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dTQxLiGFDNU5e6P0Iu7phS4SVZGeUN1hga6TjfG8Vhv9/yHPaAfNMFsGQYQB2QjQqpjQDskTJVFXCdxVzB/tJT157uruIftJ1eSvXpI68z5U0pmC3SBnoMoh8Fn1BpxIZbVZSHXRktIvKt9Boya/8K566BU+371skh1xMw9HWlNtu/hY+UXWvOXeCaeIvuJYkyA+hTcGWOtj1onO+Pf3D4FFlRYX4uEzZmiT5wLCR2VkOagWITaI9NA1DbW3XiUvYAFd/fdDIIxK70zSBnpUo0ImFBK3CWWOXLMwIYAGsHlgqxU2zphNcZWj5J/Rq03L/tf3kNGbZhoSM8eaiwGcEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HtCpQ2wOQyssAl/xdemcEv2tYHR8pnJwrmmCj4EIIvo=;
 b=lQHeLRZW4mX7uOgghO93n0N7jyvsZJKzgFft6kGZPYCNSOn5UpVOCTvCNt6czgPFi+52tn70UtZyv3m4Zd+PkB7GkxWKrh09vITlFNT9/kvPprWpqffFvHu8HvY+x7WnBLcluOatSNqU8uI1PxzxO2s6zXTtTB9zi4bdBniEkYY7S6t24b696YbDcr0tORYBJnu4L5ZU0RrUhGjQOYgy+3MYg3vMBrsM1tdYOCJOaJbgqXu+QWL5Nb/VYDfy2ml9P0R7SuRrORDRHr/ouwl+CjhBKXAS3nd7Bmt+cs+WG0El1vbbXH6UGwke+RwVGWuuFFmB/55P1hmT+wI5cUdsIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtCpQ2wOQyssAl/xdemcEv2tYHR8pnJwrmmCj4EIIvo=;
 b=RRN+kwsvQRbW0VLpcOdA4jL5QnocNrWjaXekYgHuCriYMiELpxrf06kcn8fEoQNYfH8lYFOj2QaSy2t8P9Bld+0P/iHOpwLw/wSeHstg8V2xTrKTAypeiiNxwLCYfUIL9fWu5pBlAso464SvY+3nvyggKyFi3FulHMlDi/i+DqNQTQmSJazq+mdV/UeY+bM9vqS5S+t2GBBSOBAAtv12Jq+KScKUuIdyTrkBSm2RXV5g+k13nzAjy+Pg+Wc7axTvDL+GIi5JV1w+ZKmE5yPTuEzEP3nl4BkjEGS4VN0/L1k8MBgZAcTbIJVYUw87Kxlobz3A5GJ6UWvhW3i7LopZLg==
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9) by OSQPR01MB6119.apcprd01.prod.exchangelabs.com
 (2603:1096:604:27b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.30; Sun, 21 Jan
 2024 12:43:43 +0000
Received: from TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::bcb7:50f4:7a16:4ec0]) by TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 ([fe80::bcb7:50f4:7a16:4ec0%7]) with mapi id 15.20.7181.019; Sun, 21 Jan 2024
 12:43:43 +0000
From: Ziyang Huang <hzyitc@outlook.com>
To: mcoquelin.stm32@gmail.com
Cc: alexandre.torgue@foss.st.com,
	richardcochran@gmail.com,
	p.zabel@pengutronix.de,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Ziyang Huang <hzyitc@outlook.com>
Subject: [PATCH 7/8] arm64: dts: qcom: ipq5018: enable ethernet support
Date: Sun, 21 Jan 2024 20:42:36 +0800
Message-ID:
 <TYZPR01MB5556FA040B07F48AFE544680C9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <TYZPR01MB55563BD6A2B78402E4BB44D4C9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
References: <TYZPR01MB55563BD6A2B78402E4BB44D4C9762@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [j/rJpshu8XuHjzADFwqZnDgqFi3SMIZtImm5+DszXLha21n1C+HflQ==]
X-ClientProxiedBy: PH8PR21CA0009.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::26) To TYZPR01MB5556.apcprd01.prod.exchangelabs.com
 (2603:1096:400:363::9)
X-Microsoft-Original-Message-ID: <20240121124237.3328702-7-hzyitc@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR01MB5556:EE_|OSQPR01MB6119:EE_
X-MS-Office365-Filtering-Correlation-Id: d6b8f15b-1670-40af-73f4-08dc1a7e9a15
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lVfkN+fTFs00yzvi4gQMFmFOXCew8Rq0GmOk/zsnXxnsujJdQ1Scu2wlAI56AZx79Jy1VQjG92Dz5FPoqEodx+3+REAnMojJk8FbjSeiNNz+1Zdc1qICGxyfdHdQBjJMH73q6HfLrPVfuOF8KQ7VaReUhCsytOa74C5nJReMUkRApcp/IKWMpp0tpHD6PdYlIg67s1BepICu593xw8Q4ACct4OvsQL0YsxOBtjITJ/MdEFxROopt5nQHyBl+Dd0lwowwDLmShcdp2LfqLXGpJo2/sDw/xmtoEHq0Q1uqFsDU1CFFoio3bM8xEqcZNye43iq6EPiQO+39p0z53ewlrDDuFMFP1dOVn+PSI62/pV3wIJgNlSd6meq1cish5Db7fKgTGgq8Dco6eIvqjR1nommv9BqR/nmlMJLp3sAAhcsHHyhI48r9KqoZ4OxHaYEGJIhiRhVJ77t0xGm2yzzJU95Bs3d+WcNjiR101exC++ecIjFgReWeV5H9SXmzfq4L9qMTyXV6wZPMAa1Cd0Fm5kkRlH53zbmNIikdGl7FUWvurd/xwVjxov/AgWebno6HfaChG8ly2jFcjK3UZsN69RthPGTO/QTBT5YBRNtPgqGTv4D8lOhgJbrU9eRzBOxx
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q5A08U9v8pxHEHr7jd69B/d3r64/IRCe2ZXtKoQbqABJj2LryhNFwRZZCXAI?=
 =?us-ascii?Q?sBNhghZ8ElUU2wGbIf2VfS9EeV0JQlGR+dNVSJCaQxwPSAA2i6KU+t8pgtHC?=
 =?us-ascii?Q?rKL69jcs7J2wiWHDUlRuazWreIrUJaSuWlnLbQhQ2vqjx5QXOPrODM6WfsNO?=
 =?us-ascii?Q?CWktq7zMwUjiL6LZENE1MuhY0X/da+NMmp/KKV3sh3lhySOXCTlmavW21RPZ?=
 =?us-ascii?Q?WSAtpMgJhIhRIwDlncmp9FMeT4pMGVpAJ2hs+nrUw20H9FUJ7O1DPVjoMAzG?=
 =?us-ascii?Q?ZevM1RGD9r6Cph11WqLY5P0Uxo2Ro2Cfbuq5EFhRHhx3ZJ065bBR39azbzfZ?=
 =?us-ascii?Q?n24k1od7UqOe7+uFGrLq76djR4ltcDc+Ao6/jEW0jlx5kAZzTyMBewnl9eTS?=
 =?us-ascii?Q?i/3Il/jXSi21RaA9NcoAl1IupcBrSNw+iOwulS2CZ/K2r03BlP5zUowVDd/V?=
 =?us-ascii?Q?288YAKihvYaC0RRDtBxaq7l1PC6j2ysZlBqZWYhwLJrHyWMbAQvCY/MJ3UUa?=
 =?us-ascii?Q?ohqhPNKSGtkVrgTpdYqAQBSsZdV4B6OEruzl8RSK/IsVQd/xuecAtcQQtBmj?=
 =?us-ascii?Q?1IwgrAr1gk5Z+zTWwN4MIWAPepWNHhtArUWeEwK+pSx4mFOVlJozzkDhYolm?=
 =?us-ascii?Q?iq1kPbhlY+QuRr/ZRNuuec/CrbpUVRyLu9md05Gr+v4UduiWn0hA1g3lkGvY?=
 =?us-ascii?Q?AhbRJrmKCVVYZS/p+U+2nxDBxyfef8X5ZCvfYnI+TorAJrBC8nIwtSGcGnfl?=
 =?us-ascii?Q?mELfnsYhuZgBmW2f2JWno7Flse98perUJB4llv4zH6ToU94cdmi3Y7gm+vcQ?=
 =?us-ascii?Q?un6QtKVyF/Cgx8L+5YkqklmWF2qFrf9MzjQaq3dt6je+VDyG+QukbWW+DK01?=
 =?us-ascii?Q?h0vLaA5/CwPCHkRpOupzRQF9P4c1y6O4hBW6Ym/CeE40lONTD8adfZKPBN2J?=
 =?us-ascii?Q?kxbCQjqY/aDiLqmNLymSvSJluUDjfXWE/n1eqL9nMjgUB0dTgCgwnadahlWW?=
 =?us-ascii?Q?HcYcxyX8jN0+7HX0Nq2fbW05naRfFXUFbPooh9rjiNGaDwYE74C+vOQu3rFQ?=
 =?us-ascii?Q?DJZ/jWBKzc2OFZhYV9oEsNYiz29fGXHbBlktIiXNKYJDypsCQg0xrt7RH+g9?=
 =?us-ascii?Q?Ze5QhBqOgvMS9286aDPe3ypPjNKpqydM1vR2y7euSEWzrKd1yPLXrI8vqIsM?=
 =?us-ascii?Q?j8p05ZS9gRDQvjFufXmqf9hNvPi8cOVznvN32HCB+OPlodmnbIPFgz9yvoyW?=
 =?us-ascii?Q?1pdB2VGey8M20HDDFcP8?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b8f15b-1670-40af-73f4-08dc1a7e9a15
X-MS-Exchange-CrossTenant-AuthSource: TYZPR01MB5556.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2024 12:43:43.6975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR01MB6119

Signed-off-by: Ziyang Huang <hzyitc@outlook.com>
---
 arch/arm64/boot/dts/qcom/ipq5018.dtsi | 120 +++++++++++++++++++++++++-
 1 file changed, 116 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
index e502a3ecf4b7..b36e5c2136b7 100644
--- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
@@ -94,6 +94,63 @@ soc: soc@0 {
 		#size-cells = <1>;
 		ranges = <0 0 0 0xffffffff>;
 
+		mdio0: mdio@88000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "qcom,ipq5018-mdio", "qcom,qca-mdio";
+			reg = <0x88000 0x64>;
+			resets = <&gcc GCC_GEPHY_MDC_SW_ARES>,
+				 <&gcc GCC_GEPHY_DSP_HW_ARES>;
+			clocks = <&gcc GCC_MDIO0_AHB_CLK>;
+			clock-names = "gcc_mdio_ahb_clk";
+			status = "disabled";
+
+			gephy: ethernet-phy@7 {
+				#clock-cells = <1>;
+				reg = <7>;
+				resets = <&gcc GCC_GEPHY_BCR>,
+					 <&gcc GCC_GEPHY_RX_ARES>,
+					 <&gcc GCC_GEPHY_TX_ARES>;
+				clocks = <&gcc GCC_GEPHY_RX_CLK>,
+					 <&gcc GCC_GEPHY_TX_CLK>;
+			};
+		};
+
+		mdio1: mdio@90000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "qcom,ipq5018-mdio";
+			reg = <0x90000 0x64>;
+			clocks = <&gcc GCC_MDIO1_AHB_CLK>;
+			clock-names = "gcc_mdio_ahb_clk";
+			status = "disabled";
+		};
+
+		uniphy0: eth-uniphy@98000 {
+			compatible = "qcom,ipq5018-eth-uniphy";
+			#clock-cells = <1>;
+			#phy-cells = <0>;
+			reg = <0x98000 0x800>,
+			      <0x9b000 0x800>,
+			      <0x19475c4 0x4>;
+			reg-names = "uniphy",
+				    "cmn",
+				    "tcsr";
+			clocks = <&gcc GCC_CMN_BLK_AHB_CLK>,
+				 <&gcc GCC_CMN_BLK_SYS_CLK>,
+				 <&gcc GCC_UNIPHY_AHB_CLK>,
+				 <&gcc GCC_UNIPHY_SYS_CLK>,
+				 <&gcc GCC_UNIPHY_RX_CLK>,
+				 <&gcc GCC_UNIPHY_TX_CLK>;
+			resets = <&gcc GCC_UNIPHY_BCR>,
+				 <&gcc GCC_UNIPHY_AHB_ARES>,
+				 <&gcc GCC_UNIPHY_SYS_ARES>,
+				 <&gcc GCC_UNIPHY_RX_ARES>,
+				 <&gcc GCC_UNIPHY_TX_ARES>;
+
+			status = "disabled";
+		};
+
 		tlmm: pinctrl@1000000 {
 			compatible = "qcom,ipq5018-tlmm";
 			reg = <0x01000000 0x300000>;
@@ -120,10 +177,10 @@ gcc: clock-controller@1800000 {
 				 <0>,
 				 <0>,
 				 <0>,
-				 <0>,
-				 <0>,
-				 <0>,
-				 <0>;
+				 <&gephy 0>,
+				 <&gephy 1>,
+				 <&uniphy0 0>,
+				 <&uniphy0 1>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;
@@ -244,6 +301,61 @@ frame@b128000 {
 				status = "disabled";
 			};
 		};
+
+		gmac0: ethernet@39c00000 {
+			compatible = "qcom,ipq50xx-gmac", "snps,dwmac";
+			reg = <0x39C00000 0x10000>;
+			clocks = <&gcc GCC_GMAC0_SYS_CLK>,
+				 <&gcc GCC_GMAC0_CFG_CLK>,
+				 <&gcc GCC_SNOC_GMAC0_AHB_CLK>,
+				 <&gcc GCC_SNOC_GMAC0_AXI_CLK>,
+				 <&gcc GCC_GMAC0_RX_CLK>,
+				 <&gcc GCC_GMAC0_TX_CLK>,
+				 <&gcc GCC_GMAC0_PTP_CLK>;
+			clock-names = "sys",
+				      "cfg",
+				      "ahb",
+				      "axi",
+				      "rx",
+				      "tx",
+				      "ptp";
+			resets = <&gcc GCC_GMAC0_BCR>;
+			interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq";
+
+			phy-handle = <&gephy>;
+			phy-mode = "sgmii";
+
+			status = "disabled";
+		};
+
+		gmac1: ethernet@39d00000 {
+			compatible = "qcom,ipq50xx-gmac", "snps,dwmac";
+			reg = <0x39D00000 0x10000>;
+			reg-names = "stmmaceth";
+			clocks = <&gcc GCC_GMAC1_SYS_CLK>,
+				 <&gcc GCC_GMAC1_CFG_CLK>,
+				 <&gcc GCC_SNOC_GMAC1_AHB_CLK>,
+				 <&gcc GCC_SNOC_GMAC1_AXI_CLK>,
+				 <&gcc GCC_GMAC1_RX_CLK>,
+				 <&gcc GCC_GMAC1_TX_CLK>,
+				 <&gcc GCC_GMAC1_PTP_CLK>;
+			clock-names = "sys",
+				      "cfg",
+				      "ahb",
+				      "axi",
+				      "rx",
+				      "tx",
+				      "ptp";
+			resets = <&gcc GCC_GMAC1_BCR>;
+			interrupts = <GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq";
+
+			phys = <&uniphy0>;
+			phy-names = "uniphy";
+
+			status = "disabled";
+		};
 	};
 
 	timer {
-- 
2.40.1


