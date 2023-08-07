Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A99771D82
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 11:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjHGJvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 05:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjHGJvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 05:51:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EC7F71711;
        Mon,  7 Aug 2023 02:50:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 990C31FB;
        Mon,  7 Aug 2023 02:51:13 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.32.139])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE1003F59C;
        Mon,  7 Aug 2023 02:50:27 -0700 (PDT)
Date:   Mon, 7 Aug 2023 10:50:25 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Douglas Anderson <dianders@chromium.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
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
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/7] irqchip/gic-v3: Enable support for SGIs to act as
 NMIs
Message-ID: <ZNC-YRQopO0PaIIo@FVFF77S0Q05N.cambridge.arm.com>
References: <20230601213440.2488667-1-dianders@chromium.org>
 <20230601143109.v9.1.I1223c11c88937bd0cbd9b086d4ef216985797302@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601143109.v9.1.I1223c11c88937bd0cbd9b086d4ef216985797302@changeid>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

On Thu, Jun 01, 2023 at 02:31:45PM -0700, Douglas Anderson wrote:
> From: Sumit Garg <sumit.garg@linaro.org>
> 
> Add support to handle SGIs as pseudo NMIs. As SGIs or IPIs default to a
> special flow handler: handle_percpu_devid_fasteoi_ipi(), so skip NMI
> handler update in case of SGIs.

I couldn't find handle_percpu_devid_fasteoi_ipi() in mainline, and when
researching I found that we changed that in commit:

  6abbd6988971aaa6 ("irqchip/gic, gic-v3: Make SGIs use handle_percpu_devid_irq()")

... which was in v5.11, so it looks like this is stale?

Since that commit, SGIs are treated the same as PPIs/EPPIs, and use
handle_percpu_devid_irq() by default.

IIUC handle_percpu_devid_irq() isn't NMI safe, and so to run in an NMI context
those should use handle_percpu_devid_fasteoi_nmi().

Marc, does that sound right to you? i.e. SGI NMIs should be handled exactly the
same as PPI NMIs, and use handle_percpu_devid_fasteoi_nmi()?

I have some comments below assuming that SGI NMIs should use
handle_percpu_devid_fasteoi_nmi().

> Also, enable NMI support prior to gic_smp_init() as allocation of SGIs
> as IRQs/NMIs happen as part of this routine.

This bit looks fine to me.

> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> Reviewed-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> Tested-by: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
> (no changes since v1)
> 
>  drivers/irqchip/irq-gic-v3.c | 29 +++++++++++++++++++++--------
>  1 file changed, 21 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index 0c6c1af9a5b7..ed37e02d4c5f 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -525,6 +525,7 @@ static u32 gic_get_ppi_index(struct irq_data *d)
>  static int gic_irq_nmi_setup(struct irq_data *d)
>  {
>  	struct irq_desc *desc = irq_to_desc(d->irq);
> +	u32 idx;
>  
>  	if (!gic_supports_nmi())
>  		return -EINVAL;
> @@ -542,16 +543,22 @@ static int gic_irq_nmi_setup(struct irq_data *d)
>  		return -EINVAL;
>  
>  	/* desc lock should already be held */
> -	if (gic_irq_in_rdist(d)) {
> -		u32 idx = gic_get_ppi_index(d);
> +	switch (get_intid_range(d)) {
> +	case SGI_RANGE:
> +		break;
> +	case PPI_RANGE:
> +	case EPPI_RANGE:
> +		idx = gic_get_ppi_index(d);
>  
>  		/* Setting up PPI as NMI, only switch handler for first NMI */
>  		if (!refcount_inc_not_zero(&ppi_nmi_refs[idx])) {
>  			refcount_set(&ppi_nmi_refs[idx], 1);
>  			desc->handle_irq = handle_percpu_devid_fasteoi_nmi;
>  		}
> -	} else {
> +		break;
> +	default:
>  		desc->handle_irq = handle_fasteoi_nmi;
> +		break;
>  	}

As above, I reckon this isn't right, and we should treat all rdist interrupts
(which are all percpu) the same.

I reckon what we should be doing here is make ppi_nmi_refs cover all of the
rdist interrupts (e.g. make that rdist_nmi_refs, add a gic_get_rdist_idx()
helper), and then here have something like:

	if (gic_irq_in_rdist(d)) {
		u32 idx = gic_get_rdist_idx(d);

		/* 
		 * Setting up a percpu interrupt as NMI, only switch handler
		 * for first NMI
		 */
		if (!refcount_inc_not_zero(&rdist_nmi_refs[idx])) {
			refcount_set(&ppi_nmi_refs[idx], 1);
			desc->handle_irq = handle_percpu_devid_fasteoi_nmi;
		}
	}

... as an aside, it'd be nicer if we could switch the handler at request time,
as then we wouldn't need the refcount at all, but I couldn't see a good irqchip
hook to hang that off, so I don't think that needs to change as a prerequisite.

>  
>  	gic_irq_set_prio(d, GICD_INT_NMI_PRI);
> @@ -562,6 +569,7 @@ static int gic_irq_nmi_setup(struct irq_data *d)
>  static void gic_irq_nmi_teardown(struct irq_data *d)
>  {
>  	struct irq_desc *desc = irq_to_desc(d->irq);
> +	u32 idx;
>  
>  	if (WARN_ON(!gic_supports_nmi()))
>  		return;
> @@ -579,14 +587,20 @@ static void gic_irq_nmi_teardown(struct irq_data *d)
>  		return;
>  
>  	/* desc lock should already be held */
> -	if (gic_irq_in_rdist(d)) {
> -		u32 idx = gic_get_ppi_index(d);
> +	switch (get_intid_range(d)) {
> +	case SGI_RANGE:
> +		break;
> +	case PPI_RANGE:
> +	case EPPI_RANGE:
> +		idx = gic_get_ppi_index(d);
>  
>  		/* Tearing down NMI, only switch handler for last NMI */
>  		if (refcount_dec_and_test(&ppi_nmi_refs[idx]))
>  			desc->handle_irq = handle_percpu_devid_irq;
> -	} else {
> +		break;
> +	default:
>  		desc->handle_irq = handle_fasteoi_irq;
> +		break;
>  	}

Same comments as for gic_irq_nmi_setup() here.

>  
>  	gic_irq_set_prio(d, GICD_INT_DEF_PRI);
> @@ -2001,6 +2015,7 @@ static int __init gic_init_bases(phys_addr_t dist_phys_base,
>  
>  	gic_dist_init();
>  	gic_cpu_init();
> +	gic_enable_nmi_support();
>  	gic_smp_init();
>  	gic_cpu_pm_init();
>  
> @@ -2013,8 +2028,6 @@ static int __init gic_init_bases(phys_addr_t dist_phys_base,
>  			gicv2m_init(handle, gic_data.domain);
>  	}
>  
> -	gic_enable_nmi_support();
> -

This bit looks fine to me.

Thanks,
Mark.
