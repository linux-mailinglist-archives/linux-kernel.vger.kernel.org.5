Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4236A78346F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 23:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjHUUaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 16:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjHUUaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 16:30:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1450D123
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 13:30:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4A5864A1B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 20:30:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 100D9C433C7;
        Mon, 21 Aug 2023 20:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692649800;
        bh=oKDp7W+jNaTpMN8DKncoSvKjKpl9eAmtUXNs2ax/iKc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=L8U9x3KzIDFxa5EvBxLMWolWjYHo6V8b3/po4AQRZKOlDlDVPemcEfTqwY9RagM62
         GQt26U8JpbJJMvEuVMNGv9NvmewTVU/yCUsTrXVxy+By1ARaiENkkDe4iOntaeYxzK
         J6P32w6p4jionZkF2ugsE5LhIAn2pAHTT7pbDdYnEVl6Bvqcsyfq4mlZuEYFK3IOLQ
         uNZkOlUyHrq+Gtc126SRwWWyhdJuhOmUVduXNAicPGJJIcPFWDQ+n/+iEzkgIPcksd
         Yvm6mQnxIYvxbkjWOa73KJYtda0FXjRHDsKILxFvdSwehrj8aAgmMehcKgxGoo2P/I
         677HQypmjWB7w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A2252CE02F8; Mon, 21 Aug 2023 13:29:59 -0700 (PDT)
Date:   Mon, 21 Aug 2023 13:29:59 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH,RFC] smp,csd: throw an error if a CSD lock is stuck for
 too long
Message-ID: <398f6267-7848-4991-826f-619c5339c930@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230821160409.663b8ba9@imladris.surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821160409.663b8ba9@imladris.surriel.com>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 04:04:09PM -0400, Rik van Riel wrote:
> The CSD lock seems to get stuck in 2 "modes". When it gets stuck
> temporarily, it usually gets released in a few seconds, and sometimes
> up to one or two minutes.
> 
> If the CSD lock stays stuck for more than several minutes, it never
> seems to get unstuck, and gradually more and more things in the system
> end up also getting stuck.
> 
> In the latter case, we should just give up, so the system can dump out
> a little more information about what went wrong, and, with panic_on_oops
> and a kdump kernel loaded, dump a whole bunch more information about
> what might have gone wrong.
> 
> Question: should this have its own panic_on_ipistall switch in
> /proc/sys/kernel, or maybe piggyback on panic_on_oops in a different
> way than via BUG_ON?

Keep it simple until there is a demonstrated need?

> Signed-off-by: Rik van Riel <riel@surriel.com>

Looks good to me!

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

I am also pulling this into -rcu for further testing.

							Thanx, Paul

> ---
>  kernel/smp.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/smp.c b/kernel/smp.c
> index 385179dae360..8b808bff15e6 100644
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -228,6 +228,7 @@ static bool csd_lock_wait_toolong(struct __call_single_data *csd, u64 ts0, u64 *
>  	}
>  
>  	ts2 = sched_clock();
> +	/* How long since we last checked for a stuck CSD lock.*/
>  	ts_delta = ts2 - *ts1;
>  	if (likely(ts_delta <= csd_lock_timeout_ns || csd_lock_timeout_ns == 0))
>  		return false;
> @@ -241,9 +242,17 @@ static bool csd_lock_wait_toolong(struct __call_single_data *csd, u64 ts0, u64 *
>  	else
>  		cpux = cpu;
>  	cpu_cur_csd = smp_load_acquire(&per_cpu(cur_csd, cpux)); /* Before func and info. */
> +	/* How long since this CSD lock was stuck. */
> +	ts_delta = ts2 - ts0;
>  	pr_alert("csd: %s non-responsive CSD lock (#%d) on CPU#%d, waiting %llu ns for CPU#%02d %pS(%ps).\n",
> -		 firsttime ? "Detected" : "Continued", *bug_id, raw_smp_processor_id(), ts2 - ts0,
> +		 firsttime ? "Detected" : "Continued", *bug_id, raw_smp_processor_id(), ts_delta,
>  		 cpu, csd->func, csd->info);
> +	/*
> +	 * If the CSD lock is still stuck after 5 minutes, it is unlikely
> +	 * to become unstuck. Use a signed comparison to avoid triggering
> +	 * on underflows when the TSC is out of sync between sockets.
> +	 */
> +	BUG_ON((s64)ts_delta > 300000000000LL);
>  	if (cpu_cur_csd && csd != cpu_cur_csd) {
>  		pr_alert("\tcsd: CSD lock (#%d) handling prior %pS(%ps) request.\n",
>  			 *bug_id, READ_ONCE(per_cpu(cur_csd_func, cpux)),
> -- 
> 2.41.0
> 
> 
