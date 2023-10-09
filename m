Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D0C7BDBF8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 14:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346492AbjJIMah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 08:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346567AbjJIM3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:29:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D2ECA;
        Mon,  9 Oct 2023 05:29:51 -0700 (PDT)
Date:   Mon, 09 Oct 2023 12:29:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696854588;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OH7KIZzzS+scj4RGISucuTEh4x4DgeE4MQcilN13g9o=;
        b=KGSM0KN2aPhbugtDnzEsH5ws54CZMdJHVo7QQD6+BT4mTbJTjmjmy6ZkIOF6c8UqFTEDdh
        czrfz/AiervXWw50JXxUS3sZBTJIdAQsApPaAIH4Cy5NNZVb+pfuVcIi49eCb+oVKUx8Od
        DupWwILkQLzpD+SjkchZC2cEQtyA+SoiFLSRlK22/9Ii1BWNcGZLxtYm/3G/l4q9EXbwIp
        Z3w9aP5/be152/v6vXfwQk5aGSNgPGAub7Ly6TENsVQRAfKU3Qt48LsTq3iMC4OkDFe16O
        MXTvUIcTjK3MEqC0AKmYVDG6KV1KN1C3yBtvne2VlqxoLLwl6MkoIdEKvNByMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696854588;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OH7KIZzzS+scj4RGISucuTEh4x4DgeE4MQcilN13g9o=;
        b=QQXt8Vjg6X/XvNDocgvurjUrp9DGeGyPEJKUnRacClA3C3ebjdZWMCV6bBncAGzvtdSXQK
        AnOgxpP6M9+AkcDQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode: Add per CPU result state
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231002115903.262232260@linutronix.de>
References: <20231002115903.262232260@linutronix.de>
MIME-Version: 1.0
Message-ID: <169685458741.3135.6609403190859129483.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     fc27389d6e72cf75f04a49afe851165210f8e9f3
Gitweb:        https://git.kernel.org/tip/fc27389d6e72cf75f04a49afe851165210f8e9f3
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 02 Oct 2023 14:00:00 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 06 Oct 2023 15:12:24 +02:00

x86/microcode: Add per CPU result state

The microcode rendezvous is purely acting on global state, which does
not allow to analyze fails in a coherent way.

Introduce per CPU state where the results are written into, which allows to
analyze the return codes of the individual CPUs.

Initialize the state when walking the cpu_present_mask in the online check
to avoid another for_each_cpu() loop.

Enhance the result print out with that.

The structure is intentionally named ucode_ctrl as it will gain control
fields in subsequent changes.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231002115903.262232260@linutronix.de
---
 arch/x86/kernel/cpu/microcode/core.c     | 114 ++++++++++++----------
 arch/x86/kernel/cpu/microcode/internal.h |   1 +-
 2 files changed, 68 insertions(+), 47 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 2b8e9b6..b72ef3b 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -281,6 +281,11 @@ static struct platform_device	*microcode_pdev;
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
@@ -350,19 +345,18 @@ wait_for_siblings:
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
@@ -450,7 +470,7 @@ static ssize_t reload_store(struct device *dev,
 		return -EINVAL;
 
 	cpus_read_lock();
-	ret = ucode_load_late_locked();
+	ret = load_late_locked();
 	cpus_read_unlock();
 
 	return ret ? : size;
diff --git a/arch/x86/kernel/cpu/microcode/internal.h b/arch/x86/kernel/cpu/microcode/internal.h
index a36439c..f89bbac 100644
--- a/arch/x86/kernel/cpu/microcode/internal.h
+++ b/arch/x86/kernel/cpu/microcode/internal.h
@@ -16,6 +16,7 @@ enum ucode_state {
 	UCODE_UPDATED,
 	UCODE_NFOUND,
 	UCODE_ERROR,
+	UCODE_TIMEOUT,
 };
 
 struct microcode_ops {
