Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 981DF7973F6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344629AbjIGPdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344004AbjIGPcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:32:13 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140D01FDE;
        Thu,  7 Sep 2023 08:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SJPILCabtzPOmn/vTtUAzt4xxDqr2K6S5moya2vKXFc=; b=M5Md0zitEkbRpUQMRmi0eh00Qv
        7T+cvtivl2P84nn/h8L/APTva0274xldIcRDx4C0Ol8ZbN/xp7nKr2YN5B7IKdUKZ9p3sv33XWpaj
        P/qg6CT5ArDW4xcAWrkw85DDpDXzgNjAiSbSVvyDT8qV/kPEKNyYQDpv9UIMdpFp7uEkMd930dLZn
        mzyVrHJaoYWLyZU7gantVtqG64lScf2yjq1CVcJv5ma7f7wYvOzKENyFuHaa/qtn6DFyho1KrEE/t
        RldIRW0EWiAWLcFuFsgXyINqSRs3KuWiElIVtSgMxKq3jW/UNgjDBNePmWYCSnC9BVxbKEl617hcj
        S7yAUaAg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qeFDT-001oun-33;
        Thu, 07 Sep 2023 13:38:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0DCDB300687; Thu,  7 Sep 2023 15:38:41 +0200 (CEST)
Date:   Thu, 7 Sep 2023 15:38:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Qais Yousef <qyousef@layalina.io>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, bristot@redhat.com,
        juri.lelli@redhat.com
Subject: Re: [RFC PATCH 0/7] sched: cpufreq: Remove magic margins
Message-ID: <20230907133840.GH10955@noisy.programming.kicks-ass.net>
References: <20230827233203.1315953-1-qyousef@layalina.io>
 <a6365f63-4669-15e5-b843-f4bfb1bd5e68@arm.com>
 <20230906211850.zyvk6qtt6fvpxaf3@airbuntu>
 <6011d8bb-9a3b-1435-30b0-d75b39bf5efa@arm.com>
 <20230907115307.GD10955@noisy.programming.kicks-ass.net>
 <89067f71-9b83-e647-053e-07f7d55b6529@arm.com>
 <20230907132906.GG10955@noisy.programming.kicks-ass.net>
 <5616e50d-b827-4547-5b16-9131ace98419@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5616e50d-b827-4547-5b16-9131ace98419@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 02:33:49PM +0100, Lukasz Luba wrote:
> 
> 
> On 9/7/23 14:29, Peter Zijlstra wrote:
> > On Thu, Sep 07, 2023 at 02:06:15PM +0100, Lukasz Luba wrote:
> > 
> > > > Many extentions to the periodic task model are possible, including
> > > > things like average runtime with bursts etc.. all have their trade-offs.
> > > 
> > > Was that maybe proposed somewhere on LKML (the other models)?
> > 
> > RT literatur mostly methinks. Replacing WCET with a statistical model of
> > sorts is not uncommon, the argument goes that not everybody will have
> > their worst case at the same time and lows and highs can commonly cancel
> > out and this way we can cram a little more on the system.
> > 
> > Typically this is proposed in the context of soft-realtime systems.
> 
> Thanks Peter, I will dive into some books...

I would look at academic papers, not sure any of that ever made it to
books, Daniel would know I suppose.
