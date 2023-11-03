Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E3E7E0888
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 19:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345541AbjKCSyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 14:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjKCSyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 14:54:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F3DBD
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 11:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lMSyzAFDVyohiximkrZHfefmepkkBFb8l8Zpm/xuQW0=; b=aBiC7RrqRLj9aeyNctrnxAhJz2
        JhuwjmOJ8SNazej8roFiWvPrtxnEU3ooqFV3wC1eO31jJEKwswJ3MiQzzCdqqQ2xrYguU+9gK2NaS
        EOJSW/RH961k0PKWsMc6LhwB98k41RIvvtvMc2wPbX+d/zO5RVAoePn4W94Mb3NW4lxcWbQ0l0UJt
        +kS25qjCbb8TO/bZuRiHD+zSAcO70u2GInU/85N+W5U+XQgOke87mRA1kZvsysXNN/wcUT7A3pxDY
        IVF/6LaqDFEEo8QvL23WArw1EidQXgtYBN+ES/lmhC6PdKfAtHvoar1YRacJIR0pm5loopID8qLLt
        kshUJVIA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qyzJ7-006znm-Ph; Fri, 03 Nov 2023 18:54:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 25D403002AF; Fri,  3 Nov 2023 19:54:14 +0100 (CET)
Date:   Fri, 3 Nov 2023 19:54:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Aring <aahringo@redhat.com>
Cc:     will@kernel.org, gfs2@lists.linux.dev, boqun.feng@gmail.com,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/2] refcount: introduce generic lockptr funcs
Message-ID: <20231103185414.GD8262@noisy.programming.kicks-ass.net>
References: <20231103161635.1902667-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103161635.1902667-1-aahringo@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2023 at 12:16:34PM -0400, Alexander Aring wrote:

> diff --git a/lib/refcount.c b/lib/refcount.c
> index a207a8f22b3c..e28678f0f473 100644
> --- a/lib/refcount.c
> +++ b/lib/refcount.c
> @@ -94,6 +94,34 @@ bool refcount_dec_not_one(refcount_t *r)
>  }
>  EXPORT_SYMBOL(refcount_dec_not_one);
>  
> +bool refcount_dec_and_lockptr(refcount_t *r, void (*lock)(void *lockptr),
> +			      void (*unlock)(void *lockptr),  void *lockptr)
> +{
> +	if (refcount_dec_not_one(r))
> +		return false;
> +
> +	lock(lockptr);
> +	if (!refcount_dec_and_test(r)) {
> +		unlock(lockptr);
> +		return false;
> +	}
> +
> +	return true;
> +}
> +EXPORT_SYMBOL(refcount_dec_and_lockptr);

This is terrible, you're forcing indirect calls on everything.
