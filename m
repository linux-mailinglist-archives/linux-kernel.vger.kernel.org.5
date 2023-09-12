Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9F279C8E3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbjILH65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbjILH6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:58:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310FD19B5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:58:09 -0700 (PDT)
Message-ID: <20230912065501.717580036@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694505487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=BeckiNcudXRg0sDRJH13jVMFBVk42CtM+dSN32B7aSQ=;
        b=TZAUUZfbFIkMxB7TDFN3B3QXILFVgVbeA1b5O7xkC1F9oP4ZMe+6z+rtPLUlE+ZAGz8l0a
        afdzzj0ff2JLqjXzRKIH4plQ6scDHi6HMOEGW9c9pAyc/7HEs/lp2fV/8cnKR3v6ya/UhU
        9ZHT4ZC/LpzVDYmOVIGAhdugWGwGVJMSKPPrfgm92ALWajkz6FlfL+XCEtqyjm/F/I7qrf
        m0vDkRkgeWaAHyQRJSTpT/V4gX9bI3hq+KUw+/vStE7HtSwagChhDYEcdxI7mzhHrCHvEt
        pU7aU2maz4YKrO0cph1iTe4Blr/svchFrGRDae2Y72jiodCKaFTQIuT1YFRIkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694505487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=BeckiNcudXRg0sDRJH13jVMFBVk42CtM+dSN32B7aSQ=;
        b=NeDM9/W0hh5OVKj/sdHfdbGu9I07vQP2nNbKL1tI6b0H388qyyN5JyLK0eqdDShP9FRC/J
        IrZB9EJ2BrKHT9BQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [patch V3 15/30] x86/microcode: Remove pointless apply() invocation
References: <20230912065249.695681286@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 12 Sep 2023 09:58:07 +0200 (CEST)
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
@@ -511,17 +511,6 @@ static void microcode_fini_cpu(int cpu)
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
@@ -540,15 +529,6 @@ static struct syscore_ops mc_syscore_ops
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
@@ -576,14 +556,14 @@ static int mc_cpu_down_prep(unsigned int
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
+	cpu_data(cpu).microcode = uci->cpu_sig.rev;
+	if (!cpu)
+		boot_cpu_data.microcode = uci->cpu_sig.rev;
 	mc_cpu_online(cpu);
 }
 
@@ -636,8 +616,6 @@ static int __init microcode_init(void)
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

