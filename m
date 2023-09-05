Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE6F792A09
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356657AbjIEQd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344595AbjIEDtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 23:49:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79633CC7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 20:49:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A3C7B810A0
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 03:49:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AD83C433C7;
        Tue,  5 Sep 2023 03:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693885741;
        bh=lr8JZFOrIMmBf3b1VvvA03Ns1Iavbh5ZrCVGwpM6Nik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lr3y/LfQjAjdQkg0Cyq3KvExgeue5Yw7O9pcscK462LKG4pds0vVH3HK5jEzulHxk
         V8tZPPHjhjDQtaEe9wdO/DkaoSy2zYyCUp+2husOnGCtg3q+7xbxW3ZICoXOw2BlEz
         c667MQA2GVGMubLjQcFDpOrCRA2bl0NQPd88lbfCImp2EuTELjar1Of7YHtgI7hcUI
         Yv0ERYj9STG6pMjYf1qiNvlbTV7aFVHf9CmkLypJIR+R385mEUKcKllLnFSPXnIS2b
         2s3QCEnwFJEIbSMEXnE904NOhypIm+1blPhgo5stDL1HG4QOD+AxM3kj0/BWk6iWKq
         Xh8gntPwmoIGA==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     damon@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm/damon/core: use number of passed access sampling as a timer
Date:   Tue,  5 Sep 2023 03:48:58 +0000
Message-Id: <20230905034858.127810-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230827003727.49369-1-sj@kernel.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
[...]
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 988dc39e44b1..83af336bb0e6 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
[...]
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

The above remaining interval based adjustments mean we will respect the old
intervals for one more time.  However, user wants to change it right now, so
respecting it yet makes no sense.  Also, since this function is to be called
while no aggregation is ongoing, the remaining_interval_us for
next_aggregation_sis will be always zero.  So, simply ignoring past and
resetting the timings as below may make better sense.

    ctx->next_aggregation_sis = ctx->passed_sample_intervals +
    		attrs->aggr_interval / sample_interval;

    ctx->next_ops_update_sis = ctx->passed_sample_intervals +
    		attrs->ops_update_interval / sample_interval;

I will replace the adjustments as above.


Thanks,
SJ

[...]
