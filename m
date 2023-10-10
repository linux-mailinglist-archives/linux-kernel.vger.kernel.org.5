Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98E87BF724
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 11:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjJJJVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 05:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjJJJVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 05:21:22 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AFEA7;
        Tue, 10 Oct 2023 02:21:21 -0700 (PDT)
Received: from kwepemm000012.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4S4Vdm0h4NztTJX;
        Tue, 10 Oct 2023 17:16:44 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm000012.china.huawei.com (7.193.23.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 10 Oct 2023 17:21:19 +0800
From:   Wenchao Hao <haowenchao2@huawei.com>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Douglas Gilbert <dgilbert@interlog.com>
CC:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <louhongxiang@huawei.com>, Wenchao Hao <haowenchao2@huawei.com>
Subject: [PATCH v6 03/10] scsi: scsi_debug: Define grammar to remove added error injection
Date:   Tue, 10 Oct 2023 17:20:44 +0800
Message-ID: <20231010092051.608007-4-haowenchao2@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20231010092051.608007-1-haowenchao2@huawei.com>
References: <20231010092051.608007-1-haowenchao2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000012.china.huawei.com (7.193.23.142)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

Acked-by: Douglas Gilbert <dgilbert@interlog.com>
Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
---
 drivers/scsi/scsi_debug.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 46f1ee647b15..0d5a179dbd97 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -930,6 +930,34 @@ static void sdebug_err_add(struct scsi_device *sdev, struct sdebug_err_inject *n
 	spin_unlock(&devip->list_lock);
 }
 
+static int sdebug_err_remove(struct scsi_device *sdev, const char *buf, size_t count)
+{
+	struct sdebug_dev_info *devip = (struct sdebug_dev_info *)sdev->hostdata;
+	struct sdebug_err_inject *err;
+	int type;
+	unsigned char cmd;
+
+	if (sscanf(buf, "- %d %hhx", &type, &cmd) != 2) {
+		kfree(buf);
+		return -EINVAL;
+	}
+
+	spin_lock(&devip->list_lock);
+	list_for_each_entry_rcu(err, &devip->inject_err_list, list) {
+		if (err->type == type && err->cmd == cmd) {
+			list_del_rcu(&err->list);
+			call_rcu(&err->rcu, sdebug_err_free);
+			spin_unlock(&devip->list_lock);
+			kfree(buf);
+			return count;
+		}
+	}
+	spin_unlock(&devip->list_lock);
+
+	kfree(buf);
+	return -EINVAL;
+}
+
 static int sdebug_error_show(struct seq_file *m, void *p)
 {
 	struct scsi_device *sdev = (struct scsi_device *)m->private;
@@ -987,6 +1015,9 @@ static ssize_t sdebug_error_write(struct file *file, const char __user *ubuf,
 		return -EFAULT;
 	}
 
+	if (buf[0] == '-')
+		return sdebug_err_remove(sdev, buf, count);
+
 	if (sscanf(buf, "%d", &inject_type) != 1) {
 		kfree(buf);
 		return -EINVAL;
-- 
2.32.0

