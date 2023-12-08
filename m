Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC41809858
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 02:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444201AbjLHBDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 20:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjLHBDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 20:03:23 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2401708
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 17:03:29 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-28865456abbso1360585a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 17:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701997408; x=1702602208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rr/TYjVOMzXfU7D11gbYqPgyUVWJ+jVwJDcc6d+gJ9g=;
        b=Q3gAadWMvSBxrX58by82z380q7DNjbg8zOWVGplEg5Se8N5FRRdX5Hm+VLG49yNm8Y
         1YE3Kp8kqOeU1k+pWFFdEd7Jxv8AV5IMem9jmLM9mKeqOHwrSHtA9uns7rPxTwBBEqaK
         ircCnCGqkMOMiIpElBwavWfg4gPBLL6hYYQVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701997408; x=1702602208;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rr/TYjVOMzXfU7D11gbYqPgyUVWJ+jVwJDcc6d+gJ9g=;
        b=bgZ16SDvwN5casYUfbwp+JUxRgLaxxzy7b9jqQ5VgDVqLq4Zy4oe5ZDClxDk1chA7V
         B1Ayt/bmKpie6x3KP14GH3IXgTHYwp6g900FxBMP3e0MGJEb+m/sw1q38+xTDNO4GzgO
         7Jb2oG5ozWgZd8tvtZMzmydRTQ2wE0Qieq0IuId8tCrqPsajEYL9XwKa4De7CSi36JFP
         XneF10h7hpqoBH0zZKWIYEKjAuNPHI0fdkSUZE7lnQWSKxoSRSuG5ccI2fFNHOUtf6so
         x4UEofpVr6uNoA5EFsIk2y5QXV5fjFaadijg3dUMjm2TyFE19zAoZ73lFQQVXIUjSEVH
         URDw==
X-Gm-Message-State: AOJu0YzRecEoK+bI9iC5oqv92h7QiPqqbdChoQrZ48SZKfJ055H18+MG
        2W8MMv65/Gmfu0MguLt7nNSqOg==
X-Google-Smtp-Source: AGHT+IEwhviUsWh9ZT++qGw9xtn6n46ByrUhlK1yXmK9s+wyY++LdzZ7su0Q41omyrXdb8Y8WWKtFw==
X-Received: by 2002:a17:90a:df98:b0:286:6cc1:8672 with SMTP id p24-20020a17090adf9800b002866cc18672mr2839574pjv.87.1701997408366;
        Thu, 07 Dec 2023 17:03:28 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:4e9e:64c6:782f:1cf6])
        by smtp.gmail.com with ESMTPSA id pd15-20020a17090b1dcf00b00286ab9bb87dsm541905pjb.42.2023.12.07.17.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 17:03:27 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
        Misono Tomohiro <misono.tomohiro@fujitsu.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: smp: smp_send_stop() and crash_smp_send_stop() should try non-NMI first
Date:   Thu,  7 Dec 2023 17:02:56 -0800
Message-ID: <20231207170251.1.Id4817adef610302554b8aa42b090d57270dc119c@changeid>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When testing hard lockup handling on my sc7180-trogdor-lazor device
with pseudo-NMI enabled, with serial console enabled and with kgdb
disabled, I found that the stack crawls printed to the serial console
ended up as a jumbled mess. After rebooting, the pstore-based console
looked fine though. Also, enabling kgdb to trap the panic made the
console look fine and avoided the mess.

After a bit of tracking down, I came to the conclusion that this was
what was happening:
1. The panic path was stopping all other CPUs with
   panic_other_cpus_shutdown().
2. At least one of those other CPUs was in the middle of printing to
   the serial console and holding the console port's lock, which is
   grabbed with "irqsave". ...but since we were stopping with an NMI
   we didn't care about the "irqsave" and interrupted anyway.
3. Since we stopped the CPU while it was holding the lock it would
   never release it.
4. All future calls to output to the console would end up failing to
   get the lock in qcom_geni_serial_console_write(). This isn't
   _totally_ unexpected at panic time but it's a code path that's not
   well tested, hard to get right, and apparently doesn't work
   terribly well on the Qualcomm geni serial driver.

It would probably be a reasonable idea to try to make the Qualcomm
geni serial driver work better, but also it's nice not to get into
this situation in the first place.

Taking a page from what x86 appears to do in native_stop_other_cpus(),
let's do this:
1. First, we'll try to stop other CPUs with a normal IPI and wait a
   second. This gives them a chance to leave critical sections.
2. If CPUs fail to stop then we'll retry with an NMI, but give a much
   lower timeout since there's no good reason for a CPU not to react
   quickly to a NMI.

This works well and avoids the corrupted console and (presumably)
could help avoid other similar issues.

In order to do this, we need to do a little re-organization of our
IPIs since we don't have any more free IDs. We'll do what was
suggested in previous conversations and combine "stop" and "crash
stop". That frees up an IPI so now we can have a "stop" and "stop
NMI".

