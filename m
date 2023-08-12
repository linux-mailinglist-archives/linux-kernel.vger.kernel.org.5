Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E4577A252
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 22:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjHLUGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 16:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjHLUGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 16:06:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919E01716
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 13:06:21 -0700 (PDT)
Message-ID: <20230812195729.332293834@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691870365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=tBiZyVFg2RByesw9s33ESky6BK8jMzTV8d/B5WDIvI8=;
        b=S/7ymfOX7c/c7lnr1QmYEEJG2IjfdZu+GTKQTRf/1CcBJYkqhXhddmO5vbUb6KcywTn/jf
        5qAhhE3qWtHqTb+G2qT+Zs+I+qkqQwb30rljGEv4HK83bxXKnH5zL3r6vYkjf+x/3rC/BW
        q3fq5gxHFCui7SovpGU2TAx99FcN5hQPQz2Vd1jk/X8AZovvPkeG81MEOAAtVrYXe+TEze
        09I7V0BefzWlm/UG9iJ+SbO/Mf/Zrk2reH6QQLZ+Ca20cPkD57l8NN9370tZqjewJTVTRl
        c6CRTwMQLPrRt553RKFOE8o5uG34r4/ZBiCaA8/SzljpK//iSqYDREvYcQQaVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691870365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=tBiZyVFg2RByesw9s33ESky6BK8jMzTV8d/B5WDIvI8=;
        b=+litjPSpn2DnB8QnsGio+HJVIncflnHvnuiDvl3iEs/0kRg7HBzEIluEZ36eHp7ViEb5Hf
        W5Jys18PMeT8qfDA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [patch V2 31/37] x86/microcode: Replace the all in one rendevouz
 handler
References: <20230812194003.682298127@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 12 Aug 2023 21:59:24 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

with a new handler which just separates the control flow of primary and
secondary CPUs.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/kernel/cpu/microcode/core.c |   51 ++++++-----------------------------
 1 file changed, 9 insertions(+), 42 deletions(-)
---
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -337,7 +337,7 @@ struct ucode_ctrl {
 };
 
 static DEFINE_PER_CPU(struct ucode_ctrl, ucode_ctrl);
-static atomic_t late_cpus_in, late_cpus_out;
+static atomic_t late_cpus_in;
 
 static bool wait_for_cpus(atomic_t *cnt)
 {
@@ -371,7 +371,7 @@ static bool wait_for_ctrl(void)
 	return false;
 }
 
-static __maybe_unused void ucode_load_secondary(unsigned int cpu)
+static void ucode_load_secondary(unsigned int cpu)
 {
 	unsigned int ctrl_cpu = this_cpu_read(ucode_ctrl.ctrl_cpu);
 	enum ucode_state ret;
@@ -407,7 +407,7 @@ static __maybe_unused void ucode_load_se
 	this_cpu_write(ucode_ctrl.ctrl, SCTRL_DONE);
 }
 
-static __maybe_unused void ucode_load_primary(unsigned int cpu)
+static void ucode_load_primary(unsigned int cpu)
 {
 	struct cpumask *secondaries = topology_sibling_cpumask(cpu);
 	enum sibling_ctrl ctrl;
@@ -445,46 +445,14 @@ static __maybe_unused void ucode_load_pr
 
 static int ucode_load_cpus_stopped(void *unused)
 {
-	int cpu = smp_processor_id();
-	enum ucode_state ret;
-
-	/*
-	 * Wait for all CPUs to arrive. A load will not be attempted unless all
-	 * CPUs show up.
-	 * */
-	if (!wait_for_cpus(&late_cpus_in)) {
-		this_cpu_write(ucode_ctrl.result, UCODE_TIMEOUT);
-		return 0;
-	}
-
-	/*
-	 * On an SMT system, it suffices to load the microcode on one sibling of
-	 * the core because the microcode engine is shared between the threads.
-	 * Synchronization still needs to take place so that no concurrent
-	 * loading attempts happen on multiple threads of an SMT core. See
-	 * below.
-	 */
-	if (cpumask_first(topology_sibling_cpumask(cpu)) != cpu)
-		goto wait_for_siblings;
+	unsigned int cpu = smp_processor_id();
 
-	ret = microcode_ops->apply_microcode(cpu);
-	this_cpu_write(ucode_ctrl.result, ret);
-
-wait_for_siblings:
-	if (!wait_for_cpus(&late_cpus_out))
-		panic("Timeout during microcode update!\n");
-
-	/*
-	 * At least one thread has completed update on each core.
-	 * For others, simply call the update to make sure the
-	 * per-cpu cpuinfo can be updated with right microcode
-	 * revision.
-	 */
-	if (cpumask_first(topology_sibling_cpumask(cpu)) == cpu)
-		return 0;
+	if (this_cpu_read(ucode_ctrl.ctrl_cpu) == cpu)
+		ucode_load_primary(cpu);
+	else
+		ucode_load_secondary(cpu);
 
-	ret = microcode_ops->apply_microcode(cpu);
-	this_cpu_write(ucode_ctrl.result, ret);
+	/* No point to wait here. The CPUs will all wait in stop_machine(). */
 	return 0;
 }
 
@@ -498,7 +466,6 @@ static int ucode_load_late_stop_cpus(voi
 	pr_err("You should switch to early loading, if possible.\n");
 
 	atomic_set(&late_cpus_in, num_online_cpus());
-	atomic_set(&late_cpus_out, num_online_cpus());
 
 	/*
 	 * Take a snapshot before the microcode update in order to compare and

