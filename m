Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0AF79D1D1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 15:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235380AbjILNMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 09:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235273AbjILNMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 09:12:30 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2046.outbound.protection.outlook.com [40.107.22.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1287110CB;
        Tue, 12 Sep 2023 06:12:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SpbTRXF5efHsMZ7mrW0GGq+vaGcVx90rdsybM7FqAYqj55eWMwRjWvvUi9pLtgiqCbGZu8ztaZL3NHi/PMxqv/KrfHqiu9Baov2PfZWW2L8CmnVQ/i8wPNIg6v39BiaR3IJU5pe74/4Ufex9RK85MrpY/SGBTBEZiRYsQCFSwTkCfCH5eKAAflixJxEeJBnDM00KYJmj78OZaCXiSuXU3wvdUNzOsu9Tp30O1Bre849KO16Hgd7rjbwBBjMOSykgU3hNGqT4eIb3hlLql9dZmT1hQiYIr69dmoFWPyU+8DUYcCfE896UHk7lK5zRm/l8qQGy1MY+tYxAx6JT2DA9rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2lCGt0Nt4MM24cDRP+3QADgwzQ/atodUXITkDjCbqks=;
 b=msx+xWkiB9cNEGscKqvNZoJvlgW8qsnszWqGy9BBTxG/RnhQfK30vXeV3Y3pyTTXcSp4Qmj5ONPFYP2SkWRhoEYvDEeQ2V9AxRvfT8240lJyMMvewKpJ+bgK6vspmlpVmoAg8uGNiSHN9foaeC8JfW9KQRR7aVkSEF+HtuvRbD2/Jla1E81kHFbPCdVaEC7tQO66Zqu4Ad1geqiGXDtl82mqVyjzkPcDv8aAKmUjnKFpConUemweDjtEn3ECMm9nFE+VyFobBUeo3TCPyvmTf3zopPhUI0Qt5qFnXuUDUu9aN3g573ofGWnEiHj744H2qoNa/kKa0rgEYsyxt64eYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2lCGt0Nt4MM24cDRP+3QADgwzQ/atodUXITkDjCbqks=;
 b=OBdGeEbaF3IEqhswLlSpIXl+SiRzw8jZj9uzA/aiFz3kpQq0dlhvj7Bza8jISgrIikxE+srK0U6C/P1o4Bp9Boj23osYrIgbkJDsdXPvbajBoqpPWhKnWlVDVuv5RDb7wBeVeUIQKR7US8rWFutd8+s8v2igg4XCLn9LZSZcmCs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8645.eurprd04.prod.outlook.com (2603:10a6:10:2dc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Tue, 12 Sep
 2023 13:12:23 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 13:12:23 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/4] clk: imx8mp: fix clock tree update of TF-A managed clocks
Date:   Tue, 12 Sep 2023 21:16:47 +0800
Message-Id: <20230912131649.1491378-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230912131649.1491378-1-peng.fan@oss.nxp.com>
References: <20230912131649.1491378-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:196::15) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU2PR04MB8645:EE_
X-MS-Office365-Filtering-Correlation-Id: 352f8c90-b2b2-4b2a-1768-08dbb391e6da
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fF/0u/CFfdjv1h4kdyYCdbOQET9GqMYQv9dWZLppv3+1+d/jiyX8ubbhkfd73WZ5rQ0E46184/56+ktHPV0TN5dCjxOcPdD5JIauY4VqBpV/XW5WQU4XecjJXsvIPXg5UsVQyyEx4QIarqc55cEDTmrppRzxwxEsHffhxQJB9hDF3Nq5KbJzdf+WW4FTBxVoDNFAkknTOFT7lEAwi4oxqVgUF/MtjTpUIMrWCT6MQ23dCtH9BJAaVOFPt6vn8HAOvR5Iih3wjN2DrA5rovxOXpzo/Ze3bHvyp/eL4ekeKVSqmeXMaVILXGgoZFYq/4d19UNMzck48BfSTML3nvKhNOFkiP14AEICPBs0go5H/T9q3HSmvxpLYyfGNGK1ZVKrYNOe8jb0bagyxNNHC6IseaJnhToM8uC6Dhl4krPbiH+iNpfEj0QZbwzF9grQo7VZ6wvsLAzLCGQBeEuAF+sadN2BirxRmHE8IHzJ1Yu/yqJf1J2HFiz1JT76InAMss0fF7vhhdd6JAVooz/IuwHHDCt+sQ2GcnJXNfBiP1FczGd+NR3fwXj6/1QxRKHutuaGIEGU5e9AqlGAHX7RvgCPKIJZJPJ4zaivQ7XOmsZXVkqqUamSONIhdj05YV/NwomL+I8OCCm5lq8PyWY2TsDBCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(39860400002)(346002)(186009)(451199024)(1800799009)(5660300002)(8676002)(8936002)(4326008)(83380400001)(6486002)(6666004)(6512007)(6506007)(26005)(1076003)(52116002)(2616005)(478600001)(66946007)(316002)(66476007)(41300700001)(66556008)(86362001)(2906002)(15650500001)(38350700002)(38100700002)(7416002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TceMEffna+YChBdKogTGl3JhCGEHbChXExdpUnzlSX7KK9Xqi6gO6HlOujDs?=
 =?us-ascii?Q?CMhTFm4brjwkQjJqHCnOavS+dFaBkio0cHq127RQD7ZtLQnxKVMRsqdUEDi1?=
 =?us-ascii?Q?S2A4RtpjpzbSgYL1UNWdTJv3ej2vQv0dTDo3Qnm8nFgWsz8YoBRKAZ+wIMo5?=
 =?us-ascii?Q?7vBZeaea/v2NX06nzvY/UfBB24nbKCt2cAFA4LKZD0uIDIwMPoBepvhcdyKB?=
 =?us-ascii?Q?FOpf2bUS3ObgVh7n8TzsVGX9cx6fc5MuhvFRPyrsdw7zOdwd+OfYiyAlfRhk?=
 =?us-ascii?Q?D9Su9l3F3Exh+D0RkBWuOSUwMTs71HpmYXoZlHDLv+CxOqTStPN6Vuv3Jj+i?=
 =?us-ascii?Q?ihdDFBl2D7OJC33K4nsQuIuqkMmmfVQCC82VHl+DejdM363QKQcSYsE8Dq0J?=
 =?us-ascii?Q?wV+tMssdIPO+E6DNl1SngdkS+XumptJauQ24GTZFHye4N166FdtNs9d2uipQ?=
 =?us-ascii?Q?P4cb1YoK8SFShyiTHEo4EL7jH6KTStTE4g1lYhsabBA6Or3w3SigczyLie4B?=
 =?us-ascii?Q?1vK0Uj2ZT1/2L2L8s8dtWTGVUWssE1xGFTPEmsWX3rIHakMx6vLkuIAz+1Tg?=
 =?us-ascii?Q?jjmgMD3g8Dd95AFY3tgtM4sNGAhCAbtCqwV2+WEQKq9UrH+msMbUHEbw3erW?=
 =?us-ascii?Q?ib97zssZv1M5pF85CTyTwlwDdMiL2rUuTRwzpqGg4kP5y0KVD0voQuXq+Ni/?=
 =?us-ascii?Q?LrS+av5w56ZF/LWDcxBOq9Nbtw6CHw4s+us2To14wG8InP2t5kqsTKyK9f03?=
 =?us-ascii?Q?vq4XAdSaeU0UYsAGfbyCCMU63WAGWp7WstZ8n/PHQkLH0TCCLQUG6N+dlfSi?=
 =?us-ascii?Q?+DhNJbbYdjEvGLmqiDZNuiYJLj5Pa5PQVBzwakQ2keIL86ahKhrEeaUz67EM?=
 =?us-ascii?Q?0OzyfbnSS2+jgqfjyfAywaexCxL+WROqxYo6sEuWFCRyiqWdsycXlEU2jwPd?=
 =?us-ascii?Q?VSn83pU/C+iNPZt5i/7NTjbqmwM2R1qMUgsaWTiZXu4L9+V5NMTldLzugtwi?=
 =?us-ascii?Q?SQkdn6knuTIf/U83VEG64/kRKElol0TuOa7XE/RftmqaAtxyBJhygWC99uXC?=
 =?us-ascii?Q?5JaLd5IfL/DQs5rsaN6YxzX1H8enku1BwU2cbO3YhvLLpMn45W7NmpKYzH4e?=
 =?us-ascii?Q?N1kx733kj3nV/JZydlHv/tXzK56ch1a7zbJbwSkjh/hp9c2iJrW5j6d81MPz?=
 =?us-ascii?Q?B1ybmPPytgT9fuGdd4z/GnHzIFvjasRszy9rY/IRLTHlJ9hOOXhqzU0Hn5BN?=
 =?us-ascii?Q?PRcVzYcMnlIMyFrUyLBLw5A0peeBjrejqDShY589jK3CoxAf3hpFbPyt470w?=
 =?us-ascii?Q?czTJoBt4H8csvRIYu9lnBEnS39Hsdj99nwApK8rOxJ2NnnEo1tmIU7in2Jes?=
 =?us-ascii?Q?8Y5zwUv8bDI/T86I63jduzvprE2SijowavODCIB//8ZfJ9cjgKYZsnjgnVp8?=
 =?us-ascii?Q?fie2eWH3Zhx4gGqRNtc0CjTPxDInQSkYQU7F2BXzGaf/BaGQKJpzmSeIHWOm?=
 =?us-ascii?Q?NzKmd+k2XrZ5fS/ly2b+Icoh9lcAZf8x5aCmBpec9KHpG9fl3NbsQHrAgdQI?=
 =?us-ascii?Q?RBUiHsoVKeoMIkNnDb4tJqlAYf6tfgVoULACrZjB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 352f8c90-b2b2-4b2a-1768-08dbb391e6da
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 13:12:23.0672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Av92Ddr5iYy4DH+ubc45R1Ppck62mmx9uksU6voFwSSamOuk5X1OyYcYSexEaggZgr+UjzRfoN7p62yTwOwbow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8645
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Similar to commit d36207b848a6
("clk: imx8m: fix clock tree update of TF-A managed clocks"),
i.MX8MP supports TF-A based DDR frequency scaling.

Since commit 936c383673b9 ("clk: imx: fix composite peripheral flags"),
these TF-A managed muxes have SET_PARENT_GATE set, which results
in clk_set_parent failing with -EBUSY. so use fw managed api to fix
the issue as i.MX8MM/N

Fixes: 936c383673b9 ("clk: imx: fix composite peripheral flags")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8mp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index 670aa2bab301..e561ff7b135f 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -551,8 +551,8 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 
 	hws[IMX8MP_CLK_IPG_ROOT] = imx_clk_hw_divider2("ipg_root", "ahb_root", ccm_base + 0x9080, 0, 1);
 
-	hws[IMX8MP_CLK_DRAM_ALT] = imx8m_clk_hw_composite("dram_alt", imx8mp_dram_alt_sels, ccm_base + 0xa000);
-	hws[IMX8MP_CLK_DRAM_APB] = imx8m_clk_hw_composite_critical("dram_apb", imx8mp_dram_apb_sels, ccm_base + 0xa080);
+	hws[IMX8MP_CLK_DRAM_ALT] = imx8m_clk_hw_fw_managed_composite("dram_alt", imx8mp_dram_alt_sels, ccm_base + 0xa000);
+	hws[IMX8MP_CLK_DRAM_APB] = imx8m_clk_hw_fw_managed_composite_critical("dram_apb", imx8mp_dram_apb_sels, ccm_base + 0xa080);
 	hws[IMX8MP_CLK_VPU_G1] = imx8m_clk_hw_composite("vpu_g1", imx8mp_vpu_g1_sels, ccm_base + 0xa100);
 	hws[IMX8MP_CLK_VPU_G2] = imx8m_clk_hw_composite("vpu_g2", imx8mp_vpu_g2_sels, ccm_base + 0xa180);
 	hws[IMX8MP_CLK_CAN1] = imx8m_clk_hw_composite("can1", imx8mp_can1_sels, ccm_base + 0xa200);
-- 
2.37.1

