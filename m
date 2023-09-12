Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF40879D31A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 16:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235762AbjILOC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 10:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234834AbjILOC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 10:02:57 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF52610CE;
        Tue, 12 Sep 2023 07:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zUdtnDARSEGsaZV8teORBRcSM/T2JFV9fIyHbs3iVko=; b=pGzPWYu3IcDq5RuGqivEEtVMUx
        bobaHOCtt0fDZZxDVgZo16iDnL1cYW548UAtPN9P2mBKKraGDG49XFG2Lehid8HS1mkIWvV+didNG
        gWn4lwWgbLG4PeeGlo6wIPpaXjzp3uD26m0TjSLQmEbKCMYgKORtH+MHZZP952KmEOzm65gqo3tx+
        BaeUh+CB+8brMKPaP2LaRI63YQjol/Ef3SLtVlEO3zmkyyQBzWxY8UXYY8znTyMY6YL4YB61DFMVR
        e1uCqbNs1D1Jjf3Y9DrRvFXs4bUERKaVdyH8U209rU9OI39yLeQR7tadKTc2AGVTeHc1Gz7kY88yj
        iJEYg9wg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qg3yE-0069kM-36;
        Tue, 12 Sep 2023 14:02:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1389B300348; Tue, 12 Sep 2023 16:02:28 +0200 (CEST)
Date:   Tue, 12 Sep 2023 16:02:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/5] locking: Add rwsem_is_write_locked()
Message-ID: <20230912140228.GA22248@noisy.programming.kicks-ass.net>
References: <ZPpV+MeFqX6RHIYw@dread.disaster.area>
 <20230908104434.GB24372@noisy.programming.kicks-ass.net>
 <ZP5JrYOge3tSAvj7@dread.disaster.area>
 <ZP5OfhXhPkntaEkc@casper.infradead.org>
 <ZP5llBaVrJteHQf3@dread.disaster.area>
 <70d89bf4-708b-f131-f90e-5250b6804d48@redhat.com>
 <ZP+U49yfkm0Fpfej@dread.disaster.area>
 <20230912090342.GC35261@noisy.programming.kicks-ass.net>
 <ZQBZXSCyG+u2+i8E@casper.infradead.org>
 <20230912135213.GA22127@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912135213.GA22127@noisy.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 03:52:13PM +0200, Peter Zijlstra wrote:
> On Tue, Sep 12, 2023 at 01:28:13PM +0100, Matthew Wilcox wrote:
> > On Tue, Sep 12, 2023 at 11:03:42AM +0200, Peter Zijlstra wrote:
> > > If not, then sure we can do this; it's not like I managed to get rid of
> > > muteX_is_locked() -- and I actually tried at some point :/
> > > 
> > > And just now I grepped for it, and look what I find:
> > > 
> > > drivers/hid/hid-nintendo.c:     if (unlikely(mutex_is_locked(&ctlr->output_mutex))) {
> > > drivers/nvdimm/btt.c:           if (mutex_is_locked(&arena->err_lock)
> > > 
> > > And there's more :-(
> > 
> > Are these actually abuse?  I looked at these two, and they both seem to
> > be asking "Does somebody else currently have this mutex?" rather than
> > "Do I have this mutex?".
> 
> It's effectively a random number generator in that capacity. Someone
> might have it or might have had it when you looked and no longer have
> it, or might have it now but not when you asked.

Also, there's more fun; the 'is_locked' store from spin_lock() (or
mutex, or whatever) is not ordered vs any other write inside the
critical section.

So something like:

	bar = 0;

	CPU0			CPU1

	spin_lock(&foo)		
	bar = 1;		x = READ_ONCE(bar)
				y = spin_is_locked(&foo);
	spin_unlock(&foo);


can have x==1 && y==0, even though CPU0 is currently inside the critical
section.

Normally that doesn't matter, and for the program-order case where you
ask 'am I holding the lock' this obviously cannot go wrong. But the
moment you ask: 'is someone else holding the lock' it all goes sideways
real fast.

We've been there, done that, got a t-shirt etc..
