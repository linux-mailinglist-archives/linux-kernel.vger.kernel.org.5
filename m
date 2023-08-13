Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C084B77A80C
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 17:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbjHMPxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 11:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbjHMPw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 11:52:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EE72130;
        Sun, 13 Aug 2023 08:52:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48CE66326A;
        Sun, 13 Aug 2023 15:50:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CD5FC433C8;
        Sun, 13 Aug 2023 15:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691941847;
        bh=Tc+gBRMbhAr54iMetz7p7qAboMQ8YIlsI3iIh/HPx1Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fcgi3tmfBqDHzxp+avraoZVhgxR2T9McrASlYO+jiAL2HdEss+tuyJYhzoyV3Pp25
         0yEfyskSuki8y9L2wayxrJTd8Scu2/AqqzPH0yQIcOtdTL1BV61uxn4DiFuoqGdnBd
         r+qco1ezG1rjSUtpPTD+WR0DyHzVtorEZsRXo1mibJVsBh0h0X4f0nr8Tl2S4feA69
         DBdkK2DdR3BctkEFdpcABvH2NxG7xG2AplQ56D5W7rdeCTyj4SDxV8Pte9WfrLjedb
         htZQNbIHKUouYWN7I5OGeWRivBE0/YSax3aHsj20PH5lzD0KN/NeD9c5PnJq2c5kBE
         p2FJisLRMd1cw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 25/54] s390/dasd: fix hanging device after request requeue
Date:   Sun, 13 Aug 2023 11:49:04 -0400
Message-Id: <20230813154934.1067569-25-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813154934.1067569-1-sashal@kernel.org>
References: <20230813154934.1067569-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.10
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Haberland <sth@linux.ibm.com>

[ Upstream commit 8a2278ce9c25048d999fe1a3561def75d963f471 ]

The DASD device driver has a function to requeue requests to the
blocklayer.
This function is used in various cases when basic settings for the device
have to be changed like High Performance Ficon related parameters or copy
pair settings.

The functions iterates over the device->ccw_queue and also removes the
requests from the block->ccw_queue.
In case the device is started on an alias device instead of the base
device it might be removed from the block->ccw_queue without having it
canceled properly before. This might lead to a hanging device since the
request is no longer on a queue and can not be handled properly.

Fix by iterating over the block->ccw_queue instead of the
device->ccw_queue. This will take care of all blocklayer related requests
and handle them on all associated DASD devices.

Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
Link: https://lore.kernel.org/r/20230721193647.3889634-4-sth@linux.ibm.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/block/dasd.c | 125 +++++++++++++++-----------------------
 1 file changed, 48 insertions(+), 77 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 9fbfce735d565..50c48a48fcae3 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -2938,41 +2938,32 @@ static void _dasd_wake_block_flush_cb(struct dasd_ccw_req *cqr, void *data)
  * Requeue a request back to the block request queue
  * only works for block requests
  */
-static int _dasd_requeue_request(struct dasd_ccw_req *cqr)
+static void _dasd_requeue_request(struct dasd_ccw_req *cqr)
 {
-	struct dasd_block *block = cqr->block;
 	struct request *req;
 
-	if (!block)
-		return -EINVAL;
 	/*
 	 * If the request is an ERP request there is nothing to requeue.
 	 * This will be done with the remaining original request.
 	 */
 	if (cqr->refers)
-		return 0;
+		return;
 	spin_lock_irq(&cqr->dq->lock);
 	req = (struct request *) cqr->callback_data;
 	blk_mq_requeue_request(req, true);
 	spin_unlock_irq(&cqr->dq->lock);
 
-	return 0;
+	return;
 }
 
