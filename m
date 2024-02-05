Return-Path: <linux-kernel+bounces-53205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA80784A226
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19F6A1C22846
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D3F487BE;
	Mon,  5 Feb 2024 18:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="olbfSAtt"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE42147F7C;
	Mon,  5 Feb 2024 18:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707157537; cv=none; b=oGrmWzugi2/UczNpkQuF9PAm4vN5BvJackzxoTghyTliPOFk0F4SFHGreMCGSxhfjOBgY7wcvLKHEmMkEhzjRc6Gp7B5n8it/hxAfMFtXBsgyaKW+Q+x+DmrjkXrD3oAm6MUJZTCXHnha9cxhnySleOn600tPNM/ZbS0CotS+Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707157537; c=relaxed/simple;
	bh=YAtXY4N9oiUBPs/9tUVB36/NvgKW9jdqRfamTz+Oau8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M5jhyPKEhpkCPAitcHR61MOtBXjOszm239F7RwOaAIBjpHpopTv76yJRfpGuiAgAEXwAMSilhIYS9XvXfEtEj7pyma7xIZ9+Cb7d/huMFK3g+F6kKi+kFdOELOWe6u6l/V1teTWBh4U/5YQHEyqMm0Sk3JjFgCANMe+0ONRd384=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=olbfSAtt; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 415GvNDj007307;
	Mon, 5 Feb 2024 18:25:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=MUITpMhKxm6ZS53FGejlfGGy1Sm1+6elFHPSlAhqrco=;
 b=olbfSAttbeGyT+tmf4KVvEIjZGAf52oTII6dqphFdCa66Vg0iHSXFYhOaQUBngRGeAvH
 EdEWDjuhsP6NYJi0ra1tHQE1pN0Xj+V38d62pDDK6P4mMcMK3RiL7T86AxIeqh6qVGWq
 2hkFvox8+ZD1YcRPRgtUK32RLWhrfmY1LSc1wBUfsQQY6ShST2GJwZI1MaTrRX97a/qB
 chg9a4HOMn2WFhhQLM+Z0YbBomemKatgD1mixgS96ReiT+ZeShMS3noovSEcqkYAc5Qp
 mabV6l8TZNsEtW5IRIjXJVjpFNLTHU9k9s4haiCsfqsUFSBbFj/QvsV1x/HA9odAHOhF Ww== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w33n628u5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 18:25:16 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 415IBYGP020042;
	Mon, 5 Feb 2024 18:25:15 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w33n628tw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 18:25:15 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 415HZ6HX008519;
	Mon, 5 Feb 2024 18:25:14 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w221jstma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 18:25:14 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 415IPDqY19530442
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Feb 2024 18:25:13 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0494A58061;
	Mon,  5 Feb 2024 18:25:13 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 56ACE5803F;
	Mon,  5 Feb 2024 18:25:12 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Feb 2024 18:25:12 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, zohar@linux.ibm.com, roberto.sassu@huawei.com,
        amir73il@gmail.com, brauner@kernel.org, miklos@szeredi.hu,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 3/9] evm: Implement per signature type decision in security_inode_copy_up_xattr
Date: Mon,  5 Feb 2024 13:25:00 -0500
Message-ID: <20240205182506.3569743-4-stefanb@linux.ibm.com>
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
X-Proofpoint-GUID: sfbxAz4GddVr8EkYvS-Q6hyPBjcdEIWc
X-Proofpoint-ORIG-GUID: 0HsNFykgROKZhtK6HIvQNkFoHCohmanr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_12,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 malwarescore=0 mlxlogscore=846 bulkscore=0 clxscore=1015 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402050138

To support portable and immutable signatures on otherwise unsupported
filesystems, determine the EVM signature type by the content of a file's
xattr. If the file has the appropriate signature then allow it to be
copied up. All other signature types are discarded as before.

"Portable and immutable" EVM signatures can be copied up by stacked file-
systems since the metadata their signature covers does not include file-
system-specific data such as a file's inode number, generation, and UUID.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 security/integrity/evm/evm_main.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 2555aa4501ae..565c36471408 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -898,9 +898,34 @@ void evm_inode_post_setattr(struct dentry *dentry, int ia_valid)
 
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


