Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861357CF1A8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 09:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344890AbjJSHvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 03:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232829AbjJSHvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 03:51:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F217109
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 00:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Tj2sfG6o4PVcITUMHLw1E1ngyDfKo6Oj8GiFjy0BgNw=; b=MGwUCsFGHsUm4NlLV//62krFjB
        xxzTXL7q1nbTETm+09oFZdCY9Yn2LcPZ+/ybOPkIRt3oaCtB2X1rcv4uFs8IFhwJGkI/80lZ9xFZw
        IPdTLSUPa18/8IokSQZ5sWEbBgRFdPNldOBrMk6bsLDjFmkLgtdeyjWXVlwe5VonYLw8Wn/2GGWjl
        POg1CQmY3qtF8ec3kT7YGz/dNxWJUK7lIQatOtmtxAbdBxz/yPV8jmJayrFRfKKKue0RV63n38eip
        N1I16yGqj/UhG8efHYI12PM/yQpAPw4S5C0JzlfAwYYfGN+S7lGtQsNZ/jRrydziVa0ynelt9Y+z6
        84BSry3A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qtNnr-005qil-7D; Thu, 19 Oct 2023 07:50:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id DDC6F300392; Thu, 19 Oct 2023 09:50:46 +0200 (CEST)
Date:   Thu, 19 Oct 2023 09:50:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>,
        Rohan McLure <rmclure@linux.ibm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] powerpc/smp: Disable MC domain for shared
 processor
Message-ID: <20231019075046.GN33217@noisy.programming.kicks-ass.net>
References: <20231018163751.2423181-1-srikar@linux.vnet.ibm.com>
 <20231018163751.2423181-5-srikar@linux.vnet.ibm.com>
 <87pm1b5ia7.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pm1b5ia7.fsf@mail.lhotse>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 03:48:48PM +1100, Michael Ellerman wrote:
> Srikar Dronamraju <srikar@linux.vnet.ibm.com> writes:
> > Like L2-cache info, coregroup information which is used to determine MC
> > sched domains is only present on dedicated LPARs. i.e PowerVM doesn't
> > export coregroup information for shared processor LPARs. Hence disable
> > creating MC domains on shared LPAR Systems.
> >
> > Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> > ---
> >  arch/powerpc/kernel/smp.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> > index 498c2d51fc20..29da9262cb17 100644
> > --- a/arch/powerpc/kernel/smp.c
> > +++ b/arch/powerpc/kernel/smp.c
> > @@ -1046,6 +1046,10 @@ static struct cpumask *cpu_coregroup_mask(int cpu)
> >  
> >  static bool has_coregroup_support(void)
> >  {
> > +	/* Coregroup identification not available on shared systems */
> > +	if (is_shared_processor())
> > +		return 0;
> 
> That will catch guests running under KVM too right? Do we want that?

Some KVM people use vcpu pinning and pass-through topology things,
slice-of-hardware or something like that. In that scenario you actively
do want this.

I'm fairly clueless on when this is_shared_processor() gets to be true,
so that might already be dealt with.. 
