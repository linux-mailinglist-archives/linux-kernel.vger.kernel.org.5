Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2E87726BD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234643AbjHGNyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234599AbjHGNxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:53:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE391BCB
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:53:30 -0700 (PDT)
Message-ID: <20230807135028.272781311@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691416408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=2y86e1A51xAdlHDuJ9fUEP1blarkIhmxyqQLfQd+Qgs=;
        b=LJCjhhlilULYNiC9ZXNNGMtCE0SZcQiH/MEYuQaWfRqWhLRpDbhwWOLk08s8YvXW2Zycyk
        5/y/rcsz5pGZwGI4RfzwkyG9HsVMcj8lVotz7HmCfOed+wDQZ92UkQxEJrJE+ngP2lamEe
        RfdxCOHIbT00kvt9N90zYPh38xDziVMck/7GpH8F6AlfOfoBtfFqlP1jgkx65mtea7c9UW
        cunzKO8HhUSRUey9foL+MTw8Ovn91sYodrb10oPgONfjIT7wXju0A2i6Uu3v3U6UWwW4h4
        xMj3iY2hJ4PEMuf5d4qjExYGg2x917tjQSIy0WjeGTTix63Wbd8DPyTHj/H74w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691416408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=2y86e1A51xAdlHDuJ9fUEP1blarkIhmxyqQLfQd+Qgs=;
        b=WycnduVW4XP6LfEpzuiNRYbGW8ilR801BFVYjDXAHrck+yUJwntFbihj0CvogBjVfIB3GQ
        bGXzIJE+isimZCDw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        Andy Shevchenko <andy@infradead.org>
Subject: [patch 35/53] x86/cpu/topology: Sanitize the APIC admission logic
References: <20230807130108.853357011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  7 Aug 2023 15:53:28 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the actually required content of generic_processor_id() into the call
sites and use common helper functions for them. This separates the early
boot registration and the ACPI hotplug mechanism completely which allows
further cleanups and improvements.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/topology.c |  160 +++++++++++++++++-------------------
 1 file changed, 78 insertions(+), 82 deletions(-)

--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -30,8 +30,10 @@ struct {
 	unsigned int		nr_assigned_cpus;
 	unsigned int		nr_disabled_cpus;
 	unsigned int		nr_rejected_cpus;
+	u32			boot_cpu_apic_id;
 } topo_info __read_mostly = {
 	.nr_assigned_cpus	= 1,
+	.boot_cpu_apic_id	= BAD_APICID,
 };
 
 /*
@@ -78,78 +80,6 @@ early_initcall(smp_init_primary_thread_m
 static inline void cpu_mark_primary_thread(unsigned int cpu, unsigned int apicid) { }
 #endif
 
-static int topo_lookup_cpuid(u32 apic_id)
-{
-	int i;
-
-	/* CPU# to APICID mapping is persistent once it is established */
-	for (i = 0; i < topo_info.nr_assigned_cpus; i++) {
-		if (cpuid_to_apicid[i] == apic_id)
-			return i;
-	}
-	return -ENODEV;
-}
-
-/*
- * Should use this API to allocate logical CPU IDs to keep nr_logical_cpuids
- * and cpuid_to_apicid[] synchronized.
- */
-static int allocate_logical_cpuid(u32 apic_id)
-{
-	int cpu = topo_lookup_cpuid(apic_id);
-
-	if (cpu >= 0)
-		return cpu;
-
-	return topo_info.nr_assigned_cpus++;
-}
-
-static void cpu_update_apic(unsigned int cpu, u32 apic_id)
-{
-#if defined(CONFIG_SMP) || defined(CONFIG_X86_64)
-	early_per_cpu(x86_cpu_to_apicid, cpu) = apic_id;
-#endif
-	cpuid_to_apicid[cpu] = apic_id;
-	set_cpu_possible(cpu, true);
-	set_bit(apic_id, phys_cpu_present_map);
-	set_cpu_present(cpu, true);
-
-	if (system_state != SYSTEM_BOOTING)
-		cpu_mark_primary_thread(cpu, apic_id);
-}
-
-static int generic_processor_info(int apicid)
-{
-	int cpu;
-
-	/* The boot CPU must be set before MADT/MPTABLE parsing happens */
-	if (cpuid_to_apicid[0] == BAD_APICID)
-		panic("Boot CPU APIC not registered yet\n");
-
-	if (apicid == boot_cpu_physical_apicid)
-		return 0;
-
-	if (disabled_cpu_apicid == apicid) {
-		int thiscpu = topo_info.nr_assigned_cpus + topo_info.nr_disabled_cpus;
-
-		pr_warn("APIC: Disabling requested cpu. Processor %d/0x%x ignored.\n",
-			thiscpu, apicid);
-
-		topo_info.nr_rejected_cpus++;
-		return -ENODEV;
-	}
-
-	if (topo_info.nr_assigned_cpus >= nr_cpu_ids) {
-		pr_warn_once("APIC: CPU limit of %d reached. Ignoring further CPUs\n", nr_cpu_ids);
-		topo_info.nr_rejected_cpus++;
-		return -ENOSPC;
-	}
-
-	cpu = allocate_logical_cpuid(apicid);
-	cpu_update_apic(cpu, apicid);
-	return cpu;
-}
-
 static int __initdata setup_possible_cpus = -1;
 
 /*
@@ -217,6 +147,43 @@ static int __initdata setup_possible_cpu
 		set_cpu_possible(i, true);
 }
 
+static int topo_lookup_cpuid(u32 apic_id)
+{
+	int i;
+
+	/* CPU# to APICID mapping is persistent once it is established */
+	for (i = 0; i < topo_info.nr_assigned_cpus; i++) {
+		if (cpuid_to_apicid[i] == apic_id)
+			return i;
+	}
+	return -ENODEV;
+}
+
+static int topo_assign_cpunr(u32 apic_id)
+{
+	int cpu = topo_lookup_cpuid(apic_id);
+
+	if (cpu >= 0)
+		return cpu;
+
+	return topo_info.nr_assigned_cpus++;
+}
+
+static void topo_set_cpuids(unsigned int cpu, u32 apic_id, u32 acpi_id)
+{
+#if defined(CONFIG_SMP) || defined(CONFIG_X86_64)
+	early_per_cpu(x86_cpu_to_apicid, cpu) = apic_id;
+	early_per_cpu(x86_cpu_to_acpiid, cpu) = acpi_id;
+#endif
+	cpuid_to_apicid[cpu] = apic_id;
+
+	set_cpu_possible(cpu, true);
+	set_cpu_present(cpu, true);
+
+	if (system_state != SYSTEM_BOOTING)
+		cpu_mark_primary_thread(cpu, apic_id);
+}
+
 /**
  * topology_register_apic - Register an APIC in early topology maps
  * @apic_id:	The APIC ID to set up
@@ -229,17 +196,41 @@ void __init topology_register_apic(u32 a
 
 	if (apic_id >= MAX_LOCAL_APIC) {
 		pr_err_once("APIC ID %x exceeds kernel limit of: %x\n", apic_id, MAX_LOCAL_APIC - 1);
+		topo_info.nr_rejected_cpus++;
 		return;
 	}
 
-	if (!present) {
-		topo_info.nr_disabled_cpus++;
+	/* CPU numbers exhausted? */
+	if (topo_info.nr_assigned_cpus >= nr_cpu_ids) {
+		pr_warn_once("CPU limit of %d reached. Ignoring further CPUs\n", nr_cpu_ids);
+		topo_info.nr_rejected_cpus++;
 		return;
 	}
 
