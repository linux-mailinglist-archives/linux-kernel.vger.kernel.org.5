Return-Path: <linux-kernel+bounces-100895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4297C879EBA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE3DA288EC0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EFF145B30;
	Tue, 12 Mar 2024 22:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KTuSXWWb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F464143727;
	Tue, 12 Mar 2024 22:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710282552; cv=none; b=kgU0Jo3YYWX3XkgZv+9agHYBAijDKwCmC50Ckl0VytVvmPf2HfIcH8ldjz+pPdUAI3/N8Sp9g6WOFH8Henx1Xo4yfcRE6B2AG/V0WCLFXrq4ED3Uiz0bfSRQRdSFGxq646w5J5ePTTaG00oNZWz/wxHJ49F3fY2Gidj1kI3H5vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710282552; c=relaxed/simple;
	bh=D1/EWAXI8SpxfCEHFRS2m8qX6cfft62KgrdcBDWVQkY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ulgPVreWefIx1q7lyyOXAxxlS114yArjz0nElqVmUWmRsx2mRZVYQqb6W7aLTvoTIFrGRKT4EW2B9m3koI8LrlG/3FmkA2gAr5a+LZuxvHXGx/JzwzeruYcUFsKWnzT2iZlc8G0MOn8JsqAhtBT92jY490+yWXciBz909Enfu8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KTuSXWWb; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710282550; x=1741818550;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D1/EWAXI8SpxfCEHFRS2m8qX6cfft62KgrdcBDWVQkY=;
  b=KTuSXWWbnVLPx/y/uALVzuPrVBkQiIHal561a+UOUuZ7qEllLD4L0X2T
   BSgvy25QVnIcL4jytEdOzc+2gdzzTWrnOe4XlxeZBTfFBc2LyxGi/SJNW
   TaXPZ5H5H+qVosAlsyVJZqWaFHaPxGbPuoIRo10x9J69yh8xzjWQWgs/7
   hC+eJNI3aw92i6afrESbL2ma83XJcKzBQDaghZyWpVLa7E3uRg4RSsjct
   CwoofCfN9opBZft5d2WYvnN9tGoEw/WAx2hkGEhlSr7j0VbevDnpgzPgB
   Nz7KsWx9KoDEbfYxT3vaMR2vvAIVfnb0dqNkBIThCdJQeECD7duho82Ec
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="5192024"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="5192024"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 15:29:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="16356866"
Received: from gargayus-mobl1.amr.corp.intel.com (HELO rpedgeco-desk4.intel.com) ([10.255.231.196])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 15:29:03 -0700
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
	rick.p.edgecombe@intel.com,
	linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org
Subject: [PATCH v3 08/12] treewide: Use initializer for struct vm_unmapped_area_info
Date: Tue, 12 Mar 2024 15:28:39 -0700
Message-Id: <20240312222843.2505560-9-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312222843.2505560-1-rick.p.edgecombe@intel.com>
References: <20240312222843.2505560-1-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Future changes will need to add a new member to struct
vm_unmapped_area_info. This would cause trouble for any call site that
doesn't initialize the struct. Currently every caller sets each member
manually, so if new ones are added they will be uninitialized and the
core code parsing the struct will see garbage in the new member.

It could be possible to initialize the new member manually to 0 at each
call site. This and a couple other options were discussed. Having some
struct vm_unmapped_area_info instances not zero initialized will put
those sites at risk of feeding garbage into vm_unmapped_area(), if the
convention is to zero initialize the struct and any new field addition
missed a call site that initializes each field manually. So it is
useful to do things similar across the kernel.

The consensus (see links) was that in general the best way to accomplish
taking into account both code cleanliness and minimizing the chance of
introducing bugs, was to do C99 static initialization. As in:
struct vm_unmapped_area_info info = {};

With this method of initialization, the whole struct will be zero
initialized, and any statements setting fields to zero will be unneeded.
The change should not leave cleanup at the call sides.

While iterating though the possible solutions a few archs kindly acked
other variations that still zero initialized the struct. These sites have
been modified in previous changes using the pattern acked by the respective
arch.

