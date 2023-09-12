Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D790779CB4A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbjILJPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjILJO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:14:56 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2072.outbound.protection.outlook.com [40.107.21.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37259AA;
        Tue, 12 Sep 2023 02:14:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gHQ5peldr0jyqzkzRP31CiLQVM99LkeQRNSyBrRQ3Wmeo9tf88S26ZCpSseDzJh1sruWTmxcLVY9fs/cWOQ+eZsBn6uK5+Txfd9UQSZi9BKReJ8mTCpMyQXVGU3ub2RXsogQ1VVDr/cJX1Rd3rmro40TtDNfSWkgEVBzobjxyi92tv6Bmix/EegSHyjWGqXpJBRPwK+GEHufgIwvH9NwTO/aMlaAn3m0d5kcRfFpq1YmRsnqTLywos1jugJ/DEbaigtwCyhtdYJ/dJgpKf9DW3oVGkBfRLNExdIwdUThF7rYzEWkIJQKxdHfNmdJWPSQuMHOp/W7G5+OLRccT3mu/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lGPdZ2jEYryrjMBpMzU3meu+bx+u2kHSmArn04YJbvU=;
 b=YAv8qBelKKB2KEETnixkxPjPOTthar9nrI6YxT5Sk0VZeEr9AaD1I8CvANNC0/Uhm3mlcnc2zU8mI6bZzHut0PoLSXwWyDm5fs+HLXjGpySm4iklgZjFTSqQ2r4qQikggsouQQ0qEpy3KxUMHD4oBLQ3Tdw3xHwg9wAuoygeqL9WP/qpOEWViAfmUjanQKeWk1mX8rV7XWAcIQRLAWPItVIvSDcBvr4N4rFzLC065pmaAE/cM35ukyQCOe/9Kz4X7kB95Xp+TjK41ZI3DYcbtzKtgcdxJ18oFNA99qh0jlBUzdk/78GnfyVE/QKIfOYsDlfhw0p8oO5xqhBCsTYiHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lGPdZ2jEYryrjMBpMzU3meu+bx+u2kHSmArn04YJbvU=;
 b=JAagRI33lokpty1/WNuipldGVtGA9uXef6FWHMe6X84ZouqK/IB9EopvN7zN2r5D0lRjWOao2Aw3ZXPq6mrt+YSmY3Qipbli10SN0Hmdo2H7ihP/46fMJzF1YROLYsGfmtoKm/TmBamMGHoSs4hQ2y/C27q6EQT6p08yvspwzEY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB7652.eurprd04.prod.outlook.com (2603:10a6:20b:285::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Tue, 12 Sep
 2023 09:14:48 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 09:14:48 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date:   Tue, 12 Sep 2023 17:19:01 +0800
Subject: [PATCH 3/7] clk: imx: imx8qxp: correct the enet clocks for
 i.MX8DXL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230912-imx8-clk-v1-v1-3-69a34bcfcae1@nxp.com>
References: <20230912-imx8-clk-v1-v1-0-69a34bcfcae1@nxp.com>
In-Reply-To: <20230912-imx8-clk-v1-v1-0-69a34bcfcae1@nxp.com>
To:     Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Shenwei Wang <shenwei.wang@nxp.com>,
        Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
        Jason Liu <jason.hui.liu@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694510362; l=2559;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=J9ZzBj6jt1w7y8HEhTZBc14V86K3cqrQupVPS8cfPAI=;
 b=4BMk91mGwweVGwKpDpoVXKUPn3qe19ag0rLU32BZ94Ox+sA0vXiMj6qPTTsQlGbHoHzrUpS2k
 dVbcQ511CaGDpUJmFlQml+X9+W0dWrAviifB/WMP8SnuvujV8AGrf+e
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2P153CA0019.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::10) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB7652:EE_
X-MS-Office365-Filtering-Correlation-Id: 49826c03-a0c8-484c-4582-08dbb370b668
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pL3WTsk+51q7YJen8N/NCgqk5ZQFULGFU2n4VRsgg7JxLLJekz50WrmEM84H7S5uP6KvGmI0YiNS6lXvcK4Msg3mBGh4bMYXOOV+quFGhUc27YJvEZLozPEk1lcAK2lfHkFZnu2ewnOFiCTzddzY20Uu9a9AbTURyZJiLsAMmu2/mVtDwlL8XWf0KrD3dxSoLfY6crklpPgBqjFp4lapBAiUvKnoLMBgrTQPM5A+s8UTv6lTvaVkCkEc1jljx+RPoj/USBf7gLCUYMcqoF+0KFnSWsbIK3jDmSU4TzDGLWCcuDidvDKBw3RSl0k9bPpyWKXNQ04NONOihsWCXuSyrH6ecQ4AGsDSuBu867tFs1ssf4ne4yXqpMn9el6oEZ0BVR9bQEyyBZEC+Tttys+008+mmhjcHkXTOkPeeHRFnpSX1C5uPouZYfWiLrpVUWhJrDZQcg1o2EoEPinsseyCi6QXlbfBGxY7G60VvZYGxx3u98YP9V5nigIs0wTMPueQ4Qh10Qp3nwrfqhFhJp7rYzs4LVoh9+VJ70LMc4JMXHqBKfpt2ifC6Q/aOxyFnzGt1KKgvZhJrojd4TiuTDokGBKR/6twGPI1Rpa7RlSgXKJ91Pun6+7y19VcPNQG8cslTREnnwRYzmua2j7LeI4fjML9iqu6BoFSKCph91vU9JI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(136003)(396003)(376002)(451199024)(186009)(1800799009)(5660300002)(8676002)(8936002)(4326008)(83380400001)(6486002)(6666004)(9686003)(6512007)(6506007)(26005)(52116002)(478600001)(921005)(66946007)(316002)(54906003)(110136005)(66476007)(41300700001)(66556008)(86362001)(2906002)(36756003)(38350700002)(38100700002)(7416002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGMzTXJHYlRLU3dZdlhPTkNpN3g4MFVuRkZlV2UxcWpnSFVob0hIdWZxWWhn?=
 =?utf-8?B?b3VlUDJDSDNyS3R1M01NYmN5VWZxMHM3WmZSSnJuTVZ4WlVYRStKSnRnZVVv?=
 =?utf-8?B?eGVvVDZ0VUNDOVVQSmxaZDUxSDhGdnAwVFcvdGNCNFYveC9ma0V5YkVpaHJF?=
 =?utf-8?B?U0FqOHc1bWlxWUJCNmVlT01xV3NROGdxWFNZM1IycDlZVFlhNU42cWhZdy8y?=
 =?utf-8?B?VkY0Zm1UQWpLcWVmaGlTa0NDOUsyR0dONnJPZm5yY2FweTNxNjNPaGJjanN5?=
 =?utf-8?B?M0ZoQlVoUDgzVnNub0cyZXkwWEZ3MmVOa0ZhYU9CQk9yZW02cVRXZmFoVld3?=
 =?utf-8?B?RDdzZzBKd0RwWW1RSmF1eGJ4OGI1emVlc3BSZGErNzR1bTI5WWpZVngvRzdi?=
 =?utf-8?B?ZW01YmVXTzYxWnBtMjRkaW1YZTNhWGFSZlZKUFZBMFAzdUs3MU9FamkyeSs3?=
 =?utf-8?B?MmdNTWVwVCtHL3IvQmNack1McWRUV3J0U0FEZU1PNEU2cmdPQWdFbUpic0Mr?=
 =?utf-8?B?Q0VCTWxoYWp6akRJL2x3WVZRYkFyaEdQMkQ5d0k2ZjJtQ01uL1BOZHZUeG5G?=
 =?utf-8?B?Zy9xQ09EQ3lRQXpoMWxuMUlTZkJnWTZJL2ZXYkZValVTajhnOU1EVWlqZGdT?=
 =?utf-8?B?WjZ4d2M5S1M5bXErZlFYQitwRmZPaklSUmVHdWh1ajliMis4K0ZjMjY1SVpr?=
 =?utf-8?B?cFQ3dlNIN1VhbnFNL1FDbW05akQ1QTNCYWxhbk1Mb2hSZUFwQzNFaXJnUnZK?=
 =?utf-8?B?QXQ5bGpvUXJkZE9QM2IxY2NzZFBqZWR2d2ZBMEwzZjNzZVc3MndJYndKZE5w?=
 =?utf-8?B?QlkydTlEc1BSblMrWDBkUmpDTE1sd0o3YmVsQlRkVkppK3pRTFZ4Tml5am9v?=
 =?utf-8?B?YU5mZHFLeU9udThvOXlkSTM4eUJqL2ZVcjY2R0xjNithb3N2S2NVTHpJeTZO?=
 =?utf-8?B?Uk9jUHNjbldHalBlQVEyUjNhTU9pRXpFMmdseXJNeTdncXV6VkZFWG5HQml3?=
 =?utf-8?B?NzVvUmFtU2lVZ0hscFN5NjMyNmc5bkZ2YVdnbDVmT3JQTnZYTFBtM2hlVkhD?=
 =?utf-8?B?TmhPS1dhVmh6YzhBbm44UVN2UU5RVnc0clcrSlZMdnQ0aFBSTkVMMTdPMitq?=
 =?utf-8?B?N0NIeURHalZiRkcxVi83c2d5NmZqUkFyVGVVWmVMbXl1T0xoTzJ0TTJxbUJ3?=
 =?utf-8?B?aEM3QkRjVE91LzR0eGh1VldCZ2xGcitUTmNNQ1h3WnQwam85VDdod3JmRGRx?=
 =?utf-8?B?dXV1d2xIRmxIUUtZZ3RXUFg0bjBoOFlqYzJOMDhXQ2dWYmhBclVDKzNDaThk?=
 =?utf-8?B?WklrNkJNY29xTll4ZHUrMWY1Y1ZwcFFqZzJ0RHkxTjZOSmtsbmFUWkJsYm8v?=
 =?utf-8?B?cVJWWE1QTWZueCswV1Y1aXVEUGJTV1pJY1RjL1FRMlQvVW1zN2hqd3Q5bThQ?=
 =?utf-8?B?TmpzdlJ6SnNobktoaWxtK2RwRFJ1K3hwTmxFMjBUdDNzNmloYVNFSGJaQzFU?=
 =?utf-8?B?dEFtSFlFWnlQUDdFaUtaSG5PMGhVcjJEU0Mzb3lHbDRMV1V6dG01eC9OLzQy?=
 =?utf-8?B?OXFBNVlidU9oMWFMUSt2bk9pbWtFeTBNU2pjVDc2b0JBd0g1dXhBWjkremVy?=
 =?utf-8?B?NzBhZnJ3dWI0bUV3bHJXMXB6NG9ibXBycnovTEsyZTUvTVFSWE5QTDV2LzVV?=
 =?utf-8?B?NVQ1YlBiZGlHc0NJT1BKckVrR0h5WCtkWm5mdEZGeEJ3ZjMxTUt3cytrWGV1?=
 =?utf-8?B?MXYvQTBYTkRxN2FpelVhS1R3alBiaXF5Nmh2RzFQeDNqdllFS21RZU9HZGNx?=
 =?utf-8?B?aUNCajZ2U3hGTGdZeUNGUkpicGVBbHFxTUZTWWQwVGpMR1V0cU5aWlUzU0l6?=
 =?utf-8?B?ZndDK0RLMTY0emU1RkpHV0lvYnJqOXVzSkZXckxUY1I3bjZ0YXM4NG1pL2dL?=
 =?utf-8?B?K3BWRzlDenlHWUhyczJuZ3RVMXdKdU5nMldRTzBlTzF4Q0pLMmJzZkFsNDRS?=
 =?utf-8?B?dm5DT2xXNGVzR0FMUUZ0Q2xQaThacis3NTZURkRTcmZZaDNOUDMreW1mNS9t?=
 =?utf-8?B?SndQVUV5OXRxS3RQam1OTnBKajdQYk1mYlV3cnFGWXZJR1dOWE1QYmJDLytm?=
 =?utf-8?Q?qPvtjds7IGN1S+YR22ZN5LXKH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49826c03-a0c8-484c-4582-08dbb370b668
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 09:14:48.2512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4pm5Qp+m0e0GXEi9fq8pL2PSkhYmLBJfpZgCM4MVO9F1b0/GtlV7CrY7K3TZgGj865kIlNIGgfyg4dLHzoAaDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7652
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shenwei Wang <shenwei.wang@nxp.com>

The SC_PM_CLK_MISC0 clock is not available for the resources of ENET0/1 on
i.MX8DXL. Using the clock device compatible string to identify the platform
and only initialize the enetX_rgmii_rx_clk clock for non i.MX8DXL platform.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
Reviewed-by: Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Acked-by: Jason Liu <jason.hui.liu@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8qxp.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8qxp.c b/drivers/clk/imx/clk-imx8qxp.c
index 4020aa4b79bf..41f0a45aa162 100644
--- a/drivers/clk/imx/clk-imx8qxp.c
+++ b/drivers/clk/imx/clk-imx8qxp.c
@@ -90,6 +90,11 @@ static const char * const pi_pll0_sels[] = {
 	"clk_dummy",
 };
 
+static inline bool clk_on_imx8dxl(struct device_node *node)
+{
+	return of_device_is_compatible(node, "fsl,imx8dxl-clk");
+}
+
 static int imx8qxp_clk_probe(struct platform_device *pdev)
 {
 	struct device_node *ccm_node = pdev->dev.of_node;
@@ -169,13 +174,15 @@ static int imx8qxp_clk_probe(struct platform_device *pdev)
 	imx_clk_mux_gpr_scu("enet0_rgmii_txc_sel", enet0_rgmii_txc_sels, ARRAY_SIZE(enet0_rgmii_txc_sels), IMX_SC_R_ENET_0, IMX_SC_C_TXCLK);
 	imx_clk_scu("enet0_bypass_clk", IMX_SC_R_ENET_0, IMX_SC_PM_CLK_BYPASS);
 	imx_clk_gate_gpr_scu("enet0_ref_50_clk", "clk_dummy", IMX_SC_R_ENET_0, IMX_SC_C_DISABLE_50, true);
-	imx_clk_scu("enet0_rgmii_rx_clk", IMX_SC_R_ENET_0, IMX_SC_PM_CLK_MISC0);
+	if (!clk_on_imx8dxl(ccm_node)) {
+		imx_clk_scu("enet0_rgmii_rx_clk", IMX_SC_R_ENET_0, IMX_SC_PM_CLK_MISC0);
+		imx_clk_scu("enet1_rgmii_rx_clk", IMX_SC_R_ENET_1, IMX_SC_PM_CLK_MISC0);
+	}
 	imx_clk_scu("enet1_root_clk", IMX_SC_R_ENET_1, IMX_SC_PM_CLK_PER);
 	imx_clk_divider_gpr_scu("enet1_ref_div", "enet1_root_clk", IMX_SC_R_ENET_1, IMX_SC_C_CLKDIV);
 	imx_clk_mux_gpr_scu("enet1_rgmii_txc_sel", enet1_rgmii_txc_sels, ARRAY_SIZE(enet1_rgmii_txc_sels), IMX_SC_R_ENET_1, IMX_SC_C_TXCLK);
 	imx_clk_scu("enet1_bypass_clk", IMX_SC_R_ENET_1, IMX_SC_PM_CLK_BYPASS);
 	imx_clk_gate_gpr_scu("enet1_ref_50_clk", "clk_dummy", IMX_SC_R_ENET_1, IMX_SC_C_DISABLE_50, true);
-	imx_clk_scu("enet1_rgmii_rx_clk", IMX_SC_R_ENET_1, IMX_SC_PM_CLK_MISC0);
 	imx_clk_scu("gpmi_io_clk", IMX_SC_R_NAND, IMX_SC_PM_CLK_MST_BUS);
 	imx_clk_scu("gpmi_bch_clk", IMX_SC_R_NAND, IMX_SC_PM_CLK_PER);
 	imx_clk_scu("usb3_aclk_div", IMX_SC_R_USB_2, IMX_SC_PM_CLK_PER);

-- 
2.37.1

