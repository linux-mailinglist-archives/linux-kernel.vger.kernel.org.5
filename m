Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A7579A169
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 04:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjIKCfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 22:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjIKCfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 22:35:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D18C1728
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 19:35:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1BC2C433C8;
        Mon, 11 Sep 2023 02:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694399663;
        bh=k/G7cODyLQl2Sxk/QoPyb4F689V1kXiXFE6EkBvZ2yY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X2yNn9sqM4AXQModc75Aqk5wahhVKcu+LDjW4w8bYfKiOzAMG+6Jc8OrvJ+Y8QATy
         3LVdBg3Ns//aNEEdY/I8JmOklu+YLS15g0zIE5D/gojIV/Lz5A9lL/1v1ToWRZ4xp2
         8bhKn0jatOSavwyAC65UTEI9gVJRScYV5cQBsoFX6kkLIwQdMPyVa8kqTcsTJQqVAu
         YRWHqmYFjX+mTFc/xNFjbLIEb0TQmKLzwmPap0aNwdMxGrExx/ScXyWv0jjSFsD1kz
         jML8JHHWKpaE3+jPZunzjQkH8ND58vlhdV7fxGEIakDgx6TZiJj5heZv/pldEyut5T
         9wJPCZpJMncqw==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     damon@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v2] mm/damon/core: use number of passed access sampling as a timer
Date:   Mon, 11 Sep 2023 02:34:21 +0000
Message-Id: <20230911023421.2040-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230905035210.127868-1-sj@kernel.org>
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

On Tue, 5 Sep 2023 03:52:10 +0000 SeongJae Park <sj@kernel.org> wrote:

