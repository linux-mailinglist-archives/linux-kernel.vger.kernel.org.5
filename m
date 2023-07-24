Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E995760309
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 01:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjGXXRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 19:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjGXXRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 19:17:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED5F10FA;
        Mon, 24 Jul 2023 16:17:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3031A6140B;
        Mon, 24 Jul 2023 23:17:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642A4C433C8;
        Mon, 24 Jul 2023 23:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690240653;
        bh=AuhJ0meEb0ilI4LS4R/kOuDmIjC7JpqrRYCWmQXklVA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=E2W19COfmxbvxeM3Hp2ckOuFMY2UKGhnudGU94+jagQkXjgW53nEip/GGjdP/lipL
         0I1u+JIAPeQL+IIND38oGfFPhbyTQhE01m+7NA0i5GWEdV651UsdjQ9lKDY5HOlLdF
         8ik67UB/v+It5kolPLLrz77WhKM7TjVZn63xzHpxcYrUZWAMQ6BN3McL6GeoMf4ncm
         /XQHm05OZrMoI3A3A113BuBVNkp2UxI+3lg/2/jFLqlmNjfaNV7Fxru5j4vtSKbHdg
         7HeEtg9bVZd8SNkSQKuVkdi6jkLlBeoJmcjtgGykSFQTGMGOmZHeEMTOwahSFLN5ig
         hiRPfcsAFFAbg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id ECCCDCE0908; Mon, 24 Jul 2023 16:17:32 -0700 (PDT)
Date:   Mon, 24 Jul 2023 16:17:32 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        rcu@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [BUG] Re: Linux 6.4.4
Message-ID: <fa417689-cf91-4687-8308-3ffe6759cf1d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <4b231ce5-7bb8-4abf-9c40-04aa676d1e45@paulmck-laptop>
 <123C6650-490B-4D08-96B4-39B118AD0054@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <123C6650-490B-4D08-96B4-39B118AD0054@joelfernandes.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 07:04:14PM -0400, Joel Fernandes wrote:
> 
> 
> > On Jul 24, 2023, at 12:00 PM, Paul E. McKenney <paulmck@kernel.org> wrote:
> > 
> > ﻿On Mon, Jul 24, 2023 at 09:36:02AM -0400, Joel Fernandes wrote:
> >>> On Sun, Jul 23, 2023 at 11:35 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >>> 
> >>> On Mon, Jul 24, 2023 at 12:32:57AM +0000, Joel Fernandes wrote:
> >>>> On Sun, Jul 23, 2023 at 10:19:27AM -0700, Paul E. McKenney wrote:
> >>>>> On Sun, Jul 23, 2023 at 10:50:26AM -0400, Joel Fernandes wrote:
> >>>>>> 
> >>>>>> 
> >>>>>> On 7/22/23 13:27, Paul E. McKenney wrote:
> >>>>>> [..]
> >>>>>>> 
> >>>>>>> OK, if this kernel is non-preemptible, you are not running TREE03,
> >>>>>>> correct?
> >>>>>>> 
> >>>>>>>> Next plan of action is to get sched_waking stack traces since I have a
> >>>>>>>> very reliable repro of this now.
> >>>>>>> 
> >>>>>>> Too much fun!  ;-)
> >>>>>> 
> >>>>>> For TREE07 issue, it is actually the schedule_timeout_interruptible(1)
> >>>>>> in stutter_wait() that is beating up the CPU0 for 4 seconds.
> >>>>>> 
> >>>>>> This is very similar to the issue I fixed in New year in d52d3a2bf408
> >>>>>> ("torture: Fix hang during kthread shutdown phase")
> >>>>> 
> >>>>> Agreed, if there are enough kthreads, and all the kthreads are on a
> >>>>> single CPU, this could consume that CPU.
> >>>>> 
> >>>>>> Adding a cond_resched() there also did not help.
> >>>>>> 
> >>>>>> I think the issue is the stutter thread fails to move spt forward
> >>>>>> because it does not get CPU time. But spt == 1 should be very brief
> >>>>>> AFAIU. I was wondering if we could set that to RT.
> >>>>> 
> >>>>> Or just use a single hrtimer-based wait for each kthread?
> >>>> 
> >>>> [Joel]
> >>>> Yes this might be better, but there's still the issue that spt may not be set
> >>>> back to 0 in some future release where the thread gets starved.
> >>> 
> >>> But if each thread knows the absolute time at which the current stutter
> >>> period is supposed to end, there should not be any need for the spt
> >>> variable, correct?
> >> 
> >> Yes.
> >> 
> >>>>>> But also maybe the following will cure it like it did for the shutdown
> >>>>>> issue, giving the stutter thread just enough CPU time to move spt forward.
> >>>>>> 
> >>>>>> Now I am trying the following and will let it run while I go do other
> >>>>>> family related things. ;)
> >>>>> 
> >>>>> Good point, if this avoids the problem, that gives a strong indication
> >>>>> that your hypothesis on the root cause is correct.
> >>>> 
> >>>> [Joel]
> >>>> And the TREE07 issue is gone with that change!
> >> [...]
> >>>> Let me know what you think, thanks!
> >>> 
> >>> If we can make the stutter kthread set an absolute time for the current
> >>> stutter period to end, then we should be able to simplify the code quite
> >>> a bit and get rid of the CPU consumption entirely.  (Give or take the
> >>> possible need for a given thread to check whether it was erroneously
> >>> awakened early.)
> >>> 
> >>> But what specifically did you have in mind?
> >> 
> >> I was thinking of a 2 counter approach storing the absolute time. Use
> >> an alternative counter for different stuttering sessions. But yes,
> >> generally I agree with the absolute time idea. What do you think Paul?
> >> 
> >> Do we want to just do  the simpler schedule_timeout at HZ / 20 to keep stable
> >> green, and do the absolute-time approach for mainline? That might be better
> >> from a process PoV. But I think stable requires patches to be upstream. Greg?
> >> 
> >> I will try to send out patches this week to discuss this, thanks,
> > 
> > Heh!!!
> > 
> > Me, I was just thinking of mainline.  ;-)
> 
> Turns out it is simple enough for both mainline and stable :-).
> Will test more and send it out soon.

Woo-hoo!!!  Some times you get lucky!

							Thanx, Paul
