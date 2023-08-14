Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12ECF77B6E3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 12:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbjHNKhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 06:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234467AbjHNKhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 06:37:05 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2045.outbound.protection.outlook.com [40.107.21.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3168510D;
        Mon, 14 Aug 2023 03:37:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cdKCUE3fQHlrLMdqOByIwfaVpMXCLgNSJ3lt9IDregwkPnPz7RRDdIA1kmBA/4j+GdhSSVkHBo3gRxGao049eKQcDN/ih/zIXkVrM5pBNjcscBVUbc2jp/HRF3U5vgcmeNf86WKvWFkxFB7OtmHsPuGGWB55cqDYsCcb0M9NkiG31HikfVx9ZanlZU/8s9aZzdha+mKrlhH/rS4vjZtMXDyH+4lLqP2c+kt+JH54IY05wQSU4mx3Pns5JrGu3+6vdvQzayCaHkkYFA/SbTUrxTSNN6bcmfoGPLVGHryMu31XZSYFmEA2oT/Gc8/JYr8i+c/ZtyB8innMx9RPhendWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7GbvRVhPcQTXuxEftVUaeloxpR/jBxTz+ehgNyrG1U=;
 b=DtW6xWrOh01WJ1RrqlCUZLl9bIfqM41WhHFYcVJh8mWOyuMgKVP+cMxyCYW8lK7Dgwsp2BcqoEEztqmbtuHrAC5K2AUmVjOYJVE9C3rSKwc8wzmMHzt9vmEkJ2lnaHdKFG3xENjiNly5LTBq9ssId33RHGwblxSGoeWxMXIBDh6fD/TvkWgHr4fLa2wJJRaZBjKwG0pSAseuceTGpMa2Feq0gP2KS4UVCzi3OwlmGkIvQW0C/cyZ/MYVKwrEZbLLQmskUdhMJX5nlVWEZu7QyYcB2wbe0zc7PUYTDjnCl4BMT4VLROpQeZGY1nxFBoQX73WQKEe9lsb8J2cSQ9lw2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7GbvRVhPcQTXuxEftVUaeloxpR/jBxTz+ehgNyrG1U=;
 b=RIPuPkEEVaG3ND7wp6RReZ6nPeU2a3Noz7fwpaMu3S+7cmdpnGGknLqHkUY5wZ7XItGThnPDnt+2T6tVhr8gFtWkIOc+VIoN6LXTjH+new+DG0WsIQ4WkC1nXPijnoS5QJF+SH6bv3qChKoPb9pnOAN0i6jJ+TWAki3alBqlQX8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 10:37:01 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 10:37:01 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     ulf.hansson@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 3/8] genpd: imx: scu-pd: add more PDs
