Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDD47BBFE8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 21:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbjJFT7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 15:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjJFT7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 15:59:16 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2636583
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 12:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9EjxO/+C9ix3bcyWz8ERuTU/AQhKM8F5FcFj4ng85iU=; b=mCj9XRe4/mnbPqQ7EERsJvhWhz
        iQQVrOEPepByamF5iNKb0Z+VuppJm5EAy5uqfTw4h2FGX3MSK/0TtAj+rtYzKjxr7YByDn6BD9rgV
        FE8YGEzDG7KZ5SsxKeP+/wc7fvVV/0Ygy1RoKbhc3ri1AfMlmNQ9OVdsdh/mevJiJeBuo3Z8CHIdf
        DcUp389cmHC9drVC95CznI7fIDoygnkePXrhUtCyvZpV3qXciW4l6enHmdE94V6h55w9/psCsgmJS
        ZlR71c1iq2miBCpiytjXAknObvsxYuW+tmDaNoBU8UO80E1+15sVv0lPcnjdY6FaNW408fjFIIa2F
        cuhszekw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qoqxe-00CruB-0C;
        Fri, 06 Oct 2023 19:58:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1D1FA300392; Fri,  6 Oct 2023 21:58:11 +0200 (CEST)
Date:   Fri, 6 Oct 2023 21:58:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     bristot@redhat.com, bsegall@google.com, chris.hyser@oracle.com,
        corbet@lwn.net, dietmar.eggemann@arm.com, efault@gmx.de,
        joel@joelfernandes.org, joshdon@google.com, juri.lelli@redhat.com,
        kprateek.nayak@amd.com, linux-kernel@vger.kernel.org,
        mgorman@suse.de, mingo@kernel.org, patrick.bellasi@matbug.net,
        pavel@ucw.cz, pjt@google.com, qperret@google.com,
        qyousef@layalina.io, rostedt@goodmis.org, tglx@linutronix.de,
        tim.c.chen@linux.intel.com, timj@gnu.org,
        vincent.guittot@linaro.org, youssefesmat@chromium.org,
        yu.c.chen@intel.com
Subject: Re: [PATCH] sched/fair: Always update_curr() before placing at
 enqueue
Message-ID: <20231006195810.GI36277@noisy.programming.kicks-ass.net>
References: <20230531124604.068911180@infradead.org>
 <20231006164826.335223-1-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006164826.335223-1-daniel.m.jordan@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 12:48:26PM -0400, Daniel Jordan wrote:
> Placing wants current's vruntime and the cfs_rq's min_vruntime up to
> date so that avg_runtime() is too, and similarly it wants the entity to
> be re-weighted and lag adjusted so vslice and vlag are fresh, so always
> do update_curr() and update_cfs_group() beforehand.
> 
> There doesn't seem to be a reason to treat the 'curr' case specially
> after e8f331bcc270 since vruntime doesn't get normalized anymore.
> 
> Fixes: e8f331bcc270 ("sched/smp: Use lag to simplify cross-runqueue placement")
> Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> ---
> 
> Not sure what the XXX above place_entity() is for, maybe it can go away?
> 
> Based on tip/sched/core.
> 
>  kernel/sched/fair.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 04fbcbda97d5f..db2ca9bf9cc49 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5047,15 +5047,6 @@ static inline bool cfs_bandwidth_used(void);
>  static void
>  enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>  {
> -	bool curr = cfs_rq->curr == se;
> -
> -	/*
> -	 * If we're the current task, we must renormalise before calling
> -	 * update_curr().
> -	 */
> -	if (curr)
> -		place_entity(cfs_rq, se, flags);
> -
>  	update_curr(cfs_rq);

IIRC part of the reason for this order is the:

  dequeue
  update
  enqueue

pattern we have all over the place. You don't want the enqueue to move
time forward in this case.

Could be that all magically works, but please double check.
