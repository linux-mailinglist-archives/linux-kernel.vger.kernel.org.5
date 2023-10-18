Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F467CE1A5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 17:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbjJRPst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 11:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbjJRPsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 11:48:38 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2045.outbound.protection.outlook.com [40.107.6.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BC311D
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 08:48:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+CenkIwzsnVHsjaS5Cg5ZoLxIUhWxzP9hutF4Y1Eg9GQ637qwbXqTS8zG98yGxgRc6r/z+Nr6QdblKlvrYp1RfkH6Lz6KvDxsiWP1Wa+fUCFEjyuqdczGDEh4hUwhWhR4qQfSN2TZSJn9j1HCVMvQuTF3Ro1kdmk1/iCjuUeccfunxW+eYbhRauNLV67I1Mqs3faaIfPKOtAOMgJsJANmIGpKKaCI3L+fZvsuwiaa3ZGnLQ9xPfXvzXGrDg41DenbJK1rifZdzYR1XrKpGndksm39bhaOdSJAC1fPc3xt3Ob3oFbhdN+KQ7ij40knTK0X592NPyBX/WZR4Il8CUYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6/0l63ENa1rCG9AOCfTVMMHkxQaSAkgSO/Y9e4768s=;
 b=L1Ys++cWQrl2s7nx7FWhIU1sAS/eDdwVeXH/YGxw+0DF81pza6wG+UjBVAfoIAZ63fOp3KUli/tUCh+95LP7dLmAnP7Rz28syW9AzFAst2IW4a237qSF0HL8EZbMQSdVWPGQZ71dOwtDDsAtDK8516DI/zF2sUil0uG45R38EneVswK+CduzBPzz39cmjv9casemZ8ko3N7NY61LOTgQGShbKQFQ5TIW7C4394fvW9kfakzdlneezdmlmGUHK8mtxkW6aYGkR1ww9JcS5YddQErwrf6LUiGNzgBoxKPzgmya6JPmaYPVL3G2MSnnTo9zo8LvZzDXJLHyQL5n/55iLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6/0l63ENa1rCG9AOCfTVMMHkxQaSAkgSO/Y9e4768s=;
 b=evmvXvmAb3RQKhxuEtXQoHA/3NenBbnxL/G/b2BUmf1HL1aHEBW3pCO36YjnPV2qB95BVhW7eSG6wHbLsT9pndy1gOSRFxe3Pf1Lac4CtV6rR6B3sSIy9mxOM36qz0L3FO5lLKV4HwXQPjAe80C8rs8WQqd9g7inwVFpEaQQ3T8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by GVXPR04MB9777.eurprd04.prod.outlook.com (2603:10a6:150:115::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 15:48:33 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6907.022; Wed, 18 Oct 2023
 15:48:32 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     Frank.Li@nxp.com, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] i3c: master: svc: fix race condition in ibi work thread
Date:   Wed, 18 Oct 2023 11:48:05 -0400
Message-Id: <20231018154809.3304558-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018154809.3304558-1-Frank.Li@nxp.com>
References: <20231018154809.3304558-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0087.namprd03.prod.outlook.com
 (2603:10b6:a03:331::32) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|GVXPR04MB9777:EE_
X-MS-Office365-Filtering-Correlation-Id: b20d1882-96d6-4a09-aedd-08dbcff1ae94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0+Q/Ukd5g2IUZXKr+z0tk3w+NIkANMEusDnMctqE0xndhJutSceawI+ojGYUZZhaASkXS+LLhAJANNObkWWyHgRjm6SeeFQxvT25Y9DqGkURkb4hZviv4TW0o0kQetfXRt/2AOVI5ndcrpUeN54dVSLIaVGgCKD7n8yrTeCLvz5XB8nkRMPiprK6M7oK7lOyxCJlF0erfKSZ4vW/JMa+DmZ0oPci9NCXQ0WVj3cAfoaFxfIGQgtBFnm1Bsp1zMV0m9YYZD/gHZxW6Rg5y/q4uwCt5RNkGJyI91/2dZy/pStdKugCRZ/GwTuxTNbmo/ijivFiLk98DWqlVcw0jbXVCuxESqlVKbIY/TMYb0RsNreN/gwibvdhiPD+eCRfN8rv2ZVD4W6WIHjIFpgbmdgD+qz9gRiJtiSDsmKGX2iRvMoi5hMyfTItPmL7fgphHngpXWWrr/jvBfVTsEoE+hgwu7gudaBLjx13V/XkvAYdtskdWTroojzhfc9O6H1hvNf6rscG1uD8rqNSbIPH4hu2Gu5J4P2uT/S0I2PBmxbZ8WAGnRtfoImApA8fl8P1LfSkm0Sf25F5nSqWYa4df08nNVxjVVYOgekMzPY/RX9QALXBSid0Nidm+Bie8cJGXse4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(38350700005)(52116002)(6666004)(6486002)(6506007)(6512007)(478600001)(66556008)(6916009)(66476007)(316002)(66946007)(36756003)(2616005)(1076003)(83380400001)(26005)(41300700001)(38100700002)(5660300002)(8936002)(4326008)(8676002)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zA3JdFDuGC9RgBRVuUr6L/dtDg/B3Za5hxIjdqLGe82mQeTKv2kFQrN4/mbD?=
 =?us-ascii?Q?PybWwnFnrqDHpXkl3U89srg3LrDOnOz7IKROwXiu5LVwtXgCpwipNkANqQi9?=
 =?us-ascii?Q?/HjmeO4Fk0t3d+vrE2RyT8lIlj4A0pXk/y3l2f8TeMx3gUAMTTt8QJqdvaRw?=
 =?us-ascii?Q?wmMlDZLLC6WG0SaPzLU1OA7uheyTyMu7aLW1mzfp93ND/w37QWVbDzHfZx1A?=
 =?us-ascii?Q?n3G1ENvCZOLEFzSiz77PrWPUDDmCybDevdIrBokwQ3yVHCu+REPamivE0S7r?=
 =?us-ascii?Q?M6ltSAMO28ZgLgFan03RC4VxxzAcWtVSehwDmHxGSszi/33l2T0ZJhn8mg5v?=
 =?us-ascii?Q?BpcirVAhZS+/YPwGyT/DCmxfjmZwutXAPRcybgp/BJAmoYPmWdshA2eBMAfw?=
 =?us-ascii?Q?mYbnAIoPZaAMuBfoUZ3Noed72lGgTy8RlQYDBhrHEff3eFgoRP9j2gIls7uG?=
 =?us-ascii?Q?Ry9CIcfF2vc+pXUAbx5DaEzfJd+BTYHVG+lvfvqMpRG5TAsKrKzzay0ZIloX?=
 =?us-ascii?Q?x2cwYip+0FNQ/U7AHZmZISA+AElhFCtbgCoEdCJ5tWUH/74+NPahNru9pPnP?=
 =?us-ascii?Q?iByBfzprDzxiwX8+MWmbEoqqGm0eQZ8Y6iZvp0JlWbRUBZKxKB2HbO3nUa42?=
 =?us-ascii?Q?dqpXAOPxDWrODeBFEnqpWYt24E9QCSAN+WLoSp6Sl4RbGAK2c4Nq5/cJ6d79?=
 =?us-ascii?Q?22xLPL4tDRrkqDsPkQse84K/fiVYH3u7V5aZ8k8xpXwQv/2DtvAqHIqwj0yq?=
 =?us-ascii?Q?yudQ+ub/7OGCd3x19R9PCs2+QzGfbCPXPPB3Det6R51EEZYTmUo2E9LZAklq?=
 =?us-ascii?Q?96MHHl4KJ5Wj6pWXMg0/RO/0IIdv9GqtK+JTeuh4JAe1FTiD0eHyfRISFe/D?=
 =?us-ascii?Q?4z7A9ct57Sfph4DO8IpJe8j9wrAbqvQ3XjIyg3SBV5K6QOT00FYwFUPqipc4?=
 =?us-ascii?Q?jCNGLDhfC7SUs3pakXgL6NRwluDsIcIYBVFyLrIk9te7/HO1cptwiTBvJ6o/?=
 =?us-ascii?Q?4rPjdU6yaPFuul2oxBp2SB8y1wyF+YYaXeJPWNaVm0riTC8NLukQS+a4+cYC?=
 =?us-ascii?Q?xNqtiCRShzoOfBWadgBstkh5fUkArKAf9Tls6wYyBVv3h9jEouMYtCmkAkmQ?=
 =?us-ascii?Q?Y7XnXpa2HPxTrUCVvgnFUuJ/6v9jNYA8X+9i00pcwKmo0r5WV3TAuV1CKPfU?=
 =?us-ascii?Q?7gd7+yfC/PwZo0G45TSPF0HBr2kRTR1eXLlypz0QrZXsnolQKCXv60/lcTww?=
 =?us-ascii?Q?iGDTT3u42LYYzTe1oUWsuva8c+5DVAOaB+admQSrG3GsvdUVV+DiurmTv3Bd?=
 =?us-ascii?Q?yApIQkDPADSsrLKhLRQmJ26qxczRheWTHkssqqRmTLXJfuxfmqP0AHKTDKq2?=
 =?us-ascii?Q?uxhsavZkImGGMpM8gGrRwBubffmX1GcrjAG3jroEN3iJsjeR+gaFPNJIxQou?=
 =?us-ascii?Q?xSZt5Oze3TMEijGT/s/xPCJl+tynMyCnef2LKfM+BEHrpMNMc4/slvKNJzHI?=
 =?us-ascii?Q?9jaAprTZyYt1CE6M6PJfnIc6u9TvRalmkYKY8rOLcpIWJTS56PK1C3nbMBS2?=
 =?us-ascii?Q?qzcUjqhbgB6xcND3Htzznoo4zMule/o2EHv/VLTz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b20d1882-96d6-4a09-aedd-08dbcff1ae94
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 15:48:32.7747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7P7Ie+rzo4AT7Mnud9DtPd5jdNqi1JgJ2vJt96ou2ir8p2HbkB21oDIZsxEY9cvmhPCb24PUwwtt2HkaddMQaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9777
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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

