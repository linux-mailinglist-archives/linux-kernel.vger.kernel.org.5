Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A1B7D0EBF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 13:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377413AbjJTLi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 07:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377184AbjJTLic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:38:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B23199F;
        Fri, 20 Oct 2023 04:37:49 -0700 (PDT)
Date:   Fri, 20 Oct 2023 11:37:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697801868;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kq29lUS+M7KxmBrUlIE3bOHpaYMh3IeDTIrq8jQu38o=;
        b=n1Y/QjCdeZbhr393QkFbQgR6hujB8mgdttGr/B3Xa+XmKsYPKD668uZPbLSfkg4DWWI6Y6
        FBe3qjcOLPDp18MAZBW/0hNiG5LK0A1JaeUIHUdr8LSnaQc5ZAb0t9d7hdHarcjDpzeezY
        oZY5mHxaQ6OTKSdwKU3aHL14BSzx9BkvTSfG2oJp6cqyUHkx2WrFW+8kgBMs2cvITZAAWO
        C9Ql8TlZ/yVREPxN838hl8j0hRDnG/2/k59B3HaHv/hsccuXY6gCB79OdYNksT4/DB3Ak+
        AmEGdy+wwZ8ovqlDbZPvhPciFlYxQQ+706WoxEydnxp5X6ez87cmAW8kR77xhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697801868;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kq29lUS+M7KxmBrUlIE3bOHpaYMh3IeDTIrq8jQu38o=;
        b=LMJMigFNmk0uMsdL1negQMJfSLpBdRRrYM0o7Sv+YdUWJthmm9yzqsW/lIwEfBcrzVHu0O
        +k918AnQOE9SIUBQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode: Protect against instrumentation
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231002115903.545969323@linutronix.de>
References: <20231002115903.545969323@linutronix.de>
MIME-Version: 1.0
Message-ID: <169780186765.3135.1856390804898797792.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     388adc4154d5f86b779a5a1e3f2f03f5be8152bf
Gitweb:        https://git.kernel.org/tip/388adc4154d5f86b779a5a1e3f2f03f5be8152bf
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 02 Oct 2023 14:00:06 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 19 Oct 2023 16:00:09 +02:00

x86/microcode: Protect against instrumentation

The wait for control loop in which the siblings are waiting for the
microcode update on the primary thread must be protected against
instrumentation as instrumentation can end up in #INT3, #DB or #PF,
which then returns with IRET. That IRET reenables NMI which is the
opposite of what the NMI rendezvous is trying to achieve.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231002115903.545969323@linutronix.de
---
 arch/x86/kernel/cpu/microcode/core.c | 111 +++++++++++++++++++-------
 1 file changed, 83 insertions(+), 28 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 7b8ade5..6c90836 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -272,54 +272,65 @@ struct microcode_ctrl {
 
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
 	/* Initial rendezvous to ensure that all CPUs have arrived */
 	if (!wait_for_cpus(&late_cpus_in)) {
-		pr_err_once("load: %d CPUs timed out\n", atomic_read(&late_cpus_in) - 1);
-		this_cpu_write(ucode_ctrl.result, UCODE_TIMEOUT);
-		return;
+		raw_cpu_write(ucode_ctrl.result, UCODE_TIMEOUT);
+		return false;
 	}
 
 	/*
@@ -329,9 +340,33 @@ static void load_secondary(unsigned int cpu)
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
+		pr_err_once("load: %d CPUs timed out\n",
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
@@ -343,6 +378,7 @@ static void load_secondary(unsigned int cpu)
 
 	this_cpu_write(ucode_ctrl.result, ret);
 	this_cpu_write(ucode_ctrl.ctrl, SCTRL_DONE);
+	instrumentation_end();
 }
 
 static void load_primary(unsigned int cpu)
@@ -380,25 +416,43 @@ static void load_primary(unsigned int cpu)
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
+
 	return true;
 }
 
-bool microcode_nmi_handler(void)
+/*
+ * Protection against instrumentation is required for CPUs which are not
+ * safe against an NMI which is delivered to the secondary SMT sibling
+ * while the primary thread updates the microcode. Instrumentation can end
+ * up in #INT3, #DB and #PF. The IRET from those exceptions reenables NMI
+ * which is the opposite of what the NMI rendezvous is trying to achieve.
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
 
@@ -425,6 +479,7 @@ static int load_late_stop_cpus(void)
 	pr_err("You should switch to early loading, if possible.\n");
 
 	atomic_set(&late_cpus_in, num_online_cpus());
+	loops_per_usec = loops_per_jiffy / (TICK_NSEC / 1000);
 
 	/*
 	 * Take a snapshot before the microcode update in order to compare and
