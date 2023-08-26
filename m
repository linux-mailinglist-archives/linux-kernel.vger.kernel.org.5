Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33260789319
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 03:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbjHZBcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 21:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjHZBcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 21:32:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07743E77;
        Fri, 25 Aug 2023 18:32:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9319363AAB;
        Sat, 26 Aug 2023 01:31:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2118C433C7;
        Sat, 26 Aug 2023 01:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693013519;
        bh=DAutNTAY/ejhXzgY0hUUg+eAqe9e6XFYvIOoeeMEoaM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ANqv4QfTZuKw5zyFuBtB182Ysp3R0j8fyYPO8WI2AeQ/lp3iTtpi2BhN/F9StTRGw
         /RvrhruEutb6IEX2WPEojptUe6dL6wGN6x4OPrXBuSSG9ze2psWi5AVO/4K4Kk1+UQ
         Ak2d9E+5sBkXoZPSj9pUQu5c3ljIv5Zc4lO6mb0+cyg97mb1XQUU6Jq+FYCbyWSkZX
         zXmXRKTzjza1mEb5EnrU0Yo1XOSWn9Cq03UGZ+NCFveLSMTO5uX/Lot/RR8NtTkICY
         a60oxeRx4yfwH0soQwyO0M5LjX4rVwkNNMoGsnuRDp++mGnQb1Jna3LwshihhfrHaH
         uxy9FrA2BpGsQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6A1B3CE137E; Fri, 25 Aug 2023 18:31:56 -0700 (PDT)
Date:   Fri, 25 Aug 2023 18:31:56 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH] rcutorture: Replace schedule_timeout*() 1 jiffie waits
 with HZ/20
Message-ID: <20f4de24-d7f1-4a10-bb32-b9d39773c9a6@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230816204913.450457-1-joel@joelfernandes.org>
 <530be59f-96a9-4b2b-8be3-af837d7cbe3a@paulmck-laptop>
 <20230825025538.GF4008060@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825025538.GF4008060@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 02:55:38AM +0000, Joel Fernandes wrote:
> On Wed, Aug 23, 2023 at 02:07:55PM -0700, Paul E. McKenney wrote:
> > On Wed, Aug 16, 2023 at 08:49:12PM +0000, Joel Fernandes (Google) wrote:
> > > In the past, we see that spinning on schedule_timeout* with a wait of 1
> > > jiffie can hang the kernel. See d52d3a2bf408 ("torture: Fix hang during
> > > kthread shutdown phase").
> > > 
> > > Recently again it showed up in torture's stutter code as well. The behavior is
> > > the the function may instantly return and never go to sleep preempting whatever
> > > was running under it.
> > > 
> > > To prevent future issues, apply the same fix mentioned in the above
> > > commit d52d3a2bf408 to more places.
> > > 
> > > I took care to only apply it to places where I thought it made sense.
> > > 
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > 
> > Hearing no objections, I applied this for further review and testing.
> > 
> > In the future, should some of these become hrtimers?
> 
> Yes they certainly could be but we don't need these ones to be high
> resolution AFAICS and the jiffie granularity should be good.

True, but wouldn't avoiding the repeated wakeups, even at the lower
frequency, be of some value?

							Thanx, Paul
