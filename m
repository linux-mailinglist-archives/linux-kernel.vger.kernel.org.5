Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582817BCD37
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 10:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234258AbjJHIdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 04:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234215AbjJHIdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 04:33:42 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2058.outbound.protection.outlook.com [40.107.105.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AA1C5
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 01:33:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IeGMbycp6x/BidSUr2QxxZUC1Tn7+pLpYP0ASinbfcEIupkEljIcyHgWkzVCbxvj80Z+RUXpxqsHp/c+X/QcQfUtL2Px+cDUPbZo8iBQOi6+kMATbkApYbD+JwYdmGZHeM2qmvyA6WlLQ8Y3hUNk1IavrGPX9XI8/YyBoVceTOP50RgD7gf6MjMswJLrAdigPhnvQ3hbDOQMmedLkDrTsr0ePnhp+74MuV9RodQp/xrIrIIGXQnXORDpDjF0/Ro45xEblvm/LyCH8W7CPOrjYIYzOQXN0vbla/j9nPwcF+ltp8tH9J3B4QSqaGtPCTb/QJdbN96Y+QpravLdFgqT6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=igc/7K9YrQMjC3lf5ySs6WDL5r9UuAjtc0yXTDB6HnA=;
 b=HzXLm98j3frtey7eP26lfDcBi5tI3WMpk+XTomzZZwUgy3cDrJ2Jtqmeuv37Ir4sId5rxfUYODjcaNxPJysS7+G6jheHXPg8LMDGe/91kOVdmlVZWeGNhuHsY3MYIjkpHaXnsSEbenSihIXCbP3pQwZVZpKA0Q0FbZ7IsLa1P3++VPWpcRQ+Z49U/goFwj55ZfNj7XhsqHRfCeaP4I5lrzMG9SUwOy9s99N+y/dqy22lqD8P5P3fhhbLHeifA35hdVvvONDce3/A7v0NBMUsfMiyEjx8hqYj2aPTyPg9ucDrwjGHa1uxgR0Lb8DFUsy6I7F5AkMmuvx6CUKaxx4vcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=igc/7K9YrQMjC3lf5ySs6WDL5r9UuAjtc0yXTDB6HnA=;
 b=LnULYtiWH7r161wsYMSTv6Tzjr5CFRrQ5zZPeBWxnwD19RetdM0HTlKiy1+vZiUL1pHTvHScyEyLfJKPMRMUOTfHUFcSJBTgHOcwXOkw/jC9xlqbIwTtmKx3bhGyEE1yrPLGG8FamVLE9+s9SaiSl6xI98OsKBje2q3i7QkkThM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7799.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Sun, 8 Oct
 2023 08:33:38 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6838.040; Sun, 8 Oct 2023
 08:33:38 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] soc: imx8mp: support 128 bits UID
