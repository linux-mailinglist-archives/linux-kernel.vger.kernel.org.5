Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD3B75F854
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjGXNeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjGXNdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:33:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8534490
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 06:33:51 -0700 (PDT)
Message-ID: <20230724132044.765449490@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690205630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=N2qRiZb8v2jTNGf2U89OytfeZ4DEwa0WFTfs8zeFafY=;
        b=ZtCMDmh9Xsk2egFLNUn2vGgbVEk/Yifal/hrz/ZQoSBuyqsKUfXL0lBATBBZ43hVRCILtp
        LTRILAYcJgVxctNEZJwdn9unA6++BoXwVgBS90KOxEsJ9/eOJIN3H+FgapGy2coCq74Iei
        JsJC7k/V9IYFJNHKrv6d8Jm6Aj8vAlRH+TklooBm+DUZKZrqHXAamZ+G6ebirULgG5d+rD
        JDiLgGOoA7MlftuQ9rU1ICe7AzYwp3X+QZZPP6dRGukUgsYsgOB3XFXSYZgaccag6TCi+N
        YBVTILKqc6/7C4nEGflDhp6YPxphPPL4du3dGcLEcePMn3ulJj2UJhUrtKP7gA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690205630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=N2qRiZb8v2jTNGf2U89OytfeZ4DEwa0WFTfs8zeFafY=;
        b=mgh5cr12/Iufcc5mWikiuWj8o/ih+wsAA2d5lhFpZdcvNINw6wVHXKRh1RNs9xMRZ7M+FV
        NMBBQx4e7KeOMlCA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Peter Keresztes Schmidt <peter@keresztesschmidt.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch V2 03/58] x86/apic: Rename disable_apic
