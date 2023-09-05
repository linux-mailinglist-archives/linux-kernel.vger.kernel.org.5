Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE43792BB1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbjIEQ5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343932AbjIEC53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 22:57:29 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFA5CC6;
        Mon,  4 Sep 2023 19:57:25 -0700 (PDT)
Received: from dggpemm500012.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RfqpP2nKDzMl5x;
        Tue,  5 Sep 2023 10:54:05 +0800 (CST)
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
Subject: [PATCH v6 2/3] scsi: hisi_sas: Use DEFINE_SHOW_STORE_ATTRIBUTE() helper for debugfs
Date:   Tue, 5 Sep 2023 02:48:34 +0000
Message-ID: <20230905024835.43219-3-yangxingui@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230905024835.43219-1-yangxingui@huawei.com>
References: <20230905024835.43219-1-yangxingui@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500012.china.huawei.com (7.185.36.89)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 137 ++-----------------------
 1 file changed, 9 insertions(+), 128 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index bbb64ee6afd7..5bb35c3ea4e5 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -3990,22 +3990,7 @@ static ssize_t debugfs_bist_linkrate_v3_hw_write(struct file *filp,
 
 	return count;
 }
-
-static int debugfs_bist_linkrate_v3_hw_open(struct inode *inode,
-					    struct file *filp)
-{
-	return single_open(filp, debugfs_bist_linkrate_v3_hw_show,
-			   inode->i_private);
-}
-
-static const struct file_operations debugfs_bist_linkrate_v3_hw_fops = {
-	.open = debugfs_bist_linkrate_v3_hw_open,
-	.read = seq_read,
-	.write = debugfs_bist_linkrate_v3_hw_write,
-	.llseek = seq_lseek,
-	.release = single_release,
-	.owner = THIS_MODULE,
-};
+DEFINE_SHOW_STORE_ATTRIBUTE(debugfs_bist_linkrate_v3_hw);
 
 static const struct {
 	int		value;
@@ -4080,22 +4065,7 @@ static ssize_t debugfs_bist_code_mode_v3_hw_write(struct file *filp,
 
 	return count;
 }
-
-static int debugfs_bist_code_mode_v3_hw_open(struct inode *inode,
-					     struct file *filp)
-{
-	return single_open(filp, debugfs_bist_code_mode_v3_hw_show,
-			   inode->i_private);
-}
-
-static const struct file_operations debugfs_bist_code_mode_v3_hw_fops = {
-	.open = debugfs_bist_code_mode_v3_hw_open,
-	.read = seq_read,
-	.write = debugfs_bist_code_mode_v3_hw_write,
-	.llseek = seq_lseek,
-	.release = single_release,
-	.owner = THIS_MODULE,
-};
+DEFINE_SHOW_STORE_ATTRIBUTE(debugfs_bist_code_mode_v3_hw);
 
 static ssize_t debugfs_bist_phy_v3_hw_write(struct file *filp,
 					    const char __user *buf,
@@ -4129,22 +4099,7 @@ static int debugfs_bist_phy_v3_hw_show(struct seq_file *s, void *p)
 
 	return 0;
 }
-
-static int debugfs_bist_phy_v3_hw_open(struct inode *inode,
-				       struct file *filp)
-{
-	return single_open(filp, debugfs_bist_phy_v3_hw_show,
-			   inode->i_private);
-}
-
-static const struct file_operations debugfs_bist_phy_v3_hw_fops = {
-	.open = debugfs_bist_phy_v3_hw_open,
-	.read = seq_read,
-	.write = debugfs_bist_phy_v3_hw_write,
-	.llseek = seq_lseek,
-	.release = single_release,
-	.owner = THIS_MODULE,
-};
+DEFINE_SHOW_STORE_ATTRIBUTE(debugfs_bist_phy_v3_hw);
 
 static ssize_t debugfs_bist_cnt_v3_hw_write(struct file *filp,
 					const char __user *buf,
@@ -4177,22 +4132,7 @@ static int debugfs_bist_cnt_v3_hw_show(struct seq_file *s, void *p)
 
 	return 0;
 }
-
-static int debugfs_bist_cnt_v3_hw_open(struct inode *inode,
-					  struct file *filp)
-{
-	return single_open(filp, debugfs_bist_cnt_v3_hw_show,
-			   inode->i_private);
-}
-
-static const struct file_operations debugfs_bist_cnt_v3_hw_ops = {
-	.open = debugfs_bist_cnt_v3_hw_open,
-	.read = seq_read,
-	.write = debugfs_bist_cnt_v3_hw_write,
-	.llseek = seq_lseek,
-	.release = single_release,
-	.owner = THIS_MODULE,
-};
+DEFINE_SHOW_STORE_ATTRIBUTE(debugfs_bist_cnt_v3_hw);
 
 static const struct {
 	int		value;
@@ -4256,22 +4196,7 @@ static ssize_t debugfs_bist_mode_v3_hw_write(struct file *filp,
 
 	return count;
 }
-
-static int debugfs_bist_mode_v3_hw_open(struct inode *inode,
-					struct file *filp)
-{
-	return single_open(filp, debugfs_bist_mode_v3_hw_show,
-			   inode->i_private);
-}
-
-static const struct file_operations debugfs_bist_mode_v3_hw_fops = {
-	.open = debugfs_bist_mode_v3_hw_open,
-	.read = seq_read,
-	.write = debugfs_bist_mode_v3_hw_write,
-	.llseek = seq_lseek,
-	.release = single_release,
-	.owner = THIS_MODULE,
-};
+DEFINE_SHOW_STORE_ATTRIBUTE(debugfs_bist_mode_v3_hw);
 
 static ssize_t debugfs_bist_enable_v3_hw_write(struct file *filp,
 					       const char __user *buf,
@@ -4309,22 +4234,7 @@ static int debugfs_bist_enable_v3_hw_show(struct seq_file *s, void *p)
 
 	return 0;
 }
-
-static int debugfs_bist_enable_v3_hw_open(struct inode *inode,
-					  struct file *filp)
-{
-	return single_open(filp, debugfs_bist_enable_v3_hw_show,
-			   inode->i_private);
-}
-
-static const struct file_operations debugfs_bist_enable_v3_hw_fops = {
-	.open = debugfs_bist_enable_v3_hw_open,
-	.read = seq_read,
-	.write = debugfs_bist_enable_v3_hw_write,
-	.llseek = seq_lseek,
-	.release = single_release,
-	.owner = THIS_MODULE,
-};
+DEFINE_SHOW_STORE_ATTRIBUTE(debugfs_bist_enable_v3_hw);
 
 static const struct {
 	char *name;
@@ -4362,21 +4272,7 @@ static int debugfs_v3_hw_show(struct seq_file *s, void *p)
 
 	return 0;
 }
-
-static int debugfs_v3_hw_open(struct inode *inode, struct file *filp)
-{
-	return single_open(filp, debugfs_v3_hw_show,
-			   inode->i_private);
-}
-
-static const struct file_operations debugfs_v3_hw_fops = {
-	.open = debugfs_v3_hw_open,
-	.read = seq_read,
-	.write = debugfs_v3_hw_write,
-	.llseek = seq_lseek,
-	.release = single_release,
-	.owner = THIS_MODULE,
-};
+DEFINE_SHOW_STORE_ATTRIBUTE(debugfs_v3_hw);
 
 static ssize_t debugfs_phy_down_cnt_v3_hw_write(struct file *filp,
 						const char __user *buf,
@@ -4407,22 +4303,7 @@ static int debugfs_phy_down_cnt_v3_hw_show(struct seq_file *s, void *p)
 
 	return 0;
 }
-
-static int debugfs_phy_down_cnt_v3_hw_open(struct inode *inode,
-					   struct file *filp)
-{
-	return single_open(filp, debugfs_phy_down_cnt_v3_hw_show,
-			   inode->i_private);
-}
-
-static const struct file_operations debugfs_phy_down_cnt_v3_hw_fops = {
-	.open = debugfs_phy_down_cnt_v3_hw_open,
-	.read = seq_read,
-	.write = debugfs_phy_down_cnt_v3_hw_write,
-	.llseek = seq_lseek,
-	.release = single_release,
-	.owner = THIS_MODULE,
-};
+DEFINE_SHOW_STORE_ATTRIBUTE(debugfs_phy_down_cnt_v3_hw);
 
 enum fifo_dump_mode_v3_hw {
 	FIFO_DUMP_FORVER =		(1U << 0),
@@ -4832,7 +4713,7 @@ static void debugfs_bist_init_v3_hw(struct hisi_hba *hisi_hba)
 			    hisi_hba, &debugfs_bist_phy_v3_hw_fops);
 
 	debugfs_create_file("cnt", 0600, hisi_hba->debugfs_bist_dentry,
-			    hisi_hba, &debugfs_bist_cnt_v3_hw_ops);
+			    hisi_hba, &debugfs_bist_cnt_v3_hw_fops);
 
 	debugfs_create_file("loopback_mode", 0600,
 			    hisi_hba->debugfs_bist_dentry,
-- 
2.17.1