So to be reduce the chance of bugs via uninitialized fields, perform a
tree wide change using the consensus for the best general way to do this
change. Use C99 static initializing to zero the struct and remove and
statements that simply set members to zero.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: linux-mm@kvack.org
Cc: linux-alpha@vger.kernel.org
Cc: linux-snps-arc@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-csky@vger.kernel.org
Cc: loongarch@lists.linux.dev
Cc: linux-mips@vger.kernel.org
Cc: linux-s390@vger.kernel.org
Cc: linux-sh@vger.kernel.org
Cc: sparclinux@vger.kernel.org
Link: https://lore.kernel.org/lkml/202402280912.33AEE7A9CF@keescook/#t
Link: https://lore.kernel.org/lkml/j7bfvig3gew3qruouxrh7z7ehjjafrgkbcmg6tcghhfh3rhmzi@wzlcoecgy5rs/
Link: https://lore.kernel.org/lkml/ec3e377a-c0a0-4dd3-9cb9-96517e54d17e@csgroup.eu/
---
Hi archs,

For some context, this is part of a larger series to improve shadow stack
guard gaps. It involves plumbing a new field via
struct vm_unmapped_area_info. The first user is x86, but arm and riscv may
likely use it as well. The change is compile tested only for non-x86.

Thanks,

Rick
---
 arch/alpha/kernel/osf_sys.c      |  5 +----
 arch/arc/mm/mmap.c               |  4 +---
 arch/arm/mm/mmap.c               |  5 ++---
 arch/loongarch/mm/mmap.c         |  3 +--
 arch/mips/mm/mmap.c              |  3 +--
 arch/s390/mm/hugetlbpage.c       |  7 ++-----
 arch/s390/mm/mmap.c              | 11 ++++-------
 arch/sh/mm/mmap.c                |  5 ++---
 arch/sparc/kernel/sys_sparc_32.c |  3 +--
 arch/sparc/kernel/sys_sparc_64.c |  5 ++---
 arch/sparc/mm/hugetlbpage.c      |  7 ++-----
 arch/x86/kernel/sys_x86_64.c     |  7 ++-----
 arch/x86/mm/hugetlbpage.c        |  7 ++-----
 fs/hugetlbfs/inode.c             |  7 ++-----
 mm/mmap.c                        |  9 ++-------
 15 files changed, 27 insertions(+), 61 deletions(-)

diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
index 5db88b627439..e5f881bc8288 100644
--- a/arch/alpha/kernel/osf_sys.c
+++ b/arch/alpha/kernel/osf_sys.c
@@ -1218,14 +1218,11 @@ static unsigned long
 arch_get_unmapped_area_1(unsigned long addr, unsigned long len,
 		         unsigned long limit)
 {
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {};
 
-	info.flags = 0;
 	info.length = len;
 	info.low_limit = addr;
 	info.high_limit = limit;
-	info.align_mask = 0;
-	info.align_offset = 0;
 	return vm_unmapped_area(&info);
 }
 
diff --git a/arch/arc/mm/mmap.c b/arch/arc/mm/mmap.c
index 3c1c7ae73292..69a915297155 100644
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
@@ -51,11 +51,9 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 			return addr;
 	}
 
-	info.flags = 0;
 	info.length = len;
 	info.low_limit = mm->mmap_base;
 	info.high_limit = TASK_SIZE;
-	info.align_mask = 0;
 	info.align_offset = pgoff << PAGE_SHIFT;
 	return vm_unmapped_area(&info);
 }
diff --git a/arch/arm/mm/mmap.c b/arch/arm/mm/mmap.c
index a0f8a0ca0788..d65d0e6ed10a 100644
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
@@ -68,7 +68,6 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 			return addr;
 	}
 
-	info.flags = 0;
 	info.length = len;
 	info.low_limit = mm->mmap_base;
 	info.high_limit = TASK_SIZE;
@@ -87,7 +86,7 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	unsigned long addr = addr0;
 	int do_align = 0;
 	int aliasing = cache_is_vipt_aliasing();
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {};
 
 	/*
 	 * We only need to do colour alignment if either the I or D
diff --git a/arch/loongarch/mm/mmap.c b/arch/loongarch/mm/mmap.c
index a9630a81b38a..4bbd449b4a47 100644
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
@@ -82,7 +82,6 @@ static unsigned long arch_get_unmapped_area_common(struct file *filp,
 		 */
 	}
 
