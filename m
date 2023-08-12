Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D22477A254
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 22:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjHLUH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 16:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbjHLUGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 16:06:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C237E19B1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 13:06:24 -0700 (PDT)
Message-ID: <20230812195729.454136685@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691870368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=OBavvuIISB6T38J3QGPcFo0zGeBzWsPn/MsQxWfrjc4=;
        b=KwwjhB+5EBP2+E6m+pPVbNUT+KH1rgAxGQyN1QrBB9Ka6OHxFKfeJ5Ru3/JCV2iv6duy+9
        tOI2qthFV9X24FJ/XQa1RYnjm3yTgnmng1zDzo8XpG29+FExSvyVjvRAUoZ403sK7R1dxs
        WjB/GZ3PfGOyi4jcfD3nbiZ1Eijk6MIvZ8HqAE7iW5WIUuLXSEEhcfzHcJ5rNTDIRaaE+e
        ltT/hzotkRoJCsiUUJI5dHWzPXX46qdLPmafFfTu04JMj+WFAuSl9INg9ZE4SCpf9oxoJ8
        HI3yegQpKp/I2k3gmzH80CF1cuV/UnEgY0njj+sdB9ocj/Pei4wGdRRJqY9isA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691870368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=OBavvuIISB6T38J3QGPcFo0zGeBzWsPn/MsQxWfrjc4=;
        b=g5Ud4QdNP6SrpVc3hyF6u1xQMY7Ll8PMJXj1UL3NgTsRplA5PxEwSWjhmzyXNzy/AAMeWT
        fCL9CzRsOOcC4GBw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [patch V2 33/37] x86/microcode: Protect against instrumentation
References: <20230812194003.682298127@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 12 Aug 2023 21:59:27 +0200 (CEST)
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

The wait for control loop in which the siblings are waiting for the
microcode update on the primary thread must be protected against
instrumentation as instrumentation can end up in #INT3, #DB or #PF, which
then returns with IRET. That IRET reenables NMI which is the opposite of
what the NMI rendezvouz is trying to achieve.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/kernel/cpu/microcode/core.c |  112 ++++++++++++++++++++++++++---------
 1 file changed, 84 insertions(+), 28 deletions(-)
