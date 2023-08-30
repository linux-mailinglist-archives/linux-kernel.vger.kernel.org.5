Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182FB78D1D7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 03:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241642AbjH3Bvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 21:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241634AbjH3BvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 21:51:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A15194
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 18:51:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6617461DCF
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 01:51:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 646B3C433C8;
        Wed, 30 Aug 2023 01:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693360273;
        bh=DWBYA7oCvZki07DkGCjwenj2DTnQDU4zQfO0NImpIIo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J9ujTFhFF4k1ZIMon55gd/JhFNw2FJ9/KoCG5ojGgf5lADVaQLCCPZPgQ31fvsLjB
         8eq9CpsL3ulISyFjf1W9BNluqlv165RKtB7SZeBvMYzRiichmuPwe7S567G4mv4r8Q
         4/G0Bwtr7W6UfJDzzgobdO+a8zT29CsLy6J4NgdI6XxYZyj+d9j7V6SO5T00TH7ggS
         O1nX4EAdVY7juvxBBLUU3IOBdxhXqpGFVt3OW6Rad5qcJwb+mmV4S+oVV/mwkbHlJp
         V/CCOk9iRruU5OvgMvXRd1yQ5etrNWdi8pswZTrAZQAlC36oNUup7/hCRkjXIQcJJx
         aKe6gcZCrklFg==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     damon@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm/damon/core: use number of passed access sampling as a timer
Date:   Wed, 30 Aug 2023 01:51:10 +0000
Message-Id: <20230830015110.46420-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230827003727.49369-1-sj@kernel.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Aug 2023 00:37:27 +0000 SeongJae Park <sj@kernel.org> wrote:

