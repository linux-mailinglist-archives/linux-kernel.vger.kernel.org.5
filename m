Return-Path: <linux-kernel+bounces-118923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D191F88C143
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F15481C28457
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0636F06E;
	Tue, 26 Mar 2024 11:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="E9YYTQLK"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D7D6BFD4
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 11:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711453903; cv=none; b=SiySaDsl2+GwwaCfXUwEvzVkv84ce4Ywu3FyVewbBshzG6S8XIYEeWjbxPD+7nVjcuJOIFmzpQ8//ny4IpNpAi8dlyPmLpaku0AJlFr+ejx0dp7RiUgqtzdZf06TYG3GLC8ORtSsPfLIFqXcwr0gAOluniSNv4eQNicl3ILIoZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711453903; c=relaxed/simple;
	bh=CjMiHHK0L03KyOUlDKPhfGBdV6TJfoZKnXm4Ax2DJis=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W0bvGR1PieKEtmZK0VGbGk+pVyXGK2bZrfG3SotR5OXMdLJrf5U38NV8m/YPXiZom94yo8QpYe0mQ3iH8VBpkFjvY0jopD9/kPredRlIuNpjc+iQ5BG9dVomTW2/OnuVE0sgwZMO/NvcgQxNUEXV4Uvkso7jf5EGxTeuxVcT6Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=E9YYTQLK; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711453898; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=AwEXLIJvfOIlKePIj3JTyBX7Gpl2aDHZTADkmkUue0Y=;
	b=E9YYTQLKyaN0vUwzUblHt9XalptfA+r8h8ZDqSvFsVOgPv5ILyS38JIYSlnwTVdxjt6sF+Jn2M66RA/Hwy6dInQ2I7aCpAK2aU8pR2kP97BcejJ5iYW+H6Tmshy1f+9bYwbwwFV/F7NgnfiOVpGxkD7mqo43HMTGEY1d4lRYXVM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W3LK4ka_1711453896;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W3LK4ka_1711453896)
          by smtp.aliyun-inc.com;
          Tue, 26 Mar 2024 19:51:36 +0800
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
Subject: [PATCH 1/2] mm: factor out the numa mapping rebuilding into a new helper
Date: Tue, 26 Mar 2024 19:51:24 +0800
Message-Id: <0c9df470bd2a62af8cc707cf01e42c7c744dd927.1711453317.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1711453317.git.baolin.wang@linux.alibaba.com>
References: <cover.1711453317.git.baolin.wang@linux.alibaba.com>
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