In order to do this we also need a slight change in the way we keep
track of which CPUs still need to be stopped. We need to know
specifically which CPUs haven't stopped yet when we fall back to NMI
but in the "crash stop" case the "cpu_online_mask" isn't updated as
CPUs go down. This is why that code path had an atomic of the number
of CPUs left. We'll solve this by making the cpumask into a
global. This has a potential memory implication--with NR_CPUs = 4096
this is 4096/8 = 512 bytes of globals. On the upside in that same case
we take 512 bytes off the stack which could potentially have made the
stop code less reliable. It can be noted that the NMI backtrace code
(lib/nmi_backtrace.c) uses the same approach and that use also
confirms that updating the mask is safe from NMI.

All of the above lets us combine the logic for "stop" and "crash stop"
code, which appeared to have a bunch of arbitrary implementation
differences. Possibly this could make up for some of the 512 wasted
bytes. ;-)

Aside from the above change where we try a normal IPI and then an NMI,
the combined function has a few subtle differences:
* In the normal smp_send_stop(), if we fail to stop one or more CPUs
  then we won't include the current CPU (the one running
  smp_send_stop()) in the error message.
* In crash_smp_send_stop(), if we fail to stop some CPUs we'll print
  the CPUs that we failed to stop instead of printing all _but_ the
  current running CPU.
* In crash_smp_send_stop(), we will now only print "SMP: stopping
  secondary CPUs" if (system_state <= SYSTEM_RUNNING).

Fixes: d7402513c935 ("arm64: smp: IPI_CPU_STOP and IPI_CPU_CRASH_STOP should try for NMI")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
I'm not setup to test the crash_smp_send_stop(). I made sure it
compiled and hacked the panic() method to call it, but I haven't
actually run kexec. Hopefully others can confirm that it's working for
them.

 arch/arm64/kernel/smp.c | 115 +++++++++++++++++++---------------------
 1 file changed, 54 insertions(+), 61 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index defbab84e9e5..9fe9d4342517 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -71,7 +71,7 @@ enum ipi_msg_type {
 	IPI_RESCHEDULE,
 	IPI_CALL_FUNC,
 	IPI_CPU_STOP,
-	IPI_CPU_CRASH_STOP,
+	IPI_CPU_STOP_NMI,
 	IPI_TIMER,
 	IPI_IRQ_WORK,
 	NR_IPI,
@@ -88,6 +88,9 @@ static int ipi_irq_base __ro_after_init;
 static int nr_ipi __ro_after_init = NR_IPI;
 static struct irq_desc *ipi_desc[MAX_IPI] __ro_after_init;
 
+static DECLARE_BITMAP(stop_mask, NR_CPUS) __read_mostly;
+static bool crash_stop;
+
 static void ipi_setup(int cpu);
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -770,7 +773,7 @@ static const char *ipi_types[NR_IPI] __tracepoint_string = {
 	[IPI_RESCHEDULE]	= "Rescheduling interrupts",
 	[IPI_CALL_FUNC]		= "Function call interrupts",
 	[IPI_CPU_STOP]		= "CPU stop interrupts",
-	[IPI_CPU_CRASH_STOP]	= "CPU stop (for crash dump) interrupts",
+	[IPI_CPU_STOP_NMI]	= "CPU stop NMIs",
 	[IPI_TIMER]		= "Timer broadcast interrupts",
 	[IPI_IRQ_WORK]		= "IRQ work interrupts",
 };
@@ -831,17 +834,11 @@ void __noreturn panic_smp_self_stop(void)
 	local_cpu_stop();
 }
 
