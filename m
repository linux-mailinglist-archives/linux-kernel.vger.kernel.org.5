Return-Path: <linux-kernel+bounces-107824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 365A2880220
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67CD21C22F91
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADA484A46;
	Tue, 19 Mar 2024 16:17:03 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A862A83A07
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 16:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710865023; cv=none; b=P9fki/TiIAprg6C01AKWLbOXuf9eCXAWncgCDFArQfrSy2rfUzxwiIfSWUSlEckJJo++jLgd49KQHP5r19zBNNNFtO3eN1cLBk5WewMOV9jj1InP0jlWj7i1gtKHDsxRRPgJfjKSYzhHmUpCSt/V/bglwaq7XxFca5DW3/QDvds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710865023; c=relaxed/simple;
	bh=B7BXQFgnL28XJ6Ra29639VrkAH7LwpeP5+Qa7GUzfbE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ObCAPmKcrylnldKr+73C+z0s6U+Q+BfjnxAyq2O5F6olSkEqTnU6yFTaGimye8YhKeGLfTJg4Osgkx912+S9neNBY0XGfkTpF4GHpse69yuO81IByt/LmClZFd2sL66txsxXg60sapfXSBQJFNhHefmPBszT2z80soPuYVwANno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TzcHM2TsWz1h30K;
	Wed, 20 Mar 2024 00:14:23 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id DD1011A0172;
	Wed, 20 Mar 2024 00:16:55 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Wed, 20 Mar
 2024 00:16:55 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <richard@nod.at>, <chengzhihao1@huawei.com>
CC: <lizetao1@huawei.com>, <linux-kernel@vger.kernel.org>,
	<linux-mtd@lists.infradead.org>
Subject: [RFC PATCH 2/5] ubifs: Initialize or update ACLs for inode
Date: Wed, 20 Mar 2024 00:16:43 +0800
Message-ID: <20240319161646.2153867-3-lizetao1@huawei.com>
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

There are two scenarios where ACL needs to be updated, the first one
is when creating the inode, and the second one is in the chmod process.
When creating directories/files/device node/tmpfile, ACLs needs to be
initialized, but symlink do not.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
 fs/ubifs/dir.c  | 16 ++++++++++++++++
 fs/ubifs/file.c |  4 ++++
 2 files changed, 20 insertions(+)

diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index 551148de66cd..dfb6823cc953 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -316,6 +316,10 @@ static int ubifs_create(struct mnt_idmap *idmap, struct inode *dir,
 		goto out_fname;
 	}
 
+	err = ubifs_init_acl(inode, dir);
+	if (err)
+		goto out_inode;
+
 	err = ubifs_init_security(dir, inode, &dentry->d_name);
 	if (err)
 		goto out_inode;
@@ -466,6 +470,10 @@ static int ubifs_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 	}
 	ui = ubifs_inode(inode);
 
+	err = ubifs_init_acl(inode, dir);
+	if (err)
+		goto out_inode;
+
 	err = ubifs_init_security(dir, inode, &dentry->d_name);
 	if (err)
 		goto out_inode;
@@ -1013,6 +1021,10 @@ static int ubifs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 		goto out_fname;
 	}
 
+	err = ubifs_init_acl(inode, dir);
+	if (err)
+		goto out_inode;
+
 	err = ubifs_init_security(dir, inode, &dentry->d_name);
 	if (err)
 		goto out_inode;
@@ -1108,6 +1120,10 @@ static int ubifs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	ui->data = dev;
 	ui->data_len = devlen;
 
+	err = ubifs_init_acl(inode, dir);
+	if (err)
+		goto out_inode;
+
 	err = ubifs_init_security(dir, inode, &dentry->d_name);
 	if (err)
 		goto out_inode;
diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index 5029eb3390a5..8f964f8b0f96 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -41,6 +41,7 @@
 #include <linux/mount.h>
 #include <linux/slab.h>
 #include <linux/migrate.h>
+#include <linux/posix_acl.h>
 
 static int read_block(struct inode *inode, void *addr, unsigned int block,
 		      struct ubifs_data_node *dn)
@@ -1298,6 +1299,9 @@ int ubifs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	else
 		err = do_setattr(c, inode, attr);
 
+	if (!err && (attr->ia_valid & ATTR_MODE))
+		err = posix_acl_chmod(idmap, dentry, inode->i_mode);
+
 	return err;
 }
 
-- 
2.34.1


