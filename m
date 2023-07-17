Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14D2757053
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjGQXPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbjGQXPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:15:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855AA1705
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:14:54 -0700 (PDT)
Message-ID: <20230717223223.737031480@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689635691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=OZddm0qMa+fCQ/gmjuY/HZsd/K8NL9drgmrzgYZMbN0=;
        b=DTHVIP8iXYhNrFjvw9p/C2zr4c7ot1d9tCd6POZvTETzn0MTNiS5u7DZwMdZoIoYAOmw1O
        9NMHAnqpb4W/lZlutMAxq/SbEPbQU2I+TqWaAExtQngcEsNZuw1XYcswpck1epK5BwrM7P
        oias9id99krUtB0tUxmV6y+NjT6C/ejpLsTz2cPmwQTww96bilAv/rghpHIV5fhjWB4IhX
        gVOPKswnR5rOn0qMfkGw9O+i4JPLPgOHwCesez9uaBQ47nb/iljsviKJmpWEQc0Bpx/wN/
        RwEqmRk1fU4c52/0sd/puvM7J1x6Gz2nxgWIKfJc6c+iYgC33WLaT0PHZk89qg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689635691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=OZddm0qMa+fCQ/gmjuY/HZsd/K8NL9drgmrzgYZMbN0=;
        b=uOTNnL5z3cSHcYx8OH+2g7Ajf3JECnWtkbAWERtDmsPHq3HawaQth2gZnAjWUJHugdxbTC
        dfPJ4MR2zHOIyvBQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Subject: [patch 11/58] x86/apic: Remove the pointless APIC version check
References: <20230717223049.327865981@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 18 Jul 2023 01:14:51 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This historical leftover is really uninteresting today. Whatever MPTABLE or
MADT delivers we only trust the hardware anyway.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/mpspec.h |    2 +-
 arch/x86/kernel/acpi/boot.c   |    6 +-----
 arch/x86/kernel/apic/apic.c   |   19 ++++---------------
 arch/x86/kernel/devicetree.c  |    5 ++---
 arch/x86/kernel/jailhouse.c   |    6 ++----
 arch/x86/kernel/mpparse.c     |    2 +-
 arch/x86/kernel/smpboot.c     |    4 ++--
 7 files changed, 13 insertions(+), 31 deletions(-)

--- a/arch/x86/include/asm/mpspec.h
+++ b/arch/x86/include/asm/mpspec.h
@@ -76,7 +76,7 @@ static inline void e820__memblock_alloc_
 #define default_get_smp_config x86_init_uint_noop
 #endif
 
