Return-Path: <linux-kernel+bounces-100890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BD4879EAB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5061E1F23437
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D7D1448F1;
	Tue, 12 Mar 2024 22:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C3fpnPCu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C362D14402C
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 22:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710282548; cv=none; b=YdkXZwyrDB0akCbQ9oR/k0Ixk8gkVSdqBdQAGfqbMR9A1wh2QWR8L6JNhrHg+uLp9SYJV5BPanCX+pUjj21M10xvukvj1wRfC5G+iFJJheyfkkIMtIeRYGiFK07KSU1TsHtvMdzBNkVrjsxMNRgP9kn1zuMJuAue9Dm6KGs+4Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710282548; c=relaxed/simple;
	bh=/il3sOjTRp5Oqe4q9Enzhux+EAXqchUHAcOIqSHR2bA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VPMw5ovsDDMsFPLQ3/5jt82CSX/t9gJVPwJDUtde0GmuIHeRemg652ozGprAUALCBlwkR3b+wv2NQqTBJrOg24vO9o2kHphJ6gVO1m+aKdfhifhS81VJ7b49yVvu2H+3PJRmJU/LlfOuD8nBDwxqIDY7WzjxMz6GgoBHiZp3cnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C3fpnPCu; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710282547; x=1741818547;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/il3sOjTRp5Oqe4q9Enzhux+EAXqchUHAcOIqSHR2bA=;
  b=C3fpnPCucoLFrq2Y6zSxDbF9HXdm/TZZol6ntgrNRmy+suJDltn1ATa2
   lDctq6FFVHRm0pZK3vekCK2owD9aszky5cXA/vh9MvZW/2UcgA1GWF2Yr
   7u/uzb1+aXRUXVGIvp4NNRAmJuENRlKu+5TNAUVuQ46vb0aF14WwvITkA
   m2OW6CtwVdBi1wmHIg0UdKpp+a457sv6d8sntP0ZrrXSkURrGGRcceitQ
   l1EV1BKCsblBpM3slZW5ROMPO/I31iu4gCFdW9Q1IzCrrIA3J3FVq26tz
   nQ9sVnMmEhMQdXFfQiFCXMBQ9wQhLCsfOnnct5ZBV8vAtl7ndPUeK23Qo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="5191946"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="5191946"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 15:29:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="16356836"
Received: from gargayus-mobl1.amr.corp.intel.com (HELO rpedgeco-desk4.intel.com) ([10.255.231.196])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 15:29:02 -0700
From: Rick Edgecombe <rick.p.edgecombe@intel.com>
To: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	bp@alien8.de,
	broonie@kernel.org,
	dave.hansen@linux.intel.com,
	debug@rivosinc.com,
	hpa@zytor.com,
	keescook@chromium.org,
	kirill.shutemov@linux.intel.com,
	luto@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	tglx@linutronix.de,
	x86@kernel.org,
	christophe.leroy@csgroup.eu
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	rick.p.edgecombe@intel.com
Subject: [PATCH v3 03/12] mm: Use get_unmapped_area_vmflags()
Date: Tue, 12 Mar 2024 15:28:34 -0700
Message-Id: <20240312222843.2505560-4-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312222843.2505560-1-rick.p.edgecombe@intel.com>
References: <20240312222843.2505560-1-rick.p.edgecombe@intel.com>
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
---
v2:
 - Make get_unmapped_area() a static inline (Kirill)
---
 include/linux/mm.h | 11 ++++++++++-
 mm/mmap.c          | 34 ++++++++++++++++------------------
 2 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index f5a97dec5169..d91cde79aaee 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3363,7 +3363,16 @@ extern int install_special_mapping(struct mm_struct *mm,
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
index e23ce8ca24c9..a3128ed26676 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1257,18 +1257,6 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
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
@@ -1282,6 +1270,18 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
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
@@ -1839,8 +1839,8 @@ unsigned long mm_get_unmapped_area_vmflags(struct mm_struct *mm, struct file *fi
 }
 
 unsigned long
-get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
-		unsigned long pgoff, unsigned long flags)
+__get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
+		unsigned long pgoff, unsigned long flags, vm_flags_t vm_flags)
 {
 	unsigned long (*get_area)(struct file *, unsigned long,
 				  unsigned long, unsigned long, unsigned long)
@@ -1875,8 +1875,8 @@ get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
 	if (get_area)
 		addr = get_area(file, addr, len, pgoff, flags);
 	else
-		addr = mm_get_unmapped_area(current->mm, file, addr, len,
-					    pgoff, flags);
+		addr = mm_get_unmapped_area_vmflags(current->mm, file, addr, len,
+						    pgoff, flags, vm_flags);
 	if (IS_ERR_VALUE(addr))
 		return addr;
 
@@ -1889,8 +1889,6 @@ get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
 	return error ? error : addr;
 }
 
-EXPORT_SYMBOL(get_unmapped_area);
-
 unsigned long
 mm_get_unmapped_area(struct mm_struct *mm, struct file *file,
 		     unsigned long addr, unsigned long len,
-- 
2.34.1


