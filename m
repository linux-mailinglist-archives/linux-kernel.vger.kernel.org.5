Return-Path: <linux-kernel+bounces-67818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0E8857169
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07A4EB237E8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561E214C592;
	Thu, 15 Feb 2024 23:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NfpFrd8Q"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8E914A0B4
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 23:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708038885; cv=none; b=NuD3kT1bXHQLwSujhO0FVDKrq1gyq/+5Nt38KGwyNftj/ZlBFRI80lBMUpiMDOdnmiwKDmbDIEvmWI6zLRWFt7FxrUEFKjJw3BqfyAvxN/3/FNW5T+meh/HB7+IN5kacpvqRnesY1ux7YsbzdWjiTx3VKE0/UzU3x1cKZRwQdco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708038885; c=relaxed/simple;
	bh=XHhdhuxOKWz8EspMQDfPASDrP/vRFk3wVhxiIKVJyZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XCM6cTGbz+wgQVg31jWnb6meQPVXYAfRR6VV+0b3kMpHHENWBHdYKv2B660DMoLgkV7bBt7GiAa9XuhufQ0e3OCoQkiNGP8JSbLhZICQCnTwZB5Y+qg3rLGZ4CTjFr/aZM8Y8OkHemkw7y1uolMqniT+oEpPV3Vx6r7bYfjoMvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NfpFrd8Q; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708038883; x=1739574883;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XHhdhuxOKWz8EspMQDfPASDrP/vRFk3wVhxiIKVJyZE=;
  b=NfpFrd8QKeI9hUSsEoGQdlTQLTlezIbtpPp8Y4K6b2oPY9jS6+Wvohsm
   2vvbo9RRbf9w7K80AvrYN+7sm+rvOYqOKCPuyhyzXKQBAynW5cstBsKNF
   OSIlrxc06ExNllCwHwuym+USb6RXSx8RBsjlgdvIqvYsA31ULgejFJ0SY
   XsL5ww3hdqlK+i27Qh1s9X4vkADpL81xt7EPzKOFTDYAI8+WHpKt0hh54
   TxEWKe4CAu/IwDzTl3BFj1l8ufffzWSOd9k61b89Qd1YTW8d/3+R44VkM
   Zsb2vKgtuE4L+eeoNW1ckkVHMhYLvekTND0Fq9hE5rFaFNPY9W+ALI0TH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="2066354"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="2066354"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 15:14:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="912250197"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="912250197"
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
Subject: [RFC PATCH 4/8] thp: Add thp_get_unmapped_area_vmflags()
Date: Thu, 15 Feb 2024 15:13:28 -0800
Message-Id: <20240215231332.1556787-5-rick.p.edgecombe@intel.com>
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
index fa0350b0812a..ef7251dfd9f9 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -139,6 +139,9 @@ bool hugepage_vma_check(struct vm_area_struct *vma, unsigned long vm_flags,
 
 unsigned long thp_get_unmapped_area(struct file *filp, unsigned long addr,
 		unsigned long len, unsigned long pgoff, unsigned long flags);
+unsigned long thp_get_unmapped_area_vmflags(struct file *filp, unsigned long addr,
+		unsigned long len, unsigned long pgoff, unsigned long flags,
+		vm_flags_t vm_flags);
 
 void folio_prep_large_rmappable(struct folio *folio);
 bool can_split_folio(struct folio *folio, int *pextra_pins);
@@ -286,6 +289,14 @@ static inline void folio_prep_large_rmappable(struct folio *folio) {}
 
 #define thp_get_unmapped_area	NULL
 
+static inline unsigned long
+thp_get_unmapped_area_vmflags(struct file *filp, unsigned long addr,
+			      unsigned long len, unsigned long pgoff,
+			       unsigned long flags, vm_flags_t vm_flags)
+{
+	return 0;
+}
+
 static inline bool
 can_split_folio(struct folio *folio, int *pextra_pins)
 {
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index e9ef43a719a5..f235f6d3ff62 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -628,7 +628,8 @@ static inline bool is_transparent_hugepage(struct folio *folio)
 
 static unsigned long __thp_get_unmapped_area(struct file *filp,
 		unsigned long addr, unsigned long len,
-		loff_t off, unsigned long flags, unsigned long size)
+		loff_t off, unsigned long flags, unsigned long size,
+		vm_flags_t vm_flags)
 {
 	loff_t off_end = off + len;
 	loff_t off_align = round_up(off, size);
@@ -641,8 +642,8 @@ static unsigned long __thp_get_unmapped_area(struct file *filp,
 	if (len_pad < len || (off + len_pad) < off)
 		return 0;
 
-	ret = mm_get_unmapped_area(current->mm, filp, addr, len_pad,
-				   off >> PAGE_SHIFT, flags);
+	ret = mm_get_unmapped_area_vmflags(current->mm, filp, addr, len_pad,
+					   off >> PAGE_SHIFT, flags, vm_flags);
 
 	/*
 	 * The failure might be due to length padding. The caller will retry
@@ -662,17 +663,25 @@ static unsigned long __thp_get_unmapped_area(struct file *filp,
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
index 2723f26f7c62..936d728ba1ca 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1857,16 +1857,18 @@ __get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
 		 */
 		pgoff = 0;
 		get_area = shmem_get_unmapped_area;
-	} else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
-		/* Ensures that larger anonymous mappings are THP aligned. */
-		get_area = thp_get_unmapped_area;
 	}
 
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


