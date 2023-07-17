Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49AEF757068
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbjGQXR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjGQXRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:17:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71691AC
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:16:43 -0700 (PDT)
Message-ID: <20230717223224.564567063@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689635713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=rQwiDVrZdKXtkOeCkuU+BAsq9XS3fbn/pUNfphOa6Ug=;
        b=Pim/4LrukbAuWI2R7g6Iki1lM0VXNQWjRthfzaL22Na0tDjjPIfMO5sG/Y6coO6Hx3eb3l
        +umH32CdFdB1Ob8eT0EkEZ3Ze62SiYZ4R1u0D4UYMq4MadwqEqY0I0i/e+O1c4wVJNbrbb
        hEfFbVzsi9TwesIU9bhBMJqLZe9fIIE5b8zKJOn14+aOyjL0Upyl5ok+ay7vPSp6WLyPky
        Q22Uu/FVeLSFid2urWQDQB/I1OWGPUzMhJGSjUvSI/J/ZqsQEPlQWtrW+IQMLLIsAPLli3
        7GGmJw1HB4Mc4gguWxqKhM1y3EV3Ra+Y7tZyMjbmAsFr4L6PW3P1yFYKaXUGtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689635713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=rQwiDVrZdKXtkOeCkuU+BAsq9XS3fbn/pUNfphOa6Ug=;
        b=hzhBJlXwg7x0YxSpbK4V31U/2U+qJdnSGHMqjXU+hC3oXhHjNOl5cN7+sqnSEqcDyf5oMO
        Jf/joeeBgWmmaNAQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Subject: [patch 25/58] x86/apic/32: Decrapify the def_bigsmp mechanism
References: <20230717223049.327865981@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 18 Jul 2023 01:15:13 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the system has more than 8 CPUs then XAPIC and the bigsmp APIC driver is
required. This is ensured via:

  1) Enumerating all possible CPUs up to NR_CPUS

  2) Checking at boot CPU APIC setup time whether the system has more than
     8 CPUs and has an XAPIC.

     If that's the case then it's attempted to install the bigsmp APIC
     driver and a magic variable 'def_to_bigsmp' is set to one.

  3) If that magic variable is set and CONFIG_X86_BIGSMP=n and the system
     has more than 8 CPUs smp_sanity_check() removes all CPUs >= #8 from
     the present and possible mask in the most convoluted way.

This logic is completely broken for the case where the bigsmp driver is
enabled, but not selected due to a command line option specifying the
default APIC. In that case the system boots with default APIC in logical
destination mode and fails to reduce the number of CPUs.

That aside the above which is sprinkled over 3 different places is yet
another piece of art.

It would have been too obvious to check the requirements upfront and limit
nr_cpu_ids _before_ enumerating tons of CPUs and then removing them again.

Implement exactly this. Check the bigsmp requirement when the boot APIC is
registered which happens _before_ ACPI/MPTABLE parsing and limit the number
of CPUs to 8 if it can't be used. Switch it over when the boot CPU apic is
set up if necessary.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/apic/apic.c      |    3 +++
 arch/x86/kernel/apic/bigsmp_32.c |   22 ++++++++++------------
 arch/x86/kernel/apic/local.h     |   11 +++++++++++
 arch/x86/kernel/apic/probe_32.c  |   35 +++++++++++++++++------------------
 arch/x86/kernel/smpboot.c        |   37 -------------------------------------
 5 files changed, 41 insertions(+), 67 deletions(-)

--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -63,6 +63,8 @@
 #include <asm/irq_regs.h>
 #include <asm/cpu.h>
 
+#include "local.h"
+
 unsigned int num_processors;
 
 unsigned disabled_cpus;
@@ -2418,6 +2420,7 @@ static __init void cpu_set_boot_apic(voi
 {
 	cpuid_to_apicid[0] = boot_cpu_physical_apicid;
 	cpu_update_apic(0, boot_cpu_physical_apicid);
+	x86_32_probe_bigsmp_early();
 }
 
 int generic_processor_info(int apicid)
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -100,12 +100,7 @@ static const struct dmi_system_id bigsmp
 
 static int probe_bigsmp(void)
 {
-	if (def_to_bigsmp)
-		dmi_bigsmp = 1;
-	else
-		dmi_check_system(bigsmp_dmi_table);
-
-	return dmi_bigsmp;
+	return dmi_check_system(bigsmp_dmi_table);
 }
 
 static struct apic apic_bigsmp __ro_after_init = {
@@ -149,14 +144,17 @@ static struct apic apic_bigsmp __ro_afte
 	.safe_wait_icr_idle		= native_safe_apic_wait_icr_idle,
 };
 
-void __init generic_bigsmp_probe(void)
+bool __init apic_bigsmp_possible(bool cmdline_override)
 {
-	if (!probe_bigsmp())
-		return;
-
-	apic = &apic_bigsmp;
+	return apic == &apic_bigsmp || !cmdline_override;
+}
 
-	pr_info("Overriding APIC driver with %s\n", apic_bigsmp.name);
+void __init apic_bigsmp_force(void)
+{
+	if (apic != &apic_bigsmp) {
+		apic = &apic_bigsmp;
+		pr_info("Overriding APIC driver with bigsmp\n");
+	}
 }
 
 apic_driver(apic_bigsmp);
--- a/arch/x86/kernel/apic/local.h
+++ b/arch/x86/kernel/apic/local.h
@@ -66,4 +66,15 @@ void default_send_IPI_self(int vector);
 void default_send_IPI_mask_sequence_logical(const struct cpumask *mask, int vector);
 void default_send_IPI_mask_allbutself_logical(const struct cpumask *mask, int vector);
 void default_send_IPI_mask_logical(const struct cpumask *mask, int vector);
+void x86_32_probe_bigsmp_early(void);
+#else
+static inline void x86_32_probe_bigsmp_early(void) { }
+#endif
+
+#ifdef CONFIG_X86_BIGSMP
+bool apic_bigsmp_possible(bool cmdline_selected);
+void apic_bigsmp_force(void);
+#else
+static inline bool apic_bigsmp_possible(bool cmdline_selected) { return false; };
+static inline void apic_bigsmp_force(void) { }
 #endif
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -10,6 +10,8 @@
 #include <linux/errno.h>
 #include <linux/smp.h>
 
+#include <xen/xen.h>
+
 #include <asm/io_apic.h>
 #include <asm/apic.h>
 #include <asm/acpi.h>
@@ -123,36 +125,33 @@ static int __init parse_apic(char *arg)
 }
 early_param("apic", parse_apic);
 
-void __init default_setup_apic_routing(void)
+void __init x86_32_probe_bigsmp_early(void)
 {
-	int version = boot_cpu_apic_version;
+	if (nr_cpu_ids <= 8 || xen_pv_domain())
+		return;
 
-	if (num_possible_cpus() > 8) {
+	if (IS_ENABLED(CONFIG_X86_BIGSMP)) {
 		switch (boot_cpu_data.x86_vendor) {
 		case X86_VENDOR_INTEL:
-			if (!APIC_XAPIC(version)) {
-				def_to_bigsmp = 0;
+			if (!APIC_XAPIC(boot_cpu_apic_version))
 				break;
-			}
 			/* P4 and above */
 			fallthrough;
 		case X86_VENDOR_HYGON:
 		case X86_VENDOR_AMD:
-			def_to_bigsmp = 1;
+			if (apic_bigsmp_possible(cmdline_apic))
+				return;
+			break;
 		}
 	}
+	pr_info("Limiting to 8 possible CPUs\n");
+	set_nr_cpu_ids(8);
+}
 
-#ifdef CONFIG_X86_BIGSMP
-	/*
-	 * This is used to switch to bigsmp mode when
-	 * - There is no apic= option specified by the user
-	 * - generic_apic_probe() has chosen apic_default as the sub_arch
-	 * - we find more than 8 CPUs in acpi LAPIC listing with xAPIC support
-	 */
-
-	if (!cmdline_apic && apic == &apic_default)
-		generic_bigsmp_probe();
-#endif
+void __init default_setup_apic_routing(void)
+{
+	if (nr_cpu_ids >= 8 && !xen_pv_domain())
+		apic_bigsmp_force();
 
 	if (apic->setup_apic_routing)
 		apic->setup_apic_routing();
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1149,41 +1149,6 @@ static __init void disable_smp(void)
 	cpumask_set_cpu(0, topology_die_cpumask(0));
 }
 
-/*
- * Various sanity checks.
- */
-static void __init smp_sanity_check(void)
-{
-	preempt_disable();
-
-#if !defined(CONFIG_X86_BIGSMP) && defined(CONFIG_X86_32)
-	if (def_to_bigsmp && nr_cpu_ids > 8) {
-		unsigned int cpu;
-		unsigned nr;
-
-		pr_warn("More than 8 CPUs detected - skipping them\n"
-			"Use CONFIG_X86_BIGSMP\n");
-
-		nr = 0;
-		for_each_present_cpu(cpu) {
-			if (nr >= 8)
-				set_cpu_present(cpu, false);
-			nr++;
-		}
-
-		nr = 0;
-		for_each_possible_cpu(cpu) {
-			if (nr >= 8)
-				set_cpu_possible(cpu, false);
-			nr++;
-		}
-
-		set_nr_cpu_ids(8);
-	}
-#endif
-	preempt_enable();
-}
-
 static void __init smp_cpu_index_default(void)
 {
 	int i;
@@ -1243,8 +1208,6 @@ void __init native_smp_prepare_cpus(unsi
 {
 	smp_prepare_cpus_common();
 
-	smp_sanity_check();
-
 	switch (apic_intr_mode) {
 	case APIC_PIC:
 	case APIC_VIRTUAL_WIRE_NO_CONFIG:

