Return-Path: <linux-kernel+bounces-53206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6ED984A232
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ED67285E73
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340324E1D8;
	Mon,  5 Feb 2024 18:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gfVBOY8s"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD9847F7B;
	Mon,  5 Feb 2024 18:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707157537; cv=none; b=JHZMUJMp0Cm752GbO4FmVcpp4LKzL+vPhi9DBVmmcigiIUhWPEGyIWWZeEJJpKLMxGBGxw9QPANxz1aQ8TnxDwvRYrs2AmA/zpIFHNBOX9HB+2kscYnvNRQtAm6CBfqJY6dhvrXyzhoieDz5ZfIzNQo9mxd96lJyWursAlMOQKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707157537; c=relaxed/simple;
	bh=x2BpIzDCTA5gJB6kMFv8RaiYSc+FcFrtbPtoz4OrdK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m6AKBXF4Ly5h4SrDwaiBfjtisI1H+JRtRvDWYJefzQR13zFhFejYXP3TtbSTm5rO51ZV+oErncgUa7L7tsbaqug61+7eFgqEbMab0O9cZHFax3IXwDIw/Q9uQzsYrPTDPxnoZ361MKfGK7qdV+fDQK7z4DsWWar2dK4b02K1hJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gfVBOY8s; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 415H72C5022720;
	Mon, 5 Feb 2024 18:25:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Ie1ZSAlR+WviS8YeL/P1c0yGICubqDOWwlPuMMw9jvE=;
 b=gfVBOY8s06WF0/h7fZs/vhJf2J0dmcSLobsWdoH9gozpdmnfgZCUrRmpgZXJuSL8blhe
 MBeNo9xKF8v6LrhCEZoaq/GUmNI/8RRadhktcCgIb19EKqBtt45UTVSO6VaueZiENXr1
 SJJ/YrCiUM8/yWmOwDq43RAFeOY39BlUpeJL4yMxBPPcdTSmH04N5DBoy//q9QUkVkDN
 tlD9AjXHTZpsMS1TqAeRdKquELYhII/FTuD6tFG0aLlTd6d0i/603hml9dHdUqfawl/K
 N8FOvRqJlDI2kZlxJKIEibLg3Mk7ohrpwPiFwe6FW1znLWzHGGyUifKb6yd0asJSbapn TA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w337cjx7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 18:25:18 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 415IPIVM015272;
	Mon, 5 Feb 2024 18:25:18 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w337cjx7m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 18:25:18 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 415IEACK016184;
	Mon, 5 Feb 2024 18:25:17 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w22h1sprm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 18:25:17 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 415IPGB59306752
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Feb 2024 18:25:16 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C152D5805A;
	Mon,  5 Feb 2024 18:25:16 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1FE115803F;
	Mon,  5 Feb 2024 18:25:16 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Feb 2024 18:25:16 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, zohar@linux.ibm.com, roberto.sassu@huawei.com,
        amir73il@gmail.com, brauner@kernel.org, miklos@szeredi.hu,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 8/9] evm: Rename is_unsupported_fs to is_unsupported_hmac_fs
Date: Mon,  5 Feb 2024 13:25:05 -0500
Message-ID: <20240205182506.3569743-9-stefanb@linux.ibm.com>
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
X-Proofpoint-GUID: tms3g3KiXmdecrx21yUhCa1yy3rhtfca
X-Proofpoint-ORIG-GUID: s1N8ONChkqho900xKGRrODRkebI1L0ZX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_12,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=755 priorityscore=1501
 spamscore=0 phishscore=0 mlxscore=0 clxscore=1015 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402050138

Rename is_unsupported_fs to is_unsupported_hmac_fs since only HMAC is
unsupported now on certain filesystems.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 security/integrity/evm/evm_main.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index ff659e622f4a..60ca7e9713ca 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -151,7 +151,7 @@ static int evm_find_protected_xattrs(struct dentry *dentry)
 	return count;
 }
 
-static int is_unsupported_fs(struct dentry *dentry)
+static int is_unsupported_hmac_fs(struct dentry *dentry)
 {
 	struct inode *inode = d_backing_inode(dentry);
 
@@ -196,7 +196,8 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 	 * On unsupported filesystems with EVM_INIT_X509 not enabled, skip
 	 * signature verification.
 	 */
-	if (!(evm_initialized & EVM_INIT_X509) && is_unsupported_fs(dentry))
+	if (!(evm_initialized & EVM_INIT_X509) &&
+	    is_unsupported_hmac_fs(dentry))
 		return INTEGRITY_UNKNOWN;
 
 	/* if status is not PASS, try to check again - against -ENOMEM */
@@ -267,7 +268,7 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 			} else if (!IS_RDONLY(inode) &&
 				   !(inode->i_sb->s_readonly_remount) &&
 				   !IS_IMMUTABLE(inode) &&
-				   !is_unsupported_fs(dentry)) {
+				   !is_unsupported_hmac_fs(dentry)) {
 				evm_update_evmxattr(dentry, xattr_name,
 						    xattr_value,
 						    xattr_value_len);
@@ -510,12 +511,12 @@ static int evm_protect_xattr(struct mnt_idmap *idmap,
 	if (strcmp(xattr_name, XATTR_NAME_EVM) == 0) {
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
-		if (is_unsupported_fs(dentry))
+		if (is_unsupported_hmac_fs(dentry))
 			return -EPERM;
 	} else if (!evm_protected_xattr(xattr_name)) {
 		if (!posix_xattr_acl(xattr_name))
 			return 0;
-		if (is_unsupported_fs(dentry))
+		if (is_unsupported_hmac_fs(dentry))
 			return 0;
 
 		evm_status = evm_verify_current_integrity(dentry);
@@ -523,7 +524,7 @@ static int evm_protect_xattr(struct mnt_idmap *idmap,
 		    (evm_status == INTEGRITY_NOXATTRS))
 			return 0;
 		goto out;
-	} else if (is_unsupported_fs(dentry))
+	} else if (is_unsupported_hmac_fs(dentry))
 		return 0;
 
 	evm_status = evm_verify_current_integrity(dentry);
@@ -782,7 +783,7 @@ void evm_inode_post_setxattr(struct dentry *dentry, const char *xattr_name,
 	if (!(evm_initialized & EVM_INIT_HMAC))
 		return;
 
-	if (is_unsupported_fs(dentry))
+	if (is_unsupported_hmac_fs(dentry))
 		return;
 
 	evm_update_evmxattr(dentry, xattr_name, xattr_value, xattr_value_len);
@@ -849,7 +850,7 @@ int evm_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (evm_initialized & EVM_ALLOW_METADATA_WRITES)
 		return 0;
 
-	if (is_unsupported_fs(dentry))
+	if (is_unsupported_hmac_fs(dentry))
 		return 0;
 
 	if (!(ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID)))
@@ -898,7 +899,7 @@ void evm_inode_post_setattr(struct dentry *dentry, int ia_valid)
 	if (!(evm_initialized & EVM_INIT_HMAC))
 		return;
 
-	if (is_unsupported_fs(dentry))
+	if (is_unsupported_hmac_fs(dentry))
 		return;
 
 	if (ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID))
-- 
2.43.0


