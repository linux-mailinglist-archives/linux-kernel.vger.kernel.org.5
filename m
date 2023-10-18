Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDEA7CE1FA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 18:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbjJRP7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbjJRP7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:59:50 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2049.outbound.protection.outlook.com [40.107.8.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD0511B
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 08:59:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ejz+2WQVDrE3Av4MsHY1HCoNN10iReF/YAhDtdn93cTnUvFy+Ne8hDGr7Zj498CxYN49FhslrKzn+6/SB4Wk6XWeI7Dpk0MxoQuUUzNaTAQwfB8M6SogQNa6xAm31kwPpNEcGhtJ6jVdlS7CKrj4SH4O8drcJY/kV1SH2hk2stmtoux5w7QqskVXaC4sGXlb7ecEE5WSbUb6vbXhG2Su9o7Uhh4QbuqWtkUy4NVUKXUFCBfjIL41TtmD1j6o4SElp4dBFGpEQ6SfigdXU6qDuaZ15nAnyEN01aPyTuPQua2LMYzX46PjJplY7/n3KDAUERxGNUaGiZLIzN6WR2+1iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6/0l63ENa1rCG9AOCfTVMMHkxQaSAkgSO/Y9e4768s=;
 b=Ah+ARwdmGqBMcPEzKZIKXM1gIi9lo26Ni7qzjdwR8BKmSqXm1yVUg4fbvG3HesoIrbE53ivTEtGL9NKlINI5cUBDhlDptbGe27DVnfxCcCsaGcyPPJkBpBjMHbS/77FelfMENGlvscCGjwhiwNSu1rWVxDT6G29Pw5xsCziItWrf38OVAFH0zbXnOXb6u6RZ4Ca36/oM5PC449uTkK6IDS5oXsHQ9tC6wOJ3yunyciVMULEg7P6FHKJqFCeqVgDiYtCgPnreG16K+8oDDnfq6gJp1nuNaGE+niJPTfK19W0VU2IfuCvKkrb63sSePCqe7WhxlBgske9580gqlDmuPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6/0l63ENa1rCG9AOCfTVMMHkxQaSAkgSO/Y9e4768s=;
 b=Q5NYwqvQ7p8iWUSztW7xtRxFsw6uN+1HhjOCFGmrDn/OfwQ54JKs0e4iWvc3fwyG6yBOE+A7fJLDzF3DrCHKpjHd+iTdbsqAv+IsG6Pu3X28F1dGYor1j/XYG1H7hOrKenm9S3hJR3Qc2C09nzLnGj4aabj0SX46oViKLtkc3lI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PA4PR04MB7694.eurprd04.prod.outlook.com (2603:10a6:102:e7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Wed, 18 Oct
 2023 15:59:46 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6907.022; Wed, 18 Oct 2023
 15:59:45 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     Frank.Li@nxp.com, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 Resent 1/6] i3c: master: svc: fix race condition in ibi work thread
Date:   Wed, 18 Oct 2023 11:59:21 -0400
Message-Id: <20231018155926.3305476-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018155926.3305476-1-Frank.Li@nxp.com>
References: <20231018155926.3305476-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0210.namprd05.prod.outlook.com
 (2603:10b6:a03:330::35) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PA4PR04MB7694:EE_
X-MS-Office365-Filtering-Correlation-Id: 8422bf32-b37a-469f-a9c8-08dbcff33f0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4C4+msirxM8mh5btHeCFDfWuzAmQWS1If09OhsBbkJ4J3NyDmWnJwnBIKUie5BR89x2QuyQ3tusLBxMTCSGwp7vJZ2fqDGkWSi3YDljpaIWrnwZYZjdX2HTAoY53noBOW/PpPE2kSjhqZuGRpAYCiasGMBR3C7y/MQUHRvv/vESrE92MFyPQvRkulaX6amtI4V0Iy9DTr2tqKdCnUVGm+zxom0WBCqTDQmwGEkPXJDnrUeeKIp66jrlC5oS8mhjmhYXtpT6I9/kKUcSpdhVB5OGzaAckzN0nWxBwP7yAIIejY+zLX/mu9Iy5I+gHnOWmc5kXYvx+fzDtPWRAMrXovcFOPskbfMDmAFl+XqOuetkY3MmCGiTRGlRfXDxT24viW/kuMG/fwNHtZFjJqRhhsoxzZyCwp4NIOGDBufHhDdyUPgIRz5OIR41sYi90Pb6GvLsFE9D3YBf6rxly4maNcZIOr9eIm4hUO90/zdBvgWMPonEYQKwQ8GdpHir5Hmkz28aJtFYPj6EQnvyZjzN0vL9bV6zwJw+ZLmel8fTNhXhlPUSgE4IiPulgczolmlIcrq5utN7E9U2ImKPVlKCxtCu1yTgjQiJqwFtP7D38gaE31Q344yccd+RFHfVq9Ca3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(346002)(396003)(39860400002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(66556008)(66476007)(66946007)(6916009)(316002)(6486002)(478600001)(6666004)(2906002)(38350700005)(36756003)(86362001)(5660300002)(8676002)(8936002)(4326008)(41300700001)(26005)(1076003)(2616005)(83380400001)(38100700002)(6512007)(52116002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RdDsDBLkX1y1e/C9zijEOwLjnOlwWObwlyZLzAv1OI0cDKpq0cmFsskZkNuk?=
 =?us-ascii?Q?EY28KdBPw1mc7y2XYw0Rvrjhl/cbZahd/NCnFYDZt6s/dmbaqyda1/HCRqFb?=
 =?us-ascii?Q?h5Xoub4NU+/0ez88kTQFEu2s3UoKxJztFfs7yYRHP745d5Q8r7Cs0he7mAgV?=
 =?us-ascii?Q?98RURsR55XGVuL7Q6lU+1V68X6CBeDuyo89/lVxQg9n3Lj4tqiWHM1NZxlqe?=
 =?us-ascii?Q?ty+nPa2SMmwlMngikZk/Uswr//uFFCWUpvfruABsFUSynKuDstqoe6NBjjzA?=
 =?us-ascii?Q?1v0ycp70SI/nqlM6JuKkleGIeP0JXsRJDLbsuh4JHByRoRMlHdhER7nlxalT?=
 =?us-ascii?Q?BqjMiJ85sXdU66IG+gqLMPwwrZ5g38ZUvm2L8QqR/5iR3tkKIPvv8hQlKbIs?=
 =?us-ascii?Q?3ne2feP8DGm7CCgR5PlWpjZhFWdZs7i30pMgxQZeVyMidcnCYoRIZimC+zln?=
 =?us-ascii?Q?+qClGHSTC6QTC3tsj+OlMoq3ezLMdtZ1ZIJ33/BtUa6mkevaEbqhCqg/7nk6?=
 =?us-ascii?Q?cUoJDhWVfVNPtj7Xmj82Nk63wrVXZzmph/2Sy0Orv1z5tk6UE2c/1Rgue1fO?=
 =?us-ascii?Q?BP+CT6p8588QyCb60IHZyiHFrrz/BoLtFjycPGV7zHWwxZx0VNo6KVLZv+Rv?=
 =?us-ascii?Q?A6XJymEcUd1pNH+LAQvuUdTVd/gPTMxlLZASXyaq0rozAGGQiz7r/hrZJkZX?=
 =?us-ascii?Q?uVj3z3dNx4t6+XWJBAb9nto/LR2eb1K+0mLQ0XJMLKMF8E+s76seovt2wavw?=
 =?us-ascii?Q?6ix+WhZEHKN3Mnh/qBNtWjElb5+XNpQcHV98XYEgbIXj/i1tLVtdIjHEImkb?=
 =?us-ascii?Q?Zat4VWI7BDHnWkcT6/vciMoNd8Vl+srQQyyZMfSFIeIEJEgi1Gq4c4jYqBYB?=
 =?us-ascii?Q?tqlZ8H55bll7a/ASPvSf1BIaiH1GvMaX5y0JNq7kPcMzrPaYwV5pUE9br+K6?=
 =?us-ascii?Q?kTBQBSaoHOfWfw2WRCIFOCGkiim1X334pjHyRLo18SAsowDZ8IOKgapaSYdk?=
 =?us-ascii?Q?ZybGXmNKmpH0Vzr7aqDONYWT9vxzuWQE9Qy2Sjh4GG9+ACTS3Wb3+GjmHhT5?=
 =?us-ascii?Q?CggrXiZE1HaZTlze0/Kp8oSRXHbY9yS5VkFp/xHVWWjYkNtmGV34hvPwfheC?=
 =?us-ascii?Q?WL17YSkdhr0rf64kpmJuHycgYSFkK9S/ojltYczQltPZDhFnCw47c1N/3F40?=
 =?us-ascii?Q?szrjT6wUCYbtqMBxcW9JzcePBnd/lcfHPURVg8iaBYB/Juun8kN5JxbBtgWB?=
 =?us-ascii?Q?hiNDn3khlJ70SjREUhsbd6/bNQ6ovq4g2IG0306GL5H7NsvTmnUGCjvUBAtf?=
 =?us-ascii?Q?rEFElfBuCJlTKwxQiBi1Kisz4AWNR0EX5G2ZuGsECOZtNjTIMx63OCvliY+Y?=
 =?us-ascii?Q?rNQSDZAv14IHyBYzt9CJjBcwDmXpqABbVIBAmPkaFunfNzEHnb6bLoYOB5gU?=
 =?us-ascii?Q?X4gn7uPaLdA6lqifi3C8qCgf55WbTcsBqCVFVyhk3pHSdjiSA88Ip6yVL91h?=
 =?us-ascii?Q?xRZAuSLJOXV+AJXep0KGo+gpZ/bwX+y5vJBASVXud1pTq0sfkduW6An6lbvb?=
 =?us-ascii?Q?unQwuxKfYJlVYe8dCrT/GsJ6qCqVl8O3jD0VeN10?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8422bf32-b37a-469f-a9c8-08dbcff33f0e
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 15:59:45.7748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kWzls0pEUG79HlpujAQZOcIngpvLo87aUC/rGV6GBkaE0M3rw7AayWruHUax48t8QbUXZlW7yIsPnprbuLCINw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7694
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ibi work thread operates asynchronously with other transfers, such as
svc_i3c_master_priv_xfers(). Introduce mutex protection to ensure the
completion of the entire i3c/i2c transaction.

Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")
Cc: stable@vger.kernel.org
Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v2
    - update commit message
    - Add Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

 drivers/i3c/master/svc-i3c-master.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index d29de5fe533e6..8cd708c965085 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -174,6 +174,7 @@ struct svc_i3c_regs_save {
  * @ibi.slots: Available IBI slots
  * @ibi.tbq_slot: To be queued IBI slot
  * @ibi.lock: IBI lock
+ * @lock: Transfer lock, protect between IBI work thread and callbacks from master
  */
 struct svc_i3c_master {
 	struct i3c_master_controller base;
@@ -202,6 +203,7 @@ struct svc_i3c_master {
 		/* Prevent races within IBI handlers */
 		spinlock_t lock;
 	} ibi;
+	struct mutex lock;
 };
 
 /**
@@ -383,6 +385,7 @@ static void svc_i3c_master_ibi_work(struct work_struct *work)
 	u32 status, val;
 	int ret;
 
+	mutex_lock(&master->lock);
 	/* Acknowledge the incoming interrupt with the AUTOIBI mechanism */
 	writel(SVC_I3C_MCTRL_REQUEST_AUTO_IBI |
 	       SVC_I3C_MCTRL_IBIRESP_AUTO,
@@ -459,6 +462,7 @@ static void svc_i3c_master_ibi_work(struct work_struct *work)
 
 reenable_ibis:
 	svc_i3c_master_enable_interrupts(master, SVC_I3C_MINT_SLVSTART);
+	mutex_unlock(&master->lock);
 }
 
 static irqreturn_t svc_i3c_master_irq_handler(int irq, void *dev_id)
@@ -1203,9 +1207,11 @@ static int svc_i3c_master_send_bdcast_ccc_cmd(struct svc_i3c_master *master,
 	cmd->read_len = 0;
 	cmd->continued = false;
 
+	mutex_lock(&master->lock);
 	svc_i3c_master_enqueue_xfer(master, xfer);
 	if (!wait_for_completion_timeout(&xfer->comp, msecs_to_jiffies(1000)))
 		svc_i3c_master_dequeue_xfer(master, xfer);
+	mutex_unlock(&master->lock);
 
 	ret = xfer->ret;
 	kfree(buf);
@@ -1249,9 +1255,11 @@ static int svc_i3c_master_send_direct_ccc_cmd(struct svc_i3c_master *master,
 	cmd->read_len = read_len;
 	cmd->continued = false;
 
+	mutex_lock(&master->lock);
 	svc_i3c_master_enqueue_xfer(master, xfer);
 	if (!wait_for_completion_timeout(&xfer->comp, msecs_to_jiffies(1000)))
 		svc_i3c_master_dequeue_xfer(master, xfer);
+	mutex_unlock(&master->lock);
 
 	if (cmd->read_len != xfer_len)
 		ccc->dests[0].payload.len = cmd->read_len;
@@ -1308,9 +1316,11 @@ static int svc_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
 		cmd->continued = (i + 1) < nxfers;
 	}
 
+	mutex_lock(&master->lock);
 	svc_i3c_master_enqueue_xfer(master, xfer);
 	if (!wait_for_completion_timeout(&xfer->comp, msecs_to_jiffies(1000)))
 		svc_i3c_master_dequeue_xfer(master, xfer);
+	mutex_unlock(&master->lock);
 
 	ret = xfer->ret;
 	svc_i3c_master_free_xfer(xfer);
@@ -1346,9 +1356,11 @@ static int svc_i3c_master_i2c_xfers(struct i2c_dev_desc *dev,
 		cmd->continued = (i + 1 < nxfers);
 	}
 
+	mutex_lock(&master->lock);
 	svc_i3c_master_enqueue_xfer(master, xfer);
 	if (!wait_for_completion_timeout(&xfer->comp, msecs_to_jiffies(1000)))
 		svc_i3c_master_dequeue_xfer(master, xfer);
+	mutex_unlock(&master->lock);
 
 	ret = xfer->ret;
 	svc_i3c_master_free_xfer(xfer);
@@ -1539,6 +1551,8 @@ static int svc_i3c_master_probe(struct platform_device *pdev)
 
 	INIT_WORK(&master->hj_work, svc_i3c_master_hj_work);
 	INIT_WORK(&master->ibi_work, svc_i3c_master_ibi_work);
+	mutex_init(&master->lock);
+
 	ret = devm_request_irq(dev, master->irq, svc_i3c_master_irq_handler,
 			       IRQF_NO_SUSPEND, "svc-i3c-irq", master);
 	if (ret)
-- 
2.34.1

