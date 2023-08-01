Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7600E76B234
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234070AbjHAKry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233814AbjHAKrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:47:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E466010EA
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 03:47:01 -0700 (PDT)
Message-ID: <20230801103815.982686364@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690886820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=855ZylECG6DnmhUb4ZnT7LjFoXWMj2iP75o58u/ioxI=;
        b=pTCyVBX29M3GOiFt59+IXxKYeqR/I67qvEB3ogvwJHvgo1vR5ALoFqn8DhOptKU7amoouY
        KROwf67itVrS6IjJBS03Dd3MMb2h9IhET4B/0BAKvZp/W+74ptemTjYjeQgfim/Tmw+pz0
        Jb5PiNfHfHXT74pU5ORuDVLPQb9Y5rXv1Qr9fdoUGqMCsV33+aZTeTgHwSFgJ3L2WmvX5V
        L2muTzsXyTCwGCKTTabJh53dlWSxy0FwKy/cV9PGlq730qDc6V8jFn5xSvjJkDECrgr3k6
        SfTggafIxJgrWNTOe02wl5KId1BrEvTW7uI6rnLuyZTFXTfAuMNVI0qRC9SZ+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690886820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=855ZylECG6DnmhUb4ZnT7LjFoXWMj2iP75o58u/ioxI=;
        b=bUHVRteSCjoZrZuEDmFj0kyRe92hF6caXnfPMeisxnnloOmimG02wEaZxRj4erBW2pEVmw
        Qaj96anRp4QVryAw==
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
Subject: [patch V3 15/60] x86/apic: Sanitize APIC address setup
References: <20230801103042.936020332@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  1 Aug 2023 12:46:59 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert places which just write mp_lapic_addr and let them register the
local APIC address directly instead of relying on magic other code to do
so.

Add a WARN_ON() into register_lapic_address() which is raised when
register_lapic_address() is invoked more than once during boot.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/mpspec.h |    1 -
 arch/x86/kernel/apic/apic.c   |   29 ++++++++++-------------------
 arch/x86/kernel/mpparse.c     |   11 ++---------
 3 files changed, 12 insertions(+), 29 deletions(-)

--- a/arch/x86/include/asm/mpspec.h
+++ b/arch/x86/include/asm/mpspec.h
@@ -41,7 +41,6 @@ extern DECLARE_BITMAP(mp_bus_not_pci, MA
 
 extern unsigned int boot_cpu_physical_apicid;
 extern u8 boot_cpu_apic_version;
-extern unsigned long mp_lapic_addr;
 
 #ifdef CONFIG_X86_LOCAL_APIC
 extern int smp_found_config;
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -172,7 +172,7 @@ static __init int setup_apicpmtimer(char
 __setup("apicpmtimer", setup_apicpmtimer);
 #endif
 
-unsigned long mp_lapic_addr __ro_after_init;
+static unsigned long mp_lapic_addr __ro_after_init;
 bool apic_is_disabled __ro_after_init;
 /* Disable local APIC timer from the kernel commandline or via dmi quirk */
 static int disable_apic_timer __initdata;
@@ -2009,12 +2009,12 @@ static bool __init detect_init_APIC(void
 		return false;
 	}
 
-	mp_lapic_addr = APIC_DEFAULT_PHYS_BASE;
+	register_lapic_address(APIC_DEFAULT_PHYS_BASE);
 	return true;
 }
 #else
 
-static bool __init apic_verify(void)
+static bool __init apic_verify(unsigned long addr)
 {
 	u32 features, h, l;
 
@@ -2028,15 +2028,15 @@ static bool __init apic_verify(void)
 		return false;
 	}
 	set_cpu_cap(&boot_cpu_data, X86_FEATURE_APIC);
-	mp_lapic_addr = APIC_DEFAULT_PHYS_BASE;
 
 	/* The BIOS may have set up the APIC at some other address */
 	if (boot_cpu_data.x86 >= 6) {
 		rdmsr(MSR_IA32_APICBASE, l, h);
 		if (l & MSR_IA32_APICBASE_ENABLE)
-			mp_lapic_addr = l & MSR_IA32_APICBASE_BASE;
+			addr = l & MSR_IA32_APICBASE_BASE;
 	}
 
+	register_lapic_address(addr);
 	pr_info("Found and enabled local APIC!\n");
 	return true;
 }
@@ -2063,7 +2063,7 @@ bool __init apic_force_enable(unsigned l
 			enabled_via_apicbase = 1;
 		}
 	}
-	return apic_verify();
+	return apic_verify(addr);
 }
 
 /*
@@ -2105,7 +2105,7 @@ static bool __init detect_init_APIC(void
 		if (!apic_force_enable(APIC_DEFAULT_PHYS_BASE))
 			return false;
 	} else {
-		if (!apic_verify())
+		if (!apic_verify(APIC_DEFAULT_PHYS_BASE))
 			return false;
 	}
 
@@ -2130,27 +2130,16 @@ void __init init_apic_mappings(void)
 	if (x2apic_mode)
 		return;
 
-	/* If no local APIC can be found return early */
 	if (!smp_found_config && !detect_init_APIC()) {
-		/* lets NOP'ify apic operations */
 		pr_info("APIC: disable apic facility\n");
 		apic_disable();
-	} else {
-		apic_phys = mp_lapic_addr;
-
-		/*
-		 * If the system has ACPI MADT tables or MP info, the LAPIC
-		 * address is already registered.
-		 */
-		if (!acpi_lapic && !smp_found_config)
-			register_lapic_address(apic_phys);
 	}
 }
 
 static __init void apic_set_fixmap(void)
 {
 	set_fixmap_nocache(FIX_APIC_BASE, mp_lapic_addr);
-	apic_mmio_base = APIC_BASE;
+	apic_phys = apic_mmio_base = APIC_BASE;
 	apic_printk(APIC_VERBOSE, "mapped APIC to %16lx (%16lx)\n",
 		    apic_mmio_base, mp_lapic_addr);
 	apic_read_boot_cpu_id(false);
@@ -2158,6 +2147,8 @@ static __init void apic_set_fixmap(void)
 
 void __init register_lapic_address(unsigned long address)
 {
+	/* This should only happen once */
+	WARN_ON_ONCE(mp_lapic_addr);
 	mp_lapic_addr = address;
 
 	if (!x2apic_mode)
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -378,11 +378,6 @@ static inline void __init construct_defa
 	int i;
 
 	/*
-	 * local APIC has default address
-	 */
-	mp_lapic_addr = APIC_DEFAULT_PHYS_BASE;
-
-	/*
 	 * 2 CPUs, numbered 0 & 1.
 	 */
 	processor.type = MP_PROCESSOR;
@@ -523,10 +518,8 @@ void __init default_get_smp_config(unsig
 	 */
 	if (mpf->feature1) {
 		if (early) {
-			/*
-			 * local APIC has default address
-			 */
-			mp_lapic_addr = APIC_DEFAULT_PHYS_BASE;
+			/* Local APIC has default address */
+			register_lapic_address(APIC_DEFAULT_PHYS_BASE);
 			goto out;
 		}
 

