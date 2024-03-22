Return-Path: <linux-kernel+bounces-111720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB20886FF9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2E491F22695
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A743456B78;
	Fri, 22 Mar 2024 15:48:26 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0ED7200AE;
	Fri, 22 Mar 2024 15:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711122506; cv=none; b=Nws9nWeO8Aq8tYt2mir20M0iKJWz2ni8fCVU3pdPwbCQ/OJayIirK1/w+HjkKYiwCbWvh0lFm4VTVB2xKhh3NK89Wtg0LiKFEDhQtiYFikbh3WgKUH3tlZNCV4EobqL6fTInHtInrLsaAjCjuY4/lFbsV3sef9PZJx+ppLw1pEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711122506; c=relaxed/simple;
	bh=xM8FItCAOA4E3ykBAQf3WrkJlRDOl6PcjeF34CMuCRY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LyN3bWS8SSej31g5WQwp5Dsm4eg8gN/3jD+qzJoPz7DOtn5/yG8gDaFGr5Me4DBcViZkqnn5GJ/ay+pOYVYoV4UXs27qHLQKD2HGz9WHtgKdNT9Qp4wKZJI2W7KUan1/+bVKBOZHuxFbjmNevxItWIc/JYDKUY+sCOx4ZT8LbjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4V1RWh5dH2z1xsQp;
	Fri, 22 Mar 2024 23:46:24 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 0CBA91A016C;
	Fri, 22 Mar 2024 23:48:20 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Fri, 22 Mar
 2024 23:48:19 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <richard@nod.at>, <chengzhihao1@huawei.com>, <corbet@lwn.net>,
	<kent.overstreet@linux.dev>, <agruenba@redhat.com>
CC: <lizetao1@huawei.com>, <linux-mtd@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v2 2/5] ubifs: Implement POSIX Access Control Lists (ACLs)
Date: Fri, 22 Mar 2024 23:48:09 +0800
Message-ID: <20240322154812.215369-3-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240322154812.215369-1-lizetao1@huawei.com>
References: <20240322154812.215369-1-lizetao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd500012.china.huawei.com (7.221.188.25)

Implement the ACLs feature for ubifs based on vfs Posix ACLs,
details as follows:
  * Initialize acl for newly created inode.
  * Provides get/set interface to access ACLs.

ACLs feature relies on xattr implementation which using specific key
names "system.posix_acl_default" and "system.posix_acl_access". Now Only
the v2 version of POSIX ACLs is supported, and ubifs does not need to
customize the storage format, which can simplify the implementation.

It should be noted that Linux supports updating the file mode through
ACLs. However the acl may not exist, so ubifs_xattr_remove() returns
-ENODATA. Such a scenario needs to be specially handled. At the same
time, it needs to ensure that the updated inode is written to flash.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
v1 -> v2:
  * Get xattr_name by direct expansion instead of posix_acl_xattr_name().
  * Modify ubifs_xattr_remove to an external function to remove the xattr of ACL.
  * Remove redundant likely() and unlikely().
  * Fix updating file mode via ACL and support writing to flash.

v1: https://lore.kernel.org/all/20240319161646.2153867-2-lizetao1@huawei.com/

 fs/ubifs/Makefile |   1 +
 fs/ubifs/acl.c    | 192 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/ubifs/ubifs.h  |  14 ++++
 fs/ubifs/xattr.c  |   3 +-
 4 files changed, 208 insertions(+), 2 deletions(-)
 create mode 100644 fs/ubifs/acl.c

diff --git a/fs/ubifs/Makefile b/fs/ubifs/Makefile
index 314c80b24a76..b615fbb73908 100644
--- a/fs/ubifs/Makefile
+++ b/fs/ubifs/Makefile
@@ -9,3 +9,4 @@ ubifs-y += misc.o sysfs.o
 ubifs-$(CONFIG_FS_ENCRYPTION) += crypto.o
 ubifs-$(CONFIG_UBIFS_FS_XATTR) += xattr.o
 ubifs-$(CONFIG_UBIFS_FS_AUTHENTICATION) += auth.o
