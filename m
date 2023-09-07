Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A62A797475
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241600AbjIGPio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345359AbjIGPfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:35:31 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC32198E;
        Thu,  7 Sep 2023 08:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QUUh+RqON6fS6Crk84Dx/3Y/w64C4ZDBuS3vTrptbI8=; b=Z9228xSGlZxiFF7csV7I/eWRaJ
        uFD4iyFnifMsxh/2+tqDJtloNh7/ZRAGxDeqLYOfl9hXHXV9//sQjwXo1zt7F6OVZEBa6wg+WatEm
        5WWA5cDb/zTRTqfyA11ngZdy3JIPDqlOh8RH4NYlbo0qpj9CmN49bKBXd0oofklrQ4vi/Mze7aYgp
        QUYt2TI1E0dq2S4Z1/QS1ul5TtbRWMDsQgSD9CPE8qOD7UKlfDReowzB/PYubPhUFPcGqjL+KqLse
        V8vyUn6l1bsP6glS4gfziOl8A63JcPOEkZUMQAPkrmDR2ewGhnCr3zm9CLRGyL8JVtlzSdu0u3Rd2
        i/IbDb4w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qeDQp-001mRG-2K;
        Thu, 07 Sep 2023 11:44:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id CF91A300687; Thu,  7 Sep 2023 13:44:20 +0200 (CEST)
Date:   Thu, 7 Sep 2023 13:44:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [RFC PATCH 5/7] sched/schedutil: Add a new tunable to dictate
 response time
Message-ID: <20230907114420.GC10955@noisy.programming.kicks-ass.net>
References: <20230827233203.1315953-1-qyousef@layalina.io>
 <20230827233203.1315953-6-qyousef@layalina.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230827233203.1315953-6-qyousef@layalina.io>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 12:32:01AM +0100, Qais Yousef wrote:
> +static inline unsigned long
> +sugov_apply_response_time(struct sugov_policy *sg_policy, unsigned long util)
> +{
> +	unsigned long mult;
> +
> +	if (sg_policy->freq_response_time_ms == sg_policy->tunables->response_time_ms)
> +		return util;
> +
> +	mult = sg_policy->freq_response_time_ms * SCHED_CAPACITY_SCALE;
> +	mult /=	sg_policy->tunables->response_time_ms;
> +	mult *= util;
> +
> +	return mult >> SCHED_CAPACITY_SHIFT;
> +}
> +
>  static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
>  {
>  	s64 delta_ns;
> @@ -143,6 +184,7 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
>  	unsigned int freq = arch_scale_freq_invariant() ?
>  				policy->cpuinfo.max_freq : policy->cur;
>  
> +	util = sugov_apply_response_time(sg_policy, util);
>  	freq = map_util_freq(util, freq, max);
>  
>  	if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)

Urgh, so instead of caching the multiplier you keep computing what is
essentially a constant over and over and over and over again :/

That is, compute the whole 'freq_response_time_ms * SCHED_CAPACITY_SCALE
/ response_time_ms' thing *once*, when that file is written to, and then
reduce the whole thing to:

	return (freq_response_mult * util) >> SCHED_CAPACITY_SHIFT;

No need for that special case, no need for divisions, just go.
