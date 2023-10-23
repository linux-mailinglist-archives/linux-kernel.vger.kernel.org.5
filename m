Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756BC7D3C13
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233646AbjJWQRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjJWQRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:17:18 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2050.outbound.protection.outlook.com [40.107.249.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35765103
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 09:17:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VEPtuHNCJ4L+r/69sIF8dnzICbsFzEGkVE5YCcw2y8IvtbQpywxabDSWjw/pH2txUuUgdPTz8SZHT7DAp3YrELHL4BLrG4k1+UESB7jprizJ5uXEOHDG9G84JU0v0ExTR2cTTXMO8+SqWwhXAXhVdjCZD21GUeFEeQ0EutNv+ndd3a7p81fD3VzeNhjLJAiocJgk/5GPY0M8Fi+U5dPPbl8WwBe8s5U5WSQ0E+kSt3NkWRBziHUls7tKPFJ4+FOrc1DM81Y9B2+13oaSMU1sZURsmieU9a82tAH0copaMy28JfQkAzkVRbvdYGszMZEli7DZyxZT/fprf1LKJC1GWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6/0l63ENa1rCG9AOCfTVMMHkxQaSAkgSO/Y9e4768s=;
 b=mpnidE2G8Dj4rEXd63pZV1b3apmJvh9ZnNO+ZVQE98yEwP/Bu79ncIUOAyTbyy8pjLD/XhvwwC6LuoU841m/zRrarJtcRNu4BPj05akJSj4qw/fHanvxWT2TEjcmBaQc3O91ms+1htKWx2e/HGLi5o/3AH7aAjBgmoy1MWZc31SgwSaB/tos5RCoFDCcRLwoFi/mQJmliOuDRx8ZANiuFV88S5L3M7Hv/g2LhH/97S9GRwqCe3QYRw6jhv6Pv4gRbTDD4rZg+Oh5z00OUmFmYWCUsDIbh7fFGjGvUVnxgQiQdEVvRkiM9Wkz4NFItH/ACUJEN/5UHpPBf1aEXkRV9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6/0l63ENa1rCG9AOCfTVMMHkxQaSAkgSO/Y9e4768s=;
 b=eqkEEWN6Y6cZG4cfFM/fPzfThbRIIdKKPaHd3k9sGLUFNbdsEJUSKkIYKDQ26wFGNKl2aSIstmeADe5jtoNCCIa33aYqk7nvX0j4RXxtbvOTvSMob1r9HqVD7lxSuXty2LPU/1fV5Sx3guV4hzCAs5g66DL7rMqjDdsXec1hmWA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB8655.eurprd04.prod.outlook.com (2603:10a6:102:21e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.16; Mon, 23 Oct
 2023 16:17:14 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::97ca:a905:8e64:c098]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::97ca:a905:8e64:c098%6]) with mapi id 15.20.6933.011; Mon, 23 Oct 2023
 16:17:14 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     Frank.li@nxp.com, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/6] i3c: master: svc: fix race condition in ibi work thread
