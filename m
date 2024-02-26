Return-Path: <linux-kernel+bounces-82204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEC38680D7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 580E8B2C159
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E78131E2C;
	Mon, 26 Feb 2024 19:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hr8A/QW6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE2912FB3E
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 19:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708974600; cv=none; b=bqyjr5HpBltpIoTXmEhxLhxzSGlHkbOUMuiVKnb/Y2BgLBPmsyvVING+kfXHsKWxfUtfdCGS6z392R13g232Ip5WjBDEtexEdb3PIf8fesKzYoWTBqLbU2JWhwqhH9VmV2/WhcWHggGDwVQDAwVy+AxRlXUWvZnUhsEQYMZckVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708974600; c=relaxed/simple;
	bh=g4JChMg3I76Dgv8nBf8Y40nYEQC6u5audbIsXOb5O2c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OienkmOUkZsYvl9n5Blm7Lu/B+Gnfvx5tTxokZLD964lSVL6bmQX7adpGyaKdU8jzmF7aTWlL3wtzlKOBXw0FUKr4GxP1LK+wsSWwN7kD0ZYkR121xJuV+m3URAzm1mCzhIkTiUKBBtbV3VnJ02N6w97SGFYrJlm3PzA39tFNag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hr8A/QW6; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708974599; x=1740510599;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g4JChMg3I76Dgv8nBf8Y40nYEQC6u5audbIsXOb5O2c=;
  b=hr8A/QW6sahH/WkOLVvk9UD7bEakOspbTcARDTepUozhnyJdgzxAvC+y
   Ypw/iaWxSvdwarTrgnU2ukyOdw5Xv1M3tWgie9oDEdPExO6dfY8SbNeeD
   9vcd5KAQ5Tw+/xhvwKfbyVXpJ38cpHej2BWpk32cS7ziNjR1yopnWgYaX
   B2Zla/RWXRc3YAvCV/uoBVei+QSKcioRr6MFV0wVQ1A73KysWOLta5Hmg
   AiiP797xC+8o9AhnLoNpwWBRDUyxJAN06luhLqPdr0RCzaBnLFSJs4JCM
   sbnb4l1ZQ2hIO3O6VBwvKZY6TZSYrMY8bpNvxb3gLjVqSKtMsaZnrs6fj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="14721326"
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="14721326"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 11:09:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="6911442"
Received: from bdmirand-mobl.amr.corp.intel.com (HELO rpedgeco-desk4.intel.com) ([10.251.3.213])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 11:09:57 -0800
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
Subject: [PATCH v2 1/9] mm: Switch mm->get_unmapped_area() to a flag
Date: Mon, 26 Feb 2024 11:09:43 -0800
Message-Id: <20240226190951.3240433-2-rick.p.edgecombe@intel.com>
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

The mm_struct contains a function pointer *get_unmapped_area(), which
is set to either arch_get_unmapped_area() or
arch_get_unmapped_area_topdown() during the initialization of the mm.

Since the function pointer only ever points to two functions that are named
the same across all arch's, a function pointer is not really required. In
addition future changes will want to add versions of the functions that
take additional arguments. So to save a pointers worth of bytes in
mm_struct, and prevent adding additional function pointers to mm_struct in
future changes, remove it and keep the information about which
get_unmapped_area() to use in a flag.

Add the new flag to MMF_INIT_MASK so it doesn't get clobbered on fork by
mmf_init_flags(). Most MM flags get clobbered on fork. In the pre-existing
behavior mm->get_unmapped_area() would get copied to the new mm in dup_mm(),
so not clobbering the flag preserves the existing behavior around
inherriting the topdown-ness.

Introduce a helper, mm_get_unmapped_area(), to easily convert code that
refers to the old function pointer to instead select and call either
arch_get_unmapped_area() or arch_get_unmapped_area_topdown() based on the
flag. Then drop the mm->get_unmapped_area() function pointer. Leave the
get_unmapped_area() pointer in struct file_operations alone. The main
purpose of this change is to reorganize in preparation for future changes,
but it also converts the calls of mm->get_unmapped_area() from indirect
branches into a direct ones.

