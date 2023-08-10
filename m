Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D1B77806E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 20:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235237AbjHJSjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 14:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235766AbjHJSi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:38:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4F930E5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:38:12 -0700 (PDT)
Message-ID: <20230810160806.164799931@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691692677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=2kqLUw1a4gV9FrIDWZ/O+PSOOuBOB0W9vRdpe8yDcXg=;
        b=jWBI8F5o6zbGFRWlgo8gxOe91PUCTu3tc5OSvW1vfk7yMuTqyqi1VBzbHPVpJRKE5wOj+K
        bzjSXtQRM/gblXh7O42yM367uHkbuRUas5zz4I+BhwbVFXdprRCYz4qI3UUGOcZIPSHffC
        XH/o0zA4ZYBaaq2PrFrcB7lQUlxwKkxT17noqZ8wjvwfWQ6bX20CrigskV0F6xvJX+4LOW
        mp8KyDJ23/Imw2+rK5Aowji9KQFcaiTwlzzaTBDPlHGAy4Zd+Mnm6RVRJ0knQdA5VY6wBA
        VukKZPjqydQCsMTVXwk7kNrQEU7+ku99RMVfccriXU7mCh2l/MW9MByDFfQjLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691692677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=2kqLUw1a4gV9FrIDWZ/O+PSOOuBOB0W9vRdpe8yDcXg=;
        b=EZ7VF7x91ea0u8MPqXzi1WUoffIdwLpTUGPs/g2wZNRb8P1dVfBL+/kmD8YLi7QYPT2kHp
        /3U/yYOIalyz4wCQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: [patch 21/30] x86/microcode: Add per CPU result state
References: <20230810153317.850017756@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 10 Aug 2023 20:37:57 +0200 (CEST)
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
 arch/x86/kernel/cpu/microcode/core.c     |  108 ++++++++++++++++++-------------
 arch/x86/kernel/cpu/microcode/internal.h |    1 
 2 files changed, 65 insertions(+), 44 deletions(-)
---
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -324,6 +324,11 @@ static struct platform_device	*microcode
  *   requirement can be relaxed in the future. Right now, this is conservative
  *   and good.
  */
+struct ucode_ctrl {
+	enum ucode_state	result;
+};
+
+static DEFINE_PER_CPU(struct ucode_ctrl, ucode_ctrl);
 static atomic_t late_cpus_in, late_cpus_out;
 
 static bool wait_for_cpus(atomic_t *cnt)
@@ -344,23 +349,19 @@ static bool wait_for_cpus(atomic_t *cnt)
 	return false;
 }
 
-/*
- * Returns:
- * < 0 - on error
- *   0 - success (no update done or microcode was updated)
- */
-static int __reload_late(void *info)
+static int ucode_load_cpus_stopped(void *unused)
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
@@ -369,17 +370,11 @@ static int __reload_late(void *info)
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
@@ -391,19 +386,18 @@ static int __reload_late(void *info)
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
+static int ucode_load_late_stop_cpus(void)
 {
-	int old = boot_cpu_data.microcode, ret;
+	unsigned int cpu, updated = 0, failed = 0, timedout = 0, siblings = 0;
+	int old_rev = boot_cpu_data.microcode;
 	struct cpuinfo_x86 prev_info;
 
 	pr_err("Attempting late microcode loading - it is dangerous and taints the kernel.\n");
@@ -418,26 +412,47 @@ static int microcode_reload_late(void)
 	 */
 	store_cpu_caps(&prev_info);
 
-	ret = stop_machine_cpuslocked(__reload_late, NULL, cpu_online_mask);
+	stop_machine_cpuslocked(ucode_load_cpus_stopped, NULL, cpu_online_mask);
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
+		pr_err("Microcode update failed: %u CPUs failed %u CPUs timed out\n",
+		       failed, timedout);
+		return -EIO;
 	}
-	return ret;
+
+	add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
+	pr_info("Microcode load: updated on %u primary CPUs with %u siblings\n", updated, siblings);
+	if (failed || timedout) {
+		pr_err("Microcode load incomplete. %u CPUs timed out or failed\n",
+		       num_online_cpus() - (updated + siblings));
+	}
+	pr_info("Microcode revision: 0x%x -> 0x%x\n", old_rev, boot_cpu_data.microcode);
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
@@ -448,9 +463,12 @@ static int microcode_reload_late(void)
  *    behaviour is undefined. The default play_dead() implementation on
  *    modern CPUs is using MWAIT, which is also not guaranteed to be safe
  *    against a microcode update which affects MWAIT.
+ *
+ * 2) Initialize the per CPU control structure
  */
-static bool ensure_cpus_are_online(void)
+static bool ucode_setup_cpus(void)
 {
+	struct ucode_ctrl ctrl = { .result = -1, };
 	unsigned int cpu;
 
 	for_each_cpu_and(cpu, cpu_present_mask, &cpus_booted_once_mask) {
@@ -460,6 +478,8 @@ static bool ensure_cpus_are_online(void)
 				return false;
 			}
 		}
+		/* Initialize the per CPU state */
+		per_cpu(ucode_ctrl, cpu) = ctrl;
 	}
 	return true;
 }
@@ -468,13 +488,13 @@ static int ucode_load_late_locked(void)
 {
 	int ret;
 
-	if (!ensure_cpus_are_online())
+	if (!ucode_setup_cpus())
 		return -EBUSY;
 
 	ret = microcode_ops->request_microcode_fw(0, &microcode_pdev->dev);
 	if (ret != UCODE_NEW)
 		return ret == UCODE_NFOUND ? -ENOENT : -EBADFD;
-	return microcode_reload_late();
+	return ucode_load_late_stop_cpus();
 }
 
 static ssize_t reload_store(struct device *dev,
--- a/arch/x86/kernel/cpu/microcode/internal.h
+++ b/arch/x86/kernel/cpu/microcode/internal.h
@@ -16,6 +16,7 @@ enum ucode_state {
 	UCODE_UPDATED,
 	UCODE_NFOUND,
 	UCODE_ERROR,
+	UCODE_TIMEOUT,
 };
 
 struct microcode_ops {

