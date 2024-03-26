Return-Path: <linux-kernel+bounces-118285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A102B88B747
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 03:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0202B21CE8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E4F127B43;
	Tue, 26 Mar 2024 02:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lkdm4LcS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1316839E8
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 02:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711419441; cv=none; b=BfBw3L3QDMDYNlPs1jjpx4sJEyVhWREZWp3tkrTwTLCaUop5CPdq3rRhCn+wheoDmfppecoV6ev26P8WuNJqm8wCd31e3t+FXOrl2tdmzDXoG0yyD3NfsBF3xaHV1euUluD4sCOOCcd9SlMAXiIUqPRgI+TxeQmqQxvmyV014ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711419441; c=relaxed/simple;
	bh=Bt/iCncZprnekNGl7/DyAAsQ7Fn3bf5rVZDGMJUr1K4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GdKhC9qzbMH6UQQUElYru9QIgGeqZtJL6m4mTZqS37XW+JvhKLPbGmQnMOIRzCZ+g5wI4YoGcbOVBgTmsQ2Z7ouV9GTDgwTajhsGxhXG/2gMlwhektgIpM3ZN26KQOO2rMbyMO6OSD0QeaxifksB59eMUi+MADmjo83Xw6zzQtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lkdm4LcS; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711419440; x=1742955440;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bt/iCncZprnekNGl7/DyAAsQ7Fn3bf5rVZDGMJUr1K4=;
  b=Lkdm4LcSQ5+9KGpu5/rYceOBiYWxnVvcdj983C6t4hHrgvPy52S8hppp
   ShSSHkzPlmtffuGvMA5Y2yqmvKVneKJi3aZXQyHeXMV7AVmJKpTd8Edbw
   IUG8HeZKMZin24gbYVjFQaEEgQACl2ZaPpHDwh4IYgPSeqFKFEKkPs2zC
   IrNAsApCC4QMhFlk7MUjdOoDRWgf7VU6NcsBocMbv0DzEPMIhOIRb13qX
   5/QS2Bv7dYDAqxLDKEHgcmMmKmIw//Cye/TlbgS7dNWed0OHggcEWcIi3
   I+Ni6A154JB8l8AcLMhYWdHuk/ByR1wtwnmtVmpFlsCfI1kqw6cFiT5ZP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6564259"
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="6564259"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 19:17:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="20489883"
Received: from rpwilson-mobl.amr.corp.intel.com (HELO rpedgeco-desk4.intel.com) ([10.251.11.187])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 19:17:15 -0700
From: Rick Edgecombe <rick.p.edgecombe@intel.com>
To: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	bp@alien8.de,
	broonie@kernel.org,
	christophe.leroy@csgroup.eu,
	dave.hansen@linux.intel.com,
	debug@rivosinc.com,
	hpa@zytor.com,
	keescook@chromium.org,
	kirill.shutemov@linux.intel.com,
	luto@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	tglx@linutronix.de,
	x86@kernel.org
Cc: rick.p.edgecombe@intel.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v4 05/14] mm: Use get_unmapped_area_vmflags()
Date: Mon, 25 Mar 2024 19:16:47 -0700
Message-Id: <20240326021656.202649-6-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240326021656.202649-1-rick.p.edgecombe@intel.com>
References: <20240326021656.202649-1-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When memory is being placed, mmap() will take care to respect the guard
gaps of certain types of memory (VM_SHADOWSTACK, VM_GROWSUP and
VM_GROWSDOWN). In order to ensure guard gaps between mappings, mmap()
needs to consider two things:
 1. That the new mapping isn’t placed in an any existing mappings guard
    gaps.
 2. That the new mapping isn’t placed such that any existing mappings
    are not in *its* guard gaps.

The long standing behavior of mmap() is to ensure 1, but not take any care
around 2. So for example, if there is a PAGE_SIZE free area, and a
mmap() with a PAGE_SIZE size, and a type that has a guard gap is being
placed, mmap() may place the shadow stack in the PAGE_SIZE free area. Then
the mapping that is supposed to have a guard gap will not have a gap to
the adjacent VMA.

