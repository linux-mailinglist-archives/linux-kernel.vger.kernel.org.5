Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0BD17CD9FE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 13:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjJRLDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 07:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjJRLDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 07:03:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B71F11B
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 04:03:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5AC492F4;
        Wed, 18 Oct 2023 04:04:11 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.67.200])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 14CB23F762;
        Wed, 18 Oct 2023 04:03:27 -0700 (PDT)
Date:   Wed, 18 Oct 2023 12:03:25 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        D Scott Phillips <scott@os.amperecomputing.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] Revert "arm64: smp: avoid NMI IPIs with broken
 MediaTek FW"
Message-ID: <ZS-7fbqGJez7ho9r@FVFF77S0Q05N>
References: <20231006151547.1.Ide945748593cffd8ff0feb9ae22b795935b944d6@changeid>
 <20231006151547.2.I2c5fa192e767eb3ee233bc28eb60e2f8656c29a6@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006151547.2.I2c5fa192e767eb3ee233bc28eb60e2f8656c29a6@changeid>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 03:15:52PM -0700, Douglas Anderson wrote:
> This reverts commit a07a594152173a3dd3bdd12fc7d73dbba54cdbca.
> 
> This is no longer needed after the patch ("arm64: Disable GiC
> priorities on Mediatek devices w/ firmware issues").

That first patch has a typo in the title: s/GiC/GIC/

This patch makes sense to me, so:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  arch/arm64/kernel/smp.c      | 5 +----
>  drivers/irqchip/irq-gic-v3.c | 2 +-
>  2 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 16ead57a583d..f36a97a54d2b 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -964,10 +964,7 @@ static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
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
> index 737da1b9aabf..787ccc880b22 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -106,7 +106,7 @@ static DEFINE_STATIC_KEY_TRUE(supports_deactivate_key);
>   * - Figure 4-7 Secure read of the priority field for a Non-secure Group 1
>   *   interrupt.
>   */
> -DEFINE_STATIC_KEY_FALSE(supports_pseudo_nmis);
> +static DEFINE_STATIC_KEY_FALSE(supports_pseudo_nmis);
>  
>  DEFINE_STATIC_KEY_FALSE(gic_nonsecure_priorities);
>  EXPORT_SYMBOL(gic_nonsecure_priorities);
> -- 
> 2.42.0.609.gbb76f46606-goog
> 
