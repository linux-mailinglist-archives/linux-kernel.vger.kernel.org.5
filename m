Return-Path: <linux-kernel+bounces-5280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6578A8188E8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D25891F2553D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E771C288;
	Tue, 19 Dec 2023 13:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Be6SlkjU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB851BDF3;
	Tue, 19 Dec 2023 13:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJBhEDk011557;
	Tue, 19 Dec 2023 13:49:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=NPjpiQqB/XwG2kL1albQJVZXEm834TnGuqtZmfnSItE=;
 b=Be6SlkjUf5kODr8yxPcDnOOC93iT9yZsPnrMaZyLTdBB4wzAhr5c109DFvNb5EGy6Spk
 23tXQyY7Dsz66jfF6IRtKFdNoVrtIlveb3XZ2cyc1sziaDgLZNHWptBtYAbyUOHZl7JO
 SO/xN34Sk7RwS26uSrEVo89mEhTUuMukLFd3aC+pYQ/FoAeeOONkjzAhQ/2l5P+YMOWr
 mVIJmXVrIdS4qTJrc/tYOqV6qYGpeGi3AYoFkUkCr9euCKd5grYyOKZRywSwfjqMWlXn
 WH3rhuGYkvUzS0ngfZtYGe3s3uZmDyXMJP7tsxUpd5VvX5xJ+bB4vJnHXtd5gAUoza/C jw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v3ahwk6tc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 13:49:36 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BJDAhpO008831;
	Tue, 19 Dec 2023 13:49:35 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v3ahwk6t4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 13:49:35 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJC759L029712;
	Tue, 19 Dec 2023 13:49:35 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3v1p7sg7kp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 13:49:34 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BJDnXd945023970
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 13:49:33 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4503320043;
	Tue, 19 Dec 2023 13:49:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6415A2004B;
	Tue, 19 Dec 2023 13:49:31 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.61.183.131])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 Dec 2023 13:49:31 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-unionfs@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>
Subject: [PATCH 2/2] evm: add support to disable EVM on unsupported filesystems
Date: Tue, 19 Dec 2023 08:49:01 -0500
Message-Id: <20231219134901.96300-3-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231219134901.96300-1-zohar@linux.ibm.com>
References: <20231219134901.96300-1-zohar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: r9Lni6yzcpPQwkP24dn2sm7-qa8qBnGT
X-Proofpoint-ORIG-GUID: c1n8usABbRrfBGRCvFWMf_kvc_FtTNuA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-19_08,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 spamscore=0
 phishscore=0 mlxscore=0 impostorscore=0 mlxlogscore=633 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312190103

Don't verify, write, remove or update 'security.evm' on unsupported
filesystems.

Temporarily define overlayfs as an unsupported filesystem until
a complete solution is developed.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/evm/evm_main.c | 35 ++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 02adba635b02..aa6d32a07d20 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -151,6 +151,17 @@ static int evm_find_protected_xattrs(struct dentry *dentry)
 	return count;
 }
 
+static int is_unsupported_fs(struct dentry *dentry)
+{
+	struct inode *inode = d_backing_inode(dentry);
+
+	if (strcmp(inode->i_sb->s_type->name, "overlay") == 0) {
+		pr_info_once("overlayfs not supported\n");
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


