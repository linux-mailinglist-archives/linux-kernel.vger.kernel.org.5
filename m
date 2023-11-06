Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756857E223F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 13:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbjKFMte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 07:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjKFMtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 07:49:33 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCE6BB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 04:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2WtEdZBmslCuVN1AQ4HlTQxWbr8sd/oi9GlYQjSg5r0=; b=m/B2EWUjf1oQJWy2kDbDcTYYnn
        oe3519MUtMpZwzfFB656xvf4avpOWpnP2mFNLRu+rxkG+hD/3Y006DBBEZ/ziFdgM61CRKJ2mg5c6
        M6qLyY2X+tjKyKT62s7VrPNIbGvpduhHUOjneLdpGjTiZw2u48ANj9piFqBEEjV8dSCKMCsekYOob
        21FxAhtS1MroGtgPsx6Bb0VElRAxnORmY6IKqwmg9IY8jX6wOPpJHYsIbPiy18Ql2En0AK3k1NOL3
        4WQ4mNEDuF7Dwc//qa9B52EcJB63biGBblZpeCCFZf/uG2dgbP2irqYLfxAziiMhI0dEwK8/LPxbk
        slpKsdyg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qzz2W-00AWEc-2t;
        Mon, 06 Nov 2023 12:49:13 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6425F30049D; Mon,  6 Nov 2023 13:49:12 +0100 (CET)
Date:   Mon, 6 Nov 2023 13:49:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] sched: Don't account execution time for task group
Message-ID: <20231106124912.GM8262@noisy.programming.kicks-ass.net>
References: <20231031125928.235685-1-yajun.deng@linux.dev>
 <20231031125928.235685-2-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031125928.235685-2-yajun.deng@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 08:59:26PM +0800, Yajun Deng wrote:
> The rt entity can be a task group. We will account execution time for
> each task. For consistency, we don't need to account execution time for
> task group.
> 
> Pass a parameter to update_current_exec_runtime, let the caller decide
> whether account execution time.
> 

> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 6aaf0a3d6081..79cf80d73822 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1018,7 +1018,8 @@ static void update_curr_rt(struct rq *rq)
>  
>  	trace_sched_stat_runtime(curr, delta_exec, 0);
>  
> -	update_current_exec_runtime(curr, now, delta_exec);
> +	update_current_exec_runtime(curr, now, delta_exec,
> +				    rt_entity_is_task(rt_se));
>  
>  	if (!rt_bandwidth_enabled())
>  		return;

ok, I think I've managed to confuse myself again.

But at this point rt_se := &rq->curr->rt, which is *always* a task, no?
