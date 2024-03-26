Return-Path: <linux-kernel+bounces-118290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 285DD88B753
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 03:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A06461F3F761
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A909812AAC6;
	Tue, 26 Mar 2024 02:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jcc2cLXh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E022953387;
	Tue, 26 Mar 2024 02:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711419446; cv=none; b=sMD14zvNgc2DRH5jQRo5PwqBCBc+E4SF3lP+aQlCgaPHU0eMMyiwYjGjFP5GFbCGFb13rFPuQMfpLk3IS0649HUXcHvlV8IdZEaioTpU288EofFOzQsCE7ffcoRi6CDQVvhVPZRtNp7SpCh4N/4PjEFHtfM+APQ1oXqUqbL4RnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711419446; c=relaxed/simple;
	bh=0XSWLwa7U1N+f/kgoHZwIHzVuDJ8CpV4eXuAoBVCNvI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hlcygfWLQ5Y4GXU97iBQMquJUhzzmAkSnzZ7D6wUivsGO0zDSw24FsuBg5sjxfmk/3ICRdKsBGCnlPFSvh30RzZCUmx1RLeUgCfc6F8InXhjm10e2Oj5VkQ5a3GXGFQQ9bfpS9opaQypZabRU5ycDsDx8/wkPkA29BuQA11DPwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jcc2cLXh; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711419443; x=1742955443;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0XSWLwa7U1N+f/kgoHZwIHzVuDJ8CpV4eXuAoBVCNvI=;
  b=jcc2cLXhTzNAH9zl7PZHN0sPn9QAopzFTsVDRPEy2xGPXNnQQ+PrqZO6
   BZpiXR+FxHr3Y9zla1GeKWZxnf1DGhtKbBDoWhd0MxnSxo2pOScPwras4
   xeHrrPQLQY/BIQoohxW8G5FW9y1JXe1f0OV1zR2tHGjfhBMSi84u+Qzuj
   uTJC4y24OqC4jQQycu0ybalOZe6ve1q9svylFpoLG6XC8yKsHt21qZke+
   m1Hxm4DfWJ8nfCaw0YuvPC5ovBiGE+gqEGbtzQoHTUmaZIV8sRFmHhCp7
   B5SRAs4wKZnMJ9vBXa4CqNLjH7It1NoK7TR8XTV+y1Ft/McXgH/HLxYzq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6564336"
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="6564336"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 19:17:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="20489906"
Received: from rpwilson-mobl.amr.corp.intel.com (HELO rpedgeco-desk4.intel.com) ([10.251.11.187])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 19:17:17 -0700
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
	linux-mm@kvack.org,
	linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org
Subject: [PATCH v4 10/14] treewide: Use initializer for struct vm_unmapped_area_info
Date: Mon, 25 Mar 2024 19:16:52 -0700
Message-Id: <20240326021656.202649-11-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240326021656.202649-1-rick.p.edgecombe@intel.com>
References: <20240326021656.202649-1-rick.p.edgecombe@intel.com>
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
Reviewed-by: Kees Cook <keescook@chromium.org>
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
v4:
 - Trivial rebase conflict in s390

Hi archs,

For some context, this is part of a larger series to improve shadow stack
guard gaps. It involves plumbing a new field via
struct vm_unmapped_area_info. The first user is x86, but arm and riscv may
likely use it as well. The change is compile tested only for non-x86.

Thanks,

Rick
---
 arch/alpha/kernel/osf_sys.c      | 5 +----
 arch/arc/mm/mmap.c               | 4 +---
 arch/arm/mm/mmap.c               | 5 ++---
 arch/loongarch/mm/mmap.c         | 3 +--
 arch/mips/mm/mmap.c              | 3 +--
 arch/s390/mm/hugetlbpage.c       | 7 ++-----
 arch/s390/mm/mmap.c              | 5 ++---
 arch/sh/mm/mmap.c                | 5 ++---
 arch/sparc/kernel/sys_sparc_32.c | 3 +--
 arch/sparc/kernel/sys_sparc_64.c | 5 ++---
 arch/sparc/mm/hugetlbpage.c      | 7 ++-----
 arch/x86/kernel/sys_x86_64.c     | 7 ++-----
 arch/x86/mm/hugetlbpage.c        | 7 ++-----
 fs/hugetlbfs/inode.c             | 7 ++-----
 mm/mmap.c                        | 9 ++-------
 15 files changed, 25 insertions(+), 57 deletions(-)

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
index 219d906fe830..46de7a4c0309 100644
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
index 6b2e4436ad4a..206756946589 100644
--- a/arch/s390/mm/mmap.c
+++ b/arch/s390/mm/mmap.c
@@ -86,7 +86,7 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr,
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {};
 
 	if (len > TASK_SIZE - mmap_min_addr)
 		return -ENOMEM;
@@ -102,7 +102,6 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr,
 			goto check_asce_limit;
 	}
 
-	info.flags = 0;
 	info.length = len;
 	info.low_limit = mm->mmap_base;
 	info.high_limit = TASK_SIZE;
@@ -122,7 +121,7 @@ unsigned long arch_get_unmapped_area_topdown(struct file *filp, unsigned long ad
 {
 	struct vm_area_struct *vma;
 	struct mm_struct *mm = current->mm;
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {};
 
 	/* requested length too big for entire address space */
 	if (len > TASK_SIZE - mmap_min_addr)
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
index cb9fa1d5c66f..96b9d29aead0 100644
--- a/arch/x86/kernel/sys_x86_64.c
+++ b/arch/x86/kernel/sys_x86_64.c
@@ -118,7 +118,7 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {};
 	unsigned long begin, end;
 
 	if (flags & MAP_FIXED)
@@ -137,11 +137,9 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
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
@@ -158,7 +156,7 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	struct vm_area_struct *vma;
 	struct mm_struct *mm = current->mm;
 	unsigned long addr = addr0;
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {};
 
 	/* requested length too big for entire address space */
 	if (len > TASK_SIZE)
@@ -203,7 +201,6 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
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
index 3dee18bf47ed..2f4e88552d3f 100644
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
index f734e4fa6d94..609c087bba8e 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1705,7 +1705,7 @@ generic_get_unmapped_area(struct file *filp, unsigned long addr,
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma, *prev;
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {};
 	const unsigned long mmap_end = arch_get_mmap_end(addr, len, flags);
 
 	if (len > mmap_end - mmap_min_addr)
@@ -1723,12 +1723,9 @@ generic_get_unmapped_area(struct file *filp, unsigned long addr,
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
 
@@ -1753,7 +1750,7 @@ generic_get_unmapped_area_topdown(struct file *filp, unsigned long addr,
 {
 	struct vm_area_struct *vma, *prev;
 	struct mm_struct *mm = current->mm;
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {};
 	const unsigned long mmap_end = arch_get_mmap_end(addr, len, flags);
 
 	/* requested length too big for entire address space */
@@ -1777,8 +1774,6 @@ generic_get_unmapped_area_topdown(struct file *filp, unsigned long addr,
 	info.length = len;
 	info.low_limit = PAGE_SIZE;
 	info.high_limit = arch_get_mmap_base(addr, mm->mmap_base);
-	info.align_mask = 0;
-	info.align_offset = 0;
 	addr = vm_unmapped_area(&info);
 
 	/*
-- 
2.34.1


