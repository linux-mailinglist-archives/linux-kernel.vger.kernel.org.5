Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F4C790CC8
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 17:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240729AbjICPg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 11:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjICPg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 11:36:26 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BE4C7;
        Sun,  3 Sep 2023 08:36:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7FC6FCE0A08;
        Sun,  3 Sep 2023 15:36:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8382C433C8;
        Sun,  3 Sep 2023 15:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693755378;
        bh=rLagPt889pnH97Nh+ZUYSL4v9imFZG8zRjCeBpT8bMA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Ig1ELa6K10w9AKqVMPpZtlGi5h82ipZi1H7q28Pv5ehuV125ZaXKOJ/dE6SaxZGm5
         d2J1K0zXnlS64Oz/Ek8bwAn/URmJib2Uvufk/i5PHQopD7LNJBLCaDZYWPKXdhpwhl
         CxJR19ANFt4Opwm/Q+FaXsw+VKD6XdBhonvBP0O8Xm1QDu5obUDiFHueLeMQ8EoCTD
         hd8rj9IF6t2Q8Im0ToRxnrD8/4hDwlmyc3yEMeAzWtQIbAlpnSJMQIqgCqwff5Lshe
         wBPOba0UfSj8RIbFsFewl/rWUkMPSkdXYpsaVQThKqJqccwifY4E/qrXI0h9v0iqOK
         cz4WPirC8SWcg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 64E0ECE0C90; Sun,  3 Sep 2023 08:36:18 -0700 (PDT)
Date:   Sun, 3 Sep 2023 08:36:18 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marcus Seyfarth <m.seyfarth@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Ziwei Dai <ziwei.dai@unisoc.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: Fwd: [6.5.1] Slow boot and opening files (RIP: kvfree_rcu_bulk)
Message-ID: <bb603efb-654f-4686-bad9-0bb5379745c0@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <0e6fc43f-3078-911a-e63d-290c3e6d7b91@gmail.com>
 <bbbb0bdf-553e-4fde-90d6-446e920b357e@paulmck-laptop>
 <CA+FbhJOSfqcb3=ecL-y=13j81b1Ts13wHpzBSURyCRQUvd2NWQ@mail.gmail.com>
 <c054b588-b029-4380-9ec5-4ae50ee37d08@paulmck-laptop>
 <CA+FbhJO1FbOvP=GmUse-r8Yma1tSv6iqppDhz9Ut1JKpjN49qQ@mail.gmail.com>
 <CA+FbhJPOkV4Xa7ZJ4QF2y_-5i24F+TkhByr=LzMPt9iy9EshSQ@mail.gmail.com>
 <4009a6e0-198c-4f25-8e34-4774dcd8c537@paulmck-laptop>
 <CA+FbhJPxU+QKf1tTBd8XcKcSsTeRmJ=ji_L4QYiad--hGqRB5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+FbhJPxU+QKf1tTBd8XcKcSsTeRmJ=ji_L4QYiad--hGqRB5w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 03, 2023 at 04:06:15PM +0200, Marcus Seyfarth wrote:
> > > I should also probably add my RCU config settings here:
> > >
> > > # RCU Subsystem
> > > #
> > > CONFIG_TREE_RCU=y
> > > CONFIG_PREEMPT_RCU=y
> > > CONFIG_RCU_EXPERT=y
> > > CONFIG_TREE_SRCU=y
> > > CONFIG_TASKS_RCU_GENERIC=y
> > > # CONFIG_FORCE_TASKS_RCU is not set
> > > CONFIG_TASKS_RCU=y
> > > # CONFIG_FORCE_TASKS_RUDE_RCU is not set
> > > CONFIG_TASKS_RUDE_RCU=y
> > > # CONFIG_FORCE_TASKS_TRACE_RCU is not set
> > > CONFIG_TASKS_TRACE_RCU=y
> > > CONFIG_RCU_STALL_COMMON=y
> > > CONFIG_RCU_NEED_SEGCBLIST=y
> > > CONFIG_RCU_FANOUT=32
> > > CONFIG_RCU_FANOUT_LEAF=32
> >
> > This CONFIG_RCU_FANOUT_LEAF=32 could result in lock contention, but much
> > depends on your workload.
> 
> I followed advise of ChatGPT 3.5 on that setting (while it also warned me
> about the potential lock contention, but I haven't observed performance
> problems in my benchmarking):
> 
> ChatGPT: "Since the previous recommendation for the CONFIG_RCU_FANOUT
> option for the Intel Xeon E5-2696 v3 processor was to start with a value of
> 32, it would be appropriate to set CONFIG_RCU_FANOUT_LEAF to the same value
> of 32. This aligns the fanout value at both the inner levels and the leaf
> level of the RCU hierarchy. Keeping CONFIG_RCU_FANOUT_LEAF consistent with
> CONFIG_RCU_FANOUT helps maintain a balanced distribution of resources and
> avoids potential performance bottlenecks."

