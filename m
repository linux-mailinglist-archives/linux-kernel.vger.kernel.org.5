Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E22176CBA9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 13:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbjHBLVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 07:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbjHBLVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 07:21:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C42268D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 04:21:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D12CF61934
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 11:21:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A58AC433C8;
        Wed,  2 Aug 2023 11:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690975288;
        bh=UM85u9Eehr9SJgkosXfFY8eaLUsGm9aavTi3il5wqIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e26DI5IHC5MeFhXMNn9hOLkxJSKXEE0lOMseiKxgOPVgPD3sIBXTWx06++1VqYzp1
         28emqGVvq366BWef4xpKcTbXKPacj0BWsr5noFwWfXSrN04SJUg6AXYJ05r9p6Wz1Y
         Hx7sp1kiCjK4n0TrAMTUkmP/AaynJ4kATcIns5euTnt/q9GsxkTTB03Bh6CHeBVGcb
         fHAocsI+bJaqzpueCEgyTteq3FoXQkP0tNUEBrEJCNfU9u09DM3VRYcNnDDzKFi/Y0
         L9I5Epph3cya8E5lvtSDy+cas8REXFrw814a7ojAnp6Yp5HlnB44OMEaQsUN6ZZWjW
         qM2jeXvhTNrvA==
Date:   Wed, 2 Aug 2023 12:21:23 +0100
From:   Will Deacon <will@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/fpsimd: Only provide the length to cpufeature for
 xCR registers
Message-ID: <20230802112122.GA27807@willie-the-truck>
References: <20230727-arm64-sme-fa64-hotplug-v1-1-34ae93afc05b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727-arm64-sme-fa64-hotplug-v1-1-34ae93afc05b@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 10:31:44PM +0100, Mark Brown wrote:
> For both SVE and SME we abuse the generic register field comparison
> support in the cpufeature code as part of our detection of unsupported
> variations in the vector lengths available to PEs, reporting the maximum
> vector lengths via ZCR_EL1.LEN and SMCR_EL1.LEN.  Since these are
> configuration registers rather than identification registers the
> assumptions the cpufeature code makes about how unknown bitfields behave
> are invalid, leading to warnings when SME features like FA64 are enabled
> and we hotplug a CPU:
> 
>   CPU features: SANITY CHECK: Unexpected variation in SYS_SMCR_EL1. Boot CPU: 0x0000000000000f, CPU3: 0x0000008000000f
>   CPU features: Unsupported CPU feature variation detected.
> 
> SVE has no controls other than the vector length so is not yet impacted
> but the same issue will apply there if any are defined.
> 
> Since the only field we are interested in having the cpufeature code
> handle is the length field and we use a custom read function to obtain
> the value we can avoid these warnings by filtering out all other bits
> when we return the register value.
> 
> Fixes: 2e0f2478ea37eb ("arm64/sve: Probe SVE capabilities and usable vector lengths")
> FixeS: b42990d3bf77cc ("arm64/sme: Identify supported SME vector lengths at boot")
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/kernel/fpsimd.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index 89d54a5242d1..c7fdeebd050c 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -1189,11 +1189,11 @@ u64 read_zcr_features(void)
>  	write_sysreg_s(ZCR_ELx_LEN_MASK, SYS_ZCR_EL1);
>  
>  	zcr = read_sysreg_s(SYS_ZCR_EL1);
> -	zcr &= ~(u64)ZCR_ELx_LEN_MASK; /* find sticky 1s outside LEN field */
> +	zcr &= ~(u64)ZCR_ELx_LEN_MASK;
>  	vq_max = sve_vq_from_vl(sve_get_vl());
>  	zcr |= vq_max - 1; /* set LEN field to maximum effective value */
>  
> -	return zcr;
> +	return SYS_FIELD_GET(ZCR_ELx, LEN, zcr);

Hmm, now this function looks like a mixture of code which relies on the
LEN field living at the bottom of the register and code which is agnostic
to that.

Can we update the 'zcr |= vq_max - 1' part to use something like
FIELD_PREP() instead?

>  }
>  
>  void __init sve_setup(void)
> @@ -1364,7 +1364,7 @@ u64 read_smcr_features(void)
>  	vq_max = sve_vq_from_vl(sme_get_vl());
>  	smcr |= vq_max - 1; /* set LEN field to maximum effective value */
>  
> -	return smcr;
> +	return SYS_FIELD_GET(SMCR_ELx, LEN, smcr);

It looks like there's a similar thing here.

Will
