Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0ADF799FB2
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 22:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbjIJU3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 16:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjIJU3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 16:29:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5AC39C;
        Sun, 10 Sep 2023 13:29:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6878C433C7;
        Sun, 10 Sep 2023 20:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694377751;
        bh=kQBp9/WFo7WtyQmJbHkY65UiWyG7LsfGgozms1zXFK4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YVZhELoW893Q6aKqo5TwF7DDj9glv/DIwiv0UbD5+T4ryIQPqDOTD7PLwgNy2LQRO
         dPvVGqg3FI5czcUUgSlj5YZDkB1ISUaaNVcwp2LXAoQY5jEIj0gp+T4eCRT9NxNCZb
         xggIjmDezpX5EPL4pqgKVVnFnfY9K1akJgYIC2N2Wx4d+rKKjbaFiRKV9Wx6g8GwiY
         SC30N88Rp7pSDvw1LUvb95GzXDmdvqJQ48KHBqTaUgygEy7eXfnE48j+IugjDR+4bp
         6HPKHo2MhWUTR3DFGl1iDhZUnuDRGmOpMiNsypGcogfa2wsKwBT0g0jOJJXyTK4pjW
         dLtVC4vglVHDg==
Date:   Sun, 10 Sep 2023 22:29:08 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>
Subject: Re: [PATCH 04/10] rcu/nocb: Remove needless full barrier after
 callback advancing
Message-ID: <ZP4nFCTZiHRtn5Zz@localhost.localdomain>
References: <20230908203603.5865-1-frederic@kernel.org>
 <20230908203603.5865-5-frederic@kernel.org>
 <20230909043125.GA3920383@google.com>
 <ZPy3-MS7uOJfmJhs@boqun-archlinux>
 <20230910040923.GA762577@google.com>
 <ZP4kSwWkUdf-rfRW@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZP4kSwWkUdf-rfRW@localhost.localdomain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Sun, Sep 10, 2023 at 10:17:15PM +0200, Frederic Weisbecker a écrit :
