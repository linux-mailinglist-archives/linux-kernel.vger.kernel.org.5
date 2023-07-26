Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFF87640D4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 22:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbjGZU7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 16:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjGZU7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 16:59:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A4119AD;
        Wed, 26 Jul 2023 13:59:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BBA461CB5;
        Wed, 26 Jul 2023 20:59:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A91B6C433C7;
        Wed, 26 Jul 2023 20:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690405179;
        bh=qFmhNVrbhVXAVXjyRI0k8f6CFr7UpXG0gEv/ux63DIc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=uPhXfbLvmdMwjToaC7cVmUex0b6I6aDOKZl6/J0WED5HW+6SUd/1RhDYZZmAfPz3X
         QScqY22S5Vug9ct1DP/8Z6o/7uaD9CeeYU0a+fmhzsqRjowqFHBJErj/wMSXuvbJRT
         oT16Z1/TqThQmj3NNK4buhQ+YLZWY7+ghfPDhG89tAZYyIGv/VCqgj0QjtIIkb1QXo
         NT6806kHSF19IpCh5YuAij3Cy0acYE+OgdA0ltcI1NUxzgyO8PgQmclCn9T2A1JSlM
         fmXUOxXqmRLY1bzIXyP2VE6k0eFTCvuRCx39v9ObYYa8i45p5kZd8pR91nI3brzil5
         QbEmCcP6qQbLQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3318CCE0A1C; Wed, 26 Jul 2023 13:59:39 -0700 (PDT)
Date:   Wed, 26 Jul 2023 13:59:39 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 1/5] rcutorture: Fix stuttering races and other issues
Message-ID: <f6ef4762-6d37-40a4-8272-13b248c46f5b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230725232913.2981357-1-joel@joelfernandes.org>
 <20230725232913.2981357-2-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725232913.2981357-2-joel@joelfernandes.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 11:29:06PM +0000, Joel Fernandes (Google) wrote:
> The stuttering code isn't functioning as expected. Ideally, it should
> pause the torture threads for a designated period before resuming. Yet,
> it fails to halt the test for the correct duration. Additionally, a race
> condition exists, potentially causing the stuttering code to pause for
> an extended period if the 'spt' variable is non-zero due to the stutter
> orchestration thread's inadequate CPU time.
> 
> Moreover, over-stuttering can hinder RCU's progress on TREE07 kernels.
> This happens as the stuttering code may run within a softirq due to RCU
> callbacks. Consequently, ksoftirqd keeps a CPU busy for several seconds,
> thus obstructing RCU's progress. This situation triggers a warning
> message in the logs:
> 
> [ 2169.481783] rcu_torture_writer: rtort_pipe_count: 9
> 
> This warning suggests that an RCU torture object, although invisible to
> RCU readers, couldn't make it past the pipe array and be freed -- a
> strong indication that there weren't enough grace periods during the
> stutter interval.
> 
> To address these issues, this patch sets the "stutter end" time to an
> absolute point in the future set by the main stutter thread. This is
> then used for waiting in stutter_wait(). While the stutter thread still
> defines this absolute time, the waiters' waiting logic doesn't rely on
> the stutter thread receiving sufficient CPU time to halt the stuttering
> as the halting is now self-controlled.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/torture.c | 46 +++++++++++++---------------------------------
>  1 file changed, 13 insertions(+), 33 deletions(-)
> 
> diff --git a/kernel/torture.c b/kernel/torture.c
> index 68dba4ecab5c..63f8f2a7d960 100644
> --- a/kernel/torture.c
> +++ b/kernel/torture.c
> @@ -719,7 +719,7 @@ static void torture_shutdown_cleanup(void)
>   * suddenly applied to or removed from the system.
>   */
>  static struct task_struct *stutter_task;
> -static int stutter_pause_test;
> +static ktime_t stutter_till_abs_time;
>  static int stutter;
>  static int stutter_gap;
>  
> @@ -729,30 +729,17 @@ static int stutter_gap;
>   */
>  bool stutter_wait(const char *title)
>  {
> -	unsigned int i = 0;
>  	bool ret = false;
> -	int spt;
> +	ktime_t now_ns, till_ns;
>  
>  	cond_resched_tasks_rcu_qs();
> -	spt = READ_ONCE(stutter_pause_test);
> -	for (; spt; spt = READ_ONCE(stutter_pause_test)) {
> -		if (!ret && !rt_task(current)) {
> -			sched_set_normal(current, MAX_NICE);
> -			ret = true;
> -		}
> -		if (spt == 1) {
> -			torture_hrtimeout_jiffies(1, NULL);
> -		} else if (spt == 2) {
> -			while (READ_ONCE(stutter_pause_test)) {
> -				if (!(i++ & 0xffff))
> -					torture_hrtimeout_us(10, 0, NULL);
> -				cond_resched();
> -			}
> -		} else {
> -			torture_hrtimeout_jiffies(round_jiffies_relative(HZ), NULL);
> -		}
> -		torture_shutdown_absorb(title);
> +	now_ns = ktime_get();
> +	till_ns = READ_ONCE(stutter_till_abs_time);
> +	if (till_ns && ktime_before(now_ns, till_ns)) {
> +		torture_hrtimeout_ns(ktime_sub(till_ns, now_ns), 0, NULL);

This ktime_sub() is roughly cancelled out by a ktime_add_safe() in
__hrtimer_start_range_ns().  Perhaps torture_hrtimeout_ns() needs to
take a mode argument as in the patch at the end of this email, allowing
you to ditch that ktime_sub() in favor of HRTIMER_MODE_ABS.

							Thanx, Paul

> +		ret = true;
>  	}
> +	torture_shutdown_absorb(title);
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(stutter_wait);
> @@ -763,23 +750,16 @@ EXPORT_SYMBOL_GPL(stutter_wait);
>   */
>  static int torture_stutter(void *arg)
>  {
> -	DEFINE_TORTURE_RANDOM(rand);
> -	int wtime;
> +	ktime_t till_ns;
>  
>  	VERBOSE_TOROUT_STRING("torture_stutter task started");
>  	do {
>  		if (!torture_must_stop() && stutter > 1) {
> -			wtime = stutter;
> -			if (stutter > 2) {
> -				WRITE_ONCE(stutter_pause_test, 1);
> -				wtime = stutter - 3;
> -				torture_hrtimeout_jiffies(wtime, &rand);
> -				wtime = 2;
> -			}
> -			WRITE_ONCE(stutter_pause_test, 2);
> -			torture_hrtimeout_jiffies(wtime, NULL);
> +			till_ns = ktime_add_ns(ktime_get(),
> +					       jiffies_to_nsecs(stutter));
> +			WRITE_ONCE(stutter_till_abs_time, till_ns);
> +			torture_hrtimeout_jiffies(stutter - 1, NULL);
>  		}
> -		WRITE_ONCE(stutter_pause_test, 0);
>  		if (!torture_must_stop())
>  			torture_hrtimeout_jiffies(stutter_gap, NULL);
>  		torture_shutdown_absorb("torture_stutter");

------------------------------------------------------------------------

commit 6445f014c3d4d20a0b69bd97d3b76a222820612f
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Wed Jul 26 13:57:03 2023 -0700

    torture: Make torture_hrtimeout_ns() take an hrtimer mode parameter
    
    The current torture-test sleeps are waiting for a duration, but there
    are situations where it is better to wait for an absolute time, for
    example, when ending a stutter interval.  This commit therefore adds
    an hrtimer mode parameter to torture_hrtimeout_ns().  Why not also the
    other torture_hrtimeout_*() functions?  The theory is that most absolute
    times will be in nanoseconds, especially not (say) jiffies.
    
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/include/linux/torture.h b/include/linux/torture.h
index bb466eec01e4..017f0f710815 100644
--- a/include/linux/torture.h
+++ b/include/linux/torture.h
@@ -81,7 +81,8 @@ static inline void torture_random_init(struct torture_random_state *trsp)
 }
 
 /* Definitions for high-resolution-timer sleeps. */
-int torture_hrtimeout_ns(ktime_t baset_ns, u32 fuzzt_ns, struct torture_random_state *trsp);
+int torture_hrtimeout_ns(ktime_t baset_ns, u32 fuzzt_ns, const enum hrtimer_mode mode,
+			 struct torture_random_state *trsp);
 int torture_hrtimeout_us(u32 baset_us, u32 fuzzt_ns, struct torture_random_state *trsp);
 int torture_hrtimeout_ms(u32 baset_ms, u32 fuzzt_us, struct torture_random_state *trsp);
 int torture_hrtimeout_jiffies(u32 baset_j, struct torture_random_state *trsp);
diff --git a/kernel/torture.c b/kernel/torture.c
index 68dba4ecab5c..6ba62e5993e7 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -87,14 +87,15 @@ EXPORT_SYMBOL_GPL(verbose_torout_sleep);
  * nanosecond random fuzz.  This function and its friends desynchronize
  * testing from the timer wheel.
  */
-int torture_hrtimeout_ns(ktime_t baset_ns, u32 fuzzt_ns, struct torture_random_state *trsp)
+int torture_hrtimeout_ns(ktime_t baset_ns, u32 fuzzt_ns, const enum hrtimer_mode mode,
+			 struct torture_random_state *trsp)
 {
 	ktime_t hto = baset_ns;
 
 	if (trsp)
 		hto += torture_random(trsp) % fuzzt_ns;
 	set_current_state(TASK_IDLE);
-	return schedule_hrtimeout(&hto, HRTIMER_MODE_REL);
+	return schedule_hrtimeout(&hto, mode);
 }
 EXPORT_SYMBOL_GPL(torture_hrtimeout_ns);
 
@@ -106,7 +107,7 @@ int torture_hrtimeout_us(u32 baset_us, u32 fuzzt_ns, struct torture_random_state
 {
 	ktime_t baset_ns = baset_us * NSEC_PER_USEC;
 
-	return torture_hrtimeout_ns(baset_ns, fuzzt_ns, trsp);
+	return torture_hrtimeout_ns(baset_ns, fuzzt_ns, HRTIMER_MODE_REL, trsp);
 }
 EXPORT_SYMBOL_GPL(torture_hrtimeout_us);
 
@@ -123,7 +124,7 @@ int torture_hrtimeout_ms(u32 baset_ms, u32 fuzzt_us, struct torture_random_state
 		fuzzt_ns = (u32)~0U;
 	else
 		fuzzt_ns = fuzzt_us * NSEC_PER_USEC;
-	return torture_hrtimeout_ns(baset_ns, fuzzt_ns, trsp);
+	return torture_hrtimeout_ns(baset_ns, fuzzt_ns, HRTIMER_MODE_REL, trsp);
 }
 EXPORT_SYMBOL_GPL(torture_hrtimeout_ms);
 
@@ -136,7 +137,7 @@ int torture_hrtimeout_jiffies(u32 baset_j, struct torture_random_state *trsp)
 {
 	ktime_t baset_ns = jiffies_to_nsecs(baset_j);
 
-	return torture_hrtimeout_ns(baset_ns, jiffies_to_nsecs(1), trsp);
+	return torture_hrtimeout_ns(baset_ns, jiffies_to_nsecs(1), HRTIMER_MODE_REL, trsp);
 }
 EXPORT_SYMBOL_GPL(torture_hrtimeout_jiffies);
 
@@ -153,7 +154,7 @@ int torture_hrtimeout_s(u32 baset_s, u32 fuzzt_ms, struct torture_random_state *
 		fuzzt_ns = (u32)~0U;
 	else
 		fuzzt_ns = fuzzt_ms * NSEC_PER_MSEC;
-	return torture_hrtimeout_ns(baset_ns, fuzzt_ns, trsp);
+	return torture_hrtimeout_ns(baset_ns, fuzzt_ns, HRTIMER_MODE_REL, trsp);
 }
 EXPORT_SYMBOL_GPL(torture_hrtimeout_s);
 