Me, I would not trust ChatGPT for this sort of thing, but it is your life,
so feel free to do what you want.

But if you for whatever reason trust ChatGPT, why don't you ask it for
the root cause of the slowdown and the the warning?  Why bother asking me?

> > CONFIG_RCU_BOOST=y
> > > CONFIG_RCU_BOOST_DELAY=2
> >
> > Boosting after only two milliseconds is supported, but aggressive.
> 
> That was also advised for gaming workloads by ChatGPT 3.5 but not as
> strongly:
> 
> ChatGPT: "For gaming performance, the impact of CONFIG_RCU_BOOST_DELAY is
> usually minimal, and the default value should be sufficient for most
> scenarios. The default value is typically set to 4 milliseconds (ms) in
> many kernel configurations. If you wish to experiment with different values
> to optimize gaming performance, you can try reducing the
> CONFIG_RCU_BOOST_DELAY value slightly. For example, you can experiment with
> values like 2 ms or even 1 ms to potentially improve responsiveness for
> real-time tasks, including the game itself."

Much of ChatGPT's response is counter-factual, as in ChatGPT just made a
fool of itself here, as it has done quite often in the past.  Please do
everyone (and especially yourself) a big favor and stop trusting its
statistical word-salad mashups regarding RCU.

Maybe the day will come when AI understands RCU, but today is not that
day.

> > > # CONFIG_RCU_EXP_KTHREAD is not set
> > > CONFIG_RCU_NOCB_CPU=y
> > > CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=y
> > > CONFIG_RCU_NOCB_CPU_CB_BOOST=y
> > > # CONFIG_TASKS_TRACE_RCU_READ_MB is not set
> > > CONFIG_RCU_LAZY=y
> >
> > As noted earlier, please try CONFIG_RCU_LAZY=y.
> 
> As CONFIG_RCU_LAZY=y is set above, I am confused by this suggestion. Do you
> want me to unset the other settings?

Apologies.

I want you to follow the advice I gave you in my earlier email, the one
with Message-ID c054b588-b029-4380-9ec5-4ae50ee37d08@paulmck-laptop.
I would give you a URL, but you seem to have dropped the public email
lists.  I have added them back.

> > > # CONFIG_RCU_DOUBLE_CHECK_CB_TIME is not set
> > > # end of RCU Subsystem
> > >
> > > I also added this to the CachyOS config file:
> > >
> > > # Suggestions from BARD for my Xeon E5-2696V3
> > > kernel.rcu_nocbs = 0
> >
> > Well and good.
> >
> > > kernel.rcu_cpu_stall_count = 18
> > > kernel.rcu_queue_length = 1024
> > > kernel.rcu_interval = 200
> >
> > I might be having a bad code-search day, but I don't see any sign of
> > any of these in mainline or in -rcu.
> >
> > Do any of the patches that added these also add a call_rcu() that is
> > invoked during the time that you observe the slowdowns?  More generally,
> > I suggest inspecting these patches carefully.  I did not take any of
> > them into account when reviewing recent changes (nor should I or any of
> > the other RCU maintainers or reviewers be expected to), so it is quite
> > possible that a recent change invalidated one of those patches.
> 
> These were not a result of any RCU extra patches. These four entries were
> added by me manually to the CachyOS-Settings file
> (/etc/sysctl.d/99-cachyos-settings.conf) that controls various knobs on
> that distro in this central place.

Unless there are additional patches (perhaps generated by ChatGPT?),
those settings do nothing.

> The only patch CachyOS ships with 6.5 that could be somewhat related is:
> https://lore.kernel.org/linux-mm/20230703184928.GB4378@monkey/T/#m36fa1f2a52341d57a8ac39f5bd2d64376d26bfe5
> 
> >From the discussion, I see that it was problematic. I will delete it in my
> next experiments.
> 
> The CachyOS Kernel default RCU settings are available under this link:
> https://github.com/CachyOS/linux-cachyos/blob/fa4eda73dd00e29fad3c98d49a8843d813b1c1fe/linux-cachyos/config#L163
> [which also reproduced the problems with the default distro Kernel 6.5.0-2].
> 
> Thanks a lot for your help!

You are welcome, but at this point, I am afraid that you are on your own.
You have the CONFIG_RCU_LAZY=n suggestion and the bisection suggestion.
I wish you the best of everything in your quest.

If this problem occurs in mainline, someone will reproduce it reasonably
soon against a clean mainline or -stable release.

							Thanx, Paul
