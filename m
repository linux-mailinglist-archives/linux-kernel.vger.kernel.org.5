Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4075079CFB4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbjILLUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjILLUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:20:36 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F6698
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 04:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=foRD+PUHK/sFHRd5hqwTBLZP7RJECaKCYr11zKYh2CQ=; b=PNYvg/sIhnpbgW0xo2RFfIV9ky
        xdEeRvuyOgufQpYAfl2NAnBZgEJhDgSzsHqlb8jRHy1vXjaf5avs6xGCe92AIu8cmDbMG39cByjk8
        4RiRD/jUn0vVMqMh0BUQg+OHlO92/K9SfzpEh8F7uu6n1z2fcXzuDqcXtPrQfcp+oEKz7EpHKb69K
        Iam0AWSIxTsgHPv+UZSPtYBm07Ih0vVImzflQ7gNEZy47Vxmb3JhNLoGqAJFj+DU699WT2k3GljIK
        iK+PbgwTy4Ynoc25d0Y7nYj+LBQTg6tkAr01xjKK3d2eX9KwDuBizlNjOg+Tsief/tk0rGnQoYwt7
        3Aiic1EA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qg1RG-0063it-0n;
        Tue, 12 Sep 2023 11:20:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 599B1300348; Tue, 12 Sep 2023 13:20:15 +0200 (CEST)
Date:   Tue, 12 Sep 2023 13:20:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        David Vernet <void@manifault.com>,
        Nitin Tekchandani <nitin.tekchandani@intel.com>,
        Yu Chen <yu.c.chen@intel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Swapnil Sapkal <Swapnil.Sapkal@amd.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] sched/fair: ratelimit update to tg->load_avg
Message-ID: <20230912112015.GB12405@noisy.programming.kicks-ass.net>
References: <20230912065808.2530-1-aaron.lu@intel.com>
 <20230912065808.2530-2-aaron.lu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912065808.2530-2-aaron.lu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 02:58:08PM +0800, Aaron Lu wrote:
> When using sysbench to benchmark Postgres in a single docker instance
> with sysbench's nr_threads set to nr_cpu, it is observed there are times
> update_cfs_group() and update_load_avg() shows noticeable overhead on
> a 2sockets/112core/224cpu Intel Sapphire Rapids(SPR):
> 
>     13.75%    13.74%  [kernel.vmlinux]           [k] update_cfs_group
>     10.63%    10.04%  [kernel.vmlinux]           [k] update_load_avg
> 
> Annotate shows the cycles are mostly spent on accessing tg->load_avg
> with update_load_avg() being the write side and update_cfs_group() being
> the read side. tg->load_avg is per task group and when different tasks
> of the same taskgroup running on different CPUs frequently access
> tg->load_avg, it can be heavily contended.
> 
> E.g. when running postgres_sysbench on a 2sockets/112cores/224cpus Intel
> Sappire Rapids, during a 5s window, the wakeup number is 14millions and
> migration number is 11millions and with each migration, the task's load
> will transfer from src cfs_rq to target cfs_rq and each change involves
> an update to tg->load_avg. Since the workload can trigger as many wakeups
> and migrations, the access(both read and write) to tg->load_avg can be
> unbound. As a result, the two mentioned functions showed noticeable
> overhead. With netperf/nr_client=nr_cpu/UDP_RR, the problem is worse:
> during a 5s window, wakeup number is 21millions and migration number is
> 14millions; update_cfs_group() costs ~25% and update_load_avg() costs ~16%.
> 
> Reduce the overhead by limiting updates to tg->load_avg to at most once
> per ms. The update frequency is a tradeoff between tracking accuracy and
> overhead. 1ms is chosen because PELT window is roughly 1ms and it
> delivered good results for the tests that I've done. After this change,
> the cost of accessing tg->load_avg is greatly reduced and performance
> improved. Detailed test results below.
> 

> 
> Reported-by: Nitin Tekchandani <nitin.tekchandani@intel.com>
> Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Tested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Reviewed-by: David Vernet <void@manifault.com>
> Tested-by: Swapnil Sapkal <Swapnil.Sapkal@amd.com>

Thanks!
