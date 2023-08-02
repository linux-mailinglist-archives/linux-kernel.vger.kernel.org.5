Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1C876D4F7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjHBRUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjHBRUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:20:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A2F194;
        Wed,  2 Aug 2023 10:20:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0193461A33;
        Wed,  2 Aug 2023 17:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56677C433C7;
        Wed,  2 Aug 2023 17:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690996816;
        bh=G1ZqlvVLhqnJmweScyr8cCpL2db0z118pIKtokAkSOw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=W6mw66bo57BQ8IwLdJc+wT3rOruze/svflCCPm+GE0UBZ1sIbeih9CMCMeojiWpsr
         PAYOXrncMGsArfcqxNt8JNogF5PhbrPFbqvCAVP9I5gNhZtDSc1rz6hzjfuDQl6qPw
         p3Q/yDmFFXm3T4cMFg+UOAbeSHwDyvDyL4nanpzZctis/qSoveXsJDL98B4W9g4RH+
         Owg0lfwPe+PQ+6qFB5XooHx+CvLASmq2lLeiRcMfMVt9PLuvw8d90QAmw4qkelNtUA
         PF5n4OIShcKGmIbssvG8CCQ1oP5YRfYXueRT0DEwOiYkn1xVdv0SdbQUj/YawVH6fi
         uskuWkW4uRQzQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E2105CE0922; Wed,  2 Aug 2023 10:20:15 -0700 (PDT)
Date:   Wed, 2 Aug 2023 10:20:15 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Roy Hopkins <rhopkins@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Pavel Machek <pavel@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        rcu@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Subject: Re: scheduler problems in -next (was: Re: [PATCH 6.4 000/227]
 6.4.7-rc1 review)
Message-ID: <b31ead5b-d410-4b34-b580-81af6fabb4d0@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230731145232.GM29590@hirez.programming.kicks-ass.net>
 <7ff2a2393d78275b14ff867f3af902b5d4b93ea2.camel@suse.de>
 <20230731161452.GA40850@hirez.programming.kicks-ass.net>
 <baa58a8e-54f0-2309-b34e-d62999a452a1@roeck-us.net>
 <20230731211517.GA51835@hirez.programming.kicks-ass.net>
 <a05743a3-4dec-6af7-302f-d1d2a0db7d3e@roeck-us.net>
 <8215f037-63e9-4e92-8403-c5431ada9cc9@paulmck-laptop>
 <4f18d78411a5477690640a168e0e5d9f28d1c015.camel@suse.de>
 <063a2eba-6b5e-40bc-afd4-7d26f12762e4@paulmck-laptop>
 <2568f0ca-af88-4001-79c4-571a9b6a8fb3@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2568f0ca-af88-4001-79c4-571a9b6a8fb3@roeck-us.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 08:45:06AM -0700, Guenter Roeck wrote:
> On 8/2/23 08:05, Paul E. McKenney wrote:
> > On Wed, Aug 02, 2023 at 02:57:56PM +0100, Roy Hopkins wrote:
> > > On Tue, 2023-08-01 at 12:11 -0700, Paul E. McKenney wrote:
> > > > On Tue, Aug 01, 2023 at 10:32:45AM -0700, Guenter Roeck wrote:
> > > > 
> > > > 
> > > > Please see below for my preferred fix.  Does this work for you guys?
> > > > 
> > > > Back to figuring out why recent kernels occasionally to blow up all
> > > > rcutorture guest OSes...
> > > > 
> > > >                                                          Thanx, Paul
> > > > 
> > > > ------------------------------------------------------------------------
> > > > 
> > > > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > > > index 7294be62727b..2d5b8385c357 100644
> > > > --- a/kernel/rcu/tasks.h
> > > > +++ b/kernel/rcu/tasks.h
> > > > @@ -570,10 +570,12 @@ static void rcu_tasks_one_gp(struct rcu_tasks *rtp, bool midboot)
> > > >          if (unlikely(midboot)) {
> > > >                  needgpcb = 0x2;
> > > >          } else {
> > > > +               mutex_unlock(&rtp->tasks_gp_mutex);
> > > >                  set_tasks_gp_state(rtp, RTGS_WAIT_CBS);
> > > >                  rcuwait_wait_event(&rtp->cbs_wait,
> > > >                                     (needgpcb = rcu_tasks_need_gpcb(rtp)),
> > > >                                     TASK_IDLE);
> > > > +               mutex_lock(&rtp->tasks_gp_mutex);
> > > >          }
> > > >          if (needgpcb & 0x2) {
> > > 
> > > Your preferred fix looks good to me.
> > > 
> > > With the original code I can quite easily reproduce the problem on my
> > > system every 10 reboots or so. With your fix in place the problem no
> > > longer occurs.
> > 
> > Very good, thank you!  May I add your Tested-by?
> > 
> 
> FWIW, I am still working on it. So far I get
> 
> [    8.191589]     KTAP version 1
> [    8.191769]     # Subtest: kunit_executor_test
> [    8.191972]     # module: kunit
> [    8.192012]     1..8
> [    8.197643]     ok 1 parse_filter_test
> [    8.201851]     ok 2 filter_suites_test
> [    8.206713]     ok 3 filter_suites_test_glob_test
> [    8.211806]     ok 4 filter_suites_to_empty_test
> [    8.214077] kunit executor: filter operation not found: speed>slow, module!=example
> [    8.217933]     # parse_filter_attr_test: ASSERTION FAILED at lib/kunit/executor_test.c:126
> [    8.217933]     Expected err == 0, but
> [    8.217933]         err == -22 (0xffffffffffffffea)
> [    8.217933]
> [    8.217933] failed to parse filter '(efault)'
> [    8.221266]     not ok 5 parse_filter_attr_test
> [    8.224224] kunit executor: filter operation not found: speed>slow
> [    8.225837]     # filter_attr_test: ASSERTION FAILED at lib/kunit/executor_test.c:165
> [    8.225837]     Expected err == 0, but
> [    8.225837]         err == -22 (0xffffffffffffffea)
> [    8.228850]     not ok 6 filter_attr_test
> [    8.230942] kunit executor: filter operation not found: module!=dummy
> [    8.232167]     # filter_attr_empty_test: ASSERTION FAILED at lib/kunit/executor_test.c:190
> [    8.232167]     Expected err == 0, but
> [    8.232167]         err == -22 (0xffffffffffffffea)
> [    8.235317]     not ok 7 filter_attr_empty_test
> [    8.237065] kunit executor: filter operation not found: speed>slow
> [    8.238796]     # filter_attr_skip_test: ASSERTION FAILED at lib/kunit/executor_test.c:209
> [    8.238796]     Expected err == 0, but
> [    8.238796]         err == -22 (0xffffffffffffffea)
> [    8.241897]     not ok 8 filter_attr_skip_test
> [    8.241947] # kunit_executor_test: pass:4 fail:4 skip:0 total:8
> [    8.242144] # Totals: pass:4 fail:4 skip:0 total:8
> 
> and it looks like the console no longer works. Most likely this is some other problem
> that was introduced while tests were broken. It will take me some time to track that down.

No rush.

Given that this bug is a year old, that it happens only when debug
options are enabled, and that it has only been seen in current -next,
my plan is to submit it into the next merge window.

So this one stays mutable for about another 10 days.

On the strength of Roy's Tested-by, however, I will push this patch into
-next soon, so that should make things a bit easier.  Or so I hope.

And again, thank you all for tracking this down!

							Thanx, Paul
