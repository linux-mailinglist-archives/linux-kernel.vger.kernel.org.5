Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5427FCFC7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 08:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjK2HVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 02:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjK2HVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 02:21:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D7EC9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 23:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KJyCwhlrvWaEhgruRo4W/7mjtjSOMpqD1BDi17senR0=; b=t6j8ktw+Jjw0AtWOFHMkzQQnok
        y/KGID8uwIvLLrWnUReTh1EmkahvEdd15PbekECh+vmyr/Vtj6BDnKpeItET8aDOD/W3dKCJq930s
        J804AGsi0js2yIbkHQEVv17upDoHYcNH9CatjtiIJQCzKM0VCRp/Jwh9EwLlzlrEEjj0lty3GO9vY
        gPJJ5hzpoMArIh4mg6ogUT+4k49IIxj2w6F6e6kkKNnmTbr98SSJW22vjJe5P39sfd10X68VMj04K
        jpQGSmMa69vtk6Z3l63DCXnjocaZ8SjjSd3jeGztAw586xhkjbqrtgYeQBneVTPglApYZrFrR2VyD
        9Nv2QbHw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r8EsQ-00D9W3-Rl; Wed, 29 Nov 2023 07:20:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 881703002F1; Wed, 29 Nov 2023 08:20:53 +0100 (CET)
Date:   Wed, 29 Nov 2023 08:20:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [RFC] x86/kvm/emulate: Avoid RET for fastops
Message-ID: <20231129072053.GA30650@noisy.programming.kicks-ass.net>
References: <20231112201205.GB9987@noisy.programming.kicks-ass.net>
 <ZWaV8H9e8ubhFgWJ@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWaV8H9e8ubhFgWJ@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 05:37:52PM -0800, Sean Christopherson wrote:
> On Sun, Nov 12, 2023, Peter Zijlstra wrote:
> > Hi,
> > 
> > Inspired by the likes of ba5ca5e5e6a1 ("x86/retpoline: Don't clobber
> > RFLAGS during srso_safe_ret()") I had it on my TODO to look at this,
> > because the call-depth-tracking rethunk definitely also clobbers flags
> > and that's a ton harder to fix.
> > 
> > Looking at this recently I noticed that there's really only one callsite
> > (twice, the testcc thing is basically separate from the rest of the
> > fastop stuff) and thus CALL+RET is totally silly, we can JMP+JMP.
> > 
> > The below implements this, and aside from objtool going apeshit (it
> > fails to recognise the fastop JMP_NOSPEC as a jump-table and instead
> > classifies it as a tail-call), it actually builds and the asm looks
> > good sensible enough.
> > 
> > I've not yet figured out how to test this stuff, but does something like
> > this look sane to you guys?
> 
> Yes?  The idea seems sound, but I haven't thought _that_ hard about whether or not
> there's any possible gotchas.   I did a quick test and nothing exploded (and
> usually when this code breaks, it breaks spectacularly).

That's encouraging..

> > Given that rethunks are quite fat and slow, this could be sold as a
> > performance optimization I suppose.
> > 
> > ---
> > 
> > diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
> > index f93e9b96927a..2cd3b5a46e7a 100644
> > --- a/arch/x86/include/asm/nospec-branch.h
> > +++ b/arch/x86/include/asm/nospec-branch.h
> > @@ -412,6 +412,17 @@ static inline void call_depth_return_thunk(void) {}
> >  	"call *%[thunk_target]\n",				\
> >  	X86_FEATURE_RETPOLINE_LFENCE)
> >  
> > +# define JMP_NOSPEC						\
> > +	ALTERNATIVE_2(						\
> > +	ANNOTATE_RETPOLINE_SAFE					\
> > +	"jmp *%[thunk_target]\n",				\
> > +	"jmp __x86_indirect_thunk_%V[thunk_target]\n",		\
> > +	X86_FEATURE_RETPOLINE,					\
> > +	"lfence;\n"						\
> > +	ANNOTATE_RETPOLINE_SAFE					\
> > +	"jmp *%[thunk_target]\n",				\
> > +	X86_FEATURE_RETPOLINE_LFENCE)
> 
> There needs a 32-bit version (eww) and a CONFIG_RETPOLINE=n version. :-/

I'll go make that happen. Thanks!
