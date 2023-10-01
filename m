Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7CC87B4774
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 14:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234963AbjJAMea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 08:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234896AbjJAMe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 08:34:29 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2058.outbound.protection.outlook.com [40.107.21.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6603994;
        Sun,  1 Oct 2023 05:34:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AigZJZkahtwIwh1+ClwtasVXar8JTtj0HgpekceZpHQ1dUGWJCjxtIx1PSsw8YB3hdQz1Tf+cUeOJtjRDUdRoKle5tzzijnL2d/boVblAl7r19dGeROFVGbA5lA6QrJ5xtPNUku/e6R9zyAisPqlXtcxZ9za+9etmcqoGp4EwaDbY9lmHQeyNXU7iN5xXE7VaSXoG5Us98lmC3nCYWC06O2O/MyoBKscQkcqnnKe+h1Dd9sEack9T3k7v6RB/8jf0IioCW8679MOWKKMkdn7kAju+2X6PuPRSi7MiSTwQ0H8LFCbs1oW13c7t5f1tfuzudyKZ5z+FpQUwTQckm5qBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TKBFoXA6t1zyJFBEp8w4iE5PFiGNiC6HHMYYVwlfJGI=;
 b=hPpnfDtDbmLxrFxEV2dK4O1kFnpL55GrBvRVn4AsOoJ0cU96Nj+mujLIwpUdXoGIO/zp7dvMZZ8qnSAypjYDmDI3ES1s0dIoXfzh4C5WOhzmZ1Y2/w1j8noe7vNe+qdChoIlfj7zKGmYVFsbVrO3ooNK6iOSNswWojfJ7Hj4xrjwr8swghRFa4opZoqvh24LVAxxaJdKsyYtYWa8tnYny1gD8LZGFJmyluz9GbhtrSRimGMDJKLGXz1rvdUCuhSsdmF5fuf0ZDfaARKrix1REclP1X2WOYdsVrIl5lkkpZpJpfYnFy7cJqUho0vZ+EVqxyxEqIlPwLY6jeMcQkJyQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKBFoXA6t1zyJFBEp8w4iE5PFiGNiC6HHMYYVwlfJGI=;
 b=MlkhCbk+UH1kjph09Veoxn7q6l28Jog2EuErz1Ah8w8vgVlLtVkYRB890A5iwcj+SBkvXgoFpJmf7BU6EHWy9DC+2dY2B2enVU9Wf5Xd32X1kxQ2ziqM+7GUVLUkfcSL1J2DnHXyy8+DLrXzmlyp1thAvTmWgL3M1WhnBnQWkuc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8758.eurprd04.prod.outlook.com (2603:10a6:10:2e1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Sun, 1 Oct
 2023 12:34:22 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6838.024; Sun, 1 Oct 2023
 12:34:21 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     ulf.hansson@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Dong Aisheng <Aisheng.dong@nxp.com>
Subject: [PATCH] pmdomain: imx: scu-pd: correct DMA2 channel
Date:   Sun,  1 Oct 2023 20:38:53 +0800
Message-Id: <20231001123853.200773-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::12) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DU2PR04MB8758:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f5c9cff-54a9-4fc0-0ab9-08dbc27abcf0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n4d3l7etQxW8oLDJjZEtl3Vnz7iSp1Uwklr4LBzDWuZN1ZBwVM8iam1k1ve0amVQqX2mTnfP23SkwrFpPfPmKmjgYyiCWkxpidcOj/QUuEJckHHXBkPCcvtImYu2d9YbjDfbthk+p6dk6FFd7q+AM95aIzObUpb5cVlUC5JCYtlLEF64iDtuHiJwGZslOtjj9hpLqbBTKy3BONP1vFkAXWbJjLdfqoGRVIQoawm4gh8P/gaUTNnoGKkPt9GMVCLWSHZVjkq7xjBb0F0svaQmZflapcKrlRpd/14FFbgnFFixs2uhFD7SdSWRkQT57i6PKP4tjIQsHDm463kJDEmp1KdJ+TiSy0lw2EvtCMre5htHl6XizPygBLkp28aRkjtC5WpdQ8+3gBe/XUzlA07iH1r83iJnBv3Ek8wxwwzEuCYZBr6mlDO1J/lAAEZadZLjVGT1+pjRkVt1rHSztIU12Dk/27thWbi40ML5qMpA8V7hoER2+x+jLWuo86SHhvt8RRjUK8XEIZBunL54+Sqazqs4KpDZ83m3qJ2JlNPCqI/xSwWWcIuK6sBhEmcNNlqvVlWV5Z8yMOOe0sIstR5Wh/jQmHOiSS1pob4VqGCpOdz6YabwLUTq0GGXKrIOyA+j
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39850400004)(136003)(366004)(346002)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(66556008)(54906003)(66946007)(66476007)(316002)(478600001)(83380400001)(41300700001)(8936002)(8676002)(4326008)(26005)(38100700002)(38350700002)(2616005)(86362001)(5660300002)(6486002)(1076003)(6506007)(52116002)(6512007)(6666004)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9Q71vHPMXyRvyAWwrUgcB5Hi2vpLJiiOw+uOxOMoFwFFAu65qM9ibE1WKRGU?=
 =?us-ascii?Q?f2FDW0IKRvk0e/gKwsoctgoy7Ka+q5DL6mynP9RwrCzeDzULJPcJBfMlJSmh?=
 =?us-ascii?Q?YrUo9Y72fZCe2L7j1ynyTMsX7JSxZ/B4cze41W9kpvWgaOK0LPjt9NmjezRD?=
 =?us-ascii?Q?uzjO9EHYSF97yVrz5Bl7QjahbeaXBNedZ3n8BJIyaDPUoSB7AXDg0zHu+/6D?=
 =?us-ascii?Q?ZgSlA/rQrGCadqn18HcVX0ChXRTFmGOo6FteHFW8sUVMD+x8den18L6GWxc9?=
 =?us-ascii?Q?duGwVXMQuNbj32JHLkLMbKhw6lPIfvWjaKGhb3qWjO8NPuhWu1M8citY12i+?=
 =?us-ascii?Q?TiO/FpRjqOthNNKL7gjZPsZMH+Q/mqZY2ll534LC5j7ukXkjAz3FGI8V2xCs?=
 =?us-ascii?Q?LmwK2Sta7XCPqHq+PvmGklMzb8/qOm0K8UzFSAlI12lrAnYxrWRlmkYDmZs2?=
 =?us-ascii?Q?TD1/K74SvRsje8RTHm0gjI3z+hl0Tsau8q1Oanp9kg3/vQBymNQacar6kOTQ?=
 =?us-ascii?Q?pmXDNpyaEAV73meikDwDJkueoEmhrdKNpGIystSRot4vGDUjTFKLtwoAFgch?=
 =?us-ascii?Q?VkPcmJOdPbYYJIGvvGGQcS9tqUFevGGVFUu8xqxq5eAy/gAYppWJKTMmhiE2?=
 =?us-ascii?Q?cwT3mjskqNW6QNXx5wqo4FJphOJRMYF+ju4Ci40IrftV9l8EPJUjb4E2sRnC?=
 =?us-ascii?Q?l4a+qH3hhLv4oY+wo8MobD0xMU5qAMLB+PjjYlZhxhbKssA54MwnVBWtAlPC?=
 =?us-ascii?Q?ui55zEunELqCC5kgOAmQwvXaBR8MC+xxGhzVDuiHG9GR+uCbaDgvSvDWkvDS?=
 =?us-ascii?Q?TkUiA7haAqtesouZ7XWxl/ieLSNDC17AZ4xnsvQoxbN0LdPyV0pQZ2TIHp6U?=
 =?us-ascii?Q?oRGpQ+ED0yb0VJdi0PHp8ENf96J78BtftisVPNkinS/L8bRbpfJcXCn76F1M?=
 =?us-ascii?Q?iSXAoz1W4YBPI7HxQc12ehelY4vR4rV+1IWX/gl8wxo8K7MWBwtT180IQ2QP?=
 =?us-ascii?Q?IVLmqmG7cFV/zx2jQtDOUN6ecDsOjd0MdjT8qjY4KHhKPwt42FQYOe20P/1w?=
 =?us-ascii?Q?3qqBzhkJrfxZUS/azg8LjpPJ5lDlc2WU+jqYfaghVqzIZWmD6AVlELTl5KEv?=
 =?us-ascii?Q?6nb9E20R+9HluU7sGskMlY51BaHY3pLRHMejQqbcjVfrEv/0fQJ2bZyitUaZ?=
 =?us-ascii?Q?R8JawUWDYEYhMosyf4OVWaA05EYWsMjx8Lv8RrzxCBQcnIA+rAWkLjSoRk6u?=
 =?us-ascii?Q?/R24JZb9Kh371BZqN8dZteq/oPmyvIGrL0RaQJM26nTxnpcZNvXyviKSnYnZ?=
 =?us-ascii?Q?FnJdLUqQVhqdUg3Px1SJQWU2EGyrakXpru/BMoQLLEyMP3EUtIxmICor56ar?=
 =?us-ascii?Q?xMJHbiVulT4rhvnTyJnvPv7jFdBo/WVj/bbLqc8wImqO3NuiaxvAYfai1qw4?=
 =?us-ascii?Q?PAe4m/3LIIkQmPBRVnakS4umvbG/V5asKgbumWk4JdGBfO1ktt4ugsWu1uT6?=
 =?us-ascii?Q?tnQ7SBIQG4BKIXdV7TavuUcsOimmHIzzffK3tD5RFHdkk6n9kP6a9vq+NJOz?=
 =?us-ascii?Q?oCmg6v9uaEe3ZK8qTtpNCmAciZj2hkql6HPQqS2L?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f5c9cff-54a9-4fc0-0ab9-08dbc27abcf0
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2023 12:34:21.7770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dv9yc9PhfKzOPObJ0RIbufa5/hg7qFH5A2e9aTS98KHcCe7VpugxVwpO0655Uzt1aJfR8CgGCsUTfw6yCLjSwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8758
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Per "dt-bindings/firmware/imx/rsrc.h", `IMX_SC_R_DMA_2_CH0 + 5` not
equals to IMX_SC_R_DMA_2_CH5, so there should be two entries in
imx8qxp_scu_pd_ranges, otherwise the imx_scu_add_pm_domain may filter
out wrong power domains.

