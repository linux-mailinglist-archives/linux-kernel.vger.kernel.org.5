Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E7877CC81
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 14:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237050AbjHOMX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 08:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235913AbjHOMXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 08:23:16 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD7D173C;
        Tue, 15 Aug 2023 05:23:15 -0700 (PDT)
Received: from kwepemm600012.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RQ9MN5YYtzFqdP;
        Tue, 15 Aug 2023 20:20:16 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 15 Aug 2023 20:23:12 +0800
From:   Wenchao Hao <haowenchao2@huawei.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Douglas Gilbert <dgilbert@interlog.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <louhongxiang@huawei.com>, Wenchao Hao <haowenchao2@huawei.com>
Subject: [PATCH v4 3/9] scsi:scsi_debug: Define grammar to remove added error injection
Date:   Tue, 15 Aug 2023 20:23:10 +0800
Message-ID: <20230815122316.4129333-4-haowenchao2@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230815122316.4129333-1-haowenchao2@huawei.com>
References: <20230815122316.4129333-1-haowenchao2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600012.china.huawei.com (7.193.23.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The grammar to remove error injection is a line with fixed 3 columns
separated by spaces.

First column is fixed to "-". It tells this is a removal operation.
Second column is the error code to match.
Third column is the scsi command to match.

For example the following command would remove timeout injection of
inquiry command.
    echo "- 0 0x12" > /sys/kernel/debug/scsi_debug/0:0:0:1/error

Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
Acked-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/scsi_debug.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index d7d0c8af8bff..c83bd1e52622 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -920,6 +920,33 @@ static void sdebug_err_add(struct scsi_device *sdev, struct sdebug_err_inject *n
 	list_add_tail(&new->list, &devip->inject_err_list);
 }
 
+static int sdebug_err_remove(struct scsi_device *sdev, const char *buf, size_t count)
+{
+	struct sdebug_dev_info *devip = (struct sdebug_dev_info *)sdev->hostdata;
+	struct sdebug_err_inject *tmp, *err;
+	int type;
+	unsigned char cmd;
+
+	if (sscanf(buf, "- %d %hhx", &type, &cmd) != 2) {
+		kfree(buf);
+		return -EINVAL;
+	}
+
+	list_for_each_entry_safe(err, tmp, &devip->inject_err_list, list) {
+		if (err->type == type && err->cmd == cmd) {
+			sdev_printk(KERN_INFO, sdev, "Remove %d 0x%x\n",
+				err->type, err->cmd);
+			list_del(&err->list);
+			kfree(err);
+			kfree(buf);
+			return count;
+		}
+	}
+
+	kfree(buf);
+	return -EINVAL;
+}
+
 static int sdebug_error_show(struct seq_file *m, void *p)
 {
 	struct scsi_device *sdev = (struct scsi_device *)m->private;
@@ -975,6 +1002,9 @@ static ssize_t sdebug_error_write(struct file *file, const char __user *ubuf,
 		return -EFAULT;
 	}
 
+	if (buf[0] == '-')
+		return sdebug_err_remove(sdev, buf, count);
+
 	if (sscanf(buf, "%d", &inject_type) != 1) {
 		kfree(buf);
 		return -EINVAL;
-- 
2.35.3

