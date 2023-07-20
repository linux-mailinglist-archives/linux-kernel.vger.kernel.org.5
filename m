Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5905D75AAAF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjGTJ2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjGTJ1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:27:39 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2082.outbound.protection.outlook.com [40.107.20.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5AB72700;
        Thu, 20 Jul 2023 02:12:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hUhPKcLosDcgEMS/39dKhNbXo7giIFhgO4Et+iiP8+fOAem2x821EllEc3VQYi82wKlgEYS/lbmx0xwgkcioUYtNh6gUDQI0diP+2JHnAG+jHMGscshlrkF5D3A7Ea51Kxe0oq1MoWSo+VXJOt0r5TmfDPKyWrRdYzcUsxSN1Qi2dZ2IrWlqWPW0LwDvYOw1swRuZ90WO5/9ZToXOuLSu4LY05qxMhB6+oWb0s5U+XAwIE+/2tXKbcPSk6YkNnUkUQcoXwy02TN1Qv47SbFxHntjznlTd07iKIee3LJFRnO6WTYX5RdgEUe4M79YstHpPMVv5VizmAwq9VzxW8Mscw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7GbvRVhPcQTXuxEftVUaeloxpR/jBxTz+ehgNyrG1U=;
 b=Yxmr1thRzIGqqy4W/c1s1A07YMimD3sYiomlxawJqCQ5AOM1zpOkYDrCegAD6Y4ayn/TPE/M0vE2HOTDgQPkfLIq+U/gl66zVT7/ZbMnNZNTnmhJSdVS84Kx2r+Wl7KtTEF69g9Uca1h3dr7InKraCLyJoljVymj9NkAW8aTMpKxuu5sSo6n45lSlGlGajQMNZFwbC5I60ZREp6B5+metkUB6+y2zIXhyExdixpFKddUhzbjLucfvH9bQIALTrWDEV+PS8+XtzhKhL0heDIECksKziwdyYl+BzcKwSPWWa6QZbr+mUgfl3k9RTsuCXGCv0QL1SOwMBSiL67meHef+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7GbvRVhPcQTXuxEftVUaeloxpR/jBxTz+ehgNyrG1U=;
 b=X+SdB8BEV5k0A+g8cL1Ioz7HRXvDzFi5f+BKQQck5o7odHS1eEfCCZo6sA9SOiZykI+f21W8jU23dlTcFae3+Iiis5EJN0p4DWZBcwPc6yTofcwEPW7EZ+nmI5klAqucuca75wmS+0LUkzAxoRi/OxcDcCj/96cb422vOukBrrE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8943.eurprd04.prod.outlook.com (2603:10a6:102:20e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.35; Thu, 20 Jul
 2023 09:12:26 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8%5]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 09:12:26 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     ulf.hansson@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 3/8] genpd: imx: scu-pd: add more PDs
