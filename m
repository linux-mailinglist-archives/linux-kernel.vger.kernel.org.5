Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865007F8692
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 00:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjKXW6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 17:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjKXW6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 17:58:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E07170B
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 14:58:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A37F8C433C7;
        Fri, 24 Nov 2023 22:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700866735;
        bh=6JB2cmvFWNvbLTHf+R4y9qgwUrffC1tyRDmPTqkNXIE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=etw+B/63RkQEOkN3ww9VTmsbXl6RL95UORtpGz/pklCS7bf/iLZqu75A0Ewn1upqz
         I+9WQvDm1ZFVTW8LkTrncxRiX5PF7lwuFg0r+fACh8XBtmq/GGQUHLZWcEeiq1aSSw
         10b/ANLJRbKEGKdnpMvz7vdDwTJ4VKM5dvomB9HLVNRLokrjMlTLg95IK0151ezd6V
         IMSPDzxJ1kW0T03QuTDNwTGDuzvf11x0wL8CQYm8MMwuDVsB09MnjoOFbm2yJoLJcn
         CPihLZOGYphImXMPIG9PWPMOjVeuPOnNpd32hbeita/ejg1hnLOcV6MfGJnUFPJqLh
         yR9OeJJltquyA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 33C03CE0BDB; Fri, 24 Nov 2023 14:58:55 -0800 (PST)
Date:   Fri, 24 Nov 2023 14:58:55 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/21] coda_flag_children(): cope with dentries
 turning negative
Message-ID: <6435833a-bdcb-4114-b29d-28b7f436d47d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231124060200.GR38156@ZenIV>
 <20231124060422.576198-1-viro@zeniv.linux.org.uk>
 <20231124060422.576198-2-viro@zeniv.linux.org.uk>
 <CAHk-=whGKvjHCtJ6W4pQ0_h_k9fiFQ8V2GpM=BqYnB2X=SJ+XQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whGKvjHCtJ6W4pQ0_h_k9fiFQ8V2GpM=BqYnB2X=SJ+XQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 01:22:19PM -0800, Linus Torvalds wrote:
> On Thu, 23 Nov 2023 at 22:04, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > ->d_lock on parent does not stabilize ->d_inode of child.
> > We don't do much with that inode in there, but we need
> > at least to avoid struct inode getting freed under us...
> 
> Gaah. We've gone back and forth on this. Being non-preemptible is
> already equivalent to rcu read locking.
> 
> >From Documentation/RCU/rcu_dereference.rst:
> 
>                             With the new consolidated
>         RCU flavors, an RCU read-side critical section is entered
>         using rcu_read_lock(), anything that disables bottom halves,
>         anything that disables interrupts, or anything that disables
>         preemption.
> 
> so I actually think the coda code is already mostly fine, because that
> parent spin_lock may not stabilize d_child per se, but it *does* imply
> a RCU read lock.
> 
> So I think you should drop the rcu_read_lock/rcu_read_unlock from that patch.
> 
> But that
> 
>                 struct inode *inode = d_inode_rcu(de);
> 
> conversion is required to get a stable inode pointer.
> 
> So half of this patch is unnecessary.
> 
> Adding Paul to the cc just to verify that the docs are up-to-date and
> that we're still good here.
> 
> Because we've gone back-and-forth on the "spinlocks are an implied RCU
> read-side critical section" a couple of times.

Yes, spinlocks are implied RCU read-side critical sections.  Even in -rt,
where non-raw spinlocks are preemptible, courtesy of this:

	static __always_inline void __rt_spin_lock(spinlock_t *lock)
	{
		rtlock_might_resched();
		rtlock_lock(&lock->lock);
		rcu_read_lock();
		migrate_disable();
	}

So given -rt's preemptible spinlocks still being RCU readers, I need to
explicitly call this out in the documentation.

How about as shown below for a start?

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/Documentation/RCU/rcu_dereference.rst b/Documentation/RCU/rcu_dereference.rst
index 659d5913784d..2524dcdadde2 100644
--- a/Documentation/RCU/rcu_dereference.rst
+++ b/Documentation/RCU/rcu_dereference.rst
@@ -408,7 +408,10 @@ member of the rcu_dereference() to use in various situations:
 	RCU flavors, an RCU read-side critical section is entered
 	using rcu_read_lock(), anything that disables bottom halves,
 	anything that disables interrupts, or anything that disables
-	preemption.
+	preemption.  Please note that spinlock critical sections
+	are also implied RCU read-side critical sections, even when
+	they are preemptible, as they are in kernels built with
+	CONFIG_PREEMPT_RT=y.
 
 2.	If the access might be within an RCU read-side critical section
 	on the one hand, or protected by (say) my_lock on the other,
