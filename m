Return-Path: <linux-kernel+bounces-78838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8ED861990
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 404C01F269B5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8527133995;
	Fri, 23 Feb 2024 17:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HEvVpbFv"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F84F13EFEC;
	Fri, 23 Feb 2024 17:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708709147; cv=none; b=VQOYPILSXtdtFZ2wXFf28gffUWuQ1jItUmF1UEcTSPVNmfujOBJWgJa9EPxOepfBg4bsiLp5AS7+933ZquCwL2BOpDnGuPGG1UJ06DX93QLvFvIQJh0VYtbIz+LXyiB7AURctXjXBiCEimLSDst8zle3caz+GvsTs5wsBcuUxzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708709147; c=relaxed/simple;
	bh=PIz75sF5olIjwIHAKR6ZKIO4M36wE6QeZVMo0LRm2GU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pOpsm0qnnkEGE1xJvt+1j3B+nbEtU12PRaSz6e6yxB17u5PnPfmDnzcXETy47YFQHN1GpkOhqEbOfpDsmfWpOrBAcXBlTr22BSLw9jVPtRB+VqbJjj22tWe/+0H4WGMx28bMnS4J/GAnWWEQvEFlGhmuUwaivIjBCqTHWroZaiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HEvVpbFv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41NH2D5k003988;
	Fri, 23 Feb 2024 17:25:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=2A08vXBRcDuMNCQITYClD4xABkqbmxW6fMHqWng7Dto=;
 b=HEvVpbFvKrUiRwSMbqUhEZp17W7oWJ/o4RTvDjIe3hqP/u7MK8zV/izxHpAZxB0ce2PA
 vXAeiyjAY52u8qY0WYhUPTSqcdCKbXhhZDuGIMyqC2V803u5NYAK+vFHZu5MrUT5tP5Z
 nHAyseuOH5hmy3zPf0luz4Tqx0UOw70Ha1O2fuwEogwn+tTdQRoGZJgbHR4GsCb/l3i8
 4LayK1VPUJqjqBATc7mhm4ALA/CyxN4+pHoAsMcdleCL2/U3kuWv5P47hLjX5dIJ/Pc7
 8Wx/hu8sfzJGAatV/V4lKpqu7JwcM7F5zpoNOZn59PtAaCv2OOpb+wxuQpW+q+75yvdk IA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3weydh8rds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 17:25:27 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41NH3Bgf009414;
	Fri, 23 Feb 2024 17:25:27 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3weydh8rct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 17:25:27 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41NGxSMu009583;
	Fri, 23 Feb 2024 17:25:24 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb84pxv9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 17:25:24 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41NHPLqw25231942
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 17:25:23 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B4825805F;
	Fri, 23 Feb 2024 17:25:21 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 59DE15805D;
	Fri, 23 Feb 2024 17:25:20 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Feb 2024 17:25:20 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, zohar@linux.ibm.com, roberto.sassu@huawei.com,
        amir73il@gmail.com, brauner@kernel.org, miklos@szeredi.hu,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 03/10] evm: Implement per signature type decision in security_inode_copy_up_xattr
Date: Fri, 23 Feb 2024 12:25:06 -0500
Message-ID: <20240223172513.4049959-4-stefanb@linux.ibm.com>
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
X-Proofpoint-GUID: N6RDIeFIpG1BIULpgQ5uC5TsK-NqeFzQ
X-Proofpoint-ORIG-GUID: B6-V-gx45b0iKbTrp5tmD2ZlyzyBRTXg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_03,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 impostorscore=0 spamscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402230127

To support "portable and immutable signatures" on otherwise unsupported
filesystems, determine the EVM signature type by the content of a file's
xattr. If the file has the appropriate signature type then allow it to be
copied up. All other signature types are discarded as before.

"Portable and immutable" EVM signatures can be copied up by stacked file-
system since the metadata their signature covers does not include file-
system-specific data such as a file's inode number, generation, and UUID.

Co-developed-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 security/integrity/evm/evm_main.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index b0a862bfd74a..c658d2f1494b 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -948,9 +948,34 @@ static void evm_inode_post_setattr(struct mnt_idmap *idmap,
 
 static int evm_inode_copy_up_xattr(struct dentry *src, const char *name)
 {
-	if (strcmp(name, XATTR_NAME_EVM) == 0)
-		return 1; /* Discard */
-	return -EOPNOTSUPP;
+	struct evm_ima_xattr_data *xattr_data = NULL;
+	int rc;
+
+	if (strcmp(name, XATTR_NAME_EVM) != 0)
+		return -EOPNOTSUPP;
+
+	/* first need to know the sig type */
+	rc = vfs_getxattr_alloc(&nop_mnt_idmap, src, XATTR_NAME_EVM,
+				(char **)&xattr_data, 0, GFP_NOFS);
+	if (rc <= 0)
+		return -EPERM;
+
+	if (rc < offsetof(struct evm_ima_xattr_data, type) +
+		 sizeof(xattr_data->type))
+		return -EPERM;
+
+	switch (xattr_data->type) {
+	case EVM_XATTR_PORTABLE_DIGSIG:
+		rc = 0; /* allow copy-up */
+		break;
+	case EVM_XATTR_HMAC:
+	case EVM_IMA_XATTR_DIGSIG:
+	default:
+		rc = 1; /* discard */
+	}
+
+	kfree(xattr_data);
+	return rc;
 }
 
 /*
-- 
2.43.0


