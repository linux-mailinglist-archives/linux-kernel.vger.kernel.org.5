Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD4476BF50
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 23:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbjHAVc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 17:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjHAVcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 17:32:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469B01B6;
        Tue,  1 Aug 2023 14:32:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC6326170B;
        Tue,  1 Aug 2023 21:32:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FAEEC433C7;
        Tue,  1 Aug 2023 21:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690925539;
        bh=mlLJwvIQ28in3hFDAHgMaBkqadXCSNy7GdeKaCPuqZE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=l9XhNVJGckmHfYujiSYBsJ7YApijXQj8Jo0yIajaRkRGPyQNzi0llLBftY9lUu6V0
         vzXfru2a+7ey7T7oNksxGnz2QDFBFwslI/sECS3OsqQoS0E75LuLbMoYIiq3vYLU5e
         RpSD9+k4MnTWJMNFD9KGcYsSmizswMw1fmTG9hIZjSSQeWpFASxd3EgUghuyoAqtn9
         pSxOkPoMOwG8+iVLLXlhS+/ig5tyM4urfdSxAvhIk+7cmm9jU5GvOoh5or41yNzf3W
         mI3tk6AJ0Q3HNXS5WhdTd+FKXcTXYrxlo0/CXyGJx9BFDzn7YNgMxfNGM1gw+//rFN
         TwRX76lVadhsg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B632ECE0908; Tue,  1 Aug 2023 14:32:18 -0700 (PDT)
Date:   Tue, 1 Aug 2023 14:32:18 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, Roy Hopkins <rhopkins@suse.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        Pavel Machek <pavel@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        rcu@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>
Subject: Re: scheduler problems in -next (was: Re: [PATCH 6.4 000/227]
 6.4.7-rc1 review)
Message-ID: <9154ee27-6f38-4efe-9391-ef626cdc2ff4@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230731141934.GK29590@hirez.programming.kicks-ass.net>
 <20230731143954.GB37820@hirez.programming.kicks-ass.net>
 <f5a18aa3-9db7-6ad2-33d5-3335a18e4e2f@roeck-us.net>
 <20230731145232.GM29590@hirez.programming.kicks-ass.net>
 <7ff2a2393d78275b14ff867f3af902b5d4b93ea2.camel@suse.de>
 <20230731161452.GA40850@hirez.programming.kicks-ass.net>
 <baa58a8e-54f0-2309-b34e-d62999a452a1@roeck-us.net>
 <20230731211517.GA51835@hirez.programming.kicks-ass.net>
 <a05743a3-4dec-6af7-302f-d1d2a0db7d3e@roeck-us.net>
 <20230801190852.GG11704@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801190852.GG11704@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 09:08:52PM +0200, Peter Zijlstra wrote:
> On Tue, Aug 01, 2023 at 10:32:45AM -0700, Guenter Roeck wrote:
> > On 7/31/23 14:15, Peter Zijlstra wrote:
> > > On Mon, Jul 31, 2023 at 09:34:29AM -0700, Guenter Roeck wrote:
> > > > > Ha!, I was poking around the same thing. My hack below seems to (so far,
> > > > > <20 boots) help things.
> > > > > 
> > > > 
> > > > So, dumb question:
> > > > How comes this bisects to "sched/fair: Remove sched_feat(START_DEBIT)" ?
> > > 
> > > That commit changes the timings of things; dumb luck otherwise.
> > 
> > Kind of scary. So I only experienced the problem because the START_DEBIT patch
> > happened to be queued roughly at the same time, and it might otherwise have
> > found its way unnoticed into the upstream kernel. That makes me wonder if this
> > or other similar patches may uncover similar problems elsewhere in the kernel
> > (i.e., either hide new or existing race conditions or expose existing ones).
> > 
> > This in turn makes me wonder if it would be possible to define a test which
> > would uncover such problems without the START_DEBIT patch. Any idea ?
> 
> IIRC some of the thread sanitizers use breakpoints to inject random
> sleeps, specifically to tickle races.

I have heard of are some of these, arguably including KCSAN, but they
would have a tough time on this one.

They would have to inject many milliseconds between the check of
->kthread_ptr in synchronize_rcu_tasks_generic() and that mutex_lock()
in rcu_tasks_one_gp().  Plus this window only occurs during boot shortly
before init is spawned.

On the other hand, randomly injecting delay just before acquiring each
lock would cover this case.  But such a sanitzer would still only get
one shot per boot of the kernel for this particular bug.

							Thanx, Paul
