Return-Path: <linux-kernel+bounces-129350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EABB08968E9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A22461F239E3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C33E6D1BA;
	Wed,  3 Apr 2024 08:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hUQVwZ6V"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4CC6E612
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 08:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712133571; cv=none; b=dVGKUnBs+l39YYUnfE0wEYBXVHCDIMEEqj3o49U6i06Mrp29t499ka/9ElUH3IqsiMOizCNHnSkH6d/sUW9frelEAB711WsEV2/7hSnEE+x9zROWgUPmCEBU+poulpuq7dDxvfNpHEqqAGSclxhdzEtK4yFbwzhj0DLg2+EMCIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712133571; c=relaxed/simple;
	bh=YDZsT3FH8Z43wWloCSkC1JxcBkcTwvbBFlN13oPYFP8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FEDU/NKI4atuatFcE08+4XUSb1nuVvgRzKhBZf3ZZcM3GeXPV25tTL5o4NPLd0nGPW6CDgoPkDAjp3gmTAr/e+RXS8ieHqMrvUzkgWli5UUgkHlf4pWY/84WDxAfCo0eYd72lunJDzp8OBitKPar+4a+dlsGtDsjLI65ZlECfjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hUQVwZ6V; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712133561; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=oLhTr2J/3wy/5GEpHjjzFAy9UR1eWN6w8XG4KoPFC1k=;
	b=hUQVwZ6VvtJ26cr6CaZEKy4SZwLqiDE9GVTCLyfnFCsWctyuGXyv4pLMp2USlZSZW1kS7XHrZpx30Z9qUc92Ycl8oLec3eBJVILzYsSyTrOLiqA7wKnjReOXS626nsLB2mEqI4+PF3xa9G3OnVzW/ntmCRjNLYmb/EUAAFn2pSw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W3r8YaY_1712133559;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W3r8YaY_1712133559)
          by smtp.aliyun-inc.com;
          Wed, 03 Apr 2024 16:39:20 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org
Cc: david@redhat.com,
	mgorman@techsingularity.net,
	wangkefeng.wang@huawei.com,
	jhubbard@nvidia.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] mm: factor out the numa mapping rebuilding into a new helper
Date: Wed,  3 Apr 2024 16:39:09 +0800
Message-Id: <24736d92416099336a1d0738f0afb062a8127be4.1712132950.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1712132950.git.baolin.wang@linux.alibaba.com>
References: <cover.1712132950.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To support large folio's numa balancing, factor out the numa mapping rebuilding
into a new helper as a preparation.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
---
 mm/memory.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 62ee4a15092a..c30fb4b95e15 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5054,6 +5054,20 @@ int numa_migrate_prep(struct folio *folio, struct vm_fault *vmf,
 	return mpol_misplaced(folio, vmf, addr);
 }
 
+static void numa_rebuild_single_mapping(struct vm_fault *vmf, struct vm_area_struct *vma,
+					bool writable)
+{
+	pte_t pte, old_pte;
+
+	old_pte = ptep_modify_prot_start(vma, vmf->address, vmf->pte);
+	pte = pte_modify(old_pte, vma->vm_page_prot);
+	pte = pte_mkyoung(pte);
+	if (writable)
+		pte = pte_mkwrite(pte, vma);
+	ptep_modify_prot_commit(vma, vmf->address, vmf->pte, old_pte, pte);
+	update_mmu_cache_range(vmf, vma, vmf->address, vmf->pte, 1);
+}
+
 static vm_fault_t do_numa_page(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
@@ -5159,13 +5173,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	 * Make it present again, depending on how arch implements
 	 * non-accessible ptes, some can allow access by kernel mode.
 	 */
-	old_pte = ptep_modify_prot_start(vma, vmf->address, vmf->pte);
-	pte = pte_modify(old_pte, vma->vm_page_prot);
-	pte = pte_mkyoung(pte);
-	if (writable)
-		pte = pte_mkwrite(pte, vma);
-	ptep_modify_prot_commit(vma, vmf->address, vmf->pte, old_pte, pte);
-	update_mmu_cache_range(vmf, vma, vmf->address, vmf->pte, 1);
+	numa_rebuild_single_mapping(vmf, vma, writable);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
 	goto out;
 }
-- 
2.39.3


