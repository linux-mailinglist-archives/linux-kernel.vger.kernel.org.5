Return-Path: <linux-kernel+bounces-33863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62754836FAF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 927EA1C28AE4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B32B4B5DE;
	Mon, 22 Jan 2024 17:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rPYZGmvR"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1B94B5B9;
	Mon, 22 Jan 2024 17:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705945793; cv=none; b=dnZbUN+ixuXdYUIH9iO1etPWbUmQ9eKGXKJITIYyJN7ElbJjBow+RWsZvGsUNGLlV7G3REb3SbyJbWvvffFxi5CmLZwcI+Fznl98DvVen0Rk3jkOGf3BHyqRoMgeCmh1ogdH/L0iVx4/uiPNmjsiBoMfqIAgJgHDF3xothvAC1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705945793; c=relaxed/simple;
	bh=axKfD8tnqJACGtmYvtt/WTE+tZTeB748ijuSurjg3TE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f7Y3KXa1tn0zpQHB6NAoKXUIRYNGr2oOKCgEr8F6oiXUHpkDjwdDGtavNGwuOR4Gok9WgZg5sSH30Se1e6+3QNTw2tPDufpeCe9k1qmJmoVG1l3bhakQ7W9t5DMvxwTUnZ0zlnJGrqf3YuVQ8UMH23DHGF3k8ErFXpfHE4WAdpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rPYZGmvR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40MHekUM030654;
	Mon, 22 Jan 2024 17:49:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=KeUg6p5geUeb/5YLtDehZnb7ENy/rqnJYmLETJS5zEA=;
 b=rPYZGmvRvTrSHy9pog3AK8894pa5fARralnW3DykbaPMoOhYZWVGgig7PdCzzWW89nwq
 QIVIL5I4/A+YkywssC2RRMyro5StnWvwIztSlR7nV14dkzmBa/+0vpQtRaPcRUpvhfkk
 ylylfah7CqqehKiJuk6AArKSYPK5XiKIwGjDyNzXOwBvlR2LUKalyYzJy5DbYNcKtcYI
 yzu9hLWLqe2vpZSf4OhVGlLfUXJQ1BvqK1n7JFXwKwg9+ECZzkjARtuqK2Ner8oE29aY
 v/lX3vTD3A4ZwoZ+dqcmUkT7BVGGCxbZhbJKkpF18KFkjin7x2+vYHaXcwyPkR8TKbKs FQ== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vsurfa5q4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 17:49:25 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40MHA9CN025298;
	Mon, 22 Jan 2024 17:49:24 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vrtqk1uqp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 17:49:24 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40MHnMpm16974504
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jan 2024 17:49:22 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6DB262004F;
	Mon, 22 Jan 2024 17:49:22 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0EEB12005A;
	Mon, 22 Jan 2024 17:49:20 +0000 (GMT)
Received: from li-c1fdab4c-355a-11b2-a85c-ef242fe9efb4.ibm.com.com (unknown [9.43.53.45])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 22 Jan 2024 17:49:19 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: sshegde@linux.ibm.com, mpe@ellerman.id.au, mingo@kernel.org,
        peterz@infradead.org, chandan.babu@oracle.com, anton@tuxera.com,
        djwong@kernel.org
Subject: [RFC PATCH v2 3/4] ntfs: remove duplicate ifdefs
Date: Mon, 22 Jan 2024 23:19:03 +0530
Message-Id: <20240122174904.178594-4-sshegde@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: XeEMsl10Wmu77LMj_tWv9LOPZ8Y6ZYBd
X-Proofpoint-GUID: XeEMsl10Wmu77LMj_tWv9LOPZ8Y6ZYBd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_07,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=841 adultscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

In the ntfs code, one such pattern was seen. Hence remove that duplicate
ifdef.
No functional change is intended here. It only aims to improve code
readability.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 fs/ntfs/inode.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index aba1e22db4e9..d2c8622d53d1 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -2859,11 +2859,9 @@ int ntfs_truncate(struct inode *vi)
  *
  * See ntfs_truncate() description above for details.
  */
-#ifdef NTFS_RW
 void ntfs_truncate_vfs(struct inode *vi) {
 	ntfs_truncate(vi);
 }
-#endif

 /**
  * ntfs_setattr - called from notify_change() when an attribute is being changed
--
2.39.3


