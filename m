Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11DB07726B2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234587AbjHGNyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234517AbjHGNxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:53:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BB7172B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:53:14 -0700 (PDT)
Message-ID: <20230807135027.744726431@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691416393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=nG+YvBEV0fbKDlHuwzPcSCnQUfwAu0UNTIPK/22bMkQ=;
        b=TIA7UnzXh5zAohfK/vOwilNrmoWIvemhbXWA/KYSdF9V3RTTmCXVv3M2fYDDQPfR8Y+M8s
        CqQduP/tMOQyyQPqjZn4Nq24EqGkLMQTq7c5UTTGz2mXr4IUwGie5TOxCexoZg4xQvXbKM
        1/JLm8buKdY0VQnCQJSgVr5z+UwhyqF1Q6+IN+da2qn0BCZDXB7ltScy4M5fe6FV5PqgUR
        p+8/k6S+uq1ep4AupOSfVXg+vLSVUOMVfa0MgH2jV55MtYIWaVxYr9LnNmDag7Pg3qjKoU
        h7XEcITOB6vQA0Ty/W8qgWP4nr5X6SI5C85xOl3ZZhXOK1/FdQTg1hh+pKOixQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691416393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=nG+YvBEV0fbKDlHuwzPcSCnQUfwAu0UNTIPK/22bMkQ=;
        b=LP35Q1XLE/S/6GG5Syf7Rfdt6aZGERw1YkhtUDdwa4aHeUmoSwiFYSDb3Q7noWmzA8n9MF
        UUL8rxvt1EJFPWBw==
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
Subject: [patch 25/53] x86/acpi: Use new APIC registration functions
References: <20230807130108.853357011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  7 Aug 2023 15:53:12 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new topology registration functions and make the early boot code
path __init. No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/acpi/boot.c |   44 +++++++-------------------------------------
 1 file changed, 7 insertions(+), 37 deletions(-)

--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -159,33 +159,9 @@ static int __init acpi_parse_madt(struct
 	return 0;
 }
 
-/**
- * acpi_register_lapic - register a local apic and generates a logic cpu number
- * @id: local apic id to register
- * @acpiid: ACPI id to register
- * @enabled: this cpu is enabled or not
- *
- * Returns the logic cpu number which maps to the local apic
- */
-static int acpi_register_lapic(int id, u32 acpiid, u8 enabled)
+static __init void acpi_register_lapic(u32 apic_id, u32 acpi_id, bool present)
 {
-	int cpu;
-
-	if (id >= MAX_LOCAL_APIC) {
-		pr_info("skipped apicid that is too big\n");
-		return -EINVAL;
-	}
-
-	if (!enabled) {
-		++disabled_cpus;
-		return -EINVAL;
-	}
-
-	cpu = generic_processor_info(id);
-	if (cpu >= 0)
-		early_per_cpu(x86_cpu_to_acpiid, cpu) = acpiid;
-
-	return cpu;
+	topology_register_apic(apic_id, acpi_id, present);
 }
 
 static bool __init acpi_is_processor_usable(u32 lapic_flags)
@@ -827,12 +803,10 @@ static int acpi_map_cpu2node(acpi_handle
 	return 0;
 }
 
-int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, u32 acpi_id,
-		 int *pcpu)
+int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, u32 acpi_id, int *pcpu)
 {
-	int cpu;
+	int cpu = topology_hotplug_apic(physid, acpi_id);
 
-	cpu = acpi_register_lapic(physid, acpi_id, ACPI_MADT_ENABLED);
 	if (cpu < 0) {
 		pr_info("Unable to map lapic to logical cpu number\n");
 		return cpu;
@@ -851,15 +825,11 @@ int acpi_unmap_cpu(int cpu)
 #ifdef CONFIG_ACPI_NUMA
 	set_apicid_to_node(per_cpu(x86_cpu_to_apicid, cpu), NUMA_NO_NODE);
 #endif
-
-	per_cpu(x86_cpu_to_apicid, cpu) = BAD_APICID;
-	set_cpu_present(cpu, false);
-	num_processors--;
-
-	return (0);
+	topology_hotunplug_apic(cpu);
+	return 0;
 }
 EXPORT_SYMBOL(acpi_unmap_cpu);
-#endif				/* CONFIG_ACPI_HOTPLUG_CPU */
+#endif	/* CONFIG_ACPI_HOTPLUG_CPU */
 
 int acpi_register_ioapic(acpi_handle handle, u64 phys_addr, u32 gsi_base)
 {