+ubifs-$(CONFIG_UBIFS_FS_POSIX_ACL) += acl.o
diff --git a/fs/ubifs/acl.c b/fs/ubifs/acl.c
new file mode 100644
index 000000000000..8ac5bd86f32d
--- /dev/null
+++ b/fs/ubifs/acl.c
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * This file is part of UBIFS.
+ *
+ * Copyright (C) 2024 Huawei Tech. Co., Ltd.
+ *
+ * Authors: Li Zetao <lizetao1@huawei.com>
+ */
+
+/* This file implements POSIX Access Control Lists (ACLs) */
+
+#include "ubifs.h"
+
+#include <linux/posix_acl_xattr.h>
+
+struct posix_acl *ubifs_get_inode_acl(struct inode *inode, int type, bool rcu)
+{
+	char *xattr_value = NULL;
+	const char *xattr_name;
+	struct posix_acl *acl;
+	ssize_t size;
+
+	if (rcu)
+		return ERR_PTR(-ECHILD);
+
+	switch (type) {
+	case ACL_TYPE_ACCESS:
+		xattr_name = XATTR_NAME_POSIX_ACL_ACCESS;
+		break;
+	case ACL_TYPE_DEFAULT:
+		xattr_name = XATTR_NAME_POSIX_ACL_DEFAULT;
+		break;
+	default:
+		return ERR_PTR(-EINVAL);
+	}
+
+	size = ubifs_xattr_get(inode, xattr_name, NULL, 0);
+	if (size > 0) {
+		xattr_value = kzalloc(size, GFP_KERNEL);
+		if (unlikely(!xattr_value))
+			return ERR_PTR(-ENOMEM);
+
+		size = ubifs_xattr_get(inode, xattr_name, xattr_value, size);
+	}
+
+	if (size > 0)
+		acl = posix_acl_from_xattr(&init_user_ns, xattr_value, size);
+	else if (size == -ENODATA || size == 0)
+		acl = NULL;
+	else
+		acl = ERR_PTR(size);
+
+	kfree(xattr_value);
+
+	return acl;
+}
+
+static int __ubifs_set_acl(struct inode *inode, int type, struct posix_acl *acl, int flags)
+{
+	void *xattr_value = NULL;
+	const char *xattr_name;
+	size_t size = 0;
+	int error;
+
+	switch (type) {
+	case ACL_TYPE_ACCESS:
+		xattr_name = XATTR_NAME_POSIX_ACL_ACCESS;
+		break;
+
+	case ACL_TYPE_DEFAULT:
+		xattr_name = XATTR_NAME_POSIX_ACL_DEFAULT;
+		if (!S_ISDIR(inode->i_mode))
+			return acl ? -EACCES : 0;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	if (acl) {
+		size = posix_acl_xattr_size(acl->a_count);
+		xattr_value = kmalloc(size, GFP_KERNEL);
+		if (unlikely(!xattr_value))
+			return -ENOMEM;
+
+		error = posix_acl_to_xattr(&init_user_ns, acl, xattr_value, size);
+		if (unlikely(error < 0))
+			goto out;
+
+		error = ubifs_xattr_set(inode, xattr_name, xattr_value, size, flags, false);
+	} else {
+		error = ubifs_xattr_remove(inode, xattr_name);
+		if (error == -ENODATA)
+			return 0;
+	}
+
+	if (!error)
+		set_cached_acl(inode, type, acl);
+out:
+	kfree(xattr_value);
+	return error;
+}
+
+static int ubifs_update_mode(struct inode *inode, umode_t mode)
+{
+	struct ubifs_inode *ui = ubifs_inode(inode);
+	struct ubifs_info *c = inode->i_sb->s_fs_info;
+	struct ubifs_budget_req req = { .dirtied_ino = 1,
+				.dirtied_ino_d = ALIGN(ui->data_len, 8) };
+	int release;
+	int err;
+
+	err = ubifs_budget_space(c, &req);
+	if (err)
+		return err;
+
+	mutex_lock(&ui->ui_mutex);
+	release = ui->dirty;
+	inode->i_mode = mode;
+	inode_set_ctime_current(inode);
+	mark_inode_dirty_sync(inode);
+	mutex_unlock(&ui->ui_mutex);
+
+	if (release)
+		ubifs_release_budget(c, &req);
+	if (IS_SYNC(inode))
+		err = inode->i_sb->s_op->write_inode(inode, NULL);
+
+	return err;
+}
+
+int ubifs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry, struct posix_acl *acl, int type)
+{
+	struct inode *inode = d_inode(dentry);
+	umode_t mode = inode->i_mode;
+	bool update_mode = false;
+	int error;
+
+	if (type == ACL_TYPE_ACCESS && acl) {
+		error = posix_acl_update_mode(idmap, inode, &mode, &acl);
+		if (unlikely(error))
+			return error;
+
+		if (inode->i_mode != mode)
+			update_mode = true;
+	}
+
+	error = __ubifs_set_acl(inode, type, acl, 0);
+	if (!error && update_mode)
+		error = ubifs_update_mode(inode, mode);
+
+	return error;
+
+}
+
+/**
+ * ubifs_init_acl - initialize the ACLs for a new inode.
+ * @inode: newly created inode
+ * @dir: parent directory inode
+ *
+ * This function initializes ACLs, including inheriting the
+ * default ACLs of parent directory or modifying the default
+ * ACLs according to the mode parameter in open() / creat()
+ * system calls.
+ */
+int ubifs_init_acl(struct inode *inode, struct inode *dir)
+{
+	struct posix_acl *default_acl;
+	struct posix_acl *acl;
+	int error;
+
+	error = posix_acl_create(dir, &inode->i_mode, &default_acl, &acl);
+	if (unlikely(error))
+		return error;
+
+	if (default_acl) {
+		error = __ubifs_set_acl(inode, ACL_TYPE_DEFAULT, default_acl, XATTR_CREATE);
+		posix_acl_release(default_acl);
+	} else {
+		inode->i_default_acl = NULL;
+	}
+
+	if (acl) {
+		if (!error)
+			error = __ubifs_set_acl(inode, ACL_TYPE_ACCESS, acl, XATTR_CREATE);
+		posix_acl_release(acl);
+	} else {
+		inode->i_acl = NULL;
+	}
+
+	return error;
+}
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index 1f3ea879d93a..b96c2462237a 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -2046,6 +2046,7 @@ int ubifs_xattr_set(struct inode *host, const char *name, const void *value,
 		    size_t size, int flags, bool check_lock);
 ssize_t ubifs_xattr_get(struct inode *host, const char *name, void *buf,
 			size_t size);
