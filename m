Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316CB75704F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbjGQXPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbjGQXOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:14:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4109D12D
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:14:46 -0700 (PDT)
Message-ID: <20230717223223.438098301@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689635683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=H6xuaSb8Kv7Un+nSM3Vt2lhh8dacGbRBYIeoXvHjk4U=;
        b=ZJdVRLZPN67L2dDZ8WvxnfDEt6uQADsS5bnFlPHvH3ZRokAIdVrgaEVoGxFE5UMbpwyDpv
        nF4bEllwtYfNdLtVwXJ6jaBIatetjaRvX0m4A7FoTO/ZECJiJRRvxpwgxmGj9MMqZa4cYA
        N8tyvOa5T46kp31qUnrrsWwKICmDRC/lUQ5iXXNiIS1alfimY4XPDxpGeqyqG00EQUVMay
        yoQkOaCtTaaB9W8lw1zqtjQ+3L4fXyHeNOEZxlfNkxDdRlzV6OSf+VEkaITAn288LuxqTm
        TdMk2I16aIMyq1F78nBA7FpBp4ZEMPl45zL1Kcye9hJGHU1LmyqM6EbBdM8+Qg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689635683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=H6xuaSb8Kv7Un+nSM3Vt2lhh8dacGbRBYIeoXvHjk4U=;
        b=fz3+bO0FtQwi+qTH7NfLuuj8FqYv8Q2KtVMXfd2KDhSIJ3inQcicCkuFCsIh1GYw3WqUB5
        STHbbuMJxXOwMeCQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Subject: [patch 06/58] x86/apic: Get rid of hard_smp_processor_id()
