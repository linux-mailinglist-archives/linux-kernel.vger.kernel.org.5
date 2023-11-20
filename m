Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8877F15D2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbjKTOfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:35:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbjKTOfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:35:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C038F129;
        Mon, 20 Nov 2023 06:35:40 -0800 (PST)
Date:   Mon, 20 Nov 2023 14:35:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1700490939;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QrS+qCG3XTn608zw+XH9bZIKpvqrQ0AZb8qdjowjEu4=;
        b=Zk5bjtaXWfJkp5eyjS0z7bPrucP5mXa3Te7zVr/ykWwJi8TibRhM5nMm1Y947xifykrDvZ
        tUVQKCIE88a0OJpiYSwvf7ABIyif1DHir5xUSydxyKgA1gLGEfgcAOBxGYt3I6hOglJofZ
        ePPeAwCf/F6lXb+GrREuoDAf5J8xGlP+fxIdukPQHTyQavEP/TQKz7OYME5+f9Q4Iu+NNB
        MErmK0OSkQTcBs6yLozeX6rcdRKN8pdITlA0YFgqWpfyvn33BDUysifUIO+XmBDK6Eo0Qy
        TBS0XHlnkov+EMpSXdCwfNkVtsFiUjmdjr9o5UIcTeM4tAekw2SCQ2IomKEdUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1700490939;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QrS+qCG3XTn608zw+XH9bZIKpvqrQ0AZb8qdjowjEu4=;
        b=2N952IGtnI+tkJ7ce/ooGqUGE7sCB/+MRqB6c2jhDH1q9MxY72WiI+cCTdPsGp8YVmu8gN
        RnfpVmjlYLskyFCw==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/cstate: Add Sierra Forest support
Cc:     Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231116142245.1233485-3-kan.liang@linux.intel.com>
References: <20231116142245.1233485-3-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <170049093867.398.10266740024479108325.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     3877d55a0db2688c2e4ab8a319614a0c81f8e2d2
Gitweb:        https://git.kernel.org/tip/3877d55a0db2688c2e4ab8a319614a0c81f8e2d2
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 16 Nov 2023 06:22:44 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 17 Nov 2023 10:54:53 +01:00

perf/x86/intel/cstate: Add Sierra Forest support

A new module C6 Residency Counter is introduced in the Sierra Forest.
The scope of the new counter is module (A cluster of cores shared L2
cache). Create a brand new cstate_module PMU to profile the new counter.
The only differences between the new cstate_module PMU and the existing
cstate PMU are the scope and events.

Regarding the choice of the new cstate_module PMU name, the current
naming rule of a cstate PMU is "cstate_" + the scope of the PMU. The
scope of the PMU is the cores shared L2. On SRF, Intel calls it
"module", while the internal Linux sched code calls it "cluster". The
"cstate_module" is used as the new PMU name, because
- The Cstate PMU driver is a Intel specific driver. It doesn't impact
  other ARCHs. The name makes it consistent with the documentation.
- The "cluster" mainly be used by the scheduler developer, while the
  user of cstate PMU is more likely a researcher reading HW docs and
  optimizing power.
- In the Intel's SDM, the "cluster" has a different meaning/scope for
  topology. Using it will mislead the end users.

Besides the module C6, the core C1/C6 and pkg C6 residency counters are
supported in the Sierra Forest as well.

Suggested-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20231116142245.1233485-3-kan.liang@linux.intel.com
---
 arch/x86/events/intel/cstate.c | 113 ++++++++++++++++++++++++++++++--
 1 file changed, 109 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 693bdcd..4a46ef3 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -41,7 +41,7 @@
  *	MSR_CORE_C1_RES: CORE C1 Residency Counter
  *			 perf code: 0x00
  *			 Available model: SLM,AMT,GLM,CNL,ICX,TNT,ADL,RPL
- *					  MTL
+ *					  MTL,SRF
  *			 Scope: Core (each processor core has a MSR)
  *	MSR_CORE_C3_RESIDENCY: CORE C3 Residency Counter
  *			       perf code: 0x01
@@ -52,7 +52,7 @@
  *			       perf code: 0x02
  *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
  *						SKL,KNL,GLM,CNL,KBL,CML,ICL,ICX,
- *						TGL,TNT,RKL,ADL,RPL,SPR,MTL
+ *						TGL,TNT,RKL,ADL,RPL,SPR,MTL,SRF
  *			       Scope: Core
  *	MSR_CORE_C7_RESIDENCY: CORE C7 Residency Counter
  *			       perf code: 0x03
@@ -75,7 +75,7 @@
  *			       perf code: 0x02
  *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
  *						SKL,KNL,GLM,CNL,KBL,CML,ICL,ICX,
