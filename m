Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845BA7726D1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbjHGN4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234574AbjHGN4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:56:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48C230E6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:54:03 -0700 (PDT)
Message-ID: <20230807135028.957980935@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691416429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ph7RYPSGUyMuFVs2yJ045YytT8AyPZYMy0+K0KiHV3c=;
        b=lpaO6/ZmrKCyJgmJ2rFvtDsqnC+QbF2AxqmmgLpn15UrjOcbXwkSxXYQVL5t7Cy5Gfhvse
        R3VVz+SXGZWHcJ4A/TJ+X+qaGnfkP3d8key5eJ54lqx2fveumR3I4RrFFGYIuubBEH+QGw
        PMcFrcxnMRYmbXXR6kuY0q7ljtGq1MomJA/0bCc0jm6lXasZXgYjFfqIoLlnVldbxZ2Phh
        +7oELvK/Ke1j7/LEzmEmQbao+aD9xfxYxfCLI1e1Pv1ISa9ygiJnukOZhtpYVXgZe7QO0N
        l6SWnLkJVFMENO0RdaKYOAdyEpBLcrKBDQjoIm40yAiCm/gLTbvZ6vSW4m3njQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691416429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ph7RYPSGUyMuFVs2yJ045YytT8AyPZYMy0+K0KiHV3c=;
        b=sFnIZqwJYWUDUa5fF6yrsi+9p88PE8KFWxoTA0yzJBIp0OBhwuhlhCJ0Klz3NwuaWALTYj
        VTrpkk/0b3mQt+DQ==
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
Subject: [patch 48/53] x86/cpu/topology: Retrieve cores per package from
 topology bitmaps
References: <20230807130108.853357011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  7 Aug 2023 15:53:48 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to other sizing information the number of cores per package can be
established from the topology bitmap.

Provide a function for retrieving that information and replace the buggy
hack in the CPUID evaluation with it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/topology.c        |   43 ++++++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/topology.h        |    3 ++
 arch/x86/kernel/cpu/topology_common.c |   18 ++------------
 3 files changed, 49 insertions(+), 15 deletions(-)

--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -227,6 +227,49 @@ int topology_get_logical_id(u32 apicid,
 }
 EXPORT_SYMBOL_GPL(topology_get_logical_id);
 
+/**
+ * topology_unit_count - Retrieve the count of specified units at a given topology domain level
+ * @apicid:		The APIC ID which specifies the search range
+ * @which_units:	The domain level specifying the units to count
+ * @at_level:		The domain level at which @which_units have to be counted
+ *
+ * This returns the number of possible units according to the enumerated
+ * information.
+ *
+ * E.g. topology_count_units(apicid, TOPO_CORE_DOMAIN, TOPO_PKG_DOMAIN)
+ * counts the number of possible cores in the package to which @apicid
+ * belongs.
+ *
+ * @at_level must obviously be greater than @which_level to produce useful
+ * results.  If @at_level is equal to @which_units the result is
+ * unsurprisingly 1. If @at_level is less than @which_units the results
+ * is by definition undefined and the function returns 0.
+ */
+unsigned int topology_unit_count(u32 apicid, enum x86_topology_domains which_units,
+				 enum x86_topology_domains at_level)
+{
+	/* Remove the bits below @at_level to get the proper level ID of @apicid */
+	unsigned int lvlid = topo_apicid(apicid, at_level);
+	unsigned int id, end, cnt = 0;
+
+	if (lvlid >= MAX_LOCAL_APIC)
+		return 0;
+	if (!test_bit(lvlid, apic_maps[at_level].map))
+		return 0;
+	if (which_units > at_level)
+		return 0;
+	if (which_units == at_level)
+		return 1;
+
+	/* Calculate the exclusive end */
+	end = lvlid + (1U << x86_topo_system.dom_shifts[at_level]);
+	/* Unfortunately there is no bitmap_weight_range() */
+	for (id = find_next_bit(apic_maps[which_units].map, end, lvlid);
+	     id < end; id = find_next_bit(apic_maps[which_units].map, end, ++id))
+		cnt++;
+	return cnt;
+}
+
 #ifdef CONFIG_ACPI_HOTPLUG_CPU
 /**
  * topology_hotplug_apic - Handle a physical hotplugged APIC after boot
--- a/arch/x86/kernel/cpu/topology.h
+++ b/arch/x86/kernel/cpu/topology.h
@@ -50,4 +50,7 @@ static inline void topology_update_dom(s
 
 extern const char *domain_names[TOPO_MAX_DOMAIN];
 
+unsigned int topology_unit_count(u32 apicid, enum x86_topology_domains which_units,
+				 enum x86_topology_domains at_level);
+
 #endif /* ARCH_X86_TOPOLOGY_H */
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -154,25 +154,15 @@ static void topo_set_ids(struct topo_sca
 	/* Relative core ID */
 	c->topo.core_id = topo_relative_domain_id(apicid, TOPO_CORE_DOMAIN);
 
+	/* Maximum number of cores on this package */
+	c->x86_max_cores = topology_unit_count(apicid, TOPO_CORE_DOMAIN, TOPO_PKG_DOMAIN);
+
 	c->topo.amd_node_id = tscan->amd_node_id;
 
 	if (c->x86_vendor == X86_VENDOR_AMD)
 		cpu_topology_fixup_amd(tscan);
 }
 
-static void topo_set_max_cores(struct topo_scan *tscan)
-{
-	/*
-	 * Bug compatible for now. This is broken on hybrid systems:
-	 * 8 cores SMT + 8 cores w/o SMT
-	 * tscan.dom_ncpus[TOPO_CORE_DOMAIN] = 24; 24 / 2 = 12 !!
-	 *
-	 * Cannot be fixed without further topology enumeration changes.
-	 */
-	tscan->c->x86_max_cores = tscan->dom_ncpus[TOPO_CORE_DOMAIN] >>
-		x86_topo_system.dom_shifts[TOPO_SMT_DOMAIN];
-}
-
 void cpu_parse_topology(struct cpuinfo_x86 *c)
 {
 	unsigned int dom, cpu = smp_processor_id();
@@ -198,7 +188,6 @@ void cpu_parse_topology(struct cpuinfo_x
 	}
 
 	topo_set_ids(&tscan);
-	topo_set_max_cores(&tscan);
 }
 
 void __init cpu_init_topology(struct cpuinfo_x86 *c)
@@ -220,7 +209,6 @@ void __init cpu_init_topology(struct cpu
 	}
 
 	topo_set_ids(&tscan);
-	topo_set_max_cores(&tscan);
 
 	/*
 	 * AMD systems have Nodes per package which cannot be mapped to

