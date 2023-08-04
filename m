Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5179E770256
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 15:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjHDNxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 09:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbjHDNwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:52:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E33C49D7;
        Fri,  4 Aug 2023 06:52:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 02A5262040;
        Fri,  4 Aug 2023 13:52:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57914C433CA;
        Fri,  4 Aug 2023 13:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691157153;
        bh=TC4YXwOj6B2nFvsedG4JRUtxSNjcMaFXqnhITWQUs0M=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=QeZ5mfKBwwpqMRBRimueEJRhJ2BKfPui6VgqV0q6IHZCic36huGGTVRpCfEJ+fiGS
         jrtRfFJFzlvVZ/DEeAcvHyDERmVNFIUtPt3WNzc0iM2rxqxuUCcYO+U5g3goOtEQMi
         Em68m067AUNPs0yYd+BrV7zJ/ayyknohshL7rotyecFIZqQmEkdUTvdupIjDjXqnSi
         z7lNwiYViBUMQFruvcYa8tL1s89koqMNjNpukqeFtFvxJvrQOmaPWdSCoAG5eR4WjC
         +txxeF5y2FUqmCNbKPX2BlDN9imVV7KkdUqhfseg7036PPBKTcoEI/IysFuCrclMbP
         YQW3p0pxf9iDA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 00626CE0299; Fri,  4 Aug 2023 06:52:32 -0700 (PDT)
Date:   Fri, 4 Aug 2023 06:52:32 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 2/2] docs: memory-barriers: Add note on plain-accesses to
 address-dependency barriers
Message-ID: <3f53035f-3251-4531-b9b9-e12f371c1051@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230803032408.2514989-1-joel@joelfernandes.org>
 <20230803032408.2514989-2-joel@joelfernandes.org>
 <626d1b48-de6a-4a0b-95d3-3ac438878757@paulmck-laptop>
 <20230804051127.GA3860381@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804051127.GA3860381@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 05:11:27AM +0000, Joel Fernandes wrote:
> On Thu, Aug 03, 2023 at 11:52:06AM -0700, Paul E. McKenney wrote:
> > On Thu, Aug 03, 2023 at 03:24:07AM +0000, Joel Fernandes (Google) wrote:
> > > The compiler has the ability to cause misordering by destroying
> > > address-dependency barriers if comparison operations are used. Add a
> > > note about this to memory-barriers.txt and point to rcu-dereference.rst
> > > for more information.
> > > 
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > ---
> > >  Documentation/memory-barriers.txt | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> > > index 06e14efd8662..acc8ec5ce563 100644
> > > --- a/Documentation/memory-barriers.txt
> > > +++ b/Documentation/memory-barriers.txt
> > > @@ -435,6 +435,11 @@ Memory barriers come in four basic varieties:
> > >       variables such as READ_ONCE() and rcu_dereference() provide implicit
> > >       address-dependency barriers.
> > >  
> > > +     [!] Note that address dependency barriers can be destroyed by comparison
> > > +     of a pointer obtained by a marked accessor such as READ_ONCE() or
> > > +     rcu_dereference() with some value.  For an example of this, see
> > > +     rcu_dereference.rst (part where the comparison of pointers is discussed).
> > 
> > Hmmm...
> > 
> > Given that this is in a section marked "historical" (for the old
> > smp_read_barrier_depends() API), why not instead add a pointer to
> > Documentation/RCU/rcu_dereference.rst to the beginning of the section,
> > noted as the updated material?
> 
> Sounds good. There's also another section in the same file on Address
> dependency barriers (also marked historical). So something like the
> following?

Given a Signed-off-by and so forth, I would be happy to take this one.

							Thanx, Paul

> ---8<-----------------------
> 
> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> index acc8ec5ce563..ba50220716ca 100644
> --- a/Documentation/memory-barriers.txt
> +++ b/Documentation/memory-barriers.txt
> @@ -396,6 +396,10 @@ Memory barriers come in four basic varieties:
>  
>  
>   (2) Address-dependency barriers (historical).
> +     [!] This section is marked as HISTORICAL: For more up-to-date
> +     information, including how compiler transformations related to pointer
> +     comparisons can sometimes cause problems, see
> +     Documentation/RCU/rcu_dereference.rst.
>  
>       An address-dependency barrier is a weaker form of read barrier.  In the
>       case where two loads are performed such that the second depends on the
> @@ -561,6 +565,9 @@ There are certain things that the Linux kernel memory barriers do not guarantee:
>  
>  ADDRESS-DEPENDENCY BARRIERS (HISTORICAL)
>  ----------------------------------------
> +[!] This section is marked as HISTORICAL: For more up-to-date information,
> +including how compiler transformations related to pointer comparisons can
> +sometimes cause problems, see Documentation/RCU/rcu_dereference.rst.
>  
>  As of v4.15 of the Linux kernel, an smp_mb() was added to READ_ONCE() for
>  DEC Alpha, which means that about the only people who need to pay attention
