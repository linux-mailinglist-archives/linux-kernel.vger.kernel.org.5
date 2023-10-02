Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469A67B51F8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 14:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236952AbjJBMA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 08:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236925AbjJBMAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 08:00:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916EB1BD
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 04:59:54 -0700 (PDT)
Message-ID: <20231002115902.914469212@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696247993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=rHi089u9X95MCYe+6Slgr0l9oghgbG+86h4o3zvQkNE=;
        b=LB1Rpi078hWn2/+ZoOUDZ2i2+hOukLr0RlRgCW6GjS6qqTibUJkS6M5oWfmQ7uZbCFu+P/
        IPDKHIMZvfQpTzAPHwz4cX3/O5ZknIXoK3w/iWmJOYoAFiDrjM19CvdtrqPuTCOUdhsMwK
        BbwNc1wOaELFmkWEqhBAv2Kgf1AVMSViIzZMrs9JzKsgrOXmXrgeSK/SI3CxiZoe8F1g5C
        bFFpcHpsvtDk/S0x/m0rlJCycxsXgXtxcbaR76Hgque9Um1j/VxxTo5EvDUAS5ho5IcPim
        eXYE7x2LsTuKTDIcQ8RucTZhvEGlBWOGTX1stTk4FxHTxyGx9lmKlCj3WX0qZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696247993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=rHi089u9X95MCYe+6Slgr0l9oghgbG+86h4o3zvQkNE=;
        b=yriIHcyDWEfqtiVp3kyxNo0poPHEY4mpvTr2dPFY7AsUXYnxCZkpPzyK4Itw/p40ACwaKU
        mojRa5YPCgOW94AA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [patch V4 15/30] x86/microcode: Remove pointless apply() invocation
References: <20231002115506.217091296@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  2 Oct 2023 13:59:52 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
@@ -490,17 +490,6 @@ static void microcode_fini_cpu(int cpu)
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
@@ -519,15 +508,6 @@ static struct syscore_ops mc_syscore_ops
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
@@ -555,14 +535,14 @@ static int mc_cpu_down_prep(unsigned int
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
 
@@ -615,8 +595,6 @@ static int __init microcode_init(void)
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

