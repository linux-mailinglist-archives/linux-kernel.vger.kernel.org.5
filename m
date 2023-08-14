Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A70577B6E1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 12:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbjHNKhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 06:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234243AbjHNKhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 06:37:02 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2052.outbound.protection.outlook.com [40.107.21.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB40F10C1;
        Mon, 14 Aug 2023 03:37:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aKS1gP68CO5IunWLIUjQsgJdU61zU7NetmuACj+uauyVB+VWOXn5yzOjdHbe0Yl7K0990IR8fXhLWv0Z2v2TkGX72ebgSeG7X5VTId/KgmKe3CRkOx6gdqR9teS8xpmgv2RapCe0suOq481MWB7uJlb98RIObRCN8SITTlcgtEYDIL9tPJSXrS0FZqVX0NvuTN9jL14CzIvUecIREI9TGxPWr+uouwAzaWALTbT2L8qZATeH0CSu9Ea3oq1BpYg8N4JOw2PjEe1u3OeYFyLsCBOEqguVvWiEZ+x+DCF2uiNUkSi7LQ1HiTPhzgvW/mfmo0+H9s8wzj5XamCTYKbfQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YhQoD2TPdn2oyuDeTNC+2pCtRGqQB5NBDr8lpk9WY9Q=;
 b=GRgYRb4sluVn7b3FABD7FweaQ8zYLBsWygnveW80yXZd2rnBlRfo/xMAfmMhlfMYwAHCLd9N5n0v0bjBCJbO1nt+dwOU73mUDZaScO706Eh4cPFloKHpjTH8rkybGS0tmTyVAsEfenSmiheREJTgQf0YLThhxbF3SaFDRpjbP11fv2M+dHQtePOPQBayhBRk+gWwO/8ouMSAbp2YZPL/yBYer6mpOnV1wOueJf+cpTcqc8v9SL99dApPrQTXbrR1/Vtje7bNWuEIvWGStRnhXxuo0Uj3P3HTztYKyBvWswACiFWDC72yumgKiGg4ZIhaoPOxIFjdAKTcCKz/t/gJyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YhQoD2TPdn2oyuDeTNC+2pCtRGqQB5NBDr8lpk9WY9Q=;
 b=NBpcMq+ipueHqhYMjRGEXTrjjEPQe6iHYCwc5EjdaHoiF05foJbKDNwsqs5jbv+sYT6hpxyLihzb4SILtzSjPnGpVqM8ahojmt7Weqn5pRdFHd0xwjfngX1GkGWlJWIO+Uit57uz9HP2jsiRgQmbfe0dt5rOTnPYbVoEXZdmO2w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 10:36:57 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 10:36:57 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     ulf.hansson@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 2/8] genpd: imx: scu-pd: enlarge PD range
