Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5765B797D4D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 22:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233001AbjIGUQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 16:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjIGUQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 16:16:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87241FD5;
        Thu,  7 Sep 2023 13:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jWg8/WTVxcLQeJmtvub0jZpN0nNGGp4UGRhccBbLR9Q=; b=fi7EJqT16/drP032lQHE0BKC1w
        nNvIOzzI5jkMKtVk4MnWMvr4W/g8E73gwKtV7kaXoCRGitmSmqAmEAKBEhsgEMVF6r2hvA8Gaqt9T
        LOxw10KWd80UW0nav/rVQEZI/2qy1AACrCjkcAk+xcypvmS9SzTKX1liqHkOtLBf5yGYx+D1jZQ5A
        M4UPydSMiqi8Lk04SWq14ynl4LSCqHDg/+opQnE6xLnRauE4sr+fxFWwBi0H4zDu3qMOzBIhFlRK0
        N/q7mwbph7ZkGygratv4LWx+Qn1kyC1XCsPlYwE0AGwd5JDiTCHme9WXtMip/Mmp1Pq0YHsE1TpNP
        pQSMZsSw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qeLQ9-00DExg-MH; Thu, 07 Sep 2023 20:16:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 42F60300687; Thu,  7 Sep 2023 22:16:09 +0200 (CEST)
Date:   Thu, 7 Sep 2023 22:16:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Qais Yousef <qyousef@layalina.io>
Subject: Re: [RFC PATCH 0/7] sched: cpufreq: Remove magic margins
Message-ID: <20230907201609.GC14243@noisy.programming.kicks-ass.net>
References: <20230827233203.1315953-1-qyousef@layalina.io>
 <a6365f63-4669-15e5-b843-f4bfb1bd5e68@arm.com>
 <20230906211850.zyvk6qtt6fvpxaf3@airbuntu>
 <20230907132631.GF10955@noisy.programming.kicks-ass.net>
 <8919ed14-8d19-d964-2278-3303a5bda8ee@arm.com>
 <20230907142923.GJ10955@noisy.programming.kicks-ass.net>
 <cf5c628a-e047-b5e0-b2a0-f2b280015d02@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf5c628a-e047-b5e0-b2a0-f2b280015d02@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 03:42:13PM +0100, Lukasz Luba wrote:

> > What task characteristic is tied to this? That is, this seems trivial to
> > modify per-task.
> 
> In particular Speedometer test and the main browser task, which reaches
> ~900util, but sometimes vanish and waits for other background tasks
> to do something. In the meantime it can decay and wake-up on
> Mid/Little (which can cause a penalty to score up to 5-10% vs. if
> we pin the task to big CPUs). So, a longer util_est helps to avoid
> at least very bad down migration to Littles...

Do they do a few short activations (wakeup/sleeps) while waiting? That
would indeed completely ruin things since the EWMA thing is activation
based.

I wonder if there's anything sane we can do here...
