Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5567979CCB4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 12:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233523AbjILKA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 06:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233590AbjILKAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:00:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2468C10E0;
        Tue, 12 Sep 2023 03:00:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF53C433D9;
        Tue, 12 Sep 2023 10:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694512811;
        bh=2QOrKx+Xb+EJ5/74k7kuwKb8czGo2OeeiPj5tdU/8Xk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Y5JnVKprj6bUwUEkD9rsCe2ACaJTIlMGY5JQ3MLcWfS6rdJMhVwwX49jpA5AdR+pT
         DQuYBwtHeCumymdRH/g8yBYd1vOsQnYifdOZUPwN3qiNAJ8G5Ru2l+d2neRCdQuikt
         R9V/f3VnBRhrD4qNgpLmBg49BNgjZu17qgs7PEKbD73O+p00MG0t6i8vNn8DiPVDI7
         vBEGcchvI/eD7sOSD+C92xK5++EypyGdLr9twR5Ah8yjeFE6kQXHpnJkh8RsCnBvvc
         5uVPHjAqWqKU+Ct6S8CeIiFRXFkCsNpe1fkTevf1YQtxsiqoIVg/rOWhAcgs6ENQ9h
         j6k+U780tbKmg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3F486CE093C; Tue, 12 Sep 2023 03:00:11 -0700 (PDT)
Date:   Tue, 12 Sep 2023 03:00:11 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Shanker Donthineni <sdonthineni@nvidia.com>
Subject: Re: [PATCH v2 1/2] maple_tree: Disable mas_wr_append() when other
 readers are possible
Message-ID: <62936d98-6353-486e-8535-86c9f90bc7f4@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <3f86d58e-7f36-c6b4-c43a-2a7bcffd3bd@linux-m68k.org>
 <20230906152325.dblzauybyoq5kd35@revolver>
 <ad298077-fca8-437e-b9e3-66e31424afb1@paulmck-laptop>
 <20230906172954.oq4vogeuco25zam7@revolver>
 <495849d6-1dc6-4f38-bce7-23c50df3a99f@paulmck-laptop>
 <20230911235452.xhtnt7ply7ayr53x@revolver>
 <33150b55-970c-4607-9015-af0e50e4112d@paulmck-laptop>
 <CAMuHMdWKwdxjRf031aD=Ko7vRdvFW-OR48QAc=ZFy=FP_LNAoA@mail.gmail.com>
 <f9b0a88c-8a64-439f-a488-85d500c9f2aa@paulmck-laptop>
 <CAMuHMdX89u6wL9W+8ZOn-OTT1FreYjEqYnvEip4Aq3k1gOP0EQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdX89u6wL9W+8ZOn-OTT1FreYjEqYnvEip4Aq3k1gOP0EQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 10:34:44AM +0200, Geert Uytterhoeven wrote:
> Hi Paul,
> 
> On Tue, Sep 12, 2023 at 10:30 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > On Tue, Sep 12, 2023 at 10:23:37AM +0200, Geert Uytterhoeven wrote:
> > > On Tue, Sep 12, 2023 at 10:14 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > On Mon, Sep 11, 2023 at 07:54:52PM -0400, Liam R. Howlett wrote:
> > > > > * Paul E. McKenney <paulmck@kernel.org> [230906 14:03]:
> > > > > > On Wed, Sep 06, 2023 at 01:29:54PM -0400, Liam R. Howlett wrote:
> > > > > > > * Paul E. McKenney <paulmck@kernel.org> [230906 13:24]:
> > > > > > > > On Wed, Sep 06, 2023 at 11:23:25AM -0400, Liam R. Howlett wrote:
> > > > > > > > > (Adding Paul & Shanker to Cc list.. please see below for why)
> > > > > > > > >
> > > > > > > > > Apologies on the late response, I was away and have been struggling to
> > > > > > > > > get a working PPC32 test environment.
> > > > > > > > >
> > > > > > > > > * Geert Uytterhoeven <geert@linux-m68k.org> [230829 12:42]:
> > > > > > > > > >     Hi Liam,
> > > > > > > > > >
> > > > > > > > > > On Fri, 18 Aug 2023, Liam R. Howlett wrote:
> > > > > > > > > > > The current implementation of append may cause duplicate data and/or
> > > > > > > > > > > incorrect ranges to be returned to a reader during an update.  Although
> > > > > > > > > > > this has not been reported or seen, disable the append write operation
> > > > > > > > > > > while the tree is in rcu mode out of an abundance of caution.
> > > > > > > > >
> > > > > > > > > ...
> > > > > > > > > > >
> > > > >
> > > > > ...
> > > > >
> > > > > > > > > > RCU-related configs:
> > > > > > > > > >
> > > > > > > > > >     $ grep RCU .config
> > > > > > > > > >     # RCU Subsystem
> > > > > > > > > >     CONFIG_TINY_RCU=y
> > > >
> > > > I must have been asleep last time I looked at this.  I was looking at
> > > > Tree RCU.  Please accept my apologies for my lapse.  :-/
> > > >
> > > > However, Tiny RCU's call_rcu() also avoids enabling IRQs, so I would
> > > > have said the same thing, albeit after looking at a lot less RCU code.
> > > >
> > > > TL;DR:
> > > >
> > > > 1.      Try making the __setup_irq() function's call to mutex_lock()
> > > >         instead be as follows:
> > > >
> > > >         if (!mutex_trylock(&desc->request_mutex))
> > > >                 mutex_lock(&desc->request_mutex);
> > > >
> > > >         This might fail if __setup_irq() has other dependencies on a
> > > >         fully operational scheduler.
> > > >
> > > > 2.      Move that ppc32 call to __setup_irq() much later, most definitely
> > > >         after interrupts have been enabled and the scheduler is fully
> > > >         operational.  Invoking mutex_lock() before that time is not a
> > > >         good idea.  ;-)
> > >
> > > There is no call to __setup_irq() from arch/powerpc/?
> >
> > Glad it is not just me, given that I didn't see a direct call, either.  So
> > later in this email, I asked Liam to put a WARN_ON_ONCE(irqs_disabled())
> > just before that mutex_lock() in __setup_irq().
> >
> > Either way, invoking mutex_lock() early in boot before interrupts have
> > been enabled is a bad idea.  ;-)
> 
> I'll add that WARN_ON_ONCE() too, and will report back later today...

Thank you, looking forward to hearing the outcome!

> > > Note that there are (possibly different) issues seen on ppc32 and on arm32
> > > (Renesas RZ/A in particular, but not on other Renesas ARM systems).
> > >
> > > I saw an issue on arm32 with cfeb6ae8bcb96ccf, but not with cfeb6ae8bcb96ccf^.
> > > Other people saw an issue on ppc32 with both cfeb6ae8bcb96ccf and
> > > cfeb6ae8bcb96ccf^.
> >
> > I look forward to hearing what is the issue in both cases.
> 
> For RZ/A, my problem report is
> https://lore.kernel.org/all/3f86d58e-7f36-c6b4-c43a-2a7bcffd3bd@linux-m68k.org/

Thank you, Geert!

Huh.  Is that patch you reverted causing Maple Tree or related code
to attempt to acquire mutexes in early boot before interrupts have
been enabled?

If that added WARN_ON_ONCE() doesn't trigger early, another approach
would be to put it at the beginning of mutex_lock().  Or for that matter
at the beginning of might_sleep().

							Thanx, Paul
