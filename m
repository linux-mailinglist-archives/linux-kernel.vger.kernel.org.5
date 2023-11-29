Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7ED97FE2CB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 23:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234796AbjK2WNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 17:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234576AbjK2WM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 17:12:58 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2081.outbound.protection.outlook.com [40.107.14.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838AAD5E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 14:12:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i6nRBm6HmlXSe0fgBJhrfl7GwD4Pu/A53VBh7XqKLBOOQwp5KFJhr2LVSeZ1xlumtjX+YKYcNEKcNXNlePGvp5fze1+IJA12lw0LLLU07w1kTbS+LPFKpzWzqs+XD9mYKzolgNajzp+K9rerRErd2AqO28YQB5H31x/euygJXg8LTbIarTOQLfoDXYev1PVYvb1DIh0iOA1KoJH573H6g+j4KC4hmX5/ILUERbyCkIbP74Jm5i5BDaPGYNhwjcr2zRQH5lAOVlMhhSluLwUVHvwxkbuxEgZ4Fp073cnQybFmuz0YeuPC/W0U9k8zPIN9s05/oJYpOjdClI5Aw8J53g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BYlOqxYRwrA/DY9Y5S2Maw7Zy0Q7zqC4/7Z+mE81oiY=;
 b=G5KrcNF9k09by/6YAbtPqo+m4HIVNLyq4efZZj6jaNKeraUXNjrKuAVyuD4+6g+nq3CaHnQqWFoiSlMeGJUEbdGBUOJIR9QrG/z8L9NGskZCytehRDKmAtO3SLH5sC2A4x6r/+hmEv0H2BzslIO4ZOaeGcdrERZnPd4fVx4am0tur9mulsFGDyqzb9GEVuq+HFO52jAX7L1JnB7YtTJ64w8LyZzjxxunHNxGwpTySjL2O7kRTKkZtygUpsDe4JlH9nmZlhAbktA/XDqq1LAyJ0Tbs6V/SYgXzcclF2NTmoVx8XVMh9OUydCCUd8te3JyQK1PAEeWHTuqt93QCjsnkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BYlOqxYRwrA/DY9Y5S2Maw7Zy0Q7zqC4/7Z+mE81oiY=;
 b=Z+ccet5PNfwC/ORYRkCQ17euIW71id/jczcPU+k7xZbTkfeQ4eUPAZTIs+r5b0P5MceADYlEhQBVjghRSIxRE6lOqe7ICwjmfFZzJuvBGjfqsY8NH92kPelsP+jN4xHDW+sa1anRQ14jtKhuI7AYW8DoMIbRLdp3HpU4wSSHW24=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB9578.eurprd04.prod.outlook.com (2603:10a6:10:305::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.21; Wed, 29 Nov
 2023 22:12:54 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 22:12:54 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     alexandre.belloni@bootlin.com
Cc:     Frank.li@nxp.com, conor.culhane@silvaco.com, imx@lists.linux.dev,
        joe@perches.com, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org, miquel.raynal@bootlin.com,
        zbigniew.lukwinski@linux.intel.com
Subject: [PATCH v4 4/6] i3c: svc: rename read_len as actual_len
Date:   Wed, 29 Nov 2023 17:12:23 -0500
Message-Id: <20231129221225.387952-5-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4bc5fb55-3f16-41f8-9f7c-08dbf12855ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yffM/LEHeaoxrU3rL35KGNd/otUostXP8CSy7cEL/nJ9ajmpeIktFO/BuL7wzUsF85qgqXW9xyK4n8ueI4YtSZE3GyP2ZKs1TrerwtR9XXYgDJb8MaxzsbzMtnGWnHBjtT7Gwkjm4BbdIutokfPieGRXeCry/huFsjS1Ypvdu1t85wUIrKtEqkJiKiUjsWO3Bvk+C/VEF6hKuCMvGgcvPvVf7M6J/vwrWknhsjTYVQlCxePZcUp+E34KVDwy4bEAh3h8TyglrVO+/9d10XouVCELSRFkBjO6KEpIyzYnw+j5sYyTzzS006zwNdNv9WPABxaNTalaF5neqwieBtT0BCTaipGf1lHoRLm5RUE8zJitTdIglxy2ZyXUGOdsMwj/UQseAfFKJnWo8hmbRk3wsVmsQ8n38wKaDO3rRkwyEK6iqQsQGvDbZsFAQsxT14kDqFA7Oxf2uI7Cin7M6c/QwTnTHp2mwNeNg7DS4VGZCk6vXX2UGJMgACVFaStSrelvo6VlOVA1ZGgZ6tIzTEgktt3zfSslNm3WuYxGSbHQd5JDWWB+pyoSU654kXtqi3AU83+Waoq/1Y4cJDDz9tV3koJIli9IUQORFpobQEWxOKbQAlVmrxhYyrmgooU3CSGIeHBYd70NrJit9bjkDNWSabhjPoslXWAIeX+OjQwZpMM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(202311291699003)(38350700005)(36756003)(2906002)(41300700001)(5660300002)(86362001)(6666004)(6512007)(52116002)(83380400001)(2616005)(1076003)(38100700002)(6506007)(26005)(316002)(66476007)(478600001)(6486002)(8936002)(66946007)(8676002)(66556008)(4326008)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wQfaAaYDOE+n44EAMDweCBLfUc/K4O05VxbNaIxH3HbaBi53jI7HUTTM6tZ1?=
 =?us-ascii?Q?0lBVAPfTzVRKMuXcOkmRd7SI8BZc8nB2Wb+RXhruPCJqTUhK61wR9n68o+bk?=
 =?us-ascii?Q?7nzKGrdI0l+Dm7aYI+AZHgVLa+WmbxZB8IUiWcY+0Tutq7uIKW7Xyos/uvZl?=
 =?us-ascii?Q?9IIDn40UHKJx11mLp6+0C76JX8V/qxE8BpLnM1DrOyuWfrGZ917G2JgwVohp?=
 =?us-ascii?Q?vbwjg5hhK9DRFuL9l0A/1U8CuixUYRlkHKAJ45ioc/95NJ3DYo1gqLTLuGLg?=
 =?us-ascii?Q?/O5TZSKx2d9tVv3IajiQmawNqRNgzMYfyv2LSVXdcUcYsI4lDlIrU4ZVOOWc?=
 =?us-ascii?Q?aIwtXg5QigBEbGXLq8nSmi6yWTo7gUU9/sMbbmkSYST2azeU7zjmtn5cN/5T?=
 =?us-ascii?Q?bgAhPVS71uR6wWbOqQGuYOfjahIi20l7rQzB1tTf/BdUtG+6U1NHCvuyfVXp?=
 =?us-ascii?Q?zDW1UM8JexmpIXVm9nbI4esvErIDvWCe1GvSSuLowMD4/BKDyKhhriG67CY0?=
 =?us-ascii?Q?p+kmlp2w8qeLOE9rqSYLF+Bi8D3sVQm5i3apDRnku3smQVFUG/VUvxuUifwn?=
 =?us-ascii?Q?yCkY2ElG5foopGvXmFoeT97wfZ0MBudLNhjZEznKTv8SatSU4FzFV7p6DT8l?=
 =?us-ascii?Q?GGgCycvTzCB3KnKb+uotkfCec2T0cPaPicCNGH9u1adnLyh2J7M/a06A6xtr?=
 =?us-ascii?Q?xU1wfvLKz3oa7LgFvu3ZmoorHjK+7i8gwSlNuK9Hu5XIa9z/WhUp3DoNORhU?=
 =?us-ascii?Q?H8EDgxT/YBeyNkOqmZR53CcKZc1WwWrJXBenPHW9N5uKMh9gQ+oTrYo0jGwu?=
 =?us-ascii?Q?+cC74EqQcn6uJn+JZ/i4tFeUsOi+Z7IlCAFbcKBrAtZ0pKnjNp+uU1lkywN0?=
 =?us-ascii?Q?o42WAPfGyaFHbTgtdtYeGY14sgHa8YIO+6tVG/y9JfFbckgf+c86XM8CJYff?=
 =?us-ascii?Q?az7lNKeB3z5eCqQjBicwIjU7FP/UDoAlzXZ55+QVuHbllMUgbyeR8WD4Brtc?=
 =?us-ascii?Q?qIDJv7qhBW/5ZTZPpghO5TcziDLK57we5LrLxEv2FL/60wFKpUVDmbOyRT/d?=
 =?us-ascii?Q?bHB24Q1mmh3pNBIsmzbxlg3UHPI6hK6PqpMpZ+xOragqO+EndXeK7hNvOug0?=
 =?us-ascii?Q?2SMEdxzV/+xFEY3RDMocJl3dnEIF5NYjzdXM4ZMKYYbb49aHQpQT1BeEJG8g?=
 =?us-ascii?Q?asJ2bmVGNaWo2KKqa41ExnVUDY9DlA6ZxxIwNmFPYB2RYAFZhZI3z+ekBKdH?=
 =?us-ascii?Q?OtLHuXQm61micHVw7C6vcfiTADrg3mn72wr+qEpm5EN7ZMX4EOnqyWVHv/mE?=
 =?us-ascii?Q?Dpf57ag0g6pNodhTR/CYwUvi5W4CuCCkqpzcHZL0zapIaG+PL4AHFlYGM5bV?=
 =?us-ascii?Q?zBdNVCnK1QM3eFpHMmGO4kxzihyI4+JXGo0eqIkALesjjr2MZyCwt/Gr04CC?=
 =?us-ascii?Q?CXC+gGSSAbwhpToosPSpC4G7vPixootnec0FsTgWPzae2DnXcZsjE9SmDABx?=
 =?us-ascii?Q?kk12WIg5X3nQvR+AOPBmQL7onbd0Q8UMCufBtzJIH01ebeMAlevSeNuSFsHW?=
 =?us-ascii?Q?Crm7qony15kslKxvMKeOmqCH83nowVSPJxQ0xln3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bc5fb55-3f16-41f8-9f7c-08dbf12855ce
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 22:12:54.5021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2wfL4SNdkS13YTO1bgQeQWhTV4WahUgkr2YMONHhlvnFnPxNTHyAFnquhr3VQwEoo9IxlETznEhffTJSvHBnJA==
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

I3C transfer (SDR), target can early terminate read transfer.
I3C transfer (HDR), target can end write transfer.
I2C transfer, target can NACK write transfer.

'actual_len' is better name than 'read_len'.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i3c/master/svc-i3c-master.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 880c6ae76c013..be742e6734e39 100644
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
 
@@ -1033,7 +1033,7 @@ static int svc_i3c_master_write(struct svc_i3c_master *master,
 static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 			       bool rnw, unsigned int xfer_type, u8 addr,
 			       u8 *in, const u8 *out, unsigned int xfer_len,
-			       unsigned int *read_len, bool continued)
+			       unsigned int *actual_len, bool continued)
 {
 	u32 reg;
 	int ret;
@@ -1046,7 +1046,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 	       SVC_I3C_MCTRL_IBIRESP_NACK |
 	       SVC_I3C_MCTRL_DIR(rnw) |
 	       SVC_I3C_MCTRL_ADDR(addr) |
-	       SVC_I3C_MCTRL_RDTERM(*read_len),
+	       SVC_I3C_MCTRL_RDTERM(*actual_len),
 	       master->regs + SVC_I3C_MCTRL);
 
 	ret = readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
@@ -1084,7 +1084,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 		goto emit_stop;
 
 	if (rnw)
-		*read_len = ret;
+		*actual_len = ret;
 
 	ret = readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
 				 SVC_I3C_MSTATUS_COMPLETE(reg), 0, 1000);
