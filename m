Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52EA87726C9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbjHGNzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234689AbjHGNyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:54:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B114210C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:53:38 -0700 (PDT)
Message-ID: <20230807135028.538458200@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691416416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=lEJAM6lSEYnamHvy/pM3gmY344lRoNlxzC3YlBMWnmA=;
        b=ETtcYkCFrSbFl0znfhjYUotU5DP8+kA+1D4ue1kZJamGsOntPw2n8RS/1U4jA4nvldKqlz
        NzCli0ZDDmh9ksl03VtpnZCBoQAKG6F/F8XwWOL32hm4QP1ClWXslbDtI559xXBv0BOZ8p
        HTIyFj5SNGQY0KtHfjHwFEZP0Q0DR30ykm1eaVZ2iqjfmdAdy+VsRrYeWXDok5gCHoXi4Y
        HCJIRYcXiyqn7Z1aDeAzZEkA/1cfeyr29j/H3kmMg5lFKp2zRPKGMukU1nAwaQ1KW/jBF+
        rW2HlA7oz3SqrQPjDCGp+qNlt0ysSUMtUjhtT2dRxirgWEIeMXAr9SODu0jhEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691416416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=lEJAM6lSEYnamHvy/pM3gmY344lRoNlxzC3YlBMWnmA=;
        b=NSuebcMVp9x5AsXQoWpMIxO89mNbQXxraBRBoC3sF3EUEebdEi5yMQl8LiWzPYIJndMHey
        xeyJZANDEw66CZAQ==
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
Subject: [patch 40/53] x86/cpu/topology: Assign hotpluggable CPUIDs during
 init
References: <20230807130108.853357011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  7 Aug 2023 15:53:36 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no point in assigning the CPU numbers during ACPI physical
hotplug. The number of possible hotplug CPUs is known when the possible map
is initialized, so the CPU numbers can be associated to the registered
non-present APIC IDs right there.

This allows to put more code into the __init section and makes the related
data __ro_after_init.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/topology.c |   28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -45,7 +45,7 @@ EXPORT_EARLY_PER_CPU_SYMBOL(x86_cpu_to_a
 DECLARE_BITMAP(phys_cpu_present_map, MAX_LOCAL_APIC) __read_mostly;
 
 /* Used for CPU number allocation and parallel CPU bringup */
-u32 cpuid_to_apicid[] __read_mostly = { [0 ... NR_CPUS - 1] = BAD_APICID, };
+u32 cpuid_to_apicid[] __ro_after_init = { [0 ... NR_CPUS - 1] = BAD_APICID, };
 
 /* Bitmaps to mark registered APICs at each topology domain */
 static struct { DECLARE_BITMAP(map, MAX_LOCAL_APIC); } apic_maps[TOPO_MAX_DOMAIN] __ro_after_init;
@@ -60,7 +60,7 @@ struct {
 	unsigned int		nr_rejected_cpus;
 	u32			boot_cpu_apic_id;
 	u32			real_bsp_apic_id;
-} topo_info __read_mostly = {
+} topo_info __ro_after_init = {
 	.nr_assigned_cpus	= 1,
 	.boot_cpu_apic_id	= BAD_APICID,
 	.real_bsp_apic_id	= BAD_APICID,
@@ -143,7 +143,7 @@ static int topo_lookup_cpuid(u32 apic_id
 	return -ENODEV;
 }
 
-static int topo_assign_cpunr(u32 apic_id)
+static __init int topo_assign_cpunr(u32 apic_id)
 {
 	int cpu = topo_lookup_cpuid(apic_id);
 
@@ -159,8 +159,6 @@ static void topo_set_cpuids(unsigned int
 	early_per_cpu(x86_cpu_to_apicid, cpu) = apic_id;
 	early_per_cpu(x86_cpu_to_acpiid, cpu) = acpi_id;
 #endif
-	cpuid_to_apicid[cpu] = apic_id;
-
 	set_cpu_possible(cpu, true);
 	set_cpu_present(cpu, true);
 
@@ -205,6 +203,8 @@ void __init topology_register_apic(u32 a
 			cpu = 0;
 		else
 			cpu = topo_assign_cpunr(apic_id);
+
+		cpuid_to_apicid[cpu] = apic_id;
 		topo_set_cpuids(cpu, apic_id, acpi_id);
 	} else {
 		topo_info.nr_disabled_cpus++;
@@ -247,12 +247,9 @@ int topology_hotplug_apic(u32 apic_id, u
 		return -ENODEV;
 
 	cpu = topo_lookup_cpuid(apic_id);
-	if (cpu < 0) {
-		if (topo_info.nr_assigned_cpus >= nr_cpu_ids)
-			return -ENOSPC;
+	if (cpu < 0)
+		return -ENOSPC;
 
-		cpu = topo_assign_cpunr(apic_id);
-	}
 	set_bit(apic_id, phys_cpu_present_map);
 	topo_set_cpuids(cpu, apic_id, acpi_id);
 	return cpu;
@@ -352,6 +349,7 @@ void __init topology_init_possible_cpus(
 	unsigned int disabled = topo_info.nr_disabled_cpus;
 	unsigned int total = assigned + disabled;
 	unsigned int cpu, dom, allowed = 1;
+	u32 apicid;
 
 	if (!restrict_to_up()) {
 		if (total > 1)
@@ -386,8 +384,16 @@ void __init topology_init_possible_cpus(
 	init_cpu_present(cpumask_of(0));
 	init_cpu_possible(cpumask_of(0));
 
+	for (apicid = 0; disabled; disabled--, apicid++) {
+		apicid = find_next_andnot_bit(apic_maps[TOPO_SMT_DOMAIN].map, phys_cpu_present_map,
+					      MAX_LOCAL_APIC, apicid);
+		if (apicid >= MAX_LOCAL_APIC)
+			break;
+		cpuid_to_apicid[topo_info.nr_assigned_cpus++] = apicid;
+	}
+
 	for (cpu = 0; cpu < allowed; cpu++) {
-		u32 apicid = cpuid_to_apicid[cpu];
+		apicid = cpuid_to_apicid[cpu];
 
 		/*
 		 * In case of a kdump() kernel, don't mark the real BSP in

