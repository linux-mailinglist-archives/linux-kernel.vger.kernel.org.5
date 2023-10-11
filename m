Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A447C4C3E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 09:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345033AbjJKHqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 03:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjJKHqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 03:46:47 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3493698;
        Wed, 11 Oct 2023 00:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=61isM1aH9tWSRneo34EFdKetusAPfy8ZA6xHY6hutnw=; b=jwICPp03S1haGCDCXZYFoqMdLe
        UZE55NvzirG/CnXpvK74lkt1+aTJ+Hpj6G1mvD78sldy+GA7sVz049I77lzzAcgQs23H9CbmlSB93
        ponfAMWWkDcR9DhNf4HvWxIInj4lJ+fBuvqKGuUDEe3b62skraMBN9LMonbIKmBi3fG9CI0ryGGiO
        aR87ynqpq7vCJX7c68nAxbdpMe/3IllqQt8qSbJJE5Yuuxg3hYS2pyjRqwhBK1MX+kzeGPecC47yK
        VFrOqlCUvwsJI8dpDAytuOFO2qsYdM7MsI0m4j1VSCrAuDAOwQ0Gj9uQ5mDxss4V7D9DNd0iGgQ44
        2SlbY4DA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qqTv5-0003uD-0t;
        Wed, 11 Oct 2023 07:46:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 63E7530026F; Wed, 11 Oct 2023 09:46:16 +0200 (CEST)
Date:   Wed, 11 Oct 2023 09:46:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Fei Yang <fei.yang@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCHv2] x86/alternatives: Disable KASAN in apply_alternatives()
Message-ID: <20231011074616.GL14330@noisy.programming.kicks-ass.net>
References: <20231011065849.19075-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011065849.19075-1-kirill.shutemov@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 09:58:49AM +0300, Kirill A. Shutemov wrote:
> Fei has reported that KASAN triggers during apply_alternatives() on
> 5-level paging machine:
> 

Urgh @ KASAN splat, can't we summarize that?

> 
> On machines with 5-level paging, cpu_feature_enabled(X86_FEATURE_LA57)
> got patched. It includes KASAN code, where KASAN_SHADOW_START depends on
> __VIRTUAL_MASK_SHIFT, which is defined with the cpu_feature_enabled().
> 
> KASAN gets confused when apply_alternatives() patches the
> KASAN_SHADOW_START users. A test patch that makes KASAN_SHADOW_START
> static, by replacing __VIRTUAL_MASK_SHIFT with 56, fixes the issue.
> 
> Disable KASAN while kernel patches alternatives.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reported-by: Fei Yang <fei.yang@intel.com>
> Fixes: 6657fca06e3f ("x86/mm: Allow to boot without LA57 if CONFIG_X86_5LEVEL=y")
> Cc: stable@vger.kernel.org
> ---
> 
>  v2:
>   - Move kasan_disable/_enable_current() to cover whole loop, not only
>     text_poke_early();
>   - Adjust commit message.
> 
> ---
>  arch/x86/kernel/alternative.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index 517ee01503be..b4cc4d7c0825 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -403,6 +403,17 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
>  	u8 insn_buff[MAX_PATCH_LEN];
>  
>  	DPRINTK(ALT, "alt table %px, -> %px", start, end);
> +
> +	/*
> +	 * In the case CONFIG_X86_5LEVEL=y, KASAN_SHADOW_START is defined using
> +	 * cpu_feature_enabled(X86_FEATURE_LA57) and is therefore patched here.
> +	 * During the process, KASAN becomes confused and triggers

	because of partial LA57 convertion ..

> +	 * a false-positive out-of-bound report.
> +	 *
> +	 * Disable KASAN until the patching is complete.
> +	 */
> +	kasan_disable_current();
> +
>  	/*
>  	 * The scan order should be from start to end. A later scanned
>  	 * alternative code can overwrite previously scanned alternative code.
> @@ -452,6 +463,8 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
>  
>  		text_poke_early(instr, insn_buff, insn_buff_sz);
>  	}
> +
> +	kasan_enable_current();
>  }

Other than that, ACK.
