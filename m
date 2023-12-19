Return-Path: <linux-kernel+bounces-5747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFFC818F03
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C496B246CB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B2838DFC;
	Tue, 19 Dec 2023 17:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aCQm9B6w"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E944B155;
	Tue, 19 Dec 2023 17:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJHgJ6B006624;
	Tue, 19 Dec 2023 17:52:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ucpCVXeS9j5rwPkRYgV2mtvILK/eCTItebGDK+ov8mw=;
 b=aCQm9B6wbJ8jo90hQMLH9DugmN61ZSYL6PBfx30voqzfCHFX7RsUsxul1bi/JRhtvwuN
 BgjHp16QyH4/V59uqdd2t+UnuvudliK43sWB0nruSvE1yixxcpzUe8PxpSIwZSZ2tiHA
 a2BeAeVQ62VsKODdzO/DRSHhj+iN+bol58rnul4WN3a3ZzyommOSBAIrZUYxmskOHOIR
 93Gph93pHXhYu5rQ/7g37rdUyorgRIcLhXEcSOmUP2fo1kd3tOfCg1lg/vSdfOz3vYvK
 X0DZ5fBRqBxyFWlfLdj21CzOB78JWq3mXJDEHsR5+uLC9TQPuJX8W8ooJd1l5bGwr8hK vA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v3fk5rkmk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 17:52:18 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BJHUZle031471;
	Tue, 19 Dec 2023 17:52:18 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v3fk5rkm8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 17:52:18 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJHP3EG029718;
	Tue, 19 Dec 2023 17:52:17 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3v1p7shpkx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 17:52:17 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BJHqFma22020672
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 17:52:15 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AAC6220040;
	Tue, 19 Dec 2023 17:52:15 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD8DB20043;
	Tue, 19 Dec 2023 17:52:13 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.61.138.145])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 Dec 2023 17:52:13 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-unionfs@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>
Subject: [PATCH v2 1/3] evm: don't copy up 'security.evm' xattr
Date: Tue, 19 Dec 2023 12:52:04 -0500
Message-Id: <20231219175206.12342-2-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231219175206.12342-1-zohar@linux.ibm.com>
References: <20231219175206.12342-1-zohar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: I5Ord6MBRPRcteUILlS7eHIK2uIXf0gY
X-Proofpoint-ORIG-GUID: N5OIpIMqvV6z9XtZBmbZBPn_wCbmAHwa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-19_10,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0 mlxlogscore=696
 spamscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312190133

The security.evm HMAC and the original file signatures contain
filesystem specific data.  As a result, the HMAC and signature
are not the same on the stacked and backing filesystems.

Don't copy up 'security.evm'.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 include/linux/evm.h               | 6 ++++++
 security/integrity/evm/evm_main.c | 7 +++++++
 security/security.c               | 2 +-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/linux/evm.h b/include/linux/evm.h
index 01fc495a83e2..36ec884320d9 100644
--- a/include/linux/evm.h
+++ b/include/linux/evm.h
@@ -31,6 +31,7 @@ extern void evm_inode_post_setxattr(struct dentry *dentry,
 				    const char *xattr_name,
 				    const void *xattr_value,
 				    size_t xattr_value_len);
+extern int evm_inode_copy_up_xattr(const char *name);
 extern int evm_inode_removexattr(struct mnt_idmap *idmap,
 				 struct dentry *dentry, const char *xattr_name);
 extern void evm_inode_post_removexattr(struct dentry *dentry,
@@ -117,6 +118,11 @@ static inline void evm_inode_post_setxattr(struct dentry *dentry,
 	return;
 }
 
+static inline int  evm_inode_copy_up_xattr(const char *name)
+{
+	return 0;
+}
+
 static inline int evm_inode_removexattr(struct mnt_idmap *idmap,
 					struct dentry *dentry,
 					const char *xattr_name)
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 894570fe39bc..02adba635b02 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -863,6 +863,13 @@ void evm_inode_post_setattr(struct dentry *dentry, int ia_valid)
 		evm_update_evmxattr(dentry, NULL, NULL, 0);
 }
 
+int evm_inode_copy_up_xattr(const char *name)
+{
+	if (strcmp(name, XATTR_NAME_EVM) == 0)
+		return 1; /* Discard */
+	return -EOPNOTSUPP;
+}
+
 /*
  * evm_inode_init_security - initializes security.evm HMAC value
  */
diff --git a/security/security.c b/security/security.c
index dcb3e7014f9b..f00ec4d988b8 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2539,7 +2539,7 @@ int security_inode_copy_up_xattr(const char *name)
 			return rc;
 	}
 
-	return LSM_RET_DEFAULT(inode_copy_up_xattr);
+	return evm_inode_copy_up_xattr(name);
 }
 EXPORT_SYMBOL(security_inode_copy_up_xattr);
 
-- 
2.39.3


