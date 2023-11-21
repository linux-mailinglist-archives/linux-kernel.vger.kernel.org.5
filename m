Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 867E97F22C2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 02:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbjKUBCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 20:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjKUBCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 20:02:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E112AE3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 17:02:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77BE6C433C7;
        Tue, 21 Nov 2023 01:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700528534;
        bh=c2p1c9h9OLXIW1qdxiQJ1cJW79ojVa/E+hgB2/Q4MzY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=rer8SQ05mg8xsK7UmAxkNIh1pnEOutDGdhg4EixbY39byivelsT7ourpejf41dpRj
         uNNdy3GfAq+IraJZ81zwuNFm5ADgscdzreRrTwMh9DtWqPI1jHxyNXp8qfK7wQFd/O
         f+xBFwTTnR5NP1Wmst5HZz7IKfd9Yp3qmB18oKAwRV1Q7pROwpXbLFouaXbtM6guzO
         sOppS6Sd4g4+G5I1qOk44T5Nr+7mmyD3XqTDomyUFl8Ey4H4luxWuQdXzLC12cuJVB
         5l6bAG5TYis16QdHnGaw6qoP15jdhNOEzYnoukWn3aQa18TSmhFJGBV2VCU+APMeq1
         cFjln8kTEA0uw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 25580CE1390; Mon, 20 Nov 2023 17:02:14 -0800 (PST)
Date:   Mon, 20 Nov 2023 17:02:14 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [RFC PATCH 60/86] treewide: torture: remove cond_resched()
Message-ID: <00803d57-b012-4c30-8ea2-0605cf68ddee@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-4-ankur.a.arora@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107230822.371443-4-ankur.a.arora@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 03:07:56PM -0800, Ankur Arora wrote:
> Some cases changed to cond_resched_stall() to avoid changing
> the behaviour of the test too drastically.
> 
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>

Given lazy preemption, I am OK with dropping the cond_resched()
invocations from the various torture tests.

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/rcu/rcuscale.c   | 2 --
>  kernel/rcu/rcutorture.c | 8 ++++----
>  kernel/scftorture.c     | 1 -
>  kernel/torture.c        | 1 -
>  4 files changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
> index ffdb30495e3c..737620bbec83 100644
> --- a/kernel/rcu/rcuscale.c
> +++ b/kernel/rcu/rcuscale.c
> @@ -672,8 +672,6 @@ kfree_scale_thread(void *arg)
>  			else
>  				kfree_rcu(alloc_ptr, rh);
>  		}
> -
> -		cond_resched();
>  	} while (!torture_must_stop() && ++loop < kfree_loops);
>  
>  	if (atomic_inc_return(&n_kfree_scale_thread_ended) >= kfree_nrealthreads) {
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index ade42d6a9d9b..158d58710b51 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -81,7 +81,7 @@ torture_param(int, fqs_stutter, 3, "Wait time between fqs bursts (s)");
>  torture_param(int, fwd_progress, 1, "Number of grace-period forward progress tasks (0 to disable)");
>  torture_param(int, fwd_progress_div, 4, "Fraction of CPU stall to wait");
>  torture_param(int, fwd_progress_holdoff, 60, "Time between forward-progress tests (s)");
> -torture_param(bool, fwd_progress_need_resched, 1, "Hide cond_resched() behind need_resched()");
> +torture_param(bool, fwd_progress_need_resched, 1, "Hide cond_resched_stall() behind need_resched()");
>  torture_param(bool, gp_cond, false, "Use conditional/async GP wait primitives");
>  torture_param(bool, gp_cond_exp, false, "Use conditional/async expedited GP wait primitives");
>  torture_param(bool, gp_cond_full, false, "Use conditional/async full-state GP wait primitives");
> @@ -2611,7 +2611,7 @@ static void rcu_torture_fwd_prog_cond_resched(unsigned long iter)
>  		return;
>  	}
>  	// No userspace emulation: CB invocation throttles call_rcu()
> -	cond_resched();
> +	cond_resched_stall();
>  }
>  
>  /*
> @@ -2691,7 +2691,7 @@ static void rcu_torture_fwd_prog_nr(struct rcu_fwd *rfp,
>  		udelay(10);
>  		cur_ops->readunlock(idx);
>  		if (!fwd_progress_need_resched || need_resched())
> -			cond_resched();
> +			cond_resched_stall();
>  	}
>  	(*tested_tries)++;
>  	if (!time_before(jiffies, stopat) &&
> @@ -3232,7 +3232,7 @@ static int rcu_torture_read_exit(void *unused)
>  				errexit = true;
>  				break;
>  			}
> -			cond_resched();
> +			cond_resched_stall();
>  			kthread_stop(tsp);
>  			n_read_exits++;
>  		}
> diff --git a/kernel/scftorture.c b/kernel/scftorture.c
> index 59032aaccd18..24192fe01125 100644
> --- a/kernel/scftorture.c
> +++ b/kernel/scftorture.c
> @@ -487,7 +487,6 @@ static int scftorture_invoker(void *arg)
>  			set_cpus_allowed_ptr(current, cpumask_of(cpu));
>  			was_offline = false;
>  		}
> -		cond_resched();
>  		stutter_wait("scftorture_invoker");
>  	} while (!torture_must_stop());
>  
> diff --git a/kernel/torture.c b/kernel/torture.c
> index b28b05bbef02..0c0224c76275 100644
> --- a/kernel/torture.c
> +++ b/kernel/torture.c
> @@ -747,7 +747,6 @@ bool stutter_wait(const char *title)
>  			while (READ_ONCE(stutter_pause_test)) {
>  				if (!(i++ & 0xffff))
>  					torture_hrtimeout_us(10, 0, NULL);
> -				cond_resched();
>  			}
>  		} else {
>  			torture_hrtimeout_jiffies(round_jiffies_relative(HZ), NULL);
> -- 
> 2.31.1
> 
