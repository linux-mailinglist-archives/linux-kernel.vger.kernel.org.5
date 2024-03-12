Return-Path: <linux-kernel+bounces-100897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE38879EB9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A01561F2347A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B7C145B2A;
	Tue, 12 Mar 2024 22:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SyXcLdvt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C247314534D
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 22:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710282552; cv=none; b=i02bp9cBTflmBithrijKyaZNCzXFa7SejpGfGdnP7/YGxAI7hbR1uJ/3aoOGtFoPwlG2dKFq2s12E51b2JWORl1WL01hj3vKT5V8FaCnE016eWtfJVqU/L30w0F05E47ywExLW50QEdohKSIi+Z2y+/5K0QZb1GXqFbsn64YaHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710282552; c=relaxed/simple;
	bh=CreGxe5/iXfUXls5YDaI9mwicpyrEDmmn8Wmlsjwro0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bD5cogevrATZiwhcAS90A0Clm9uXYZxf1d/MJvcDlrABD7UTFCqWF7ua3e4ilP8Ecsj78A4o4gYcGn1N+9p664g0rvgQGqpcO/uoQtbvaEA40uN7gG86PNIhwj8HJcPJzICslGKWXYabxobOZjjiWSa7y/W4rBaEu/s6ZFsQ0Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SyXcLdvt; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710282551; x=1741818551;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CreGxe5/iXfUXls5YDaI9mwicpyrEDmmn8Wmlsjwro0=;
  b=SyXcLdvtMsMYzgACl6Hl1fzWH1D4E2TbtEvDmTfYxDHMjQ7dqe89vDXJ
   6Qoza3X00xbx1Lf7cOGfw2hvKkZR16+R+cIHFbO8G65nOJP4eJWTr/vZ6
   hOHCDKQCdVI68fJdPG0S+OwH7ZorGBCXcxsejUg1rejDY2tzChMIJwuut
   qNR7f/An1P9YJj7PB3+mgn6KAeLejQWw6QvevsTQac+21kPhfakDHbA9g
   UHsPC7tfQRYqd8wzhKaPwsf1wzDd53IEG+TOeQW7FWj0wNlnFFG5AKolD
   qNVlq79QmVAxtHTA7Wf0OYwa7o1r71YZypqDUiNWqbAYrGdmRQs+W4XDf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="5192058"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="5192058"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 15:29:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="16356880"
Received: from gargayus-mobl1.amr.corp.intel.com (HELO rpedgeco-desk4.intel.com) ([10.255.231.196])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 15:29:04 -0700
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
Subject: [PATCH v3 10/12] x86/mm: Implement HAVE_ARCH_UNMAPPED_AREA_VMFLAGS
Date: Tue, 12 Mar 2024 15:28:41 -0700
Message-Id: <20240312222843.2505560-11-rick.p.edgecombe@intel.com>
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

Add x86 arch implementations of arch_get_unmapped_area_vmflags/_topdown()
so future changes can allow the guard gap of type of vma being placed to
be taken into account. This will be used for shadow stack memory.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
v3:
 - Commit log grammar

v2:
 - Remove unnecessary added extern
---
 arch/x86/include/asm/pgtable_64.h |  1 +
 arch/x86/kernel/sys_x86_64.c      | 25 ++++++++++++++++++++-----
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index 24af25b1551a..13dcaf436efd 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -244,6 +244,7 @@ extern void cleanup_highmap(void);
 
 #define HAVE_ARCH_UNMAPPED_AREA
 #define HAVE_ARCH_UNMAPPED_AREA_TOPDOWN
+#define HAVE_ARCH_UNMAPPED_AREA_VMFLAGS
 
 #define PAGE_AGP    PAGE_KERNEL_NOCACHE
 #define HAVE_PAGE_AGP 1
diff --git a/arch/x86/kernel/sys_x86_64.c b/arch/x86/kernel/sys_x86_64.c
index b3278e4f7e59..d6fbc4dd08ef 100644
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
@@ -156,9 +156,9 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
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
@@ -227,3 +227,18 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
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


