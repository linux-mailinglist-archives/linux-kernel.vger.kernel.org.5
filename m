Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719637C505D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 12:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345992AbjJKKjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 06:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjJKKjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 06:39:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF87C0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 03:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697020761; x=1728556761;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=gXkJ9Rz4wh3rd3Sz4VQwFqIASu0MtsnAvP+47lbpfF8=;
  b=Q7fKpUdVVrFlNq/KXY2A1byxTeFvthpw12Wckr2txiLoYo1N/LZPr0VT
   RqZsAJmBvDg3bCAwctQKELuWYRCq2TOxbeMaEqebhmtSZM8gxHEs2Prac
   2Dg/t+dZyDv5EyGwycJU1jnIf4lbkcmLjwrp3ours44rYeJZQcKXqXlfv
   8J2fuMspX//VZPRTrTKfcjQ1dirFd6dvjGnHnFEyE+U/hSIhscYvXIJq3
   Ppa2r27pyMaI/fOlm5AtIitDIwZq3HY7GRgt5+aSai4AOZ6vguab8pwmy
   aO3hkrDCYb54x8HtwyIIwNQLjx0nwseG20z8EmT8qRbROSjZD5EBu9U3A
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="451121937"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="451121937"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 03:39:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="1001058836"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="1001058836"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 03:39:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qqWcT-00000004b1I-0Ivx;
        Wed, 11 Oct 2023 13:39:13 +0300
Date:   Wed, 11 Oct 2023 13:39:12 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ankit Jain <ankitja@vmware.com>
Cc:     peterz@infradead.org, yury.norov@gmail.com,
        linux@rasmusvillemoes.dk, qyousef@layalina.io, pjt@google.com,
        joshdon@google.com, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, namit@vmware.com,
        amakhalov@vmware.com, srinidhir@vmware.com, vsirnapalli@vmware.com,
        vbrahmajosyula@vmware.com, akaher@vmware.com,
        srivatsa@csail.mit.edu
Subject: Re: [PATCH RFC] cpumask: Randomly distribute the tasks within
 affinity mask
Message-ID: <ZSZ7UOBupdHHB24h@smile.fi.intel.com>
References: <20231011071925.761590-1-ankitja@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231011071925.761590-1-ankitja@vmware.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 12:49:25PM +0530, Ankit Jain wrote:
> commit 46a87b3851f0 ("sched/core: Distribute tasks within affinity masks")
> and commit 14e292f8d453 ("sched,rt: Use cpumask_any*_distribute()")
> introduced the logic to distribute the tasks at initial wakeup on cpus
> where load balancing works poorly or disabled at all (isolated cpus).
> 
> There are cases in which the distribution of tasks
> that are spawned on isolcpus does not happen properly.
> In production deployment, initial wakeup of tasks spawn from
> housekeeping cpus to isolcpus[nohz_full cpu] happens on first cpu
> within isolcpus range instead of distributed across isolcpus.
> 
> Usage of distribute_cpu_mask_prev from one processes group,
> will clobber previous value of another or other groups and vice-versa.
> 
> When housekeeping cpus spawn multiple child tasks to wakeup on
> isolcpus[nohz_full cpu], using cpusets.cpus/sched_setaffinity(),
> distribution is currently performed based on per-cpu
> distribute_cpu_mask_prev counter.
> At the same time, on housekeeping cpus there are percpu
> bounded timers interrupt/rcu threads and other system/user tasks
> would be running with affinity as housekeeping cpus. In a real-life
> environment, housekeeping cpus are much fewer and are too much loaded.
> So, distribute_cpu_mask_prev value from these tasks impacts
> the offset value for the tasks spawning to wakeup on isolcpus and
> thus most of the tasks end up waking up on first cpu within the
> isolcpus set.
> 
> Steps to reproduce:
> Kernel cmdline parameters:
> isolcpus=2-5 skew_tick=1 nohz=on nohz_full=2-5
> rcu_nocbs=2-5 rcu_nocb_poll idle=poll irqaffinity=0-1
> 
> * pid=$(echo $$)
> * taskset -pc 0 $pid
> * cat loop-normal.c
> int main(void)
> {
>         while (1)
>                 ;
>         return 0;
> }
> * gcc -o loop-normal loop-normal.c
> * for i in {1..50}; do ./loop-normal & done
> * pids=$(ps -a | grep loop-normal | cut -d' ' -f5)
> * for i in $pids; do taskset -pc 2-5 $i ; done
> 
> Expected output:
> * All 50 “loop-normal” tasks should wake up on cpu2-5
> equally distributed.
> * ps -eLo cpuid,pid,tid,ppid,cls,psr,cls,cmd | grep "^    [2345]"
> 
> Actual output:
> * All 50 “loop-normal” tasks got woken up on cpu2 only
> 
> Analysis:
> There are percpu bounded timer interrupt/rcu threads activities
> going on every few microseconds on housekeeping cpus, exercising
> find_lowest_rq() -> cpumask_any_and_distribute()/cpumask_any_distribute()
> So, per cpu variable distribute_cpu_mask_prev for housekeeping cpus
> keep on getting set to housekeeping cpus. Bash/docker processes
> are sharing same per cpu variable as they run on housekeeping cpus.
> Thus intersection of clobbered distribute_cpu_mask_prev and
> new mask(isolcpus) return always first cpu within the new mask(isolcpus)
> in accordance to the logic mentioned in commits above.
> 
> Fix the issue by using random cores out of the applicable CPU set
> instead of relying on distribute_cpu_mask_prev.

> Fixes: 46a87b3851f0 ("sched/core: Distribute tasks within affinity masks")
> Fixes: 14e292f8d453 ("sched,rt: Use cpumask_any*_distribute()")

> 

Blank lines are not allowed in the tag block.

> Signed-off-by: Ankit Jain <ankitja@vmware.com>

...

> +/**
> + * Returns an arbitrary cpu within srcp.
> + *
> + * Iterated calls using the same srcp will be randomly distributed
> + */

This is invalid. Always run

	scripts/kernel-doc -v -none -Wall ...

against the file of interest and fix all warnings and errors reported.

-- 
With Best Regards,
Andy Shevchenko


