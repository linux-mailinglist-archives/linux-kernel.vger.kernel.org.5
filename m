Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0CE175EB94
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 08:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjGXGfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 02:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjGXGer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 02:34:47 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2046.outbound.protection.outlook.com [40.107.21.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D265E7C
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 23:34:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cZ+483gVwe8+wwuBHRTlWc/rM/m3jbkNKcYxz6nLC9Clrh+hn8C6el/dgbtfhlNRQ0+qvunT0dPDpPNxvzsbIBNP+iYZt0NXOzk2U+MsXo13hKWMdpQcDRO6mYh3BIn8owJC8YDmL7AI+6v1zJazrFeHkRXAWsHjt4OgxRu+waNLnQFkldDc1/I+z1PPWPqtY3wKCQVjBebnUdGJ2zHRfULkUQekKTLnWuOyzgQgmvv8MdaifVY0BDxL3JKPHMkdbx4adsaChGY7VWW8F0wACeGHIIFawO8rSjTqn9dC4KMvPZtCmwuvlZu53Ga6Beo1MHh5uSmStjbu0SgzUh+Rqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QALHUzHVhQKD3fKu06vGPOUlJ4GnUotQExquzQP0wVA=;
 b=KUiXSbNma00VE9w/9aoEgOlNtEyC2q2pOq0PLOra+vvVk4No0xKkmvz2nkS1+6ihiYFOuXbXRXCs3WflTt7bv2ThphTLfRHkiiMtkiEve8tnZeVSPs0lAaZKes5VP1ejK0tq3OVkQtDf9CqFXj7/2PFf29GTMRnINot8RjR2fWvfliPt5991ikenIZBWMEB0EjEg5BI0Ts28jGzJDujHuRPyYEz9NU1VY0/jk9AfK1mrFX3kstA7ZgUHLu5HdsmGUJUWV/qQCW/VvQQDVrhii6zr/HO+1lwwQ1U/EKjEdxincUZX33a9ww/sVVP8qo7pUuisNGW4Zd6zs52vRVEppQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QALHUzHVhQKD3fKu06vGPOUlJ4GnUotQExquzQP0wVA=;
 b=NaUIQB3bsdR62ACWpMbXpIyhjsQCriQxkU2oAxHT2CEpe6DFm6A7AZHNZsvdY2Iou7OFkZfT4xn3FAh6aTQ12G9JqsgRf0CpxpicL4Ov9kogjwRcatAdC+al3cFFJagXblPLcC12gdy1L/KiwLkxEdjjMPEf4l08nrmrNATUmyg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB9092.eurprd04.prod.outlook.com (2603:10a6:102:22a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 06:34:30 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 06:34:30 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 7/8] firmware: imx: scu-irq: enlarge the IMX_SC_IRQ_NUM_GROUP
Date:   Mon, 24 Jul 2023 14:38:51 +0800
Message-Id: <20230724063852.2666930-8-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230724063852.2666930-1-peng.fan@oss.nxp.com>
References: <20230724063852.2666930-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0010.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::13) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PAXPR04MB9092:EE_
X-MS-Office365-Filtering-Correlation-Id: f008243c-d92b-487a-5a11-08db8c1008e7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 87jnWOthJ7orEw6KKYPOmYL1s2bcxjNqQmPMVoLGbSz0SUAgIFhvHpjq2X4UsAAm6NdrxdfkiQlMNxmdl8BpB3E1+Uwv0p3w6f0urgLqFybKqR6egeBHOCMK5WeO9ndKTj4UroyPhzZqC0tvJl6SvppZJGNsxauYo8V6Y8DiEwirFIbDex0flvi6emDRd/PIYb/1nvTrmaW8mPcwKWb9nDmwEkzlplzXYLyRSEnQii/96MRMWvIVfqc/mdgjDzNBYJnbSBVov65gffXaurbRoZq3x8+wASWycpzK32to14o+QqgsyKTJAgvd0aCZ/Cwrjz4s2tfgLpoetCzF3hpDraWXlegz2FXLT02770XDHj6beG17HWeOmjj8OoAlQNtlAKWK5q4LQlK8bFIryISkCH2yQJxqHXbA0hfLnLKrzGciR7qDVgJeDI5WgOAX9c9+j7TE8Mf7bq4XWXlKZCGlESBeREy9mGMG83jrUmDG3r0bLsSAtuAswNYjTNdPBhkRfuF2pW3oqBs100CYxJduXkovK7FOy+flDJddMu4mH1IrXF61JlLS+SizFmQyRlr+ALbBTQQlhPX5N/R7LmLiSIoONUSTWDIICR6Jejrgc/XJR4hK0MovgruhfT8HElUV0lIlf4KP6eBUxlHfwzfVEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(451199021)(2906002)(38100700002)(478600001)(38350700002)(8676002)(6512007)(83380400001)(186003)(6506007)(26005)(2616005)(1076003)(5660300002)(86362001)(8936002)(4744005)(6666004)(6486002)(52116002)(66946007)(66476007)(66556008)(316002)(41300700001)(4326008)(147533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?APVNIOnRAFJXy26LKtvjIhhqYItWY5j4TnDYG6/8YEy6n4B1kHQ2uoxkjlFP?=
 =?us-ascii?Q?yYbp+aXaknA/XN4yCQ4sEfzTAGtHr3/Rl2ccO8/pW8xpEEoCxhZIbjkcVtw8?=
 =?us-ascii?Q?v4u5V3Dmxs/rtLIx0TR3IHbEYTN2+o7bu4xS9oGh5Px4WXmccfQRZMK6xXrV?=
 =?us-ascii?Q?gRGiN4KAivjuh6I4EtkSh79z+fRv92XncRCq+MkkFeUdIJJm9p7yf4UP/Iet?=
 =?us-ascii?Q?OSBYrGX1GQGBvVSGEswK4dWZrZ3I07NlVoCi1mIDA65K6pGigCYNaYD8H7BP?=
 =?us-ascii?Q?L78uVHoCwh7ntrmXsuD1Po2AiKy0gXAeKpzDEKKMgRMVXTjzW00uCBqOTHEj?=
 =?us-ascii?Q?1ylNb3f5NzLuaUy0MokCcd5t2DEQrUCRW0RWyRABusGLxa4Zfj0DO1YzGe3b?=
 =?us-ascii?Q?SXmLSRNyhjtKWd3amAh5FwDrfsNgeWMGo7mBn1iTnAiv4UNf2safAK3u/GWm?=
 =?us-ascii?Q?apKAgNEwkmVyPP1wjrGg+Su6gLb7LeJs49E5Q3Cjp+Y5vgw5aCB380Om/PJX?=
 =?us-ascii?Q?fp6UUZ84RJxxffL67EdoGrQBmHDbj7FZ/SbNOY5h0gHkWmEaRgd8iPWuVhlX?=
 =?us-ascii?Q?Gq6UvexHAiTglCnjpOEFAYb7PaHQv6CtfI2kw8MOB7rWYe6ndTSHabEGqkQM?=
 =?us-ascii?Q?82lkDOkBJq8Bh4M0i81f7IGTZfKOberfAQk0x1Nz35mrLpDb6Yo6dlwDsudQ?=
 =?us-ascii?Q?vuIK22ccyykOWN5WG8SN+5Ci9+gI+pX4ktTim00JDn59aLajfV3t2P9YDObi?=
 =?us-ascii?Q?fuVi9uc2+QpQguwH2CsdIVBM6Df8/lJ8Xxz8xEySs+lKhW6QWlBuQu3+Tgj8?=
 =?us-ascii?Q?FBnri64nJcSXZiCY3HHKIz9z5DiEDPbdB1YIWuHC4tgWIGU15WjvTROyG5ss?=
 =?us-ascii?Q?/T4pMgNdmYR4Oy6Lhp7xe44apiarj597B0LXAcgYmIiCtPgLnsrTz8765O0x?=
 =?us-ascii?Q?EpQLYnsemV9uJMJhybjS5bTNNA6Hdo80CHcJrkEW5UosBtvsNdNbsGMSyEdi?=
 =?us-ascii?Q?8Q260K7EEEA4T4Br4sCQ0SPxyZOvMH21j/HRNiOhCyWwbPQh0RiQ1zA5w8As?=
 =?us-ascii?Q?Y/SyJmarJXJnY9xfgrbj0hIfxC1NkwX+Qy0gRRlB7VOkRXQ+51fL9WeAtrbk?=
 =?us-ascii?Q?93GDR46tenDku6NVJH/V+PQ9ulkdPxkILpfg6iYRNhgukjGOKp8IyYNzqrIo?=
 =?us-ascii?Q?hG64qYz8Nk7o/RrzSLswNcal+l5JJSa1CaCMdKArwDAwiu0aC6ICcQInS0ea?=
 =?us-ascii?Q?bnNtQrqx7XzakDOUtF1XYFFAeMF48q8tRI7sstFi5qlkWvvdXO2+YaxPWTNp?=
 =?us-ascii?Q?UhSiWqeomMUnISNeJwVFpwBhECVCB4Bw6hSF7A7a9aWj+RSftMoU0WuneH0Q?=
 =?us-ascii?Q?NjeVquN6MnajQwe/3uPWD3j/CN2Aa0N2lVlDu/V2XfAo1r5H/kafuK79DF9k?=
 =?us-ascii?Q?COmu50kXtdXYoMvdnP1eXI6IOu6Q9+MUyx6MiQXEfTTNSx++xYe18NNOQlRs?=
 =?us-ascii?Q?eYRmgGnuCFVXCVoezPcaHgXQITLnArFEhJuA3EOgGxqMMH3+z9luSkc1VdEQ?=
 =?us-ascii?Q?iU9MQV4BEPmiYVuFTa/wD0bPN2MYm8ZHn0JKRIa4?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f008243c-d92b-487a-5a11-08db8c1008e7
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 06:34:30.3072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5iYTcEJVTc1TVUqQIliwvieILXt1lZ0btJ6ByTzxbCKbAHK/mCgoRdIPtS2L1cUMEFGbq1/0OmVE73jKcxuAhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9092
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Per SCFW update, update the IMX_SC_IRQ_NUM_GROUP to 9.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/imx-scu-irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/imx/imx-scu-irq.c b/drivers/firmware/imx/imx-scu-irq.c
index 6549f3792a0f..8d902db1daf2 100644
--- a/drivers/firmware/imx/imx-scu-irq.c
+++ b/drivers/firmware/imx/imx-scu-irq.c
@@ -14,7 +14,7 @@
 
 #define IMX_SC_IRQ_FUNC_ENABLE	1
 #define IMX_SC_IRQ_FUNC_STATUS	2
-#define IMX_SC_IRQ_NUM_GROUP	4
+#define IMX_SC_IRQ_NUM_GROUP	9
 
 static u32 mu_resource_id;
 
-- 
2.37.1

