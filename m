Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB63E757720
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbjGRIy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbjGRIyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:54:16 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C9D135
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 01:54:14 -0700 (PDT)
Received: from dggpemm500009.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R4t5k5gBlz18LZc;
        Tue, 18 Jul 2023 16:53:30 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpemm500009.china.huawei.com
 (7.185.36.225) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 18 Jul
 2023 16:54:12 +0800
From:   ZhaoLong Wang <wangzhaolong1@huawei.com>
To:     <richard@nod.at>, <miquel.raynal@bootlin.com>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <wangzhaolong1@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH V2 2/5] ubi: Split io_failures into write_failure and erase_failure
Date:   Tue, 18 Jul 2023 16:51:16 +0800
Message-ID: <20230718085119.3885747-3-wangzhaolong1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230718085119.3885747-1-wangzhaolong1@huawei.com>
References: <20230718085119.3885747-1-wangzhaolong1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The emulate_io_failures debugfs entry controls both write
failure and erase failure. This patch split io_failures
to write_failure and erase_failure.

Signed-off-by: ZhaoLong Wang <wangzhaolong1@huawei.com>
---
 drivers/mtd/ubi/debug.c | 13 +++++++++----
 drivers/mtd/ubi/debug.h | 14 ++++++++------
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/mtd/ubi/debug.c b/drivers/mtd/ubi/debug.c
index 9ca584da32c6..7826bc8166e8 100644
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
index fc4234c9a90a..6bc698b38e35 100644
--- a/drivers/mtd/ubi/debug.h
+++ b/drivers/mtd/ubi/debug.h
@@ -92,10 +92,12 @@ static inline int ubi_dbg_erase_failure(const struct ubi_device *ubi)
 /* Emulate bit-flips */
 #define MASK_BITFLIPS		(1 << 3)
 /* Emulates -EIO during write/erase */
-#define MASK_IO_FAILURE		(1 << 4)
+#define MASK_WRITE_FAILURE	(1 << 4)
+#define MASK_ERASE_FAILURE	(1 << 5)
 
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

