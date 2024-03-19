Return-Path: <linux-kernel+bounces-107821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2D588021B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6CDDB252C0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0422883CAA;
	Tue, 19 Mar 2024 16:17:02 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5C483A02
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 16:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710865021; cv=none; b=K0PBXeHrvcUzVTjO8sbX4khqjsd1GMnCerv15g+6JmPUpUlMNE0NWLg4NhjNqpvn8if0h+bh3MELP+GaWMYkgQChKgmZpqF/XqsNkdVArum0Lge3AyaHTpLUsmzElLqGSI7e20RfFBSnENtaflukYVQ61VeJOqHy97kFh8AIErU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710865021; c=relaxed/simple;
	bh=mpCI3oCjVwl2nFUvst8LdRaWyCFJGjR1hr3Sv0nZaHg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O30DRs+QboF081VmAdf7YDtrj4AEnz88nHk3C7QBkgec3xSSDTPvCiEiumCkC0NTlpni34gRNBQ8H44RP1lNxyANTR0B1aS/xRXrR0x9wGjasWPrrPXuygok9iplyWGBEQjcYR3EMVu7maFXmvGCdrQd8jux1eC0DQFfmG27krE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4TzcKP4vPTz1vx43;
	Wed, 20 Mar 2024 00:16:09 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 9B0931A016C;
	Wed, 20 Mar 2024 00:16:55 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Wed, 20 Mar
 2024 00:16:55 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <richard@nod.at>, <chengzhihao1@huawei.com>
CC: <lizetao1@huawei.com>, <linux-kernel@vger.kernel.org>,
	<linux-mtd@lists.infradead.org>
Subject: [RFC PATCH 1/5] ubifs: Implement POSIX Access Control Lists (ACLs)
Date: Wed, 20 Mar 2024 00:16:42 +0800
Message-ID: <20240319161646.2153867-2-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240319161646.2153867-1-lizetao1@huawei.com>
References: <20240319161646.2153867-1-lizetao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd500012.china.huawei.com (7.221.188.25)

Implement the ACLs feature for ubifs based on vfs Posix ACLs,
details as follows:
  * Initialize acl for newly created inode.
  * Provides get/set interface to access ACLs.

ACLs feature relies on xattr implementation which using specific key
names "system.posix_acl_default" and "system.posix_acl_access". Now Only
the v2 version of POSIX ACLs is supported, and ubifs does not need to
customize the storage format, which can simplify the implementation.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 fs/ubifs/acl.c   | 140 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/ubifs/ubifs.h |  13 +++++
 fs/ubifs/xattr.c |   1 -
 3 files changed, 153 insertions(+), 1 deletion(-)
 create mode 100644 fs/ubifs/acl.c

diff --git a/fs/ubifs/acl.c b/fs/ubifs/acl.c
new file mode 100644
index 000000000000..253568baf097
--- /dev/null
+++ b/fs/ubifs/acl.c
@@ -0,0 +1,140 @@
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
+	xattr_name = posix_acl_xattr_name(type);
+	if (unlikely(!strcmp(xattr_name, "")))
+		return ERR_PTR(-EINVAL);
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
+	xattr_name = posix_acl_xattr_name(type);
+	if (unlikely(!strcmp(xattr_name, "")))
+		return -EINVAL;
+
+	if (unlikely(!strcmp(xattr_name, XATTR_NAME_POSIX_ACL_DEFAULT) && !S_ISDIR(inode->i_mode)))
+		return acl ? -EACCES : 0;
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
+	}
+
+	error = ubifs_xattr_set(inode, xattr_name, xattr_value, size, flags, false);
+	if (likely(!error))
+		set_cached_acl(inode, type, acl);
+out:
+	kfree(xattr_value);
+	return error;
+}
+
+int ubifs_set_acl(struct mnt_idmap *idmap, struct dentry *dentry, struct posix_acl *acl, int type)
+{
+	struct inode *inode = d_inode(dentry);
+	umode_t old_mode = inode->i_mode;
+	int error;
+
+	if (type == ACL_TYPE_ACCESS && acl) {
+		error = posix_acl_update_mode(idmap, inode, &inode->i_mode, &acl);
+		if (unlikely(error))
+			return error;
+	}
+
+	error = __ubifs_set_acl(inode, type, acl, 0);
+	if (unlikely(error))
+		inode->i_mode = old_mode;
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
+ * This function initialize ACLs, including inheriting the
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
+		if (likely(!error))
+			error = __ubifs_set_acl(inode, ACL_TYPE_ACCESS, acl, XATTR_CREATE);
+		posix_acl_release(acl);
+	} else {
+		inode->i_acl = NULL;
+	}
+
+	return error;
+}
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index 3916dc4f30ca..b0d3b076290d 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -2069,6 +2069,19 @@ static inline int ubifs_init_security(struct inode *dentry,
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
index 0847db521984..eb1c1f5d10df 100644
--- a/fs/ubifs/xattr.c
+++ b/fs/ubifs/xattr.c
@@ -40,7 +40,6 @@
  * in the VFS inode cache. The xentries are cached in the LNC cache (see
  * tnc.c).
  *
- * ACL support is not implemented.
  */
 
 #include "ubifs.h"
-- 
2.34.1


