Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E447E7B5D17
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 00:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234616AbjJBWYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 18:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjJBWYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 18:24:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F411CCE
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 15:24:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2975CC433C8;
        Mon,  2 Oct 2023 22:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696285445;
        bh=6qGFQixEXCDQMv2uE867U8nPAhyA6HAp0HAbQvXyowI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y2TRtaufDtXKOBdW9HsEg/4Cmcj6gp1POmp49UuRFnR2kVNi6LhQ/dk+zg58rc3+8
         +6FVlz++Oaz7IchukZ9Z4RW4H2zeOpQQ+f1DfZVwZD0wMV3ljNFYNDNy3ELFQXvazN
         QZVDlrBL0cUsmlPqSH4y9emJ0b+xuoIaNXFFGvBcKNdPT4ZmE+pavRhKLe80n/yG/s
         R7v2Djgr5y/m6t+4wH+ghlMXbZ5MRkpvDYoIKuFetKi0ovvbuLfOi53Dcf/omzVeID
         QNWRjCHzKQs06ecWZbgC6iO2UnYTdX6ImkTfuxL40T7EhC4Cwdq/oWbMB3pxe8KM5f
         +fEvxSSZ2GEoQ==
Date:   Mon, 2 Oct 2023 15:24:02 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, acdunlap@google.com,
        ashok.raj@intel.com, bp@alien8.de, david@redhat.com,
        dionnaglaze@google.com, hpa@zytor.com, jacobhxu@google.com,
        jgross@suse.com, jroedel@suse.de, khalid.elmously@canonical.com,
        kim.phillips@amd.com, kirill.shutemov@linux.intel.com,
        llvm@lists.linux.dev, luto@kernel.org, mingo@redhat.com,
        nikunj@amd.com, peterz@infradead.org, pgonda@google.com,
        rientjes@google.com, rppt@kernel.org, seanjc@google.com,
        tglx@linutronix.de, thomas.lendacky@amd.com,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] x86/boot: Move x86_cache_alignment initialization to
 correct spot
Message-ID: <20231002222402.GA486933@dev-arch.thelio-3990X>
References: <20231002200426.GA4127272@dev-arch.thelio-3990X>
 <20231002220045.1014760-1-dave.hansen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002220045.1014760-1-dave.hansen@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 03:00:45PM -0700, Dave Hansen wrote:
> c->x86_cache_alignment is initialized from c->x86_clflush_size.
> However, commit fbf6449f84bf moved c->x86_clflush_size initialization
> to later in boot without moving the c->x86_cache_alignment assignment.
> 
> This presumably left c->x86_cache_alignment set to zero for longer
> than it should be.
> 
> The result was an oops on 32-bit kernels while accessing a pointer
> at 0x20.  The 0x20 came from accessing a structure member at offset
> 0x10 (buffer->cpumask) from a ZERO_SIZE_PTR=0x10.  kmalloc() can
> evidently return ZERO_SIZE_PTR when it's given 0 as its alignment
> requirement.
> 
> Move the c->x86_cache_alignment initialization to be after
> c->x86_clflush_size has an actual value.
> 
> Fixes: fbf6449f84bf ("x86/sev-es: Set x86_virt_bits to the correct value straight away, instead of a two-phase approach")
> Cc: Adam Dunlap <acdunlap@google.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Jacob Xu <jacobhxu@google.com>
> Link: https://lore.kernel.org/all/20231002200426.GA4127272@dev-arch.thelio-3990X/

Tested-by: Nathan Chancellor <nathan@kernel.org>

Thanks for the quick fix!

> ---
>  arch/x86/kernel/cpu/common.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 8d7063e4f63c9..9c51ad5bbf319 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -1141,6 +1141,7 @@ void get_cpu_address_sizes(struct cpuinfo_x86 *c)
>  		}
>  	}
>  	c->x86_cache_bits = c->x86_phys_bits;
> +	c->x86_cache_alignment = c->x86_clflush_size;
>  }
>  
>  static void identify_cpu_without_cpuid(struct cpuinfo_x86 *c)
> @@ -1594,8 +1595,6 @@ static void __init cpu_parse_early_param(void)
>   */
>  static void __init early_identify_cpu(struct cpuinfo_x86 *c)
>  {
> -	c->x86_cache_alignment = c->x86_clflush_size;
> -
>  	memset(&c->x86_capability, 0, sizeof(c->x86_capability));
>  	c->extended_cpuid_level = 0;
>  
> -- 
> 2.34.1
> 
