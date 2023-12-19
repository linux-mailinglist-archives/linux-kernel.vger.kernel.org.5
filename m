Return-Path: <linux-kernel+bounces-5278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F088188E1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9067DB2361B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E381A73C;
	Tue, 19 Dec 2023 13:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jrSsh/9H"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D821A727;
	Tue, 19 Dec 2023 13:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJCoXKJ008082;
	Tue, 19 Dec 2023 13:49:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=zZbjaoTjlPkJFXiQHD8SI3UTG7YuYOK40SKblWX/KhY=;
 b=jrSsh/9HrSwa1+b0R4nBUxaTa2JhLrx8zFWnu/Ygrfy0mJb9A3I3hXBTDp8RcZmnQmP/
 lWNA0Yx9ps+tAsEX5OpzbY6gERhtZeBdHcfOpFkoJx6s3ST61mGAltOxcC4QpL276BWn
 kB2YC+8Ey8OOCajEDLGPdSVKiw+v6UJINvU2M0dzy/RUbF+DcSQFnP2GjafKiXAv3e8F
 a8fBl8hxvpG/aLRDkHSK+pBjedljoqBcYUjqhmixntt9Lq07UhIOumYvvuz//mvofWuo
 Okg2tEVzYF4jpS/UcINUOG3848iunMacvsaNF57dheajSiqO105uJOSTToX11yJ5f+Rn +g== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v3ayj2ceg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 13:49:35 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BJDKL4Q007383;
	Tue, 19 Dec 2023 13:49:34 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v3ayj2cdn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 13:49:34 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BJDM8uo010900;
	Tue, 19 Dec 2023 13:49:33 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3v1q7nfy7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 13:49:33 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BJDnVrn10748516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Dec 2023 13:49:31 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 036322004B;
	Tue, 19 Dec 2023 13:49:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8644820040;
	Tue, 19 Dec 2023 13:49:28 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.61.183.131])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 Dec 2023 13:49:28 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-unionfs@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>
Subject: [PATCH 1/2] evm: don't copy up 'security.evm' xattr
Date: Tue, 19 Dec 2023 08:49:00 -0500
Message-Id: <20231219134901.96300-2-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231219134901.96300-1-zohar@linux.ibm.com>
References: <20231219134901.96300-1-zohar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9u4vQM_WsVdwHQBtpzy2p2ScOXEspfY0
X-Proofpoint-GUID: 2h3nsbQ7kqlQ3tmC7PO76szmAyrwvT3N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-19_08,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=811
 bulkscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 spamscore=0
 mlxscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312190103

The security.evm HMAC and the original file signatures contain
filesystem specific data.  As a result, the HMAC and signature
are not the same on the stacked and backing filesystems.

Don't copy up 'security.evm'.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 include/linux/evm.h               | 6 ++++++
 security/integrity/evm/evm_main.c | 7 +++++++
 security/security.c               | 4 ++++
 3 files changed, 17 insertions(+)

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
index dcb3e7014f9b..a02e78c45007 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2539,6 +2539,10 @@ int security_inode_copy_up_xattr(const char *name)
 			return rc;
 	}
 
+	rc = evm_inode_copy_up_xattr(name);
+	if (rc != LSM_RET_DEFAULT(inode_copy_up_xattr))
+		return rc;
+
 	return LSM_RET_DEFAULT(inode_copy_up_xattr);
 }
 EXPORT_SYMBOL(security_inode_copy_up_xattr);
-- 
2.39.3