References: <20230724131206.500814398@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 24 Jul 2023 15:33:49 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It reflects a state and not a command. Make it bool while at it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/apic.h      |    4 ++--
 arch/x86/kernel/apic/apic.c      |   22 +++++++++++-----------
 arch/x86/kernel/apic/apic_noop.c |    6 +++---
 arch/x86/kernel/apic/msi.c       |    2 +-
 arch/x86/kernel/apic/vector.c    |    2 +-
 arch/x86/kernel/setup.c          |    2 +-
 arch/x86/pci/xen.c               |    2 +-
 7 files changed, 20 insertions(+), 20 deletions(-)

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -52,7 +52,7 @@ static inline void generic_apic_probe(vo
 extern int apic_verbosity;
 extern int local_apic_timer_c2_ok;
 
-extern int disable_apic;
+extern bool apic_is_disabled;
 extern unsigned int lapic_timer_period;
 
 extern int cpuid_to_apicid[];
@@ -90,7 +90,7 @@ static inline void default_inquire_remot
  */
 static inline bool apic_from_smp_config(void)
 {
-	return smp_found_config && !disable_apic;
+	return smp_found_config && !apic_is_disabled;
 }
 
 /*
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -180,7 +180,7 @@ static __init int setup_apicpmtimer(char
 #endif
 
 unsigned long mp_lapic_addr __ro_after_init;
-int disable_apic __ro_after_init;
+bool apic_is_disabled __ro_after_init;
 /* Disable local APIC timer from the kernel commandline or via dmi quirk */
 static int disable_apic_timer __initdata;
 /* Local APIC timer works in C2 */
@@ -810,7 +810,7 @@ bool __init apic_needs_pit(void)
 		return true;
 
 	/* Is there an APIC at all or is it disabled? */
-	if (!boot_cpu_has(X86_FEATURE_APIC) || disable_apic)
+	if (!boot_cpu_has(X86_FEATURE_APIC) || apic_is_disabled)
 		return true;
 
 	/*
@@ -1299,7 +1299,7 @@ enum apic_intr_mode_id apic_intr_mode __
 static int __init __apic_intr_mode_select(void)
 {
 	/* Check kernel option */
-	if (disable_apic) {
+	if (apic_is_disabled) {
 		pr_info("APIC disabled via kernel command line\n");
 		return APIC_PIC;
 	}
@@ -1308,7 +1308,7 @@ static int __init __apic_intr_mode_selec
 #ifdef CONFIG_X86_64
 	/* On 64-bit, the APIC must be integrated, Check local APIC only */
 	if (!boot_cpu_has(X86_FEATURE_APIC)) {
-		disable_apic = 1;
+		apic_is_disabled = true;
 		pr_info("APIC disabled by BIOS\n");
 		return APIC_PIC;
 	}
@@ -1317,14 +1317,14 @@ static int __init __apic_intr_mode_selec
 
 	/* Neither 82489DX nor integrated APIC ? */
 	if (!boot_cpu_has(X86_FEATURE_APIC) && !smp_found_config) {
-		disable_apic = 1;
+		apic_is_disabled = true;
 		return APIC_PIC;
 	}
 
 	/* If the BIOS pretends there is an integrated APIC ? */
 	if (!boot_cpu_has(X86_FEATURE_APIC) &&
 		APIC_INTEGRATED(boot_cpu_apic_version)) {
-		disable_apic = 1;
+		apic_is_disabled = true;
 		pr_err(FW_BUG "Local APIC %d not detected, force emulation\n",
 				       boot_cpu_physical_apicid);
 		return APIC_PIC;
@@ -1567,7 +1567,7 @@ static void setup_local_APIC(void)
 	int cpu = smp_processor_id();
 	unsigned int value;
 
-	if (disable_apic) {
+	if (apic_is_disabled) {
 		disable_ioapic_support();
 		return;
 	}
@@ -1943,7 +1943,7 @@ void __init check_x2apic(void)
 	pr_err("Kernel does not support x2APIC, please recompile with CONFIG_X86_X2APIC.\n");
 	pr_err("Disabling APIC, expect reduced performance and functionality.\n");
 
-	disable_apic = 1;
+	apic_is_disabled = true;
 	setup_clear_cpu_cap(X86_FEATURE_APIC);
 }
 
@@ -2037,7 +2037,7 @@ int __init apic_force_enable(unsigned lo
 {
 	u32 h, l;
 
-	if (disable_apic)
+	if (apic_is_disabled)
 		return -1;
 
 	/*
@@ -2064,7 +2064,7 @@ int __init apic_force_enable(unsigned lo
 static int __init detect_init_APIC(void)
 {
 	/* Disabled by kernel option? */
-	if (disable_apic)
+	if (apic_is_disabled)
 		return -1;
 
 	switch (boot_cpu_data.x86_vendor) {
@@ -2919,7 +2919,7 @@ int apic_is_clustered_box(void)
  */
 static int __init setup_disableapic(char *arg)
 {
-	disable_apic = 1;
+	apic_is_disabled = true;
 	setup_clear_cpu_cap(X86_FEATURE_APIC);
 	return 0;
 }
--- a/arch/x86/kernel/apic/apic_noop.c
+++ b/arch/x86/kernel/apic/apic_noop.c
@@ -71,13 +71,13 @@ static int noop_apic_id_registered(void)
 
 static u32 noop_apic_read(u32 reg)
 {
-	WARN_ON_ONCE(boot_cpu_has(X86_FEATURE_APIC) && !disable_apic);
+	WARN_ON_ONCE(boot_cpu_has(X86_FEATURE_APIC) && !apic_is_disabled);
 	return 0;
 }
 
-static void noop_apic_write(u32 reg, u32 v)
+static void noop_apic_write(u32 reg, u32 val)
 {
-	WARN_ON_ONCE(boot_cpu_has(X86_FEATURE_APIC) && !disable_apic);
+	WARN_ON_ONCE(boot_cpu_has(X86_FEATURE_APIC) && !apic_is_disabled);
 }
 
 #ifdef CONFIG_X86_32
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -269,7 +269,7 @@ static const struct msi_parent_ops x86_v
 
 struct irq_domain * __init native_create_pci_msi_domain(void)
 {
-	if (disable_apic)
+	if (apic_is_disabled)
 		return NULL;
 
 	x86_vector_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -536,7 +536,7 @@ static int x86_vector_alloc_irqs(struct
 	struct irq_data *irqd;
 	int i, err, node;
 
-	if (disable_apic)
+	if (apic_is_disabled)
 		return -ENXIO;
 
 	/*
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1020,7 +1020,7 @@ void __init setup_arch(char **cmdline_p)
 
 	if (acpi_mps_check()) {
 #ifdef CONFIG_X86_LOCAL_APIC
-		disable_apic = 1;
+		apic_is_disabled = true;
 #endif
 		setup_clear_cpu_cap(X86_FEATURE_APIC);
 	}
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -517,7 +517,7 @@ int __init pci_xen_init(void)
 #ifdef CONFIG_PCI_MSI
 static void __init xen_hvm_msi_init(void)
 {
-	if (!disable_apic) {
+	if (!apic_is_disabled) {
 		/*
 		 * If hardware supports (x2)APIC virtualization (as indicated
 		 * by hypervisor's leaf 4) then we don't need to use pirqs/