+int ubifs_xattr_remove(struct inode *host, const char *name);
 
 #ifdef CONFIG_UBIFS_FS_XATTR
 extern const struct xattr_handler * const ubifs_xattr_handlers[];
@@ -2074,6 +2075,19 @@ static inline int ubifs_init_security(struct inode *dentry,
 }
 #endif
 
+#ifdef CONFIG_UBIFS_FS_POSIX_ACL
+struct posix_acl *ubifs_get_inode_acl(struct inode *inode, int type, bool rcu);
+int ubifs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry, struct posix_acl *acl, int type);
+int ubifs_init_acl(struct inode *inode, struct inode *dir);
+
+#else /* CONFIG_UBIFS_FS_POSIX_ACL */
+#define ubifs_get_inode_acl NULL
+#define ubifs_set_acl NULL
+static inline int ubifs_init_acl(struct inode *inode, struct inode *dir)
+{
+	return 0;
+}
+#endif /* CONFIG_UBIFS_FS_POSIX_ACL */
 
 /* super.c */
 struct inode *ubifs_iget(struct super_block *sb, unsigned long inum);
diff --git a/fs/ubifs/xattr.c b/fs/ubifs/xattr.c
index 0847db521984..87350b15f2c2 100644
--- a/fs/ubifs/xattr.c
+++ b/fs/ubifs/xattr.c
@@ -40,7 +40,6 @@
  * in the VFS inode cache. The xentries are cached in the LNC cache (see
  * tnc.c).
  *
- * ACL support is not implemented.
  */
 
 #include "ubifs.h"
@@ -592,7 +591,7 @@ void ubifs_evict_xattr_inode(struct ubifs_info *c, ino_t xattr_inum)
 	}
 }
 
-static int ubifs_xattr_remove(struct inode *host, const char *name)
+int ubifs_xattr_remove(struct inode *host, const char *name)
 {
 	struct inode *inode;
 	struct ubifs_info *c = host->i_sb->s_fs_info;
-- 
2.34.1