Fixes: 927b7d15dcf2 ("genpd: imx: scu-pd: enlarge PD range")
Reported-by: Dong Aisheng <Aisheng.dong@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pmdomain/imx/scu-pd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/imx/scu-pd.c b/drivers/pmdomain/imx/scu-pd.c
index 2f693b67ddb4..891c1d925a9d 100644
--- a/drivers/pmdomain/imx/scu-pd.c
+++ b/drivers/pmdomain/imx/scu-pd.c
@@ -150,7 +150,8 @@ static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges[] = {
 	{ "mclk-out-1", IMX_SC_R_MCLK_OUT_1, 1, false, 0 },
 	{ "dma0-ch", IMX_SC_R_DMA_0_CH0, 32, true, 0 },
 	{ "dma1-ch", IMX_SC_R_DMA_1_CH0, 16, true, 0 },
-	{ "dma2-ch", IMX_SC_R_DMA_2_CH0, 32, true, 0 },
+	{ "dma2-ch-0", IMX_SC_R_DMA_2_CH0, 5, true, 0 },
+	{ "dma2-ch-1", IMX_SC_R_DMA_2_CH5, 27, true, 0 },
 	{ "dma3-ch", IMX_SC_R_DMA_3_CH0, 32, true, 0 },
 	{ "asrc0", IMX_SC_R_ASRC_0, 1, false, 0 },
 	{ "asrc1", IMX_SC_R_ASRC_1, 1, false, 0 },
-- 
2.37.1