-	info.flags = 0;
 	info.low_limit = mm->mmap_base;
 	info.high_limit = TASK_SIZE;
 	return vm_unmapped_area(&info);
diff --git a/arch/mips/mm/mmap.c b/arch/mips/mm/mmap.c
index 00fe90c6db3e..7e11d7b58761 100644
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
@@ -92,7 +92,6 @@ static unsigned long arch_get_unmapped_area_common(struct file *filp,
 		 */
 	}
 
-	info.flags = 0;
 	info.low_limit = mm->mmap_base;
 	info.high_limit = TASK_SIZE;
 	return vm_unmapped_area(&info);
diff --git a/arch/s390/mm/hugetlbpage.c b/arch/s390/mm/hugetlbpage.c
index c2d2850ec8d5..51fb3806395b 100644
--- a/arch/s390/mm/hugetlbpage.c
+++ b/arch/s390/mm/hugetlbpage.c
@@ -258,14 +258,12 @@ static unsigned long hugetlb_get_unmapped_area_bottomup(struct file *file,
 		unsigned long pgoff, unsigned long flags)
 {
 	struct hstate *h = hstate_file(file);
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {};
 
-	info.flags = 0;
 	info.length = len;
 	info.low_limit = current->mm->mmap_base;
 	info.high_limit = TASK_SIZE;
 	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
-	info.align_offset = 0;
 	return vm_unmapped_area(&info);
 }
 
