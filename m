Return-Path: <linux-kernel+bounces-164248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2F58B7B5B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 948A51F22AEF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51C5143738;
	Tue, 30 Apr 2024 15:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=morinfr.org header.i=@morinfr.org header.b="1TI+xOV3"
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24ED143737;
	Tue, 30 Apr 2024 15:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714490544; cv=none; b=eEfoYEUA9FdrljgAXE5IOYkAx4vb2nofV5Klu5K3X5OsiGNqMh1hsKSxbVu+As9oYPWKGXzPtuzP0NQJQqViBfqQeCbG+XksWE8LsXa8osKgtBFWFXB3BWAJwwuRUgL6ZZTZ1/s5BoWzvgsqEUimqtPnOhTVuCHDseqy8eVCUEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714490544; c=relaxed/simple;
	bh=xfSIlhknITm7Nn1Vpn8PZ3WraOqM67xMgM/4IKfddrY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+9Sx/NfCEe9RZsOJiQotZHMHoi22wG/p5U+zchrUaZwvCrT1c/hMXeuzEnEocgLlJfV6WMlTDUA19cO4aiZFR7mHVp1knTm67qv5qQs5j6Z4vRUPqxGan59AbQPd0j/BLuGLrAxAskRWMVvjARm4aqdsvHVDZHbila1DAhu+yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=morinfr.org; spf=pass smtp.mailfrom=morinfr.org; dkim=pass (1024-bit key) header.d=morinfr.org header.i=@morinfr.org header.b=1TI+xOV3; arc=none smtp.client-ip=212.27.42.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=morinfr.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morinfr.org
Received: from bender.morinfr.org (unknown [82.66.66.112])
	by smtp2-g21.free.fr (Postfix) with ESMTPS id 1A9182003E0;
	Tue, 30 Apr 2024 17:22:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=morinfr.org
	; s=20170427; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=dQM45eMyF7RJffXkEfhsLwlqWnYeFBAu+epsoydTVNw=; b=1TI+xOV3wyhVryjw+IYpNflVED
	DYfMjcZBFudXQQQ53imVpl7FvtNGAdIPhaghOPg+Ty8Ox8VTM0O3KQsTV9oWnxeVUhsOlzLy5/gBH
	Ha8zDn/nXWvevmbsFeFnCEEKHRU/XsZ1IaRrFGIDCgJ8LwWB/aRP77d93czL+DW2iT2E=;
Received: from guillaum by bender.morinfr.org with local (Exim 4.96)
	(envelope-from <guillaume@morinfr.org>)
	id 1s1pJ2-004apZ-1H;
	Tue, 30 Apr 2024 17:22:08 +0200
Date: Tue, 30 Apr 2024 17:22:08 +0200
From: Guillaume Morin <guillaume@morinfr.org>
To: David Hildenbrand <david@redhat.com>, oleg@redhat.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	muchun.song@linux.dev
Subject: Re: [RFC][PATCH] uprobe: support for private hugetlb mappings
Message-ID: <ZjEMoHkbloHVeJ0h@bender.morinfr.org>
References: <22fcde31-16c4-42d0-ad99-568173ec4dd0@redhat.com>
 <ZibOQI9kwzE98n12@bender.morinfr.org>
 <8d5314ac-5afe-41d4-9d27-9512cd96d21c@redhat.com>
 <ZilvOi7ceSXmwkNq@bender.morinfr.org>
 <b1cf78f8-8480-4451-bbf8-78694ebd0438@redhat.com>
 <Zip0fEliGeL0qmID@bender.morinfr.org>
 <e84a82b8-b788-499c-be79-e6dcb64ac969@redhat.com>
 <Zirw0uINbP6GxFiK@bender.morinfr.org>
 <385d3516-95bb-4ff9-9d60-ac4e46104130@redhat.com>
 <ZiwGovSHiVCF7z6y@bender.morinfr.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiwGovSHiVCF7z6y@bender.morinfr.org>

