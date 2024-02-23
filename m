Return-Path: <linux-kernel+bounces-78833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E77861982
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEB27B24491
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC92912BF0E;
	Fri, 23 Feb 2024 17:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fxnRfpBx"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BFD133995;
	Fri, 23 Feb 2024 17:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708709145; cv=none; b=nnSsgmh8mbmMz6ixVNVALM/qobLCU1jDz/38y0DSogKmgxWx9P5++CFUB7nCc/rAjNeo/35Z80X96Pgq6HoTCzzdHJhjE7NgzJxVl2bFvZTzjOOzZUdlfrUsRnLBiJ/8YJhK2aEuPrS1szSmVjgo6a29cCizFga4Gjv0O7loqWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708709145; c=relaxed/simple;
	bh=Wcxk/pW2ApZdsxdazfcYBccAOePPqvmN+7FUVnxaU1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VlRSZY/3KyhVmUAYGc1rWQUZSUxSGpFJCNOipGLNFkGmmhE26arTSCZz0AaflS2vwL5WrfjT9vLESjfrmKBogRh1dfBPa1TKLSP7ajfF/wuysq+iixL8dCTzbaSE4mMa27nyMExjAeo/KEsLi5DbvlrHnelPxSuQJkMh1q6yIOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fxnRfpBx; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41NHMLMJ026952;
	Fri, 23 Feb 2024 17:25:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=f7fMqHVvGlmlrQidq+MgrQXb3avxC1L2tKqK0iFmhYU=;
 b=fxnRfpBxol2Ny9/n8Dof5D8wj1j1Xma2zDB5NAX6VppD9zChIXzG2OU7IFPHDJHwLmjo
 LXweM2ilXevfFMdj4XW0xY6BlECV1uY8GP5qk381LE8dmRfe6FfY59L7f8DNdhs57O5O
 YTKxOTS/SelOAHQe2Zl+NkX456JUI+NAcbPMdseGyYlokER7VnCak6mzPTRRzZvWZ/7O
 mK2Z8M8oTeSx8rnFhMLqL45FQohbEPKplqtFbjhID1eFAnhMFXH4ZIudU3f2KbwwlY20
 rz3R6bBiv8eIHeoCAgMtQPlOnIaaWtA5JYxRmtvDOMlgVF5Fla6mrnzjRHRMZwPKcqU6 +g== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3weypt83k9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 17:25:24 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41NHOF16002168;
	Fri, 23 Feb 2024 17:25:23 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3weypt83jr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 17:25:23 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41NHKFi1009577;
	Fri, 23 Feb 2024 17:25:22 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb84pxv93-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 17:25:22 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41NHPIHV42664310
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 17:25:21 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D65FA58053;
	Fri, 23 Feb 2024 17:25:18 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B34D75805F;
	Fri, 23 Feb 2024 17:25:17 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Feb 2024 17:25:17 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, zohar@linux.ibm.com, roberto.sassu@huawei.com,
        amir73il@gmail.com, brauner@kernel.org, miklos@szeredi.hu,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 01/10] ima: Rename backing_inode to real_inode
Date: Fri, 23 Feb 2024 12:25:04 -0500
Message-ID: <20240223172513.4049959-2-stefanb@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: zT64E0vfiaWQj7WBFEKb8cNnGREHa82_
X-Proofpoint-GUID: HLRheZjO50dpmu7Kws_Xy85TKhoZi7BF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_03,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=770 spamscore=0 impostorscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402230127

Rename the backing_inode variable to real_inode since it gets its value
from real_inode().

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Co-developed-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Acked-by: Amir Goldstein <amir73il@gmail.com>
---
 security/integrity/ima/ima_main.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index c84e8c55333d..a744770d8c43 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -208,7 +208,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 			       u32 secid, char *buf, loff_t size, int mask,
 			       enum ima_hooks func)
 {
-	struct inode *backing_inode, *inode = file_inode(file);
+	struct inode *real_inode, *inode = file_inode(file);
 	struct ima_iint_cache *iint = NULL;
 	struct ima_template_desc *template_desc = NULL;
 	char *pathbuf = NULL;
@@ -285,14 +285,16 @@ static int process_measurement(struct file *file, const struct cred *cred,
 		iint->measured_pcrs = 0;
 	}
 
-	/* Detect and re-evaluate changes made to the backing file. */
-	backing_inode = d_real_inode(file_dentry(file));
-	if (backing_inode != inode &&
+	/*
+	 * On stacked filesystems, detect and re-evaluate file data changes.
+	 */
+	real_inode = d_real_inode(file_dentry(file));
+	if (real_inode != inode &&
 	    (action & IMA_DO_MASK) && (iint->flags & IMA_DONE_MASK)) {
-		if (!IS_I_VERSION(backing_inode) ||
-		    backing_inode->i_sb->s_dev != iint->real_dev ||
-		    backing_inode->i_ino != iint->real_ino ||
-		    !inode_eq_iversion(backing_inode, iint->version)) {
+		if (!IS_I_VERSION(real_inode) ||
+		    real_inode->i_sb->s_dev != iint->real_dev ||
+		    real_inode->i_ino != iint->real_ino ||
+		    !inode_eq_iversion(real_inode, iint->version)) {
 			iint->flags &= ~IMA_DONE_MASK;
 			iint->measured_pcrs = 0;
 		}
-- 
2.43.0


