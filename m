Return-Path: <linux-kernel+bounces-78840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDECD861998
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DB5D1C2536A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B709A14264B;
	Fri, 23 Feb 2024 17:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qxK6KSA/"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520961420B9;
	Fri, 23 Feb 2024 17:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708709151; cv=none; b=OgAQc/zDpAzLR2QUwkPB9dOp+XVVoQq/iF8aFAvM5esAcA8rB17ui+2EcMjBKCYcnD0AIBwz9IIp8s9E+iOmuOpCpC1QYl0MgteVMAg3ffW4QgE1vu0ZwbLXOz8Uo34xrnsKGkiHvIAeQ0I03U84n9MErH5H0fuMoetLISRkQxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708709151; c=relaxed/simple;
	bh=qk6eBYdSaq73cHdPreSkg58GdcRTMI+QfYmaEAb1hq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S2fzBfVoxQX8cq9DXuPvvYTvt6nR5W6YLEyyD/cq/VDq84S9c7Q+pr9H+IPBvI8zpA4b1dXA3p3fpEU/ktkcpviQsbVEh/QBZB842V5gb5j96VRPKhRmZqszj25DxzKCsXJzsB7LVssGrMZHhd6l9x7cVYQGmzqexLnUnBjjZmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qxK6KSA/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41NHML2q026892;
	Fri, 23 Feb 2024 17:25:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=r0c/Ergx/iiTnS5WKbLktdb0Si4+5T+37n2KsEAQEJo=;
 b=qxK6KSA/f007PFOmzcifvEVvU2R8EDYynlP/ggf4b79NlGEOwbJ+R8lEGnvhlWpjHNh/
 4RyJT19IeslrC37ZU1j3JREk3O3OuRbRPPdHK2wFuTYJ44NBPpOPZQT4qOxLijxVMTyU
 lFq5H0iA2EPeqE4e3OEatYdq0De26QBuEHbaBYr/FRpZ4AAifzP6LyUp7MzAozy1fqnw
 FMWFrpQifE99UofIYqnLREwLdWKhd0qfrhvgvcpOXvack1Lovs/vUWubp02DI7A39cbL
 HZMYcmL7qZcn/c07gQ9KHKzkPObYcD0xURHN7sMUpC8I7Q5Hnu2e2TIaoe3bYO3vWtFc 6w== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3weypt83ts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 17:25:35 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41NHN2ww028956;
	Fri, 23 Feb 2024 17:25:35 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3weypt83t5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 17:25:35 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41NGObFe003624;
	Fri, 23 Feb 2024 17:25:34 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wb74u757a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 17:25:34 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41NHPUv517171062
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 17:25:32 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A0B1D58063;
	Fri, 23 Feb 2024 17:25:30 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7FFED5805F;
	Fri, 23 Feb 2024 17:25:29 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Feb 2024 17:25:29 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, zohar@linux.ibm.com, roberto.sassu@huawei.com,
        amir73il@gmail.com, brauner@kernel.org, miklos@szeredi.hu,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 10/10] evm: Rename is_unsupported_fs to is_unsupported_hmac_fs
Date: Fri, 23 Feb 2024 12:25:13 -0500
Message-ID: <20240223172513.4049959-11-stefanb@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: OXDLETSYEaOt9t0APn-B5SYmICmm8cDJ
X-Proofpoint-GUID: yZQAG4jeRKOtD9wsID-ZKZDzfGYRi8E9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_03,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=798 spamscore=0 impostorscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402230127

Rename is_unsupported_fs to is_unsupported_hmac_fs since now only HMAC is
unsupported.

Co-developed-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 security/integrity/evm/evm_main.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index c4a6081ce596..62fe66dd53ce 100644
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
 	 * On unsupported filesystems without EVM_INIT_X509 enabled, skip
 	 * signature verification.
 	 */
-	if (!(evm_initialized & EVM_INIT_X509) && is_unsupported_fs(dentry))
+	if (!(evm_initialized & EVM_INIT_X509) &&
+	    is_unsupported_hmac_fs(dentry))
 		return INTEGRITY_UNKNOWN;
 
 	/* if status is not PASS, try to check again - against -ENOMEM */
@@ -266,7 +267,7 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 			} else if (!IS_RDONLY(inode) &&
 				   !(inode->i_sb->s_readonly_remount) &&
 				   !IS_IMMUTABLE(inode) &&
-				   !is_unsupported_fs(dentry)) {
+				   !is_unsupported_hmac_fs(dentry)) {
 				evm_update_evmxattr(dentry, xattr_name,
 						    xattr_value,
 						    xattr_value_len);
@@ -502,12 +503,12 @@ static int evm_protect_xattr(struct mnt_idmap *idmap,
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
@@ -515,7 +516,7 @@ static int evm_protect_xattr(struct mnt_idmap *idmap,
 		    (evm_status == INTEGRITY_NOXATTRS))
 			return 0;
 		goto out;
-	} else if (is_unsupported_fs(dentry))
+	} else if (is_unsupported_hmac_fs(dentry))
 		return 0;
 
 	evm_status = evm_verify_current_integrity(dentry);
@@ -817,7 +818,7 @@ static void evm_inode_post_setxattr(struct dentry *dentry,
 	if (!(evm_initialized & EVM_INIT_HMAC))
 		return;
 
-	if (is_unsupported_fs(dentry))
+	if (is_unsupported_hmac_fs(dentry))
 		return;
 
 	evm_update_evmxattr(dentry, xattr_name, xattr_value, xattr_value_len);
@@ -916,7 +917,7 @@ static int evm_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (evm_initialized & EVM_ALLOW_METADATA_WRITES)
 		return 0;
 
-	if (is_unsupported_fs(dentry))
+	if (is_unsupported_hmac_fs(dentry))
 		return 0;
 
 	if (!(ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID)))
@@ -967,7 +968,7 @@ static void evm_inode_post_setattr(struct mnt_idmap *idmap,
 	if (!(evm_initialized & EVM_INIT_HMAC))
 		return;
 
-	if (is_unsupported_fs(dentry))
+	if (is_unsupported_hmac_fs(dentry))
 		return;
 
 	if (ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID))
-- 
2.43.0


