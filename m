Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76DF2771E0F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 12:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjHGK30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 06:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbjHGK3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 06:29:20 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 083FE1721;
        Mon,  7 Aug 2023 03:29:13 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A0571FB;
        Mon,  7 Aug 2023 03:29:42 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.32.139])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 79A453F59C;
        Mon,  7 Aug 2023 03:28:56 -0700 (PDT)
Date:   Mon, 7 Aug 2023 11:28:52 +0100
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
        Wei Li <liwei391@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 7/7] arm64: kgdb: Roundup cpus using the debug IPI
Message-ID: <ZNDHZLGds0DTN6zg@FVFF77S0Q05N.cambridge.arm.com>
References: <20230601213440.2488667-1-dianders@chromium.org>
 <20230601143109.v9.7.I2ef26d1b3bfbed2d10a281942b0da7d9854de05e@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601143109.v9.7.I2ef26d1b3bfbed2d10a281942b0da7d9854de05e@changeid>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 02:31:51PM -0700, Douglas Anderson wrote:
> From: Sumit Garg <sumit.garg@linaro.org>
> 
> Let's use the debug IPI for rounding up CPUs in kgdb. When the debug
> IPI is backed by an NMI (or pseudo NMI) then this will let us debug
> even hard locked CPUs. When the debug IPI isn't backed by an NMI then
> this won't really have any huge benefit but it will still work.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
> Changes in v9:
> - Remove fallback for when debug IPI isn't available.
> - Renamed "NMI IPI" to "debug IPI" since it might not be backed by NMI.
> 
>  arch/arm64/kernel/ipi_debug.c |  5 +++++
>  arch/arm64/kernel/kgdb.c      | 14 ++++++++++++++
>  2 files changed, 19 insertions(+)

This looks fine to me, but I'd feel a bit happier if we had separate SGIs for
the backtrace and the KGDB callback as they're logically unrelated.

Thanks,
Mark.

> 
> diff --git a/arch/arm64/kernel/ipi_debug.c b/arch/arm64/kernel/ipi_debug.c
> index 6984ed507e1f..5794894d94f1 100644
> --- a/arch/arm64/kernel/ipi_debug.c
> +++ b/arch/arm64/kernel/ipi_debug.c
> @@ -8,6 +8,7 @@
>  
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
> +#include <linux/kgdb.h>
>  #include <linux/nmi.h>
>  #include <linux/smp.h>
>  
> @@ -40,6 +41,7 @@ void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
>  static irqreturn_t ipi_debug_handler(int irq, void *data)
>  {
>  	irqreturn_t ret = IRQ_NONE;
> +	unsigned int cpu = smp_processor_id();
>  
>  	/*
>  	 * NOTE: Just like in arch_trigger_cpumask_backtrace(), we're calling
> @@ -49,6 +51,9 @@ static irqreturn_t ipi_debug_handler(int irq, void *data)
>  	if (nmi_cpu_backtrace(get_irq_regs()))
>  		ret = IRQ_HANDLED;
>  
> +	if (!kgdb_nmicallback(cpu, get_irq_regs()))
> +		ret = IRQ_HANDLED;
> +
>  	return ret;
>  }
>  
> diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
> index 4e1f983df3d1..9c4c47507cd4 100644
> --- a/arch/arm64/kernel/kgdb.c
> +++ b/arch/arm64/kernel/kgdb.c
> @@ -20,6 +20,8 @@
>  #include <asm/patching.h>
>  #include <asm/traps.h>
>  
> +#include "ipi_debug.h"
> +
>  struct dbg_reg_def_t dbg_reg_def[DBG_MAX_REG_NUM] = {
>  	{ "x0", 8, offsetof(struct pt_regs, regs[0])},
>  	{ "x1", 8, offsetof(struct pt_regs, regs[1])},
> @@ -356,3 +358,15 @@ int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt)
>  	return aarch64_insn_write((void *)bpt->bpt_addr,
>  			*(u32 *)bpt->saved_instr);
>  }
> +
> +void kgdb_roundup_cpus(void)
> +{
> +	struct cpumask mask;
> +
> +	cpumask_copy(&mask, cpu_online_mask);
> +	cpumask_clear_cpu(raw_smp_processor_id(), &mask);
> +	if (cpumask_empty(&mask))
> +		return;
> +
> +	arm64_debug_ipi(&mask);
> +}
> -- 
> 2.41.0.rc2.161.g9c6817b8e7-goog
> 
