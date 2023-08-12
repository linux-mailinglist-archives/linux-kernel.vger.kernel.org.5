Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30B377A240
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 22:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjHLUCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 16:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbjHLUBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 16:01:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42A02729
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 13:01:24 -0700 (PDT)
Message-ID: <20230812195728.824553325@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691870351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=D7ZrdA6sXE8GlpN8vSC6yf/zxBb4RukOrJuRRxzbufg=;
        b=jBFj0txSmp09zpQTI0doP2s65siBwVk5RGfmdK0e4lZY9ag4awjSXqUx66UTzbqPCixHLz
        1xv6XkN2AE0dIXQoNiiXqg9sdkZFtFxqnlnwquIRv91Nie0ExsSef+KTF9wtd4WZIRNyIu
        6/yMI6KIidZTXkjG4fQ2kU2p4A3TEXy6ufVM4UwMuDxXL5oZHX8/e6NCL+4O2Sfj+0SJIn
        jdbd7kx1+yZ47YOh9xras2MfwVBq4aaipc3lrtewdt7bLxi7r3LBTKyiHGNOWyF69igx/E
        2Nzr2ks+QbQ2AB6pdyxkNywSgV+TQ/YeviciJllVd5ydwOE7/hKwZP5xRhDmNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691870351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=D7ZrdA6sXE8GlpN8vSC6yf/zxBb4RukOrJuRRxzbufg=;
        b=G/gQKPU1/fqDFtGqYTVAv7UTEjNS0OhfNuBqYI6UT9i3429kIx28CIqn9bRfAztlGC/1Lp
        SUijy4Ly3SiAePDA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [patch V2 22/37] x86/microcode: Remove pointless apply() invocation
References: <20230812194003.682298127@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 12 Aug 2023 21:59:10 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Microcode is applied on the APs during early bringup. There is no point in
trying to apply the microcode again during the hotplug operations and
neither at the point where the microcode device is initialized.

Collect CPU info and microcode revision in setup_online_cpu() for now. This
will move to the CPU hotplug callback in the next step.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
---
 arch/x86/kernel/cpu/microcode/core.c |   34 ++++++----------------------------
 include/linux/cpuhotplug.h           |    1 -
 2 files changed, 6 insertions(+), 29 deletions(-)

--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -533,17 +533,6 @@ static void microcode_fini_cpu(int cpu)
 		microcode_ops->microcode_fini_cpu(cpu);
 }
 
-static enum ucode_state microcode_init_cpu(int cpu)
-{
-	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
-
-	memset(uci, 0, sizeof(*uci));
-
-	microcode_ops->collect_cpu_info(cpu, &uci->cpu_sig);
-
-	return microcode_ops->apply_microcode(cpu);
-}
-
 /**
  * microcode_bsp_resume - Update boot CPU microcode during resume.
  */
@@ -562,15 +551,6 @@ static struct syscore_ops mc_syscore_ops
 	.resume	= microcode_bsp_resume,
 };
 
-static int mc_cpu_starting(unsigned int cpu)
-{
-	enum ucode_state err = microcode_ops->apply_microcode(cpu);
-
-	pr_debug("%s: CPU%d, err: %d\n", __func__, cpu, err);
-
-	return err == UCODE_ERROR;
-}
-
 static int mc_cpu_online(unsigned int cpu)
 {
 	struct device *dev = get_cpu_device(cpu);
@@ -598,14 +578,14 @@ static int mc_cpu_down_prep(unsigned int
 static void setup_online_cpu(struct work_struct *work)
 {
 	int cpu = smp_processor_id();
-	enum ucode_state err;
+	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
 
-	err = microcode_init_cpu(cpu);
-	if (err == UCODE_ERROR) {
-		pr_err("Error applying microcode on CPU%d\n", cpu);
-		return;
-	}
+	memset(uci, 0, sizeof(*uci));
 
+	microcode_ops->collect_cpu_info(cpu, &uci->cpu_sig);
+	this_cpu_write(cpu_info.microcode, uci->cpu_sig.rev);
+	if (!cpu)
+		boot_cpu_data.microcode = uci->cpu_sig.rev;
 	mc_cpu_online(cpu);
 }
 
@@ -658,8 +638,6 @@ static int __init microcode_init(void)
 	schedule_on_each_cpu(setup_online_cpu);
 
 	register_syscore_ops(&mc_syscore_ops);
-	cpuhp_setup_state_nocalls(CPUHP_AP_MICROCODE_LOADER, "x86/microcode:starting",
-				  mc_cpu_starting, NULL);
 	cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "x86/microcode:online",
 				  mc_cpu_online, mc_cpu_down_prep);
 
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -156,7 +156,6 @@ enum cpuhp_state {
 	CPUHP_AP_IRQ_LOONGARCH_STARTING,
 	CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
 	CPUHP_AP_ARM_MVEBU_COHERENCY,
-	CPUHP_AP_MICROCODE_LOADER,
 	CPUHP_AP_PERF_X86_AMD_UNCORE_STARTING,
 	CPUHP_AP_PERF_X86_STARTING,
 	CPUHP_AP_PERF_X86_AMD_IBS_STARTING,

