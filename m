Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915B57BA758
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 19:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjJERJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 13:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjJERIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 13:08:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4AF49FE;
        Thu,  5 Oct 2023 09:54:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A81CEC433C7;
        Thu,  5 Oct 2023 16:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696524852;
        bh=AgguJfMtwK8c/3uwNKFmoA5/NNLqG6ARHOdwutqovnE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=roGUcmOToDAKl9V2dkTOMYuTOSR7NOQ2e9LTXH65zfZzsZpNYvZbidDEeGMvjfxXc
         3MRfvreNmABas+w2vCJWo/dxe18loFIBOfzHrhupfhKjXs0L7Zvb6iEzIKsGuPT6uZ
         OUHo9Rv+rgYBzJ6BZi3I+gOZJ3mw+DE7IR/C5ej0sTokr6mOlPA2e1jbiOIXNvtOpX
         goYtsX+nzYTziIVp74lFZxYOjZBk0CmCVijiEzgFdiTCKrBnPoniVplczh2FFyKZmP
         ++cYc7NYGtKll2yhmmisbJUIqLSUz8ElP2c4aVAX8HWQI7AXTufLLDhr/6U6M531u6
         0RTWx64nhjgTg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4D7F0CE0869; Thu,  5 Oct 2023 09:54:12 -0700 (PDT)
Date:   Thu, 5 Oct 2023 09:54:12 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Yong He <zhuangel570@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>, RCU <rcu@vger.kernel.org>
Subject: Re: [PATCH 0/5] srcu fixes
Message-ID: <5a37a92f-2f3c-467a-83db-b2e2df22557b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231003232903.7109-1-frederic@kernel.org>
 <f214737a-6856-455f-ac86-9f7ec605b902@paulmck-laptop>
 <1d21ceee-56d3-4784-9e6f-0a766c773833@paulmck-laptop>
 <811d08e3-efb8-4398-8fbc-6b5d030afb15@paulmck-laptop>
 <ZR0yMdyoA5biYYxg@lothringen>
 <77322b72-1d95-46c6-9837-1d811b36336c@paulmck-laptop>
 <02d3ae63-8e52-4931-acf6-32ef69a6511a@paulmck-laptop>
 <ZR3YwR4FriKP_Pab@localhost.localdomain>
 <b8f2e454-f188-4603-b410-9b28fcbb148c@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b8f2e454-f188-4603-b410-9b28fcbb148c@paulmck-laptop>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 02:54:57PM -0700, Paul E. McKenney wrote:
> On Wed, Oct 04, 2023 at 11:27:29PM +0200, Frederic Weisbecker wrote:
> > Le Wed, Oct 04, 2023 at 09:47:04AM -0700, Paul E. McKenney a écrit :
> > > > The 10-hour 40-CPU SRCU-P run and pair of 10-hour 16-CPU SRCU-N runs
> > > > completed without failure.  The others had some failures, but I need
> > > > to look and see if any were unexpected.  In the meantime, I started a
> > > > two-hour 40-CPU SRCU-P run and a pair of one-hour 16-CPU SRCU-N runs on
> > > > just that first commit.  Also servicing SIGSHOWER and SIGFOOD.  ;-)
> > > 
> > > And the two-hour 40-CPU SRCU-P run and a pair of two-hour 16-CPU SRCU-N
> > > runs (on only the first commit) completed without incident.
> > > 
> > > The other set of overnight full-stack runs had only tick-stop errors,
> > > so I started a two-hour set on the first commit.
> > > 
> > > So far so good!
> > 
> > Very nice!
> > 
> > As for the tick-stop error, see the upstream fix:
> > 
> >    1a6a46477494 ("timers: Tag (hr)timer softirq as hotplug safe")
> 
> Got it, thank you!
> 
> And the two-hour set of 200*SRCU-N and 100*SRCU-P had only tick-stop
> errors.  I am refreshing the test grid, and will run overnight.

And the ten-hour test passed with only the tick-stop errors, representing
2000 hours of SRCU-N and 1000 hours of SRCU-P.  (I ran the exact same
stack, without the rebased fix you call out above.)

Looking good!

							Thanx, Paul
