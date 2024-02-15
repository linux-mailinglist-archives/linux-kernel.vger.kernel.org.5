Return-Path: <linux-kernel+bounces-67815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC53857165
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 638CF1C203A8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EEE14A4E9;
	Thu, 15 Feb 2024 23:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bjSdW0Fi"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70096145346
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 23:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708038883; cv=none; b=jNx2rAxrlh9B29fpxUxcNldgT1F5Fl2g6eJMvVVLg3u4LKb5g9XuPkXHCkyo46cPs0iw0WOjZayAf+FhSGZGQ9WPEmfIKhtTDq/5OgksizcrazQDULpztXmlyR4nVrgz/4f4ViLo80CAcN/hNLm6J4e7UaQVk9VP6SCNj6/vBM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708038883; c=relaxed/simple;
	bh=NmgdWGUKdUuPH56dpQmxlcj6RB+edyhe9JvhgeXosrc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QIx8ks7WFcZbpnSKUGypeRd+AIwVErxY01fXPgNbgyCu8TnWKLqe3zQknkxZYrg14mCqQ9woWk3YaVD034Wz3so8x2zlL3jRaqRg+c76ICyXux+05Yrtt6/lVFzlScZGVhuS4jIKMSXNNGYXR9H5YJh/DIHdAFiqvIN/0B3hzJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bjSdW0Fi; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708038881; x=1739574881;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NmgdWGUKdUuPH56dpQmxlcj6RB+edyhe9JvhgeXosrc=;
  b=bjSdW0FiZPOIPYqgZjTJtj/8HojCKHYM1z3hDgxnfScB+SH2YcZkXIwF
   aBnp5shlB6XSIaZ+OAVMGgmZcw3wgbWkyzjzjdIMBwDAn/x2PVp4+nAwL
   vE0rZUvMCjGVftzZEr9y30opbdXlqhpcOur0vmrGuZgD+JX3S4tls3tNc
   2jQn8NJI1dHyMAE2q/+91lX6QgIz2TOScFWfW8NC531ewJMhn64rZxJ4M
   Fb5cQNMOBeeXCrLYU6KNgLvc9Gxw8HWU5Mz0ArK+NZpS0ibu+3OuJ7iVt
   jAPgaHa0PRoK0uUIQw9uCt/OGRBTg5t85eghuNYt8MJKQyZwWfAEJ0go6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="2066326"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="2066326"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 15:14:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="912250191"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="912250191"
Received: from yshin-mobl1.amr.corp.intel.com (HELO rpedgeco-desk4.intel.com) ([10.209.95.133])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 15:14:38 -0800
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
Subject: [RFC PATCH 2/8] mm: Introduce arch_get_unmapped_area_vmflags()
Date: Thu, 15 Feb 2024 15:13:26 -0800
Message-Id: <20240215231332.1556787-3-rick.p.edgecombe@intel.com>
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


