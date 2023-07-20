Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0FA275B840
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 21:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjGTTrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 15:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjGTTrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 15:47:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2F31733;
        Thu, 20 Jul 2023 12:47:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 580E861C2A;
        Thu, 20 Jul 2023 19:47:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9AE6C433C7;
        Thu, 20 Jul 2023 19:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689882464;
        bh=DwX1uNy6mTJOThmesJskJiO3f0zQ/UjEjsi7fYSoDeQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=F2VOzhGEq/ehzA3T7FojKe0nvvYABR7BaAGOIDRc3zB7kyFFHA8lK54shuPEhhkmw
         LLp2y+fetfpkcgdK/tz0QUqF/4jkDeEX1t481gP22EiRadHc5WXu+y+q1onQqHz7hV
         bD5RjIft73fv8JaYtIp2mg3gqI49YTajtIv63wdTs5yvSbwgUC+PVvXBmh4okXqURx
         v07BYphbv8Om/rR6zc3kr6cAtnXbO+mNAHEDDD3JPDhHK/rdZPgkgjH53iAJw8UmrU
         awqbn9sl31zZbzDDefvpkLFAzpxSWu/hqo2rrPE3rBjBE+F4GkngTyQmohYBEIy2/F
         fi0bUPVPlLZAA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4B74ACE03CF; Thu, 20 Jul 2023 12:47:44 -0700 (PDT)
Date:   Thu, 20 Jul 2023 12:47:44 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
        jslaby@suse.cz, rcu@vger.kernel.org
Subject: Re: [BUG] Re: Linux 6.4.4
Message-ID: <eb04b7d0-2f49-4e01-be09-9062d9f08404@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <2023071940-suspect-ominous-4a6a@gregkh>
 <20230720132714.GA3726096@google.com>
 <2b8fc10b-785e-48b9-9a38-5c1af81f9578@paulmck-laptop>
 <CAEXW_YQO7OCdkXm_SBcPhAm8V8vMaF_5DQq7PbG9PZb7RFgA_g@mail.gmail.com>
 <f18e165c-9196-4b41-a202-82cfd5ac7f8b@paulmck-laptop>
 <8682b08c-347b-5547-60e0-013dcf1f8c93@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8682b08c-347b-5547-60e0-013dcf1f8c93@joelfernandes.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 03:32:35PM -0400, Joel Fernandes wrote:
> On 7/20/23 15:04, Paul E. McKenney wrote:
> > On Thu, Jul 20, 2023 at 12:31:13PM -0400, Joel Fernandes wrote:
> >> Hi Paul,
> >>
> >> On Thu, Jul 20, 2023 at 11:55 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> >>>
> >>> On Thu, Jul 20, 2023 at 01:27:14PM +0000, Joel Fernandes wrote:
> [...]
> >>>>
> >>>> So likely RCU boosting is failing:
> >>>>
> >>>> The full TREE03 splat:
> >>>> [   54.243588] ------------[ cut here ]------------
> >>>> [   54.244547] rcu-torture: rcu_torture_boost started
> [...]
> >>>> [   54.300499] RIP: 0010:rcu_torture_stats_print+0x5b2/0x620
> [...]
> >>>> [ 2169.481783] rcu_torture_writer: rtort_pipe_count: 9
> >>>>
> >>>> However, if we are to believe the '9', it appears the object did made it
> >>>> quite some till the end of the pipe array but not until the free pool.
> >>>
> >>> This is from this if/for statement, correct?
> >>>
> >>>                  stutter_waited = stutter_wait("rcu_torture_writer");
> >>>                  if (stutter_waited &&
> >>>                      !atomic_read(&rcu_fwd_cb_nodelay) &&
> >>>                      !cur_ops->slow_gps &&
> >>>                      !torture_must_stop() &&
> >>>                      boot_ended)
> >>>                          for (i = 0; i < ARRAY_SIZE(rcu_tortures); i++)
> >>>                                  if (list_empty(&rcu_tortures[i].rtort_free) &&
> >>>                                      rcu_access_pointer(rcu_torture_current) !=
> >>>                                      &rcu_tortures[i]) {
> >>>                                          tracing_off();
> >>>                                          show_rcu_gp_kthreads();
> >>>                                          WARN(1, "%s: rtort_pipe_count:
> >>>                                          rcu_ftrace_dump(DUMP_ALL);
> >>>                                  }
> >>
> >> Yes, that's right.
> >>
> >>> If so, this happens when there was a stutter wait, but RCU grace
> >>> periods failed to clear out the backlog during the several seconds that
> >>> rcutorture was forced idle.  This might be related to the RCU priority
> >>> boosting failure, in which a preempted reader persisted across the
> >>> stutter interval.
> >>
> >> When RCU is operating normally, shouldn't the check
> >> "(list_empty(&rcu_tortures[i].rtort_free)" not run until the preempted
> >> reader unblocks and exits its RCU read-side critical section?
> >
> > Yes, but not just "until", but rather "long after".  If RCU is doing
> > grace periods correctly, an active reader on a given rcu_tortures[]
> > element will prevent .rtort_pipe_count from exceeding the value 2.
> 
> Ah ok, so the rtort_pipe_count being 9 is a sign RCU isn't making progress
> thus making it absent from the free list.

Yes, though RCU is -just- -barely- too slow, as one more grace period
would have done it.

> > The element will not be put on a list until .rtort_pipe_count is equal
> > to RCU_TORTURE_PIPE_LEN, which is 10.
> >
> > This warning usually appears when something is holding up the grace-period
> > kthread.  Historically, this has included deadlocks, missed timers,
> > and whatever else can prevent the grace-period kthread from running.
> 
> Makes sense.
> 
> >> One thing that confuses me, in the case of
> >> "cur_ops->deferred_free(old_rp);" , the earlier do-while loop may exit
> >> before the async callbacks can finish. So what prevents the
> >> "(list_empty(&rcu_tortures[i].rtort_free)" check from happening before
> >> grace periods happen? Thanks for any clarification.
> >
> > We only enter this code if the stutter_wait() actually waited, and by
> > default this function will wait about five seconds.  Since the rcutorture
> > testing goes idle during this time period (or is supposed to!), if things
> > are working properly, knocking off ten grace periods during that time
> > should be pretty much a given.
> 
> Sure, makes sense. And this is not Lazy-RCU so 5 seconds should be plenty
> ;). I think I was subconsciously expecting an rcu_barrier() somewhere in the
> code before those checks, but that's not needed as you pointed that the
> stutter should be giving enough time for RCU to make progress.

And there might need to be a call_rcu_hurry() in there somewhere,
now that you mention it.  Which would pretty much defeat any sort of
lazy-RCU-callback testing in rcutorture, but testing of laziness might
need to be separate anyway.

> So hmm, the count being 9 means that not enough RCU grace periods have
> passed for the rcu_torture object in question thus keeping it always
> allocated. The GP thread not getting CPU can do that indeed, or perhaps
> something else stalling RCU like a preempted reader, length preemption
> disabling on a CPU and so forth..  I'll try to collect a trace when it
> happens.

Looking forward to seeing what you come up with!

							Thanx, Paul
