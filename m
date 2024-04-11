Return-Path: <linux-kernel+bounces-141337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8518A1CD4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 112B31F211B3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9785446DB;
	Thu, 11 Apr 2024 16:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZRDGRD1C"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2104437C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 16:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712853642; cv=none; b=lfuYKYCMuRrBYLsQg4DTFybu0jurpmqi/NFr2aOiFRtt3FpOtRHZVAC4nfAJtZZbc66CabIXAAteyBPlrzmo7l+iHbnazWL8ATuy9uAr9GIvm2y9c4Y32rIFvkhqwFZrnE33c6DiyJetHAzHjJjsMbMkS5kBWPf1UcRMlBBbhE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712853642; c=relaxed/simple;
	bh=m/w90s13kH6AsJ4zBD4v4yx0y6IqxDrEiPBEL4UNSHE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G/SiPs1O8NBX5JDmX6bp+Uzp6HzUTTXsrbf4cxu6cbJq+8k/leF7w60GahbuHzz5hQt2TBFAqhr+EbmGV0lzEIP+zKLXzBF6Mrm9cDCqjPXrPGQWntnzM61KlruHdge0n3jIt87NRI+GWteDRYpf0KCclumlAey2SoHy5cvE/0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZRDGRD1C; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43BGYf1e014847;
	Thu, 11 Apr 2024 16:40:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=zc8zh/JRJr57ikJjyKewTyO/joTKoeW778VhZry+YzE=;
 b=ZRDGRD1CdK6G/GXzV3ozOOs+o84j4iR+AsKHEYm68h7+yQLgstOqjIhHJ1ooH8jewcXA
 A+tCorR+xZ6KZpNk8ExJNouqY5v2uTtta623VUDqmlaidkxs26zHrPIzaaP45QvA1uPe
 +wt0u7WYA6RPe00qu7QwPTzj5y8yGL4IIsizUxdOu9er2SYqRtiQfgExmpDCqJQadxge
 05tZtzy+gpwkLOBt8KvuLHb0b0Z4k+6DqHxebb2P3bzFJa8T9WKcpqpZ4RcivmY9ux6U
 th/Erj+xsdSM2rlrCQwkv+zkpKBAUro020GwWrh9FNwkqX5aIecmPLLmd/dK+lkuuOe1 Ug== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xed4jrudt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Apr 2024 16:40:25 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43BFoP7h032343;
	Thu, 11 Apr 2024 16:40:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xavuadhnd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Apr 2024 16:40:24 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43BGduJQ008535;
	Thu, 11 Apr 2024 16:40:24 GMT
Received: from jfwang-mac.us.oracle.com (dhcp-10-159-230-44.vpn.oracle.com [10.159.230.44])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3xavuadhma-1;
	Thu, 11 Apr 2024 16:40:24 +0000
From: Jianfeng Wang <jianfeng.w.wang@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        junxiao.bi@oracle.com
Subject: [PATCH] slub: limit number of slabs to scan in count_partial()
Date: Thu, 11 Apr 2024 09:40:23 -0700
Message-ID: <20240411164023.99368-1-jianfeng.w.wang@oracle.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_09,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404110122
X-Proofpoint-GUID: -SwOfn8GKUt0X4zWUsz5phuu6G-mtB0D
X-Proofpoint-ORIG-GUID: -SwOfn8GKUt0X4zWUsz5phuu6G-mtB0D

When reading "/proc/slabinfo", the kernel needs to report the number
of free objects for each kmem_cache. The current implementation relies
on count_partial() that counts the number of free objects by scanning
each kmem_cache_node's list of partial slabs and summing free objects
from every partial slab in the list. This process must hold per
kmem_cache_node spinlock and disable IRQ and may take a long time.
Consequently, it can block slab allocation requests on other CPU cores
and cause timeouts for network devices etc., when the partial slab list
is long. In production, even NMI watchdog can be triggered due to this
matter: e.g., for "buffer_head", the number of partial slabs was
observed to be ~1M in one kmem_cache_node. This problem was also
confirmed by several others [1-3] in the past.

Iterating a partial list to get the exact count of objects can cause
soft lockups for a long list with or without the lock (e.g., if
preemption is disabled), and is not very useful too: the object
count can change right after the lock is released. The approach of
maintaining free-object counters requires atomic operations on the
fast path [3].

So, the fix is to limit the number of slabs to scan in
count_partial(), and output an approximated result if the list is too
long. Default to 10000 which should be enough for most sane cases.

[1] https://lore.kernel.org/linux-mm/
alpine.DEB.2.21.2003031602460.1537@www.lameter.com/T/
[2] https://lore.kernel.org/lkml/
alpine.DEB.2.22.394.2008071258020.55871@www.lameter.com/T/
[3] https://lore.kernel.org/lkml/
1e01092b-140d-2bab-aeba-321a74a194ee@linux.com/T/

Signed-off-by: Jianfeng Wang <jianfeng.w.wang@oracle.com>
---
 mm/slub.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 1bb2a93cf7b6..5ed998ec7d6d 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3213,16 +3213,25 @@ static inline bool free_debug_processing(struct kmem_cache *s,
 #endif /* CONFIG_SLUB_DEBUG */
 
 #if defined(CONFIG_SLUB_DEBUG) || defined(SLAB_SUPPORTS_SYSFS)
+#define MAX_PARTIAL_TO_SCAN 10000
+
 static unsigned long count_partial(struct kmem_cache_node *n,
 					int (*get_count)(struct slab *))
 {
 	unsigned long flags;
 	unsigned long x = 0;
+	unsigned long scanned = 0;
 	struct slab *slab;
 
 	spin_lock_irqsave(&n->list_lock, flags);
-	list_for_each_entry(slab, &n->partial, slab_list)
+	list_for_each_entry(slab, &n->partial, slab_list) {
 		x += get_count(slab);
+		if (++scanned > MAX_PARTIAL_TO_SCAN) {
+			/* Approximate total count of objects */
+			x = mult_frac(x, n->nr_partial, scanned);
+			break;
+		}
+	}
 	spin_unlock_irqrestore(&n->list_lock, flags);
 	return x;
 }
-- 
2.42.1


