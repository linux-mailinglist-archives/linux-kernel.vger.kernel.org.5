Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA77C7F4423
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 11:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343713AbjKVKmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 05:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235039AbjKVKmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 05:42:25 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2040.outbound.protection.outlook.com [40.107.8.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610DE110;
        Wed, 22 Nov 2023 02:42:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MlV8hHxNVQFfgOTx2pZULvWnwSKOMTXAed0EmrvDHX9FUAmrHq10BM7vh4IYUOJ2c35TY9wEje3dCYJvTRef1MmUw7bkuAaaCjscXtwtrv8iSMYq9OSv40rVk4dUehpQHg6RUHWBdx+V+xcQwwgUk9zSed8URr2fXSfK71ibvpFZJgezBUC//bUPTbSq/cammyUNpClZJKgrWGYjI164nQ1hU95w9Ts094zJt2quwgVwFMA8wYA1hFWU+hk+ct9oJQvb8uKJvwce2v02314yCpOmjY3xQ6S5ec66X3JEwR59mR6W71dlUKlgpmQ8aNO5sq3TBM62lrx7KkVTGhPbPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjJQMqMV5aGZi33hJTV0HP4lkIVFV1wV9mkNDyQS85M=;
 b=lh6zzf11aS8L24y9uSyB+pdMe4laFRPw6ucl9fOfSfVoEfqFZmJ2NUZCRYj+tMbORBpGYJgeqL/IqRObkYgDCg63VhR7okTaJnlb0zPQCmkTHIRqf4NQ3/xwHZ7nzEFMr5E8YyugnQflIPqYiM2aWH9I+bEJ+WI5N1VuxUHGCxlW31DQIXtnt9J5KLphPjwACbkecsoK3ZaCB7kg4uwOVV0SA4vHj/PmRYe13HsJlxMkJ66lU9T8Vp4MlNvyvB7MMQWd7d5sAQg1LoSULAV7+pKiq61pYgfAcySCvEyF+c8ZAt/LAToLXlFxu5e6nACOhXmyheh1MvNzgJdSok89WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjJQMqMV5aGZi33hJTV0HP4lkIVFV1wV9mkNDyQS85M=;
 b=ngzVueGo22pPez3bgn0MczcWCnYNBL2i58eBgYm/QFO2uo/hU5ZH0/7DtbActQJ6EuMMS68s6PUGB2aOfqbM5Bc2Oh4DAULdz9Z2pebkauNXCAVyyO219QVy4PF/M5ATDhscv64gVOiHsqzIFGbZ+xITCu0Mp/9BIUCQo1Q9Bls=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9498.eurprd04.prod.outlook.com (2603:10a6:10:360::21)
 by PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.17; Wed, 22 Nov
 2023 10:42:17 +0000
Received: from DB9PR04MB9498.eurprd04.prod.outlook.com
 ([fe80::dffc:1d:4398:7768]) by DB9PR04MB9498.eurprd04.prod.outlook.com
 ([fe80::dffc:1d:4398:7768%6]) with mapi id 15.20.7025.019; Wed, 22 Nov 2023
 10:42:17 +0000
From:   Chancel Liu <chancel.liu@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc:     Chancel Liu <chancel.liu@nxp.com>
Subject: [PATCH v3 1/3] arm64: dts: imx93: Add audio device nodes
Date:   Wed, 22 Nov 2023 18:19:57 +0800
Message-Id: <20231122101959.30264-2-chancel.liu@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231122101959.30264-1-chancel.liu@nxp.com>
References: <20231122101959.30264-1-chancel.liu@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0074.eurprd03.prod.outlook.com
 (2603:10a6:208:69::15) To DB9PR04MB9498.eurprd04.prod.outlook.com
 (2603:10a6:10:360::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9498:EE_|PAXPR04MB9328:EE_
X-MS-Office365-Filtering-Correlation-Id: 93a56f35-fb1f-4cb3-f051-08dbeb47b268
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zl03NYezsQf3qhu8+3Wr24Oxdjb1DdlRoyDpjHQzoUUs2Gt9ZAajAcfGLRak3uWDVHtOp+InzwRkT+QpuKshSFrPKzNougfOXBuPNEWX2ggX+gOuIgaLUbTfvoB596tFFQkhfVhQBAGOGdiaDqG+iph14nAjmjO27y4xw2AmV7wnXG0OQl22YiMWyOwgvsMsmuHAb7oHSakzEH+egG+CDc4kKaQ3iGiRc2tei4uOGSD1x8ncdt4b8WWnjjeGp2Ji5dn5LQZDpw5dgI865og1s1W6tK/n5tJVRowjcFr97EPcKv70eRwHtWp4UakIrqxijSQb39Jj/rZL6xsND4+Ogya3ilCzfI2CqJiLhkq8leBXeUprwD7ilt4/+YDeVC4wPp+7AmR2tU8Wito5JfNpwYB6AZDD0snyG6fZYlsNQA4JsQDjRCKoj1u05MdOxU1HrcMsGTDeQvvEvmyEQ00n96pvW0lEyLLhDyy4/R2TYxmjIil9gdOKnQFIey5x/2wYlXAx05SPDdIlDeaP6bf1e0CWuVVBEcPEbznkPSsh/RvTqu0wuACgwBmapcs0YXc07sBcIzKb4bnxwnQYmgisSicr4GHkiYy9WU/TXGftBcEwrLToLrgsesD+aRwar1j6gSOXhZosTmTx1SczoevfDLXE7K3diGVbLLmSFFLoN1c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9498.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(366004)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(83380400001)(6486002)(6506007)(478600001)(6512007)(26005)(6666004)(1076003)(52116002)(2616005)(38100700002)(66946007)(66476007)(316002)(66556008)(44832011)(86362001)(5660300002)(7416002)(2906002)(2013699003)(921008)(38350700005)(41300700001)(8936002)(4326008)(8676002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GG9HbfG1sxEbQPSPh+U+/9lkLcjDu86FwqzxRGv0Nzr91pPkemXs9rxQtzha?=
 =?us-ascii?Q?itiVx0OsE44Ve5EV/RsTCteLHcRyJeIGm6MOD9TN/3mLib6mSsKflHxoGv5X?=
 =?us-ascii?Q?Mynt6b0E8d0+LPZmkBI4AncBtprHfUPKMaxvsquBXgBqMawJkEbuluaYXIDe?=
 =?us-ascii?Q?f53GvBMicVucRgZBf2hNiLrp5tp7reWRZczU2bDpk0J2wz+IaxtGkJB8rHmC?=
 =?us-ascii?Q?cuLcgq9VBnU5V7qwJ6G2zw69ZPMDp4CzsjSOlWcawRsQVDEZmQG1sWEk1JR/?=
 =?us-ascii?Q?DK1jzOTLz2KEh/rDSVUKhwV9qOceXPCyuO0ntslmfRwW8RSR22Wu5qwlo1dc?=
 =?us-ascii?Q?I1JR96p7cBdWGEJrz+gqOrgCM23b1yTNzB4XxyZ+oKabcq8wgSbsujipj9/Z?=
 =?us-ascii?Q?gOsUPIGT6hJnPA0qLX3HadBgR+wvfLBjTBhRva+zB2Y1DSVEaeQK3elAlZdq?=
 =?us-ascii?Q?12SP4LrmEl/6H4D2E0G0+yCSlQFmlx1TV9zmtbCfaiLMwuXQtSzWrWcUvVoM?=
 =?us-ascii?Q?fuIHG1QWC32YiHoKZPz9P356HKbomLuLBwKSPVyT0X+ePQ3abcZyR+LWwJKo?=
 =?us-ascii?Q?O1dGV8lXbBXEbA3UeKTRGYFr7ffV00zO2tTbcMcIHZUU8PpHJCLBbcfVs3cP?=
 =?us-ascii?Q?pCeNgAFuMrhcvb8I2fh8dyneM5KFsWGgc4/5HM6WpQ9c3NEH2hIBt1MykywI?=
 =?us-ascii?Q?eU/0C0NU83jUETOIi0B6fOrV8aGSQ4PR071aEUpxGSk/Yiv8ajd71qAGInSZ?=
 =?us-ascii?Q?osEq/JogKw8Z6L3UoZuTOZcEsf2MMLU5T+dKvrlb4gfgGbvTat2VV9X/+b/W?=
 =?us-ascii?Q?XOfLp5lDXqQLyTJlavvK6rxPtqryTeJB63oFM/gwR2Fv9ZxeXeTM9/hUUWqH?=
 =?us-ascii?Q?vE9kFcfn3X9xrUBInlBJQa41pX+ZUtb5A8DrogIZFs+S2X4CNZe8Bq8b3paP?=
 =?us-ascii?Q?wyT74TajvoRkSnUVZMQY2ouQedL718w+BjZ2jDiO11ZsH/OZiBhROAmZZ47I?=
 =?us-ascii?Q?MTpSDltR4m1YTDAuJQ68DJ4tyYSP8YGAhBK9BpgmA3H4Hq4aGitJvRwPmQto?=
 =?us-ascii?Q?vO+VM7xfCNDhAPnUzWCUo0ZkXwCKKwzz5Zq0klJgwxS/+CXY3nviSVpUVZKN?=
 =?us-ascii?Q?56d/jtziULUk1/+Y6LL0jvKYpNZuxWl1jkcApVe90c/5SsQCnhXhYVs2OnAc?=
 =?us-ascii?Q?HR9CVUjRMUYKiMkzTBRLHIiK9Jsu+QKrlXsl6MQtAtXweMVQ4ZYzUIAW0+3m?=
 =?us-ascii?Q?LgEKH+0tWiRHP8FT2TpC27LR+bK11tbDXnNNi2m+MSkr6pWX9pokRNjtVcGi?=
 =?us-ascii?Q?xzl42/U30OSonEZwnUVZPyLLrN52YJKjC2MT6JWLO+HbjDaUqSk5MVGhCQto?=
 =?us-ascii?Q?nM9JvEL5SExYpxOP9+ruw4v2mqFGZT4EpYDAS3f3R1qWfuP0RVCc2fbBOPnR?=
 =?us-ascii?Q?sjZoMVsXVrsOdKyBlL7DvOtHlS21Gg7/zRhGmcRd+aHYFvOapJx7mYSLUVPi?=
 =?us-ascii?Q?PPVpTTrPOyC1Hc2cQLzWTX+BH54gxA5eAfyJweaEkBX4MkYjNOSg2zqIeYPH?=
 =?us-ascii?Q?zvOfRNg2xlcKihk+RD5mjacfa3LUbv/gt0cp5zwu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93a56f35-fb1f-4cb3-f051-08dbeb47b268
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9498.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 10:42:17.4880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aQvb4TRtEgzUF1sWTzokWK2bv2UDeQoqGLfyJZpzsCemtGJ4ULP1imaXaVYMbTBbxIfV1q4Qw40btoEQNceFlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9328
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index ceccf4766440..9a7bff39519c 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -171,6 +171,18 @@ cm33: remoteproc-cm33 {
 		status = "disabled";
 	};
 
+	mqs1: mqs1 {
+		compatible = "fsl,imx93-mqs";
+		gpr = <&aonmix_ns_gpr>;
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
@@ -367,6 +379,19 @@ flexcan1: can@443a0000 {
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
@@ -447,6 +472,23 @@ tmu: tmu@44482000 {
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
@@ -738,6 +780,51 @@ flexspi1: spi@425e0000 {
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
2.42.0

