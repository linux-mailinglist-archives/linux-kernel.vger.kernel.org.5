Return-Path: <linux-kernel+bounces-100889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE57879EAA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 936021C220DF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1DC1448C6;
	Tue, 12 Mar 2024 22:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MXYO5lm2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AA5143C74
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 22:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710282547; cv=none; b=o13kOaItmv+P+opCpgWfWK6oOYQJD1+UVOIeygP0NIjYVjvF2XV5zNHarNjYQu+QEzGxJ89hj5UmXPP6iTbSq/GNZ0mrCXQb4Jwrv9PJqVvuQ9svUUuLA5eqt43yOnILJ4nrX3c7urSpdcSDsDuwAnpXYem9UIb+VuMhXdr4jgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710282547; c=relaxed/simple;
	bh=/QgkcmxaszXiFcioo4194oXRAE7nWH9S6PPTH54Wib0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eBdXYO/LME5NYs18T6tIjJcF8dRvDz+AvzC08wBSmXTOoPss3XjHszrwqHQv8yrZB+T+1alUUrKQHAnAdQqplwYi85XaNmcBPQvSnpj0i4FUra+f4dgPxrjG1Q7Qehl4lUbjdukifw+MILKm7e2+Tz/5Yq+ak35Ub18Ad5oq6N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MXYO5lm2; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710282546; x=1741818546;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/QgkcmxaszXiFcioo4194oXRAE7nWH9S6PPTH54Wib0=;
  b=MXYO5lm2sx8QJAaL83Rxan2dGl/ke4Ef1mwpUho+EhxBD7w/1v9VEPs7
   71xQu5dLlQUWw/2+zliMxJy/77kJCiF3MvWG17RutpEaY253yVIAB0Bmj
   Al7TNn81vBIh8e0DuzU52lS4S1K+m3nXeE+3hhJjKsE+VL4X7CgXrc9Y6
   8oHAzQOSLuwuqOiIOYUzxYmmC2MYiZXp1O0p8bUgT6/DYCCKnJR3MXC+a
   V0T1BS268YMzaPtfBtdFaPq2yM+70P8je/Oopq/z6zt8ef9ZkiH4sB+eC
   4yosXBmQg4QBUEFUR+L2xfF9gVrXHWpzhl6WuNhcBT8irhj7x3JlGp6+H
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="5191960"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="5191960"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 15:29:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="16356841"
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
Subject: [PATCH v3 04/12] thp: Add thp_get_unmapped_area_vmflags()
Date: Tue, 12 Mar 2024 15:28:35 -0700
Message-Id: <20240312222843.2505560-5-rick.p.edgecombe@intel.com>
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

Add a THP implementations of the vm_flags variant of get_unmapped_area().
Future changes will call this from mmap.c in the do_mmap() path to allow
shadow stacks to be placed with consideration taken for the start guard
gap. Shadow stack memory is always private and anonymous and so special
guard gap logic is not needed in a lot of caseis, but it can be mapped by
THP, so needs to be handled.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 include/linux/huge_mm.h | 11 +++++++++++
 mm/huge_memory.c        | 23 ++++++++++++++++-------
 mm/mmap.c               | 12 +++++++-----
 3 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 5adb86af35fc..8744c808d380 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -262,6 +262,9 @@ unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
 
 unsigned long thp_get_unmapped_area(struct file *filp, unsigned long addr,
 		unsigned long len, unsigned long pgoff, unsigned long flags);
+unsigned long thp_get_unmapped_area_vmflags(struct file *filp, unsigned long addr,
+		unsigned long len, unsigned long pgoff, unsigned long flags,
+		vm_flags_t vm_flags);
 
 void folio_prep_large_rmappable(struct folio *folio);
 bool can_split_folio(struct folio *folio, int *pextra_pins);
@@ -416,6 +419,14 @@ static inline void folio_prep_large_rmappable(struct folio *folio) {}
 
 #define thp_get_unmapped_area	NULL
 
