Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D70F772813
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234748AbjHGOn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 10:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233922AbjHGOn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:43:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F404E10DC;
        Mon,  7 Aug 2023 07:43:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C37B1FB;
        Mon,  7 Aug 2023 07:44:38 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.32.139])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 74E703F64C;
        Mon,  7 Aug 2023 07:43:51 -0700 (PDT)
Date:   Mon, 7 Aug 2023 15:43:46 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        linux-perf-users@vger.kernel.org, ito-yuichi@fujitsu.com,
        Chen-Yu Tsai <wens@csie.org>, Ard Biesheuvel <ardb@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        kgdb-bugreport@lists.sourceforge.net,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Ben Dooks <ben-linux@fluff.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Wei Li <liwei391@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 0/7] arm64: Add debug IPI for backtraces / kgdb; try
 to use NMI for it
Message-ID: <ZNEDIlst3OVZF7P2@FVFF77S0Q05N.cambridge.arm.com>
References: <20230601213440.2488667-1-dianders@chromium.org>
 <CAD=FV=V2fFqwg3f3KS29+AkggHFDbyYvfAb12DrDn_PF8+bJjA@mail.gmail.com>
 <ZNDKVP2m-iiZCz3v@FVFF77S0Q05N.cambridge.arm.com>
 <CAFA6WYMD4TRR5psUyhu2jhZ2XBMUfav3D7_eH1HE8VJfXc7Fuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFA6WYMD4TRR5psUyhu2jhZ2XBMUfav3D7_eH1HE8VJfXc7Fuw@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 06:16:24PM +0530, Sumit Garg wrote:
> On Mon, 7 Aug 2023 at 16:11, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Mon, Jul 24, 2023 at 08:55:44AM -0700, Doug Anderson wrote:
> > > On Thu, Jun 1, 2023 at 2:37 PM Douglas Anderson <dianders@chromium.org> wrote:
> > I'd also strongly prefer if we
> > could have separate IPI_CPU_BACKTRACE and IPI_CPU_KGDB IPIs,
> 
> With current logic of single debug IPI, it is not required for a user
> to enable KGDB in order to use that IPI for backtrace. The original
> motivation for this logic was that the IPIs are a scarce resource on
> arm64 as per comments from Marc. So I am fine either way to keep them
> separate or unified.
> 
> > and I think we can
> > do that either by unifying IPI_CPU_STOP && IPI_CPU_CRASH_STOP or by reclaiming
> > IPI_WAKEUP by reusing a different IPI for the parking protocol (e.g.
> > IPI_RESCHEDULE).
> 
> That sounds like a good cleanup.

I took a quick stab at removing IPI_WAKEUP, and it seems simple enough; patch
below.

Mark.

----<8----
From 267401824576c1dd3bb6d380142c92f710098b67 Mon Sep 17 00:00:00 2001
From: Mark Rutland <mark.rutland@arm.com>
Date: Mon, 7 Aug 2023 15:05:47 +0100
Subject: [PATCH] arm64: smp: Remove dedicated wakeup IPI

To enable NMI backtrace and KGDB's NMI cpu roundup, we need to free up
at least one dedicated IPI.

On arm64 the IPI_WAKEUP IPI is only used for the ACPI parking protocol,
which itself is only used on some very early ARMv8 systems which
couldn't implement PSCI.

Remove the IPI_WAKEUP IPI, and rely on the IPI_RESCHEDULE IPI to wake
CPUs from the parked state. This will cause a tiny amonut of redundant
work to check the thread flags, but this is miniscule in relation to the
cost of taking and handling the IPI in the first place. We can safely
handle redundant IPI_RESCHEDULE IPIs, so there should be no functional
impact as a result of this change.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/smp.h              |  4 ++--
 arch/arm64/kernel/acpi_parking_protocol.c |  2 +-
 arch/arm64/kernel/smp.c                   | 28 +++++++++--------------
 3 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index 9b31e6d0da174..798fd76a883a0 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -89,9 +89,9 @@ extern void arch_send_call_function_single_ipi(int cpu);
 extern void arch_send_call_function_ipi_mask(const struct cpumask *mask);
 
 #ifdef CONFIG_ARM64_ACPI_PARKING_PROTOCOL
