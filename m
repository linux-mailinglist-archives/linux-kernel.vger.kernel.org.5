Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB81577B6DF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 12:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbjHNKhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 06:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233811AbjHNKg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 06:36:59 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2068.outbound.protection.outlook.com [40.107.21.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9201FB;
        Mon, 14 Aug 2023 03:36:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tm56X62miaigmZXvrm0sJXsQDnAZoFM4een+y62ipNGQal00mi2l/mDGszlhm8alM4Yv/BCQNvApLmw/6116SGP08HwYfZmAFlKhdz8gbuuXPBpQ4AMv5OEWVllmO4mhZkb77ZACqDM7cA4uKzCWuzujb9y3zoYUhBQH/N/pifYifQSR7NMDzdOHTPFThNAjYmLWHSSOxb6oCPL+Ofoj6vrs/Y6wnWxC4P5uAgqJACOminpgt6Nwi8xCzrR5t7bLNn++pXPWIvRXvh7Z/fCXK0MKQZ5T3OTRHd1A9bo+iSNnxJ0dsV+gL2W10ETFhDl+RmClLxsnnk6mTQ/avnho2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rkvjEz5P5bLiSv98FtG/zmYm3TFZEB8qrvdApjcpSqs=;
 b=LKnOBYyjixx5/Wrc/kwSJuW4CtSgAIj6KunQRIEMPVikxesNy7N0lREPFLllrTFgnZIlwZ3tyv7hTft2r0FRVLRsAUQwi5Iu+Gwjt2PM3wSIkc/B7EIw4+FD5U2gpwNjFm1FmJXUmU91mNQ7kbPQPfZoSavOyfTl6TDUeXXHagW8ipV+zOoFj8HRFm3/Qav9oZgYqIY79ucs/XxTZfli1DvrslSrJgOAmvKauNZFTUverfxQsf7nUkDvfFE8JEWRLQcrm2sJLtIJnt6GL+XDvBGTVVEhYdfNVAnkcVtyah5ctvkCgyr+BFcfYZ9p1sT0hNWixTW9pS72GP28ut5yOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkvjEz5P5bLiSv98FtG/zmYm3TFZEB8qrvdApjcpSqs=;
 b=kFNQY1mAvy/hYDRZqy3hkW7Tq4+tQS2py1nIUu2YEaqbhtR8mTdK+QDJYmuOplLe/cmtTggVsgllVfuN/tn8hHzSnQToKrENP0JdMxekN03tsfLaVmJLVoHN0GHpuLPcWDlHkX1+0GqhPCXKcTOwSxiGnmpQ06p18t8FQ6e31Z8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 10:36:54 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 10:36:54 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     ulf.hansson@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 1/8] genpd: imx: relocate scu-pd under genpd
