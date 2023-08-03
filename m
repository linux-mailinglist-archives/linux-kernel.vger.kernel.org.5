Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0BD76E35B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjHCIlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbjHCIlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:41:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87288DF
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 01:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=SACFvnr2rbydFAco2HYqoxJUl3pe8fK1O5C3pDq8h1Q=; b=UAGk95RKrr66JPKNS/fl48luNT
        TwNx9IwDM+O1skayDM+TdbGftgYAquTeY8umuwAThjF/1ttKcELngO4EBuhT5P90l9VvsJqcOI6a8
        DO/uFUOGcXPkRRA6lF2xp5MYBnvgesc861EyhiAyIxZ88g85cKUQ6dXkaz8RmQsS7UzB86D8mG6V9
        N7HkyrTtz6glIa4LNINpv8CcOIUa626R5cIWH6PrvflUo0ie72sjvwnYyDYHV/ninwdlyVkkZiYr/
        1peFcVtCBgG/uHFSP4t5R/Ccq4bftXUuFmKT0LL1OYSUkiHW2raF0ZcTNx8SU7oKwgnQwJ5GfNY7D
        KFMezNGg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qRTte-002YZf-Cs; Thu, 03 Aug 2023 08:41:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6C30A30007E;
        Thu,  3 Aug 2023 10:41:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 49F2121094074; Thu,  3 Aug 2023 10:41:25 +0200 (CEST)
Date:   Thu, 3 Aug 2023 10:41:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mateusz Guzik <mjguzik@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, rppt@kernel.org
Subject: Re: [PATCH v2 2/2] mm,nodemask: Use nr_node_ids
Message-ID: <20230803084125.GE212435@hirez.programming.kicks-ass.net>
References: <20230802112458.230221601@infradead.org>
 <20230802112525.633758009@infradead.org>
 <20230802193616.GC231007@hirez.programming.kicks-ass.net>
 <ZMr4uBfjKY9dERl2@yury-ThinkPad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZMr4uBfjKY9dERl2@yury-ThinkPad>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 05:45:44PM -0700, Yury Norov wrote:
> + Linus, Mateusz
> 
> On Wed, Aug 02, 2023 at 09:36:16PM +0200, Peter Zijlstra wrote:
> > 
> > Just like how cpumask uses nr_cpu_ids to limit the bitmap scanning,
> > make nodemask use nr_node_ids.
> > 
> > Since current users expect MAX_NUMNODES as the end-of-bitmap marker,
> > retain this behaviour for now.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
> > ---
> > Changes since v1:
> >  - updated and reflowed the 'borrowed' comment some more (rppt)
> 
> Hi Peter,
> 
> Thanks for the patch! I wanted to do it sooner or later.
> 
> Can you mention the commit that you used to borrow the approach.
> Maybe suggested-by?

I borrowed the comment from current include/linux/cpumask.h, not a
particular commit.

> The motivation for the original patch was that the following test
> revealed broken small_const_nbits() optimization for cpumasks:
> 
>   On Fri, Mar 3, 2023 at 12:39 PM Mateusz Guzik <mjguzik@gmail.com> wrote:
>   >
>   > as an example here is a one-liner to show crappers which do 0-sized ops:
>   > bpftrace -e 'kprobe:memset,kprobe:memcpy /arg2 == 0/ { @[probe,
>   > kstack(2)] = count(); }'
> 
> See:
> https://lore.kernel.org/lkml/CAHk-=wgfNrMFQCFWFtn+UXjAdJAGAAFFJZ1JpEomTneza32A6g@mail.gmail.com/
> 
> Can you make sure your patch doesn't brake the test for nodemasks?

I've no idea what that even tries to do; I don't speak bpf. And
typically bpf things don't work on my machines because I refuse to build
with BTF on since that blows up build times.

