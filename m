Return-Path: <linux-kernel+bounces-82205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EFF8680CF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 252E6B2C072
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CE6131E27;
	Mon, 26 Feb 2024 19:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BMTozr32"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A9C12FF64
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 19:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708974601; cv=none; b=LJfQYh5jO0cNY3awX1TEG1RYpkjAUQ7eZx1EPALaG4t3bp9VADOK4j/Bb9VHk3K2J6+jnzlbdDMRvgsC9UkkAZMDkTxr9lprH6kCVXomHzKAl/4MgNvztxT6lSXXIORucyhiBkQcvs0wbx+EJYUrqKaLfdYRwOIxTc3Wipk9v6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708974601; c=relaxed/simple;
	bh=NmgdWGUKdUuPH56dpQmxlcj6RB+edyhe9JvhgeXosrc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bUErzU2Q/Flq9DD56fVflW0ExcQFnol2VHzNMXE4mxwF+QKluSu8073pn3z9hTj6iubOeEH3dfU9MqA4i5GjEPqCRUl7DVQmcjvB6To/eD7MBl6FosVlE7/AP1UHc5iHLVXKTlPgyig+oF9sYnQEjAHIFEfo9C1lq3Y57uBX+5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BMTozr32; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708974600; x=1740510600;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NmgdWGUKdUuPH56dpQmxlcj6RB+edyhe9JvhgeXosrc=;
  b=BMTozr32Ybu9fPRNdf/0/sV47vpUR3CZFP6n72QeyduUXY6pfhIXWbHN
   L3zlhki4cDQbB3a4UmCJQAniwEvQB176rKdCelJpaN7CSdtjmkG5lw99t
   Dya6cJ3uxr+mlgyd8+xU/tB8WpPF6PjWfW//PIEvvL6dCAOk4h3VuLezU
   n9sCOAKcCOwgBJ67JdTeAwmoy+7rDHx/em5MxBL+JDeMgMuWm0I3/aU6U
   sE2prZnCnOWJpB0gCrJZtbJZ2L4FImz6632Lc4pwf6UDV0bmJ06akqAsC
   c+RgoH7wPyL2b+Qgc2E0OC8f2Y82cBNySMYqBy0WuQtnWLY36L5waEMXc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="14721338"
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="14721338"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 11:09:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="6911445"
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
Subject: [PATCH v2 2/9] mm: Introduce arch_get_unmapped_area_vmflags()
Date: Mon, 26 Feb 2024 11:09:44 -0800
Message-Id: <20240226190951.3240433-3-rick.p.edgecombe@intel.com>
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

In order to take the start gap into account, the maple tree search needs
to know the size of start gap the new mapping will need. The call chain
from do_mmap() to the actual maple tree search looks like this:

do_mmap(size, vm_flags, map_flags, ..)
	mm/mmap.c:get_unmapped_area(size, map_flags, ...)
		arch_get_unmapped_area(size, map_flags, ...)
			vm_unmapped_area(struct vm_unmapped_area_info)

One option would be to add another MAP_ flag to mean a one page start gap
(as is for shadow stack), but this consumes a flag unnecessarily. Another
option could be to simply increase the size passed in do_mmap() by the
start gap size, and adjust after the fact, but this will interfere with
the alignment requirements passed in struct vm_unmapped_area_info, and
unknown to mmap.c. Instead, introduce variants of
arch_get_unmapped_area/_topdown() that take vm_flags. In future changes,
these variants can be used in mmap.c:get_unmapped_area() to allow the
vm_flags to be passed through to vm_unmapped_area(), while preserving the
normal arch_get_unmapped_area/_topdown() for the existing callers.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 include/linux/sched/mm.h | 17 +++++++++++++++++
 mm/mmap.c                | 28 ++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index cde946e926d8..7b44441865c5 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -191,6 +191,23 @@ unsigned long mm_get_unmapped_area(struct mm_struct *mm, struct file *filp,
 				   unsigned long addr, unsigned long len,
 				   unsigned long pgoff, unsigned long flags);
 
+extern unsigned long
+arch_get_unmapped_area_vmflags(struct file *filp, unsigned long addr,
+			       unsigned long len, unsigned long pgoff,
+			       unsigned long flags, vm_flags_t vm_flags);
+extern unsigned long
+arch_get_unmapped_area_topdown_vmflags(struct file *filp, unsigned long addr,
+				       unsigned long len, unsigned long pgoff,
+				       unsigned long flags, vm_flags_t);
+
+unsigned long mm_get_unmapped_area_vmflags(struct mm_struct *mm,
+					   struct file *filp,
+					   unsigned long addr,
+					   unsigned long len,
+					   unsigned long pgoff,
+					   unsigned long flags,
+					   vm_flags_t vm_flags);
+
 unsigned long
 generic_get_unmapped_area(struct file *filp, unsigned long addr,
 			  unsigned long len, unsigned long pgoff,
diff --git a/mm/mmap.c b/mm/mmap.c
index b61bc515c729..2021bc040e81 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1802,6 +1802,34 @@ arch_get_unmapped_area_topdown(struct file *filp, unsigned long addr,
 }
 #endif
 
+#ifndef HAVE_ARCH_UNMAPPED_AREA_VMFLAGS
+extern unsigned long
+arch_get_unmapped_area_vmflags(struct file *filp, unsigned long addr, unsigned long len,
+			       unsigned long pgoff, unsigned long flags, vm_flags_t vm_flags)
+{
+	return arch_get_unmapped_area(filp, addr, len, pgoff, flags);
+}
+
+extern unsigned long
+arch_get_unmapped_area_topdown_vmflags(struct file *filp, unsigned long addr,
+				       unsigned long len, unsigned long pgoff,
+				       unsigned long flags, vm_flags_t vm_flags)
+{
+	return arch_get_unmapped_area_topdown(filp, addr, len, pgoff, flags);
+}
+#endif
+
+unsigned long mm_get_unmapped_area_vmflags(struct mm_struct *mm, struct file *filp,
+					   unsigned long addr, unsigned long len,
+					   unsigned long pgoff, unsigned long flags,
+					   vm_flags_t vm_flags)
+{
+	if (test_bit(MMF_TOPDOWN, &mm->flags))
+		return arch_get_unmapped_area_topdown_vmflags(filp, addr, len, pgoff,
+							      flags, vm_flags);
+	return arch_get_unmapped_area_vmflags(filp, addr, len, pgoff, flags, vm_flags);
+}
+
 unsigned long
 get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
 		unsigned long pgoff, unsigned long flags)
-- 
2.34.1


