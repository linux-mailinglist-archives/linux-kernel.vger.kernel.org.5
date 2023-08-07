Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7057726AF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbjHGNyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234510AbjHGNxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:53:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED4AE79
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:53:12 -0700 (PDT)
Message-ID: <20230807135027.692922999@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691416391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=IqAKXGpiL7mvQVclSEowAMUpcYUdp0UmfO0umAl+WIU=;
        b=xvqD84j5Lo6sV4+Tev8QdMaXG0YVemHJ0oscuIqKtuxRAs9qkCJldpu6sl72q+/53WEhQ7
        zo+RW7FYAs6nbmz8Lbe6KiIg0PlpcM4o1HATGBL/4UrsqSSjVOC7eQSZjD6YE2cCbOXn4l
        No/snYuXiWNHT8T0wpotpYRpenw7oCEZ4v+bO6ucc/xqsLLvuuKM37+/3xXZO6/PxECiRv
        pxTwTQV4csd1X/CjlJqVdePVWx13gx1lD3aB+Xfmbakl+WWe1hovb0yPhnxwvTt0o8iRqS
        kjlel56JzvCxquTXXu4NeyYab+2Kzg4Rx40ChrXH9oLxrzHlmAwXQIRT/Q3NRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691416391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=IqAKXGpiL7mvQVclSEowAMUpcYUdp0UmfO0umAl+WIU=;
        b=b3w1iUWC31HmC3cDjgcLS5OUz9y5vPc8OerZFlz8Qk3jROwpXKhvJrMe2VKrflYuoWBfSN
        mkwrldqL2VuQ+5Cw==
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
Subject: [patch 24/53] x86/cpu/topology: Provide separate APIC registration
 functions
References: <20230807130108.853357011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  7 Aug 2023 15:53:11 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

generic_processor_info() aside of being a complete misnomer is used for
both early boot registration and ACPI CPU hotplug.

While it's arguable that this can share some code, it results in code which
is hard to understand and kept around post init for no real reason.

Also the call sites do lots of manual fiddling in topology related
variables instead of having proper interfaces for the purpose which handle
the topology internals correctly.

Provide topology_register_apic(), topology_hotplug_apic() and
topology_hot_unplug_apic() which have the extra magic of the call sites
incorporated and for now are wrappers around generic_processor_info().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/apic.h         |    3 
 arch/x86/kernel/cpu/topology.c |  113 ++++++++++++++++++++++++++++++------
 2 files changed, 98 insertions(+), 18 deletions(-)

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -171,7 +171,10 @@ extern bool apic_needs_pit(void);
 
 extern void apic_send_IPI_allbutself(unsigned int vector);
 
+extern void topology_register_apic(u32 apic_id, u32 acpi_id, bool present);
 extern void topology_register_boot_apic(u32 apic_id);
+extern int topology_hotplug_apic(u32 apic_id, u32 acpi_id);
+extern void topology_hotunplug_apic(unsigned int cpu);
 
 #else /* !CONFIG_X86_LOCAL_APIC */
 static inline void lapic_shutdown(void) { }
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -79,32 +79,38 @@ early_initcall(smp_init_primary_thread_m
 static inline void cpu_mark_primary_thread(unsigned int cpu, unsigned int apicid) { }
 #endif
 
-/*
- * Should use this API to allocate logical CPU IDs to keep nr_logical_cpuids
- * and cpuid_to_apicid[] synchronized.
- */
-static int allocate_logical_cpuid(int apicid)
+static int topo_lookup_cpuid(u32 apic_id)
 {
 	int i;
 
-	/*
-	 * cpuid <-> apicid mapping is persistent, so when a cpu is up,
-	 * check if the kernel has allocated a cpuid for it.
-	 */
+	/* CPU# to APICID mapping is persistent once it is established */
 	for (i = 0; i < nr_logical_cpuids; i++) {
-		if (cpuid_to_apicid[i] == apicid)
+		if (cpuid_to_apicid[i] == apic_id)
 			return i;
 	}
+	return -ENODEV;
+}
+
+/*
+ * Should use this API to allocate logical CPU IDs to keep nr_logical_cpuids
+ * and cpuid_to_apicid[] synchronized.
+ */
+static int allocate_logical_cpuid(u32 apic_id)
+{
+	int cpu = topo_lookup_cpuid(apic_id);
+
+	if (cpu >= 0)
+		return cpu;
 
 	/* Allocate a new cpuid. */
 	if (nr_logical_cpuids >= nr_cpu_ids) {
 		WARN_ONCE(1, "APIC: NR_CPUS/possible_cpus limit of %u reached. "
 			     "Processor %d/0x%x and the rest are ignored.\n",
-			     nr_cpu_ids, nr_logical_cpuids, apicid);
+			     nr_cpu_ids, nr_logical_cpuids, apic_id);
 		return -EINVAL;
 	}
 
-	cpuid_to_apicid[nr_logical_cpuids] = apicid;
+	cpuid_to_apicid[nr_logical_cpuids] = apic_id;
 	return nr_logical_cpuids++;
 }
 
