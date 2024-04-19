Return-Path: <linux-kernel+bounces-151875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 035458AB51E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 20:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF3A9282371
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B18D225CF;
	Fri, 19 Apr 2024 18:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=morinfr.org header.i=@morinfr.org header.b="DGcQZ2F+"
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA09C8DE
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 18:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713551838; cv=none; b=i1/vMlEVAcmlBd0auzNFW32BPi4Plb4TmKzecaGB4nJ/FZ9u6mSP7AxX6e/P7MFSJuoW1EAPYjez1uASKgeQdhpSZxtoJuOxcfn/v23peBn9puIdjfCYwzic8bKGnMYxzJjreLMLYcCYY5y+tZgIjomLj4jiTqippCla0eMdqpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713551838; c=relaxed/simple;
	bh=6ODNNbC6XPC/AmkCjeM8WjCVT/44g5K47ArK6pISSIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Mjn273Zqn3cx9KZYmRiDEzjTzG4ZT4Qi2lkz5449UDHbqbsjpihnCEONYHWqVCD29pT36ANGon0Sy20PvYyQlDGORWfTX2pSstgoXwETqbdy1Bv0ny8v5ojv6yqGshPiS+f8O8bgEjMfjiUJ0IfFzHY8HWGkT0rwyg/saXywnks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=morinfr.org; spf=pass smtp.mailfrom=morinfr.org; dkim=pass (1024-bit key) header.d=morinfr.org header.i=@morinfr.org header.b=DGcQZ2F+; arc=none smtp.client-ip=212.27.42.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=morinfr.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morinfr.org
Received: from bender.morinfr.org (unknown [82.66.66.112])
	by smtp2-g21.free.fr (Postfix) with ESMTPS id E80E02003D0;
	Fri, 19 Apr 2024 20:37:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=morinfr.org
	; s=20170427; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=BaMyinP3KfzvaDzjf8QGOl7I3TQO10J/GCySfxkyYL0=; b=DGcQZ2F+hIrSg+NuCnt488TPwR
	El5L1czkmBnKK2FniQXNdZ/TBtORHUomjqS0Ce0g4lX8JeQOBOweoV6Zqns4pVMlSTa9wpJf4Wg+d
	4oyFdFPVaHYj5KwUC0fP/WXFoWtvYEBYZhbXPATdtUdTbRvc8XvOGIpDMbhL6msEJgv0=;
Received: from guillaum by bender.morinfr.org with local (Exim 4.96)
	(envelope-from <guillaume@morinfr.org>)
	id 1rxt6h-003H26-1X;
	Fri, 19 Apr 2024 20:37:07 +0200
Date: Fri, 19 Apr 2024 20:37:06 +0200
From: Guillaume Morin <guillaume@morinfr.org>
To: Mike Kravetz <mike.kravetz@oracle.com>, david@redhat.com,
	oleg@redhat.com, linux-kernel@vger.kernel.org
Cc: guillaume@morinfr.org
Subject: [RFC][PATCH] uprobe: support for private hugetlb mappings
Message-ID: <ZiK50qob9yl5e0Xz@bender.morinfr.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

libhugetlbfs, the Intel iodlr code both allow to remap .text onto a
hugetlb private mapping. It's also pretty easy to do it manually.
One drawback of using this functionality is the lack of support for
uprobes (NOTE uprobe ignores shareable vmas)

This patch adds support for private hugetlb mappings.  It does require exposing
some hugetlbfs innards and relies on copy_user_large_folio which is only
available when CONFIG_HUGETLBFS is used so I had to use an ugly #ifdef

