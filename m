Return-Path: <linux-kernel+bounces-78837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C98E386198F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30041B26F56
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B132C141980;
	Fri, 23 Feb 2024 17:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="adJO34xO"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53D313DBAC;
	Fri, 23 Feb 2024 17:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708709147; cv=none; b=AaBENgbp1l0nmi1ZaL7Wp2e79Yq1T5D0xMG900bYer9KkgrRenPpmHTKPxw1ndvmsoprTqjIGkYj77ul/JIV0JdaMdjS75sZvYhDfNvqpqZYXw1o6IPTfI7W/oa4kEgCkrrO4HqHNa3HTN8C4IQO6tJrQQNB+OQHUlPHGyNtf2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708709147; c=relaxed/simple;
	bh=c5koPI2duiiIjfLt3UPjDSudsH+SR7VddfBtj1u6hlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ieg0UqRPWXKqUG9gIHQ7rL5cx7C4mUGbhYCTYBa2/bbKobrqHBzJknyL+x4FcakLOAsBYqevNM09McB2vY0eyHystgy37Vqgl074Qyju+uZQ+D0UumTaynJ0AzXKcAIzyxgg2jWQOb1ctyjeH3IkD5HTONqIwk7gP9QX6/eQ/KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=adJO34xO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41NHHSDW021956;
	Fri, 23 Feb 2024 17:25:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=CusroZQmCdII/hHrH+Jv6nGMmvnOvekxQ90ggrfTLqE=;
 b=adJO34xOPOvYrw1VBXO1F67pbBcWzyKi1Tz8ISULJCmWZvfRHoyEFQOTubRJW5D4r9PZ
 Ko8V+GVG6fktFEY4HR8cnpjeaGQ/4HJt52OAkMp1ryyawTI91huZ/7qFsB8rJ7XLFjUZ
 FY8HfB33LXPoKncXET7DX4XmhDNyDc8ZbRnJeVSYEwTt5tMJImH7An7nWpWVI+iW09Pj
 uATrHqeVmBnUu8grlyLf/lZ96aj9KhDEHi08eZOoQBFpisYHdxiZ3h0DjFTpnZ3viFOy
 b4FqbjoDE+97NE+8JAXayYiaeKcxHRYjRP0zV1TaOyAHzGtv2BeQjEpSkFzfHOyBqOJa Bw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3weymgg7gm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 17:25:24 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41NHHgFd022279;
	Fri, 23 Feb 2024 17:25:24 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3weymgg7g7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 17:25:24 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41NHALS6017307;
	Fri, 23 Feb 2024 17:25:23 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb8mmxqvx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 17:25:23 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41NHPK5f26083880
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 17:25:22 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 33BF558043;
	Fri, 23 Feb 2024 17:25:20 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 10D565805D;
	Fri, 23 Feb 2024 17:25:19 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Feb 2024 17:25:18 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, zohar@linux.ibm.com, roberto.sassu@huawei.com,
        amir73il@gmail.com, brauner@kernel.org, miklos@szeredi.hu,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 02/10] security: allow finer granularity in permitting copy-up of security xattrs
Date: Fri, 23 Feb 2024 12:25:05 -0500
Message-ID: <20240223172513.4049959-3-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240223172513.4049959-1-stefanb@linux.ibm.com>
References: <20240223172513.4049959-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OTW2zZhc-uoOo01f4N81ZBXs2utqLG0w
X-Proofpoint-GUID: 4QbLBXqqGLouXFjXlLjpilvGTHlKk3_4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_03,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 mlxlogscore=677 mlxscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402230127

Copying up xattrs is solely based on the security xattr name. For finer
granularity add a dentry parameter to the security_inode_copy_up_xattr
hook definition, allowing decisions to be based on the xattr content as
well.

