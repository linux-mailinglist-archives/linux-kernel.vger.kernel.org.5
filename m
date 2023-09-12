Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935EA79C920
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbjILIAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbjILH7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:59:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9142701
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:58:23 -0700 (PDT)
Message-ID: <20230912065502.265405353@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694505502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=tBiZyVFg2RByesw9s33ESky6BK8jMzTV8d/B5WDIvI8=;
        b=ZZG7THSJj1FSt3wSuX5xQNdGvOs2Cwn2089apJGMssuXfq1xxC47x5KnycQ14WAZUlpObq
        LG5K2NafGw0BeRifHaJcCodesPMLMGynYR4o4236a2UaIW9VnDPAq01dgYkzt5RLBTVY2N
        5gBcFasCpmB8jV/tWJlSr+yHG4puA3xZanxYvLiykuIriKgKb3P+COP0Ty2ZKWiN3hbRCu
        3U5uwZb5B7hTJOUsMfXAVcg8fgkHy63KICgOoeOQQtNitjngK5j15G+ejJbP3dRxoXM0o6
        PZeAUb1OQ+RESWgmxzLAsZdaGMkbZkWJzI0uXO2fskyM3sEBJgr48qE3Ki3+Kg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694505502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=tBiZyVFg2RByesw9s33ESky6BK8jMzTV8d/B5WDIvI8=;
        b=V/LNYjqIkgOictOpkJfjKYzl3XBC7Nbi3r6Hl6Hajb8CDdxUNdn5x2wQuVSDeT7swWQP5E
        KEHjxvrP2sdVZGCA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [patch V3 24/30] x86/microcode: Replace the all in one rendevouz
 handler
References: <20230912065249.695681286@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 12 Sep 2023 09:58:21 +0200 (CEST)
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

