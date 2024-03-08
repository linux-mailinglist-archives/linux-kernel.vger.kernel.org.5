Return-Path: <linux-kernel+bounces-97137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 058DC8765F6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85E771F25F8E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF733FBAF;
	Fri,  8 Mar 2024 14:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fZ93+G6h"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47923FBB3
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 14:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709906740; cv=none; b=UkFsLO7NRGAwUdBpX6mDnrWgbb3ypiSUcPN7P/jEgD8d/W/2lXyAuDcC1noFLX3Mo3HTy9YXHRgH3mnTzqtVucvGWxfsZq3amweO8YPY+Ru6I3nIgZ211ArocE6EsTS5hQjQ03jgbKopI2bdaff5wVv+2HhnUAmDgk38A9LKDTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709906740; c=relaxed/simple;
	bh=3bNaGsTQaX57W6302QNmcHBrfrgBv5LKbPPTrEpuh4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGLfQVa3rHq966IT/w6FJ8jm5pW1znwE+p4kWH6Y/UStSywUnDocljlLilXNRvK19kolxyU4DjxZ46a3vifpD0d5rkxTS9ZzMVCTzt9jNEPVrT0jMgaSr6bdMrMffG9VtC95bYYW2APDHwP7WaUwktdw9OsCJbGXNZzT3TC2/RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fZ93+G6h; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709906739; x=1741442739;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3bNaGsTQaX57W6302QNmcHBrfrgBv5LKbPPTrEpuh4c=;
  b=fZ93+G6hvBkVDmNRUq7RIkiB+GtVYr1qPFcSY/Qk+VgUaKPem1fe6wEt
   CcKo+TnxJiW1cr65G+H6rM1EM+RQCGX3NscjzyW01WkrxdIbjKBBQruIc
   hAANHh08CceJZqCNz6a4QhLDpIlROXqkw6lAjJyxaGudLefsxUhypzBbj
   YiE9Jai8WmKuhQVeOHvzLUWc015iDnC1WhPCdvNeRvI1FkUtzHI54Cq1m
   h565d6qa3n0dY5hzw4lULu2sIH6rxRFnKL4rgqvOp6qMAkCUUt61Uuq1A
   D9RSGK6DMGbiPDDZaM1m6OHb5U6g6QEuK5UbL9TWjIbEfYsa7vC1JDi4B
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4484452"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="4484452"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 06:05:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="937047523"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="937047523"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 08 Mar 2024 06:05:34 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 390B11F1; Fri,  8 Mar 2024 16:05:33 +0200 (EET)
Date: Fri, 8 Mar 2024 16:05:33 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andy Lutomirski <luto@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@intel.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
	the arch/x86 maintainers <x86@kernel.org>, linux-mm@kvack.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/3] x86/mm: make sure LAM is up-to-date during
 context switching
Message-ID: <3h7wb3sai4ael74njzrxrdh66y3vo4bp2u5yuvcdoq4j657hgw@q3k2n3hmtv6a>
References: <20240307133916.3782068-1-yosryahmed@google.com>
 <20240307133916.3782068-3-yosryahmed@google.com>
 <420fcb06-c3c3-4e8f-a82d-be2fb2ef444d@app.fastmail.com>
 <ZepuO5bDoE-5T0RB@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZepuO5bDoE-5T0RB@google.com>

On Fri, Mar 08, 2024 at 01:47:39AM +0000, Yosry Ahmed wrote:
> I like it very much. The problem now is, as I told Dave, I realized I
> cannot do any testing beyond compilation due to lack of hardware. I am
> happy to send a next version if this is acceptable or if someone else
> can test.

I have non-upstreamable QEMU patch that adds LAM emulation, if it helps:

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 93b1ca810bf4..fe887a86a156 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1295,6 +1295,19 @@ void tlb_set_page(CPUState *cpu, vaddr addr,
                             prot, mmu_idx, size);
 }
 
