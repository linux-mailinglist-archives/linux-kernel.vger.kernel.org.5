Return-Path: <linux-kernel+bounces-137271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DE289DFBC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37715281CB6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FE313848D;
	Tue,  9 Apr 2024 15:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="koBP5gFl"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3136A136994;
	Tue,  9 Apr 2024 15:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712678077; cv=none; b=TxK12CcYXU9yXT1PNitYNWwBDGDXcXWhCIrMT6FaGDQWB3I7iOlgHBDpgcr9E/c0OqcjWSmUcq0Af4aS1+jTPKAeMX7/YFauSLDTzHAUHe4eiXq7gDwiEQCfI1w6oV2iMIBZ13z+tglXjdMQMc7uStGazjIVMQN29lgaRaeMf1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712678077; c=relaxed/simple;
	bh=deh9a6oj7S2gS2ULfJVmjBcpLmZfqHAkc6kcjO7qmUo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=lYV5EW6ZjtjS15CL11VZHWdrdZuhbSB6vJIswqcSgye4UObAOFYX8pOlp/PTLjFjErUlUFM/eaXeCktsy3AT6aAEHgM2biyybsAtH+jF7IRobtj0GkBQqfnGxesRpRgz2GlrZl/wttJYgh1u35rYqavjWjo/Ic42nJBzm/6NNlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=koBP5gFl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 439FR6dd010322;
	Tue, 9 Apr 2024 15:54:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=hltvEKuUiuAjdE9Nr1WEt7/LBEqngI0qozmlnXjnpxQ=;
 b=koBP5gFlerfgpNI8OIJu7AleYBawOadeGKFYBwnGA8Pk4vhUcPSTi1kbZQwhy6oGdE4t
 BXOZKClyN1Nni+3DzSdl+etqj0+SaDETd8LGqT8rx9/MK/qB5Hq2gI8nDyhlZx+DhwXq
 LwZWoL/gVB69eC8xcTsMEUwl0mIl28tDM/y/z6Ql7R84suftLYFhHbdoqAJduQOh3arO
 rXFoxTYOZM9tl5/wT4s4xwbXoy0nIXqLnI88eGASrrvNF+aS+/aO99AdLHVyKZi43zqv
 xU2STpY58crxyuJOhob0SqDqUq/t0CBnBTgbjkugVbymPopoVw1AlLIDNwtjI6YeZYsj RA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xd7rq05gc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 15:54:26 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 439FsNm6022291;
	Tue, 9 Apr 2024 15:54:23 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xd7rq05g8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 15:54:23 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 439Flq8D021485;
	Tue, 9 Apr 2024 15:54:22 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xbjxkpvrd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 15:54:22 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 439FsHGU29491696
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Apr 2024 15:54:19 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 507B82004B;
	Tue,  9 Apr 2024 15:54:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 232FB20040;
	Tue,  9 Apr 2024 15:54:17 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Apr 2024 15:54:17 +0000 (GMT)
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: akpm@linux-foundation.org, linux-mm@kvack.org
Cc: hughd@google.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, iii@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
Subject: [PATCH] mm/shmem: Inline shmem_is_huge() for disabled transparent hugepages
Date: Tue,  9 Apr 2024 17:54:07 +0200
Message-Id: <20240409155407.2322714-1-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Yh2qOqAwEPz1FAUnTgCuXIpzv-cWRku-
X-Proofpoint-ORIG-GUID: O04OGiBclUlW1kPL5W7uXFQepVAMoGO2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_11,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 mlxlogscore=569
 suspectscore=0 priorityscore=1501 clxscore=1011 phishscore=0 adultscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404090104

In order to  minimize code size (CONFIG_CC_OPTIMIZE_FOR_SIZE=y),
compiler might choose to make a regular function call (out-of-line) for
shmem_is_huge() instead of inlining it. When transparent hugepages are
disabled (CONFIG_TRANSPARENT_HUGEPAGE=n), it can cause compilation
error.

mm/shmem.c: In function ‘shmem_getattr’:
/include/linux/huge_mm.h:383:27: note: in expansion of macro ‘BUILD_BUG’
  383 | #define HPAGE_PMD_SIZE ({ BUILD_BUG(); 0; })
      |                           ^~~~~~~~~
mm/shmem.c:1148:33: note: in expansion of macro ‘HPAGE_PMD_SIZE’
 1148 |                 stat->blksize = HPAGE_PMD_SIZE;

To prevent the possible error, always inline shmem_is_huge() when
transparent hugepages are disabled.

Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 include/linux/shmem_fs.h | 9 +++++++++
 mm/shmem.c               | 6 ------
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index a4c15db2f5e5..3fb18f7eb73e 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -110,8 +110,17 @@ extern struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
 extern void shmem_truncate_range(struct inode *inode, loff_t start, loff_t end);
 int shmem_unuse(unsigned int type);
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 extern bool shmem_is_huge(struct inode *inode, pgoff_t index, bool shmem_huge_force,
 			  struct mm_struct *mm, unsigned long vm_flags);
+#else
+static __always_inline bool shmem_is_huge(struct inode *inode, pgoff_t index, bool shmem_huge_force,
+					  struct mm_struct *mm, unsigned long vm_flags)
+{
+	return false;
+}
+#endif
+
 #ifdef CONFIG_SHMEM
 extern unsigned long shmem_swap_usage(struct vm_area_struct *vma);
 #else
diff --git a/mm/shmem.c b/mm/shmem.c
index 0aad0d9a621b..94ab99b6b574 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -748,12 +748,6 @@ static long shmem_unused_huge_count(struct super_block *sb,
 
 #define shmem_huge SHMEM_HUGE_DENY
 
-bool shmem_is_huge(struct inode *inode, pgoff_t index, bool shmem_huge_force,
-		   struct mm_struct *mm, unsigned long vm_flags)
-{
-	return false;
-}
-
 static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
 		struct shrink_control *sc, unsigned long nr_to_split)
 {
-- 
2.40.1


