Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2FA75F862
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjGXNer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbjGXNea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:34:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6221BCD
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 06:34:08 -0700 (PDT)
Message-ID: <20230724132045.361461564@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690205647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ny7Fxu7g7PBQMTLhRl8hSl0RLxzChrJ0DtIsWugH0fI=;
        b=UYKFq2eVSj6AOmPTSVltR0cAd7r1HY4xZMlg7KasidxrQeHBZT/+kyYoKHIgmneHZsb01q
        7t029ehZZUBnkIhz19oNda3IV4mkrkZkNbPleGevUsTQLpsQMFS8KmW5SskjSQLz04Yf0o
        sIWWfE3+Hpil2wCXH2j6xEzqmBDKA+zwh5H4jnxnByWrDUaB8mhPNDEkijB/OgWT7tPoPr
        3/bvtM+buu4oruNkwgtnqp9oDkdaxG0TRq1+sLLU4AwB0RdXhry6/QR/NFjIbzgny9m3Ad
        O0OEl5oAGZVVAxRyB/tYPrqEE1Zx8tf/XFNDRw+ijRN4NyOQr94IM5Di+PrZdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690205647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ny7Fxu7g7PBQMTLhRl8hSl0RLxzChrJ0DtIsWugH0fI=;
        b=HLzz1DJCmQ830YC+0xiySYwEqQszPcXyt3grCF9HHtD+uTsrzrrDMG8jqywzDpsoVFidja
        RbO45lgaWF8vzZBg==
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
Subject: [patch V2 13/58] x86/apic: Make some APIC init functions bool
References: <20230724131206.500814398@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 24 Jul 2023 15:34:06 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quite some APIC init functions are pure boolean, but use the success = 0,
fail < 0 model. That's confusing as hell when reading through the code.

Convert them to boolean.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/apic.h  |    6 +++---
 arch/x86/kernel/apic/apic.c  |   36 ++++++++++++++++++------------------
 arch/x86/kernel/devicetree.c |    2 +-
 3 files changed, 22 insertions(+), 22 deletions(-)

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -135,12 +135,12 @@ extern void setup_secondary_APIC_clock(v
 extern void lapic_update_tsc_freq(void);
 
 #ifdef CONFIG_X86_64
-static inline int apic_force_enable(unsigned long addr)
+static inline bool apic_force_enable(unsigned long addr)
 {
-	return -1;
+	return false;
 }
 #else
-extern int apic_force_enable(unsigned long addr);
+extern bool apic_force_enable(unsigned long addr);
 #endif
 
 extern void apic_ap_setup(void);
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2000,19 +2000,19 @@ void __init enable_IR_x2apic(void)
  * On AMD64 we trust the BIOS - if it says no APIC it is likely
  * not correctly set up (usually the APIC timer won't work etc.)
  */
-static int __init detect_init_APIC(void)
+static bool __init detect_init_APIC(void)
 {
 	if (!boot_cpu_has(X86_FEATURE_APIC)) {
 		pr_info("No local APIC present\n");
-		return -1;
+		return false;
 	}
 
 	mp_lapic_addr = APIC_DEFAULT_PHYS_BASE;
-	return 0;
+	return true;
 }
 #else
 
-static int __init apic_verify(void)
+static bool __init apic_verify(void)
 {
 	u32 features, h, l;
 
@@ -2023,7 +2023,7 @@ static int __init apic_verify(void)
 	features = cpuid_edx(1);
 	if (!(features & (1 << X86_FEATURE_APIC))) {
 		pr_warn("Could not enable APIC!\n");
-		return -1;
+		return false;
 	}
 	set_cpu_cap(&boot_cpu_data, X86_FEATURE_APIC);
 	mp_lapic_addr = APIC_DEFAULT_PHYS_BASE;
@@ -2036,15 +2036,15 @@ static int __init apic_verify(void)
 	}
 
 	pr_info("Found and enabled local APIC!\n");
-	return 0;
+	return true;
 }
 
-int __init apic_force_enable(unsigned long addr)
+bool __init apic_force_enable(unsigned long addr)
 {
 	u32 h, l;
 
 	if (apic_is_disabled)
-		return -1;
+		return false;
 
 	/*
 	 * Some BIOSes disable the local APIC in the APIC_BASE
@@ -2067,11 +2067,11 @@ int __init apic_force_enable(unsigned lo
 /*
  * Detect and initialize APIC
  */
-static int __init detect_init_APIC(void)
+static bool __init detect_init_APIC(void)
 {
 	/* Disabled by kernel option? */
 	if (apic_is_disabled)
-		return -1;
+		return false;
 
 	switch (boot_cpu_data.x86_vendor) {
 	case X86_VENDOR_AMD:
@@ -2098,22 +2098,22 @@ static int __init detect_init_APIC(void)
 		if (!force_enable_local_apic) {
 			pr_info("Local APIC disabled by BIOS -- "
 				"you can enable it with \"lapic\"\n");
-			return -1;
+			return false;
 		}
-		if (apic_force_enable(APIC_DEFAULT_PHYS_BASE))
-			return -1;
+		if (!apic_force_enable(APIC_DEFAULT_PHYS_BASE))
+			return false;
 	} else {
-		if (apic_verify())
-			return -1;
+		if (!apic_verify())
+			return false;
 	}
 
 	apic_pm_activate();
 
-	return 0;
+	return true;
 
 no_apic:
 	pr_info("No local APIC present or hardware disabled\n");
-	return -1;
+	return false;
 }
 #endif
 
@@ -2129,7 +2129,7 @@ void __init init_apic_mappings(void)
 		return;
 
 	/* If no local APIC can be found return early */
-	if (!smp_found_config && detect_init_APIC()) {
+	if (!smp_found_config && !detect_init_APIC()) {
 		/* lets NOP'ify apic operations */
 		pr_info("APIC: disable apic facility\n");
 		apic_disable();
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -158,7 +158,7 @@ static void __init dtb_lapic_setup(void)
 	/* Did the boot loader setup the local APIC ? */
 	if (!boot_cpu_has(X86_FEATURE_APIC)) {
 		/* Try force enabling, which registers the APIC address */
-		if (apic_force_enable(lapic_addr))
+		if (!apic_force_enable(lapic_addr))
 			return;
 	} else {
 		register_lapic_address(lapic_addr);