+
+static vaddr clean_addr(CPUState *cpu, vaddr addr)
+{
+    CPUClass *cc = CPU_GET_CLASS(cpu);
+
+    if (cc->tcg_ops->do_clean_addr) {
+        addr = cc->tcg_ops->do_clean_addr(cpu, addr);
+    }
+
+    return addr;
+}
+
+
 /*
  * Note: tlb_fill() can trigger a resize of the TLB. This means that all of the
  * caller's prior references to the TLB table (e.g. CPUTLBEntry pointers) must
@@ -1867,9 +1880,10 @@ static bool mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
  * Probe for an atomic operation.  Do not allow unaligned operations,
  * or io operations to proceed.  Return the host address.
  */
-static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
+static void *atomic_mmu_lookup(CPUState *cpu, vaddr address, MemOpIdx oi,
                                int size, uintptr_t retaddr)
 {
+    vaddr addr = clean_addr(cpu, address);
     uintptr_t mmu_idx = get_mmuidx(oi);
     MemOp mop = get_memop(oi);
     int a_bits = get_alignment_bits(mop);
@@ -2002,10 +2016,11 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
  * The bytes are concatenated in big-endian order with @ret_be.
  */
 static uint64_t int_ld_mmio_beN(CPUState *cpu, CPUTLBEntryFull *full,
-                                uint64_t ret_be, vaddr addr, int size,
+                                uint64_t ret_be, vaddr address, int size,
                                 int mmu_idx, MMUAccessType type, uintptr_t ra,
                                 MemoryRegion *mr, hwaddr mr_offset)
 {
+    vaddr addr = clean_addr(cpu, address);
     do {
         MemOp this_mop;
         unsigned this_size;
@@ -2543,10 +2558,11 @@ static Int128 do_ld16_mmu(CPUState *cpu, vaddr addr,
  * return the bytes of @val_le beyond @p->size that have not been stored.
  */
 static uint64_t int_st_mmio_leN(CPUState *cpu, CPUTLBEntryFull *full,
-                                uint64_t val_le, vaddr addr, int size,
+                                uint64_t val_le, vaddr address, int size,
                                 int mmu_idx, uintptr_t ra,
                                 MemoryRegion *mr, hwaddr mr_offset)
 {
+    vaddr addr = clean_addr(cpu, address);
     do {
         MemOp this_mop;
         unsigned this_size;
diff --git a/include/hw/core/tcg-cpu-ops.h b/include/hw/core/tcg-cpu-ops.h
index bf8ff8e3eec1..eaa8e09a6226 100644
--- a/include/hw/core/tcg-cpu-ops.h
+++ b/include/hw/core/tcg-cpu-ops.h
@@ -140,6 +140,12 @@ struct TCGCPUOps {
                                            MMUAccessType access_type,
                                            int mmu_idx, uintptr_t retaddr);
 
+
+    /**
+     * @do_clean_addr: Callback for clearing metadata/tags from the address.
+     */
+    vaddr (*do_clean_addr)(CPUState *cpu, vaddr addr);
+
     /**
      * @adjust_watchpoint_address: hack for cpu_check_watchpoint used by ARM
      */
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 2666ef380891..1bbfd31042b2 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -739,7 +739,7 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
 #define TCG_7_0_EDX_FEATURES (CPUID_7_0_EDX_FSRM | CPUID_7_0_EDX_KERNEL_FEATURES)
 
 #define TCG_7_1_EAX_FEATURES (CPUID_7_1_EAX_FZRM | CPUID_7_1_EAX_FSRS | \
-          CPUID_7_1_EAX_FSRC | CPUID_7_1_EAX_CMPCCXADD)
+          CPUID_7_1_EAX_FSRC | CPUID_7_1_EAX_CMPCCXADD | CPUID_7_1_EAX_LAM)
 #define TCG_7_1_EDX_FEATURES 0
 #define TCG_7_2_EDX_FEATURES 0
 #define TCG_APM_FEATURES 0
@@ -968,7 +968,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "fsrc", NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, "amx-fp16", NULL, "avx-ifma",
-            NULL, NULL, NULL, NULL,
+            NULL, NULL, "lam", NULL,
             NULL, NULL, NULL, NULL,
         },
         .cpuid = {
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 952174bb6f52..6ef9afd443b7 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -238,6 +238,9 @@ typedef enum X86Seg {
 #define CR0_CD_MASK  (1U << 30)
 #define CR0_PG_MASK  (1U << 31)
 
+#define CR3_LAM_U57  (1ULL << 61)
+#define CR3_LAM_U48  (1ULL << 62)
+
 #define CR4_VME_MASK  (1U << 0)
 #define CR4_PVI_MASK  (1U << 1)
 #define CR4_TSD_MASK  (1U << 2)
@@ -261,6 +264,7 @@ typedef enum X86Seg {
 #define CR4_SMAP_MASK   (1U << 21)
 #define CR4_PKE_MASK   (1U << 22)
 #define CR4_PKS_MASK   (1U << 24)
+#define CR4_LAM_SUP    (1U << 28)
 
 #define CR4_RESERVED_MASK \
 (~(target_ulong)(CR4_VME_MASK | CR4_PVI_MASK | CR4_TSD_MASK \
@@ -269,7 +273,8 @@ typedef enum X86Seg {
                 | CR4_OSFXSR_MASK | CR4_OSXMMEXCPT_MASK | CR4_UMIP_MASK \
                 | CR4_LA57_MASK \
                 | CR4_FSGSBASE_MASK | CR4_PCIDE_MASK | CR4_OSXSAVE_MASK \
-                | CR4_SMEP_MASK | CR4_SMAP_MASK | CR4_PKE_MASK | CR4_PKS_MASK))
+                | CR4_SMEP_MASK | CR4_SMAP_MASK | CR4_PKE_MASK | CR4_PKS_MASK \
+                | CR4_LAM_SUP ))
 
 #define DR6_BD          (1 << 13)
 #define DR6_BS          (1 << 14)
@@ -932,6 +937,8 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
 #define CPUID_7_1_EAX_AMX_FP16          (1U << 21)
 /* Support for VPMADD52[H,L]UQ */
 #define CPUID_7_1_EAX_AVX_IFMA          (1U << 23)
+/* Linear Address Masking */
+#define CPUID_7_1_EAX_LAM               (1U << 26)
 
 /* Support for VPDPB[SU,UU,SS]D[,S] */
 #define CPUID_7_1_EDX_AVX_VNNI_INT8     (1U << 4)
@@ -2525,6 +2532,24 @@ static inline bool hyperv_feat_enabled(X86CPU *cpu, int feat)
     return !!(cpu->hyperv_features & BIT(feat));
 }
 
+static inline uint64_t cr3_reserved_bits(CPUX86State *env)
+{
+    uint64_t reserved_bits;
+
+    if (!(env->efer & MSR_EFER_LMA)) {
+        return 0;
+    }
+
+    reserved_bits = (~0ULL) << env_archcpu(env)->phys_bits;
+
+    if (env->features[FEAT_7_1_EAX] & CPUID_7_1_EAX_LAM) {
+        reserved_bits &= ~(CR3_LAM_U48 | CR3_LAM_U57);
+    }
+
+    return reserved_bits;
+}
+
+
 static inline uint64_t cr4_reserved_bits(CPUX86State *env)
 {
     uint64_t reserved_bits = CR4_RESERVED_MASK;
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 2070dd0dda1f..4901c9c17b1e 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -262,7 +262,7 @@ hwaddr x86_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
             }
 
             if (la57) {
-                pml5e_addr = ((env->cr[3] & ~0xfff) +
+                pml5e_addr = ((env->cr[3] & PG_ADDRESS_MASK) +
                         (((addr >> 48) & 0x1ff) << 3)) & a20_mask;
                 pml5e = x86_ldq_phys(cs, pml5e_addr);
                 if (!(pml5e & PG_PRESENT_MASK)) {
diff --git a/target/i386/tcg/helper-tcg.h b/target/i386/tcg/helper-tcg.h
index effc2c1c9842..11f75ea475e3 100644
--- a/target/i386/tcg/helper-tcg.h
+++ b/target/i386/tcg/helper-tcg.h
@@ -84,6 +84,7 @@ bool x86_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
 G_NORETURN void x86_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
                                             MMUAccessType access_type,
                                             int mmu_idx, uintptr_t retaddr);
+vaddr x86_cpu_clean_addr(CPUState *cpu, vaddr addr);
 #endif
 
 /* cc_helper.c */
diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
index 8f7011d96631..1bc71170e6a3 100644
--- a/target/i386/tcg/sysemu/excp_helper.c
+++ b/target/i386/tcg/sysemu/excp_helper.c
@@ -163,7 +163,7 @@ static bool mmu_translate(CPUX86State *env, const TranslateParams *in,
                 /*
                  * Page table level 5
                  */
-                pte_addr = (in->cr3 & ~0xfff) + (((addr >> 48) & 0x1ff) << 3);
+                pte_addr = (in->cr3 & PG_ADDRESS_MASK) + (((addr >> 48) & 0x1ff) << 3);
                 if (!ptw_translate(&pte_trans, pte_addr)) {
                     return false;
                 }
@@ -638,3 +638,30 @@ G_NORETURN void x86_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
     X86CPU *cpu = X86_CPU(cs);
     handle_unaligned_access(&cpu->env, vaddr, access_type, retaddr);
 }
+
+
+static inline int64_t sign_extend64(uint64_t value, int index)
+{
+    int shift = 63 - index;
+    return (int64_t)(value << shift) >> shift;
+}
+
+vaddr x86_cpu_clean_addr(CPUState *cs, vaddr addr)
+{
+    CPUX86State *env = &X86_CPU(cs)->env;
+    bool la57 = env->cr[4] & CR4_LA57_MASK;
+
+    if (addr >> 63) {
+        if (env->cr[4] & CR4_LAM_SUP) {
+            return sign_extend64(addr, la57 ? 56 : 47);
+        }
+    } else {
+        if (env->cr[3] & CR3_LAM_U57) {
+            return sign_extend64(addr, 56);
+        } else if (env->cr[3] & CR3_LAM_U48) {
+            return sign_extend64(addr, 47);
+        }
+    }
+
+    return addr;
+}
diff --git a/target/i386/tcg/sysemu/misc_helper.c b/target/i386/tcg/sysemu/misc_helper.c
index edb7c3d89408..aecb523e777d 100644
--- a/target/i386/tcg/sysemu/misc_helper.c
+++ b/target/i386/tcg/sysemu/misc_helper.c
@@ -98,8 +98,7 @@ void helper_write_crN(CPUX86State *env, int reg, target_ulong t0)
         cpu_x86_update_cr0(env, t0);
         break;
     case 3:
-        if ((env->efer & MSR_EFER_LMA) &&
-                (t0 & ((~0ULL) << env_archcpu(env)->phys_bits))) {
+        if (t0 & cr3_reserved_bits(env)) {
             cpu_vmexit(env, SVM_EXIT_ERR, 0, GETPC());
         }
         if (!(env->efer & MSR_EFER_LMA)) {
diff --git a/target/i386/tcg/sysemu/svm_helper.c b/target/i386/tcg/sysemu/svm_helper.c
index 5d6de2294fa1..e981b124d975 100644
--- a/target/i386/tcg/sysemu/svm_helper.c
+++ b/target/i386/tcg/sysemu/svm_helper.c
@@ -305,8 +305,7 @@ void helper_vmrun(CPUX86State *env, int aflag, int next_eip_addend)
         cpu_vmexit(env, SVM_EXIT_ERR, 0, GETPC());
     }
     new_cr3 = x86_ldq_phys(cs, env->vm_vmcb + offsetof(struct vmcb, save.cr3));
-    if ((env->efer & MSR_EFER_LMA) &&
-            (new_cr3 & ((~0ULL) << cpu->phys_bits))) {
+    if (new_cr3 & cr3_reserved_bits(env)) {
         cpu_vmexit(env, SVM_EXIT_ERR, 0, GETPC());
     }
     new_cr4 = x86_ldq_phys(cs, env->vm_vmcb + offsetof(struct vmcb, save.cr4));
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index cca19cd40e81..8ceeb954364e 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -118,6 +118,7 @@ static const TCGCPUOps x86_tcg_ops = {
     .record_sigbus = x86_cpu_record_sigbus,
 #else
     .tlb_fill = x86_cpu_tlb_fill,
+    .do_clean_addr = x86_cpu_clean_addr,
     .do_interrupt = x86_cpu_do_interrupt,
     .cpu_exec_halt = x86_cpu_exec_halt,
     .cpu_exec_interrupt = x86_cpu_exec_interrupt,
-- 
  Kiryl Shutsemau / Kirill A. Shutemov

