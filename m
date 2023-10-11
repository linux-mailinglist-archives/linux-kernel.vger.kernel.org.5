Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE4FC7C4C23
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 09:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344007AbjJKHly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 03:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344237AbjJKHlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 03:41:52 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C2D98
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 00:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NwwdyOmIcBB+xNLX4kU/9Jg2RxysZbVN5XtGJEqI3Ww=; b=MXmm8G6C6r9bYg15xSIBwBC9Xw
        zIwx8SVeGrdK84QjsxQQ1520diYXAF4yblV5Wy3FsJ9QEmNSTWJhJw+D6y4Xa/P9daLdtzQpkDfw6
        Nn8Z/bebp3pQ3Riw7SrXOlaTGlQo37p5/vGUQFYwD+UMmddJbu8X4s7Y6HNB77pfTh9sQKBVV3GVC
        lq+iKCVws6qZ4Ffu66JSc/y6dlLXQr6p+5xncQoPazHoy9hiw/jysBdV19rAqUtKwOihvjgs0tLM8
        Wjf81xWdwDzyH3YFEGVY34KjaKyH6NdGgEsRFv3z616KuGfKEzO4SU8WKKHiu86AhGLZ7prkompqj
        SViGuEEA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qqTqf-0003rN-1P;
        Wed, 11 Oct 2023 07:41:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8A9EA30026F; Wed, 11 Oct 2023 09:41:42 +0200 (CEST)
Date:   Wed, 11 Oct 2023 09:41:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        David Kaplan <david.kaplan@amd.com>, x86@kernel.org,
        luto@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Revert "x86/retpoline: Remove
 .text..__x86.return_thunk section"
Message-ID: <20231011074142.GK14330@noisy.programming.kicks-ass.net>
References: <20231010171020.462211-1-david.kaplan@amd.com>
 <20231010171020.462211-2-david.kaplan@amd.com>
 <20231010174833.GG14330@noisy.programming.kicks-ass.net>
 <20231010195721.p5pb273kevg7ydxz@treble>
 <20231010200429.GIZSWuTWSUM9aId7a6@fat_crate.local>
 <20231010201912.7pjksbparssqu34k@treble>
 <20231010212254.ypk2wdogno55shit@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010212254.ypk2wdogno55shit@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 02:22:54PM -0700, Josh Poimboeuf wrote:

> From: Josh Poimboeuf <jpoimboe@kernel.org>
> Subject: [PATCH] objtool: Fix return thunk patching in retpolines
> 
> With CONFIG_RETHUNK enabled, the compiler replaces every RET with a tail
> call to a return thunk ('JMP __x86_return_thunk').  Objtool annotates
> all such return sites so they can be patched during boot by
> apply_returns().
> 
> The implementation of __x86_return_thunk() is just a bare RET.  It's
> only meant to be used temporarily until apply_returns() patches all
> return sites with either a JMP to another return thunk or an actual RET.
> 
> The following commit
> 
>   e92626af3234 ("x86/retpoline: Remove .text..__x86.return_thunk section") retpolines
> 
> broke objtool's detection of return sites in retpolines.  Since
> retpolines and return thunks are now in the same section, the compiler
> no longer uses relocations for the intra-section jumps between the
> retpolines and the return thunk, causing objtool to overlook them.
> 
> As a result, none of the retpolines' return sites get patched.  Each one
> stays at 'JMP __x86_return_thunk', effectively a bare RET.
> 
> Fix it by teaching objtool to detect when a non-relocated jump target is
> a return thunk.
> 
> Fixes: e92626af3234 ("x86/retpoline: Remove .text..__x86.return_thunk section")
> Reported-by: David Kaplan <david.kaplan@amd.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  tools/objtool/check.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index e308d1ba664e..556469db4239 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -1610,6 +1610,15 @@ static int add_jump_destinations(struct objtool_file *file)
>  			return -1;
>  		}
>  
> +		/*
> +		 * Since retpolines are in the same section as the return
> +		 * thunk, they might not use a relocation when branching to it.
> +		 */
> +		if (jump_dest->sym && jump_dest->sym->return_thunk) {
> +			add_return_call(file, insn, true);
> +			continue;
> +		}

*urgh*... I mean, yes, that obviously works, but should we not also have
the retpoline thingy for consistency? That case makes less sense though
:/

Perhaps warn about this instead of fixing it? Forcing people to play the
section game?

I dunno.. no real strong opinions.
