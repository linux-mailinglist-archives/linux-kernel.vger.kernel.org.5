Return-Path: <linux-kernel+bounces-112655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAA1887C9A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 13:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 694061C20AFD
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 12:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F63C179AA;
	Sun, 24 Mar 2024 12:02:33 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBB51759E
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 12:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711281752; cv=none; b=QXsv++mAa77jNLUY5BoYL3mAoKn4tKpVEiw+Cdr/8tgtHzixVeml5F9oNRrtvFwpD7jXxj/HDx7lYWVccFZNnQ3Wn4xrok854Vi6D6Uekg3qgK5UGPf+Dr5k/Tb7sDjV2UfqyBkq4TzGWpJVE7CI7LYt5ilv6gHpdm614LC9CaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711281752; c=relaxed/simple;
	bh=uswSHN8gM7EHW19tuezUmRw7mtMd+UG2/e+TbNplN5o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LjIVGMX8qtLamXd8nUWxxVuTm+Yrx7bYHVZMHgnVIsL3HOhIx4Ag3SaR40cXHYeH1YLTMvcrh0MzV29fhPU+Kp1Lit72QlVXdQiO1XrdcdszOFegEmRc0qwlH4vNKcK3zKIUXpv3yzPmrwgv/2QMnd+6DGjOd4acsa2r+1J7KKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4V2ZQ44bs9z1xs6Y;
	Sun, 24 Mar 2024 20:00:28 +0800 (CST)
Received: from dggpemd200001.china.huawei.com (unknown [7.185.36.224])
	by mail.maildlp.com (Postfix) with ESMTPS id E11ED140381;
	Sun, 24 Mar 2024 20:02:25 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpemd200001.china.huawei.com
 (7.185.36.224) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Sun, 24 Mar
 2024 20:02:25 +0800
From: ZhaoLong Wang <wangzhaolong1@huawei.com>
To: <richard@nod.at>, <miquel.raynal@bootlin.com>, <vigneshr@ti.com>,
	<ada@thorsis.com>, <error27@gmail.com>, <Artem.Bityutskiy@nokia.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<chengzhihao1@huawei.com>, <wangzhaolong1@huawei.com>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>
Subject: [PATCH] ubifs: fix incorrect UBIFS_DFS_DIR_LEN macro definition
Date: Sun, 24 Mar 2024 20:03:33 +0800
Message-ID: <20240324120333.3837837-1-wangzhaolong1@huawei.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemd200001.china.huawei.com (7.185.36.224)

The UBIFS_DFS_DIR_LEN macro, which defines the maximum length of the UBIFS
debugfs directory name, is incorrectly calculated. The current formula is
(3 + 1 + 2*2 + 1), which assumes that both UBI device number and volume ID
are limited to 2 characters. However, UBI device number ranges from 0 to
37 (2 characters), and volume ID ranges from 0 to 127 (up to 3 characters).

This incorrect definition leads to a buffer overflow issue when the device
number is 31 and volume ID is 127, causing the dbg_debugfs_init_fs() function
to return prematurely without creating debugfs directory in the stable branch
linux-5.10.y.

A previous attempt to fix this issue in commit be076fdf8369 ("ubifs: fix
snprintf() checking") by modifying the snprintf return value check range is
insufficient. It avoids the premature function return but does not address
the root cause of the problem. If the buffer length is inadequate, snprintf
will truncate the output string, resulting in incorrect directory names
during filesystem debugging.

The proper solution is to correct the UBIFS_DFS_DIR_LEN macro definition to
(3 + 1 + 2 + 3 + 1), accommodating the maximum lengths of both UBI device
number and volume ID, plus the separators and null terminator.

Additionally, the original equality check for snprintf return value strictly
adheres to the function definition. Although it may seem rigid, it is a good
programming practice to prevent introducing subtle bugs.

This patch makes the following changes:

1. Corrects the UBIFS_DFS_DIR_LEN macro definition to (3 + 1 + 2 + 3 + 1).
2. Updates the snprintf calls to use UBIFS_DFS_DIR_LEN instead of
    UBIFS_DFS_DIR_LEN + 1.
3. Modifies the error checks to compare against UBIFS_DFS_DIR_LEN using >=
    instead of >.
4. Removes the redundant UBIFS_DFS_DIR_LEN definition in ubifs.h.
5. Updates the relevant comments to reflect the correct maximum length
    calculation.

With these changes, the buffer overflow issue is thoroughly resolved, and the
code is made more robust and maintainable.

Fixes: be076fdf8369 ("ubifs: fix snprintf() checking")
Fixes: ae380ce04731 ("UBIFS: lessen the size of debugging info data structure")
Fixes: 2a734bb8d502 ("UBI: use debugfs for the extra checks knobs")
Signed-off-by: ZhaoLong Wang <wangzhaolong1@huawei.com>
---
 drivers/mtd/ubi/debug.c | 4 ++--
 drivers/mtd/ubi/ubi.h   | 2 +-
 fs/ubifs/debug.c        | 4 ++--
 fs/ubifs/debug.h        | 9 +++++----
 fs/ubifs/ubifs.h        | 7 -------
 5 files changed, 10 insertions(+), 16 deletions(-)

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
index ed966108da80..bbcb2bf41f83 100644
--- a/fs/ubifs/debug.h
+++ b/fs/ubifs/debug.h
@@ -18,11 +18,12 @@ typedef int (*dbg_znode_callback)(struct ubifs_info *c,
 				  struct ubifs_znode *znode, void *priv);
 
 /*
- * The UBIFS debugfs directory name pattern and maximum name length (3 for "ubi"
- * + 1 for "_" and plus 2x2 for 2 UBI numbers and 1 for the trailing zero byte.
+ * The UBIFS sysfs directory name pattern and maximum name length (3 for "ubi"
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
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index 1f3ea879d93a..7b6be3fb4f62 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -157,13 +157,6 @@
 #define UBIFS_HMAC_ARR_SZ 0
 #endif
 
-/*
- * The UBIFS sysfs directory name pattern and maximum name length (3 for "ubi"
- * + 1 for "_" and plus 2x2 for 2 UBI numbers and 1 for the trailing zero byte.
- */
-#define UBIFS_DFS_DIR_NAME "ubi%d_%d"
-#define UBIFS_DFS_DIR_LEN  (3 + 1 + 2*2 + 1)
-
 /*
  * Lockdep classes for UBIFS inode @ui_mutex.
  */
-- 
2.31.1