The stress-ng bigheap benchmark calls realloc a lot, which calls through
get_unmapped_area() in the kernel. On x86, the change yielded a ~1%
improvement there on a retpoline config.

In testing a few x86 configs, removing the pointer unfortunately didn't
result in any actual size reductions in the compiled layout of mm_struct.
But depending on compiler or arch alignment requirements, the change could
shrink the size of mm_struct.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
v2:
 - Fix comment on MMF_TOPDOWN (Kirill, rppt)
 - Move MMF_TOPDOWN to actually unused bit
 - Add MMF_TOPDOWN to MMF_INIT_MASK so it doesn't get clobbered on fork,
   and result in the children using the search up path.
 - New lower performance results after above bug fix
 - Add Reviews and Acks
---
 arch/s390/mm/hugetlbpage.c       |  2 +-
 arch/s390/mm/mmap.c              |  4 ++--
 arch/sparc/kernel/sys_sparc_64.c | 15 ++++++---------
 arch/sparc/mm/hugetlbpage.c      |  2 +-
 arch/x86/kernel/cpu/sgx/driver.c |  2 +-
 arch/x86/mm/hugetlbpage.c        |  2 +-
 arch/x86/mm/mmap.c               |  4 ++--
 drivers/char/mem.c               |  2 +-
 drivers/dax/device.c             |  6 +++---
 fs/hugetlbfs/inode.c             |  2 +-
 fs/proc/inode.c                  | 15 ++++++++-------
 fs/ramfs/file-mmu.c              |  2 +-
 include/linux/mm_types.h         |  6 +-----
 include/linux/sched/coredump.h   |  5 ++++-
 include/linux/sched/mm.h         |  5 +++++
 io_uring/io_uring.c              |  2 +-
 mm/debug.c                       |  6 ------
 mm/huge_memory.c                 |  6 +++---
 mm/mmap.c                        | 21 ++++++++++++++++++---
 mm/shmem.c                       | 11 +++++------
 mm/util.c                        |  6 +++---
 21 files changed, 68 insertions(+), 58 deletions(-)

diff --git a/arch/s390/mm/hugetlbpage.c b/arch/s390/mm/hugetlbpage.c
index 297a6d897d5a..c2d2850ec8d5 100644
--- a/arch/s390/mm/hugetlbpage.c
+++ b/arch/s390/mm/hugetlbpage.c
@@ -328,7 +328,7 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 			goto check_asce_limit;
 	}
 
-	if (mm->get_unmapped_area == arch_get_unmapped_area)
+	if (!test_bit(MMF_TOPDOWN, &mm->flags))
 		addr = hugetlb_get_unmapped_area_bottomup(file, addr, len,
 				pgoff, flags);
 	else
diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
index fc9a7dc26c5e..cd52d72b59cf 100644
--- a/arch/s390/mm/mmap.c
+++ b/arch/s390/mm/mmap.c
@@ -182,10 +182,10 @@ void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
 	 */
 	if (mmap_is_legacy(rlim_stack)) {
 		mm->mmap_base = mmap_base_legacy(random_factor);
-		mm->get_unmapped_area = arch_get_unmapped_area;
+		clear_bit(MMF_TOPDOWN, &mm->flags);
 	} else {
 		mm->mmap_base = mmap_base(random_factor, rlim_stack);
-		mm->get_unmapped_area = arch_get_unmapped_area_topdown;
+		set_bit(MMF_TOPDOWN, &mm->flags);
 	}
 }
 
