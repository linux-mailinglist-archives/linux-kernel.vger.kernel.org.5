Return-Path: <linux-kernel+bounces-78834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D422861983
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0AF11C23C69
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534D3140376;
	Fri, 23 Feb 2024 17:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CxQZ/2R9"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194B61339B0;
	Fri, 23 Feb 2024 17:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708709146; cv=none; b=WEkEzKWSQXDKy71q63P9nwsik1oVq6BR0cWVXvXJXNVGNcP/Jdrr/BGk025pUFjLXCOVYpHkkKWmGNUfid5xLFn7qXy3qM119yb2h9w3TQ/YfkJmBHBAYK5AWXYJe2j8DOUJI2pg6LPH2KWme2M5fhEbUEniU3l/jNKoVrm8/Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708709146; c=relaxed/simple;
	bh=3McHf+8Oydf7tmLHs1XHb0QiBubKlhMTGhJTYPeUKzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GxLKLkfWnbD4HZSzmk46BIrVsNXC5yoOPJVXbbXwl/OXlHQlJVZHN0v0rwCeNd8lEDFHb/+QNxu5xQHsE5JuYs7xpDfYMT1xORVktx/79V6gzeaO72lwcFfFHCLLBK1O2PqtYv2OVMuDY9kX4vIIRqzrofzhr89QxlqEiW0kxas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CxQZ/2R9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41NHMMlR026968;
	Fri, 23 Feb 2024 17:25:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=PTFPe5c6QXZuJE89UosKsmiENdqTI0MPlrHEXhBA6LI=;
 b=CxQZ/2R92Tfi98sipsE9aW64T2SK0O/F8bnZoOJM5B++Q9P9OMymusMgtSI4vXWMxaJ+
 ecw7KugijWhHQXg7JM2gYessYYgBrcv0W4SO+oneG2eSXr3ZCYjXxPgO3csVBObJ2Ptr
 yUaBwFa68sODAQZSLB9DDgNYV/NFjmtX00kCWe54NDXZcLffYTecxR+S9utrrypTBNP4
 xrDookELz/NEW/BJwCHEq1SuSs71LZRmVfkbzKB2s+iqwbeQUx34DjWt91c2ePy2SyCV
 Bhq6SA1d/Dlppnq4dmnuS+BDM//jmJ6kxpcWQ9r916nX4tUnDAXMFPlwJnwtyPD8F8fU GQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3weypt83qq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 17:25:31 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41NHMdWb027623;
	Fri, 23 Feb 2024 17:25:30 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3weypt83pb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 17:25:30 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41NGDXxs013532;
	Fri, 23 Feb 2024 17:25:29 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb7h0y3u4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 17:25:29 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41NHPPQB17367702
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 17:25:27 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7538B58043;
	Fri, 23 Feb 2024 17:25:25 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4942458059;
	Fri, 23 Feb 2024 17:25:24 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Feb 2024 17:25:24 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, zohar@linux.ibm.com, roberto.sassu@huawei.com,
        amir73il@gmail.com, brauner@kernel.org, miklos@szeredi.hu,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 06/10] evm: Store and detect metadata inode attributes changes
Date: Fri, 23 Feb 2024 12:25:09 -0500
Message-ID: <20240223172513.4049959-7-stefanb@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: e_QrGgerAJUVMuykYqcHw0goeNliW3w-
X-Proofpoint-GUID: KdMqPSLvVlyuwRUn_7e2mInceBcH8qMX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_03,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 impostorscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402230127

On stacked filesystem the metadata inode may be different than the one
file data inode and therefore changes to it need to be detected
independently. Therefore, store the i_version, device number, and inode
number associated with the file metadata inode.

Implement a function to detect changes to the inode and if a change is
detected reset the evm_status. This function will be called by IMA when
IMA detects that the metadata inode is different from the file's inode.

Co-developed-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 include/linux/evm.h                 |  8 ++++++++
 security/integrity/evm/evm.h        |  6 ++++--
 security/integrity/evm/evm_crypto.c | 23 ++++++++++++++++------
 security/integrity/evm/evm_main.c   | 30 +++++++++++++++++++++++++++--
 4 files changed, 57 insertions(+), 10 deletions(-)

