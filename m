Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC2D792B20
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241275AbjIEQs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354322AbjIEKmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 06:42:08 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219F1199
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 03:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=W/Sh0lasrP8w91s8Mf/Ik7lT0sbtln1VXgSdRBtU1ks=; b=NVAwzSREIQ7moOcvyoFbxLliPj
        USFMA2/zGLS/ZXU4g8o14WWR+GfpB2gfjW+OIAIVbyLNNzHSW2e8S0+ftHJbgttylfSi3EhEwKnHA
        NJWnEb47iOh107bePh6+D+i87gmr1NcwM6yCBFbJlKIUIqGPxUNjak7SW5TBCWDg8W+z+RJQBRzTc
        klImuhe1XarUNQzs+mlQirmxLSFZ9efqISQOZN7xqMz0VbB34PFDbwgoXiFd0N8vUFvmaU8X6UEfG
        /WhLANEsylX3LHHwR9AKnE2eK+rayFqqjdg1BJ7skiUUSoHoCoaAGth/+gGbmiyQpgvbQ50Dz1NlQ
        Z3RJ3V5Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qdTV1-0001Pg-0z;
        Tue, 05 Sep 2023 10:41:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6A05D300687; Tue,  5 Sep 2023 12:41:36 +0200 (CEST)
Date:   Tue, 5 Sep 2023 12:41:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>, bristot@redhat.com,
        bsegall@google.com, dietmar.eggemann@arm.com, hdanton@sina.com,
        ionela.voinescu@arm.com, juri.lelli@redhat.com,
        len.brown@intel.com, linux-kernel@vger.kernel.org, mgorman@suse.de,
        naveen.n.rao@linux.vnet.ibm.com, rafael.j.wysocki@intel.com,
        ravi.v.shankar@intel.com, ricardo.neri@intel.com,
        rostedt@goodmis.org, srikar@linux.vnet.ibm.com,
        srinivas.pandruvada@linux.intel.com, v-songbaohua@oppo.com,
        vincent.guittot@linaro.org, vschneid@redhat.com, x86@kernel.org,
        yangyicong@hisilicon.com, yu.c.chen@intel.com
Subject: Re: [PATCH] sched/fair: Add SMT4 group_smt_balance handling
Message-ID: <20230905104136.GC28319@noisy.programming.kicks-ass.net>
References: <20230717133718.GJ4253@hirez.programming.kicks-ass.net>
 <20230717145823.1531759-1-sshegde@linux.vnet.ibm.com>
 <804548a12363479d41dee19bb843002d9e105afd.camel@linux.intel.com>
 <6b20e0c0cd82d0d1aafc2a7fb14d9456e19c2c85.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b20e0c0cd82d0d1aafc2a7fb14d9456e19c2c85.camel@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 06:32:44AM -0700, Tim Chen wrote:

>  kernel/sched/fair.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a87988327f88..566686c5f2bd 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9563,7 +9563,7 @@ static inline long sibling_imbalance(struct lb_env *env,
>  	imbalance /= ncores_local + ncores_busiest;
>  
>  	/* Take advantage of resource in an empty sched group */
> -	if (imbalance == 0 && local->sum_nr_running == 0 &&
> +	if (imbalance <= 1 && local->sum_nr_running == 0 &&
>  	    busiest->sum_nr_running > 1)
>  		imbalance = 2;
>  
> @@ -9751,6 +9751,20 @@ static bool update_sd_pick_busiest(struct lb_env *env,
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
> +			else
> +				return true;
> +		}
> +		goto fully_busy;
> +		break;

This is really daft; why can't this simply be: fallthrough; ? At the
very least that break must go.

> +
>  	case group_fully_busy:
>  		/*
>  		 * Select the fully busy group with highest avg_load. In
> @@ -9763,7 +9777,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
>  		 * select the 1st one, except if @sg is composed of SMT
>  		 * siblings.
>  		 */
> -
> +fully_busy:
>  		if (sgs->avg_load < busiest->avg_load)
>  			return false;
>  
> -- 
> 2.32.0
> 
> 
