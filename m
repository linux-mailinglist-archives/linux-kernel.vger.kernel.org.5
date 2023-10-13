Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76877C8247
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjJMJii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 05:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbjJMJiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:38:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66679C9;
        Fri, 13 Oct 2023 02:38:10 -0700 (PDT)
Date:   Fri, 13 Oct 2023 09:38:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697189889;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p5yLutIQPnUf+mNNxzq24/4l8BXttTsKaO4NbA7slGE=;
        b=fKsgRkbHLswMqN0E00y9DNP3xmp7hARLWM4EPoZ7Hs4E+bil8nvsYcPGzEpEguhozr7GYW
        G5imlgKtZRYRdV+WiMYpOaUsZUd3ZtBkDNfUti3zCNPDIRrWNP+i21dciox1xBYHzUNC2n
        NCuLz41e2HSaHew5FhAjFRlKSF7Uu4c1CbEmDYfLkTJJx+yTHuJaO8/oqLFhH8NTKr8Ohi
        ZiX+12A+c40/X07Rmgt7q3Hh/LXJ0gzVzB3kwYc8GujYw6Flx0dR0iUj73vPDZaGtQmakL
        WupmFln3hiVQjYqiJV228CqTlmd2qCknm8espxg0kJXwhovHs3xo4yPFauJwZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697189889;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p5yLutIQPnUf+mNNxzq24/4l8BXttTsKaO4NbA7slGE=;
        b=0feIaNZPnCt9OdT6e2tabClXh6etzhAygxNQTpPsheHK/Zn5iXGIZjPVXECyqZOySWWONt
        yM72FpoVlaORRHBQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/cpu: Move logical package and die IDs into topology info
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Juergen Gross <jgross@suse.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230814085112.745139505@linutronix.de>
References: <20230814085112.745139505@linutronix.de>
MIME-Version: 1.0
Message-ID: <169718988833.3135.1156832342181364377.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     22dc9631625352426cd665f4e3f8fe0d793b2bf5
Gitweb:        https://git.kernel.org/tip/22dc9631625352426cd665f4e3f8fe0d793b2bf5
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 14 Aug 2023 10:18:37 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Oct 2023 14:38:18 +02:00

x86/cpu: Move logical package and die IDs into topology info

Yet another topology related data pair. Rename logical_proc_id to
logical_pkg_id so it fits the common naming conventions.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mikelley@microsoft.com>
Tested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230814085112.745139505@linutronix.de

---
 Documentation/arch/x86/topology.rst | 2 +-
 arch/x86/events/intel/uncore.c      | 2 +-
 arch/x86/include/asm/processor.h    | 8 ++++----
 arch/x86/include/asm/topology.h     | 4 ++--
 arch/x86/kernel/cpu/common.c        | 2 +-
 arch/x86/kernel/smpboot.c           | 8 ++++----
 6 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/arch/x86/topology.rst b/Documentation/arch/x86/topology.rst
index ff36e52..88f29ba 100644
--- a/Documentation/arch/x86/topology.rst
+++ b/Documentation/arch/x86/topology.rst
@@ -67,7 +67,7 @@ Package-related topology information in the kernel:
     Modern systems use this value for the socket. There may be multiple
     packages within a socket. This value may differ from topo.die_id.
 
-  - cpuinfo_x86.logical_proc_id:
+  - cpuinfo_x86.topo.logical_pkg_id:
 
     The logical ID of the package. As we do not trust BIOSes to enumerate the
     packages in a consistent way, we introduced the concept of logical package
diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 69043e0..01023aa 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -74,7 +74,7 @@ int uncore_device_to_die(struct pci_dev *dev)
 		struct cpuinfo_x86 *c = &cpu_data(cpu);
 
 		if (c->initialized && cpu_to_node(cpu) == node)
-			return c->logical_die_id;
+			return c->topo.logical_die_id;
 	}
 
 	return -1;
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 517d0bc..b2cf309 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -95,6 +95,10 @@ struct cpuinfo_topology {
 
 	// Core ID relative to the package
 	u32			core_id;
+
+	// Logical ID mappings
+	u32			logical_pkg_id;
+	u32			logical_die_id;
 };
 
 struct cpuinfo_x86 {
@@ -145,10 +149,6 @@ struct cpuinfo_x86 {
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
diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 7fa567c..ac0c274 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -105,9 +105,9 @@ static inline void setup_node_to_cpumask_map(void) { }
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
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 106b27f..052bd79 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1810,7 +1810,7 @@ static void validate_apic_and_package_id(struct cpuinfo_x86 *c)
 	BUG_ON(topology_update_package_map(c->topo.pkg_id, cpu));
 	BUG_ON(topology_update_die_map(c->topo.die_id, cpu));
 #else
-	c->logical_proc_id = 0;
+	c->topo.logical_pkg_id = 0;
 #endif
 }
 
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 17b86f4..82a30d0 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -340,7 +340,7 @@ int topology_phys_to_logical_pkg(unsigned int phys_pkg)
 		struct cpuinfo_x86 *c = &cpu_data(cpu);
 
 		if (c->initialized && c->topo.pkg_id == phys_pkg)
-			return c->logical_proc_id;
+			return c->topo.logical_pkg_id;
 	}
 	return -1;
 }
@@ -362,7 +362,7 @@ static int topology_phys_to_logical_die(unsigned int die_id, unsigned int cur_cp
 
 		if (c->initialized && c->topo.die_id == die_id &&
 		    c->topo.pkg_id == proc_id)
-			return c->logical_die_id;
+			return c->topo.logical_die_id;
 	}
 	return -1;
 }
@@ -387,7 +387,7 @@ int topology_update_package_map(unsigned int pkg, unsigned int cpu)
 			cpu, pkg, new);
 	}
 found:
-	cpu_data(cpu).logical_proc_id = new;
+	cpu_data(cpu).topo.logical_pkg_id = new;
 	return 0;
 }
 /**
@@ -410,7 +410,7 @@ int topology_update_die_map(unsigned int die, unsigned int cpu)
 			cpu, die, new);
 	}
 found:
-	cpu_data(cpu).logical_die_id = new;
+	cpu_data(cpu).topo.logical_die_id = new;
 	return 0;
 }
 
