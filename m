Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4237D0ECC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 13:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377437AbjJTLjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 07:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377386AbjJTLiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:38:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21F7D7B;
        Fri, 20 Oct 2023 04:38:05 -0700 (PDT)
Date:   Fri, 20 Oct 2023 11:37:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697801871;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UhZMnqexpvTNu/iT5V6cKQCR1X5nYTYwFZsAXoKTWnM=;
        b=mZZVeRbAdaPtBaQOa4tic+Sq9fEMeB7wbRaP12T3Wgfeo6+jX5eca1Wq6bGr5QrVzFkgHJ
        JC3D0FcqzJbxllWYym9LFH1PNP7Qs2ttMKYzRAE1iEtb1QXDCG4jxtGvTNNkw4EZwpWlvI
        WPeAtrc7dCMOxmB2tZOTOKbnGq2eAAMJ38ik41wDrteislrU3V27UgUv/qqrzdK5ou8JMN
        7n2No5Dj/WJgU3wzOdLOqOr9Bpu1d7RCE0VNr+EjQF4hccd7Xvg9vm9gliEIOaQMWAsRVY
        Z52FzbdZYjhyOqmTkt0hX2+r708NSLsAKmjCGQGNoLDdS8ZEdJe2QLVKnxy6NQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697801871;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UhZMnqexpvTNu/iT5V6cKQCR1X5nYTYwFZsAXoKTWnM=;
        b=4MqrKB3HSmlN870b4fZrMEKHUgdvLuNeHEjNH9f2h3BTfhtPggCLZGwkkCCr5KHeI81Ax8
        F+ZKyXA9aRyKRcBA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode: Add per CPU result state
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231017211723.632681010@linutronix.de>
References: <20231017211723.632681010@linutronix.de>
MIME-Version: 1.0
Message-ID: <169780187031.3135.7510865871073622886.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     1b0bb8bb90f08d337564f7095d631f25182f3324
Gitweb:        https://git.kernel.org/tip/1b0bb8bb90f08d337564f7095d631f25182f3324
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 17 Oct 2023 23:24:05 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 19 Oct 2023 15:57:21 +02:00

x86/microcode: Add per CPU result state

The microcode rendezvous is purely acting on global state, which does
not allow to analyze fails in a coherent way.

Introduce per CPU state where the results are written into, which allows to
analyze the return codes of the individual CPUs.

Initialize the state when walking the cpu_present_mask in the online
check to avoid another for_each_cpu() loop.

Enhance the result print out with that.

The structure is intentionally named ucode_ctrl as it will gain control
fields in subsequent changes.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231017211723.632681010@linutronix.de
---
 arch/x86/kernel/cpu/microcode/core.c     | 114 ++++++++++++----------
 arch/x86/kernel/cpu/microcode/internal.h |   1 +-
 2 files changed, 68 insertions(+), 47 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 9fd5a96..67b8932 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -252,6 +252,11 @@ static struct platform_device	*microcode_pdev;
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
@@ -274,23 +279,19 @@ static bool wait_for_cpus(atomic_t *cnt)
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
@@ -299,17 +300,11 @@ static int __reload_late(void *info)
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
@@ -321,19 +316,18 @@ wait_for_siblings:
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
@@ -348,26 +342,47 @@ static int microcode_reload_late(void)
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
-
-	if (!ret) {
-		pr_info("Reload succeeded, microcode revision: 0x%x -> 0x%x\n",
-			old, boot_cpu_data.microcode);
-		microcode_check(&prev_info);
-		add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
-	} else {
-		pr_info("Reload failed, current microcode revision: 0x%x\n",
-			boot_cpu_data.microcode);
+		microcode_ops->finalize_late_load(!updated);
+
+	if (!updated) {
+		/* Nothing changed. */
+		if (!failed && !timedout)
+			return 0;
+		pr_err("update failed: %u CPUs failed %u CPUs timed out\n",
+		       failed, timedout);
+		return -EIO;
+	}
+
+	add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
+	pr_info("load: updated on %u primary CPUs with %u siblings\n", updated, siblings);
+	if (failed || timedout) {
+		pr_err("load incomplete. %u CPUs timed out or failed\n",
+		       num_online_cpus() - (updated + siblings));
 	}
-	return ret;
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
@@ -378,9 +393,12 @@ static int microcode_reload_late(void)
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
@@ -390,18 +408,20 @@ static bool ensure_cpus_are_online(void)
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
@@ -421,7 +441,7 @@ static ssize_t reload_store(struct device *dev,
 		return -EINVAL;
 
 	cpus_read_lock();
-	ret = ucode_load_late_locked();
+	ret = load_late_locked();
 	cpus_read_unlock();
 
 	return ret ? : size;
diff --git a/arch/x86/kernel/cpu/microcode/internal.h b/arch/x86/kernel/cpu/microcode/internal.h
index 07aa5f8..c699043 100644
--- a/arch/x86/kernel/cpu/microcode/internal.h
+++ b/arch/x86/kernel/cpu/microcode/internal.h
@@ -16,6 +16,7 @@ enum ucode_state {
 	UCODE_UPDATED,
 	UCODE_NFOUND,
 	UCODE_ERROR,
+	UCODE_TIMEOUT,
 };
 
 struct microcode_ops {
