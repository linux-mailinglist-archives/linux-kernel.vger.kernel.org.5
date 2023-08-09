Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4DF477604C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 15:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbjHINMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 09:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbjHINMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 09:12:52 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F24A1FF9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 06:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KMfbP4dBOevFA5GkOUq4eQ2mNbjqR+JoOTQOD+f/DJM=; b=gIvCQN81IdLZdAVxlNb1Ouoxj4
        cpCCMvXxsD/0NzaW0GxJVy1AB6WyYdqrvgRhrufluLdIkajC8VFMI/8r/QkPIjUfk74+f1JpMxnKw
        SSokZ/jnXeLKtrY73t/r1ZJmKsHXi0QeDhRkli6s0gjiL/pvsqFWXAM98+vHWdA+ROmOqpmxWNzmr
        DifH/JkEb49qzLSPxR6Fur81JhQkEmDIk5zbVn50Ubsz9SehnAl7U4DpplqGxfZ78ztxO0uvwwRjA
        KO/ivZaQeV+IcGA7OyDHyaAqdZxAFgEeWuI/HgIg9AI5sCyIS/kUwIkKaxuRmCstV0wi+GbKRAj7Y
        Ft0l4CBw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qTizT-005epw-2b;
        Wed, 09 Aug 2023 13:12:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4DEE430003A;
        Wed,  9 Aug 2023 15:12:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 31E1D206DF88D; Wed,  9 Aug 2023 15:12:43 +0200 (CEST)
Date:   Wed, 9 Aug 2023 15:12:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, gregkh@linuxfoundation.org
Subject: Re: [RFC][PATCH 05/17] x86/cpu: Cleanup the untrain mess
Message-ID: <20230809131243.GK212435@hirez.programming.kicks-ass.net>
References: <20230809071218.000335006@infradead.org>
 <20230809072200.782716727@infradead.org>
 <20230809125101.xxwhuipfvj7kbasn@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809125101.xxwhuipfvj7kbasn@treble>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 08:51:01AM -0400, Josh Poimboeuf wrote:
> On Wed, Aug 09, 2023 at 09:12:23AM +0200, Peter Zijlstra wrote:
> > Since there can only be one active return_thunk, there only needs be
> > one (matching) untrain_ret. It fundamentally doesn't make sense to
> > allow multiple untrain_ret at the same time.
> > 
> > Fold all the 3 different untrain methods into a single (temporary)
> > helper stub.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  arch/x86/include/asm/nospec-branch.h |   19 +++++--------------
> >  arch/x86/lib/retpoline.S             |    7 +++++++
> >  2 files changed, 12 insertions(+), 14 deletions(-)
> > 
> > --- a/arch/x86/include/asm/nospec-branch.h
> > +++ b/arch/x86/include/asm/nospec-branch.h
> > @@ -272,9 +272,9 @@
> >  .endm
> >  
> >  #ifdef CONFIG_CPU_UNRET_ENTRY
> > -#define CALL_ZEN_UNTRAIN_RET	"call zen_untrain_ret"
> > +#define CALL_UNTRAIN_RET	"call entry_untrain_ret"
> >  #else
> > -#define CALL_ZEN_UNTRAIN_RET	""
> > +#define CALL_UNTRAIN_RET	""
> >  #endif
> >  
> >  /*
> > @@ -293,15 +293,10 @@
> >  	defined(CONFIG_CALL_DEPTH_TRACKING) || defined(CONFIG_CPU_SRSO)
> >  	VALIDATE_UNRET_END
> >  	ALTERNATIVE_3 "",						\
> > -		      CALL_ZEN_UNTRAIN_RET, X86_FEATURE_UNRET,		\
> > +		      CALL_UNTRAIN_RET, X86_FEATURE_UNRET,		\
> 
> SRSO doesn't have X86_FEATURE_UNRET set.

Argh.. this stuff doesn't exist at the end anymore, but yeah, that's
unfortunate.

I'll see if I can find another intermediate step.
