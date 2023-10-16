Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56AF7C9D52
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 04:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjJPCJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 22:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjJPCJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 22:09:05 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4F3AB;
        Sun, 15 Oct 2023 19:09:03 -0700 (PDT)
Received: from kwepemm000012.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4S80mn6DsfzMm19;
        Mon, 16 Oct 2023 10:04:57 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm000012.china.huawei.com (7.193.23.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 16 Oct 2023 10:09:00 +0800
From:   Wenchao Hao <haowenchao2@huawei.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <louhongxiang@huawei.com>,
        Wenchao Hao <haowenchao2@huawei.com>
Subject: [PATCH v2 1/2] scsi: core: cleanup scsi_dev_queue_ready()
Date:   Mon, 16 Oct 2023 10:08:46 +0800
Message-ID: <20231016020847.1270258-2-haowenchao2@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20231016020847.1270258-1-haowenchao2@huawei.com>
References: <20231016020847.1270258-1-haowenchao2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000012.china.huawei.com (7.193.23.142)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is just a cleanup for scsi_dev_queue_ready() to avoid
redundant goto and if statement, it did not change the origin
logic.

Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
---
 drivers/scsi/scsi_lib.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 40f407ffd26f..b179c24f9c76 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1250,28 +1250,29 @@ static inline int scsi_dev_queue_ready(struct request_queue *q,
 	int token;
 
 	token = sbitmap_get(&sdev->budget_map);
-	if (atomic_read(&sdev->device_blocked)) {
-		if (token < 0)
-			goto out;
+	if (token < 0)
+		return -1;
 
-		if (scsi_device_busy(sdev) > 1)
-			goto out_dec;
+	/*
+	 * device_blocked is not set at mostly time, so check it first
+	 * and return token when it is not set.
+	 */
+	if (!atomic_read(&sdev->device_blocked))
+		return token;
 
-		/*
-		 * unblock after device_blocked iterates to zero
-		 */
-		if (atomic_dec_return(&sdev->device_blocked) > 0)
-			goto out_dec;
-		SCSI_LOG_MLQUEUE(3, sdev_printk(KERN_INFO, sdev,
-				   "unblocking device at zero depth\n"));
+	/*
+	 * unblock after device_blocked iterates to zero
+	 */
+	if (scsi_device_busy(sdev) > 1 ||
+	    atomic_dec_return(&sdev->device_blocked) > 0) {
+		sbitmap_put(&sdev->budget_map, token);
+		return -1;
 	}
 
+	SCSI_LOG_MLQUEUE(3, sdev_printk(KERN_INFO, sdev,
+			 "unblocking device at zero depth\n"));
+
 	return token;
-out_dec:
-	if (token >= 0)
-		sbitmap_put(&sdev->budget_map, token);
-out:
-	return -1;
 }
 
 /*
-- 
2.32.0

