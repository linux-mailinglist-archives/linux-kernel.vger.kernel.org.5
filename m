Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D8B7B5206
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 14:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236841AbjJBMBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 08:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236955AbjJBMA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 08:00:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4411810D9
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 05:00:08 -0700 (PDT)
Message-ID: <20231002115903.545969323@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696248006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=BZYJfmyEkcEUrvO2SGy5jScmTWgbT5L9UgtF0YXKdoY=;
        b=IF6PEv6oZJQwZyYqk/0hWecJqpLTSDyDZDHCr9F2Kh/jZ6wx3hjJyftauZ9oMUvT9yj2a2
        tFOpzvN5VDhQuMsKlOL3MuUl5oaP1PjiDqP7EAqSODYA940lmCP+WixS20h2WH7qKP5Mkb
        xdeGJo3THpTHMbL/I0T+hU06tI0HBchN+JrIMoEZ8bfUb3iU66D1LPJI+5uyn7psSrjsF4
        G3NxMSHOWubsUwTjWeoGaZ65AKIq7ZPmJ5r1peuYArOAhjswXLM9Rfhe3yWN1Hoi4v0gvb
        6imh62cs3BQ4I+uaqbb4whdRVeeBwTKgvZ5Qb+UCUKgW0fSnp5buFR/ONGjIWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696248006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=BZYJfmyEkcEUrvO2SGy5jScmTWgbT5L9UgtF0YXKdoY=;
        b=OZ5XG5hLbib6kqtcQi41zT0OPxlQJf20vlyyLoZ+Vt/glLTf++xmWdRRfI9elYcvbZDBZ7
        LKb2psvzadyA2VDQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [patch V4 26/30] x86/microcode: Protect against instrumentation
References: <20231002115506.217091296@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon,  2 Oct 2023 14:00:06 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 arch/x86/kernel/cpu/microcode/core.c |  110 ++++++++++++++++++++++++++---------
 1 file changed, 82 insertions(+), 28 deletions(-)
---
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -301,54 +301,65 @@ struct microcode_ctrl {
 
 DEFINE_STATIC_KEY_FALSE(microcode_nmi_handler_enable);
 static DEFINE_PER_CPU(struct microcode_ctrl, ucode_ctrl);
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
+		for (loops = 0; loops < loops_per_usec; loops++)
+			cpu_relax();
 
 		/* If invoked directly, tickle the NMI watchdog */
-		if (!microcode_ops->use_nmi && !(timeout % USEC_PER_MSEC))
+		if (!microcode_ops->use_nmi && !(timeout % USEC_PER_MSEC)) {
+			instrumentation_begin();
 			touch_nmi_watchdog();
+			instrumentation_end();
+		}
 	}
 	/* Prevent the late comers from making progress and let them time out */
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
+		if (!microcode_ops->use_nmi && !(timeout % USEC_PER_MSEC)) {
+			instrumentation_begin();
 			touch_nmi_watchdog();
+			instrumentation_end();
+		}
 	}
 	return false;
 }
 
-static void load_secondary(unsigned int cpu)
+/*
+ * Protected against instrumentation up to the point where the primary
+ * thread completed the update. See microcode_nmi_handler() for details.
+ */
+static noinstr bool load_secondary_wait(unsigned int ctrl_cpu)
 {
-	unsigned int ctrl_cpu = this_cpu_read(ucode_ctrl.ctrl_cpu);
-	enum ucode_state ret;
-
 	/* Initial rendezvouz to ensure that all CPUs have arrived */
 	if (!wait_for_cpus(&late_cpus_in)) {
-		pr_err_once("load: %d CPUs timed out\n", atomic_read(&late_cpus_in) - 1);
-		this_cpu_write(ucode_ctrl.result, UCODE_TIMEOUT);
-		return;
+		raw_cpu_write(ucode_ctrl.result, UCODE_TIMEOUT);
+		return false;
 	}
 
 	/*
@@ -358,9 +369,33 @@ static void load_secondary(unsigned int
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
+static noinstr void load_secondary(unsigned int cpu)
+{
+	unsigned int ctrl_cpu = raw_cpu_read(ucode_ctrl.ctrl_cpu);
+	enum ucode_state ret;
+
+	if (!load_secondary_wait(ctrl_cpu)) {
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
@@ -372,6 +407,7 @@ static void load_secondary(unsigned int
 
 	this_cpu_write(ucode_ctrl.result, ret);
 	this_cpu_write(ucode_ctrl.ctrl, SCTRL_DONE);
+	instrumentation_end();
 }
 
 static void load_primary(unsigned int cpu)
@@ -409,25 +445,42 @@ static void load_primary(unsigned int cp
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
 		load_primary(cpu);
-	else
+		instrumentation_end();
+	} else {
 		load_secondary(cpu);
+	}
 
+	instrumentation_begin();
 	touch_nmi_watchdog();
+	instrumentation_end();
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
 
@@ -454,6 +507,7 @@ static int load_late_stop_cpus(void)
 	pr_err("You should switch to early loading, if possible.\n");
 
 	atomic_set(&late_cpus_in, num_online_cpus());
+	loops_per_usec = loops_per_jiffy / (TICK_NSEC / 1000);
 
 	/*
 	 * Take a snapshot before the microcode update in order to compare and