-/*
- * Go through all request on the dasd_block request queue, cancel them
- * on the respective dasd_device, and return them to the generic
- * block layer.
- */
-static int dasd_flush_block_queue(struct dasd_block *block)
+static int _dasd_requests_to_flushqueue(struct dasd_block *block,
+					struct list_head *flush_queue)
 {
 	struct dasd_ccw_req *cqr, *n;
-	int rc, i;
-	struct list_head flush_queue;
 	unsigned long flags;
+	int rc, i;
 
-	INIT_LIST_HEAD(&flush_queue);
-	spin_lock_bh(&block->queue_lock);
+	spin_lock_irqsave(&block->queue_lock, flags);
 	rc = 0;
 restart:
 	list_for_each_entry_safe(cqr, n, &block->ccw_queue, blocklist) {
@@ -2987,13 +2978,32 @@ static int dasd_flush_block_queue(struct dasd_block *block)
 		 * is returned from the dasd_device layer.
 		 */
 		cqr->callback = _dasd_wake_block_flush_cb;
-		for (i = 0; cqr != NULL; cqr = cqr->refers, i++)
-			list_move_tail(&cqr->blocklist, &flush_queue);
+		for (i = 0; cqr; cqr = cqr->refers, i++)
+			list_move_tail(&cqr->blocklist, flush_queue);
 		if (i > 1)
 			/* moved more than one request - need to restart */
 			goto restart;
 	}
-	spin_unlock_bh(&block->queue_lock);
+	spin_unlock_irqrestore(&block->queue_lock, flags);
+
+	return rc;
+}
+
+/*
+ * Go through all request on the dasd_block request queue, cancel them
+ * on the respective dasd_device, and return them to the generic
+ * block layer.
+ */
+static int dasd_flush_block_queue(struct dasd_block *block)
+{
+	struct dasd_ccw_req *cqr, *n;
+	struct list_head flush_queue;
+	unsigned long flags;
+	int rc;
+
+	INIT_LIST_HEAD(&flush_queue);
+	rc = _dasd_requests_to_flushqueue(block, &flush_queue);
+
 	/* Now call the callback function of flushed requests */
 restart_cb:
 	list_for_each_entry_safe(cqr, n, &flush_queue, blocklist) {
@@ -3878,75 +3888,36 @@ EXPORT_SYMBOL_GPL(dasd_generic_space_avail);
  */
 int dasd_generic_requeue_all_requests(struct dasd_device *device)
 {
+	struct dasd_block *block = device->block;
 	struct list_head requeue_queue;
 	struct dasd_ccw_req *cqr, *n;
-	struct dasd_ccw_req *refers;
 	int rc;
 
-	INIT_LIST_HEAD(&requeue_queue);
-	spin_lock_irq(get_ccwdev_lock(device->cdev));
-	rc = 0;
-	list_for_each_entry_safe(cqr, n, &device->ccw_queue, devlist) {
-		/* Check status and move request to flush_queue */
-		if (cqr->status == DASD_CQR_IN_IO) {
-			rc = device->discipline->term_IO(cqr);
-			if (rc) {
-				/* unable to terminate requeust */
-				dev_err(&device->cdev->dev,
-					"Unable to terminate request %p "
-					"on suspend\n", cqr);
-				spin_unlock_irq(get_ccwdev_lock(device->cdev));
-				dasd_put_device(device);
-				return rc;
-			}
-		}
-		list_move_tail(&cqr->devlist, &requeue_queue);
-	}
-	spin_unlock_irq(get_ccwdev_lock(device->cdev));
-
-	list_for_each_entry_safe(cqr, n, &requeue_queue, devlist) {
-		wait_event(dasd_flush_wq,
-			   (cqr->status != DASD_CQR_CLEAR_PENDING));
+	if (!block)
+		return 0;
 
-		/*
-		 * requeue requests to blocklayer will only work
-		 * for block device requests
-		 */
-		if (_dasd_requeue_request(cqr))
-			continue;
+	INIT_LIST_HEAD(&requeue_queue);
+	rc = _dasd_requests_to_flushqueue(block, &requeue_queue);
 
-		/* remove requests from device and block queue */
-		list_del_init(&cqr->devlist);
-		while (cqr->refers != NULL) {
-			refers = cqr->refers;
-			/* remove the request from the block queue */
-			list_del(&cqr->blocklist);
-			/* free the finished erp request */
-			dasd_free_erp_request(cqr, cqr->memdev);
-			cqr = refers;
+	/* Now call the callback function of flushed requests */
+restart_cb:
+	list_for_each_entry_safe(cqr, n, &requeue_queue, blocklist) {
+		wait_event(dasd_flush_wq, (cqr->status < DASD_CQR_QUEUED));
+		/* Process finished ERP request. */
+		if (cqr->refers) {
+			spin_lock_bh(&block->queue_lock);
+			__dasd_process_erp(block->base, cqr);
+			spin_unlock_bh(&block->queue_lock);
+			/* restart list_for_xx loop since dasd_process_erp
+			 * might remove multiple elements
+			 */
+			goto restart_cb;
 		}
-
-		/*
-		 * _dasd_requeue_request already checked for a valid
-		 * blockdevice, no need to check again
-		 * all erp requests (cqr->refers) have a cqr->block
-		 * pointer copy from the original cqr
-		 */
+		_dasd_requeue_request(cqr);
 		list_del_init(&cqr->blocklist);
 		cqr->block->base->discipline->free_cp(
 			cqr, (struct request *) cqr->callback_data);
 	}
-
-	/*
-	 * if requests remain then they are internal request
-	 * and go back to the device queue
-	 */
-	if (!list_empty(&requeue_queue)) {
-		/* move freeze_queue to start of the ccw_queue */
-		spin_lock_irq(get_ccwdev_lock(device->cdev));
-		list_splice_tail(&requeue_queue, &device->ccw_queue);
-		spin_unlock_irq(get_ccwdev_lock(device->cdev));
-	}
 	dasd_schedule_device_bh(device);
 	return rc;
 }
-- 
2.40.1

