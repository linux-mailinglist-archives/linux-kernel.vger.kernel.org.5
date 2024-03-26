Return-Path: <linux-kernel+bounces-118286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A2788B748
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 03:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F16151C33AC0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6D0127B60;
	Tue, 26 Mar 2024 02:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ENDzvvFT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA33C83CBE
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 02:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711419441; cv=none; b=bzh4A5FikK3VCPFXBx01WB2BIoNJ38TnI9E3Qc1AfFkuM+yD3arB4li7GvR5GyzhtYNhKJOpM/zyJLPVza5C29K9Rro5OaBv5d0ETxRArEPfjiJf5LIlMUk6l6/CMlKXKn8XHBY5O5KeT1a8/hkeJmWr1bF+6Vpn0aqJUWodHTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711419441; c=relaxed/simple;
	bh=lEMD/P3qLo8sANIiWTYyDSHpg8TQh31/i79RKWObRQk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qBwNmYhWcVTy2/kF6XNbvzxmG6wsFGeofUV5uZq2KEZAyo7SNKANV/EZ5E0SnepiUR/An7+2v73A0WFaim5Q95jisRieg9ezra3qD1XD7IuU/7CpNeizst7/cEtvQxz4qVLPf+d4V/NeWB1FEpgGq9oA5c60JeolF0cawgD+RJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ENDzvvFT; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711419440; x=1742955440;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lEMD/P3qLo8sANIiWTYyDSHpg8TQh31/i79RKWObRQk=;
  b=ENDzvvFTmcuGILvodFjMByE/RdSGTrACDm3U5tOd03uYjtAUA/2t1vs5
   h2Ahrlbm+P5gHzVlQk07Go74UGUTrSbyzqF7R9EryGpB2jpZKeOGw9kdk
   kN4JVuPu+YgeFv2x3iRK3Shn2J1VJR9qLQG1Xcs78yhYxA6ZSfqXOPGIa
   Q8zy37sijVR2aE6mpImDfbEkmBT+or628AEFpQ4r53W6+rD1lQRRyeenx
   xQbOX+1MLdd4l1/WKw7SzlxSD7OEequQCp7s0sEMo7MM6YH/C1rsUkF/N
   St85FZNOoghwua85+gTtf9bP0s3EOg0L1RNjsHRs0tOuD66lK62icyddT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6564273"
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="6564273"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 19:17:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="20489886"
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
Subject: [PATCH v4 06/14] thp: Add thp_get_unmapped_area_vmflags()
Date: Mon, 25 Mar 2024 19:16:48 -0700
Message-Id: <20240326021656.202649-7-rick.p.edgecombe@intel.com>
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

Add a THP implementations of the vm_flags variant of get_unmapped_area().
Future changes will call this from mmap.c in the do_mmap() path to allow
shadow stacks to be placed with consideration taken for the start guard
gap. Shadow stack memory is always private and anonymous and so special
guard gap logic is not needed in a lot of caseis, but it can be mapped by
THP, so needs to be handled.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 include/linux/huge_mm.h | 11 +++++++++++
 mm/huge_memory.c        | 23 ++++++++++++++++-------
 mm/mmap.c               | 12 +++++++-----
 3 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index de0c89105076..cc599de5e397 100644
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
@@ -417,6 +420,14 @@ static inline void folio_prep_large_rmappable(struct folio *folio) {}
 
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
index cede9ccb84dc..b29f3e456888 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -808,7 +808,8 @@ static inline bool is_transparent_hugepage(struct folio *folio)
 
 static unsigned long __thp_get_unmapped_area(struct file *filp,
 		unsigned long addr, unsigned long len,
-		loff_t off, unsigned long flags, unsigned long size)
+		loff_t off, unsigned long flags, unsigned long size,
+		vm_flags_t vm_flags)
 {
 	loff_t off_end = off + len;
 	loff_t off_align = round_up(off, size);
@@ -824,8 +825,8 @@ static unsigned long __thp_get_unmapped_area(struct file *filp,
 	if (len_pad < len || (off + len_pad) < off)
 		return 0;
 
-	ret = mm_get_unmapped_area(current->mm, filp, addr, len_pad,
-				   off >> PAGE_SHIFT, flags);
+	ret = mm_get_unmapped_area_vmflags(current->mm, filp, addr, len_pad,
+					   off >> PAGE_SHIFT, flags, vm_flags);
 
 	/*
 	 * The failure might be due to length padding. The caller will retry
@@ -850,17 +851,25 @@ static unsigned long __thp_get_unmapped_area(struct file *filp,
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
index 68b5bfcebadd..f734e4fa6d94 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1861,20 +1861,22 @@ __get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
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


