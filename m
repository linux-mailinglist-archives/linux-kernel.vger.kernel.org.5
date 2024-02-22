Return-Path: <linux-kernel+bounces-77158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E32C8601C5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90B091F28348
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DF86AFA9;
	Thu, 22 Feb 2024 18:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A5zMDDeZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752B75491F
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 18:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708627174; cv=none; b=QxPEs85q9EpBGIaTs/5KlZPvaQq1wBAN32gF4QHKPYLho1lg22GhDofqkpuCrkiRLaJ9bl9cgo6cP08P5EOSH914jIs2mDrFkX1kyFNJDA2LE0k8TGuqQ0N7NLs4NsHH+AcfoqIck1/YcqLBwr/lVUJzNquP2YDzXvLcRYDFq+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708627174; c=relaxed/simple;
	bh=Eq7jdEpOQPVSjCTiWMZuECRIdQ2sytlAHMnF66rSgXg=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=KETBFbQ2p7jMta/YonlGByl610M0IPLTuxPGJgcisFrPLyvKUX+b4JyJ/smvqzOC7+LaSWWh6enljd8X/TkxbNGr/f98rxvdF8/M6kKN1lfMnCQySbQo0Sm8wVDFg47xbe0djBjSD4bw5RTUmo/7Q1n2ZMd7KN26HySlQ5c7kZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A5zMDDeZ; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708627173; x=1740163173;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=Eq7jdEpOQPVSjCTiWMZuECRIdQ2sytlAHMnF66rSgXg=;
  b=A5zMDDeZe0jTgkhBbUKTduHKty3FQiyfrZF4boZxqVn3g1cSkVwZiVE7
   yEyTy3dji8hqujLi9NlAKwNhZ9AbrKnfBsec8R4rYFOHzg/a2qYpLTUji
   AHRoxzNhhN7vsa3qpOnHDvrOGlurOUDqyicIK2awmXqnZILmmruePHe+T
   negVrqAx0hVMhivdTyy8ykiJbL6Jq9AzR9av8sNEqnTMR8c6xVYdI50YR
   F5Uy0d08iCs9gKo4gpDpLB2A8Tl6n6GvXu0SyliKEl8Bm/iWe86RSoK8Y
   zmqpqGsZFlCOQhDPgIwcpEEBgZBrISFxPxWZ5yfzz6GcQdBfgN9FxeD8w
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="3031708"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="3031708"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 10:39:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="5975401"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa008.jf.intel.com with ESMTP; 22 Feb 2024 10:39:32 -0800
Subject: [RFC][PATCH 04/34] x86/mm: Introduce physical address limit helper
To: linux-kernel@vger.kernel.org
Cc: kirill.shutemov@linux.intel.com,pbonzini@redhat.com,tglx@linutronix.de,x86@kernel.org,bp@alien8.de,Dave Hansen <dave.hansen@linux.intel.com>,rafael@kernel.org,lenb@kernel.org
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Thu, 22 Feb 2024 10:39:32 -0800
References: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
In-Reply-To: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
Message-Id: <20240222183932.244390AC@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

Modern processors enumerate the sizes of the physical and virtual address
spaces that they can handle.  The kernel stashes this information for each
CPU in 'cpuinfo_x86'.

Like a lot of system-wide configuration, in practice the kernel only uses
this information from the boot CPU.  That makes a lot of sense because
the kernel can't practically support two CPUs with such different
fundamental support as the size of the address spaces.

Having a per-cpu copy of this data is silly.  It is, at best, a waste
of space to keep it around for the non-boot CPUs.  At worst, it is yet
another bit of data that must be initialized in a particular order and
can be a source of bugs.

Introduce a helper to look up the number of supported physical address bits:

	x86_phys_bits()

Replace most open-coded references to boot_cpu_data.x86_phys_bits.