-extern void arch_send_wakeup_ipi_mask(const struct cpumask *mask);
+extern void arch_send_wakeup_ipi(int cpu);
 #else
-static inline void arch_send_wakeup_ipi_mask(const struct cpumask *mask)
+static inline void arch_send_wakeup_ipi(int cpu)
 {
 	BUILD_BUG();
 }
diff --git a/arch/arm64/kernel/acpi_parking_protocol.c b/arch/arm64/kernel/acpi_parking_protocol.c
index b1990e38aed0a..e1be29e608b71 100644
--- a/arch/arm64/kernel/acpi_parking_protocol.c
+++ b/arch/arm64/kernel/acpi_parking_protocol.c
@@ -103,7 +103,7 @@ static int acpi_parking_protocol_cpu_boot(unsigned int cpu)
 		       &mailbox->entry_point);
 	writel_relaxed(cpu_entry->gic_cpu_id, &mailbox->cpu_id);
 
-	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
+	arch_send_wakeup_ipi(cpu);
 
 	return 0;
 }
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index edd63894d61e8..be00c8c5c1711 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -72,7 +72,6 @@ enum ipi_msg_type {
 	IPI_CPU_CRASH_STOP,
 	IPI_TIMER,
 	IPI_IRQ_WORK,
-	IPI_WAKEUP,
 	NR_IPI
 };
 
@@ -764,7 +763,6 @@ static const char *ipi_types[NR_IPI] __tracepoint_string = {
 	[IPI_CPU_CRASH_STOP]	= "CPU stop (for crash dump) interrupts",
 	[IPI_TIMER]		= "Timer broadcast interrupts",
 	[IPI_IRQ_WORK]		= "IRQ work interrupts",
-	[IPI_WAKEUP]		= "CPU wake-up interrupts",
 };
 
 static void smp_cross_call(const struct cpumask *target, unsigned int ipinr);
@@ -797,13 +795,6 @@ void arch_send_call_function_single_ipi(int cpu)
 	smp_cross_call(cpumask_of(cpu), IPI_CALL_FUNC);
 }
 
-#ifdef CONFIG_ARM64_ACPI_PARKING_PROTOCOL
-void arch_send_wakeup_ipi_mask(const struct cpumask *mask)
-{
-	smp_cross_call(mask, IPI_WAKEUP);
-}
-#endif
-
 #ifdef CONFIG_IRQ_WORK
 void arch_irq_work_raise(void)
 {
@@ -897,14 +888,6 @@ static void do_handle_IPI(int ipinr)
 		break;
 #endif
 
-#ifdef CONFIG_ARM64_ACPI_PARKING_PROTOCOL
-	case IPI_WAKEUP:
-		WARN_ONCE(!acpi_parking_protocol_valid(cpu),
-			  "CPU%u: Wake-up IPI outside the ACPI parking protocol\n",
-			  cpu);
-		break;
-#endif
-
 	default:
 		pr_crit("CPU%u: Unknown IPI message 0x%x\n", cpu, ipinr);
 		break;
@@ -979,6 +962,17 @@ void arch_smp_send_reschedule(int cpu)
 	smp_cross_call(cpumask_of(cpu), IPI_RESCHEDULE);
 }
 
+#ifdef CONFIG_ARM64_ACPI_PARKING_PROTOCOL
+void arch_send_wakeup_ipi(int cpu)
+{
+	/*
+	 * We use a scheduler IPI to wake the CPU as this avoids the need for a
+	 * dedicated IPI and we can safely handle spurious scheduler IPIs.
+	 */
+	arch_smp_send_reschedule(cpu);
+}
+#endif
+
 #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
 void tick_broadcast(const struct cpumask *mask)
 {
-- 
2.30.2