-int generic_processor_info(int apicid, int version);
+int generic_processor_info(int apicid);
 
 #define PHYSID_ARRAY_SIZE	BITS_TO_LONGS(MAX_LOCAL_APIC)
 
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -169,7 +169,6 @@ static int __init acpi_parse_madt(struct
  */
 static int acpi_register_lapic(int id, u32 acpiid, u8 enabled)
 {
-	unsigned int ver = 0;
 	int cpu;
 
 	if (id >= MAX_LOCAL_APIC) {
@@ -182,10 +181,7 @@ static int acpi_register_lapic(int id, u
 		return -EINVAL;
 	}
 
-	if (boot_cpu_physical_apicid != -1U)
-		ver = boot_cpu_apic_version;
-
-	cpu = generic_processor_info(id, ver);
+	cpu = generic_processor_info(id);
 	if (cpu >= 0)
 		early_per_cpu(x86_cpu_to_acpiid, cpu) = acpiid;
 
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2428,19 +2428,8 @@ static int allocate_logical_cpuid(int ap
 	return nr_logical_cpuids++;
 }
 
-static void cpu_update_apic(int cpu, int apicid, int version)
+static void cpu_update_apic(int cpu, int apicid)
 {
-	if (version == 0x0) {
-		pr_warn("BIOS bug: APIC version is 0 for CPU %d/0x%x, fixing up to 0x10\n",
-			cpu, apicid);
-		version = 0x10;
-	}
-
-	if (version != boot_cpu_apic_version) {
-		pr_warn("BIOS bug: APIC version mismatch, boot CPU: %x, CPU %d: version %x\n",
-			boot_cpu_apic_version, cpu, version);
-	}
-
 #if defined(CONFIG_SMP) || defined(CONFIG_X86_64)
 	early_per_cpu(x86_cpu_to_apicid, cpu) = apicid;
 #endif
@@ -2460,10 +2449,10 @@ static void cpu_update_apic(int cpu, int
 static __init void cpu_set_boot_apic(void)
 {
 	cpuid_to_apicid[0] = boot_cpu_physical_apicid;
-	cpu_update_apic(0, boot_cpu_physical_apicid, boot_cpu_apic_version);
+	cpu_update_apic(0, boot_cpu_physical_apicid);
 }
 
-int generic_processor_info(int apicid, int version)
+int generic_processor_info(int apicid)
 {
 	int cpu, max = nr_cpu_ids;
 
@@ -2500,7 +2489,7 @@ int generic_processor_info(int apicid, i
 		return -EINVAL;
 	}
 
-	cpu_update_apic(cpu, apicid, version);
+	cpu_update_apic(cpu, apicid);
 	return cpu;
 }
 
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -128,16 +128,15 @@ static void __init dtb_setup_hpet(void)
 static void __init dtb_cpu_setup(void)
 {
 	struct device_node *dn;
-	u32 apic_id, version;
+	u32 apic_id;
 
-	version = GET_APIC_VERSION(apic_read(APIC_LVR));
 	for_each_of_cpu_node(dn) {
 		apic_id = of_get_cpu_hwid(dn, 0);
 		if (apic_id == ~0U) {
 			pr_warn("%pOF: missing local APIC ID\n", dn);
 			continue;
 		}
-		generic_processor_info(apic_id, version);
+		generic_processor_info(apic_id);
 	}
 }
 
--- a/arch/x86/kernel/jailhouse.c
+++ b/arch/x86/kernel/jailhouse.c
@@ -101,10 +101,8 @@ static void __init jailhouse_get_smp_con
 
 	register_lapic_address(0xfee00000);
 
-	for (cpu = 0; cpu < setup_data.v1.num_cpus; cpu++) {
-		generic_processor_info(setup_data.v1.cpu_ids[cpu],
-				       boot_cpu_apic_version);
-	}
+	for (cpu = 0; cpu < setup_data.v1.num_cpus; cpu++)
+		generic_processor_info(setup_data.v1.cpu_ids[cpu]);
 
 	smp_found_config = 1;
 
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -62,7 +62,7 @@ static void __init MP_processor_info(str
 		bootup_cpu = " (Bootup-CPU)";
 
 	pr_info("Processor #%d%s\n", m->apicid, bootup_cpu);
-	generic_processor_info(apicid, m->apicver);
+	generic_processor_info(apicid);
 }
 
 #ifdef CONFIG_X86_IO_APIC
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1389,7 +1389,7 @@ early_param("possible_cpus", _setup_poss
 {
 	int i, possible;
 
-	/* No boot processor was found in mptable or ACPI MADT */
+	/* No processor was found in mptable or ACPI MADT */
 	if (!num_processors) {
 		if (boot_cpu_has(X86_FEATURE_APIC)) {
 			int apicid = boot_cpu_physical_apicid;
@@ -1400,7 +1400,7 @@ early_param("possible_cpus", _setup_poss
 			/* Make sure boot cpu is enumerated */
 			if (apic->cpu_present_to_apicid(0) == BAD_APICID &&
 			    apic->apic_id_valid(apicid))
-				generic_processor_info(apicid, boot_cpu_apic_version);
+				generic_processor_info(apicid);
 		}
 
 		if (!num_processors)