This form is more compact and also opens up the door to adding some
centralized checking and enforcing rules around this important system-
wide value.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
---

 b/arch/x86/include/asm/kmsan.h       |    2 +-
 b/arch/x86/include/asm/mce.h         |    2 +-
 b/arch/x86/include/asm/processor.h   |    5 +++++
 b/arch/x86/kernel/cpu/mtrr/cleanup.c |    2 +-
 b/arch/x86/kernel/cpu/mtrr/generic.c |    2 +-
 b/arch/x86/kernel/cpu/mtrr/mtrr.c    |    5 ++---
 b/arch/x86/kernel/setup.c            |    2 +-
 b/arch/x86/kvm/cpuid.c               |    2 +-
 b/arch/x86/kvm/mmu.h                 |   10 +++++-----
 b/arch/x86/kvm/mmu/spte.c            |    2 +-
 b/arch/x86/kvm/svm/svm.c             |    2 +-
 b/arch/x86/kvm/vmx/vmx.c             |   10 +++++-----
 b/arch/x86/kvm/vmx/vmx.h             |    2 +-
 b/arch/x86/mm/physaddr.h             |    2 +-
 b/drivers/acpi/acpi_fpdt.c           |    2 +-
 15 files changed, 28 insertions(+), 24 deletions(-)

diff -puN arch/x86/include/asm/kmsan.h~introduce-x86_phys_bits arch/x86/include/asm/kmsan.h
--- a/arch/x86/include/asm/kmsan.h~introduce-x86_phys_bits	2024-02-22 10:08:49.828507052 -0800
+++ b/arch/x86/include/asm/kmsan.h	2024-02-22 10:08:49.852507994 -0800
@@ -52,7 +52,7 @@ static inline void *arch_kmsan_get_meta_
 static inline bool kmsan_phys_addr_valid(unsigned long addr)
 {
 	if (IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT))
-		return !(addr >> boot_cpu_data.x86_phys_bits);
+		return !(addr >> x86_phys_bits());
 	else
 		return true;
 }
diff -puN arch/x86/include/asm/mce.h~introduce-x86_phys_bits arch/x86/include/asm/mce.h
--- a/arch/x86/include/asm/mce.h~introduce-x86_phys_bits	2024-02-22 10:08:49.828507052 -0800
+++ b/arch/x86/include/asm/mce.h	2024-02-22 10:08:49.852507994 -0800
@@ -89,7 +89,7 @@
 #define  MCI_MISC_ADDR_GENERIC	7	/* generic */
 
 /* MCi_ADDR register defines */
-#define MCI_ADDR_PHYSADDR	GENMASK_ULL(boot_cpu_data.x86_phys_bits - 1, 0)
+#define MCI_ADDR_PHYSADDR	GENMASK_ULL(x86_phys_bits() - 1, 0)
 
 /* CTL2 register defines */
 #define MCI_CTL2_CMCI_EN		BIT_ULL(30)
diff -puN arch/x86/include/asm/processor.h~introduce-x86_phys_bits arch/x86/include/asm/processor.h
--- a/arch/x86/include/asm/processor.h~introduce-x86_phys_bits	2024-02-22 10:08:49.828507052 -0800
+++ b/arch/x86/include/asm/processor.h	2024-02-22 10:08:49.852507994 -0800
@@ -767,4 +767,9 @@ static inline void weak_wrmsr_fence(void
 	alternative("mfence; lfence", "", ALT_NOT(X86_FEATURE_APIC_MSRS_FENCE));
 }
 
+static inline u8 x86_phys_bits(void)
+{
+	return boot_cpu_data.x86_phys_bits;
+}
+
 #endif /* _ASM_X86_PROCESSOR_H */
diff -puN arch/x86/kernel/cpu/mtrr/cleanup.c~introduce-x86_phys_bits arch/x86/kernel/cpu/mtrr/cleanup.c
--- a/arch/x86/kernel/cpu/mtrr/cleanup.c~introduce-x86_phys_bits	2024-02-22 10:08:49.832507209 -0800
+++ b/arch/x86/kernel/cpu/mtrr/cleanup.c	2024-02-22 10:08:49.852507994 -0800
@@ -170,7 +170,7 @@ set_var_mtrr(unsigned int reg, unsigned
 		return;
 	}
 
