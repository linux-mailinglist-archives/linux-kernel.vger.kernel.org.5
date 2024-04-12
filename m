Return-Path: <linux-kernel+bounces-142785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2FD8A3016
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29BE4B23E18
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB0485958;
	Fri, 12 Apr 2024 14:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kNXdy89b"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EE886263;
	Fri, 12 Apr 2024 14:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712930504; cv=none; b=m3VKCbwoHIm2PIBYw3eNQIa5ujqvTJjEM7mFWdsuzFZ7hnbmQXc2gmK4rpF/qkf6hNNfo/d71eYUjk4Gvh4f5ARcqlHYiE3U92G+WXuvqJ/u7OkcI5Q4mgv7xJTi85m9lcIgOsg/IBrP3ilE1qXf81sx8hAoweWCj3WfYxPoFe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712930504; c=relaxed/simple;
	bh=gGjW2b6424KvqKll5M6gaO2TdOJ5v0dFJTon93QnOCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pqLHhH2YpTRGRYLbp64O11OPQy2o+rDhEcBZf0uucteSxIfQXLb7K3QXSLLEw7/uuFdPjEylKUgkdsqKbi5xf3laOyXAriKnD25f88HuN/F/7yNBsG9732AlC526C5bSrdIWSu+s6hKZOJbMF1ZQD5m2lSOhnG8WzEO6h62PNgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kNXdy89b; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43CDFU1j023559;
	Fri, 12 Apr 2024 14:01:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=EUCx6GDFLRxE+4XIrvIIlReZtZ6BbhEwIa722HP+UWQ=;
 b=kNXdy89bLll3B5Umv85WxDxEKAiEOKLKvI5uDsrkb5fhy//poQPb1Fq/UeD/vRDYIbbv
 H1DmDjHtbHtMqaxkBBNNqCHfenT2qTanUXwYieYfgagKOdJgLxQxgjwEMZ3xPAiNsmtM
 V4mAZPeunJF1FAuz1lXnnG2M8RmwJ/5AtO8YL/VpTdOmfsRRjzpNLpa8meYkP1fBM456
 qD/mwJs4HPl3Du3CIH0q8AvX+VL6UnviS8/+KSGtQEVHDe6DfQYq+81cE9AVoVqJla5e
 8lwA40kOwhhOLFlHB207DY5VCKhhSJk0I8Ge0/fre7MmTNoWPYHIPmXZOASv0XhhLSft ng== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xf5kc836r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 14:01:34 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43CE1Xe3002193;
	Fri, 12 Apr 2024 14:01:33 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xf5kc836p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 14:01:33 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43CC1AJr021479;
	Fri, 12 Apr 2024 14:01:32 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xbjxm9whd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 14:01:32 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43CE1Ul910420964
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 14:01:32 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F14685807D;
	Fri, 12 Apr 2024 14:01:29 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 816D358072;
	Fri, 12 Apr 2024 14:01:29 +0000 (GMT)
Received: from sbct-3.bos2.lab (unknown [9.47.158.153])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 12 Apr 2024 14:01:29 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org, linux-unionfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        roberto.sassu@huawei.com, amir73il@gmail.com, miklos@szeredi.hu,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [RFC 2/2] ima: Fix detection of read/write violations on stacked filesystems
Date: Fri, 12 Apr 2024 10:01:22 -0400
Message-ID: <20240412140122.2607743-3-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412140122.2607743-1-stefanb@linux.ibm.com>
References: <20240412140122.2607743-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: F66x76YQQK7e3KFcjK8xmYKVfx3CRbU_
X-Proofpoint-GUID: dGfdMG9kHsPPIYDH-CQ5EZKWf7XlgOYw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_10,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 mlxlogscore=665 phishscore=0 suspectscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404120101

On a stacked filesystem, when one process opens the file holding a file's
data (e.g., on upper or lower layer on overlayfs) then issue a violation
when another process opens the file for reading on the top layer (overlay
layer on overlayfs). This then provides similar behavior to the existing
case where a violation is generated when one process opens a file for
writing and another one opens the same file for reading. On stacked
filesystem also search all the lower layers for relevant files opened for
writing and issue the violation if one is found.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 security/integrity/ima/ima_main.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index f04f43af651c..590dd9d5d99a 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -121,8 +121,11 @@ static void ima_rdwr_violation_check(struct file *file,
 				     const char **pathname,
 				     char *filename)
 {
+	struct inode *real_inode = d_real_inode(file_dentry(file));
 	struct inode *inode = file_inode(file);
+	struct dentry *fd_dentry, *d;
 	fmode_t mode = file->f_mode;
+	struct inode *fd_inode;
 	bool send_tomtou = false, send_writers = false;
 
 	if (mode & FMODE_WRITE) {
@@ -134,11 +137,25 @@ static void ima_rdwr_violation_check(struct file *file,
 						&iint->atomic_flags))
 				send_tomtou = true;
 		}
-	} else {
-		if (must_measure)
-			set_bit(IMA_MUST_MEASURE, &iint->atomic_flags);
-		if (inode_is_open_for_write(inode) && must_measure)
-			send_writers = true;
+	} else if (must_measure) {
+		set_bit(IMA_MUST_MEASURE, &iint->atomic_flags);
+
+		if (inode == real_inode) {
+			if (inode_is_open_for_write(inode))
+				send_writers = true;
+		} else {
+			d = d_real(file_dentry(file), D_REAL_FILEDATA);
+			do {
+				fd_dentry = d;
+				fd_inode = d_inode(fd_dentry);
+				if (inode_is_open_for_write(fd_inode)) {
+					send_writers = true;
+					break;
+				}
+				/* next layer of stacked fs */
+				d = d_real(fd_dentry, D_REAL_FILEDATA);
+			} while (d != fd_dentry);
+		}
 	}
 
 	if (!send_tomtou && !send_writers)
-- 
2.43.0


