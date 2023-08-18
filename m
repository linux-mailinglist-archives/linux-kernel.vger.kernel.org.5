Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839E778060B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 09:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358107AbjHRG7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 02:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239325AbjHRG7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 02:59:24 -0400
Received: from out-46.mta0.migadu.com (out-46.mta0.migadu.com [91.218.175.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C268F2D72
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 23:59:21 -0700 (PDT)
Message-ID: <a60de9ff-6dad-f243-6bd0-56810ef57c85@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692341959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CmMGnP7L7bn/5ssBCNCkB8ryZejZU4L6IU8tNWtA8SU=;
        b=qk7w6tviAs5Oa5HG9F4Y1FXDH7P1BeQVk9ddJEzlTyeN+JDa1EwWL6exFVAaxqWOeEyiL3
        GJ+u9sm8V8Dpgi/mdD8dxbYG7FJgVJ/zF4fKPIUM6n3WcMmO5IRODTQA5Djyp4EDiw4VCq
        V+e5XLxhAaI+92zrhup++X+05QLElEM=
Date:   Fri, 18 Aug 2023 14:59:13 +0800
MIME-Version: 1.0
Subject: Re: [PATCH V2] lib/group_cpus.c: avoid to acquire cpu hotplug lock in
 group_cpus_evenly
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Yi Zhang <yi.zhang@redhat.com>,
        Guangwu Zhang <guazhang@redhat.com>
References: <20230818015244.1176929-1-ming.lei@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20230818015244.1176929-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023/8/18 09:52, Ming Lei wrote:
> group_cpus_evenly() could be part of storage driver's error handler,
> such as nvme driver, when may happen during CPU hotplug, in which
> storage queue has to drain its pending IOs because all CPUs associated
> with the queue are offline and the queue is becoming inactive. And
> handling IO needs error handler to provide forward progress.
> 
> Then dead lock is caused:
> 
> 1) inside CPU hotplug handler, CPU hotplug lock is held, and blk-mq's
> handler is waiting for inflight IO
> 
> 2) error handler is waiting for CPU hotplug lock
> 
> 3) inflight IO can't be completed in blk-mq's CPU hotplug handler because
> error handling can't provide forward progress.
> 
> Solve the deadlock by not holding CPU hotplug lock in group_cpus_evenly(),
> in which two stage spreads are taken: 1) the 1st stage is over all present
> CPUs; 2) the end stage is over all other CPUs.
> 
> Turns out the two stage spread just needs consistent 'cpu_present_mask', and
> remove the CPU hotplug lock by storing it into one local cache. This way
> doesn't change correctness, because all CPUs are still covered.
> 
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: linux-nvme@lists.infradead.org
> Cc: linux-block@vger.kernel.org
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Reported-by: Guangwu Zhang <guazhang@redhat.com>
> Tested-by: Guangwu Zhang <guazhang@redhat.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> V2:
> 	- fix "Cc: block list"
> 	- add tested-by tag
> 
>  lib/group_cpus.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/lib/group_cpus.c b/lib/group_cpus.c
> index aa3f6815bb12..15006e79196f 100644
> --- a/lib/group_cpus.c
> +++ b/lib/group_cpus.c
> @@ -348,6 +348,7 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
>  {
>  	unsigned int curgrp = 0, nr_present = 0, nr_others = 0;
>  	cpumask_var_t *node_to_cpumask;
> +	cpumask_var_t local_cpu_present_mask;
>  	cpumask_var_t nmsk, npresmsk;
>  	int ret = -ENOMEM;
>  	struct cpumask *masks = NULL;
> @@ -355,6 +356,16 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
>  	if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
>  		return NULL;
>  
> +	if (!zalloc_cpumask_var(&local_cpu_present_mask, GFP_KERNEL))
> +		goto fail_local_pres_mask;
> +
> +	/*
> +	 * Make a local cache of 'cpu_present_mask', so the two stages
> +	 * spread can observe consistent 'cpu_present_mask' without holding
> +	 * cpu hotplug lock.
> +	 */
> +	cpumask_copy(local_cpu_present_mask, cpu_present_mask);
> +

Maybe we can reuse npresmsk instead of allocating another cpumask?
In the first stage: npresmsk = cpu_present_mask
In the second stage: npresmsk = cpu_possible_mask & ~npresmsk

>  	if (!zalloc_cpumask_var(&npresmsk, GFP_KERNEL))
>  		goto fail_nmsk;
>  
> @@ -366,13 +377,11 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
>  	if (!masks)
>  		goto fail_node_to_cpumask;
>  
> -	/* Stabilize the cpumasks */
> -	cpus_read_lock();
>  	build_node_to_cpumask(node_to_cpumask);
>  
>  	/* grouping present CPUs first */
>  	ret = __group_cpus_evenly(curgrp, numgrps, node_to_cpumask,
> -				  cpu_present_mask, nmsk, masks);
> +				  local_cpu_present_mask, nmsk, masks);
>  	if (ret < 0)
>  		goto fail_build_affinity;
>  	nr_present = ret;
> @@ -387,15 +396,13 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
>  		curgrp = 0;
>  	else
>  		curgrp = nr_present;
> -	cpumask_andnot(npresmsk, cpu_possible_mask, cpu_present_mask);
> +	cpumask_andnot(npresmsk, cpu_possible_mask, local_cpu_present_mask);
>  	ret = __group_cpus_evenly(curgrp, numgrps, node_to_cpumask,
>  				  npresmsk, nmsk, masks);
>  	if (ret >= 0)
>  		nr_others = ret;
>  
>   fail_build_affinity:
> -	cpus_read_unlock();
> -
>  	if (ret >= 0)
>  		WARN_ON(nr_present + nr_others < numgrps);

This fail_build_affinity tag seems unneeded anymore.

The patch looks good to me:

Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>

Thanks.

>  
> @@ -406,6 +413,9 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
>  	free_cpumask_var(npresmsk);
>  
>   fail_nmsk:
> +	free_cpumask_var(local_cpu_present_mask);
> +
> + fail_local_pres_mask:
>  	free_cpumask_var(nmsk);
>  	if (ret < 0) {
>  		kfree(masks);

