Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A29797375
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240079AbjIGPYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236386AbjIGPXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:23:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DC0CC;
        Thu,  7 Sep 2023 08:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+IHqfq8QIvXbyDFuHCBfvC02F8uZgk5ZBVn+a1FzJbA=; b=kTeqwUCyZj90g9YXmVoDNp5lBh
        4XMHEhXWiEBXTBpskFUu7mNbCGQ+Et64o+4z6xxot8694zVDAwKxILWGab0FRCanudJh3yLFoPPEX
        R4eKf2hSHYI0B9CQzA+/sSAih3lMquFm6N7aO/oWYEiKPbTOsQ27bAYO37WOqoIhqHvOU6m3O6lgw
        QVIQWQlW97UYOOjTSOgAfDTU06f5YRFR1oG4X7qad1hY5HQSNOVaD6512pRNw8Fe0GhTmLKYcEzkL
        7ktTX6SAo82f/CDAFN5pV3Y80aJT4zFurNvO5YxoZSPXWoKlfaznp6mWzYMFe4KXgsRK9546Imgg5
        /yXX00Fg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qeDHh-00AYIp-Ml; Thu, 07 Sep 2023 11:34:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5ACD3300687; Thu,  7 Sep 2023 13:34:53 +0200 (CEST)
Date:   Thu, 7 Sep 2023 13:34:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [RFC PATCH 4/7] sched: cpufreq: Remove magic 1.25 headroom from
 apply_dvfs_headroom()
Message-ID: <20230907113453.GB10955@noisy.programming.kicks-ass.net>
References: <20230827233203.1315953-1-qyousef@layalina.io>
 <20230827233203.1315953-5-qyousef@layalina.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230827233203.1315953-5-qyousef@layalina.io>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 12:32:00AM +0100, Qais Yousef wrote:
> Instead of the magical 1.25 headroom, use the new approximate_util_avg()
> to provide headroom based on the dvfs_update_delay; which is the period
> at which the cpufreq governor will send DVFS updates to the hardware.
> 
> Add a new percpu dvfs_update_delay that can be cheaply accessed whenever
> apply_dvfs_headroom() is called. We expect cpufreq governors that rely
> on util to drive its DVFS logic/algorithm to populate these percpu
> variables. schedutil is the only such governor at the moment.
> 
> Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> ---
>  kernel/sched/core.c              |  3 ++-
>  kernel/sched/cpufreq_schedutil.c | 10 +++++++++-
>  kernel/sched/sched.h             | 25 ++++++++++++++-----------
>  3 files changed, 25 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 602e369753a3..f56eb44745a8 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -116,6 +116,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_se_tp);
>  EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_tp);
>  
>  DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
> +DEFINE_PER_CPU_SHARED_ALIGNED(u64, dvfs_update_delay);

This makes no sense, why are you using SHARED_ALIGNED and thus wasting
an entire cacheline for the one variable?
