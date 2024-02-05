Return-Path: <linux-kernel+bounces-53209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D9E84A233
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D8411C23054
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4C84EB29;
	Mon,  5 Feb 2024 18:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sSh/8qFA"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD31482FD;
	Mon,  5 Feb 2024 18:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707157539; cv=none; b=uwYqjy5GdAHuKA03qZ1AwYIziUcTx02IULUI/FJcyt5uVJXyDfw6CNlTIQVYXLbHMUClFk5oH+HgNvMEzgUjkDdlXAJu07Aqd0c51E8oL5caOMvwDuw729JRc7y1brkcOwQ35sC5I3s/6YSd7EkIMa1zNaJ2PNBJZV3ts6KE4Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707157539; c=relaxed/simple;
	bh=BGYKIPoPP5t1acGX1Z4ApwDyNa96J17A48RHUmlhupY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FeivNM0zABj+Zz0MfymaUB4EY7mVX5UUpgymkbxbdSBBc5uAAs8pVHnmWJpWuXYIGWV7Rx0Nv2KRX47EaloBYl+X9UAqMmeVKze57Uz56eE9aO5i9DU33yD602ojHSEnij6OyXkmtXV6oCTJYWw9jtXBej1v3vKV1B4J3gt9zt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sSh/8qFA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 415IMu8i029989;
	Mon, 5 Feb 2024 18:25:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=OZGR2pRbBQotZkC9gUAw8PeTY/6OpLRRrxVMaQ0cwec=;
 b=sSh/8qFAHSwsL9ADWMDkUnjdFz+w5Vsvv6LTJZO9Ta21noanVQn6fqaVZg8UWsv3xq22
 1knPDo+rR0Z0XBViIDhTV01wSMLPiZjU0nCy7cxJgeqhR5+GgaWjcTLR2GbfXNJOZwfo
 9cZtP9C/zqcYdPJ6nhJ4ZAcDPThWUEsvFi2Z8KqiPcVsmVkKNLed97I28RmiiUl0CEFS
 9RGjw6pfZg38fGc2bBycACTf8+BwT1mQmDdNwT1z2EJfigUVr1nUORIHgc5hS89fHcwx
 OLbhjf1CPwh0/znabdvnpI8ZSexVNRfethgfwo2BnWtetMZJY1CzwIu/eqyCJ/uslqEK 4Q== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w34w9r1ff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 18:25:17 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 415IOEM7032494;
	Mon, 5 Feb 2024 18:25:16 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w34w9r1f5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 18:25:16 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 415G7bbY020375;
	Mon, 5 Feb 2024 18:25:16 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w1ytstesw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 18:25:16 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 415IPFPq17105474
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Feb 2024 18:25:15 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4484658056;
	Mon,  5 Feb 2024 18:25:15 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 978D35803F;
	Mon,  5 Feb 2024 18:25:14 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Feb 2024 18:25:14 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, zohar@linux.ibm.com, roberto.sassu@huawei.com,
        amir73il@gmail.com, brauner@kernel.org, miklos@szeredi.hu,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 6/9] evm: Enforce signatures on unsupported filesystem for EVM_INIT_X509
Date: Mon,  5 Feb 2024 13:25:03 -0500
Message-ID: <20240205182506.3569743-7-stefanb@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 33AqcJXDM7ctghzltTK3ljCy-tCVBxAD
X-Proofpoint-GUID: TuhTt_CLfyCB8UVCnWsqbMeCk2tFT6DL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_12,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 mlxlogscore=931 phishscore=0 spamscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402050138

Unsupported filesystems currently do not enforce any signatures. Add
support for signature enforcement of the "original" and "portable &
immutable" signatures when EVM_INIT_X509 is enabled.

The "original" signature type contains filesystem specific metadata.
Thus it cannot be copied up and verified. However with EVM_INIT_X509
and EVM_ALLOW_METADATA_WRITES enabled, the "original" file signature
may be written.

When EVM_ALLOW_METADATA_WRITES is not set or once it is removed from
/sys/kernel/security/evm by setting EVM_INIT_HMAC for example, it is not
possible to write or remove xattrs on the overlay filesystem.

This change still prevents EVM from writing HMAC signatures on
unsupported filesystem when EVM_INIT_HMAC is enabled.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 security/integrity/evm/evm_main.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 81c94967f136..c3bd88aba78c 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -192,7 +192,11 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 		     iint->evm_status == INTEGRITY_PASS_IMMUTABLE))
 		return iint->evm_status;
 
-	if (is_unsupported_fs(dentry))
+	/*
+	 * On unsupported filesystems with EVM_INIT_X509 not enabled, skip
+	 * signature verification.
+	 */
+	if (!(evm_initialized & EVM_INIT_X509) && is_unsupported_fs(dentry))
 		return INTEGRITY_UNKNOWN;
 
 	/* if status is not PASS, try to check again - against -ENOMEM */
@@ -262,7 +266,8 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 				evm_status = INTEGRITY_PASS_IMMUTABLE;
 			} else if (!IS_RDONLY(inode) &&
 				   !(inode->i_sb->s_readonly_remount) &&
-				   !IS_IMMUTABLE(inode)) {
+				   !IS_IMMUTABLE(inode) &&
+				   !is_unsupported_fs(dentry)) {
 				evm_update_evmxattr(dentry, xattr_name,
 						    xattr_value,
 						    xattr_value_len);
@@ -422,9 +427,6 @@ enum integrity_status evm_verifyxattr(struct dentry *dentry,
 	if (!evm_key_loaded() || !evm_protected_xattr(xattr_name))
 		return INTEGRITY_UNKNOWN;
 
-	if (is_unsupported_fs(dentry))
-		return INTEGRITY_UNKNOWN;
-
 	if (!iint) {
 		iint = integrity_iint_find(d_backing_inode(dentry));
 		if (!iint)
-- 
2.43.0


