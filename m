Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824237E59F1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 16:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbjKHPYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 10:24:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjKHPYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 10:24:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C9E1FCF;
        Wed,  8 Nov 2023 07:24:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F0A3C433C9;
        Wed,  8 Nov 2023 15:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699457049;
        bh=vUq9vUGeNt9ba5ywMzxzi9MVWrSJp4URognnPDDyJqM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=KnUCJF77aIrfv9I59Yb9yyR+fi6BsnGhPMggt2U2y5ZaNQ+ryK8YTTq8ZC5Gm7CGu
         7Jg+2sXRbk9hs64co61Ge20pklKE18Q/+TZAD853+LuwoKd0B02lDMWfsWmL6ZxBaI
         Vtkiuj4coD6jVBdB51EiQuQZHkXW3odqSYiWTzdTMhClsu7/cm6txLphj+ulvefHOW
         2rOGnxBf7zI3b5q4U/3uEEGHMFe0JT220dzt1gF9865pcm+DgDOiHGFymHntSbsqZW
         0hZkSBisgPA6pjYh6pC5x6YfDifpupwISG+tu+jJo35LPy3otM7tx92qu0amS/lilZ
         4qKdSY6hvQTKA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A2E4CCE0A4F; Wed,  8 Nov 2023 07:24:07 -0800 (PST)
Date:   Wed, 8 Nov 2023 07:24:07 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     RCU <rcu@vger.kernel.org>,
        Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v2 1/3] rcu: Reduce synchronize_rcu() latency
Message-ID: <2e4a5a1c-8fdb-4f55-8b88-4c66d3002a32@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231030131254.488186-1-urezki@gmail.com>
 <20231030131254.488186-2-urezki@gmail.com>
 <70578164-6c12-47ca-9528-163b688c1b47@paulmck-laptop>
 <ZUjWWpqOQObm8yaz@pc636>
 <988c2023-f97b-4706-8a97-e829bc030245@paulmck-laptop>
 <ZUpH7BqS3PldQf5K@pc636>
 <9cd799fd-e4e9-4a24-9e91-0443592b2960@paulmck-laptop>
 <ZUtpWbUfdesFWvDw@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUtpWbUfdesFWvDw@pc636>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2023 at 11:56:25AM +0100, Uladzislau Rezki wrote:
> > > 
> > > Do you have something that can easily trigger it? I mean some proposal
> > > or steps to test. Probably i should try what you wrote, regarding
> > > toggling from user space.
> > > 
> > > > I can imagine ways around this, but they are a bit ugly.  They end
> > > > up being things like recording a timestamp on every sysfs change to
> > > > rcu_normal, and then using that timestamp to deduce whether there could
> > > > possibly have been sysfs activity on rcu_normal in the meantime.
> > > > 
> > > > It feels like it should be so easy...  ;-)
> > > > 
> > > Hmm.. Yes it requires more deep analysis :)
> > 
> > Maybe make that WARN_ONCE() condition also test a separate Kconfig
> > option that depends on both DEBUG_KERNEL and RCU_EXPERT?
> > 
> Do you mean to introduce a new Kconfig? For example CONFIG_DEBUG_SRS:
> 
> <snip>
> config DEBUG_SRS
>         bool "Provide debugging asserts for normal synchronize_rcu() call"
>         depends on DEBUG_KERNEL && RCU_EXPERT
>         help
> 	   ...
> <snip>

Yes, in kernel/rcu/Kconfig.debug.  But please use a more self-explanatory
name, keeping in mind that Kconfig options are a global namespace.
Please at least have an "RCU" in there somewhere.  ;-)

> > > > > I was thinking about read_lock()/write_lock() since we have many readers
> > > > > and only one writer. But i do not really like it either.
> > > > 
> > > > This might be a hint that we should have multiple lists, perhaps one
> > > > per CPU.  Or lock contention could be used to trigger the transition
> > > > from a single list to multiple lists. as is done in SRCU and tasks RCU.
> > > >
> > > I do not consider to be a sync call as heavily used as other callbacks
> > > which require several workers to handle, IMHO. From the other hand my
> > > experiments show that to handle 60K-100K by NOCB gives even worse results.
> > > 
> > > > 
> > > > But I bet that there are several ways to make things work.
> > > > 
> > > Right. The main concern with read_lock()/write_lock() is a PREEMPT_RT
> > > kernels where it is a rt-mutex. It would be good to avoid of using any
> > > blocking in the gp-kthread since it is a gp driver.
> > 
> > RCU is pretty low-level, so it is OK with a raw spinlock for the list
> > manipulation.  But only the list manipulation itself.  Perhaps you are
> > worried about lock contention, but in that case, there is also the issue
> > of memory contention for the llist code.
> > 
> I do not consider a lock nor memory contention as an issue here. Whereas
> blocking on rt-mutex in the gp-kthread i consider as "not good to go with".
> raw-spinlocks are OK, but it is a per-cpu or per-node approach which i tend
> to avoid, if not, then probably per-cpu-or-node and merge everything into
> one llist to offload by one worker.

If you have a large enough system and a high enough rate of calls to
synchronize_rcu(), something is going to break.  The current llist
approach will suffer from memory contention and high cache-miss rate,
thus also suffering excessive CPU consumption.  A sleeplock will (as you
say) suffer from excessive blocking.  A spinlock (including raw spinlocks
on PREEMPT_RT) will suffer from excessive spinning and CPU consumption.

Which is why this optimization must continue to be default-off.

I agree that a change to multiple queues, perhaps up to per-CPU queueing,
would be needed to eliminate the possibility of these problems and thus
(hopefully!) make this safe for being a default-on option.  It might
even need to be dynamic, as for SRCU and Tasks RCU.  But neither of
these more-complex options need to be implemented in the initial version.

							Thanx, Paul
