Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6671B7CAD6A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 17:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjJPPZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 11:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbjJPPZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 11:25:16 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2078.outbound.protection.outlook.com [40.107.104.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7AAB4;
        Mon, 16 Oct 2023 08:25:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PqCJ4beJLL9Wih5Se+kT57zWPKDw4ObxcnEQiZRvmAsLqSdrfwXtY6X6MoUyJdymGoisOq8PrvGJuJYYr8YID33f4GBP1X89vKPsg0wgLP82p99dXhk0GMDvwNMwWuVF2vIcFuQE557KbPChVZd3n+IxrJwZocHa+nNimKDFmc03/nOCA/Y6b9LjEBxS8V4wFFaS2+xAACnQfRDl5out4gcEo2l59Kq8zvJI3MPtiF0fxHUkEYpW0FfZG1WH5lC1X9gbQajEy0njuez1t1qTpSpfTTkL/paQCTN2KmNrLnjVv1oUkmNUQXTh6LXg6ZqmDArqRUsR04YZ+baNyZkZMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RU5UxsGVuxW2kAmnkRY4NXylyfszEUhsk18zodLTk0Y=;
 b=Y5RvP8Z5N7aKsVkCGBHgU66j6ALaNEDCHBjMU4RSuMm0KT7U/GnFuQK0GUwUEvUVbTMzgeZPJYY3QCkcRNt4p5BK/d4NcX7RWoUk0j7CPl//WrC/3ts/Vz0eduo+4/S0+wimcShe7sve/PDm3+KOSzKgi8Ru1f9Xw0lUxAiLlmo1w0NQPzj2rwkQBztCQq2o/dSDD0Shg8I3DDE8qZZQdVo/G8PU2RjgbEbV3+PE3vQ674w2SAWa/jZ4Pii2Cr1mWqopBRa6Q+aGkpJXMv6cafd+8FxAmMDlv/j8aApq86JNuwjy1fIExjKHHdGM9gz2ETUPjSRs+grrsyJ5M15XoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RU5UxsGVuxW2kAmnkRY4NXylyfszEUhsk18zodLTk0Y=;
 b=GJ+JySdhtOOkGqG0N7jLuc2RGnwe9SQsDlHHP1I/ntKrC3oL4CG5Pe/c50fWG53ru86bMAV1JZWiXAPgV6FAD1b8NpuHdwjlk62fK8Rj/6QYHcZM1M4qNm7suoSeGyD9zYQ8vsxuaeHBguCbUwnGqO4RVV0+L7gGt45Sgrn4ITA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 15:25:12 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 15:25:12 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com, conor.culhane@silvaco.com,
        alexandre.belloni@bootlin.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, joe@perches.com,
        peng.fan@nxp.com, alexander.stein@ew.tq-group.com,
        haibo.chen@nxp.com, ping.bai@nxp.com, xiaoning.wang@nxp.com,
        Frank.Li@nxp.com, sherry.sun@nxp.com,
        linux-i3c@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        imx@lists.linux.dev
Subject: [PATCH 2/2] arm64: dts: freescale: imx93: add i3c1 and i3c2
Date:   Mon, 16 Oct 2023 11:24:50 -0400
Message-Id: <20231016152450.2850498-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016152450.2850498-1-Frank.Li@nxp.com>
References: <20231016152450.2850498-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0069.namprd11.prod.outlook.com
 (2603:10b6:a03:80::46) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB9185:EE_
X-MS-Office365-Filtering-Correlation-Id: 65559ff4-2093-4862-c3dd-08dbce5c172f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tU+6fTIcP/Utm9DT3MNzeGAsi1wd5AvGTndcmNXHqUs5QtBVhvI4rNhCMuuuYWgss2zEFKh2VhL/57hbGW3mgxaa58p8AZzudhtPdrzom7yNRx29ErKNCWVBOEVt9t6wGoEkaJJLvl7FV9Y/uT4CbhZ1FwJsKOpd7LSDSCMipO+hHYmZQwPzCIHUcw03mOZgXRYPueWGYPiZ+V2cXVEzB71rM9XEFxLg1aV4mwxUIEZOcKtyV7qkTQ8Anu1hRy8x49blgCzf/kM+ybLMSBrhvgnmQ/+BrzNfiiesN6lPwok3YgT2Aa8mHjwQRJR0xTyKQJeEMD2yCz5v2I5ek3n1Y0jeoQKPxNX8LgZplJPsFirMvXrrUXZb9zVxh9EGDJSBUurbRg16/Eee6hLQUAdNDOOBSiZAqB6+54G2Dnc2mCrivche+/EFnOH6uA2UpFYGPejYzOeeWZkNXnn+XyWk6Jeeb9hgH0+dlfoTp2kMowGMmnZI80TLvPnpNCubCiN4pnH+KH7D42Rw0awzhFAqfIBjDWIQcKGn/O3FNjlZYDXFDkqUeW2N7llE3CIfvBz4zCjZutaU6cgW/7ECI+LAbq6yZA3ef+tU4wcX304qeHftQN4kg6dWmIxDACVu08bZpuBZECaXId/Z2CaGjJXblVEXANw74LE9wDtN5ohoOJI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(366004)(136003)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(7416002)(2906002)(5660300002)(41300700001)(8936002)(8676002)(316002)(66946007)(478600001)(6486002)(6506007)(6666004)(36756003)(52116002)(38350700005)(83380400001)(66556008)(66476007)(26005)(1076003)(86362001)(38100700002)(6512007)(2616005)(921005)(138113003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+P97d5s6VbhfRm/qan1UMpkpiTcuPko8WbyG+ol7deb/yRcZoUvqf1i3fwcU?=
 =?us-ascii?Q?AobK2dOTBV+d8Je4WC/iZfz0bjtoOO4fchoCWIP9KTQlKcvM0wdutnURMU9h?=
 =?us-ascii?Q?TiSikiNzHCjIf9qPorTkyPHBqtuG895YxspXCrjQN+uHZAaDMDmXlnPGEcsP?=
 =?us-ascii?Q?nq0DPtwh4GRjasHGnEmjwFQOOnEB3uCLs9IHmNSbPGt33KV+qFcXWo2BXlX0?=
 =?us-ascii?Q?rYTonBEwNEp8zADLiKAyyfBQCwVGAjE9ujW2l6BKt2E5VGYyR2Zsm8mp9f6N?=
 =?us-ascii?Q?ABnnf129MRxLKxu0nlyXzJTwMA6GH/B46mgmX/nwr5J/+C1W6BHEf1j6IUck?=
 =?us-ascii?Q?LRzdP4c2zkrbGVFajT9liLVMAFnPCExogdb890srimBpIhqWASawBoM9ef+C?=
 =?us-ascii?Q?Wb0odP6Mk24SVbymQYjwwJNLbwsx77fRQpAU7o3ygIDAZTbQvTspCUsrsUAx?=
 =?us-ascii?Q?xst99My/HfIsvR+iZouBaPN7QQ5xx1YL6M3m2v8EDEF57lGMAV5psIraB2n3?=
 =?us-ascii?Q?JVFj1QWu3j8cA6676dAt2bJdN2Aha8cuzhI9qzmyh6Pp51F+OGimnKeh9/mP?=
 =?us-ascii?Q?JwLZJx9TdknSMNUyLXzj6mJxXRmW9UO1m+rXaVGcmYiyoRgkMasvBDd7RYfz?=
 =?us-ascii?Q?l/Fv62B8BU8EaFWPj9DImzCQXRXs2aHy0OiQ0tn3lSz8Y0xLiEWzKcpHIS7H?=
 =?us-ascii?Q?Lv/i/jQ0+tVn9Zb+odLmEX6BTfN2BQGw1EfR4HlzI74UfSDhsW2Lb2Wnt40g?=
 =?us-ascii?Q?EAbCgBdnfjvXVbm5nDHkmFARODR+4OQM74cSyXR0wSTBUwQWfCOcmcTQWi6s?=
 =?us-ascii?Q?xdk7ytSPZhwkLWZ+OKxH2NzgK6kzpKMG7Boq0vzdCLdy9UkvFrLEkGW9h4Z9?=
 =?us-ascii?Q?MCOMMfXYCWiu6eYR7e1hsoKoHIM0qEO7L8Z7L60SXuZ4ypoRFxR73jqa/Ygg?=
 =?us-ascii?Q?cEsThQILt/k2vZTzpxBpq7m5vsLEz5BfoawoUuanPRj3xRKHBw+or9Cn5FuQ?=
 =?us-ascii?Q?xjU9JkiJItepSqgFoue7E4cjNxIWuaQzteVgN4oSzHD5EV9iHancTavAWkWo?=
 =?us-ascii?Q?AlafTKRitzas7FOpP3nbj15vWEI8gL+2DWLKqp9ByIRYhpEno0nkVolK2OJ0?=
 =?us-ascii?Q?EM/70taQaFjwx0XXSyo7M7RkjLydmL7+Z/X0NeK+8PJGRrDSrkEtbS4nKM1h?=
 =?us-ascii?Q?OREy+yjF/J1IhESzG5l6XAUHxxZpz3jZZtTxsWx1y2MHXuSwiZdXTlbx5iBx?=
 =?us-ascii?Q?ed+5dAIY8p6YPXZULy+ub5SRqjVxb0z+s4pXfDeaT5gjMldgPn5S7XnD105J?=
 =?us-ascii?Q?ZXk9pHql7qYecc6BjEjJWz4c6+ACoL7SSvVAgpotf8Vrw6GIBlHrXE0QCDkB?=
 =?us-ascii?Q?DGMSV+wLrx+HAIlPvIzsaa4UP1r/J2+5CoM5MSpJCeEAYnTf0ZzAKgOpXPJw?=
 =?us-ascii?Q?7k4E9P/heCTIeEqltSzj8+qRUTxt9S1szq38hwK7USJHTWA5mpdQXcPqo2pa?=
 =?us-ascii?Q?bnE6XHcuFBruMbQqsEoW+DFlsJN97i2mN+ZqTFnO66ScKF1sIrYEMManmt5y?=
 =?us-ascii?Q?tpsgq29soF/aRS27d1NC2Qs/sG5UkShlIqXCJAtN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65559ff4-2093-4862-c3dd-08dbce5c172f
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 15:25:12.5927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HqZKQB7tr0+83fObvzjKUoDs/ZYEwJgARTmLtPavxe6EMSBuid5b04Br/T3i08sJi1U2ENWH0c0jL15EHj56kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9185
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add I3C1 and I3C2.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 26 ++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 6f85a05ee7e1..4d9ed0b32853 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -242,6 +242,19 @@ tpm2: pwm@44320000 {
 				status = "disabled";
 			};
 
+			i3c1: i3c-master@44330000 {
+				compatible = "silvaco,i3c-master";
+				reg = <0x44330000 0x10000>;
+				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <3>;
+				#size-cells = <0>;
+				clocks = <&clk IMX93_CLK_BUS_AON>,
+					 <&clk IMX93_CLK_I3C1_GATE>,
+					 <&clk IMX93_CLK_I3C1_SLOW>;
+				clock-names = "pclk", "fast_clk", "slow_clk";
+				status = "disabled";
+			};
+
 			lpi2c1: i2c@44340000 {
 				compatible = "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";
 				reg = <0x44340000 0x10000>;
@@ -496,6 +509,19 @@ tpm6: pwm@42510000 {
 				status = "disabled";
 			};
 
+			i3c2: i3c-master@42520000 {
+				compatible = "silvaco,i3c-master";
+				reg = <0x42520000 0x10000>;
+				interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <3>;
+				#size-cells = <0>;
+				clocks = <&clk IMX93_CLK_BUS_WAKEUP>,
+					 <&clk IMX93_CLK_I3C2_GATE>,
+					 <&clk IMX93_CLK_I3C2_SLOW>;
+				clock-names = "pclk", "fast_clk", "slow_clk";
+				status = "disabled";
+			};
+
 			lpi2c3: i2c@42530000 {
 				compatible = "fsl,imx93-lpi2c", "fsl,imx7ulp-lpi2c";
 				reg = <0x42530000 0x10000>;
-- 
2.34.1

