Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A6B8057BE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 15:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345981AbjLEOho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 09:37:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345946AbjLEOhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 09:37:42 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FBD183
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 06:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701787067; x=1733323067;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=E0fR/LV8LcO5zj23A2K3suoU3zT8qKQpMn8kQgLJL+o=;
  b=gpTOj/7XbAHsSxYiRe2mC1ooYspT+wG2ccwM4Dqkc1Jgv+rzvYbUZpOO
   U+dDIlXbPGJrXvbe8uOQ4Py2PBUesVUbFMvN5AvdYYzMnxRSSVYR3VKQB
   8OSRJmUtZ9g3TroS+4RpnON/7pacFxxNHcoB9MJeAtCU3t9nhgypwRrRW
   VJaDQLeGPkRAJqBA3IAQoe4Ze6mUoAQG8lP2NfkAwfbRRlVSOEUuUMhAt
   oSFsCXvxnP+2IUT8rxIuWs8o9Jps3EI49HtX8GJGD3nY4qQIvGf4cr7if
   9Kgpfx6LjewvHT8+HAY9ZLb18AWuoDQ56OkMJmmQyG7Ry2QOj+tG0LJC8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="743643"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="743643"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 06:37:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="774652508"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="774652508"
Received: from rjongalo-mobl2.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.46.235])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 06:37:43 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id CEACA10A437; Tue,  5 Dec 2023 17:37:40 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH] x86/coco, x86/sev: Use cpu_feature_enabled() to detect SEV guest flavor
Date:   Tue,  5 Dec 2023 17:37:38 +0300
Message-ID: <20231205143738.2875-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SEV code uses cc_platform_has() checks to detect the SEV flavor.
However, these checks can sometimes produce false positives depending on
the context.

For example, sev_map_percpu_data() uses CC_ATTR_GUEST_MEM_ENCRYPT to
detect SEV guest, but this check will also pass for TDX guests.

To address this issue, cc_vendor checks were added in several places
(e.g. sev_es_nmi_complete()). However, this approach is clunky and
goes against the original idea of cc_platform_has(). cc_platform_has()
was introduced to be used in generic code that handles multiple
confidential computing environments. The kernel has better mechanisms
for detecting specific platform features.

To solve this problem, introduce three synthetic X86_FEATURE_ and
replace cc_platform_has() with cpu_feature_enabled() where it was used
to detect SEV flavor.

It removes all users of CC_ATTR_GUEST_STATE_ENCRYPT and
CC_ATTR_GUEST_SEV_SNP. These attributes are no longer needed.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/coco/core.c                     | 15 +++++----------
 arch/x86/include/asm/cpufeatures.h       |  3 +++
 arch/x86/include/asm/disabled-features.h | 10 +++++++++-
 arch/x86/include/asm/sev.h               |  9 +++------
 arch/x86/include/asm/unaccepted_memory.h |  2 +-
 arch/x86/kernel/cpu/mtrr/generic.c       |  2 +-
 arch/x86/kernel/kvm.c                    |  6 +++---
 arch/x86/kernel/sev.c                    | 24 ++++++++++++------------
 arch/x86/kvm/svm/svm.c                   |  2 +-
 arch/x86/mm/cpu_entry_area.c             |  8 +++-----
 arch/x86/mm/mem_encrypt.c                |  6 +++---
 arch/x86/mm/mem_encrypt_amd.c            | 15 +++++++++++----
 arch/x86/realmode/init.c                 |  4 +---
 drivers/virt/coco/sev-guest/sev-guest.c  |  2 +-
 include/linux/cc_platform.h              | 18 ------------------
 15 files changed, 57 insertions(+), 69 deletions(-)

diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index eeec9986570e..f989afa40b4b 100644
--- a/arch/x86/coco/core.c
+++ b/arch/x86/coco/core.c
@@ -11,6 +11,7 @@
 #include <linux/cc_platform.h>
 
 #include <asm/coco.h>