If there is some interest in applying this patch in some form or
another, I am open to any refactoring suggestions (esp getting rid the
#ifdef in uprobes.c) . I tried to limit the
amount of branching.

---
 fs/hugetlbfs/inode.c    |   4 ++
 include/linux/hugetlb.h |  12 ++++
 kernel/events/uprobes.c | 133 ++++++++++++++++++++++++++++++----------
 mm/hugetlb.c            |   2 +-
 4 files changed, 117 insertions(+), 34 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 6502c7e776d1..63bc5d0ddcf7 100644
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
index 77b30a8c6076..49fd47b79bed 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -174,6 +174,8 @@ u32 hugetlb_fault_mutex_hash(struct address_space *mapping, pgoff_t idx);
 
 pte_t *huge_pmd_share(struct mm_struct *mm, struct vm_area_struct *vma,
 		      unsigned long addr, pud_t *pud);
+pte_t make_huge_pte(struct vm_area_struct *vma, struct page *page,
+				int writable);
 
 struct address_space *hugetlb_page_mapping_lock_write(struct page *hpage);
 
@@ -492,6 +494,13 @@ static inline vm_fault_t hugetlb_fault(struct mm_struct *mm,
 
 static inline void hugetlb_unshare_all_pmds(struct vm_area_struct *vma) { }
 
+static inline pte_t make_huge_pte(struct vm_area_struct *vma, struct page *page,
+				int writable) {
+    pte_t ret;
+    BUG();
+    return ret;
+}
+
 #endif /* !CONFIG_HUGETLB_PAGE */
 /*
  * hugepages at page global directory. If arch support
@@ -539,6 +548,8 @@ struct hugetlbfs_sb_info {
 	umode_t mode;
 };
 
+bool hugetlbfs_mapping(struct address_space *mapping);
+
 static inline struct hugetlbfs_sb_info *HUGETLBFS_SB(struct super_block *sb)
 {
 	return sb->s_fs_info;
@@ -585,6 +596,7 @@ static inline struct hstate *hstate_inode(struct inode *i)
 {
 	return NULL;
 }
+static inline bool hugetlbfs_mapping(struct address_space *mapping) { return false; }
 #endif /* !CONFIG_HUGETLBFS */
 
 #ifdef HAVE_ARCH_HUGETLB_UNMAPPED_AREA
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index e4834d23e1d1..cf4716e73f54 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -11,6 +11,7 @@
 
 #include <linux/kernel.h>
 #include <linux/highmem.h>
+#include <linux/hugetlb.h>
 #include <linux/pagemap.h>	/* read_mapping_page */
 #include <linux/slab.h>
 #include <linux/sched.h>
@@ -119,7 +120,7 @@ struct xol_area {
  */
 static bool valid_vma(struct vm_area_struct *vma, bool is_register)
 {
-	vm_flags_t flags = VM_HUGETLB | VM_MAYEXEC | VM_MAYSHARE;
+	vm_flags_t flags = VM_MAYEXEC | VM_MAYSHARE;
 
 	if (is_register)
 		flags |= VM_WRITE;
@@ -159,9 +160,12 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
 	DEFINE_FOLIO_VMA_WALK(pvmw, old_folio, vma, addr, 0);
 	int err;
 	struct mmu_notifier_range range;
+	unsigned long page_size = is_vm_hugetlb_page(vma) ?
+		huge_page_size(hstate_vma(vma)):
+		PAGE_SIZE;
 
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, addr,
-				addr + PAGE_SIZE);
+				addr + page_size);
 
 	if (new_page) {
 		new_folio = page_folio(new_page);
@@ -181,26 +185,46 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
 
 	if (new_page) {
 		folio_get(new_folio);
-		folio_add_new_anon_rmap(new_folio, vma, addr);
-		folio_add_lru_vma(new_folio, vma);
-	} else
+		if (folio_test_hugetlb(new_folio)) {
+			hugetlb_add_new_anon_rmap(new_folio, vma, addr);
+		} else {
+			folio_add_new_anon_rmap(new_folio, vma, addr);
+			folio_add_lru_vma(new_folio, vma);
+		}
+	} else if (!folio_test_hugetlb(old_folio))
 		/* no new page, just dec_mm_counter for old_page */
 		dec_mm_counter(mm, MM_ANONPAGES);
 
-	if (!folio_test_anon(old_folio)) {
+	if (!folio_test_anon(old_folio) && !folio_test_hugetlb(old_folio)) {
 		dec_mm_counter(mm, mm_counter_file(old_folio));
 		inc_mm_counter(mm, MM_ANONPAGES);
 	}
 
 	flush_cache_page(vma, addr, pte_pfn(ptep_get(pvmw.pte)));
-	ptep_clear_flush(vma, addr, pvmw.pte);
-	if (new_page)
-		set_pte_at_notify(mm, addr, pvmw.pte,
-				  mk_pte(new_page, vma->vm_page_prot));
+	if (folio_test_hugetlb(old_folio))
+		huge_ptep_clear_flush(vma, addr, pvmw.pte);
+	else
+		ptep_clear_flush(vma, addr, pvmw.pte);
+	if (new_page) {
+		if (folio_test_hugetlb(new_folio)) {
+			pte_t pte = make_huge_pte(vma, new_page,
+						  vma->vm_flags & VM_WRITE);
+			mmu_notifier_change_pte(mm, addr, pte);
+			set_huge_pte_at(mm, addr, pvmw.pte, pte,
+					page_size);
+		} else {
+			set_pte_at_notify(mm, addr, pvmw.pte,
+					mk_pte(new_page, vma->vm_page_prot));
+		}
+	}
 
-	folio_remove_rmap_pte(old_folio, old_page, vma);
-	if (!folio_mapped(old_folio))
-		folio_free_swap(old_folio);
+	if (folio_test_hugetlb(old_folio))
+		hugetlb_remove_rmap(old_folio);
+	else {
+		folio_remove_rmap_pte(old_folio, old_page, vma);
+		if (!folio_mapped(old_folio))
+			folio_free_swap(old_folio);
+	}
 	page_vma_mapped_walk_done(&pvmw);
 	folio_put(old_folio);
 
@@ -236,21 +260,25 @@ bool __weak is_trap_insn(uprobe_opcode_t *insn)
 	return is_swbp_insn(insn);
 }
 
-static void copy_from_page(struct page *page, unsigned long vaddr, void *dst, int len)
+static void copy_from_page(struct page *page, unsigned long vaddr,
+			   void *dst, int len, size_t page_mask)
 {
 	void *kaddr = kmap_atomic(page);
-	memcpy(dst, kaddr + (vaddr & ~PAGE_MASK), len);
+	memcpy(dst, kaddr + (vaddr & ~page_mask), len);
 	kunmap_atomic(kaddr);
 }
 
-static void copy_to_page(struct page *page, unsigned long vaddr, const void *src, int len)
+static void copy_to_page(struct page *page, unsigned long vaddr,
+			 const void *src, int len, size_t page_mask)
 {
 	void *kaddr = kmap_atomic(page);
-	memcpy(kaddr + (vaddr & ~PAGE_MASK), src, len);
+	memcpy(kaddr + (vaddr & ~page_mask), src, len);
 	kunmap_atomic(kaddr);
 }
 
-static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t *new_opcode)
+static int verify_opcode(struct page *page, unsigned long vaddr,
+			 uprobe_opcode_t *new_opcode,
+			 unsigned long page_mask)
 {
 	uprobe_opcode_t old_opcode;
 	bool is_swbp;
@@ -264,7 +292,8 @@ static int verify_opcode(struct page *page, unsigned long vaddr, uprobe_opcode_t
 	 * is a trap variant; uprobes always wins over any other (gdb)
 	 * breakpoint.
 	 */
-	copy_from_page(page, vaddr, &old_opcode, UPROBE_SWBP_INSN_SIZE);
+	copy_from_page(page, vaddr, &old_opcode, UPROBE_SWBP_INSN_SIZE,
+		       page_mask);
 	is_swbp = is_swbp_insn(&old_opcode);
 
 	if (is_swbp_insn(new_opcode)) {
@@ -464,7 +493,9 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 	struct vm_area_struct *vma;
 	int ret, is_register, ref_ctr_updated = 0;
 	bool orig_page_huge = false;
+	struct hstate *h = NULL;
 	unsigned int gup_flags = FOLL_FORCE;
+	unsigned long page_mask = PAGE_MASK;
 
 	is_register = is_swbp_insn(&opcode);
 	uprobe = container_of(auprobe, struct uprobe, arch);
@@ -477,11 +508,18 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 	if (IS_ERR(old_page))
 		return PTR_ERR(old_page);
 
-	ret = verify_opcode(old_page, vaddr, &opcode);
+	if (is_vm_hugetlb_page(vma)) {
+		h = hstate_vma(vma);
+		page_mask = huge_page_mask(h);
+
+		BUG_ON(!PageCompound(old_page));
+		old_page = compound_head(old_page);
+	}
+	ret = verify_opcode(old_page, vaddr, &opcode, page_mask);
 	if (ret <= 0)
 		goto put_old;
 
-	if (WARN(!is_register && PageCompound(old_page),
+	if (WARN(!is_register && PageCompound(old_page) && !h,
 		 "uprobe unregister should never work on compound page\n")) {
 		ret = -EINVAL;
 		goto put_old;
@@ -505,13 +543,30 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 		goto put_old;
 
 	ret = -ENOMEM;
-	new_page = alloc_page_vma(GFP_HIGHUSER_MOVABLE, vma, vaddr);
+	if (h) {
+		struct folio *new_folio = alloc_hugetlb_folio(vma, vaddr, 0);
+		if (IS_ERR(new_folio))
+			goto put_old;
+		new_page = &new_folio->page;
+	} else {
+		new_page = alloc_page_vma(GFP_HIGHUSER_MOVABLE, vma, vaddr);
+	}
 	if (!new_page)
 		goto put_old;
 
 	__SetPageUptodate(new_page);
-	copy_highpage(new_page, old_page);
-	copy_to_page(new_page, vaddr, &opcode, UPROBE_SWBP_INSN_SIZE);
+	if (h) {
+#if defined(CONFIG_HUGETLBFS)
+		copy_user_large_folio(page_folio(new_page),
+				      page_folio(old_page), vaddr, vma);
+#else
+        BUG();
+#endif
+	} else {
+		copy_highpage(new_page, old_page);
+	}
+	copy_to_page(new_page, vaddr, &opcode, UPROBE_SWBP_INSN_SIZE,
+		     page_mask);
 
 	if (!is_register) {
 		struct page *orig_page;
@@ -519,7 +574,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 
 		VM_BUG_ON_PAGE(!PageAnon(old_page), old_page);
 
-		index = vaddr_to_offset(vma, vaddr & PAGE_MASK) >> PAGE_SHIFT;
+		index = vaddr_to_offset(vma, vaddr & page_mask) >> PAGE_SHIFT;
 		orig_page = find_get_page(vma->vm_file->f_inode->i_mapping,
 					  index);
 
@@ -530,14 +585,14 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
 				put_page(new_page);
 				new_page = NULL;
 
-				if (PageCompound(orig_page))
+				if (!h && PageCompound(orig_page))
 					orig_page_huge = true;
 			}
 			put_page(orig_page);
 		}
 	}
 
-	ret = __replace_page(vma, vaddr & PAGE_MASK, old_page, new_page);
+	ret = __replace_page(vma, vaddr & page_mask, old_page, new_page);
 	if (new_page)
 		put_page(new_page);
 put_old:
@@ -785,6 +840,7 @@ static int __copy_insn(struct address_space *mapping, struct file *filp,
 			void *insn, int nbytes, loff_t offset)
 {
 	struct page *page;
+	unsigned long mask = PAGE_MASK;
 	/*
 	 * Ensure that the page that has the original instruction is populated
 	 * and in page-cache. If ->read_folio == NULL it must be shmem_mapping(),
@@ -792,12 +848,20 @@ static int __copy_insn(struct address_space *mapping, struct file *filp,
 	 */
 	if (mapping->a_ops->read_folio)
 		page = read_mapping_page(mapping, offset >> PAGE_SHIFT, filp);
-	else
+	else if (!is_file_hugepages(filp))
 		page = shmem_read_mapping_page(mapping, offset >> PAGE_SHIFT);
+	else {
+		struct hstate *h = hstate_file(filp);
+		mask = huge_page_mask(h);
+
+		page = find_get_page(mapping, (offset & mask) >> PAGE_SHIFT);
+		WARN_ON_ONCE(!page);
+	}
+
 	if (IS_ERR(page))
 		return PTR_ERR(page);
 
-	copy_from_page(page, offset, insn, nbytes);
+	copy_from_page(page, offset, insn, nbytes, mask);
 	put_page(page);
 
 	return 0;
@@ -1142,9 +1206,12 @@ static int __uprobe_register(struct inode *inode, loff_t offset,
 	if (!uc->handler && !uc->ret_handler)
 		return -EINVAL;
 
-	/* copy_insn() uses read_mapping_page() or shmem_read_mapping_page() */
+	/* copy_insn() uses read_mapping_page() or shmem/hugetlbfs specific
+	 * code
+	 */
 	if (!inode->i_mapping->a_ops->read_folio &&
-	    !shmem_mapping(inode->i_mapping))
+	    !shmem_mapping(inode->i_mapping) &&
+	    !hugetlbfs_mapping(inode->i_mapping))
 		return -EIO;
 	/* Racy, just to catch the obvious mistakes */
 	if (offset > i_size_read(inode))
@@ -1665,7 +1732,7 @@ void __weak arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
 				  void *src, unsigned long len)
 {
 	/* Initialize the slot */
-	copy_to_page(page, vaddr, src, len);
+	copy_to_page(page, vaddr, src, len, PAGE_MASK);
 
 	/*
 	 * We probably need flush_icache_user_page() but it needs vma.
@@ -2029,7 +2096,7 @@ static int is_trap_at_addr(struct mm_struct *mm, unsigned long vaddr)
 	if (result < 0)
 		return result;
 
-	copy_from_page(page, vaddr, &opcode, UPROBE_SWBP_INSN_SIZE);
+	copy_from_page(page, vaddr, &opcode, UPROBE_SWBP_INSN_SIZE, PAGE_MASK);
 	put_page(page);
  out:
 	/* This needs to return true for any variant of the trap insn */
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 23ef240ba48a..c8f26c112b81 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5310,7 +5310,7 @@ const struct vm_operations_struct hugetlb_vm_ops = {
 	.pagesize = hugetlb_vm_op_pagesize,
 };
 
-static pte_t make_huge_pte(struct vm_area_struct *vma, struct page *page,
+pte_t make_huge_pte(struct vm_area_struct *vma, struct page *page,
 				int writable)
 {
 	pte_t entry;
-- 
2.39.1


-- 
Guillaume Morin <guillaume@morinfr.org>

