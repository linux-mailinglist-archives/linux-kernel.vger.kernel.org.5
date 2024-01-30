Return-Path: <linux-kernel+bounces-45344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B566842ED6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52A152824FC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EC37AE58;
	Tue, 30 Jan 2024 21:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="p588R8yj"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE3678B63;
	Tue, 30 Jan 2024 21:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706651214; cv=none; b=kSfci2l9DbQn9PQUEqHgw2bhee7TjffKAeoKqu2RRGYSxCQeqKLH8Wg4mygn/fue+p7VvFsIpuO8OAwE5lDeiJTk5LaiNfIRj5hmCAQn+WOfuFbyQExe36HhuQESisteyoki9nEx/E+1al6OS9VzfSmttXgLWQMVlZSFFsaUuwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706651214; c=relaxed/simple;
	bh=g3XohpEx+AqEZl5s7sOl5bPcV3dAbvI8Q4t0hJNfxO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G9FR7a2jEnhM4u+BvXgS820JXjhHcHua1OdrpdaeMBwYDUq5BBrXjdzKvNg5UmLHOpJl67OsbA97Bw5U/J/5TI9dJU4wIleyd/OZ9OPLGlGTvAg7TxIpiEEsToTnQ8ZamD7effz5APDP4DmitnOWCGTqlrDbUyzg+5Re2DN5bds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=p588R8yj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40ULVFM9009379;
	Tue, 30 Jan 2024 21:46:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=mAlx22Ahv7RnWALJi16RhDsHycOIjE8NeYAg7sZHGGw=;
 b=p588R8yjSQHvf3whFXlEXFe+TQwM1SCEnBATmv4XPny7BM+i6lYbdxlaCmkclOn2mHQG
 FPAK0l84E5ERWrdU1/5rjp3urrBNA6HKkqjnjCaR/jgNYermSIBolbQ+hT1J7htihRHf
 Yxi5K5a5aTIwzobQ3830Jm1LIECkct53eomRhvLHEcoZK6MpJD9GDZR9vYYcDNtDjshF
 t0nJqx1hdpzDVCFcqfLPkyFWJ93ecp1DkLLE1lpIX7x1xU1Nj+xH+9NRoA82hUYGCPZE
 S/+dASKYHWkv1Wz+HpnZacYGNxltkDKZII2h1/XkiqiRearIpa8ewCkGrsSLZDrP4+wJ Wg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vy8ews1p7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 21:46:33 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40ULkWhO020764;
	Tue, 30 Jan 2024 21:46:32 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vy8ews1ne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 21:46:32 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40UJNwwC010535;
	Tue, 30 Jan 2024 21:46:30 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vwd5nsf60-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 21:46:30 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40ULkTtL57016818
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 21:46:29 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6682A58056;
	Tue, 30 Jan 2024 21:46:29 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BDE8F58052;
	Tue, 30 Jan 2024 21:46:28 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jan 2024 21:46:28 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, zohar@linux.ibm.com, roberto.sassu@huawei.com,
        amir73il@gmail.com, miklos@szeredi.hu,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 3/5] ima: Reset EVM status upon detecting changes to overlay backing file
Date: Tue, 30 Jan 2024 16:46:18 -0500
Message-ID: <20240130214620.3155380-4-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130214620.3155380-1-stefanb@linux.ibm.com>
References: <20240130214620.3155380-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hSY_ubgPqweHLnnU1uF16aBWXdxnw9Jz
X-Proofpoint-ORIG-GUID: t4eLxYBI81pwHaLkFRofusXABLnLq-sn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_12,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=615 lowpriorityscore=0 priorityscore=1501
 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401300163

To avoid caching effects to take effect reset the EVM status upon
detecting changes to the overlay backing files. This prevents a not-yet-
copied-up file on the overlay from executing if for example the
security.evm xattr on the file on the 'lower' layer has been removed.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 include/linux/evm.h               | 8 ++++++++
 security/integrity/evm/evm_main.c | 7 +++++++
 security/integrity/ima/ima_main.c | 2 ++
 3 files changed, 17 insertions(+)

diff --git a/include/linux/evm.h b/include/linux/evm.h
index d8c0343436b8..e7d6742eee9d 100644
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
@@ -189,5 +191,11 @@ static inline int evm_read_protected_xattrs(struct dentry *dentry, u8 *buffer,
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
index 22a5e26860ea..e96d127b48a2 100644
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
index cc1217ac2c6f..84bdc6e58329 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -26,6 +26,7 @@
 #include <linux/ima.h>
 #include <linux/fs.h>
 #include <linux/iversion.h>
+#include <linux/evm.h>
 
 #include "ima.h"
 
@@ -295,6 +296,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 		    !inode_eq_iversion(backing_inode, iint->version)) {
 			iint->flags &= ~IMA_DONE_MASK;
 			iint->measured_pcrs = 0;
+			evm_reset_cache_status(file_dentry(file), iint);
 		}
 	}
 
-- 
2.43.0


