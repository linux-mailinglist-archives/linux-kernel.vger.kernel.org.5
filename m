Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D03AA80EF0D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 15:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376855AbjLLOnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 09:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232756AbjLLOna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 09:43:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602FBA8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 06:43:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D91A4C433C7;
        Tue, 12 Dec 2023 14:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702392216;
        bh=zH7F49ukr5k3TYZOyYjACtpnYbGPr2nPcV7/qbFxNls=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=KQozYY1liD5nj3+5l91ePLB5H3PYfPL1VqrOK4QAevDrWop5mq9bDf3Fp+jPe/ohr
         44j75TqdfEy2L5N8q5ulM14Qzoetn0lNN9ZiDQQYOIuZmE1pXj6RCRz0bD+wQE3sVe
         96DNr0m44fZ4B2xrsmoF9WhX3EUYTxFMEaoWgjMlj56JPH+QaGvwSmhxpLYY17uZfh
         vVY+3EZF3lCEwToDH/1sBkyTG0Eh3q8D6lsouRvo5dOOMndzjRC2SCiS7dbR/VZna7
         SCFFpwtWyMqnZHgxasC0YXXS3s8IqK3XInxKJQgsFsDTIubkUK3wacnBcxwBB39gNL
         J+n8QuPEUR5iw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6ED48CE042D; Tue, 12 Dec 2023 06:43:36 -0800 (PST)
Date:   Tue, 12 Dec 2023 06:43:36 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Oliver Sang <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [paulmck-rcu:dev.2023.11.08a] [EXP locktorture] 1254a620b4:
 WARNING:at_kernel/rcu/tree_stall.h:#rcu_stall_chain_notifier_register
Message-ID: <9c002d7f-01b6-4315-9b92-be3abf8b949c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202312071506.6eac1bac-oliver.sang@intel.com>
 <2ad1abcc-d82b-406f-a7b7-606224a24813@paulmck-laptop>
 <ZXfALH1TIHSH/7cN@xsang-OptiPlex-9020>
 <4be82070-4cd5-4f31-8eb4-b38853fad865@paulmck-laptop>
 <ZXgPMLDAn5ZHqvT6@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXgPMLDAn5ZHqvT6@xsang-OptiPlex-9020>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 03:43:44PM +0800, Oliver Sang wrote:
> hi, Paul,
> 
> On Mon, Dec 11, 2023 at 08:26:12PM -0800, Paul E. McKenney wrote:
> > On Tue, Dec 12, 2023 at 10:06:36AM +0800, Oliver Sang wrote:
> > > hi, Paul,
> > > 
> > > On Mon, Dec 11, 2023 at 08:59:16AM -0800, Paul E. McKenney wrote:
> > > > On Thu, Dec 07, 2023 at 04:19:56PM +0800, kernel test robot wrote:
> > > > > 
> > > > > 
> > > > > Hello,
> > > > > 
> > > > > kernel test robot noticed "WARNING:at_kernel/rcu/tree_stall.h:#rcu_stall_chain_notifier_register" on:
> > > > > 
> > > > > commit: 1254a620b4a3832e65ac01bcef769b99e34515b2 ("EXP locktorture: Add RCU CPU stall-warning notifier stub")
> > > > > https://git.kernel.org/cgit/linux/kernel/git/paulmck/linux-rcu.git dev.2023.11.08a
> > > > 
> > > > Thank you for your testing efforts!
> > > > 
> > > > This one is expected behavior by explicit request from Linus Torvalds.
> > > > The concern is that people might use this hook without understanding
> > > > the risks of losing RCU CPU stall warnings.
> > > > 
> > > > One fix would be to never specify the rcupdate.rcu_cpu_stall_notifiers
> > > > kernel boot parameter.  Another would be to forgive this warning when
> > > > that boot parameter was specified.  Your choice!  ;-)
> > > 
> > > Thanks a lot for information!
> > > 
> > > this commit (1254a620b4) is a test for this warning, am I right?
> > > when this warning mechanism goes into upstream, do you want us still report
> > > for similar cases? or we could just ignore them? Thanks!
> > 
> > This 1254a620b4 ("EXP locktorture: Add RCU CPU stall-warning notifier
> > stub") commit is a debug-only use of this facility that will never go
> > upstream, as signified by the "EXP" at the beginning of the subject line.
> > 
> > Or is there some better way than "EXP" to mark commits that are not
> > intended for mainline?
> > 
> > 							Thanx, Paul
> >
> 
> sorry, seems I didn't state it very well. let me clarify.
> 
> the 'EXP' and "This not-for-mainline commit" is very good for us to know it
> will not go into mainline.
> 
> what I asked is if this warning is triggered by other usages (not this
> debug-only test), could we still ignore them by following below guidance you
> gave us?

Ah, got it!  I could imagine someone pushing out a not-for-mainline use
of this facility in order to allow others to run their test.  Actually,
I could also imagine me doing that.  ;-)

							Thanx, Paul

> > > > One fix would be to never specify the rcupdate.rcu_cpu_stall_notifiers
> > > > kernel boot parameter.  Another would be to forgive this warning when
> > > > that boot parameter was specified.  Your choice!  ;-)