- *						TGL,TNT,RKL,ADL,RPL,SPR,MTL
+ *						TGL,TNT,RKL,ADL,RPL,SPR,MTL,SRF
  *			       Scope: Package (physical package)
  *	MSR_PKG_C7_RESIDENCY:  Package C7 Residency Counter.
  *			       perf code: 0x03
@@ -97,6 +97,10 @@
  *			       Available model: HSW ULT,KBL,GLM,CNL,CML,ICL,TGL,
  *						TNT,RKL,ADL,RPL,MTL
  *			       Scope: Package (physical package)
+ *	MSR_MODULE_C6_RES_MS:  Module C6 Residency Counter.
+ *			       perf code: 0x00
+ *			       Available model: SRF
+ *			       Scope: A cluster of cores shared L2 cache
  *
  */
 
@@ -130,6 +134,7 @@ static ssize_t cstate_get_attr_cpumask(struct device *dev,
 struct cstate_model {
 	unsigned long		core_events;
 	unsigned long		pkg_events;
+	unsigned long		module_events;
 	unsigned long		quirks;
 };
 
@@ -270,6 +275,28 @@ static struct perf_msr pkg_msr[] = {
 
 static cpumask_t cstate_pkg_cpu_mask;
 
+/* cstate_module PMU */
+static struct pmu cstate_module_pmu;
+static bool has_cstate_module;
+
+enum perf_cstate_module_events {
+	PERF_CSTATE_MODULE_C6_RES = 0,
+
+	PERF_CSTATE_MODULE_EVENT_MAX,
+};
+
+PMU_EVENT_ATTR_STRING(c6-residency, attr_cstate_module_c6, "event=0x00");
+
+static unsigned long module_msr_mask;
+
+PMU_EVENT_GROUP(events, cstate_module_c6);
+
+static struct perf_msr module_msr[] = {
+	[PERF_CSTATE_MODULE_C6_RES]  = { MSR_MODULE_C6_RES_MS,	&group_cstate_module_c6,	test_msr },
+};
+
+static cpumask_t cstate_module_cpu_mask;
+
 static ssize_t cstate_get_attr_cpumask(struct device *dev,
 				       struct device_attribute *attr,
 				       char *buf)
@@ -280,6 +307,8 @@ static ssize_t cstate_get_attr_cpumask(struct device *dev,
 		return cpumap_print_to_pagebuf(true, buf, &cstate_core_cpu_mask);
 	else if (pmu == &cstate_pkg_pmu)
 		return cpumap_print_to_pagebuf(true, buf, &cstate_pkg_cpu_mask);
+	else if (pmu == &cstate_module_pmu)
+		return cpumap_print_to_pagebuf(true, buf, &cstate_module_cpu_mask);
 	else
 		return 0;
 }
@@ -320,6 +349,15 @@ static int cstate_pmu_event_init(struct perf_event *event)
 		event->hw.event_base = pkg_msr[cfg].msr;
 		cpu = cpumask_any_and(&cstate_pkg_cpu_mask,
 				      topology_die_cpumask(event->cpu));
+	} else if (event->pmu == &cstate_module_pmu) {
+		if (cfg >= PERF_CSTATE_MODULE_EVENT_MAX)
+			return -EINVAL;
+		cfg = array_index_nospec((unsigned long)cfg, PERF_CSTATE_MODULE_EVENT_MAX);
+		if (!(module_msr_mask & (1 << cfg)))
+			return -EINVAL;
+		event->hw.event_base = module_msr[cfg].msr;
+		cpu = cpumask_any_and(&cstate_module_cpu_mask,
+				      topology_cluster_cpumask(event->cpu));
 	} else {
 		return -ENOENT;
 	}
@@ -407,6 +445,17 @@ static int cstate_cpu_exit(unsigned int cpu)
 			perf_pmu_migrate_context(&cstate_pkg_pmu, cpu, target);
 		}
 	}
+
+	if (has_cstate_module &&
+	    cpumask_test_and_clear_cpu(cpu, &cstate_module_cpu_mask)) {
+
+		target = cpumask_any_but(topology_cluster_cpumask(cpu), cpu);
+		/* Migrate events if there is a valid target */
+		if (target < nr_cpu_ids) {
+			cpumask_set_cpu(target, &cstate_module_cpu_mask);
+			perf_pmu_migrate_context(&cstate_module_pmu, cpu, target);
+		}
+	}
 	return 0;
 }
 
