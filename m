Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A00E75E3FD
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 19:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjGWRTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 13:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjGWRTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 13:19:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5A8DF;
        Sun, 23 Jul 2023 10:19:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B09F860DE1;
        Sun, 23 Jul 2023 17:19:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 132FCC433C9;
        Sun, 23 Jul 2023 17:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690132768;
        bh=dX2SHTNsZ5to4x5tfiKvvH1U1MEL+YgckvrEklsGLL0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=cKfB+qy9SHRDmByNTnON2BAK+roy+x6g/n0nWqmq8JVQs6YVKOAy9twu01mmshXJo
         OKbNzSZZPTdolsIuWijFoi58TvSRbB7Ciw/bzpP0SqwlTg0bFg1dM59eXeCyXDxP2D
         LoEisFZdTgEnaEW/UV8x7LgHkABQSaQeoNfTA2DlqY7I6t1F+TicEi9f9XDukfjRlJ
         OYkFutQN0uKsrYYq7rstbkxMB9Wgnhzh6TBxGQyE3fh9qE/nqKF8kK6vb6g/LP5kxt
         /KGcXxXfCRNKSUR0cevFDoRAVoC1rb0P/ChTEWdKQPmMg70vbmZiYSdDxeABKtTcb0
         KqgwYxZ475M+g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A9485CE0304; Sun, 23 Jul 2023 10:19:27 -0700 (PDT)
Date:   Sun, 23 Jul 2023 10:19:27 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        rcu@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [BUG] Re: Linux 6.4.4
Message-ID: <ebde8612-95de-4eaf-aa56-34e9b3a3fa86@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CAEXW_YQO7OCdkXm_SBcPhAm8V8vMaF_5DQq7PbG9PZb7RFgA_g@mail.gmail.com>
 <f18e165c-9196-4b41-a202-82cfd5ac7f8b@paulmck-laptop>
 <8682b08c-347b-5547-60e0-013dcf1f8c93@joelfernandes.org>
 <eb04b7d0-2f49-4e01-be09-9062d9f08404@paulmck-laptop>
 <32aec6d1-bf25-7b47-8f31-7b6318d5238d@joelfernandes.org>
 <9b42cb38-8375-fc41-475a-2bd26c60a7b9@joelfernandes.org>
 <5dcf7117-cec7-4772-8aad-e100484a84dc@paulmck-laptop>
 <7bfde9f4-2bd6-7337-b9ca-94a9253d847f@joelfernandes.org>
 <ad82995c-061e-4f97-a972-c13a85ad0b72@paulmck-laptop>
 <a7bcbcf2-9b34-4326-822f-e1f2aa5c5668@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7bcbcf2-9b34-4326-822f-e1f2aa5c5668@joelfernandes.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 23, 2023 at 10:50:26AM -0400, Joel Fernandes wrote:
> 
> 
> On 7/22/23 13:27, Paul E. McKenney wrote:
> [..]
> > 
> > OK, if this kernel is non-preemptible, you are not running TREE03,
> > correct?
> > 
> >> Next plan of action is to get sched_waking stack traces since I have a
> >> very reliable repro of this now.
> > 
> > Too much fun!  ;-)
> 
> For TREE07 issue, it is actually the schedule_timeout_interruptible(1)
> in stutter_wait() that is beating up the CPU0 for 4 seconds.
> 
> This is very similar to the issue I fixed in New year in d52d3a2bf408
> ("torture: Fix hang during kthread shutdown phase")

Agreed, if there are enough kthreads, and all the kthreads are on a
single CPU, this could consume that CPU.

> Adding a cond_resched() there also did not help.
> 
> I think the issue is the stutter thread fails to move spt forward
> because it does not get CPU time. But spt == 1 should be very brief
> AFAIU. I was wondering if we could set that to RT.

Or just use a single hrtimer-based wait for each kthread?

> But also maybe the following will cure it like it did for the shutdown
> issue, giving the stutter thread just enough CPU time to move spt forward.
> 
> Now I am trying the following and will let it run while I go do other
> family related things. ;)

Good point, if this avoids the problem, that gives a strong indication
that your hypothesis on the root cause is correct.

							Thanx, Paul

> +++ b/kernel/torture.c
> @@ -733,6 +733,6 @@ bool stutter_wait(const char *title)
>                         ret = true;
>                 }
>                 if (spt == 1) {
> -                       schedule_timeout_interruptible(1);
> +                       schedule_timeout_interruptible(HZ / 20);
>                         cond_resched();
>                 } else if (spt == 2) {
> 