+#include <asm/cpufeature.h>
 #include <asm/processor.h>
 
 enum cc_vendor cc_vendor __ro_after_init = CC_VENDOR_NONE;
@@ -70,24 +71,18 @@ static bool noinstr amd_cc_platform_has(enum cc_attr attr)
 		return sme_me_mask;
 
 	case CC_ATTR_HOST_MEM_ENCRYPT:
-		return sme_me_mask && !(sev_status & MSR_AMD64_SEV_ENABLED);
+		return sme_me_mask && !cpu_feature_enabled(X86_FEATURE_SEV_GUEST);
 
 	case CC_ATTR_GUEST_MEM_ENCRYPT:
-		return sev_status & MSR_AMD64_SEV_ENABLED;
-
-	case CC_ATTR_GUEST_STATE_ENCRYPT:
-		return sev_status & MSR_AMD64_SEV_ES_ENABLED;
+		return cpu_feature_enabled(X86_FEATURE_SEV_GUEST);
 
 	/*
 	 * With SEV, the rep string I/O instructions need to be unrolled
 	 * but SEV-ES supports them through the #VC handler.
 	 */
 	case CC_ATTR_GUEST_UNROLL_STRING_IO:
-		return (sev_status & MSR_AMD64_SEV_ENABLED) &&
-			!(sev_status & MSR_AMD64_SEV_ES_ENABLED);
-
-	case CC_ATTR_GUEST_SEV_SNP:
-		return sev_status & MSR_AMD64_SEV_SNP_ENABLED;
+		return cpu_feature_enabled(X86_FEATURE_SEV_GUEST) &&
+			!cpu_feature_enabled(X86_FEATURE_SEV_ES_GUEST);
 
 	default:
 		return false;
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 149cc5d5c2ae..bf731e021ba5 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -237,6 +237,9 @@
 #define X86_FEATURE_PVUNLOCK		( 8*32+20) /* "" PV unlock function */
 #define X86_FEATURE_VCPUPREEMPT		( 8*32+21) /* "" PV vcpu_is_preempted function */
 #define X86_FEATURE_TDX_GUEST		( 8*32+22) /* Intel Trust Domain Extensions Guest */
+#define X86_FEATURE_SEV_GUEST			( 8*32+23) /* AMD Secure Encrypted Virtualization */
+#define X86_FEATURE_SEV_ES_GUEST		( 8*32+24) /* AMD Secure Encrypted Virtualization-Encrypted State */
+#define X86_FEATURE_SEV_SNP_GUEST		( 8*32+25) /* AMD Secure Nested Paging */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (EBX), word 9 */
 #define X86_FEATURE_FSGSBASE		( 9*32+ 0) /* RDFSBASE, WRFSBASE, RDGSBASE, WRGSBASE instructions*/
diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index 702d93fdd10e..b7733355e381 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -105,6 +105,14 @@
 # define DISABLE_TDX_GUEST	(1 << (X86_FEATURE_TDX_GUEST & 31))
 #endif
 
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+# define DISABLED_SEV_GUEST	0
+#else
+# define DISABLED_SEV_GUEST	((1 << (X86_FEATURE_SEV_GUEST & 31)) | \
+				 (1 << (X86_FEATURE_SEV_ES_GUEST & 31)) | \
+				 (1 << (X86_FEATURE_SEV_SNP_GUEST & 31)))
+#endif
+
 #ifdef CONFIG_X86_USER_SHADOW_STACK
 #define DISABLE_USER_SHSTK	0
 #else
@@ -128,7 +136,7 @@
 #define DISABLED_MASK5	0
 #define DISABLED_MASK6	0
 #define DISABLED_MASK7	(DISABLE_PTI)
