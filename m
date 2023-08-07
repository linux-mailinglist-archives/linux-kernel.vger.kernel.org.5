Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51406771DCA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 12:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjHGKM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 06:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjHGKMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 06:12:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B3F110EA;
        Mon,  7 Aug 2023 03:12:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 126241FB;
        Mon,  7 Aug 2023 03:13:06 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.32.139])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B1A13F59C;
        Mon,  7 Aug 2023 03:12:20 -0700 (PDT)
Date:   Mon, 7 Aug 2023 11:12:17 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
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
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 3/7] arm64: Add framework for a debug IPI
Message-ID: <ZNDDgRuNGzovddaO@FVFF77S0Q05N.cambridge.arm.com>
References: <20230601213440.2488667-1-dianders@chromium.org>
 <20230601143109.v9.3.Ie6c132b96ebbbcddbf6954b9469ed40a6960343c@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601143109.v9.3.Ie6c132b96ebbbcddbf6954b9469ed40a6960343c@changeid>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 02:31:47PM -0700, Douglas Anderson wrote:
> From: Sumit Garg <sumit.garg@linaro.org>
> 
> Introduce a framework for an IPI that will be used for debug
> purposes. The primary use case of this IPI will be to generate stack
> crawls on other CPUs, but it will also be used to round up CPUs for
> kgdb.
> 
> When possible, we try to allocate this debug IPI as an NMI (or a
> pseudo NMI). If that fails (due to CONFIG, an incompatible interrupt
> controller, a quirk, missing the "irqchip.gicv3_pseudo_nmi=1" kernel
> parameter, etc) we fall back to a normal IPI.
> 
> NOTE: hooking this up for CPU backtrace / kgdb will happen in a future
> patch, this just adds the framework.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

I think that we shouldn't add a framework in a separate file for this:

* This is very similar to our existing IPI management in smp.c, so it feels
  like duplication, or at least another thing we'd like to keep in-sync.

* We're going to want an NMI backtrace regardless of KGDB

* We're going to want the IPI_CPU_STOP and IPI_CRASH_CPU_STOP IPIs to be NMIs
  too.

I reckon it'd be better to extend the existing IPI logic in smp.c to allow IPIs
to be requested as NMIs, e.g.

----
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index edd63894d61e8..48e6aa62c473e 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -33,6 +33,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/kexec.h>
 #include <linux/kvm_host.h>
+#include <linux/nmi.h>
 
 #include <asm/alternative.h>
 #include <asm/atomic.h>
@@ -926,6 +927,21 @@ static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
 	__ipi_send_mask(ipi_desc[ipinr], target);
 }
 
+static bool ipi_should_be_nmi(enum ipi_msg_type ipi)
+{
+	if (!system_uses_irq_prio_masking())
+		return false;
+
+	switch (ipi) {
+	/*
+	 * TODO: select NMI IPIs here
+	 */
+		return true;
+	default:
+		return false;
+	}
+}
+
 static void ipi_setup(int cpu)
 {
 	int i;
@@ -933,8 +949,14 @@ static void ipi_setup(int cpu)
 	if (WARN_ON_ONCE(!ipi_irq_base))
 		return;
 
-	for (i = 0; i < nr_ipi; i++)
-		enable_percpu_irq(ipi_irq_base + i, 0);
+	for (i = 0; i < nr_ipi; i++) {
+		if (ipi_should_be_nmi(i)) {
+			prepare_percpu_nmi(ipi_irq_base + i);
+			enable_percpu_nmi(ipi_irq_base + i, 0);
+		} else {
+			enable_percpu_irq(ipi_irq_base + i, 0);
+		}
+	}
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -945,8 +967,14 @@ static void ipi_teardown(int cpu)
 	if (WARN_ON_ONCE(!ipi_irq_base))
 		return;
 
-	for (i = 0; i < nr_ipi; i++)
-		disable_percpu_irq(ipi_irq_base + i);
+	for (i = 0; i < nr_ipi; i++) {
+		if (ipi_should_be_nmi(i)) {
+			disable_percpu_nmi(ipi_irq_base + i);
+			teardown_percpu_nmi(ipi_irq_base + i);
+		} else {
+			disable_percpu_irq(ipi_irq_base + i);
+		}
+	}
 }
 #endif
 
