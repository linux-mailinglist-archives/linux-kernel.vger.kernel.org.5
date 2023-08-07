Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7DBC7726CD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234122AbjHGN4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234551AbjHGNz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:55:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D1326BE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:53:45 -0700 (PDT)
Message-ID: <20230807135028.747059118@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691416423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=HA0GkWkS8cpM1N2spYIG0KC2cT4EUF8chsnc8hqXNxI=;
        b=mbcBIdnUQxSlwmQa6B+H/Gxl393lPsdfzT7tBvYwR3Pn3VJf+tNWgt85zxFZlKT+UExE60
        ASDnC02eCyZYX7oG5pFGosDAY7wgWYXqfo7i9s4IXwE7UN8vUEKjyg70NMAgWSck1bK9Vp
        sq8DFONe71gmmM6A6utJkBgjTFWyvu/Y94S+hHnZVWQbEUIe2n89QtOy3IG1YHv/g6OYwt
        Y0Daaj5eXg7Ztf98SmbUplU62i50xj7dd1bVbHmJcYXAVc7vmzhkSvTsB20gGfqqrGaq4y
        2dlTvsOe9Pi5x41DNKPfgkdFBAyGsl69fcCLCbKMt+PpcIcoisLs+YTvzKenHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691416423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=HA0GkWkS8cpM1N2spYIG0KC2cT4EUF8chsnc8hqXNxI=;
        b=cMZSsmtB0P6xqMZ/ZMF9HG3Kk7dfRR61Hvfa0iJr5FHBerw5WEqBc+hBW+SJbcqeNUvqIs
        VSi+KA69RHL6wTCg==
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
Subject: [patch 44/53] x86/cpu/topology: Mop up primary thread mask handling
References: <20230807130108.853357011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  7 Aug 2023 15:53:42 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The early initcall to initialize the primary thread mask is not longer
required because topology_init_possible_cpus() can mark primary threads
correctly when initializing the possible and present map as the number of
SMT threads is already determined correctly.

The XENPV workaround is not longer required because XENPV now registers
fake APIC IDs which will just work like any other enumeration.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/topology.c |   29 ++---------------------------
 1 file changed, 2 insertions(+), 27 deletions(-)

--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -92,30 +92,6 @@ static void cpu_mark_primary_thread(unsi
 	if (smp_num_siblings == 1 || !(apicid & mask))
 		cpumask_set_cpu(cpu, &__cpu_primary_thread_mask);
 }
-
-/*
- * Due to the utter mess of CPUID evaluation smp_num_siblings is not valid
- * during early boot. Initialize the primary thread mask before SMP
- * bringup.
- */
-static int __init smp_init_primary_thread_mask(void)
-{
-	unsigned int cpu;
-
-	/*
-	 * XEN/PV provides either none or useless topology information.
-	 * Pretend that all vCPUs are primary threads.
-	 */
-	if (xen_pv_domain()) {
-		cpumask_copy(&__cpu_primary_thread_mask, cpu_possible_mask);
-		return 0;
-	}
-
-	for (cpu = 0; cpu < topo_info.nr_assigned_cpus; cpu++)
-		cpu_mark_primary_thread(cpu, cpuid_to_apicid[cpu]);
-	return 0;
-}
-early_initcall(smp_init_primary_thread_mask);
 #else
 static inline void cpu_mark_primary_thread(unsigned int cpu, unsigned int apicid) { }
 #endif
@@ -161,9 +137,6 @@ static void topo_set_cpuids(unsigned int
 #endif
 	set_cpu_possible(cpu, true);
 	set_cpu_present(cpu, true);
-
-	if (system_state != SYSTEM_BOOTING)
-		cpu_mark_primary_thread(cpu, apic_id);
 }
 
 /**
@@ -252,6 +225,7 @@ int topology_hotplug_apic(u32 apic_id, u
 
 	set_bit(apic_id, phys_cpu_present_map);
 	topo_set_cpuids(cpu, apic_id, acpi_id);
+	cpu_mark_primary_thread(cpu, apic_id);
 	return cpu;
 }
 
@@ -422,6 +396,7 @@ void __init topology_init_possible_cpus(
 		if (apicid == BAD_APICID)
 			continue;
 
+		cpu_mark_primary_thread(cpu, apicid);
 		set_cpu_present(cpu, test_bit(apicid, phys_cpu_present_map));
 	}
 }