Date:   Mon, 14 Aug 2023 18:41:21 +0800
Message-Id: <20230814104127.1929-3-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9352c623-c7ce-4a23-582b-08db9cb262a9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jK3miuyvva7VcK11OWnfJXcv5DRgDtpk+cNBeYGz7mCfhuUbHCyEC04Jqd5PJf36FcVjD7wVsz2lf+fXPmLqV2eDT3Oovqr9vkNCsy8CAni6kcmMGCOoZfvItOnGJTP9e2nkN8/rxS+7UxlSI1S0SvoRvjyXXFiTuqlq5hotyLuJHepoPzEmdKYc7BxJoUIVOYdKa9yp3ym9F9f/87oqVLAr8rHoZqNWWgmPm3nmTcEiEiHobj1TKxhWIC+/xx7juEJudzXwQo5ZDyN1UDY6FP7N1e8H1dRG+o3EHRnwu0R4gcv8BBcHH3orf8d148adj1bABhtwzkN5ORld2D0hxWYlk15r5OaYgWyR6JXxVQfwH9zDqNTADEu3VwNeayqRWoo9n8WXcHsdW9cTnGcP91rSnf/L51U3XopyJ3bcI4ouSqACL/PmX85fX+FdEb1c4S/k/UkrXbq++sB4cqDJvZkQ/F49BLFgkIhfepYAR0qDsu81a1JyHmCNOy+4Y/rOU+7xw7Gt4ttfUE7IGXL6j7g73Qfn+u0L3M6wfWpDkxDX5yQcM5MMd9A5lGNPE+elPX2quXiYzR/ey7///B+HIXwiZw+jnQerQWh1HBcTpf5coCFW9UxXu9HuZHnzgmFive6MzdDMtETfdawLfliAuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(346002)(136003)(39860400002)(366004)(1800799006)(186006)(451199021)(478600001)(6486002)(6666004)(6506007)(26005)(1076003)(52116002)(6512007)(2616005)(66946007)(66556008)(66476007)(8676002)(316002)(4326008)(8936002)(41300700001)(5660300002)(38100700002)(38350700002)(86362001)(83380400001)(2906002)(147533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yEtb/qv8HBMVqaEgFl/LODhwSEWM81aFPUEQqWxcqh2KohOiZPc98qoZ1fZI?=
 =?us-ascii?Q?2Ttz30hzsAgoPnYrRpAR00hc1f6fRRcoj/HRoXDhoQZLKejmDJE6ec1XN8zt?=
 =?us-ascii?Q?g21p/3EAdj1FMt9OVQNAnAQVCS8Y9KCKy1odcHAn/mkE3Pww+J2rWG6PJvm3?=
 =?us-ascii?Q?hD0M5v+l4jSk5CjQUMcIl526zslSdm6f8W1YfkvlYLcaVYFDtU+UJHar5Wpa?=
 =?us-ascii?Q?Krr9ciN0tva6ZOMSphi7ZtDzqc/TFuYySAwtu7+B8Yb9o90U9j0nya5rdoas?=
 =?us-ascii?Q?007JF/sv2Y6ov9Ipy94Aj2t49sCW5CkFaPME3B5iIZnvt2jD3fyQTWLxRnb3?=
 =?us-ascii?Q?YpDruX3Aq6iqyGyschixSEkCTt2QfSbdufiPmnAmP3yUVZvCHLzQGRZS7Tn2?=
 =?us-ascii?Q?Gwy0pzDEUUe8uZrh+d2vX/zwrrw3SnLwUqTDhCxlk+RgtTGc4WI94MieKl+1?=
 =?us-ascii?Q?AuJZZWzjVUG0IkaDZeVSnUEda/2DExxWRDYmzfraYQkyuU9zb0IReW1Olncj?=
 =?us-ascii?Q?6L4LmKePOW4654l0vuixrDPC3tdWF/EHRuItRxdHoOKEfXFj3X16Z2DJosxR?=
 =?us-ascii?Q?ppZxUMIR7SE+GcLjak0LgLc5gWjpA5r/XfKN7VFTk9vSTrkk0Hcp1XjMdeF8?=
 =?us-ascii?Q?UdXG5JFIT8XeWZfzWowHuF1Ze4gUIjFc39nllwy/dq6AIgQhJZW2Zp9H77qM?=
 =?us-ascii?Q?U5pEbgnRWPHwPrwWYIdjcT1UsavyHCFEbtH0zCu28WG4piNx+j5QB5qs3gc8?=
 =?us-ascii?Q?Kuvc6bkHsRMiLGJsBKz4Yj8wygKA4ZxJB2whLEvji6MaEyHF58mgAZOJDyPO?=
 =?us-ascii?Q?jAwYzRWr8cRXjLuAvtVde10+/G4YInyh7XFTxUSpvGp3irNSiEgWVn2/bEst?=
 =?us-ascii?Q?mswupE5JeALMV6UmUbk6E0KJSxch1h8qdcpn+kzdOfZQDcQOGBX0VCmoc1Xb?=
 =?us-ascii?Q?j5QnIurikoQ90EEGEaolv21sUlrkcNmbEsiyyUSiONq1mJnqW8mB/k78k8BO?=
 =?us-ascii?Q?ICMUSfo7uLu3oPLv2mVXfPP+WRjNbGvFeWhPYAI6Dlx+/QVLT0S3G3t5jOiJ?=
 =?us-ascii?Q?2m974wVsJp7KStBvAStnl0lbCJ/mOWiOQvgxARMgva9abdIikDm+NjE3ecF0?=
 =?us-ascii?Q?yT4fNtbP5tG13uAWcG/0JcWdZRcoOeCtxLt+9Gz1WsBzD+6CASR0RHxN/Fzq?=
 =?us-ascii?Q?52ymC2eMhwdZCe6oEoX28VAfcnGwzXCXHK+TwM2tmeGxTsbBnJrZlk0MkWG1?=
 =?us-ascii?Q?Ad8iuimPhYHtcg5YqSE5HTVC3chCxsDewKMsEtKyd9NrKPlI77g5ZjRUdNRb?=
 =?us-ascii?Q?yaO/C15g2+Uwhblch9bJLCOLmc3zG7JKqqFTgAtHMwxys3+28Hp+O5hvMh2N?=
 =?us-ascii?Q?aR+buAY2/4IrUFFa0HKO+hmZv06gc3vDKIbYHr9Jr4h1PQCb1/9gSpoDGPDX?=
 =?us-ascii?Q?/amQDWUdJme+SZ4kUBqyx5CYG3sUWdtqDOJJ5Lh53ofelFnx/5L69gf4nluQ?=
 =?us-ascii?Q?uHzy0YcqYKt1mAhlFa1NsoQ+rYVH62bkrV0CIXDOJ8DUh8ftSMoDdKbczXMT?=
 =?us-ascii?Q?48wYOuPt8Fw/gOrQ/Am5/BcdY7qTogFFKoXuPSK8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9352c623-c7ce-4a23-582b-08db9cb262a9
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 10:36:57.8226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kiQLVI8B+6A5OeVTDmL885bQKi3fg6UyHaOKr6XPgBcDrfiunW6NhhXPzXPv/3AukQF+hJQIP8L5FCY89ECzPA==
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

