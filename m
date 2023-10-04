Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E35F7B84F7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 18:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243358AbjJDQYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 12:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243328AbjJDQYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:24:50 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73ACAEE
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 09:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=F4G+OyGH2GoDmdfpbtW/176TGOkO/dnjNFfXNCxoQk0=;
  b=t7OG2ITIR7+F5nD622fweWoEWiBpzP1LEJa5T00pu2NkP+k5I6s80pyX
   fnfgkuR9ZEawt5/ZiQ898/ojFtprkeiHLHPpR0YNWQiF5tD16lwEXuWzf
   OhFGLEbt2mMy45To19uC+NjTMxccssFN4MMEfem8ACvrZ5vOBea7vVMe+
   M=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.03,200,1694728800"; 
   d="scan'208";a="129502245"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 18:24:39 +0200
Date:   Wed, 4 Oct 2023 18:24:39 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: EEVDF and NUMA balancing
In-Reply-To: <20231004120544.GA6307@noisy.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.22.394.2310041822170.3108@hadrien>
References: <alpine.DEB.2.22.394.2310032059060.3220@hadrien> <20231003215159.GJ1539@noisy.programming.kicks-ass.net> <alpine.DEB.2.22.394.2310041358420.3108@hadrien> <20231004120544.GA6307@noisy.programming.kicks-ass.net>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 4 Oct 2023, Peter Zijlstra wrote:

> On Wed, Oct 04, 2023 at 02:01:26PM +0200, Julia Lawall wrote:
> >
> >
> > On Tue, 3 Oct 2023, Peter Zijlstra wrote:
> >
> > > On Tue, Oct 03, 2023 at 10:25:08PM +0200, Julia Lawall wrote:
> > > > Is it expected that the commit e8f331bcc270 should have an impact on the
> > > > frequency of NUMA balancing?
> > >
> > > Definitely not expected. The only effect of that commit was supposed to
> > > be the runqueue order of tasks. I'll go stare at it in the morning --
> > > definitely too late for critical thinking atm.
> >
> > Maybe it's just randomly making a bad situation worse rather than directly
> > introduing a problem.  There is a high standard deviatind in the
> > performance.  Here are some results with hyperfine.  The general trends
> > are reproducible.
>
> OK,. I'm still busy trying to bring a 4 socket machine up-to-date...
> gawd I hate the boot times on those machines :/
>
> But yeah, I was thinking similar things, I really can't spot an obvious
> fail in that commit.
>
> I'll go have a poke once the darn machine is willing to submit :-)

I tried a two-socket machine, but in 50 runs the problem doesn't show up.

The commit e8f331bcc270 starts with

-       if (sched_feat(PLACE_LAG) && cfs_rq->nr_running > 1) {
+       if (sched_feat(PLACE_LAG) && cfs_rq->nr_running) {

This seemed like a big change - cfs_rq->nr_running > 1 should be rarely
true in ua, while cfs_rq->nr_running should always be true.  Adding back
the > 1 and simply replacing the test by 0 both had no effect, though.

julia