diff --git a/arch/sparc/kernel/sys_sparc_64.c b/arch/sparc/kernel/sys_sparc_64.c
index 1e9a9e016237..1dbf7211666e 100644
--- a/arch/sparc/kernel/sys_sparc_64.c
+++ b/arch/sparc/kernel/sys_sparc_64.c
@@ -218,14 +218,10 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 unsigned long get_fb_unmapped_area(struct file *filp, unsigned long orig_addr, unsigned long len, unsigned long pgoff, unsigned long flags)
 {
 	unsigned long align_goal, addr = -ENOMEM;
-	unsigned long (*get_area)(struct file *, unsigned long,
-				  unsigned long, unsigned long, unsigned long);
-
-	get_area = current->mm->get_unmapped_area;
 
 	if (flags & MAP_FIXED) {
 		/* Ok, don't mess with it. */
-		return get_area(NULL, orig_addr, len, pgoff, flags);
+		return mm_get_unmapped_area(current->mm, NULL, orig_addr, len, pgoff, flags);
 	}
 	flags &= ~MAP_SHARED;
 
@@ -238,7 +234,8 @@ unsigned long get_fb_unmapped_area(struct file *filp, unsigned long orig_addr, u
 		align_goal = (64UL * 1024);
 
 	do {
-		addr = get_area(NULL, orig_addr, len + (align_goal - PAGE_SIZE), pgoff, flags);
+		addr = mm_get_unmapped_area(current->mm, NULL, orig_addr,
+					    len + (align_goal - PAGE_SIZE), pgoff, flags);
 		if (!(addr & ~PAGE_MASK)) {
 			addr = (addr + (align_goal - 1UL)) & ~(align_goal - 1UL);
 			break;
@@ -256,7 +253,7 @@ unsigned long get_fb_unmapped_area(struct file *filp, unsigned long orig_addr, u
 	 * be obtained.
 	 */
 	if (addr & ~PAGE_MASK)
-		addr = get_area(NULL, orig_addr, len, pgoff, flags);
+		addr = mm_get_unmapped_area(current->mm, NULL, orig_addr, len, pgoff, flags);
 
 	return addr;
 }
@@ -292,7 +289,7 @@ void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
 	    gap == RLIM_INFINITY ||
 	    sysctl_legacy_va_layout) {
 		mm->mmap_base = TASK_UNMAPPED_BASE + random_factor;
-		mm->get_unmapped_area = arch_get_unmapped_area;
+		clear_bit(MMF_TOPDOWN, &mm->flags);
 	} else {
 		/* We know it's 32-bit */
 		unsigned long task_size = STACK_TOP32;
@@ -303,7 +300,7 @@ void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
 			gap = (task_size / 6 * 5);
 
 		mm->mmap_base = PAGE_ALIGN(task_size - gap - random_factor);
-		mm->get_unmapped_area = arch_get_unmapped_area_topdown;
+		set_bit(MMF_TOPDOWN, &mm->flags);
 	}
 }
 
diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
index b432500c13a5..38a1bef47efb 100644
--- a/arch/sparc/mm/hugetlbpage.c
+++ b/arch/sparc/mm/hugetlbpage.c
@@ -123,7 +123,7 @@ hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 		    (!vma || addr + len <= vm_start_gap(vma)))
 			return addr;
 	}
-	if (mm->get_unmapped_area == arch_get_unmapped_area)
+	if (!test_bit(MMF_TOPDOWN, &mm->flags))
 		return hugetlb_get_unmapped_area_bottomup(file, addr, len,
 				pgoff, flags);
 	else
diff --git a/arch/x86/kernel/cpu/sgx/driver.c b/arch/x86/kernel/cpu/sgx/driver.c
index 262f5fb18d74..22b65a5f5ec6 100644
--- a/arch/x86/kernel/cpu/sgx/driver.c
+++ b/arch/x86/kernel/cpu/sgx/driver.c
@@ -113,7 +113,7 @@ static unsigned long sgx_get_unmapped_area(struct file *file,
 	if (flags & MAP_FIXED)
 		return addr;
 
-	return current->mm->get_unmapped_area(file, addr, len, pgoff, flags);
+	return mm_get_unmapped_area(current->mm, file, addr, len, pgoff, flags);
 }
 
 #ifdef CONFIG_COMPAT
