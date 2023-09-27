Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5550A7AF939
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 06:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjI0EWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 00:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjI0EV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 00:21:26 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2054.outbound.protection.outlook.com [40.107.8.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845727AAF;
        Tue, 26 Sep 2023 19:33:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePe0LFqdAvbYZPQrW/FlyGmvWGx0EW7Gv2M3/tYBRwhDQQoq2595Jyy0Jp4J8kem0vdvW37kAMWx/+NPEmkd/ztx2GgH6+GkcvYCv/us5/9jDTe8Uai8x4ld3bQfXESvq2mCWdF5kyaVnk7BTF3MiJkGvPJdycQn0UjHFaLmTyqAJZR4nB5+VmX+57p/STTtFkshiKasc34pexRKkM9b1quOPn4c3nhIUCehicRcmVMF5T4CkqAzsqTwdW4nkjSrwwl/j5fSPowMqgjYzmMNfgnAQAs64mPoxs2Tiv3e4ICHx/76JFO8WFfQs3dt1GEDs2FRIwFJYeiuPPe6nKpZZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+/yWg7UAlBZBqfnjTJEhe69VGob3z30U9N4/k7/DxA=;
 b=iLDqvCDXhWlP/XvGQxDLDDk4lb5FaNh3kNx1aMzJf2UR35k7sT5Mew1z3pZQZqZlEuR1+AFtyd4ed/IaT919HNBF+/3s6bzhridQLqKk7M4HT8qJb/sYFh7vCOiHCoBYqcsw6qoPaUqzHgTHQAG6QMIR1V6ZFfh92BbLDdq/c7tjOX8IqPCFnSAAADNaia1/5KpYgspoRtgJZOKMxRxjUJhihsRyzBneIL5/hwMRXg2mRqmZWWEOQKL44vOTM7mvxdsRy7+5I88FyGMyxHMNIsJxSVQe3FHX1UiWeDklcAfjdArFt/ilfPGUqtBK9JRZvz0Bxf3Zy+paOXnrW2iqag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+/yWg7UAlBZBqfnjTJEhe69VGob3z30U9N4/k7/DxA=;
 b=ra4AfNsOZ3SAFcMp5wPe0Mgub7w+Xwc0ZX8GEK0vtcO5qn5AD4PxqjunALS992E9G0NygafdgqlOV9xMoE+hk0jvj2zr7okea+GGEmEzbB/Sfj1+M4ykslzGjv3opZzc3Xpqo6oN9d9qpBkJX7/NkpNhd5FmXTaw/QPJLFOdyTA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9498.eurprd04.prod.outlook.com (2603:10a6:10:360::21)
 by AM0PR04MB7090.eurprd04.prod.outlook.com (2603:10a6:208:19e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.25; Wed, 27 Sep
 2023 02:33:51 +0000
Received: from DB9PR04MB9498.eurprd04.prod.outlook.com
 ([fe80::51f9:b8d2:7ddd:c74f]) by DB9PR04MB9498.eurprd04.prod.outlook.com
 ([fe80::51f9:b8d2:7ddd:c74f%6]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 02:33:51 +0000
From:   Chancel Liu <chancel.liu@nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Chancel Liu <chancel.liu@nxp.com>
Subject: [PATCH 1/2] arm64: dts: imx93: Add audio device nodes
Date:   Wed, 27 Sep 2023 10:33:20 +0800
Message-Id: <20230927023321.3955170-1-chancel.liu@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0197.apcprd04.prod.outlook.com
 (2603:1096:4:14::35) To DB9PR04MB9498.eurprd04.prod.outlook.com
 (2603:10a6:10:360::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9498:EE_|AM0PR04MB7090:EE_
X-MS-Office365-Filtering-Correlation-Id: 85cb1fc8-d34e-4dba-a4b9-08dbbf022f80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3BX5u/Ch+1+/H6WKe9tcVuReXcHTgoXPeCZo87eDLJLZbAHJYGEpB2EG90dHNSX4T22w8UzJKED/edsw+PFUWgLjkFIwJp9UvblKxNK8TlcpVQU6HxosRve9BQGWGsc1XdPIeH2Ynccamf2XZFPkf8tUWskmBPoxfc7KPU+va/wUcgotUBhbur+DUKKrBloQkTQYB0N1d3ft83R59q7nlbDACDvEUnJ53STWxHzZcRsZAVxtaIA5yyZfUz8dcY4vBYixWdR5OGJqV6m+mvVmYJJBwEKjwIwPpey4Ko4uldk+VGaZEKiyKLnrUnmcRg/c85q1DaLC/SjgoUOo/onAvHo+lCqL2uSb/ZZxrfbzHTmJiNV5/STZ2E3K9hTRbRwp63eUc7jSq3Xsp8H+V2JoQfNYqyNcuGCpQhN1BPAHOrK/CeqSLQMxK1QPBQPfoO0eX3PhbLy4n9lc/+BTlqBbrA9mX2r8R/osLC6Sn699/eKJY83Q/8olJYFwQiAn3mezgH/BJfl3CCEHjs/v0PbyF5wQvJqGD3kShi9iJAgIoBhllNngeUj5qC64eJZK7+QTonxZXYtCjWgU5SGh7y5sXaydh0Zp0JWgeUiZm08ac1YvyOPTlxR3z4NoS9qFRUk/0+a5B7RErI+n5wcPjTGt3YdEDPLuqEmHVWoHYiy2PCc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9498.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(39860400002)(376002)(136003)(230922051799003)(451199024)(1800799009)(186009)(1076003)(52116002)(6512007)(83380400001)(2616005)(38100700002)(921005)(6666004)(6506007)(26005)(36756003)(38350700002)(6486002)(66476007)(478600001)(66946007)(66556008)(41300700001)(316002)(5660300002)(8676002)(8936002)(2906002)(44832011)(86362001)(2013699003)(7416002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3QawiXgfO+tJ2EtqYeYVTaq66htmTsJbKhZZYM1VMyibVnrbtp94VNsUpCQz?=
 =?us-ascii?Q?Rc8lHF/KZqesNhC9YWZduJEPKfeh4mcVHXaYRpGi3nHxq7criK4HE9nWOR8s?=
 =?us-ascii?Q?8gZL6K2ltOLgXaOfninxtdaKwShvRCDbH+dnoNbX8zsTaobsA38FxF/vh+jc?=
 =?us-ascii?Q?GDSslCjn2knb5HfXFoZX2+lAGfX1qUAhlSs8EcB9BUvnOhPdfb+YQ3J8RkjX?=
 =?us-ascii?Q?5/l2rNrsW2/gD4zsBq6/QSs5Ju8A5BWDIHa01B4BIU5Cp6gQGFYxCz/eh5up?=
 =?us-ascii?Q?KsQHSG8Ff34zMFA7wxkWNrizx3qELhauIueueNMFyv8lEq8BTHcwO8N00cVT?=
 =?us-ascii?Q?AaD+jx9WbStZ1/2pJhlAkLgZ6oWmLIliNx5iGO95lBdzPUmmre5zyTcM+xtQ?=
 =?us-ascii?Q?CLx7FEiSdAcy6DsOvHvhRHKpkAbWMgZMp7aBKkfIKoH28Ti7pF1A9qImhJVm?=
 =?us-ascii?Q?GPJNA7Biifm+ejCtvMRzhix9PSHJ2cUdoaZ8EaI1MfEs15fk1bqiUaArTDZl?=
 =?us-ascii?Q?mmmQkXrvWmqwtfslupF+ydfbihsGuc+bmW8Yd6g33w0Jy88MAQ0S3C2F6+EA?=
 =?us-ascii?Q?FTKygGCJe7tpjWsJtBi2YlkXRbEs7EkpSnhXvPAFsEKp895w2XkV3RwEA5jc?=
 =?us-ascii?Q?8HX9G9JlutEhC0DfFlBLgCGh29mwDez2WR+buwWLv30rvORv5OelNyAVWaXB?=
 =?us-ascii?Q?P3cr4rTupDWNao2j/OvrO7X/LWGMokBaDEUNvprablXLwplprDiqXuVd3AB8?=
 =?us-ascii?Q?2cJa9X75Mx4zW0H0ZQWssbcK51dTLRbBp+bfpqGEq5qC3y4SH8I03GQpjKbB?=
 =?us-ascii?Q?QkQ8X4QN8QLEjZMeeljwcb9d4S2vvo3KZAdy3tWt8UNaob53LTg9xnO7EzPV?=
 =?us-ascii?Q?c9fGI9itnhwuZzBVA/MrpRUwu2a2r+BSbJ+y0QYmDqXSyx7Lfobh/r8Qy2PX?=
 =?us-ascii?Q?cIq5vlY+SGvcZ9at4IZD/V87bgb6NAexCfnvfTEbaqrL2Dd0/K/0YVn3CUP3?=
 =?us-ascii?Q?4cu+SmPYDUZR6mW3RjZ5Kj1LeeDJYN/P0OYTy8s+7hHFU+BczjjCcuIajVRy?=
 =?us-ascii?Q?s2naBX1zauR1hdaoF9i8FNX82nTVDVahro67moX+QpeWsTE5m25sa0ZFK3dx?=
 =?us-ascii?Q?7b0IIuAlvU2H81Spd/PeEEGk5VNVlh5QK4ChTX5X72H7jGZJF42MxuU+xrG5?=
 =?us-ascii?Q?2d1bHbE5xnP5tC18gAdN9efFrSmLDPx+aJno+VpIc7Q8SVWTjVHntZV0hl1i?=
 =?us-ascii?Q?/ZBvvV/qmbKDwEUIdBz0mOCpNZZJMzVOna4wtOLLvMQJwBcUkWCDs6jAEKyx?=
 =?us-ascii?Q?Yn7C/UYKrqOqCzDPNIXroWmWVFkCPGOGTPePK27tC/c56qmS86w4ECrHOgJQ?=
 =?us-ascii?Q?/cfi/mpIOTnPuOXYMh7lvSu+etqTG/SOKWMlmJpvg9mXJTseDSMV5ybR+C8w?=
 =?us-ascii?Q?yuQlcYcBCCVKi6gAGr6yUOIAcFmnv//Gp1yYfB0tzCQWK10zZVqU4K8Bi59h?=
 =?us-ascii?Q?3FDyiAhZBUXyju4+d1YPx/FCc5ui5mY1bKsPpFhy37rCYHU2SW3rxaLMJto1?=
 =?us-ascii?Q?WruA4AN2iJjP6KRtbtPLuoA62icQfhsNPAEss/Lu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85cb1fc8-d34e-4dba-a4b9-08dbbf022f80
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9498.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 02:33:51.1885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 70DV/tyIIZIHqHHqiuW/sRNym1AYRFpRP10eYvYqVAIw5ubld3eA/5SO6Gdw2s52nAlMNLFjK9uLMiFAYSg+HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7090
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
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
index f20dd18e0b65..6ed7b156c633 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -366,6 +366,25 @@ flexcan1: can@443a0000 {
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
+			mqs1: mqs {
+				compatible = "fsl,imx93-mqs";
+				gpr = <&anomix_ns_gpr>;
+				status = "disabled";
+			};
+
 			iomuxc: pinctrl@443c0000 {
 				compatible = "fsl,imx93-iomuxc";
 				reg = <0x443c0000 0x10000>;
@@ -446,6 +465,23 @@ tmu: tmu@44482000 {
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
@@ -736,6 +772,57 @@ flexspi1: spi@425e0000 {
 				status = "disabled";
 			};
 
+			sai2: sai@42650000 {
+				compatible = "fsl,imx93-sai";
+				reg = <0x42650000 0x10000>;
+				interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX93_CLK_SAI2_IPG>, <&clk IMX93_CLK_DUMMY>,
+					 <&clk IMX93_CLK_SAI2_GATE>, <&clk IMX93_CLK_DUMMY>,
+					<&clk IMX93_CLK_DUMMY>;
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
+			mqs2: mqs {
+				compatible = "fsl,imx93-mqs";
+				gpr = <&wakeupmix_gpr>;
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