@@ -433,6 +482,15 @@ static int cstate_cpu_init(unsigned int cpu)
 	if (has_cstate_pkg && target >= nr_cpu_ids)
 		cpumask_set_cpu(cpu, &cstate_pkg_cpu_mask);
 
+	/*
+	 * If this is the first online thread of that cluster, set it
+	 * in the cluster cpu mask as the designated reader.
+	 */
+	target = cpumask_any_and(&cstate_module_cpu_mask,
+				 topology_cluster_cpumask(cpu));
+	if (has_cstate_module && target >= nr_cpu_ids)
+		cpumask_set_cpu(cpu, &cstate_module_cpu_mask);
+
 	return 0;
 }
 
@@ -455,6 +513,11 @@ static const struct attribute_group *pkg_attr_update[] = {
 	NULL,
 };
 
+static const struct attribute_group *module_attr_update[] = {
+	&group_cstate_module_c6,
+	NULL
+};
+
 static struct pmu cstate_core_pmu = {
 	.attr_groups	= cstate_attr_groups,
 	.attr_update	= core_attr_update,
@@ -485,6 +548,21 @@ static struct pmu cstate_pkg_pmu = {
 	.module		= THIS_MODULE,
 };
 
+static struct pmu cstate_module_pmu = {
+	.attr_groups	= cstate_attr_groups,
+	.attr_update	= module_attr_update,
+	.name		= "cstate_module",
+	.task_ctx_nr	= perf_invalid_context,
+	.event_init	= cstate_pmu_event_init,
+	.add		= cstate_pmu_event_add,
+	.del		= cstate_pmu_event_del,
+	.start		= cstate_pmu_event_start,
+	.stop		= cstate_pmu_event_stop,
+	.read		= cstate_pmu_event_update,
+	.capabilities	= PERF_PMU_CAP_NO_INTERRUPT | PERF_PMU_CAP_NO_EXCLUDE,
+	.module		= THIS_MODULE,
+};
+
 static const struct cstate_model nhm_cstates __initconst = {
 	.core_events		= BIT(PERF_CSTATE_CORE_C3_RES) |
 				  BIT(PERF_CSTATE_CORE_C6_RES),
@@ -599,6 +677,15 @@ static const struct cstate_model glm_cstates __initconst = {
 				  BIT(PERF_CSTATE_PKG_C10_RES),
 };
 
+static const struct cstate_model srf_cstates __initconst = {
+	.core_events		= BIT(PERF_CSTATE_CORE_C1_RES) |
+				  BIT(PERF_CSTATE_CORE_C6_RES),
+
+	.pkg_events		= BIT(PERF_CSTATE_PKG_C6_RES),
+
+	.module_events		= BIT(PERF_CSTATE_MODULE_C6_RES),
+};
+
 
 static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(NEHALEM,		&nhm_cstates),
@@ -651,6 +738,7 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT,	&glm_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_L,	&glm_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GRACEMONT,	&adl_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_CRESTMONT_X,	&srf_cstates),
 
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_L,		&icl_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE,		&icl_cstates),
@@ -692,10 +780,14 @@ static int __init cstate_probe(const struct cstate_model *cm)
 	pkg_msr_mask = perf_msr_probe(pkg_msr, PERF_CSTATE_PKG_EVENT_MAX,
 				      true, (void *) &cm->pkg_events);
 
+	module_msr_mask = perf_msr_probe(module_msr, PERF_CSTATE_MODULE_EVENT_MAX,
+				      true, (void *) &cm->module_events);
+
 	has_cstate_core = !!core_msr_mask;
 	has_cstate_pkg  = !!pkg_msr_mask;
+	has_cstate_module  = !!module_msr_mask;
 
-	return (has_cstate_core || has_cstate_pkg) ? 0 : -ENODEV;
+	return (has_cstate_core || has_cstate_pkg || has_cstate_module) ? 0 : -ENODEV;
 }
 
 static inline void cstate_cleanup(void)
@@ -708,6 +800,9 @@ static inline void cstate_cleanup(void)
 
 	if (has_cstate_pkg)
 		perf_pmu_unregister(&cstate_pkg_pmu);
+
+	if (has_cstate_module)
+		perf_pmu_unregister(&cstate_module_pmu);
 }
 
 static int __init cstate_init(void)
@@ -744,6 +839,16 @@ static int __init cstate_init(void)
 			return err;
 		}
 	}
+
+	if (has_cstate_module) {
+		err = perf_pmu_register(&cstate_module_pmu, cstate_module_pmu.name, -1);
+		if (err) {
+			has_cstate_module = false;
+			pr_info("Failed to register cstate cluster pmu\n");
+			cstate_cleanup();
+			return err;
+		}
+	}
 	return 0;
 }
 
