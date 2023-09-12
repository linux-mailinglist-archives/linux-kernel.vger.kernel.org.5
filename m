Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A6679D37C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 16:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235875AbjILOXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 10:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235796AbjILOXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 10:23:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC9810D;
        Tue, 12 Sep 2023 07:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/H+bFDVMZGBYCVEP7wj9urnwFfRSQ9S3k0Idab6o22M=; b=FVBXqHi4R1OgjgueOAXk3SoMxu
        yJsijKjYeue08jJnaQ7TSXQhceSpFtRcZR/hmKb6+HClpksbboY1aO4FhUQm8+9NeGVX//ETl1kUM
        rep3tDv674hRzvI1l/hPmOqzJFoT2ucT7qnhyxq9LZq+qYmZ2mIyxdJgpR2yf1toVfsGUm/hFPOs7
        p9IdlUDHFw/3qtM1UOdx6ATcL0phlP6XIVvVcVNcQhik/meARVeUaGNSfGi6Oq9w3Wj1j991KwiAy
        9Ghw0CfwmhayBX63nGFeY/o/tc5YJAUHzz8nttDzS5x5ccgNO1UrhaYunkKZv9XcbVz3jrVYoFdVN
        W3sAHEmg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qg4I8-0083sg-Ox; Tue, 12 Sep 2023 14:23:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 68BEE3005B2; Tue, 12 Sep 2023 16:23:00 +0200 (CEST)
Date:   Tue, 12 Sep 2023 16:23:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/5] locking: Add rwsem_is_write_locked()
Message-ID: <20230912142300.GC22127@noisy.programming.kicks-ass.net>
References: <20230908104434.GB24372@noisy.programming.kicks-ass.net>
 <ZP5JrYOge3tSAvj7@dread.disaster.area>
 <ZP5OfhXhPkntaEkc@casper.infradead.org>
 <ZP5llBaVrJteHQf3@dread.disaster.area>
 <70d89bf4-708b-f131-f90e-5250b6804d48@redhat.com>
 <ZP+U49yfkm0Fpfej@dread.disaster.area>
 <20230912090342.GC35261@noisy.programming.kicks-ass.net>
 <ZQBZXSCyG+u2+i8E@casper.infradead.org>
 <20230912135213.GA22127@noisy.programming.kicks-ass.net>
 <ZQBuiJ2n0uBOdjnr@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQBuiJ2n0uBOdjnr@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 02:58:32PM +0100, Matthew Wilcox wrote:
> On Tue, Sep 12, 2023 at 03:52:13PM +0200, Peter Zijlstra wrote:
> > On Tue, Sep 12, 2023 at 01:28:13PM +0100, Matthew Wilcox wrote:
> > > On Tue, Sep 12, 2023 at 11:03:42AM +0200, Peter Zijlstra wrote:
> > > > If not, then sure we can do this; it's not like I managed to get rid of
> > > > muteX_is_locked() -- and I actually tried at some point :/
> > > > 
> > > > And just now I grepped for it, and look what I find:
> > > > 
> > > > drivers/hid/hid-nintendo.c:     if (unlikely(mutex_is_locked(&ctlr->output_mutex))) {
> > > > drivers/nvdimm/btt.c:           if (mutex_is_locked(&arena->err_lock)
> > > > 
> > > > And there's more :-(
> > > 
> > > Are these actually abuse?  I looked at these two, and they both seem to
> > > be asking "Does somebody else currently have this mutex?" rather than
> > > "Do I have this mutex?".
> > 
> > It's effectively a random number generator in that capacity. Someone
> > might have it or might have had it when you looked and no longer have
> > it, or might have it now but not when you asked.
> 
> Well, no.
> 
>                 if (mutex_is_locked(&arena->err_lock)
>                                 || arena->freelist[lane].has_err) {
>                         nd_region_release_lane(btt->nd_region, lane);
> 
>                         ret = arena_clear_freelist_error(arena, lane);
> 
> So that's "Is somebody currently processing an error, or have they
> already finished setting an error".  Sure, it's somewhat racy, but
> it looks like a performance optimisation, not something that needs
> 100% accuracy.

We're arguing past one another I think. Yes mutex_is_locked() is a
random number generator when asked for something you don't own. But it
might not be a bug because the code is ok with races.

It is still fully dodgy IMO, such usage is pretty close to UB.
