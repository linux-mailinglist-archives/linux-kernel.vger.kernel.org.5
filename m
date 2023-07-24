Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10E375ECDC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 09:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjGXHyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 03:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbjGXHyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 03:54:33 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2072.outbound.protection.outlook.com [40.107.13.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95F910C9;
        Mon, 24 Jul 2023 00:54:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3LdibsXlL4ZISyQPStfpVC8EvG+Ae69ieHqJHZUdH5BB+Fxn96AepzFwkqKut80LuIZtA+gHnDB3Wpl3wiPaJcgf/WoT7YGVpjpeRhzmoZxV9xONN3ekhQ6N1mBRC5MIaSghQBXaukEhmMRBpOBRZ3Idrr4aX+R8QNG9Cg5+hzfqqnkykhESWmY9ycw68suean9Ii6sQxzUTXLo87VdxShXYR4hq5kpb+T9hwb03vP5nzBE2K6Nh1rcVg7sUv9Mbjwj/bBy6/2I+1FMUoXG33XzAofojDbIEkzIgB/MndEf0hlhisLqMFSzpenJT+QMI0jYPIhRYQBEZJMsyS2rXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dovzsysI9H+HqSmbCi+EBxmdc4Smf5KwYPkCGCiTKuQ=;
 b=LMv5DF0wIfM++UG/wvGdIIRQYjlyxguG6snVMEy1V83/JKfPEJrB7EsgVV4VLTjCkuUZytnhdkxL8iT1K2+iFuRn8GRlJBXw3wLvFfTGiztSyZzInpO8fVJDszV2mv42LIk1E9VQTo+0+ZW1MzQ3CU1jlJXO4FKYwQEmcnL1t1RyfHJ/ujY3cViKdLr7pFb5682y+GSxepaBum197NT5vfeyNPSPRallVcRo6L0O0Zc9yTrmdMoEcZlyBtFtzNu1thaAAd1/BIQ30jQUkIT//c1Wp6BeIk77mKKC4boJ86Tw86DYIT/XqDW/pX8FUm7ILUBl6yvx0ALF2SE0tL1OOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dovzsysI9H+HqSmbCi+EBxmdc4Smf5KwYPkCGCiTKuQ=;
 b=RGwIHaXKekyiItukzQ9fvLSKW4/gpfoK6kvGxyGkf54FpIcZUdHaTxh1v/uIRV3Y+PJGk4T73LWPoUMl9l5cjTZ8hqMLh3LTaeYBkgv24OEvV9RTbsOeUBeXUeDVIf0qu8g3TBtyWBQRVe3ZmzCMQlWxfY5nqQFGORcllEmXS/Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB9445.eurprd04.prod.outlook.com (2603:10a6:102:2b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 07:54:13 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 07:54:12 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 05/10] arm64: dts: imx8ulp: add flexspi node
Date:   Mon, 24 Jul 2023 15:58:28 +0800
Message-Id: <20230724075833.2763190-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230724075833.2763190-1-peng.fan@oss.nxp.com>
References: <20230724075833.2763190-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0191.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::6) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB9445:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ecc136e-9726-45ee-7b0b-08db8c1b2b91
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /eJc/WPDu+59OQqmLYm5B3zo5gnug7VP58ihKTWMYDlqqqZ4KxR7veudPWtXk/7umr5u0YuGptzsWRGAm99jICi0NijWKoTUHo8AVKpucJ1BupdRbGMVqxm/OlS5d0/yV+yzfTebdierMsmI4+GUcw+Gp4jgPu5IF0Vm56KJsX2V2h1Oc3qF18NBCb+U/4UYvGw/TEX7x/31E9yeffzWS/QiRwiH6tTumGogabftR6UDPbIQ+GPoeTpePuk+nddlFZ2UOIgTZtwnc/NIvufnfhLdnjC6JOJyR67QYZAM6sI9565R163NFo+Z0EMJncugcceuC883z0oS4cxTt/hukeZSnZKpR/W9EECOwqfMQWuC0izJpTHVNJhBP05jYgw/kCx0V3cGHuubX3HsMDzitvwzCoCMam1TKKSWVvbV3nVs/Mr9hpM5Tnppfac5PlIgMtiwQVFAMDkVrPAVeNZXfF5jhUXmxIG1J5DM1kp0cxUSqODd9dfw91HSEB0ivjoK7a8Zzu/YDNYim2Li8WRNI4X/l+xKUeM0yZ9yWAsDGmhdU7pPSJXzzEurFW3wFb+U8mwUMuz1hviCyHZVtECjdooYRonrC/w9E8x6TOxCyNH0qEvZc/Mdf7q0QNt4xQzimxwcRqEE0IqXb3RR7PCd7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199021)(8936002)(5660300002)(8676002)(41300700001)(316002)(2906002)(66556008)(66476007)(66946007)(38350700002)(1076003)(26005)(6506007)(38100700002)(6512007)(54906003)(83380400001)(86362001)(52116002)(4326008)(478600001)(6486002)(6666004)(2616005)(186003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xP3vVo86YLe3HEaGsVOQgijUga5gz2596YGR5zifIGesvPCyjucdW+8E8I9S?=
 =?us-ascii?Q?/IWzEufjVTcNEdopjvbK8nwDdSumJf1TeXyKXxZEhwM6rRNWJr5lzCdMq+9s?=
 =?us-ascii?Q?Lj8WXtygsGHPEF9CEFbx/GRWFdRhD6c26eCFdra8lFBHLneX1rkqg/CTWjZd?=
 =?us-ascii?Q?8bZDsqeXaEflODJEAVPzy2dclHfYpwL7HYRQ9eD0GGaYlQmIXGtn1JwlEIKz?=
 =?us-ascii?Q?ibLTGtKg7YYPrz3LLM/t0lN2IB+gSeIM6yNnt1Ayv0d8GQd8OVClgyWq5V8/?=
 =?us-ascii?Q?uQ1+tsuU13vjCKHBTnU6IK7EUKV++BESH0v1CH0rfP1A71IZu+hM0FexsdlW?=
 =?us-ascii?Q?utAmxcxJriOJ8gPAvOtPpzdgVLiC+Ll4G+Fg+CLP5rZ4JjN6qr6lZBM7C6CL?=
 =?us-ascii?Q?naQbl7VlVwRyxdEipSxSWUYNMYUxM/7MfYJu3t/jkEbEtq7gygrGJ6nnU+KN?=
 =?us-ascii?Q?1b/Lx0UuEe6uRbxppsMx8AgSYGKb70w1zPgQmG8zENkoPIJRLWLC+Fz3cwwq?=
 =?us-ascii?Q?i2ZmXHi5go83Hzl3jDDheLZm+THmUoulNeuybBoe5S9rgGMfJ7uUj9BO7PDA?=
 =?us-ascii?Q?QO9tPH4xs7Y4x6Ov/wJ8qWIeLqwW2BD3w+7CE3FDLe+gmixhTXoopeWlOkqd?=
 =?us-ascii?Q?11Tqe9PEEbJZ+walcvr4N1Esjp/7KAfjtyEg3hj1Dr/Sf1FGZ75xnreKo3A/?=
 =?us-ascii?Q?CV1ikdBtJfnmM+uRBHZGOoturu/uAQqNRtNiR8lKgbdL2hlHLSY5HuU2Pie8?=
 =?us-ascii?Q?3dOe1wJ4OaAWrGEI6J3yrca/y9XxsUiI7Z+30LqsQQQZw3dglyFtVCKh5Dlx?=
 =?us-ascii?Q?9Hy2hygQazZ1yMoIMXWDvXAnvjov5UEx/XN35IXMCxAgIVOknmyVnQQ1lvHB?=
 =?us-ascii?Q?/8JlfiMQuSExQ0o3LGKc3NTcROgfApF7Mvku2B42YpPr1njV+9fO+SLjn4Y7?=
 =?us-ascii?Q?ZB5LBTtHPjS5T9ujxFY6alZNwrolBmCIRhdH6JRXUCXe/lLqVtTxm76e8bI3?=
 =?us-ascii?Q?VKixG6yCXH72hTPErSrHqyz+I8XfMWvJ+/SupLe2gdCexAgdG+54pv7WbVao?=
 =?us-ascii?Q?bBe0p/NFIaSFksOiaO8sJ94k95E9+uYGcWCgcTjeB7LhzZOcOfm6lFGQGT+F?=
 =?us-ascii?Q?wO4wU+6dcMY04Hx5ekomNMbD97AJJ8SoYkcsBoPuu0yXufkqNu54DAFV1/oM?=
 =?us-ascii?Q?7mteSs+FF8gpZlp18GX6xRqDw+Re0Hj6U6cO3Ix/KZJV80de75DG/kiY8/al?=
 =?us-ascii?Q?0WpG2aSUwC0yXPs2D1q1WFn8LKkHik7h0blC43YZjsh8XJTyk6cecgGmFQd+?=
 =?us-ascii?Q?GrmTIzaYLZSyrD6hHcluTtflf2ZQEbwDiDrAxVCx8qRXQxClA4iNU1R7xWCd?=
 =?us-ascii?Q?bAJqgeKo1d8/jxfnSvO7Uu0dEiSScyZg8tR38i3+sQzBM9IPV0gKOTzTOnAO?=
 =?us-ascii?Q?1TQW0RTIbTgKdvZsGPzMDRb8m5YwOYoxtZLRX6g4jqF9pIhLeLBUXRdYvaZx?=
 =?us-ascii?Q?2jXf5Riaq4vlNtzjzYz6AS9Y1jcnl2o903RpDcklrM5Fj7ktvydfHZuDCaGg?=
 =?us-ascii?Q?BVB0+TU0BjRfLXFtQCr9RV7xh1l4KqwT2UXlXldX?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ecc136e-9726-45ee-7b0b-08db8c1b2b91
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 07:54:12.8658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m5vQAhKu+c7SAL64wP8XKoriTasxDzBfgh1dXaXcdofvJZ49tZBX9CufQfcntorb9QdrrN2d+1tBR8S5OV+CJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

Add flexspi node, flexspi has a special memory region mapped to
0x60000000~0x6fffffff. This region is for AHB usage. So add this region
to SoC ranges.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index 17cbe526a5b0..8a6596d5a581 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -195,7 +195,8 @@ soc: soc@0 {
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
-		ranges = <0x0 0x0 0x0 0x40000000>;
+		ranges = <0x0 0x0 0x0 0x40000000>,
+			 <0x60000000 0x0 0x60000000 0x1000000>;
 
 		s4muap: mailbox@27020000 {
 			compatible = "fsl,imx8ulp-mu-s4";
@@ -350,6 +351,21 @@ pcc4: clock-controller@29800000 {
 				#reset-cells = <1>;
 			};
 
+			flexspi2: spi@29810000 {
+				compatible = "nxp,imx8mm-fspi";
+				reg = <0x29810000 0x10000>, <0x60000000 0x10000000>;
+				reg-names = "fspi_base", "fspi_mmap";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&pcc4 IMX8ULP_CLK_FLEXSPI2>,
+					 <&pcc4 IMX8ULP_CLK_FLEXSPI2>;
+				clock-names = "fspi", "fspi_en";
+				assigned-clocks = <&pcc4 IMX8ULP_CLK_FLEXSPI2>;
+				assigned-clock-parents = <&cgc1 IMX8ULP_CLK_SPLL3_PFD3_DIV2>;
+				status = "disabled";
+			};
+
 			lpi2c6: i2c@29840000 {
 				compatible = "fsl,imx8ulp-lpi2c", "fsl,imx7ulp-lpi2c";
 				reg = <0x29840000 0x10000>;
-- 
2.37.1

