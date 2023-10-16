Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3711C7CB533
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 23:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbjJPVTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 17:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJPVTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 17:19:18 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2044.outbound.protection.outlook.com [40.107.21.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B44FA2;
        Mon, 16 Oct 2023 14:19:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JyfSBhlgzMbIinPnCEtPuX5/h0NLPfbVUIWOXWEzpzOHh4gR2DoT9Jk5h0RYGwZfI8Kgibxn/AnLgbXI4SO4YylPH5IDlHx4wdKwxnMmIisTVT/uH2qiCV+auYZEqqjcC1VhUkJh39TnYqlluGneWDZEzLKMT/f+mRXg6p0t5K3viU01EinYwCZz4s+S2nfyf57yN7v5r4d6PpsliY1BnMhjncQreDHemKIqppz5w+qNEnLH1eDH4S7ay+KD8nALiNw0U7pUwS3VliGvjbX6cSgqe4g7NgB7wcbQqH9/uwhYXPydJW3qnkFR9T1zFwatBBrIQVJsoa401d7sf1Ic/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVEE0HpknEwqtZu+kMDQ7IDJWgh/qCQ0shnQhPDJ8q0=;
 b=f98nROYvW8x1fPEHjcR4+Vl43w5ZUsZWHq98rvmrqGV76iwibTGEMwQjpNuw2QKyPfPTHevNe5jZI6Jt8IotSv733uxtIwhFPowveAKSLpvfKQepUjcKbMSTGYYoi9lbJe0sTZYY3pRUzrWMYIKiZ2HLPreLui7ld4Pm3OMDDZQNRqou2NDKV4YztwOigMmubCzyyhPCfK+XoBeK01lTcMOiuMKAXbs5NMIGHsYjxJ3d1Xsj2yXjBswg/FeJt/rSQCtBFMf+yYgbvmLDHDbuk4XI+nFdscn9aOIHlQXBxbehOgSr0uJivAhEBsiddNMJp84cH2cjRPYS7TypySGVAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVEE0HpknEwqtZu+kMDQ7IDJWgh/qCQ0shnQhPDJ8q0=;
 b=prZfvea1Vo+sMysh8Yls2zsYpnVi5CrzIbpp1+kSOXm/AEn3KKj+M/zfZ6sd0KRgT+oFI53Z/gPTmakLVWDZ2rBMD+3OSuCXw0IJ5vwpZre8OSjBU4QmrdziULQzaBOJg9vpaOowo8AVqbwRBsvxURduSooQL6Ia0D0NocKTiVE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PR3PR04MB7417.eurprd04.prod.outlook.com (2603:10a6:102:8e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Mon, 16 Oct
 2023 21:19:14 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 21:19:14 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     krzysztof.kozlowski@linaro.org
Cc:     Frank.li@nxp.com, alexander.stein@ew.tq-group.com,
        alexandre.belloni@bootlin.com, conor+dt@kernel.org,
        conor.culhane@silvaco.com, conor@kernel.org,
        devicetree@vger.kernel.org, festevam@gmail.com, haibo.chen@nxp.com,
        imx@lists.linux.dev, joe@perches.com, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-i3c@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, miquel.raynal@bootlin.com,
        peng.fan@nxp.com, ping.bai@nxp.com, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org, sherry.sun@nxp.com,
        xiaoning.wang@nxp.com
Subject: [PATCH 2/2] arm64: dts: freescale: imx93: add i3c1 and i3c2
Date:   Mon, 16 Oct 2023 17:18:54 -0400
Message-Id: <20231016211854.2901427-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016211854.2901427-1-Frank.Li@nxp.com>
References: <20231016211854.2901427-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR20CA0019.namprd20.prod.outlook.com
 (2603:10b6:510:23c::25) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PR3PR04MB7417:EE_
X-MS-Office365-Filtering-Correlation-Id: ffd4fce4-360c-4687-da65-08dbce8d8c7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LjN/Vye4qd0jmG0deuXuBTto4/zMTJnVgmCf54JHzzqqclF0u+tUjVUTu1GvcEoMi5OV+qe8IyzgZ0uVJaJCmJc719b5Pul7LmxMdZXiXWjXdI0bveau6XgJr6Q+EJa2+8Z3Fg8RWW1bAtlO5gmsPM+6NQuAfQ5sMWAgteByMKKFsHeoHv3g5YzB6wZeLzNhIuZQkFcGBbrRi+u5aeHgVTgpyjJaD9GFahzTMydEV6Tc2nRHND+JnH8B+3+28Dns8DXPmPIgDgLxFThliJdh4hVD/BhqjaMUTHmkA3H7V+XiV5CHjMPVUp+tWkZJNg6xXAssI/P2QvIjPAp4mpymcG4YXvgnlKbPScagoHunR9Kjxtnwnmt0V/l/hOvWLyFcSiQZNRDyrODod48TvYlqNhWUwJm5xB4lehuCy4K1QP33IiFvDwkhWheFm4Qrr6ipSzNlGDjB1g/0IHj121MgmsEdr0CFruopivbKlOEdT94zkt/JnrSxETSDWHBAX0/koO6tj4/qHeDRs+p6j2m1pIYo/9u99VwVJHHTMzi1WD9i3AlJOPKmTl2qXely8ZanjTOjtBZdEo9c5fAlurSHVw8aeI1P449eWXFy8FYICUg5ZuhNeU4Ny1JPuT+LOUHKUoeqpwFtWa7Q3QGZUJaCaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(38350700005)(52116002)(26005)(2616005)(1076003)(86362001)(38100700002)(36756003)(83380400001)(7416002)(4326008)(2906002)(6512007)(6506007)(6666004)(478600001)(316002)(41300700001)(6916009)(5660300002)(8936002)(6486002)(8676002)(66476007)(66946007)(66556008)(138113003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3aLdYs8Wr3BozGwDcVrie+5DExNSCp0ywguy2ua2iEjyow5jfh8NBEPaerDM?=
 =?us-ascii?Q?k5AG2hDtMG+r/oysG+j4g3k5904JzoOzWcFGg/2a1+z+6UN4A3PckctzzqN3?=
 =?us-ascii?Q?dFmOZY9B1CMcaQOQjs9CtsE0rYvp7tdqL6+hmv12SD8FihBCPYrUukABSbLa?=
 =?us-ascii?Q?zrx4NX9IlFy9kpzIAzuGys0u2FCKJOdGk1AV+/UCzUgMM8j/BbQAKWftT2fW?=
 =?us-ascii?Q?nYbnaUzX5rQ2bX1FB+Ls+E72xnUtqDvkTumr8LeJ6XZ9DgTG1cyc2LEV1jTW?=
 =?us-ascii?Q?/XC9dKk/j86Q93oKLn4eAXj2y2BqueW77kjPWgTjgqcrKXf58cwQm4Ow5sPQ?=
 =?us-ascii?Q?bW9XKKbhJry2CJMWi/ZzPVNSxCiFNuUswmg4ORjR67Iqvol2edvrk1H1dWiB?=
 =?us-ascii?Q?76NxgbyYjrzwTIUsBtLuapyA81JRi4zY9G74kJYQHWroRL/sj5GLwMZNfmW3?=
 =?us-ascii?Q?FPy24VBBTlqmwuOc7VfOOlSQdavLBlAznTOHF3TFib3d9Jwmod0dfbIqZgq1?=
 =?us-ascii?Q?QhDJvmhWReF1wM27kehhfqQsNPmTj5XQTwdufWcKPYxz2XQyk/yQzOP++HQb?=
 =?us-ascii?Q?yeAjABCxHdZXZ3dj4SVxfDRQDTYj983aUrim5XztVuhLAkJBXFqIwRBXcygB?=
 =?us-ascii?Q?j4Tg3vSBvN10vE5GpyYekHsQjZqRnDVnS0FnGQcgEznTJFMw+vsnw/L4AtXB?=
 =?us-ascii?Q?RSlJtBP2a9hbWEq42ZKAu/T5pR46blZcclaPjiMD7ubRQKssLcs8xSB8x469?=
 =?us-ascii?Q?ouZ7iG+Zmbe+JlAYTpuP8Ia5EgimzKCG9A+bBC7ctsFFggBooVnIUN9jifjx?=
 =?us-ascii?Q?nfiLcHKj/BjXKTAER8PRqYeldvMevYzYjRfCXQjFACtYA/1pTw9s+m7hn5u5?=
 =?us-ascii?Q?fwFq54+t+yslMjhJtU9P1er+csxtOEygY62Lp9gbA/TlxMJqB3W/2Xxlx3b0?=
 =?us-ascii?Q?E8fkioLE44/uNezmtGa7rV4krpvSZ03D1OgAknX3NfK3EkDi2S64GaYcWATb?=
 =?us-ascii?Q?haYn4HvqHMxnKP57xP/4d1aj5hZvxL2lL3IwwsfR2LGHRv7FFlbqeaopxizP?=
 =?us-ascii?Q?4VPtAcRdOO775mb2NT1r8ovcVV2U+mjJyzle5bSoKl3AGxkkyZzKZuDggQvM?=
 =?us-ascii?Q?p3kfhjbFVZdRXmVO+mnqIXNOfl/RV68F8cAgB7vi9MxMCzEfUdrdNhnQ/X58?=
 =?us-ascii?Q?vuflz6PFPNENVb/LcbL4AlSf6sjJZRvxgQOdRBsRJGQV5iBz6OTi+YouW5zp?=
 =?us-ascii?Q?xizDicPVa6EH251tCfwfgPrCBGOmzzfZG2Qj7whc72mfYpWyRiPYCwmPq4/0?=
 =?us-ascii?Q?6rsiEu/WUzgL1SOCOLQnXUyb3Or/pecoC2R5+cRZftmnvMDS0nMTITbKJDOb?=
 =?us-ascii?Q?7tTBVMviGHeuUaf1GWRgXrRYQ+JFW3Ukna6+bNDluOfL7sO9N+Fa3yvFZGNK?=
 =?us-ascii?Q?NVr4sRsFOOpbTJRFcz8XBR6uTdAVO1X9Xce8mxqB58DmTX96yj88ISwn81ou?=
 =?us-ascii?Q?IIRWrlmZQ+jMYMIlQfaYY2oY2BWtXo78ssJC1TInhlRTX+0usRPbXNa69RA8?=
 =?us-ascii?Q?iY6TkVGTNMWt7z0KR0Cc+M10eOkXvIhEYkn3fhOJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffd4fce4-360c-4687-da65-08dbce8d8c7c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 21:19:14.7097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8B+LmCWx1YFexcvcoMNTZZSE1fymbbCH+RIMa11LIGdroadj49jseakZHsX5Ru4XkKJ/Ob8UTrifX63ZMy/LdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7417
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add I3C1 and I3C2.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v2
    - using compatible string silvaco,i3c-master-v1

 arch/arm64/boot/dts/freescale/imx93.dtsi | 26 ++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 6f85a05ee7e1..c6ad9ba9eb9a 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -242,6 +242,19 @@ tpm2: pwm@44320000 {
 				status = "disabled";
 			};
 
+			i3c1: i3c-master@44330000 {
+				compatible = "silvaco,i3c-master-v1";
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
+				compatible = "silvaco,i3c-master-v1";
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