Date:   Mon, 14 Aug 2023 18:41:20 +0800
Message-Id: <20230814104127.1929-2-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9c1a9139-0008-4132-0341-08db9cb26091
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MH6YVlUEI/jF5egfN4pHQ0MzMq+zM+YFyKDPMTh7WI/rCw1AcdYW1exsfm4cii70GtXW5vj2+H9XoAnyxOw65b9HEz3rCwsBwplVk2MLBfk4cXF61sr55QGkpW+IHQXeBMJQAy2fkq7p5aWu4O8Aa2COuj2mnjcKJpM0cRqoOr9Q5WV3wgsn9WVtZjs2afWXhVMr1fM8iYcKqCReZgHVTAYR93UEwycBsHYyqlTPAucFRNT2g4ieAxIHkOPz90I44SExfelHiSYgBBEJKhxiGTE6svyExgBC0mdtnKjSbkpchrKeAqFshilcjyhwcSsW22KKeviUUuuyAeUOG4szNy40Vq4EtigPJUN+jnLepbXEUnRq49tmwQxu1UJ9N5NLIzaw65bfKYQ2hrn3ertogESxDDRRGaf0iHe2IXT+RFAc+tAAkxLy7UwQ9rmlWuh2fd544h2tGRUaMkEqfqcs3+y0AkEvNpu30v7GyawKWD5pbfrtSiDdT8WAhFxtFdzei2+CjiqRz/wLBJ+TvtS2ZdAeOwzHspjmozT8e68uT1sDCYYnmIqXrw3FxGKEri0vK/X/KtMVuMQcHwkRd1pfm5T3BwjTfyTCeEXKRm+KFKDKAxPSYa7n5Q7gYTpFTXxs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(346002)(136003)(39860400002)(366004)(1800799006)(186006)(451199021)(478600001)(6486002)(6666004)(6506007)(26005)(1076003)(52116002)(6512007)(2616005)(66946007)(66556008)(66476007)(8676002)(316002)(4326008)(8936002)(41300700001)(5660300002)(38100700002)(38350700002)(86362001)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z8FjTiI1pRzturyS8n0hHPsWMa4+3OFi/1UvPCvFvKdiXS73zdo838ABRNrU?=
 =?us-ascii?Q?KzHHkvZE4SRWlSQVZND+zFK+IoJSUXlJU15Pc2v79AHsc4eoVGYC6cXqbFHS?=
 =?us-ascii?Q?WNQXpxbifJ13/JQMVzxktsXArE4KBFXaWhKpZXegNHBsZ6xFL+LaNY8khNc3?=
 =?us-ascii?Q?2qY60ZLGek2OYRdUHSiQb0KUG0gwiH9KEpjLI+7fLHh+nNIoh5Gb6fO6d+5j?=
 =?us-ascii?Q?J5lybagOYTVfafc3247fiItIl58I8bJFSr3pYbrpVLPyRGc4hYajUqIKYxvE?=
 =?us-ascii?Q?7qMkKS5h9hQJnVIo5WtQaV7j1R0w3sirC4atk0gLt8BWziqwI138xZr548cl?=
 =?us-ascii?Q?UoAg3wSscogvQ/QMQNb+bywTqjfqZwwT/CuzosrJb4mNZyw92Ptedt2rQwT4?=
 =?us-ascii?Q?2o1529IHU90NRLDzZHWaU9qWTuytMT7KrSTg17seSPa1l4WP6cFBuEkVDp2T?=
 =?us-ascii?Q?ngQHtpHSUBtEO6eqkW9dVknh4E5+5h9Ux76VC0FyjNPlVwFkvNOTTk4A2Hj9?=
 =?us-ascii?Q?ZJpSbdQQ4td3nwmNaVC6ZrBrdSLU3/Bk82qbG+gTDt3F7H7dWM5aa7E1EE/4?=
 =?us-ascii?Q?Lye/hIG/Oc8murTZ9dF+pSbFI6LxFb5n6AHfjK6lHKar9NKIUqjWChNv1k7p?=
 =?us-ascii?Q?MoOqObcfvGuTJNOjFoZ4AMINuFkqup8kM7sCKH8QGVUw/MLEZoqSB+y45H7t?=
 =?us-ascii?Q?m+OL5Eo2+rbEf9Sb6AGB5PBMV9+lUVOlY7fPeEcrnLIkM4jmm7HtGpjDPLqU?=
 =?us-ascii?Q?hrxCLCCAggbl38azxvCcU6m0Vl1RmNdVVksarjNkILWC+rzW3iwTYMl7zk5z?=
 =?us-ascii?Q?2BudrephDrCTkBNJJ887YLvDGQ8fweHPE004/s3Cm6soLghjuUKMupH2SZ6B?=
 =?us-ascii?Q?y63cYYhe5RxClRRqQNepW0oJ6iAsbb54rXQi62CqK6AwV0Y++Cz+kZ5stOeH?=
 =?us-ascii?Q?Av+sAREKFuV+PfOsfaZqCSvukLASCUm67XhnmXh/h7fy+i4rcjoevhgz7R35?=
 =?us-ascii?Q?cNN0GOJHsE2N0uRVvkwZdLgO0WOY+OMWkjSaJDfn7k9qL8MeQ01m48cMdIuU?=
 =?us-ascii?Q?edDO8A6Xz89khiY/GuJeBkkc0mYgpgrc4rRQ8EbNYq0PL6Z/b5r5MX1ETGLw?=
 =?us-ascii?Q?O0R4z9Mq8SXN76nJS9MvUk5Ma45tpGkW4xrzt8OqxT/unBO8Xb4fMqsr6Ob8?=
 =?us-ascii?Q?c/3RmoI+r2WKxzzcQ1aUs5J1hL3ksKZ8beQBcbEEOEUOKrIqvSrRgWTf2oMG?=
 =?us-ascii?Q?z4m0O4oZejk6azhtNVflOg9DnNrAdUUymadqB7zXpHyKeJS89B+Fz3ihwtoo?=
 =?us-ascii?Q?uFvNJ8GK7jT8nsTmgMwtXrk5cqKjbGXpXRHVxaUYXN4iJXJAF7nhjhwnPaFh?=
 =?us-ascii?Q?P8hIyFm6X66n5P5gXbmmu+inWKgS7UtWBgaYXoWfy+8zU3+o+gssRUPRGCPm?=
 =?us-ascii?Q?bnqJ14B7yn0xgj/I9y7qzVj12XqaE47CC7QFnZP54DSU9D9gkKgyhfy6QzHj?=
 =?us-ascii?Q?n+QwK9bjfBIXOdC9iZ2mWHwnFEQi8a8j1/4T3w0f2YsoXAC8eHlnMiNbIpeP?=
 =?us-ascii?Q?Pra56PM6i3hgmX4ymeLqsySmOa3lX94+R/J9ScPr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c1a9139-0008-4132-0341-08db9cb26091
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 10:36:54.3128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yQMEfmQBebw6A6QpYZJ3AVc3YoEl2Xca6ZXEelmTaEM3fw2Fw8lswFey7RTzLS14H7SCAF7n6qvRO7wUpd9oHQ==
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

