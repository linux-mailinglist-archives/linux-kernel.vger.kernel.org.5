Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9A07F5515
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 00:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344368AbjKVX5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 18:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344054AbjKVX5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 18:57:33 -0500
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECFE110
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 15:57:29 -0800 (PST)
Date:   Wed, 22 Nov 2023 18:57:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700697448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1ZPhv1Y4mad8pc6Sp3pH+gIGSK/MlW2XI6tHY4Xxt8w=;
        b=Ism3Y9NBJBn4HNWS4hpsESFKy/rFrGOE8+evdNB9lbSC3EW4417UqfABLGmGbP90JIjflL
        yJJ8ht//Oi9oH7PUduBsN8brbXkJ+Z3qdqvkx+MGg7H872urew6utALcBEkaW1ZPvMSGdT
        hQ6//Lp5UcVHXbPI/u4BUG6I5ysMfpA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: lockdep + kasan bug?
Message-ID: <20231122235725.m6nwjrwjr2fr2hpa@moria.home.lan>
References: <20231120233659.e36txv3fedbjn4sx@moria.home.lan>
 <20231121103614.GG8262@noisy.programming.kicks-ass.net>
 <ZVyRHd-MjMdkLp6S@FVFF77S0Q05N>
 <20231121114126.GH8262@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121114126.GH8262@noisy.programming.kicks-ass.net>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 12:41:26PM +0100, Peter Zijlstra wrote:
> > I suspect the dodgy access is to chain_block_buckets[-1], which hits the last 4
> > bytes of the redzone and gets (incorrectly/misleadingly) attributed to
> > nr_large_chain_blocks.
> 
> That would mean @size == 0, at which point size_to_bucket() returns -1
> and the above happens.
> 
> alloc_chain_hlocks() has 'size - req', for the first with the
> precondition 'size >= rq', which allows the 0.
> 
> The second is an iteration with the condition size > req, which does not
> allow the 0 case.
> 
> So the first, thing, IIRC, this is trying to split a block,
> del_chain_block() takes what we need, and add_chain_block() puts back
> the remainder, except in the above case the remainder is 0 sized and
> things go sideways or so.
> 
> Does the below help?
> 
> ---
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index e85b5ad3e206..151bd3de5936 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -3497,7 +3497,8 @@ static int alloc_chain_hlocks(int req)
>  		size = chain_block_size(curr);
>  		if (likely(size >= req)) {
>  			del_chain_block(0, size, chain_block_next(curr));
> -			add_chain_block(curr + req, size - req);
> +			if (size > req)
> +				add_chain_block(curr + req, size - req);
>  			return curr;
>  		}
>  	}
> 

Yep, no kasan splats with that patch
