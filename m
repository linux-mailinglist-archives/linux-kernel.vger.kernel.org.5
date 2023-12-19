Return-Path: <linux-kernel+bounces-5749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 923D7818F08
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:59:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4942D288098
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF2041765;
	Tue, 19 Dec 2023 17:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MCoWO2iw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8158D4B15A;
	Tue, 19 Dec 2023 17:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJGuba1031658;
	Tue, 19 Dec 2023 17:52:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ubw/02NX+oGg4rMZa0xxhA5je29gZEt2sBM9XgRMLAE=;
 b=MCoWO2iw4rWGNOmjpYa6CeLIGQyM2EOO1a9ujnGTEkp/kS9YRgWV4ObJDPt9vDVFhrwJ
 UegTLZ68Jkj/+gSsVdhIkWacP1MaQ8GVyllHuBgLlCNWe/VrSt2EWpZUENeEun0m4S94
 eu/EaC0Q7m4chH+iiHBytGAMwwm0lImAuBek4wTGwwd1YnhI416xLCIaphdvK6Wmz5J1
 Kntem0cx188GHWiol/RH51zQo2HKPjmjPp2Am2H6OHz/BqHzeldLMAbcmVShX6ursDll
 DSrG895goJHtHCXtk6sYskB4GeCB0dxNhZVl0WKrvnHy5NTvfK5b7GX/t6PYRVpUOuls LA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v3d5u5170-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 17:52:21 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BJGvGt1002295;
	Tue, 19 Dec 2023 17:52:20 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v3d5u516f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 17:52:20 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJGVnNq027074;
	Tue, 19 Dec 2023 17:52:19 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3v1rek14a1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 17:52:19 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BJHqHBH6029852
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 17:52:18 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D4C6820043;
	Tue, 19 Dec 2023 17:52:17 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 19FD420040;
	Tue, 19 Dec 2023 17:52:16 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.61.138.145])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 Dec 2023 17:52:15 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-unionfs@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>
Subject: [PATCH v2 2/3] evm: add support to disable EVM on unsupported filesystems
Date: Tue, 19 Dec 2023 12:52:05 -0500
Message-Id: <20231219175206.12342-3-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231219175206.12342-1-zohar@linux.ibm.com>
References: <20231219175206.12342-1-zohar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sw4cRC9kcEPU8sCeqQ4m2TkoPQ9ytdvT
X-Proofpoint-ORIG-GUID: TUMf6bEFbJlZGUVSGAbqDczSow3KzQnq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-19_10,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxlogscore=755 clxscore=1015
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312190133

Identify EVM unsupported filesystems by defining a new flag
SB_I_EVM_UNSUPPORTED.

Don't verify, write, remove or update 'security.evm' on unsupported
filesystems.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 include/linux/fs.h                |  1 +
 security/integrity/evm/evm_main.c | 35 ++++++++++++++++++++++++++++++-
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 98b7a7a8c42e..db9350a734ef 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1164,6 +1164,7 @@ extern int send_sigurg(struct fown_struct *fown);
 #define SB_I_USERNS_VISIBLE		0x00000010 /* fstype already mounted */
 #define SB_I_IMA_UNVERIFIABLE_SIGNATURE	0x00000020
 #define SB_I_UNTRUSTED_MOUNTER		0x00000040
+#define SB_I_EVM_UNSUPPORTED		0x00000050
 
 #define SB_I_SKIP_SYNC	0x00000100	/* Skip superblock at global sync */
 #define SB_I_PERSB_BDI	0x00000200	/* has a per-sb bdi */
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 02adba635b02..cc7956d7878b 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -151,6 +151,17 @@ static int evm_find_protected_xattrs(struct dentry *dentry)
 	return count;
 }
 
+static int is_unsupported_fs(struct dentry *dentry)
+{
+	struct inode *inode = d_backing_inode(dentry);
+
+	if (inode->i_sb->s_iflags & SB_I_EVM_UNSUPPORTED) {
+		pr_info_once("%s not supported\n", inode->i_sb->s_type->name);
+		return 1;
+	}
+	return 0;
+}
+
 /*
  * evm_verify_hmac - calculate and compare the HMAC with the EVM xattr
  *
@@ -181,6 +192,9 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 		     iint->evm_status == INTEGRITY_PASS_IMMUTABLE))
 		return iint->evm_status;
 
+	if (is_unsupported_fs(dentry))
+		return INTEGRITY_UNKNOWN;
+
 	/* if status is not PASS, try to check again - against -ENOMEM */
 
 	/* first need to know the sig type */
@@ -408,6 +422,9 @@ enum integrity_status evm_verifyxattr(struct dentry *dentry,
 	if (!evm_key_loaded() || !evm_protected_xattr(xattr_name))
 		return INTEGRITY_UNKNOWN;
 
+	if (is_unsupported_fs(dentry))
+		return INTEGRITY_UNKNOWN;
+
 	if (!iint) {
 		iint = integrity_iint_find(d_backing_inode(dentry));
 		if (!iint)
@@ -491,15 +508,21 @@ static int evm_protect_xattr(struct mnt_idmap *idmap,
 	if (strcmp(xattr_name, XATTR_NAME_EVM) == 0) {
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
+		if (is_unsupported_fs(dentry))
+			return -EPERM;
 	} else if (!evm_protected_xattr(xattr_name)) {
 		if (!posix_xattr_acl(xattr_name))
 			return 0;
+		if (is_unsupported_fs(dentry))
+			return 0;
+
 		evm_status = evm_verify_current_integrity(dentry);
 		if ((evm_status == INTEGRITY_PASS) ||
 		    (evm_status == INTEGRITY_NOXATTRS))
 			return 0;
 		goto out;
-	}
+	} else if (is_unsupported_fs(dentry))
+		return 0;
 
 	evm_status = evm_verify_current_integrity(dentry);
 	if (evm_status == INTEGRITY_NOXATTRS) {
@@ -750,6 +773,9 @@ void evm_inode_post_setxattr(struct dentry *dentry, const char *xattr_name,
 	if (!(evm_initialized & EVM_INIT_HMAC))
 		return;
 
+	if (is_unsupported_fs(dentry))
+		return;
+
 	evm_update_evmxattr(dentry, xattr_name, xattr_value, xattr_value_len);
 }
 
@@ -814,8 +840,12 @@ int evm_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (evm_initialized & EVM_ALLOW_METADATA_WRITES)
 		return 0;
 
+	if (is_unsupported_fs(dentry))
+		return 0;
+
 	if (!(ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID)))
 		return 0;
+
 	evm_status = evm_verify_current_integrity(dentry);
 	/*
 	 * Writing attrs is safe for portable signatures, as portable signatures
@@ -859,6 +889,9 @@ void evm_inode_post_setattr(struct dentry *dentry, int ia_valid)
 	if (!(evm_initialized & EVM_INIT_HMAC))
 		return;
 
+	if (is_unsupported_fs(dentry))
+		return;
+
 	if (ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID))
 		evm_update_evmxattr(dentry, NULL, NULL, 0);
 }
-- 
2.39.3


