Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4D576B22E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbjHAKrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233345AbjHAKrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:47:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5126F1BF0
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 03:46:55 -0700 (PDT)
Message-ID: <20230801103815.707466941@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690886813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=tXQKKwpyD/5KWCvdmuzL9UCOi5F812bKdsX6A+OvjaI=;
        b=Mn9w4RJyrHBhyieWkk9u0q52FPjCH9y2Zr91JEAbjpj1hUuZyRhsrJyOpEpF9LT+lPRXz5
        gLHSeeoqpwR46IVVyuYAP6zYfrq5XMgoptLLgpZZJRr7G+88ek6RbmoRAaefP7p36MK+vm
        u6ymRBhNT1sd/0MI6/GN3juPfpjVBsA5KxjuAMaExahKpU7AuDdvNkzuT2yiGIcZq4C2wx
        RxPJVRpqPM7Pj3K+c7l0t1R866FVJlvMKcZDKJMFXXFkSqtZ/44bMdcIEkeD3oAUfCviwl
        Mz6t7BCnDtvHw7SszShT6qGj4CXkOVY6eMGWczlmGXh19Mjmd0icaeeUpa20IA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690886813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=tXQKKwpyD/5KWCvdmuzL9UCOi5F812bKdsX6A+OvjaI=;
        b=KPaCfvKXD6FpJehHm2N0Z52D4OsXF745gCdHq0blGpbfmiLPN4b7Hy2P73VdxgzUTovPo4
        EMMfgwpgm56I/ZCg==
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
Subject: [patch V3 10/60] x86/apic: Register boot CPU APIC early
References: <20230801103042.936020332@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  1 Aug 2023 12:46:53 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register the boot CPU APIC right when the boot CPUs APIC is read from the
hardware. No point is doing this on random places and having wild
heuristics to save the boot CPU APIC ID slot and CPU number 0 reserved.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/apic/apic.c |  120 ++++++++++++++++++--------------------------
 1 file changed, 50 insertions(+), 70 deletions(-)

--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1734,6 +1734,8 @@ void apic_ap_setup(void)
 	end_local_APIC_setup();
 }
 
+static __init void cpu_set_boot_apic(void);
+
 static __init void apic_read_boot_cpu_id(bool x2apic)
 {
 	/*
@@ -1748,9 +1750,9 @@ static __init void apic_read_boot_cpu_id
 		boot_cpu_physical_apicid = read_apic_id();
 		boot_cpu_apic_version = GET_APIC_VERSION(apic_read(APIC_LVR));
 	}
+	cpu_set_boot_apic();
 }
 
-
 #ifdef CONFIG_X86_X2APIC
 int x2apic_mode;
 EXPORT_SYMBOL_GPL(x2apic_mode);
@@ -2426,76 +2428,8 @@ static int allocate_logical_cpuid(int ap
 	return nr_logical_cpuids++;
 }
 
-int generic_processor_info(int apicid, int version)
+static void cpu_update_apic(int cpu, int apicid, int version)
 {
-	int cpu, max = nr_cpu_ids;
-	bool boot_cpu_detected = physid_isset(boot_cpu_physical_apicid,
-				phys_cpu_present_map);
-
-	/*
-	 * boot_cpu_physical_apicid is guaranteed to contain the boot CPU
-	 * APIC ID read from the local APIC when this function is invoked.
-	 */
-	if (disabled_cpu_apicid != boot_cpu_physical_apicid &&
-	    disabled_cpu_apicid == apicid) {
-		int thiscpu = num_processors + disabled_cpus;
-
-		pr_warn("APIC: Disabling requested cpu. Processor %d/0x%x ignored.\n",
-			thiscpu, apicid);
-
-		disabled_cpus++;
-		return -ENODEV;
-	}
-
-	/*
-	 * If boot cpu has not been detected yet, then only allow upto
-	 * nr_cpu_ids - 1 processors and keep one slot free for boot cpu
-	 */
-	if (!boot_cpu_detected && num_processors >= nr_cpu_ids - 1 &&
-	    apicid != boot_cpu_physical_apicid) {
-		int thiscpu = max + disabled_cpus - 1;
-
-		pr_warn("APIC: NR_CPUS/possible_cpus limit of %i almost"
-			" reached. Keeping one slot for boot cpu."
-			"  Processor %d/0x%x ignored.\n", max, thiscpu, apicid);
-
-		disabled_cpus++;
-		return -ENODEV;
-	}
-
-	if (num_processors >= nr_cpu_ids) {
-		int thiscpu = max + disabled_cpus;
-
-		pr_warn("APIC: NR_CPUS/possible_cpus limit of %i reached. "
-			"Processor %d/0x%x ignored.\n", max, thiscpu, apicid);
-
-		disabled_cpus++;
-		return -EINVAL;
-	}
-
-	if (apicid == boot_cpu_physical_apicid) {
-		/*
-		 * x86_cpu_to_apicid is required to have processors listed
-		 * in same order as logical cpu numbers. Hence the first
-		 * entry is BSP, and so on.
-		 * boot_cpu_init() already hold bit 0 in cpu_present_mask
-		 * for BSP.
-		 */
-		cpu = 0;
-
-		/* Logical cpuid 0 is reserved for BSP. */
-		cpuid_to_apicid[0] = apicid;
-	} else {
-		cpu = allocate_logical_cpuid(apicid);
-		if (cpu < 0) {
-			disabled_cpus++;
-			return -EINVAL;
-		}
-	}
-
-	/*
-	 * Validate version
-	 */
 	if (version == 0x0) {
 		pr_warn("BIOS bug: APIC version is 0 for CPU %d/0x%x, fixing up to 0x10\n",
 			cpu, apicid);
@@ -2521,10 +2455,56 @@ int generic_processor_info(int apicid, i
 
 	if (system_state != SYSTEM_BOOTING)
 		cpu_mark_primary_thread(cpu, apicid);
+}
+
+static __init void cpu_set_boot_apic(void)
+{
+	cpuid_to_apicid[0] = boot_cpu_physical_apicid;
+	cpu_update_apic(0, boot_cpu_physical_apicid, boot_cpu_apic_version);
+}
+
+int generic_processor_info(int apicid, int version)
+{
+	int cpu, max = nr_cpu_ids;
+
+	/* The boot CPU must be set before MADT/MPTABLE parsing happens */
+	if (cpuid_to_apicid[0] == BAD_APICID)
+		panic("Boot CPU APIC not registered yet\n");
+
+	if (apicid == boot_cpu_physical_apicid)
+		return 0;
+
+	if (disabled_cpu_apicid == apicid) {
+		int thiscpu = num_processors + disabled_cpus;
+
+		pr_warn("APIC: Disabling requested cpu. Processor %d/0x%x ignored.\n",
+			thiscpu, apicid);
 
+		disabled_cpus++;
+		return -ENODEV;
+	}
+
+	if (num_processors >= nr_cpu_ids) {
+		int thiscpu = max + disabled_cpus;
+
+		pr_warn("APIC: NR_CPUS/possible_cpus limit of %i reached. "
+			"Processor %d/0x%x ignored.\n", max, thiscpu, apicid);
+
+		disabled_cpus++;
+		return -EINVAL;
+	}
+
+	cpu = allocate_logical_cpuid(apicid);
+	if (cpu < 0) {
+		disabled_cpus++;
+		return -EINVAL;
+	}
+
+	cpu_update_apic(cpu, apicid, version);
 	return cpu;
 }
 
+
 void __irq_msi_compose_msg(struct irq_cfg *cfg, struct msi_msg *msg,
 			   bool dmar)
 {