Date:   Thu, 20 Jul 2023 17:16:56 +0800
Message-Id: <20230720091701.517197-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230720091701.517197-1-peng.fan@oss.nxp.com>
References: <20230720091701.517197-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:4:196::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB8943:EE_
X-MS-Office365-Filtering-Correlation-Id: 61b86f08-4ecd-4478-cc5c-08db89016f80
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MF+BiYctRaNrlJfgyJG/A3Ep4gQvSApuzjJR9fvqQDyb3nR3SeYaTIErn2BY1xeRD2zmgp1ewCjayIcGeOzyIpLhayRL5r0hZC5ZnRy8U32GdXhaK/l+lC+VFS65O5hrw80W7OKLICm6k/fGOW/4JQ3ByxEkoVpKEeefkfxHrAhfX6i2L6Wwkv3Iq0BiJTt86C40v63j+szzxtkLSphbguv61mYeblrHdfvSBIipPSh/JX1Jy2UHdXrxhjFPi5b3xLNOn3CBFEiG2jUjTiD/CGtP2Pb45gGs14Z/031TcVWHC/g9vdwuNZoDE92RdEnaK0X+NoIrPxT9QrbA7gH36/xm8IGetnYKs8nVVaOYs/Fq693DVF6377fHVhcvbe2FO9dcnRBpjBwKKLM6NFMxtSkMC1mMjW/aIQNYWkcyOM9f8uoOOonPQ4KtQ7TrVXVeBoLFvlrPQ0XdnD0NEkNHBLY4uW+UY0KLmsvhpcUlVgEtm5g4voCNMLpVctD/fG/xNNo6Ks52rHKlMKhuJnWnkVemjjbHkiREbigrx1xVesEDotPi+GwOYCDPm58q0Ipy06VOCLMXuY5yxRBQKh17Y4HIQSzBMshyOVQE69PxRs4/44POxYOuU4inh/ptuW1l
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199021)(66476007)(478600001)(41300700001)(26005)(186003)(1076003)(6506007)(6512007)(6486002)(6666004)(52116002)(316002)(4326008)(5660300002)(8936002)(66946007)(66556008)(8676002)(2906002)(2616005)(83380400001)(38100700002)(38350700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bpuWT1WffBTWxD0yUv+JhnEgYr6/7GimuzIi13WpD38TJWslS/+SoZccvqVm?=
 =?us-ascii?Q?zTQaYPPJ1bTIAO7fxXTLESQ0qXgXrFaqIJbXxrDooH881f09A8BwYZrg8wBm?=
 =?us-ascii?Q?wHM3nTwHIBFcQmPEKvhj3+IHRJyQYQPBuSPYUvni0aGbcyGRHruYqnRDxX+v?=
 =?us-ascii?Q?7GTcJjT03+VI2vFGGP9O1RzpVSlMB1FOPcBCTP20KWOWeOzcR7+Zr+nxqDaC?=
 =?us-ascii?Q?G3DkDgk4r9qhj83PgNu32MYfURE/NJ2EqVbfHeqbjlVxS1ITGBLXdCY3Ue+0?=
 =?us-ascii?Q?dpSrSuoYpkA2/PtIB9n77/tKk31XxJ5fWQTMvtA+kVFIkMpPVbKWG154HXGF?=
 =?us-ascii?Q?9tjlNpaCJykcdkQ204+FRUZdGqKgZiYbKrYiks7Bdn2io+l2Zzvme1M126LE?=
 =?us-ascii?Q?xTt/5vfkhbYncm4bsHkGaH+fm4C6R22UTsbGLjOXTvB338aAMnHCOce1BWqE?=
 =?us-ascii?Q?Hr+JF+GjhcP07bVZ5NSRTXoY7w4ZU8LOvbsc5Hlz+A7pQ+AhbwfP1yyqHf8s?=
 =?us-ascii?Q?ERnhvm58mJBsQabam7WLkwv2tiJ8sVigDlK2LMX9NWp7gCv6jvJS3rahUlX7?=
 =?us-ascii?Q?ZRFCwqUyhLs/O6jCVo22bgjAfHLY8QwR0vuxJC3H1C3FXr3hPHKuLLRqH692?=
 =?us-ascii?Q?fQOd3TekhptIEUfgloukObpWGMPq1LqqYSRM07xqYbxfUHa1KVJ3NGrDLqIN?=
 =?us-ascii?Q?B1pgsgCnDCC/MaBPssnTA6Vo2hUNNt5/STeaX67zXXwNo8l+FLexno5S4Fdw?=
 =?us-ascii?Q?orqmZyycW1PB35Mg3n2eshtRHvVeiSvgz7SO/SPTjamQY+bjj+Q9SXtV7kGD?=
 =?us-ascii?Q?myT1tToRqU6xCxr6fk7fQYv8RzrkSYdb3g5U38hjz8YF7GziOnH4qxDgr04v?=
 =?us-ascii?Q?g41QgmHpU6EQtcG7kwvUbVzWWPsSb414G/Kbgq0uD7pUJQuXObIYR/JyQKtu?=
 =?us-ascii?Q?G/dBsPU9Zimyj8sfbmSe5AYZlB54RS0HOkLbCZzFqA53UIKQhGE54KwEgVAb?=
 =?us-ascii?Q?CWEBMJdP4qJHIcS3SlLC1fJfhOtT8hbOm76LU5TEgktdI15TMWPxQMxKRA9o?=
 =?us-ascii?Q?CAFoa7BAikN/7gJjZML2Tr3fkubbwU65Jlo/3vKO4fNijn+xMGXr/I2/lFBi?=
 =?us-ascii?Q?7YmyLerpLZ88+PG+0UWyKlX2XY47qKuN9tKZ7qknqi0Uo8kO5XSFmOtoqumI?=
 =?us-ascii?Q?0a1HLPbo2a7E/86O1udWSNR1YPbTfVqHQIbkpcyv+TKVv2jX+EZXiRRypj3n?=
 =?us-ascii?Q?ADYwQPhIuLmSwViP31C9hEgLrYs3RA++80mGclCEVp1iuw2L/5EamXofbLC4?=
 =?us-ascii?Q?o5Cufh7z+VfxS67nUileHvBfaKsO4Q5kdeyEP8acd3TzjC6GDLh/2uNKTr5y?=
 =?us-ascii?Q?VPtIHBxj8Xb6+rVJdDg2WIy+IseqqXNsTb9/p38wZao5wAgllnrzLPyv8vbu?=
 =?us-ascii?Q?MjMbvF0tdZsHpD+b11JVlVMd/6Jc+ls/aYJ1qA+d1dbphjortrxcJ89B22x3?=
 =?us-ascii?Q?fyOPkRQpARQg4WwikGivvgrxckhz7uGaxXYe5BmGhA/FVFTvq2N+q2ww/Zrr?=
 =?us-ascii?Q?qVKOaQeeEeSH8Uxe7zEAH3YonWGuk22xgjRv6pbs?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61b86f08-4ecd-4478-cc5c-08db89016f80
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 09:12:26.3516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pG0XQNVFjNZkG4UJzApYIsBT1TJW7Tqyc1LirziTXVlDgBJWz9pZHD1TYwK+yFckcohnT7x9kWLYuiIrXNRlOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8943
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add more PDs for i.MX8QM and i.MX8DXL, including
dma-ch, esai, gpu1, v2x-mu, seco-mu, hdmi, img and etc.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/genpd/imx/scu-pd.c | 65 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/drivers/genpd/imx/scu-pd.c b/drivers/genpd/imx/scu-pd.c
index 5a28f5af592a..08583a10ac62 100644
--- a/drivers/genpd/imx/scu-pd.c
+++ b/drivers/genpd/imx/scu-pd.c
@@ -121,12 +121,16 @@ static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
 	{ "audio-pll1", IMX_SC_R_AUDIO_PLL_1, 1, false, 0 },
 	{ "audio-clk-0", IMX_SC_R_AUDIO_CLK_0, 1, false, 0 },
 	{ "audio-clk-1", IMX_SC_R_AUDIO_CLK_1, 1, false, 0 },
+	{ "mclk-out-0", IMX_SC_R_MCLK_OUT_0, 1, false, 0 },
+	{ "mclk-out-1", IMX_SC_R_MCLK_OUT_1, 1, false, 0 },
 	{ "dma0-ch", IMX_SC_R_DMA_0_CH0, 32, true, 0 },
 	{ "dma1-ch", IMX_SC_R_DMA_1_CH0, 16, true, 0 },
 	{ "dma2-ch", IMX_SC_R_DMA_2_CH0, 32, true, 0 },
+	{ "dma3-ch", IMX_SC_R_DMA_3_CH0, 32, true, 0 },
 	{ "asrc0", IMX_SC_R_ASRC_0, 1, false, 0 },
 	{ "asrc1", IMX_SC_R_ASRC_1, 1, false, 0 },
 	{ "esai0", IMX_SC_R_ESAI_0, 1, false, 0 },
+	{ "esai1", IMX_SC_R_ESAI_1, 1, false, 0 },
 	{ "spdif0", IMX_SC_R_SPDIF_0, 1, false, 0 },
 	{ "spdif1", IMX_SC_R_SPDIF_1, 1, false, 0 },
 	{ "sai", IMX_SC_R_SAI_0, 3, true, 0 },
@@ -146,8 +150,10 @@ static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
 	{ "lpi2c", IMX_SC_R_I2C_0, 5, true, 0 },
 	{ "adc", IMX_SC_R_ADC_0, 2, true, 0 },
 	{ "lcd", IMX_SC_R_LCD_0, 1, true, 0 },
+	{ "lcd-pll", IMX_SC_R_ELCDIF_PLL, 1, true, 0 },
 	{ "lcd0-pwm", IMX_SC_R_LCD_0_PWM_0, 1, true, 0 },
 	{ "lpuart", IMX_SC_R_UART_0, 5, true, 0 },
+	{ "sim", IMX_SC_R_EMVSIM_0, 2, true, 0 },
 	{ "lpspi", IMX_SC_R_SPI_0, 4, true, 0 },
 	{ "irqstr_dsp", IMX_SC_R_IRQSTR_DSP, 1, false, 0 },
 
@@ -163,10 +169,15 @@ static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
 
 	/* GPU SS */
 	{ "gpu0-pid", IMX_SC_R_GPU_0_PID0, 4, true, 0 },
+	{ "gpu1-pid", IMX_SC_R_GPU_1_PID0, 4, true, 0 },
+
 
 	/* HSIO SS */
+	{ "pcie-a", IMX_SC_R_PCIE_A, 1, false, 0 },
+	{ "serdes-0", IMX_SC_R_SERDES_0, 1, false, 0 },
 	{ "pcie-b", IMX_SC_R_PCIE_B, 1, false, 0 },
 	{ "serdes-1", IMX_SC_R_SERDES_1, 1, false, 0 },
+	{ "sata-0", IMX_SC_R_SATA_0, 1, false, 0 },
 	{ "hsio-gpio", IMX_SC_R_HSIO_GPIO, 1, false, 0 },
 
 	/* MIPI SS */
@@ -186,11 +197,20 @@ static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
 	{ "lvds1-pwm", IMX_SC_R_LVDS_1_PWM_0, 1, false, 0 },
 	{ "lvds1-lpi2c", IMX_SC_R_LVDS_1_I2C_0, 2, true, 0 },
 
+	{ "mipi1", IMX_SC_R_MIPI_1, 1, 0 },
+	{ "mipi1-pwm0", IMX_SC_R_MIPI_1_PWM_0, 1, 0 },
+	{ "mipi1-i2c", IMX_SC_R_MIPI_1_I2C_0, 2, 1 },
+	{ "lvds1", IMX_SC_R_LVDS_1, 1, 0 },
+
 	/* DC SS */
 	{ "dc0", IMX_SC_R_DC_0, 1, false, 0 },
 	{ "dc0-pll", IMX_SC_R_DC_0_PLL_0, 2, true, 0 },
 	{ "dc0-video", IMX_SC_R_DC_0_VIDEO0, 2, true, 0 },
 
+	{ "dc1", IMX_SC_R_DC_1, 1, false, 0 },
+	{ "dc1-pll", IMX_SC_R_DC_1_PLL_0, 2, true, 0 },
+	{ "dc1-video", IMX_SC_R_DC_1_VIDEO0, 2, true, 0 },
+
 	/* CM40 SS */
 	{ "cm40-i2c", IMX_SC_R_M4_0_I2C, 1, false, 0 },
 	{ "cm40-intmux", IMX_SC_R_M4_0_INTMUX, 1, false, 0 },
@@ -205,11 +225,56 @@ static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
 	{ "cm41-mu-a1", IMX_SC_R_M4_1_MU_1A, 1, false, 0},
 	{ "cm41-lpuart", IMX_SC_R_M4_1_UART, 1, false, 0},
 
+	/* CM41 SS */
+	{ "cm41_i2c", IMX_SC_R_M4_1_I2C, 1, false, 0 },
+	{ "cm41_intmux", IMX_SC_R_M4_1_INTMUX, 1, false, 0 },
+
+	/* DB SS */
+	{ "perf", IMX_SC_R_PERF, 1, false, 0},
+
 	/* IMAGE SS */
 	{ "img-jpegdec-mp", IMX_SC_R_MJPEG_DEC_MP, 1, false, 0 },
 	{ "img-jpegdec-s0", IMX_SC_R_MJPEG_DEC_S0, 4, true, 0 },
 	{ "img-jpegenc-mp", IMX_SC_R_MJPEG_ENC_MP, 1, false, 0 },
 	{ "img-jpegenc-s0", IMX_SC_R_MJPEG_ENC_S0, 4, true, 0 },
+
+	/* SECO SS */
+	{ "seco_mu", IMX_SC_R_SECO_MU_2, 3, true, 2},
+
+	/* V2X SS */
+	{ "v2x_mu", IMX_SC_R_V2X_MU_0, 2, true, 0},
+	{ "v2x_mu", IMX_SC_R_V2X_MU_2, 1, true, 2},
+	{ "v2x_mu", IMX_SC_R_V2X_MU_3, 2, true, 3},
+	{ "img-pdma", IMX_SC_R_ISI_CH0, 8, true, 0 },
+	{ "img-csi0", IMX_SC_R_CSI_0, 1, false, 0 },
+	{ "img-csi0-i2c0", IMX_SC_R_CSI_0_I2C_0, 1, false, 0 },
+	{ "img-csi0-pwm0", IMX_SC_R_CSI_0_PWM_0, 1, false, 0 },
+	{ "img-csi1", IMX_SC_R_CSI_1, 1, false, 0 },
+	{ "img-csi1-i2c0", IMX_SC_R_CSI_1_I2C_0, 1, false, 0 },
+	{ "img-csi1-pwm0", IMX_SC_R_CSI_1_PWM_0, 1, false, 0 },
+	{ "img-parallel", IMX_SC_R_PI_0, 1, false, 0 },
+	{ "img-parallel-i2c0", IMX_SC_R_PI_0_I2C_0, 1, false, 0 },
+	{ "img-parallel-pwm0", IMX_SC_R_PI_0_PWM_0, 2, true, 0 },
+	{ "img-parallel-pll", IMX_SC_R_PI_0_PLL, 1, false, 0 },
+
+	/* HDMI TX SS */
+	{ "hdmi-tx", IMX_SC_R_HDMI, 1, false, 0},
+	{ "hdmi-tx-i2s", IMX_SC_R_HDMI_I2S, 1, false, 0},
+	{ "hdmi-tx-i2c0", IMX_SC_R_HDMI_I2C_0, 1, false, 0},
+	{ "hdmi-tx-pll0", IMX_SC_R_HDMI_PLL_0, 1, false, 0},
+	{ "hdmi-tx-pll1", IMX_SC_R_HDMI_PLL_1, 1, false, 0},
+
+	/* HDMI RX SS */
+	{ "hdmi-rx", IMX_SC_R_HDMI_RX, 1, false, 0},
+	{ "hdmi-rx-pwm", IMX_SC_R_HDMI_RX_PWM_0, 1, false, 0},
+	{ "hdmi-rx-i2c0", IMX_SC_R_HDMI_RX_I2C_0, 1, false, 0},
+	{ "hdmi-rx-bypass", IMX_SC_R_HDMI_RX_BYPASS, 1, false, 0},
+
+	/* SECURITY SS */
+	{ "sec-jr", IMX_SC_R_CAAM_JR2, 2, true, 2},
+
+	/* BOARD SS */
+	{ "board", IMX_SC_R_BOARD_R0, 8, true, 0},
 };
 
 static const struct imx_sc_pd_soc imx8qxp_scu_pd = {
-- 
2.37.1

