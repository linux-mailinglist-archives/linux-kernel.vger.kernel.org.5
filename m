Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832B6771DD1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 12:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjHGKRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 06:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjHGKRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 06:17:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F92210F3;
        Mon,  7 Aug 2023 03:17:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE9E61FB;
        Mon,  7 Aug 2023 03:18:34 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.32.139])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A99AB3F59C;
        Mon,  7 Aug 2023 03:17:48 -0700 (PDT)
Date:   Mon, 7 Aug 2023 11:17:45 +0100
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
        Ben Dooks <ben-linux@fluff.org>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 4/7] arm64: smp: Assign and setup the debug IPI
Message-ID: <ZNDEyT3mHCl0UQIV@FVFF77S0Q05N.cambridge.arm.com>
References: <20230601213440.2488667-1-dianders@chromium.org>
 <20230601143109.v9.4.I6d7f7d5fa0aa293c8c3374194947254b93114d37@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601143109.v9.4.I6d7f7d5fa0aa293c8c3374194947254b93114d37@changeid>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 02:31:48PM -0700, Douglas Anderson wrote:
> From: Sumit Garg <sumit.garg@linaro.org>
> 
> All current arm64 interrupt controllers have at least 8
> IPIs. Currently we are only using 7 of them on arm64. Let's use the
> 8th one as a debug IPI. This uses the new "debug IPI" infrastructure
> which will try to allocate this IPI as an NMI/pseudo NMI if possible.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

I think with my suggestion on the prior patch, we don't need the additional
logic here.

> ---
> I could imagine that people object to using up the last free IPI on
> interrupt controllers with only 8 IPIs. However, it shouldn't be a big
> deal. If we later need an extra IPI, it shouldn't be too hard to
> combine some of the existing ones. Presumably we could just get rid of
> the "crash stop" IPI and have the normal "stop" IPI do the crash if
> "waiting_for_crash_ipi" is non-zero

TBH, I'd love to unify the logic for IPI_CPU_STOP and IPI_CPU_CRASH_STOP as
they have a bunch of pointless divergence.

We could also remove IPI_WAKEUP and replace that with something else (e.g.
IPI_CALL_FUNC with an empty function) in order to free up an IPI.

I'd *also* prefer to have separate IPI_CPU_BACKTRACE and IPI_CPU_DEBUG as the
backtrace logic is used for a bunch of things other than KGDB (e.g. RCU stalls,
panic), and that would clearly separate the logic for the two cases.

Thanks,
Mark.

> 
> Changes in v9:
> - Add a warning if we don't have enough IPIs for the NMI IPI
> - Renamed "NMI IPI" to "debug IPI" since it might not be backed by NMI.
> - Update commit description
> 
> Changes in v8:
> - debug_ipi_setup() and debug_ipi_teardown() no longer take cpu param
> 
>  arch/arm64/kernel/smp.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index edd63894d61e..db019b49d3bd 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -53,6 +53,8 @@
>  
>  #include <trace/events/ipi.h>
>  
> +#include "ipi_debug.h"
> +
>  DEFINE_PER_CPU_READ_MOSTLY(int, cpu_number);
>  EXPORT_PER_CPU_SYMBOL(cpu_number);
>  
> @@ -935,6 +937,8 @@ static void ipi_setup(int cpu)
>  
>  	for (i = 0; i < nr_ipi; i++)
>  		enable_percpu_irq(ipi_irq_base + i, 0);
> +
> +	debug_ipi_setup();
>  }
>  
>  #ifdef CONFIG_HOTPLUG_CPU
> @@ -947,6 +951,8 @@ static void ipi_teardown(int cpu)
>  
>  	for (i = 0; i < nr_ipi; i++)
>  		disable_percpu_irq(ipi_irq_base + i);
> +
> +	debug_ipi_teardown();
>  }
>  #endif
>  
> @@ -968,6 +974,11 @@ void __init set_smp_ipi_range(int ipi_base, int n)
>  		irq_set_status_flags(ipi_base + i, IRQ_HIDDEN);
>  	}
>  
> +	if (n > nr_ipi)
> +		set_smp_debug_ipi(ipi_base + nr_ipi);
> +	else
> +		WARN(1, "Not enough IPIs for NMI IPI\n");
> +
>  	ipi_irq_base = ipi_base;
>  
>  	/* Setup the boot CPU immediately */
> -- 
> 2.41.0.rc2.161.g9c6817b8e7-goog
> 
