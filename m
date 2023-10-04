Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD16F7B86EC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 19:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233958AbjJDRsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 13:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbjJDRsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 13:48:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6409E
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 10:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cCyNQY2PqRUUwPVEhQWWTvU6sVIE17n3grQQ+eFVYPo=; b=GNG8f37hv9dXl/xj4GQO6Ms+X9
        7hZxFURq6Hyelp5HeRptfl2Iy8DnVMgma7qSR1sAoxnYTuZjhFBFunOP5nrM6ktQHq+cqkgmvLzxg
        JKK7jkssuLx03mz3uxYwMvFmuDMfaX0H6gdejJlAbIyG1dbZq2TQREWeMK+BP99/KxdncWqeZTA3l
        HUQ84Hy8VHUItgcC6A/z8xZ9aGynGZV3eMbHBT85LBOQRboBQqD+MdlOZzm76gh+teukAHlImKuyW
        bpQ8wAXYjzFZH2/JNdi3Jwo2yuvvL2vx8cMfzFbcTjAkYV5ujXs+KbnpocGu8kF1CXQ9UTO6lXzMf
        lK1qQ0UQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qo5yb-004f4g-P6; Wed, 04 Oct 2023 17:48:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 71A76300392; Wed,  4 Oct 2023 19:48:01 +0200 (CEST)
Date:   Wed, 4 Oct 2023 19:48:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: EEVDF and NUMA balancing
Message-ID: <20231004174801.GE19999@noisy.programming.kicks-ass.net>
References: <alpine.DEB.2.22.394.2310032059060.3220@hadrien>
 <20231003215159.GJ1539@noisy.programming.kicks-ass.net>
 <alpine.DEB.2.22.394.2310041358420.3108@hadrien>
 <20231004120544.GA6307@noisy.programming.kicks-ass.net>
 <alpine.DEB.2.22.394.2310041822170.3108@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2310041822170.3108@hadrien>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 06:24:39PM +0200, Julia Lawall wrote:
> 
> 
> On Wed, 4 Oct 2023, Peter Zijlstra wrote:
> 
> > On Wed, Oct 04, 2023 at 02:01:26PM +0200, Julia Lawall wrote:
> > >
> > >
> > > On Tue, 3 Oct 2023, Peter Zijlstra wrote:
> > >
> > > > On Tue, Oct 03, 2023 at 10:25:08PM +0200, Julia Lawall wrote:
> > > > > Is it expected that the commit e8f331bcc270 should have an impact on the
> > > > > frequency of NUMA balancing?
> > > >
> > > > Definitely not expected. The only effect of that commit was supposed to
> > > > be the runqueue order of tasks. I'll go stare at it in the morning --
> > > > definitely too late for critical thinking atm.
> > >
> > > Maybe it's just randomly making a bad situation worse rather than directly
> > > introduing a problem.  There is a high standard deviatind in the
> > > performance.  Here are some results with hyperfine.  The general trends
> > > are reproducible.
> >
> > OK,. I'm still busy trying to bring a 4 socket machine up-to-date...
> > gawd I hate the boot times on those machines :/
> >
> > But yeah, I was thinking similar things, I really can't spot an obvious
> > fail in that commit.
> >
> > I'll go have a poke once the darn machine is willing to submit :-)
> 
> I tried a two-socket machine, but in 50 runs the problem doesn't show up.

I've had to re-install the 4 socket thing -- lost the day to this
trainwreck :/ Because obvoiusly the BMC needs Java and that all don't
work anymore -- so I had to go sit next to the jet-engine thing with a
keyboard and monitor.

I'll go build the benchmark thing tomorrow, if I can figure out how that
works, this NAS stuff looked 'special'. Nothing simple like ./configure;
make -j$lots :/

> The commit e8f331bcc270 starts with
> 
> -       if (sched_feat(PLACE_LAG) && cfs_rq->nr_running > 1) {
> +       if (sched_feat(PLACE_LAG) && cfs_rq->nr_running) {
> 
> This seemed like a big change - cfs_rq->nr_running > 1 should be rarely
> true in ua, while cfs_rq->nr_running should always be true.  Adding back
> the > 1 and simply replacing the test by 0 both had no effect, though.

Yeah, this is because I flip the order of place_entity() and
nr_running++ around later in the patch. Previously it would increment
before place, now it does place before increment.
