Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13BA771DE2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 12:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbjHGKXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 06:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjHGKXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 06:23:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 941AB10F8;
        Mon,  7 Aug 2023 03:23:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 235D01FB;
        Mon,  7 Aug 2023 03:24:33 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.32.139])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A24E3F59C;
        Mon,  7 Aug 2023 03:23:47 -0700 (PDT)
Date:   Mon, 7 Aug 2023 11:23:44 +0100
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
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 5/7] arm64: ipi_debug: Add support for backtrace using
 the debug IPI
Message-ID: <ZNDGMJW01avOMShn@FVFF77S0Q05N.cambridge.arm.com>
References: <20230601213440.2488667-1-dianders@chromium.org>
 <20230601143109.v9.5.I65981105e1f62550b0316625dd1e599deaf9e1aa@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601143109.v9.5.I65981105e1f62550b0316625dd1e599deaf9e1aa@changeid>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 02:31:49PM -0700, Douglas Anderson wrote:
> From: Sumit Garg <sumit.garg@linaro.org>
> 
> Enable arch_trigger_cpumask_backtrace() support on arm64 using the new
> debug IPI. With this arm64 can now get backtraces in cases where
> callers of the trigger_xyz_backtrace() class of functions don't check
> the return code and implement a fallback. One example is
> `kernel.softlockup_all_cpu_backtrace`. This also allows us to
> backtrace hard locked up CPUs in cases where the debug IPI is backed
> by an NMI (or pseudo NMI).
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
> Changes in v9:
> - Added comments that we might not be using NMI always.
> - Renamed "NMI IPI" to "debug IPI" since it might not be backed by NMI.
> - arch_trigger_cpumask_backtrace() no longer returns bool
> 
> Changes in v8:
> - Removed "#ifdef CONFIG_SMP" since arm64 is always SMP
> 
>  arch/arm64/include/asm/irq.h  |  3 +++
>  arch/arm64/kernel/ipi_debug.c | 25 +++++++++++++++++++++++--
>  2 files changed, 26 insertions(+), 2 deletions(-)

As with prior patches, I'd prefer if this lived in smp.c with the other IPI
logic.

> 
> diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
> index fac08e18bcd5..be2d103f316e 100644
> --- a/arch/arm64/include/asm/irq.h
> +++ b/arch/arm64/include/asm/irq.h
> @@ -6,6 +6,9 @@
>  
>  #include <asm-generic/irq.h>
>  
> +void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self);
> +#define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
> +
>  struct pt_regs;
>  
>  int set_handle_irq(void (*handle_irq)(struct pt_regs *));
> diff --git a/arch/arm64/kernel/ipi_debug.c b/arch/arm64/kernel/ipi_debug.c
> index b57833e31eaf..6984ed507e1f 100644
> --- a/arch/arm64/kernel/ipi_debug.c
> +++ b/arch/arm64/kernel/ipi_debug.c
> @@ -8,6 +8,7 @@
>  
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
> +#include <linux/nmi.h>
>  #include <linux/smp.h>
>  
>  #include "ipi_debug.h"
> @@ -24,11 +25,31 @@ void arm64_debug_ipi(cpumask_t *mask)
>  	__ipi_send_mask(ipi_debug_desc, mask);
>  }
>  
> +void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
> +{
> +	/*
> +	 * NOTE: though nmi_trigger_cpumask_backtrace has "nmi_" in the name,
> +	 * nothing about it truly needs to be backed by an NMI, it's just that
> +	 * it's _allowed_ to be called from an NMI. If set_smp_debug_ipi()
> +	 * failed to get an NMI (or pseudo-NMI) this will just be backed by a
> +	 * regular IPI.
> +	 */
> +	nmi_trigger_cpumask_backtrace(mask, exclude_self, arm64_debug_ipi);
> +}
> +
>  static irqreturn_t ipi_debug_handler(int irq, void *data)
>  {
> -	/* nop, NMI handlers for special features can be added here. */
> +	irqreturn_t ret = IRQ_NONE;
> +
> +	/*
> +	 * NOTE: Just like in arch_trigger_cpumask_backtrace(), we're calling
> +	 * a function with "nmi_" in the name but it works fine even if we
> +	 * are using a regulaor IPI.
> +	 */
> +	if (nmi_cpu_backtrace(get_irq_regs()))
> +		ret = IRQ_HANDLED;
>  

Does this need the printk_deferred_{enter,exit}() that 32-bit arm has?

Thanks,
Mark.

> -	return IRQ_NONE;
> +	return ret;
>  }
>  
>  void debug_ipi_setup(void)
> -- 
> 2.41.0.rc2.161.g9c6817b8e7-goog
> 