On 26 Apr 21:55, Guillaume Morin wrote:
>
> On 26 Apr  9:19, David Hildenbrand wrote:
> > A couple of points:
> > 
> > a) Don't use page_mapcount(). Either folio_mapcount(), but likely you want
> > to check PageAnonExclusive.
> > 
> > b) If you're not following the can_follow_write_pte/_pmd model, you are
> > doing something wrong :)
> > 
> > c) The code was heavily changed in mm/mm-unstable. It was merged with t
> > the common code.
> > 
> > Likely, in mm/mm-unstable, the existing can_follow_write_pte and
> > can_follow_write_pmd checks will already cover what you want in most cases.
> > 
> > We'd need a can_follow_write_pud() to cover follow_huge_pud() and
> > (unfortunately) something to handle follow_hugepd() as well similarly.
> > 
> > Copy-pasting what we do in can_follow_write_pte() and adjusting for
> > different PTE types is the right thing to do. Maybe now it's time to factor
> > out the common checks into a separate helper.
> 
> I tried to get the hugepd stuff right but this was the first I heard
> about it :-) Afaict follow_huge_pmd and friends were already DTRT

I got it working on top of your uprobes-cow branch with the foll force
patch sent friday. Still pretty lightly tested

I went with using one write uprobe function with some additional
branches. I went back and forth between that and making them 2 different
functions.

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 2f4e88552d3f..8a33e380f7ea 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -83,6 +83,10 @@ static const struct fs_parameter_spec hugetlb_fs_parameters[] = {
 	{}
 };
 
+bool hugetlbfs_mapping(struct address_space *mapping) {
+	return mapping->a_ops == &hugetlbfs_aops;
+}
+
 /*
  * Mask used when checking the page offset value passed in via system
  * calls.  This value will be converted to a loff_t which is signed.
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 68244bb3637a..66fdcc0b5db2 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -511,6 +511,8 @@ struct hugetlbfs_sb_info {
 	umode_t mode;
 };
 
+bool hugetlbfs_mapping(struct address_space *mapping);
+
 static inline struct hugetlbfs_sb_info *HUGETLBFS_SB(struct super_block *sb)
 {
 	return sb->s_fs_info;
@@ -557,6 +559,8 @@ static inline struct hstate *hstate_inode(struct inode *i)
 {
 	return NULL;
 }
+
+static inline bool hugetlbfs_mapping(struct address_space *mapping) { return false; }
 #endif /* !CONFIG_HUGETLBFS */
 
 #ifdef HAVE_ARCH_HUGETLB_UNMAPPED_AREA
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 4237a7477cca..e6e93a574c39 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -11,6 +11,7 @@
 
 #include <linux/kernel.h>
 #include <linux/highmem.h>
+#include <linux/hugetlb.h>
 #include <linux/pagemap.h>	/* read_mapping_page */
 #include <linux/slab.h>
 #include <linux/sched.h>
