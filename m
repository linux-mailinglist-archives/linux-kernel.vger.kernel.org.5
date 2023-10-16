Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011207CAE09
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 17:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbjJPPrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 11:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233830AbjJPPrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 11:47:01 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2068.outbound.protection.outlook.com [40.107.105.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846CE83
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 08:46:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FePhy3FDQKkK4p/W+jKqMrAhfLaiHcxhyoOMmC515f/v7CjHHE2ElRfFqakeKdjr17gkGFa7A+hlIfzLgCw7sQFZqZu1r+gqw39N9/pz1LbmaU8jh69QIZDBbvT75vHpW5WWUe0nKU5hQ06uNOs6Lr+R0Q3l9KQwQNTKXjA+zBEbTRjCBspj4V4WZo1fgIQpWyX0R+aNECJxvoLic32OiNH2EGaAnvPf201iiUVybbpBjdaX+exOH071q1HlGunUAK+RZ/qQanZmhd1OXPzpQRk4xShpp7s2jBsFAoGT77AzMEcIfKA0NcDp7SbinZZxNbnAvPPbjHvB9EzCRGj4FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLHHTxYnZgBT1P+zxKSvT0yfK4m2Bh87+eq/thPm0/I=;
 b=eZjJkxjJasigD1vrZYNDdpc7PqAn2iK8op0zBKBlpNOqSQj22vjXBKZppCrIPHFqcnaYGXEQ+KFxUtf8CMjjw1npE0vMlFwWkJvi1OhSFUTfzqfYpVK1C/24kElUsR9OM5hBm//G9K/BAcGNsZQwV/AzErIuc+KDr9wAv7gNMDqlDEdGKdyq2bHPq3ZFigU9rOAJfYlujwPyZBZp+W6BmjW2tpJJOl9oLHxQfXwyq3sV7GHwsnOkwuS9NLYvlNfdDHxtUDaCbLSlIHWKE+xqa/0+JmX7q5bDntUVfQCet3HOt9jE1ILVXD3fQIgzelM8rtEX4y+IAaz95mFzy07aMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLHHTxYnZgBT1P+zxKSvT0yfK4m2Bh87+eq/thPm0/I=;
 b=aKMROMOkMevOzDzDvm82bWDCv82tFFW4CL0FZ7HtkgeofpJ4/2KiSVAAzmz9l43AFJooVBzJ/z3NflIwBcnAgDLOGZOeAAdkOPu9VIxD4xYoIu91FYZ4WoFb1ai+1kghjzW6Ok4my61y/JXE7BlLy/t42lDXJe2c/w6z6zCstoo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB8329.eurprd04.prod.outlook.com (2603:10a6:10:24c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.47; Mon, 16 Oct
 2023 15:46:55 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 15:46:54 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     alexandre.belloni@bootlin.com, miquel.raynal@bootlin.com,
        conor.culhane@silvaco.com, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        imx@lists.linux.dev
Subject: [PATCH 3/5] i3c: svc: rename read_len as actual_len
Date:   Mon, 16 Oct 2023 11:46:30 -0400
Message-Id: <20231016154632.2851957-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016154632.2851957-1-Frank.Li@nxp.com>
References: <20231016154632.2851957-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0089.namprd03.prod.outlook.com
 (2603:10b6:a03:331::34) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB9PR04MB8329:EE_
X-MS-Office365-Filtering-Correlation-Id: 13f4452e-4a36-48d8-02a4-08dbce5f1f3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sEnhSdoX2aci+Tt16neEBngChGa37im3tUGzfvjurC0Phxy1mn7fU53TfMIQBzbU9wv9CVYhYA2QW+aFzoYinrr3y3t8etrpyPP6Xb/mbK7ormB0bcKXmYGaRCGwXR9Yjg/Rqas5bVAuLjhzTlOb5K3JAHtJJHKmyCEhVSGwSNj4Ic/Q3nDRbmg/ffzr1VCWwkXjwCkN3ePGRWhFm/DHlCB67kfJUvTSNKotlYPM9SZfV6dlOI5qJZ2HFXLlHl8vALMIoYIFBJEUgUZqFOnwSKVmGxduMoGCQlROLPqfM/YZ1uG+xNyeut7pnTXXTqLZ1VbJy/hyXZbrdx4LI0+q1USHfXOt73OCxzfkL8e7+kExv8ew/7jG8zjsxzExxxz03Zpq8pJWRQv0US7MBVl7nsBdggoXuNlDrkhPdaXUYFjj4tZIi5oJLTqr7GBfDUPL0uqfJcI1KLBc0B0B/+ssKgemptGQEsUa8wTGazaU4xWTSRSf1i1fT4JIAF6707cFv3WtbpWmmGVIaFhWFkRgwTc7DkZIKBbjU147yPLC3YsQFpvKOS10tsmbFrOurS5ZeQQZgJfpNLm1ZBGmNgkIr1XC61K6bf066lzmLG2tS04CeMBZB54ZHckaxObLZZcA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(346002)(376002)(396003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(6666004)(6512007)(6506007)(52116002)(5660300002)(8936002)(8676002)(38350700005)(478600001)(6486002)(1076003)(83380400001)(2616005)(26005)(66476007)(66556008)(66946007)(316002)(41300700001)(86362001)(38100700002)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NQWI7pH9Xi9gNjr1mSV7lB5IUbcqQp0e3BRxSU6+/uMBfbIeuI1yeDCG0O9W?=
 =?us-ascii?Q?cS1bnkwHebrU0Yd0sQZRPdy0YMnF4OxyXxC7JIGqr/Q1wXmo8TAwHlNOm8xX?=
 =?us-ascii?Q?VkbRdGC9XGIxsiKp93AilfTNweuIalNN6kigcOMYzpSZJ4QV33SA8orEqjlQ?=
 =?us-ascii?Q?dKJtkKAt0C3FuzZJiTBGbd7ktX08EDuHz/844mx4vIbq38FB4n0dnRdhVTJs?=
 =?us-ascii?Q?SEBCvDx3R6I+cyo+R9pPNw22SDKnhZSvUwk9fc6yXY4FvT6cFgDZzVInHhCD?=
 =?us-ascii?Q?FNKnVsYKREGvfZcNHo71uXVs1YmAmOf8fEMq0fZmT/MosS3EjXUkWeCklx4V?=
 =?us-ascii?Q?+N6rIhqd2ClunvAsyMbxQ0qNFulGUtQ+hsFdzQCj/8afKzh/54Q7MGn7YDU6?=
 =?us-ascii?Q?JeLkGSA3cWR9AH9K9+PCPwk2pTHcgaSvyy4eEAr4kn2cDlKXFeVEOITGiOIS?=
 =?us-ascii?Q?llK65tbssgMmJVtvdly7EgkrQci/2ThuLjmL2uXsxDzw7cnoHB17eeh4M6sY?=
 =?us-ascii?Q?Yf6cirFppZTcgldZ7tXGBiBx+4n5l95RQl6Lmp3xLuVRV3l8UT83tcuVwrVB?=
 =?us-ascii?Q?6WpsTk+J3vLTKq9wtGGLtpft7+8J3cEtnGwd6EEeg9Zoorjs94RqoLMW0UFa?=
 =?us-ascii?Q?v0jcgv6cb0ULp++hiCcCmdSzXJQDiai/r8Gcw6329SQAHQjK3gEvor1ViHJ/?=
 =?us-ascii?Q?J8xngYY3uQK9iZUhG5Ocexhxf5wge/S2edpQcHPXjYKrTYA1ZRENGLmrG2F5?=
 =?us-ascii?Q?2juNuMNM0HBUwrX4cRV/1sY3SqPzMdX7QLimlMe1cMmLUtX1CiRXk4f1CUbQ?=
 =?us-ascii?Q?ytl3DMbbIow+4BopAeDePVnVwHX9WEmHvgNQT6+kGY4tQHlXyNPMGpx1GOOu?=
 =?us-ascii?Q?547m108fUHoxXh/y+rD5uGt2CpoHU/FEiz7Bmd/IVxtxT18pIVFdgzcpeV94?=
 =?us-ascii?Q?2dxq+JljtHFtjfnbxcM5Jc7bXgkoQDpl7yasTgqrpZF/RDmX5IJKvlF3PdBA?=
 =?us-ascii?Q?l60chMnmud+XP1zaTHfc+2R12kjqr5OqnRKE7M4jnOMBdh5E6/S0Is3a01gn?=
 =?us-ascii?Q?AITVO5FERk1zZL5VKrMDm4zkM0Yqyid+riVmXIP5uXBtjBdkkrmdkP2JyM7H?=
 =?us-ascii?Q?ekhp2v9vklR7NJlXP++3AQXTeKk6TPyFh4QbpykBGRseSzaAunfTefwBhcLy?=
 =?us-ascii?Q?vtUyg8csI5tXOPHmBTGND1KaotMT1HKGIH0JvXPGzDVJ3dcagfkua3Zmdx+p?=
 =?us-ascii?Q?5FnrylvXndrGf2O3n3pWAW+9UDli+cnWiLMdJ20jxTO10LbiQyiDnV9sczcQ?=
 =?us-ascii?Q?r720ekNolL2WlmuiyIUlRvGMXeej0U4FMe56DjjLFYWq1hiJcSs9EKwzXY+T?=
 =?us-ascii?Q?8nKYGaTWMSjKXfp+p2lwk2FxzpCqy5CDVcfXwdBEpbs7kmhNw1ozanyYFE5J?=
 =?us-ascii?Q?bH+L1p+Q5v5xlXcfMwcfZ4ejbZKiWkAzmk/ka7MMYllFwWpa7mO1yRuG/Pmz?=
 =?us-ascii?Q?EkWf1ZT2FaMRzxkFalhGYXWNIN4h5MN9hWTKRobGo+Ze1GwXEQrdJQPO/WUD?=
 =?us-ascii?Q?8vsva+yIQ1VKYqZ1WH0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f4452e-4a36-48d8-02a4-08dbce5f1f3a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 15:46:54.6724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2siZ+6N1jqsO6gBklU2WvZgLnMz4RqG4mUBlmC9GO35MDrbghme0tkrCph+c3q/GifFezA3vRpK8KWfZPgB4LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8329
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I3C transfer, target can early terminate transfer.
I2C transfer, target can NACK write transfer.

'actual_len' is better name than 'read_len'.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i3c/master/svc-i3c-master.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index f0d99b029e5f..3570b709cf60 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -137,7 +137,7 @@ struct svc_i3c_cmd {
 	u8 *in;
 	const void *out;
 	unsigned int len;
-	unsigned int read_len;
+	unsigned int actual_len;
 	bool continued;
 };
 
@@ -1022,7 +1022,7 @@ static int svc_i3c_master_write(struct svc_i3c_master *master,
 static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 			       bool rnw, unsigned int xfer_type, u8 addr,
 			       u8 *in, const u8 *out, unsigned int xfer_len,
-			       unsigned int *read_len, bool continued)
+			       unsigned int *actual_len, bool continued)
 {
 	u32 reg;
 	int ret;
@@ -1035,7 +1035,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 	       SVC_I3C_MCTRL_IBIRESP_NACK |
 	       SVC_I3C_MCTRL_DIR(rnw) |
 	       SVC_I3C_MCTRL_ADDR(addr) |
-	       SVC_I3C_MCTRL_RDTERM(*read_len),
+	       SVC_I3C_MCTRL_RDTERM(*actual_len),
 	       master->regs + SVC_I3C_MCTRL);
 
 	ret = readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
@@ -1073,7 +1073,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 		goto emit_stop;
 
 	if (rnw)
-		*read_len = ret;
+		*actual_len = ret;
 
 	ret = readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
 				 SVC_I3C_MSTATUS_COMPLETE(reg), 0, 1000);
@@ -1155,7 +1155,7 @@ static void svc_i3c_master_start_xfer_locked(struct svc_i3c_master *master)
 
 		ret = svc_i3c_master_xfer(master, cmd->rnw, xfer->type,
 					  cmd->addr, cmd->in, cmd->out,
-					  cmd->len, &cmd->read_len,
+					  cmd->len, &cmd->actual_len,
 					  cmd->continued);
 		if (ret)
 			break;
@@ -1241,7 +1241,7 @@ static int svc_i3c_master_send_bdcast_ccc_cmd(struct svc_i3c_master *master,
 	cmd->in = NULL;
 	cmd->out = buf;
 	cmd->len = xfer_len;
-	cmd->read_len = 0;
+	cmd->actual_len = 0;
 	cmd->continued = false;
 
 	mutex_lock(&master->lock);
@@ -1261,7 +1261,7 @@ static int svc_i3c_master_send_direct_ccc_cmd(struct svc_i3c_master *master,
 					      struct i3c_ccc_cmd *ccc)
 {
 	unsigned int xfer_len = ccc->dests[0].payload.len;
-	unsigned int read_len = ccc->rnw ? xfer_len : 0;
+	unsigned int actual_len = ccc->rnw ? xfer_len : 0;
 	struct svc_i3c_xfer *xfer;
 	struct svc_i3c_cmd *cmd;
 	int ret;
@@ -1279,7 +1279,7 @@ static int svc_i3c_master_send_direct_ccc_cmd(struct svc_i3c_master *master,
 	cmd->in = NULL;
 	cmd->out = &ccc->id;
 	cmd->len = 1;
-	cmd->read_len = 0;
+	cmd->actual_len = 0;
 	cmd->continued = true;
 
 	/* Directed message */
@@ -1289,7 +1289,7 @@ static int svc_i3c_master_send_direct_ccc_cmd(struct svc_i3c_master *master,
 	cmd->in = ccc->rnw ? ccc->dests[0].payload.data : NULL;
 	cmd->out = ccc->rnw ? NULL : ccc->dests[0].payload.data,
 	cmd->len = xfer_len;
-	cmd->read_len = read_len;
+	cmd->actual_len = actual_len;
 	cmd->continued = false;
 
 	mutex_lock(&master->lock);
@@ -1298,8 +1298,8 @@ static int svc_i3c_master_send_direct_ccc_cmd(struct svc_i3c_master *master,
 		svc_i3c_master_dequeue_xfer(master, xfer);
 	mutex_unlock(&master->lock);
 
-	if (cmd->read_len != xfer_len)
-		ccc->dests[0].payload.len = cmd->read_len;
+	if (cmd->actual_len != xfer_len)
+		ccc->dests[0].payload.len = cmd->actual_len;
 
 	ret = xfer->ret;
 	svc_i3c_master_free_xfer(xfer);
@@ -1349,7 +1349,7 @@ static int svc_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
 		cmd->in = xfers[i].rnw ? xfers[i].data.in : NULL;
 		cmd->out = xfers[i].rnw ? NULL : xfers[i].data.out;
 		cmd->len = xfers[i].len;
-		cmd->read_len = xfers[i].rnw ? xfers[i].len : 0;
+		cmd->actual_len = xfers[i].rnw ? xfers[i].len : 0;
 		cmd->continued = (i + 1) < nxfers;
 	}
 
@@ -1389,7 +1389,7 @@ static int svc_i3c_master_i2c_xfers(struct i2c_dev_desc *dev,
 		cmd->in = cmd->rnw ? xfers[i].buf : NULL;
 		cmd->out = cmd->rnw ? NULL : xfers[i].buf;
 		cmd->len = xfers[i].len;
-		cmd->read_len = cmd->rnw ? xfers[i].len : 0;
+		cmd->actual_len = cmd->rnw ? xfers[i].len : 0;
 		cmd->continued = (i + 1 < nxfers);
 	}
 
-- 
2.34.1