> Le Sun, Sep 10, 2023 at 12:09:23AM -0400, Joel Fernandes a écrit :
> > On Sat, Sep 09, 2023 at 11:22:48AM -0700, Boqun Feng wrote:
> > > On Sat, Sep 09, 2023 at 04:31:25AM +0000, Joel Fernandes wrote:
> > > > On Fri, Sep 08, 2023 at 10:35:57PM +0200, Frederic Weisbecker wrote:
> > > > > A full barrier is issued from nocb_gp_wait() upon callbacks advancing
> > > > > to order grace period completion with callbacks execution.
> > > > > 
> > > > > However these two events are already ordered by the
> > > > > smp_mb__after_unlock_lock() barrier within the call to
> > > > > raw_spin_lock_rcu_node() that is necessary for callbacks advancing to
> > > > > happen.
> > > > > 
> > > > > The following litmus test shows the kind of guarantee that this barrier
> > > > > provides:
> > > > > 
> > > > > 	C smp_mb__after_unlock_lock
> > > > > 
> > > > > 	{}
> > > > > 
> > > > > 	// rcu_gp_cleanup()
> > > > > 	P0(spinlock_t *rnp_lock, int *gpnum)
> > > > > 	{
> > > > > 		// Grace period cleanup increase gp sequence number
> > > > > 		spin_lock(rnp_lock);
> > > > > 		WRITE_ONCE(*gpnum, 1);
> > > > > 		spin_unlock(rnp_lock);
> > > > > 	}
> > > > > 
> > > > > 	// nocb_gp_wait()
> > > > > 	P1(spinlock_t *rnp_lock, spinlock_t *nocb_lock, int *gpnum, int *cb_ready)
> > > > > 	{
> > > > > 		int r1;
> > > > > 
> > > > > 		// Call rcu_advance_cbs() from nocb_gp_wait()
> > > > > 		spin_lock(nocb_lock);
> > > > > 		spin_lock(rnp_lock);
> > > > > 		smp_mb__after_unlock_lock();
> > > > > 		r1 = READ_ONCE(*gpnum);
> > > > > 		WRITE_ONCE(*cb_ready, 1);
> > > > > 		spin_unlock(rnp_lock);
> > > > > 		spin_unlock(nocb_lock);
> > > > > 	}
> > > > > 
> > > > > 	// nocb_cb_wait()
> > > > > 	P2(spinlock_t *nocb_lock, int *cb_ready, int *cb_executed)
> > > > > 	{
> > > > > 		int r2;
> > > > > 
> > > > > 		// rcu_do_batch() -> rcu_segcblist_extract_done_cbs()
> > > > > 		spin_lock(nocb_lock);
> > > > > 		r2 = READ_ONCE(*cb_ready);
> > > > > 		spin_unlock(nocb_lock);
> > > > > 
> > > > > 		// Actual callback execution
> > > > > 		WRITE_ONCE(*cb_executed, 1);
> > > > 
> > > > So related to this something in the docs caught my attention under "Callback
> > > > Invocation" [1]
> > > > 
> > > > <quote>
> > > > However, if the callback function communicates to other CPUs, for example,
> > > > doing a wakeup, then it is that function's responsibility to maintain
> > > > ordering. For example, if the callback function wakes up a task that runs on
> > > > some other CPU, proper ordering must in place in both the callback function
> > > > and the task being awakened. To see why this is important, consider the top
> > > > half of the grace-period cleanup diagram. The callback might be running on a
> > > > CPU corresponding to the leftmost leaf rcu_node structure, and awaken a task
> > > > that is to run on a CPU corresponding to the rightmost leaf rcu_node
> > > > structure, and the grace-period kernel thread might not yet have reached the
> > > > rightmost leaf. In this case, the grace period's memory ordering might not
> > > > yet have reached that CPU, so again the callback function and the awakened
> > > > task must supply proper ordering.
> > > > </quote>
> > > > 
> > > > I believe this text is for non-nocb but if we apply that to the nocb case,
> > > > lets see what happens.
> > > > 
> > > > In the litmus, he rcu_advance_cbs() happened on P1, however the callback is
> > > > executing on P2. That sounds very similar to the non-nocb world described in
> > > > the text where a callback tries to wake something up on a different CPU and
> > > > needs to take care of all the ordering.
> > > > 
> > > > So unless I'm missing something (quite possible), P2 must see the update to
> > > > gpnum as well. However, per your limus test, the only thing P2  does is
> > > > acquire the nocb_lock. I don't see how it is guaranteed to see gpnum == 1.
> > > 
> > > Because P1 writes cb_ready under nocb_lock, and P2 reads cb_ready under
> > > nocb_lock as well and if P2 read P1's write, then we know the serialized
> > > order of locking is P1 first (i.e. the spin_lock(nocb_lock) on P2 reads
> > > from the spin_unlock(nocb_lock) on P1), in other words:
> > > 
> > > (fact #1)
> > > 
> > > 	unlock(nocb_lock) // on P1
> > > 	->rfe
> > > 	lock(nocb_lock) // on P2
> > > 
> > > so if P1 reads P0's write on gpnum
> > > 
> > > (assumption #1)
> > > 
> > > 	W(gpnum)=1 // on P0
> > > 	->rfe
> > > 	R(gpnum)=1 // on P1
> > > 
> > > and we have
> > > 
> > > (fact #2)
> > > 
> > > 	R(gpnum)=1 // on P1
> > > 	->(po; [UL])
> > > 	unlock(nocb_lock) // on P1
> > > 
> > > combine them you get
> > > 
> > > 	W(gpnum)=1 // on P0
> > > 	->rfe           // fact #1
> > > 	->(po; [UL])    // fact #2
> > > 	->rfe           // assumption #1
> > > 	lock(nocb_lock) // on P2
> > > 	->([LKR]; po)
> > > 	M // any access on P2 after spin_lock(nocb_lock);
> > > 
> > > so
> > > 	W(gpnum)=1 // on P0
> > > 	->rfe ->po-unlock-lock-po
> > > 	M // on P2
> > > 
> > > and po-unlock-lock-po is A-culum, hence "->rfe ->po-unlock-lock-po" or
> > > "rfe; po-unlock-lock-po" is culum-fence, hence it's a ->prop, which
> > > means the write of gpnum on P0 propagates to P2 before any memory
> > > accesses after spin_lock(nocb_lock)?
> > 
> > You and Frederic are right. I confirmed this by running herd7 as well.
> > 
> > Also he adds a ->co between P2 and P3, so that's why the
> > smp_mb__after_lock_unlock() helps to keep the propogation intact. Its pretty
> > much the R-pattern extended across 4 CPUs.
> > 
> > We should probably document these in the RCU memory ordering docs.
> 
> I have to trust you on that guys, I haven't managed to spend time on
> tools/memory-model/Documentation/explanation.txt yet. But glad you sorted
> it out.

Oh and I can indeed add a comment in rcu_do_batch() -> rcu_nocb_lock_irqsave()
to tell about how the guaranteed ordering against grace period completion is
enforced. Will do on the next take.

Thanks.
