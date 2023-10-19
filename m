Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE507D04BF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 00:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346641AbjJSW1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 18:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbjJSW1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 18:27:48 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2080.outbound.protection.outlook.com [40.107.22.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3D3FA
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 15:27:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjbmLZ4O7YAtvnmhYT/FWwec1B98qrgyNkleF+v0ilcJvx7H6qITTuxtmwuF23qwApSZV9IMFPpVYE/RQJNQNzkeORVIqEfB6lF5IGAHi9EUNDf25xOtgnTEhkerXF1QIujYJBfUsoPd7GNs6hFmu1ZzvNjQYWl8RJ0VyZvF0pmzlHu/Uiz0M8OGdABy/VdjXv7LmD0Lr2F/G3mWD005NEc2mN6NhPTO5vFDtsCmAlcCI+tzhcN3kwtRa3Iec2JMgQw3iRsEUJaIGgYfqQ9nnvgux6p5VPnOyhFiSdkjmx3nE2S7cn3krBcn6orFGov46zk8IX5iA5A8SvxAuYiK2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6/0l63ENa1rCG9AOCfTVMMHkxQaSAkgSO/Y9e4768s=;
 b=APcOd4aL3ucrDzk10wuO3ccAOpl0HFmrTgoUaQGzsph7Fc26X9o7CXmz6MYh2vaYXp/yLhq1xjzgY8JJmslaTssSALIc8XTaGqMx3I9/WOLZf4y/MPF4pq1OFHKoSYmefRxA/hSKq0WFVa3cFQc8UbsN9lB4rfGuyb7pir6/KyP8oN7LIvIvtZ61q7eGTbzgBfHs4DTdyPw0z5H0oOVdWBtojLctsC2d8xTtYQwyuRZK03azlONFAPRDH1urLWMi+RZmtepWAIlMtB+7V6TCPsFLQZbSEzLFs7StiXJdUVwBsWgkTnIubBK/ZAyfm/+tgxbYND7mWvyqATyd/8DoWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6/0l63ENa1rCG9AOCfTVMMHkxQaSAkgSO/Y9e4768s=;
 b=bn24Mqv5WxV0x6P3+PZDEvu/SyRpBQ1BozyntBWpwvjs2vFVFQzd2cULETiyjmNfgEQO2C19FylJNqxtnkZd49d0nOQ0DJXoMTReKdGzyxB0tKbMMQXzVJAl09RKFLtBcTkPPZ/myxbGlc8tayfOJA1Avo+mGe4sXAHPxoqZC+o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DBBPR04MB7708.eurprd04.prod.outlook.com (2603:10a6:10:20d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.10; Thu, 19 Oct
 2023 22:27:44 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 22:27:44 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     Frank.Li@nxp.com, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/6] i3c: master: svc: fix race condition in ibi work thread
Date:   Thu, 19 Oct 2023 18:27:20 -0400
Message-Id: <20231019222725.3598022-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019222725.3598022-1-Frank.Li@nxp.com>
References: <20231019222725.3598022-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR17CA0042.namprd17.prod.outlook.com
 (2603:10b6:510:323::21) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DBBPR04MB7708:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e42faf6-f3a8-4881-0108-08dbd0f29d53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J0mW8jbWK7e0Xw225stXJn7vAJGg3bOBJXfxm0RgJcA9/p8yNSaVSwHlnHHHK/D/S1zRkDlO2oz+a+V+eV4hYhki28CxLcNjw0BI0n3NfLdUAzoHIKkqh15cLrcA2kJN6F0/hRr50cQjzkeBiraDPxK07QlOA/Ii5fxRe11nuFkKO2uSHaeD46i5SesQQSzuBxzR8j3jnYTfN5LA10DWShmqC80YNVP3CVn2e9FEirLzKG770bgxRcb5ksANI/lT62Fkqbfn/3wNxdAX0U6jCxRv46GXdNAFHYkFdnWk1OPiiRCQTs14PzAJuQ1cXs+/Gx17ZMvVqJ3EItUrxMVk9JnYDUpo5P0VgbCTdNulFAuE7lion0nzr1RHB8MNJd4saCKEQ1v/c2MbbbPGVSEOydFSKnU7oiHfy1G6LQjQrqOrtF5Dq6YRSeDi8njRFuP271+1Hh75BBC2VjXnabdWWDi8SIKUMApJfmFDqIIR3K6cd7IMCwsjrO+4484ItDFweCANUkHJj4VJfs6J+MPPyeLKqgbxrWvCCcRLjCBubfi+IOZscSxSHcVqkat9H0LoRRAUDED+fWw+Y6pLzfUYgQkQtiG48S4glFuV5z8i6pJkt+jMBgvPIIqZKHejBeqgMmcvoGc2FXib1HZD8x2rqrZiIedWvtFUnQRbxwk+SGo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(346002)(39860400002)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(6506007)(83380400001)(6512007)(38100700002)(478600001)(36756003)(66476007)(66556008)(66946007)(316002)(6916009)(86362001)(6486002)(52116002)(2616005)(1076003)(26005)(6666004)(5660300002)(2906002)(41300700001)(8676002)(8936002)(4326008)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pu9mvWOXUgdVCGcWk0gOOKgSmKtdLUjQMW+xfHXzIJgYd70B7Z0sGumaLv8A?=
 =?us-ascii?Q?aouWsVFwwmEUA4JZbgOeRJCcadOrPN5hwxv23FnpjYhJjHa9rQpbh2BBDc2x?=
 =?us-ascii?Q?V7UY6eUta1ZieYpRyhexd8zCKMyCE+etOcDiorIPdGiaVqt10kvVUCI0AZrP?=
 =?us-ascii?Q?v01qV8Hla1i/tQYz0AAckuRtk8A7FpYffTtHTlL0c/2oGhL8/6ibXZ82naBR?=
 =?us-ascii?Q?Ukpv8KAS2W41SjDz5OKA3X3pE617A7KPHcg9eBYMr3X1fLWXYGQRWTrF411s?=
 =?us-ascii?Q?l18hf2hp5EXYsZ4IMC5eKQP5tntxFS6o21Ng0R1C2jdqP1xuxD10I5EyA8+x?=
 =?us-ascii?Q?LFZMh1cWsIhnHiOaSjT7yrcg/I4q0hYS7JcITTgj0znPd+pIKBqYRtuduSZW?=
 =?us-ascii?Q?14Rx7/GYKC8oC43gWTQkuFc2gz/sw7sJntl82Rk2hZMiUNPMKi6UnaKEri1i?=
 =?us-ascii?Q?DHnIvxjmN3h93PuKYaIl9PCdZaTGkwBbnL5bjDNvCGnGdEK5/Xd3dM7vpUjX?=
 =?us-ascii?Q?KFHr22tKHgvN7cjpyKEGgpYQqY9oc2EHWKgvyg3hyoOqElJLXZiJDxrH2f5O?=
 =?us-ascii?Q?+bVm/gpN+ekTKFKG9VUFimGVv2En3AGOcpQO8CtHC821xN+wliX9LN6logVm?=
 =?us-ascii?Q?SNv1TwOOcVtyz84In5Ya7Cl2bwuKTkKDl6lwRejIIAORwO0L55fXVUK1rvqN?=
 =?us-ascii?Q?5DzvwDTAYCFN0NwGbc4w6qw0/dGS7gzsYWeGIfTAEHOys+fGrj5DaYv7/1f5?=
 =?us-ascii?Q?Yx44XuT+rayd8QRYXEpT5n3889ruU9SRGIrrvyCB2cO81yh59NR7kBOA4aGo?=
 =?us-ascii?Q?3oy1Hm/2fXeWjB4rUaFUcokV0MbUlRYx3amBYIgT2cAL/Ga24ODmCPMxGmae?=
 =?us-ascii?Q?vXE28GZc74jnKqAjAN9553922nOUGVUGNZYaFE1bys9MgbjOBklHzUtmIWms?=
 =?us-ascii?Q?q5DQb0fYn83o0oydKg+4nrlVb0Ra2/g2wfQKJDbcraEOWDn9W2yD2P1nn/B1?=
 =?us-ascii?Q?13OBC6DqlNHkOftybF3NC3jkr3l1SCLk03gqpib6Nl09l4tQC37fQIjNrGUN?=
 =?us-ascii?Q?yxaFknzVSO9eLPJ4sNv2iHjOLWXkAq3Ze2Ks50js1zMWDxV9RjwFSI0H1RIF?=
 =?us-ascii?Q?vZgDb5GeeJS3U3IkQUkpmM4EBhgMO/gFH/9MK3mjhSGadsFrFrN9eTzUGYmX?=
 =?us-ascii?Q?U4qqeEVnh/ha36aYzAMZIfNwv3G2egX5hgPC/wxZRSzYiS8ZTVQL733lZFeq?=
 =?us-ascii?Q?1Q+yODFzfmMhdW8CVvhqfY9t7AG17OFvfPavjid6oss/4EWSg1sm9XjseMaA?=
 =?us-ascii?Q?li225Aef98dJlDXjFpnWWHw5kE2xQBldsDkCP/LObXaPni606HQWaDqysT/Y?=
 =?us-ascii?Q?o1ru7yNmqjgazwRmfsmUaMQCEl8wnLEsT9fwReToLoodDeHEHOtqZCGDL3JS?=
 =?us-ascii?Q?LxOXSwH0zmM9kGStCU/hTuR57z/c/C/vHjPu8ZNRFHMT6/9NODrBGBG4u21U?=
 =?us-ascii?Q?uyjFcdpXqJoVbRViuhBAZV4KuwVynGixRJGFJ0GoiLQDcLnDFxZUtKRS/xwg?=
 =?us-ascii?Q?k9blfWG8heDO7V2uxGE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e42faf6-f3a8-4881-0108-08dbd0f29d53
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 22:27:44.4908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zvE2pkCCJER1Gd8hajOv23G3+cV1h0Lc6WNBXCZFNyoStWnuZLfo5ZeA94J/j/cub1YgY7el7BlQziKBGyIBhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7708
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
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