@@ -274,7 +272,7 @@ static unsigned long hugetlb_get_unmapped_area_topdown(struct file *file,
 		unsigned long pgoff, unsigned long flags)
 {
 	struct hstate *h = hstate_file(file);
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {};
 	unsigned long addr;
 
 	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
@@ -282,7 +280,6 @@ static unsigned long hugetlb_get_unmapped_area_topdown(struct file *file,
 	info.low_limit = PAGE_SIZE;
 	info.high_limit = current->mm->mmap_base;
 	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
-	info.align_offset = 0;
 	addr = vm_unmapped_area(&info);
 
 	/*
diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
index cd52d72b59cf..5c9d9f18a55f 100644
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
@@ -93,14 +93,12 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr,
 			goto check_asce_limit;
 	}
 
-	info.flags = 0;
 	info.length = len;
 	info.low_limit = mm->mmap_base;
 	info.high_limit = TASK_SIZE;
 	if (filp || (flags & MAP_SHARED))
 		info.align_mask = MMAP_ALIGN_MASK << PAGE_SHIFT;
-	else
-		info.align_mask = 0;
+
 	info.align_offset = pgoff << PAGE_SHIFT;
 	addr = vm_unmapped_area(&info);
 	if (offset_in_page(addr))
@@ -116,7 +114,7 @@ unsigned long arch_get_unmapped_area_topdown(struct file *filp, unsigned long ad
 {
 	struct vm_area_struct *vma;
 	struct mm_struct *mm = current->mm;
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {};
 
 	/* requested length too big for entire address space */
 	if (len > TASK_SIZE - mmap_min_addr)
@@ -140,8 +138,7 @@ unsigned long arch_get_unmapped_area_topdown(struct file *filp, unsigned long ad
 	info.high_limit = mm->mmap_base;
 	if (filp || (flags & MAP_SHARED))
 		info.align_mask = MMAP_ALIGN_MASK << PAGE_SHIFT;
-	else
-		info.align_mask = 0;
+
 	info.align_offset = pgoff << PAGE_SHIFT;
 	addr = vm_unmapped_area(&info);
 
diff --git a/arch/sh/mm/mmap.c b/arch/sh/mm/mmap.c
index b82199878b45..bee329d4149a 100644
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
@@ -88,7 +88,6 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr,
 			return addr;
 	}
 
-	info.flags = 0;
 	info.length = len;
 	info.low_limit = TASK_UNMAPPED_BASE;
 	info.high_limit = TASK_SIZE;
@@ -106,7 +105,7 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	struct mm_struct *mm = current->mm;
 	unsigned long addr = addr0;
 	int do_colour_align;
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {};
 
 	if (flags & MAP_FIXED) {
 		/* We do not accept a shared mapping if it would violate
diff --git a/arch/sparc/kernel/sys_sparc_32.c b/arch/sparc/kernel/sys_sparc_32.c
index 082a551897ed..08a19727795c 100644
--- a/arch/sparc/kernel/sys_sparc_32.c
+++ b/arch/sparc/kernel/sys_sparc_32.c
@@ -41,7 +41,7 @@ SYSCALL_DEFINE0(getpagesize)
 
 unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr, unsigned long len, unsigned long pgoff, unsigned long flags)
 {
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {};
 
 	if (flags & MAP_FIXED) {
 		/* We do not accept a shared mapping if it would violate
@@ -59,7 +59,6 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr, unsi
 	if (!addr)
 		addr = TASK_UNMAPPED_BASE;
 
-	info.flags = 0;
 	info.length = len;
 	info.low_limit = addr;
 	info.high_limit = TASK_SIZE;
diff --git a/arch/sparc/kernel/sys_sparc_64.c b/arch/sparc/kernel/sys_sparc_64.c
index 1dbf7211666e..d9c3b34ca744 100644
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
@@ -126,7 +126,6 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr, unsi
 			return addr;
 	}
 
-	info.flags = 0;
 	info.length = len;
 	info.low_limit = TASK_UNMAPPED_BASE;
 	info.high_limit = min(task_size, VA_EXCLUDE_START);
@@ -154,7 +153,7 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	unsigned long task_size = STACK_TOP32;
 	unsigned long addr = addr0;
 	int do_color_align;
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {};
 
 	/* This should only ever run for 32-bit processes.  */
 	BUG_ON(!test_thread_flag(TIF_32BIT));
diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
index 38a1bef47efb..4caf56b32e26 100644
--- a/arch/sparc/mm/hugetlbpage.c
+++ b/arch/sparc/mm/hugetlbpage.c
@@ -31,17 +31,15 @@ static unsigned long hugetlb_get_unmapped_area_bottomup(struct file *filp,
 {
 	struct hstate *h = hstate_file(filp);
 	unsigned long task_size = TASK_SIZE;
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {};
 
 	if (test_thread_flag(TIF_32BIT))
 		task_size = STACK_TOP32;
 
-	info.flags = 0;
 	info.length = len;
 	info.low_limit = TASK_UNMAPPED_BASE;
 	info.high_limit = min(task_size, VA_EXCLUDE_START);
 	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
-	info.align_offset = 0;
 	addr = vm_unmapped_area(&info);
 
 	if ((addr & ~PAGE_MASK) && task_size > VA_EXCLUDE_END) {
@@ -63,7 +61,7 @@ hugetlb_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	struct hstate *h = hstate_file(filp);
 	struct mm_struct *mm = current->mm;
 	unsigned long addr = addr0;
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {};
 
 	/* This should only ever run for 32-bit processes.  */
 	BUG_ON(!test_thread_flag(TIF_32BIT));
@@ -73,7 +71,6 @@ hugetlb_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	info.low_limit = PAGE_SIZE;
 	info.high_limit = mm->mmap_base;
 	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
-	info.align_offset = 0;
 	addr = vm_unmapped_area(&info);
 
 	/*
diff --git a/arch/x86/kernel/sys_x86_64.c b/arch/x86/kernel/sys_x86_64.c
index c783aeb37dce..b3278e4f7e59 100644
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
@@ -144,11 +144,9 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 			return addr;
 	}
 
-	info.flags = 0;
 	info.length = len;
 	info.low_limit = begin;
 	info.high_limit = end;
-	info.align_mask = 0;
 	info.align_offset = pgoff << PAGE_SHIFT;
 	if (filp) {
 		info.align_mask = get_align_mask();
@@ -165,7 +163,7 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	struct vm_area_struct *vma;
 	struct mm_struct *mm = current->mm;
 	unsigned long addr = addr0;
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {};
 
 	/* requested length too big for entire address space */
 	if (len > TASK_SIZE)
@@ -210,7 +208,6 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	if (addr > DEFAULT_MAP_WINDOW && !in_32bit_syscall())
 		info.high_limit += TASK_SIZE_MAX - DEFAULT_MAP_WINDOW;
 
-	info.align_mask = 0;
 	info.align_offset = pgoff << PAGE_SHIFT;
 	if (filp) {
 		info.align_mask = get_align_mask();
diff --git a/arch/x86/mm/hugetlbpage.c b/arch/x86/mm/hugetlbpage.c
index 6d77c0039617..fb600949a355 100644
--- a/arch/x86/mm/hugetlbpage.c
+++ b/arch/x86/mm/hugetlbpage.c
@@ -51,9 +51,8 @@ static unsigned long hugetlb_get_unmapped_area_bottomup(struct file *file,
 		unsigned long pgoff, unsigned long flags)
 {
 	struct hstate *h = hstate_file(file);
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {};
 
-	info.flags = 0;
 	info.length = len;
 	info.low_limit = get_mmap_base(1);
 
@@ -65,7 +64,6 @@ static unsigned long hugetlb_get_unmapped_area_bottomup(struct file *file,
 		task_size_32bit() : task_size_64bit(addr > DEFAULT_MAP_WINDOW);
 
 	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
-	info.align_offset = 0;
 	return vm_unmapped_area(&info);
 }
 
@@ -74,7 +72,7 @@ static unsigned long hugetlb_get_unmapped_area_topdown(struct file *file,
 		unsigned long pgoff, unsigned long flags)
 {
 	struct hstate *h = hstate_file(file);
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {};
 
 	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
 	info.length = len;
@@ -89,7 +87,6 @@ static unsigned long hugetlb_get_unmapped_area_topdown(struct file *file,
 		info.high_limit += TASK_SIZE_MAX - DEFAULT_MAP_WINDOW;
 
 	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
-	info.align_offset = 0;
 	addr = vm_unmapped_area(&info);
 
 	/*
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index cd87ea5944a1..ae833080a146 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -176,14 +176,12 @@ hugetlb_get_unmapped_area_bottomup(struct file *file, unsigned long addr,
 		unsigned long len, unsigned long pgoff, unsigned long flags)
 {
 	struct hstate *h = hstate_file(file);
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {};
 
-	info.flags = 0;
 	info.length = len;
 	info.low_limit = current->mm->mmap_base;
 	info.high_limit = arch_get_mmap_end(addr, len, flags);
 	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
-	info.align_offset = 0;
 	return vm_unmapped_area(&info);
 }
 
@@ -192,14 +190,13 @@ hugetlb_get_unmapped_area_topdown(struct file *file, unsigned long addr,
 		unsigned long len, unsigned long pgoff, unsigned long flags)
 {
 	struct hstate *h = hstate_file(file);
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {};
 
 	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
 	info.length = len;
 	info.low_limit = PAGE_SIZE;
 	info.high_limit = arch_get_mmap_base(addr, current->mm->mmap_base);
 	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
-	info.align_offset = 0;
 	addr = vm_unmapped_area(&info);
 
 	/*
diff --git a/mm/mmap.c b/mm/mmap.c
index 68381b90f906..b889c79d11bd 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1707,7 +1707,7 @@ generic_get_unmapped_area(struct file *filp, unsigned long addr,
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma, *prev;
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {};
 	const unsigned long mmap_end = arch_get_mmap_end(addr, len, flags);
 
 	if (len > mmap_end - mmap_min_addr)
@@ -1725,12 +1725,9 @@ generic_get_unmapped_area(struct file *filp, unsigned long addr,
 			return addr;
 	}
 
-	info.flags = 0;
 	info.length = len;
 	info.low_limit = mm->mmap_base;
 	info.high_limit = mmap_end;
-	info.align_mask = 0;
-	info.align_offset = 0;
 	return vm_unmapped_area(&info);
 }
 
@@ -1755,7 +1752,7 @@ generic_get_unmapped_area_topdown(struct file *filp, unsigned long addr,
 {
 	struct vm_area_struct *vma, *prev;
 	struct mm_struct *mm = current->mm;
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {};
 	const unsigned long mmap_end = arch_get_mmap_end(addr, len, flags);
 
 	/* requested length too big for entire address space */
@@ -1779,8 +1776,6 @@ generic_get_unmapped_area_topdown(struct file *filp, unsigned long addr,
 	info.length = len;
 	info.low_limit = PAGE_SIZE;
 	info.high_limit = arch_get_mmap_base(addr, mm->mmap_base);
-	info.align_mask = 0;
-	info.align_offset = 0;
 	addr = vm_unmapped_area(&info);
 
 	/*
-- 
2.34.1


