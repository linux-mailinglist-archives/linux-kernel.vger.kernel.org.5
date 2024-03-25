Return-Path: <linux-kernel+bounces-117067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EED288B027
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B88F5B2B74D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CAF5C8ED;
	Mon, 25 Mar 2024 12:56:13 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2098938DFB
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 12:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711371373; cv=none; b=jtYY09LvFrWDV9xYyUF/uVV/MzHOTR73zZBc6zGODaIwdmjLASZcjpAmH+zOMD20DmErUIu8kMcoPvircnjQIjPUqa1jHVqd2za6fjzrElCpOxSjDOf91idijGCA2uEYmsIc4eAmP6zLc8ebUuoHlVf3YwhfpmfxBuBHMIMstv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711371373; c=relaxed/simple;
	bh=5OAhuWAh6c1XxTM2gZOtkNUeQHR9OqCW/nJQI7SqgHU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rvn5oJrvqduAn6usA9lc4inTEYZGy8Tzm7rzGIuAWxwPRbS2HQmnvamjmHJo/ewlYUh6gOxmsjDvHgTTaPcZoFoL+37TwCUJB7cpqNl/ORA+bJ1SrEaTAw3U3w5ycFFGnSix/tgbeHX+ir7xgyDYy12eIpgmT6cavFA9PY11TKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4V3CXp6Dmgz1h3lV;
	Mon, 25 Mar 2024 20:53:30 +0800 (CST)
Received: from dggpemd200001.china.huawei.com (unknown [7.185.36.224])
	by mail.maildlp.com (Postfix) with ESMTPS id 8CB151A0172;
	Mon, 25 Mar 2024 20:56:08 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpemd200001.china.huawei.com
 (7.185.36.224) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Mon, 25 Mar
 2024 20:56:07 +0800
From: ZhaoLong Wang <wangzhaolong1@huawei.com>
To: <richard@nod.at>, <miquel.raynal@bootlin.com>, <vigneshr@ti.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<chengzhihao1@huawei.com>, <wangzhaolong1@huawei.com>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>
Subject: [PATCH V2] ubifs: correct UBIFS_DFS_DIR_LEN macro definition and improve code clarity
Date: Mon, 25 Mar 2024 20:57:13 +0800
Message-ID: <20240325125713.95035-1-wangzhaolong1@huawei.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemd200001.china.huawei.com (7.185.36.224)

The UBIFS_DFS_DIR_LEN macro, which defines the maximum length of the UBIFS
debugfs directory name, has an incorrect formula and misleading comments.
The current formula is (3 + 1 + 2*2 + 1), which assumes that both UBI device
number and volume ID are limited to 2 characters. However, UBI device number
ranges from 0 to 37 (2 characters), and volume ID ranges from 0 to 127 (up
to 3 characters).

Although the current code works due to the cancellation of mathematical
errors (9 + 1 = 10, which matches the correct UBIFS_DFS_DIR_LEN value), it
can lead to confusion and potential issues in the future.

This patch aims to improve the code clarity and maintainability by making
the following changes:

1. Corrects the UBIFS_DFS_DIR_LEN macro definition to (3 + 1 + 2 + 3 + 1),
   accommodating the maximum lengths of both UBI device number and volume ID,
   plus the separators and null terminator.
2. Updates the snprintf calls to use UBIFS_DFS_DIR_LEN instead of
   UBIFS_DFS_DIR_LEN + 1, removing the unnecessary +1.
3. Modifies the error checks to compare against UBIFS_DFS_DIR_LEN using >=
   instead of >, aligning with the corrected macro definition.
4. Removes the redundant +1 in the dfs_dir_name array definitions in ubi.h
   and debug.h.
5. Renames the duplicated UBIFS_DFS_DIR_LEN and UBIFS_DFS_DIR_NAME macros in
   the sysfs-related code (sysfs.c and ubifs.h) to UBIFS_SYSFS_DIR_LEN and
   UBIFS_SYSFS_DIR_NAME, respectively, to differentiate their usage from the
   debugfs constants.

While these changes do not affect the runtime behavior, they make the code
more readable, maintainable, and less prone to future errors.

Signed-off-by: ZhaoLong Wang <wangzhaolong1@huawei.com>
---
 drivers/mtd/ubi/debug.c | 4 ++--
 drivers/mtd/ubi/ubi.h   | 2 +-
 fs/ubifs/debug.c        | 4 ++--
 fs/ubifs/debug.h        | 7 ++++---
 fs/ubifs/sysfs.c        | 6 +++---
 fs/ubifs/ubifs.h        | 7 ++++---
 6 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/mtd/ubi/debug.c b/drivers/mtd/ubi/debug.c
index d57f52bd2ff3..9ec3b8b6a0aa 100644
--- a/drivers/mtd/ubi/debug.c
+++ b/drivers/mtd/ubi/debug.c
@@ -598,9 +598,9 @@ int ubi_debugfs_init_dev(struct ubi_device *ubi)
 	if (!IS_ENABLED(CONFIG_DEBUG_FS))
 		return 0;
 
