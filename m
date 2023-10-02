Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3BD27B5203
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 14:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237065AbjJBMAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 08:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236983AbjJBMAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 08:00:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97669CF3
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 05:00:04 -0700 (PDT)
Message-ID: <20231002115903.377922731@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696248002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=p686dGKnLUGiOBuJ3ZmFJ4Qfbmz+TWkPBvmKkOJ7OCc=;
        b=SPqIhS1hrgF2dkqtk/+E/F0nA3bJ4MDo+PwLvXGME2dgr7O8LbXe3/8abKLvmTN6fe1xHC
        K3hCNngS+/8ca/hRZOWgQPhOpm5Gq5UXia+eY5x4Ws3vIKhDpdTj9lNWmfaionaGBcXEqo
        K9KDHcVpvQBczZ8tr3WQ5ghm9TLctmpv+33X/FGXO2s9FpDAGv0G65r53hofeFP67OdSmH
        jiH/x9qtkRbE2S8JlqOBEtusSp3SsAfxz3NXrR5gN/q8CMahquCfkeB8uRFpxGbyabqzzB
        3+SEDyr9cpK4wdHuyg7eZrpJnYoRG24A5QdvLcfvKWdN+JLEwq6JrtijlQxSmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696248002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=p686dGKnLUGiOBuJ3ZmFJ4Qfbmz+TWkPBvmKkOJ7OCc=;
        b=WmdkA0xpYnMj5C2a8Q91uUzS8bCPoIvxADv7s9Fh2OTUIEa85bY2tcN1Zr7Ja3Vqt8GnN+
        gWeq3LxnSWCMeXCg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [patch V4 23/30] x86/microcode: Provide new control functions
References: <20231002115506.217091296@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  2 Oct 2023 14:00:02 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The current all in one code is unreadable and really not suited for adding
future features like uniform loading with package or system scope.

Provide a set of new control functions which split the handling of the
primary and secondary CPUs. These will replace the current rendezvouz all in
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
 arch/x86/kernel/cpu/microcode/core.c |   84 +++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)
---
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -319,6 +319,90 @@ static bool wait_for_cpus(atomic_t *cnt)
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
+static __maybe_unused void load_secondary(unsigned int cpu)
+{
+	unsigned int ctrl_cpu = this_cpu_read(ucode_ctrl.ctrl_cpu);
+	enum ucode_state ret;
+
+	/* Initial rendezvouz to ensure that all CPUs have arrived */
+	if (!wait_for_cpus(&late_cpus_in)) {
+		pr_err_once("load: %d CPUs timed out\n", atomic_read(&late_cpus_in) - 1);
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
+static __maybe_unused void load_primary(unsigned int cpu)
+{
+	struct cpumask *secondaries = topology_sibling_cpumask(cpu);
+	enum sibling_ctrl ctrl;
+	enum ucode_state ret;
+	unsigned int sibling;
+
+	/* Initial rendezvouz to ensure that all CPUs have arrived */
+	if (!wait_for_cpus(&late_cpus_in)) {
+		this_cpu_write(ucode_ctrl.result, UCODE_TIMEOUT);
+		pr_err_once("load: %d CPUs timed out\n", atomic_read(&late_cpus_in) - 1);
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
 static int load_cpus_stopped(void *unused)
 {
 	int cpu = smp_processor_id();

