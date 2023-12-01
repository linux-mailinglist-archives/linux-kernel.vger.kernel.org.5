Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC948015A1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 22:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379691AbjLAVoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 16:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLAVoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 16:44:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F6DE6
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 13:44:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ADDDC433C9;
        Fri,  1 Dec 2023 21:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701467047;
        bh=Gt2exZhN0pfBhamoCKIzysIgj2FlXmSneCvHWmAiG1o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SrE6sgFs70knxhrz67wYrNEqcgFC+AdktpAWBbze6mUqHNG+++qLum+0DA4kxYsm2
         QmThJR8YPgLxB0hP495k/fLvImeUyLdmCxoWF7yuHgT1pBQlYFD/dZdLDwes6649GM
         l2ryaKPwodXfb+T8gCq2DlE05hL8rnZDq56WU/XEGou92PWt/lDqLint27GmlYkDiC
         G1UJIhqDIVQEjFApUp79dy7S6pA2RvWgReNLaEGxR6+tLqRJKeJhFQBpPeLPFfuf0N
         OB7PSF0PUVNKjTLQ39XfBsIdeumJqQ1/qlTmkhWq5v9XbFtwXEcWTMlpQ9GdvUDqFk
         I6YRjpPQniUWA==
Date:   Fri, 1 Dec 2023 14:44:05 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     x86@kernel.org, llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] x86/callthunks: Correct calculation of dest address in
 is_callthunk()
Message-ID: <20231201214405.GA1533860@dev-arch.thelio-3990X>
References: <20231201085727.3647051-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201085727.3647051-1-ubizjak@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 09:57:27AM +0100, Uros Bizjak wrote:
> GCC didn't warn on the invalid use of relocation destination
> pointer, so the calculated destination value was applied to
> the uninitialized pointer location in error.
> 
> Fixes: 17bce3b2ae2d ("x86/callthunks: Handle %rip-relative relocations in call thunk template")
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Closes: https://lore.kernel.org/lkml/20231201035457.GA321497@dev-arch.thelio-3990X/
> Cc: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>

This obviously clears up the warning and all my machines booted
(although I don't think any of them actually exercise this code path?):

Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  arch/x86/kernel/callthunks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
> index f5507c95e7be..c561dd481eb9 100644
> --- a/arch/x86/kernel/callthunks.c
> +++ b/arch/x86/kernel/callthunks.c
> @@ -306,7 +306,7 @@ static bool is_callthunk(void *addr)
>  	if (!thunks_initialized || skip_addr((void *)dest))
>  		return false;
>  
> -	*pad = dest - tmpl_size;
> +	pad = (void *)(dest - tmpl_size);
>  
>  	memcpy(insn_buff, skl_call_thunk_template, tmpl_size);
>  	apply_relocation(insn_buff, tmpl_size, pad,
> -- 
> 2.31.1
> 
