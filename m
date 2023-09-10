Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C5979A011
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 23:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbjIJVR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 17:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjIJVRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 17:17:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D8B188;
        Sun, 10 Sep 2023 14:17:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D964C433D9;
        Sun, 10 Sep 2023 21:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694380639;
        bh=6y+5JQAtoGDJPQ/gP5gfj0PWf74JgBdlv8t1BNLkVE0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=COS/NHZcGSjCvRXnU3GiksfbUQjnoh4ljDeKs750yu1CKMi1XnLFQQ9az5wrawzaX
         otVZGXNA+xVEUK38InHmchqV8BSLMqqzDr+5LwqINuh4htX3m6+iF6sqOeD+MO+B/f
         a8nL+ZoX/vjA9eshIYAQgykoL3qVo420ZNf2pzWw6LblMt8KXW/Mb//EU9XBvyTFMh
         QcfoueaxwZgViYFAI9XTJUXTqyDMyUmA5uXxBz9Ha41jBAC9b1j2EVTcaCtb1OXX9e
         Bp+92wYmC7pmV6HAQodn9sCgwvhTrIPpSgGa3ZDg5uZQHQKVMXAAZO7YjpvsItVAA2
         ada7cPoJ9i52g==
Date:   Sun, 10 Sep 2023 23:17:16 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH 03/10] rcu/nocb: Remove needless LOAD-ACQUIRE
Message-ID: <ZP4yXP1LQkTfqrHg@localhost.localdomain>
References: <20230908203603.5865-1-frederic@kernel.org>
 <20230908203603.5865-4-frederic@kernel.org>
 <CAEXW_YTxSft0cZkq6UOsdkDxLCjMZfqqK3fBVz6He0UebCqS+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YTxSft0cZkq6UOsdkDxLCjMZfqqK3fBVz6He0UebCqS+g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Fri, Sep 08, 2023 at 09:48:44PM -0400, Joel Fernandes a écrit :
> On Fri, Sep 8, 2023 at 4:36 PM Frederic Weisbecker <frederic@kernel.org> wrote:
> >
> > The LOAD-ACQUIRE access performed on rdp->nocb_cb_sleep advertizes
> > ordering callback execution against grace period completion. However
> > this is contradicted by the following:
> >
> > * This LOAD-ACQUIRE doesn't pair with anything. The only counterpart
> >   barrier that can be found is the smp_mb() placed after callbacks
> >   advancing in nocb_gp_wait(). However the barrier is placed _after_
> >   ->nocb_cb_sleep write.
> 
> Hmm, on one side you have:
> 
> WRITE_ONCE(rdp->nocb_cb_sleep, false);
> smp_mb();
> swake_up_one(&rdp->nocb_cb_wq);   /* wakeup -- consider this to be a STORE */
> 
> And on another side you have:
> swait_event_interruptible_exclusive(rdp->nocb_cb_wq, ..cond..) /*
> consider this to be a LOAD */
> smp_load_acquire(&rdp->nocb_cb_sleep)
> /* exec CBs (LOAD operations) */
> 
> So there seems to be pairing AFAICS.

I must be confused, that would give such pattern:

         WRITE X                LOAD Y
         smp_mb()
         WRITE Y                smp_load_acquire(X)

How does this pair?

> 
> But maybe you are referring to pairing between advancing the callbacks
> and storing to nocb_cb_sleep. In this case, the RELEASE of the nocb
> unlock operation just after advancing should be providing the
> ordering

Right.

> but we still need the acquire this patch deletes.

Why?

> 
> > * Callbacks can be concurrently advanced between the LOAD-ACQUIRE on
> >   ->nocb_cb_sleep and the call to rcu_segcblist_extract_done_cbs() in
> >   rcu_do_batch(), making any ordering based on ->nocb_cb_sleep broken.
> 
> If you don't mind, could you elaborate more?

So imagine:

1) Some callbacks are pending
2) A grace period completes, nocb_gp_wait() advance some callbacks to DONE and
   some callbacks to WAIT, another grace period starts to handle the latter.
3) Because some callbacks are ready to invoke, nocb_gp_wait() sets
   rdp->nocb_cb_sleep to false and wakes up nocb_cb_wait()
4) nocb_cb_wait() does smp_load_acquire(rdp->nocb_cb_sleep) and proceeds
   with rcu_do_batch() but it gets preempted right before.
5) The new grace period completes.
6) nocb_gp_wait() does one more round and advances the WAIT callbacks to the
   non-empty DONE segment. Also it doesn't need to wake up nocb_cb_wait()
   since it's pending and ->nocb_cb_sleep is still false but it force writes
   again ->nocb_cb_sleep to false.
7) nocb_cb_wait() resumes and calls rcu_do_batch() without doing a new
   load-acquire on ->nocb_cb_sleep, this means the ordering only applies to the
   callbacks that were moved to DONE on step 2) but not to those moved to DONE
   on step 6).

> 
> > * Both rcu_segcblist_extract_done_cbs() and rcu_advance_cbs() are called
> >   under the nocb_lock, the latter hereby providing already the desired
> >   ACQUIRE semantics.
> 
> The acquire orders loads to nocb_cb_sleep with all later loads/stores.
> I am not sure how nocb_lock gives that same behavior since that's
> doing ACQUIRE on the lock access itself and not on nocb_cb_sleep
> access, I'd appreciate it if we can debate this out.

Well, the nocb_lock releases not only the write to nocb_cb_sleep but also
everything that precedes it. So it plays the same role and, most importantly,
it's acquired before calling rcu_segcblist_extract_done_cbs().

> 
> Every few months I need a memory-ordering workout so this can be that.
> ;-) You could be onto something.

No worries, I have some more headaches upcoming for all of us on the plate  ;-)

Thanks.
