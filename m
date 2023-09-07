Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7BB797370
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234297AbjIGPYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbjIGPXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:23:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACB6CE7;
        Thu,  7 Sep 2023 08:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iiuy4XAI5CxK/vACt9pDVDtdvIP/HPrNPXDG5x9xeng=; b=CC1MuhmrBtrnrenenBL0ZH9u6D
        1Ty74BT6Y7l69I4O/G4MHkg23FhRrpDf2vWbEVC2OA6h+MZ2IblEVKE+lTqHrPz3wwCbyOUCEmY3a
        sWVS77OUOcER6Jqq63ZHg4IAcGysk7mZNE6k0ocwHCCWPlfUUgf39hGMiwz30cybI5GVWqa3zF6L+
        k4CJda7D8LNcN03l4e93Z2FYnbdzk7TI7FjHexML06hEI4prnvDV4e6Ah12GX5nhZRp57imc10RvI
        gS7Gk3g0thNNds9Cef0qY5GIjwBy562cBadSRj3SrgSscrZr7WRCwn2dXwBvDTnh4J300/px59Qqo
        CUFq+Y2g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qeG0Z-00BRxi-Rb; Thu, 07 Sep 2023 14:29:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7EEA3300687; Thu,  7 Sep 2023 16:29:23 +0200 (CEST)
Date:   Thu, 7 Sep 2023 16:29:23 +0200
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
Message-ID: <20230907142923.GJ10955@noisy.programming.kicks-ass.net>
References: <20230827233203.1315953-1-qyousef@layalina.io>
 <a6365f63-4669-15e5-b843-f4bfb1bd5e68@arm.com>
 <20230906211850.zyvk6qtt6fvpxaf3@airbuntu>
 <20230907132631.GF10955@noisy.programming.kicks-ass.net>
 <8919ed14-8d19-d964-2278-3303a5bda8ee@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8919ed14-8d19-d964-2278-3303a5bda8ee@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 02:57:26PM +0100, Lukasz Luba wrote:
> 
> 
> On 9/7/23 14:26, Peter Zijlstra wrote:
> > On Wed, Sep 06, 2023 at 10:18:50PM +0100, Qais Yousef wrote:
> > 
> > > This is probably controversial statement. But I am not in favour of util_est.
> > > I need to collect the data, but I think we're better with 16ms PELT HALFLIFE as
> > > default instead. But I will need to do a separate investigation on that.
> > 
> > I think util_est makes perfect sense, where PELT has to fundamentally
> > decay non-running / non-runnable tasks in order to provide a temporal
> > average, DVFS might be best served with a termporal max filter.
> > 
> > 
> 
> Since we are here...
> Would you allow to have a configuration for
> the util_est shifter: UTIL_EST_WEIGHT_SHIFT ?
> 
> I've found other values than '2' better in some scenarios. That helps
> to prevent a big task to 'down' migrate from a Big CPU (1024) to some
> Mid CPU (~500-700 capacity) or even Little (~120-300).

Larger values, I'm thinking you're after? Those would cause the new
contribution to weight less, making the function more smooth, right?

What task characteristic is tied to this? That is, this seems trivial to
modify per-task.