Co-developed-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Acked-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/copy_up.c            | 2 +-
 include/linux/lsm_hook_defs.h     | 3 ++-
 include/linux/security.h          | 4 ++--
 security/integrity/evm/evm_main.c | 2 +-
 security/security.c               | 5 +++--
 security/selinux/hooks.c          | 2 +-
 security/smack/smack_lsm.c        | 2 +-
 7 files changed, 11 insertions(+), 9 deletions(-)

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
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 7e4683035d34..c538d39dd9a9 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -176,7 +176,8 @@ LSM_HOOK(int, 0, inode_listsecurity, struct inode *inode, char *buffer,
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
index 8436f9abf43d..2553a4f4b726 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -397,7 +397,7 @@ int security_inode_setsecurity(struct inode *inode, const char *name, const void
 int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size);
 void security_inode_getsecid(struct inode *inode, u32 *secid);
 int security_inode_copy_up(struct dentry *src, struct cred **new);
-int security_inode_copy_up_xattr(const char *name);
+int security_inode_copy_up_xattr(struct dentry *src, const char *name);
 int security_kernfs_init_security(struct kernfs_node *kn_dir,
 				  struct kernfs_node *kn);
 int security_file_permission(struct file *file, int mask);
@@ -1015,7 +1015,7 @@ static inline int security_kernfs_init_security(struct kernfs_node *kn_dir,
 	return 0;
 }
 
-static inline int security_inode_copy_up_xattr(const char *name)
+static inline int security_inode_copy_up_xattr(struct dentry *src, const char *name)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 81dbade5b9b3..b0a862bfd74a 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -946,7 +946,7 @@ static void evm_inode_post_setattr(struct mnt_idmap *idmap,
 		evm_update_evmxattr(dentry, NULL, NULL, 0);
 }
 
-static int evm_inode_copy_up_xattr(const char *name)
+static int evm_inode_copy_up_xattr(struct dentry *src, const char *name)
 {
 	if (strcmp(name, XATTR_NAME_EVM) == 0)
 		return 1; /* Discard */
diff --git a/security/security.c b/security/security.c
index b95772333d05..8d8b89e6b5d9 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2622,6 +2622,7 @@ EXPORT_SYMBOL(security_inode_copy_up);
 
 /**
  * security_inode_copy_up_xattr() - Filter xattrs in an overlayfs copy-up op
+ * @src: union dentry of copy-up file
  * @name: xattr name
  *
  * Filter the xattrs being copied up when a unioned file is copied up from a
@@ -2632,7 +2633,7 @@ EXPORT_SYMBOL(security_inode_copy_up);
  *         if the security module does not know about attribute, or a negative
  *         error code to abort the copy up.
  */
-int security_inode_copy_up_xattr(const char *name)
+int security_inode_copy_up_xattr(struct dentry *src, const char *name)
 {
 	int rc;
 
@@ -2641,7 +2642,7 @@ int security_inode_copy_up_xattr(const char *name)
 	 * xattr), -EOPNOTSUPP if it does not know anything about the xattr or
 	 * any other error code in case of an error.
 	 */
-	rc = call_int_hook(inode_copy_up_xattr, name);
+	rc = call_int_hook(inode_copy_up_xattr, src, name);
 	if (rc != LSM_RET_DEFAULT(inode_copy_up_xattr))
 		return rc;
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index cedb4cbf072e..1d2395d8bba7 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3531,7 +3531,7 @@ static int selinux_inode_copy_up(struct dentry *src, struct cred **new)
 	return 0;
 }
 
-static int selinux_inode_copy_up_xattr(const char *name)
+static int selinux_inode_copy_up_xattr(struct dentry *dentry, const char *name)
 {
 	/* The copy_up hook above sets the initial context on an inode, but we
 	 * don't then want to overwrite it by blindly copying all the lower
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 1b6abfdf7173..972d50e3f266 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4875,7 +4875,7 @@ static int smack_inode_copy_up(struct dentry *dentry, struct cred **new)
 	return 0;
 }
 
-static int smack_inode_copy_up_xattr(const char *name)
+static int smack_inode_copy_up_xattr(struct dentry *src, const char *name)
 {
 	/*
 	 * Return 1 if this is the smack access Smack attribute.
-- 
2.43.0


