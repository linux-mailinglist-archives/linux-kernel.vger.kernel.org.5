Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067827D9F98
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 20:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346143AbjJ0SMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 14:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbjJ0SMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 14:12:05 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7BBC0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 11:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zK/CiVdYJ8O+SV9ZItDMSxFmIGXmmE9LWj7ScxLym7E=; b=kJfy/xce0qpXWt+FIbToecpdbr
        WJ3MPaGsCTj/TcHgcX6d63fM+R81DD6B7MXTpbQLnz7Z0C8VoPKWDoB0vPxIZSLuuhc3UGN1yoV3v
        8jf+rGque1UnJibpTB8Rrh7rdZ/dBGuk2OIRYqMri438TGbVNOV8CUh0DOe2oIfKJQhkDGYIDJ4j/
        mFILUlsBQfOg9xvIUun/ZMYX5iAng9NzolSsyuB4M8QFBJS1IojND+18/BcLIJULI7ohuZQi9WsfN
        oqDld2CcWJr0byYI/MbPtDTUkxL9AJryYRRRbmH9AtRGqBiwTVHXatNMoSlEkK1HNi/3oGLYcvzNd
        LTvziGGg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qwRJD-000uFQ-2G;
        Fri, 27 Oct 2023 18:11:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5F249300392; Fri, 27 Oct 2023 20:11:47 +0200 (CEST)
Date:   Fri, 27 Oct 2023 20:11:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>,
        Kishon VijayAbraham <Kishon.VijayAbraham@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] x86/alternative: Add per-vendor patching
Message-ID: <20231027181147.GC26550@noisy.programming.kicks-ass.net>
References: <20230622095212.20940-1-bp@alien8.de>
 <20230703125419.GJ4253@hirez.programming.kicks-ass.net>
 <20230704074631.GAZKPOV/9BfqP0aU8v@fat_crate.local>
 <20230704090132.GP4253@hirez.programming.kicks-ass.net>
 <20230704092222.GBZKPkzgdM8rbPe7zA@fat_crate.local>
 <20231027153327.GKZTvYR3qslaTUjtCT@fat_crate.local>
 <20231027153418.GLZTvYejCkXb03rArO@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027153418.GLZTvYejCkXb03rArO@fat_crate.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 05:34:18PM +0200, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> Date: Fri, 27 Oct 2023 13:34:12 +0200
> 
> Add the capability to apply alternatives not based on a CPU feature but
> on the current vendor the machine is running on.
> 
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> ---
>  arch/x86/include/asm/alternative.h |  7 ++++++-
>  arch/x86/kernel/alternative.c      | 14 +++++++++-----
>  2 files changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
> index 65f79092c9d9..76750f8b5aba 100644
> --- a/arch/x86/include/asm/alternative.h
> +++ b/arch/x86/include/asm/alternative.h
> @@ -8,8 +8,13 @@
>  
>  #define ALT_FLAGS_SHIFT		16
>  
> -#define ALT_FLAG_NOT		(1 << 0)
> +/* Negate the tested feature flag */
> +#define ALT_FLAG_NOT		BIT(0)
> +/* Check X86_VENDOR_* instead of a feature flag */
> +#define	ALT_FLAG_VENDOR		BIT(1)
> +
>  #define ALT_NOT(feature)	((ALT_FLAG_NOT << ALT_FLAGS_SHIFT) | (feature))
> +#define ALT_VENDOR(x86_vendor)	((ALT_FLAG_VENDOR << ALT_FLAGS_SHIFT) | (x86_vendor))
>  
>  #ifndef __ASSEMBLY__
>  
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index 73be3931e4f0..8b67b5c6090e 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -433,19 +433,23 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
>  
>  		/*
>  		 * Patch if either:
> +		 * - running on the respective x86 vendor
>  		 * - feature is present
>  		 * - feature not present but ALT_FLAG_NOT is set to mean,
>  		 *   patch if feature is *NOT* present.
>  		 */
> -		if (!boot_cpu_has(a->cpuid) == !(a->flags & ALT_FLAG_NOT)) {
> +		if (a->flags & ALT_FLAG_VENDOR) {
> +			if (boot_cpu_data.x86_vendor != a->cpuid) {
> +				optimize_nops(instr, a->instrlen);
> +				continue;
> +			}
> +		} else if (!boot_cpu_has(a->cpuid) == !(a->flags & ALT_FLAG_NOT)) {
>  			optimize_nops(instr, a->instrlen);
>  			continue;
>  		}

But what if I want to do ALT_FLAG_VENDOR | ALT_FLAG_NOT?

/me runs
