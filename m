Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A70768C2D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 08:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjGaGnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 02:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjGaGnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 02:43:15 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2077.outbound.protection.outlook.com [40.107.241.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06379D;
        Sun, 30 Jul 2023 23:43:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nv9sa6UaqDSAgSMEgRKHiALA2qIO3JImwAbTer5kLG4Lu3S2XsPLTNmh2ob2+ckfUs5p95sqSBy96L2eo1hITf34EhQTb2PXfUqDkIOKHWjwzfgCmp416XEumYMwTcJBaG1GbJDipuvHkp/umhkMKQXEi/foobUwSYTrUw1BsViAjS+LwkzOsQvtm18fbrYyBrztizDlXdfJ5EFW5A2Z2UXEsk8yF26SjcYOvg5GyyiiPI+3NakxFymTxNUZ2PHpgba8MGN0kCvZmmL4DdyU3eHIwhMSLD5cXUZrvkosz0WPhhrKXd5jITXNBOVqsUHnFDc6qbWis/+a94j8bFe7pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YhQoD2TPdn2oyuDeTNC+2pCtRGqQB5NBDr8lpk9WY9Q=;
 b=EVIsfA5BjkPAdLdFyLvx9yjD8cDedGWitbM8/uMqBUi8jIMQS8KD7OxJInXmet/645RFYY8DNuv7muIR9t2IEYlZ+IkgiXHnfjnkZFElIRpgeKCi3FUOnb2gsUgBJaj9raWZskpNTvPY1BoVjAHo5IZ6UGZJk7351TxWlyWFEga7ptmVu+dBEnNVcnflOzwUIJs0FAofSWxyq8VMa7xaqlOJpCj03MFbzAo07ffhxFyas/EMHywhF00saxz5jn03jA6zt8m/t22EHBQzNgusbncTJpMGfR/wGizVnknwt48XVmWNLAssMxF57ivmJ9wo0sk0oCI6aWnyHH2gTLkJ7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YhQoD2TPdn2oyuDeTNC+2pCtRGqQB5NBDr8lpk9WY9Q=;
 b=AabOEozme6eDOhyj10cU6S0zZ1gwUG2IrSDajSIdjBoM7H4Y36zHHB5GsZQT899H45FzfJwbW1wacm8o+G6QLoKwt/gXETMCc4KxabfBp+a/WtJDhf2x65MEQf0GVbgojwrNzwIJ1yI+9kwg5nBB4N/6xiTpDBifkWU+Qy1H1lo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6834.eurprd04.prod.outlook.com (2603:10a6:208:17e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 06:43:10 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 06:43:09 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     ulf.hansson@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 2/8] genpd: imx: scu-pd: enlarge PD range
Date:   Mon, 31 Jul 2023 14:47:40 +0800
Message-Id: <20230731064746.2717684-3-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: b19362e3-b696-46dd-4f84-08db9191678e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zq7KXu2bw4ntQ1C52QTtvj3ds8uv+AAy5FaidWOaK6mWzDPopdFQYPz3bonnEhqWeCUVfYTlIOGeVnlSTmXRt2J56g66kXtQNPYtZ3Saq/2dR0KdK4f77ApxGR0zMzg4rQq6s5o/RZLv3GQDvSh8yTlMyZc/Vl/Jbfz/9xjDOQa8RcbSkqPlEAsYN2ySxZQddHOhqKFqfBAlJws2exgOQ8S2SfotRrXoMkxzHRJNrSKj7/qLMxvBwRXOgjV83MZt/InxxqztaE21eYpVI5/yV4ylDXYQiGz2tYTIGY57NTrpfLLnzwTSfkxaj9rPieaaV0jncJB6udVAf3ZjK7DEqg8GomIVqwUJS4cMOVyiwu3W5BdVnMHYd/IOSdOAemug6t71VyevioonwuS1PbUwrdzfuQNHx4hNnJsNMQmt2onk68CJ10jjxWEn+pvcx3g9G/FjLGMI5dHNztJFjyJ+MUarLZfBAUInxmrsmMefhCwBRH6v1CfI+Sxg7/jYG5sjwEIUlfcaPLeoTFKptpafhH9H8pbTfaTDmgk7e7xbKzA5DKIWEMkAaYOXdJWqqhaCGiX6duP1aeYTr9zrmehHcLdstAreD7GSm1YhVch1xGySsgNLXPuYWmA9OQH+sC585W7908cgSxVp4xNk/Hd8+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(39860400002)(346002)(366004)(451199021)(6512007)(52116002)(6666004)(6486002)(186003)(83380400001)(2616005)(86362001)(38350700002)(38100700002)(26005)(6506007)(1076003)(5660300002)(41300700001)(8936002)(8676002)(66946007)(66556008)(66476007)(2906002)(316002)(478600001)(4326008)(147533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?17YxNnsw6nQvGmA1ulXCQMWYzUIO76aN4EP56gHWJSmM4nzYYVg7hYo9eruC?=
 =?us-ascii?Q?kzsim2MgUpYK4akk3ThXWPo5e1lS2ezrqNZxckvwhI5eQd4D2ZMoVtZOJ5A1?=
 =?us-ascii?Q?ftjTiqSXMV+NvZITUqo53IzRRug0h4kyIDDcVfQR9L4KJYVC/av6sqPPSSXo?=
 =?us-ascii?Q?UFNR8OO0cuAxuXAmPHNtvoNAqgaRnMM0qx+Xf2XeP+oFhngYOa4NpegpRnPz?=
 =?us-ascii?Q?5LZ1zDX8Of3/3XIYnkhbNxBEUbJVir3SzVHJ9vbYOxiofFZm5yvfEjOdSzV9?=
 =?us-ascii?Q?/vInH6/AdMrTpHBztxWt69PsoS0wzglDPKommoc4cXTUBRRUYQw2g4WcVTXF?=
 =?us-ascii?Q?WTIRJqmUAJtqfJRBGW4JXcCmtKV339eMLwxZvtlCr22xIWWN4jZR0tvsHICt?=
 =?us-ascii?Q?h76KL+0HIRFuJk5r2mY7wPD2V6MP+/qWjJFMwR3tRZV2uJRbtWhaAMnE42Ag?=
 =?us-ascii?Q?rTAMl6bmy5/I548sz7wtrupuWzfopXj8NFq5kEcmp7aHxrDo66BJ5jxQUMkG?=
 =?us-ascii?Q?ODA8uHC791LJYIMxpwCMh+SvzE13Gp27IcMkdJiI9zNr5PqV6OmRXqL6RQCS?=
 =?us-ascii?Q?gRq0wGYcqYkRI9V9UvYqHCgHAZ1uWm/WpozJvgbcKmq6WNSyiQERPOqU/HN9?=
 =?us-ascii?Q?MbWxVUG6qJBWFbJq9HsvhhOcayf/Xx4EKIWKu0iE3zGEM7YgQyMNRPgVu23n?=
 =?us-ascii?Q?S3IfcDZSBZ1HoXNwL80Oq91yDLE6+MRdGCa4Es+KSRwNIfbDjALcU3GJtW6Y?=
 =?us-ascii?Q?k/uTUXtQbJrzDNUM5KF8nROWVcpW7jIDJIe+xTwGjZL6X+oAXnwXSvsJSbUH?=
 =?us-ascii?Q?CC0Ava6hcrVXRdAoxIU2sAxUtPCgzMlws77LQ0ymBJQN9N/KFAq/kv6knVQt?=
 =?us-ascii?Q?qNF9y4qul5mFpcY3kuiN+EzS6a8QU9suJLoRmOcasNgeubRCY0hVBlZS/P92?=
 =?us-ascii?Q?vPpnA98rd/OpXjyUWok1BUUpY2Wiifi+vKOdUVO2gV6/w0UiUshiMqdWeXfs?=
 =?us-ascii?Q?x/6DutjqdGHjvJcAnO1XWY7Bd0pGIK9boG1HEaJgke4SSWLV13HNkA5nwTNB?=
 =?us-ascii?Q?R5NcytCIwJOXf51tkH3H4eVUwJUaHXbjIZTLjEv7kt6iestLYoqPJ1GMSPJU?=
 =?us-ascii?Q?MRXgb/eG6YaQY/HWykQtW1zoUhHgJ5R2X42PDeAgnQuBjmsRJrms2wK+FF/B?=
 =?us-ascii?Q?6sBIubxgaT+26r5J15e7f6FoKtaGFEAngcXMtclFJ3GRfpMRVnj2esDtrNrq?=
 =?us-ascii?Q?fbqV6+t/i9vJPbKU9bNJdJTs+GpfoA2Cs8U8KHaStBIK/AjW5gAtMSv49oQk?=
 =?us-ascii?Q?gm0q9K/Ns/CViGMqwujxDftO5ZgFzivlYlyvsTfuTlIx3OCs3KFlCezpDvzP?=
 =?us-ascii?Q?apWudH/oo3MU5LKkwkTcJSV5JjiASU0d6PT2ZNorTtaWQPyBKxN2eiilYLso?=
 =?us-ascii?Q?xClWCAeZZbkwjIADyTG776dK/x9miBj3sH+tYBksyHI9N+6M9PKggRMzY/5t?=
 =?us-ascii?Q?ChY/K089XryePYtTdyH0jv6ksWNntduEE6+/ftBzq8NuqdhWX9/W88D/4JvI?=
 =?us-ascii?Q?nfjxiBO8CpF2gdwG2WFCoT6Aac5GQRLNSZGETJS/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b19362e3-b696-46dd-4f84-08db9191678e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 06:43:09.9297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PL2H5nV68GIAJAMGUS4t25sZhTJuvc/8//YM9M36+8m7PMryxRD516zI8l2RvXNPlbMB9VVuaz8YIRLIQc2SPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6834
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

There are 5 LPI2C, 5 LPUART and 32 DMA0 Channel resources per imx_rsrc.h,
and they are in i.MX8QM, so enlarge the PD range for them.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/genpd/imx/scu-pd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/genpd/imx/scu-pd.c b/drivers/genpd/imx/scu-pd.c
index 84b673427073..5a28f5af592a 100644
--- a/drivers/genpd/imx/scu-pd.c
+++ b/drivers/genpd/imx/scu-pd.c
@@ -121,9 +121,9 @@ static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
 	{ "audio-pll1", IMX_SC_R_AUDIO_PLL_1, 1, false, 0 },
 	{ "audio-clk-0", IMX_SC_R_AUDIO_CLK_0, 1, false, 0 },
 	{ "audio-clk-1", IMX_SC_R_AUDIO_CLK_1, 1, false, 0 },
-	{ "dma0-ch", IMX_SC_R_DMA_0_CH0, 16, true, 0 },
+	{ "dma0-ch", IMX_SC_R_DMA_0_CH0, 32, true, 0 },
 	{ "dma1-ch", IMX_SC_R_DMA_1_CH0, 16, true, 0 },
-	{ "dma2-ch", IMX_SC_R_DMA_2_CH0, 5, true, 0 },
+	{ "dma2-ch", IMX_SC_R_DMA_2_CH0, 32, true, 0 },
 	{ "asrc0", IMX_SC_R_ASRC_0, 1, false, 0 },
 	{ "asrc1", IMX_SC_R_ASRC_1, 1, false, 0 },
 	{ "esai0", IMX_SC_R_ESAI_0, 1, false, 0 },
@@ -143,11 +143,11 @@ static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
 	/* DMA SS */
 	{ "can", IMX_SC_R_CAN_0, 3, true, 0 },
 	{ "ftm", IMX_SC_R_FTM_0, 2, true, 0 },
-	{ "lpi2c", IMX_SC_R_I2C_0, 4, true, 0 },
+	{ "lpi2c", IMX_SC_R_I2C_0, 5, true, 0 },
 	{ "adc", IMX_SC_R_ADC_0, 2, true, 0 },
 	{ "lcd", IMX_SC_R_LCD_0, 1, true, 0 },
 	{ "lcd0-pwm", IMX_SC_R_LCD_0_PWM_0, 1, true, 0 },
-	{ "lpuart", IMX_SC_R_UART_0, 4, true, 0 },
+	{ "lpuart", IMX_SC_R_UART_0, 5, true, 0 },
 	{ "lpspi", IMX_SC_R_SPI_0, 4, true, 0 },
 	{ "irqstr_dsp", IMX_SC_R_IRQSTR_DSP, 1, false, 0 },
 
-- 
2.37.1

