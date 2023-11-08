Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733627E558B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 12:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344516AbjKHL3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 06:29:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344193AbjKHL3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 06:29:54 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 15F49186
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 03:29:52 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C3B11477;
        Wed,  8 Nov 2023 03:30:36 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.37.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 710473F703;
        Wed,  8 Nov 2023 03:29:49 -0800 (PST)
Date:   Wed, 8 Nov 2023 11:29:46 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        D Scott Phillips <scott@os.amperecomputing.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] Revert "arm64: smp: avoid NMI IPIs with broken
 MediaTek FW"
Message-ID: <ZUtxKgPkTZJ9gthU@FVFF77S0Q05N>
References: <20231107072651.v2.1.Ide945748593cffd8ff0feb9ae22b795935b944d6@changeid>
 <20231107072651.v2.2.I2c5fa192e767eb3ee233bc28eb60e2f8656c29a6@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107072651.v2.2.I2c5fa192e767eb3ee233bc28eb60e2f8656c29a6@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 07:26:57AM -0800, Douglas Anderson wrote:
> This reverts commit a07a594152173a3dd3bdd12fc7d73dbba54cdbca.
> 
> This is no longer needed after the patch ("arm64: Move Mediatek GIC
> quirk handling from irqchip to core).
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
> 
> Changes in v2:
> - Fixed typo in subject: s/GiC/GIC.
> 
>  arch/arm64/kernel/smp.c      | 5 +----
>  drivers/irqchip/irq-gic-v3.c | 2 +-
>  2 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index be95b523c101..defbab84e9e5 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -965,10 +965,7 @@ static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
>  
>  static bool ipi_should_be_nmi(enum ipi_msg_type ipi)
>  {
> -	DECLARE_STATIC_KEY_FALSE(supports_pseudo_nmis);
> -
> -	if (!system_uses_irq_prio_masking() ||
> -	    !static_branch_likely(&supports_pseudo_nmis))
> +	if (!system_uses_irq_prio_masking())
>  		return false;
>  
>  	switch (ipi) {
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index 1ba674367ee3..98b0329b7154 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -105,7 +105,7 @@ static DEFINE_STATIC_KEY_TRUE(supports_deactivate_key);
>   * - Figure 4-7 Secure read of the priority field for a Non-secure Group 1
>   *   interrupt.
>   */
> -DEFINE_STATIC_KEY_FALSE(supports_pseudo_nmis);
> +static DEFINE_STATIC_KEY_FALSE(supports_pseudo_nmis);
>  
>  DEFINE_STATIC_KEY_FALSE(gic_nonsecure_priorities);
>  EXPORT_SYMBOL(gic_nonsecure_priorities);
> -- 
> 2.42.0.869.gea05f2083d-goog
> 
