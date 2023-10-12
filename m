Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393F27C69F6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 11:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235615AbjJLJqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 05:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234030AbjJLJqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 05:46:35 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED5BA9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 02:46:32 -0700 (PDT)
Received: from dggpeml500002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4S5l8C3V6PzrT8v;
        Thu, 12 Oct 2023 17:43:55 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500002.china.huawei.com (7.185.36.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 12 Oct 2023 17:46:30 +0800
From:   Junhao He <hejunhao3@huawei.com>
To:     <suzuki.poulose@arm.com>, <james.clark@arm.com>
CC:     <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <jonathan.cameron@huawei.com>, <yangyicong@huawei.com>,
        <prime.zeng@hisilicon.com>, <hejunhao3@huawei.com>
Subject: [PATCH 2/3] coresight: ultrasoc-smb: simplify the code for check to_copy valid
Date:   Thu, 12 Oct 2023 17:47:05 +0800
Message-ID: <20231012094706.21565-3-hejunhao3@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231012094706.21565-1-hejunhao3@huawei.com>
References: <20231012094706.21565-1-hejunhao3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500002.china.huawei.com (7.185.36.158)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We only need to check once when before using the to_copy variable
to simplify the code.

Signed-off-by: Junhao He <hejunhao3@huawei.com>
---
 drivers/hwtracing/coresight/ultrasoc-smb.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/hwtracing/coresight/ultrasoc-smb.c b/drivers/hwtracing/coresight/ultrasoc-smb.c
index b08a619d1116..e78edc3480ce 100644
--- a/drivers/hwtracing/coresight/ultrasoc-smb.c
+++ b/drivers/hwtracing/coresight/ultrasoc-smb.c
@@ -127,20 +127,15 @@ static ssize_t smb_read(struct file *file, char __user *data, size_t len,
 					struct smb_drv_data, miscdev);
 	struct smb_data_buffer *sdb = &drvdata->sdb;
 	struct device *dev = &drvdata->csdev->dev;
-	ssize_t to_copy = 0;
-
-	if (!len)
-		return 0;
-
-	if (!sdb->data_size)
-		return 0;
-
-	to_copy = min(sdb->data_size, len);
+	ssize_t to_copy = min(sdb->data_size, len);
 
 	/* Copy parts of trace data when read pointer wrap around SMB buffer */
 	if (sdb->buf_rdptr + to_copy > sdb->buf_size)
 		to_copy = sdb->buf_size - sdb->buf_rdptr;
 
+	if (!to_copy)
+		return 0;
+
 	if (copy_to_user(data, sdb->buf_base + sdb->buf_rdptr, to_copy)) {
 		dev_dbg(dev, "Failed to copy data to user\n");
 		return -EFAULT;
-- 
2.33.0

