Return-Path: <linux-kernel+bounces-45347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD7E842EDF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B09B1F25C87
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7B578682;
	Tue, 30 Jan 2024 21:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WS5ir9TD"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8168678B64;
	Tue, 30 Jan 2024 21:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706651215; cv=none; b=Z6AJwCmrOU//8FXYgR0cDLBgeJimaXvM5gI5ZMckog97a2fShbAdaxpX0hgiLyV70b50ixJSlSz6qirSTQtZkdBRI5OYCpssAJPL5DvzfJyMhq/rKQcHTOtWuS6LJVYlJhygRJSS4UyR/tNY2QAhekRCsAXtnx7xnQReC7FfXDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706651215; c=relaxed/simple;
	bh=HLpwlFI69iotr1hPLjzeM18DSEwoMiQ2mxy0WSHuluk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sSSc//Qxav5UUM8AMk1dZo4bzKrm3JnyZz14VM6ImH8F0UiIGTo7oGDyVpfm46qBGZGsj2mXQ3MZKq4LhlcVUhLQ4L0LkByDOazI1Hr0eEGhbksjDjCToxxcRDkJknopWWqzbB4xrKyDVeVWIW7NRic7552O69clYKjdDD9tyAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WS5ir9TD; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40ULXLnV012708;
	Tue, 30 Jan 2024 21:46:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ziVlO+dnOtCXjBz/gV1l3+dnf+oYvewAs/EKyz4Wv3U=;
 b=WS5ir9TDTufmdS/1nR6z0UqzkzV2HvUV7VdRfk+owYB4AYGM1QUAbQU/U0sPpTuO55Mf
 kvd9JSVxSvcXN0ZQBmxjDNPxZyEWJBijj/lP0eLMetEJc3+oBV9QcmRNN15cAf4WkKw8
 QtwjFrg00OTUTCNG+6QZ9ZXXxO4vfZCAdRR6wphyb7lZqHaAdDm+VhWSeXYVWzrcDM5s
 z81aPQsQaa8vHWGMupHigaImSMh2TFtqN3YMyLGgoeo4w7xUr54rsFEdvoEfIa6A17FG
 UjGGG8E2x8DVoP7wh6dW0VXmr7+BQAMfb/X6ZW10jcfNWyj5x4U0yb5j/Nru5Gw7Srhu tg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vy94n07kj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 21:46:30 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40ULYcX2015260;
	Tue, 30 Jan 2024 21:46:29 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vy94n07k1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 21:46:29 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40UJ86Jm010564;
	Tue, 30 Jan 2024 21:46:28 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vwd5nsf5r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 21:46:28 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40ULkS3p31326538
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 21:46:28 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E816558056;
	Tue, 30 Jan 2024 21:46:27 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BF5E58052;
	Tue, 30 Jan 2024 21:46:27 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jan 2024 21:46:27 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, zohar@linux.ibm.com, roberto.sassu@huawei.com,
        amir73il@gmail.com, miklos@szeredi.hu,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 1/5] security: allow finer granularity in permitting copy-up of security xattrs
Date: Tue, 30 Jan 2024 16:46:16 -0500
Message-ID: <20240130214620.3155380-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130214620.3155380-1-stefanb@linux.ibm.com>
References: <20240130214620.3155380-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nsNshzt1SCogKEXlGy533T4CUsAVBwI3
X-Proofpoint-ORIG-GUID: YWDCNKq7p8-nPtFrvnuRxTAM3vP-0P-x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_12,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=562
 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 bulkscore=0 spamscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401300162

