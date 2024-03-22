Return-Path: <linux-kernel+bounces-111723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 728EC886FFE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12C031F21DA1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA7859B5F;
	Fri, 22 Mar 2024 15:48:27 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7645453E33;
	Fri, 22 Mar 2024 15:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711122507; cv=none; b=OWemclt5LykBR9+TuC8UWq8SSWQlbuy6FZDAAvREZhgqVsj4uZbD2FwK0qyu5fm6e7qF2x6Voacjo8fBJGUIjUcMxaPMcnsnIZfiY37u/EKdm2pIUdxsfDCj9RQNNKt4zqHEVDWt6nIuFrXcNplzz7vxMdUv1bS40/Jv8hu5HSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711122507; c=relaxed/simple;
	bh=acFs/MQ+m3wH/w6F9F25EZh7RH06LQFjK8XjUdS9LF4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IVm27xP6bE5Yz+bjF8/Zr75Rk00YvV/ku4eZGeR/vIF51m7bLcJK6NY82d1ZSvIlzxMW54JNzCq0dyQNVGckeYUqGEfVs+NbnY4taVT6Lgtxc3vY14bmllTf5LLAbIXQj2Vnlzos+9ujpmndONMueccDy0uskUPOEJvkkUomV0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4V1RWF35WJztQVr;
	Fri, 22 Mar 2024 23:46:01 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 7663D140157;
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
Subject: [RFC PATCH v2 3/5] ubifs: Initialize or update ACLs for inode
Date: Fri, 22 Mar 2024 23:48:10 +0800
Message-ID: <20240322154812.215369-4-lizetao1@huawei.com>
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

There are two scenarios where ACL needs to be updated, the first one
is when creating the inode, and the second one is in the chmod process.
When creating directories/files/device node/tmpfile, ACLs needs to be
initialized, but symlink do not.

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
v1 -> v2: Add initialization ACL in create_whiteout()
v1: https://lore.kernel.org/all/20240319161646.2153867-3-lizetao1@huawei.com/

 fs/ubifs/dir.c  | 20 ++++++++++++++++++++
 fs/ubifs/file.c |  4 ++++
 2 files changed, 24 insertions(+)

diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index eac0fef801f1..243dfb478984 100644
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
@@ -376,6 +380,10 @@ static struct inode *create_whiteout(struct inode *dir, struct dentry *dentry)
 	init_special_inode(inode, inode->i_mode, WHITEOUT_DEV);
 	ubifs_assert(c, inode->i_op == &ubifs_file_inode_operations);
 
+	err = ubifs_init_acl(inode, dir);
+	if (err)
+		goto out_inode;
+
 	err = ubifs_init_security(dir, inode, &dentry->d_name);
 	if (err)
 		goto out_inode;
@@ -466,6 +474,10 @@ static int ubifs_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 	}
 	ui = ubifs_inode(inode);
 
+	err = ubifs_init_acl(inode, dir);
+	if (err)
+		goto out_inode;
+
 	err = ubifs_init_security(dir, inode, &dentry->d_name);
 	if (err)
 		goto out_inode;
@@ -1013,6 +1025,10 @@ static int ubifs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 		goto out_fname;
 	}
 
+	err = ubifs_init_acl(inode, dir);
+	if (err)
+		goto out_inode;
+
 	err = ubifs_init_security(dir, inode, &dentry->d_name);
 	if (err)
 		goto out_inode;
@@ -1108,6 +1124,10 @@ static int ubifs_mknod(struct mnt_idmap *idmap, struct inode *dir,
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
index a1f46919934c..808a2ded4f8c 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -41,6 +41,7 @@
 #include <linux/mount.h>
 #include <linux/slab.h>
 #include <linux/migrate.h>
+#include <linux/posix_acl.h>
 
 static int read_block(struct inode *inode, void *addr, unsigned int block,
 		      struct ubifs_data_node *dn)
@@ -1297,6 +1298,9 @@ int ubifs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	else
 		err = do_setattr(c, inode, attr);
 
+	if (!err && (attr->ia_valid & ATTR_MODE))
+		err = posix_acl_chmod(idmap, dentry, inode->i_mode);
+
 	return err;
 }
 
-- 
2.34.1