-	n = snprintf(d->dfs_dir_name, UBI_DFS_DIR_LEN + 1, UBI_DFS_DIR_NAME,
+	n = snprintf(d->dfs_dir_name, UBI_DFS_DIR_LEN, UBI_DFS_DIR_NAME,
 		     ubi->ubi_num);
-	if (n > UBI_DFS_DIR_LEN) {
+	if (n >= UBI_DFS_DIR_LEN) {
 		/* The array size is too small */
 		return -EINVAL;
 	}
diff --git a/drivers/mtd/ubi/ubi.h b/drivers/mtd/ubi/ubi.h
index 32009a24869e..da4e53ef5b0a 100644
--- a/drivers/mtd/ubi/ubi.h
+++ b/drivers/mtd/ubi/ubi.h
@@ -420,7 +420,7 @@ struct ubi_debug_info {
 	unsigned int power_cut_min;
 	unsigned int power_cut_max;
 	unsigned int emulate_failures;
-	char dfs_dir_name[UBI_DFS_DIR_LEN + 1];
+	char dfs_dir_name[UBI_DFS_DIR_LEN];
 	struct dentry *dfs_dir;
 	struct dentry *dfs_chk_gen;
 	struct dentry *dfs_chk_io;
diff --git a/fs/ubifs/debug.c b/fs/ubifs/debug.c
index ac77ac1fd73e..d91cec93d968 100644
--- a/fs/ubifs/debug.c
+++ b/fs/ubifs/debug.c
@@ -2827,9 +2827,9 @@ void dbg_debugfs_init_fs(struct ubifs_info *c)
 	const char *fname;
 	struct ubifs_debug_info *d = c->dbg;
 
-	n = snprintf(d->dfs_dir_name, UBIFS_DFS_DIR_LEN + 1, UBIFS_DFS_DIR_NAME,
+	n = snprintf(d->dfs_dir_name, UBIFS_DFS_DIR_LEN, UBIFS_DFS_DIR_NAME,
 		     c->vi.ubi_num, c->vi.vol_id);
-	if (n > UBIFS_DFS_DIR_LEN) {
+	if (n >= UBIFS_DFS_DIR_LEN) {
 		/* The array size is too small */
 		return;
 	}
diff --git a/fs/ubifs/debug.h b/fs/ubifs/debug.h
index ed966108da80..d425861e6b82 100644
--- a/fs/ubifs/debug.h
+++ b/fs/ubifs/debug.h
@@ -19,10 +19,11 @@ typedef int (*dbg_znode_callback)(struct ubifs_info *c,
 
 /*
  * The UBIFS debugfs directory name pattern and maximum name length (3 for "ubi"
- * + 1 for "_" and plus 2x2 for 2 UBI numbers and 1 for the trailing zero byte.
+ * + 1 for "_" and 2 for UBI device numbers and 3 for volume number and 1 for
+ * the trailing zero byte.
  */
 #define UBIFS_DFS_DIR_NAME "ubi%d_%d"
-#define UBIFS_DFS_DIR_LEN  (3 + 1 + 2*2 + 1)
+#define UBIFS_DFS_DIR_LEN  (3 + 1 + 2 + 3 + 1)
 
 /**
  * ubifs_debug_info - per-FS debugging information.
@@ -103,7 +104,7 @@ struct ubifs_debug_info {
 	unsigned int chk_fs:1;
 	unsigned int tst_rcvry:1;
 
-	char dfs_dir_name[UBIFS_DFS_DIR_LEN + 1];
+	char dfs_dir_name[UBIFS_DFS_DIR_LEN];
 	struct dentry *dfs_dir;
 	struct dentry *dfs_dump_lprops;
 	struct dentry *dfs_dump_budg;
diff --git a/fs/ubifs/sysfs.c b/fs/ubifs/sysfs.c
index 1c958148bb87..7b30aac42ac5 100644
--- a/fs/ubifs/sysfs.c
+++ b/fs/ubifs/sysfs.c
@@ -91,17 +91,17 @@ static struct kset ubifs_kset = {
 int ubifs_sysfs_register(struct ubifs_info *c)
 {
 	int ret, n;
-	char dfs_dir_name[UBIFS_DFS_DIR_LEN+1];
+	char dfs_dir_name[UBIFS_SYSFS_DIR_LEN];
 
 	c->stats = kzalloc(sizeof(struct ubifs_stats_info), GFP_KERNEL);
 	if (!c->stats) {
 		ret = -ENOMEM;
 		goto out_last;
 	}
-	n = snprintf(dfs_dir_name, UBIFS_DFS_DIR_LEN + 1, UBIFS_DFS_DIR_NAME,
+	n = snprintf(dfs_dir_name, UBIFS_SYSFS_DIR_LEN, UBIFS_SYSFS_DIR_NAME,
 		     c->vi.ubi_num, c->vi.vol_id);
 
-	if (n > UBIFS_DFS_DIR_LEN) {
+	if (n >= UBIFS_SYSFS_DIR_LEN) {
 		/* The array size is too small */
 		ret = -EINVAL;
 		goto out_free;
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index 1f3ea879d93a..549e147c5ce5 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -159,10 +159,11 @@
 
 /*
  * The UBIFS sysfs directory name pattern and maximum name length (3 for "ubi"
- * + 1 for "_" and plus 2x2 for 2 UBI numbers and 1 for the trailing zero byte.
+ * + 1 for "_" and 2 for UBI device numbers and 3 for volume number and 1 for
+ * the trailing zero byte.
  */
-#define UBIFS_DFS_DIR_NAME "ubi%d_%d"
-#define UBIFS_DFS_DIR_LEN  (3 + 1 + 2*2 + 1)
+#define UBIFS_SYSFS_DIR_NAME "ubi%d_%d"
+#define UBIFS_SYSFS_DIR_LEN  (3 + 1 + 2 + 3 + 1)
 
 /*
  * Lockdep classes for UBIFS inode @ui_mutex.
-- 
2.31.1


