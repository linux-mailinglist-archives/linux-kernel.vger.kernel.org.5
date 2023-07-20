Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071EA75AAAD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjGTJ2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjGTJ1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:27:38 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2082.outbound.protection.outlook.com [40.107.20.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4D449E2;
        Thu, 20 Jul 2023 02:12:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNqF8W1NYLuw2Gz671TDZZZjmII0BtPQNBhRDkaWSZ9HMLwIzuCewWDGURhkzHUn1kJIHC9/fysBBq6Eer1rvOrL3D3Gxr4sjRp35MgRt6QhlGRON835VkKbA56Ay9VNJ6GaqUT7lJXQi0on2swPD1ORr40ClZHc9UX1ATLGkU3bLnptfvoULIbv5Z+b/jcyEJSUSkmwXoC5WhwBGWi2LD0fVWqNaAIJMvZuK6JenNizRDtYmHbXnEt9yK9DMhnM3cKgCzw+uO5zOxMHJ7+mH9bp5OeNiCIQdo6yuqaq9QbC3/JRXTLAntqPXf9FeMeT0W4r8pMMhM6i36C3lurY0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YhQoD2TPdn2oyuDeTNC+2pCtRGqQB5NBDr8lpk9WY9Q=;
 b=ha8Cbn6AHOAtlwS2+FL813qvYkN1w4/lsY/S4XsUIiwhzqtbc79sA2EGN+N4dlNATYlU2xMEjtzpJPy1LAwxt/wJlnKEbaoQY64gxpctV+Ay5puqmnNYPNQWDZVTkIkFrNpx3jdxoQoVgyeEWQLStBoUyN2YvJAFNKKV/7SxPYQYplYCWmTknKu02pUxVOTtB/sBlyRJ0K6PC9Eqxlwc62qWPdFb0hsOyQ3KcdOfvoWmsnh4uw2vBUiB3aWWkTzua0xkVWlWPF7vedOGKb/ne6w3vD9HBt+GDk3d6Vw4dEvbEoD4YH1qk63mv1EGyMtTSqxUiXev1lSKKBk0CECj7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YhQoD2TPdn2oyuDeTNC+2pCtRGqQB5NBDr8lpk9WY9Q=;
 b=COiPJhz5T8LFqGGo9EQIHhtI6yXwUI3JA/mGcowHAxar3IWdKZ7Brrhjqbs84/srNH7tc2DETFoG/gevDvwSeYR9Ne+ywc0T9hp/LvynaYBvQfnK4SYesZNusuhFZUYABLGZ/gexAUKtnNPzm4W4NDOcG/+5nmTZLXc7S57vDJI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8943.eurprd04.prod.outlook.com (2603:10a6:102:20e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.35; Thu, 20 Jul
 2023 09:12:22 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8%5]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 09:12:22 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     ulf.hansson@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 2/8] genpd: imx: scu-pd: enlarge PD range