> Changes from v1
> (https://lore.kernel.org/damon/20230827003727.49369-1-sj@kernel.org/)
> - Initalize next_*_sis at the beginning of kdamond_fn()
> - Remove unnecessary remaining intervals compensations in
>   damon_set_attrs()
> 
> DAMON sleeps for sampling interval after each sampling, and check if the
> aggregation interval and the ops update interval have passed using
> ktime_get_coarse_ts64() and baseline timestamps for the intervals.  That
> design is for making the operations occur at deterministic timing
> regardless of the time that spend for each work.  However, it turned out
> it is not that useful, and incur not-that-intuitive results.
> 
> After all, timer functions, and especially sleep functions that DAMON
> uses to wait for specific timing, are not necessarily strictly accurate.
> It is legal design, so no problem.  However, depending on such
> inaccuracies, the nr_accesses can be larger than aggregation interval
> divided by sampling interval.  For example, with the default setting (5
> ms sampling interval and 100 ms aggregation interval) we frequently show
> regions having nr_accesses larger than 20.  Also, if the execution of a
> DAMOS scheme takes a long time, next aggregation could happen before
> enough number of samples are collected.  This is not what usual users
> would intuitively expect.
> 
> Since access check sampling is the smallest unit work of DAMON, using
> the number of passed sampling intervals as the DAMON-internal timer can
> easily avoid these problems.  That is, convert aggregation and ops
> update intervals to numbers of sampling intervals that need to be passed
> before those operations be executed, count the number of passed sampling
> intervals, and invoke the operations as soon as the specific amount of
> sampling intervals passed.  Make the change.
> 
> Note that this could make a behavioral change to settings that using
> intervals that not aligned by the sampling interval.  For example, if
> the sampling interval is 5 ms and the aggregation interval is 12 ms,
> DAMON effectively used 15 ms as its aggregation interval with the old
> design, hence it checks whether the aggregation interval after sleeping
> the sampling interval.  This change will make DAMON to effectively use
> 10 ms as aggregation interval, since it uses 'aggregation interval /
> sampling interval * sampling interval' as the effective aggregation
> interval, and we don't use floating point types.  Usual users would have
> used aligned intervals, so this behavioral change is not expected to
> make any meaningful impact, so just make this change.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  include/linux/damon.h | 14 ++++++-
>  mm/damon/core.c       | 87 +++++++++++++++++++------------------------
>  2 files changed, 51 insertions(+), 50 deletions(-)
> 
[...]
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index b895f70acb2d..d64ddaa472ca 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
[...]
> @@ -581,6 +583,8 @@ static void damon_update_monitoring_results(struct damon_ctx *ctx,
>   */
>  int damon_set_attrs(struct damon_ctx *ctx, struct damon_attrs *attrs)
>  {
> +	unsigned long sample_interval;
> +
>  	if (attrs->min_nr_regions < 3)
>  		return -EINVAL;
>  	if (attrs->min_nr_regions > attrs->max_nr_regions)
> @@ -588,6 +592,12 @@ int damon_set_attrs(struct damon_ctx *ctx, struct damon_attrs *attrs)
>  	if (attrs->sample_interval > attrs->aggr_interval)
>  		return -EINVAL;
>  
> +	sample_interval = attrs->sample_interval ? attrs->sample_interval : 1;
> +	ctx->next_aggregation_sis = ctx->passed_sample_intervals +
> +		attrs->aggr_interval / sample_interval;
> +	ctx->next_ops_update_sis = ctx->passed_sample_intervals +
> +		attrs->ops_update_interval / sample_interval;
> +

So, damon_set_attrs() can be called from after_wamrks_check() or
after_aggregation() callbacks while kdamond is running.  And, it updates the
next_{aggregation,ops_update}_sis.

>  	damon_update_monitoring_results(ctx, attrs);
>  	ctx->attrs = *attrs;
>  	return 0;
> @@ -761,38 +771,6 @@ int damon_stop(struct damon_ctx **ctxs, int nr_ctxs)
>  	return err;
>  }
>  
[...]
> @@ -1432,6 +1409,8 @@ static int kdamond_fn(void *data)
>  
>  	pr_debug("kdamond (%d) starts\n", current->pid);
>  
> +	kdamond_init_intervals_sis(ctx);
> +
>  	if (ctx->ops.init)
>  		ctx->ops.init(ctx);
>  	if (ctx->callback.before_start && ctx->callback.before_start(ctx))
> @@ -1440,6 +1419,8 @@ static int kdamond_fn(void *data)
>  	sz_limit = damon_region_sz_limit(ctx);
>  
>  	while (!kdamond_need_stop(ctx)) {
> +		unsigned long sample_interval;
> +
>  		if (kdamond_wait_activation(ctx))

The after_wmarks_check() callback is called from kdamond_wait_activation().
Hence, the user might call damon_set_attrs() there, and
next_{aggr_interval,ops_update}_sis can be changed here.

>  			break;
>  
> @@ -1450,11 +1431,17 @@ static int kdamond_fn(void *data)
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

This branch reads next_aggregation_sis, which could be changed from above
after_wmarks_check() call.

This branch also executes after_aggregation() callback, which again can call
damon_set_attrs() and therefore update next_ops_update_sis.

> +			ctx->next_aggregation_sis +=
> +				ctx->attrs.aggr_interval / sample_interval;
>  			kdamond_merge_regions(ctx,
>  					max_nr_accesses / 10,
>  					sz_limit);
> @@ -1469,7 +1456,11 @@ static int kdamond_fn(void *data)
>  				ctx->ops.reset_aggregated(ctx);
>  		}
>  
> -		if (kdamond_need_update_operations(ctx)) {
> +		if (ctx->passed_sample_intervals ==
> +				ctx->next_ops_update_sis) {

This branch reads next_ops_update_sis, which could be changed from above
after_aggregation() or after_wmarks_check() callbacks.

As a result, we can unexpectedly skip aggregation or ops update executions.
This could be problem for later changes including pseudo-moving sum based
nr_accesses[1] and DAMOS apply intervals[2].  Let's read
next_{aggregation,ops_update}_sis at the beginning of the loop and use those.

[1] https://lore.kernel.org/damon/20230909033711.55794-9-sj@kernel.org/
[2] https://lore.kernel.org/damon/20230910034048.59191-1-sj@kernel.org/

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
