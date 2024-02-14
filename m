Return-Path: <linux-kernel+bounces-65552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9234A854E9F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F0DA288042
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E344E60DEE;
	Wed, 14 Feb 2024 16:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mOnBVfN/"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BB060254;
	Wed, 14 Feb 2024 16:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707928370; cv=none; b=l8UxkHCPaqa5Uau9h6SmEtWeawdKmLeSTk6Q/mZK1KpCLhLyjSJT6yK4DOu4P0Ez8pnGHwTSZECPp70vifHDkQsm87sC10gvv7ektAkOIeUTny0CHET5HcsZI68aRrYqfYeTQOAr3yszjMZQEoRNw0ibH9XMqCALeDzo2uhM7Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707928370; c=relaxed/simple;
	bh=03sJ2hDczb8lu598NQs1X/W4Y9/EjHIxR85MWTfK+Lw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pbLplNxghDh4kyiuYEHhaOZOLkk1tzqAmvM+CzNTOSdwKKebDEVkQs8sz3V7uIuE1Rg9bd3RE1zORc7aSasEmGgxo0mAOFPJl2AfCwCNAINvFQBY/1YarHJPLcNqDmDWpiUqnyWHpN6xL368bfYxcNsz31Z1ajkja/TXXpO6PkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mOnBVfN/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41EGRJQv006641;
	Wed, 14 Feb 2024 16:32:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=WKALQ+lDwn3emaVlHdtwZPAsOGX41pzOtb3nal5YbHw=;
 b=mOnBVfN/M6FlaiowH1cEnmD2IShhFtEflD+UyjiLFT/VhzGzwfp0FUb+lljv45D8qLy9
 guO8wARGgCFNUcTed07mgTwsoy2fpC5NbCjrFEi8GWLvDKWwBRMpyJl6qBWbZJp8xAh/
 OHuLi+Sq0gJuqXjy2ubyZV/2D+Cgt57P+b6FTd8PEF7HrkM/xcpC3rPFBP4TcgzD6MJd
 155h7v7nN/vll1SuA9eHOhvxwZg2BmRHhv7kwvwbO+FohnKJLd7a/plcY1iG/P0g+5xA
 QR0BhSVT2uNaafuAF2i2Spyds5clhFG8RaqGuIXwMUJI0P45en1f20Wndt7LRw1TEaY1 jQ== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w912385rk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 16:32:47 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41EDtcN9016184;
	Wed, 14 Feb 2024 16:32:46 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6mympwda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 16:32:46 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41EGWe0162914960
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 16:32:42 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 625072004B;
	Wed, 14 Feb 2024 16:32:40 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 52B1E20043;
	Wed, 14 Feb 2024 16:32:40 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 14 Feb 2024 16:32:40 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 145D6E1774; Wed, 14 Feb 2024 17:32:40 +0100 (CET)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Alexandra Winter <wintera@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net/iucv: fix the allocation size of iucv_path_table array
Date: Wed, 14 Feb 2024 17:32:40 +0100
Message-Id: <20240214163240.2537189-1-agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aci-nP1IVeIgb66j2QNZ_uqq5RFYFdm8
X-Proofpoint-ORIG-GUID: aci-nP1IVeIgb66j2QNZ_uqq5RFYFdm8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_09,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0
 mlxlogscore=900 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2402140129

iucv_path_table is a dynamically allocated array of pointers to
struct iucv_path items. Yet, its size is calculated as if it was
an array of struct iucv_path items.

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 net/iucv/iucv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/iucv/iucv.c b/net/iucv/iucv.c
index 9e62783e6acb..5b56ae6612dd 100644
--- a/net/iucv/iucv.c
+++ b/net/iucv/iucv.c
@@ -156,7 +156,7 @@ static char iucv_error_pathid[16] = "INVALID PATHID";
 static LIST_HEAD(iucv_handler_list);
 
 /*
- * iucv_path_table: an array of iucv_path structures.
+ * iucv_path_table: array of pointers to iucv_path structures.
  */
 static struct iucv_path **iucv_path_table;
 static unsigned long iucv_max_pathid;
@@ -545,7 +545,7 @@ static int iucv_enable(void)
 
 	cpus_read_lock();
 	rc = -ENOMEM;
-	alloc_size = iucv_max_pathid * sizeof(struct iucv_path);
+	alloc_size = iucv_max_pathid * sizeof(*iucv_path_table);
 	iucv_path_table = kzalloc(alloc_size, GFP_KERNEL);
 	if (!iucv_path_table)
 		goto out;
-- 
2.40.1