-#ifdef CONFIG_KEXEC_CORE
-static atomic_t waiting_for_crash_ipi = ATOMIC_INIT(0);
-#endif
-
 static void __noreturn ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
 {
 #ifdef CONFIG_KEXEC_CORE
 	crash_save_cpu(regs, cpu);
 
-	atomic_dec(&waiting_for_crash_ipi);
-
 	local_irq_disable();
 	sdei_mask_local_cpu();
 
@@ -907,14 +904,13 @@ static void do_handle_IPI(int ipinr)
 		break;
 
 	case IPI_CPU_STOP:
-		local_cpu_stop();
-		break;
-
-	case IPI_CPU_CRASH_STOP:
-		if (IS_ENABLED(CONFIG_KEXEC_CORE)) {
+	case IPI_CPU_STOP_NMI:
+		cpumask_clear_cpu(cpu, to_cpumask(stop_mask));
+		if (IS_ENABLED(CONFIG_KEXEC_CORE) && crash_stop) {
 			ipi_cpu_crash_stop(cpu, get_irq_regs());
-
 			unreachable();
+		} else {
+			local_cpu_stop();
 		}
 		break;
 
@@ -969,8 +965,7 @@ static bool ipi_should_be_nmi(enum ipi_msg_type ipi)
 		return false;
 
 	switch (ipi) {
-	case IPI_CPU_STOP:
-	case IPI_CPU_CRASH_STOP:
+	case IPI_CPU_STOP_NMI:
 	case IPI_CPU_BACKTRACE:
 	case IPI_KGDB_ROUNDUP:
 		return true;
@@ -1085,77 +1080,75 @@ void smp_send_stop(void)
 {
 	unsigned long timeout;
 
-	if (num_other_online_cpus()) {
-		cpumask_t mask;
+	/*
+	 * If this cpu is the only one alive at this point in time, online or
+	 * not, there are no stop messages to be sent around, so just back out.
+	 */
+	if (num_other_online_cpus() == 0)
+		goto skip_ipi;
 
-		cpumask_copy(&mask, cpu_online_mask);
-		cpumask_clear_cpu(smp_processor_id(), &mask);
+	cpumask_copy(to_cpumask(stop_mask), cpu_online_mask);
+	cpumask_clear_cpu(smp_processor_id(), to_cpumask(stop_mask));
 
-		if (system_state <= SYSTEM_RUNNING)
-			pr_crit("SMP: stopping secondary CPUs\n");
-		smp_cross_call(&mask, IPI_CPU_STOP);
-	}
+	if (system_state <= SYSTEM_RUNNING)
+		pr_crit("SMP: stopping secondary CPUs\n");
 
-	/* Wait up to one second for other CPUs to stop */
+	/*
+	 * Start with a normal IPI and wait up to one second for other CPUs to
+	 * stop. We do this first because it gives other processors a chance
+	 * to exit critical sections / drop locks and makes the rest of the
+	 * stop process (especially console flush) more robust.
+	 */
+	smp_cross_call(to_cpumask(stop_mask), IPI_CPU_STOP);
 	timeout = USEC_PER_SEC;
-	while (num_other_online_cpus() && timeout--)
+	while (!cpumask_empty(to_cpumask(stop_mask)) && timeout--)
 		udelay(1);
 
-	if (num_other_online_cpus())
+	/*
+	 * If CPUs are still online, try an NMI. There's no excuse for this to
+	 * be slow, so we only give them an extra 10 ms to respond.
+	 */
+	if (!cpumask_empty(to_cpumask(stop_mask)) &&
+	    ipi_should_be_nmi(IPI_CPU_STOP_NMI)) {
+		pr_info("SMP: retry stop with NMI for CPUs %*pbl\n",
+			cpumask_pr_args(to_cpumask(stop_mask)));
+
+		smp_cross_call(to_cpumask(stop_mask), IPI_CPU_STOP_NMI);
+		timeout = USEC_PER_MSEC * 10;
+		while (!cpumask_empty(to_cpumask(stop_mask)) && timeout--)
+			udelay(1);
+	}
+
+	if (!cpumask_empty(to_cpumask(stop_mask)))
 		pr_warn("SMP: failed to stop secondary CPUs %*pbl\n",
-			cpumask_pr_args(cpu_online_mask));
+			cpumask_pr_args(to_cpumask(stop_mask)));
 
+skip_ipi:
 	sdei_mask_local_cpu();
 }
 
 #ifdef CONFIG_KEXEC_CORE
 void crash_smp_send_stop(void)
 {
-	static int cpus_stopped;
-	cpumask_t mask;
-	unsigned long timeout;
-
 	/*
 	 * This function can be called twice in panic path, but obviously
 	 * we execute this only once.
+	 *
+	 * We use this same boolean to tell whether the IPI we send was a
+	 * stop or a "crash stop".
 	 */
-	if (cpus_stopped)
+	if (crash_stop)
 		return;
+	crash_stop = 1;
 
-	cpus_stopped = 1;
-
-	/*
-	 * If this cpu is the only one alive at this point in time, online or
-	 * not, there are no stop messages to be sent around, so just back out.
-	 */
-	if (num_other_online_cpus() == 0)
-		goto skip_ipi;
-
-	cpumask_copy(&mask, cpu_online_mask);
-	cpumask_clear_cpu(smp_processor_id(), &mask);
-
-	atomic_set(&waiting_for_crash_ipi, num_other_online_cpus());
+	smp_send_stop();
 
-	pr_crit("SMP: stopping secondary CPUs\n");
-	smp_cross_call(&mask, IPI_CPU_CRASH_STOP);
-
-	/* Wait up to one second for other CPUs to stop */
-	timeout = USEC_PER_SEC;
-	while ((atomic_read(&waiting_for_crash_ipi) > 0) && timeout--)
-		udelay(1);
-
-	if (atomic_read(&waiting_for_crash_ipi) > 0)
-		pr_warn("SMP: failed to stop secondary CPUs %*pbl\n",
-			cpumask_pr_args(&mask));
-
-skip_ipi:
-	sdei_mask_local_cpu();
 	sdei_handler_abort();
 }
 
 bool smp_crash_stop_failed(void)
 {
-	return (atomic_read(&waiting_for_crash_ipi) > 0);
+	return !cpumask_empty(to_cpumask(stop_mask));
 }
 #endif
 
-- 
2.43.0.472.g3155946c3a-goog

