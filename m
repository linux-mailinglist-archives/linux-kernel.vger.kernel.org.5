Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFCD798832
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 15:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243684AbjIHN67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 09:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243524AbjIHN64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 09:58:56 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0A81BF8;
        Fri,  8 Sep 2023 06:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Wcr8a8tBWINLXI36zvPNSpRI4FGFx++ifjXy4lZNYKw=; b=b2HFnzZX5M+bXCic/fxOccx1Ci
        43Q4tIUuOWBjHHRDGWnhVZxwOLkD9bYF+fHvNhiysfxlQvbbnBcCtryXrKAiZsVYXucjQ9OIjkbWp
        4MkMaNjM5XEBgiYTMZcgCeG56KSqGbwZYdGOMwsDMy83K8o6oC1XWHYSzsmlw3lDBvP5sLB3AsIjM
        LaxqhJXD89hPx1LdR24cy5nsGVw2WR/n28FZYHkgntBsK5r/X/x+WDSNdJjs7d8Yl+8XjDAxCEasW
        xhfR7pLyvZf7VVNfEIh4zzjx1qyKkLA8l00kF50uwjxtC1JrZrmxU2bnWr9ij8mmVe9bFd+jUGH0Y
        KQ2IqctQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qec0Q-002YU2-2z;
        Fri, 08 Sep 2023 13:58:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0E0F0300472; Fri,  8 Sep 2023 15:58:44 +0200 (CEST)
Date:   Fri, 8 Sep 2023 15:58:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [RFC PATCH 0/7] sched: cpufreq: Remove magic margins
Message-ID: <20230908135843.GC24372@noisy.programming.kicks-ass.net>
References: <20230827233203.1315953-1-qyousef@layalina.io>
 <20230907130805.GE10955@noisy.programming.kicks-ass.net>
 <20230908001725.mtqbse3xwhzvo5qp@airbuntu>
 <20230908102511.GA24372@noisy.programming.kicks-ass.net>
 <20230908133336.uge4hcnx4cum3lg5@airbuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908133336.uge4hcnx4cum3lg5@airbuntu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 02:33:36PM +0100, Qais Yousef wrote:

> > > UTIL_EST_FASTER moves in one direction. And it's a constant response too, no?
> > 
> > The idea of UTIL_EST_FASTER was that we run a PELT sum on the current
> > activation runtime, all runtime since wakeup and take the max of this
> > extra sum and the regular thing.
> > 
> > On top of that this extra PELT sum can/has a time multiplier and thus
> > ramps up faster (this multiplies could be per task). Nb.:
> > 
> > 	util_est_fast = faster_est_approx(delta * 2);
> > 
> > is a state-less expression -- by making
> > 
> > 	util_est_fast = faster_est_approx(delta * curr->se.faster_mult);
> > 
> > only the current task is affected.
> 
> Okay; maybe I didn't understand this fully and will go back and study it more.
> 
> Maybe the word faster is what makes me worried as I really see faster is not
> what people want on a class of systems; or at least CPUs if you think of HMP.
> Taming the beast is a more difficult problem in this class of systems.

The faster refers to the ramp-up. Which was the issue identified in that
earlier thread. The game thing wanted to ramp up more agressive.