-	mask = (1ULL << boot_cpu_data.x86_phys_bits) - 1;
+	mask = (1ULL << x86_phys_bits()) - 1;
 	mask &= ~((((u64)sizek) << 10) - 1);
 
 	base = ((u64)basek) << 10;
diff -puN arch/x86/kernel/cpu/mtrr/generic.c~introduce-x86_phys_bits arch/x86/kernel/cpu/mtrr/generic.c
--- a/arch/x86/kernel/cpu/mtrr/generic.c~introduce-x86_phys_bits	2024-02-22 10:08:49.832507209 -0800
+++ b/arch/x86/kernel/cpu/mtrr/generic.c	2024-02-22 10:08:49.852507994 -0800
@@ -660,7 +660,7 @@ static void __init print_mtrr_state(void
 	}
 	pr_info("MTRR variable ranges %sabled:\n",
 		mtrr_state.enabled & MTRR_STATE_MTRR_ENABLED ? "en" : "dis");
-	high_width = (boot_cpu_data.x86_phys_bits - (32 - PAGE_SHIFT) + 3) / 4;
+	high_width = (x86_phys_bits() - (32 - PAGE_SHIFT) + 3) / 4;
 
 	for (i = 0; i < num_var_ranges; ++i) {
 		if (mtrr_state.var_ranges[i].mask_lo & MTRR_PHYSMASK_V)
diff -puN arch/x86/kernel/cpu/mtrr/mtrr.c~introduce-x86_phys_bits arch/x86/kernel/cpu/mtrr/mtrr.c
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c~introduce-x86_phys_bits	2024-02-22 10:08:49.836507366 -0800
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c	2024-02-22 10:08:49.852507994 -0800
@@ -252,8 +252,7 @@ int mtrr_add_page(unsigned long base, un
 		return -EINVAL;
 	}
 
-	if ((base | (base + size - 1)) >>
-	    (boot_cpu_data.x86_phys_bits - PAGE_SHIFT)) {
+	if ((base | (base + size - 1)) >> (x86_phys_bits() - PAGE_SHIFT)) {
 		pr_warn("base or size exceeds the MTRR width\n");
 		return -EINVAL;
 	}
@@ -556,7 +555,7 @@ void __init mtrr_bp_init(void)
 	const char *why = "(not available)";
 	unsigned long config, dummy;
 
-	phys_hi_rsvd = GENMASK(31, boot_cpu_data.x86_phys_bits - 32);
+	phys_hi_rsvd = GENMASK(31, x86_phys_bits() - 32);
 
 	if (!generic_mtrrs && mtrr_state.enabled) {
 		/*
diff -puN arch/x86/kernel/setup.c~introduce-x86_phys_bits arch/x86/kernel/setup.c
--- a/arch/x86/kernel/setup.c~introduce-x86_phys_bits	2024-02-22 10:08:49.836507366 -0800
+++ b/arch/x86/kernel/setup.c	2024-02-22 10:08:49.852507994 -0800
@@ -813,7 +813,7 @@ void __init setup_arch(char **cmdline_p)
 	 */
 	early_reserve_memory();
 
-	iomem_resource.end = (1ULL << boot_cpu_data.x86_phys_bits) - 1;
+	iomem_resource.end = (1ULL << x86_phys_bits()) - 1;
 	e820__memory_setup();
 	parse_setup_data();
 
diff -puN arch/x86/kvm/cpuid.c~introduce-x86_phys_bits arch/x86/kvm/cpuid.c
--- a/arch/x86/kvm/cpuid.c~introduce-x86_phys_bits	2024-02-22 10:08:49.836507366 -0800
+++ b/arch/x86/kvm/cpuid.c	2024-02-22 10:08:49.852507994 -0800
@@ -1236,7 +1236,7 @@ static inline int __do_cpuid_func(struct
 		 * the HPAs do not affect GPAs.
 		 */
 		if (!tdp_enabled)
-			g_phys_as = boot_cpu_data.x86_phys_bits;
+			g_phys_as = x86_phys_bits();
 		else if (!g_phys_as)
 			g_phys_as = phys_as;
 
diff -puN arch/x86/kvm/mmu.h~introduce-x86_phys_bits arch/x86/kvm/mmu.h
--- a/arch/x86/kvm/mmu.h~introduce-x86_phys_bits	2024-02-22 10:08:49.840507523 -0800
+++ b/arch/x86/kvm/mmu.h	2024-02-22 10:08:49.852507994 -0800
@@ -84,10 +84,10 @@ static inline gfn_t kvm_mmu_max_gfn(void
 static inline u8 kvm_get_shadow_phys_bits(void)
 {
 	/*
-	 * boot_cpu_data.x86_phys_bits is reduced when MKTME or SME are detected
-	 * in CPU detection code, but the processor treats those reduced bits as
-	 * 'keyID' thus they are not reserved bits. Therefore KVM needs to look at
-	 * the physical address bits reported by CPUID.
+	 * x86_phys_bits() is reduced when MKTME or SME are detected in CPU
+	 * detection code, but the processor treats those reduced bits as 'keyID'
+	 * thus they are not reserved bits. Therefore KVM needs to look at the
+	 * physical address bits reported by CPUID.
 	 */
 	if (likely(boot_cpu_data.extended_cpuid_level >= 0x80000008))
 		return cpuid_eax(0x80000008) & 0xff;
@@ -97,7 +97,7 @@ static inline u8 kvm_get_shadow_phys_bit
 	 * custom CPUID.  Proceed with whatever the kernel found since these features
 	 * aren't virtualizable (SME/SEV also require CPUIDs higher than 0x80000008).
 	 */
-	return boot_cpu_data.x86_phys_bits;
+	return x86_phys_bits();
 }
 
 void kvm_mmu_set_mmio_spte_mask(u64 mmio_value, u64 mmio_mask, u64 access_mask);
diff -puN arch/x86/kvm/mmu/spte.c~introduce-x86_phys_bits arch/x86/kvm/mmu/spte.c
--- a/arch/x86/kvm/mmu/spte.c~introduce-x86_phys_bits	2024-02-22 10:08:49.840507523 -0800
+++ b/arch/x86/kvm/mmu/spte.c	2024-02-22 10:08:49.852507994 -0800
@@ -468,7 +468,7 @@ void kvm_mmu_reset_all_pte_masks(void)
 	 * the most significant bits of legal physical address space.
 	 */
 	shadow_nonpresent_or_rsvd_mask = 0;
-	low_phys_bits = boot_cpu_data.x86_phys_bits;
+	low_phys_bits = x86_phys_bits();
 	if (boot_cpu_has_bug(X86_BUG_L1TF) &&
 	    !WARN_ON_ONCE(boot_cpu_data.x86_cache_bits >=
 			  52 - SHADOW_NONPRESENT_OR_RSVD_MASK_LEN)) {
diff -puN arch/x86/kvm/svm/svm.c~introduce-x86_phys_bits arch/x86/kvm/svm/svm.c
--- a/arch/x86/kvm/svm/svm.c~introduce-x86_phys_bits	2024-02-22 10:08:49.840507523 -0800
+++ b/arch/x86/kvm/svm/svm.c	2024-02-22 10:08:49.852507994 -0800
@@ -5054,7 +5054,7 @@ static __init void svm_adjust_mmio_mask(
 		return;
 
 	enc_bit = cpuid_ebx(0x8000001f) & 0x3f;
-	mask_bit = boot_cpu_data.x86_phys_bits;
+	mask_bit = x86_phys_bits();
 
 	/* Increment the mask bit if it is the same as the encryption bit */
 	if (enc_bit == mask_bit)
diff -puN arch/x86/kvm/vmx/vmx.c~introduce-x86_phys_bits arch/x86/kvm/vmx/vmx.c
--- a/arch/x86/kvm/vmx/vmx.c~introduce-x86_phys_bits	2024-02-22 10:08:49.844507680 -0800
+++ b/arch/x86/kvm/vmx/vmx.c	2024-02-22 10:08:49.852507994 -0800
@@ -8444,14 +8444,14 @@ static void __init vmx_setup_me_spte_mas
 	 * kvm_get_shadow_phys_bits() returns shadow_phys_bits.  Use
 	 * the former to avoid exposing shadow_phys_bits.
 	 *
-	 * On pre-MKTME system, boot_cpu_data.x86_phys_bits equals to
+	 * On pre-MKTME system, x86_phys_bits() equals to
 	 * shadow_phys_bits.  On MKTME and/or TDX capable systems,
-	 * boot_cpu_data.x86_phys_bits holds the actual physical address
-	 * w/o the KeyID bits, and shadow_phys_bits equals to MAXPHYADDR
+	 * x86_phys_bits() holds the actual physical address w/o the
+	 * KeyID bits, and shadow_phys_bits equals to MAXPHYADDR
 	 * reported by CPUID.  Those bits between are KeyID bits.
 	 */
-	if (boot_cpu_data.x86_phys_bits != kvm_get_shadow_phys_bits())
-		me_mask = rsvd_bits(boot_cpu_data.x86_phys_bits,
+	if (x86_phys_bits() != kvm_get_shadow_phys_bits())
+		me_mask = rsvd_bits(x86_phys_bits(),
 			kvm_get_shadow_phys_bits() - 1);
 	/*
 	 * Unlike SME, host kernel doesn't support setting up any
diff -puN arch/x86/kvm/vmx/vmx.h~introduce-x86_phys_bits arch/x86/kvm/vmx/vmx.h
--- a/arch/x86/kvm/vmx/vmx.h~introduce-x86_phys_bits	2024-02-22 10:08:49.844507680 -0800
+++ b/arch/x86/kvm/vmx/vmx.h	2024-02-22 10:08:49.852507994 -0800
@@ -721,7 +721,7 @@ static inline bool vmx_need_pf_intercept
 	if (!enable_ept)
 		return true;
 
-	return allow_smaller_maxphyaddr && cpuid_maxphyaddr(vcpu) < boot_cpu_data.x86_phys_bits;
+	return allow_smaller_maxphyaddr && cpuid_maxphyaddr(vcpu) < x86_phys_bits();
 }
 
 static inline bool is_unrestricted_guest(struct kvm_vcpu *vcpu)
diff -puN arch/x86/mm/physaddr.h~introduce-x86_phys_bits arch/x86/mm/physaddr.h
--- a/arch/x86/mm/physaddr.h~introduce-x86_phys_bits	2024-02-22 10:08:49.848507837 -0800
+++ b/arch/x86/mm/physaddr.h	2024-02-22 10:08:49.852507994 -0800
@@ -4,7 +4,7 @@
 static inline int phys_addr_valid(resource_size_t addr)
 {
 #ifdef CONFIG_PHYS_ADDR_T_64BIT
-	return !(addr >> boot_cpu_data.x86_phys_bits);
+	return !(addr >> x86_phys_bits());
 #else
 	return 1;
 #endif
diff -puN drivers/acpi/acpi_fpdt.c~introduce-x86_phys_bits drivers/acpi/acpi_fpdt.c
--- a/drivers/acpi/acpi_fpdt.c~introduce-x86_phys_bits	2024-02-22 10:08:49.848507837 -0800
+++ b/drivers/acpi/acpi_fpdt.c	2024-02-22 10:08:49.852507994 -0800
@@ -151,7 +151,7 @@ static bool fpdt_address_valid(u64 addre
 	 * On some systems the table contains invalid addresses
 	 * with unsuppored high address bits set, check for this.
 	 */
-	return !(address >> boot_cpu_data.x86_phys_bits);
+	return !(address >> x86_phys_bits());
 }
 #else
 static bool fpdt_address_valid(u64 address)
_

