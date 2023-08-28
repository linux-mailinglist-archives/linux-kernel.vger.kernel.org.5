Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B4678AF57
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 13:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbjH1Lz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 07:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjH1LzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 07:55:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE47811A;
        Mon, 28 Aug 2023 04:55:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CEAF6395A;
        Mon, 28 Aug 2023 11:55:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E14C433C8;
        Mon, 28 Aug 2023 11:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693223701;
        bh=/8tAnL+tnbTvj3j/wSQn2yohVsi210nGoYiyMuVlcY0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=py/HHypFgxYMTvU/b1ByweLOSW13BoBw4KW9kfXxlRpbHRc88BeX9oHunbW8X3yTw
         zjjXxZdyA3PkmpsHSgIU/ztzFQ0o8nl/ARKXpOiDSNjo7MxXKRrBYXVSYE+Heqt6/j
         OWh/9iqK3xK/7M7SjzTO0NEokMbE+hWgwIl3VPlacmc41DslM7tzoDE/6bpCUbGRQL
         1Z+yhnvS2jilUsuzShVkZf3gH1kz3KIjTu8z6lQH3SWX9GRmPvtglchgsUF8gxDMaP
         vWwDgZVnTzs254K9+ApVpnMDm/vxENSftvEAqq00w5HuhJXIFOPC74uY1rr8/07Uj1
         aXFk9uDRP2fiw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 80603CE0930; Mon, 28 Aug 2023 04:54:59 -0700 (PDT)
Date:   Mon, 28 Aug 2023 04:54:59 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Z qiang <qiang.zhang1211@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Binbin Zhou <zhoubinbin@loongson.cn>
Subject: Re: [PATCH V4 2/2] rcu: Update jiffies in rcu_cpu_stall_reset()
Message-ID: <75b1d69e-b93f-43ba-8289-9465b9fa39a8@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <8792da20-a58e-4cc0-b3d2-231d5ade2242@paulmck-laptop>
 <CAAhV-H5BNPX8Eo3Xdy-jcYY97=xazGU+VVqoDy7qEH+VpVWFJA@mail.gmail.com>
 <24e34f50-32d2-4b67-8ec0-1034c984d035@paulmck-laptop>
 <CAAhV-H5pfDG_tsRDL4dUYykaQ1ZwQYRDrQccpULBM5+kF4i2fA@mail.gmail.com>
 <20230825232807.GA97898@google.com>
 <CAEXW_YSock304V471X_A7WrxCWtHJGx3APmSy0k7Lc0o69D9Hg@mail.gmail.com>
 <CAAhV-H6PM_KZj4_h-SdJAaseMDK2nMqqJWL8fWHhL4vUA50bQg@mail.gmail.com>
 <CAEXW_YS5dVVOQvO6tWwF7mrgtHiYgVKP_TAipzBNiaFqWDzdeQ@mail.gmail.com>
 <2681134d-cc88-49a0-a1bc-4ec0816288f6@paulmck-laptop>
 <CAAhV-H6hkyAe616BuuE2H2TqNYFXqyHpJVc_Zn4307JszuVKYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H6hkyAe616BuuE2H2TqNYFXqyHpJVc_Zn4307JszuVKYQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 07:30:43PM +0800, Huacai Chen wrote:
> Hi, Paul and Joel,
> 
> On Mon, Aug 28, 2023 at 6:47 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Sun, Aug 27, 2023 at 06:11:40PM -0400, Joel Fernandes wrote:
> > > On Sun, Aug 27, 2023 at 1:51 AM Huacai Chen <chenhuacai@kernel.org> wrote:
> > > [..]
> > > > > > > > The only way I know of to avoid these sorts of false positives is for
> > > > > > > > the user to manually suppress all timeouts (perhaps using a kernel-boot
> > > > > > > > parameter for your early-boot case), do the gdb work, and then unsuppress
> > > > > > > > all stalls.  Even that won't work for networking, because the other
> > > > > > > > system's clock will be running throughout.
> > > > > > > >
> > > > > > > > In other words, from what I know now, there is no perfect solution.
> > > > > > > > Therefore, there are sharp limits to the complexity of any solution that
> > > > > > > > I will be willing to accept.
> > > > > > > I think the simplest solution is (I hope Joel will not angry):
> > > > > >
> > > > > > Not angry at all, just want to help. ;-). The problem is the 300*HZ solution
> > > > > > will also effect the VM workloads which also do a similar reset.  Allow me few
> > > > > > days to see if I can take a shot at fixing it slightly differently. I am
> > > > > > trying Paul's idea of setting jiffies at a later time. I think it is doable.
> > > > > > I think the advantage of doing this is it will make stall detection more
> > > > > > robust in this face of these gaps in jiffie update. And that solution does
> > > > > > not even need us to rely on ktime (and all the issues that come with that).
> > > > > >
> > > > >
> > > > > I wrote a patch similar to Paul's idea and sent it out for review, the
> > > > > advantage being it purely is based on jiffies. Could you try it out
> > > > > and let me know?
> > > > If you can cc my gmail <chenhuacai@gmail.com>, that could be better.
> > >
> > > Sure, will do.
> > >
> > > > I have read your patch, maybe the counter (nr_fqs_jiffies_stall)
> > > > should be atomic_t and we should use atomic operation to decrement its
> > > > value. Because rcu_gp_fqs() can be run concurrently, and we may miss
> > > > the (nr_fqs == 1) condition.
> > >
> > > I don't think so. There is only 1 place where RMW operation happens
> > > and rcu_gp_fqs() is called only from the GP kthread. So a concurrent
> > > RMW (and hence a lost update) is not possible.
> >
> > Huacai, is your concern that the gdb user might have created a script
> > (for example, printing a variable or two, then automatically continuing),
> > so that breakpoints could happen in quick successsion, such that the
> > second breakpoint might run concurrently with rcu_gp_fqs()?
> >
> > If this can really happen, the point that Joel makes is a good one, namely
> > that rcu_gp_fqs() is single-threaded and (absent rcutorture) runs only
> > once every few jiffies.  And gdb breakpoints, even with scripting, should
> > also be rather rare.  So if this is an issue, a global lock should do the
> > trick, perhaps even one of the existing locks in the rcu_state structure.
> > The result should then be just as performant/scalable and a lot simpler
> > than use of atomics.
> 
> Sorry, I made a mistake. Yes, there is no concurrent issue, and this
> approach probably works. But I have another problem: how to ensure
> that there is a jiffies update in three calls to rcu_gp_fqs()? Or in
> other word, is three also a magic number here?

Each of the three calls to rcu_gp_fqs() involves a wakeup of and a
context switch to RCU's grace-period kthread, each of which should be
sufficient to update jiffies if initially in an out-of-date-jiffies state.
The three is to some extent magic, the idea being to avoid a situation
where an currently running FQS reenables stall warnings immediately
after gdb disables them.

Obviously, if your testing shows that some other value works better,
please do let us know so that we can update!  But we have to start
somewhere.

> And I rechecked the commit message of a80be428fbc1f1f3bc9e ("rcu: Do
> not disable GP stall detection in rcu_cpu_stall_reset()"). I don't
> know why Sergey said that the original code disables stall-detection
> forever, in fact it only disables the detection in the current GP.

Well, it does disable stall detection forever in the case where the
current grace period lasts forever, which if I recall correctly was the
case that Sergey was encountering.

							Thanx, Paul

> Huacai
> 
> >
> > > Could you test the patch for the issue you are seeing and provide your
> > > Tested-by tag? Thanks,
> >
> > Either way, testing would of course be very good!  ;-)
> >
> >                                                         Thanx, Paul