@@ -1166,7 +1166,7 @@ static void svc_i3c_master_start_xfer_locked(struct svc_i3c_master *master)
 
 		ret = svc_i3c_master_xfer(master, cmd->rnw, xfer->type,
 					  cmd->addr, cmd->in, cmd->out,
-					  cmd->len, &cmd->read_len,
+					  cmd->len, &cmd->actual_len,
 					  cmd->continued);
 		if (ret)
 			break;
@@ -1252,7 +1252,7 @@ static int svc_i3c_master_send_bdcast_ccc_cmd(struct svc_i3c_master *master,
 	cmd->in = NULL;
 	cmd->out = buf;
 	cmd->len = xfer_len;
-	cmd->read_len = 0;
+	cmd->actual_len = 0;
 	cmd->continued = false;
 
 	mutex_lock(&master->lock);
@@ -1272,7 +1272,7 @@ static int svc_i3c_master_send_direct_ccc_cmd(struct svc_i3c_master *master,
 					      struct i3c_ccc_cmd *ccc)
 {
 	unsigned int xfer_len = ccc->dests[0].payload.len;
-	unsigned int read_len = ccc->rnw ? xfer_len : 0;
+	unsigned int actual_len = ccc->rnw ? xfer_len : 0;
 	struct svc_i3c_xfer *xfer;
 	struct svc_i3c_cmd *cmd;
 	int ret;
@@ -1290,7 +1290,7 @@ static int svc_i3c_master_send_direct_ccc_cmd(struct svc_i3c_master *master,
 	cmd->in = NULL;
 	cmd->out = &ccc->id;
 	cmd->len = 1;
-	cmd->read_len = 0;
+	cmd->actual_len = 0;
 	cmd->continued = true;
 
 	/* Directed message */
@@ -1300,7 +1300,7 @@ static int svc_i3c_master_send_direct_ccc_cmd(struct svc_i3c_master *master,
 	cmd->in = ccc->rnw ? ccc->dests[0].payload.data : NULL;
 	cmd->out = ccc->rnw ? NULL : ccc->dests[0].payload.data,
 	cmd->len = xfer_len;
-	cmd->read_len = read_len;
+	cmd->actual_len = actual_len;
 	cmd->continued = false;
 
 	mutex_lock(&master->lock);
@@ -1309,8 +1309,8 @@ static int svc_i3c_master_send_direct_ccc_cmd(struct svc_i3c_master *master,
 		svc_i3c_master_dequeue_xfer(master, xfer);
 	mutex_unlock(&master->lock);
 
-	if (cmd->read_len != xfer_len)
-		ccc->dests[0].payload.len = cmd->read_len;
+	if (cmd->actual_len != xfer_len)
+		ccc->dests[0].payload.len = cmd->actual_len;
 
 	ret = xfer->ret;
 	svc_i3c_master_free_xfer(xfer);
@@ -1360,7 +1360,7 @@ static int svc_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
 		cmd->in = xfers[i].rnw ? xfers[i].data.in : NULL;
 		cmd->out = xfers[i].rnw ? NULL : xfers[i].data.out;
 		cmd->len = xfers[i].len;
-		cmd->read_len = xfers[i].rnw ? xfers[i].len : 0;
+		cmd->actual_len = xfers[i].rnw ? xfers[i].len : 0;
 		cmd->continued = (i + 1) < nxfers;
 	}
 
@@ -1400,7 +1400,7 @@ static int svc_i3c_master_i2c_xfers(struct i2c_dev_desc *dev,
 		cmd->in = cmd->rnw ? xfers[i].buf : NULL;
 		cmd->out = cmd->rnw ? NULL : xfers[i].buf;
 		cmd->len = xfers[i].len;
-		cmd->read_len = cmd->rnw ? xfers[i].len : 0;
+		cmd->actual_len = cmd->rnw ? xfers[i].len : 0;
 		cmd->continued = (i + 1 < nxfers);
 	}
 
-- 
2.34.1