Use mm_get_unmapped_area_vmflags() in the do_mmap() so future changes
can cause shadow stack mappings to be placed with a guard gap. Also use
the THP variant that takes vm_flags, such that THP shadow stack can get the
same treatment. Adjust the vm_flags calculation to happen earlier so that
the vm_flags can be passed into __get_unmapped_area().

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v4:
 - Split removal of get_unmapped_area() export into a separate patch
   (Christophe Leroy)
v2:
 - Make get_unmapped_area() a static inline (Kirill)
---
 include/linux/mm.h | 11 ++++++++++-
 mm/mmap.c          | 32 ++++++++++++++++----------------
 2 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0436b919f1c7..8b13cd891b53 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3383,7 +3383,16 @@ extern int install_special_mapping(struct mm_struct *mm,
 unsigned long randomize_stack_top(unsigned long stack_top);
 unsigned long randomize_page(unsigned long start, unsigned long range);
 
-extern unsigned long get_unmapped_area(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
+unsigned long
+__get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
+		    unsigned long pgoff, unsigned long flags, vm_flags_t vm_flags);
+
+static inline unsigned long
+get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
+		  unsigned long pgoff, unsigned long flags)
+{
+	return __get_unmapped_area(file, addr, len, pgoff, flags, 0);
+}
 
 extern unsigned long mmap_region(struct file *file, unsigned long addr,
 	unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
diff --git a/mm/mmap.c b/mm/mmap.c
index d160e88b1b1e..68b5bfcebadd 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1255,18 +1255,6 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 	if (mm->map_count > sysctl_max_map_count)
 		return -ENOMEM;
 
-	/* Obtain the address to map to. we verify (or select) it and ensure
-	 * that it represents a valid section of the address space.
-	 */
-	addr = get_unmapped_area(file, addr, len, pgoff, flags);
-	if (IS_ERR_VALUE(addr))
-		return addr;
-
-	if (flags & MAP_FIXED_NOREPLACE) {
-		if (find_vma_intersection(mm, addr, addr + len))
-			return -EEXIST;
-	}
-
 	if (prot == PROT_EXEC) {
 		pkey = execute_only_pkey(mm);
 		if (pkey < 0)
@@ -1280,6 +1268,18 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 	vm_flags |= calc_vm_prot_bits(prot, pkey) | calc_vm_flag_bits(flags) |
 			mm->def_flags | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
 
+	/* Obtain the address to map to. we verify (or select) it and ensure
+	 * that it represents a valid section of the address space.
+	 */
+	addr = __get_unmapped_area(file, addr, len, pgoff, flags, vm_flags);
+	if (IS_ERR_VALUE(addr))
+		return addr;
+
+	if (flags & MAP_FIXED_NOREPLACE) {
+		if (find_vma_intersection(mm, addr, addr + len))
+			return -EEXIST;
+	}
+
 	if (flags & MAP_LOCKED)
 		if (!can_do_mlock())
 			return -EPERM;
@@ -1837,8 +1837,8 @@ unsigned long mm_get_unmapped_area_vmflags(struct mm_struct *mm, struct file *fi
 }
 
 unsigned long
-get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
-		unsigned long pgoff, unsigned long flags)
+__get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
+		unsigned long pgoff, unsigned long flags, vm_flags_t vm_flags)
 {
 	unsigned long (*get_area)(struct file *, unsigned long,
 				  unsigned long, unsigned long, unsigned long)
@@ -1873,8 +1873,8 @@ get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
 	if (get_area)
 		addr = get_area(file, addr, len, pgoff, flags);
 	else
-		addr = mm_get_unmapped_area(current->mm, file, addr, len,
-					    pgoff, flags);
+		addr = mm_get_unmapped_area_vmflags(current->mm, file, addr, len,
+						    pgoff, flags, vm_flags);
 	if (IS_ERR_VALUE(addr))
 		return addr;
 
-- 
2.34.1