Date:   Mon, 23 Oct 2023 12:16:53 -0400
Message-Id: <20231023161658.3890811-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023161658.3890811-1-Frank.Li@nxp.com>
References: <20231023161658.3890811-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0002.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::15) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB8655:EE_
X-MS-Office365-Filtering-Correlation-Id: 8489aece-a84a-42fc-3c3d-08dbd3e384bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QGIVRFM0DhgJsZ7DOn0j/KOO4HpplLY5uZvEb8EXTbTOILKtN69HmexNHN+hxUygVPi42yUsGjTwiTsqw04XkW+h5lFqCDMt1wqn/dCCNAcRoeog4/MStnhUW7KAWfrMAShP+Lqb66IttY6Q9H0UH82/YZuRGOx19pItwM9NaEWBLRLeQJesL7q7LMC4pUPbDMWMZNTza1qIvEzQ/WncxZIpgWcPXqDfzThDHfY4qmufWbCyyf2E2KBbA4S334KbKjdsqOJDIdAbwPUV/yNIt1IjuDT4BLIwKBPvuQOqHey4Ihf5vcUzVu9FHsq3jB1qBkZb91inewNC2PLV+HC5rf3EzM+0h3LKczzRsxOyTtpDCaDb3vlOT78zfASGcmwslAyvG5BHHpSbsbqsInKFnKdDVLwoyLaWvVeyBNYw80qTjxbI+uKxOTrnkIX2Pl6N48782zxdLXlcctXEg6loYUmomdPV3c8EwcPGMsZYhj+yqax7Jl4y/l+By3wYeOuY1FkGfZLj9iuc/UW+5rYsDkdYiQuE8UEYQAwfA76B3B8JszBMmT8jR3T0XXh3l0/2O0pTugpDwdYMC3O9BLc3b9pmtCwt2sA9YTPs+AglFgOqsl//h1xxVJIxJ3+yyA3n
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(366004)(396003)(376002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(478600001)(6506007)(6512007)(6666004)(86362001)(316002)(41300700001)(6916009)(2906002)(6486002)(5660300002)(52116002)(36756003)(8676002)(2616005)(1076003)(26005)(38100700002)(8936002)(4326008)(66946007)(38350700005)(83380400001)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9xG898d1HPqildgpO2+8kvlb7/VOhVc51pME8yo8eVViiBsYLWg2KIvpmF6u?=
 =?us-ascii?Q?qE9xhocyi7LTVhNC7N1VTkkxpIY6qawS2iVORG4RzRpZ+amHrCbPt7/97pWq?=
 =?us-ascii?Q?W89CefpGJs3/nv3NMim0k6er91thvKDNY2byDkUPPG/zk/oCA2dq5Aj4bP/V?=
 =?us-ascii?Q?AjL21wvR8kkbf0cHrW9+YiEaa9Zx5fvSQpqNl7W5hNxrf6Aqi/ZHvlWm2hDQ?=
 =?us-ascii?Q?OuzUD0Af4X11PXfpmVtJ4vTW4wSZgXBA/jVLWqwTP9FaCiIZl3H7aLrpAaOe?=
 =?us-ascii?Q?Cem6cxdfw4K/OYwgTmljvZ6uRn11ipiIImp1my+XXBihiWXxDY+sQv8wxT+e?=
 =?us-ascii?Q?YqnW65NCGLRqkLdf2C0Nx1b3rm4GDyaWkUtBaJOIfL+Vu6rzPnU/rYlOyNGC?=
 =?us-ascii?Q?VefijjiWHbBxOAz59dTGFnzadGdcQa7Q2RmWO6C1hDridN/h3mZphZCyTeCE?=
 =?us-ascii?Q?YlL4/FYwmS1uRiggAZbZ8GwqX6iC0Cvoi7s3mTqQEtXr+m+edRlCFmVvyZpF?=
 =?us-ascii?Q?M6ZHVtiaMH6a2rgOlTmPplpSapUwlmK+avboal5yar86mEYWCWkICU9TlYGb?=
 =?us-ascii?Q?uttcy2uh7z53L2UmnY3M3xBMgTGCGefENMnU9xL+oGSp16sXp5TY1hlDvLwg?=
 =?us-ascii?Q?lWwJtVTFPN8bmbt21Gjj6q5iglaupYH/qrQs7aG0cOfmQvqJ5dB5H/bUZNxs?=
 =?us-ascii?Q?I2o96dCb//lyX+CLEGqjZiPK93khekQ/nX9GF6Jcu9Xfe/g52yEDpipu11Fm?=
 =?us-ascii?Q?BxJVbkXNGP+/W9W/LTH11TDwvO/1pEUCT4XOMlj3obfTs3+Ic6yksptqdMRD?=
 =?us-ascii?Q?GQ2OaLMLzqU6N+vqaeM4sAblWcTtFaTKPL381viGk00JP0QB0cmLO9iGlnZT?=
 =?us-ascii?Q?acRtQ+u37b2cTd74IhvGgtcHLDq2y1VrHwUvEkUn9oBNtlJX7p5RxqqMn+Wb?=
 =?us-ascii?Q?y4YmO71k95dBBUMogw5KbMXEt/v2JV5luiV4I1y9QPayfZWVtKZro3al8Nxh?=
 =?us-ascii?Q?Go6J4e6pdRL+w/9jCK8IjiJ74l7HQyvTHdQ9/7hyznkfsDw4nyoD34ZnUc7i?=
 =?us-ascii?Q?D6X7ZA20beFB51UttTpmpofkafS4JbiYeaV9j1bTqEfyo1Qc8GedmEbQBrby?=
 =?us-ascii?Q?zSF4LVb6JJOyC6VzQpPwnkawVRGOn4dTdU1VW1wWP9I1i2oEqL8EDMyNXVPn?=
 =?us-ascii?Q?E48oYVJ4GBkMXYNlscaUTVQRvVhzdWFTdqDLlLWabiYjvcfgOJSCT3HLureb?=
 =?us-ascii?Q?KrtVIywCAWySv9G2X6fnitG9dyvwQDi1jS2kncOmIZzxLCD5qpXyxY/jy/F8?=
 =?us-ascii?Q?BLkS7tkUupQ0gyyMEk7C9nZPImj4z+Xg422qY2Y0Xd+vPKcUQE6TYtTQN5Az?=
 =?us-ascii?Q?wHGBulUTKLmsRkSzpKbkLc+CV9cD5+xyh938cHKwTzWBHqKYS30cuRUgLztJ?=
 =?us-ascii?Q?FzjFYHNvwG43CVaL7JvtvaSdsiRa9iUfNekrwMTqo6mD873ithCdrGYUoMkq?=
 =?us-ascii?Q?tZL+6jLsznVTACeJEPcfPIpX0rIFKUKqF60L6ka9Ethh+02z0Le34WlYU9+N?=
 =?us-ascii?Q?ekr6YC/s25Mxkh8Ce6nVKIOJJ8e5XQOmZC6t0bdZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8489aece-a84a-42fc-3c3d-08dbd3e384bc
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 16:17:14.3524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9uflEK7zPHL/LXkr8Lfd/TBXARYo03GlXp4fmMfSYmqzDHcJqyyjNBM8uuBctIlw7bUzjNsglpJNEmZiEVuWTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8655
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