@@ -120,7 +121,7 @@ struct xol_area {
  */
 static bool valid_vma(struct vm_area_struct *vma, bool is_register)
 {
-	vm_flags_t flags = VM_HUGETLB | VM_MAYEXEC | VM_MAYSHARE;
+	vm_flags_t flags = VM_MAYEXEC | VM_MAYSHARE;
 
 	if (is_register)
 		flags |= VM_WRITE;
@@ -163,21 +164,21 @@ bool __weak is_trap_insn(uprobe_opcode_t *insn)
 	return is_swbp_insn(insn);
 }
 
-static void copy_from_page(struct page *page, unsigned long vaddr, void *dst, int len)
+static void copy_from_page(struct page *page, unsigned long vaddr, void *dst, int len, unsigned long page_mask)
 {
 	void *kaddr = kmap_atomic(page);
-	memcpy(dst, kaddr + (vaddr & ~PAGE_MASK), len);
+	memcpy(dst, kaddr + (vaddr & ~page_mask), len);
 	kunmap_atomic(kaddr);
 }
 
-static void copy_to_page(struct page *page, unsigned long vaddr, const void *src, int len)
+static void copy_to_page(struct page *page, unsigned long vaddr, const void *src, int len, unsigned long page_mask)
 {
 	void *kaddr = kmap_atomic(page);
-	memcpy(kaddr + (vaddr & ~PAGE_MASK), src, len);
+	memcpy(kaddr + (vaddr & ~page_mask), src, len);
 	kunmap_atomic(kaddr);
 }
 
-static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t *new_opcode)
+static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t *new_opcode, unsigned long page_mask)
 {
 	uprobe_opcode_t old_opcode;
 	bool is_swbp;
@@ -191,7 +192,8 @@ static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t
 	 * is a trap variant; uprobes always wins over any other (gdb)
 	 * breakpoint.
 	 */
-	copy_from_page(page, vaddr, &old_opcode, UPROBE_SWBP_INSN_SIZE);
+	copy_from_page(page, vaddr, &old_opcode, UPROBE_SWBP_INSN_SIZE,
+		       page_mask);
 	is_swbp = is_swbp_insn(&old_opcode);
 
 	if (is_swbp_insn(new_opcode)) {
@@ -376,8 +378,8 @@ struct uwo_data {
 	uprobe_opcode_t opcode;
 };
 
-static int __write_opcode_pte(pte_t *ptep, unsigned long vaddr,
-		unsigned long next, struct mm_walk *walk)
+static int __write_opcode(pte_t *ptep, unsigned long vaddr,
+			  unsigned long page_mask, struct mm_walk *walk)
 {
 	struct uwo_data *data = walk->private;;
 	const bool is_register = !!is_swbp_insn(&data->opcode);
@@ -415,9 +417,12 @@ static int __write_opcode_pte(pte_t *ptep, unsigned long vaddr,
 
 	/* Unmap + flush the TLB, such that we can write atomically .*/
 	flush_cache_page(vma, vaddr, pte_pfn(pte));
-	pte = ptep_clear_flush(vma, vaddr, ptep);
+	if (folio_test_hugetlb(folio))
+		pte = huge_ptep_clear_flush(vma, vaddr, ptep);
+	else
+		pte = ptep_clear_flush(vma, vaddr, ptep);
 	copy_to_page(page, data->opcode_vaddr, &data->opcode,
-		     UPROBE_SWBP_INSN_SIZE);
+		     UPROBE_SWBP_INSN_SIZE, page_mask);
 
 	/* When unregistering, we may only zap a PTE if uffd is disabled ... */
 	if (is_register || userfaultfd_missing(vma))
@@ -443,13 +448,18 @@ static int __write_opcode_pte(pte_t *ptep, unsigned long vaddr,
 	if (!identical || folio_maybe_dma_pinned(folio))
 		goto remap;
 
-	/* Zap it and try to reclaim swap space. */
-	dec_mm_counter(mm, MM_ANONPAGES);
-	folio_remove_rmap_pte(folio, page, vma);
-	if (!folio_mapped(folio) && folio_test_swapcache(folio) &&
-	     folio_trylock(folio)) {
-		folio_free_swap(folio);
-		folio_unlock(folio);
+	if (folio_test_hugetlb(folio)) {
+		hugetlb_remove_rmap(folio);
+		large = false;
+	} else {
+		/* Zap it and try to reclaim swap space. */
+		dec_mm_counter(mm, MM_ANONPAGES);
+		folio_remove_rmap_pte(folio, page, vma);
+		if (!folio_mapped(folio) && folio_test_swapcache(folio) &&
+		folio_trylock(folio)) {
+			folio_free_swap(folio);
+			folio_unlock(folio);
+		}
 	}
 	folio_put(folio);
 
@@ -461,11 +471,29 @@ static int __write_opcode_pte(pte_t *ptep, unsigned long vaddr,
 	 */
 	smp_wmb();
 	/* We modified the page. Make sure to mark the PTE dirty. */
-	set_pte_at(mm, vaddr, ptep, pte_mkdirty(pte));
+	if (folio_test_hugetlb(folio))
+		set_huge_pte_at(mm , vaddr, ptep, huge_pte_mkdirty(pte),
+				(~page_mask) + 1);
+	else
+		set_pte_at(mm, vaddr, ptep, pte_mkdirty(pte));
 	return UWO_DONE;
 }
 
+static int __write_opcode_hugetlb(pte_t *ptep, unsigned long hmask,
+		unsigned long vaddr,
+		unsigned long next, struct mm_walk *walk)
+{
+	return __write_opcode(ptep, vaddr, hmask, walk);
+}
+
+static int __write_opcode_pte(pte_t *ptep, unsigned long vaddr,
+		unsigned long next, struct mm_walk *walk)
+{
+	return __write_opcode(ptep, vaddr, PAGE_MASK, walk);
+}
+
 static const struct mm_walk_ops write_opcode_ops = {
+	.hugetlb_entry		= __write_opcode_hugetlb,
 	.pte_entry		= __write_opcode_pte,
 	.walk_lock		= PGWALK_WRLOCK,
 };
@@ -492,7 +520,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 		unsigned long opcode_vaddr, uprobe_opcode_t opcode)
 {
 	struct uprobe *uprobe = container_of(auprobe, struct uprobe, arch);
-	const unsigned long vaddr = opcode_vaddr & PAGE_MASK;
+	unsigned long vaddr = opcode_vaddr & PAGE_MASK;
 	const bool is_register = !!is_swbp_insn(&opcode);
 	struct uwo_data data = {
 		.opcode = opcode,
@@ -503,6 +531,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 	struct mmu_notifier_range range;
 	int ret, ref_ctr_updated = 0;
 	struct page *page;
+	unsigned long page_size = PAGE_SIZE;
 
 	if (WARN_ON_ONCE(!is_cow_mapping(vma->vm_flags)))
 		return -EINVAL;
@@ -521,7 +550,14 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 	if (ret != 1)
 		goto out;
 
-	ret = verify_opcode(page, opcode_vaddr, &opcode);
+
+	if (is_vm_hugetlb_page(vma)) {
+		struct hstate *h = hstate_vma(vma);
+		page_size = huge_page_size(h);
+		vaddr &= huge_page_mask(h);
+		page = compound_head(page);
+	}
+	ret = verify_opcode(page, opcode_vaddr, &opcode, ~(page_size - 1));
 	put_page(page);
 	if (ret <= 0)
 		goto out;
@@ -541,12 +577,12 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 		 * be able to do it under PTL.
 		 */
 		mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm,
-					vaddr, vaddr + PAGE_SIZE);
+					vaddr, vaddr + page_size);
 		mmu_notifier_invalidate_range_start(&range);
 	}
 
 	/* Walk the page tables and perform the actual magic. */
-	ret = walk_page_range_vma(vma, vaddr, vaddr + PAGE_SIZE,
+	ret = walk_page_range_vma(vma, vaddr, vaddr + page_size,
 				  &write_opcode_ops, &data);
 
 	if (!is_register)
@@ -816,6 +852,7 @@ static int __copy_insn(struct address_space *mapping, struct file *filp,
 			void *insn, int nbytes, loff_t offset)
 {
 	struct page *page;
+	unsigned long mask = PAGE_MASK;
 	/*
 	 * Ensure that the page that has the original instruction is populated
 	 * and in page-cache. If ->read_folio == NULL it must be shmem_mapping(),
@@ -823,12 +860,17 @@ static int __copy_insn(struct address_space *mapping, struct file *filp,
 	 */
 	if (mapping->a_ops->read_folio)
 		page = read_mapping_page(mapping, offset >> PAGE_SHIFT, filp);
-	else
+	else if (!is_file_hugepages(filp))
 		page = shmem_read_mapping_page(mapping, offset >> PAGE_SHIFT);
+	else {
+		struct hstate *h = hstate_file(filp);
+		mask = huge_page_mask(h);
+		page = find_get_page(mapping, (offset & mask) >> PAGE_SHIFT);
+	}
 	if (IS_ERR(page))
 		return PTR_ERR(page);
 
-	copy_from_page(page, offset, insn, nbytes);
+	copy_from_page(page, offset, insn, nbytes, mask);
 	put_page(page);
 
 	return 0;
@@ -1175,9 +1217,12 @@ static int __uprobe_register(struct inode *inode, loff_t offset,
 	if (!uc->handler && !uc->ret_handler)
 		return -EINVAL;
 
-	/* copy_insn() uses read_mapping_page() or shmem_read_mapping_page() */
+	/* copy_insn() uses read_mapping_page() or shmem/hugetlbfs specific
+	 * logic
+	 */
 	if (!inode->i_mapping->a_ops->read_folio &&
-	    !shmem_mapping(inode->i_mapping))
+	    !shmem_mapping(inode->i_mapping) &&
+	    !hugetlbfs_mapping(inode->i_mapping))
 		return -EIO;
 	/* Racy, just to catch the obvious mistakes */
 	if (offset > i_size_read(inode))
@@ -1698,7 +1743,7 @@ void __weak arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
 				  void *src, unsigned long len)
 {
 	/* Initialize the slot */
-	copy_to_page(page, vaddr, src, len);
+	copy_to_page(page, vaddr, src, len, PAGE_MASK);
 
 	/*
 	 * We probably need flush_icache_user_page() but it needs vma.
@@ -2062,7 +2107,7 @@ static int is_trap_at_addr(struct mm_struct *mm, unsigned long vaddr)
 	if (result < 0)
 		return result;
 
-	copy_from_page(page, vaddr, &opcode, UPROBE_SWBP_INSN_SIZE);
+	copy_from_page(page, vaddr, &opcode, UPROBE_SWBP_INSN_SIZE, PAGE_MASK);
 	put_page(page);
  out:
 	/* This needs to return true for any variant of the trap insn */

-- 
Guillaume Morin <guillaume@morinfr.org>

