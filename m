Return-Path: <linux-kernel+bounces-82209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A379868097
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32AAA1C2828E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA333132C20;
	Mon, 26 Feb 2024 19:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FmAmElEE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1828131E37;
	Mon, 26 Feb 2024 19:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708974605; cv=none; b=gtrJTgX2T1j3tGNIWY2WEFi7XeENlhzWoD1zb70HAQx7uqzSui/0+ois/1RrFp8wsgDjN1XVfZO62WkgLeUtdDNGLx1htf42vm8hXlYLmaGRqXhpY9gkPaWsXM+VxODiFYDjL/BQbOduLMI0QT6MxeT7U2FmU+YrSINEaAzOZL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708974605; c=relaxed/simple;
	bh=M4PemZaS0aqUDnC2dki1OuhIuHLGRlk1+X+hvrPVA+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N8iE2ocEDwqTtWa1fnPfxdDzy6iO/DL91ruAVjGuQzP4/Jej9fJsZTDLH2NGcFM9KUJaA6I9yhFtYsgBIeesz2moO1/WWR/zxf0+UIPYSUkMkmZYFDysnj/AIlkdHLkdF8RzAaJ6SUSjVuSuYHDaM8WL1HMbdJnQ44KYcqnkd9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FmAmElEE; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708974603; x=1740510603;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M4PemZaS0aqUDnC2dki1OuhIuHLGRlk1+X+hvrPVA+A=;
  b=FmAmElEE2j0GbdsLhEOnJFMYnobg+ZH8Wb4P+Wpnui51MRaU1GNBa/o2
   zCR2kG4rZtkdKacBLnb/hcSR7FkrMUdiIq3T0jCL/H9wUWMnaA69/uq/M
   FiUNg8n7zHJoQvDTWg0abSvuGfjEEexUzlMFtKdtdFAjw0idVT2ErxcOJ
   d74EHGW9ZI+FTxk1gQu6/epQBaooAucnfubjhCYI+ZU9+vpO5OQ0bazQG
   MHYaNbG5lW6neKfPIdpSpVXFPbt6BxB6EqWplYq5MASwijPutyrY0ViaJ
   WtUqCa92Vp9/DWHV+1RCSL/2JNOvCNCjBS8aJtHpuYGU818oqj0K1lbi8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="14721380"
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="14721380"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 11:10:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="6911458"
Received: from bdmirand-mobl.amr.corp.intel.com (HELO rpedgeco-desk4.intel.com) ([10.251.3.213])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 11:10:00 -0800
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
Cc: rick.p.edgecombe@intel.com,
	linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org
Subject: [PATCH v2 5/9] mm: Initialize struct vm_unmapped_area_info
Date: Mon, 26 Feb 2024 11:09:47 -0800
Message-Id: <20240226190951.3240433-6-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240226190951.3240433-1-rick.p.edgecombe@intel.com>
References: <20240226190951.3240433-1-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Future changes will need to add a field to struct vm_unmapped_area_info.
This would cause trouble for any archs that don't initialize the
struct. Currently every user sets each field, so if new fields are
added, the core code parsing the struct will see garbage in the new
field.

It could be possible to initialize the new field for each arch to 0, but
instead simply inialize the field with a C99 struct inializing syntax.

Cc: linux-mm@kvack.org
Cc: linux-alpha@vger.kernel.org
Cc: linux-snps-arc@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-csky@vger.kernel.org
Cc: loongarch@lists.linux.dev
Cc: linux-mips@vger.kernel.org
Cc: linux-parisc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-s390@vger.kernel.org
Cc: linux-sh@vger.kernel.org
Cc: sparclinux@vger.kernel.org
Cc: x86@kernel.org
Suggested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Link: https://lore.kernel.org/lkml/3ynogxcgokc6i6xojbxzzwqectg472laes24u7jmtktlxcch5e@dfytra3ia3zc/#t
---
Hi archs,

For some context, this is part of a larger series to improve shadow stack
guard gaps. It involves plumbing a new field via
struct vm_unmapped_area_info. The first user is x86, but arm and riscv may
likely use it as well. The change is compile tested only for non-x86 but
seems like a relatively safe one.

Thanks,

Rick

v2:
 - New patch
