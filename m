Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099EF7747B4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235917AbjHHTSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236191AbjHHTRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:17:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB21F3D196
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:41:24 -0700 (PDT)
Date:   Tue, 8 Aug 2023 09:15:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691478917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tSlAtwHP5+fv1h1rjVClZSjw78YwaCqK59xC5+cvFac=;
        b=WPwkl5geBuEDV2jcJp97PsKClLV7vXZwtgBMSenDZyJSs3pECo2VkLIkOjwa9uRtttJTMp
        N6My+g/+LvedXWziZX3WoGCGAXsYZMnZX1OJIUmZKs/XKxfc7FsfqYQkD56bt0JyAa5Cmu
        0nfC1t6Du785w2lXiTChGSA6J6wZsmetWSjO1ixm6PdJy8qcY3wsHhQ4oqPUsgEUbLzVIp
        AnVSbG/u89tIkMnCrAlYN5S21ZCZ/xyW1Hb2otlhlqSVYauhGBbKNPwzB+MHXSGo2Zn8DI
        I17ExbykhGvAkazkNNbBPQ4uqv7hdjn9XDyGzcdwusHIcbB7p14Nu3lOhhe+8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691478917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tSlAtwHP5+fv1h1rjVClZSjw78YwaCqK59xC5+cvFac=;
        b=UC4tH41hzLHFXFAKDMbJjHrNR8WkEV/IQ/bwUd6iAOd3nSNd4CbRkEzctXMaG+AkbdFKwk
        QPmcftVRWHfNNpDQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Eric Dumazet <edumazet@google.com>
Subject: Re: [RFC PATCH 0/6] softirq: Start pushing down the big softirq lock
Message-ID: <20230808071514.VTDoPGMm@linutronix.de>
References: <20230801132441.559222-1-frederic@kernel.org>
 <20230807125020.0tMGart2@linutronix.de>
 <ZNEMImA1dWs07U3z@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZNEMImA1dWs07U3z@lothringen>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-07 17:22:10 [+0200], Frederic Weisbecker wrote:
> > However, how do you continue here? Assuming all timers are marked
> > TIMER_SOFTINTERRUPTIBLE then you could avoid the BH-lock at the
> > timer-softirq.
> > But when is a timer considered safe? Would the lack of the _bh suffix be
> > that and you would simply add it during your push down?
>=20
> Yeah that requires manual inspection. A timer that obviously doesn't mess
> up with other softirqs, as is the case most of the time, can simply get t=
he flag.
>=20
> Other timers can be dealt with individually with local_bh_disable() or
> spin_lock_bh() or critical section.

The question is what keeps _bh() doing if you intend to get rid of the
lock.

> > Then you continue the same thing for the remaining softirqs. And once
> > you are done you would remove that RT lock within local_bh_disable()?
> > This isn't something a !RT user would benefit, right?
>=20
> Why not? A long lasting ksoftirqd handling lots of NET_RX could be
> interrupted by a timer/rcu softirq in !RT for example. Further, there
> could even be more than one ksoftirqd if necessary, though I doubt it.

That would require more thinking on how to accomplish this. It is
generally assumed that a softirq callback makes always progress if you
look at it from a different CPU. Therefore a loop like in
__timer_delete_sync() is "okay" because the callback will continue and
finish. If you drop the BH bits from the preemption pointer and allow
preemption then the other CPU could spin until that timer gets back and
continues to work. There is more of this kind of logic=E2=80=A6

But I don't think that you want ksoftirqd handling NET_RX in the first
place. However having a long running NET_RX is a problem in RT because
it blocks all other force-threaded interrupts. Mainline doesn't have
this problem unless it uses threaded interrupts.
The other problematic thing is that everything is mixed up. So you can't
really distinguish between TASKLET as in USB vs SCSI. Not to mention
NET_RX vs TASKLET. If you don't have luxury to move them to different
CPU I *think* assigning them a priority would be a good thing.

> > The other idea I have (besides the preemption point in each softirq
> > handler (mentioned earlier)) is to simple drop the BH-lock on RT. Unlike
> > mainline, RT wouldn't deadlock then. The only that would be missing is
> > synchronisation against local_bh_disable() only locking for variables.
> > From what I remember from the various BH-models we have in RT in the
> > past, that was the only thing that exploded.
>=20
> I thought the issue was about timers fiddling with per-cpu state assuming
> they wouldn't be disturbed by other vectors and thus they lack
> local_bh_disable() on appropriate places. Or perhaps I misunderstood?
>=20
> Otherwise all timers can carry TIMER_SOFTINTERRUPTIBLE right away, right?

The last time I have been looking at it is just the usage of per-CPU
variables. For instance assume a timer invokes napi_consume_skb().

> Thanks.

Sebastian
