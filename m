Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92BAB75652F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjGQNiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 09:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbjGQNh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:37:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996658F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 06:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=533J8q09bdBVgsSwgi5fjA/3C2Ga+QfLswMcOtH+Swk=; b=mjiuohBcL19EX4pyeKTYv2DSgT
        zZMpUgEltG9nwunrNMkKpw1yvMFX3pMpLy/2/o6AKYNfMq9hTTvbAYxjjTFGJXsiBog3nRpdQNt7Z
        FSAHmnkyZtnIEI71h5yG0r89OHRYLQNpphbpD3qlmccWlln8yjzgIsOU5JuhpE6wR8gk/owbkvBla
        +LRUSsSbNu4+UUJQGlC3RK6ufIqwY0yl9U+6JBPzKRdFHvqAIy9bpzJhgqOpvUVXjemfPHRdqFgFK
        RybXTt4g8o4ulAIEgNd+qBF4uc9gktjq7Dx5qvNwxTzISOpMNZH+uroEcQ4pjdr46oBgUXAxanxpE
        VJ4TUFcg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qLOPh-003x82-HK; Mon, 17 Jul 2023 13:37:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E6D1630019C;
        Mon, 17 Jul 2023 15:37:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C41AF24BB537A; Mon, 17 Jul 2023 15:37:18 +0200 (CEST)
Date:   Mon, 17 Jul 2023 15:37:18 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        naveen.n.rao@linux.vnet.ibm.com,
        Yicong Yang <yangyicong@hisilicon.com>,
        Barry Song <v-songbaohua@oppo.com>,
        Chen Yu <yu.c.chen@intel.com>, Hillf Danton <hdanton@sina.com>
Subject: Re: [Patch v3 1/6] sched/fair: Determine active load balance for SMT
 sched groups
Message-ID: <20230717133718.GJ4253@hirez.programming.kicks-ass.net>
References: <cover.1688770494.git.tim.c.chen@linux.intel.com>
 <e24f35d142308790f69be65930b82794ef6658a2.1688770494.git.tim.c.chen@linux.intel.com>
 <165778ce-7b8f-1966-af02-90ef481455b9@linux.vnet.ibm.com>
 <a399af19aa8e1291558724509a1de2f52b3bad0a.camel@linux.intel.com>
 <05ed4537-e79b-0ff3-5be5-92cbffaab3ee@linux.vnet.ibm.com>
 <20230717111053.GI4253@hirez.programming.kicks-ass.net>
 <eba3aa23-99ca-ce72-4933-940b8dd6ff6b@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eba3aa23-99ca-ce72-4933-940b8dd6ff6b@linux.vnet.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 05:48:02PM +0530, Shrikanth Hegde wrote:

> Hi Peter. 
> 
> Sending on behalf of tim. I have included my suggestion as well. Hope
> that's ok.  Please find below the patch as of now. it includes the
> couple of changes that are discussed. (in 1/6 and in 3/6)

Could you please add a Changelog and SoB thingies such that I can apply
the thing?

Given Tim is on holidays, perhaps do something like:

Originally-by: Tim Chen <...>

After all, you did some changes and verified it actually works etc..


> ---
>  kernel/sched/fair.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 932e7b78894a..9502013abe33 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9532,7 +9532,7 @@ static inline long sibling_imbalance(struct lb_env *env,
>  	imbalance /= ncores_local + ncores_busiest;
>  
>  	/* Take advantage of resource in an empty sched group */
> -	if (imbalance == 0 && local->sum_nr_running == 0 &&
> +	if (imbalance <= 1 && local->sum_nr_running == 0 &&
>  	    busiest->sum_nr_running > 1)
>  		imbalance = 2;
>  
> @@ -9720,6 +9720,17 @@ static bool update_sd_pick_busiest(struct lb_env *env,
>  		break;
>  
>  	case group_smt_balance:
> +		/* no idle cpus on both groups handled by group_fully_busy below */
> +		if (sgs->idle_cpus != 0 || busiest->idle_cpus != 0) {
> +			if (sgs->idle_cpus > busiest->idle_cpus)
> +				return false;
> +			if (sgs->idle_cpus < busiest->idle_cpus)
> +				return true;
> +			if (sgs->sum_nr_running <= busiest->sum_nr_running)
> +				return false;
> +		}
> +		break;
> +
>  	case group_fully_busy:
>  		/*
>  		 * Select the fully busy group with highest avg_load. In
> -- 
> 2.31.1