diff --git a/arch/x86/mm/hugetlbpage.c b/arch/x86/mm/hugetlbpage.c
index 5804bbae4f01..6d77c0039617 100644
--- a/arch/x86/mm/hugetlbpage.c
+++ b/arch/x86/mm/hugetlbpage.c
@@ -141,7 +141,7 @@ hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 	}
 
 get_unmapped_area:
-	if (mm->get_unmapped_area == arch_get_unmapped_area)
+	if (!test_bit(MMF_TOPDOWN, &mm->flags))
 		return hugetlb_get_unmapped_area_bottomup(file, addr, len,
 				pgoff, flags);
 	else
diff --git a/arch/x86/mm/mmap.c b/arch/x86/mm/mmap.c
index c90c20904a60..a2cabb1c81e1 100644
--- a/arch/x86/mm/mmap.c
+++ b/arch/x86/mm/mmap.c
@@ -129,9 +129,9 @@ static void arch_pick_mmap_base(unsigned long *base, unsigned long *legacy_base,
 void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
 {
 	if (mmap_is_legacy())
-		mm->get_unmapped_area = arch_get_unmapped_area;
+		clear_bit(MMF_TOPDOWN, &mm->flags);
 	else
-		mm->get_unmapped_area = arch_get_unmapped_area_topdown;
+		set_bit(MMF_TOPDOWN, &mm->flags);
 
 	arch_pick_mmap_base(&mm->mmap_base, &mm->mmap_legacy_base,
 			arch_rnd(mmap64_rnd_bits), task_size_64bit(0),
diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 3c6670cf905f..9b80e622ae80 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -544,7 +544,7 @@ static unsigned long get_unmapped_area_zero(struct file *file,
 	}
 
 	/* Otherwise flags & MAP_PRIVATE: with no shmem object beneath it */
-	return current->mm->get_unmapped_area(file, addr, len, pgoff, flags);
+	return mm_get_unmapped_area(current->mm, file, addr, len, pgoff, flags);
 #else
 	return -ENOSYS;
 #endif
diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 93ebedc5ec8c..47c126d37b59 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -329,14 +329,14 @@ static unsigned long dax_get_unmapped_area(struct file *filp,
 	if ((off + len_align) < off)
 		goto out;
 
-	addr_align = current->mm->get_unmapped_area(filp, addr, len_align,
-			pgoff, flags);
+	addr_align = mm_get_unmapped_area(current->mm, filp, addr, len_align,
+					  pgoff, flags);
 	if (!IS_ERR_VALUE(addr_align)) {
 		addr_align += (off - addr_align) & (align - 1);
 		return addr_align;
 	}
  out:
-	return current->mm->get_unmapped_area(filp, addr, len, pgoff, flags);
+	return mm_get_unmapped_area(current->mm, filp, addr, len, pgoff, flags);
 }
 
 static const struct address_space_operations dev_dax_aops = {
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index f757d4f7ad98..a63d2eee086f 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -242,7 +242,7 @@ generic_hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
 	 * If architectures have special needs, they should define their own
 	 * version of hugetlb_get_unmapped_area.
 	 */
-	if (mm->get_unmapped_area == arch_get_unmapped_area_topdown)
+	if (test_bit(MMF_TOPDOWN, &mm->flags))
 		return hugetlb_get_unmapped_area_topdown(file, addr, len,
 				pgoff, flags);
 	return hugetlb_get_unmapped_area_bottomup(file, addr, len,
diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index b33e490e3fd9..6f4c2e21e68f 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -454,15 +454,16 @@ pde_get_unmapped_area(struct proc_dir_entry *pde, struct file *file, unsigned lo
 			   unsigned long len, unsigned long pgoff,
 			   unsigned long flags)
 {
-	typeof_member(struct proc_ops, proc_get_unmapped_area) get_area;
-
-	get_area = pde->proc_ops->proc_get_unmapped_area;
+	if (pde->proc_ops->proc_get_unmapped_area)
+		return pde->proc_ops->proc_get_unmapped_area(file, orig_addr,
+							     len, pgoff,
+							     flags);
 #ifdef CONFIG_MMU
-	if (!get_area)
-		get_area = current->mm->get_unmapped_area;
+	else
+		return mm_get_unmapped_area(current->mm, file, orig_addr,
+					    len, pgoff, flags);
 #endif
-	if (get_area)
-		return get_area(file, orig_addr, len, pgoff, flags);
+
 	return orig_addr;
 }
 
diff --git a/fs/ramfs/file-mmu.c b/fs/ramfs/file-mmu.c
index c7a1aa3c882b..b45c7edc3225 100644
--- a/fs/ramfs/file-mmu.c
+++ b/fs/ramfs/file-mmu.c
@@ -35,7 +35,7 @@ static unsigned long ramfs_mmu_get_unmapped_area(struct file *file,
 		unsigned long addr, unsigned long len, unsigned long pgoff,
 		unsigned long flags)
 {
-	return current->mm->get_unmapped_area(file, addr, len, pgoff, flags);
+	return mm_get_unmapped_area(current->mm, file, addr, len, pgoff, flags);
 }
 
 const struct file_operations ramfs_file_operations = {
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 957ce38768b2..f01c01b4a4fc 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -745,11 +745,7 @@ struct mm_struct {
 		} ____cacheline_aligned_in_smp;
 
 		struct maple_tree mm_mt;
-#ifdef CONFIG_MMU
-		unsigned long (*get_unmapped_area) (struct file *filp,
-				unsigned long addr, unsigned long len,
-				unsigned long pgoff, unsigned long flags);
-#endif
+
 		unsigned long mmap_base;	/* base of mmap area */
 		unsigned long mmap_legacy_base;	/* base of mmap area in bottom-up allocations */
 #ifdef CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES
diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
index 02f5090ffea2..e62ff805cfc9 100644
--- a/include/linux/sched/coredump.h
+++ b/include/linux/sched/coredump.h
@@ -92,9 +92,12 @@ static inline int get_dumpable(struct mm_struct *mm)
 #define MMF_VM_MERGE_ANY	30
 #define MMF_VM_MERGE_ANY_MASK	(1 << MMF_VM_MERGE_ANY)
 
+#define MMF_TOPDOWN		31	/* mm searches top down by default */
+#define MMF_TOPDOWN_MASK	(1 << MMF_TOPDOWN)
+
 #define MMF_INIT_MASK		(MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK |\
 				 MMF_DISABLE_THP_MASK | MMF_HAS_MDWE_MASK |\
-				 MMF_VM_MERGE_ANY_MASK)
+				 MMF_VM_MERGE_ANY_MASK | MMF_TOPDOWN_MASK)
 
 static inline unsigned long mmf_init_flags(unsigned long flags)
 {
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 9a19f1b42f64..cde946e926d8 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -8,6 +8,7 @@
 #include <linux/mm_types.h>
 #include <linux/gfp.h>
 #include <linux/sync_core.h>
+#include <linux/sched/coredump.h>
 
 /*
  * Routines for handling mm_structs
@@ -186,6 +187,10 @@ arch_get_unmapped_area_topdown(struct file *filp, unsigned long addr,
 			  unsigned long len, unsigned long pgoff,
 			  unsigned long flags);
 
+unsigned long mm_get_unmapped_area(struct mm_struct *mm, struct file *filp,
+				   unsigned long addr, unsigned long len,
+				   unsigned long pgoff, unsigned long flags);
+
 unsigned long
 generic_get_unmapped_area(struct file *filp, unsigned long addr,
 			  unsigned long len, unsigned long pgoff,
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 9626a363f121..b3c4ec115989 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -3569,7 +3569,7 @@ static unsigned long io_uring_mmu_get_unmapped_area(struct file *filp,
 #else
 	addr = 0UL;
 #endif
-	return current->mm->get_unmapped_area(filp, addr, len, pgoff, flags);
+	return mm_get_unmapped_area(current->mm, filp, addr, len, pgoff, flags);
 }
 
 #else /* !CONFIG_MMU */
diff --git a/mm/debug.c b/mm/debug.c
index ee533a5ceb79..32db5de8e1e7 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -162,9 +162,6 @@ EXPORT_SYMBOL(dump_vma);
 void dump_mm(const struct mm_struct *mm)
 {
 	pr_emerg("mm %px task_size %lu\n"
-#ifdef CONFIG_MMU
-		"get_unmapped_area %px\n"
-#endif
 		"mmap_base %lu mmap_legacy_base %lu\n"
 		"pgd %px mm_users %d mm_count %d pgtables_bytes %lu map_count %d\n"
 		"hiwater_rss %lx hiwater_vm %lx total_vm %lx locked_vm %lx\n"
@@ -190,9 +187,6 @@ void dump_mm(const struct mm_struct *mm)
 		"def_flags: %#lx(%pGv)\n",
 
 		mm, mm->task_size,
-#ifdef CONFIG_MMU
-		mm->get_unmapped_area,
-#endif
 		mm->mmap_base, mm->mmap_legacy_base,
 		mm->pgd, atomic_read(&mm->mm_users),
 		atomic_read(&mm->mm_count),
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 86ee29b5c39c..e9ef43a719a5 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -641,8 +641,8 @@ static unsigned long __thp_get_unmapped_area(struct file *filp,
 	if (len_pad < len || (off + len_pad) < off)
 		return 0;
 
-	ret = current->mm->get_unmapped_area(filp, addr, len_pad,
-					      off >> PAGE_SHIFT, flags);
+	ret = mm_get_unmapped_area(current->mm, filp, addr, len_pad,
+				   off >> PAGE_SHIFT, flags);
 
 	/*
 	 * The failure might be due to length padding. The caller will retry
@@ -672,7 +672,7 @@ unsigned long thp_get_unmapped_area(struct file *filp, unsigned long addr,
 	if (ret)
 		return ret;
 
-	return current->mm->get_unmapped_area(filp, addr, len, pgoff, flags);
+	return mm_get_unmapped_area(current->mm, filp, addr, len, pgoff, flags);
 }
 EXPORT_SYMBOL_GPL(thp_get_unmapped_area);
 
diff --git a/mm/mmap.c b/mm/mmap.c
index aa82eec17489..b61bc515c729 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1807,7 +1807,8 @@ get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
 		unsigned long pgoff, unsigned long flags)
 {
 	unsigned long (*get_area)(struct file *, unsigned long,
-				  unsigned long, unsigned long, unsigned long);
+				  unsigned long, unsigned long, unsigned long)
+				  = NULL;
 
 	unsigned long error = arch_mmap_check(addr, len, flags);
 	if (error)
@@ -1817,7 +1818,6 @@ get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
 	if (len > TASK_SIZE)
 		return -ENOMEM;
 
-	get_area = current->mm->get_unmapped_area;
 	if (file) {
 		if (file->f_op->get_unmapped_area)
 			get_area = file->f_op->get_unmapped_area;
@@ -1834,7 +1834,11 @@ get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
 		get_area = thp_get_unmapped_area;
 	}
 
-	addr = get_area(file, addr, len, pgoff, flags);
+	if (get_area)
+		addr = get_area(file, addr, len, pgoff, flags);
+	else
+		addr = mm_get_unmapped_area(current->mm, file, addr, len,
+					    pgoff, flags);
 	if (IS_ERR_VALUE(addr))
 		return addr;
 
@@ -1849,6 +1853,17 @@ get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
 
 EXPORT_SYMBOL(get_unmapped_area);
 
+unsigned long
+mm_get_unmapped_area(struct mm_struct *mm, struct file *file,
+		     unsigned long addr, unsigned long len,
+		     unsigned long pgoff, unsigned long flags)
+{
+	if (test_bit(MMF_TOPDOWN, &mm->flags))
+		return arch_get_unmapped_area_topdown(file, addr, len, pgoff, flags);
+	return arch_get_unmapped_area(file, addr, len, pgoff, flags);
+}
+EXPORT_SYMBOL(mm_get_unmapped_area);
+
 /**
  * find_vma_intersection() - Look up the first VMA which intersects the interval
  * @mm: The process address space.
diff --git a/mm/shmem.c b/mm/shmem.c
index 0d1ce70bce38..a8cac92dff88 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2242,8 +2242,6 @@ unsigned long shmem_get_unmapped_area(struct file *file,
 				      unsigned long uaddr, unsigned long len,
 				      unsigned long pgoff, unsigned long flags)
 {
-	unsigned long (*get_area)(struct file *,
-		unsigned long, unsigned long, unsigned long, unsigned long);
 	unsigned long addr;
 	unsigned long offset;
 	unsigned long inflated_len;
@@ -2253,8 +2251,8 @@ unsigned long shmem_get_unmapped_area(struct file *file,
 	if (len > TASK_SIZE)
 		return -ENOMEM;
 
-	get_area = current->mm->get_unmapped_area;
-	addr = get_area(file, uaddr, len, pgoff, flags);
+	addr = mm_get_unmapped_area(current->mm, file, uaddr, len, pgoff,
+				    flags);
 
 	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
 		return addr;
@@ -2311,7 +2309,8 @@ unsigned long shmem_get_unmapped_area(struct file *file,
 	if (inflated_len < len)
 		return addr;
 
-	inflated_addr = get_area(NULL, uaddr, inflated_len, 0, flags);
+	inflated_addr = mm_get_unmapped_area(current->mm, NULL, uaddr,
+					     inflated_len, 0, flags);
 	if (IS_ERR_VALUE(inflated_addr))
 		return addr;
 	if (inflated_addr & ~PAGE_MASK)
@@ -4757,7 +4756,7 @@ unsigned long shmem_get_unmapped_area(struct file *file,
 				      unsigned long addr, unsigned long len,
 				      unsigned long pgoff, unsigned long flags)
 {
-	return current->mm->get_unmapped_area(file, addr, len, pgoff, flags);
+	return mm_get_unmapped_area(current->mm, file, addr, len, pgoff, flags);
 }
 #endif
 
diff --git a/mm/util.c b/mm/util.c
index 744b4d7e3fae..10c836a75e66 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -452,17 +452,17 @@ void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
 
 	if (mmap_is_legacy(rlim_stack)) {
 		mm->mmap_base = TASK_UNMAPPED_BASE + random_factor;
-		mm->get_unmapped_area = arch_get_unmapped_area;
+		clear_bit(MMF_TOPDOWN, &mm->flags);
 	} else {
 		mm->mmap_base = mmap_base(random_factor, rlim_stack);
-		mm->get_unmapped_area = arch_get_unmapped_area_topdown;
+		set_bit(MMF_TOPDOWN, &mm->flags);
 	}
 }
 #elif defined(CONFIG_MMU) && !defined(HAVE_ARCH_PICK_MMAP_LAYOUT)
 void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
 {
 	mm->mmap_base = TASK_UNMAPPED_BASE;
-	mm->get_unmapped_area = arch_get_unmapped_area;
+	clear_bit(MMF_TOPDOWN, &mm->flags);
 }
 #endif
 
-- 
2.34.1


