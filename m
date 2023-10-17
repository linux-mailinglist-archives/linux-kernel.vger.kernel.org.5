Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15CFD7CCF20
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 23:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344148AbjJQVXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 17:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344159AbjJQVXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 17:23:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B15F9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 14:23:32 -0700 (PDT)
Message-ID: <20231017211722.292291436@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697577811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=3mXXYCmv0bVfMYDZcEO6X7VusLAPyknFMuG5E+/gL3Y=;
        b=UMzh/2po3KoQQqnSV6luxMPgcv444x4N2N/4ZTRckWYVxEFL2VCfk5jhwgeoQmi1toPAnK
        taYhXCK0D1NI7A2UBdB5Kr+Ocgdged/jskGRUUo2mMJNiAgGO2QGWKsQWlA7EzAaNsoffe
        o/77rAUYNMlU3cjhtU4sDLYuwvL/raPveabrkTUVgdUjLZJbxGwLTT3AGX1C168GGE2oc/
        /XbfMir2sYhRpgLZgj7LFPVlgiMA2cglYN8wKsLdiEBrkdfhaKydzabgHCzLSs8ohdQbwR
        fTF5cU1EYQYnfOB8QELImP2w7Dt2BUG1OWl8OIjGmCYmvYVNeBSiif2FSElPqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697577811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=3mXXYCmv0bVfMYDZcEO6X7VusLAPyknFMuG5E+/gL3Y=;
        b=P0F1MWymNHMHaSxSJWrKIHU/uV/2nB6ASFkvWkJEcGt+JlEB+2bcEmTFf16fce202//iIx
        b7o0g/iHUj0VHWAg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>
Subject: [patch V5 06/39] x86/boot/32: Temporarily map initrd for microcode
 loading
References: <20231017200758.877560658@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 17 Oct 2023 23:23:31 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Early microcode loading on 32-bit runs in physical address mode because the
initrd is not covered by the initial page tables. That results in a
horrible mess all over the microcode loader code.

Provide a temporary mapping for the initrd in the initial page tables by
appending it to the actual initial mapping starting with a new PGD or PMD
depending on the configured page table levels ([non-]PAE).

The page table entries are located after _brk_end so they are not
permanently using memory space. The mapping is invalidated right away in
i386_start_kernel() after the early microcode loader has run.

This prepares for removing the physical address mode oddities from all over
the microcode loader code, which in turn allows further cleanups.

Provide the map and unmap code and document the place where the microcode
loader needs to be invoked with a comment.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V5: New patch
---
 arch/x86/include/asm/microcode.h |    2 +
 arch/x86/kernel/head32.c         |   54 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 54 insertions(+), 2 deletions(-)
---
--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -23,6 +23,8 @@ static inline void load_ucode_ap(void) {
 static inline void microcode_bsp_resume(void) { }
 #endif
 
+extern unsigned long initrd_start_early;
+
 #ifdef CONFIG_CPU_SUP_INTEL
 /* Intel specific microcode defines. Public for IFS */
 struct microcode_header_intel {
--- a/arch/x86/kernel/head32.c
+++ b/arch/x86/kernel/head32.c
@@ -29,11 +29,33 @@ static void __init i386_default_early_se
 	x86_init.mpparse.setup_ioapic_ids = setup_ioapic_ids_from_mpc;
 }
 
+#ifdef CONFIG_MICROCODE_INITRD32
+unsigned long __initdata initrd_start_early;
+static pte_t __initdata *initrd_pl2p_start, *initrd_pl2p_end;
+
+static void zap_early_initrd_mapping(void)
+{
+	pte_t *pl2p = initrd_pl2p_start;
+
+	for (; pl2p < initrd_pl2p_end; pl2p++) {
+		*pl2p = (pte_t){ .pte = 0 };
+
+		if (!IS_ENABLED(CONFIG_X86_PAE))
+			*(pl2p + ((PAGE_OFFSET >> PGDIR_SHIFT))) = (pte_t) {.pte = 0};
+	}
+}
+#else
+static inline void zap_early_initrd_mapping(void) { }
+#endif
+
 asmlinkage __visible void __init __noreturn i386_start_kernel(void)
 {
 	/* Make sure IDT is set up before any exception happens */
 	idt_setup_early_handler();
 
+	/* load_ucode_bsp() */
+	zap_early_initrd_mapping();
+
 	cr4_init_shadow();
 
 	sanitize_boot_params(&boot_params);
@@ -107,9 +129,9 @@ static __init __no_stack_protector pte_t
 void __init __no_stack_protector mk_early_pgtbl_32(void)
 {
 	/* Enough space to fit pagetables for the low memory linear map */
-	const unsigned long limit = __pa_nodebug(_end) +
-		(PAGE_TABLE_SIZE(LOWMEM_PAGES) << PAGE_SHIFT);
+	unsigned long limit = __pa_nodebug(_end) + (PAGE_TABLE_SIZE(LOWMEM_PAGES) << PAGE_SHIFT);
 	pte_t pte, *ptep = (pte_t *)__pa_nodebug(__brk_base);
+	struct boot_params __maybe_unused *params;
 	pl2_t *pl2p = (pl2_t *)__pa_nodebug(pl2_base);
 	unsigned long *ptr;
 
@@ -122,4 +144,32 @@ void __init __no_stack_protector mk_earl
 
 	ptr = (unsigned long *)__pa_nodebug(&_brk_end);
 	*ptr = (unsigned long)ptep + PAGE_OFFSET;
+
+#ifdef CONFIG_MICROCODE_INITRD32
+	/* Running on a hypervisor? */
+	if (native_cpuid_ecx(1) & BIT(31))
+		return;
+
+	params = (struct boot_params *)__pa_nodebug(&boot_params);
+	if (!params->hdr.ramdisk_size || !params->hdr.ramdisk_image)
+		return;
+
+	/* Save the virtual start address */
+	ptr = (unsigned long *)__pa_nodebug(&initrd_start_early);
+	*ptr = (pte.pte & PTE_PFN_MASK) + PAGE_OFFSET;
+	*ptr += ((unsigned long)params->hdr.ramdisk_image) & ~PAGE_MASK;
+
+	/* Save PLP2 for cleanup */
+	ptr = (unsigned long *)__pa_nodebug(&initrd_pl2p_start);
+	*ptr = (unsigned long)pl2p + PAGE_OFFSET;
+
+	limit = (unsigned long)params->hdr.ramdisk_image;
+	pte.pte = PTE_IDENT_ATTR | PFN_ALIGN(limit);
+	limit = (unsigned long)params->hdr.ramdisk_image + params->hdr.ramdisk_size;
+
+	init_map(pte, &ptep, &pl2p, limit);
+
+	ptr = (unsigned long *)__pa_nodebug(&initrd_pl2p_end);
+	*ptr = (unsigned long)pl2p + PAGE_OFFSET;
+#endif
 }

