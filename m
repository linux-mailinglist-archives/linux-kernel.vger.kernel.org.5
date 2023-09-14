Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A2C79F5CC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 02:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbjINAEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 20:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjINAEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 20:04:39 -0400
Received: from out-217.mta1.migadu.com (out-217.mta1.migadu.com [IPv6:2001:41d0:203:375::d9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55442E6A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 17:04:35 -0700 (PDT)
Date:   Thu, 14 Sep 2023 00:04:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694649873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kfv4Zhx1bwbtVJ2Jm5wO4ve633QMh2KTeWELK3A6p6w=;
        b=EkjUA9C2vZhCis33BkatvJsmHMcE1KLe7dGi3Nt1OT2o9Tupl61AJHhh6y2YeC3C31PwGF
        4284oBDu7yFUrVmO/1zQO7/2K+kvNbOOR66xDE7O7pt0oDzqr3jpZFCB28ZER9VodQDeut
        GANLbUAdtod/774vv0kRmU7VY7Y3vd4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Mark Brown <broonie@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Only default to enabling SVE when present
Message-ID: <ZQJODdfwZLxc9o1l@linux.dev>
References: <20230913-kvm-arm64-fp-init-v1-1-8ce9ba1cc4c4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913-kvm-arm64-fp-init-v1-1-8ce9ba1cc4c4@kernel.org>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Wed, Sep 13, 2023 at 07:34:16PM +0100, Mark Brown wrote:
> For unclear reasons our handling of SVE and SME when setting the default
> value of CPTR_EL2 for VHE mode is inconsistent. For normal VHE we
> unconditionally set CPTR_EL2.ZEN to 0b01 but only set the equivalent
> field CPTR_EL2.SMEN to 0b01 if SME is present, for hVHE we will always
> set the field 0b11 if SVE is not supported. Given the similarities
> between the two extensions it would generally be expected that the code
> handling SVE and SME would be very similar.
> 
> Since CPTR_ELx.ZEN is RES0 when SVE is not implemented it is probably not
> harmful to try to set the bits but it is better practice to not set
> unimplemented bits so resolve the inconsistency in favour of checking if
> SVE is present too.

It is entirely possible that implementers 'disable' a feature by hiding
it from the ID register, leaving the control bits completely functional.
These systems are at odds with the architecture, though we probably
shouldn't engage in _deliberately_ hostile programming patterns in the
kernel :)

> FPSIMD is also in theory optional though there's probably much more work to
> handle the case where it is not implemented properly and that is not
> something we see in practical systems.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/include/asm/kvm_emulate.h | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
> index 3d6725ff0bf6..4cf53b4aa226 100644
> --- a/arch/arm64/include/asm/kvm_emulate.h
> +++ b/arch/arm64/include/asm/kvm_emulate.h
> @@ -584,15 +584,17 @@ static __always_inline u64 kvm_get_reset_cptr_el2(struct kvm_vcpu *vcpu)
>  	u64 val;
>  
>  	if (has_vhe()) {
> -		val = (CPACR_EL1_FPEN_EL0EN | CPACR_EL1_FPEN_EL1EN |
> -		       CPACR_EL1_ZEN_EL1EN);
> +		val = (CPACR_EL1_FPEN_EL0EN | CPACR_EL1_FPEN_EL1EN);
> +		if (cpus_have_final_cap(ARM64_SVE))
> +			val |= CPACR_EL1_ZEN_EL1EN;
>  		if (cpus_have_final_cap(ARM64_SME))
>  			val |= CPACR_EL1_SMEN_EL1EN;
>  	} else if (has_hvhe()) {
>  		val = (CPACR_EL1_FPEN_EL0EN | CPACR_EL1_FPEN_EL1EN);
>  
> -		if (!vcpu_has_sve(vcpu) ||
> -		    (vcpu->arch.fp_state != FP_STATE_GUEST_OWNED))
> +		if (cpus_have_final_cap(ARM64_SVE) &&
> +		    (!vcpu_has_sve(vcpu) ||
> +		     (vcpu->arch.fp_state != FP_STATE_GUEST_OWNED)))

vcpu_has_sve() already tests system_supports_sve(), so I don't believe
this hunk is necessary.

-- 
Thanks,
Oliver
