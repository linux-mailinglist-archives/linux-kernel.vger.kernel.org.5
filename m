Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C73781311
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 20:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379500AbjHRSsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 14:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379489AbjHRSsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 14:48:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55633A98
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 11:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692384448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kof001mFn/ifBDFR+GMgOzOUbn9QJlpGG3ggxMuSCvk=;
        b=STSsh1IYi2/+RBK0eyLzviklmxQ5N0QeM4JmTIHHQjlzSqah8asyOxLCUthR+cknYDN9cX
        vNv3xwXQA67lNVeKz4EiO7HCfTkWmpfY9zn8KS7Ze4KRz5RYSF1M4lPhwZTkjHZCZ2G1fw
        t38gEuvpSVenvV3NaqLUID9gyJ4Fwi4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-562-Ta9-U0flNFiRtKdVF9gORw-1; Fri, 18 Aug 2023 14:47:22 -0400
X-MC-Unique: Ta9-U0flNFiRtKdVF9gORw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 410D58DC670;
        Fri, 18 Aug 2023 18:47:22 +0000 (UTC)
Received: from [10.22.32.157] (unknown [10.22.32.157])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5F8822166B2D;
        Fri, 18 Aug 2023 18:47:21 +0000 (UTC)
Message-ID: <fe1702b4-1b22-6293-11a2-2de82ff729a6@redhat.com>
Date:   Fri, 18 Aug 2023 14:47:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3] sched/core: Use empty mask to reset cpumasks in
 sched_setaffinity()
Content-Language: en-US
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>,
        Brent Rowsell <browsell@redhat.com>,
        Peter Hunt <pehunt@redhat.com>
References: <20230804023218.75544-1-longman@redhat.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230804023218.75544-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/23 22:32, Waiman Long wrote:
> Since commit 8f9ea86fdf99 ("sched: Always preserve the user requested
> cpumask"), user provided CPU affinity via sched_setaffinity(2) is
> perserved even if the task is being moved to a different cpuset. However,
> that affinity is also being inherited by any subsequently created child
> processes which may not want or be aware of that affinity.
>
> One way to solve this problem is to provide a way to back off from
> that user provided CPU affinity.  This patch implements such a scheme
> by using an empty cpumask to signal a reset of the cpumasks to the
> default as allowed by the current cpuset.
>
> Before this patch, passing in an empty cpumask to sched_setaffinity(2)
> will always return an -EINVAL error. With this patch, an alternative
> error of -ENODEV will be returned returned if sched_setaffinity(2)
> has been called before to set up user_cpus_ptr. In this case, the
> user_cpus_ptr that stores the user provided affinity will be cleared and
> the task's CPU affinity will be reset to that of the current cpuset. This
> alternative error code of -ENODEV signals that the no CPU is specified
> and, at the same time, a side effect of resetting cpu affinity to the
> cpuset default.
>
> If sched_setaffinity(2) has not been called previously, an EINVAL error
> will be returned with an empty cpumask just like before.  Tests or
> tools that rely on the behavior that an empty cpumask will return an
> error code will not be affected.
>
> We will have to update the sched_setaffinity(2) manpage to document
> this possible side effect of passing in an empty cpumask.
>
> Signed-off-by: Waiman Long <longman@redhat.com>

Ping.

Are there other concerns about this patch? I haven't seen any error 
report from kernel test robot so far.

Cheers,
Longman

> ---
>   kernel/sched/core.c | 42 +++++++++++++++++++++++++++++++++---------
>   1 file changed, 33 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index c52c2eba7c73..3ef7397f2a61 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8317,7 +8317,12 @@ __sched_setaffinity(struct task_struct *p, struct affinity_context *ctx)
>   	}
>   
>   	cpuset_cpus_allowed(p, cpus_allowed);
> -	cpumask_and(new_mask, ctx->new_mask, cpus_allowed);
> +
> +	/* Default to cpus_allowed with NULL new_mask */
> +	if (ctx->new_mask)
> +		cpumask_and(new_mask, ctx->new_mask, cpus_allowed);
> +	else
> +		cpumask_copy(new_mask, cpus_allowed);
>   
>   	ctx->new_mask = new_mask;
>   	ctx->flags |= SCA_CHECK;
> @@ -8366,6 +8371,7 @@ __sched_setaffinity(struct task_struct *p, struct affinity_context *ctx)
>   
>   long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
>   {
> +	bool reset_cpumasks = cpumask_empty(in_mask);
>   	struct affinity_context ac;
>   	struct cpumask *user_mask;
>   	struct task_struct *p;
> @@ -8403,15 +8409,26 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
>   		goto out_put_task;
>   
>   	/*
> -	 * With non-SMP configs, user_cpus_ptr/user_mask isn't used and
> -	 * alloc_user_cpus_ptr() returns NULL.
> +	 * If an empty cpumask is passed in and user_cpus_ptr is set,
> +	 * clear user_cpus_ptr and reset the current cpu affinity to the
> +	 * default for the current cpuset. If user_cpus_ptr isn't set,
> +	 * -EINVAL will be returned as before.
>   	 */
> -	user_mask = alloc_user_cpus_ptr(NUMA_NO_NODE);
> -	if (user_mask) {
> -		cpumask_copy(user_mask, in_mask);
> -	} else if (IS_ENABLED(CONFIG_SMP)) {
> -		retval = -ENOMEM;
> -		goto out_put_task;
> +	if (reset_cpumasks && p->user_cpus_ptr) {
> +		in_mask = NULL;	/* To be updated in __sched_setaffinity */
> +		user_mask = NULL;
> +	} else {
> +		/*
> +		 * With non-SMP configs, user_cpus_ptr/user_mask isn't used
> +		 * and alloc_user_cpus_ptr() returns NULL.
> +		 */
> +		user_mask = alloc_user_cpus_ptr(NUMA_NO_NODE);
> +		if (user_mask) {
> +			cpumask_copy(user_mask, in_mask);
> +		} else if (IS_ENABLED(CONFIG_SMP)) {
> +			retval = -ENOMEM;
> +			goto out_put_task;
> +		}
>   	}
>   
>   	ac = (struct affinity_context){
> @@ -8423,6 +8440,13 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
>   	retval = __sched_setaffinity(p, &ac);
>   	kfree(ac.user_mask);
>   
> +	/*
> +	 * Force an error return (-ENODEV), if no error yet, for the empty
> +	 * cpumask case to avoid breaking existing tests.
> +	 */
> +	if (reset_cpumasks && !retval)
> +		retval = -ENODEV;
> +
>   out_put_task:
>   	put_task_struct(p);
>   	return retval;

