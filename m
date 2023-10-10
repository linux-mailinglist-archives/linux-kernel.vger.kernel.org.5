Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD7A7BFE03
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 15:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbjJJNkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 09:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbjJJNjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 09:39:31 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2042.outbound.protection.outlook.com [40.107.249.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14823D4D;
        Tue, 10 Oct 2023 06:39:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h3DlCGM+zm6bnDn+9U3qf4TVR8kAjOU/rl26i3iDJV+FllSqz1+YEgTMsOFUklYRU3DA04rcL/jsK3ak4AhSjloykWMfenHSTDi5MS7JdNP/dd9wu8TXFCORN+0qUr74rgtqzVEmXkbjAlL/GqdXqn96T4MNJf3ccLkmq+g+9c8z60xbnTLwKOvr9oixMM9q1R0mHAbwfrgvLrxZXUV5SK40km1HtwyawlB9vOkKc0DLTz+k5yhM8R/6L/SMZok6t/zzEKmwChpp7Vpyl1a1haTiqCKs+ryQs9usMBtOfvil4Wwsnk28nq9Sbv64uE7IT11hPiDUWCmUx0U+cfDVCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kWFgDR4XULeGsuvmgvI/uv22/Oc4M9BPQPVNwLll7DQ=;
 b=FOnO7F3nVyi4Hn63BUp9Ib0Sdw1qdqntzFdo0lRtouYx/3QpFiRE0l7GXzHWMJpWykwiB8bkwjuzrpm/hDQtmExmXJCEdDGdM0dzMG4FkX29Ef1F3iosCN00o4I1M6Pm8ZVKnbfkkLVV82vd3StMb4ZkJ1EGsb+RbC+ZGAX4QHehUgH7giFhNu3pRNYCLUhrviOXcBcE08RZK/79HF3yCwWsoQaM4Wd+r3n6I3gpWZd47dLvsOyvgy2h58AZReeT4WGS2M7nTSGCNJPhwnhtoFlNs0YmNcRiiz8RSryzNcQhM+BNxbx7Ab0momjynjPIS7Ka8/KUrUvOA6Uy9NTZyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWFgDR4XULeGsuvmgvI/uv22/Oc4M9BPQPVNwLll7DQ=;
 b=mKeiOiPsT7HMYWQuB+gxJj1khK3lRUqtL/j5Lr6yuo+BYgWJSDCxA+k1JnE8iODCNFCZDOJCWiWYawfGdSrNxzZi/VRzgzt7niIA1ld6dF81JhyifRYZ6z7tPmLXqsvyjhlBGtEil4TeIj1S5yziM/qoxkztp+clCbKn9rZ3HR4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9498.eurprd04.prod.outlook.com (2603:10a6:10:360::21)
 by GVXPR04MB9831.eurprd04.prod.outlook.com (2603:10a6:150:11c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Tue, 10 Oct
 2023 13:39:11 +0000
Received: from DB9PR04MB9498.eurprd04.prod.outlook.com
 ([fe80::51f9:b8d2:7ddd:c74f]) by DB9PR04MB9498.eurprd04.prod.outlook.com
 ([fe80::51f9:b8d2:7ddd:c74f%6]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 13:39:11 +0000
From:   Chancel Liu <chancel.liu@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc:     Chancel Liu <chancel.liu@nxp.com>
Subject: [PATCH v2 1/3] arm64: dts: imx93: Add audio device nodes
Date:   Tue, 10 Oct 2023 21:38:36 +0800
Message-Id: <20231010133838.799714-2-chancel.liu@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231010133838.799714-1-chancel.liu@nxp.com>
References: <20231010133838.799714-1-chancel.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:195::13) To DB9PR04MB9498.eurprd04.prod.outlook.com
 (2603:10a6:10:360::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9498:EE_|GVXPR04MB9831:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c577109-d742-4dae-9c18-08dbc99648e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BxWQakRzHgk5TekYgwxVx4euBKEI/tEe2ycZzYqqtxZCwmcfSWrwPGqvQOgNwS1FoLnkkAcf80TcwqbM0Ea9DuAJrPkWRg/8INQRCIfF2ldP2P2cEjb18lR3kRfYLxgCiM5Z3rIO6qAaEOAmMfpxOq8AzX2X4xzSfIZh1mpsPbx+7TRoQaQCgFMk9NNJmvZxYsgOcJMyRXrultZrOmb+U4dx8jSbjCWLyS8tpD/RTEvZOtEIPZnAc+HTgU6fisDLiAblVInLSbKuEbhR+zuoQMpb3SaMwaHQANXGWdY/jVqHK5/c04qmQfosgG1No3ONbbbd9KZ6UHcDv/arlYqyr2d5lc0Fj1NbOezILNIkWYMhDm6ucde7iM3kYARSEkq1H7JB38gKD+jNSkmHP4pQtioNalRMExcfrQ/nCoOlZCRKSNuw2kucZNRtDtFraF0P+DGmYD5YGFR1eDhpWnzpFLe375Vkw8LYDAXe0oFlGoUUwnxXX2l4phL4umnAC/P+/sykcMVAvBVEvSNhoDSvbpKlqyVGbaHvrSvIx4OBBVIPLfgMuqHC7JPC0bIdGYtwsLlRFA/GHUh+QrHqOr4Ec+m3//O4DYx8y+mhPm8/9wixDt3aTSr+dcUVQRShb9RmfXLxDYbSrMp2wPk7NdDK/1EbDEzBJlVA7nftAfBralU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9498.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(346002)(39860400002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(86362001)(38350700002)(38100700002)(921005)(36756003)(2013699003)(2906002)(6512007)(52116002)(478600001)(6486002)(41300700001)(4326008)(8676002)(5660300002)(44832011)(6506007)(8936002)(6666004)(2616005)(1076003)(83380400001)(316002)(66476007)(66556008)(66946007)(7416002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7vrAqF+g91/goqUfCDGcZvNEXagIWMA4rxiIcnpA/zGtgXWKhnya/KZboUFk?=
 =?us-ascii?Q?JVXsmY/BzIjSfgusf3j/IHW3UB2foXkGOoLj+KW57fUitYXv9XWFGU1doAWD?=
 =?us-ascii?Q?HvY8NbAnHRPbXI6Z3WX9qb35OcHu7K0z7hsA3x1EFYCBciQW/6tOMPFwTwGM?=
 =?us-ascii?Q?1kyTULChQzRn4qL9iceZDDOF9zdnl27BmElxLTi+mmD8Mw/Po1FQxEqFP8ZE?=
 =?us-ascii?Q?+HrtUWJ1888Ch7F4mT5mw1oX7vMZimfHAxBKh+vidpuzwZRc+dCuLjQY1Vdn?=
 =?us-ascii?Q?UvFY5vxC+7/6+jfJ+INokmvzfyrmiSrDFfbjYTj/maxHR0w6BnxPtQBBGLzp?=
 =?us-ascii?Q?8aB0shJ61PMI8Rf9Pa2x5fFYQL0GDxwlwvFmI2X7qjFlZl/xAO54nZg9JQH1?=
 =?us-ascii?Q?PKFO2RKpzXFWnvsmPSJM7EK1yLCKQzI4Z4/Es1egJ/L8EyZ3L1j4FRn5Ogzm?=
 =?us-ascii?Q?9gkiUQdh02AhqfK1RiOeznsm5bG3uwp5Q7ZZIFzlhGLFgeO8i0gSdRp8MwyI?=
 =?us-ascii?Q?H6YuVayaCarPTyhLOFFknnnNSpdKCMnIndhFYSgu2rSiSVpoh7XMyDCNG8E8?=
 =?us-ascii?Q?ZZlsNAs1sS0ZyKG+j8xs8vb29Wm615+dVgjlDRdA6Vha6m09+vbSn+Qgk64D?=
 =?us-ascii?Q?FVBEW9Dma9jbUN7XDZtRF+eG8uMkqnZD1GvWVml5oJgoCF1yf9uCqoQdsDDc?=
 =?us-ascii?Q?88XJoyg+vNNfnRljHPddmPzQhF7Zk6/w9cD1ntrlH3JPTew+2y8Bb38m1U61?=
 =?us-ascii?Q?hGNuwUCM49QQbL+/J64NZArPlrjFPYefD9WyfWXpizvr2CboyFcUFoJZyEX4?=
 =?us-ascii?Q?V5dtOwfEv3BzryPQBQ3baZq1oC2Dk7cC1IyDId8f3ZY+GBm5XK3h1QX57o3L?=
 =?us-ascii?Q?Ty1lYohWu6EOuemFnXPBKYK0AwUwbpTrmQEldvoVQLjpa9y8HVUCwez7c17x?=
 =?us-ascii?Q?nAWuu1WReSR98UUpur1dSFGljiImwPkoBI1KezsoccjinlSvQUNXuuFjQBlJ?=
 =?us-ascii?Q?cH5BajQnGDBn3Rmf76t12LQjujmZYyQUaYO/v4jCIAMWKjH6ejwEIJ3Sv7N+?=
 =?us-ascii?Q?iX4rvWo1gwfR7Rj7iqoeiF3NBAwYkFUVIqcGuVO4JEnQg9hOI9aPBkTpDiIR?=
 =?us-ascii?Q?pp1r8M0F+0Il8dzwhvnB0dRY7GAJtaCBBgt4qed2MT2oI9Ehim5KWwF6mz6i?=
 =?us-ascii?Q?bP9i33cyha3nRC3A0BuGrLen/n4ivw7n0NTO8TpTsQ6qanSTziwamSwaD/9U?=
 =?us-ascii?Q?Kmv1Y5tzHFoQoHUK+jJfBCMn98t+Kku23r6UizLo1rxXYgFsMrJd3wdqXgpw?=
 =?us-ascii?Q?WpzcHiBTPBml661N7MnRulGGZqNluCB2q4/aN6fR3Fbfyryuyb916M5T6hv3?=
 =?us-ascii?Q?dxclI45NH7r78tERR2S29AkLmlBqboBl3mTiUcIvkIoKUcXUJxxH+vit4KgZ?=
 =?us-ascii?Q?1zVJm89FP6ohJw8wFR8eDn6Ac8KlUq9dHctxq/CTp7s3YyI5joHjs/gUPOld?=
 =?us-ascii?Q?RRQddKgwJOEUmcfrkL5CmPp+Zy5VYOsY+Bcjg30Gzl/l0qWeeihkZd1z3gKM?=
 =?us-ascii?Q?8h8oXUd3/+/rx3Qdf965+qET10ExF9VT99cG0yop?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c577109-d742-4dae-9c18-08dbc99648e0
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9498.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 13:39:10.9563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jl05N3L2cKVBGwjivQ35XO8uKS70DFFeHqU3LSXpu8uAtOYxlOqknOaKYVv6XPgTNfDe/mjF/vTHucUll5omuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9831
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add audio devices nodes including SAI, MICFIL, XCVR and MQS.

Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 87 ++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index f20dd18e0b65..a1310710080a 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -171,6 +171,18 @@ cm33: remoteproc-cm33 {
 		status = "disabled";
 	};
 
+	mqs1: mqs1 {
+		compatible = "fsl,imx93-mqs";
+		gpr = <&anomix_ns_gpr>;
+		status = "disabled";
+	};
+
+	mqs2: mqs2 {
+		compatible = "fsl,imx93-mqs";
+		gpr = <&wakeupmix_gpr>;
+		status = "disabled";
+	};
+
 	soc@0 {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -366,6 +378,19 @@ flexcan1: can@443a0000 {
 				status = "disabled";
 			};
 
+			sai1: sai@443b0000 {
+				compatible = "fsl,imx93-sai";
+				reg = <0x443b0000 0x10000>;
+				interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX93_CLK_SAI1_IPG>, <&clk IMX93_CLK_DUMMY>,
+					 <&clk IMX93_CLK_SAI1_GATE>, <&clk IMX93_CLK_DUMMY>,
+					 <&clk IMX93_CLK_DUMMY>;
+				clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
+				dmas = <&edma1 22 0 1>, <&edma1 21 0 0>;
+				dma-names = "rx", "tx";
+				status = "disabled";
+			};
+
 			iomuxc: pinctrl@443c0000 {
 				compatible = "fsl,imx93-iomuxc";
 				reg = <0x443c0000 0x10000>;
@@ -446,6 +471,23 @@ tmu: tmu@44482000 {
 				#thermal-sensor-cells = <1>;
 			};
 
+			micfil: micfil@44520000 {
+				compatible = "fsl,imx93-micfil";
+				reg = <0x44520000 0x10000>;
+				interrupts = <GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 199 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX93_CLK_PDM_IPG>,
+					 <&clk IMX93_CLK_PDM_GATE>,
+					 <&clk IMX93_CLK_AUDIO_PLL>,
+					 <&clk IMX93_CLK_DUMMY>;
+				clock-names = "ipg_clk", "ipg_clk_app",
+					      "pll8k", "clkext3";
+				dmas = <&edma1 29 0 5>;
+				dma-names = "rx";
+				status = "disabled";
+			};
 
 			adc1: adc@44530000 {
 				compatible = "nxp,imx93-adc";
@@ -736,6 +778,51 @@ flexspi1: spi@425e0000 {
 				status = "disabled";
 			};
 
+			sai2: sai@42650000 {
+				compatible = "fsl,imx93-sai";
+				reg = <0x42650000 0x10000>;
+				interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX93_CLK_SAI2_IPG>, <&clk IMX93_CLK_DUMMY>,
+					 <&clk IMX93_CLK_SAI2_GATE>, <&clk IMX93_CLK_DUMMY>,
+					 <&clk IMX93_CLK_DUMMY>;
+				clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
+				dmas = <&edma2 59 0 1>, <&edma2 58 0 0>;
+				dma-names = "rx", "tx";
+				status = "disabled";
+			};
+
+			sai3: sai@42660000 {
+				compatible = "fsl,imx93-sai";
+				reg = <0x42660000 0x10000>;
+				interrupts = <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX93_CLK_SAI3_IPG>, <&clk IMX93_CLK_DUMMY>,
+					 <&clk IMX93_CLK_SAI3_GATE>, <&clk IMX93_CLK_DUMMY>,
+					 <&clk IMX93_CLK_DUMMY>;
+				clock-names = "bus", "mclk0", "mclk1", "mclk2", "mclk3";
+				dmas = <&edma2 61 0 1>, <&edma2 60 0 0>;
+				dma-names = "rx", "tx";
+				status = "disabled";
+			};
+
+			xcvr: xcvr@42680000 {
+				compatible = "fsl,imx93-xcvr";
+				reg = <0x42680000 0x800>,
+				      <0x42680800 0x400>,
+				      <0x42680c00 0x080>,
+				      <0x42680e00 0x080>;
+				reg-names = "ram", "regs", "rxfifo", "txfifo";
+				interrupts = <GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX93_CLK_BUS_WAKEUP>,
+					 <&clk IMX93_CLK_SPDIF_GATE>,
+					 <&clk IMX93_CLK_DUMMY>,
+					 <&clk IMX93_CLK_AUD_XCVR_GATE>;
+				clock-names = "ipg", "phy", "spba", "pll_ipg";
+				dmas = <&edma2 65 0 1>, <&edma2 66 0 0>;
+				dma-names = "rx", "tx";
+				status = "disabled";
+			};
+
 			lpuart7: serial@42690000 {
 				compatible = "fsl,imx93-lpuart", "fsl,imx8ulp-lpuart", "fsl,imx7ulp-lpuart";
 				reg = <0x42690000 0x1000>;
-- 
2.25.1

