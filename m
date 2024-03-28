Return-Path: <linux-kernel+bounces-123563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA31890B28
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75268B242B6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4423813F456;
	Thu, 28 Mar 2024 20:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="X4/19zvb"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91131386A3;
	Thu, 28 Mar 2024 20:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711657057; cv=none; b=HCyqT5DFolKgszgjraMQggcQW31mjcewCdgEPsYtZghNEhnLKv3MnGXGuBmqBQw3xHZsTIMP3Xx0SwLyvWxto6tPIN1GcgoyknZOFjhJ8UcoshX5D5wLxOAHkh4kCwVQXmBb8B1+CSPEQE1iFvQju60drmvzTVllbyzuiox8gdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711657057; c=relaxed/simple;
	bh=8Wkj6APgowOM1wCYwpFj64MBNrIKEgRwdw3icE38+Y8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=qgSqAkJK7A+uVoB0Aj2Qh00W46RXX7hGpR5zFepf51tYX3wEzoijYpmZzEBY3Z/jiuiOGAg+5rxZ4vp1v6auf7bz9FzuL0OnS23nq8CIXnOAvuk/toCFPnW6JocGtNVg4ShsfTxw9CZgZ1jhqBez+e681rWR18cANNuthElfedk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=X4/19zvb; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1052)
	id 44D5A20E6F61; Thu, 28 Mar 2024 13:17:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 44D5A20E6F61
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1711657049;
	bh=dUH87E40NrkSioYizP3cef7n/LxfQy39zSmAnjbWbeg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X4/19zvbS1QHZiOwRguyh0mnDOMxnwtxqh+K8spjotNxTe81quYgpaSIVb7qlu1/g
	 IofoxD7cKR91OhnX4Ur5zK6QVJjJX55hofb+X4TmTJHPhmoZg6W3m0WTAgFE1HsT8m
	 alQDzQkeFoPcwuRTwFEwWyUjqjKS1RlG2pds7adc=
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
Subject: [PATCH v16 15/20] security: add security_inode_setintegrity() hook
Date: Thu, 28 Mar 2024 13:17:22 -0700
Message-Id: <1711657047-10526-16-git-send-email-wufan@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1711657047-10526-1-git-send-email-wufan@linux.microsoft.com>
References: <1711657047-10526-1-git-send-email-wufan@linux.microsoft.com>
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
index 26b422059f54..22612058b903 100644
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
+					      enum lsm_integrity_type, type,
+					      const void *value, size_t size)
+{
+	return 0;
+}
+
 static inline int security_kernfs_init_security(struct kernfs_node *kn_dir,
 						struct kernfs_node *kn)
 {
diff --git a/security/security.c b/security/security.c
index 8f462d82bd8b..629f31710975 100644
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


