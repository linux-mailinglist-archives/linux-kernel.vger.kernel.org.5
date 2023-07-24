Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0547975FE28
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 19:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjGXRpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 13:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbjGXRob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:44:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC4419BA;
        Mon, 24 Jul 2023 10:44:06 -0700 (PDT)
Message-ID: <20230724172844.220566075@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690220645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=skYZWeSKFejqJKJ3o0gQ5nxraXU88Lyk+hKEUORa/8k=;
        b=aOy8VWeIxoAwZdpAQrqhVbWhtdzUrpMqacGqYTtzJ83hWFD+6uXpw0cWCXRAnYqG+ROtgt
        G0WoKyWAQiKgk/LgNaNTKlyZeud9aOkpZ+XrjaA3cZmFIjIpU0HG1yMurVk9rPrXOPsrUB
        afK1MO/qWMn4RU6cMRAftUv2stdgZeGaUT/sfSlv0MZXR/568D1fc0aUFfVkK80gEk4krT
        FMnqpQ7c/oWGPvVil6+Nhp1aFVGHvYzLJjxmGdzjboW65b+SOAnljAMj0uekrBfB5n3lvp
        Q+Q0+4coblZK9FVzPEm/4fJp5YFPLnOfTKrE0dF0ZDPPEjMuw9gbcvGPriuhtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690220645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=skYZWeSKFejqJKJ3o0gQ5nxraXU88Lyk+hKEUORa/8k=;
        b=ZkBlJUEqTX8oYOw/OspLCoIOeblmg0GsFMKhk4a9Z+bBXCoXM6wRt2xDK7DfZ0PLog44rr
        1L+1znScbSbnaiCA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Huang Rui <ray.huang@amd.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>
Subject: [patch 09/29] x86/cpu: Move logical package and die IDs into topology
 info
References: <20230724155329.474037902@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 24 Jul 2023 19:44:04 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yet another topology related data pair. Rename logical_proc_id to
logical_pkg_id so it fits the common naming conventions.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 Documentation/arch/x86/topology.rst |    2 +-
 arch/x86/events/intel/uncore.c      |    2 +-
 arch/x86/include/asm/processor.h    |    8 ++++----
 arch/x86/include/asm/topology.h     |    4 ++--
 arch/x86/kernel/cpu/common.c        |    2 +-
 arch/x86/kernel/smpboot.c           |    8 ++++----
 6 files changed, 13 insertions(+), 13 deletions(-)

--- a/Documentation/arch/x86/topology.rst
+++ b/Documentation/arch/x86/topology.rst
@@ -67,7 +67,7 @@ AMD nomenclature for package is 'Node'.
     Modern systems use this value for the socket. There may be multiple
     packages within a socket. This value may differ from topo.die_id.
 
-  - cpuinfo_x86.logical_proc_id:
+  - cpuinfo_x86.topo.logical_pkg_id:
 
     The logical ID of the package. As we do not trust BIOSes to enumerate the
     packages in a consistent way, we introduced the concept of logical package
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -74,7 +74,7 @@ int uncore_device_to_die(struct pci_dev
 		struct cpuinfo_x86 *c = &cpu_data(cpu);
 
 		if (c->initialized && cpu_to_node(cpu) == node)
-			return c->logical_die_id;
+			return c->topo.logical_die_id;
 	}
 
 	return -1;
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -92,6 +92,10 @@ struct cpuinfo_topology {
 
 	// Core ID relative to the package
 	u16			core_id;
+
+	// Logical ID mappings
+	u16			logical_pkg_id;
+	u16			logical_die_id;
 };
 
 struct cpuinfo_x86 {
@@ -142,10 +146,6 @@ struct cpuinfo_x86 {
 	u16			x86_clflush_size;
 	/* number of cores as seen by the OS: */
 	u16			booted_cores;
-	/* Logical processor id: */
-	u16			logical_proc_id;
-	/* Core id: */
-	u16			logical_die_id;
 	/* Index into per_cpu list: */
 	u16			cpu_index;
 	/*  Is SMT active on this core? */
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -105,9 +105,9 @@ static inline void setup_node_to_cpumask
 extern const struct cpumask *cpu_coregroup_mask(int cpu);
 extern const struct cpumask *cpu_clustergroup_mask(int cpu);
 
-#define topology_logical_package_id(cpu)	(cpu_data(cpu).logical_proc_id)
+#define topology_logical_package_id(cpu)	(cpu_data(cpu).topo.logical_pkg_id)
 #define topology_physical_package_id(cpu)	(cpu_data(cpu).topo.pkg_id)
-#define topology_logical_die_id(cpu)		(cpu_data(cpu).logical_die_id)
+#define topology_logical_die_id(cpu)		(cpu_data(cpu).topo.logical_die_id)
 #define topology_die_id(cpu)			(cpu_data(cpu).topo.die_id)
 #define topology_core_id(cpu)			(cpu_data(cpu).topo.core_id)
 #define topology_ppin(cpu)			(cpu_data(cpu).ppin)
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1770,7 +1770,7 @@ static void validate_apic_and_package_id
 	BUG_ON(topology_update_package_map(c->topo.pkg_id, cpu));
 	BUG_ON(topology_update_die_map(c->topo.die_id, cpu));
 #else
-	c->logical_proc_id = 0;
+	c->topo.logical_pkg_id = 0;
 #endif
 }
 
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -348,7 +348,7 @@ int topology_phys_to_logical_pkg(unsigne
 		struct cpuinfo_x86 *c = &cpu_data(cpu);
 
 		if (c->initialized && c->topo.pkg_id == phys_pkg)
-			return c->logical_proc_id;
+			return c->topo.logical_pkg_id;
 	}
 	return -1;
 }
@@ -370,7 +370,7 @@ static int topology_phys_to_logical_die(
 
 		if (c->initialized && c->topo.die_id == die_id &&
 		    c->topo.pkg_id == proc_id)
-			return c->logical_die_id;
+			return c->topo.logical_die_id;
 	}
 	return -1;
 }
@@ -395,7 +395,7 @@ int topology_update_package_map(unsigned
 			cpu, pkg, new);
 	}
 found:
-	cpu_data(cpu).logical_proc_id = new;
+	cpu_data(cpu).topo.logical_pkg_id = new;
 	return 0;
 }
 /**
@@ -418,7 +418,7 @@ int topology_update_die_map(unsigned int
 			cpu, die, new);
 	}
 found:
-	cpu_data(cpu).logical_die_id = new;
+	cpu_data(cpu).topo.logical_die_id = new;
 	return 0;
 }
 