> >  include/linux/nodemask.h |  121 ++++++++++++++++++++++++++++++++++-------------
> >  1 file changed, 89 insertions(+), 32 deletions(-)
> > 
> > --- a/include/linux/nodemask.h
> > +++ b/include/linux/nodemask.h
> > @@ -99,6 +99,48 @@
> >  typedef struct { DECLARE_BITMAP(bits, MAX_NUMNODES); } nodemask_t;
> >  extern nodemask_t _unused_nodemask_arg_;
> >  
> > +#if MAX_NUMNODES > 1
> > +extern unsigned int nr_node_ids;
> > +#else
> > +#define nr_node_ids		1U
> > +#endif
> > +
> > +/*
> > + * We have several different "preferred sizes" for the nodemask operations,
> > + * depending on operation.
> > + *
> > + * For example, the bitmap scanning and operating operations have optimized
> > + * routines that work for the single-word case, but only when the size is
> > + * constant. So if MAX_NUMNODES fits in one single word, we are better off
> > + * using that small constant, in order to trigger the optimized bit finding.
> > + * That is 'small_nodemask_size'.
> > + *
> > + * The clearing and copying operations will similarly perform better with a
> 
> Copying will not, because there's no nodemask_copy(). :-)

Yeah, I know, *shrug*. If you really care, I'd prefer to actually
implement that instead of fixing the comment.

> > + * constant size, but we limit that size arbitrarily to four words. We call
> > + * this 'large_nodemask_size'.
> > + *
> > + * Finally, some operations just want the exact limit, either because they set
> > + * bits or just don't have any faster fixed-sized versions. We call this just
> > + * 'nr_nodemask_bits'.
> > + *
> > + * Note that these optional constants are always guaranteed to be at least as
> > + * big as 'nr_node_ids' itself is, and all our nodemask allocations are at
> > + * least that size. The optimization comes from being able to potentially use
> > + * a compile-time constant instead of a run-time generated exact number of
> > + * nodes.
> > + */
> > +#if MAX_NUMNODES <= BITS_PER_LONG
> > +  #define small_nodemask_bits ((unsigned int)MAX_NUMNODES)
> > +  #define large_nodemask_bits ((unsigned int)MAX_NUMNODES)
> > +#elif MAX_NUMNODES <= 4*BITS_PER_LONG
> > +  #define small_nodemask_bits nr_node_ids
> > +  #define large_nodemask_bits ((unsigned int)MAX_NUMNODES)
> > +#else
> > +  #define small_nodemask_bits nr_node_ids
> > +  #define large_nodemask_bits nr_node_ids
> > +#endif
> > +#define nr_nodemask_bits nr_node_ids
> 
> We don't need nr_nodemask_bits. In CPU subsystem nr_cpumask_bits
> exists (existed) to support dynamic allocation for cpumask_var_t
> if CPUMASK_OFFSTACK is enabled. And it apparently caused troubles.
> 
> In nodemasks we don't have an offstack feature, and don't need the
> nr_nodemask_bits. Just use nr_node_ids everywhere.

Sure, can do.

> [...]
> 
> > -#define nodes_setall(dst) __nodes_setall(&(dst), MAX_NUMNODES)
> > +#define nodes_setall(dst) __nodes_setall(&(dst), large_nodemask_bits)
> >  static inline void __nodes_setall(nodemask_t *dstp, unsigned int nbits)
> >  {
> >  	bitmap_fill(dstp->bits, nbits);
> >  }
> 
> When MAX_NUMNODES <= 4*BITS_PER_LONG, this breaks the rule that all
> bits beyond nr_node_ids must be clear. And that in turn may brake
> nodemask_weight() and others. Refer to this patch for details and
> correct implementation:

I think I got that right, consider:

#elif MAX_NUMNODES <= 4*BITS_PER_LONG
  #define small_nodemask_bits nr_node_ids
  #define large_nodemask_bits ((unsigned int)MAX_NUMNODES)

IOW: small_nodemask_bits <= large_nodemask_bits (as per the naming)

So nodemask_weight() will look at less or all bits set/cleared.

The bug you referred to was using fill with nr_cpumask_bits, using
large_cpumask_bits would've been sufficient.

> > @@ -452,7 +511,6 @@ static inline unsigned int next_memory_n
> >  	return next_node(nid, node_states[N_MEMORY]);
> >  }
> >  
> > -extern unsigned int nr_node_ids;
> >  extern unsigned int nr_online_nodes;
> >  
> >  static inline void node_set_online(int nid)
> > @@ -494,7 +552,6 @@ static inline int num_node_state(enum no
> >  #define first_memory_node	0
> >  #define next_online_node(nid)	(MAX_NUMNODES)
> >  #define next_memory_node(nid)	(MAX_NUMNODES)
> > -#define nr_node_ids		1U
> >  #define nr_online_nodes		1U
>  
> I like how you separated the nr_node_ids from the other ifdefery, and
> changed it to __ro_after_init. But I think it's better to fold this all
> into the 1st patch.

This move was needed to make it build -- compiler feels strongly you
should have declared a variable before using it etc.. No other
motivation for it. As such it sits in this patch.

> Why don't we make nr_cpu_ids to be a __ro_after_init just as well?

Sure, will add patch. Should've checked :/
