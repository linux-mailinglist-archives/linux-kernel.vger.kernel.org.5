Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2EF87CDAAB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 13:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjJRLi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 07:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235236AbjJRLiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 07:38:15 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67BED76;
        Wed, 18 Oct 2023 04:38:03 -0700 (PDT)
Received: from kwepemm000012.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4S9TJs0nwjzRt83;
        Wed, 18 Oct 2023 19:34:21 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm000012.china.huawei.com (7.193.23.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 18 Oct 2023 19:38:00 +0800
From:   Wenchao Hao <haowenchao2@huawei.com>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>
CC:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <louhongxiang@huawei.com>, Wenchao Hao <haowenchao2@huawei.com>
Subject: [PATCH v3 1/2] scsi: core: cleanup scsi_dev_queue_ready()
Date:   Wed, 18 Oct 2023 19:37:45 +0800
Message-ID: <20231018113746.1940197-2-haowenchao2@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20231018113746.1940197-1-haowenchao2@huawei.com>
References: <20231018113746.1940197-1-haowenchao2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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
 drivers/scsi/scsi_lib.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index aca57c3ab626..cf3864f72093 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1251,28 +1251,26 @@ static inline int scsi_dev_queue_ready(struct request_queue *q,
 	int token;
 
 	token = sbitmap_get(&sdev->budget_map);
-	if (atomic_read(&sdev->device_blocked)) {
-		if (token < 0)
-			goto out;
+	if (token < 0)
+		return -1;
 
-		if (scsi_device_busy(sdev) > 1)
-			goto out_dec;
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
+	 * Only unblock if no other commands are pending and
+	 * if device_blocked has decreased to zero
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