---
 arch/alpha/kernel/osf_sys.c      | 2 +-
 arch/arc/mm/mmap.c               | 2 +-
 arch/arm/mm/mmap.c               | 4 ++--
 arch/csky/abiv1/mmap.c           | 2 +-
 arch/loongarch/mm/mmap.c         | 2 +-
 arch/mips/mm/mmap.c              | 2 +-
 arch/parisc/kernel/sys_parisc.c  | 2 +-
 arch/powerpc/mm/book3s64/slice.c | 4 ++--
 arch/s390/mm/hugetlbpage.c       | 4 ++--
 arch/s390/mm/mmap.c              | 4 ++--
 arch/sh/mm/mmap.c                | 4 ++--
 arch/sparc/kernel/sys_sparc_32.c | 2 +-
 arch/sparc/kernel/sys_sparc_64.c | 4 ++--
 arch/sparc/mm/hugetlbpage.c      | 4 ++--
 arch/x86/kernel/sys_x86_64.c     | 4 ++--
 arch/x86/mm/hugetlbpage.c        | 4 ++--
 fs/hugetlbfs/inode.c             | 4 ++--
 mm/mmap.c                        | 4 ++--
 18 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
index 5db88b627439..dd6801bb9240 100644
--- a/arch/alpha/kernel/osf_sys.c
+++ b/arch/alpha/kernel/osf_sys.c
@@ -1218,7 +1218,7 @@ static unsigned long
 arch_get_unmapped_area_1(unsigned long addr, unsigned long len,
 		         unsigned long limit)
 {
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {};
 
 	info.flags = 0;
 	info.length = len;
diff --git a/arch/arc/mm/mmap.c b/arch/arc/mm/mmap.c
index 3c1c7ae73292..6549b3375f54 100644
--- a/arch/arc/mm/mmap.c
+++ b/arch/arc/mm/mmap.c
@@ -27,7 +27,7 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {};
 
 	/*
 	 * We enforce the MAP_FIXED case.
diff --git a/arch/arm/mm/mmap.c b/arch/arm/mm/mmap.c
index a0f8a0ca0788..525795578c29 100644
--- a/arch/arm/mm/mmap.c
+++ b/arch/arm/mm/mmap.c
@@ -34,7 +34,7 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	struct vm_area_struct *vma;
 	int do_align = 0;
 	int aliasing = cache_is_vipt_aliasing();
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {};
 
 	/*
 	 * We only need to do colour alignment if either the I or D
@@ -87,7 +87,7 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	unsigned long addr = addr0;
 	int do_align = 0;
 	int aliasing = cache_is_vipt_aliasing();
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {};
 
 	/*
 	 * We only need to do colour alignment if either the I or D
diff --git a/arch/csky/abiv1/mmap.c b/arch/csky/abiv1/mmap.c
index 6792aca49999..726659d41fa9 100644
--- a/arch/csky/abiv1/mmap.c
+++ b/arch/csky/abiv1/mmap.c
@@ -28,7 +28,7 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
 	int do_align = 0;
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {};
 
 	/*
 	 * We only need to do colour alignment if either the I or D
diff --git a/arch/loongarch/mm/mmap.c b/arch/loongarch/mm/mmap.c
index a9630a81b38a..664bf4abfdcf 100644
--- a/arch/loongarch/mm/mmap.c
+++ b/arch/loongarch/mm/mmap.c
@@ -24,7 +24,7 @@ static unsigned long arch_get_unmapped_area_common(struct file *filp,
 	struct vm_area_struct *vma;
 	unsigned long addr = addr0;
 	int do_color_align;
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {};
 
 	if (unlikely(len > TASK_SIZE))
 		return -ENOMEM;
diff --git a/arch/mips/mm/mmap.c b/arch/mips/mm/mmap.c
index 00fe90c6db3e..6321b53dc995 100644
--- a/arch/mips/mm/mmap.c
+++ b/arch/mips/mm/mmap.c
@@ -34,7 +34,7 @@ static unsigned long arch_get_unmapped_area_common(struct file *filp,
 	struct vm_area_struct *vma;
 	unsigned long addr = addr0;
 	int do_color_align;
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {};
 
 	if (unlikely(len > TASK_SIZE))
 		return -ENOMEM;
diff --git a/arch/parisc/kernel/sys_parisc.c b/arch/parisc/kernel/sys_parisc.c
index 98af719d5f85..e87c0e325abf 100644
--- a/arch/parisc/kernel/sys_parisc.c
+++ b/arch/parisc/kernel/sys_parisc.c
@@ -104,7 +104,7 @@ static unsigned long arch_get_unmapped_area_common(struct file *filp,
 	struct vm_area_struct *vma, *prev;
 	unsigned long filp_pgoff;
 	int do_color_align;
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {};
 
 	if (unlikely(len > TASK_SIZE))
 		return -ENOMEM;
diff --git a/arch/powerpc/mm/book3s64/slice.c b/arch/powerpc/mm/book3s64/slice.c
index c0b58afb9a47..5884f384866f 100644
--- a/arch/powerpc/mm/book3s64/slice.c
+++ b/arch/powerpc/mm/book3s64/slice.c
@@ -282,7 +282,7 @@ static unsigned long slice_find_area_bottomup(struct mm_struct *mm,
 {
 	int pshift = max_t(int, mmu_psize_defs[psize].shift, PAGE_SHIFT);
 	unsigned long found, next_end;
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {};
 
 	info.flags = 0;
 	info.length = len;
@@ -326,7 +326,7 @@ static unsigned long slice_find_area_topdown(struct mm_struct *mm,
 {
 	int pshift = max_t(int, mmu_psize_defs[psize].shift, PAGE_SHIFT);
 	unsigned long found, prev;
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {};
 	unsigned long min_addr = max(PAGE_SIZE, mmap_min_addr);
 
 	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
diff --git a/arch/s390/mm/hugetlbpage.c b/arch/s390/mm/hugetlbpage.c
index c2d2850ec8d5..7f68485feea0 100644
--- a/arch/s390/mm/hugetlbpage.c
+++ b/arch/s390/mm/hugetlbpage.c
@@ -258,7 +258,7 @@ static unsigned long hugetlb_get_unmapped_area_bottomup(struct file *file,
 		unsigned long pgoff, unsigned long flags)
 {
 	struct hstate *h = hstate_file(file);
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {};
 
 	info.flags = 0;
 	info.length = len;
@@ -274,7 +274,7 @@ static unsigned long hugetlb_get_unmapped_area_topdown(struct file *file,
 		unsigned long pgoff, unsigned long flags)
 {
 	struct hstate *h = hstate_file(file);
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {};
 	unsigned long addr;
 
 	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
index cd52d72b59cf..df88496e2903 100644
--- a/arch/s390/mm/mmap.c
+++ b/arch/s390/mm/mmap.c
@@ -77,7 +77,7 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr,
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {};
 
 	if (len > TASK_SIZE - mmap_min_addr)
 		return -ENOMEM;
@@ -116,7 +116,7 @@ unsigned long arch_get_unmapped_area_topdown(struct file *filp, unsigned long ad
 {
 	struct vm_area_struct *vma;
 	struct mm_struct *mm = current->mm;
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {};
 
 	/* requested length too big for entire address space */
 	if (len > TASK_SIZE - mmap_min_addr)
diff --git a/arch/sh/mm/mmap.c b/arch/sh/mm/mmap.c
index b82199878b45..6aee5f761e08 100644
--- a/arch/sh/mm/mmap.c
+++ b/arch/sh/mm/mmap.c
@@ -57,7 +57,7 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
 	int do_colour_align;
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {};
 
 	if (flags & MAP_FIXED) {
 		/* We do not accept a shared mapping if it would violate
@@ -106,7 +106,7 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	struct mm_struct *mm = current->mm;
 	unsigned long addr = addr0;
 	int do_colour_align;
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {};
 
 	if (flags & MAP_FIXED) {
 		/* We do not accept a shared mapping if it would violate
diff --git a/arch/sparc/kernel/sys_sparc_32.c b/arch/sparc/kernel/sys_sparc_32.c
index 082a551897ed..7e781dbfd052 100644
--- a/arch/sparc/kernel/sys_sparc_32.c
+++ b/arch/sparc/kernel/sys_sparc_32.c
@@ -41,7 +41,7 @@ SYSCALL_DEFINE0(getpagesize)
 
 unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr, unsigned long len, unsigned long pgoff, unsigned long flags)
 {
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {};
 
 	if (flags & MAP_FIXED) {
 		/* We do not accept a shared mapping if it would violate
diff --git a/arch/sparc/kernel/sys_sparc_64.c b/arch/sparc/kernel/sys_sparc_64.c
index 1dbf7211666e..fc48ab3f83af 100644
--- a/arch/sparc/kernel/sys_sparc_64.c
+++ b/arch/sparc/kernel/sys_sparc_64.c
@@ -93,7 +93,7 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr, unsi
 	struct vm_area_struct * vma;
 	unsigned long task_size = TASK_SIZE;
 	int do_color_align;
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {};
 
 	if (flags & MAP_FIXED) {
 		/* We do not accept a shared mapping if it would violate
@@ -154,7 +154,7 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	unsigned long task_size = STACK_TOP32;
 	unsigned long addr = addr0;
 	int do_color_align;
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {};
 
 	/* This should only ever run for 32-bit processes.  */
 	BUG_ON(!test_thread_flag(TIF_32BIT));
diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
index 38a1bef47efb..614e2c46d781 100644
--- a/arch/sparc/mm/hugetlbpage.c
+++ b/arch/sparc/mm/hugetlbpage.c
@@ -31,7 +31,7 @@ static unsigned long hugetlb_get_unmapped_area_bottomup(struct file *filp,
 {
 	struct hstate *h = hstate_file(filp);
 	unsigned long task_size = TASK_SIZE;
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {};
 
 	if (test_thread_flag(TIF_32BIT))
 		task_size = STACK_TOP32;
@@ -63,7 +63,7 @@ hugetlb_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	struct hstate *h = hstate_file(filp);
 	struct mm_struct *mm = current->mm;
 	unsigned long addr = addr0;
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {};
 
 	/* This should only ever run for 32-bit processes.  */
 	BUG_ON(!test_thread_flag(TIF_32BIT));
diff --git a/arch/x86/kernel/sys_x86_64.c b/arch/x86/kernel/sys_x86_64.c
index c783aeb37dce..6e5d4fa5fc42 100644
--- a/arch/x86/kernel/sys_x86_64.c
+++ b/arch/x86/kernel/sys_x86_64.c
@@ -125,7 +125,7 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {};
 	unsigned long begin, end;
 
 	if (flags & MAP_FIXED)
@@ -165,7 +165,7 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	struct vm_area_struct *vma;
 	struct mm_struct *mm = current->mm;
 	unsigned long addr = addr0;
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {};
 
 	/* requested length too big for entire address space */
 	if (len > TASK_SIZE)
diff --git a/arch/x86/mm/hugetlbpage.c b/arch/x86/mm/hugetlbpage.c
index 6d77c0039617..88726bd1f72d 100644
--- a/arch/x86/mm/hugetlbpage.c
+++ b/arch/x86/mm/hugetlbpage.c
@@ -51,7 +51,7 @@ static unsigned long hugetlb_get_unmapped_area_bottomup(struct file *file,
 		unsigned long pgoff, unsigned long flags)
 {
 	struct hstate *h = hstate_file(file);
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {};
 
 	info.flags = 0;
 	info.length = len;
@@ -74,7 +74,7 @@ static unsigned long hugetlb_get_unmapped_area_topdown(struct file *file,
 		unsigned long pgoff, unsigned long flags)
 {
 	struct hstate *h = hstate_file(file);
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {};
 
 	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
 	info.length = len;
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index a63d2eee086f..848b2239a215 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -165,7 +165,7 @@ hugetlb_get_unmapped_area_bottomup(struct file *file, unsigned long addr,
 		unsigned long len, unsigned long pgoff, unsigned long flags)
 {
 	struct hstate *h = hstate_file(file);
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {};
 
 	info.flags = 0;
 	info.length = len;
@@ -181,7 +181,7 @@ hugetlb_get_unmapped_area_topdown(struct file *file, unsigned long addr,
 		unsigned long len, unsigned long pgoff, unsigned long flags)
 {
 	struct hstate *h = hstate_file(file);
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {};
 
 	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
 	info.length = len;
diff --git a/mm/mmap.c b/mm/mmap.c
index e02bb17fef5b..33af683a643f 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1699,7 +1699,7 @@ generic_get_unmapped_area(struct file *filp, unsigned long addr,
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma, *prev;
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {};
 	const unsigned long mmap_end = arch_get_mmap_end(addr, len, flags);
 
 	if (len > mmap_end - mmap_min_addr)
@@ -1747,7 +1747,7 @@ generic_get_unmapped_area_topdown(struct file *filp, unsigned long addr,
 {
 	struct vm_area_struct *vma, *prev;
 	struct mm_struct *mm = current->mm;
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {};
 	const unsigned long mmap_end = arch_get_mmap_end(addr, len, flags);
 
 	/* requested length too big for entire address space */
-- 
2.34.1