-	cpu = generic_processor_info(apic_id);
-	if (cpu >= 0)
-		early_per_cpu(x86_cpu_to_acpiid, cpu) = acpi_id;
+	if (disabled_cpu_apicid == apic_id) {
+		pr_info("Disabling CPU as requested via 'disable_cpu_apicid=0x%x'.\n", apic_id);
+		topo_info.nr_rejected_cpus++;
+		return;
+	}
+
+	if (present) {
+		/*
+		 * Prevent double registration, which is valid in case of
+		 * the boot CPU APIC because that is registered before the
+		 * enumeration of the APICs via firmware parsers or VM
+		 * guest mechanisms.
+		 */
+		if (test_and_set_bit(apic_id, phys_cpu_present_map))
+			return;
+
+		if (apic_id == topo_info.boot_cpu_apic_id)
+			cpu = 0;
+		else
+			cpu = topo_assign_cpunr(apic_id);
+		topo_set_cpuids(cpu, apic_id, acpi_id);
+	} else {
+		topo_info.nr_disabled_cpus++;
+	}
 }
 
 /**
@@ -250,8 +241,10 @@ void __init topology_register_apic(u32 a
  */
 void __init topology_register_boot_apic(u32 apic_id)
 {
-	cpuid_to_apicid[0] = apic_id;
-	cpu_update_apic(0, apic_id);
+	WARN_ON_ONCE(topo_info.boot_cpu_apic_id != BAD_APICID);
+
+	topo_info.boot_cpu_apic_id = apic_id;
+	topology_register_apic(apic_id, CPU_ACPIID_INVALID, true);
 }
 
 #ifdef CONFIG_ACPI_HOTPLUG_CPU
@@ -269,10 +262,13 @@ int topology_hotplug_apic(u32 apic_id, u
 
 	cpu = topo_lookup_cpuid(apic_id);
 	if (cpu < 0) {
-		cpu = generic_processor_info(apic_id);
-		if (cpu >= 0)
-			per_cpu(x86_cpu_to_acpiid, cpu) = acpi_id;
+		if (topo_info.nr_assigned_cpus >= nr_cpu_ids)
+			return -ENOSPC;
+
+		cpu = topo_assign_cpunr(apic_id);
 	}
+	set_bit(apic_id, phys_cpu_present_map);
+	topo_set_cpuids(cpu, apic_id, acpi_id);
 	return cpu;
 }
 

