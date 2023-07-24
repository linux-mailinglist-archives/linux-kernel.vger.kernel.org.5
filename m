Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0DE475EA17
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 05:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjGXDf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 23:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGXDfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 23:35:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76102E40;
        Sun, 23 Jul 2023 20:35:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06BE160F19;
        Mon, 24 Jul 2023 03:35:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ACB6C433C9;
        Mon, 24 Jul 2023 03:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690169752;
        bh=r8OMqjgkYTM37vdEaKCReVtxqi+YxupAe66Ipr1F05E=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=nMIAYIMiGC+CJ+TLr6JMBh8wEN3pvdoBakp3jqbUu0MmLBd9ZtXCLHZafMX0tPJZR
         uRtTSB5nrpAW8cwsL+PhREr7zCqxIHdT/RmYS3EP70PEqDEywioVs/HXatoE2sWP/P
         h1xwc4wTKie2bmDfwTqRrGAzn6mXFTP9dqg67m+SqXk00Ece3e2tVwuB2pkaV7OYnW
         1stdLtC64fwMJexMbVsU7/IsphIzn2GlHa5jTXFZPKv+wcJ22LZCyS9UrOXlpZm4Io
         P6iFseU1kmO0ET1tBW2vUgJBb+DLx5hyV3nDsPImIiviDQ6HYCZn1bZ6NBkj/Cl1GR
         csldwMNPqnNtA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D991ACE0ACC; Sun, 23 Jul 2023 20:35:51 -0700 (PDT)
Date:   Sun, 23 Jul 2023 20:35:51 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        rcu@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [BUG] Re: Linux 6.4.4
Message-ID: <381862e5-153c-4641-a60e-8175acae971d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <8682b08c-347b-5547-60e0-013dcf1f8c93@joelfernandes.org>
 <eb04b7d0-2f49-4e01-be09-9062d9f08404@paulmck-laptop>
 <32aec6d1-bf25-7b47-8f31-7b6318d5238d@joelfernandes.org>
 <9b42cb38-8375-fc41-475a-2bd26c60a7b9@joelfernandes.org>
 <5dcf7117-cec7-4772-8aad-e100484a84dc@paulmck-laptop>
 <7bfde9f4-2bd6-7337-b9ca-94a9253d847f@joelfernandes.org>
 <ad82995c-061e-4f97-a972-c13a85ad0b72@paulmck-laptop>
 <a7bcbcf2-9b34-4326-822f-e1f2aa5c5668@joelfernandes.org>
 <ebde8612-95de-4eaf-aa56-34e9b3a3fa86@paulmck-laptop>
 <20230724003257.GA60074@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724003257.GA60074@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 12:32:57AM +0000, Joel Fernandes wrote:
> On Sun, Jul 23, 2023 at 10:19:27AM -0700, Paul E. McKenney wrote:
> > On Sun, Jul 23, 2023 at 10:50:26AM -0400, Joel Fernandes wrote:
> > > 
> > > 
> > > On 7/22/23 13:27, Paul E. McKenney wrote:
> > > [..]
> > > > 
> > > > OK, if this kernel is non-preemptible, you are not running TREE03,
> > > > correct?
> > > > 
> > > >> Next plan of action is to get sched_waking stack traces since I have a
> > > >> very reliable repro of this now.
> > > > 
> > > > Too much fun!  ;-)
> > > 
> > > For TREE07 issue, it is actually the schedule_timeout_interruptible(1)
> > > in stutter_wait() that is beating up the CPU0 for 4 seconds.
> > > 
> > > This is very similar to the issue I fixed in New year in d52d3a2bf408
> > > ("torture: Fix hang during kthread shutdown phase")
> > 
> > Agreed, if there are enough kthreads, and all the kthreads are on a
> > single CPU, this could consume that CPU.
> > 
> > > Adding a cond_resched() there also did not help.
> > > 
> > > I think the issue is the stutter thread fails to move spt forward
> > > because it does not get CPU time. But spt == 1 should be very brief
> > > AFAIU. I was wondering if we could set that to RT.
> > 
> > Or just use a single hrtimer-based wait for each kthread?
> 
> [Joel]
> Yes this might be better, but there's still the issue that spt may not be set
> back to 0 in some future release where the thread gets starved.

But if each thread knows the absolute time at which the current stutter
period is supposed to end, there should not be any need for the spt
variable, correct?

> > > But also maybe the following will cure it like it did for the shutdown
> > > issue, giving the stutter thread just enough CPU time to move spt forward.
> > > 
> > > Now I am trying the following and will let it run while I go do other
> > > family related things. ;)
> > 
> > Good point, if this avoids the problem, that gives a strong indication
> > that your hypothesis on the root cause is correct.
> 
> [Joel]
> And the TREE07 issue is gone with that change! So I think I'll roll into a
> patch and send it to you. But I am also hoping that you are Ok with me
> setting the stutter thread to RT in addition to the longer schedule_timeout.
> That's just to make it more robust since I think it is crucial that it does
> not stutter threads indefinitely due to the scheduler (for any unforeseen
> reason in the future, such as scheduler issues). And maybe, as a part of
> that I could also tackle that other TODO item about cleaning up
> torture_create_kthead() as well to add support to it for setting things to
> RT and use it for that.

Very good, thank you!

> Let me know what you think, thanks!

If we can make the stutter kthread set an absolute time for the current
stutter period to end, then we should be able to simplify the code quite
a bit and get rid of the CPU consumption entirely.  (Give or take the
possible need for a given thread to check whether it was erroneously
awakened early.)

But what specifically did you have in mind?

							Thanx, Paul
