Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75FD479D307
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 15:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235749AbjILN6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 09:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234939AbjILN6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 09:58:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A488E10DE;
        Tue, 12 Sep 2023 06:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HLmUvHYjOx5CSGh1JuF73s0prezlWCqoq7fl6e++tvY=; b=C4dp3zc/srLNk1O5LCPz7WiVIl
        WeS9N0E29pdEYfHkVCt7Btc1NSXni+wJoEFBjTeLUj/+wDBk2ullMwbj5vydn10EntGUrQAn/8sfk
        KisApbEl4A19ddb+g1RkaOUeezkH83SpxC/HpEgwfWgXQEzKq+Lm23GXf8QrQtjaM+fh6/M3zZYJh
        CEAODiUyuUO091KirHgiB4kCXbYBN52SbPjMJ9DTedD6MTqWaGf7VRtsGU3yyFJ+If1OWfhy7vjZ8
        hpsdRTVjjPw1TbqE7kec1kMZgqwNDfi6FnYjrEnxLl4dHzXHVAWwTFUkqMpyjumYYdsLZIGumUaG6
        EYx5yTtg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qg3uS-007vmd-JF; Tue, 12 Sep 2023 13:58:32 +0000
Date:   Tue, 12 Sep 2023 14:58:32 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/5] locking: Add rwsem_is_write_locked()
Message-ID: <ZQBuiJ2n0uBOdjnr@casper.infradead.org>
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

Well, no.

                if (mutex_is_locked(&arena->err_lock)
                                || arena->freelist[lane].has_err) {
                        nd_region_release_lane(btt->nd_region, lane);

                        ret = arena_clear_freelist_error(arena, lane);

So that's "Is somebody currently processing an error, or have they
already finished setting an error".  Sure, it's somewhat racy, but
it looks like a performance optimisation, not something that needs
100% accuracy.

The other one's in a similar boat; an optimisation if anyone else is
currently holding this mutex:

        /*
         * Immediately after receiving a report is the most reliable time to
         * send a subcommand to the controller. Wake any subcommand senders
         * waiting for a report.
         */
        if (unlikely(mutex_is_locked(&ctlr->output_mutex))) {
                spin_lock_irqsave(&ctlr->lock, flags);
                ctlr->received_input_report = true;
                spin_unlock_irqrestore(&ctlr->lock, flags);
                wake_up(&ctlr->wait);
        }

Sure, they might not still be holding it, or it may have been grabbed
one clock tick later; that just means they miss out on this optimisation.
