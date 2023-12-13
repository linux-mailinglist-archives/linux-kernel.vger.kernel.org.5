Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76FB810B77
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 08:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbjLMH2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 02:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbjLMH2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 02:28:30 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64523AD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 23:28:33 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BD7DwYO024904;
        Wed, 13 Dec 2023 07:28:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=RbfgNqZ+9WSCH8jBvjKjM/9Hh1JGThZebaRgzWJuirs=;
 b=jxCTjV64zJHBZ4WQ0uI5LhDxFcSWVEIK+CoUmbV+1nzHgr3gCloRMxhYV3BvHdteemRc
 +m45CNBRcD66ycEwlSN7CFAXJrJHtxCl2n7B87t7IvmpfbV7gElu0vKXJbnkKxkpdqQ6
 uVFsk71rIaoKjdLiQXwuXG6DydU2MS1cVM7aXJUcj8IIOa0L/qDOcBF/T0rrgfg0lriA
 8GJP5K5eVyKTaAfKqRkSCIAAXRv48c0AC7Gg6lYrJy/cUtxqpz3AN6whvIAWmAKYBTS6
 VTqFUlk4Ryqe1+BCLAHvL18peaTlOQasVle3svyhWcQ0c7y9m0M+N+RgssShK/JvP/13 6g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvgsufja0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Dec 2023 07:28:29 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BD70Idl010147;
        Wed, 13 Dec 2023 07:28:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep7tej6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Dec 2023 07:28:27 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BD7SRdv020500;
        Wed, 13 Dec 2023 07:28:27 GMT
Received: from jfwang-mac.us.oracle.com (dhcp-10-159-129-184.vpn.oracle.com [10.159.129.184])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3uvep7te97-1;
        Wed, 13 Dec 2023 07:28:27 +0000
From:   Jianfeng Wang <jianfeng.w.wang@oracle.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jianfeng Wang <jianfeng.w.wang@oracle.com>
Subject: [PATCH] mm: remove redundant lru_add_drain() prior to unmapping pages
Date:   Tue, 12 Dec 2023 23:28:05 -0800
Message-ID: <20231213072805.74201-1-jianfeng.w.wang@oracle.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_14,2023-12-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312130053
X-Proofpoint-ORIG-GUID: HraMxghePdLtKHJbsbQnLR9EzC-2LppB
X-Proofpoint-GUID: HraMxghePdLtKHJbsbQnLR9EzC-2LppB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 mm/mmap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index 1971bfffcc03..0451285dee4f 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2330,7 +2330,9 @@ static void unmap_region(struct mm_struct *mm, struct ma_state *mas,
 	struct mmu_gather tlb;
 	unsigned long mt_start = mas->index;
 
+#ifdef CONFIG_MMU_GATHER_NO_GATHER
 	lru_add_drain();
+#endif
 	tlb_gather_mmu(&tlb, mm);
 	update_hiwater_rss(mm);
 	unmap_vmas(&tlb, mas, vma, start, end, tree_end, mm_wr_locked);
@@ -3300,7 +3302,9 @@ void exit_mmap(struct mm_struct *mm)
 		return;
 	}
 
+#ifdef CONFIG_MMU_GATHER_NO_GATHER
 	lru_add_drain();
+#endif
 	flush_cache_mm(mm);
 	tlb_gather_mmu_fullmm(&tlb, mm);
 	/* update_hiwater_rss(mm) here? but nobody should be looking */
-- 
2.42.1

