Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A357726CB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbjHGNzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234621AbjHGNyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:54:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A990F2680
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:53:41 -0700 (PDT)
Message-ID: <20230807135028.642879580@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691416419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=1jDy+E2RKdGXAnT2Cl62jdceXo6yFfKHSHoyZ7qBNXo=;
        b=Vqgls1KGgbThxa0cPzIzq7xxMdV//XuJ2bdtGlIcyPSeyOdL0fiEtz9nLblciUvbK29I5o
        qIB5Ijrp5Hfc5mSScEKaxKMNsqVpI/klhiVZS9W2IhBzBlYbHBrmK4UJFv9gTEJavG+gKi
        Gkibr+qE+rPnZ2wN8yP8Wy/b2ZOPOlhPMHjZehLvrJFBCJSDGKgk+Gae9YSDDTFZz5Ciyp
        ecYZhOFCOsLhAAUQcn/utmg+jd6YMzXsSbZiyf7Eq0QXVvw8NRBKO/cVplbSEFhqxzzPRg
        6bsGI2j0aXC9jj+GJP1wjonFe0pNsp7gcV9plD5lEJCQFnKwe8jPsQ+rVvAvZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691416419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=1jDy+E2RKdGXAnT2Cl62jdceXo6yFfKHSHoyZ7qBNXo=;
        b=R2Nshg6rJNPWAunJZisyc2+a4VAL3Urp50ajDxoRPL7hMZe7RYJsfKdfPhAu828SU7qWDm
        qe03HyqNRkviv1Cw==
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
Subject: [patch 42/53] x86/cpu/topology: Let XEN/PV use topology from
 CPUID/MADT
References: <20230807130108.853357011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  7 Aug 2023 15:53:39 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out that XEN/PV Dom0 has halfways usable CPUID/MADT enumeration
except that it cannot deal with CPUs which are enumerated as disabled in
MADT.

DomU has no MADT and provides at least rudimentary topology information in
CPUID leaves 1 and 4.

For both it's important that there are not more possible Linux CPUs than
vCPUs provided by the hypervisor.

As this is ensured by counting the vCPUs before enumeration happens:

  - lift the restrictions in the CPUID evaluation and the MADT parser

  - Utilize MADT registration for Dom0

  - Keep the fake APIC ID registration for DomU

  - Fix the XEN APIC fake so the readout of the local APIC ID works for
    Dom0 via the hypercall and for DomU by returning the registered
    fake APIC IDs.

With that the XEN/PV fake approximates usefulness.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/acpi/boot.c           |   25 ++++++++-----------------
 arch/x86/kernel/cpu/topology_common.c |    2 +-
 arch/x86/xen/apic.c                   |   14 +++++++-------
 arch/x86/xen/smp_pv.c                 |   13 ++++++++-----
 4 files changed, 24 insertions(+), 30 deletions(-)
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -23,8 +23,6 @@
 #include <linux/serial_core.h>
 #include <linux/pgtable.h>
 
-#include <xen/xen.h>
-
 #include <asm/e820/api.h>
 #include <asm/irqdomain.h>
 #include <asm/pci_x86.h>
@@ -161,12 +159,6 @@ static int __init acpi_parse_madt(struct
 	return 0;
 }
 
