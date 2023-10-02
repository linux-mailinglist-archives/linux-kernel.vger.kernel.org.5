Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7B5A7B5201
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 14:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236994AbjJBMAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 08:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236930AbjJBMAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 08:00:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27FECE2
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 05:00:01 -0700 (PDT)
Message-ID: <20231002115903.262232260@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696248000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=UeM0gcDdtu4Q5hOuXaPXZf9xAZkloT57pR5hJH36+Rc=;
        b=gyoomB8v9yabLuugTqV7UwkLzKxpy1ov0uqx7ak5dgTt15CA1w4mCV8dTmxyUAIydaklkc
        aiImilkXe6dfcsoMdpshfLbGYob7/d0vpOwrRF0ULT4I3Ys1IaVil8CT7vZ6lfuyFsDHmo
        KWyCDbMFHIrJvN108d5rOL4h2mis8+IHUGK6UiaIjueDUnM2OThRsqmCMyE8EeMhI1/w3P
        WC2vg9ntcr0TS85Kuwem810cY01eOC42G3bh39Kwe6szsLGBdTSvDRc2rj32dYvqXI4WgL
        RFBRkj80NgpbIvnTAx5jpxTcFfbCePm7lFm9m9ozA/3Wt2KyeVFMTqtoA47r0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696248000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=UeM0gcDdtu4Q5hOuXaPXZf9xAZkloT57pR5hJH36+Rc=;
        b=SV32byAJsV8WRpZ3dg1PKJ64cQnSshlQggUX3HSFrvr50GoHgDLUDkYvp5v9GKSg3Hln+h
        vQjek7ipJwgkcHCw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [patch V4 21/30] x86/microcode: Add per CPU result state
References: <20231002115506.217091296@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  2 Oct 2023 14:00:00 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The microcode rendevouz is purely acting on global state, which does not
allow to analyze fails in a coherent way.

Introduce per CPU state where the results are written into, which allows to
analyze the return codes of the individual CPUs.

Initialize the state when walking the cpu_present_mask in the online check
to avoid another for_each_cpu() loop.

Enhance the result print out with that.

The structure is intentionally named ucode_ctrl as it will gain control
fields in subsequent changes.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/kernel/cpu/microcode/core.c     |  112 ++++++++++++++++++-------------
 arch/x86/kernel/cpu/microcode/internal.h |    1 
 2 files changed, 67 insertions(+), 46 deletions(-)
---
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -281,6 +281,11 @@ static struct platform_device	*microcode
  *   requirement can be relaxed in the future. Right now, this is conservative
  *   and good.
  */
+struct microcode_ctrl {
+	enum ucode_state	result;
+};
+
+static DEFINE_PER_CPU(struct microcode_ctrl, ucode_ctrl);
 static atomic_t late_cpus_in, late_cpus_out;
 
 static bool wait_for_cpus(atomic_t *cnt)
@@ -303,23 +308,19 @@ static bool wait_for_cpus(atomic_t *cnt)
 	return false;
 }
 
-/*
- * Returns:
- * < 0 - on error
- *   0 - success (no update done or microcode was updated)
- */
-static int __reload_late(void *info)
+static int load_cpus_stopped(void *unused)
 {
 	int cpu = smp_processor_id();
-	enum ucode_state err;
-	int ret = 0;
+	enum ucode_state ret;
 
 	/*
 	 * Wait for all CPUs to arrive. A load will not be attempted unless all
 	 * CPUs show up.
 	 * */
-	if (!wait_for_cpus(&late_cpus_in))
-		return -1;
+	if (!wait_for_cpus(&late_cpus_in)) {
+		this_cpu_write(ucode_ctrl.result, UCODE_TIMEOUT);
+		return 0;
+	}
 
 	/*
 	 * On an SMT system, it suffices to load the microcode on one sibling of
@@ -328,17 +329,11 @@ static int __reload_late(void *info)
 	 * loading attempts happen on multiple threads of an SMT core. See
 	 * below.
 	 */
-	if (cpumask_first(topology_sibling_cpumask(cpu)) == cpu)
-		err = microcode_ops->apply_microcode(cpu);
-	else
+	if (cpumask_first(topology_sibling_cpumask(cpu)) != cpu)
 		goto wait_for_siblings;
 
-	if (err >= UCODE_NFOUND) {
-		if (err == UCODE_ERROR) {
-			pr_warn("Error reloading microcode on CPU %d\n", cpu);
-			ret = -1;
-		}
-	}
+	ret = microcode_ops->apply_microcode(cpu);
+	this_cpu_write(ucode_ctrl.result, ret);
 
 wait_for_siblings:
 	if (!wait_for_cpus(&late_cpus_out))
@@ -350,19 +345,18 @@ static int __reload_late(void *info)
 	 * per-cpu cpuinfo can be updated with right microcode
 	 * revision.
 	 */
-	if (cpumask_first(topology_sibling_cpumask(cpu)) != cpu)
-		err = microcode_ops->apply_microcode(cpu);
+	if (cpumask_first(topology_sibling_cpumask(cpu)) == cpu)
+		return 0;
 
-	return ret;
+	ret = microcode_ops->apply_microcode(cpu);
+	this_cpu_write(ucode_ctrl.result, ret);
+	return 0;
 }
 