@@ -122,12 +128,6 @@ static void cpu_update_apic(int cpu, u32
 		cpu_mark_primary_thread(cpu, apicid);
 }
 
-void __init topology_register_boot_apic(u32 apic_id)
-{
-	cpuid_to_apicid[0] = apic_id;
-	cpu_update_apic(0, apic_id);
-}
-
 int generic_processor_info(int apicid)
 {
 	int cpu, max = nr_cpu_ids;
@@ -169,6 +169,83 @@ int generic_processor_info(int apicid)
 	return cpu;
 }
 
+/**
+ * topology_register_apic - Register an APIC in early topology maps
+ * @apic_id:	The APIC ID to set up
+ * @acpi_id:	The ACPI ID associated to the APIC
+ * @present:	True if the corresponding CPU is present
+ */
+void __init topology_register_apic(u32 apic_id, u32 acpi_id, bool present)
+{
+	int cpu;
+
+	if (apic_id >= MAX_LOCAL_APIC) {
+		pr_err_once("APIC ID %x exceeds kernel limit of: %x\n", apic_id, MAX_LOCAL_APIC - 1);
+		return;
+	}
+
+	if (!present) {
+		disabled_cpus++;
+		return;
+	}
+
+	cpu = generic_processor_info(apic_id);
+	if (cpu >= 0)
+		early_per_cpu(x86_cpu_to_acpiid, cpu) = acpi_id;
+}
+
+/**
+ * topology_register_boot_apic - Register the boot CPU APIC
+ * @apic_id:	The APIC ID to set up
+ *
+ * Separate so CPU #0 can be assigned
+ */
+void __init topology_register_boot_apic(u32 apic_id)
+{
+	cpuid_to_apicid[0] = apic_id;
+	cpu_update_apic(0, apic_id);
+}
+
+#ifdef CONFIG_ACPI_HOTPLUG_CPU
+/**
+ * topology_hotplug_apic - Handle a physical hotplugged APIC after boot
+ * @apic_id:	The APIC ID to set up
+ * @acpi_id:	The ACPI ID associated to the APIC
+ */
+int topology_hotplug_apic(u32 apic_id, u32 acpi_id)
+{
+	int cpu;
+
+	if (apic_id >= MAX_LOCAL_APIC)
+		return -EINVAL;
+
+	cpu = topo_lookup_cpuid(apic_id);
+	if (cpu < 0) {
+		cpu = generic_processor_info(apic_id);
+		if (cpu >= 0)
+			per_cpu(x86_cpu_to_acpiid, cpu) = acpi_id;
+	}
+	return cpu;
+}
+
+/**
+ * topology_hotunplug_apic - Remove a physical hotplugged APIC after boot
+ * @cpu:	The CPU number for which the APIC ID is removed
+ */
+void topology_hotunplug_apic(unsigned int cpu)
+{
+	u32 apic_id = cpuid_to_apicid[cpu];
+
+	if (apic_id == BAD_APICID)
+		return;
+
+	per_cpu(x86_cpu_to_apicid, cpu) = BAD_APICID;
+	clear_bit(apic_id, phys_cpu_present_map);
+	set_cpu_present(cpu, false);
+	num_processors--;
+}
+#endif
+
 static int __init apic_set_disabled_cpu_apicid(char *arg)
 {
 	if (!arg || !get_option(&arg, &disabled_cpu_apicid))

