Return-Path: <linux-kernel+bounces-100888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 701A9879EA8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF8062873A8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D362C144055;
	Tue, 12 Mar 2024 22:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TFB8VeGm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55749143C67
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 22:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710282547; cv=none; b=KbdKEgoRhsflhFCmsYss7GlgTTXGnuW+1zkiOxG+7POF8HygxQdvtcX7f2RDBWQN7jWbnX6FsG6GKFjX/l0FUHAzyCA6oZANfdGCFafQZM/pd4UjuqfLdiHdCtGuRwFWnVBa4JuctPRJZdREVj8PZA68gCtspzzN0iwfFdYJk+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710282547; c=relaxed/simple;
	bh=dgRXKbvPqyuL8hOX1YSrzuU0fpl568sxa0M2x6sm+7M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XdgfsPelgrty0UabL2Twfx8bRC8w0zzymNnjAs757+IDOVca6JkRy+VM1oHgurde5BUX8JLpqQiZWZEbf8T/C1jZ9tLS8rkIogq5E0AVDA4fm2k/U6PXKp7Dp0NInQTDLB2pendgHjj94XJl/XhqW0E/cusH0qO5VkNXcp7d+MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TFB8VeGm; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710282546; x=1741818546;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dgRXKbvPqyuL8hOX1YSrzuU0fpl568sxa0M2x6sm+7M=;
  b=TFB8VeGmoVtM4LI8BsNN8T/jXdfDHfhMxEJhfEypwQUKq9yNUtkynoZg
   xOw12WER5Qufxai22EBT3Ks78X+zu6wkhaYhLcrAVTaHnvP6esq7fAOQR
   vKFEUSfl6sI7FYsJyqdgTXJE+9gNQRwN8daiJYWd79RdTVQo7t4THKXJV
   Ltu0FoqU6KiovaW33u8CQOFZo07W/UW9DVdy4eMTHGYjWK/zU9gI5kxgt
   l2+tohsOMVgjIYroWM3H7BEEwFNTwt7EDd+nrQtesakuGct5F01CG3yhZ
   q4LC7s7VXvaBdvHOxrVeZSEhFZHe9hNpLqNdCEHG8Wsu3WrBy46XNIUAB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="5191940"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="5191940"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 15:29:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="16356831"
Received: from gargayus-mobl1.amr.corp.intel.com (HELO rpedgeco-desk4.intel.com) ([10.255.231.196])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 15:29:01 -0700
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
Subject: [PATCH v3 02/12] mm: Introduce arch_get_unmapped_area_vmflags()
Date: Tue, 12 Mar 2024 15:28:33 -0700
Message-Id: <20240312222843.2505560-3-rick.p.edgecombe@intel.com>
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
index 39e9a3ae3ca5..e23ce8ca24c9 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1810,6 +1810,34 @@ arch_get_unmapped_area_topdown(struct file *filp, unsigned long addr,
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


