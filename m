Return-Path: <linux-kernel+bounces-72285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5350F85B19F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBB7B2822D6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCDB51C2C;
	Tue, 20 Feb 2024 03:48:46 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53891C2E
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 03:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708400925; cv=none; b=SeUpQSKFPRTRwOZyUI2+uLhOB/vUGReNzEIg+fgrdpiUiQJ5vsqxhNnGIZ1onh3GWuXfFUIBf7X8oVRSLaGnvP0lbIP6E4PRlmtwcnRM1hgCXprlj4FT+1YC7IlSVriLHLyrKIFoFPsdw3nX6Ob5vJlz9FR1hKVbbMVRteDRdio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708400925; c=relaxed/simple;
	bh=HZH4hKQzxLHFZ1M195Fil/k9uUanGNnlf5EBFb/dF+8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LnVTWssaRwKSYk6yQ5IeKLTPrBZogdlgTjvgi4Je5V8s6w8OUqczj/swJCC4ft8E4eNZqJhJluSPru2RgS15V4xKiwYne9sM3D80SpE91Bm0HTui2MT2RhvjDjNuLN6TI9dQGmcVCln3OmWdr9NJ5VGNAEjSdWTCrCxkMO0eHQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Tf4yF70nMz1FKnT;
	Tue, 20 Feb 2024 11:43:49 +0800 (CST)
Received: from dggpemd200001.china.huawei.com (unknown [7.185.36.224])
	by mail.maildlp.com (Postfix) with ESMTPS id 50EA11402DE;
	Tue, 20 Feb 2024 11:48:40 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemd200001.china.huawei.com (7.185.36.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Tue, 20 Feb 2024 11:48:39 +0800
From: Wupeng Ma <mawupeng1@huawei.com>
To: <akpm@linux-foundation.org>, <dave.hansen@linux.intel.com>,
	<luto@kernel.org>, <tglx@linutronix.de>, <peterz@infradead.org>,
	<hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <mawupeng1@huawei.com>,
	<bp@suse.de>, <mingo@redhat.com>, <rdunlap@infradead.org>,
	<bhelgaas@google.com>, <linux-mm@kvack.org>
Subject: [PATCH v4 1/3] x86/mm/pat: Move follow_phys to pat-related file
Date: Tue, 20 Feb 2024 11:48:33 +0800
Message-ID: <20240220034835.507022-2-mawupeng1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240220034835.507022-1-mawupeng1@huawei.com>
References: <20240220034835.507022-1-mawupeng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemd200001.china.huawei.com (7.185.36.224)

From: Ma Wupeng <mawupeng1@huawei.com>

Since only PAT in x86 use follow_phys(), move this to from memory.c to
memtype.c and make it static.

Since config HAVE_IOREMAP_PROT is selected by x86, drop this config macro.

Signed-off-by: Ma Wupeng <mawupeng1@huawei.com>
---
 arch/x86/mm/pat/memtype.c | 28 ++++++++++++++++++++++++++++
 include/linux/mm.h        |  2 --
 mm/memory.c               | 28 ----------------------------
 3 files changed, 28 insertions(+), 30 deletions(-)

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 0904d7e8e126..d8c37aaaf041 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -950,6 +950,34 @@ static void free_pfn_range(u64 paddr, unsigned long size)
 		memtype_free(paddr, paddr + size);
 }
 
+static int follow_phys(struct vm_area_struct *vma,
+		unsigned long address, unsigned int flags,
+		unsigned long *prot, resource_size_t *phys)
+{
+	int ret = -EINVAL;
+	pte_t *ptep, pte;
+	spinlock_t *ptl;
+
+	if (!(vma->vm_flags & (VM_IO | VM_PFNMAP)))
+		goto out;
+
+	if (follow_pte(vma->vm_mm, address, &ptep, &ptl))
+		goto out;
+	pte = ptep_get(ptep);
+
+	if ((flags & FOLL_WRITE) && !pte_write(pte))
+		goto unlock;
+
+	*prot = pgprot_val(pte_pgprot(pte));
+	*phys = (resource_size_t)pte_pfn(pte) << PAGE_SHIFT;
+
+	ret = 0;
+unlock:
+	pte_unmap_unlock(ptep, ptl);
+out:
+	return ret;
+}
+
 /*
  * track_pfn_copy is called when vma that is covering the pfnmap gets
  * copied through copy_page_range().
diff --git a/include/linux/mm.h b/include/linux/mm.h
index f5a97dec5169..75c683f2f5ae 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2375,8 +2375,6 @@ int follow_pte(struct mm_struct *mm, unsigned long address,
 	       pte_t **ptepp, spinlock_t **ptlp);
 int follow_pfn(struct vm_area_struct *vma, unsigned long address,
 	unsigned long *pfn);
-int follow_phys(struct vm_area_struct *vma, unsigned long address,
-		unsigned int flags, unsigned long *prot, resource_size_t *phys);
 int generic_access_phys(struct vm_area_struct *vma, unsigned long addr,
 			void *buf, int len, int write);
 
diff --git a/mm/memory.c b/mm/memory.c
index 15f8b10ea17c..86ad7f1ca3af 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5802,34 +5802,6 @@ int follow_pfn(struct vm_area_struct *vma, unsigned long address,
 EXPORT_SYMBOL(follow_pfn);
 
 #ifdef CONFIG_HAVE_IOREMAP_PROT
-int follow_phys(struct vm_area_struct *vma,
-		unsigned long address, unsigned int flags,
-		unsigned long *prot, resource_size_t *phys)
-{
-	int ret = -EINVAL;
-	pte_t *ptep, pte;
-	spinlock_t *ptl;
-
-	if (!(vma->vm_flags & (VM_IO | VM_PFNMAP)))
-		goto out;
-
-	if (follow_pte(vma->vm_mm, address, &ptep, &ptl))
-		goto out;
-	pte = ptep_get(ptep);
-
-	if ((flags & FOLL_WRITE) && !pte_write(pte))
-		goto unlock;
-
-	*prot = pgprot_val(pte_pgprot(pte));
-	*phys = (resource_size_t)pte_pfn(pte) << PAGE_SHIFT;
-
-	ret = 0;
-unlock:
-	pte_unmap_unlock(ptep, ptl);
-out:
-	return ret;
-}
-
 /**
  * generic_access_phys - generic implementation for iomem mmap access
  * @vma: the vma to access
-- 
2.25.1


