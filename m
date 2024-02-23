Return-Path: <linux-kernel+bounces-78831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97ED186197A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37F991F25FB6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7CD13DBBB;
	Fri, 23 Feb 2024 17:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KYYn/Y1w"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0EC133298;
	Fri, 23 Feb 2024 17:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708709145; cv=none; b=mn1t3PYs7tiorl/aAwwGZXpdpqGP9cXdvGKF0w9g1R+IreWU94QzlEmm1PBxnS/Pfopm8hS9l/IXzMd5/WzSBUV5FuAEh9H7HZTZhqc/ooLcvo92YNXgFskgfZnGjYrCqoI8buW/QCeWVilBwoGeJAPYeiCcXCx9THfsq/ukFxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708709145; c=relaxed/simple;
	bh=kSLFV7xyi48KFJ8Rsbkur+uvzn+lPnb3q506OlHWcEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ryhr/za06OD8piRpvYG0fxqLiORKVSpBJwnu7+RPlgqGjhKYubzGbP1383Kec0KzJzeLXCVDhF6yRN+eir/tk9a63CqyMzRWUZo2XkLOJ+ahcCLzCt8SVg6/wDJyaQeECPYYQKO1rfgceAChR7quNBc01nTjAkYRuKMQ+6K0Zm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KYYn/Y1w; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41NHHP82021805;
	Fri, 23 Feb 2024 17:25:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=HEvyJIBK+QBpF4DAvae6ALmzO3GZjqSd7hnalCftw4g=;
 b=KYYn/Y1wsEEeusaE1UCEIIA3sR0wjY07eVJbMVuBGrDrC1lAIINE5dSHXQ6BCJKNcTEd
 0mItmennSDK7KxfxFarxI6TgeT9QNgNE905/ap12VmKr87G1+C5saE+VkC2i1c7Nx0xE
 bmYYekSeqM2HCpAeOW5zWwGafA3xvCMGhPE/IMvHvsNBfMQuX79GMEPDQF746UbXqxuN
 G0mlOZ98M514WrRrd+TkmJJVuW9Sm4lz+I5VO6aKdoybcF3QMC5ZFMs9jEfGrYT/bq9K
 VqGlLEXMlKjLFxS0DarTz+Mb6Slu6YV3fGnicZJTsSqh6ZNvdKQSAHCK71sT70zPdO7O 6w== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3weymgg7ku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 17:25:31 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41NHID7X023435;
	Fri, 23 Feb 2024 17:25:30 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3weymgg7k8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 17:25:30 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41NG7eBu014416;
	Fri, 23 Feb 2024 17:25:30 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wb9u36atn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 17:25:30 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41NHPQZU9241488
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 17:25:29 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD35E58066;
	Fri, 23 Feb 2024 17:25:26 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B8E158059;
	Fri, 23 Feb 2024 17:25:25 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Feb 2024 17:25:25 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, zohar@linux.ibm.com, roberto.sassu@huawei.com,
        amir73il@gmail.com, brauner@kernel.org, miklos@szeredi.hu,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 07/10] ima: re-evaluate file integrity on file metadata change
Date: Fri, 23 Feb 2024 12:25:10 -0500
Message-ID: <20240223172513.4049959-8-stefanb@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: BgIcHTriD_2Qpaakvseutw3_Hj9NklpK
X-Proofpoint-GUID: y5XdLjV7a6dU1pN0kREb3005F3MWryIK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_03,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 mlxlogscore=876 mlxscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402230127

Force a file's integrity to be re-evaluated on file metadata change by
resetting both the IMA and EVM status flags.

Co-developed-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 security/integrity/ima/ima_main.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index c15378dd9456..36c92d6c01f6 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -26,6 +26,7 @@
 #include <linux/ima.h>
 #include <linux/fs.h>
 #include <linux/iversion.h>
+#include <linux/evm.h>
 
 #include "ima.h"
 
@@ -211,6 +212,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	struct inode *real_inode, *inode = file_inode(file);
 	struct ima_iint_cache *iint = NULL;
 	struct ima_template_desc *template_desc = NULL;
+	struct inode *metadata_inode;
 	char *pathbuf = NULL;
 	char filename[NAME_MAX];
 	const char *pathname = NULL;
@@ -286,7 +288,8 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	}
 
 	/*
-	 * On stacked filesystems, detect and re-evaluate file data changes.
+	 * On stacked filesystems, detect and re-evaluate file data and
+	 * metadata changes.
 	 */
 	real_inode = d_real_inode(file_dentry(file));
 	if (real_inode != inode &&
@@ -297,6 +300,15 @@ static int process_measurement(struct file *file, const struct cred *cred,
 			iint->flags &= ~IMA_DONE_MASK;
 			iint->measured_pcrs = 0;
 		}
+
+		/*
+		 * Reset the EVM status when metadata changed.
+		 */
+		metadata_inode = d_inode(d_real(file_dentry(file),
+					 D_REAL_METADATA));
+		if (evm_metadata_changed(inode, metadata_inode))
+			iint->flags &= ~(IMA_APPRAISED |
+					 IMA_APPRAISED_SUBMASK);
 	}
 
 	/* Determine if already appraised/measured based on bitmask
-- 
2.43.0


