Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D6C7CC0C0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 12:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343576AbjJQKfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 06:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234594AbjJQKfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 06:35:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 42587A2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 03:35:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 869872F4;
        Tue, 17 Oct 2023 03:36:28 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.68.232])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A2D843F762;
        Tue, 17 Oct 2023 03:35:46 -0700 (PDT)
Date:   Tue, 17 Oct 2023 11:35:44 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, suzuki.poulose@arm.com,
        anshuman.khandual@arm.com, shan.gavin@gmail.com
Subject: Re: [PATCH] arm64: Remove system_uses_lse_atomics()
Message-ID: <ZS5jgCNm8jV9E8Ao@FVFF77S0Q05N>
References: <20231017005036.334067-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017005036.334067-1-gshan@redhat.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 10:50:36AM +1000, Gavin Shan wrote:
> There are two variants of system_uses_lse_atomics(), depending on
> CONFIG_ARM64_LSE_ATOMICS. The function isn't called anywhere when
> CONFIG_ARM64_LSE_ATOMICS is disabled. It can be directly replaced
> by alternative_has_cap_likely(ARM64_HAS_LSE_ATOMICS) when the kernel
> option is enabled.
> 
> No need to keep system_uses_lse_atomics() and just remove it.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>

I had meant to remove this already, so:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/include/asm/lse.h | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/lse.h b/arch/arm64/include/asm/lse.h
> index cbbcdc35c4cd..3129a5819d0e 100644
> --- a/arch/arm64/include/asm/lse.h
> +++ b/arch/arm64/include/asm/lse.h
> @@ -16,14 +16,9 @@
>  #include <asm/atomic_lse.h>
>  #include <asm/cpucaps.h>
>  
> -static __always_inline bool system_uses_lse_atomics(void)
> -{
> -	return alternative_has_cap_likely(ARM64_HAS_LSE_ATOMICS);
> -}
> -
>  #define __lse_ll_sc_body(op, ...)					\
>  ({									\
> -	system_uses_lse_atomics() ?					\
> +	alternative_has_cap_likely(ARM64_HAS_LSE_ATOMICS) ?		\
>  		__lse_##op(__VA_ARGS__) :				\
>  		__ll_sc_##op(__VA_ARGS__);				\
>  })
> @@ -34,8 +29,6 @@ static __always_inline bool system_uses_lse_atomics(void)
>  
>  #else	/* CONFIG_ARM64_LSE_ATOMICS */
>  
> -static inline bool system_uses_lse_atomics(void) { return false; }
> -
>  #define __lse_ll_sc_body(op, ...)		__ll_sc_##op(__VA_ARGS__)
>  
>  #define ARM64_LSE_ATOMIC_INSN(llsc, lse)	llsc
> -- 
> 2.41.0
> 
