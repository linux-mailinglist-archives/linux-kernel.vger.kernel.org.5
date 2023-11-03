Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626487E00E8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 11:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbjKCGvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 02:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbjKCGvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 02:51:23 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDF11AD
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 23:51:17 -0700 (PDT)
Received: from dggpemd200001.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SMBGk65ZKzVkCQ;
        Fri,  3 Nov 2023 14:51:10 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpemd200001.china.huawei.com
 (7.185.36.224) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1258.23; Fri, 3 Nov
 2023 14:51:15 +0800
From:   ZhaoLong Wang <wangzhaolong1@huawei.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <wangzhaolong1@huawei.com>,
        <yi.zhang@huawei.com>, <yangerkun@huawei.com>
Subject: [PATCH v4 2/5] ubi: Split io_failures into write_failure and erase_failure
Date:   Fri, 3 Nov 2023 14:55:33 +0800
Message-ID: <20231103065536.3778940-3-wangzhaolong1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231103065536.3778940-1-wangzhaolong1@huawei.com>
References: <20231103065536.3778940-1-wangzhaolong1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemd200001.china.huawei.com (7.185.36.224)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The emulate_io_failures debugfs entry controls both write
failure and erase failure. This patch split io_failures
to write_failure and erase_failure.

Signed-off-by: ZhaoLong Wang <wangzhaolong1@huawei.com>
Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 drivers/mtd/ubi/debug.c | 13 +++++++++----
 drivers/mtd/ubi/debug.h | 14 ++++++++------
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/mtd/ubi/debug.c b/drivers/mtd/ubi/debug.c
index 81682bd72eb9..3ce5265e3a16 100644
--- a/drivers/mtd/ubi/debug.c
+++ b/drivers/mtd/ubi/debug.c
@@ -14,7 +14,8 @@
 
 #ifdef CONFIG_MTD_UBI_FAULT_INJECTION
 static DECLARE_FAULT_ATTR(fault_bitflips_attr);
-static DECLARE_FAULT_ATTR(fault_io_failures_attr);
+static DECLARE_FAULT_ATTR(fault_write_failure_attr);
+static DECLARE_FAULT_ATTR(fault_erase_failure_attr);
 static DECLARE_FAULT_ATTR(fault_power_cut_attr);
 
 #define FAIL_ACTION(name, fault_attr)			\
@@ -24,7 +25,8 @@ bool should_fail_##name(void)				\
 }
 
 FAIL_ACTION(bitflips,		fault_bitflips_attr)
-FAIL_ACTION(io_failures,	fault_io_failures_attr)
+FAIL_ACTION(write_failure,	fault_write_failure_attr)
+FAIL_ACTION(erase_failure,	fault_erase_failure_attr)
 FAIL_ACTION(power_cut,		fault_power_cut_attr)
 #endif
 
@@ -245,8 +247,11 @@ static void dfs_create_fault_entry(struct dentry *parent)
 	fault_create_debugfs_attr("emulate_bitflips", dir,
 				  &fault_bitflips_attr);
 
-	fault_create_debugfs_attr("emulate_io_failures", dir,
-				  &fault_io_failures_attr);
+	fault_create_debugfs_attr("emulate_write_failure", dir,
+				  &fault_write_failure_attr);
+
+	fault_create_debugfs_attr("emulate_erase_failure", dir,
+				  &fault_erase_failure_attr);
 
 	fault_create_debugfs_attr("emulate_power_cut", dir,
 				  &fault_power_cut_attr);
diff --git a/drivers/mtd/ubi/debug.h b/drivers/mtd/ubi/debug.h
index fa7e12fa43f9..7386c40474de 100644
--- a/drivers/mtd/ubi/debug.h
+++ b/drivers/mtd/ubi/debug.h
@@ -92,10 +92,12 @@ static inline int ubi_dbg_erase_failure(const struct ubi_device *ubi)
 /* Emulate bit-flips */
 #define MASK_BITFLIPS				(1 << 2)
 /* Emulates -EIO during write/erase */
-#define MASK_IO_FAILURE				(1 << 3)
+#define MASK_WRITE_FAILURE			(1 << 3)
+#define MASK_ERASE_FAILURE			(1 << 4)
 
 extern bool should_fail_bitflips(void);
-extern bool should_fail_io_failures(void);
+extern bool should_fail_write_failure(void);
+extern bool should_fail_erase_failure(void);
 extern bool should_fail_power_cut(void);
 
 static inline bool ubi_dbg_fail_bitflip(const struct ubi_device *ubi)
@@ -107,15 +109,15 @@ static inline bool ubi_dbg_fail_bitflip(const struct ubi_device *ubi)
 
 static inline bool ubi_dbg_fail_write(const struct ubi_device *ubi)
 {
-	if (ubi->dbg.emulate_failures & MASK_IO_FAILURE)
-		return should_fail_io_failures();
+	if (ubi->dbg.emulate_failures & MASK_WRITE_FAILURE)
+		return should_fail_write_failure();
 	return false;
 }
 
 static inline bool ubi_dbg_fail_erase(const struct ubi_device *ubi)
 {
-	if (ubi->dbg.emulate_failures & MASK_IO_FAILURE)
-		return should_fail_io_failures();
+	if (ubi->dbg.emulate_failures & MASK_ERASE_FAILURE)
+		return should_fail_erase_failure();
 	return false;
 }
 
-- 
2.31.1

