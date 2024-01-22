Return-Path: <linux-kernel+bounces-33862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF1F83704F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70643B280D8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E0E4B5C6;
	Mon, 22 Jan 2024 17:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="na3zs/SB"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE814B5B5;
	Mon, 22 Jan 2024 17:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705945792; cv=none; b=RuRHiXBUbn3DTqmz7LEzG4auiwVrEgSJ03p5vq64j/EfMvnDEiKHwweV3aBMSCg4cbxJNx7foq/pMv43sB+ivE6043Eq9Sk0+x2MiKvVO+5RFtZiav3AhKw8UPhNjrMx54x/po2g3y3ivTzFltvCobA+WvsRRgL5LYRxcgDkeIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705945792; c=relaxed/simple;
	bh=HNfxO4OVAOMMPCvuJ/CYiuWPFlxMpg2ulzsvYKkIrm0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LatzuI83nL4j5qI63LMUZ9o0EkntgHMjonLlN7z+ar5q7teTU5PpGoqzqtighKMHuSZsI91yyVERDrugWj6B8Bgt1tjOIZHT5BOIeag2SA+LwkSy0Ewr5nH8QeTWI6/0fD2zZjwXxQP2Va3vgifW5YruZ1HkJflDs8OWctYp15o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=na3zs/SB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40MHTuAd004239;
	Mon, 22 Jan 2024 17:49:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=qyDB3MUGpiqwHmFDZQYonWrl45UOQmMx3+ebuJTdasw=;
 b=na3zs/SBIIK0E9HV0MK2minHOi+C4UdBnZqpcJPqkJvHyjefvZOtCr8h2yOl0rUIRn/P
 nzFsykyUHFpJPFnD1IAc9kXEKRKb8bTppE3VHBo+LqVhCtNOxp5lG235mUpBigSTJG3F
 LEze+7L7bBqU5FO4fcHP4hQWsP9P1IokfZBPSqUuM0rbfWIj+2dMtLGS0A51iMaT1f9t
 nOlCz84TuWFrt3B4Rq+5F0lK/rdyIXM+p07RRYtxKk2BTMAk76/BIzyADqplsPENpz/W
 SHYjA01G8JJJmCp5PzWkKQ+4TWL4HYOC4wlbXmHMHR8all9izUPRQnb+bW+6yEW5fGom 2Q== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vstkfdt4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 17:49:21 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40MGFaSN022510;
	Mon, 22 Jan 2024 17:49:20 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vrt0kt2mc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 17:49:20 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40MHnIAX15860470
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jan 2024 17:49:18 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B2E4020043;
	Mon, 22 Jan 2024 17:49:18 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0003A20040;
	Mon, 22 Jan 2024 17:49:15 +0000 (GMT)
Received: from li-c1fdab4c-355a-11b2-a85c-ef242fe9efb4.ibm.com.com (unknown [9.43.53.45])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 22 Jan 2024 17:49:15 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: sshegde@linux.ibm.com, mpe@ellerman.id.au, mingo@kernel.org,
        peterz@infradead.org, chandan.babu@oracle.com, anton@tuxera.com,
        djwong@kernel.org
Subject: [RFC PATCH v2 2/4] xfs: remove duplicate ifdefs
Date: Mon, 22 Jan 2024 23:19:02 +0530
Message-Id: <20240122174904.178594-3-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240122174904.178594-1-sshegde@linux.ibm.com>
References: <20240122174904.178594-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: hnGm0V7dji-YQfItNaSxH8to-qPFXDCc
X-Proofpoint-GUID: hnGm0V7dji-YQfItNaSxH8to-qPFXDCc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_07,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=816
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 phishscore=0
 mlxscore=0 malwarescore=0 adultscore=0 clxscore=1015 impostorscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401220124

when a ifdef is used in the below manner, second one could be considered as
duplicate.

ifdef DEFINE_A
..code block...
ifdef DEFINE_A
..code block...
endif
..code block...
endif

In the xfs code two such patterns were seen. Hence removing these ifdefs.
No functional change is intended here. It only aims to improve code
readability.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 fs/xfs/xfs_sysfs.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/xfs/xfs_sysfs.c b/fs/xfs/xfs_sysfs.c
index 17485666b672..d2391eec37fe 100644
--- a/fs/xfs/xfs_sysfs.c
+++ b/fs/xfs/xfs_sysfs.c
@@ -193,7 +193,6 @@ always_cow_show(
 }
 XFS_SYSFS_ATTR_RW(always_cow);

-#ifdef DEBUG
 /*
  * Override how many threads the parallel work queue is allowed to create.
  * This has to be a debug-only global (instead of an errortag) because one of
@@ -260,7 +259,6 @@ larp_show(
 	return snprintf(buf, PAGE_SIZE, "%d\n", xfs_globals.larp);
 }
 XFS_SYSFS_ATTR_RW(larp);
-#endif /* DEBUG */

 STATIC ssize_t
 bload_leaf_slack_store(
@@ -319,10 +317,8 @@ static struct attribute *xfs_dbg_attrs[] = {
 	ATTR_LIST(log_recovery_delay),
 	ATTR_LIST(mount_delay),
 	ATTR_LIST(always_cow),
-#ifdef DEBUG
 	ATTR_LIST(pwork_threads),
 	ATTR_LIST(larp),
-#endif
 	ATTR_LIST(bload_leaf_slack),
 	ATTR_LIST(bload_node_slack),
 	NULL,
--
2.39.3