Date:   Mon, 14 Aug 2023 18:41:22 +0800
Message-Id: <20230814104127.1929-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230814104127.1929-1-peng.fan@oss.nxp.com>
References: <20230814104127.1929-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:3:17::23) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|VE1PR04MB7216:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d407db5-7603-44de-151d-08db9cb264a5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p2198oHr/mX1YJHM8B7BAjlK9inu2zZ91VDgnDnnOiRhgVGVQ2XJtvHBVzB8AtFwlWOH8j95dxAGoFkjJHUP/+0LzGlYYHfkDv+ZlQ8Ufmt4HkazoFzR0KGA1TxLY9W4lbqiFoQiF4FSobVtFeMGabZiVinw3aI6XZ1NqFTclaSIlW96sYUCO6Hv6vKLZhvHKMEZkz+7M0oKBrznoqK5js8xIcv0o3akyAjiR46KBCBcoyUVd9UEShWxB7TxCMcQuFNs2xmY9mYrnkymbHERRrSSHVBqtrzHkMqI+nv1q9gFt9Yc/PmB/qjlyEaQZd0xMHJs7kpbkGT6INeslo080bBwELtAeudgi5FNHeTMqOpEhBuV2gmkVlcYlF3KNuln1LplPn4IcDYxHYUNJYKpvPut4ojKfY2adA1y8Rp6fFJbb0zg/x6QLNNpM5s94IVwynJrI+oPS2ew+/ZyZ5ZY9vAJ7P0JKXcStroZduFFKp6QJUqJ5Cow1lq+i3OISaOcPw0/ZpP8WZxOPB3bAqzBcwLRw5HExZbXkUCusz/6TV7scPLe/NrCV1eimgQ//zyzGiS7cFZ3QGy3Im980qJx3m3w6QuLCTgFt5siEcM4HzODaCDvnJ3CI20oKge0dq6B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(346002)(136003)(39860400002)(366004)(1800799006)(186006)(451199021)(478600001)(6486002)(6666004)(6506007)(26005)(1076003)(52116002)(6512007)(2616005)(66946007)(66556008)(66476007)(8676002)(316002)(4326008)(8936002)(41300700001)(5660300002)(38100700002)(38350700002)(86362001)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ikpnc7oBe7XiR81v0/d1uoqnk8BTD7oUScWOvm0HY4qLV3bj4DB+1Rejwybm?=
 =?us-ascii?Q?LXSA/n1EK9sWrAsd2EW0/cV55S7Un5PEIijGy+htfrRxf2BaR+84BbJ3d5ug?=
 =?us-ascii?Q?fm4nFRwf0kccN8R7NmSFB9oE74E5p5vJUQE24qpE8ncljgK3ZPutXtESq2jU?=
 =?us-ascii?Q?G8txmziHN0/Fr1HsW7dyr6esQ/6+pouY0ryJr1G29Vlt7JCJC+JBtjjG6KtZ?=
 =?us-ascii?Q?HXDzSmdfZfeFNN7SFlDWctkUOwWnomJJareNMd8+JWdombWpZxv8MU9K3yE7?=
 =?us-ascii?Q?h2siyuGY3WuVEEUr1dxQMEVxgtOUpre9W0vWE/SgpRgBSN4xfokvl/+TJrdU?=
 =?us-ascii?Q?cMZ+Ls40zFimZ2RlR77F7xMpWrhisL/912zz4ggyU+IHf9/7/L5YrWYfiTxg?=
 =?us-ascii?Q?IUsd6Aq4Cu2oc4kOF0eP7UL7XZV4APi83YQ+apQfMPuZlGoQkdcIMMntjN2G?=
 =?us-ascii?Q?fDnw9nqiSYB83dP7c1tz+vWWWGzkY8RoPCt5kHLR5sZB6izbd8rVpeS6SoLG?=
 =?us-ascii?Q?OX+fHsCORxCRKy3eJSNwoku1R18pWkezNT9+5zHXqm6OSbrPrl8YvSLxtQ0l?=
 =?us-ascii?Q?gISXJy6I8kZFgjj76dIyJBerKzC0sfdlCczlRyDXr2fmk9ikeUnuqBW0mjSe?=
 =?us-ascii?Q?KTsYP1WaBKOo2HOei09YASx5+qfNMLCXiOlMe7BsbcjdfORTiiO4FZnLujV+?=
 =?us-ascii?Q?IY14x70tsfbOtB5Xf2UY7rtCPTPpdvnYS0Ws0qHtPh3rSQwAEHsA8ogOXwZ2?=
 =?us-ascii?Q?KzhbVVh1WSgeCyBujFXeDBGdzzB3JCLREzzK7Y6jVemy1Bli68oWxt38NlyV?=
 =?us-ascii?Q?zTLbZ6oKG0pTfL4iaRNpDFJZsiwyPEHrEUC3W/RAcqm728oR9fO5a9elXwup?=
 =?us-ascii?Q?1hPpz2efcwYSPCQjSqWM0OsaEmiUOYY6iPWK48exojkvK4CzLr2P5onNd+m1?=
 =?us-ascii?Q?yXIhEI7zpurzIRUb2EqlZ+Yk8e9ljiEy8iPhV2AKIC+SV4sa+YiqynMCa1rm?=
 =?us-ascii?Q?vX+4CNs5hCzlfz8rcETGFxYnzp6i+V3sfg3Ih36X9kJm+uoRW4sQKEu1GIKL?=
 =?us-ascii?Q?HkqfOcNNRnivKObwLg9nPoyiez6NmkbsR3ZffdnmtBTYvqj3nIDSdc5yWY6Z?=
 =?us-ascii?Q?6EHE1aBPoPQ2XZqEVVC0/t6oW8gqEDKyUy+0DkKTSS/ub8UY2hKVZCFkvEXM?=
 =?us-ascii?Q?yHYJ6XUuxboMQf8ri8mwGV/qtX25jHUKaggz36GdKDGq89OWcavF7jvmtwtZ?=
 =?us-ascii?Q?kVkNtXNMcrUQpMJR/fOttKGDYSsr5+dA8RknnxuAW/91thARPiASIBQDh0A5?=
 =?us-ascii?Q?opOJG20X02ahsBSEk0+bxt/7KFqlL2dr5FvYV/HwVZV03OSpDlUvHoug5Z8Z?=
 =?us-ascii?Q?8ED/0p+G2zlRGVx6wM+tYNDgHtm6qBUC4NghNlHLwO35NYl7IK7KE/PNESY8?=
 =?us-ascii?Q?EQpxpQwuzzHC0g+oxGXnuZcyli/tOXVNAnptmMBuVVsOCLQ09o5DAs1DtaCg?=
 =?us-ascii?Q?M3LrkEfV9NQFSEHuer8znQzY/om6+J8m9mZ/X3WFT1eflTr39y8oUWlZQsXw?=
 =?us-ascii?Q?FOYM0BooqxyJPotTFMUTiybMiTgAM/1sEBt53Hi2?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d407db5-7603-44de-151d-08db9cb264a5
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 10:37:01.1698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jWbIZMzUa4lyLnNeATP+jHUSkUPC8OJJnG3sZ/28jutoMx73Wnx3rp4PUmTkedAEdMnYfSiEUSsq4bzCJuEGMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7216
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

