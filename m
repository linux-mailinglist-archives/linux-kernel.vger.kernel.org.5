Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6618F7B75E9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 02:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238126AbjJDAfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 20:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjJDAfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 20:35:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28EDA6;
        Tue,  3 Oct 2023 17:35:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3898AC433C7;
        Wed,  4 Oct 2023 00:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696379732;
        bh=xTLf60xl9ywLlbfDNQmvd8IqUlwOS3SJ+u4eCvgHsog=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=atW2Z6340QtMCKI8qMfcwBjRgADGd6qTVXy/dhms8Ls1XdIgOn3N/arWd2e/DQ911
         B1CWAHHGhiXlgoN9VZE5Db35fX8hxXkoyg+apqoOG7pu8GWyaM3SJ6aD/q05+0Ub0R
         HMQc7qACPaNrexqyobcJW1NUry3Cuz3yiUceT5J2brb9Bx4XDYz286PxoOWRYpKEOm
         EBs7DGlNZ6ilJH00w19sQ2krB+Hn0UqcQh0Z1EAd9pNVNDFqFLVynJJM8woXSTOYCs
         sHxLVG7H0wHoSeJMrowr5J0ireJ8kxKAuRKPXF2ko30ED8Dp0iDLQ/Wf/Bu3Incxop
         ih8GREYNELj1Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C6B74CE09E4; Tue,  3 Oct 2023 17:35:31 -0700 (PDT)
Date:   Tue, 3 Oct 2023 17:35:31 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Yong He <zhuangel570@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>, RCU <rcu@vger.kernel.org>
Subject: Re: [PATCH 0/5] srcu fixes
Message-ID: <f214737a-6856-455f-ac86-9f7ec605b902@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231003232903.7109-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003232903.7109-1-frederic@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 01:28:58AM +0200, Frederic Weisbecker wrote:
> Hi,
> 
> This contains a fix for "SRCU: kworker hung in synchronize_srcu":
> 
> 	http://lore.kernel.org/CANZk6aR+CqZaqmMWrC2eRRPY12qAZnDZLwLnHZbNi=xXMB401g@mail.gmail.com
> 
> And a few cleanups.
> 
> Passed 50 hours of SRCU-P and SRCU-N.
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
> 	srcu/fixes
> 
> HEAD: 7ea5adc5673b42ef06e811dca75e43d558cc87e0
> 
> Thanks,
> 	Frederic

Very good, and a big "Thank You!!!" to all of you!

I queued this series for testing purposes, and have started a bunch of
SRCU-P and SRCU-N tests on one set of systems, and a single SRCU-P and
SRCU-N on another system, but with both scenarios resized to 40 CPU each.

While that is in flight, a few questions:

o	Please check the Co-developed-by rules.  Last I knew, it was
	necessary to have a Signed-off-by after each Co-developed-by.

o	Is it possible to get a Tested-by from the original reporter?
	Or is this not reproducible?

o	Is it possible to convince rcutorture to find this sort of
	bug?  Seems like it should be, but easy to say...

o	Frederic, would you like to include this in your upcoming
	pull request?  Or does it need more time?

						Thanx, Paul

> ---
> 
> Frederic Weisbecker (5):
>       srcu: Fix callbacks acceleration mishandling
>       srcu: Only accelerate on enqueue time
>       srcu: Remove superfluous callbacks advancing from srcu_start_gp()
>       srcu: No need to advance/accelerate if no callback enqueued
>       srcu: Explain why callbacks invocations can't run concurrently
> 
> 
>  kernel/rcu/srcutree.c | 55 ++++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 39 insertions(+), 16 deletions(-)
