Return-Path: <linux-kernel+bounces-45343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC56F842ED5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5369528110C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9B27AE57;
	Tue, 30 Jan 2024 21:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZzZ7FQbz"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5677A78B4C;
	Tue, 30 Jan 2024 21:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706651214; cv=none; b=jO43fD1HHNZ487JtM8DWrxLgYhaPATQ8rsDiPyPIuxNj2E2mGzbeCs/z87jHzWTwN5SCJqYN0ug304OHtCL91OknbM+HcQ3K1/O8uvI2ykRlWuvnwQopTro6ml62Gm3Hggbeiwp2oBQ1WSC4ayGNSOMv+A+0tEYbf9iFQ3Os3NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706651214; c=relaxed/simple;
	bh=gJ3vl1IMfF3fP9qTiQ9UtT+9SZi41uTtAGlG8gJxc6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mhsNruz7XGrVs/8Ts3oMdBjXsrLImmz9ZWSYnm6ZHlIXcuO0cAXu74KZPwB0paJJYdfeonfAF8kQxNT2/HNLoUzzIHI1x9XqguKKqT8UgQXbYl04+gyAR8SKXgt1a2XtTkLAGDLCeVC90PqRqMmAmg746k7bthiV7Lm9u03sSus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZzZ7FQbz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40ULbLcR019603;
	Tue, 30 Jan 2024 21:46:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Vng+snvAnhV7hqMmeOgbU4LTAwnF0GrXQskYulFXNnE=;
 b=ZzZ7FQbzOhja6zbFvKJ0EBgfbq469wHxmV1iTPt61iEgdb0U/Gr1Fj54XV7pAyyOyJiH
 b/KWU59VIWAZXlsp9jttZhw+c+WBW1YTAAJYanN/5+7GTibaGJDb+n8OpsFBvjVDsEfX
 dznYrmBiag6YJGTr8RwimvcYFGC2pHMIHzMHbVVUentb1amBOZDefogRd2VvdanAT3YL
 SVIrdn3xyq+O7/nsDthDr/+XqzUlOyceQg7gm/Joay6O3PUcPpNor9TePWuG5URBK31m
 Sa068Bch4IoT+FQNHoy7QvlZui7PcMbIB39QDtC1xsr3rqzq102iVXArVTORyC3OzFoo KA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vy96br52u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 21:46:31 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40ULbNmK019715;
	Tue, 30 Jan 2024 21:46:31 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vy96br52c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 21:46:30 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40UJ5Z5i017797;
	Tue, 30 Jan 2024 21:46:29 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vwchysnhm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 21:46:29 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40ULkSHJ30474592
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 21:46:28 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6BA858056;
	Tue, 30 Jan 2024 21:46:28 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B59B58052;
	Tue, 30 Jan 2024 21:46:28 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jan 2024 21:46:27 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, zohar@linux.ibm.com, roberto.sassu@huawei.com,
        amir73il@gmail.com, miklos@szeredi.hu,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 2/5] evm: Implement per signature type decision in security_inode_copy_up_xattr
Date: Tue, 30 Jan 2024 16:46:17 -0500
Message-ID: <20240130214620.3155380-3-stefanb@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: _mfZnCnWYIgcuKRY0iZ_eUnB6EujrXHj
X-Proofpoint-GUID: CII-6DtfoAnrJ5hyDHJLv2dibe1LllOa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_12,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 mlxscore=0 spamscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 adultscore=0 mlxlogscore=858 bulkscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401300163

To support portable and immutable signatures on otherwise unsupported
filesystems, determine the EVM signature type by the content of a file's
xattr. If the file has the appropriate signature then allow it to be
copied up. All other signature types are discarded as before.

Portable and immutable EVM signatures can be copied up by stacked file-
system since the metadata their signature covers does not include file-
system-specific data such as a file's inode number, generation, and UUID.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 security/integrity/evm/evm_main.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 2555aa4501ae..22a5e26860ea 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -898,9 +898,30 @@ void evm_inode_post_setattr(struct dentry *dentry, int ia_valid)
 
 int evm_inode_copy_up_xattr(struct dentry *src, const char *name)
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


