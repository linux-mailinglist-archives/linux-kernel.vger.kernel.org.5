Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEEF7C6857
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 10:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235373AbjJLIRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 04:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbjJLIRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 04:17:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DB498
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 01:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OpjpvPhklzSNoquONgrhQHuPwYsGV4Tz3zjFn7RUCjo=; b=NBKs9jI1dnz7jTgqZtpJWq1SJU
        bGIpMCgHOnbROILthGIqcnOeX1X8HmhfaEpT4UpqeKhpcIS0VS7h/YFyXaXfiEn16xvSgOZMiGC/A
        seIHTs4lobRDxzw3UC5fMgXRvuxsEnJ3NPGapY2zruZzKwxgUse3vZNjaMZPzJSHFmC+N4uA//sTP
        i2GJR1B8Cb1ujlUrByVNQ9LFZM3mRUQiLoGut38wroFdbRSgizt51GwQqksb0nvz5Y0WsNhBTIk8C
        tVjnr2lpRQwv86Mseq5kqlHhHGt8ubD1xVwP10fpUzzWi1+8TmxQviIiP95sGqeO/U1CiKx/zJpLx
        DZdudenw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qqqsK-00FnBc-Js; Thu, 12 Oct 2023 08:16:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 486E8300392; Thu, 12 Oct 2023 10:16:56 +0200 (CEST)
Date:   Thu, 12 Oct 2023 10:16:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        David Kaplan <david.kaplan@amd.com>, x86@kernel.org,
        luto@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] objtool: Fix return thunk patching in retpolines
Message-ID: <20231012081656.GK6307@noisy.programming.kicks-ass.net>
References: <20231010174833.GG14330@noisy.programming.kicks-ass.net>
 <20231010195721.p5pb273kevg7ydxz@treble>
 <20231010200429.GIZSWuTWSUM9aId7a6@fat_crate.local>
 <20231010201912.7pjksbparssqu34k@treble>
 <20231010212254.ypk2wdogno55shit@treble>
 <20231011074142.GK14330@noisy.programming.kicks-ass.net>
 <20231011162843.grv6kixw4ides6uw@treble>
 <20231011223513.GH6307@noisy.programming.kicks-ass.net>
 <20231012022758.lf62lgf5jx5xrno7@treble>
 <20231012024737.eg5phclogp67ik6x@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012024737.eg5phclogp67ik6x@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 07:47:37PM -0700, Josh Poimboeuf wrote:
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
> a return thunk (or retpoline).
> 
> Fixes: e92626af3234 ("x86/retpoline: Remove .text..__x86.return_thunk section")
> Reported-by: David Kaplan <david.kaplan@amd.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  tools/objtool/check.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index e308d1ba664e..e94756e09ca9 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -1610,6 +1610,22 @@ static int add_jump_destinations(struct objtool_file *file)
>  			return -1;
>  		}
>  
> +		/*
> +		 * An intra-TU jump in retpoline.o might not have a relocation
> +		 * for its jump dest, in which case the above
> +		 * add_{retpoline,return}_call() didn't happen.
> +		 */
> +		if (jump_dest->sym && jump_dest->offset == jump_dest->sym->offset) {
> +			if (jump_dest->sym->retpoline_thunk) {
> +				add_retpoline_call(file, insn);
> +				continue;
> +			}
> +			if (jump_dest->sym->return_thunk) {
> +				add_return_call(file, insn, true);
> +				continue;
> +			}
> +		}
> +
>  		/*
>  		 * Cross-function jump.
>  		 */
> -- 
> 2.41.0
> 
