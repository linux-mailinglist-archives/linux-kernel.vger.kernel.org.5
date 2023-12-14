Return-Path: <linux-kernel+bounces-190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 373EB813D42
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 23:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 696771C21E12
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1062967207;
	Thu, 14 Dec 2023 22:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Gx18r61u"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1614467216
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 22:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BEMHP2J032548;
	Thu, 14 Dec 2023 22:27:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=vWebtL2rhfE1sZveziVMAIBgy0M/wp/MnldOKJtCGJA=;
 b=Gx18r61ud07Dn6edn9pWwaJ7Z63e0Kz9zITNQAXzM0QfCuGWEI90KvM7sS4J0Dh5GxEL
 UGMtJreLR2/0op/a1T3XQ+z6JWTJrkLd61aj7rU6OajKxZ8siqrOkW73yEdN2T89ektb
 //FuSiaGwXxFikHP50hwbuFwWSzt+QY9q3U+zmaN2Vz6PwcHMsi0270MYEi6QL7n4ybv
 hUqlLV7pS+lencdsArH6e1iRvIwRgwwPO7BP7yWQWkXUvMOS5unrLiRC1tZz0o/KqoqK
 ljlY1leGL10IqEcKY4Im1bMXEp3w1KsGePr9jWaKyPrpMaFejUYZqQsehQXb3lk+osZH 7Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvgsum0rw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Dec 2023 22:27:20 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BELD9D8008284;
	Thu, 14 Dec 2023 22:27:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvepaug4d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Dec 2023 22:27:19 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BEMRImB001139;
	Thu, 14 Dec 2023 22:27:19 GMT
Received: from jfwang-mac.us.oracle.com (dhcp-10-65-130-157.vpn.oracle.com [10.65.130.157])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3uvepaug41-1;
	Thu, 14 Dec 2023 22:27:18 +0000
From: Jianfeng Wang <jianfeng.w.wang@oracle.com>
To: akpm@linux-foundation.org
Cc: tim.c.chen@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Jianfeng Wang <jianfeng.w.wang@oracle.com>
Subject: [PATCH v2] mm: remove redundant lru_add_drain() prior to unmapping pages
Date: Thu, 14 Dec 2023 14:27:17 -0800
Message-ID: <20231214222717.50277-1-jianfeng.w.wang@oracle.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-14_15,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312140159
X-Proofpoint-ORIG-GUID: 7K-1cvQBvkGHX_8Z6IKaJyasvuhRD8p7
X-Proofpoint-GUID: 7K-1cvQBvkGHX_8Z6IKaJyasvuhRD8p7

When unmapping VMA pages, pages will be gathered in batch and released by
tlb_finish_mmu() if CONFIG_MMU_GATHER_NO_GATHER is not set. The function
tlb_finish_mmu() is responsible for calling free_pages_and_swap_cache(),
which calls lru_add_drain() to drain cached pages in folio_batch before
releasing gathered pages. Thus, it is redundant to call lru_add_drain()
before gathering pages, if CONFIG_MMU_GATHER_NO_GATHER is not set.

Remove lru_add_drain() prior to gathering and unmapping pages in
exit_mmap() and unmap_region() if CONFIG_MMU_GATHER_NO_GATHER is not set.

Note that the page unmapping process in oom_killer (e.g., in
__oom_reap_task_mm()) also uses tlb_finish_mmu() and does not have
redundant lru_add_drain(). So, this commit makes the code more consistent.

Signed-off-by: Jianfeng Wang <jianfeng.w.wang@oracle.com>
---
 mm/mmap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index 1971bfffcc03..da0308eef435 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2330,7 +2330,10 @@ static void unmap_region(struct mm_struct *mm, struct ma_state *mas,
 	struct mmu_gather tlb;
 	unsigned long mt_start = mas->index;
 
+	/* Defer lru_add_drain() to tlb_finish_mmu() for the ifndef case. */
+#ifdef CONFIG_MMU_GATHER_NO_GATHER
 	lru_add_drain();
+#endif
 	tlb_gather_mmu(&tlb, mm);
 	update_hiwater_rss(mm);
 	unmap_vmas(&tlb, mas, vma, start, end, tree_end, mm_wr_locked);
@@ -3300,7 +3303,10 @@ void exit_mmap(struct mm_struct *mm)
 		return;
 	}
 
+	/* Defer lru_add_drain() to tlb_finish_mmu() for the ifndef case. */
+#ifdef CONFIG_MMU_GATHER_NO_GATHER
 	lru_add_drain();
+#endif
 	flush_cache_mm(mm);
 	tlb_gather_mmu_fullmm(&tlb, mm);
 	/* update_hiwater_rss(mm) here? but nobody should be looking */
-- 
2.42.1


