Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DACC67861F3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 23:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236705AbjHWVIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 17:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236964AbjHWVH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 17:07:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AB010D8;
        Wed, 23 Aug 2023 14:07:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DA1C62CDE;
        Wed, 23 Aug 2023 21:07:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 335CBC433C7;
        Wed, 23 Aug 2023 21:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692824876;
        bh=/PuuXO/QYD9GC1BSe9gvQM/Dq5frWY05/UE9gYxUQXU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=mfVNycNXBof/osoyaRgWxI/Tt0rulVbPmqSG0t5kiXk7KtVPr5GWVhl+067X9PQHR
         FaSw6b09QLneiKJ3ByXhsXU2e/fU+DMnWoyOXVJwjZ46L1ax6+ljts5tNLIQOKFwch
         DA0ML2/xiV0qRmskJq3Ap4j1X15Wnn/WIbxewgBMMeGkgAtcD85cYBaeQnJDZqAkgk
         iT7Q1R9tHXXxRfB0eVrJU1t0JwGvsM9/eXwLn/B+A5Qci5BFLOrYNgMYj9JatBlsrK
         ueBmS4YQnKNopdnHaKgFlPamf0U2KSl6v/evDgnkP8xOFYhQosBvCSettc9QRRT0+d
         SvgvYDkENGQjQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C8E2CCE02EE; Wed, 23 Aug 2023 14:07:55 -0700 (PDT)
Date:   Wed, 23 Aug 2023 14:07:55 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org
Subject: Re: [PATCH] rcutorture: Replace schedule_timeout*() 1 jiffie waits
 with HZ/20
Message-ID: <530be59f-96a9-4b2b-8be3-af837d7cbe3a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230816204913.450457-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816204913.450457-1-joel@joelfernandes.org>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 08:49:12PM +0000, Joel Fernandes (Google) wrote:
> In the past, we see that spinning on schedule_timeout* with a wait of 1
> jiffie can hang the kernel. See d52d3a2bf408 ("torture: Fix hang during
> kthread shutdown phase").
> 
> Recently again it showed up in torture's stutter code as well. The behavior is
> the the function may instantly return and never go to sleep preempting whatever
> was running under it.
> 
> To prevent future issues, apply the same fix mentioned in the above
> commit d52d3a2bf408 to more places.
> 
> I took care to only apply it to places where I thought it made sense.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Hearing no objections, I applied this for further review and testing.

In the future, should some of these become hrtimers?

						Thanx, Paul

> ---
>  kernel/rcu/rcutorture.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 8dd52ea78b52..a31297f32a2a 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -1153,7 +1153,7 @@ static int rcu_torture_boost(void *arg)
>  				mutex_unlock(&boost_mutex);
>  				break;
>  			}
> -			schedule_timeout_uninterruptible(1);
> +			schedule_timeout_uninterruptible(HZ / 20);
>  		}
>  
>  		/* Go do the stutter. */
> @@ -1164,7 +1164,7 @@ checkwait:	if (stutter_wait("rcu_torture_boost"))
>  	/* Clean up and exit. */
>  	while (!kthread_should_stop()) {
>  		torture_shutdown_absorb("rcu_torture_boost");
> -		schedule_timeout_uninterruptible(1);
> +		schedule_timeout_uninterruptible(HZ / 20);
>  	}
>  	torture_kthread_stopping("rcu_torture_boost");
>  	return 0;
> @@ -1187,7 +1187,7 @@ rcu_torture_fqs(void *arg)
>  		fqs_resume_time = jiffies + fqs_stutter * HZ;
>  		while (time_before(jiffies, fqs_resume_time) &&
>  		       !kthread_should_stop()) {
> -			schedule_timeout_interruptible(1);
> +			schedule_timeout_interruptible(HZ / 20);
>  		}
>  		fqs_burst_remaining = fqs_duration;
>  		while (fqs_burst_remaining > 0 &&
> @@ -2903,7 +2903,7 @@ static int rcu_torture_fwd_prog(void *args)
>  			WRITE_ONCE(rcu_fwd_seq, rcu_fwd_seq + 1);
>  		} else {
>  			while (READ_ONCE(rcu_fwd_seq) == oldseq && !torture_must_stop())
> -				schedule_timeout_interruptible(1);
> +				schedule_timeout_interruptible(HZ / 20);
>  			oldseq = READ_ONCE(rcu_fwd_seq);
>  		}
>  		pr_alert("%s: Starting forward-progress test %d\n", __func__, rfp->rcu_fwd_id);
> @@ -3204,7 +3204,7 @@ static int rcu_torture_read_exit_child(void *trsp_in)
>  	set_user_nice(current, MAX_NICE);
>  	// Minimize time between reading and exiting.
>  	while (!kthread_should_stop())
> -		schedule_timeout_uninterruptible(1);
> +		schedule_timeout_uninterruptible(HZ / 20);
>  	(void)rcu_torture_one_read(trsp, -1);
>  	return 0;
>  }
> @@ -3252,7 +3252,7 @@ static int rcu_torture_read_exit(void *unused)
>  	smp_mb(); // Store before wakeup.
>  	wake_up(&read_exit_wq);
>  	while (!torture_must_stop())
> -		schedule_timeout_uninterruptible(1);
> +		schedule_timeout_uninterruptible(HZ / 20);
>  	torture_kthread_stopping("rcu_torture_read_exit");
>  	return 0;
>  }
> -- 
> 2.41.0.694.ge786442a9b-goog
> 
