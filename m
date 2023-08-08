Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A38773E98
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbjHHQcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbjHHQbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:31:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6621395D;
        Tue,  8 Aug 2023 08:51:43 -0700 (PDT)
Date:   Tue, 08 Aug 2023 08:43:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691484238;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bl3OGdQdGVJVuKLHC3VSjek7fCAi+BdoSyqXZZHJHG8=;
        b=GhUw5HQLlEZyIWqcTh6Ld3JolsUp3GI0UFYaunfbizaH8ul18d9+el4u9cRMmEsV7od5AU
        vJRmg16AbZkWgX+Xlw2x+X2RPKcrcgyc4F0MrlGMR8Ir/D0h1nKiOXSi0wEa074l2d/py8
        Upiq2DcsWH+q6xG/rGIlFtz4oaja0DCQWpRm56BJdeACXKwsKcvjrCOhGuj1pGgQjXSDIi
        1Q+ZomYknWwfYBXCTmdtl8ld+wjICPdqZIP8xpJHI7uk6uO+EUMUGI2ul6u+t+N/DSP23u
        2ZHcGrKeAKbT9rhVpOEOsOy+WMWZk7He1L6rpvtYj48n6I1zCzZzqmHE4b42+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691484238;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bl3OGdQdGVJVuKLHC3VSjek7fCAi+BdoSyqXZZHJHG8=;
        b=a6XQaXoZT3s3WD+Up144FdQyucSw2iwWrRxBPogJl19ySVLzg9BlZo3oQeFjJRDZLyKzwr
        NeWYXUlXPdIA3GCA==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/efistub: Perform SNP feature test while running
 in the firmware
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230807162720.545787-23-ardb@kernel.org>
References: <20230807162720.545787-23-ardb@kernel.org>
MIME-Version: 1.0
Message-ID: <169148423806.27769.4186073114311056791.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     31c77a50992e8dd136feed7b67073bb5f1f978cc
Gitweb:        https://git.kernel.org/tip/31c77a50992e8dd136feed7b67073bb5f1f978cc
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Mon, 07 Aug 2023 18:27:19 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 07 Aug 2023 21:03:53 +02:00

x86/efistub: Perform SNP feature test while running in the firmware

Before refactoring the EFI stub boot flow to avoid the legacy bare metal
decompressor, duplicate the SNP feature check in the EFI stub before
handing over to the kernel proper.

The SNP feature check can be performed while running under the EFI boot
services, which means it can force the boot to fail gracefully and
return an error to the bootloader if the loaded kernel does not
implement support for all the features that the hypervisor enabled.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230807162720.545787-23-ardb@kernel.org
---
 arch/x86/boot/compressed/sev.c          | 112 +++++++++++++----------
 arch/x86/include/asm/sev.h              |   4 +-
 drivers/firmware/efi/libstub/x86-stub.c |  17 +++-
 3 files changed, 87 insertions(+), 46 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index c3e343b..199155b 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -367,20 +367,25 @@ static void enforce_vmpl0(void)
  */
 #define SNP_FEATURES_PRESENT (0)
 