Move scu-pd driver under genpd directory where the driver
should be.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/Makefile            | 1 -
 drivers/genpd/imx/Makefile               | 1 +
 drivers/{firmware => genpd}/imx/scu-pd.c | 0
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/{firmware => genpd}/imx/scu-pd.c (100%)

diff --git a/drivers/firmware/imx/Makefile b/drivers/firmware/imx/Makefile
index b76acbade2a0..8f9f04a513a8 100644
--- a/drivers/firmware/imx/Makefile
+++ b/drivers/firmware/imx/Makefile
@@ -1,4 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_IMX_DSP)		+= imx-dsp.o
 obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o rm.o imx-scu-soc.o
-obj-$(CONFIG_IMX_SCU_PD)	+= scu-pd.o
diff --git a/drivers/genpd/imx/Makefile b/drivers/genpd/imx/Makefile
index 5f012717a666..52d2629014a7 100644
--- a/drivers/genpd/imx/Makefile
+++ b/drivers/genpd/imx/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_HAVE_IMX_GPC) += gpc.o
 obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) += gpcv2.o
+obj-$(CONFIG_IMX_SCU_PD) += scu-pd.o
 obj-$(CONFIG_IMX8M_BLK_CTRL) += imx8m-blk-ctrl.o
 obj-$(CONFIG_IMX8M_BLK_CTRL) += imx8mp-blk-ctrl.o
 obj-$(CONFIG_SOC_IMX9) += imx93-pd.o
diff --git a/drivers/firmware/imx/scu-pd.c b/drivers/genpd/imx/scu-pd.c
similarity index 100%
rename from drivers/firmware/imx/scu-pd.c
rename to drivers/genpd/imx/scu-pd.c
-- 
2.37.1

