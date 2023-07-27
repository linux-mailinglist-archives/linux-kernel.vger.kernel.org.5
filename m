Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920FB76584F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 18:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbjG0QJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 12:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjG0QJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 12:09:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAE72723
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 09:09:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5BCA61EBA
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 16:09:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2FEC433C8;
        Thu, 27 Jul 2023 16:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690474156;
        bh=OVB2HnBwuq4s+VFd9Hwc8Ai7TvaLJTTKhvDjcGcBCwM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=So6i3veCC5QVdy8A6oURdQYjr2v7mOmlfPLsEFCsoQ+g+rcWYGNJEXfacqYLAgcCw
         uyj6HfjjfHmLZjIjFqtFgS/tvhlnH7XZ35691KfR9ds0/9ubZlZtdnmdw8kRhm3R23
         4dBKNKdGc9EKI/hp6T9fyCxm7aNIrxVG0/ynWsootj8hqxHYBx5CXnsNc6YkZUO0jq
         Da0N4CW4Gomi7rNvPKdIegGrSp0LSCSxdUyQQfnsMgTKiXcTJHvp7knMLT45uBNxx8
         766HRIrBsOC1W2zHHYa23ZtiR5RPreA9oSpLQPThaHrWznHpl+5dXcS4RK8yYEV/D6
         xtXc/8m+2iF8g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B2249CE0B66; Thu, 27 Jul 2023 09:09:15 -0700 (PDT)
Date:   Thu, 27 Jul 2023 09:09:15 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 0/2] fix vma->anon_vma check for per-VMA locking; fix
 anon_vma memory ordering
Message-ID: <01bcf3aa-6072-45e6-9149-c2cd99171454@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230726214103.3261108-1-jannh@google.com>
 <31df93bd-4862-432c-8135-5595ffd2bd43@paulmck-laptop>
 <CAG48ez1fDzHzdD8YHEK-9D=7YcsR7Bp-FHCr25x13aqXpz7UnQ@mail.gmail.com>
 <ZMKINJ9+WX1WWG8g@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMKINJ9+WX1WWG8g@casper.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 04:07:32PM +0100, Matthew Wilcox wrote:
> On Thu, Jul 27, 2023 at 04:39:34PM +0200, Jann Horn wrote:
> > Assume that we are holding some kind of lock that ensures that the
> > only possible concurrent update to "vma->anon_vma" is that it changes
> > from a NULL pointer to a non-NULL pointer (using smp_store_release()).
> > 
> > 
> > if (READ_ONCE(vma->anon_vma) != NULL) {
> >   // we now know that vma->anon_vma cannot change anymore
> > 
> >   // access the same memory location again with a plain load
> >   struct anon_vma *a = vma->anon_vma;
> > 
> >   // this needs to be address-dependency-ordered against one of
> >   // the loads from vma->anon_vma
> >   struct anon_vma *root = a->root;
> > }
> > 
> > 
> > Is this fine? If it is not fine just because the compiler might
> > reorder the plain load of vma->anon_vma before the READ_ONCE() load,
> > would it be fine after adding a barrier() directly after the
> > READ_ONCE()?
> > 
> > I initially suggested using READ_ONCE() for this, and then Linus and
> > me tried to reason it out and Linus suggested (if I understood him
> > correctly) that you could make the ugly argument that this works
> > because loads from the same location will not be reordered by the
> > hardware. So on anything other than alpha, we'd still have the
> > required address-dependency ordering because that happens for all
> > loads, even plain loads, while on alpha, the READ_ONCE() includes a
> > memory barrier. But that argument is weirdly reliant on
> > architecture-specific implementation details.
> > 
> > The other option is to replace the READ_ONCE() with a
> > smp_load_acquire(), at which point it becomes a lot simpler to show
> > that the code is correct.
> 
> Aren't we straining at gnats here?  The context of this is handling a
> page fault, and we used to take an entire rwsem for read.  I'm having
> a hard time caring about "the extra expense" of an unnecessarily broad
> barrier.
> 
> Cost of an L3 cacheline miss is in the thousands of cycles.  Cost of a
> barrier is ... tens?

Couldn't agree more!

							Thanx, Paul
