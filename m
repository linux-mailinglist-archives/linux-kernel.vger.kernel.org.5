Return-Path: <linux-kernel+bounces-78836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2CC86198E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23465287D67
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630A7140E4D;
	Fri, 23 Feb 2024 17:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HQjHfEq9"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A845412D763;
	Fri, 23 Feb 2024 17:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708709147; cv=none; b=CzgzhjQvf0i67XB5xsJxzXNLbmgP/HEA3Cn5KF5i+y+FbLL59mtY3wO40XeslNFXYetw9ikQqNNUv4yZTLK798qqK0I/9jvHhew45KpVcLBNDkK3V2P8bRSebnl+HReSVm1gewNgzBCOLAo2BYXK1K9vgfVF9RBJ00LVM0IesG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708709147; c=relaxed/simple;
	bh=ZW06s7wjj9gTGUJT+QloYe2xGmFjTLmoYI5gCOp0Tys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U9POsXrSqyxztcw2Cir6hlRgEs3boeaH6UMO3uqoYZD1wPMySQ0Qm1yghlzm5enqrqDhE83PfDglzVMzzMYOCG0KZMmo6xG68vLzj58AckGdtHObK0ILoDExAJkuyAgt4dfo8xllwWcvH8LBkDYNHImeHPbU+HAvD4mIBrPKDXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HQjHfEq9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41NHMxDo026579;
	Fri, 23 Feb 2024 17:25:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=aDrrYmw5t3BqAMNqGn8xOIneLz0gWSOm+/nasgeSH5Y=;
 b=HQjHfEq90BCALa37sw+h3oEtOeBpQ7XuG/OS6ARfccxCKf+oYGXMEn2m8w67O02z1RIU
 csmay8swHy/KZqBaOAK0NefWPr9LoRIbhB75ojFsjSB8lLg4WAl+UC+5JfWVVRMhxLW1
 PwYlBGsRvTNEWis7lEpkkTfkWzFdJSnh/fTBhzj+upFoS9ipqvkKRpcAuBxyUL1kekNt
 xyy9IWZDC3gmILfjhzybRO/ixel8zuw+WNip3JapurWj0jKVJQhB7Hria5vfjfE5xMa1
 h5H5DO/Lf+YbTHMah3IUzufPATGSCqyo0Rmaa09/G2hFPZ6MHA1yvrU0IaQ3r83P9k2P zg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3weyq7r33c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 17:25:32 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41NHPEI2001882;
	Fri, 23 Feb 2024 17:25:32 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3weyq7r32k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 17:25:31 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41NHKFi2009577;
	Fri, 23 Feb 2024 17:25:31 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb84pxva0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 17:25:31 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41NHPSYx29164174
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 17:25:30 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 078F258043;
	Fri, 23 Feb 2024 17:25:28 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E3E9158059;
	Fri, 23 Feb 2024 17:25:26 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Feb 2024 17:25:26 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, zohar@linux.ibm.com, roberto.sassu@huawei.com,
        amir73il@gmail.com, brauner@kernel.org, miklos@szeredi.hu,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 08/10] evm: Enforce signatures on unsupported filesystem for EVM_INIT_X509
Date: Fri, 23 Feb 2024 12:25:11 -0500
Message-ID: <20240223172513.4049959-9-stefanb@linux.ibm.com>
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
X-Proofpoint-GUID: zIW5Up1MKJQsuaoxHMKfwanSiqMdoDAB
X-Proofpoint-ORIG-GUID: ttjXmNiwHXBpNfA2jly-K0dxoad2B2dx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_03,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402230127

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

Co-developed-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 security/integrity/evm/evm_main.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index c1ca0894cd8a..cfb4f9809369 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -192,7 +192,11 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 		     iint->evm_status == INTEGRITY_PASS_IMMUTABLE))
 		return iint->evm_status;
 
-	if (is_unsupported_fs(dentry))
+	/*
+	 * On unsupported filesystems without EVM_INIT_X509 enabled, skip
+	 * signature verification.
+	 */
+	if (!(evm_initialized & EVM_INIT_X509) && is_unsupported_fs(dentry))
 		return INTEGRITY_UNKNOWN;
 
 	/* if status is not PASS, try to check again - against -ENOMEM */
@@ -261,7 +265,8 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 				evm_status = INTEGRITY_PASS_IMMUTABLE;
 			} else if (!IS_RDONLY(inode) &&
 				   !(inode->i_sb->s_readonly_remount) &&
-				   !IS_IMMUTABLE(inode)) {
+				   !IS_IMMUTABLE(inode) &&
+				   !is_unsupported_fs(dentry)) {
 				evm_update_evmxattr(dentry, xattr_name,
 						    xattr_value,
 						    xattr_value_len);
@@ -419,9 +424,6 @@ enum integrity_status evm_verifyxattr(struct dentry *dentry,
 	if (!evm_key_loaded() || !evm_protected_xattr(xattr_name))
 		return INTEGRITY_UNKNOWN;
 
-	if (is_unsupported_fs(dentry))
-		return INTEGRITY_UNKNOWN;
-
 	return evm_verify_hmac(dentry, xattr_name, xattr_value,
 				 xattr_value_len);
 }
-- 
2.43.0


