Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF147905E1
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 09:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351771AbjIBHou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 03:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbjIBHos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 03:44:48 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951091702;
        Sat,  2 Sep 2023 00:44:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A0AB3CE23F6;
        Sat,  2 Sep 2023 07:44:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943C5C433C7;
        Sat,  2 Sep 2023 07:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693640681;
        bh=3GnpFDM/i6NMgad+8/eGE8jqvreCE/gETJ2KQKeants=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gzpayze2Hxjm2vmaEqjhgRtLfbHWngQtCLPhTlae4zCEyPlHXsFUVil0IF6duVlqC
         /9WebOZYdhwlZfRGR4s84bRLu3blws4pO4/YZFrBuM7AEC4uM49NsZWKlKpo3Qka57
         QmvqOpDZr1ZOjci/d/Q6A8siFFt8d0V+rYDOx9ZQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.15.130
Date:   Sat,  2 Sep 2023 09:44:37 +0200
Message-ID: <2023090236-waviness-spongy-9d39@gregkh>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <2023090235-bobble-pound-ae28@gregkh>
References: <2023090235-bobble-pound-ae28@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index bb78526120f3..2cd4d66ab64c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5770,10 +5770,6 @@
 			-1: disable all critical trip points in all thermal zones
 			<degrees C>: override all critical trip points
 
-	thermal.nocrt=	[HW,ACPI]
-			Set to disable actions on ACPI thermal zone
-			critical and hot trip points.
-
 	thermal.off=	[HW,ACPI]
 			1: disable ACPI thermal control
 
diff --git a/Makefile b/Makefile
index 96c3f014094b..08cc0832e4d1 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 129
+SUBLEVEL = 130
 EXTRAVERSION =
 NAME = Trick or Treat
 
diff --git a/arch/arm/kernel/module-plts.c b/arch/arm/kernel/module-plts.c
index 1fc309b41f94..8d809724cde5 100644
--- a/arch/arm/kernel/module-plts.c
+++ b/arch/arm/kernel/module-plts.c
@@ -256,7 +256,7 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 		/* sort by type and symbol index */
 		sort(rels, numrels, sizeof(Elf32_Rel), cmp_rel, NULL);
 
-		if (strncmp(secstrings + dstsec->sh_name, ".init", 5) != 0)
+		if (!module_init_layout_section(secstrings + dstsec->sh_name))
 			core_plts += count_plts(syms, dstsec->sh_addr, rels,
 						numrels, s->sh_info);
 		else
diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module-plts.c
index e53493d8b208..08fcbcb40d88 100644
--- a/arch/arm64/kernel/module-plts.c
+++ b/arch/arm64/kernel/module-plts.c
@@ -7,6 +7,7 @@
 #include <linux/ftrace.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/moduleloader.h>
 #include <linux/sort.h>
 
 static struct plt_entry __get_adrp_add_pair(u64 dst, u64 pc,
@@ -342,7 +343,7 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 		if (nents)
 			sort(rels, nents, sizeof(Elf64_Rela), cmp_rela, NULL);
 
-		if (!str_has_prefix(secstrings + dstsec->sh_name, ".init"))
+		if (!module_init_layout_section(secstrings + dstsec->sh_name))
 			core_plts += count_plts(syms, rels, numrels,
 						sechdrs[i].sh_info, dstsec);
 		else
diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 155bbabcc6f5..809e12b94123 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -59,10 +59,6 @@ static int tzp;
 module_param(tzp, int, 0444);
 MODULE_PARM_DESC(tzp, "Thermal zone polling frequency, in 1/10 seconds.");
 
-static int nocrt;
-module_param(nocrt, int, 0);
-MODULE_PARM_DESC(nocrt, "Set to take no action upon ACPI thermal zone critical trips points.");
-
 static int off;
 module_param(off, int, 0);
 MODULE_PARM_DESC(off, "Set to disable ACPI thermal support.");
@@ -1132,7 +1128,7 @@ static int thermal_nocrt(const struct dmi_system_id *d) {
 
 	pr_notice("%s detected: disabling all critical thermal trip point actions.\n",
 		  d->ident);
-	nocrt = 1;
+	crt = -1;
 	return 0;
 }
 static int thermal_tzp(const struct dmi_system_id *d) {
diff --git a/include/linux/moduleloader.h b/include/linux/moduleloader.h
index 9e09d11ffe5b..1322652a9d0d 100644
--- a/include/linux/moduleloader.h
+++ b/include/linux/moduleloader.h
@@ -39,6 +39,11 @@ bool module_init_section(const char *name);
  */
 bool module_exit_section(const char *name);
 
+/* Describes whether within_module_init() will consider this an init section
+ * or not. This behaviour changes with CONFIG_MODULE_UNLOAD.
+ */
+bool module_init_layout_section(const char *sname);
+
 /*
  * Apply the given relocation to the (simplified) ELF.  Return -error
  * or 0.
diff --git a/kernel/module.c b/kernel/module.c
index 8a1766c69c6e..ed96295cc114 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2407,7 +2407,7 @@ static long get_offset(struct module *mod, unsigned int *size,
 	return ret;
 }
 
-static bool module_init_layout_section(const char *sname)
+bool module_init_layout_section(const char *sname)
 {
 #ifndef CONFIG_MODULE_UNLOAD
 	if (module_exit_section(sname))
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 94b8ee84bc78..28f628c70245 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -951,7 +951,7 @@ static void trc_read_check_handler(void *t_in)
 static bool trc_inspect_reader(struct task_struct *t, void *arg)
 {
 	int cpu = task_cpu(t);
-	bool in_qs = false;
+	int nesting;
 	bool ofl = cpu_is_offline(cpu);
 
 	if (task_curr(t)) {
@@ -971,18 +971,18 @@ static bool trc_inspect_reader(struct task_struct *t, void *arg)
 		n_heavy_reader_updates++;
 		if (ofl)
 			n_heavy_reader_ofl_updates++;
-		in_qs = true;
+		nesting = 0;
 	} else {
 		// The task is not running, so C-language access is safe.
-		in_qs = likely(!t->trc_reader_nesting);
+		nesting = t->trc_reader_nesting;
 	}
 
-	// Mark as checked so that the grace-period kthread will
-	// remove it from the holdout list.
-	t->trc_reader_checked = true;
-
-	if (in_qs)
-		return true;  // Already in quiescent state, done!!!
+	// If not exiting a read-side critical section, mark as checked
+	// so that the grace-period kthread will remove it from the
+	// holdout list.
+	t->trc_reader_checked = nesting >= 0;
+	if (nesting <= 0)
+		return !nesting;  // If in QS, done, otherwise try again later.
 
 	// The task is in a read-side critical section, so set up its
 	// state so that it will awaken the grace-period kthread upon exit
@@ -1041,9 +1041,11 @@ static void trc_wait_for_one_reader(struct task_struct *t,
 		if (smp_call_function_single(cpu, trc_read_check_handler, t, 0)) {
 			// Just in case there is some other reason for
 			// failure than the target CPU being offline.
+			WARN_ONCE(1, "%s():  smp_call_function_single() failed for CPU: %d\n",
+				  __func__, cpu);
 			rcu_tasks_trace.n_ipis_fails++;
 			per_cpu(trc_ipi_to_cpu, cpu) = false;
-			t->trc_ipi_to_cpu = cpu;
+			t->trc_ipi_to_cpu = -1;
 		}
 	}
 }
@@ -1164,14 +1166,28 @@ static void check_all_holdout_tasks_trace(struct list_head *hop,
 	}
 }
 
+static void rcu_tasks_trace_empty_fn(void *unused)
+{
+}
+
 /* Wait for grace period to complete and provide ordering. */
 static void rcu_tasks_trace_postgp(struct rcu_tasks *rtp)
 {
+	int cpu;
 	bool firstreport;
 	struct task_struct *g, *t;
 	LIST_HEAD(holdouts);
 	long ret;
 
+	// Wait for any lingering IPI handlers to complete.  Note that
+	// if a CPU has gone offline or transitioned to userspace in the
+	// meantime, all IPI handlers should have been drained beforehand.
+	// Yes, this assumes that CPUs process IPIs in order.  If that ever
+	// changes, there will need to be a recheck and/or timed wait.
+	for_each_online_cpu(cpu)
+		if (smp_load_acquire(per_cpu_ptr(&trc_ipi_to_cpu, cpu)))
+			smp_call_function_single(cpu, rcu_tasks_trace_empty_fn, NULL, 1);
+
 	// Remove the safety count.
 	smp_mb__before_atomic();  // Order vs. earlier atomics
 	atomic_dec(&trc_n_readers_need_end);
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index f46c0c1a5eb3..407941a2903b 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -507,7 +507,10 @@ static void synchronize_rcu_expedited_wait(void)
 				if (rdp->rcu_forced_tick_exp)
 					continue;
 				rdp->rcu_forced_tick_exp = true;
-				tick_dep_set_cpu(cpu, TICK_DEP_BIT_RCU_EXP);
+				preempt_disable();
+				if (cpu_online(cpu))
+					tick_dep_set_cpu(cpu, TICK_DEP_BIT_RCU_EXP);
+				preempt_enable();
 			}
 		}
 		j = READ_ONCE(jiffies_till_first_fqs);
