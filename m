Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E6A7F1266
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 12:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbjKTLsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 06:48:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbjKTLsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 06:48:52 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBECB8E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 03:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tRSjvBLeRfQ7O2tsXsQTusJsAygDUJstbiZc4CjFK0w=; b=PJkslyS3n0J8xbNI52IL+Qqxv5
        fp2UQiM38h25OoXaQzJgznpaaXpfp2CqWBYLtqtOE64DHZL+ESsmuQLBH95UBcg6+EKRD+d1/CS8I
        0un5Mm+ww+Ps4ZMfIEIldGlfd0gMN2bsEMpeqJURsnF1ro6I/mlHgAtxlIdJ+9WpTYf+qCYWKWqIR
        U66BZXp6jopYx4ftXSFGf0pltVW7DEf6FRvJdU1u5VuLYEWXmje0JfPodkA2AZnmkAmdC5PwrYDpT
        xpyBUGnxWtQP8a6rCeP3UPgJxZNOb9g+95sWOnxMeIUKKsJN0eu+/Ja4PSv0SnDjYyuoxsAJYbYfn
        EHXLllZw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r52lX-00AwDo-2n;
        Mon, 20 Nov 2023 11:48:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 25EBA3004E3; Mon, 20 Nov 2023 12:48:35 +0100 (CET)
Date:   Mon, 20 Nov 2023 12:48:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yiwei Lin <s921975628@gmail.com>
Cc:     mingo@redhat.com, wuyun.abel@bytedance.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org, s921975627@gmail.com
Subject: Re: [PATCH] sched/fair: Update min_vruntime for reweight_entity()
 correctly
Message-ID: <20231120114835.GS8262@noisy.programming.kicks-ass.net>
References: <20231117080106.12890-1-s921975628@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117080106.12890-1-s921975628@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 04:01:06PM +0800, Yiwei Lin wrote:
> Since reweight_entity() may have chance to change the weight of
> cfs_rq->curr entity, we should also update_min_vruntime() if
> this is the case
> 
> Fixes: eab03c23c2a1 ("sched/eevdf: Fix vruntime adjustment on reweight")
> Signed-off-by: Yiwei Lin <s921975628@gmail.com>


Right, but as you wrote in your other patch, min_vruntime isn't all that
critical anymore. I'll go queue this in sched/core, I don't think this
warrants /urgent.

> ---
>  kernel/sched/fair.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 07f555857..6fb89f4a3 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3815,17 +3815,17 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
>  	enqueue_load_avg(cfs_rq, se);
>  	if (se->on_rq) {
>  		update_load_add(&cfs_rq->load, se->load.weight);
> -		if (!curr) {
> -			/*
> -			 * The entity's vruntime has been adjusted, so let's check
> -			 * whether the rq-wide min_vruntime needs updated too. Since
> -			 * the calculations above require stable min_vruntime rather
> -			 * than up-to-date one, we do the update at the end of the
> -			 * reweight process.
> -			 */
> +		if (!curr)
>  			__enqueue_entity(cfs_rq, se);
> -			update_min_vruntime(cfs_rq);
> -		}
> +
> +		/*
> +		 * The entity's vruntime has been adjusted, so let's check
> +		 * whether the rq-wide min_vruntime needs updated too. Since
> +		 * the calculations above require stable min_vruntime rather
> +		 * than up-to-date one, we do the update at the end of the
> +		 * reweight process.
> +		 */
> +		update_min_vruntime(cfs_rq);
>  	}
>  }
>  
> -- 
> 2.34.1
> 
