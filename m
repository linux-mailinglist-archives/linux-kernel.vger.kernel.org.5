Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA557E568B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 13:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344402AbjKHMux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 07:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjKHMuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 07:50:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFB31BF5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 04:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5rQmqHyq28sTTx41SOIqjCjlEAdR533KDLfge20GJyA=; b=NvLDaPEObNlQZ7/0u1uC02f+nj
        DtroOR/1+yb6jRjXuKyms6rhG80O4ap5jN6IfZOLPGroo/dS611lZWyrlMWeyPBhfG3ayEoiB+E9K
        locsP9xtG+ZKLvaHcarIa2VVPq2u2++trb6Cp8Ar3PXys1IYmx/jgrTUGzhYhI/U+KNhaDxGQOuf7
        b7vhoHzjbAaWWlsNCKqu8NFmJtuQnLJPs+H8lYxSfLFT2SQbRAiK8H9JbuhA0dY1O4y45Ti9O5A/W
        bqitrYXZjB+CJF6ehczO6Ahx4z+kun1wdo/zM5QU1ZDjXb+L1omhK8RE86nZW1zmyAnVYI1nlkvqE
        3GSVzkxw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r0i0y-0013wa-92; Wed, 08 Nov 2023 12:50:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9EB5B30049D; Wed,  8 Nov 2023 13:50:36 +0100 (CET)
Date:   Wed, 8 Nov 2023 13:50:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v5 6/7] sched/deadline: Deferrable dl server
Message-ID: <20231108125036.GD4779@noisy.programming.kicks-ass.net>
References: <cover.1699095159.git.bristot@kernel.org>
 <c7b706d30d6316c52853ca056db5beb82ba72863.1699095159.git.bristot@kernel.org>
 <CAEXW_YS=PrWDx+YGVR7bmq0_SoKNztzGrreApCd9qk1yBLA5bA@mail.gmail.com>
 <CAEXW_YQ8kv3tXQJexLSguPuWi0bXiReKDyYNo9+A-Hgp=Zo1vA@mail.gmail.com>
 <CAEXW_YSjsZSrJK_RbGmbLNy4UrLCgu+7NPZjg-wiLuNbGOGr+w@mail.gmail.com>
 <20231107114732.5dd350ec@gandalf.local.home>
 <7d1ea71b-5218-4ee0-bc89-f02ee6bd5154@redhat.com>
 <3e58fad7-7f66-4e48-adcc-0fda9e9d0d07@kernel.org>
 <20231108124401.GQ8262@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108124401.GQ8262@noisy.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2023 at 01:44:01PM +0100, Peter Zijlstra wrote:

> Should we rather not cap the runtime, something like so?
> 

Clearly I should've done the patch against a tree that includes the
changes... 

> ---
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 58b542bf2893..1453a2cd0680 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -829,10 +829,12 @@ static inline void setup_new_dl_entity(struct sched_dl_entity *dl_se)
>   */
>  static void replenish_dl_entity(struct sched_dl_entity *dl_se)
>  {
> +	struct sched_dl_entity *pi_se = pi_of(dl_se);
>  	struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
>  	struct rq *rq = rq_of_dl_rq(dl_rq);
> +	u64 dl_runtime = pi_se->dl_runtime;
>  
> -	WARN_ON_ONCE(pi_of(dl_se)->dl_runtime <= 0);
> +	WARN_ON_ONCE(dl_runtime <= 0);
>  
>  	/*
>  	 * This could be the case for a !-dl task that is boosted.
> @@ -851,10 +853,13 @@ static void replenish_dl_entity(struct sched_dl_entity *dl_se)
>  	 * arbitrary large.
>  	 */
>  	while (dl_se->runtime <= 0) {
> -		dl_se->deadline += pi_of(dl_se)->dl_period;
> -		dl_se->runtime += pi_of(dl_se)->dl_runtime;
> +		dl_se->deadline += pi_se->dl_period;
> +		dl_se->runtime += dl_runtime;
>  	}
>  
> +	if (dl_se->zerolax && dl_se->runtime > dl_runtime)
> +		dl_se->runtime = dl_runtime;
> +

This should ofcourse go in the if (dl_se->dl_zerolax_armed) branch a
little down from here.

>  	/*
>  	 * At this point, the deadline really should be "in
>  	 * the future" with respect to rq->clock. If it's
