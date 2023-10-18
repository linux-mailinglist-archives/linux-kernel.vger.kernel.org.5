Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB30A7CD9FB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 13:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjJRLBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 07:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjJRLBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 07:01:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9844BB8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 04:01:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C495A2F4;
        Wed, 18 Oct 2023 04:02:17 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.67.200])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A6D953F762;
        Wed, 18 Oct 2023 04:01:34 -0700 (PDT)
Date:   Wed, 18 Oct 2023 12:01:32 +0100
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
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/3] arm64: Disable GiC priorities on Mediatek devices w/
 firmware issues
Message-ID: <ZS-7DC9OH2DUejLY@FVFF77S0Q05N>
References: <20231006151547.1.Ide945748593cffd8ff0feb9ae22b795935b944d6@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006151547.1.Ide945748593cffd8ff0feb9ae22b795935b944d6@changeid>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 03:15:51PM -0700, Douglas Anderson wrote:
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
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  arch/arm64/kernel/cpufeature.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 2806a2850e78..e35efab8efa9 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -2094,9 +2094,30 @@ static int __init early_enable_pseudo_nmi(char *p)
>  }
>  early_param("irqchip.gicv3_pseudo_nmi", early_enable_pseudo_nmi);
>  
> +static bool are_gic_priorities_broken(void)
> +{
> +	bool is_broken = false;
> +	struct device_node *np;
> +
> +	/*
> +	 * Detect broken Mediatek firmware that doesn't properly save and
> +	 * restore GIC priorities.
> +	 */
> +	np = of_find_compatible_node(NULL, NULL, "arm,gic-v3");
> +	if (np) {
> +		is_broken = of_property_read_bool(np, "mediatek,broken-save-restore-fw");
> +		of_node_put(np);
> +	}
> +
> +	return is_broken;
> +}

I'm definitely in favour of detecting this in the cpucap, but I think it'd be
better to parse the DT once on the boot CPU rather than on each CPU every time
it's brought up.

I think if we add something like:

#ifdef CONFIG_ARM64_PSEUDO_NMI
static void detect_system_supports_pseudo_nmi(void)
{
	struct device_node *np;

	if (!enable_pseudo_nmi)
		return;
	
	/*
	 * Detect broken Mediatek firmware that doesn't properly save and
	 * restore GIC priorities.
	 */
	np = of_find_compatible_node(NULL, NULL, "arm,gic-v3");
	if (np && of_property_read_bool(np, "mediatek,broken-save-restore-fw")) {
		pr_info("Pseudo-NMI disabled due to Mediatek Chromebook GICR save problem");
		enable_pseudo_nmi = false;
	}
	of_node_put(np);
}
#endif /* CONFIG_ARM64_PSEUDO_NMI */
static inline void detect_system_supports_pseudo_nmi(void) { }
#endif

... then we can call that from init_cpu_features() before we call
setup_boot_cpu_capabilities(), and then the existing logic in
can_use_gic_priorities() should just work as that returns the value of
enable_pseudo_nmi.

Note: of_node_put(NULL) does nothing, like kfree(NULL), so it's fine for that
to be called in the !np case.

Would you be happy to fold that in? I'm happy with a Suggested-by tag if so. :)

Mark
