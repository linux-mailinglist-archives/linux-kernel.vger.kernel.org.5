Return-Path: <linux-kernel+bounces-82206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D878680A9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2E75B2C144
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C855C131E2F;
	Mon, 26 Feb 2024 19:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bb7Gj0zQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF3612FF6E
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 19:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708974601; cv=none; b=fC0dIb0Lc+LYUA1Ua+iVxIzGjrS5Dx/Ut8l7+M5trI7wO1qPmt+iV+C9DyCTdcbExYHqYuolKYxMubqSeaVXIxBHDhv1VWmvAameyRG6G+fF0Vv5iWZzNTou1OwcQlD1yCWhRA2VWRqxX0W8KZfyIp/mLx/hdnlpFmX9DSZkwfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708974601; c=relaxed/simple;
	bh=UpMkpaIresTqtixl68LlSa8NKJ54JsLLMvQyZqHlQM8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XD8BKFeelfWWRSX6LY7gu0lk1T3/6WRt6jfNEchnF/O8Hi6QdjSy6UhiKYm9dRPBaqmvvocC9koR+K+0+Eq+GY7Nwy1mbIS48eif6uhuIInCdCt2Cozp8UelxGeMUpQwxrMB6K3kpGrRvUbGDvZflHgo7c95a90TLkyAVYO/RA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bb7Gj0zQ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708974600; x=1740510600;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UpMkpaIresTqtixl68LlSa8NKJ54JsLLMvQyZqHlQM8=;
  b=Bb7Gj0zQnHHADrg/RL4WxdAJVTz38K88WKxl3HbWea/3PFo9frinNTqF
   6RaVJ8UzgMQOOW1+dv9Ev4YrAGAcnd+HS6ozgYVOf7cvmtf9GGUbRqe5D
   yR2rffwqB4iHmn6EBdvH1fdUMenu78rrtWo2Ia5JjQDA27YJ4bCoI5YU4
   auv2fkQNl0aMEPQk1ObHVUUb8fg2ejRF2Gg0FqDCLnwArtB8X3sWlqgJX
   9Izn0Uyko4v03xWcguqQJDSV1C6t/nvFPwkiyCPw4LhzGrgk+XSwh5PP4
   x9QZvPwXIrqyy1NyUhW/wd0kSFPErkOjAOgNZiI07bJc0fK8p3AfN/bn3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="14721352"
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="14721352"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 11:10:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="6911448"
Received: from bdmirand-mobl.amr.corp.intel.com (HELO rpedgeco-desk4.intel.com) ([10.251.3.213])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 11:09:58 -0800
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
Subject: [PATCH v2 3/9] mm: Use get_unmapped_area_vmflags()
Date: Mon, 26 Feb 2024 11:09:45 -0800
Message-Id: <20240226190951.3240433-4-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240226190951.3240433-1-rick.p.edgecombe@intel.com>
References: <20240226190951.3240433-1-rick.p.edgecombe@intel.com>
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
index da5219b48d52..a091181ef65a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3351,7 +3351,16 @@ extern int install_special_mapping(struct mm_struct *mm,
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
index 2021bc040e81..ac7601d05e89 100644
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
 
@@ -1879,8 +1879,6 @@ get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
 	return error ? error : addr;
 }
 
-EXPORT_SYMBOL(get_unmapped_area);
-
 unsigned long
 mm_get_unmapped_area(struct mm_struct *mm, struct file *file,
 		     unsigned long addr, unsigned long len,
-- 
2.34.1


