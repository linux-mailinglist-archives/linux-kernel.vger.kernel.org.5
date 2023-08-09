Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD66776845
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjHITNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233483AbjHITM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:12:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CB0269D;
        Wed,  9 Aug 2023 12:12:35 -0700 (PDT)
Date:   Wed, 09 Aug 2023 19:12:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691608344;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=w9z14t1hh50IRFMjctaHzzONk5fbNGxc3UQQoEuosrk=;
        b=XEj7DTVSszUZlbDDWZRqJoCNbss2dctlz8c2Ghz8J/YpSm7B2BDfst+D7CMURDcndewdoG
        3zj3Hq8edb9CQ+quOimh4hpi44ziiVRm1KOX4nUIHMDZgAMEk+fg6etLWvAIOx7eQ+OjO5
        Ogw6T+fEXoQSSrbw6GlaSLD04/gNQ6o7jpRfZ7ontix5VUuu2k75+LdNqLIyoIKeGytyd5
        v5UxJKHQfHgFtI04WcFWu1S7Xp2Q89ATCfY+GSdcPr0GJiLmTet681hbT9fVt15S6xPZby
        qvovAsTBv9cv9MZ25NhE4ghrQJO8MbGK5xNgCml1JCDYAx2cXCEE59xVRj8UEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691608344;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=w9z14t1hh50IRFMjctaHzzONk5fbNGxc3UQQoEuosrk=;
        b=gjAupvTTprg9NI4+OIbyV8nLKHzQE3sUhil0H1nJZydcVtufW/y8s3iO5zmMcLbbxKj1r/
        T2cNPOiVhF0TaGDQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Sanitize APIC address setup
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169160834403.27769.11039492690551665143.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     81287ad65da5b82155f2eca03d81db5512802d16
Gitweb:        https://git.kernel.org/tip/81287ad65da5b82155f2eca03d81db5512802d16
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:03:49 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 11:58:20 -07:00

x86/apic: Sanitize APIC address setup

Convert places which just write mp_lapic_addr and let them register the
local APIC address directly instead of relying on magic other code to do
so.

Add a WARN_ON() into register_lapic_address() which is raised when
register_lapic_address() is invoked more than once during boot.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Juergen Gross <jgross@suse.com> # Xen PV (dom0 and unpriv. guest)
---
 arch/x86/include/asm/mpspec.h |  1 -
 arch/x86/kernel/apic/apic.c   | 29 ++++++++++-------------------
 arch/x86/kernel/mpparse.c     | 11 ++---------
 3 files changed, 12 insertions(+), 29 deletions(-)

diff --git a/arch/x86/include/asm/mpspec.h b/arch/x86/include/asm/mpspec.h
index 190d306..5d01bde 100644
--- a/arch/x86/include/asm/mpspec.h
+++ b/arch/x86/include/asm/mpspec.h
@@ -41,7 +41,6 @@ extern DECLARE_BITMAP(mp_bus_not_pci, MAX_MP_BUSSES);
 
 extern unsigned int boot_cpu_physical_apicid;
 extern u8 boot_cpu_apic_version;
-extern unsigned long mp_lapic_addr;
 
 #ifdef CONFIG_X86_LOCAL_APIC
 extern int smp_found_config;
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 45ae178..84ff5b2 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -172,7 +172,7 @@ static __init int setup_apicpmtimer(char *s)
 __setup("apicpmtimer", setup_apicpmtimer);
 #endif
 
-unsigned long mp_lapic_addr __ro_after_init;
+static unsigned long mp_lapic_addr __ro_after_init;
 bool apic_is_disabled __ro_after_init;
 /* Disable local APIC timer from the kernel commandline or via dmi quirk */
 static int disable_apic_timer __initdata;
@@ -2009,12 +2009,12 @@ static bool __init detect_init_APIC(void)
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
@@ -2063,7 +2063,7 @@ bool __init apic_force_enable(unsigned long addr)
 			enabled_via_apicbase = 1;
 		}
 	}
-	return apic_verify();
+	return apic_verify(addr);
 }
 
 /*
@@ -2105,7 +2105,7 @@ static bool __init detect_init_APIC(void)
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
diff --git a/arch/x86/kernel/mpparse.c b/arch/x86/kernel/mpparse.c
index 333dee2..b223922 100644
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -375,11 +375,6 @@ static inline void __init construct_default_ISA_mptable(int mpc_default_type)
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
@@ -520,10 +515,8 @@ void __init default_get_smp_config(unsigned int early)
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
 
