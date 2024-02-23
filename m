Return-Path: <linux-kernel+bounces-78835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D9C861988
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A08A1B2128B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A008014038C;
	Fri, 23 Feb 2024 17:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lDAvNlBe"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C996E1353EA;
	Fri, 23 Feb 2024 17:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708709146; cv=none; b=FaVOwOCLs6S05GbSVZPzMT5imubQy1rIo6Algn6yuy6MM1QmYVeCJXFnWlJcS9kTUJi77cXIYf3XxBvG3KHVHbmYj501MBTIV8qcNiuFhxQSVP1sOTwuM7Wde97odTZDmu7TuPwz2D9+Yb2nFrqM5vZdORpW1zAqB0+4GG2ujd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708709146; c=relaxed/simple;
	bh=ywiNYTeMaZJFqTebr2w2TJULMk3lm9JjS8tRWOZISo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ExNjbm03W3eRbjHwmC+Fyp+a/NlBPj9zjgVMnFWKT1NCtSPPrKeNj3LPqUFP1iouqAmMkJMsMMmG4qB5tkWcWdsvgVgGaU72Dpccb0+wEt83F/U64YG0n+kRSpTQHX4F0S0u2DiWTk2OTzfi0XClOmVvluQb9WWOGl98VFUEn7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lDAvNlBe; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41NGfwnH023506;
	Fri, 23 Feb 2024 17:25:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=56+2zu/KSzjzM1P7dZTtpagnOVyBmhYDqaxIS45CplU=;
 b=lDAvNlBeshXOJBnFDA1e7rLL/1+13K0BxGZAVIb3+tirxabgFKdfHyLbAIixbqESkRv+
 /FRU0uHbb1ZVMh77U/32uC10yQyiAs/W8OwaJKw3w69kfI1u3en+4VuXq897BnWhYnpp
 8HebAig2jzRebU5VLvfHUDznN3NdRMtTumqPSqffbqWAyEuUpAboWvXureufaHgepRAb
 BwtC5A7z469riGB8433evPMhlobTZXbB6h773QAzD94aFtjKW5vXg84fCiRg8+n4Dm35
 rS3jIbTn3qCgMv38jFIi9mCdh4ak2/Ojq5S2FQQdlzkxthi1e5w6V/VpGmcyeQ5KMONL cg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wexwe9pkx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 17:25:29 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41NGgcpg026369;
	Fri, 23 Feb 2024 17:25:28 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wexwe9pkq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 17:25:28 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41NHEkCQ017344;
	Fri, 23 Feb 2024 17:25:27 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb8mmxqw8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 17:25:27 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41NHPO2I10486470
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 17:25:26 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 227535805D;
	Fri, 23 Feb 2024 17:25:24 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB94458061;
	Fri, 23 Feb 2024 17:25:22 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Feb 2024 17:25:22 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, zohar@linux.ibm.com, roberto.sassu@huawei.com,
        amir73il@gmail.com, brauner@kernel.org, miklos@szeredi.hu,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 05/10] ima: Move file-change detection variables into new structure
Date: Fri, 23 Feb 2024 12:25:08 -0500
Message-ID: <20240223172513.4049959-6-stefanb@linux.ibm.com>
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
X-Proofpoint-GUID: WC24sZDNwUTWYzZWtSCqAG7qYnXEvTS2
X-Proofpoint-ORIG-GUID: 800ZHnaGuezJcIes3nrW2c7Jwpt8M9hD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_03,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 bulkscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402230127

Move all the variables used for file change detection into a structure
that can be used by IMA and EVM. Implement an inline function for storing
the identification of an inode and one for detecting changes to an inode
based on this new structure.

Co-developed-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 include/linux/integrity.h         | 34 +++++++++++++++++++++++++++++++
 security/integrity/ima/ima.h      |  4 +---
 security/integrity/ima/ima_api.c  | 10 ++++-----
 security/integrity/ima/ima_iint.c |  2 +-
 security/integrity/ima/ima_main.c |  7 +++----
 5 files changed, 44 insertions(+), 13 deletions(-)

diff --git a/include/linux/integrity.h b/include/linux/integrity.h
index 459b79683783..f5842372359b 100644
--- a/include/linux/integrity.h
+++ b/include/linux/integrity.h
@@ -8,6 +8,7 @@
 #define _LINUX_INTEGRITY_H
 
 #include <linux/fs.h>
+#include <linux/iversion.h>
 
 enum integrity_status {
 	INTEGRITY_PASS = 0,
@@ -28,4 +29,37 @@ static inline void integrity_load_keys(void)
 }
 #endif /* CONFIG_INTEGRITY */
 
