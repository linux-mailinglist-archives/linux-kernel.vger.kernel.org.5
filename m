Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01955797374
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239865AbjIGPYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236114AbjIGPXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:23:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC19135;
        Thu,  7 Sep 2023 08:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OI476zBUwqc76nvniBbxYuu0lwS1B+BEzNEeiMb9prM=; b=YWBUFZDlCLXGhIHhep3kUss7WX
        58SpxA+obyk9Yr50WkV8w6pYdrJcBO9nIVzcW1H9sUd8rqojPW6cAD75eRMtNw+zYwv3NGqsm0/7C
        mQES2ZWgNpF+Vos54yYoMjqM2ZiJZQ2MNYxtd060vYxy9eTL5vgc2AxiXoIiwLXdk3o3TXZTUk+lz
        3mdDX2kYgSAW/9gYFpgDgPF6B0I6VJYfuCWAmyg7Vb+t5jXk5FZiwSX0BdDtwAy9l3HiAt1FHTHla
        Px+XUieyhSyG0q0UNnOWUrhkKMBRfAmGuYuCJoSv3et79OAFOpm8oMG2I5vMz0MB6noWPDi8Yo9mA
        5nmk/Djg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qeDZL-00Aen9-SW; Thu, 07 Sep 2023 11:53:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 830C7300687; Thu,  7 Sep 2023 13:53:07 +0200 (CEST)
Date:   Thu, 7 Sep 2023 13:53:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Qais Yousef <qyousef@layalina.io>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH 0/7] sched: cpufreq: Remove magic margins
Message-ID: <20230907115307.GD10955@noisy.programming.kicks-ass.net>
References: <20230827233203.1315953-1-qyousef@layalina.io>
 <a6365f63-4669-15e5-b843-f4bfb1bd5e68@arm.com>
 <20230906211850.zyvk6qtt6fvpxaf3@airbuntu>
 <6011d8bb-9a3b-1435-30b0-d75b39bf5efa@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6011d8bb-9a3b-1435-30b0-d75b39bf5efa@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 08:48:08AM +0100, Lukasz Luba wrote:

> > Hehe. That's because they're not really periodic ;-)
> 
> They are periodic in a sense, they wake up every 16ms, but sometimes
> they have more work. It depends what is currently going in the game
> and/or sometimes the data locality (might not be in cache).
> 
> Although, that's for games, other workloads like youtube play or this
> one 'Yahoo browser' (from your example) are more 'predictable' (after
> the start up period). And I really like the potential energy saving
> there :)

So everything media is fundamentally periodic, you're hard tied to the
framerate / audio-buffer size etc..

Also note that the traditional periodic task model from the real-time
community has the notion of WCET, which completely covers this
fluctuation in frame-to-frame work, it only considers the absolute worst
case.

Now, practically, that stinks, esp. when you care about batteries, but
it does not mean these tasks are not periodic.

Many extentions to the periodic task model are possible, including
things like average runtime with bursts etc.. all have their trade-offs.
