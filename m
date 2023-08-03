Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E2F76F419
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 22:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbjHCUls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 16:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbjHCUlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 16:41:46 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2EE30EA
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 13:41:45 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-7658430eb5dso114927085a.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 13:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691095304; x=1691700104;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TcDnbxiBPDzOphuc02sW0vwiJpe0C01reQZ+2uN1onU=;
        b=biDFdUF6sYNcKGoLXdrbgsEz+S+wsM0jUhIk7GJK8aExv8hk3/l1Yj2IAo+2B8zK6o
         vL5ggDZcPoPeexwMRxr+n81qw26GOaCvBPiI4hYsihBJdKYs2NTVOxJ60ajx+getObsr
         +Q4BD0O0QnT1e7d4+ICPQihlX6al5JQgWwADCWn2r9Np8Ma4tj+QukHEZge5gb8H1Z6t
         DfryvZbvpu/1KUAwX1zbCUieuV1Xn9nbhmIloIcL+ZZ7PxqHKhSDfh0/w5C9qzDhjJro
         2nW7Qrom8L/8cMV08h9iJ8JBN8pVZrZsQu4TJR+gJoSMQbmO1lvIuNhl/laTTzvyyLsU
         UKew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691095304; x=1691700104;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TcDnbxiBPDzOphuc02sW0vwiJpe0C01reQZ+2uN1onU=;
        b=F8fG0R56xhk4KdtItiKS1LVMya/FVMMRp7CBgxwJCGGUhz/XnN7o3xaEWLcO/nJT+9
         lmwkTrOriMwr9cY76s2ZW4i5KgD3bFFyHGzKN8Vcj02aFgnrtZclc0tfxh/PPtB2/cEI
         nv3WB5Nu5aRZpFCJI+qru3/TyOlnzVI2aEPjZWEd0Pu5w5yErHyFsG/pFh7myGzVqEYi
         1BdxT+cGBd1ZLR+83hv7PWqs588QLFHkthCV0SjVMy/1D8wPRBFXiS31DYsvWqRU3AuA
         F1LJOwX6q4NoMTHwZ1qRBxFsjEb0T/ZLtekodq7ep+07xUvFTNlRIKQXC5A2T+FRwBVC
         8sNQ==
X-Gm-Message-State: ABy/qLb7xck6pNxeVcleDf6nz/caQcQvQ2HUbuOpF1Cbk5F8Rird15IQ
        DYfxRjQdVX55NmmPN+7ukS5NVdturkU=
X-Google-Smtp-Source: APBJJlFWAjBAppG4nzoNi4eLC2h6yoS+0G49wA7Jf1MpneXlzuutoD3gCYXcV3EQEWS55u0atqgUNw==
X-Received: by 2002:a05:620a:a97:b0:76c:a290:5285 with SMTP id v23-20020a05620a0a9700b0076ca2905285mr16439631qkg.15.1691095304303;
        Thu, 03 Aug 2023 13:41:44 -0700 (PDT)
Received: from localhost ([50.217.79.158])
        by smtp.gmail.com with ESMTPSA id r30-20020a0cb29e000000b0063d2a70dff5sm163939qve.72.2023.08.03.13.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 13:41:43 -0700 (PDT)
Date:   Thu, 3 Aug 2023 13:41:42 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mateusz Guzik <mjguzik@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, rppt@kernel.org
Subject: Re: [PATCH v2 2/2] mm,nodemask: Use nr_node_ids
Message-ID: <ZMwRBqTgkvA7o9x3@yury-ThinkPad>
References: <20230802112458.230221601@infradead.org>
 <20230802112525.633758009@infradead.org>
 <20230802193616.GC231007@hirez.programming.kicks-ass.net>
 <ZMr4uBfjKY9dERl2@yury-ThinkPad>
 <20230803084125.GE212435@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230803084125.GE212435@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 10:41:25AM +0200, Peter Zijlstra wrote:
> On Wed, Aug 02, 2023 at 05:45:44PM -0700, Yury Norov wrote:
> > + Linus, Mateusz
> > 
> > On Wed, Aug 02, 2023 at 09:36:16PM +0200, Peter Zijlstra wrote:
> > > 
> > > Just like how cpumask uses nr_cpu_ids to limit the bitmap scanning,
> > > make nodemask use nr_node_ids.
> > > 
> > > Since current users expect MAX_NUMNODES as the end-of-bitmap marker,
> > > retain this behaviour for now.
> > > 
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
> > > ---
> > > Changes since v1:
> > >  - updated and reflowed the 'borrowed' comment some more (rppt)
> > 
> > Hi Peter,
> > 
> > Thanks for the patch! I wanted to do it sooner or later.
> > 
> > Can you mention the commit that you used to borrow the approach.
> > Maybe suggested-by?
 
> I borrowed the comment from current include/linux/cpumask.h, not a
> particular commit.

The particular commit is 596ff4a09b898 ("cpumask: re-introduce
constant-sized cpumask optimizations"). I think I mentioned it in the
other email.

It has a quite detailed description why small and large sizes exist.
The 'Just like how cpumask does' explanation works, but I'd prefer to
have an explicit link that describes why are we doing that.
 
> > The motivation for the original patch was that the following test
> > revealed broken small_const_nbits() optimization for cpumasks:
> > 
> >   On Fri, Mar 3, 2023 at 12:39 PM Mateusz Guzik <mjguzik@gmail.com> wrote:
> >   >
> >   > as an example here is a one-liner to show crappers which do 0-sized ops:
> >   > bpftrace -e 'kprobe:memset,kprobe:memcpy /arg2 == 0/ { @[probe,
> >   > kstack(2)] = count(); }'
> > 
> > See:
> > https://lore.kernel.org/lkml/CAHk-=wgfNrMFQCFWFtn+UXjAdJAGAAFFJZ1JpEomTneza32A6g@mail.gmail.com/
> > 
> > Can you make sure your patch doesn't brake the test for nodemasks?
> 
> I've no idea what that even tries to do; I don't speak bpf. And

