Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8227E05E8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 16:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344008AbjKCP6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 11:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344730AbjKCP6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 11:58:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15C2D52
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 08:58:03 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8671B1F45F;
        Fri,  3 Nov 2023 15:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1699027082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vFnigUx+7qpYC+4Dey3mI9qEiFvu9YLcz7iE7OLqZ90=;
        b=VofaeDom1pVNONfjHJKV2C4nen1wdPd5tNWU8B4lP67L1CAT0gxyWpPAAqwpd7CGiMJBKV
        ylf/2V97EZvUCkrWSnB+JZhHcmX4P1VSBrayb4HOI5DlE4HVxEX903Il9KNb2Tej0V3Bbu
        OfmrRuOaTAzOTl3ltYyIB7wO7JxcoDo=
Received: from suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CD51A2C38D;
        Fri,  3 Nov 2023 15:58:01 +0000 (UTC)
Date:   Fri, 3 Nov 2023 16:58:01 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Mukesh Ojha <quic_mojha@quicinc.com>,
        Chunlei Wang <chunlei.wang@mediatek.com>
Subject: Re: [RFC PATCH printk v1] printk: ringbuffer: Do not skip
 non-finalized with prb_next_seq()
Message-ID: <ZUUYiYpCecPoI8mv@alley>
References: <ZTkxOJbDLPy12n41@alley>
 <87zfzwp8pk.fsf@jogness.linutronix.de>
 <ZUToEzarc_F-bEXT@alley>
 <8734xnj74k.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8734xnj74k.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2023-11-03 14:37:23, John Ogness wrote:
> On 2023-11-03, Petr Mladek <pmladek@suse.com> wrote:
> >> Generally we have not concerned ourselves with readers. But I agree we
> >> should make the optimization coherent with what a reader can actually
> >> read. It might save some CPU cycles for polling tasks.
> >
> > I wanted to agree. But then I found this scenario:
> >
> > CPU0				CPU1
> >
> > console_unlock()
> >   console_flush_all()
> >
> > 				printk()
> > 				  vprintk_store()
> >     return;
> > 				    prb_final_commit;
> >
> > 				  console_trylock();  # failed

      __console_unlock();

    while (prb_read_valid() || console_trylock();

I added the __console_unlock() and console_trylock()
to have the full picture.

> >
> > Now, the race:
> >
> >   + console_flush_all() did not flush the message from CPU1 because
> >     it was not finalized in time.
> >
> >   + CPU1 failed to get console_lock() => CPU0 is responsible for
> >     flushing
> >
> >   + prb_read_valid() failed on CPU0 because it did not see
> >     the prb_desc finalized (missing barrier).
> 
> For semaphores, up() and down_trylock() successfully take and release a
> raw spin lock. That provides the necessary barriers so that CPU0 sees
> the record that CPU1 finalized.

I see. Hmm, we should document this. The spinlock is an implementaion
detail.

IMHO, up()/down()/down_trylock() are quite special. I think
that the theory is that lock() and unlock() are one-way barriers.
And trylock() is one-way barrier only when it succeds.

By other words, _trylock() on CPU1 normally would not guarantee
that CPU0 would see the finalized record after unlock(). [*]


Maybe, we could rely on the existing behavior but we should at least
document it.

Note that I thouht many times about using spin_trylock() in
down_trylock(). It would make more sense because trylock()
should not be be blocking operations. But I see now,
that it might break users depending on the full barrier.


Note: It is possible that I get it wrong. It is so easy to get lost
      in barriers.


> >> Writing and reading of @last_finalized_seq will provide the necessary
> >> boundaries to guarantee this:
> >> 
> >> ...finalize record...
> >> atomic_long_try_cmpxchg_release(&desc_ring->last_finalized_seq, ...);
> >> 
> >> and
> >> 
> >> atomic_long_read_acquire(&desc_ring->last_finalized_seq);
> >> ...read record...
> >
> > Yup. something like this.
> >
> > Well, it is suspicious that there is no _release() counter part.
> 
> Take a closer look above. The cmpxchg (on the writer side) does the
> release. I have the litmus tests to verify that is correct and
> sufficient for what we want: to guarantee that for any read
> @last_finalized_seq value, the CPU can also read the associated record.

The barrier is only in _prb_commit() which sets the committed state.

desc_make_final() uses cmpxchg_relaxed() so that it is not guaranteed
that other CPUs would see the "finalized" state.

> I am finalizing a new version of the "fix console flushing on panic"
> series [0] that will also include the prb_next_seq() fix. If needed, we
> can continue this discussion based on the new code.

OK, maybe it would look different in the new version. And it might
be better to continue the discussion on the new code.

Best Regards,
Petr

