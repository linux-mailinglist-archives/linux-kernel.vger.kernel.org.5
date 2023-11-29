Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3CA7FE2CC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 23:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234674AbjK2WNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 17:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234918AbjK2WNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 17:13:04 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2054.outbound.protection.outlook.com [40.107.14.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A05170E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 14:13:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5QwvBRRs1kY7yJmGzFKM2vuRkpKLV5BCvsOO/R+uiZsT1vVhm5QCLkrNeQJI2hLl6NJkM/tH38AFieThU6ebg6uTZoz78vn1zmOFj17aCkS3c17jtDN6uH6yM0dMFFBcfc2KcRIcTw9hPIHMxHoNoz+MiPrZWR8AOtcjG1OvG1ThdJ6rBU1iAxALbj8eo0lvZMB9YA6pQGnimNPFkLxVZKOZ/CGhb1KSEdeSlnIfS6wjEHVsJ8xba38BM3pTMuqGR3AHcfdUN+mcAREwR/d/0rfNBiOp/pC4bjOoj12xukZHBz4TR0vzvV1e+blVHvxr91nuG0DjJPoYwrrqf7hOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2/YV3nkqc3UDSc0gYS53JKr0jm5PsR0IRqF30SYf6s=;
 b=T6IfY/b6DTTfzLtlzWcN+ebztrQ8xNGnJ7kCnSPcE0z3u1mqvkRKwd+KFoFhOQXQe5hE8pEwkGNu5z2XZSxd8tJYbIXZzoTMG7CIvcHPE9e3ZbonhOAXl/HFiD498AugLCeBdPEIMQLEeEBYarVk9yisSzsY1hCcgGfQWvBMBpX7wc7j0thiN0kcW62jMkWIsjieB25M41AVGedPNX2l9fyYMTHuUGZ39jEwRrUrpDSyumxIJk0frsVdrZjBXUWKl5UOVtVcuuipcXkv7pewi9lScbxqCTIfAWVvobCMXndZ0jhuzUn8U2fpDqWKnbVLzEC2rJvi/VX8k2Fcvhf7Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2/YV3nkqc3UDSc0gYS53JKr0jm5PsR0IRqF30SYf6s=;
 b=F7BbBMsUhXUgcB1JZ0s4oTRQZY6bkVVsJSQZxI76xuLjdNjWMAU4HDshqu/3TkEfbl3VoLNcnkhUyt/q0CDybqwFmc6/uweBOT+iQvJLpjunbe/JKMkf3Qodba+GTjVmOGcJNVBpFvQ7E3D0l8+zIrW9Jy5cvxo+xgRaVNf51TY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB9578.eurprd04.prod.outlook.com (2603:10a6:10:305::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.21; Wed, 29 Nov
 2023 22:12:57 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 22:12:57 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     alexandre.belloni@bootlin.com
Cc:     Frank.li@nxp.com, conor.culhane@silvaco.com, imx@lists.linux.dev,
        joe@perches.com, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org, miquel.raynal@bootlin.com,
        zbigniew.lukwinski@linux.intel.com
Subject: [PATCH v4 5/6] i3c: master: svc return actual transfer data len
Date:   Wed, 29 Nov 2023 17:12:24 -0500
Message-Id: <20231129221225.387952-6-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231129221225.387952-1-Frank.Li@nxp.com>
References: <20231129221225.387952-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0003.namprd04.prod.outlook.com
 (2603:10b6:a03:40::16) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB9PR04MB9578:EE_
X-MS-Office365-Filtering-Correlation-Id: 58f96f7c-c90f-4b49-5c68-08dbf128574d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xfwVV0mxbvSnUIqN43btO6qB9nIC3/6W7sKDlnJyJbpgI+kS+H90MjJqKntiRClDDUewHrdKzuow2PQUXtCca4dw37Df7FliQv38K+9JYY3NQAqbV5R/c0Dtr8hacJJALLW9/Mx83FnAd3gL3EpbNh+S+fCL6enAaNH3x5CifSsjKKjci38DVkVPtjScNERqWFdCPaVeEarGqh/JVMuaJ3JyXjL0bA5EzQChCqUMURmsfmNvKxeQCwQR76TLE8CjaN/pM26iouLFHBKxWufnKSgEtfXKJ5sdelBwhW9q+Q/cw49l9YO3l//B+MA7LNQmtk76DrMQ9afD1Ezh0g0iPk0/OdKhDvuTRVASMjXXmjwUjhcL+yIHj8rZbDp4YRCKFO0jhPsuRDFxrtgKIKs+D4MhyruhJiHShO+WPGp+bQ8V8FHuXQEYaCf2fa1aHfBz69WC80FlfcHR/cEf1vBrcuyFca6AUXDViK9di9HKUBOqubob6xp763fPfsVxxHoQ21A+KLWg5++v7AYPwNFCr3Lh0JLTJejeoA5Y+JdildEQXEwjI/u2RUHrqFdlyiAEmF+lu3P+srPUj9Eg2K9U9FCvcwtYOvqsXSVs9UMoIMyP8lnt5W7qhaFpWNL4azKDhF0E+wPVl308cEkCFdTJYiBNOWlO+RGVf5PX9BM8i7E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(202311291699003)(38350700005)(36756003)(2906002)(41300700001)(5660300002)(86362001)(6666004)(6512007)(52116002)(83380400001)(2616005)(1076003)(38100700002)(6506007)(26005)(316002)(66476007)(478600001)(6486002)(8936002)(66946007)(8676002)(66556008)(4326008)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/okbGPYL3DNgegIHqv5WJKuKuArHt8I00VAZ69CRP+rTqNTZ1IqMaWt/+ASy?=
 =?us-ascii?Q?ezJjCs+keKu3cZWrmsPmHyn487/mK1iuLzFi5nqQ5KRceFqjL2e21sHYm7ee?=
 =?us-ascii?Q?bJ9E/YLmKWamRd2ncnq87AsCecA3EfJgD3Aqcob7drhCgdbH7ISX0KmemmCn?=
 =?us-ascii?Q?Jp29+ynHErhBhsVamtVXjYTOQcVM0nRKwOLefHEMkq8mZ+xX31t/VK9nxom4?=
 =?us-ascii?Q?fVROX8jocVfD+niPjrHPwvhZCyRlBk8Pg6LErAUkDqRd9uot8PJ10J2cjmjb?=
 =?us-ascii?Q?cekAbF+SP3NyiNOwjWQnQ6xBY9oV9ZDXlJUsN+1vla0ZWgDrXrI8757iG17q?=
 =?us-ascii?Q?sGLjRLIQviM7SYRMnYbKcsDaxVMN7qP+noW/ogEgkT/H6GCGbC52KawUqiPK?=
 =?us-ascii?Q?37MysKZVnxsVPn2Qn4jqTU+jiCLyJ+II4tuarB1B97amZg7z9sIjgjHMi6VN?=
 =?us-ascii?Q?KVvuGRe0QaetyeIYcM3z90qLP73AHtOTo8fWDo/sg7br4GcLXHjFHfogKb8w?=
 =?us-ascii?Q?g06boeThhJ2C6legp+TCoHM51Mz1zAFfEcptalUxXADexqaUx3SQTlsHJznz?=
 =?us-ascii?Q?w2PVO+Xws5xcN9Ju6P74B/GbboNRqBxwDK3pcWGQmm9PLAuMHOYTkx7MwZQz?=
 =?us-ascii?Q?ZwKeQAuo2rjJ6b33VXP75OB2nEblEE3BHFGFRFnKA4dFpbQ1W7wu9vWHJAM3?=
 =?us-ascii?Q?0pYl/bUO2tNdMBXGhIWkRyR/R2mseIgf2jOb8TiL4aunXO6BYcL5hfSgatsk?=
 =?us-ascii?Q?5lsZFyleblThJbRbS1IYK6Fh2QK7kLPd7zJZDBjVHn9Iyb9IG2LVV8eBwGiR?=
 =?us-ascii?Q?pYQfeBEWNYIrwb+RzRj4Pafgi3ncytnzLmStdn6SoQ263QTZwm/w+p1O6DjO?=
 =?us-ascii?Q?s43uON6BKBXiWXVAQhJNmQmWjieMqkdVK6MWqmH5L9x4O+W4ltxxywMRiqZ1?=
 =?us-ascii?Q?PRiPFgyhiyfFG5BvSzu183a5jFBTcdNTTO7bN4lL/w1LZ7WABxd7UkjtN1lF?=
 =?us-ascii?Q?gJbE5F6Xf51Tif0aXS6jGe5DGSfy2f5+waca4ltHTp29hhGlPe7dY5nrj8b0?=
 =?us-ascii?Q?0rKMG39HGbIdbZxyeU/E0+DcElxpAd+JKmCu6M3hlbjt8IeYIu82FBhc3eaV?=
 =?us-ascii?Q?68/jY4Tre6GYNKwsfVaYLEyPROUTEQtBPcygOqbHrSpdbXrwg54CnSUNoTgc?=
 =?us-ascii?Q?mU+fZBaP5hMnT0ZUIzMwGAe9fsACt77Uh+7dM1EqJcmoZ1Js84KoPa1jo2IQ?=
 =?us-ascii?Q?gvLs8hcbgzWu34vH/p82QqQN4sLKNysuC/GD7wxY3a9+xwoZ7F2vQi16JSLi?=
 =?us-ascii?Q?i1Mm8HH/Kg2d9VXpoWFjXaMNifyDrXfLV2HAwm+BBjJ1Y/jFTcd+Kc1WnI8m?=
 =?us-ascii?Q?v08jGJcNpvFJxIwSLQWlpyBo21Obrds0p7t/YadSyuC39WY+Z/6GPV9QqwLP?=
 =?us-ascii?Q?kqoHYWaWGRDKMBnfW36sJtDvz8gsRglgBDSUrjyWhhScWXuPjp79MpxBbcvO?=
 =?us-ascii?Q?hWc9AN90dTkt3WkFxzPfsZd7hR2O9NeZadU49rYPvKguSXINzYW3FD9gLNYv?=
 =?us-ascii?Q?RA8Kn0suFNzm8WtOC3iLSQuRTitYutId/2Ocpjzw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58f96f7c-c90f-4b49-5c68-08dbf128574d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 22:12:57.0049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8VvR9+CqVtcyF9uTwbwidtWHxLlTZSl5xvWuEBim0Zr0Ak1KJnVmIXrS4YC+t9PGlKTi6fqteL4WPBbCEO/3Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9578
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I3C allow devices early terminate data transfer. So set "actual_len" to
indicate how much data get by i3c_priv_xfer.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i3c/master/svc-i3c-master.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index be742e6734e39..9dc12f9936a27 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -138,6 +138,7 @@ struct svc_i3c_cmd {
 	const void *out;
 	unsigned int len;
 	unsigned int actual_len;
+	struct i3c_priv_xfer *xfer;
 	bool continued;
 };
 
@@ -1056,6 +1057,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 
 	if (readl(master->regs + SVC_I3C_MERRWARN) & SVC_I3C_MERRWARN_NACK) {
 		ret = -ENXIO;
+		*actual_len = 0;
 		goto emit_stop;
 	}
 
@@ -1073,6 +1075,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 	 */
 	if (SVC_I3C_MSTATUS_IBIWON(reg)) {
 		ret = -ENXIO;
+		*actual_len = 0;
 		goto emit_stop;
 	}
 
@@ -1168,6 +1171,10 @@ static void svc_i3c_master_start_xfer_locked(struct svc_i3c_master *master)
 					  cmd->addr, cmd->in, cmd->out,
 					  cmd->len, &cmd->actual_len,
 					  cmd->continued);
+		/* cmd->xfer is NULL if I2C or CCC transfer */
+		if (cmd->xfer)
+			cmd->xfer->actual_len = cmd->actual_len;
+
 		if (ret)
 			break;
 	}
@@ -1355,6 +1362,7 @@ static int svc_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
 	for (i = 0; i < nxfers; i++) {
 		struct svc_i3c_cmd *cmd = &xfer->cmds[i];
 
+		cmd->xfer = &xfers[i];
 		cmd->addr = master->addrs[data->index];
 		cmd->rnw = xfers[i].rnw;
 		cmd->in = xfers[i].rnw ? xfers[i].data.in : NULL;
-- 
2.34.1