References: <20230717223049.327865981@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 18 Jul 2023 01:14:43 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No point in having a wrapper around read_apic_id().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/apic.h    |    6 +++++-
 arch/x86/include/asm/smp.h     |    7 -------
 arch/x86/kernel/apic/apic.c    |    5 -----
 arch/x86/kernel/apic/io_apic.c |    2 +-
 arch/x86/kernel/apic/ipi.c     |    2 +-
 arch/x86/kernel/apic/vector.c  |    2 +-
 arch/x86/kernel/cpu/amd.c      |    2 +-
 arch/x86/kernel/cpu/hygon.c    |    3 ++-
 arch/x86/kernel/smpboot.c      |   10 +++++-----
 arch/x86/kernel/vsmp_64.c      |    2 +-
 10 files changed, 17 insertions(+), 24 deletions(-)

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -503,7 +503,11 @@ extern void default_ioapic_phys_id_map(p
 extern int default_cpu_present_to_apicid(int mps_cpu);
 extern int default_check_phys_apicid_present(int phys_apicid);
 
-#endif /* CONFIG_X86_LOCAL_APIC */
+#else /* CONFIG_X86_LOCAL_APIC */
+
+static inline unsigned int read_apic_id(void) { return 0; }
+
+#endif /* !CONFIG_X86_LOCAL_APIC */
 
 #ifdef CONFIG_SMP
 void apic_smt_update(void);
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -185,13 +185,6 @@ static inline struct cpumask *cpu_llc_sh
 
 extern unsigned disabled_cpus;
 
-#ifdef CONFIG_X86_LOCAL_APIC
-extern int hard_smp_processor_id(void);
-
-#else /* CONFIG_X86_LOCAL_APIC */
-#define hard_smp_processor_id()	0
-#endif /* CONFIG_X86_LOCAL_APIC */
-
 #ifdef CONFIG_DEBUG_NMI_SELFTEST
 extern void nmi_selftest(void);
 #else
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2562,11 +2562,6 @@ int generic_processor_info(int apicid, i
 	return cpu;
 }
 
-int hard_smp_processor_id(void)
-{
-	return read_apic_id();
-}
-
 void __irq_msi_compose_msg(struct irq_cfg *cfg, struct msi_msg *msg,
 			   bool dmar)
 {
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2095,7 +2095,7 @@ static inline void __init unlock_ExtINT_
 	entry0 = ioapic_read_entry(apic, pin);
 	clear_IO_APIC_pin(apic, pin);
 
-	apic_id = hard_smp_processor_id();
+	apic_id = read_apic_id();
 	memset(&entry1, 0, sizeof(entry1));
 
 	entry1.dest_mode_logical	= true;
--- a/arch/x86/kernel/apic/ipi.c
+++ b/arch/x86/kernel/apic/ipi.c
@@ -320,7 +320,7 @@ int safe_smp_processor_id(void)
 	if (!boot_cpu_has(X86_FEATURE_APIC))
 		return 0;
 
-	apicid = hard_smp_processor_id();
+	apicid = read_apic_id();
 	if (apicid == BAD_APICID)
 		return 0;
 
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -1150,7 +1150,7 @@ static void __init print_local_APIC(void
 	u64 icr;
 
 	pr_debug("printing local APIC contents on CPU#%d/%d:\n",
-		 smp_processor_id(), hard_smp_processor_id());
+		 smp_processor_id(), read_apic_id());
 	v = apic_read(APIC_ID);
 	pr_info("... APIC ID:      %08x (%01x)\n", v, read_apic_id());
 	v = apic_read(APIC_LVR);
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -934,7 +934,7 @@ static void init_amd(struct cpuinfo_x86
 		set_cpu_cap(c, X86_FEATURE_FSRS);
 
 	/* get apicid instead of initial apic id from cpuid */
-	c->apicid = hard_smp_processor_id();
+	c->apicid = read_apic_id();
 
 	/* K6s reports MCEs but don't actually have all the MSRs */
 	if (c->x86 < 6)
--- a/arch/x86/kernel/cpu/hygon.c
+++ b/arch/x86/kernel/cpu/hygon.c
@@ -8,6 +8,7 @@
  */
 #include <linux/io.h>
 
+#include <asm/apic.h>
 #include <asm/cpu.h>
 #include <asm/smp.h>
 #include <asm/numa.h>
@@ -300,7 +301,7 @@ static void init_hygon(struct cpuinfo_x8
 	set_cpu_cap(c, X86_FEATURE_REP_GOOD);
 
 	/* get apicid instead of initial apic id from cpuid */
-	c->apicid = hard_smp_processor_id();
+	c->apicid = read_apic_id();
 
 	/*
 	 * XXX someone from Hygon needs to confirm this DTRT
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1220,11 +1220,11 @@ static void __init smp_sanity_check(void
 	}
 #endif
 
-	if (!physid_isset(hard_smp_processor_id(), phys_cpu_present_map)) {
+	if (!physid_isset(read_apic_id(), phys_cpu_present_map)) {
 		pr_warn("weird, boot CPU (#%d) not listed by the BIOS\n",
-			hard_smp_processor_id());
+			read_apic_id());
 
-		physid_set(hard_smp_processor_id(), phys_cpu_present_map);
+		physid_set(read_apic_id(), phys_cpu_present_map);
 	}
 
 	/*
@@ -1234,7 +1234,7 @@ static void __init smp_sanity_check(void
 	if (!apic->check_phys_apicid_present(boot_cpu_physical_apicid)) {
 		pr_notice("weird, boot CPU (#%d) not listed by the BIOS\n",
 			  boot_cpu_physical_apicid);
-		physid_set(hard_smp_processor_id(), phys_cpu_present_map);
+		physid_set(read_apic_id(), phys_cpu_present_map);
 	}
 	preempt_enable();
 }
@@ -1431,7 +1431,7 @@ early_param("possible_cpus", _setup_poss
 	if (!num_processors) {
 		if (boot_cpu_has(X86_FEATURE_APIC)) {
 			int apicid = boot_cpu_physical_apicid;
-			int cpu = hard_smp_processor_id();
+			int cpu = read_apic_id();
 
 			pr_warn("Boot CPU (id %d) not listed by BIOS\n", cpu);
 
--- a/arch/x86/kernel/vsmp_64.c
+++ b/arch/x86/kernel/vsmp_64.c
@@ -129,7 +129,7 @@ static void __init vsmp_cap_cpus(void)
 
 static int apicid_phys_pkg_id(int initial_apic_id, int index_msb)
 {
-	return hard_smp_processor_id() >> index_msb;
+	return read_apic_id() >> index_msb;
 }
 
 static void vsmp_apic_post_init(void)

