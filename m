Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E53776828
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbjHITMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233420AbjHITMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:12:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BFD26B3;
        Wed,  9 Aug 2023 12:12:21 -0700 (PDT)
Date:   Wed, 09 Aug 2023 19:12:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691608340;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=0voAEnyqqNcB037cLDazQXy6UiUKYafkjrBo9a6P1lQ=;
        b=WE8n5MbdMEbHb/e1idCJadJU+CR38XrRIom0j9HU2PZIMOuDfNHEO7kyo/qg66G42Mcpq6
        4f2aYPwEzu0QRUpJrdZbmGR3yX4xJlgMmBHGykilyAA0HGKj87GIUvgh4tRgtoUJgL2Y3a
        E32e0zMeiSms8oy3S+khHTsvHX5wdXM4Glc2NOEmfkfvRWP97OsxVL9ur+vmKDUAMlDCoo
        fJg4sNcTuiDXrwyPz1e48K/J/LTCayiciSvXF+UGYyWNW7H8e/7wof+v3KZK6FzaygtlTc
        la8IQ5OY5b9NbfxTTcOv6lnpgOLsjSia2TJ6az+yGA0sssOepD3kgEWyQqw9xg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691608340;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=0voAEnyqqNcB037cLDazQXy6UiUKYafkjrBo9a6P1lQ=;
        b=ehYwzGGyL0yobgHyvWqDDnML3Vm9d7ZAe6FP/uk01TNvC1qU0NZtPhH+aEThjlMmKJtEMl
        VOiHF5yiSaQ1eSAA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic/32: Decrapify the def_bigsmp mechanism
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169160833951.27769.17362699614639635999.tip-bot2@tip-bot2>
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

Commit-ID:     79c9a17c16e95e3c9e8646cf869fabea53bf283f
Gitweb:        https://git.kernel.org/tip/79c9a17c16e95e3c9e8646cf869fabea53bf283f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 08 Aug 2023 15:03:56 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 09 Aug 2023 11:58:25 -07:00

x86/apic/32: Decrapify the def_bigsmp mechanism

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

[ dhansen: fix nr_cpu_ids off-by-one in default_setup_apic_routing() ]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Juergen Gross <jgross@suse.com> # Xen PV (dom0 and unpriv. guest)
---
 arch/x86/include/asm/mpspec.h    |  2 +--
 arch/x86/kernel/apic/apic.c      |  3 +++-
 arch/x86/kernel/apic/bigsmp_32.c | 22 ++++++++----------
 arch/x86/kernel/apic/local.h     | 11 +++++++++-
 arch/x86/kernel/apic/probe_32.c  | 35 ++++++++++++++---------------
 arch/x86/kernel/setup.c          |  1 +-
 arch/x86/kernel/smpboot.c        | 37 +-------------------------------
 7 files changed, 41 insertions(+), 70 deletions(-)

diff --git a/arch/x86/include/asm/mpspec.h b/arch/x86/include/asm/mpspec.h
index 5d01bde..f46df83 100644
--- a/arch/x86/include/asm/mpspec.h
+++ b/arch/x86/include/asm/mpspec.h
@@ -23,8 +23,6 @@ extern int pic_mode;
 
 #define MAX_IRQ_SOURCES		256
 
-extern unsigned int def_to_bigsmp;
-
 #else /* CONFIG_X86_64: */
 
 #define MAX_MP_BUSSES		256
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 224dff4..24912b2 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -63,6 +63,8 @@
 #include <asm/irq_regs.h>
 #include <asm/cpu.h>
 
+#include "local.h"
+
 unsigned int num_processors;
 
 unsigned disabled_cpus;
@@ -2420,6 +2422,7 @@ static __init void cpu_set_boot_apic(void)
 {
 	cpuid_to_apicid[0] = boot_cpu_physical_apicid;
 	cpu_update_apic(0, boot_cpu_physical_apicid);
+	x86_32_probe_bigsmp_early();
 }
 
 int generic_processor_info(int apicid)
diff --git a/arch/x86/kernel/apic/bigsmp_32.c b/arch/x86/kernel/apic/bigsmp_32.c
index d19dcf9..a26cb46 100644
--- a/arch/x86/kernel/apic/bigsmp_32.c
+++ b/arch/x86/kernel/apic/bigsmp_32.c
@@ -100,12 +100,7 @@ static const struct dmi_system_id bigsmp_dmi_table[] = {
 
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
@@ -149,14 +144,17 @@ static struct apic apic_bigsmp __ro_after_init = {
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
diff --git a/arch/x86/kernel/apic/local.h b/arch/x86/kernel/apic/local.h
index a997d84..ad96c1a 100644
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
diff --git a/arch/x86/kernel/apic/probe_32.c b/arch/x86/kernel/apic/probe_32.c
index 20d7f57..706a844 100644
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
+	if (nr_cpu_ids > 8 && !xen_pv_domain())
+		apic_bigsmp_force();
 
 	if (apic->setup_apic_routing)
 		apic->setup_apic_routing();
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index a5ef400..779477d 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -114,7 +114,6 @@ static struct resource bss_resource = {
 #ifdef CONFIG_X86_32
 /* CPU data as detected by the assembly code in head_32.S */
 struct cpuinfo_x86 new_cpu_data;
-unsigned int def_to_bigsmp;
 
 struct apm_info apm_info;
 EXPORT_SYMBOL(apm_info);
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index da795f7..df1c5f0 100644
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
@@ -1243,8 +1208,6 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
 {
 	smp_prepare_cpus_common();
 
-	smp_sanity_check();
-
 	switch (apic_intr_mode) {
 	case APIC_PIC:
 	case APIC_VIRTUAL_WIRE_NO_CONFIG:
