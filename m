Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6174800253
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 04:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377201AbjLADyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 22:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjLADyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 22:54:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD4210D7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 19:55:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62ABAC433C8;
        Fri,  1 Dec 2023 03:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701402900;
        bh=2eDs4rq/o2XffOF2c3AbganMdUEvcgwhvDkUuTL6Ks8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NpE2SaUiW5ZvDrhOhXYzsnU0dePt+6ngyVmnyYun5XctDO7RXcU4oK7xE/D0OMSgz
         8h+ykVLnUyskKTFsDzUnI6nQ/CJ1jJDD/498a1t5g5XIgW2Y6+4xiI7gYpJiEQHsar
         hpy3NZLDmU170gwZYh8+RK9/jRHsZLppceiP02vJ7mrDdM8W39b6scSgNdTdpFlGiN
         pzzdPALI87+hTO4qTDpT0jgDpDXKWyelpdkSfbdHvnSRXGXd3UMb911N45DQ4tfuFM
         sGDy13+zlv4uaAhmNdAuLV6BTHmpRFcFb8TVN2Ejf4VWTPep6eaLInU7YzaiA18bSS
         9QJe/Ec5oDwqQ==
Date:   Thu, 30 Nov 2023 20:54:57 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, llvm@lists.linux.dev
Subject: Re: [PATCH -tip v2 2/3] x86/callthunks: Handle %rip-relative
 relocations in call thunk template
Message-ID: <20231201035457.GA321497@dev-arch.thelio-3990X>
References: <20231105213731.1878100-1-ubizjak@gmail.com>
 <20231105213731.1878100-3-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231105213731.1878100-3-ubizjak@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uros,

On Sun, Nov 05, 2023 at 10:34:36PM +0100, Uros Bizjak wrote:
> Contrary to alternatives, relocations are currently not supported in
> call thunk templates.  Re-use the existing infrastructure from
> alternative.c to allow %rip-relative relocations when copying call
> thunk template from its storage location.
> 
> The patch allows unification of ASM_INCREMENT_CALL_DEPTH, which already
> uses PER_CPU_VAR macro, with INCREMENT_CALL_DEPTH, used in call thunk
> template, which is currently limited to use absolute address.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
...
> diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
> index e9ad518a5003..ef9c04707b3c 100644
> --- a/arch/x86/kernel/callthunks.c
> +++ b/arch/x86/kernel/callthunks.c
...
> @@ -291,20 +298,27 @@ void *callthunks_translate_call_dest(void *dest)
>  static bool is_callthunk(void *addr)
>  {
>  	unsigned int tmpl_size = SKL_TMPL_SIZE;
> -	void *tmpl = skl_call_thunk_template;
> +	u8 insn_buff[MAX_PATCH_LEN];
>  	unsigned long dest;
> +	u8 *pad;
>  
>  	dest = roundup((unsigned long)addr, CONFIG_FUNCTION_ALIGNMENT);
>  	if (!thunks_initialized || skip_addr((void *)dest))
>  		return false;
>  
> -	return !bcmp((void *)(dest - tmpl_size), tmpl, tmpl_size);
> +	*pad = dest - tmpl_size;

Clang warns (or errors with CONFIG_WERROR=y):

  arch/x86/kernel/callthunks.c:315:3: error: variable 'pad' is uninitialized when used here [-Werror,-Wuninitialized]
    315 |         *pad = dest - tmpl_size;
        |          ^~~
  arch/x86/kernel/callthunks.c:309:9: note: initialize the variable 'pad' to silence this warning
    309 |         u8 *pad;
        |                ^
        |                 = NULL
  1 error generated.

which came from our continuous integration:

https://github.com/ClangBuiltLinux/continuous-integration2/actions/runs/7054081453/job/19205345548
https://storage.tuxsuite.com/public/clangbuiltlinux/continuous-integration2/builds/2Yv1FATZZIeD3P7S57ZkHYhyZ8A/build.log

> +
> +	memcpy(insn_buff, skl_call_thunk_template, tmpl_size);
> +	apply_relocation(insn_buff, tmpl_size, pad,
> +			 skl_call_thunk_template, tmpl_size);
> +
> +	return !bcmp(pad, insn_buff, tmpl_size);
>  }

Cheers,
Nathan
