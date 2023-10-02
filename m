Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9AAE7B5202
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 14:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237023AbjJBMA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 08:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236914AbjJBMA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 08:00:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3FACFC
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 05:00:05 -0700 (PDT)
Message-ID: <20231002115903.433704135@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696248004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ieBuqQWksnZY/BH9wf5B9oj4Sl+Y6MDqsZ/PHThlnTM=;
        b=Q4TE8q8l5JiNVhzWFESeoJszo8+qdH8T7XjwskCMAqXgXL7Wgn2blSnXkFketydzCYoDch
        36F1qFbJ1+B7zGqwVLuVHxT9yxJ92VlbDghmyq195VQpp6s4xnoEMc8/dr2s2htP/fptcb
        3YT4r3pZ8Io1aoqmWJ7xW/0FheDMLo3Awdf+fCBbct9bL31SEQohk6f9tiUNGzXveCKw0E
        h2VhXlUXS/oTNhCDpBzdXCwRshugTmiTohWb+mz6u8Mnq4oZrX982YdaFAXalkAc3/n6hu
        /AhoCCtPVXcRyyMKLyh8foywn5+WM6R+KzkJyFNmDsOXTxWJW5ljsSPK5E8JRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696248004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ieBuqQWksnZY/BH9wf5B9oj4Sl+Y6MDqsZ/PHThlnTM=;
        b=jnpSpz9uCWSbygDlUogcWaBQGJDOA45yddJGvbtunkIhhEPXQ64SvD5b1C704gPZrfgIM8
        k1KwwGfTXiVMGvDA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [patch V4 24/30] x86/microcode: Replace the all in one rendevouz
 handler
References: <20231002115506.217091296@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  2 Oct 2023 14:00:03 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
@@ -297,7 +297,7 @@ struct microcode_ctrl {
 };
 
 static DEFINE_PER_CPU(struct microcode_ctrl, ucode_ctrl);
-static atomic_t late_cpus_in, late_cpus_out;
+static atomic_t late_cpus_in;
 
 static bool wait_for_cpus(atomic_t *cnt)
 {
@@ -333,7 +333,7 @@ static bool wait_for_ctrl(void)
 	return false;
 }
 
-static __maybe_unused void load_secondary(unsigned int cpu)
+static void load_secondary(unsigned int cpu)
 {
 	unsigned int ctrl_cpu = this_cpu_read(ucode_ctrl.ctrl_cpu);
 	enum ucode_state ret;
@@ -368,7 +368,7 @@ static __maybe_unused void load_secondar
 	this_cpu_write(ucode_ctrl.ctrl, SCTRL_DONE);
 }
 
-static __maybe_unused void load_primary(unsigned int cpu)
+static void load_primary(unsigned int cpu)
 {
 	struct cpumask *secondaries = topology_sibling_cpumask(cpu);
 	enum sibling_ctrl ctrl;
@@ -405,46 +405,14 @@ static __maybe_unused void load_primary(
 
 static int load_cpus_stopped(void *unused)
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
+		load_primary(cpu);
+	else
+		load_secondary(cpu);
 
-	ret = microcode_ops->apply_microcode(cpu);
-	this_cpu_write(ucode_ctrl.result, ret);
+	/* No point to wait here. The CPUs will all wait in stop_machine(). */
 	return 0;
 }
 
@@ -458,7 +426,6 @@ static int load_late_stop_cpus(void)
 	pr_err("You should switch to early loading, if possible.\n");
 
 	atomic_set(&late_cpus_in, num_online_cpus());
-	atomic_set(&late_cpus_out, num_online_cpus());
 
 	/*
 	 * Take a snapshot before the microcode update in order to compare and