diff --git a/include/linux/evm.h b/include/linux/evm.h
index d48d6da32315..ddece4a6b25d 100644
--- a/include/linux/evm.h
+++ b/include/linux/evm.h
@@ -26,6 +26,8 @@ extern int evm_protected_xattr_if_enabled(const char *req_xattr_name);
 extern int evm_read_protected_xattrs(struct dentry *dentry, u8 *buffer,
 				     int buffer_size, char type,
 				     bool canonical_fmt);
+extern bool evm_metadata_changed(struct inode *inode,
+				 struct inode *metadata_inode);
 #ifdef CONFIG_FS_POSIX_ACL
 extern int posix_xattr_acl(const char *xattrname);
 #else
@@ -76,5 +78,11 @@ static inline int evm_read_protected_xattrs(struct dentry *dentry, u8 *buffer,
 	return -EOPNOTSUPP;
 }
 
+static inline bool evm_metadata_changed(struct inode *inode,
+					struct inode *metadata_inode)
+{
+	return false;
+}
+
 #endif /* CONFIG_EVM */
 #endif /* LINUX_EVM_H */
diff --git a/security/integrity/evm/evm.h b/security/integrity/evm/evm.h
index eb1a2c343bd7..b357c0ca8d23 100644
--- a/security/integrity/evm/evm.h
+++ b/security/integrity/evm/evm.h
@@ -39,6 +39,7 @@ struct xattr_list {
 struct evm_iint_cache {
 	unsigned long flags;
 	enum integrity_status evm_status:4;
+	struct integrity_inode_attributes metadata_inode;
 };
 
 extern struct lsm_blob_sizes evm_blob_sizes;
@@ -74,11 +75,12 @@ int evm_update_evmxattr(struct dentry *dentry,
 			size_t req_xattr_value_len);
 int evm_calc_hmac(struct dentry *dentry, const char *req_xattr_name,
 		  const char *req_xattr_value,
-		  size_t req_xattr_value_len, struct evm_digest *data);
+		  size_t req_xattr_value_len, struct evm_digest *data,
+		  struct evm_iint_cache *iint);
 int evm_calc_hash(struct dentry *dentry, const char *req_xattr_name,
 		  const char *req_xattr_value,
 		  size_t req_xattr_value_len, char type,
-		  struct evm_digest *data);
+		  struct evm_digest *data, struct evm_iint_cache *iint);
 int evm_init_hmac(struct inode *inode, const struct xattr *xattrs,
 		  char *hmac_val);
 int evm_init_secfs(void);
diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index 35416f55391c..7c06ffd633d2 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -221,7 +221,8 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
 				 const char *req_xattr_name,
 				 const char *req_xattr_value,
 				 size_t req_xattr_value_len,
-				 uint8_t type, struct evm_digest *data)
+				 uint8_t type, struct evm_digest *data,
+				 struct evm_iint_cache *iint)
 {
 	struct inode *inode = d_inode(d_real(dentry, D_REAL_METADATA));
 	struct xattr_list *xattr;
@@ -231,6 +232,7 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
 	int error;
 	int size, user_space_size;
 	bool ima_present = false;
+	u64 i_version = 0;
 
 	if (!(inode->i_opflags & IOP_XATTR) ||
 	    inode->i_sb->s_user_ns != &init_user_ns)
@@ -294,6 +296,13 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
 	}
 	hmac_add_misc(desc, inode, type, data->digest);
 
+	if (inode != d_backing_inode(dentry) && iint) {
+		if (IS_I_VERSION(inode))
+			i_version = inode_query_iversion(inode);
+		integrity_inode_attrs_store(&iint->metadata_inode, i_version,
+					    inode);
+	}
+
 	/* Portable EVM signatures must include an IMA hash */
 	if (type == EVM_XATTR_PORTABLE_DIGSIG && !ima_present)
 		error = -EPERM;
