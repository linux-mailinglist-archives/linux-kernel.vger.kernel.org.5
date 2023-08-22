Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E27784648
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 17:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237398AbjHVPyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 11:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbjHVPyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 11:54:03 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2060.outbound.protection.outlook.com [40.107.21.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DEBBE;
        Tue, 22 Aug 2023 08:54:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dtcXkJXHEBf47Ykl4kHqG2hngZNW3rI3+5aLZX+3pG+KLSkRqXo8hOow6+C56sAhcBBr6bun8l6XOT2ymkphmoZMOedwmrDAxTeeOpU3pLolimlqMoHSmK9JZAfmkGUEc7bHBYoRiR2IZucNyNd5TwMIVLY4CH/t1+VeVZi4BTuss9Is4NGy9Yce/1QFVPl/ms07AvFLqLn05mQNQfgGrSN+t75kfb8US1WfOvKybhcYvdDaJ/X4C6s/nJprlu27Eldj7Fh0A1c2IdzydsUSGiOCQkl7qd85oq0Z/j1W6bbssPsm3aGMZ0PFjjGjH0mTH9b7mTn4R068haQ/J+o+0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HP7mGhw3gWBAzsx2ZdlRIDAdbC0EQ3vG3Agb3jrJRRg=;
 b=SBUfhPNlopCHfPXHvvSDMoPmycqoJ/YHzlyFIY66rf30WkRf2wjxzhnePjVRlxUf3qho29UE3EaqKa+sxzaQrxnwgF1YgWRqRmkv36eEz0FJUFMO2OKl8TT9r7QrKubCqj3j9F3n5ZfPS1SVLLhdf58EPrbYnDTwXx3bpHb54Vhwe0NIsHQrnjvo3sVHbANLZkeuCHZfJ++eAexwQVnB4+rAwgtJ2e7pSE2zyVZ2KCy5TwkhRmYQmKotWps4/2dKeOQdKLtvVT1ho/YlZsSwIFeJNG25rfjCd2hh1a3CGnltI6leFW2wmnGzTLYFqFiPGuNHiU6QlZEieOtf0zHmFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HP7mGhw3gWBAzsx2ZdlRIDAdbC0EQ3vG3Agb3jrJRRg=;
 b=Rm4/eSU4s0O+HJ39y33Hi+JpR/wOz1BLsR9OhesoQxfa0DXFFLlq86FXCNez5TerUU5ptD6sPpLUr4mDA7p/WLgK+ZxwrzpZpJK/EeABlklz/kS3gfuBKnYvS7ojAaVMYb/dx/Gfyg/BZTJcq/wQ4ZLV+xGdccnu3mgbwQvzYSc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PR3PR04MB7322.eurprd04.prod.outlook.com (2603:10a6:102:8e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 15:53:59 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8%3]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 15:53:59 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com, shawnguo@kernel.org, joy.zou@nxp.com,
        shenwei.wang@nxp.com, sherry.sun@nxp.com
Cc:     clin@suse.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
        eagle.zhou@nxp.com, festevam@gmail.com, imx@lists.linux.dev,
        kernel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org,
        leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        pierre.gondois@arm.com, robh+dt@kernel.org, s.hauer@pengutronix.de
Subject: [PATCH 1/5] firmware: imx: scu-pd: added missing edma channel power domain
Date:   Tue, 22 Aug 2023 11:53:29 -0400
Message-Id: <20230822155333.2261262-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822155333.2261262-1-Frank.Li@nxp.com>
References: <20230822155333.2261262-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0231.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::26) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PR3PR04MB7322:EE_
X-MS-Office365-Filtering-Correlation-Id: 11d20e2a-fec5-4d46-f97f-08dba327ff52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e1MKqD9BDO4gObRWO4S2s5nJ1NxXwKf4VMY0Hvl1KQBviw3ELrFHHSULfh9Y374X7t69UGvhCTJD2JnRbPL075EA5ljZUktPpLd5plCVGa6w95+MowHY5uDqx7b7T8zcLmYLVNz+pjvNDgeR4N/5plcLF0/Wex+DitDz1YgRuuYUJZyNKMGOeFtxsuWYIPlgxvoqFl0ScjAtmNOBmgyE/9YPV+kxhg2MhLKd82pwnOo/xO0knYJFUHKPPIfSrfQn2zsdBQIdIGpJTHsbb0RZNb1LVkRmMkYSIPlyi3AtaMyfc39uI7BTt16kh5G3BZeNxp1tGCjnkhgY3ByTC0oHy4FVsqGYz9VEwOtI4iymgHKICDk+BvTf6JkNnqRHBjQpt1ZvBQ4Lf+xkA9lfyLiOsEICuJCilIDRmkzcgxK+nnb4zj33nlYbVeFQzfvAagZeIng3a1x2Y+xeYRfDX/PtSeJpyw3slDcbbpqcFiA+W2rutYGHKTLqZWzuSCv7a+6WrBcicg58X42obA3P1Ooxrr5kGOTuFyT7Jr+QGebjsF52smOnKnPoywgYDVpUNc2LHKb/3MiIfxbv4xGO1J3HywsXQp1EGw88uajPgXW/klwDUPivXTektXRz8xlmc96E
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199024)(186009)(1800799009)(2906002)(7416002)(38350700002)(52116002)(6486002)(38100700002)(6506007)(83380400001)(5660300002)(86362001)(26005)(8936002)(2616005)(4326008)(66946007)(316002)(66476007)(66556008)(6512007)(6636002)(478600001)(8676002)(6666004)(41300700001)(36756003)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cNBhekafPKw8MvItp2bQhStf5Ijhv+PpfaS1MTwVGxVhCqWq0mmdGMTqYXSF?=
 =?us-ascii?Q?H3OxsyAn/JUY8dFI9OKT2X4skJjIBdz/aD91ZGFXIf52+IW3vRLHjtuxyMqO?=
 =?us-ascii?Q?LFir3x+lxDcdT81CD/OoRvIBvNZcnrBKsEDVrj76jaUcY6FUuQyqUE1N7F9n?=
 =?us-ascii?Q?Iqkw9qHIKCvLfCiXkVqgzuidt3eOTOolDYaCkSP0O941A6gPrFupvc4fCFe2?=
 =?us-ascii?Q?QQcM9xXTAOWqxefwWhX9T/q9y8nWCCcf7sds1XbRASl2Alu09RdMvZOhbDlF?=
 =?us-ascii?Q?93yaATe0RF5ka2LlNwl1TF/UdJI3luhO398PLp1WWmw4Tsco/dMfSHFZUb7Q?=
 =?us-ascii?Q?LpCz3pT4rPMarQH3k0aar6kwvyBWqN1zjw0++UH7sJQRh2RpZmZVdEK9nLfW?=
 =?us-ascii?Q?AD+FBV4cNgRKSl4MwWAw/WoNDyhHzTKBt85+5ypff0AHW+B/6+mBfRgh2N0r?=
 =?us-ascii?Q?xy8PZyvSguGaLL4jtKrF1riBz+dBeU7bwMJ9W/542NV/Axv0MM5fN5pwC0m3?=
 =?us-ascii?Q?LX6N7DSygWsKEUvjXYEPMDZHqrAY3+QG6mmHNqPorTeZmBbp6heFCAIrUofF?=
 =?us-ascii?Q?uR9E/LS/RwGsFpPMO7Su5MZThGeHCobIwlydgNTIUmJSEVftyk/tMaz1L01i?=
 =?us-ascii?Q?z0KfPE/lvWytOK3mCXEBfWoQvIfaG3kHAw5Wo7EVYTLVcr2TXeKGSnj7cK3g?=
 =?us-ascii?Q?W5tJN0CiHzwfqw/elrtl3PzMhvDJPiWwOrALRy2CjTlDHXFSH4breghffR/U?=
 =?us-ascii?Q?dYA77JZUpKzFGnKM3doOaIhMIHGDoAzdLHCGWYKWe5xQyiRNIn1+b0oG1Zov?=
 =?us-ascii?Q?tF+3XiDuz8q5DFEb0/MCYgyUjf3kirm+wWYwnxgdSpaSerKUxwcA0F0UQo30?=
 =?us-ascii?Q?zmlTv3sHeJt2q/kJKSxTDgnCn4YHklG0RwQ1iXD2BhHGP5SqsVHT5vMR+Wlb?=
 =?us-ascii?Q?iCCX3jE//2x6AYJPU4ddxWPYMpyas37ezykz9HtEuk8qWK64Ve7JSQb1wUj1?=
 =?us-ascii?Q?99/VxwadzM7A7zQiqmWMD59MVYa7IAjRXXm58GvqjTJZOD/UTEveJ7SLIiwC?=
 =?us-ascii?Q?qqDvHe4PEf7rm1qksmaGRoLOaFZI1N4nNmSevZfAPgnhfCMvZUW5fFD/eNmI?=
 =?us-ascii?Q?y732idx20dSewUC1fgS8vYkCTip1lzt7pHq10LLp3IWFge4nT0kCES6gfmuI?=
 =?us-ascii?Q?KhUGiVlu5Ynf4nehjO4YreEEVa4oNjosAxlCwDFlx9XLcO3qDUhLL+byDAqX?=
 =?us-ascii?Q?NYYM1dyc0qGPSwYiZiE6+6wAYFCBpJSIUiGfIF1AzazGc4VbSqbmIbRYp2E4?=
 =?us-ascii?Q?8XJwHp8Ex6N6Fdo3ecixr2dmwDF3YnUOKzczqR8gIBk7ziDbHQqBZPaIfZaf?=
 =?us-ascii?Q?YfsxoH8OZ8iSZtBMCktG/GCV72c/uGD7zWxLVav+cNv8buAfc52MP/LzX1rk?=
 =?us-ascii?Q?5oi6qeHZAz1egaXtRtC9Z7GSfwcP9+2k1ivzm0BLPfISpYx+jTqqMroXMUlu?=
 =?us-ascii?Q?PsSFkXH9GxFDY44rlSE0RFUHUlHVM5A/Bvug98mKRxCz4GMXY5nI1JEQ8mGw?=
 =?us-ascii?Q?2jklkbZdyaon7kFxJsrA92KvZR40kSbXIW6i1pzv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d20e2a-fec5-4d46-f97f-08dba327ff52
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 15:53:58.8846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8BIUikWJ1p67nrN2yGeCHu3+iCJNU/lzdMGkIPsiv2c9hoA5j0gzkPhKCykzP3+V/JDHs8AEmO/REQZW8VIhqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7322
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are more power resources for dma channel at 8qxp and 8qm.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/firmware/imx/scu-pd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/imx/scu-pd.c b/drivers/firmware/imx/scu-pd.c
index 84b673427073..7d80eabd7941 100644
--- a/drivers/firmware/imx/scu-pd.c
+++ b/drivers/firmware/imx/scu-pd.c
@@ -121,9 +121,11 @@ static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
 	{ "audio-pll1", IMX_SC_R_AUDIO_PLL_1, 1, false, 0 },
 	{ "audio-clk-0", IMX_SC_R_AUDIO_CLK_0, 1, false, 0 },
 	{ "audio-clk-1", IMX_SC_R_AUDIO_CLK_1, 1, false, 0 },
-	{ "dma0-ch", IMX_SC_R_DMA_0_CH0, 16, true, 0 },
+	{ "dma0-ch", IMX_SC_R_DMA_0_CH0, 32, true, 0 },
 	{ "dma1-ch", IMX_SC_R_DMA_1_CH0, 16, true, 0 },
-	{ "dma2-ch", IMX_SC_R_DMA_2_CH0, 5, true, 0 },
+	{ "dma2-ch-0", IMX_SC_R_DMA_2_CH0, 5, true, 0 },
+	{ "dma2-ch-1", IMX_SC_R_DMA_2_CH5, 27, true, 0 },
+	{ "dma3-ch", IMX_SC_R_DMA_3_CH0, 32, true, 0 },
 	{ "asrc0", IMX_SC_R_ASRC_0, 1, false, 0 },
 	{ "asrc1", IMX_SC_R_ASRC_1, 1, false, 0 },
 	{ "esai0", IMX_SC_R_ESAI_0, 1, false, 0 },
-- 
2.34.1