Date:   Thu, 20 Jul 2023 17:16:55 +0800
Message-Id: <20230720091701.517197-3-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 52893e0a-81ac-49bc-747e-08db89016d68
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vIrTWDTJwu75+YzgGPdEAK9UqVtD8t+em26jl0TDsvk8DfpfZISsv2CanE3XHtqdiMzeUAWXTL5oRQp3IDgc0b0+tTywS7t4xEXbCuqSyO4pli+FGf7mp6W13r/wfB1EPNDg7YGf7AR/O/7gkocv3dskYpbEnukIm9HlDoi2w5a4mo1zYw+QVVO+FqNY0HrIUtxjwZa7cReWlBCgYcHQjc4KgpNovuuITH1fxrgNxnHCNjwMBplm21+4a5z9O1ZtVguZnkf4//Q3xvgNirN2FY3jswaUfHMZRubuEMGMD4sFeAMCwC/CamP1FID/K/tyoK7rRhE/g7aJ3QfE22BiEHbYCzuRh6nO+dyBTardZMi3da4SjS5cYyzkyYLmQKk4QeP0p0RRfAdj1JZsZ7SjDP4LpJdPuk5RIKpL4au3d741l88Y1z/ZyS3gl8rWQHc8eg51xuJU0gFal2zTN7lf5+STXB+fxwMXc3jvUbA8lpW1cTh7Z6NXPIAig3Sk+RCJGa6NdSkdXpwfd0UYu5egyLvukQD7lCami0GSUA1Da7FLlhs8rQiai+K9ZPLpf7I9uMEMlOxX/l+IcO8+mVc7nhMAHXoakinXMAQWDm37rdqb4OWyi10v7xfupMkRaRikczOziAUV/uomX4PK58Vsng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199021)(66476007)(478600001)(41300700001)(26005)(186003)(1076003)(6506007)(6512007)(6486002)(6666004)(52116002)(316002)(4326008)(5660300002)(8936002)(66946007)(66556008)(8676002)(2906002)(2616005)(83380400001)(38100700002)(38350700002)(86362001)(147533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/IAYcOGw1oH1g5+r4HZ34QA6BtNcQ1bGS0rJMzjddpI0yNXRrytHxsUOAtcb?=
 =?us-ascii?Q?vvXVWgXULKBXZH2APD9fK/ZkJOMd1F3lLf+e+JNs2hUIchbJPZo04FIvewET?=
 =?us-ascii?Q?c2hj/F9jplUV5eFFP6bvA5t2FK/Md8tPXijOuOXvVcuu7FBDFpsrxUteKcHD?=
 =?us-ascii?Q?EV2/NdX9ajcZHZZJ3lZmcPEimcs3Nvbksz8uUlbFoSSF0CWcDINCJ3mRFLJO?=
 =?us-ascii?Q?jnVsnspKWvwKRLy6o/CjmhK+1+PIw1zpYk2XStuIgcWNui/dtwZqCdKuvgal?=
 =?us-ascii?Q?43+y8W1T87jhfPuVBisviSez3VEiKA/CJYRiz3vktTxt4QUzMbZi1ZxfFb8I?=
 =?us-ascii?Q?QuDIt8cjCZ47uJrWmI78CAnrKao/HNYRjMInQtlOPB6SyeIIjklqdxBFsBhN?=
 =?us-ascii?Q?I+t1Sswl95tTWxFDVxwTR0/AhbyGM1djWoVzKZMLISDhEiJPKIcI19IrBpSb?=
 =?us-ascii?Q?xKKzE7roB4Bkvo0Y8xPS0dQBLqZ+P4AF/CZdRaiC4X0ye43j78n4NziHYlrw?=
 =?us-ascii?Q?DQVBss/LuI1bMw0HdXxFhMa5xWeYdI4k/U8f8kBPwKuLkHQBIpYUdX5JteA+?=
 =?us-ascii?Q?RHujARPLkQca7joiiSd8uaLEXa7T+8nQu22CNnLpGsYFUpYhyimxn0Q7YpaR?=
 =?us-ascii?Q?CAKciV3zHg+xkq2+hEvYTGbMGKSfpEe3o7NLPY1s/iAzNL4pcgwiWKJIV0B4?=
 =?us-ascii?Q?ktDW68XdSyV6w3Dsm58/M8c3qlHBdYNu7rjx3G+5hUA/BhsKXsZIaXqTmdgH?=
 =?us-ascii?Q?4VKyazxyrxGC7HAe+o4BD9Bxjv3TZXXFymwCa7aFVBhzd5QVFHkNmtk1t9dx?=
 =?us-ascii?Q?UOV7FEPLDj/oscuDGgDMBAYanuK6BsWcH73YBW0Wauowfwg5EQWyWOvoGTpx?=
 =?us-ascii?Q?wi9m54M/XsgRe8ffC2PgvYqpTgbOXPd49Qti8pvnS6jpi2W0toJK6hb8+3cD?=
 =?us-ascii?Q?4kkKQy6XkfPIdGN23wANAuBUqOAZWWke1ylpdPT9vWgqZj4S9AZ6cdGGTqpi?=
 =?us-ascii?Q?QiJ5824XbKzQBvq8imUzqBUtnh2a933jabhabkm+RELUXHjhT0PJKQtK0q2v?=
 =?us-ascii?Q?obzYMbJ/o1qen3V6Tv2o5QAun4B+Vy0ZhomUhD/OC+vVyOdolD6AWkoWD5N+?=
 =?us-ascii?Q?qJAW6Uj54NSatx0Gsw+MORkTdcwqrMT4HGUczPy0GfMXEwQM24LOCZZCX3dv?=
 =?us-ascii?Q?bqWdFeYxNwgRWLhZUT5phPmUNmpgJ5A+JKGrxNGB3LP9VD0sxr+LAH2qysUh?=
 =?us-ascii?Q?wHC/ORuUkQJCPFw+IUSnhNhPbvF4xJujc7qO/ysONhG2MrYI3qHMtCPY6CzB?=
 =?us-ascii?Q?22BClWqvme8/EeMG4Xn47H4AmwKuJYURZoey9Y4CXHI81cAdcT3UN/S3GXXE?=
 =?us-ascii?Q?EmnZO7P2jLN41Re3SXeRy6GHRXAOYh9/eVMahJzmt8RNQbIbEAZCoUjYoqb8?=
 =?us-ascii?Q?tNtcYeq87dzwPuxMA/MC5/ZC6dZePcc0spyOWgvG+DXr0h0bMNqJNp1YtQ6A?=
 =?us-ascii?Q?8RJ7TZ1NGq8numdXh97IHM3TbpkLWfy6VgmERlAO6er2hFzq3D53Hul3gETj?=
 =?us-ascii?Q?B07c9wqbWnO4558WU13ZVg5Av21Ru6JDKdPVvKkK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52893e0a-81ac-49bc-747e-08db89016d68
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 09:12:22.8119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pcTUSacGt3Y6HdfF76VIFjdMAV8GCIISF0IgAzrckr1ZzFOJNKBnUZSHxqQs3b36tv1haA3S/FhESonvO6IaHg==
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