-/*
- * Reload microcode late on all CPUs. Wait for a sec until they
- * all gather together.
- */
-static int microcode_reload_late(void)
+static int load_late_stop_cpus(void)
 {
-	int old = boot_cpu_data.microcode, ret;
+	unsigned int cpu, updated = 0, failed = 0, timedout = 0, siblings = 0;
+	int old_rev = boot_cpu_data.microcode;
 	struct cpuinfo_x86 prev_info;
 
 	pr_err("Attempting late microcode loading - it is dangerous and taints the kernel.\n");
@@ -377,26 +371,47 @@ static int microcode_reload_late(void)
 	 */
 	store_cpu_caps(&prev_info);
 
-	ret = stop_machine_cpuslocked(__reload_late, NULL, cpu_online_mask);
+	stop_machine_cpuslocked(load_cpus_stopped, NULL, cpu_online_mask);
+
+	/* Analyze the results */
+	for_each_cpu_and(cpu, cpu_present_mask, &cpus_booted_once_mask) {
+		switch (per_cpu(ucode_ctrl.result, cpu)) {
+		case UCODE_UPDATED:	updated++; break;
+		case UCODE_TIMEOUT:	timedout++; break;
+		case UCODE_OK:		siblings++; break;
+		default:		failed++; break;
+		}
+	}
 
 	if (microcode_ops->finalize_late_load)
-		microcode_ops->finalize_late_load(ret);
+		microcode_ops->finalize_late_load(!updated);
 
-	if (!ret) {
-		pr_info("Reload succeeded, microcode revision: 0x%x -> 0x%x\n",
-			old, boot_cpu_data.microcode);
-		microcode_check(&prev_info);
-		add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
-	} else {
-		pr_info("Reload failed, current microcode revision: 0x%x\n",
-			boot_cpu_data.microcode);
+	if (!updated) {
+		/* Nothing changed. */
+		if (!failed && !timedout)
+			return 0;
+		pr_err("update failed: %u CPUs failed %u CPUs timed out\n",
+		       failed, timedout);
+		return -EIO;
 	}
-	return ret;
+
+	add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
+	pr_info("load: updated on %u primary CPUs with %u siblings\n", updated, siblings);
+	if (failed || timedout) {
+		pr_err("load incomplete. %u CPUs timed out or failed\n",
+		       num_online_cpus() - (updated + siblings));
+	}
+	pr_info("revision: 0x%x -> 0x%x\n", old_rev, boot_cpu_data.microcode);
+	microcode_check(&prev_info);
+
+	return updated + siblings == num_online_cpus() ? 0 : -EIO;
 }
 
 /*
- *  Ensure that all required CPUs which are present and have been booted
- *  once are online.
+ * This function does two things:
+ *
+ * 1) Ensure that all required CPUs which are present and have been booted
+ *    once are online.
  *
  *    To pass this check, all primary threads must be online.
  *
@@ -407,9 +422,12 @@ static int microcode_reload_late(void)
  *    behaviour is undefined. The default play_dead() implementation on
  *    modern CPUs uses MWAIT, which is also not guaranteed to be safe
  *    against a microcode update which affects MWAIT.
+ *
+ * 2) Initialize the per CPU control structure
  */
-static bool ensure_cpus_are_online(void)
+static bool setup_cpus(void)
 {
+	struct microcode_ctrl ctrl = { .result = -1, };
 	unsigned int cpu;
 
 	for_each_cpu_and(cpu, cpu_present_mask, &cpus_booted_once_mask) {
@@ -419,18 +437,20 @@ static bool ensure_cpus_are_online(void)
 				return false;
 			}
 		}
+		/* Initialize the per CPU state */
+		per_cpu(ucode_ctrl, cpu) = ctrl;
 	}
 	return true;
 }
 
-static int ucode_load_late_locked(void)
+static int load_late_locked(void)
 {
-	if (!ensure_cpus_are_online())
+	if (!setup_cpus())
 		return -EBUSY;
 
 	switch (microcode_ops->request_microcode_fw(0, &microcode_pdev->dev)) {
 	case UCODE_NEW:
-		return microcode_reload_late();
+		return load_late_stop_cpus();
 	case UCODE_NFOUND:
 		return -ENOENT;
 	default:
@@ -450,7 +470,7 @@ static ssize_t reload_store(struct devic
 		return -EINVAL;
 
 	cpus_read_lock();
-	ret = ucode_load_late_locked();
+	ret = load_late_locked();
 	cpus_read_unlock();
 
 	return ret ? : size;
--- a/arch/x86/kernel/cpu/microcode/internal.h
+++ b/arch/x86/kernel/cpu/microcode/internal.h
@@ -16,6 +16,7 @@ enum ucode_state {
 	UCODE_UPDATED,
 	UCODE_NFOUND,
 	UCODE_ERROR,
+	UCODE_TIMEOUT,
 };
 
 struct microcode_ops {

