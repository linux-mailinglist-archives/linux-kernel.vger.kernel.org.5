Return-Path: <linux-kernel+bounces-53201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7BB84A21A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AA33B229F3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2EC482DF;
	Mon,  5 Feb 2024 18:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rBSiL9wU"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D61347F41;
	Mon,  5 Feb 2024 18:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707157535; cv=none; b=sGfuiGu0H+eoxfuvhOHTGA+xhEwJdh1MsRcaIkSpyK/RdebG+OyKCrdU+8prCQe70YulzSij6nWSaYavmlRp4OQZgj8TO2a+oS1aYndB0Ov82SP7wu0R3lMnRu9UaNLg18E6jyMbb0C0xjOB0Z4v0Lxsn3CzelqIagBXLo2lgmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707157535; c=relaxed/simple;
	bh=c420FT9xPcjNNnI7cnPYtoKyvaj5gGmp6EuWZ909yrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TFhB1OrLeVPUdGL1SWq/303S1wZPpxlqMOcM1AzPGMaP4rmTXJQKFcVJqKbLX/OAskgAk4McDcRPLONasf6w8vktteMZbFug+UM4zssZyuqu185+5U0UgbpW2U4dkUMhbA65IGqB4SPPZDrXktHFckMYxmFMf/90oPGhk1agPYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rBSiL9wU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 415I8r7X000793;
	Mon, 5 Feb 2024 18:25:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=f8lofELfN0pFVcElPi3ezYw8PsjubzFBlRnZcA1QfOw=;
 b=rBSiL9wUQfqgimDZM7zff6YQ3UzVf6x0Blq3g5QxV0xcuK7Gyk+WCOHOmvFR1IMlBjTI
 HqxErU0P+6rnXx6b303Lr+9bi6HPUiR9t4hvrbGyeBH47N8imjzHsj7s6QvCq3bEvqju
 Bi5uLC6SXzIF93tll23qVAQm7GTWR3cdsKtZFIGUg3ZUl0DO5AKccSirkfzzM3G8U3sw
 T2J4IZilgd89RwMBiO8SExHCDQnT2FxPXH653paP1dx1ke7aQ8RzJl/c1lir/lnAuSkT
 ZrG+mxBz7CmmDVmwdWaU4xXsEnDKIudyEPEi1TryTXzDqv0h0k8EXVhNC0gk83xNujAp Fg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w34pk89yn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 18:25:19 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 415I9xoc003410;
	Mon, 5 Feb 2024 18:25:19 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w34pk89yj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 18:25:19 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 415G1sJ9020234;
	Mon, 5 Feb 2024 18:25:18 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w1ytstet2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 18:25:18 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 415IPHbn5374862
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Feb 2024 18:25:17 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 85BA95805A;
	Mon,  5 Feb 2024 18:25:17 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D843E5803F;
	Mon,  5 Feb 2024 18:25:16 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Feb 2024 18:25:16 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, zohar@linux.ibm.com, roberto.sassu@huawei.com,
        amir73il@gmail.com, brauner@kernel.org, miklos@szeredi.hu,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 9/9] ima: Record i_version of real_inode for change detection
Date: Mon,  5 Feb 2024 13:25:06 -0500
Message-ID: <20240205182506.3569743-10-stefanb@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: ZNRgc6oqUmqwEd5qverWof6L4JleiyOw
X-Proofpoint-GUID: 0UyHcsfJXduKx_DbyfsYnX2nWa-rvek4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_12,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402050138

process_measurement() will try to detect file content changes for not-yet-
copied-up files on a stacked filesystem based on the i_version number of
the real inode: !inode_eq_iversion(real_inode, iint->version)
Therefore, take a snapshot of the i_version of the real file to be used
for i_version number-based file content change detection by IMA in
process_meassurements().

In this case vfs_getattr_nosec() cannot be used since it will return the
i_version number of the file on the overlay layer which will trigger more
iint resets in process_measurements() than necessary since this i_version
number represents different state than that of the real_inode (of a
not-yet-copied up file).

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 security/integrity/ima/ima_api.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 597ea0c4d72f..530888cc481e 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -14,6 +14,7 @@
 #include <linux/xattr.h>
 #include <linux/evm.h>
 #include <linux/fsverity.h>
+#include <linux/iversion.h>
 
 #include "ima.h"
 
@@ -250,7 +251,6 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
 	int result = 0;
 	int length;
 	void *tmpbuf;
-	u64 i_version = 0;
 
 	/*
 	 * Always collect the modsig, because IMA might have already collected
@@ -263,16 +263,6 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
 	if (iint->flags & IMA_COLLECTED)
 		goto out;
 
-	/*
-	 * Detecting file change is based on i_version. On filesystems
-	 * which do not support i_version, support was originally limited
-	 * to an initial measurement/appraisal/audit, but was modified to
-	 * assume the file changed.
-	 */
-	result = vfs_getattr_nosec(&file->f_path, &stat, STATX_CHANGE_COOKIE,
-				   AT_STATX_SYNC_AS_STAT);
-	if (!result && (stat.result_mask & STATX_CHANGE_COOKIE))
-		i_version = stat.change_cookie;
 	hash.hdr.algo = algo;
 	hash.hdr.length = hash_digest_size[algo];
 
@@ -302,10 +292,22 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
 
 	iint->ima_hash = tmpbuf;
 	memcpy(iint->ima_hash, &hash, length);
-	iint->version = i_version;
-	if (real_inode != inode) {
+	if (real_inode == inode) {
+		/*
+		 * Detecting file change is based on i_version. On filesystems
+		 * which do not support i_version, support was originally limited
+		 * to an initial measurement/appraisal/audit, but was modified to
+		 * assume the file changed.
+		 */
+		result = vfs_getattr_nosec(&file->f_path, &stat,
+					   STATX_CHANGE_COOKIE,
+					   AT_STATX_SYNC_AS_STAT);
+		if (!result && (stat.result_mask & STATX_CHANGE_COOKIE))
+			iint->version = stat.change_cookie;
+	} else {
 		iint->real_ino = real_inode->i_ino;
 		iint->real_dev = real_inode->i_sb->s_dev;
+		iint->version = inode_query_iversion(real_inode);
 	}
 
 	/* Possibly temporary failure due to type of read (eg. O_DIRECT) */
-- 
2.43.0