-static __init void acpi_register_lapic(u32 apic_id, u32 acpi_id, bool present)
-{
-	if (!xen_pv_domain())
-		topology_register_apic(apic_id, acpi_id, present);
-}
-
 static bool __init acpi_is_processor_usable(u32 lapic_flags)
 {
 	if (lapic_flags & ACPI_MADT_ENABLED)
@@ -220,7 +212,7 @@ acpi_parse_x2apic(union acpi_subtable_he
 		return 0;
 	}
 
-	acpi_register_lapic(apic_id, processor->uid, enabled);
+	topology_register_apic(apic_id, processor->uid, enabled);
 #else
 	pr_warn("x2apic entry ignored\n");
 #endif
@@ -255,9 +247,9 @@ acpi_parse_lapic(union acpi_subtable_hea
 	 * to not preallocating memory for all NR_CPUS
 	 * when we use CPU hotplug.
 	 */
-	acpi_register_lapic(processor->id,	/* APIC ID */
-			    processor->processor_id, /* ACPI ID */
-			    processor->lapic_flags & ACPI_MADT_ENABLED);
+	topology_register_apic(processor->id,	/* APIC ID */
+			       processor->processor_id, /* ACPI ID */
+			       processor->lapic_flags & ACPI_MADT_ENABLED);
 
 	return 0;
 }
@@ -274,9 +266,9 @@ acpi_parse_sapic(union acpi_subtable_hea
 
 	acpi_table_print_madt_entry(&header->common);
 
-	acpi_register_lapic((processor->id << 8) | processor->eid,/* APIC ID */
-			    processor->processor_id, /* ACPI ID */
-			    processor->lapic_flags & ACPI_MADT_ENABLED);
+	topology_register_apic((processor->id << 8) | processor->eid,/* APIC ID */
+			       processor->processor_id, /* ACPI ID */
+			       processor->lapic_flags & ACPI_MADT_ENABLED);
 
 	return 0;
 }
@@ -1073,8 +1065,7 @@ static int __init early_acpi_parse_madt_
 		return count;
 	}
 
-	if (!xen_pv_domain())
-		register_lapic_address(acpi_lapic_addr);
+	register_lapic_address(acpi_lapic_addr);
 
 	return count;
 }
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -77,7 +77,7 @@ static bool fake_topology(struct topo_sc
 	topology_set_dom(tscan, TOPO_SMT_DOMAIN, 0, 1);
 	topology_set_dom(tscan, TOPO_CORE_DOMAIN, 0, 1);
 
-	return tscan->c->cpuid_level < 1 || xen_pv_domain();
+	return tscan->c->cpuid_level < 1;
 }
 
 static void parse_topology(struct topo_scan *tscan, bool early)
--- a/arch/x86/xen/apic.c
+++ b/arch/x86/xen/apic.c
@@ -43,20 +43,20 @@ static u32 xen_apic_read(u32 reg)
 	struct xen_platform_op op = {
 		.cmd = XENPF_get_cpuinfo,
 		.interface_version = XENPF_INTERFACE_VERSION,
-		.u.pcpu_info.xen_cpuid = 0,
 	};
-	int ret;
-
-	/* Shouldn't need this as APIC is turned off for PV, and we only
-	 * get called on the bootup processor. But just in case. */
-	if (!xen_initial_domain() || smp_processor_id())
-		return 0;
+	int ret, cpu;
 
 	if (reg == APIC_LVR)
 		return 0x14;
 	if (reg != APIC_ID)
 		return 0;
 
+	cpu = smp_processor_id();
+	if (!xen_initial_domain())
+		return cpu ? cpuid_to_apicid[cpu] << 24 : 0;
+
+	op.u.pcpu_info.xen_cpuid = cpu;
+
 	ret = HYPERVISOR_platform_op(&op);
 	if (ret)
 		op.u.pcpu_info.apic_id = BAD_APICID;
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -156,11 +156,9 @@ static void __init xen_pv_smp_config(voi
 
 	topology_register_boot_apic(apicid++);
 
-	for (i = 1; i < nr_cpu_ids; i++) {
-		if (HYPERVISOR_vcpu_op(VCPUOP_is_up, i, NULL) < 0)
-			break;
+	for (i = 1; i < nr_cpu_ids; i++)
 		topology_register_apic(apicid++, CPU_ACPIID_INVALID, true);
-	}
+
 	/* Pretend to be a proper enumerated system */
 	smp_found_config = 1;
 }
@@ -451,5 +449,10 @@ void __init xen_smp_init(void)
 	/* Avoid searching for BIOS MP tables */
 	x86_init.mpparse.find_mptable		= x86_init_noop;
 	x86_init.mpparse.early_parse_smp_cfg	= x86_init_noop;
-	x86_init.mpparse.parse_smp_cfg		= xen_pv_smp_config;
+
+	/* XEN/PV Dom0 has halfways sane topology information via CPUID/MADT */
+	if (xen_initial_domain())
+		x86_init.mpparse.parse_smp_cfg	= x86_init_noop;
+	else
+		x86_init.mpparse.parse_smp_cfg	= xen_pv_smp_config;
 }

