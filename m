Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C97F769C10
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbjGaQP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjGaQPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:15:24 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED21A7;
        Mon, 31 Jul 2023 09:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=WO2NwJzYkKlp18843ortxVXWaoHck3bm6C+aHCT7Luk=; b=ATw9jOpGyGIz2BDGrr+lIKcKAT
        +ezdgWwZByzg4gchU3+1uJKhRhCDNY8xPW7KKdDaFmMURRUzyJtFcuiRwWYcS8w0ZfV/cTdNlBhey
        pOaqfQ86j2h9Z8mNAffl850PjIZxZjWjIcEu097JoXqT1LfM8ONTzWmjEDpNp0FcW6h3mjzA2lFOw
        CABwwPYlj6u7wOVcU+CcnauUco/FIHeyvI7i4vLXTM4jQ4OA5odjbrkZjovF4FQey75q+C8gXhiNz
        WQMoCIAbjpVRRWCVJRwPVSPgFfkwc6jcrfz3k89OJiqIn2a4m3F0YxoeKA1iVskF5hQTnH7f55Npm
        ltbnC9Ug==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qQVXp-00Csud-0g;
        Mon, 31 Jul 2023 16:14:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3AA25300134;
        Mon, 31 Jul 2023 18:14:52 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 21E5F203C0B01; Mon, 31 Jul 2023 18:14:52 +0200 (CEST)
Date:   Mon, 31 Jul 2023 18:14:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Roy Hopkins <rhopkins@suse.de>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Joel Fernandes <joel@joelfernandes.org>, paulmck@kernel.org,
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
Message-ID: <20230731161452.GA40850@hirez.programming.kicks-ass.net>
References: <2cfc68cc-3a2f-4350-a711-ef0c0d8385fd@paulmck-laptop>
 <D56D0318-A2EA-4448-8F4D-BE84706E26A5@joelfernandes.org>
 <3da81a5c-700b-8e21-1bde-27dd3a0b8945@roeck-us.net>
 <20230731141934.GK29590@hirez.programming.kicks-ass.net>
 <20230731143954.GB37820@hirez.programming.kicks-ass.net>
 <f5a18aa3-9db7-6ad2-33d5-3335a18e4e2f@roeck-us.net>
 <20230731145232.GM29590@hirez.programming.kicks-ass.net>
 <7ff2a2393d78275b14ff867f3af902b5d4b93ea2.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ff2a2393d78275b14ff867f3af902b5d4b93ea2.camel@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 05:08:29PM +0100, Roy Hopkins wrote:
> On Mon, 2023-07-31 at 16:52 +0200, Peter Zijlstra wrote:
> > On Mon, Jul 31, 2023 at 07:48:19AM -0700, Guenter Roeck wrote:
> > 
> > > > I've taken your config above, and the rootfs.ext2 and run-sh from x86/.
> > > > I've then modified run-sh to use:
> > > > 
> > > >    qemu-system-x86_64 -enable-kvm -cpu host
> > > > 
> > > > What I'm seeing is that some boots get stuck at:
> > > > 
> > > > [    0.608230] Running RCU-tasks wait API self tests
> > > > 
> > > > Is this the right 'problem' ?
> > > > 
> > > 
> > > 
> > > Yes, exactly.
> > 
> > Excellent! Let me prod that with something sharp, see what comes
> > creeping out.
> 
> In an effort to get up to speed with this area of the kernel, I've been playing
> around with this too today and managed to reproduce the problem using the same
> configuration. I'm completely new to this code but I think I may have found the
> root of the problem.
> 
> What I've found is that there is a race condition between starting the RCU tasks
> grace-period thread in rcu_spawn_tasks_kthread_generic() and a subsequent call
> to synchronize_rcu_tasks_generic(). This results in rtp->tasks_gp_mutex being
> locked in the initial thread which subsequently blocks the newly started grace-
> period thread.
> 
> The problem is that although synchronize_rcu_tasks_generic() checks to see if
> the grace-period kthread is running, it uses rtp->kthread_ptr to achieve this.
> This is only set in the thread entry point and not when the thread is created,
> meaning that it is set only after the creating thread yields or is preempted. If
> this has not happened before the next call to synchronize_rcu_tasks_generic()
> then a deadlock occurs.
> 
> I've created a debug patch that introduces a new flag in rcu_tasks that is set
> when the kthread is created and used this in synchronize_rcu_tasks_generic() in
> place of READ_ONCE(rtp->kthread_ptr). This fixes the issue in my test
> environment.
> 
> I'm happy to have a go at submitting a patch for this if it helps.

Ha!, I was poking around the same thing. My hack below seems to (so far,
<20 boots) help things.


diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 56c470a489c8..b083b5a30025 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -652,7 +658,11 @@ static void __init rcu_spawn_tasks_kthread_generic(struct rcu_tasks *rtp)
 	t = kthread_run(rcu_tasks_kthread, rtp, "%s_kthread", rtp->kname);
 	if (WARN_ONCE(IS_ERR(t), "%s: Could not start %s grace-period kthread, OOM is now expected behavior\n", __func__, rtp->name))
 		return;
-	smp_mb(); /* Ensure others see full kthread. */
+	for (;;) {
+		cond_resched();
+		if (smp_load_acquire(&rtp->kthread_ptr))
+			break;
+	}
 }
 
 #ifndef CONFIG_TINY_RCU
