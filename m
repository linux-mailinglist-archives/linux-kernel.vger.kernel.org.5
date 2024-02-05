Return-Path: <linux-kernel+bounces-53203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 494B184A222
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F3E61C22E6F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7AB48785;
	Mon,  5 Feb 2024 18:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="O5vvViGP"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864ED47F5B;
	Mon,  5 Feb 2024 18:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707157536; cv=none; b=hr5hl5rT2WwfUc1te86G7SkHxQL67Eu8UDiW1JXl2iMAAc3YIQwePc5468uKsxhcglxG+BAt5sMGWrgXk1pNSnDhLlr2wVozvBQzU6+nIs+p5JGFOFbCsoz58Y+yT+p9wIUafiKGCYmyJ6H7JavIH90M21+LaG3hM9ymLwcYEKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707157536; c=relaxed/simple;
	bh=nRlkemry8e9rHjYY9gTcQk6eiSQkRaEsITgV2GDJt9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EgzHcT7JaX4uBJsfYdToT/Ij+VMYzvu176wfz9syT7iXmgIfbdE9MbDePUExAn3/PqZNDw92G7h99APYmVt3EYiFl9nhmlHLwngzVD+WN9LF0OxdukckOqDeQ3PilcrQynNmdyRlpvjvT6N64YTLHN57X0oM8PWPTTu8wM5nDvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=O5vvViGP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 415IMuE0029996;
	Mon, 5 Feb 2024 18:25:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Wk7V4FTMtJ/XLALgG1N0VoKg1jrLFG4EnJzMMyTwT/Y=;
 b=O5vvViGPJYzjA1y/rwWWJ277Cadevp3rbkQ9VutBDdI+gDyPQvmaiLNih/eZwZdNd8pu
 RRW48ut5chpZkwp7WRuigLN6kzoKsgMNPxqVDerheckSQJvUhBH2eBVwOzzkrpyivIG6
 i6GIHh3wOcLi2nHLJVU0UP9lkL440vxgF4CpbVoyogGcE+SWtfQSNSo8800OXuDDMr1P
 zqN2ruft15vEDnAYFnLcKtxAvjVpWl9HUH1/59tO8fOccmHk9jDbaDeaun3Asol3/yIU
 ccJWUM1DfEIdVixx9MWytfu7icVEMCFRiaES9dYNNpFGKoDxmO3BrBheISat3A8VQqam 7Q== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w34w9r1ee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 18:25:15 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 415IOIqh032731;
	Mon, 5 Feb 2024 18:25:14 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w34w9r1e5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 18:25:14 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 415I4tQ7008515;
	Mon, 5 Feb 2024 18:25:13 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w221jstm8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 18:25:13 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 415IPCN226018352
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Feb 2024 18:25:12 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3FA4D58060;
	Mon,  5 Feb 2024 18:25:12 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 923C15803F;
	Mon,  5 Feb 2024 18:25:11 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Feb 2024 18:25:11 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, zohar@linux.ibm.com, roberto.sassu@huawei.com,
        amir73il@gmail.com, brauner@kernel.org, miklos@szeredi.hu,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 2/9] security: allow finer granularity in permitting copy-up of security xattrs
Date: Mon,  5 Feb 2024 13:24:59 -0500
Message-ID: <20240205182506.3569743-3-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205182506.3569743-1-stefanb@linux.ibm.com>
References: <20240205182506.3569743-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3avXmh77O9GQVyd566ADz_sCPRIzzKN8
X-Proofpoint-GUID: UWtVzI6LjZd_YET8IbMf_kxsMaIEveB3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_12,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxlogscore=557 phishscore=0 spamscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402050138

Copying up xattrs is solely based on the security xattr name. For finer
granularity add a dentry parameter to the security_inode_copy_up_xattr
hook definition, allowing decisions to be based on the xattr content as
well.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 fs/overlayfs/copy_up.c            | 2 +-
 include/linux/evm.h               | 5 +++--
 include/linux/lsm_hook_defs.h     | 3 ++-
 include/linux/security.h          | 4 ++--
 security/integrity/evm/evm_main.c | 2 +-
 security/security.c               | 7 ++++---
 security/selinux/hooks.c          | 2 +-
 security/smack/smack_lsm.c        | 2 +-
 8 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 8586e2f5d243..de20fe9333c0 100644
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
index 36ec884320d9..840ffbdc2860 100644
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
@@ -118,7 +118,8 @@ static inline void evm_inode_post_setxattr(struct dentry *dentry,
 	return;
 }
 
-static inline int  evm_inode_copy_up_xattr(const char *name)
+static inline int evm_inode_copy_up_xattr(struct dentry *dentry,
+					  const char *name)
 {
 	return 0;
 }
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


