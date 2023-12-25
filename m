Return-Path: <linux-kernel+bounces-11094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA4681E136
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 16:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB8FF1C21491
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 15:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C05D52F80;
	Mon, 25 Dec 2023 15:03:17 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1409151C43
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 15:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SzLjy4BVtz1Q6wB;
	Mon, 25 Dec 2023 23:02:46 +0800 (CST)
Received: from dggpemd200001.china.huawei.com (unknown [7.185.36.224])
	by mail.maildlp.com (Postfix) with ESMTPS id 39189140336;
	Mon, 25 Dec 2023 23:03:10 +0800 (CST)
Received: from huawei.com (10.175.104.67) by dggpemd200001.china.huawei.com
 (7.185.36.224) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1258.28; Mon, 25 Dec
 2023 23:03:09 +0800
From: ZhaoLong Wang <wangzhaolong1@huawei.com>
To: <richard@nod.at>, <miquel.raynal@bootlin.com>, <vigneshr@ti.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<chengzhihao1@huawei.com>, <wangzhaolong1@huawei.com>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>
Subject: [PATCH V6 2/5] ubi: Split io_failures into write_failure and erase_failure
Date: Mon, 25 Dec 2023 23:00:46 +0800
Message-ID: <20231225150049.183756-3-wangzhaolong1@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231225150049.183756-1-wangzhaolong1@huawei.com>
References: <20231225150049.183756-1-wangzhaolong1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemd200001.china.huawei.com (7.185.36.224)

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
index fd101ad6f12f..186306228b4d 100644
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
index f2f499feff49..8cdd25eee013 100644
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
2.39.2