-#define DISABLED_MASK8	(DISABLE_XENPV|DISABLE_TDX_GUEST)
+#define DISABLED_MASK8	(DISABLE_XENPV|DISABLE_TDX_GUEST|DISABLED_SEV_GUEST)
 #define DISABLED_MASK9	(DISABLE_SGX)
 #define DISABLED_MASK10	0
 #define DISABLED_MASK11	(DISABLE_RETPOLINE|DISABLE_RETHUNK|DISABLE_UNRET| \
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 5b4a1ce3d368..acc8b4d4bb92 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -145,22 +145,19 @@ extern void __sev_es_ist_enter(struct pt_regs *regs);
 extern void __sev_es_ist_exit(void);
 static __always_inline void sev_es_ist_enter(struct pt_regs *regs)
 {
-	if (cc_vendor == CC_VENDOR_AMD &&
-	    cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
+	if (cpu_feature_enabled(X86_FEATURE_SEV_ES_GUEST))
 		__sev_es_ist_enter(regs);
 }
 static __always_inline void sev_es_ist_exit(void)
 {
-	if (cc_vendor == CC_VENDOR_AMD &&
-	    cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
+	if (cpu_feature_enabled(X86_FEATURE_SEV_ES_GUEST))
 		__sev_es_ist_exit();
 }
 extern int sev_es_setup_ap_jump_table(struct real_mode_header *rmh);
 extern void __sev_es_nmi_complete(void);
 static __always_inline void sev_es_nmi_complete(void)
 {
-	if (cc_vendor == CC_VENDOR_AMD &&
-	    cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
+	if (cpu_feature_enabled(X86_FEATURE_SEV_ES_GUEST))
 		__sev_es_nmi_complete();
 }
 extern int __init sev_es_efi_map_ghcbs(pgd_t *pgd);
diff --git a/arch/x86/include/asm/unaccepted_memory.h b/arch/x86/include/asm/unaccepted_memory.h
index f5937e9866ac..591c0b6ab0bc 100644
--- a/arch/x86/include/asm/unaccepted_memory.h
+++ b/arch/x86/include/asm/unaccepted_memory.h
@@ -11,7 +11,7 @@ static inline void arch_accept_memory(phys_addr_t start, phys_addr_t end)
 	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
 		if (!tdx_accept_memory(start, end))
 			panic("TDX: Failed to accept memory\n");
-	} else if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP)) {
+	} else if (cpu_feature_enabled(X86_FEATURE_SEV_SNP_GUEST)) {
 		snp_accept_memory(start, end);
 	} else {
 		panic("Cannot accept memory: unknown platform\n");
diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index d3524778a545..aabc5c2468e4 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -453,7 +453,7 @@ void mtrr_overwrite_state(struct mtrr_var_range *var, unsigned int num_var,
 	 * - when running as SEV-SNP or TDX guest to avoid unnecessary
 	 *   VMM communication/Virtualization exceptions (#VC, #VE)
 	 */
-	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP) &&
+	if (!cpu_feature_enabled(X86_FEATURE_SEV_SNP_GUEST) &&
 	    !hv_is_isolation_supported() &&
 	    !cpu_feature_enabled(X86_FEATURE_XENPV) &&
 	    !cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 0ddb3bd0f1aa..31ae51ab0c09 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -434,7 +434,7 @@ static void __init sev_map_percpu_data(void)
 {
 	int cpu;
 
-	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
+	if (!cpu_feature_enabled(X86_FEATURE_SEV_GUEST))
 		return;
 
 	for_each_possible_cpu(cpu) {
@@ -578,7 +578,7 @@ static int __init setup_efi_kvm_sev_migration(void)
 	unsigned long size;
 	bool enabled;
 
-	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) ||
+	if (!cpu_feature_enabled(X86_FEATURE_SEV_GUEST) ||
 	    !kvm_para_has_feature(KVM_FEATURE_MIGRATION_CONTROL))
 		return 0;
 
@@ -930,7 +930,7 @@ static void kvm_sev_hc_page_enc_status(unsigned long pfn, int npages, bool enc)
 
 static void __init kvm_init_platform(void)
 {
-	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) &&
+	if (cpu_feature_enabled(X86_FEATURE_SEV_GUEST) &&
 	    kvm_para_has_feature(KVM_FEATURE_MIGRATION_CONTROL)) {
 		unsigned long nr_pages;
 		int i;
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index c67285824e82..3775124187e3 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -656,7 +656,7 @@ static u64 __init get_jump_table_addr(void)
 	struct ghcb *ghcb;
 	u64 ret = 0;
 
-	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+	if (cpu_feature_enabled(X86_FEATURE_SEV_SNP_GUEST))
 		return get_snp_jump_table_addr();
 
 	local_irq_save(flags);
@@ -879,7 +879,7 @@ static void set_pages_state(unsigned long vaddr, unsigned long npages, int op)
 
 void snp_set_memory_shared(unsigned long vaddr, unsigned long npages)
 {
-	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+	if (!cpu_feature_enabled(X86_FEATURE_SEV_SNP_GUEST))
 		return;
 
 	set_pages_state(vaddr, npages, SNP_PAGE_STATE_SHARED);
@@ -887,7 +887,7 @@ void snp_set_memory_shared(unsigned long vaddr, unsigned long npages)
 
 void snp_set_memory_private(unsigned long vaddr, unsigned long npages)
 {
-	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+	if (!cpu_feature_enabled(X86_FEATURE_SEV_SNP_GUEST))
 		return;
 
 	set_pages_state(vaddr, npages, SNP_PAGE_STATE_PRIVATE);
@@ -897,7 +897,7 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end)
 {
 	unsigned long vaddr, npages;
 
-	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+	if (!cpu_feature_enabled(X86_FEATURE_SEV_SNP_GUEST))
 		return;
 
 	vaddr = (unsigned long)__va(start);
@@ -1117,7 +1117,7 @@ static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
 
 void __init snp_set_wakeup_secondary_cpu(void)
 {
-	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+	if (!cpu_feature_enabled(X86_FEATURE_SEV_SNP_GUEST))
 		return;
 
 	/*
@@ -1175,7 +1175,7 @@ int __init sev_es_efi_map_ghcbs(pgd_t *pgd)
 	int cpu;
 	u64 pfn;
 
-	if (!cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
+	if (!cpu_feature_enabled(X86_FEATURE_SEV_ES_GUEST))
 		return 0;
 
 	pflags = _PAGE_NX | _PAGE_RW;
@@ -1231,7 +1231,7 @@ static void snp_register_per_cpu_ghcb(void)
 
 void setup_ghcb(void)
 {
-	if (!cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
+	if (!cpu_feature_enabled(X86_FEATURE_SEV_ES_GUEST))
 		return;
 
 	/*
@@ -1242,7 +1242,7 @@ void setup_ghcb(void)
 	 * exception handler can use it.
 	 */
 	if (initial_vc_handler == (unsigned long)kernel_exc_vmm_communication) {
-		if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+		if (cpu_feature_enabled(X86_FEATURE_SEV_SNP_GUEST))
 			snp_register_per_cpu_ghcb();
 
 		sev_cfg.ghcbs_initialized = true;
@@ -1267,7 +1267,7 @@ void setup_ghcb(void)
 	boot_ghcb = &boot_ghcb_page;
 
 	/* SNP guest requires that GHCB GPA must be registered. */
-	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+	if (cpu_feature_enabled(X86_FEATURE_SEV_SNP_GUEST))
 		snp_register_ghcb_early(__pa(&boot_ghcb_page));
 }
 
@@ -1365,7 +1365,7 @@ void __init sev_es_init_vc_handling(void)
 
 	BUILD_BUG_ON(offsetof(struct sev_es_runtime_data, ghcb_page) % PAGE_SIZE);
 
-	if (!cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
+	if (!cpu_feature_enabled(X86_FEATURE_SEV_ES_GUEST))
 		return;
 
 	if (!sev_es_check_cpu_features())
@@ -1375,7 +1375,7 @@ void __init sev_es_init_vc_handling(void)
 	 * SNP is supported in v2 of the GHCB spec which mandates support for HV
 	 * features.
 	 */
-	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP)) {
+	if (cpu_feature_enabled(X86_FEATURE_SEV_SNP_GUEST)) {
 		sev_hv_features = get_hv_features();
 
 		if (!(sev_hv_features & GHCB_HV_FT_SNP))
@@ -2244,7 +2244,7 @@ static int __init snp_init_platform_device(void)
 	struct sev_guest_platform_data data;
 	u64 gpa;
 
-	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+	if (!cpu_feature_enabled(X86_FEATURE_SEV_SNP_GUEST))
 		return -ENODEV;
 
 	gpa = get_secrets_page();
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 712146312358..a8bac13c1314 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -532,7 +532,7 @@ static bool __kvm_is_svm_supported(void)
 		return false;
 	}
 
-	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
+	if (cpu_feature_enabled(X86_FEATURE_SEV_GUEST)) {
 		pr_info("KVM is unsupported when running as an SEV guest\n");
 		return false;
 	}
diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
index e91500a80963..900641a769da 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -156,11 +156,9 @@ static void __init percpu_setup_exception_stacks(unsigned int cpu)
 	cea_map_stack(DB);
 	cea_map_stack(MCE);
 
-	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
-		if (cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT)) {
-			cea_map_stack(VC);
-			cea_map_stack(VC2);
-		}
+	if (cpu_feature_enabled(X86_FEATURE_SEV_ES_GUEST)) {
+	    cea_map_stack(VC);
+	    cea_map_stack(VC2);
 	}
 }
 #else
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index c290c55b632b..689c2efd008a 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -62,15 +62,15 @@ static void print_mem_encrypt_feature_info(void)
 	}
 
 	/* Secure Encrypted Virtualization */
-	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
+	if (cpu_feature_enabled(X86_FEATURE_SEV_GUEST))
 		pr_cont(" SEV");
 
 	/* Encrypted Register State */
-	if (cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
+	if (cpu_feature_enabled(X86_FEATURE_SEV_ES_GUEST))
 		pr_cont(" SEV-ES");
 
 	/* Secure Nested Paging */
-	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+	if (cpu_feature_enabled(X86_FEATURE_SEV_SNP_GUEST))
 		pr_cont(" SEV-SNP");
 
 	pr_cont("\n");
diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index a68f2dda0948..16c33a8530dc 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -126,7 +126,7 @@ static void __init __sme_early_enc_dec(resource_size_t paddr,
 		 * Use a temporary buffer, of cache-line multiple size, to
 		 * avoid data corruption as documented in the APM.
 		 */
-		if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP)) {
+		if (cpu_feature_enabled(X86_FEATURE_SEV_SNP_GUEST)) {
 			snp_memcpy(sme_early_buffer, src, len, paddr, enc);
 			snp_memcpy(dst, sme_early_buffer, len, paddr, !enc);
 		} else {
@@ -288,7 +288,7 @@ static bool amd_enc_status_change_prepare(unsigned long vaddr, int npages, bool
 	 * To maintain the security guarantees of SEV-SNP guests, make sure
 	 * to invalidate the memory before encryption attribute is cleared.
 	 */
-	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP) && !enc)
+	if (cpu_feature_enabled(X86_FEATURE_SEV_SNP_GUEST) && !enc)
 		snp_set_memory_shared(vaddr, npages);
 
 	return true;
@@ -301,7 +301,7 @@ static bool amd_enc_status_change_finish(unsigned long vaddr, int npages, bool e
 	 * After memory is mapped encrypted in the page table, validate it
 	 * so that it is consistent with the page table updates.
 	 */
-	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP) && enc)
+	if (cpu_feature_enabled(X86_FEATURE_SEV_SNP_GUEST) && enc)
 		snp_set_memory_private(vaddr, npages);
 
 	if (!cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
@@ -467,6 +467,13 @@ void __init sme_early_init(void)
 	x86_platform.guest.enc_tlb_flush_required    = amd_enc_tlb_flush_required;
 	x86_platform.guest.enc_cache_flush_required  = amd_enc_cache_flush_required;
 
+	if (sev_status & MSR_AMD64_SEV_ENABLED)
+		setup_force_cpu_cap(X86_FEATURE_SEV_GUEST);
+	if (sev_status & MSR_AMD64_SEV_ES_ENABLED)
+		setup_force_cpu_cap(X86_FEATURE_SEV_ES_GUEST);
+	if (sev_status & MSR_AMD64_SEV_SNP_ENABLED)
+		setup_force_cpu_cap(X86_FEATURE_SEV_SNP_GUEST);
+
 	/*
 	 * AMD-SEV-ES intercepts the RDMSR to read the X2APIC ID in the
 	 * parallel bringup low level code. That raises #VC which cannot be
@@ -479,7 +486,7 @@ void __init sme_early_init(void)
 	 * "initial" APIC ID to be the same as the real APIC ID.
 	 * Disable parallel bootup.
 	 */
-	if (sev_status & MSR_AMD64_SEV_ES_ENABLED)
+	if (cpu_feature_enabled(X86_FEATURE_SEV_ES_GUEST))
 		x86_cpuinit.parallel_bringup = false;
 }
 
diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index 788e5559549f..f9f74e346798 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -69,11 +69,10 @@ void __init reserve_real_mode(void)
 
 static void __init sme_sev_setup_real_mode(struct trampoline_header *th)
 {
-#ifdef CONFIG_AMD_MEM_ENCRYPT
 	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
 		th->flags |= TH_FLAGS_SME_ACTIVE;
 
-	if (cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT)) {
+	if (cpu_feature_enabled(X86_FEATURE_SEV_ES_GUEST)) {
 		/*
 		 * Skip the call to verify_cpu() in secondary_startup_64 as it
 		 * will cause #VC exceptions when the AP can't handle them yet.
@@ -83,7 +82,6 @@ static void __init sme_sev_setup_real_mode(struct trampoline_header *th)
 		if (sev_es_setup_ap_jump_table(real_mode_header))
 			panic("Failed to get/update SEV-ES AP Jump Table");
 	}
-#endif
 }
 
 static void __init setup_real_mode(void)
diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index bc564adcf499..e116da099f9b 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -905,7 +905,7 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 	void __iomem *mapping;
 	int ret;
 
-	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+	if (!cpu_feature_enabled(X86_FEATURE_SEV_SNP_GUEST))
 		return -ENODEV;
 
 	if (!dev->platform_data)
diff --git a/include/linux/cc_platform.h b/include/linux/cc_platform.h
index cb0d6cd1c12f..0b7073eb6105 100644
--- a/include/linux/cc_platform.h
+++ b/include/linux/cc_platform.h
@@ -52,16 +52,6 @@ enum cc_attr {
 	 */
 	CC_ATTR_GUEST_MEM_ENCRYPT,
 
-	/**
-	 * @CC_ATTR_GUEST_STATE_ENCRYPT: Guest state encryption is active
-	 *
-	 * The platform/OS is running as a guest/virtual machine and actively
-	 * using memory encryption and register state encryption.
-	 *
-	 * Examples include SEV-ES.
-	 */
-	CC_ATTR_GUEST_STATE_ENCRYPT,
-
 	/**
 	 * @CC_ATTR_GUEST_UNROLL_STRING_IO: String I/O is implemented with
 	 *                                  IN/OUT instructions
@@ -73,14 +63,6 @@ enum cc_attr {
 	 */
 	CC_ATTR_GUEST_UNROLL_STRING_IO,
 
-	/**
-	 * @CC_ATTR_SEV_SNP: Guest SNP is active.
-	 *
-	 * The platform/OS is running as a guest/virtual machine and actively
-	 * using AMD SEV-SNP features.
-	 */
-	CC_ATTR_GUEST_SEV_SNP,
-
 	/**
 	 * @CC_ATTR_HOTPLUG_DISABLED: Hotplug is not supported or disabled.
 	 *
-- 
2.41.0

