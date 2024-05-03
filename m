Return-Path: <linux-kernel+bounces-168363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C03B8BB795
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 00:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCC061C233F3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 22:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7FC82D6C;
	Fri,  3 May 2024 22:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="BGz1C8iF"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F99127B68;
	Fri,  3 May 2024 22:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714775562; cv=none; b=D/46ohgPdJe7RQ8g0kEyEiCrTmuFRg9KjxDN6C5WdAnxxMeOLU4x2T8sPpafp0TN44NOFeUqHbrAKYNUlOhooWeI7m6Yz4zpev39SZCBNUDwqqiVaSY15RcHkmZxTFEXigXbBto5ydG1v5cJC2cKrWA11dp7BqtUI8w3UpKCsgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714775562; c=relaxed/simple;
	bh=cYCeNmGfogWmDfJA0uRRJxas6UgsZckoduksMCuRFXY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=PaFFdzuMchqM184NNS+oW8lzgGQCgqnGaZ0gkLayG/af1IBQgliggB1/DHW/IktdVGe/GAP7bmzYv/LgX7Uxjd6FziDsukY3B/SChW1IYe7vujqLaMPVjxJXTzTQZetY2Hrg0KAdQp9lsVL9DA9rDx6SWIvdoUWyMiyLww75Uks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=BGz1C8iF; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1052)
	id 99BB720B2C84; Fri,  3 May 2024 15:32:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 99BB720B2C84
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1714775553;
	bh=qWRfm+z8o5siZBUEZXo0Ir9dXDcVc+rgpNsCKrDtxSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BGz1C8iF0i8Wksm9rIzoAKes6WCpTwdxF1J+/FSJ9ipa2CzM/RTZ6LWY8n9T0iTEj
	 eR8mjfNo1uCiBY216J1zehWvpW065XxCkHCIXQVVnhCeMDUe2FpF9j6ObvOFWU1ry5
	 xZrdrGm4IKo807zyp5UDDzELFRNUEjhwmUJL2Pj0=
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
Subject: [PATCH v18 15/21] security: add security_inode_setintegrity() hook
Date: Fri,  3 May 2024 15:32:25 -0700
Message-Id: <1714775551-22384-16-git-send-email-wufan@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1714775551-22384-1-git-send-email-wufan@linux.microsoft.com>
References: <1714775551-22384-1-git-send-email-wufan@linux.microsoft.com>
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

v18:
  + No changes
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
index d2ddd7c63b62..568d96012a48 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -410,6 +410,9 @@ int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer
 void security_inode_getsecid(struct inode *inode, u32 *secid);
 int security_inode_copy_up(struct dentry *src, struct cred **new);
 int security_inode_copy_up_xattr(const char *name);
+int security_inode_setintegrity(struct inode *inode,
+				enum lsm_integrity_type type, const void *value,
+				size_t size);
 int security_kernfs_init_security(struct kernfs_node *kn_dir,
 				  struct kernfs_node *kn);
 int security_file_permission(struct file *file, int mask);
@@ -1026,6 +1029,13 @@ static inline int security_inode_copy_up(struct dentry *src, struct cred **new)
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


