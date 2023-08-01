Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B1B76BD68
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 21:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbjHATLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 15:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjHATLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 15:11:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AB21FFD;
        Tue,  1 Aug 2023 12:11:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E75E616AE;
        Tue,  1 Aug 2023 19:11:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E61C433C7;
        Tue,  1 Aug 2023 19:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690917064;
        bh=I5IRbbk5GYsrJAddIdo+1EAx+W7o18ZR/bm/hKMCs0U=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=nUeYYOy2Gu9i2qPYiR+4CKM2bYReaet0i38eiL8kxwMksQ1i/bxlHN4OK1RZ8A6p8
         5ED7U2ui0RUWLiURWSl2vCgwX10E4yqjMrnBMWQ0DcdXzDSqohk7H8AZ/WLcNVgJYx
         +M3oTCc9tpoHIyJVc8aOyQLP58p3x8UzK6th8cOaF/2VZZYk0cxPQqKJfiHWZ8yQEa
         mkKhi0koiAJDUx77Zey9rR6VIn1Zr2Wk6uRoMj0OS6dq9uXdEChiT7gdWyqYJsDLUs
         uXoB4oRObaHkc6Wuwptx3UHgaOABBy2Vdj5xNODaG7DxCOwx7Z6qkASybTS9SxWflG
         gaG/fmTC3meHQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 42F01CE0908; Tue,  1 Aug 2023 12:11:04 -0700 (PDT)
Date:   Tue, 1 Aug 2023 12:11:04 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Roy Hopkins <rhopkins@suse.de>,
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
Message-ID: <8215f037-63e9-4e92-8403-c5431ada9cc9@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <3da81a5c-700b-8e21-1bde-27dd3a0b8945@roeck-us.net>
 <20230731141934.GK29590@hirez.programming.kicks-ass.net>
 <20230731143954.GB37820@hirez.programming.kicks-ass.net>
 <f5a18aa3-9db7-6ad2-33d5-3335a18e4e2f@roeck-us.net>
 <20230731145232.GM29590@hirez.programming.kicks-ass.net>
 <7ff2a2393d78275b14ff867f3af902b5d4b93ea2.camel@suse.de>
 <20230731161452.GA40850@hirez.programming.kicks-ass.net>
 <baa58a8e-54f0-2309-b34e-d62999a452a1@roeck-us.net>
 <20230731211517.GA51835@hirez.programming.kicks-ass.net>
 <a05743a3-4dec-6af7-302f-d1d2a0db7d3e@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a05743a3-4dec-6af7-302f-d1d2a0db7d3e@roeck-us.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 10:32:45AM -0700, Guenter Roeck wrote:
> On 7/31/23 14:15, Peter Zijlstra wrote:
> > On Mon, Jul 31, 2023 at 09:34:29AM -0700, Guenter Roeck wrote:
> > > > Ha!, I was poking around the same thing. My hack below seems to (so far,
> > > > <20 boots) help things.
> > > > 
> > > 
> > > So, dumb question:
> > > How comes this bisects to "sched/fair: Remove sched_feat(START_DEBIT)" ?
> > 
> > That commit changes the timings of things; dumb luck otherwise.
> 
> Kind of scary. So I only experienced the problem because the START_DEBIT patch
> happened to be queued roughly at the same time, and it might otherwise have
> found its way unnoticed into the upstream kernel. That makes me wonder if this
> or other similar patches may uncover similar problems elsewhere in the kernel
> (i.e., either hide new or existing race conditions or expose existing ones).
> 
> This in turn makes me wonder if it would be possible to define a test which
> would uncover such problems without the START_DEBIT patch. Any idea ?

Thank you all for tracking this down!

One way is to put a schedule_timeout_idle(100) right before the call to
rcu_tasks_one_gp() from synchronize_rcu_tasks_generic().  That is quite
specific to this particular issue, but it does have the virtue of making
it actually happen in my testing.

There have been a few academic projects that inject delays at points
chosen by various heuristics plus some randomness.  But this would be
a bit of a challenge to those because each kernel only passes through
this window once at boot time.

Please see below for my preferred fix.  Does this work for you guys?

Back to figuring out why recent kernels occasionally to blow up all
rcutorture guest OSes...

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 7294be62727b..2d5b8385c357 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -570,10 +570,12 @@ static void rcu_tasks_one_gp(struct rcu_tasks *rtp, bool midboot)
 	if (unlikely(midboot)) {
 		needgpcb = 0x2;
 	} else {
+		mutex_unlock(&rtp->tasks_gp_mutex);
 		set_tasks_gp_state(rtp, RTGS_WAIT_CBS);
 		rcuwait_wait_event(&rtp->cbs_wait,
 				   (needgpcb = rcu_tasks_need_gpcb(rtp)),
 				   TASK_IDLE);
+		mutex_lock(&rtp->tasks_gp_mutex);
 	}
 
 	if (needgpcb & 0x2) {
