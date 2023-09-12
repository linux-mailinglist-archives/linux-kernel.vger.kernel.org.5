Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E61879CB51
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbjILJPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233322AbjILJPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:15:20 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2088.outbound.protection.outlook.com [40.107.22.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D069C1701;
        Tue, 12 Sep 2023 02:15:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVclAdQU2ekdPKfBS2ikIV0FjxMXA+b/taXdOMSjm+cpSAE7jtPuch41bKi5erJdYRFBtw8E9uCMlpNcp3w6I8FPbMO4tGyDHDHi2YBoe/FPH1DrpBbVKu4QclLc1Yt1LevL5PfUDneJOW3m3nmAmIlLI+bcYN2hZ+KVlDDNtbXYoDuWUmToHICX7tWCBJn/KpRkWmYv360ohBMzTTG88XJw+Qzps9VndaIE4POZwMVv2TwUjEyKtynvpzjqBHRAvVMbbIaQYAXGBuCSx+XbXMBAzagnjkgbEEQZcpXtlUzymBcxVNiRbxgD2OWoDePwvJm+gnqyGYAChhqZNMjgtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZ6MxPoO6pbOIdCJN+Ls8KBvrIEJlQmdHp1HxuzDBVk=;
 b=C+1+l3FqNosEwWahab8wwhzWT43z+lEsj+gJghr0Afyx5ourDwZKKAAnzECuZYgLxMdDc9Z0UJlW7qbTLexGwNz+yQVodTADgsoxzVCiykuQfUBuNtJxDHjyH2N3tRIViSJ14S3q4bkVXkg4T/OXDiyLB3UE+khfN3jVO/hTggTmNf+w4qKkSaM5dqSqgNHugwzOhLMvV9YSv1+5hDGnvhamWnriw6gB1HtMGAAId8F024NfODjyGf6dY+zSVf+jjJPIoNiaedpZtsUVpwOiZ5cnvHyKjAdb3FOp7VGAg5ovHzD4nEoxUsXTLFuQsXJlglHLrhG9SzwDnjs6z7wL6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZ6MxPoO6pbOIdCJN+Ls8KBvrIEJlQmdHp1HxuzDBVk=;
 b=YwOOlPv9UWHqC5hR8m0VEzqLMQmsKyVCJQvvwsA6FsLvwimwttnkznDW1/vO7PchPXmkfilcvSg+jTnMJ+fJmN49olIUURNQ2Dc+urkTOsfAR29s86wB79mtVWj8nTabE734Ynf91aJAXS9J98rFH8izTi5meKayGkZ/tPJSag4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB7652.eurprd04.prod.outlook.com (2603:10a6:20b:285::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Tue, 12 Sep
 2023 09:15:02 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 09:15:02 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date:   Tue, 12 Sep 2023 17:19:04 +0800
Subject: [PATCH 6/7] clk: imx: scu: ignore clks not owned by Cortex-A
 partition
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230912-imx8-clk-v1-v1-6-69a34bcfcae1@nxp.com>
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
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694510362; l=2416;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=nH7n8INf47JK7uOfFevP12wS6LNZDQbcsvG6Nkp3f0Q=;
 b=VmYbYTuGv8t2IfT0HGAa/H/S09PPzDDaLmIbHkTOOnrHLbQ2U4PiUqemf1OsxyuK+Sjm/AjlB
 s/Yp+UsdQnRCSI9wQE3HPvT4Waw4S3LVtZdohFxBJXhQ202v4lJxE6M
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2P153CA0019.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::10) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB7652:EE_
X-MS-Office365-Filtering-Correlation-Id: ce467042-4639-4f80-0efe-08dbb370be8e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GzaN+Hv0zpHq2X4MGtq4SfLgY7jnGZR/6MVZzhLzpItrCZI5TZFJl+U9RRNHXdwV014hkRvsVPJ2TValGqNCVhXgnSPTfmC7e7zVB4v+M3/B4Q7Ee422eVNJsGF3t/ruFHxqgV495eFtiAjAU4HB1VmpTEJWEWIt596M+f/Pt8ygNoeeUCrUm3w9DcrwZIkR/mMuU+QDEVbwH7kue3NtbQgVPsDiWynk9/DB0epNZRC5iTSurfVhbYeW8llRyyQVkHfNZwQ1Vqv//OAKGY0iKe9RL1w32utDcJp6Y9c+wsNRW89e7TAQ+EFH2R4s2NTpAg+UZWeeuGmtNEhvuMPl7igBfYPpwFXfkRK0O3s2LJH1og1FGO0wlMFaZytbcqPdqWqvROu2D6lJqD5aWoJVh+BMt3vsEOxy1V045jlsCT3pygVWBcQK+Ex/TX0kOVyZgXWTxJIoTPSuHap7TMevSoIBC/Q44ZNSHdgjSUwlJGA3vSRavTDyvhsj0z3K4c0P3GbKJ006Cyw9zNDEEZVsPneVATyQvU38z37RnWLYED1KjVBfGnDnOUHwQV5EWIu97IKBtzAiLklq4GYOZda+jTDyBQUGei4vTN5XRXPyILhlboZs+KGE9p+wKBfPj5eA15QCOK+ZPmSeoW9QUKyEUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(136003)(396003)(376002)(451199024)(186009)(1800799009)(5660300002)(8676002)(8936002)(4326008)(6486002)(9686003)(6512007)(6506007)(26005)(52116002)(478600001)(921005)(66946007)(316002)(110136005)(66476007)(41300700001)(66556008)(86362001)(2906002)(36756003)(38350700002)(38100700002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elcwZFRkMVY0Wko0ajRtOGNDTlNvNDYveHN2b2hDUjcvNk9YZkFLVUJTZnJW?=
 =?utf-8?B?Yms5VWRPUmxDcXZjNFhHaktVZ2JwZXF1NkpPSVQ1Sm40SVNqbHB2eWhnbWNQ?=
 =?utf-8?B?bEl0dHBoVW9CZStEWEVPQzQybm81RlpCZGRlS3p6UEgyOENWRFpyL1BJZnV5?=
 =?utf-8?B?ZkR0bUFpRjVKTUw1QVJkWGs0ZkYzRUsyekpPUVh6b3doOHlGVXYzUEFHbTBB?=
 =?utf-8?B?cGpHYUlKQS82eGltbkdBM3l3UGNNdWxmaVc4YjNBdW40TmkvK25zYkpNN05V?=
 =?utf-8?B?RnZKZ3RLN1dOUjFUZ0huWDdBRnZ0eUxnWWNiOTY5aGdIZjFnS1dtYmdzZ1Vp?=
 =?utf-8?B?V1kxT0FMZXMreW1aZlA1MGNKQ0tRMVJ5VXRGUXZ1eVMxSUdLZ0hlZ2pTem9L?=
 =?utf-8?B?cmFXZGoxLy9CVWY5Z01ydytFT2ZwbUtLS3J0cWVaNGJPMW9qVlZnTDN4Yk4z?=
 =?utf-8?B?czQ1dEU5a3ZML3dubytMY0RlaWoyY0Jud0VGZzI3ekhQb3dtMXhIanRLN1NT?=
 =?utf-8?B?UDFWcFM0UURxRlBaaGtwSUV5VW9BUXcvNkF1QVNGbVYrYmFjYzZ1MUdXb1Jw?=
 =?utf-8?B?Q1M3c3ZpN0FCRGU2a1FvOWdQaGpheUx3N1NOS3pPVnRrZ2NCbHJ0VzFDQTY0?=
 =?utf-8?B?RnZLTTJuM0lET2tpb0JTSyswVFJoc1Jidy9pdXdJYVJoOXl2WG1lRnFRZzQ1?=
 =?utf-8?B?ejdadHhxdHdRRTdDRnpUSUJIR2VvNlp5U08xSmhNQnZIL0U3TUNhbWhLaU5M?=
 =?utf-8?B?N0FjUzFxU1FoZ0Q2NlRyNmEyM3BHc2N1Nk93OVhhTmJhY2ErdTRBK3B1b0s1?=
 =?utf-8?B?U1JNNExQRDdyU2VNbVFXVHJwZXYyclBGeEhKbTVDbDRIdjk5eVBjUWlMYXV4?=
 =?utf-8?B?aWxOZGdHdXJmYTRyZk14bkN6VldoS1I1S2JWY2o4SmhQVVhkNUk0T3l4MGtP?=
 =?utf-8?B?WjlTOHQ5dFdkN3hTRjVwMjVjQk1JWGlxTWorRVJOS3NTck1YZFgrQnVUclpI?=
 =?utf-8?B?Q2ZscnIzMHp2OUxKa0hiaWdmN3FxRjJNN01TZFlqMHFOM3VpWk9Kdzhyc0lz?=
 =?utf-8?B?bHRyN25PWkpCa2dkV2FlSDJpVmJVOGhNa1AxU2s2anlkcnA1Ykd6aHN3TTRC?=
 =?utf-8?B?QzJiQUVRNnV3UG1VUXpCYm9vb0hYR0IwbEI2bWo0REV1Y0pkQ3ByQ0oyTzRn?=
 =?utf-8?B?T1BIZTB2Y05ZZ01FanJZaVQvOG42MjBGRjQvUGZjWklEZjdiK0JvTWRqT1dI?=
 =?utf-8?B?cllsSVF5UTNkQzRRb3VjTEtUYVcycE5jNlp1Njg4N3BVQjZhaWQ3cjF1WjUv?=
 =?utf-8?B?YnpuUjMwaTZ1ZjB0c1YzK2ZQSnY4ZjZmLzBSOWZxOUNIYlhkT0xFdnRmRnVk?=
 =?utf-8?B?b1UrNnNSN3R6R1RoYTBNbEZRclBValhHRDFTQXJIRGpiVGFLT1d1NEJGSW84?=
 =?utf-8?B?RVB3N3ppejRlUktSWEg3Q0tteEtRM2UyM3BBUDdUOHlxdGU0cDFOMmcxcWQv?=
 =?utf-8?B?anJtVFdEUFZWMVVpdWNaRUVDNnU2SmZPUFNJMUFPYWhyN1ViOG5SUVZhUEx0?=
 =?utf-8?B?RXpkUTl6VnprMldHcGdDYUR1WkdGVWUzUmdZR29rcytnMUdSc0hjcUxUbDJS?=
 =?utf-8?B?SUxNSUV5Z0hRRnJVcElwZEswOTByaXdtNlVLRVhENHNlQjlNR3E0cEFiajAr?=
 =?utf-8?B?TzFTUFVsU0NVcE80dU1YZUtJRmtmRHNGenEvcjR1bVdEL1IrRXRVV09UMkEy?=
 =?utf-8?B?emllWU5oalJYZTYyK0VzQzhhbVhuK3FSZERwY0FOTlVUdnY4UG5US0J3TkhX?=
 =?utf-8?B?K1BvL3lDa1pQcDR6Tzh3bHlzR2QvZDBRWENrQStFWU85a05ZNTlnRWhnV0ND?=
 =?utf-8?B?YVZ0bi9tZkhWT1VaNnFHOEE4NkRwTjhXY2xmbUhMUnV2ZmNPZHFTNjE1WFF4?=
 =?utf-8?B?V25tb2x3eEJEMEd3dUkrSXhmTlliQ1ZOWTlpNW1DS2ZTeWUrY3pWWGhBMXJV?=
 =?utf-8?B?T2F2VlYyZEdZdlRQU3ByM3Zja0hZcWVBbis2NzNyR1VNN3BiMDJUNGRTUzlq?=
 =?utf-8?B?MUtLRVpXMzRoV3BjL0VCVXlvejN2MFYvMFNmenM0dVBUS28yQWI4V1dsdFFZ?=
 =?utf-8?Q?/FTa1KvowoWysiC2/uvp/KQHR?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce467042-4639-4f80-0efe-08dbb370be8e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 09:15:01.9649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VS0c6VQoMeGFxWwD333bANGOxSEMj8Lo0/WqxQISWtmvGefTFGRrzsFQgcsq+HmqIxxY4E1RoJa99h+2yRxSmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7652
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Not register clks that not owned to current partition.
CPU resources are specical resources, it is assigned in ATF, not
non-secure OS, but we still need to allow cpu freq, so return
true for non-secure OS for cpu resources.

Otherwise there will be error log if the resources are owned by current
partition:
[   19.387291] cm40_i2c_div: failed to attached the power domain -2
[   19.389305] cm40_lpuart_div: failed to attached the power domain -2

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-scu.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/clk/imx/clk-scu.c b/drivers/clk/imx/clk-scu.c
index cd83c52e9952..be89180dd19c 100644
--- a/drivers/clk/imx/clk-scu.c
+++ b/drivers/clk/imx/clk-scu.c
@@ -10,10 +10,12 @@
 #include <linux/clk-provider.h>
 #include <linux/err.h>
 #include <linux/of.h>
+#include <linux/firmware/imx/svc/rm.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
+#include <xen/xen.h>
 
 #include "clk-scu.h"
 
@@ -670,6 +672,18 @@ static int imx_clk_scu_attach_pd(struct device *dev, u32 rsrc_id)
 	return of_genpd_add_device(&genpdspec, dev);
 }
 
