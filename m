Return-Path: <linux-kernel+bounces-82210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0249C868098
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C8E21F274EA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52A9132C26;
	Mon, 26 Feb 2024 19:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k1A88vYc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DDD132462
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 19:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708974606; cv=none; b=T7NpxK4W4b865yWAiRr8mgbMhPLgf58/2gAn9nKrwj6nVhk7LqZ2ynjAhqZeHnwirPfR5lDxctjiKUhTgZ+Q0qoOBu5SS774rpLV4vc6xicOSTKEqR/F6SNrg3Wkyj3/oWyDxfsBiQnPDKZ4LRX2jQNocgcXPsjITq0Zglos0LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708974606; c=relaxed/simple;
	bh=K/25qnwR+QY0dPYdq2kDmPj6NmWSjdLBsEBSug4d6Ew=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MGzDuy8hLI91SxhXW1moCZXku+kcdnIZtZc5XCBYzm+a+FX5jI5/P1Oq1Z25olTYmMuAgB6OidcprExdvt4XCiDu+Q/659IeUfluU/nFnDq83IbyK/T33vGNveZdz5yI5yLhvKCPX78JdWZ5lazTdtKpm8x7pQ536Uva7NMLo7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k1A88vYc; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708974605; x=1740510605;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K/25qnwR+QY0dPYdq2kDmPj6NmWSjdLBsEBSug4d6Ew=;
  b=k1A88vYcyjw6WJXT1de92wDZar6loS1AxV8YLoIv16Pp514N5h4ks4gV
   VupC4kF1yOrreFkc5xSd2JyW9hGvOqCqbIL6raTD5K1B+lkiJkjby3RVM
   hW6utWLD5isoT0WGW5no3u3kcuJHpDUOQQl6/LDB61M7jIf83MIgq/oGE
   2bOFVi219AITYKBhv41YqYBpqO7ZBVQENU2CaRzwoAgc1FcOZdGwdNWfU
   2bbCNiCalVwmhcApvu/wqD5It1gwu+LqRN6wTx+miXELWz8f4XuunxiiJ
   cOVoCbQPlgK2wHQVoZjkeXxIW0zwzY1tnySUSJdAx7sxCjEKI1IJ68SrB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="14721407"
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="14721407"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 11:10:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="6911467"
Received: from bdmirand-mobl.amr.corp.intel.com (HELO rpedgeco-desk4.intel.com) ([10.251.3.213])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 11:10:02 -0800
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
Subject: [PATCH v2 7/9] x86/mm: Implement HAVE_ARCH_UNMAPPED_AREA_VMFLAGS
Date: Mon, 26 Feb 2024 11:09:49 -0800
Message-Id: <20240226190951.3240433-8-rick.p.edgecombe@intel.com>
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

Add x86 arch implementations of arch_get_unmapped_area_vmflags/_topdown()
so future changes can allow the the guard gap of type of vma being placed
to be taken into account. This will be used for shadow stack memory.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
v2:
 - Remove unnecessary added extern
---
 arch/x86/include/asm/pgtable_64.h |  1 +
 arch/x86/kernel/sys_x86_64.c      | 25 ++++++++++++++++++++-----
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index a629b1b9f65a..eb09a11621ad 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -244,6 +244,7 @@ extern void cleanup_highmap(void);
 
 #define HAVE_ARCH_UNMAPPED_AREA
 #define HAVE_ARCH_UNMAPPED_AREA_TOPDOWN
+#define HAVE_ARCH_UNMAPPED_AREA_VMFLAGS
 
 #define PAGE_AGP    PAGE_KERNEL_NOCACHE
 #define HAVE_PAGE_AGP 1
diff --git a/arch/x86/kernel/sys_x86_64.c b/arch/x86/kernel/sys_x86_64.c
index 6e5d4fa5fc42..95cb9efc47fb 100644
--- a/arch/x86/kernel/sys_x86_64.c
+++ b/arch/x86/kernel/sys_x86_64.c
@@ -120,8 +120,8 @@ static void find_start_end(unsigned long addr, unsigned long flags,
 }
 
 unsigned long
-arch_get_unmapped_area(struct file *filp, unsigned long addr,
-		unsigned long len, unsigned long pgoff, unsigned long flags)
+arch_get_unmapped_area_vmflags(struct file *filp, unsigned long addr, unsigned long len,
+		       unsigned long pgoff, unsigned long flags, vm_flags_t vm_flags)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
@@ -158,9 +158,9 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 }
 
 unsigned long
-arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
-			  const unsigned long len, const unsigned long pgoff,
-			  const unsigned long flags)
+arch_get_unmapped_area_topdown_vmflags(struct file *filp, unsigned long addr0,
+			  unsigned long len, unsigned long pgoff,
+			  unsigned long flags, vm_flags_t vm_flags)
 {
 	struct vm_area_struct *vma;
 	struct mm_struct *mm = current->mm;
@@ -230,3 +230,18 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	 */
 	return arch_get_unmapped_area(filp, addr0, len, pgoff, flags);
 }
+
+unsigned long
+arch_get_unmapped_area(struct file *filp, unsigned long addr,
+		unsigned long len, unsigned long pgoff, unsigned long flags)
+{
+	return arch_get_unmapped_area_vmflags(filp, addr, len, pgoff, flags, 0);
+}
+
+unsigned long
+arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr,
+			  const unsigned long len, const unsigned long pgoff,
+			  const unsigned long flags)
+{
+	return arch_get_unmapped_area_topdown_vmflags(filp, addr, len, pgoff, flags, 0);
+}
-- 
2.34.1


