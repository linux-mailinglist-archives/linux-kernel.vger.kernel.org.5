Return-Path: <linux-kernel+bounces-138936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D891C89FC3B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04D1A1C20E26
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A9217167D;
	Wed, 10 Apr 2024 15:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ry6UqU38"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CC0171073
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 15:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712764568; cv=none; b=FXmhHiPSH65uvOjrnZo6Drxi8wI2DnwtfBnbF5ckbaDg0R9lLa75tzF1ACwl/lIckKiJ4cimJTtZuyjvA4Cq52hkBMXk6lvNzuYZVgXI7AFSAeqKBrLr4/DLT/mdLCFwg7bWrx7tBGup/3HfJ0xyxMtIg439RuQDT98cWMz7E9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712764568; c=relaxed/simple;
	bh=6DoHRazE2AdkkgvwQ+M9pwdyMbWO47BKIxioDARIWrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cMeMBOgZffaKa6PRtegItpTl/jKd0jV1tkZmcGUSRZCtQgDi3n9fjgv7iqtLk/Lb0lsb1X4u6+ApBEroALyeBSgPAwM8q+b7HgPgnv/7zMKqId0MEwsSi7FB+sEb32ChwLCUPOHWsBGw4NZ0iaZcuhCdvdn9ma9QxsclJGFiOZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ry6UqU38; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712764566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zm2HUbj93tLCBwYj5xez26lXQ8QRlBjo5saPfJK4BXw=;
	b=Ry6UqU38TdgFcsEVUMqLVa7UY+3G203hmp0UteBhqo2gEU26AGQS5HVN7nf5FmwEiz3rVY
	Icztt841ulhRItgHllpCSOH1b4QFrUanz3kZrUr0oWcl2YBbAT+hvSQO7ri0aQKtQM5H0L
	KnKieEbuxksCgdM33iiBR9Rb38OOuok=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-TxmI7OvqP0OHwoTn9q7Fqw-1; Wed, 10 Apr 2024 11:56:01 -0400
X-MC-Unique: TxmI7OvqP0OHwoTn9q7Fqw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3320B1805BE1;
	Wed, 10 Apr 2024 15:56:00 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.193.162])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 94236490FE;
	Wed, 10 Apr 2024 15:55:56 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	x86@kernel.org,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yonghua Huang <yonghua.huang@intel.com>,
	Fei Li <fei1.li@intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v1 2/3] mm: pass VMA instead of MM to follow_pte()
Date: Wed, 10 Apr 2024 17:55:26 +0200
Message-ID: <20240410155527.474777-3-david@redhat.com>
In-Reply-To: <20240410155527.474777-1-david@redhat.com>
References: <20240410155527.474777-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

.. and centralize the VM_IO/VM_PFNMAP sanity check in there. We'll
now also perform these sanity checks for direct follow_pte()
invocations.

For generic_access_phys(), we might now check multiple times: nothing to
worry about, really.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/pci/pci_mmio.c        |  4 ++--
 arch/x86/mm/pat/memtype.c       |  5 +----
 drivers/vfio/vfio_iommu_type1.c |  4 ++--
 drivers/virt/acrn/mm.c          |  3 +--
 include/linux/mm.h              |  2 +-
 mm/memory.c                     | 15 ++++++++-------
 virt/kvm/kvm_main.c             |  4 ++--
 7 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/arch/s390/pci/pci_mmio.c b/arch/s390/pci/pci_mmio.c