+static bool imx_clk_is_resource_owned(u32 rsrc)
+{
+	/*
+	 * A-core resources are special. SCFW reports they are not "owned" by
+	 * current partition but linux can still adjust them for cpufreq.
+	 */
+	if (rsrc == IMX_SC_R_A53 || rsrc == IMX_SC_R_A72 || rsrc == IMX_SC_R_A35)
+		return true;
+
+	return imx_sc_rm_is_resource_owned(ccm_ipc_handle, rsrc);
+}
+
 struct clk_hw *imx_clk_scu_alloc_dev(const char *name,
 				     const char * const *parents,
 				     int num_parents, u32 rsrc_id, u8 clk_type)
@@ -687,6 +701,9 @@ struct clk_hw *imx_clk_scu_alloc_dev(const char *name,
 	if (!imx_scu_clk_is_valid(rsrc_id))
 		return ERR_PTR(-EINVAL);
 
+	if (!imx_clk_is_resource_owned(rsrc_id))
+		return NULL;
+
 	pdev = platform_device_alloc(name, PLATFORM_DEVID_NONE);
 	if (!pdev) {
 		pr_err("%s: failed to allocate scu clk dev rsrc %d type %d\n",
@@ -869,6 +886,9 @@ struct clk_hw *__imx_clk_gpr_scu(const char *name, const char * const *parent_na
 		return ERR_PTR(-EINVAL);
 	}
 
+	if (!imx_clk_is_resource_owned(rsrc_id))
+		return NULL;
+
 	clk = kzalloc(sizeof(*clk), GFP_KERNEL);
 	if (!clk) {
 		kfree(clk_node);

-- 
2.37.1