Date:   Sun,  8 Oct 2023 16:38:08 +0800
Message-Id: <20231008083808.1517132-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0005.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::17)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB7799:EE_
X-MS-Office365-Filtering-Correlation-Id: d6863162-5c79-4ac2-86c9-08dbc7d944a3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L/2ALryRiPpy937Tj2i62Rf9BQ3EbpihHAp1KtPa5xKAWB6u3gydgrguOTcToYRAULNFx4kUB+xm8qPxuB/j+ZDDD874RIDh0CQA9ZOIEdf3jqaNterON/xldvzy+EFqjUgxmrgvRgY2KdsoQq3VU86he6OBt0UTs3/L7cJgOZlLQPpz0N8uxs/coJDf9GCUrE82/dpf93ODA2rzz5HUahvN78c9qCnCzuyHxeCifmqnvnC85xhX/1LHdJ8WJ6OgK1r5sGdRMBVs0r7pIFLxToEoHG0ZRKhJl3kq4XGR5f40kkbc5tNlcsNnOlAi77wVZLqFZrG9fiMlhtjnEmwJBh9vsHoJwsIo2SbYVeVzpKASUP4nS5YFQHoOU9FHr0NbASQ0wraq+DHQyZQIUIkCVJdQlkEASY0XPmusEkwtiNuv0kdwdoDkO9tOL1JG2n9+7rbFifVKSf/Tjbt8cSok5baT90SpFuTF6I2ZA49K8OwKp0Uu1yNL8sr17MgqCxyiC6MhtTmUfQZVjkIu0Tba94LYlwVelbJONYYa219au6Ln6nhYYm0wQZXrM+GjB2K+gEgiwuMHATBl8JWIFTENf0wB/G+vuOAxzbWG/l9z0EcEdnSSgQeaY8Uatg5YsY6gEcdqGkc1Sb5BFpOGZX3U4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39860400002)(396003)(366004)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(2616005)(1076003)(52116002)(26005)(86362001)(38350700002)(38100700002)(83380400001)(4326008)(2906002)(478600001)(8676002)(6666004)(6506007)(6512007)(41300700001)(6486002)(8936002)(316002)(5660300002)(66476007)(66946007)(66556008)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fZVpOs1ZODqPaT+I23m4s6K2of4c1X7h0/qQO7RUfK2hwD6A8nLfvKV9Z7Yt?=
 =?us-ascii?Q?fJCoNhesmunwmDGiknM0colA8s3ImsK/jos6IJlfXxnqaY5Aud72HDIjXCGK?=
 =?us-ascii?Q?Wu1HF3+Boha/QjGHveGjRcXRRFa+YuOPrIg8dxdG1S+VGqdUfeSPflL7THEx?=
 =?us-ascii?Q?GYFfHrTTR0IdgfvCjGxUgtwxsczND0SI5daXWs9RF5RHDa2syzYILOptA2Hu?=
 =?us-ascii?Q?EflHPauQZUpBJCEt/gtku5Fu330n3P0S19ty/6UR4QBJ5iwuxBdSPbpMtVqV?=
 =?us-ascii?Q?qC9RRwHxh3ikz6s8xnhWXAH8hdBbvJ4Pwyqad1tSUPp0569QlhZkDl0dV+gM?=
 =?us-ascii?Q?AAfyUWy0SuQaNXRvo6+bvP8nCO1kUH25A/0sfFb1oGJ6NWw3WRCy2OHxhcZK?=
 =?us-ascii?Q?Oca0WrxSXr4ECXkJ9GlkWlyBlSuYwq0KOfeM1jB3I4q89ipklMdPYD2K5ohC?=
 =?us-ascii?Q?kYUdbX/9riNVedPqXLIq/cM9xX+bxcEF99tvFBAImppN/VsrALtawd4wpUzm?=
 =?us-ascii?Q?2Tk1swRMOBwpuqkwaZykNqTYGXgEYV6p7oiEAbpfifQHDAMnx3l7ZarsRaWZ?=
 =?us-ascii?Q?mAPa7dVvNBswLa50NdTXa5n8AsmetlPblT+pfl3/H35d4mB52SMCXbUg4+Ax?=
 =?us-ascii?Q?VWgUlvnqJKmreO3Nba8Y3XCk+3H65LU2T7bsyTGq+nLQ2mrG/a0baHMog2Vp?=
 =?us-ascii?Q?hXjGEUqyUXPy5mITuHR+bBKGBjI8Np92A50b6uirOgPD5o8gJ9/Vu9WfoeV1?=
 =?us-ascii?Q?0YHVB/Gf52/aVkKar95g+MHo45kTa3B458Ik3845jrZEjAjmFngdhTCg5LM5?=
 =?us-ascii?Q?yQgGybe+5tVVxSJQoO0LFWSikr6GaAU6zGFycgxmNvnQbEQ5nLm7EL+Cpcj9?=
 =?us-ascii?Q?qgRP68P/1UsMm4NDZyEGgnGoXfBg4kn/0WGSrROhIrslTKNhv+btvytSHNjC?=
 =?us-ascii?Q?kQRSBERJCsxhr1hg6eYdC92MH1q9F5FCt9AyAS98Y0DsaYH4EXLo1uh7V5Rs?=
 =?us-ascii?Q?JnYz7orrKZnUbZhQ8dHqAmikhkbV4igLQymjMggI7GK8C2wLWlIDTvSDtF5G?=
 =?us-ascii?Q?lA6mh17N0k1t/qR3chPeKFj1mpGxlzWAG8pETJeD1FUiWZyMy2iKC5EG1y8C?=
 =?us-ascii?Q?2V+p1D8Ztk2FHyrb3+qzWjK+agOtuIDpksOXy5dTOhVrMZI9nyp/+VSCZXWZ?=
 =?us-ascii?Q?cRDDRSfdE2k/LIoupd8GwHHGk46uBZvBo1A0/JwokD3uxLwEysrkBzNJ0RUd?=
 =?us-ascii?Q?948GUhaV8IGh5wc5yPp5jZXowazarPNUpYSM+4hTlWPBbvmeH8NakMu55qoy?=
 =?us-ascii?Q?Be/0k7QnaBVMlXkEWSE7K13eaLCD1KHrvqSg0UCHKgCgLb9nPIMTeboa5Gm1?=
 =?us-ascii?Q?wWGroqhmd3WbUujFNp8o2fmyN0pYUpcbG7qctme3JwwJ241JWM/71ci+0cr/?=
 =?us-ascii?Q?Zi9uFI93qLrsyQ+4FojJXrWIvocSMpJ/vDfZ6wWvfz2YeLp98nj5uOcNcgLS?=
 =?us-ascii?Q?IWDnCcLI/tT3NtmUGbe8itPmPMgWaLIeYg4wq/PL4GmSfDaJiVoec7qTStn6?=
 =?us-ascii?Q?StTVnDPutv26pYGWb8sGiwUO3oxhWFhlRBV04GO8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6863162-5c79-4ac2-86c9-08dbc7d944a3
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2023 08:33:37.9286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cMnTbWGc/mvItpc5bGvDoiyQVm1wuhvc/PsgKUeo43CmzI9j61hZd84Qmy0vTCSRwvVchWMsycgA0aGYhDEajw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7799
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Current driver only supports 64bits UID for i.MX8MP, but
i.MX8MP UID is actually 128bits, the high 64bits is at 0xE00.
So update driver to support it.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/soc/imx/soc-imx8m.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
index ec87d9d878f3..5dcc227d41c0 100644
--- a/drivers/soc/imx/soc-imx8m.c
+++ b/drivers/soc/imx/soc-imx8m.c
@@ -24,6 +24,7 @@
 #define OCOTP_UID_HIGH			0x420
 
 #define IMX8MP_OCOTP_UID_OFFSET		0x10
