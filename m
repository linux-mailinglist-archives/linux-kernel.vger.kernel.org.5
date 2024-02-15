Return-Path: <linux-kernel+bounces-67816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28307857166
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93709B23390
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E0814A4F3;
	Thu, 15 Feb 2024 23:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YM/GTh8e"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF36148FF3
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 23:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708038883; cv=none; b=VZT/hCbxpbHjYsnGoaPRpuVzb51wqrDGqovl3wP0Ik1HddDZgowwxo+BSU/TzfxXgCo5aJJi0R3E8NFXbrzOYr4SHV1419n5BUHgXS5NOgRgfaGlP2chZNDmYct7bdDYxakab9S6Ie9WN5HQ4lzVaiKh5KRUP6Df2wF1PrYADfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708038883; c=relaxed/simple;
	bh=unKAy/CGTalz/NFNrhf3RgWUr6Aw4RHxK63+GyNg8+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y2Hj9zuPVxwpqcplg2o9BNvbx/EMUzorMlGT1ne+LX724DtfReTPlZi/YL+1iNat2SPbCLeyjR2kzZDGEidiJ+HpvQ1IABvq6SPPIdWfuLhumnfsymVbWmePxCLswyNC05ZAVFfWFc7boF/f6JTe385mG8TB3YP7dgJygvCx6z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YM/GTh8e; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708038882; x=1739574882;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=unKAy/CGTalz/NFNrhf3RgWUr6Aw4RHxK63+GyNg8+4=;
  b=YM/GTh8eK6mmi7U9ztodoNavv2KsLhrv/Sw40BG7ed/5Y/ArNFlMiQdt
   AhW1OAnRzD+XSqg6dVq8RnXL+IipxMwuQwAYURyYBG3zf3jgjuhj+wvz0
   MuUNearUX/GMA0y0QSBUp5mi4/0IreoGqW5jWJo8zQKvGcPCF3FqI0dNT
   kvCkrS8Kc/CJNaqxDwqNCMpB9+W69FXpZHVlmGLY9gigJThblFJTyIta3
   ZHd4h9FL3YPa2Z1P+9ktN5/M+8KUwLGNv98cGw5JgsXby+lBzJDubLQne
   5xoie9YIb97VNby7QW8BuQtfaNuQLrq0Y2aHHCu3dqiZKtGWLzYYfPz/+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="2066341"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="2066341"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 15:14:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="912250194"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="912250194"
Received: from yshin-mobl1.amr.corp.intel.com (HELO rpedgeco-desk4.intel.com) ([10.209.95.133])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 15:14:39 -0800
From: Rick Edgecombe <rick.p.edgecombe@intel.com>
To: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	debug@rivosinc.com,
	broonie@kernel.org,
	kirill.shutemov@linux.intel.com,
	keescook@chromium.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	luto@kernel.org,
	peterz@infradead.org,
	hpa@zytor.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: rick.p.edgecombe@intel.com
Subject: [RFC PATCH 3/8] mm: Use get_unmapped_area_vmflags()
Date: Thu, 15 Feb 2024 15:13:27 -0800
Message-Id: <20240215231332.1556787-4-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215231332.1556787-1-rick.p.edgecombe@intel.com>
References: <20240215231332.1556787-1-rick.p.edgecombe@intel.com>
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
 include/linux/mm.h |  2 ++
 mm/mmap.c          | 38 ++++++++++++++++++++++----------------
 2 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index da5219b48d52..9addf16dbf18 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3352,6 +3352,8 @@ unsigned long randomize_stack_top(unsigned long stack_top);
 unsigned long randomize_page(unsigned long start, unsigned long range);
 
 extern unsigned long get_unmapped_area(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
+extern unsigned long __get_unmapped_area(struct file *, unsigned long, unsigned long,
+					 unsigned long, unsigned long, vm_flags_t);
 
 extern unsigned long mmap_region(struct file *file, unsigned long addr,
 	unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
diff --git a/mm/mmap.c b/mm/mmap.c
index 2021bc040e81..2723f26f7c62 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1249,18 +1249,6 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
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
@@ -1274,6 +1262,18 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
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
@@ -1831,8 +1831,8 @@ unsigned long mm_get_unmapped_area_vmflags(struct mm_struct *mm, struct file *fi
 }
 
 unsigned long
-get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
-		unsigned long pgoff, unsigned long flags)
+__get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
+		unsigned long pgoff, unsigned long flags, vm_flags_t vm_flags)
 {
 	unsigned long (*get_area)(struct file *, unsigned long,
 				  unsigned long, unsigned long, unsigned long)
@@ -1865,8 +1865,8 @@ get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
 	if (get_area)
 		addr = get_area(file, addr, len, pgoff, flags);
 	else
-		addr = mm_get_unmapped_area(current->mm, file, addr, len,
-					    pgoff, flags);
+		addr = mm_get_unmapped_area_vmflags(current->mm, file, addr, len,
+						    pgoff, flags, vm_flags);
 	if (IS_ERR_VALUE(addr))
 		return addr;
 
@@ -1879,6 +1879,12 @@ get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
 	return error ? error : addr;
 }
 
+unsigned long
+get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
+		unsigned long pgoff, unsigned long flags)
+{
+	return __get_unmapped_area(file, addr, len, pgoff, flags, 0);
+}
 EXPORT_SYMBOL(get_unmapped_area);
 
 unsigned long
-- 
2.34.1


