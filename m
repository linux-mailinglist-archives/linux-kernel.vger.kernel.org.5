Return-Path: <linux-kernel+bounces-143479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 844C28A39F5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 03:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A5811F21C88
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 01:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251686D1B5;
	Sat, 13 Apr 2024 00:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="f9rfld/V"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD381BC3F;
	Sat, 13 Apr 2024 00:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712969775; cv=none; b=CURmisbDNUc+c9sMYC7g9r9F72qMza0InTrQsmKmxtNdVKqshMNi+KCPomjX5W/OYVzTkqzi3LsWFS/fEGRpg+PSpVQDq1kKXlUt/tQ+DhbK6OiBY2lVepcKswcfXv6l10Lu96hCuh2+P5IwiefSI6CJt4bzk10PHBTSB/G2wG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712969775; c=relaxed/simple;
	bh=nTi15qG8lmVh0RkooefIUS4ZyKTgWdzS0Mn6TnFLPw0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ilmmywxVjbYSHUsYOsEfBUxn61JZDcA+6oEdXzxskqSv9QnrwGFM/J1q2/AdgXifCVxAy8F2dHRG1FyuLAiwf5uGiQAuWxMlpyR4TgwEkTrpiNC30O2UTMyK/oVffMjybo0vZCQNU9nyQAPAzCb3bLNSsDEHdT973p3e6bWtwEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=f9rfld/V; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1052)
	id 581A820FC5F0; Fri, 12 Apr 2024 17:56:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 581A820FC5F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1712969766;
	bh=LHTCW6UukkGntCuP2Gvty+Tw0pym/FlPsCBlFmagVTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f9rfld/VezGgp5zZgmyBasHci0PWrt5GN5SmY/SzOu6ButyQ7X7ERgjCGSTr56FBr
	 psD6XyrxU6Vhs4CCTcfr+4sCesu2RlubJLHKAa3VSdF/RMk2y47T17slU8gDfPG2VK
	 lxLUGzNNRnsnxV+pYtlmJOSY370gCqgHdo3CUUzE=
From: Fan Wu <wufan@linux.microsoft.com>
To: corbet@lwn.net,
	zohar@linux.ibm.com,
	jmorris@namei.org,
	serge@hallyn.com,
	tytso@mit.edu,
	ebiggers@kernel.org,
	axboe@kernel.dk,
	agk@redhat.com,
	snitzer@kernel.org,
	eparis@redhat.com,
	paul@paul-moore.com
Cc: linux-doc@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	fsverity@lists.linux.dev,
	linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fan Wu <wufan@linux.microsoft.com>
Subject: [PATCH v17 15/21] security: add security_inode_setintegrity() hook
Date: Fri, 12 Apr 2024 17:55:58 -0700
Message-Id: <1712969764-31039-16-git-send-email-wufan@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1712969764-31039-1-git-send-email-wufan@linux.microsoft.com>
References: <1712969764-31039-1-git-send-email-wufan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This patch introduces a new hook to save inode's integrity
data. For example, for fsverity enabled files, LSMs can use this hook to
save the verified fsverity builtin signature into the inode's security
blob, and LSMs can make access decisions based on the data inside
the signature, like the signer certificate.

Signed-off-by: Fan Wu <wufan@linux.microsoft.com>

--
v1-v14:
  + Not present

v15:
  + Introduced

v16:
  + Switch to call_int_hook()

v17:
  + Fix a typo
---
 include/linux/lsm_hook_defs.h |  2 ++
 include/linux/security.h      | 10 ++++++++++
 security/security.c           | 20 ++++++++++++++++++++
 3 files changed, 32 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index b391a7f13053..6f746dfdb28b 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -177,6 +177,8 @@ LSM_HOOK(int, 0, inode_listsecurity, struct inode *inode, char *buffer,
 LSM_HOOK(void, LSM_RET_VOID, inode_getsecid, struct inode *inode, u32 *secid)
 LSM_HOOK(int, 0, inode_copy_up, struct dentry *src, struct cred **new)
 LSM_HOOK(int, -EOPNOTSUPP, inode_copy_up_xattr, const char *name)
+LSM_HOOK(int, 0, inode_setintegrity, struct inode *inode,
+	 enum lsm_integrity_type type, const void *value, size_t size)
 LSM_HOOK(int, 0, kernfs_init_security, struct kernfs_node *kn_dir,
 	 struct kernfs_node *kn)
 LSM_HOOK(int, 0, file_permission, struct file *file, int mask)
diff --git a/include/linux/security.h b/include/linux/security.h
index 9e46b13a356c..703762b0c4ad 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -404,6 +404,9 @@ int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer
 void security_inode_getsecid(struct inode *inode, u32 *secid);
 int security_inode_copy_up(struct dentry *src, struct cred **new);
 int security_inode_copy_up_xattr(const char *name);
+int security_inode_setintegrity(struct inode *inode,
+				enum lsm_integrity_type type, const void *value,
+				size_t size);
 int security_kernfs_init_security(struct kernfs_node *kn_dir,
 				  struct kernfs_node *kn);
 int security_file_permission(struct file *file, int mask);
@@ -1020,6 +1023,13 @@ static inline int security_inode_copy_up(struct dentry *src, struct cred **new)
 	return 0;
 }
 
+static inline int security_inode_setintegrity(struct inode *inode,
+					      enum lsm_integrity_type type,
+					      const void *value, size_t size)
+{
+	return 0;
+}
+
 static inline int security_kernfs_init_security(struct kernfs_node *kn_dir,
 						struct kernfs_node *kn)
 {
diff --git a/security/security.c b/security/security.c
index 3a7724c3dd76..2c20635a589b 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2681,6 +2681,26 @@ int security_inode_copy_up_xattr(const char *name)
 }
 EXPORT_SYMBOL(security_inode_copy_up_xattr);
 
+/**
+ * security_inode_setintegrity() - Set the inode's integrity data
+ * @inode: inode
+ * @type: type of integrity, e.g. hash digest, signature, etc
+ * @value: the integrity value
+ * @size: size of the integrity value
+ *
+ * Register a verified integrity measurement of a inode with LSMs.
+ * LSMs should free the previously saved data if @value is NULL.
+ *
+ * Return: Returns 0 on success, negative values on failure.
+ */
+int security_inode_setintegrity(struct inode *inode,
+				enum lsm_integrity_type type, const void *value,
+				size_t size)
+{
+	return call_int_hook(inode_setintegrity, inode, type, value, size);
+}
+EXPORT_SYMBOL(security_inode_setintegrity);
+
 /**
  * security_kernfs_init_security() - Init LSM context for a kernfs node
  * @kn_dir: parent kernfs node
-- 
2.44.0


