Return-Path: <linux-kernel+bounces-130618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69534897A96
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 23:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C3341C23C05
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9269156877;
	Wed,  3 Apr 2024 21:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UxhnYUUB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF5115696E
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 21:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712179320; cv=none; b=nXTe8PL3gBUpJKSsf9EOHjn/8Yb/pc00CGZGKxlbhpo6QKdgCZEAxMYJAnxkC1+Dn1ll3/2zqTEGfRWvHk7zBwoN5c7eYy+nE0Unc2WPtdwavJ1Q70vJj44BWRMNvW9JBMm3/zzdYGuI7h722Y1nIo9LJq50PzX0UxcCx8a1cIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712179320; c=relaxed/simple;
	bh=gJB6PnOnH9pEcRZfFJUFoATzU7tNBKNy6P4IKxxIrRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bL8YeK6DFjfXB+CMtUGkaXdhAXtSWYDaHVyDB8esKMa3R3+ARoSyZoQJGsnzlSStCs440YymQ4UpodrnrOacx6ZVgskK6I5Vsm1VEFXA7ffSIND9shJgbO1Ftb15dsI0X6F6Eypio4tXhd9PzIZ3vO1+g2eVFJYd7qfnnnNFpkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UxhnYUUB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712179318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=efLT3sOcQF/h2hQN5fWNO1q+LEWoeOZtTC+KwC/NbJA=;
	b=UxhnYUUB3nhYK69Su6li4P29O+VUwiieH7AwhHPNglPZ1vjRjIaVWTzdwToV7WSvuDNzi8
	oiJr/Ul8CQUFZMeN4dlWpF4Twzj0sFRCYV9dOMOJKHGApi6XqFqsZbkr4rl9/PWtpKljLY
	3Fnc54AO7SeZPzhxU7+N+/bn4LvFHP8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-lsbBclVqNHi4N3-nmhzPHA-1; Wed, 03 Apr 2024 17:21:54 -0400
X-MC-Unique: lsbBclVqNHi4N3-nmhzPHA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E3D73101A535;
	Wed,  3 Apr 2024 21:21:52 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.52])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1CD02111E408;
	Wed,  3 Apr 2024 21:21:48 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	x86@kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Christoph Hellwig <hch@lst.de>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Fei Li <fei1.li@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v2 3/3] mm: move follow_phys to arch/x86/mm/pat/memtype.c
Date: Wed,  3 Apr 2024 23:21:31 +0200
Message-ID: <20240403212131.929421-4-david@redhat.com>
In-Reply-To: <20240403212131.929421-1-david@redhat.com>
References: <20240403212131.929421-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

From: Christoph Hellwig <hch@lst.de>

follow_phys is only used by two callers in arch/x86/mm/pat/memtype.c.
Move it there and hardcode the two arguments that get the same values
passed by both callers.

Link: https://lkml.kernel.org/r/20240324234542.2038726-4-hch@lst.de
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: David Hildenbrand <david@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Fei Li <fei1.li@intel.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com> # rebased, applied fixups
---
 arch/x86/mm/pat/memtype.c | 29 ++++++++++++++++++++++++++++-
 include/linux/mm.h        |  2 --
 mm/memory.c               | 32 --------------------------------
 3 files changed, 28 insertions(+), 35 deletions(-)

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 36b603d0cdde..d01c3b0bd6eb 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -39,6 +39,7 @@
 #include <linux/pfn_t.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
+#include <linux/highmem.h>
 #include <linux/fs.h>
 #include <linux/rbtree.h>
 
@@ -947,6 +948,32 @@ static void free_pfn_range(u64 paddr, unsigned long size)
 		memtype_free(paddr, paddr + size);
 }
 
+static int follow_phys(struct vm_area_struct *vma, unsigned long *prot,
+		resource_size_t *phys)
+{
+	pte_t *ptep, pte;
+	spinlock_t *ptl;
+
+	if (!(vma->vm_flags & (VM_IO | VM_PFNMAP)))
+		return -EINVAL;
+
+	if (follow_pte(vma->vm_mm, vma->vm_start, &ptep, &ptl))
+		return -EINVAL;
+
+	pte = ptep_get(ptep);
+
+	/* Never return PFNs of anon folios in COW mappings. */
+	if (vm_normal_folio(vma, vma->vm_start, pte)) {
+		pte_unmap_unlock(ptep, ptl);
+		return -EINVAL;
+	}
+
+	*prot = pgprot_val(pte_pgprot(pte));
+	*phys = (resource_size_t)pte_pfn(pte) << PAGE_SHIFT;
+	pte_unmap_unlock(ptep, ptl);
+	return 0;
+}
+
 static int get_pat_info(struct vm_area_struct *vma, resource_size_t *paddr,
 		pgprot_t *pgprot)
 {
@@ -964,7 +991,7 @@ static int get_pat_info(struct vm_area_struct *vma, resource_size_t *paddr,
 	 * detect the PFN. If we need the cachemode as well, we're out of luck
 	 * for now and have to fail fork().
 	 */
-	if (!follow_phys(vma, vma->vm_start, 0, &prot, paddr)) {
+	if (!follow_phys(vma, &prot, paddr)) {
 		if (pgprot)
 			*pgprot = __pgprot(prot);
 		return 0;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 97e779993c74..bc0cd34a8042 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2424,8 +2424,6 @@ int
 copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma);
 int follow_pte(struct mm_struct *mm, unsigned long address,
 	       pte_t **ptepp, spinlock_t **ptlp);
-int follow_phys(struct vm_area_struct *vma, unsigned long address,
-		unsigned int flags, unsigned long *prot, resource_size_t *phys);
 int generic_access_phys(struct vm_area_struct *vma, unsigned long addr,
 			void *buf, int len, int write);
 
diff --git a/mm/memory.c b/mm/memory.c
index 1e9a0288fdaf..912cd738ec03 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5987,38 +5987,6 @@ int follow_pte(struct mm_struct *mm, unsigned long address,
 EXPORT_SYMBOL_GPL(follow_pte);
 
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
-	/* Never return PFNs of anon folios in COW mappings. */
-	if (vm_normal_folio(vma, address, pte))
-		goto unlock;
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
2.44.0


