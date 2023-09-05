Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A15D792690
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240494AbjIEQJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343933AbjIEC5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 22:57:30 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA37CCB;
        Mon,  4 Sep 2023 19:57:25 -0700 (PDT)
Received: from dggpemm500012.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Rfqp021wczNnB3;
        Tue,  5 Sep 2023 10:53:44 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 dggpemm500012.china.huawei.com (7.185.36.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 5 Sep 2023 10:57:23 +0800
From:   Xingui Yang <yangxingui@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <john.g.garry@oracle.com>, <damien.lemoal@opensource.wdc.com>
CC:     <andriy.shevchenko@linux.intel.com>, <akpm@linux-foundation.org>,
        <viro@zeniv.linux.org.uk>, <himanshu.madhani@cavium.com>,
        <felipe.balbi@linux.intel.com>, <gregkh@linuxfoundation.org>,
        <uma.shankar@intel.com>, <anshuman.gupta@intel.com>,
        <animesh.manna@intel.com>, <linux-usb@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yangxingui@huawei.com>,
        <prime.zeng@hisilicon.com>, <kangfenglong@huawei.com>,
        <chenxiang66@hisilicon.com>
Subject: [PATCH v6 3/3] scsi: qla2xxx: Use DEFINE_SHOW_STORE_ATTRIBUTE() helper for debugfs
Date:   Tue, 5 Sep 2023 02:48:35 +0000
Message-ID: <20230905024835.43219-4-yangxingui@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230905024835.43219-1-yangxingui@huawei.com>
References: <20230905024835.43219-1-yangxingui@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500012.china.huawei.com (7.185.36.89)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_STORE_ATTRIBUTE() helper for read-write file to reduce some
duplicated code.

Signed-off-by: Luo Jiaxing <luojiaxing@huawei.com>
Co-developed-by: Xingui Yang <yangxingui@huawei.com>
Signed-off-by: Xingui Yang <yangxingui@huawei.com>
---
 drivers/scsi/qla2xxx/qla_dfs.c | 59 ++++------------------------------
 1 file changed, 7 insertions(+), 52 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_dfs.c b/drivers/scsi/qla2xxx/qla_dfs.c
index f060e593685d..debb14d71e8a 100644
--- a/drivers/scsi/qla2xxx/qla_dfs.c
+++ b/drivers/scsi/qla2xxx/qla_dfs.c
@@ -528,51 +528,22 @@ qla_dfs_naqp_show(struct seq_file *s, void *unused)
  *
  * Example for creating "TEST" sysfs file:
  * 1. struct qla_hw_data { ... struct dentry *dfs_TEST; }
- * 2. QLA_DFS_SETUP_RD(TEST, scsi_qla_host_t);
+ * 2. QLA_DFS_SETUP_RD(TEST);
  * 3. In qla2x00_dfs_setup():
  * QLA_DFS_CREATE_FILE(ha, TEST, 0600, ha->dfs_dir, vha);
  * 4. In qla2x00_dfs_remove():
  * QLA_DFS_REMOVE_FILE(ha, TEST);
  */
-#define QLA_DFS_SETUP_RD(_name, _ctx_struct)				\
-static int								\
-qla_dfs_##_name##_open(struct inode *inode, struct file *file)		\
-{									\
-	_ctx_struct *__ctx = inode->i_private;				\
-									\
-	return single_open(file, qla_dfs_##_name##_show, __ctx);	\
-}									\
-									\
-static const struct file_operations qla_dfs_##_name##_ops = {		\
-	.open           = qla_dfs_##_name##_open,			\
-	.read           = seq_read,					\
-	.llseek         = seq_lseek,					\
-	.release        = single_release,				\
-};
+#define QLA_DFS_SETUP_RD(_name)	DEFINE_SHOW_ATTRIBUTE(qla_dfs_##_name)
 
-#define QLA_DFS_SETUP_RW(_name, _ctx_struct)				\
-static int								\
-qla_dfs_##_name##_open(struct inode *inode, struct file *file)		\
-{									\
-	_ctx_struct *__ctx = inode->i_private;				\
-									\
-	return single_open(file, qla_dfs_##_name##_show, __ctx);	\
-}									\
-									\
-static const struct file_operations qla_dfs_##_name##_ops = {		\
-	.open           = qla_dfs_##_name##_open,			\
-	.read           = seq_read,					\
-	.llseek         = seq_lseek,					\
-	.release        = single_release,				\
-	.write		= qla_dfs_##_name##_write,			\
-};
+#define QLA_DFS_SETUP_RW(_name)	DEFINE_SHOW_STORE_ATTRIBUTE(qla_dfs_##_name)
 
 #define QLA_DFS_ROOT_CREATE_FILE(_name, _perm, _ctx)			\
 	do {								\
 		if (!qla_dfs_##_name)					\
 			qla_dfs_##_name = debugfs_create_file(#_name,	\
 					_perm, qla2x00_dfs_root, _ctx,	\
-					&qla_dfs_##_name##_ops);	\
+					&qla_dfs_##_name##_fops);	\
 	} while (0)
 
 #define QLA_DFS_ROOT_REMOVE_FILE(_name)					\
@@ -587,7 +558,7 @@ static const struct file_operations qla_dfs_##_name##_ops = {		\
 	do {								\
 		(_struct)->dfs_##_name = debugfs_create_file(#_name,	\
 					_perm, _parent, _ctx,		\
-					&qla_dfs_##_name##_ops)		\
+					&qla_dfs_##_name##_fops)	\
 	} while (0)
 
 #define QLA_DFS_REMOVE_FILE(_struct, _name)				\
@@ -598,14 +569,6 @@ static const struct file_operations qla_dfs_##_name##_ops = {		\
 		}							\
 	} while (0)
 
-static int
-qla_dfs_naqp_open(struct inode *inode, struct file *file)
-{
-	struct scsi_qla_host *vha = inode->i_private;
-
-	return single_open(file, qla_dfs_naqp_show, vha);
-}
-
 static ssize_t
 qla_dfs_naqp_write(struct file *file, const char __user *buffer,
     size_t count, loff_t *pos)
@@ -653,15 +616,7 @@ qla_dfs_naqp_write(struct file *file, const char __user *buffer,
 	kfree(buf);
 	return rc;
 }
-
-static const struct file_operations dfs_naqp_ops = {
-	.open		= qla_dfs_naqp_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-	.write		= qla_dfs_naqp_write,
-};
-
+QLA_DFS_SETUP_RW(naqp);
 
 int
 qla2x00_dfs_setup(scsi_qla_host_t *vha)
@@ -707,7 +662,7 @@ qla2x00_dfs_setup(scsi_qla_host_t *vha)
 
 	if (IS_QLA27XX(ha) || IS_QLA83XX(ha) || IS_QLA28XX(ha)) {
 		ha->tgt.dfs_naqp = debugfs_create_file("naqp",
-		    0400, ha->dfs_dir, vha, &dfs_naqp_ops);
+		    0400, ha->dfs_dir, vha, &qla_dfs_naqp_fops);
 		if (!ha->tgt.dfs_naqp) {
 			ql_log(ql_log_warn, vha, 0xd011,
 			       "Unable to create debugFS naqp node.\n");
-- 
2.17.1

