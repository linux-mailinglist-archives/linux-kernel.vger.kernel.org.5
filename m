Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B29577608F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 15:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbjHIN0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 09:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbjHIN0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 09:26:44 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CD7C1
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 06:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Vx2mUVsjSOnk5sRFiAETHtgQoikD5oeJ4dtL08W0elU=; b=M1787bq2Y5ssLrYO6GPlyCkx3+
        EBvUqjywdU8nkXMRRt4bMuSsdQvqceeG48Wf/P+917MTI5m3+zmPifpfaf2yGrW+6wdxY5c0Rdr57
        ALwuQXh2hE7IsDxJJb/LpRJo6QPjdls70FpVRmxfyOJ9978Ovcg5pQyQzhyr30b+5gwWbLpgQNrV8
        7PKeYLF6lkpJXV3FHJ+oJ61uplMf6i9FqKNu6E5+3+RZ6krdEob/uudAcFvZXVRRQDnqYWbzJN06+
        xHDUO/S9UHOhH4knllsR3ARyLwLEUdYfXNjWAcvmt9yGPfjnHei0lPY/0ielQfNYoMon0kWuTg/bi
        tKZt4PJQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qTjCt-005f4g-2T;
        Wed, 09 Aug 2023 13:26:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6584D30003A;
        Wed,  9 Aug 2023 15:26:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4B7B6202BDC65; Wed,  9 Aug 2023 15:26:35 +0200 (CEST)
Date:   Wed, 9 Aug 2023 15:26:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, gregkh@linuxfoundation.org
Subject: Re: [RFC][PATCH 05/17] x86/cpu: Cleanup the untrain mess
Message-ID: <20230809132635.GB220434@hirez.programming.kicks-ass.net>
References: <20230809071218.000335006@infradead.org>
 <20230809072200.782716727@infradead.org>
 <20230809125101.xxwhuipfvj7kbasn@treble>
 <20230809131243.GK212435@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809131243.GK212435@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 03:12:43PM +0200, Peter Zijlstra wrote:
> On Wed, Aug 09, 2023 at 08:51:01AM -0400, Josh Poimboeuf wrote:
> > On Wed, Aug 09, 2023 at 09:12:23AM +0200, Peter Zijlstra wrote:
> > > Since there can only be one active return_thunk, there only needs be
> > > one (matching) untrain_ret. It fundamentally doesn't make sense to
> > > allow multiple untrain_ret at the same time.
> > > 
> > > Fold all the 3 different untrain methods into a single (temporary)
> > > helper stub.
> > > 
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > ---
> > >  arch/x86/include/asm/nospec-branch.h |   19 +++++--------------
> > >  arch/x86/lib/retpoline.S             |    7 +++++++
> > >  2 files changed, 12 insertions(+), 14 deletions(-)
> > > 
> > > --- a/arch/x86/include/asm/nospec-branch.h
> > > +++ b/arch/x86/include/asm/nospec-branch.h
> > > @@ -272,9 +272,9 @@
> > >  .endm
> > >  
> > >  #ifdef CONFIG_CPU_UNRET_ENTRY
> > > -#define CALL_ZEN_UNTRAIN_RET	"call zen_untrain_ret"
> > > +#define CALL_UNTRAIN_RET	"call entry_untrain_ret"
> > >  #else
> > > -#define CALL_ZEN_UNTRAIN_RET	""
> > > +#define CALL_UNTRAIN_RET	""
> > >  #endif
> > >  
> > >  /*
> > > @@ -293,15 +293,10 @@
> > >  	defined(CONFIG_CALL_DEPTH_TRACKING) || defined(CONFIG_CPU_SRSO)
> > >  	VALIDATE_UNRET_END
> > >  	ALTERNATIVE_3 "",						\
> > > -		      CALL_ZEN_UNTRAIN_RET, X86_FEATURE_UNRET,		\
> > > +		      CALL_UNTRAIN_RET, X86_FEATURE_UNRET,		\
> > 
> > SRSO doesn't have X86_FEATURE_UNRET set.
> 
> Argh.. this stuff doesn't exist at the end anymore, but yeah, that's
> unfortunate.
> 
> I'll see if I can find another intermediate step.

I think simply setting UNRET for SRSO at this point will be sufficient.
That ensures the entry_untrain_ret thing gets called, and the
alternative there DTRT.

The feature isn't used anywhere else afaict.

Then later, after the fancy alternatives happen, this can be cleaned up
again.
