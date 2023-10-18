Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A107CDA06
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 13:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjJRLIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 07:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjJRLIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 07:08:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 57AD110F
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 04:08:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1AC202F4;
        Wed, 18 Oct 2023 04:08:49 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.67.200])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 613D13F762;
        Wed, 18 Oct 2023 04:08:06 -0700 (PDT)
Date:   Wed, 18 Oct 2023 12:08:03 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 3/3] irqchip/gic-v3: Remove Mediatek pseudo-NMI firmware
 quirk handling
Message-ID: <ZS-8k22ZWgn5hcCd@FVFF77S0Q05N>
References: <20231006151547.1.Ide945748593cffd8ff0feb9ae22b795935b944d6@changeid>
 <20231006151547.3.Ie582d33cfe46f9ec2248e7f2dabdd6bbd66486a6@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006151547.3.Ie582d33cfe46f9ec2248e7f2dabdd6bbd66486a6@changeid>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 03:15:53PM -0700, Douglas Anderson wrote:
> This is a partial revert of commit 44bd78dd2b88 ("irqchip/gic-v3:
> Disable pseudo NMIs on Mediatek devices w/ firmware issues"). In the
> patch ("arm64: Disable GiC priorities on Mediatek devices w/ firmware
> issues") we've moved the quirk handling to another place and so it's
> not needed in the GiC driver.
> 
> NOTE: this isn't a full revert because it leaves some of the changes
> to the "quirks" structure around in case future code needs it.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

I think it might make sense to fold this into the patch adding the cpucap
detection. Otherwise, if you apply my suggestions to the first patch, there's a
2-commit window where we'll have two places that log that NMI is being disabled
due to the FW issue. That's not a functional issue, so doesn't matter that
much.

Either way:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> 
>  drivers/irqchip/irq-gic-v3.c | 22 +---------------------
>  1 file changed, 1 insertion(+), 21 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index 787ccc880b22..9ff776709ae6 100644
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
> @@ -1790,15 +1789,6 @@ static bool gic_enable_quirk_msm8996(void *data)
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
> @@ -1891,11 +1881,6 @@ static const struct gic_quirk gic_quirks[] = {
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
> @@ -1957,11 +1942,6 @@ static void gic_enable_nmi_support(void)
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
> 2.42.0.609.gbb76f46606-goog
> 
