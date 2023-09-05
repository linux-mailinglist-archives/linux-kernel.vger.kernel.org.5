Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28EC1792A56
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351924AbjIEQfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343910AbjIEC53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 22:57:29 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A7FCC7;
        Mon,  4 Sep 2023 19:57:25 -0700 (PDT)
Received: from dggpemm500012.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RfqpP119MzMl5y;
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
Subject: [PATCH v6 1/3] seq_file: Add helper macro to define attribute for rw file
Date:   Tue, 5 Sep 2023 02:48:33 +0000
Message-ID: <20230905024835.43219-2-yangxingui@huawei.com>
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

We already own DEFINE_SHOW_ATTRIBUTE() helper macro for defining attribute
for read-only file, but many of drivers want a helper macro for read-write
file too.

So we add DEFINE_SHOW_STORE_ATTRIBUTE() helper to reduce duplicated code.

Signed-off-by: Luo Jiaxing <luojiaxing@huawei.com>
Co-developed-by: Xingui Yang <yangxingui@huawei.com>
Signed-off-by: Xingui Yang <yangxingui@huawei.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/seq_file.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
index bd023dd38ae6..e400007e410c 100644
--- a/include/linux/seq_file.h
+++ b/include/linux/seq_file.h
@@ -207,6 +207,21 @@ static const struct file_operations __name ## _fops = {			\
 	.release	= single_release,				\
 }
 
+#define DEFINE_SHOW_STORE_ATTRIBUTE(__name)				\
+static int __name ## _open(struct inode *inode, struct file *file)	\
+{									\
+	return single_open(file, __name ## _show, inode->i_private);	\
+}									\
+									\
+static const struct file_operations __name ## _fops = {			\
+	.owner		= THIS_MODULE,					\
+	.open		= __name ## _open,				\
+	.read		= seq_read,					\
+	.write		= __name ## _write,				\
+	.llseek		= seq_lseek,					\
+	.release	= single_release,				\
+}
+
 #define DEFINE_PROC_SHOW_ATTRIBUTE(__name)				\
 static int __name ## _open(struct inode *inode, struct file *file)	\
 {									\
-- 
2.17.1