@@ -958,11 +986,19 @@ void __init set_smp_ipi_range(int ipi_base, int n)
 	nr_ipi = min(n, NR_IPI);
 
 	for (i = 0; i < nr_ipi; i++) {
-		int err;
-
-		err = request_percpu_irq(ipi_base + i, ipi_handler,
-					 "IPI", &cpu_number);
-		WARN_ON(err);
+		int err = -EINVAL;
+
+		if (ipi_should_be_nmi(i)) {
+			err = request_percpu_nmi(ipi_base + i, ipi_handler,
+						 "IPI", &cpu_number);
+			WARN(err, "Could not request IPI %d as NMI, err=%d\n",
+			     i, err);
+		} else {
+			err = request_percpu_irq(ipi_base + i, ipi_handler,
+						 "IPI", &cpu_number);
+			WARN(err, "Could not request IPI %d as IRQ, err=%d\n",
+			     i, err);
+		}
 
 		ipi_desc[i] = irq_to_desc(ipi_base + i);
 		irq_set_status_flags(ipi_base + i, IRQ_HIDDEN);
----

... and then if we need an IPI for KGDB, we can add that to the existing list
of IPIs, and have it requested/enabled/disabled as usual.

Thanks,
Mark.

> ---
> I didn't get any feedback from v8 patch #10 [1], but I went ahead and
> folded it in here anyway since it really simplfies things. If people
> don't like the fallback to regular IPI, I can also undo it.
> 
> [1] https://lore.kernel.org/r/20230419155341.v8.10.Ic3659997d6243139d0522fc3afcdfd88d7a5f030@changeid/
> 
> Changes in v9:
> - Fold in v8 patch #10 ("Fallback to a regular IPI if NMI isn't enabled")
> - Moved header file out of "include" since it didn't need to be there.
> - Remove arm64_supports_nmi()
> - Renamed "NMI IPI" to "debug IPI" since it might not be backed by NMI.
> 
> Changes in v8:
> - debug_ipi_setup() and debug_ipi_teardown() no longer take cpu param
> 
>  arch/arm64/kernel/Makefile    |  2 +-
>  arch/arm64/kernel/ipi_debug.c | 76 +++++++++++++++++++++++++++++++++++
>  arch/arm64/kernel/ipi_debug.h | 13 ++++++
>  3 files changed, 90 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/kernel/ipi_debug.c
>  create mode 100644 arch/arm64/kernel/ipi_debug.h
> 
> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> index cc22011ab66a..737838f803b7 100644
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -34,7 +34,7 @@ obj-y			:= debug-monitors.o entry.o irq.o fpsimd.o		\
>  			   cpufeature.o alternative.o cacheinfo.o		\
>  			   smp.o smp_spin_table.o topology.o smccc-call.o	\
>  			   syscall.o proton-pack.o idreg-override.o idle.o	\
> -			   patching.o
> +			   patching.o ipi_debug.o
>  
>  obj-$(CONFIG_COMPAT)			+= sys32.o signal32.o			\
>  					   sys_compat.o
> diff --git a/arch/arm64/kernel/ipi_debug.c b/arch/arm64/kernel/ipi_debug.c
> new file mode 100644
> index 000000000000..b57833e31eaf
> --- /dev/null
> +++ b/arch/arm64/kernel/ipi_debug.c
> @@ -0,0 +1,76 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Debug IPI support
> + *
> + * Copyright (C) 2020 Linaro Limited
> + * Author: Sumit Garg <sumit.garg@linaro.org>
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/smp.h>
> +
> +#include "ipi_debug.h"
> +
> +static struct irq_desc *ipi_debug_desc __read_mostly;
> +static int ipi_debug_id __read_mostly;
> +static bool is_nmi;
> +
> +void arm64_debug_ipi(cpumask_t *mask)
> +{
> +	if (WARN_ON_ONCE(!ipi_debug_desc))
> +		return;
> +
> +	__ipi_send_mask(ipi_debug_desc, mask);
> +}
> +
> +static irqreturn_t ipi_debug_handler(int irq, void *data)
> +{
> +	/* nop, NMI handlers for special features can be added here. */
> +
> +	return IRQ_NONE;
> +}
> +
> +void debug_ipi_setup(void)
> +{
> +	if (!ipi_debug_desc)
> +		return;
> +
> +	if (is_nmi) {
> +		if (!prepare_percpu_nmi(ipi_debug_id))
> +			enable_percpu_nmi(ipi_debug_id, IRQ_TYPE_NONE);
> +	} else {
> +		enable_percpu_irq(ipi_debug_id, IRQ_TYPE_NONE);
> +	}
> +}
> +
> +void debug_ipi_teardown(void)
> +{
> +	if (!ipi_debug_desc)
> +		return;
> +
> +	if (is_nmi) {
> +		disable_percpu_nmi(ipi_debug_id);
> +		teardown_percpu_nmi(ipi_debug_id);
> +	} else {
> +		disable_percpu_irq(ipi_debug_id);
> +	}
> +}
> +
> +void __init set_smp_debug_ipi(int ipi)
> +{
> +	int err;
> +
> +	if (!request_percpu_nmi(ipi, ipi_debug_handler, "IPI", &cpu_number)) {
> +		is_nmi = true;
> +	} else {
> +		err = request_percpu_irq(ipi, ipi_debug_handler, "IPI", &cpu_number);
> +		if (WARN_ON(err))
> +			return;
> +
> +		irq_set_status_flags(ipi, IRQ_HIDDEN);
> +	}
> +
> +	ipi_debug_desc = irq_to_desc(ipi);
> +	ipi_debug_id = ipi;
> +}
> diff --git a/arch/arm64/kernel/ipi_debug.h b/arch/arm64/kernel/ipi_debug.h
> new file mode 100644
> index 000000000000..f6011a09282f
> --- /dev/null
> +++ b/arch/arm64/kernel/ipi_debug.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_NMI_H
> +#define __ASM_NMI_H
> +
> +#include <linux/cpumask.h>
> +
> +void arm64_debug_ipi(cpumask_t *mask);
> +
> +void set_smp_debug_ipi(int ipi);
> +void debug_ipi_setup(void);
> +void debug_ipi_teardown(void);
> +
> +#endif
> -- 
> 2.41.0.rc2.161.g9c6817b8e7-goog
> 
