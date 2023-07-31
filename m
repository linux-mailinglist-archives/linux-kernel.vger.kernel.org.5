Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F0F768C2E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 08:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjGaGnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 02:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjGaGnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 02:43:21 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2081.outbound.protection.outlook.com [40.107.104.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D016410E0;
        Sun, 30 Jul 2023 23:43:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WnwWlh+hLr71ZkYCa7p3zYb3rYeDPeWSz8d6onpkxQHesFHRR9aXfLkEZoleQtZsfvwr+sWNMHt2iGLTUiUXmNebZSudlfZx4jdByW7p2vnlU924dlbjFmxXBSDm6njzENKD5vf3M5g3MipSMarnt5/6TFXbg1msHIhWHduU6pFQSHwL3mflypYqqY+euiML3glSvzc+++fIIjfr1ZGSC02KlBCsz+54CL8U22PKne5vFImLeSK7miXAJ3+0VHjntRAyJNjwHsGAVFlCABN15CSCiQcGVwS+vbR9oQBkRTPmJaTabbn5KYPOdPRk1lSKfqRAWnt1e7h4rMFXGzPMJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7GbvRVhPcQTXuxEftVUaeloxpR/jBxTz+ehgNyrG1U=;
 b=M+p0GMF9LGbEf/0TAT1fYtb5TDtjtvBRg1s9LInvDJ88tRmF3kjrQPxZRa3lRi3tQqrX8YpMnr+S7PtiCNPajybmSVnCx4oODRnt0/6nhPbgNcUInG/0B7fVtRi+47LSleyA+8VM42zTRBvS6YfdxM0BEanWIaZJC+RFS/IohWZOf4L4OyCyGnOl0b/dWY31jecsLnJetx4fN0DDq998f8cU2L+J6WaUbv1ysp3yZDtrShyxXllXBJbvA/DFtK3l4SJyEGK8ZmfZRwLa3Rwv+TuSPmHJta3SoCnmaEzmK1zDL7A1SkCVHK2n8pMBQZd0UO2Gc7iCCmPiQZrBQEm5eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7GbvRVhPcQTXuxEftVUaeloxpR/jBxTz+ehgNyrG1U=;
 b=A13VFZAGUUbmmcyRPCM3niQTiDItyhWwaR0uYOTVlBUHMs3mnET+rxyDjRqW/sFBww+94ZwN+eQ2y+2NvkalDJTcLbQ3LexkDSZjZE6ecdDMCtGdeSuWLCxTstYuRjjHXFjEH5UGWdsy/hIToYBSHGd1mvIkV07pl2bJbQN6tSE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6834.eurprd04.prod.outlook.com (2603:10a6:208:17e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 06:43:14 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 06:43:13 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     ulf.hansson@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 3/8] genpd: imx: scu-pd: add more PDs
Date:   Mon, 31 Jul 2023 14:47:41 +0800
Message-Id: <20230731064746.2717684-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230731064746.2717684-1-peng.fan@oss.nxp.com>
References: <20230731064746.2717684-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0133.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::13) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM0PR04MB6834:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fb8fa12-78f7-4b13-1f13-08db9191699d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NDz6mkPNGcUDk/Bff4TV3sTTk5XvsOIyyg5N92WTbwBRqqzZGG1+Dni0g8GA+5uOEDThfJI24foeQhFuXkEHfVRf0Ke0cOU/Xo73rYZ6E1XHaJCYo60ZnZ4pLuMSdTYCFaWR5URc+wKwiSmxuS6TEoYkcnE7ElEtB8MhbonB772GKrMVRZSoJe6rFNEmlChByprP8YsLeza8ZEArhuSYmy454TQzYREOOIG+wES/auYPsheV6eHEegrmyGiZSyLFrjg48IxjNMQmE8nr/hUCiVfpsNibUvxmQwbPrr1xEkA74JWqogbgZzlmxYvBuGYMY2GxIwdOxfaYS/P59lNRuL0H+c0VKKovizxUOKFQ3Z+hNV5wJIWRCNCCNFpMiiEi6kr/776MgUeOiF+dwnxEYoaUcrnt8B9kQTn7iZ+3D0ilpaOto5xqPnOQ7NX75V8zTHzveBDxVZZrnUFakdcNuWn5ZtPs1hqLbG0b2uSvcogfVusjP1lUR13gMCUQd3CzcdX5hmHdzXZ3KJu51+obgg9fOGx3+ms9sdktMPcKJbVuK3l9ONIioDIVOCZZgip8l0wWYwVUMbZ5ZEpzJfeDVA89vDQoDywKGXoDyyyARxvlx5sWbQgIGJEYZ26Ip4mO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(39860400002)(346002)(366004)(451199021)(6512007)(52116002)(6666004)(6486002)(186003)(83380400001)(2616005)(86362001)(38350700002)(38100700002)(26005)(6506007)(1076003)(5660300002)(41300700001)(8936002)(8676002)(66946007)(66556008)(66476007)(2906002)(316002)(478600001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NzflYHZJgWGn2pUu9KXCFUoCFEJCSAlQfmjL+QTfecHwF0h5Dx+UXVae93jf?=
 =?us-ascii?Q?CZPN8jA+EljG3pg3zmxC8fl990zl6S6Xmqlf3JZENsEmrRXpitVGwVYBq/F0?=
 =?us-ascii?Q?zZ0nSB77NEhLRRler1nRURWprpDx59dCQ633fa9GqQqPVb07X84lH9OgP5GM?=
 =?us-ascii?Q?+o1oe5N7YJDo1OBVW9VSoZxss614EjTSG7nMJnfw8RkaAbecbVyaaHMfAeE6?=
 =?us-ascii?Q?gn5GCRBlTx8j1Br/eMO7tpAP1f6MQGjcuzb3pDcxzQ0jzKoeU8siBI2qmJ2C?=
 =?us-ascii?Q?WHAxKniHs8uMU7ZvtDOt3AbjtTxaVZWaLvNFG7dv0DnLw9sOJQJR/Ms67BQb?=
 =?us-ascii?Q?rJ4elhpO5zZ3aXmdWmc2HfwJmg/E+grY/PoHzg8i+nRgJZh50pfZ9Fwd1yG4?=
 =?us-ascii?Q?7QpbocD7g+DkBZAz4f7m2ablo58jei+VDo3HOFGQ/0pMt9JZJQPpOut7ePR6?=
 =?us-ascii?Q?7Q+oE8snnDU5441YZj4NV2i+TjKgW5Wo1Yd0HoqI4l/ydhExH223LQ6AdeXI?=
 =?us-ascii?Q?56qP/AUJZx3W9QyuzeEqtQHP84PuWjeiQbHP4f+4trGBCSv+KjVWxXoba6jT?=
 =?us-ascii?Q?Oe9pRr6O0RDf9zcTYq1pR0wGlP//UxDQ2aggqckttWxuViCxIQEhzcx2i8bf?=
 =?us-ascii?Q?1nQQ5ZsCLmLwfmYlFRfAb/X002v+MZcNFPKSAnY2rz//cV67vyrRbtQZ/bwE?=
 =?us-ascii?Q?KhKlwJWRs6F1V2TDZlc1d59Ub94OHzllWvS5vzNuTLTmsUieZryjU71/qqsZ?=
 =?us-ascii?Q?2Z4TN9CfHuneJmV+EOa/MOyPTpakHQ97B0+r514p44oSyyVPa9TDdTXy24mK?=
 =?us-ascii?Q?cGJmoaQ/MTo5jyHn58WsKH7lrg38MVNuOt6Yznf9gYY5/LV3qrjEdIO8pWBr?=
 =?us-ascii?Q?Dy9wdefMwedQ7teTB3hVTtWK5BqY/+EZPT8aMceY7FqKBEmX2rDZZZcSMtFG?=
 =?us-ascii?Q?Gm4AWHY44/T+hDbDW2mVdoF8gEplyF8w20dcHtLNLxbU+rltk4XMVqGmDmYH?=
 =?us-ascii?Q?zPrEO70kLSMeDzYqC+66z4mKhEVUoBxfuGmUpKmMI0xvFqPCtxsVuALVS03T?=
 =?us-ascii?Q?dS87zJ1NW233lPt6t/oATRkDbGltfcSFkZu7HInZzalJtRwzdHcv9EaqrwMA?=
 =?us-ascii?Q?s3F+g0OdbMkCsgBympxC9fX7Dw6XHk6kdsaqgG7OYONsF0GIJYASjPITgNGW?=
 =?us-ascii?Q?9nsIb0ywixqIkg+U81FN5aIiglwLIzX4N4t+SSqAZLXgWBJ70Cslj/t7L0Js?=
 =?us-ascii?Q?0SQRCVRaemowGUSqhDm+wCZ2BSBqCGi5go2dZcUd9QvWt87XbWVuzFjVLVci?=
 =?us-ascii?Q?XTJ+Umr4GBgiqce6IS+o/EelipbycRZtFybwEuLgFoAGKpfNP8OCnRuA210f?=
 =?us-ascii?Q?0XmWSIRm4yAgE6N758mdT9qY0nZCFo0mG6R5T3x23v9d6koTjun9+cHITUfe?=
 =?us-ascii?Q?Oxg7CM6OsRlf8l/d+A3Mba40gqDqgT94D7CANfKZMqSPkAOSOzGNz5j2E3fz?=
 =?us-ascii?Q?us9UmUFYJsXHK4206qi6ZME2lmOj82NDtbGbOGOz3spmjDxPf99LYkjsH2St?=
 =?us-ascii?Q?575+Y0OpDEc/AL809p6SEi/4nxM9S/yR5pUwuCc3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb8fa12-78f7-4b13-1f13-08db9191699d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 06:43:13.2787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8I6mJb2Uspc81O16yWVezswkKnRh2g42iSBU6ZVIfP5paEB5m80myaDctGYYwPAedl+NIP7nyI5sRCdzv9pi8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6834
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

