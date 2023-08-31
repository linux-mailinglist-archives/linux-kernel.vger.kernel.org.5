Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D784978E9FA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 12:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343915AbjHaKOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 06:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344124AbjHaKOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 06:14:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C9A59CED;
        Thu, 31 Aug 2023 03:14:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DFCCC15;
        Thu, 31 Aug 2023 03:14:50 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.3.201])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3EF463F64C;
        Thu, 31 Aug 2023 03:14:07 -0700 (PDT)
Date:   Thu, 31 Aug 2023 11:14:04 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Tomohiro Misono <misono.tomohiro@fujitsu.com>,
        Stephane Eranian <eranian@google.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <swboyd@chromium.org>, ito-yuichi@fujitsu.com,
        linux-perf-users@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        D Scott Phillips <scott@os.amperecomputing.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 6/7] arm64: kgdb: Implement kgdb_roundup_cpus() to
 enable pseudo-NMI roundup
Message-ID: <ZPBn7CJ9ppIheCT4@FVFF77S0Q05N>
References: <20230830191314.1618136-1-dianders@chromium.org>
 <20230830121115.v12.6.I2ef26d1b3bfbed2d10a281942b0da7d9854de05e@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830121115.v12.6.I2ef26d1b3bfbed2d10a281942b0da7d9854de05e@changeid>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 12:11:27PM -0700, Douglas Anderson wrote:
> Up until now we've been using the generic (weak) implementation for
> kgdb_roundup_cpus() when using kgdb on arm64. Let's move to a custom
> one. The advantage here is that, when pseudo-NMI is enabled on a
> device, we'll be able to round up CPUs using pseudo-NMI. This allows
> us to debug CPUs that are stuck with interrupts disabled. If
> pseudo-NMIs are not enabled then we'll fallback to just using an IPI,
> which is still slightly better than the generic implementation since
> it avoids the potential situation described in the generic
> kgdb_call_nmi_hook().
> 
> Co-developed-by: Sumit Garg <sumit.garg@linaro.org>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> I debated whether this should be in "arch/arm64/kernel/smp.c" or if I
> should try to find a way for it to go into "arch/arm64/kernel/kgdb.c".
> In the end this is so little code that it didn't seem worth it to find
> a way to export the IPI defines or to otherwise come up with some API
> between kgdb.c and smp.c. If someone has strong feelings and wants
> this to change, please shout and give details of your preferred
> solution.

Putting this in smp.c seems fine to me.

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> 
> FWIW, it seems like ~half the other platforms put this in "smp.c" with
> an ifdef for KGDB and the other half put it in "kgdb.c" with an ifdef
> for SMP. :-P
> 
> (no changes since v10)
> 
> Changes in v10:
> - Don't allocate the cpumask on the stack; just iterate.
> - Moved kgdb calls to smp.c to avoid needing to export IPI info.
> - kgdb now has its own IPI.
> 
> Changes in v9:
> - Remove fallback for when debug IPI isn't available.
> - Renamed "NMI IPI" to "debug IPI" since it might not be backed by NMI.
> 
>  arch/arm64/kernel/smp.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 800c59cf9b64..1a53e57c81d0 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -32,6 +32,7 @@
>  #include <linux/irq_work.h>
>  #include <linux/kernel_stat.h>
>  #include <linux/kexec.h>
> +#include <linux/kgdb.h>
>  #include <linux/kvm_host.h>
>  #include <linux/nmi.h>
>  
> @@ -79,6 +80,7 @@ enum ipi_msg_type {
>  	 * with trace_ipi_*
>  	 */
>  	IPI_CPU_BACKTRACE = NR_IPI,
> +	IPI_KGDB_ROUNDUP,
>  	MAX_IPI
>  };
>  
> @@ -868,6 +870,22 @@ void arch_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_cpu)
>  	nmi_trigger_cpumask_backtrace(mask, exclude_cpu, arm64_backtrace_ipi);
>  }
>  
> +#ifdef CONFIG_KGDB
> +void kgdb_roundup_cpus(void)
> +{
> +	int this_cpu = raw_smp_processor_id();
> +	int cpu;
> +
> +	for_each_online_cpu(cpu) {
> +		/* No need to roundup ourselves */
> +		if (cpu == this_cpu)
> +			continue;
> +
> +		__ipi_send_single(ipi_desc[IPI_KGDB_ROUNDUP], cpu);
> +	}
> +}
> +#endif
> +
>  /*
>   * Main handler for inter-processor interrupts
>   */
> @@ -919,6 +937,10 @@ static void do_handle_IPI(int ipinr)
>  		nmi_cpu_backtrace(get_irq_regs());
>  		break;
>  
> +	case IPI_KGDB_ROUNDUP:
> +		kgdb_nmicallback(cpu, get_irq_regs());
> +		break;
> +
>  	default:
>  		pr_crit("CPU%u: Unknown IPI message 0x%x\n", cpu, ipinr);
>  		break;
> @@ -949,6 +971,7 @@ static bool ipi_should_be_nmi(enum ipi_msg_type ipi)
>  	case IPI_CPU_STOP:
>  	case IPI_CPU_CRASH_STOP:
>  	case IPI_CPU_BACKTRACE:
> +	case IPI_KGDB_ROUNDUP:
>  		return true;
>  	default:
>  		return false;
> -- 
> 2.42.0.283.g2d96d420d3-goog
> 
