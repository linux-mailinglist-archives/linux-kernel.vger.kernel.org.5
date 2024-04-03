Return-Path: <linux-kernel+bounces-130616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 868C8897A94
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 23:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA1EC1C210AC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD14156888;
	Wed,  3 Apr 2024 21:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gp1FpwP7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49038156674
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 21:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712179314; cv=none; b=D07m+qzJ0yyplPiN/jX0VFbYT4KRANh/RiceYskG9LoGgdxytd3QuluKAoZjDv7WAGfxWJPHutjIbzISuo7UctGz8B6me2cQdPfux7RTAKiXBVTKys5aD8mAiWlunilOnk6WXUSBHteQoJzShlLtUDsiA5Stsg9n5C9UrHwUWKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712179314; c=relaxed/simple;
	bh=xRjj4HKRFbrKs9gCV7Lg6Hj5wDEoFEJ9KPAK3TRhw6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BzGzZd4rwAVJmrXTuer0Xy1yFDRNGtJbT6OJaJdBMeKgtxkEOn/gvoTtV+oJI2uiNB5FsUr+H30pwFG0R6O1HoKpi6LroQ5s/zi1ngdKBEorPt2ypMTL5KVss0BqWpBgboHtPYJB/mlQj5Lvn4Mmpmwhl0wbvxQGwY4GxgqTvb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gp1FpwP7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712179311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g0bue21sVFDV6mnO+mYp+9W9/z08Eqmsuy0DOkkfVG0=;
	b=Gp1FpwP7OhW547snzTUeumZWLu7Kz+3QwQHRzY6/c0PYpUvIcGJH0aFgq9xbCU43LffAZE
	aWmXmdo+VgWW92W8VWwP+AIDeQUb/SiihP7csXXtpmISQWhtgvaB8rjFCuoQe1vITPXpMw
	/OCI11YE85DWL2gX/x30OKAl+F6lbCw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-504-YCtSuczBNGSVezlxIXJuOQ-1; Wed,
 03 Apr 2024 17:21:45 -0400
X-MC-Unique: YCtSuczBNGSVezlxIXJuOQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 542C33C13920;
	Wed,  3 Apr 2024 21:21:44 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.52])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B0C1D1121306;
	Wed,  3 Apr 2024 21:21:40 +0000 (UTC)
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
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2 1/3] [mm-unstable] Revert "mm: move follow_phys to arch/x86/mm/pat/memtype.c"
Date: Wed,  3 Apr 2024 23:21:29 +0200
Message-ID: <20240403212131.929421-2-david@redhat.com>
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

Revert mm-unstable patches:
 * mm-move-follow_phys-to-arch-x86-mm-pat-memtypec-fix-2
 * mm-move-follow_phys-to-arch-x86-mm-pat-memtypec-fix
 * mm: move follow_phys to arch/x86/mm/pat/memtype.c

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/x86/mm/pat/memtype.c | 24 ++----------------------
 include/linux/mm.h        |  2 ++
 mm/memory.c               | 28 ++++++++++++++++++++++++++++
 3 files changed, 32 insertions(+), 22 deletions(-)

diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 143d1e3d3fd2..0d72183b5dd0 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -39,7 +39,6 @@
 #include <linux/pfn_t.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
-#include <linux/highmem.h>
 #include <linux/fs.h>
 #include <linux/rbtree.h>
 
@@ -948,25 +947,6 @@ static void free_pfn_range(u64 paddr, unsigned long size)
 		memtype_free(paddr, paddr + size);
 }
 
-static int follow_phys(struct vm_area_struct *vma, unsigned long *prot,
-		resource_size_t *phys)
-{
-	pte_t *ptep, pte;
-	spinlock_t *ptl;
-
-	if (!(vma->vm_flags & (VM_IO | VM_PFNMAP)))
-		return -EINVAL;
-
-	if (follow_pte(vma->vm_mm, vma->vm_start, &ptep, &ptl))
-		return -EINVAL;
-
-	pte = ptep_get(ptep);
-	*prot = pgprot_val(pte_pgprot(pte));
-	*phys = (resource_size_t)pte_pfn(pte) << PAGE_SHIFT;
-	pte_unmap_unlock(ptep, ptl);
-	return 0;
-}
-
 /*
  * track_pfn_copy is called when vma that is covering the pfnmap gets
  * copied through copy_page_range().
@@ -986,7 +966,7 @@ int track_pfn_copy(struct vm_area_struct *vma)
 		 * reserve the whole chunk covered by vma. We need the
 		 * starting address and protection from pte.
 		 */
-		if (follow_phys(vma, &prot, &paddr)) {
+		if (follow_phys(vma, vma->vm_start, 0, &prot, &paddr)) {
 			WARN_ON_ONCE(1);
 			return -EINVAL;
 		}
@@ -1073,7 +1053,7 @@ void untrack_pfn(struct vm_area_struct *vma, unsigned long pfn,
 	/* free the chunk starting from pfn or the whole chunk */
 	paddr = (resource_size_t)pfn << PAGE_SHIFT;
 	if (!paddr && !size) {
-		if (follow_phys(vma, &prot, &paddr)) {
+		if (follow_phys(vma, vma->vm_start, 0, &prot, &paddr)) {
 			WARN_ON_ONCE(1);
 			return;
 		}
diff --git a/include/linux/mm.h b/include/linux/mm.h
index bc0cd34a8042..97e779993c74 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2424,6 +2424,8 @@ int
 copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma);
 int follow_pte(struct mm_struct *mm, unsigned long address,
 	       pte_t **ptepp, spinlock_t **ptlp);
+int follow_phys(struct vm_area_struct *vma, unsigned long address,
+		unsigned int flags, unsigned long *prot, resource_size_t *phys);
 int generic_access_phys(struct vm_area_struct *vma, unsigned long addr,
 			void *buf, int len, int write);
 
diff --git a/mm/memory.c b/mm/memory.c
index 912cd738ec03..1211e2090c1a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5987,6 +5987,34 @@ int follow_pte(struct mm_struct *mm, unsigned long address,
 EXPORT_SYMBOL_GPL(follow_pte);
 
 #ifdef CONFIG_HAVE_IOREMAP_PROT
+int follow_phys(struct vm_area_struct *vma,
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
 /**
  * generic_access_phys - generic implementation for iomem mmap access
  * @vma: the vma to access
-- 
2.44.0


