Return-Path: <linux-kernel+bounces-67820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 448D185716A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68EDE1C218B3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F02B14C59C;
	Thu, 15 Feb 2024 23:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J67+WqLJ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51D214A4C9
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 23:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708038885; cv=none; b=kphL5IjI8qtSvNR3bQQLe73WFLlx1vmTgKG1iywqnyPrrGvAxQH4Fr83gBjS4nPfOpJYK1dskOvZK61GC1M/+FXNsX+qt4igigV3/CZnaoV3fS2jFXDz43s0csBVdz0wmlN0UniZgI5OjhWUv+ZwAVMuiWd8Fc+B4AT+5QxZFYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708038885; c=relaxed/simple;
	bh=VO9DQY6lGtiG1eC5gi6w3K4FE6tMMi6+Q5ti33XNprc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JqbkO8CciD7zEOoEuPQ2wt61aJ5HfhK+Agm4cJjOgc4Auwtdm6tKVrWiqqz1dpW4AfjMU+2fgbR06CZSi0HYj7oqDODJ9WcbJYlToXmJ0aTH1dYlcfgL8f3m1Jyj6e6Rdeag6K6vQrr5J/D/hdY7oPcmD8JxUX+HxNJbEe140T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J67+WqLJ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708038884; x=1739574884;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VO9DQY6lGtiG1eC5gi6w3K4FE6tMMi6+Q5ti33XNprc=;
  b=J67+WqLJBRvfQDvEc8w0q2MZpIfq4EbTbPasgs/MIL1ucB8F0t1Izdph
   AnoHk+OtNrZDygV6IAuvYp8yCy8sWoy/baVZcWtvChTcHLCrq3d+4y9zn
   fp4WczYl9+n75Oxx7eiC/yHofsFcD/FRMEqA8Zh9mics4TpIQ2UaHM8NP
   GlPhKHi4fW7tTrsQfUdjda6UA+PdasrkVhfYTlaw49GODv1fHT0Kd5g+n
   6W0fn4gsGIDvGJbj7tPdKSXSGwIowtmkR/xrfqx6pNfhWDsoIGM7T+qBq
   /e6EfL9jU3eLeccw/BK8klCptxvVd8cXu7dCH1BcoCo1EX5YgfR5Csqbb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="2066382"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="2066382"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 15:14:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="912250203"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="912250203"
Received: from yshin-mobl1.amr.corp.intel.com (HELO rpedgeco-desk4.intel.com) ([10.209.95.133])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 15:14:41 -0800
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
Subject: [RFC PATCH 6/8] x86/mm: Implement HAVE_ARCH_UNMAPPED_AREA_VMFLAGS
Date: Thu, 15 Feb 2024 15:13:30 -0800
Message-Id: <20240215231332.1556787-7-rick.p.edgecombe@intel.com>
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

Add x86 arch implementations of arch_get_unmapped_area_vmflags/_topdown()
so future changes can allow the the guard gap of type of vma being placed
to be taken into account. This will be used for shadow stack memory.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/include/asm/pgtable_64.h |  1 +
 arch/x86/kernel/sys_x86_64.c      | 29 ++++++++++++++++++++++-------
 2 files changed, 23 insertions(+), 7 deletions(-)

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
index c783aeb37dce..f92780cf9662 100644
--- a/arch/x86/kernel/sys_x86_64.c
+++ b/arch/x86/kernel/sys_x86_64.c
@@ -119,9 +119,9 @@ static void find_start_end(unsigned long addr, unsigned long flags,
 		*end = task_size_64bit(addr > DEFAULT_MAP_WINDOW);
 }
 
-unsigned long
-arch_get_unmapped_area(struct file *filp, unsigned long addr,
-		unsigned long len, unsigned long pgoff, unsigned long flags)
+extern unsigned long
+arch_get_unmapped_area_vmflags(struct file *filp, unsigned long addr, unsigned long len,
+		       unsigned long pgoff, unsigned long flags, vm_flags_t vm_flags)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
@@ -157,10 +157,10 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	return vm_unmapped_area(&info);
 }
 
-unsigned long
-arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
-			  const unsigned long len, const unsigned long pgoff,
-			  const unsigned long flags)
+extern unsigned long
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


