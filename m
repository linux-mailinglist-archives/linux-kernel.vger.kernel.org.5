Return-Path: <linux-kernel+bounces-53210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C741984A234
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2B6AB21811
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6391A4EB37;
	Mon,  5 Feb 2024 18:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pt3AQHSx"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D7F482EB;
	Mon,  5 Feb 2024 18:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707157539; cv=none; b=E/qGZqBK3xM6M2Q6Mw9cDcoKAc3UOvlfO/3cIQFNj/kCWx6/x4TYd3nroXwLWB8metFfXlQRpiDUvir0w7SRYFMy+yC9NeFq4ZthXInNTZ6G6O0xjLxx5+MQwOb5tMwFngJBXMDEFMXTkWRiJlTQxzabgpYhhsATFOi5eygkV+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707157539; c=relaxed/simple;
	bh=hqZUaJG+ux2LMrr24JBHv1325O/xG41kZbE+VmUOc+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ONfCqlGCsAc+E3MdTNCleZM4SYY6AGubkY0UC2Ai2YMcU4iajGbiJDy4Rs5o85Lr+2uFBGH0jx2YD8mJsUoBS5icmiSL8aXERyYk4yGSVZC1+w2ale1BzltdISdU3NQLhtuWV/ByiUOcFRGt3lRINoVmPkOF5Iyg2dPOBk8chTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pt3AQHSx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 415I8o3N000686;
	Mon, 5 Feb 2024 18:25:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=HRVq2c9uSuZERHtMlqfSbAbWFd+PcbFQz/T1bvC8R5Y=;
 b=pt3AQHSxgiqnPbJV3NGrY63HgIT1z7Y7727hrkks2YD8GAzmTHspjYhE7WatMDHtzuXx
 REyLdR3S08Ua/hbiHFKg/cCwPgYgYgA86gTHRNHbMDLRlHZXyVtUoRbqAv2wMxhhgvrP
 WngM53XZgufEe8x9uS1IhihGx5RStC+lCuyvBxE1rzPWBSv8yoc5NKbj8iICO8zciQY7
 CYy+E3kko6TqXiruXPjm28A48gxy90Lo9RLgeKakTsSwsSFbgNa6M6yq0zR9SN0OgBN9
 xlsNgoFtfb8SCe131E5qjl4X4s6ScU9cAN6zinMdYbzfrwGa/3JsFI0e5clTPeTs2nBP tQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w34pk89xu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 18:25:16 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 415I9VeY001800;
	Mon, 5 Feb 2024 18:25:16 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w34pk89xq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 18:25:16 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 415IKubQ016154;
	Mon, 5 Feb 2024 18:25:15 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w22h1sprf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 18:25:15 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 415IPD6r19464922
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Feb 2024 18:25:14 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD3BC58056;
	Mon,  5 Feb 2024 18:25:13 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1BE7E5803F;
	Mon,  5 Feb 2024 18:25:13 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Feb 2024 18:25:13 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, zohar@linux.ibm.com, roberto.sassu@huawei.com,
        amir73il@gmail.com, brauner@kernel.org, miklos@szeredi.hu,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 4/9] ima: Reset EVM status upon detecting changes to the real file
Date: Mon,  5 Feb 2024 13:25:01 -0500
Message-ID: <20240205182506.3569743-5-stefanb@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: YS8wDTn87xaAe1z0tJ47U07xMq_AgWYW
X-Proofpoint-GUID: aPCwZ4bjjNqqh9eFaNkc7WHi34f_-LFw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_12,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=785 adultscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402050138

Piggyback the resetting of EVM status on IMA's file content detection that
is triggered when a not-yet-copied-up file on the 'lower' layer was
changed. However, since EVM only cares about changes to the file metadata,
only reset the EVM status if the 'lower' layer file is also the one holding
the file metadata.

Note that in the case of a stacked filesystem (e.g., overlayfs) the iint
represents the file_inode() of a file on the overlay layer. The data in
the in iint must help detect file content (IMA) and file metadata (EVM)
changes occurring on the lower layer for as long as the content or
metadata have not been copied up yet. After copy-up the iit must continue
detecting them on the overlay layer.

Changes to the file metadata on the overlay layer are causing an EVM
status reset through existing evm_inode_post_sattr/setxattr/removexattr
functions *if* an iint for a file exist. An iint exists if the file is
'in (IMA) policy', meaning that IMA created an iint for the file's inode
since the file is covered by the IMA policy.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 include/linux/evm.h               | 8 ++++++++
 security/integrity/evm/evm_main.c | 7 +++++++
 security/integrity/ima/ima_main.c | 5 +++++
 3 files changed, 20 insertions(+)

diff --git a/include/linux/evm.h b/include/linux/evm.h
index 840ffbdc2860..eade9fff7d0b 100644
--- a/include/linux/evm.h
+++ b/include/linux/evm.h
@@ -66,6 +66,8 @@ extern int evm_protected_xattr_if_enabled(const char *req_xattr_name);
 extern int evm_read_protected_xattrs(struct dentry *dentry, u8 *buffer,
 				     int buffer_size, char type,
 				     bool canonical_fmt);
+extern void evm_reset_cache_status(struct dentry *dentry,
+				   struct integrity_iint_cache *iint);
 #ifdef CONFIG_FS_POSIX_ACL
 extern int posix_xattr_acl(const char *xattrname);
 #else
@@ -190,5 +192,11 @@ static inline int evm_read_protected_xattrs(struct dentry *dentry, u8 *buffer,
 	return -EOPNOTSUPP;
 }
 
+static inline void evm_reset_cache_status(struct dentry *dentry,
+					  struct integrity_iint_cache *iint)
+{
+	return;
+}
+
 #endif /* CONFIG_EVM */
 #endif /* LINUX_EVM_H */
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 565c36471408..81c94967f136 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -721,6 +721,13 @@ static void evm_reset_status(struct inode *inode)
 		iint->evm_status = INTEGRITY_UNKNOWN;
 }
 
+void evm_reset_cache_status(struct dentry *dentry,
+			    struct integrity_iint_cache *iint)
+{
+	if (d_real_inode(dentry) != d_backing_inode(dentry))
+		iint->evm_status = INTEGRITY_UNKNOWN;
+}
+
 /**
  * evm_revalidate_status - report whether EVM status re-validation is necessary
  * @xattr_name: pointer to the affected extended attribute name
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index f1a01d32b92a..b6ba829c4e67 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -26,6 +26,7 @@
 #include <linux/ima.h>
 #include <linux/fs.h>
 #include <linux/iversion.h>
+#include <linux/evm.h>
 
 #include "ima.h"
 
@@ -297,6 +298,10 @@ static int process_measurement(struct file *file, const struct cred *cred,
 		    !inode_eq_iversion(real_inode, iint->version)) {
 			iint->flags &= ~IMA_DONE_MASK;
 			iint->measured_pcrs = 0;
+
+			if (real_inode == d_inode(d_real(file_dentry(file),
+							 D_REAL_METADATA)))
+				evm_reset_cache_status(file_dentry(file), iint);
 		}
 	}
 
-- 
2.43.0