+/* An inode's attributes for detection of changes */
+struct integrity_inode_attributes {
+	u64 version;		/* track inode changes */
+	unsigned long ino;
+	dev_t dev;
+};
+
+/*
+ * On stacked filesystems the i_version alone is not enough to detect file data
+ * or metadata change. Additional metadata is required.
+ */
+static inline void
+integrity_inode_attrs_store(struct integrity_inode_attributes *attrs,
+			    u64 i_version, const struct inode *inode)
+{
+	attrs->version = i_version;
+	attrs->dev = inode->i_sb->s_dev;
+	attrs->ino = inode->i_ino;
+}
+
+/*
+ * On stacked filesystems detect whether the inode or its content has changed.
+ */
+static inline bool
+integrity_inode_attrs_changed(const struct integrity_inode_attributes *attrs,
+			      const struct inode *inode)
+{
+	return (inode->i_sb->s_dev != attrs->dev ||
+		inode->i_ino != attrs->ino ||
+		!inode_eq_iversion(inode, attrs->version));
+}
+
+
 #endif /* _LINUX_INTEGRITY_H */
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 11d7c0332207..9151b5369cdc 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -175,12 +175,10 @@ struct ima_kexec_hdr {
 /* IMA integrity metadata associated with an inode */
 struct ima_iint_cache {
 	struct mutex mutex;	/* protects: version, flags, digest */
-	u64 version;		/* track inode changes */
+	struct integrity_inode_attributes real_inode;
 	unsigned long flags;
 	unsigned long measured_pcrs;
 	unsigned long atomic_flags;
-	unsigned long real_ino;
-	dev_t real_dev;
 	enum integrity_status ima_file_status:4;
 	enum integrity_status ima_mmap_status:4;
 	enum integrity_status ima_bprm_status:4;
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index b37d043d5748..4b2c3448dfda 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -303,11 +303,11 @@ int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
 
 	iint->ima_hash = tmpbuf;
 	memcpy(iint->ima_hash, &hash, length);
-	iint->version = i_version;
-	if (real_inode != inode) {
-		iint->real_ino = real_inode->i_ino;
-		iint->real_dev = real_inode->i_sb->s_dev;
-	}
+	if (real_inode == inode)
+		iint->real_inode.version = i_version;
+	else
+		integrity_inode_attrs_store(&iint->real_inode, i_version,
+					    real_inode);
 
 	/* Possibly temporary failure due to type of read (eg. O_DIRECT) */
 	if (!result)
diff --git a/security/integrity/ima/ima_iint.c b/security/integrity/ima/ima_iint.c
index e7c9c216c1c6..e23412a2c56b 100644
--- a/security/integrity/ima/ima_iint.c
+++ b/security/integrity/ima/ima_iint.c
@@ -59,7 +59,7 @@ static void ima_iint_init_always(struct ima_iint_cache *iint,
 				 struct inode *inode)
 {
 	iint->ima_hash = NULL;
-	iint->version = 0;
+	iint->real_inode.version = 0;
 	iint->flags = 0UL;
 	iint->atomic_flags = 0UL;
 	iint->ima_file_status = INTEGRITY_UNKNOWN;
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index a744770d8c43..c15378dd9456 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -173,7 +173,7 @@ static void ima_check_last_writer(struct ima_iint_cache *iint,
 				      STATX_CHANGE_COOKIE,
 				      AT_STATX_SYNC_AS_STAT) ||
 		    !(stat.result_mask & STATX_CHANGE_COOKIE) ||
-		    stat.change_cookie != iint->version) {
+		    stat.change_cookie != iint->real_inode.version) {
 			iint->flags &= ~(IMA_DONE_MASK | IMA_NEW_FILE);
 			iint->measured_pcrs = 0;
 			if (update)
@@ -292,9 +292,8 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	if (real_inode != inode &&
 	    (action & IMA_DO_MASK) && (iint->flags & IMA_DONE_MASK)) {
 		if (!IS_I_VERSION(real_inode) ||
-		    real_inode->i_sb->s_dev != iint->real_dev ||
-		    real_inode->i_ino != iint->real_ino ||
-		    !inode_eq_iversion(real_inode, iint->version)) {
+		    integrity_inode_attrs_changed(&iint->real_inode,
+						  real_inode)) {
 			iint->flags &= ~IMA_DONE_MASK;
 			iint->measured_pcrs = 0;
 		}
-- 
2.43.0