Neither me. The idea is that bitmap users shouldn't break
small_const_nbits() optimization.

> typically bpf things don't work on my machines because I refuse to build
> with BTF on since that blows up build times.

> > >  include/linux/nodemask.h |  121 ++++++++++++++++++++++++++++++++++-------------
> > >  1 file changed, 89 insertions(+), 32 deletions(-)
> > > 
> > > --- a/include/linux/nodemask.h
> > > +++ b/include/linux/nodemask.h
> > > @@ -99,6 +99,48 @@
> > >  typedef struct { DECLARE_BITMAP(bits, MAX_NUMNODES); } nodemask_t;
> > >  extern nodemask_t _unused_nodemask_arg_;
> > >  
> > > +#if MAX_NUMNODES > 1
> > > +extern unsigned int nr_node_ids;
> > > +#else
> > > +#define nr_node_ids		1U
> > > +#endif
> > > +
> > > +/*
> > > + * We have several different "preferred sizes" for the nodemask operations,
> > > + * depending on operation.
> > > + *
> > > + * For example, the bitmap scanning and operating operations have optimized
> > > + * routines that work for the single-word case, but only when the size is
> > > + * constant. So if MAX_NUMNODES fits in one single word, we are better off
> > > + * using that small constant, in order to trigger the optimized bit finding.
> > > + * That is 'small_nodemask_size'.
> > > + *
> > > + * The clearing and copying operations will similarly perform better with a
> > 
> > Copying will not, because there's no nodemask_copy(). :-)
> 
> Yeah, I know, *shrug*. If you really care, I'd prefer to actually
> implement that instead of fixing the comment.

That would be a dead code, isn't?

[...]

> > > -#define nodes_setall(dst) __nodes_setall(&(dst), MAX_NUMNODES)
> > > +#define nodes_setall(dst) __nodes_setall(&(dst), large_nodemask_bits)
> > >  static inline void __nodes_setall(nodemask_t *dstp, unsigned int nbits)
> > >  {
> > >  	bitmap_fill(dstp->bits, nbits);
> > >  }
> > 
> > When MAX_NUMNODES <= 4*BITS_PER_LONG, this breaks the rule that all
> > bits beyond nr_node_ids must be clear. And that in turn may brake
> > nodemask_weight() and others. Refer to this patch for details and
> > correct implementation:
> 
> I think I got that right, consider:
> 
> #elif MAX_NUMNODES <= 4*BITS_PER_LONG
>   #define small_nodemask_bits nr_node_ids
>   #define large_nodemask_bits ((unsigned int)MAX_NUMNODES)
> 
> IOW: small_nodemask_bits <= large_nodemask_bits (as per the naming)
> 
> So nodemask_weight() will look at less or all bits set/cleared.
> 
> The bug you referred to was using fill with nr_cpumask_bits, using
> large_cpumask_bits would've been sufficient.

Consider MAX_NUMNODES == 64 and nr_node_ids == 4. Then
small_nodemask_bits == 64.

The nodes_full() will set all 64 bits:

  #define nodes_full(nodemask) __nodes_full(&(nodemask), small_nodemask_bits)
  static inline bool __nodes_full(const nodemask_t *srcp, unsigned int nbits)
  {
          return bitmap_full(srcp->bits, nbits);
  }

And the following nodes_weight() will return 64:

  #define nodes_weight(nodemask) __nodes_weight(&(nodemask), small_nodemask_bits)
  static inline int __nodes_weight(const nodemask_t *srcp, unsigned int nbits)
  {
          return bitmap_weight(srcp->bits, nbits);
  }

Which is definitely wrong because there's 4 nodes at max. To solve
this problem, both cpumask and nodemask implementations share the same
rule: all bits beyond nr_{node,cpumask}_bits must be always cleared.

See how cpumask_setall() implements that:

  static inline void cpumask_setall(struct cpumask *dstp)
  {
          // Make sure we don't break the optimization
          if (small_const_nbits(small_cpumask_bits)) {
                  cpumask_bits(dstp)[0] = BITMAP_LAST_WORD_MASK(nr_cpumask_bits);
                  return;
          }

          // Pass the exact (runtime) number of bits
          bitmap_fill(cpumask_bits(dstp), nr_cpumask_bits);
  }

Hope that makes sense.

Thanks,
Yury

> > > @@ -452,7 +511,6 @@ static inline unsigned int next_memory_n
> > >  	return next_node(nid, node_states[N_MEMORY]);
> > >  }
> > >  
> > > -extern unsigned int nr_node_ids;
> > >  extern unsigned int nr_online_nodes;
> > >  
> > >  static inline void node_set_online(int nid)
> > > @@ -494,7 +552,6 @@ static inline int num_node_state(enum no
> > >  #define first_memory_node	0
> > >  #define next_online_node(nid)	(MAX_NUMNODES)
> > >  #define next_memory_node(nid)	(MAX_NUMNODES)
> > > -#define nr_node_ids		1U
> > >  #define nr_online_nodes		1U
> >  
> > I like how you separated the nr_node_ids from the other ifdefery, and
> > changed it to __ro_after_init. But I think it's better to fold this all
> > into the 1st patch.
> 
> This move was needed to make it build -- compiler feels strongly you
> should have declared a variable before using it etc.. No other
> motivation for it. As such it sits in this patch.
> 
> > Why don't we make nr_cpu_ids to be a __ro_after_init just as well?
> 
> Sure, will add patch. Should've checked :/
