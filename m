Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1C578FB23
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 11:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348975AbjIAJm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 05:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348905AbjIAJmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 05:42:12 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E531717;
        Fri,  1 Sep 2023 02:41:59 -0700 (PDT)
Received: from kwepemm600012.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RcY0v3ZpBzrSFC;
        Fri,  1 Sep 2023 17:40:15 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 1 Sep 2023 17:41:56 +0800
From:   Wenchao Hao <haowenchao2@huawei.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
CC:     Hannes Reinecke <hare@suse.de>, <linux-kernel@vger.kernel.org>,
        <louhongxiang@huawei.com>, <lixiaokeng@huawei.com>,
        Wenchao Hao <haowenchao2@huawei.com>
Subject: [RFC PATCH v2 09/19] scsi: core: increase/decrease target_busy without check can_queue
Date:   Fri, 1 Sep 2023 17:41:17 +0800
Message-ID: <20230901094127.2010873-10-haowenchao2@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230901094127.2010873-1-haowenchao2@huawei.com>
References: <20230901094127.2010873-1-haowenchao2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600012.china.huawei.com (7.193.23.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is preparation for a genernal target based error handle strategy
to check if to wake up actual error handler.

Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
---
 drivers/scsi/scsi_lib.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index db0a42fe49c0..4a7fb48aa60f 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -293,8 +293,7 @@ void scsi_device_unbusy(struct scsi_device *sdev, struct scsi_cmnd *cmd)
 
 	scsi_dec_host_busy(shost, cmd);
 
-	if (starget->can_queue > 0)
-		atomic_dec(&starget->target_busy);
+	atomic_dec(&starget->target_busy);
 
 	sbitmap_put(&sdev->budget_map, cmd->budget_token);
 	cmd->budget_token = -1;
@@ -1311,10 +1310,10 @@ static inline int scsi_target_queue_ready(struct Scsi_Host *shost,
 		spin_unlock_irq(shost->host_lock);
 	}
 
+	busy = atomic_inc_return(&starget->target_busy) - 1;
 	if (starget->can_queue <= 0)
 		return 1;
 
-	busy = atomic_inc_return(&starget->target_busy) - 1;
 	if (atomic_read(&starget->target_blocked) > 0) {
 		if (busy)
 			goto starved;
@@ -1339,8 +1338,7 @@ static inline int scsi_target_queue_ready(struct Scsi_Host *shost,
 	list_move_tail(&sdev->starved_entry, &shost->starved_list);
 	spin_unlock_irq(shost->host_lock);
 out_dec:
-	if (starget->can_queue > 0)
-		atomic_dec(&starget->target_busy);
+	atomic_dec(&starget->target_busy);
 	return 0;
 }
 
@@ -1784,8 +1782,7 @@ static blk_status_t scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
 out_dec_host_busy:
 	scsi_dec_host_busy(shost, cmd);
 out_dec_target_busy:
-	if (scsi_target(sdev)->can_queue > 0)
-		atomic_dec(&scsi_target(sdev)->target_busy);
+	atomic_dec(&scsi_target(sdev)->target_busy);
 out_put_budget:
 	scsi_mq_put_budget(q, cmd->budget_token);
 	cmd->budget_token = -1;
-- 
2.35.3

