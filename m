Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E513477E925
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 20:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345456AbjHPS7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 14:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345437AbjHPS6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 14:58:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8732700;
        Wed, 16 Aug 2023 11:58:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2493D616BE;
        Wed, 16 Aug 2023 18:58:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C587C433C8;
        Wed, 16 Aug 2023 18:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692212321;
        bh=KOcJnVf+IGU2HZid9hXIz9udCgKgKpVwzp9BezrllYQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WAa03ArG6fJtgrH4Q/F1/UyLWFbddV2PsGcj7oOVMkfSq54qSd+qXeOHAIwYXltm1
         3GoSZDpxZiJVjTqVDYNWS6q2tJoXN2+vcE5AVAasxUzUrb+xOia19YFJZT45UGAVy/
         6DKChDW+AaoP6j7+H4sUZctU0CBlE9wWavlmswRPHFwsgkzWOboWh7fFnwRVSklcxB
         a8Od9glXb2jorhdOqm09jU6jkCf32aWNCKvYycIAA1QYfja6hhWkOa8uwqdrBOHIQp
         51TW16IbJaRLl7jm9L/+kvdixG4E07RD8RS9kcX0v4Udv78Qbot6bGg8Ck/fypNz9K
         bCZo+UdqI9lEw==
Date:   Wed, 16 Aug 2023 11:58:39 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>
Cc:     linux-tip-commits@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/cpu: Clean up SRSO return thunk mess
Message-ID: <20230816185839.GA3843691@dev-arch.thelio-3990X>
References: <20230814121148.842775684@infradead.org>
 <169217251663.27769.14430226618442726061.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169217251663.27769.14430226618442726061.tip-bot2@tip-bot2>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 07:55:16AM -0000, tip-bot2 for Peter Zijlstra wrote:
> The following commit has been merged into the x86/urgent branch of tip:
> 
> Commit-ID:     9010e01a8efffa0d14972b79fbe87bd329d79bfd
> Gitweb:        https://git.kernel.org/tip/9010e01a8efffa0d14972b79fbe87bd329d79bfd
> Author:        Peter Zijlstra <peterz@infradead.org>
> AuthorDate:    Mon, 14 Aug 2023 13:44:31 +02:00
> Committer:     Borislav Petkov (AMD) <bp@alien8.de>
> CommitterDate: Wed, 16 Aug 2023 09:39:16 +02:00
> 
> x86/cpu: Clean up SRSO return thunk mess

<snip>

> diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
> index a478eb5..fb81895 100644
> --- a/arch/x86/lib/retpoline.S
> +++ b/arch/x86/lib/retpoline.S
> @@ -151,22 +151,27 @@ SYM_CODE_END(__x86_indirect_jump_thunk_array)
>  	.section .text..__x86.rethunk_untrain
>  
>  SYM_START(srso_untrain_ret_alias, SYM_L_GLOBAL, SYM_A_NONE)
> +	UNWIND_HINT_FUNC
>  	ANNOTATE_NOENDBR
>  	ASM_NOP2
>  	lfence
> -	jmp __x86_return_thunk
> +	jmp srso_alias_return_thunk
>  SYM_FUNC_END(srso_untrain_ret_alias)
>  __EXPORT_THUNK(srso_untrain_ret_alias)
>  
>  	.section .text..__x86.rethunk_safe
> +#else
> +/* dummy definition for alternatives */
> +SYM_START(srso_untrain_ret_alias, SYM_L_GLOBAL, SYM_A_NONE)
> +	ANNOTATE_UNRET_SAFE
> +	ret
> +	int3
> +SYM_FUNC_END(srso_alias_untrain_ret)

Just a heads up, this series will have a small bisectability issue
because of this hunk, it needs

diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index fb818957955b..7df8582fb64e 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -166,7 +166,7 @@ SYM_START(srso_untrain_ret_alias, SYM_L_GLOBAL, SYM_A_NONE)
 	ANNOTATE_UNRET_SAFE
 	ret
 	int3
-SYM_FUNC_END(srso_alias_untrain_ret)
+SYM_FUNC_END(srso_untrain_ret_alias)
 #endif
 
 SYM_START(srso_safe_ret_alias, SYM_L_GLOBAL, SYM_A_NONE)

but it obviously gets fixed by commit a3fd3ac0a605 ("x86/cpu: Rename
srso_(.*)_alias to srso_alias_\1") so it is probably fine. I only
noticed it because I cherry-picked the first five changes to my patched
-next tree.

Cheers,
Nathan
