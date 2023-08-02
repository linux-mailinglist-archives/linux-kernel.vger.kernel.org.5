Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B3976D2C3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 17:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234408AbjHBPs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 11:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbjHBPsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:48:46 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB45C1735
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 08:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LImLObs3PbfWRmVyYwazP2aaA0QKB8bTTtlThaSyFQc=; b=oPsrUIn++gGVB1cVF8en2q3Ucd
        5GTIohXyXNKbdDGldSnxZCvsCuFwALvV3SPb0q++JunJbI6FjjNPG9cZx/RUPm2UBR04uBhkG88XQ
        4dhAal277kVoHtsLYNIiH3dhzX1ER//Xw5s14AZ0lwSYr4DatgroBqyVFG4teTt5DAyT6Bu/cOOt1
        FfBMM68QZ4ui3mt3w76rx1YwOTFEYeP3yyoYhNd5STQ7RJdDwiEp+FBhjfumb3WHSjXpJ0PDz1NnP
        MbBNZM5d59AS2Rv7LF5ECtCU57pvYdLruMr/bc6OncQ0OE2k/pDslsHtHibm/bSZbLNPRBBk91mkT
        BDYxwRwQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qRE5P-00G2gC-09;
        Wed, 02 Aug 2023 15:48:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 011D73001DD;
        Wed,  2 Aug 2023 17:48:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E19FA210A8CBB; Wed,  2 Aug 2023 17:48:29 +0200 (CEST)
Date:   Wed, 2 Aug 2023 17:48:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     yury.norov@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de
Subject: Re: [PATCH 2/2] mm,nodemask: Use nr_node_ids
Message-ID: <20230802154829.GB214207@hirez.programming.kicks-ass.net>
References: <20230802112458.230221601@infradead.org>
 <20230802112525.633758009@infradead.org>
 <20230802153251.GF2607694@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802153251.GF2607694@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 06:32:51PM +0300, Mike Rapoport wrote:
> > +/*
> > + * We have several different "preferred sizes" for the nodemask
> > + * operations, depending on operation.
> > + *
> > + * For example, the bitmap scanning and operating operations have
> > + * optimized routines that work for the single-word case, but only when
> > + * the size is constant. So if NR_CPUS fits in one single word, we are
> 
>                                 ^ MAX_NUMNODES?
> 
> > + * better off using that small constant, in order to trigger the
> > + * optimized bit finding. That is 'small_nodemask_size'.
> > + *
> > + * The clearing and copying operations will similarly perform better
> > + * with a constant size, but we limit that size arbitrarily to four
> > + * words. We call this 'large_nodemask_size'.
> > + *
> > + * Finally, some operations just want the exact limit, either because
> > + * they set bits or just don't have any faster fixed-sized versions. We
> > + * call this just 'nr_nodemask_bits'.
> > + *
> > + * Note that these optional constants are always guaranteed to be at
> > + * least as big as 'nr_node_ids' itself is, and all our nodemask
> > + * allocations are at least that size (see nodemask_size()). The
> 
> We don't have nodemask_size(). NODEMASK_ALLOC() actually allocates memory
> only when NODE_SHIFT > 8 and it always uses the static size.
> 
> > + * optimization comes from being able to potentially use a compile-time
> > + * constant instead of a run-time generated exact number of CPUs.
> 
>                                                               ^ nodes?

Durr, clearly I didn't actually read the comment after I 'borrowed' it
and regex'ed it into 'shape'.

I'll go fix, thanks!
