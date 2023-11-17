Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04197EEF1E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 10:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345745AbjKQJpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 04:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345881AbjKQJoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 04:44:39 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD56171D
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 01:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pXuCWcFMMyNm3tQDni1BukKDks9Oa0qI5QFUTW5eN8U=; b=JwfecIc3SNWc5QSq5CmXKQA0f2
        DOu48zzXFAWzzBIG86ozmTfe3qEZCZaE67GH4j2AlmsZBjMPuxUnAMWCCUY68PUQQReK5hBE174QZ
        +Q5mk6uFwVyh/d1O5C6Y1hSUb4gyGTv/gD+4/1IRQkEz/L0ApIL5wgJHfKV92AvMbIk6gDW1bTEQb
        YpKkuRhR0tSPwxTpToazFw8aC6YqcxEhkzMh3fgq9zh+5YGB24aKnrSftpF7xj4T8rk3gedURjsSP
        gZWPuSufNirqQuOQI+Dn/BuvFi0vQITUax8cFM0CmcntN/Rd0qC0EZ0dPPzNi6d/ONbXu+Zd6OFOC
        GTN0Jq3Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r3vLU-007BRO-04;
        Fri, 17 Nov 2023 09:43:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id AD124300478; Fri, 17 Nov 2023 10:41:03 +0100 (CET)
Date:   Fri, 17 Nov 2023 10:41:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, kirill.shutemov@linux.intel.com
Subject: Re: [PATCH -tip] x86/mm: Use %RIP-relative address in untagged_addr()
Message-ID: <20231117094103.GM8262@noisy.programming.kicks-ass.net>
References: <20231116191127.3446476-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116191127.3446476-1-ubizjak@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2023 at 08:10:59PM +0100, Uros Bizjak wrote:
> %RIP-relative addresses are nowadays correctly handled in alternative
> instructions, so remove misleading comment and improve assembly to
> use %RIP-relative address.

Ha!, it might've been this exact case (and Kirill grumbling) that got me
to fix the alternative code :-)

> Also, explicitly using %gs: prefix will segfault for non-SMP builds.
> Use macros from percpu.h which will DTRT with segment prefix register
> as far as SMP/non-SMP builds are concerned.

> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>

Acked-byL Peter Zijlstra (Intel) <peterz@infradaed.org>

> ---
>  arch/x86/include/asm/uaccess_64.h | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
> index f2c02e4469cc..01455c0b070c 100644
> --- a/arch/x86/include/asm/uaccess_64.h
> +++ b/arch/x86/include/asm/uaccess_64.h
> @@ -11,6 +11,7 @@
>  #include <asm/alternative.h>
>  #include <asm/cpufeatures.h>
>  #include <asm/page.h>
> +#include <asm/percpu.h>
>  
>  #ifdef CONFIG_ADDRESS_MASKING
>  /*
> @@ -18,14 +19,10 @@
>   */
>  static inline unsigned long __untagged_addr(unsigned long addr)
>  {
> -	/*
> -	 * Refer tlbstate_untag_mask directly to avoid RIP-relative relocation
> -	 * in alternative instructions. The relocation gets wrong when gets
> -	 * copied to the target place.
> -	 */
>  	asm (ALTERNATIVE("",
> -			 "and %%gs:tlbstate_untag_mask, %[addr]\n\t", X86_FEATURE_LAM)
> -	     : [addr] "+r" (addr) : "m" (tlbstate_untag_mask));
> +			 "and " __percpu_arg([mask]) ", %[addr]", X86_FEATURE_LAM)
> +	     : [addr] "+r" (addr)
> +	     : [mask] "m" (__my_cpu_var(tlbstate_untag_mask)));
>  
>  	return addr;
>  }
> -- 
> 2.41.0
> 
