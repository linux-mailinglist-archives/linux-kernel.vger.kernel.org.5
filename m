Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40A279C91D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbjILIAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbjILH7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:59:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F259926AC
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:58:21 -0700 (PDT)
Message-ID: <20230912065502.202675936@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694505500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=tcStbJBYGm1S6mX3lupmzFXgqW4kHxxe4AHt7jQaeKc=;
        b=TxPEeNSADqF/1espoa4joMFPyaHU6sd/ZlOPhCdIrC7wCV7KkIwcL/CpJ3otO5/BeCCDCo
        eQM3VPvorqp+UHwR7xfGfR7oqCQMrU6H2AcGCDyFDt8NSD/2zPH3lA7Gbjqn4jFKln0mKf
        SvzyPyAAw/gjlJuf9mzIRFtSt5z/x0/+/YbOY7SGuSJDaiOaIpxabQPr/ONgil6EmnyV3y
        sMju8Gu3jM0lADivxRf8YWsQG72GcHPQNwgKPfHr4QMWpvfHJL/RVnxECXZ7eadRM0V1JL
        YnXR2WMROfkL7M/aK2fvIj7V2oMjuGhCn0C3CVYbwmp0C8NGIvdJYreJzxl/0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694505500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=tcStbJBYGm1S6mX3lupmzFXgqW4kHxxe4AHt7jQaeKc=;
        b=cAq/Q/RnWWyE8qyo5fCPHQbCSaX+Da2dUskr+Di+xg/82NEnYLBZSh4+X9yo3WN+YSDnT7
        fO+si2bL29tUcAAw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [patch V3 23/30] x86/microcode: Provide new control functions
References: <20230912065249.695681286@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 12 Sep 2023 09:58:20 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The current all in one code is unreadable and really not suited for adding
future features like uniform loading with package or system scope.

Provide a set of new control functions which split the handling of the
primary and secondary CPUs. These will replace the current rendevouz all in
one function in the next step. This is intentionally a separate change
because diff makes an complete unreadable mess otherwise.

So the flow separates the primary and the secondary CPUs into their own
functions, which use the control field in the per CPU ucode_ctrl struct.

   primary()			secondary()
    wait_for_all()		 wait_for_all()
    apply_ucode()		 wait_for_release()
    release()			 apply_ucode()

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/kernel/cpu/microcode/core.c |   86 +++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)
---
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -357,6 +357,92 @@ static bool wait_for_cpus(atomic_t *cnt)
 	return false;
 }
 
+static bool wait_for_ctrl(void)
+{
+	unsigned int timeout;
+
+	for (timeout = 0; timeout < USEC_PER_SEC; timeout++) {
+		if (this_cpu_read(ucode_ctrl.ctrl) != SCTRL_WAIT)
+			return true;
+		udelay(1);
+		if (!(timeout % 1000))
+			touch_nmi_watchdog();
+	}
+	return false;
+}
+
+static __maybe_unused void ucode_load_secondary(unsigned int cpu)
+{
+	unsigned int ctrl_cpu = this_cpu_read(ucode_ctrl.ctrl_cpu);
+	enum ucode_state ret;
+
+	/* Initial rendevouz to ensure that all CPUs have arrived */
+	if (!wait_for_cpus(&late_cpus_in)) {
+		pr_err_once("Microcode load: %d CPUs timed out\n",
+			    atomic_read(&late_cpus_in) - 1);
+		this_cpu_write(ucode_ctrl.result, UCODE_TIMEOUT);
+		return;
+	}
+
+	/*
+	 * Wait for primary threads to complete. If one of them hangs due
+	 * to the update, there is no way out. This is non-recoverable
+	 * because the CPU might hold locks or resources and confuse the
+	 * scheduler, watchdogs etc. There is no way to safely evacuate the
+	 * machine.
+	 */
+	if (!wait_for_ctrl())
+		panic("Microcode load: Primary CPU %d timed out\n", ctrl_cpu);
+
+	/*
+	 * If the primary succeeded then invoke the apply() callback,
+	 * otherwise copy the state from the primary thread.
+	 */
+	if (this_cpu_read(ucode_ctrl.ctrl) == SCTRL_APPLY)
+		ret = microcode_ops->apply_microcode(cpu);
+	else
+		ret = per_cpu(ucode_ctrl.result, ctrl_cpu);
+
+	this_cpu_write(ucode_ctrl.result, ret);
+	this_cpu_write(ucode_ctrl.ctrl, SCTRL_DONE);
+}
+
+static __maybe_unused void ucode_load_primary(unsigned int cpu)
+{
+	struct cpumask *secondaries = topology_sibling_cpumask(cpu);
+	enum sibling_ctrl ctrl;
+	enum ucode_state ret;
+	unsigned int sibling;
+
+	/* Initial rendevouz to ensure that all CPUs have arrived */
+	if (!wait_for_cpus(&late_cpus_in)) {
+		this_cpu_write(ucode_ctrl.result, UCODE_TIMEOUT);
+		pr_err_once("Microcode load: %d CPUs timed out\n",
+			    atomic_read(&late_cpus_in) - 1);
+		return;
+	}
+
+	ret = microcode_ops->apply_microcode(cpu);
+	this_cpu_write(ucode_ctrl.result, ret);
+	this_cpu_write(ucode_ctrl.ctrl, SCTRL_DONE);
+
+	/*
+	 * If the update was successful, let the siblings run the apply()
+	 * callback. If not, tell them it's done. This also covers the
+	 * case where the CPU has uniform loading at package or system
+	 * scope implemented but does not advertise it.
+	 */
+	if (ret == UCODE_UPDATED || ret == UCODE_OK)
+		ctrl = SCTRL_APPLY;
+	else
+		ctrl = SCTRL_DONE;
+
+	for_each_cpu(sibling, secondaries) {
+		if (sibling != cpu)
+			per_cpu(ucode_ctrl.ctrl, sibling) = ctrl;
+	}
+}
+
 static int ucode_load_cpus_stopped(void *unused)
 {
 	int cpu = smp_processor_id();