+static inline unsigned long
+thp_get_unmapped_area_vmflags(struct file *filp, unsigned long addr,
+			      unsigned long len, unsigned long pgoff,
+			      unsigned long flags, vm_flags_t vm_flags)
+{
+	return 0;
+}
+
 static inline bool
 can_split_folio(struct folio *folio, int *pextra_pins)
 {
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index bc3bf441e768..349c93a1a7c3 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -806,7 +806,8 @@ static inline bool is_transparent_hugepage(struct folio *folio)
 
 static unsigned long __thp_get_unmapped_area(struct file *filp,
 		unsigned long addr, unsigned long len,
-		loff_t off, unsigned long flags, unsigned long size)
+		loff_t off, unsigned long flags, unsigned long size,
+		vm_flags_t vm_flags)
 {
 	loff_t off_end = off + len;
 	loff_t off_align = round_up(off, size);
@@ -822,8 +823,8 @@ static unsigned long __thp_get_unmapped_area(struct file *filp,
 	if (len_pad < len || (off + len_pad) < off)
 		return 0;
 
-	ret = mm_get_unmapped_area(current->mm, filp, addr, len_pad,
-				   off >> PAGE_SHIFT, flags);
+	ret = mm_get_unmapped_area_vmflags(current->mm, filp, addr, len_pad,
+					   off >> PAGE_SHIFT, flags, vm_flags);
 
 	/*
 	 * The failure might be due to length padding. The caller will retry
@@ -848,17 +849,25 @@ static unsigned long __thp_get_unmapped_area(struct file *filp,
 	return ret;
 }
 
-unsigned long thp_get_unmapped_area(struct file *filp, unsigned long addr,
-		unsigned long len, unsigned long pgoff, unsigned long flags)
+unsigned long thp_get_unmapped_area_vmflags(struct file *filp, unsigned long addr,
+		unsigned long len, unsigned long pgoff, unsigned long flags,
+		vm_flags_t vm_flags)
 {
 	unsigned long ret;
 	loff_t off = (loff_t)pgoff << PAGE_SHIFT;
 
-	ret = __thp_get_unmapped_area(filp, addr, len, off, flags, PMD_SIZE);
+	ret = __thp_get_unmapped_area(filp, addr, len, off, flags, PMD_SIZE, vm_flags);
 	if (ret)
 		return ret;
 
-	return mm_get_unmapped_area(current->mm, filp, addr, len, pgoff, flags);
+	return mm_get_unmapped_area_vmflags(current->mm, filp, addr, len, pgoff, flags,
+					    vm_flags);
+}
+
+unsigned long thp_get_unmapped_area(struct file *filp, unsigned long addr,
+		unsigned long len, unsigned long pgoff, unsigned long flags)
+{
+	return thp_get_unmapped_area_vmflags(filp, addr, len, pgoff, flags, 0);
 }
 EXPORT_SYMBOL_GPL(thp_get_unmapped_area);
 
diff --git a/mm/mmap.c b/mm/mmap.c
index a3128ed26676..68381b90f906 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1863,20 +1863,22 @@ __get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
 		 * so use shmem's get_unmapped_area in case it can be huge.
 		 */
 		get_area = shmem_get_unmapped_area;
-	} else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
-		/* Ensures that larger anonymous mappings are THP aligned. */
-		get_area = thp_get_unmapped_area;
 	}
 
 	/* Always treat pgoff as zero for anonymous memory. */
 	if (!file)
 		pgoff = 0;
 
-	if (get_area)
+	if (get_area) {
 		addr = get_area(file, addr, len, pgoff, flags);
-	else
+	} else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
+		/* Ensures that larger anonymous mappings are THP aligned. */
+		addr = thp_get_unmapped_area_vmflags(file, addr, len,
+						     pgoff, flags, vm_flags);
+	} else {
 		addr = mm_get_unmapped_area_vmflags(current->mm, file, addr, len,
 						    pgoff, flags, vm_flags);
+	}
 	if (IS_ERR_VALUE(addr))
 		return addr;
 
-- 
2.34.1


