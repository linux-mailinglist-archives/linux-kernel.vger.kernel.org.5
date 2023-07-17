Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F51757054
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbjGQXPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjGQXPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:15:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20004E51
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 16:14:51 -0700 (PDT)
Message-ID: <20230717223223.679207826@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689635690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=+hrw46hsMBswWQNzqDZfoOo5VDQtds9fIHiVlhGFvxE=;
        b=1iTxgDBd2IbtrJHBH42NS0qXgndUHXqc+7hJZhMPlsQ1A5nnuWul3sMzl1eRLXfeL79pal
        6M8fKqhPBbLvUGtpV6azGOGtAzJJrbxi3/x2wDCA7V1+RmHC84NRiWYKNXIHmwWZhW5ny3
        YCN5lpG9uZAC0AveAZ1JK0yfseY4HNZFMCGOTUlTg8Ggn/anco5DaSbMbIqMMll3AVbWBe
        mzIBF21GQmLd55tm7d3RRgZZ4sXmkgKz44j9OpUBGcjdxBBuoKp7X/Sh6zmwAHZuCnIF/t
        sC3HmdEAFAdUrBq7X9t+1n9PNKlpW5p2orCq35A8ulMSINTDxYzaI6vGi1rfeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689635690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=+hrw46hsMBswWQNzqDZfoOo5VDQtds9fIHiVlhGFvxE=;
        b=iAwgexARZuIjyMMP7UxCAZX4JGqXaF5PrTmuzRWnXmv0RdbAK+3jOqKoz3aUpSMx1/Ml/O
        n+7JxTHMmJ8CMNCw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Subject: [patch 10/58] x86/apic: Register boot CPU APIC early
References: <20230717223049.327865981@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 18 Jul 2023 01:14:49 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