Copying up xattrs is solely based on the security xattr name. For finer
granularity add a dentry parameter to the security_inode_copy_up_xattr
hook definition, allowing decisions to be based on the xattr content as
well.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 fs/overlayfs/copy_up.c            | 2 +-
 include/linux/evm.h               | 2 +-
 include/linux/lsm_hook_defs.h     | 3 ++-
 include/linux/security.h          | 4 ++--
 security/integrity/evm/evm_main.c | 2 +-
 security/security.c               | 7 ++++---
 security/selinux/hooks.c          | 2 +-
 security/smack/smack_lsm.c        | 2 +-
 8 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index b8e25ca51016..bd9ddcefb7a7 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -114,7 +114,7 @@ int ovl_copy_xattr(struct super_block *sb, const struct path *oldpath, struct de
 		if (ovl_is_private_xattr(sb, name))
 			continue;
 
-		error = security_inode_copy_up_xattr(name);
+		error = security_inode_copy_up_xattr(old, name);
 		if (error < 0 && error != -EOPNOTSUPP)
 			break;
 		if (error == 1) {
diff --git a/include/linux/evm.h b/include/linux/evm.h
index 36ec884320d9..d8c0343436b8 100644
--- a/include/linux/evm.h
+++ b/include/linux/evm.h
@@ -31,7 +31,7 @@ extern void evm_inode_post_setxattr(struct dentry *dentry,
 				    const char *xattr_name,
 				    const void *xattr_value,
 				    size_t xattr_value_len);
-extern int evm_inode_copy_up_xattr(const char *name);
+extern int evm_inode_copy_up_xattr(struct dentry *dentry, const char *name);
 extern int evm_inode_removexattr(struct mnt_idmap *idmap,
 				 struct dentry *dentry, const char *xattr_name);
 extern void evm_inode_post_removexattr(struct dentry *dentry,
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 185924c56378..7dd61f51d84a 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -163,7 +163,8 @@ LSM_HOOK(int, 0, inode_listsecurity, struct inode *inode, char *buffer,
 	 size_t buffer_size)
 LSM_HOOK(void, LSM_RET_VOID, inode_getsecid, struct inode *inode, u32 *secid)
 LSM_HOOK(int, 0, inode_copy_up, struct dentry *src, struct cred **new)
-LSM_HOOK(int, -EOPNOTSUPP, inode_copy_up_xattr, const char *name)
+LSM_HOOK(int, -EOPNOTSUPP, inode_copy_up_xattr, struct dentry *src,
+	 const char *name)
 LSM_HOOK(int, 0, kernfs_init_security, struct kernfs_node *kn_dir,
 	 struct kernfs_node *kn)
 LSM_HOOK(int, 0, file_permission, struct file *file, int mask)
diff --git a/include/linux/security.h b/include/linux/security.h
index d0eb20f90b26..9fc9ca6284d6 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -387,7 +387,7 @@ int security_inode_setsecurity(struct inode *inode, const char *name, const void
 int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size);
 void security_inode_getsecid(struct inode *inode, u32 *secid);
 int security_inode_copy_up(struct dentry *src, struct cred **new);
-int security_inode_copy_up_xattr(const char *name);
+int security_inode_copy_up_xattr(struct dentry *src, const char *name);
 int security_kernfs_init_security(struct kernfs_node *kn_dir,
 				  struct kernfs_node *kn);
 int security_file_permission(struct file *file, int mask);
@@ -980,7 +980,7 @@ static inline int security_kernfs_init_security(struct kernfs_node *kn_dir,
 	return 0;
 }
 
-static inline int security_inode_copy_up_xattr(const char *name)
+static inline int security_inode_copy_up_xattr(struct dentry *src, const char *name)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index cc7956d7878b..2555aa4501ae 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -896,7 +896,7 @@ void evm_inode_post_setattr(struct dentry *dentry, int ia_valid)
 		evm_update_evmxattr(dentry, NULL, NULL, 0);
 }
 
-int evm_inode_copy_up_xattr(const char *name)
+int evm_inode_copy_up_xattr(struct dentry *src, const char *name)
 {
 	if (strcmp(name, XATTR_NAME_EVM) == 0)
 		return 1; /* Discard */
diff --git a/security/security.c b/security/security.c
index 0144a98d3712..ee63863c1dc0 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2596,6 +2596,7 @@ EXPORT_SYMBOL(security_inode_copy_up);
 
 /**
  * security_inode_copy_up_xattr() - Filter xattrs in an overlayfs copy-up op
+ * @src: union dentry of copy-up file
  * @name: xattr name
  *
  * Filter the xattrs being copied up when a unioned file is copied up from a
@@ -2606,7 +2607,7 @@ EXPORT_SYMBOL(security_inode_copy_up);
  *         if the security module does not know about attribute, or a negative
  *         error code to abort the copy up.
  */
-int security_inode_copy_up_xattr(const char *name)
+int security_inode_copy_up_xattr(struct dentry *src, const char *name)
 {
 	struct security_hook_list *hp;
 	int rc;
@@ -2618,12 +2619,12 @@ int security_inode_copy_up_xattr(const char *name)
 	 */
 	hlist_for_each_entry(hp,
 			     &security_hook_heads.inode_copy_up_xattr, list) {
-		rc = hp->hook.inode_copy_up_xattr(name);
+		rc = hp->hook.inode_copy_up_xattr(src, name);
 		if (rc != LSM_RET_DEFAULT(inode_copy_up_xattr))
 			return rc;
 	}
 
-	return evm_inode_copy_up_xattr(name);
+	return evm_inode_copy_up_xattr(src, name);
 }
 EXPORT_SYMBOL(security_inode_copy_up_xattr);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index a6bf90ace84c..ebb8876837c6 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3530,7 +3530,7 @@ static int selinux_inode_copy_up(struct dentry *src, struct cred **new)
 	return 0;
 }
 
-static int selinux_inode_copy_up_xattr(const char *name)
+static int selinux_inode_copy_up_xattr(struct dentry *dentry, const char *name)
 {
 	/* The copy_up hook above sets the initial context on an inode, but we
 	 * don't then want to overwrite it by blindly copying all the lower
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 0fdbf04cc258..bffca165f07f 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4873,7 +4873,7 @@ static int smack_inode_copy_up(struct dentry *dentry, struct cred **new)
 	return 0;
 }
 
-static int smack_inode_copy_up_xattr(const char *name)
+static int smack_inode_copy_up_xattr(struct dentry *src, const char *name)
 {
 	/*
 	 * Return 1 if this is the smack access Smack attribute.
-- 
2.43.0


