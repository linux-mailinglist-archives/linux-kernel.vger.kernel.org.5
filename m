Return-Path: <linux-kernel+bounces-12349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E3881F3A5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 02:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A69F71F21D76
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 01:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5F517E1;
	Thu, 28 Dec 2023 01:38:12 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62A510E5
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 01:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4T0rdg1m7jz1FGL4;
	Thu, 28 Dec 2023 09:34:15 +0800 (CST)
Received: from kwepemm000013.china.huawei.com (unknown [7.193.23.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 2A137140120;
	Thu, 28 Dec 2023 09:38:07 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemm000013.china.huawei.com
 (7.193.23.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Dec
 2023 09:38:06 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <david.oberhollenzer@sigma-star.at>, <richard@nod.at>,
	<miquel.raynal@bootlin.com>, <s.hauer@pengutronix.de>,
	<Tudor.Ambarus@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: [PATCH RFC 01/17] ubifs: repair: Load filesystem info from volume
Date: Thu, 28 Dec 2023 09:40:56 +0800
Message-ID: <20231228014112.2836317-2-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231228014112.2836317-1-chengzhihao1@huawei.com>
References: <20231228014112.2836317-1-chengzhihao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm000013.china.huawei.com (7.193.23.81)

This is the 1/13 step of repairing. Open UBI volume and read UBIFS super
block, which is similar to UBIFS mounting process. If read superblock
failed, repair is failure.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/ubifs/Makefile |   2 +-
 fs/ubifs/repair.c | 109 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/ubifs/super.c  |  10 ++---
 fs/ubifs/ubifs.h  |   5 +++
 4 files changed, 120 insertions(+), 6 deletions(-)
 create mode 100644 fs/ubifs/repair.c

diff --git a/fs/ubifs/Makefile b/fs/ubifs/Makefile
index 314c80b24a76..88a11f85e150 100644
--- a/fs/ubifs/Makefile
+++ b/fs/ubifs/Makefile
@@ -5,7 +5,7 @@ ubifs-y += shrinker.o journal.o file.o dir.o super.o sb.o io.o
 ubifs-y += tnc.o master.o scan.o replay.o log.o commit.o gc.o orphan.o
 ubifs-y += budget.o find.o tnc_commit.o compress.o lpt.o lprops.o
 ubifs-y += recovery.o ioctl.o lpt_commit.o tnc_misc.o debug.o
-ubifs-y += misc.o sysfs.o
+ubifs-y += misc.o sysfs.o repair.o
 ubifs-$(CONFIG_FS_ENCRYPTION) += crypto.o
 ubifs-$(CONFIG_UBIFS_FS_XATTR) += xattr.o
 ubifs-$(CONFIG_UBIFS_FS_AUTHENTICATION) += auth.o
diff --git a/fs/ubifs/repair.c b/fs/ubifs/repair.c
new file mode 100644
index 000000000000..b722187de74f
--- /dev/null
+++ b/fs/ubifs/repair.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * This file is part of UBIFS.
+ *
+ * Copyright (C) 2023-2024, Huawei Technologies Co, Ltd.
+ *
+ * Authors: Zhihao Cheng <chengzhihao1@huawei.com>
+ */
+
+/*
+ * This file implements ubifs repair.
+ */
+
+#include <linux/module.h>
+#include "ubifs.h"
+
+int ubifs_repair(const char *dev_name)
+{
+	int err = 0;
+	struct ubifs_info *c;
+	struct ubi_volume_desc *ubi;
+	struct super_block *fake_sb;
+
+	ubi = open_ubi(dev_name, UBI_READWRITE);
+	if (IS_ERR(ubi)) {
+		err = PTR_ERR(ubi);
+		pr_err("cannot open dev %s, err %d\n", dev_name, err);
+		return err;
+	}
+
+	fake_sb = kzalloc(sizeof(struct super_block), GFP_KERNEL);
+	if (!fake_sb) {
+		err = -ENOMEM;
+		goto close_volume;
+	}
+
+	c = alloc_ubifs_info(ubi);
+	if (!c) {
+		err = -ENOMEM;
+		goto free_sb;
+	}
+
+	c->ubi = ubi;
+	c->vfs_sb = fake_sb;
+	c->max_inode_sz = key_max_inode_size(c);
+	if (c->max_inode_sz > MAX_LFS_FILESIZE)
+		c->max_inode_sz = MAX_LFS_FILESIZE;
+
+	err = init_constants_early(c);
+	if (err)
+		goto free_ubifs;
+
+	err = ubifs_debugging_init(c);
+	if (err)
+		goto free_ubifs;
+
+	if (c->ro_media) {
+		err = -EROFS;
+		goto free_debug;
+	}
+
+	err = check_volume_empty(c);
+	if (err)
+		goto free_debug;
+
+	if (c->empty) {
+		ubifs_err(c, "empty filesystem");
+		err = -ENODEV;
+		goto free_debug;
+	}
+
+	c->sbuf = vmalloc(c->leb_size);
+	if (!c->sbuf) {
+		err = -ENOMEM;
+		goto free_debug;
+	}
+
+	/* Step 1: Load filesystem info from volume. */
+	ubifs_msg(c, "Step 1: Load filesystem");
+	err = ubifs_read_superblock(c);
+	if (err)
+		goto free_sup;
+
+	/* TODO: Support repairing authenticated image. */
+	if (le32_to_cpu(c->sup_node->flags) & UBIFS_FLG_AUTHENTICATION) {
+		ubifs_err(c, "not support authentication");
+		err = -EOPNOTSUPP;
+		goto free_sup;
+	}
+
+	err = init_constants_sb(c);
+	if (err)
+		goto free_sup;
+
+	ubifs_msg(c, "Repair success!");
+
+free_sup:
+	kfree(c->sup_node);
+	vfree(c->sbuf);
+free_debug:
+	ubifs_debugging_exit(c);
+free_ubifs:
+	kfree(c);
+free_sb:
+	kfree(fake_sb);
+close_volume:
+	ubi_close_volume(ubi);
+	return err;
+}
diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index eabb0f44ea3e..ad726523d491 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -506,7 +506,7 @@ static int ubifs_sync_fs(struct super_block *sb, int wait)
  * requirements. Returns zero in case of success and a negative error code in
  * case of failure.
  */
-static int init_constants_early(struct ubifs_info *c)
+int init_constants_early(struct ubifs_info *c)
 {
 	if (c->vi.corrupted) {
 		ubifs_warn(c, "UBI volume is corrupted - read-only mode");
@@ -670,7 +670,7 @@ static int bud_wbuf_callback(struct ubifs_info *c, int lnum, int free, int pad)
  * makes sure they are all right. Returns zero in case of success and a
  * negative error code in case of failure.
  */
-static int init_constants_sb(struct ubifs_info *c)
+int init_constants_sb(struct ubifs_info *c)
 {
 	int tmp, err;
 	long long tmp64;
@@ -934,7 +934,7 @@ static void free_buds(struct ubifs_info *c)
  * Returns zero in case of success and a negative error code in case of
  * failure.
  */
-static int check_volume_empty(struct ubifs_info *c)
+int check_volume_empty(struct ubifs_info *c)
 {
 	int lnum, err;
 
@@ -2086,7 +2086,7 @@ const struct super_operations ubifs_super_operations = {
  * returns UBI volume description object in case of success and a negative
  * error code in case of failure.
  */
-static struct ubi_volume_desc *open_ubi(const char *name, int mode)
+struct ubi_volume_desc *open_ubi(const char *name, int mode)
 {
 	struct ubi_volume_desc *ubi;
 	int dev, vol;
@@ -2132,7 +2132,7 @@ static struct ubi_volume_desc *open_ubi(const char *name, int mode)
 	return ERR_PTR(-EINVAL);
 }
 
-static struct ubifs_info *alloc_ubifs_info(struct ubi_volume_desc *ubi)
+struct ubifs_info *alloc_ubifs_info(struct ubi_volume_desc *ubi)
 {
 	struct ubifs_info *c;
 
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index 3916dc4f30ca..a7ee8010ad66 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -2072,6 +2072,11 @@ static inline int ubifs_init_security(struct inode *dentry,
 
 /* super.c */
 struct inode *ubifs_iget(struct super_block *sb, unsigned long inum);
+int init_constants_early(struct ubifs_info *c);
+int init_constants_sb(struct ubifs_info *c);
+int check_volume_empty(struct ubifs_info *c);
+struct ubi_volume_desc *open_ubi(const char *name, int mode);
+struct ubifs_info *alloc_ubifs_info(struct ubi_volume_desc *ubi);
 
 /* recovery.c */
 int ubifs_recover_master_node(struct ubifs_info *c);
-- 
2.31.1


