Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85E27BF997
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 13:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjJJLXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 07:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjJJLXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 07:23:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E1693;
        Tue, 10 Oct 2023 04:23:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5F8C433C8;
        Tue, 10 Oct 2023 11:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696936984;
        bh=1J6gu5kW3DbwI0FpSQCZzBm2PXMVcfvVI3Q0lV4Dx/k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LCSu6UorJ3VPK8eWT5ib55ErSdXVFUMr7d8PchJY0pog7nVRnIdZ9thT82fXx8kGU
         zIWLzBtO20IgurmylvCzNvm2kkFMhxqp442I4UmnP+Wm2t1yoaekQWwDcqPXposarG
         151VThtzPUSToFy1y2jgLVJNt7BTmax4pWAnlRVou5ROVV0Z8uCVpB4eHxHnjQfZjl
         cBkJqhadxtEFXN5TN51MCIzUstTBtM96sLW0Luy1VLpNGVMi3BAL0uLzJRnqEzrkWW
         4YOTCSLOw8uXAJ4D6r+gs4kxUf17PplZaCZBNKK/NwCCHYfi157ghffopJYnIAPPne
         tho5ApmlaGzHw==
Date:   Tue, 10 Oct 2023 13:23:01 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Yong He <zhuangel570@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>, RCU <rcu@vger.kernel.org>
Subject: Re: [PATCH 0/5] srcu fixes
Message-ID: <ZSU0FUYCLTKPLMks@lothringen>
References: <20231003232903.7109-1-frederic@kernel.org>
 <f214737a-6856-455f-ac86-9f7ec605b902@paulmck-laptop>
 <1d21ceee-56d3-4784-9e6f-0a766c773833@paulmck-laptop>
 <811d08e3-efb8-4398-8fbc-6b5d030afb15@paulmck-laptop>
 <ZR0yMdyoA5biYYxg@lothringen>
 <77322b72-1d95-46c6-9837-1d811b36336c@paulmck-laptop>
 <02d3ae63-8e52-4931-acf6-32ef69a6511a@paulmck-laptop>
 <ZR3YwR4FriKP_Pab@localhost.localdomain>
 <b8f2e454-f188-4603-b410-9b28fcbb148c@paulmck-laptop>
 <5a37a92f-2f3c-467a-83db-b2e2df22557b@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5a37a92f-2f3c-467a-83db-b2e2df22557b@paulmck-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 09:54:12AM -0700, Paul E. McKenney wrote:
> On Wed, Oct 04, 2023 at 02:54:57PM -0700, Paul E. McKenney wrote:
> > On Wed, Oct 04, 2023 at 11:27:29PM +0200, Frederic Weisbecker wrote:
> > > Le Wed, Oct 04, 2023 at 09:47:04AM -0700, Paul E. McKenney a écrit :
> > > > > The 10-hour 40-CPU SRCU-P run and pair of 10-hour 16-CPU SRCU-N runs
> > > > > completed without failure.  The others had some failures, but I need
> > > > > to look and see if any were unexpected.  In the meantime, I started a
> > > > > two-hour 40-CPU SRCU-P run and a pair of one-hour 16-CPU SRCU-N runs on
> > > > > just that first commit.  Also servicing SIGSHOWER and SIGFOOD.  ;-)
> > > > 
> > > > And the two-hour 40-CPU SRCU-P run and a pair of two-hour 16-CPU SRCU-N
> > > > runs (on only the first commit) completed without incident.
> > > > 
> > > > The other set of overnight full-stack runs had only tick-stop errors,
> > > > so I started a two-hour set on the first commit.
> > > > 
> > > > So far so good!
> > > 
> > > Very nice!
> > > 
> > > As for the tick-stop error, see the upstream fix:
> > > 
> > >    1a6a46477494 ("timers: Tag (hr)timer softirq as hotplug safe")
> > 
> > Got it, thank you!
> > 
> > And the two-hour set of 200*SRCU-N and 100*SRCU-P had only tick-stop
> > errors.  I am refreshing the test grid, and will run overnight.
> 
> And the ten-hour test passed with only the tick-stop errors, representing
> 2000 hours of SRCU-N and 1000 hours of SRCU-P.  (I ran the exact same
> stack, without the rebased fix you call out above.)

Thanks a lot!
