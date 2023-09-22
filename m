Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0FFE7AAE5C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 11:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbjIVJjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 05:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233253AbjIVJjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:39:14 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53C51A1;
        Fri, 22 Sep 2023 02:39:07 -0700 (PDT)
Received: from kwepemm000012.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RsRxP42zKz15NSB;
        Fri, 22 Sep 2023 17:36:57 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm000012.china.huawei.com (7.193.23.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 22 Sep 2023 17:39:05 +0800
From:   Wenchao Hao <haowenchao2@huawei.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <open-iscsi@googlegroups.com>, <linux-scsi@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <louhongxiang@huawei.com>,
        Wenchao Hao <haowenchao2@huawei.com>
Subject: [PATCH 1/2] scsi: core: cleanup scsi_dev_queue_ready()
Date:   Fri, 22 Sep 2023 17:38:41 +0800
Message-ID: <20230922093842.2646157-2-haowenchao2@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230922093842.2646157-1-haowenchao2@huawei.com>
References: <20230922093842.2646157-1-haowenchao2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm000012.china.huawei.com (7.193.23.142)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index ca5eb058d5c7..f3e388127dbd 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1254,28 +1254,29 @@ static inline int scsi_dev_queue_ready(struct request_queue *q,
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