---
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -341,53 +341,65 @@ struct ucode_ctrl {
 
 DEFINE_STATIC_KEY_FALSE(microcode_nmi_handler_enable);
 static DEFINE_PER_CPU(struct ucode_ctrl, ucode_ctrl);
+static unsigned int loops_per_usec;
 static atomic_t late_cpus_in;
 
-static bool wait_for_cpus(atomic_t *cnt)
+static noinstr bool wait_for_cpus(atomic_t *cnt)
 {
-	unsigned int timeout;
+	unsigned int timeout, loops;
 
-	WARN_ON_ONCE(atomic_dec_return(cnt) < 0);
+	WARN_ON_ONCE(raw_atomic_dec_return(cnt) < 0);
 
 	for (timeout = 0; timeout < USEC_PER_SEC; timeout++) {
-		if (!atomic_read(cnt))
+		if (!raw_atomic_read(cnt))
 			return true;
-		udelay(1);
+
+		for (loops = 0; loops < loops_per_usec; loops++)
+			cpu_relax();
+
 		/* If invoked directly, tickle the NMI watchdog */
-		if (!microcode_ops->use_nmi && !(timeout % 1000))
+		if (!microcode_ops->use_nmi && !(timeout % 1000)) {
+			instrumentation_begin();
 			touch_nmi_watchdog();
+			instrumentation_end();
+		}
 	}
 	/* Prevent the late comers to make progress and let them time out */
-	atomic_inc(cnt);
+	raw_atomic_inc(cnt);
 	return false;
 }
 
-static bool wait_for_ctrl(void)
+static noinstr bool wait_for_ctrl(void)
 {
-	unsigned int timeout;
+	unsigned int timeout, loops;
 
 	for (timeout = 0; timeout < USEC_PER_SEC; timeout++) {
-		if (this_cpu_read(ucode_ctrl.ctrl) != SCTRL_WAIT)
+		if (raw_cpu_read(ucode_ctrl.ctrl) != SCTRL_WAIT)
 			return true;
-		udelay(1);
+
+		for (loops = 0; loops < loops_per_usec; loops++)
+			cpu_relax();
+
 		/* If invoked directly, tickle the NMI watchdog */
-		if (!microcode_ops->use_nmi && !(timeout % 1000))
+		if (!microcode_ops->use_nmi && !(timeout % 1000)) {
+			instrumentation_begin();
 			touch_nmi_watchdog();
+			instrumentation_end();
+		}
 	}
 	return false;
 }
 
-static void ucode_load_secondary(unsigned int cpu)
+/*
+ * Protected against instrumentation up to the point where the primary
+ * thread completed the update. See microcode_nmi_handler() for details.
+ */
+static noinstr bool ucode_load_secondary_wait(unsigned int ctrl_cpu)
 {
-	unsigned int ctrl_cpu = this_cpu_read(ucode_ctrl.ctrl_cpu);
-	enum ucode_state ret;
-
 	/* Initial rendevouz to ensure that all CPUs have arrived */
 	if (!wait_for_cpus(&late_cpus_in)) {
-		pr_err_once("Microcode load: %d CPUs timed out\n",
-			    atomic_read(&late_cpus_in) - 1);
 		this_cpu_write(ucode_ctrl.result, UCODE_TIMEOUT);
-		return;
+		return false;
 	}
 
 	/*
@@ -397,9 +409,33 @@ static void ucode_load_secondary(unsigne
 	 * scheduler, watchdogs etc. There is no way to safely evacuate the
 	 * machine.
 	 */
-	if (!wait_for_ctrl())
-		panic("Microcode load: Primary CPU %d timed out\n", ctrl_cpu);
+	if (wait_for_ctrl())
+		return true;
+
+	instrumentation_begin();
+	panic("Microcode load: Primary CPU %d timed out\n", ctrl_cpu);
+	instrumentation_end();
+}
 
+/*
+ * Protected against instrumentation up to the point where the primary
+ * thread completed the update. See microcode_nmi_handler() for details.
+ */
+static noinstr void ucode_load_secondary(unsigned int cpu)
+{
+	unsigned int ctrl_cpu = raw_cpu_read(ucode_ctrl.ctrl_cpu);
+	enum ucode_state ret;
+
+	if (!ucode_load_secondary_wait(ctrl_cpu)) {
+		instrumentation_begin();
+		pr_err_once("Microcode load: %d CPUs timed out\n",
+			    atomic_read(&late_cpus_in) - 1);
+		instrumentation_end();
+		return;
+	}
+
+	/* Primary thread completed. Allow to invoke instrumentable code */
+	instrumentation_begin();
 	/*
 	 * If the primary succeeded then invoke the apply() callback,
 	 * otherwise copy the state from the primary thread.
@@ -411,6 +447,7 @@ static void ucode_load_secondary(unsigne
 
 	this_cpu_write(ucode_ctrl.result, ret);
 	this_cpu_write(ucode_ctrl.ctrl, SCTRL_DONE);
+	instrumentation_end();
 }
 
 static void ucode_load_primary(unsigned int cpu)
@@ -449,25 +486,43 @@ static void ucode_load_primary(unsigned
 	}
 }
 
-static bool microcode_update_handler(void)
+static noinstr bool microcode_update_handler(void)
 {
-	unsigned int cpu = smp_processor_id();
+	unsigned int cpu = raw_smp_processor_id();
 
-	if (this_cpu_read(ucode_ctrl.ctrl_cpu) == cpu)
+	if (raw_cpu_read(ucode_ctrl.ctrl_cpu) == cpu) {
+		instrumentation_begin();
 		ucode_load_primary(cpu);
-	else
+		instrumentation_end();
+	} else {
 		ucode_load_secondary(cpu);
+	}
 
+	instrumentation_begin();
 	touch_nmi_watchdog();
+	instrumentation_end();
+
 	return true;
 }
 
-bool microcode_nmi_handler(void)
+/*
+ * Protection against instrumentation is required for CPUs which are not
+ * safe against an NMI which is delivered to the secondary SMT sibling
+ * while the primary thread updates the microcode. Instrumentation can end
+ * up in #INT3, #DB and #PF. The IRET from those exceptions reenables NMI
+ * which is the opposite of what the NMI rendevouz is trying to achieve.
+ *
+ * The primary thread is safe versus instrumentation as the actual
+ * microcode update handles this correctly. It's only the sibling code
+ * path which must be NMI safe until the primary thread completed the
+ * update.
+ */
+bool noinstr microcode_nmi_handler(void)
 {
-	if (!this_cpu_read(ucode_ctrl.nmi_enabled))
+	if (!raw_cpu_read(ucode_ctrl.nmi_enabled))
 		return false;
 
-	this_cpu_write(ucode_ctrl.nmi_enabled, false);
+	raw_cpu_write(ucode_ctrl.nmi_enabled, false);
 	return microcode_update_handler();
 }
 
@@ -494,6 +549,7 @@ static int ucode_load_late_stop_cpus(voi
 	pr_err("You should switch to early loading, if possible.\n");
 
 	atomic_set(&late_cpus_in, num_online_cpus());
+	loops_per_usec = loops_per_jiffy / (TICK_NSEC / 1000);
 
 	/*
 	 * Take a snapshot before the microcode update in order to compare and