@@ -305,18 +314,19 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
 
 int evm_calc_hmac(struct dentry *dentry, const char *req_xattr_name,
 		  const char *req_xattr_value, size_t req_xattr_value_len,
-		  struct evm_digest *data)
+		  struct evm_digest *data, struct evm_iint_cache *iint)
 {
 	return evm_calc_hmac_or_hash(dentry, req_xattr_name, req_xattr_value,
-				    req_xattr_value_len, EVM_XATTR_HMAC, data);
+				    req_xattr_value_len, EVM_XATTR_HMAC, data,
+				    iint);
 }
 
 int evm_calc_hash(struct dentry *dentry, const char *req_xattr_name,
 		  const char *req_xattr_value, size_t req_xattr_value_len,
-		  char type, struct evm_digest *data)
+		  char type, struct evm_digest *data, struct evm_iint_cache *iint)
 {
 	return evm_calc_hmac_or_hash(dentry, req_xattr_name, req_xattr_value,
-				     req_xattr_value_len, type, data);
+				     req_xattr_value_len, type, data, iint);
 }
 
 static int evm_is_immutable(struct dentry *dentry, struct inode *inode)
@@ -357,6 +367,7 @@ int evm_update_evmxattr(struct dentry *dentry, const char *xattr_name,
 			const char *xattr_value, size_t xattr_value_len)
 {
 	struct inode *inode = d_backing_inode(dentry);
+	struct evm_iint_cache *iint = evm_iint_inode(inode);
 	struct evm_digest data;
 	int rc = 0;
 
@@ -372,7 +383,7 @@ int evm_update_evmxattr(struct dentry *dentry, const char *xattr_name,
 
 	data.hdr.algo = HASH_ALGO_SHA1;
 	rc = evm_calc_hmac(dentry, xattr_name, xattr_value,
-			   xattr_value_len, &data);
+			   xattr_value_len, &data, iint);
 	if (rc == 0) {
 		data.hdr.xattr.sha1.type = EVM_XATTR_HMAC;
 		rc = __vfs_setxattr_noperm(&nop_mnt_idmap, dentry,
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index c658d2f1494b..c1ca0894cd8a 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -226,7 +226,7 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 
 		digest.hdr.algo = HASH_ALGO_SHA1;
 		rc = evm_calc_hmac(dentry, xattr_name, xattr_value,
-				   xattr_value_len, &digest);
+				   xattr_value_len, &digest, iint);
 		if (rc)
 			break;
 		rc = crypto_memneq(xattr_data->data, digest.digest,
@@ -247,7 +247,8 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 		hdr = (struct signature_v2_hdr *)xattr_data;
 		digest.hdr.algo = hdr->hash_algo;
 		rc = evm_calc_hash(dentry, xattr_name, xattr_value,
-				   xattr_value_len, xattr_data->type, &digest);
+				   xattr_value_len, xattr_data->type, &digest,
+				   iint);
 		if (rc)
 			break;
 		rc = integrity_digsig_verify(INTEGRITY_KEYRING_EVM,
@@ -733,6 +734,31 @@ static void evm_reset_status(struct inode *inode)
 		iint->evm_status = INTEGRITY_UNKNOWN;
 }
 
+/**
+ * evm_metadata_changed: Detect changes to the metadata
+ * @inode: a file's inode
+ * @metadata_inode: metadata inode
+ *
+ * On a stacked filesystem detect whether the metadata has changed. If this is
+ * the case reset the evm_status associated with the inode that represents the
+ * file.
+ */
+bool evm_metadata_changed(struct inode *inode, struct inode *metadata_inode)
+{
+	struct evm_iint_cache *iint = evm_iint_inode(inode);
+	bool ret = false;
+
+	if (iint) {
+		ret = (!IS_I_VERSION(metadata_inode) ||
+		       integrity_inode_attrs_changed(&iint->metadata_inode,
+						     metadata_inode));
+		if (ret)
+			iint->evm_status = INTEGRITY_UNKNOWN;
+	}
+
+	return ret;
+}
+
 /**
  * evm_revalidate_status - report whether EVM status re-validation is necessary
  * @xattr_name: pointer to the affected extended attribute name
-- 
2.43.0


