Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6FB7761E97
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 18:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjGYQdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 12:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjGYQdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 12:33:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB3DFB;
        Tue, 25 Jul 2023 09:33:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB0B36177F;
        Tue, 25 Jul 2023 16:33:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EAC7C433C7;
        Tue, 25 Jul 2023 16:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690302827;
        bh=MRQMQFjTgJfjqUwN+LpHsvnC6Xaoz6At3uH/zrv07fg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=bI9n/ekeJLcHTnxE08dGvBWflyQw4bwkKr5aJU8lGmmf0cMd3Gk4c1ym5G7XCQhTA
         XEKO/bWfHXXlSLQENYVjELXNhpWHpBn+wRrnfvWevawHGnXGWyjT1IK2xyLGXre106
         qhCo7nc02WNOq/olNKh8WgdZ/7cFlas0eAONga2YEhiWmA5+MTUQhG6Qw2rb4sGdT2
         9jqbDU7VlAb6yqHVViG+Z+1/q6Nyamr08M49HbK3uIwhcEMI3QZKg0sz246Bau5CJp
         QV1V+gvjBdwJ4B69tk04Whuci2g3ctdbk71Y++v+uw4QjwBKKPs1ZOXfQPYLKLB62V
         ovDOwvxjScnVw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 02B03CE0902; Tue, 25 Jul 2023 09:33:46 -0700 (PDT)
Date:   Tue, 25 Jul 2023 09:33:46 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        rcu@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [BUG] Re: Linux 6.4.4
Message-ID: <749b68ac-da4d-452e-883a-d7065b3b3c30@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <4b231ce5-7bb8-4abf-9c40-04aa676d1e45@paulmck-laptop>
 <123C6650-490B-4D08-96B4-39B118AD0054@joelfernandes.org>
 <fa417689-cf91-4687-8308-3ffe6759cf1d@paulmck-laptop>
 <20230725153017.GA1191712@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230725153017.GA1191712@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 03:30:17PM +0000, Joel Fernandes wrote:
> On Mon, Jul 24, 2023 at 04:17:32PM -0700, Paul E. McKenney wrote:
> > On Mon, Jul 24, 2023 at 07:04:14PM -0400, Joel Fernandes wrote:
> > > 
> > > 
> > > > On Jul 24, 2023, at 12:00 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > 
> > > > ﻿On Mon, Jul 24, 2023 at 09:36:02AM -0400, Joel Fernandes wrote:
> > > >>> On Sun, Jul 23, 2023 at 11:35 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >>> 
> > > >>> On Mon, Jul 24, 2023 at 12:32:57AM +0000, Joel Fernandes wrote:
> > > >>>> On Sun, Jul 23, 2023 at 10:19:27AM -0700, Paul E. McKenney wrote:
> > > >>>>> On Sun, Jul 23, 2023 at 10:50:26AM -0400, Joel Fernandes wrote:
> > > >>>>>> 
> > > >>>>>> 
> > > >>>>>> On 7/22/23 13:27, Paul E. McKenney wrote:
> > > >>>>>> [..]
> > > >>>>>>> 
> > > >>>>>>> OK, if this kernel is non-preemptible, you are not running TREE03,
> > > >>>>>>> correct?
> > > >>>>>>> 
> > > >>>>>>>> Next plan of action is to get sched_waking stack traces since I have a
> > > >>>>>>>> very reliable repro of this now.
> > > >>>>>>> 
> > > >>>>>>> Too much fun!  ;-)
> > > >>>>>> 
> > > >>>>>> For TREE07 issue, it is actually the schedule_timeout_interruptible(1)
> > > >>>>>> in stutter_wait() that is beating up the CPU0 for 4 seconds.
> > > >>>>>> 
> > > >>>>>> This is very similar to the issue I fixed in New year in d52d3a2bf408
> > > >>>>>> ("torture: Fix hang during kthread shutdown phase")
> > > >>>>> 
> > > >>>>> Agreed, if there are enough kthreads, and all the kthreads are on a
> > > >>>>> single CPU, this could consume that CPU.
> > > >>>>> 
> > > >>>>>> Adding a cond_resched() there also did not help.
> > > >>>>>> 
> > > >>>>>> I think the issue is the stutter thread fails to move spt forward
> > > >>>>>> because it does not get CPU time. But spt == 1 should be very brief
> > > >>>>>> AFAIU. I was wondering if we could set that to RT.
> > > >>>>> 
> > > >>>>> Or just use a single hrtimer-based wait for each kthread?
> > > >>>> 
> > > >>>> [Joel]
> > > >>>> Yes this might be better, but there's still the issue that spt may not be set
> > > >>>> back to 0 in some future release where the thread gets starved.
> > > >>> 
> > > >>> But if each thread knows the absolute time at which the current stutter
> > > >>> period is supposed to end, there should not be any need for the spt
> > > >>> variable, correct?
> > > >> 
> > > >> Yes.
> > > >> 
> > > >>>>>> But also maybe the following will cure it like it did for the shutdown
> > > >>>>>> issue, giving the stutter thread just enough CPU time to move spt forward.
> > > >>>>>> 
> > > >>>>>> Now I am trying the following and will let it run while I go do other
> > > >>>>>> family related things. ;)
> > > >>>>> 
> > > >>>>> Good point, if this avoids the problem, that gives a strong indication
> > > >>>>> that your hypothesis on the root cause is correct.
> > > >>>> 
> > > >>>> [Joel]
> > > >>>> And the TREE07 issue is gone with that change!
> > > >> [...]
> > > >>>> Let me know what you think, thanks!
> > > >>> 
> > > >>> If we can make the stutter kthread set an absolute time for the current
> > > >>> stutter period to end, then we should be able to simplify the code quite
> > > >>> a bit and get rid of the CPU consumption entirely.  (Give or take the
> > > >>> possible need for a given thread to check whether it was erroneously
> > > >>> awakened early.)
> > > >>> 
> > > >>> But what specifically did you have in mind?
> > > >> 
> > > >> I was thinking of a 2 counter approach storing the absolute time. Use
> > > >> an alternative counter for different stuttering sessions. But yes,
> > > >> generally I agree with the absolute time idea. What do you think Paul?
> > > >> 
> > > >> Do we want to just do  the simpler schedule_timeout at HZ / 20 to keep stable
> > > >> green, and do the absolute-time approach for mainline? That might be better
> > > >> from a process PoV. But I think stable requires patches to be upstream. Greg?
> > > >> 
> > > >> I will try to send out patches this week to discuss this, thanks,
> > > > 
> > > > Heh!!!
> > > > 
> > > > Me, I was just thinking of mainline.  ;-)
> > > 
> > > Turns out it is simple enough for both mainline and stable :-).
> > > Will test more and send it out soon.
> > 
> > Woo-hoo!!!  Some times you get lucky!
> 
> Better luck today than yesterday since yesterday a Linux distro update
> stalled my development. :-). Thanks to backups that I got back up quickly..
> 
> Here is the mostly tested patch as preview. I am running the full suite now
> after confirming it fixed TREE07. Looks OK? (I also confirmed with prints
> that stuttering timing is the same as before).

Looks quite plausible, thank you!

							Thanx, Paul

> ---8<-----------------------
> 
> From: Joel Fernandes <joelaf@google.com>
> Subject: [PATCH] rcutorture: Fix stuttering races and other issues
> 
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
> -- 
> 2.41.0.487.g6d72f3e995-goog
> 