+u64 snp_get_unsupported_features(u64 status)
+{
+	if (!(status & MSR_AMD64_SEV_SNP_ENABLED))
+		return 0;
+
+	return status & SNP_FEATURES_IMPL_REQ & ~SNP_FEATURES_PRESENT;
+}
+
 void snp_check_features(void)
 {
 	u64 unsupported;
 
-	if (!(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
-		return;
-
 	/*
 	 * Terminate the boot if hypervisor has enabled any feature lacking
 	 * guest side implementation. Pass on the unsupported features mask through
 	 * EXIT_INFO_2 of the GHCB protocol so that those features can be reported
 	 * as part of the guest boot failure.
 	 */
-	unsupported = sev_status & SNP_FEATURES_IMPL_REQ & ~SNP_FEATURES_PRESENT;
+	unsupported = snp_get_unsupported_features(sev_status);
 	if (unsupported) {
 		if (ghcb_version < 2 || (!boot_ghcb && !early_setup_ghcb()))
 			sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
@@ -390,35 +395,22 @@ void snp_check_features(void)
 	}
 }
 
-void sev_enable(struct boot_params *bp)
+/*
+ * sev_check_cpu_support - Check for SEV support in the CPU capabilities
+ *
+ * Returns < 0 if SEV is not supported, otherwise the position of the
+ * encryption bit in the page table descriptors.
+ */
+static int sev_check_cpu_support(void)
 {
 	unsigned int eax, ebx, ecx, edx;
-	struct msr m;
-	bool snp;
-
-	/*
-	 * bp->cc_blob_address should only be set by boot/compressed kernel.
-	 * Initialize it to 0 to ensure that uninitialized values from
-	 * buggy bootloaders aren't propagated.
-	 */
-	if (bp)
-		bp->cc_blob_address = 0;
-
-	/*
-	 * Do an initial SEV capability check before snp_init() which
-	 * loads the CPUID page and the same checks afterwards are done
-	 * without the hypervisor and are trustworthy.
-	 *
-	 * If the HV fakes SEV support, the guest will crash'n'burn
-	 * which is good enough.
-	 */
 
 	/* Check for the SME/SEV support leaf */
 	eax = 0x80000000;
 	ecx = 0;
 	native_cpuid(&eax, &ebx, &ecx, &edx);
 	if (eax < 0x8000001f)
-		return;
+		return -ENODEV;
 
 	/*
 	 * Check for the SME/SEV feature:
@@ -433,6 +425,35 @@ void sev_enable(struct boot_params *bp)
 	native_cpuid(&eax, &ebx, &ecx, &edx);
 	/* Check whether SEV is supported */
 	if (!(eax & BIT(1)))
+		return -ENODEV;
+
+	return ebx & 0x3f;
+}
+
+void sev_enable(struct boot_params *bp)
+{
+	struct msr m;
+	int bitpos;
+	bool snp;
+
+	/*
+	 * bp->cc_blob_address should only be set by boot/compressed kernel.
+	 * Initialize it to 0 to ensure that uninitialized values from
+	 * buggy bootloaders aren't propagated.
+	 */
+	if (bp)
+		bp->cc_blob_address = 0;
+
+	/*
+	 * Do an initial SEV capability check before snp_init() which
+	 * loads the CPUID page and the same checks afterwards are done
+	 * without the hypervisor and are trustworthy.
+	 *
+	 * If the HV fakes SEV support, the guest will crash'n'burn
+	 * which is good enough.
+	 */
+
+	if (sev_check_cpu_support() < 0)
 		return;
 
 	/*
@@ -443,26 +464,8 @@ void sev_enable(struct boot_params *bp)
 
 	/* Now repeat the checks with the SNP CPUID table. */
 
-	/* Recheck the SME/SEV support leaf */
-	eax = 0x80000000;
-	ecx = 0;
-	native_cpuid(&eax, &ebx, &ecx, &edx);
-	if (eax < 0x8000001f)
-		return;
-
-	/*
-	 * Recheck for the SME/SEV feature:
-	 *   CPUID Fn8000_001F[EAX]
-	 *   - Bit 0 - Secure Memory Encryption support
-	 *   - Bit 1 - Secure Encrypted Virtualization support
-	 *   CPUID Fn8000_001F[EBX]
-	 *   - Bits 5:0 - Pagetable bit position used to indicate encryption
-	 */
-	eax = 0x8000001f;
-	ecx = 0;
-	native_cpuid(&eax, &ebx, &ecx, &edx);
-	/* Check whether SEV is supported */
-	if (!(eax & BIT(1))) {
+	bitpos = sev_check_cpu_support();
+	if (bitpos < 0) {
 		if (snp)
 			error("SEV-SNP support indicated by CC blob, but not CPUID.");
 		return;
@@ -494,7 +497,24 @@ void sev_enable(struct boot_params *bp)
 	if (snp && !(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
 		error("SEV-SNP supported indicated by CC blob, but not SEV status MSR.");
 
-	sme_me_mask = BIT_ULL(ebx & 0x3f);
+	sme_me_mask = BIT_ULL(bitpos);
+}
+
+/*
+ * sev_get_status - Retrieve the SEV status mask
+ *
+ * Returns 0 if the CPU is not SEV capable, otherwise the value of the
+ * AMD64_SEV MSR.
+ */
+u64 sev_get_status(void)
+{
+	struct msr m;
+
+	if (sev_check_cpu_support() < 0)
+		return 0;
+
+	boot_rdmsr(MSR_AMD64_SEV, &m);
+	return m.q;
 }
 
 /* Search for Confidential Computing blob in the EFI config table. */
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 66c8067..b97d239 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -210,6 +210,8 @@ bool snp_init(struct boot_params *bp);
 void __init __noreturn snp_abort(void);
 int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct snp_guest_request_ioctl *rio);
 void snp_accept_memory(phys_addr_t start, phys_addr_t end);
+u64 snp_get_unsupported_features(u64 status);
+u64 sev_get_status(void);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -235,6 +237,8 @@ static inline int snp_issue_guest_request(u64 exit_code, struct snp_req_data *in
 }
 
 static inline void snp_accept_memory(phys_addr_t start, phys_addr_t end) { }
+static inline u64 snp_get_unsupported_features(u64 status) { return 0; }
+static inline u64 sev_get_status(void) { return 0; }
 #endif
 
 #endif
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index acb1c65..b4685da 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -15,6 +15,7 @@
 #include <asm/setup.h>
 #include <asm/desc.h>
 #include <asm/boot.h>
+#include <asm/sev.h>
 
 #include "efistub.h"
 #include "x86-stub.h"
@@ -790,6 +791,19 @@ static efi_status_t exit_boot(struct boot_params *boot_params, void *handle)
 	return EFI_SUCCESS;
 }
 
+static bool have_unsupported_snp_features(void)
+{
+	u64 unsupported;
+
+	unsupported = snp_get_unsupported_features(sev_get_status());
+	if (unsupported) {
+		efi_err("Unsupported SEV-SNP features detected: 0x%llx\n",
+			unsupported);
+		return true;
+	}
+	return false;
+}
+
 static void __noreturn enter_kernel(unsigned long kernel_addr,
 				    struct boot_params *boot_params)
 {
@@ -820,6 +834,9 @@ void __noreturn efi_stub_entry(efi_handle_t handle,
 	if (efi_system_table->hdr.signature != EFI_SYSTEM_TABLE_SIGNATURE)
 		efi_exit(handle, EFI_INVALID_PARAMETER);
 
+	if (have_unsupported_snp_features())
+		efi_exit(handle, EFI_UNSUPPORTED);
+
 	if (IS_ENABLED(CONFIG_EFI_DXE_MEM_ATTRIBUTES)) {
 		efi_dxe_table = get_efi_config_table(EFI_DXE_SERVICES_TABLE_GUID);
 		if (efi_dxe_table &&
