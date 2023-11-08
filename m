Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E147E5586
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 12:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344508AbjKHL3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 06:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjKHL3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 06:29:03 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 549E7B0
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 03:29:01 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 830001477;
        Wed,  8 Nov 2023 03:29:45 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.37.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C6ADF3F703;
        Wed,  8 Nov 2023 03:28:58 -0800 (PST)
Date:   Wed, 8 Nov 2023 11:28:55 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        James Morse <james.morse@arm.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 1/2] arm64: Move Mediatek GIC quirk handling from
 irqchip to core
Message-ID: <ZUtw95AZ4sCbvqBk@FVFF77S0Q05N>
References: <20231107072651.v2.1.Ide945748593cffd8ff0feb9ae22b795935b944d6@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107072651.v2.1.Ide945748593cffd8ff0feb9ae22b795935b944d6@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 07:26:56AM -0800, Douglas Anderson wrote:
> In commit 44bd78dd2b88 ("irqchip/gic-v3: Disable pseudo NMIs on
> Mediatek devices w/ firmware issues") we added a method for detecting
> Mediatek devices with broken firmware and disabled pseudo-NMI. While
> that worked, it didn't address the problem at a deep enough level.
> 
> The fundamental issue with this broken firmware is that it's not
> saving and restoring several important GICR registers. The current
> list is believed to be:
> * GICR_NUM_IPRIORITYR
> * GICR_CTLR
> * GICR_ISPENDR0
> * GICR_ISACTIVER0
> * GICR_NSACR
> 
> Pseudo-NMI didn't work because it was the only thing (currently) in
> the kernel that relied on the broken registers, so forcing pseudo-NMI
> off was an effective fix. However, it could be observed that calling
> system_uses_irq_prio_masking() on these systems still returned
> "true". That caused confusion and led to the need for
> commit a07a59415217 ("arm64: smp: avoid NMI IPIs with broken MediaTek
> FW"). It's worried that the incorrect value returned by
> system_uses_irq_prio_masking() on these systems will continue to
> confuse future developers.
> 
> Let's fix the issue a little more completely by disabling IRQ
> priorities at a deeper level in the kernel. Once we do this we can
> revert some of the other bits of code dealing with this quirk.
> 
> This includes a partial revert of commit 44bd78dd2b88
> ("irqchip/gic-v3: Disable pseudo NMIs on Mediatek devices w/ firmware
> issues"). This isn't a full revert because it leaves some of the
> changes to the "quirks" structure around in case future code needs it.
> 
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
> 
> Changes in v2:
> - Just detect the quirk once at init time.
> - Fixed typo in subject: s/GiC/GIC.
> - Squash in ("Remove Mediatek pseudo-NMI firmware quirk handling").
> 
>  arch/arm64/kernel/cpufeature.c | 46 ++++++++++++++++++++++++++++------
>  drivers/irqchip/irq-gic-v3.c   | 22 +---------------
>  2 files changed, 39 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index f6b2e2906fc9..928124ea2e96 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -999,6 +999,37 @@ static void init_32bit_cpu_features(struct cpuinfo_32bit *info)
>  	init_cpu_ftr_reg(SYS_MVFR2_EL1, info->reg_mvfr2);
>  }
>  
> +#ifdef CONFIG_ARM64_PSEUDO_NMI
> +static bool enable_pseudo_nmi;
> +
> +static int __init early_enable_pseudo_nmi(char *p)
> +{
> +	return kstrtobool(p, &enable_pseudo_nmi);
> +}
> +early_param("irqchip.gicv3_pseudo_nmi", early_enable_pseudo_nmi);
> +
> +static __init void detect_system_supports_pseudo_nmi(void)
> +{
> +	struct device_node *np;
> +
> +	if (!enable_pseudo_nmi)
> +		return;
> +
> +	/*
> +	 * Detect broken Mediatek firmware that doesn't properly save and
> +	 * restore GIC priorities.
> +	 */
> +	np = of_find_compatible_node(NULL, NULL, "arm,gic-v3");
> +	if (np && of_property_read_bool(np, "mediatek,broken-save-restore-fw")) {
> +		pr_info("Pseudo-NMI disabled due to Mediatek Chromebook GICR save problem\n");
> +		enable_pseudo_nmi = false;
> +	}
> +	of_node_put(np);
> +}
> +#else /* CONFIG_ARM64_PSEUDO_NMI */
> +static inline void detect_system_supports_pseudo_nmi(void) { }
> +#endif
> +
>  void __init init_cpu_features(struct cpuinfo_arm64 *info)
>  {
>  	/* Before we start using the tables, make sure it is sorted */
> @@ -1057,6 +1088,13 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
>  	 */
>  	init_cpucap_indirect_list();
>  
> +	/*
> +	 * Detect broken pseudo-NMI. Must be called _before_ the call to
> +	 * setup_boot_cpu_capabilities() since it interacts with
> +	 * can_use_gic_priorities().
> +	 */
> +	detect_system_supports_pseudo_nmi();
> +
>  	/*
>  	 * Detect and enable early CPU capabilities based on the boot CPU,
>  	 * after we have initialised the CPU feature infrastructure.
> @@ -2085,14 +2123,6 @@ static void cpu_enable_e0pd(struct arm64_cpu_capabilities const *cap)
>  #endif /* CONFIG_ARM64_E0PD */
>  
>  #ifdef CONFIG_ARM64_PSEUDO_NMI
> -static bool enable_pseudo_nmi;
> -
> -static int __init early_enable_pseudo_nmi(char *p)
> -{
> -	return kstrtobool(p, &enable_pseudo_nmi);
> -}
> -early_param("irqchip.gicv3_pseudo_nmi", early_enable_pseudo_nmi);
> -
>  static bool can_use_gic_priorities(const struct arm64_cpu_capabilities *entry,
>  				   int scope)
>  {
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index 68d11ccee441..1ba674367ee3 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -39,8 +39,7 @@
>  
>  #define FLAGS_WORKAROUND_GICR_WAKER_MSM8996	(1ULL << 0)
>  #define FLAGS_WORKAROUND_CAVIUM_ERRATUM_38539	(1ULL << 1)
> -#define FLAGS_WORKAROUND_MTK_GICR_SAVE		(1ULL << 2)
> -#define FLAGS_WORKAROUND_ASR_ERRATUM_8601001	(1ULL << 3)
> +#define FLAGS_WORKAROUND_ASR_ERRATUM_8601001	(1ULL << 2)
>  
>  #define GIC_IRQ_TYPE_PARTITION	(GIC_IRQ_TYPE_LPI + 1)
>  
> @@ -1779,15 +1778,6 @@ static bool gic_enable_quirk_msm8996(void *data)
>  	return true;
>  }
>  
> -static bool gic_enable_quirk_mtk_gicr(void *data)
> -{
> -	struct gic_chip_data *d = data;
> -
> -	d->flags |= FLAGS_WORKAROUND_MTK_GICR_SAVE;
> -
> -	return true;
> -}
> -
>  static bool gic_enable_quirk_cavium_38539(void *data)
>  {
>  	struct gic_chip_data *d = data;
> @@ -1888,11 +1878,6 @@ static const struct gic_quirk gic_quirks[] = {
>  		.compatible = "asr,asr8601-gic-v3",
>  		.init	= gic_enable_quirk_asr8601,
>  	},
> -	{
> -		.desc	= "GICv3: Mediatek Chromebook GICR save problem",
> -		.property = "mediatek,broken-save-restore-fw",
> -		.init	= gic_enable_quirk_mtk_gicr,
> -	},
>  	{
>  		.desc	= "GICv3: HIP06 erratum 161010803",
>  		.iidr	= 0x0204043b,
> @@ -1959,11 +1944,6 @@ static void gic_enable_nmi_support(void)
>  	if (!gic_prio_masking_enabled())
>  		return;
>  
> -	if (gic_data.flags & FLAGS_WORKAROUND_MTK_GICR_SAVE) {
> -		pr_warn("Skipping NMI enable due to firmware issues\n");
> -		return;
> -	}
> -
>  	rdist_nmi_refs = kcalloc(gic_data.ppi_nr + SGI_NR,
>  				 sizeof(*rdist_nmi_refs), GFP_KERNEL);
>  	if (!rdist_nmi_refs)
> -- 
> 2.42.0.869.gea05f2083d-goog
> 