index a90499c087f0..5398729bfe1b 100644
--- a/arch/s390/pci/pci_mmio.c
+++ b/arch/s390/pci/pci_mmio.c
@@ -169,7 +169,7 @@ SYSCALL_DEFINE3(s390_pci_mmio_write, unsigned long, mmio_addr,
 	if (!(vma->vm_flags & VM_WRITE))
 		goto out_unlock_mmap;
 
-	ret = follow_pte(vma->vm_mm, mmio_addr, &ptep, &ptl);
+	ret = follow_pte(vma, mmio_addr, &ptep, &ptl);
 	if (ret)
 		goto out_unlock_mmap;
 
@@ -308,7 +308,7 @@ SYSCALL_DEFINE3(s390_pci_mmio_read, unsigned long, mmio_addr,
 	if (!(vma->vm_flags & VM_WRITE))
 		goto out_unlock_mmap;
 
-	ret = follow_pte(vma->vm_mm, mmio_addr, &ptep, &ptl);
+	ret = follow_pte(vma, mmio_addr, &ptep, &ptl);
 	if (ret)
 		goto out_unlock_mmap;
 
diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index d01c3b0bd6eb..bdc2a240c2aa 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -954,10 +954,7 @@ static int follow_phys(struct vm_area_struct *vma, unsigned long *prot,
 	pte_t *ptep, pte;
 	spinlock_t *ptl;
 
-	if (!(vma->vm_flags & (VM_IO | VM_PFNMAP)))
-		return -EINVAL;
-
-	if (follow_pte(vma->vm_mm, vma->vm_start, &ptep, &ptl))
+	if (follow_pte(vma, vma->vm_start, &ptep, &ptl))
 		return -EINVAL;
 
 	pte = ptep_get(ptep);
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index b5c15fe8f9fc..3a0218171cfa 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -518,7 +518,7 @@ static int follow_fault_pfn(struct vm_area_struct *vma, struct mm_struct *mm,
 	spinlock_t *ptl;
 	int ret;
 
-	ret = follow_pte(vma->vm_mm, vaddr, &ptep, &ptl);
+	ret = follow_pte(vma, vaddr, &ptep, &ptl);
 	if (ret) {
 		bool unlocked = false;
 
@@ -532,7 +532,7 @@ static int follow_fault_pfn(struct vm_area_struct *vma, struct mm_struct *mm,
 		if (ret)
 			return ret;
 
-		ret = follow_pte(vma->vm_mm, vaddr, &ptep, &ptl);
+		ret = follow_pte(vma, vaddr, &ptep, &ptl);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/virt/acrn/mm.c b/drivers/virt/acrn/mm.c
index 2d98e1e185c4..db8ff1d0ac23 100644
--- a/drivers/virt/acrn/mm.c
+++ b/drivers/virt/acrn/mm.c
@@ -187,8 +187,7 @@ int acrn_vm_ram_map(struct acrn_vm *vm, struct acrn_vm_memmap *memmap)
 		}
 
 		for (i = 0; i < nr_pages; i++) {
-			ret = follow_pte(vma->vm_mm,
-					 memmap->vma_base + i * PAGE_SIZE,
+			ret = follow_pte(vma, memmap->vma_base + i * PAGE_SIZE,
 					 &ptep, &ptl);
 			if (ret)
 				break;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index ef34cf54c14f..374b307abfc1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2420,7 +2420,7 @@ void free_pgd_range(struct mmu_gather *tlb, unsigned long addr,
 		unsigned long end, unsigned long floor, unsigned long ceiling);
 int
 copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma);
-int follow_pte(struct mm_struct *mm, unsigned long address,
+int follow_pte(struct vm_area_struct *vma, unsigned long address,
 	       pte_t **ptepp, spinlock_t **ptlp);
 int generic_access_phys(struct vm_area_struct *vma, unsigned long addr,
 			void *buf, int len, int write);
diff --git a/mm/memory.c b/mm/memory.c
index 78422d1c7381..ab01fb69dc72 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5928,7 +5928,7 @@ int __pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address)
 
 /**
  * follow_pte - look up PTE at a user virtual address
- * @mm: the mm_struct of the target address space
+ * @vma: the memory mapping
  * @address: user virtual address
  * @ptepp: location to store found PTE
  * @ptlp: location to store the lock for the PTE
@@ -5947,15 +5947,19 @@ int __pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long address)
  *
  * Return: zero on success, -ve otherwise.
  */
-int follow_pte(struct mm_struct *mm, unsigned long address,
+int follow_pte(struct vm_area_struct *vma, unsigned long address,
 	       pte_t **ptepp, spinlock_t **ptlp)
 {
+	struct mm_struct *mm = vma->vm_mm;
 	pgd_t *pgd;
 	p4d_t *p4d;
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *ptep;
 
+	if (!(vma->vm_flags & (VM_IO | VM_PFNMAP)))
+		goto out;
+
 	pgd = pgd_offset(mm, address);
 	if (pgd_none(*pgd) || unlikely(pgd_bad(*pgd)))
 		goto out;
@@ -6009,11 +6013,8 @@ int generic_access_phys(struct vm_area_struct *vma, unsigned long addr,
 	int offset = offset_in_page(addr);
 	int ret = -EINVAL;
 
-	if (!(vma->vm_flags & (VM_IO | VM_PFNMAP)))
-		return -EINVAL;
-
 retry:
-	if (follow_pte(vma->vm_mm, addr, &ptep, &ptl))
+	if (follow_pte(vma, addr, &ptep, &ptl))
 		return -EINVAL;
 	pte = ptep_get(ptep);
 	pte_unmap_unlock(ptep, ptl);
@@ -6028,7 +6029,7 @@ int generic_access_phys(struct vm_area_struct *vma, unsigned long addr,
 	if (!maddr)
 		return -ENOMEM;
 
-	if (follow_pte(vma->vm_mm, addr, &ptep, &ptl))
+	if (follow_pte(vma, addr, &ptep, &ptl))
 		goto out_unmap;
 
 	if (!pte_same(pte, ptep_get(ptep))) {
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index fb49c2a60200..f57dbacb8689 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2902,7 +2902,7 @@ static int hva_to_pfn_remapped(struct vm_area_struct *vma,
 	spinlock_t *ptl;
 	int r;
 
-	r = follow_pte(vma->vm_mm, addr, &ptep, &ptl);
+	r = follow_pte(vma, addr, &ptep, &ptl);
 	if (r) {
 		/*
 		 * get_user_pages fails for VM_IO and VM_PFNMAP vmas and does
@@ -2917,7 +2917,7 @@ static int hva_to_pfn_remapped(struct vm_area_struct *vma,
 		if (r)
 			return r;
 
-		r = follow_pte(vma->vm_mm, addr, &ptep, &ptl);
+		r = follow_pte(vma, addr, &ptep, &ptl);
 		if (r)
 			return r;
 	}
-- 
2.44.0