> DAMON sleeps for sampling interval after each sampling, and check if
> it's time for further doing aggregation and ops updating using
> ktime_get_coarse_ts64() and baseline timestamps for the two periodic
> operations.  That's for making the operations occur at deterministic
> timing.  However, it turned out it could still result in indeterministic
> and even not-that-intuitive results.
> 
> After all, timer functions, and especially sleep functions that DAMON
> uses to wait for specific timing, could contain some errors.  Those
> errors are legal, so no problem.  However, depending on such legal
> timing errors, the nr_accesses can be larger than aggregation interval
> divided by sampling interval.  For example, with the default setting (5
> ms sampling interval and 100 ms aggregation interval) we frequently show
> regions having nr_accesses larger than 20.  Also, if the execution of a
> DAMOS scheme takes a long time, next aggregation could happen before
> enough number of samples are collected.
> 
> Since access check sampling is the smallest unit work of DAMON, using
> the number of passed sampling intervals as the DAMON-internal timer can
> easily avoid these problems.  That is, convert aggregation and ops
> update intervals to numbers of sampling intervals that need to be passed
> before those operations be executed, count the number of passed sampling
> intervals, and invoke the operations as soon as the specific amount of
> sampling intervals passed.  Make the change.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  include/linux/damon.h | 14 ++++++--
>  mm/damon/core.c       | 84 +++++++++++++++++++------------------------
>  2 files changed, 48 insertions(+), 50 deletions(-)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index ab3089de1478..9a32b8fd0bd3 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -524,8 +524,18 @@ struct damon_ctx {
>  	struct damon_attrs attrs;
>  
>  /* private: internal use only */
> -	struct timespec64 last_aggregation;
> -	struct timespec64 last_ops_update;
> +	/* number of sample intervals that passed since this context started */
> +	unsigned long passed_sample_intervals;
> +	/*
> +	 * number of sample intervals that should be passed before next
> +	 * aggregation
> +	 */
> +	unsigned long next_aggregation_sis;
> +	/*
> +	 * number of sample intervals that should be passed before next ops
> +	 * update
> +	 */
> +	unsigned long next_ops_update_sis;
>  
>  /* public: */
>  	struct task_struct *kdamond;
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 988dc39e44b1..83af336bb0e6 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -456,8 +456,11 @@ struct damon_ctx *damon_new_ctx(void)
>  	ctx->attrs.aggr_interval = 100 * 1000;
>  	ctx->attrs.ops_update_interval = 60 * 1000 * 1000;
>  
> -	ktime_get_coarse_ts64(&ctx->last_aggregation);
> -	ctx->last_ops_update = ctx->last_aggregation;
> +	ctx->passed_sample_intervals = 0;
> +	ctx->next_aggregation_sis = ctx->attrs.aggr_interval /
> +		ctx->attrs.sample_interval;
> +	ctx->next_ops_update_sis = ctx->attrs.ops_update_interval /
> +		ctx->attrs.sample_interval;
>  
>  	mutex_init(&ctx->kdamond_lock);
>  
> @@ -577,6 +580,9 @@ static void damon_update_monitoring_results(struct damon_ctx *ctx,
>   */
>  int damon_set_attrs(struct damon_ctx *ctx, struct damon_attrs *attrs)
>  {
> +	unsigned long sample_interval;
> +	unsigned long remaining_interval_us;
> +
>  	if (attrs->min_nr_regions < 3)
>  		return -EINVAL;
>  	if (attrs->min_nr_regions > attrs->max_nr_regions)
> @@ -584,6 +590,20 @@ int damon_set_attrs(struct damon_ctx *ctx, struct damon_attrs *attrs)
>  	if (attrs->sample_interval > attrs->aggr_interval)
>  		return -EINVAL;
>  
> +	sample_interval = attrs->sample_interval ? attrs->sample_interval : 1;
> +
> +	/* adjust next_aggregation_sis */
> +	remaining_interval_us = ctx->attrs.sample_interval *
> +		(ctx->next_aggregation_sis - ctx->passed_sample_intervals);
> +	ctx->next_aggregation_sis = ctx->passed_sample_intervals +
> +		remaining_interval_us / sample_interval;
> +
> +	/* adjust next_ops_update_sis */
> +	remaining_interval_us = ctx->attrs.sample_interval *
> +		(ctx->next_ops_update_sis - ctx->passed_sample_intervals);
> +	ctx->next_ops_update_sis = ctx->passed_sample_intervals +
> +		remaining_interval_us / sample_interval;
> +
>  	damon_update_monitoring_results(ctx, attrs);
>  	ctx->attrs = *attrs;
>  	return 0;
> @@ -757,38 +777,6 @@ int damon_stop(struct damon_ctx **ctxs, int nr_ctxs)
>  	return err;
>  }

So, the new timer variables are initialized in damon_new_ctx() as the default
(5ms sampling interval, 100ms aggregation interval, and 1s ops update interval)
and adjusted in damon_set_attrs().  It means the first intervals will be the
default ones always.  I will make those initialized at the beginning of
kdamond_fn() from the next spin.

[...]
> @@ -1436,6 +1412,8 @@ static int kdamond_fn(void *data)
>  	sz_limit = damon_region_sz_limit(ctx);

As mentioned abovely, the timer variables will be initialized around here (at
the beggining of kdamond_fn(), before going into the loop), in the next spin.


Thanks,
SJ

>  
>  	while (!kdamond_need_stop(ctx)) {
> +		unsigned long sample_interval;
> +
>  		if (kdamond_wait_activation(ctx))
>  			break;
>  
> @@ -1446,11 +1424,17 @@ static int kdamond_fn(void *data)
>  			break;
>  
>  		kdamond_usleep(ctx->attrs.sample_interval);
> +		ctx->passed_sample_intervals++;
>  
>  		if (ctx->ops.check_accesses)
>  			max_nr_accesses = ctx->ops.check_accesses(ctx);
>  
> -		if (kdamond_aggregate_interval_passed(ctx)) {
> +		sample_interval = ctx->attrs.sample_interval ?
> +			ctx->attrs.sample_interval : 1;
> +		if (ctx->passed_sample_intervals ==
> +				ctx->next_aggregation_sis) {
> +			ctx->next_aggregation_sis +=
> +				ctx->attrs.aggr_interval / sample_interval;
>  			kdamond_merge_regions(ctx,
>  					max_nr_accesses / 10,
>  					sz_limit);
> @@ -1465,7 +1449,11 @@ static int kdamond_fn(void *data)
>  				ctx->ops.reset_aggregated(ctx);
>  		}
>  
> -		if (kdamond_need_update_operations(ctx)) {
> +		if (ctx->passed_sample_intervals ==
> +				ctx->next_ops_update_sis) {
> +			ctx->next_ops_update_sis +=
> +				ctx->attrs.ops_update_interval /
> +				sample_interval;
>  			if (ctx->ops.update)
>  				ctx->ops.update(ctx);
>  			sz_limit = damon_region_sz_limit(ctx);
> -- 
> 2.25.1
> 
> 
