Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7B675ECE8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 09:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbjGXH43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 03:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbjGXH4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 03:56:03 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2072.outbound.protection.outlook.com [40.107.13.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B5410DE;
        Mon, 24 Jul 2023 00:55:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tp3GRFgl7iRL1wtfPKCJEeW1fB1MDxWeVflEnDoxVKRXqiBCatc4oMxE+lG/vGtNeMi7K2BVzBy+Jmku7e4aJvEWlEy9CuqaJ65IaCpLmvRnKJxqw8z1cYhB/n7f1qWhzK84sUxO5poeXHVY3draHdWulpbF8qSm/uqezwc+U/OfGzEDQG1aECo90NZBw1QW7ja0Qbs4MASxynVjitItrVCOuh81g+RPJVPcKAy25ckIAZhP/msYpv/qSlXu9/aw+1axervuLqrYgJPhuFmX72WFsR7m1fInxlq/5G4A1KrK9G23lfuk+jkTGghTdis9P5cMmZE8I/nqpoOa3N3HHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9MCWDCrLnn1XkDtShMtJDjrsNjpelSaBIR+waHjZeQ=;
 b=ZQJXiWVrTdYgyndI7F+6urTs8qQ0a71uXEHJbrSCmvHva6ofq1Aw4/K+U5i96sdTdjuZ5Zf3jO+Kzp1pI4rAjaobwnmfOS7A3ElyyWKYQayXat8IIbpfmNwehRBO0KJO65gYztY6lRD/wbU6A02IWHoYwhO7J+YiQM2GV9z1LUc0lEMh9u/AUw7Or3rRXW9Z9pwWJyY60jnzLk0njIOVicaoBzDo3+Y8r3YbcXjtBt5eLBbFr5q+rPowY4Pwox5utiQLkDxvZAV30+GF0060IiyZ/7dAcjgVnvEc+k5Jv+/367Q2ovR3t4Y99YfX2WcT8CobD7x/irT9HTpCgfUbdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9MCWDCrLnn1XkDtShMtJDjrsNjpelSaBIR+waHjZeQ=;
 b=AiKS1n5Je6iD6I+XpSVx5acoKozNk3x2ozfu32nhjNHVUW/epAV8w2zgn43MgiDGEKdrS3GciaQskRGJoUUABf9+LC5we3kdT8Y05UCG8y2AXThroYphW/WFoGc3adVTqU9XeJXVuv/BfKwzhoBSDErVqg0yqMPFKcQ2ntpzMOo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB9445.eurprd04.prod.outlook.com (2603:10a6:102:2b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 07:54:29 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 07:54:28 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>,
        Sherry Sun <sherry.sun@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 09/10] arm64: dts: imx8ulp-evk: add 100MHz/200MHz pinctrl setting for eMMC
Date:   Mon, 24 Jul 2023 15:58:32 +0800
Message-Id: <20230724075833.2763190-10-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 59e665fb-8093-4e21-0ac2-08db8c1b3518
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4kdpCO2L8+fbBJA+yIkCgiHeO74Zvtf00Rm1VaGJw8dYWu9C072n69VW60xdHlS/bYqsOFoaj3H4UM5/u76FdcgBc2VXik3FVXgOcrun9hu+Cp3QViW38112QmXkM2/LD4pM7gXGimG5b8E4eBETInbK69GqUjVfxvxcvVfUVqv3xJOT++Z+jc1yQ0ecWg44IZSYoqQ9/5asjSTIC940AnpO/jWuBgjuqonwkuEcJGlbYA6eaQd8jSppBl/2MPZxFUtCrcoSGNvNjoCyKGAxyHPMqViZkNHEqjtKeIMrJ6K3ChZZJ+zAsF0fkCvDrTXRW2IQhsg1xpvEfphg/vaBA7hq4pQOfaFLPTT5gMKbrSWyoSb0TynW2zg4zQ86ZGhUWewiWBoO7aH+uwWcE4O6hWNtG8GDwXY1JC+Ng+lRH737RkE9zJE800OONKLp3VAMgbPhMbEAy/OxSrZq09AL7NfRWr4BxnmuZzOQuxtbVsWYbV9n/jzXXTYvP9DMwcKG3TgxT1Uig86Mr7sBVwP6KgiWAdI9xLCvkhlmA+G0uITm2xzq/ez0rDKuBrvNmHcWqTlQejXP1tiTFqoJZJ3pVVDU3lkQ5tbgCRqX8Lt6ardU+RsrxFWZhp/ITFLGjeSNhFhQHm2NvRBBTLWYbIQKGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199021)(8936002)(5660300002)(8676002)(41300700001)(316002)(2906002)(66556008)(66476007)(66946007)(38350700002)(1076003)(26005)(6506007)(38100700002)(6512007)(54906003)(83380400001)(86362001)(52116002)(4326008)(478600001)(6486002)(6666004)(2616005)(186003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oZBkZA2Td/QlDQLV8JaGaX2oHk7DUw8msS5+JgovFsvQrHOI0FSwu8F9BCtx?=
 =?us-ascii?Q?U8cUpYX+3oUTPrzbALV/8k5xGXpgqGsYc2C+MS8xB6XCNmyBAXP7kATNyI+f?=
 =?us-ascii?Q?H6BEfAFyrvC50CvolAbY1pVxi+5jXpp8jadzTXQ0emyOK25g3CmsNsoA135y?=
 =?us-ascii?Q?Lu8qz6bX7KWX4agi3naen1bIDFn0Bw+XRBuMCKAkqp4xOSpF9hWnRDkZ1zlS?=
 =?us-ascii?Q?yglO8R6q1mi42trUEGRy1q9bLEII9jwd/jkAV+g8m+dBXVy+/UQdBhNfrzq3?=
 =?us-ascii?Q?DiSkb9fayxoci338FYzUiQT30F8o62WeTTa9fWgRdi6hKat3aRpt1ecz1xpZ?=
 =?us-ascii?Q?ZTbPNqANhJjaju8QKrKFDPXgQHFF2mCz+etYqJgsRqiW8SO4UvQXv4+t5BSg?=
 =?us-ascii?Q?+SRVK7oWPt/LdfV807M/V/ESq38x83zECYCe4oZSSPi2b4wzAs+qBAvWrINN?=
 =?us-ascii?Q?C4Syew9JD78p5JWE56hTDTg1kakU2JBVxUeBCdrhuj3X8tpQd3B4irxwf4Jj?=
 =?us-ascii?Q?wMupDvWQ9FpzWvChWsLGO/NMg+tpNRgnu3YTrtadZqLD36yD9twfcvU5E+mk?=
 =?us-ascii?Q?T2qGHDLu/1KWjzyRn8tMunjxONPwyZJ7PUqJHNjH/3PCXTlc4Ut3xSOIMdu7?=
 =?us-ascii?Q?9ZxrOUqv0de1Bn4iRN8HokIYLScR1DdmqlZe3RnAvfb3ersPbnffyehphLOu?=
 =?us-ascii?Q?JXYpRmMGYpRY2BJRQYn8MktYlBPciUkygU/oeECSryrf+7YLC6Sy7eUHWSCr?=
 =?us-ascii?Q?f1FLliH0BXdjzIgPcJwdvwukmM57xvV7JopJKtTwhHU5B8JDjVCu3GdRZh6p?=
 =?us-ascii?Q?2MCXu2AdPS1j1Tyirur9EOCAhqXf7MBS3mv0FT5mgaIRPu3INYUNNKnRxIAS?=
 =?us-ascii?Q?cmiXjwbTnB6fS33uu44tPdAXzFJBsbsQE12LgM4eRzc/5oNHVjShsryEevbm?=
 =?us-ascii?Q?y8QZKG+PxIJcYjp9GKgqilMnBI7UlkLsww1VF3M65EPT1dsLMJNFw6ZPXfbd?=
 =?us-ascii?Q?lpb865qmElcbJ+wfmfJReP7QeWSGWowY0yXso76hudveFczFWoiH1YnzveN+?=
 =?us-ascii?Q?z4TIPjpVBsFB9G3NUSOHuxqB4gdxHR9KKHABqDqL++oRQwikgLq6DmRERPmZ?=
 =?us-ascii?Q?P02rpgEUokreb99dBwHRza4h57F9s1fxc2kxG25M7v9tR5dk7icKIgUk4zTJ?=
 =?us-ascii?Q?9254xVsfiBNIvSc3JmF0JDN4z5xTxj2Ina0AFqaib3tFMs2VRAsuWY+IcLSy?=
 =?us-ascii?Q?G4/QyvgLRbqERzdLZkl0iWEbI0O4xatzDaciHTxXx6yxSCJ/Thw+6/hu2/GH?=
 =?us-ascii?Q?Gw364r60WRQHwVdRiLfz9pnOnFtia7AIm3GGlsn8hR4cyaezjqlKhGg7pNJd?=
 =?us-ascii?Q?Qmh0udJ7zPpEunTM3koe4GsoiaxIPAjS0ILBOylLHdH9TyuImHqrOy2mzvL2?=
 =?us-ascii?Q?ron4o08sFka0mibUP3UePBpn4MHbSEz33fDtDRSDbXwiXfKpeZgvgl2hhGSH?=
 =?us-ascii?Q?8yAipKJEMJQvN48A4jkYc+P7huSZsQSBAcqk6R8YOCi0vBugs84foqU9SM/z?=
 =?us-ascii?Q?KUNYgq4mXxNrx3lZMSyMt5pZk4T9ntFCALOdM0OD?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e665fb-8093-4e21-0ac2-08db8c1b3518
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 07:54:28.8787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JLsZ2S/d/QnCoI/3PBWG5trlG60AgMPeoXohz//f4YhI7Gn2ram3FpWSN4vhDSj6ZW4l+J/uBtl9S8/V+pvj2w==
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

Add 100MHz and 200MHz pinctrl setting for eMMC, and enable 8 bit bus mode
to config the eMMC work at HS400ES mode.

Also update to use Standard Drive Strength for USDHC pad to get a better
signal quality per Hardware team suggests.

Reviewed-by: Sherry Sun <sherry.sun@nxp.com>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts | 26 ++++++++++---------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
index f841b722597e..1314383caf76 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
@@ -119,9 +119,11 @@ &lpuart5 {
 };
 
 &usdhc0 {
-	pinctrl-names = "default", "sleep";
+	pinctrl-names = "default", "state_100mhz", "state_200mhz", "sleep";
 	pinctrl-0 = <&pinctrl_usdhc0>;
 	pinctrl-1 = <&pinctrl_usdhc0>;
+	pinctrl-2 = <&pinctrl_usdhc0>;
+	pinctrl-3 = <&pinctrl_usdhc0>;
 	non-removable;
 	bus-width = <8>;
 	status = "okay";
@@ -200,17 +202,17 @@ MX8ULP_PAD_PTF15__LPUART5_RX	0x3
 
 	pinctrl_usdhc0: usdhc0grp {
 		fsl,pins = <
-			MX8ULP_PAD_PTD1__SDHC0_CMD	0x43
-			MX8ULP_PAD_PTD2__SDHC0_CLK	0x10042
-			MX8ULP_PAD_PTD10__SDHC0_D0	0x43
-			MX8ULP_PAD_PTD9__SDHC0_D1	0x43
-			MX8ULP_PAD_PTD8__SDHC0_D2	0x43
-			MX8ULP_PAD_PTD7__SDHC0_D3	0x43
-			MX8ULP_PAD_PTD6__SDHC0_D4	0x43
-			MX8ULP_PAD_PTD5__SDHC0_D5	0x43
-			MX8ULP_PAD_PTD4__SDHC0_D6	0x43
-			MX8ULP_PAD_PTD3__SDHC0_D7	0x43
-			MX8ULP_PAD_PTD11__SDHC0_DQS	0x10042
+			MX8ULP_PAD_PTD1__SDHC0_CMD	0x3
+			MX8ULP_PAD_PTD2__SDHC0_CLK	0x10002
+			MX8ULP_PAD_PTD10__SDHC0_D0	0x3
+			MX8ULP_PAD_PTD9__SDHC0_D1	0x3
+			MX8ULP_PAD_PTD8__SDHC0_D2	0x3
+			MX8ULP_PAD_PTD7__SDHC0_D3	0x3
+			MX8ULP_PAD_PTD6__SDHC0_D4	0x3
+			MX8ULP_PAD_PTD5__SDHC0_D5	0x3
+			MX8ULP_PAD_PTD4__SDHC0_D6	0x3
+			MX8ULP_PAD_PTD3__SDHC0_D7	0x3
+			MX8ULP_PAD_PTD11__SDHC0_DQS	0x10002
 		>;
 	};
 };
-- 
2.37.1

