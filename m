Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D665F7F7042
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 10:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345202AbjKXJnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 04:43:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345376AbjKXJmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 04:42:43 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0B010F7;
        Fri, 24 Nov 2023 01:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4ImK8ZKf78iSxa2f5LHktOGbisjfNwWDxqqa3/kmr4s=; b=ONuzufwTHtkvCQAW4DtB+RrfFr
        EQ0LsWwjDM3e03aVWmdppi37DHTj4eop+PdXeonJclwq3cNj6Pq6mAM0WJ71AAyiIgfNupl8fBuYW
        9WWsm0+pbvX3YYec/NIlvTgSP0haxwRmnZ50TP0OVIJ1BsAgxed3wDtb/EzypBSf2mlKwk5972cXH
        WMt0G//XSqCJNvTth39+8i89Qwz3WkI6kwPooQN2vHtRxhDzwLdgrRKgXFqobS3cea+OXVYKvoYt/
        OGWxQeGgB5m8hqcBkN8FL/u5IVCaYKg7+ByPlO4lbxK9D0I6ASkcSycrI263I/7Ot9J/qDmrjt1s5
        +22o8F7g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r6Sfm-00DpiA-0b;
        Fri, 24 Nov 2023 09:42:33 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id D3CDB3002BE; Fri, 24 Nov 2023 10:40:29 +0100 (CET)
Date:   Fri, 24 Nov 2023 10:40:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yang Weijiang <weijiang.yang@intel.com>
Cc:     seanjc@google.com, pbonzini@redhat.com, dave.hansen@intel.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        chao.gao@intel.com, rick.p.edgecombe@intel.com,
        mlevitsk@redhat.com, john.allen@amd.com
Subject: Re: [PATCH v7 02/26] x86/fpu/xstate: Refine CET user xstate bit
 enabling
Message-ID: <20231124094029.GK3818@noisy.programming.kicks-ass.net>
References: <20231124055330.138870-1-weijiang.yang@intel.com>
 <20231124055330.138870-3-weijiang.yang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124055330.138870-3-weijiang.yang@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 12:53:06AM -0500, Yang Weijiang wrote:
> Remove XFEATURE_CET_USER entry from dependency array as the entry doesn't
> reflect true dependency between CET features and the user xstate bit.
> Enable the bit in fpu_kernel_cfg.max_features when either SHSTK or IBT is
> available.
> 
> Both user mode shadow stack and indirect branch tracking features depend
> on XFEATURE_CET_USER bit in XSS to automatically save/restore user mode
> xstate registers, i.e., IA32_U_CET and IA32_PL3_SSP whenever necessary.
> 
> Note, the issue, i.e., CPUID only enumerates IBT but no SHSTK is resulted
> from CET KVM series which synthesizes guest CPUIDs based on userspace
> settings,in real world the case is rare. In other words, the exitings
> dependency check is correct when only user mode SHSTK is available.
> 
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Tested-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
>  arch/x86/kernel/fpu/xstate.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index 73f6bc00d178..6e50a4251e2b 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -73,7 +73,6 @@ static unsigned short xsave_cpuid_features[] __initdata = {
>  	[XFEATURE_PT_UNIMPLEMENTED_SO_FAR]	= X86_FEATURE_INTEL_PT,
>  	[XFEATURE_PKRU]				= X86_FEATURE_OSPKE,
>  	[XFEATURE_PASID]			= X86_FEATURE_ENQCMD,
> -	[XFEATURE_CET_USER]			= X86_FEATURE_SHSTK,
>  	[XFEATURE_XTILE_CFG]			= X86_FEATURE_AMX_TILE,
>  	[XFEATURE_XTILE_DATA]			= X86_FEATURE_AMX_TILE,
>  };
> @@ -798,6 +797,14 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
>  			fpu_kernel_cfg.max_features &= ~BIT_ULL(i);
>  	}
>  
> +	/*
> +	 * CET user mode xstate bit has been cleared by above sanity check.
> +	 * Now pick it up if either SHSTK or IBT is available. Either feature
> +	 * depends on the xstate bit to save/restore user mode states.
> +	 */
> +	if (boot_cpu_has(X86_FEATURE_SHSTK) || boot_cpu_has(X86_FEATURE_IBT))
> +		fpu_kernel_cfg.max_features |= BIT_ULL(XFEATURE_CET_USER);

So booting a host with "ibt=off" will clear the FEATURE_IBT, this was
fine before this patch-set, but possibly not with.

That kernel argument really only wants to tell the kernel not to use IBT
itself, but not inhibit IBT from being used by guests.
