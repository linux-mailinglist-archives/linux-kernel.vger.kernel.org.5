Return-Path: <linux-kernel+bounces-153603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A398AD041
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56E701C21F40
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735561534E2;
	Mon, 22 Apr 2024 15:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PkV6Kq3v"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB3B15217D;
	Mon, 22 Apr 2024 15:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713798443; cv=none; b=oqL2EPDmhBy28+YLg8J6kTYHdCOUUoRb5OEswqJz7Z3yw1R6nDMAKPkp9JSDa/da8iOsT2RmPD1j3dPEqZXcc2pcn1haV15BgW6e92mEr9J41RYTPyeOrLJNmhcdvfg3Lxa4vTrD8Oysdfzl3HZleW0fCezHtCerJgxc52mNZIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713798443; c=relaxed/simple;
	bh=9JnUA2M7ld+cdmtH5SExTOA4m2nU2g3VkDOtkWnpGRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nVebu9B/v75k/jlrIkYc7pxFhknBlVopEaSgTWxtd0iv19gU+ihJEs1thh9NwjGKxxpdNfRM0o+f4jEzHtkQl5DcwBubSBQQ7pRisex+VnUXLMFiRy5Hq7P/PBKfQOrcdrUVAztx3EvSVM8OHoSDg3yyoif+4pA2M8VjVepIhmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PkV6Kq3v; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43MEnRRp031035;
	Mon, 22 Apr 2024 15:07:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=CfL7MiiThw2Agk96Q2WmYQnMT87ZKq/BPxVs8GeYDHQ=;
 b=PkV6Kq3vDONA65I06A84onrC2BA9rTn1GZB0i/zH5P8fmc8CpPQJ70/kQtSVa0o7NYkA
 CMlLy81cc79fTQ7+VwPT0VxNIlCukfawsDINr4cTYORx3RFKk88ZGVAWCM00zWXH22EM
 Dky1FD1txBNWuCzRsI79P0o/UMYuzy78ygPdkJRaX/vKbupLee9vDZyHddkHsfZsmSyi
 C/68nEVbjOpww4+VOtEwXWbbkjQ/CQdK3vt9lOk/9+Yd0RUdfdlkqYwma6fI04eXdvoI
 2aDztbR4N5wUayiO7VVFw/jWAoIwvsYX4vSYrcof93u/R+4T5YORlB09zi9NYN2gaArz aA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xnt0501jk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 15:07:05 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43MF75L7030765;
	Mon, 22 Apr 2024 15:07:05 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xnt0501jj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 15:07:05 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43MBmHMw028328;
	Mon, 22 Apr 2024 15:07:04 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xmtr27ve2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 15:07:04 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43MF71OD54329610
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Apr 2024 15:07:03 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5EDB758053;
	Mon, 22 Apr 2024 15:07:01 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 85AAE58043;
	Mon, 22 Apr 2024 15:07:00 +0000 (GMT)
Received: from sbct-3.bos2.lab (unknown [9.47.158.153])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 22 Apr 2024 15:07:00 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org, linux-unionfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        roberto.sassu@huawei.com, amir73il@gmail.com, miklos@szeredi.hu,
        brauner@kernel.org, Stefan Berger <stefanb@linux.ibm.com>
Subject: [RFC PATCH v2 2/2] ima: Fix detection of read/write violations on stacked filesystems
Date: Mon, 22 Apr 2024 11:06:51 -0400
Message-ID: <20240422150651.2908169-3-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422150651.2908169-1-stefanb@linux.ibm.com>
References: <20240422150651.2908169-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2KSdtnbHGMLxs-JxKxr0E51uN_l0aoP0
X-Proofpoint-ORIG-GUID: jf-2JOobOTNWqrxHexaYVu1VCXNPeWLY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=547 clxscore=1015
 adultscore=0 impostorscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404220065

On a stacked filesystem, when one process opens the file holding a file's
data (e.g., on upper or lower layer on overlayfs) then issue a violation
when another process opens the file for reading on the top layer (overlay
layer on overlayfs). This then provides similar behavior to the existing
case where a violation is generated when one process opens a file for
writing and another one opens the same file for reading.

Convert the current code so that it can handle the normal case as well
as the stacked filesystem case. Therefore, use d_real with parameter
D_REAL_FILEDATA to get the next dentry holding the file data. On a normal
filesystem this would be the dentry of the file and on a stacked filesystem
this could be an upper or lower dentry. Check the dentry's inode for
writes and if it has any issue the violation. Otherwise continue onto the
next dentry given the current dentry by again calling d_real. On a normal
filesystem this would return the same dentry as before and on a stacked
filesystem it would return the next-level dentry, so either the upper
or lower dentry of the next lower layer.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 security/integrity/ima/ima_main.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index f04f43af651c..7d727c448dc7 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -122,7 +122,9 @@ static void ima_rdwr_violation_check(struct file *file,
 				     char *filename)
 {
 	struct inode *inode = file_inode(file);
+	struct dentry *fd_dentry, *d;
 	fmode_t mode = file->f_mode;
+	struct inode *fd_inode;
 	bool send_tomtou = false, send_writers = false;
 
 	if (mode & FMODE_WRITE) {
@@ -134,11 +136,20 @@ static void ima_rdwr_violation_check(struct file *file,
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
+		d = d_real(file_dentry(file), D_REAL_FILEDATA);
+		do {
+			fd_dentry = d;
+			fd_inode = d_inode(fd_dentry);
+			if (inode_is_open_for_write(fd_inode)) {
+				send_writers = true;
+				break;
+			}
+			/* next layer of stacked fs */
+			d = d_real(fd_dentry, D_REAL_FILEDATA);
+		} while (d != fd_dentry);
 	}
 
 	if (!send_tomtou && !send_writers)
-- 
2.43.0