+#define IMX8MP_OCOTP_UID_HIGH		0xE00
 
 /* Same as ANADIG_DIGPROG_IMX7D */
 #define ANADIG_DIGPROG_IMX8MM	0x800
@@ -34,6 +35,7 @@ struct imx8_soc_data {
 };
 
 static u64 soc_uid;
+static u64 soc_uid_h;
 
 #ifdef CONFIG_HAVE_ARM_SMCCC
 static u32 imx8mq_soc_revision_from_atf(void)
@@ -122,8 +124,15 @@ static void __init imx8mm_soc_uid(void)
 	soc_uid <<= 32;
 	soc_uid |= readl_relaxed(ocotp_base + OCOTP_UID_LOW + offset);
 
+	if (offset) {
+		soc_uid_h = readl_relaxed(ocotp_base + IMX8MP_OCOTP_UID_HIGH + 0x10);
+		soc_uid_h <<= 32;
+		soc_uid_h |= readl_relaxed(ocotp_base + IMX8MP_OCOTP_UID_HIGH);
+	}
+
 	clk_disable_unprepare(clk);
 	clk_put(clk);
+
 	iounmap(ocotp_base);
 	of_node_put(np);
 }
@@ -222,7 +231,12 @@ static int __init imx8_soc_init(void)
 		goto free_soc;
 	}
 
-	soc_dev_attr->serial_number = kasprintf(GFP_KERNEL, "%016llX", soc_uid);
+	if (soc_uid_h) {
+		soc_dev_attr->serial_number = kasprintf(GFP_KERNEL, "%016llX%016llX",
+							soc_uid_h, soc_uid);
+	} else {
+		soc_dev_attr->serial_number = kasprintf(GFP_KERNEL, "%016llX", soc_uid);
+	}
 	if (!soc_dev_attr->serial_number) {
 		ret = -ENOMEM;
 		goto free_rev;
-- 
2.37.1

