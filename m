Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7A57AAE5A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 11:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbjIVJjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 05:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbjIVJjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:39:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5FECE
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 02:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695375498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wClyhpJJsYcaIGDe+oBgZpYY/QcBTvm0V5/+qFTrePg=;
        b=UP0NrPKQwUBe5hhoCh0ZVoZTWWUSsFc6C75tHYOuCK2vTiM+Uj27+ajPBt1et6RiTdl8Jh
        KIcKYzGjTJObfeL9PBlXBfpMr9PNgm1Palm9KK5pRteYV8dM3zE3i1qL7mGtz2cAdb5YSS
        K2YEhvV2BcwzKwpTpzECl6y1hj51Iaw=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15--odDbXPUOS2SZQKxk41YEQ-1; Fri, 22 Sep 2023 05:38:17 -0400
X-MC-Unique: -odDbXPUOS2SZQKxk41YEQ-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2bf6f455751so6935341fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 02:38:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695375495; x=1695980295;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wClyhpJJsYcaIGDe+oBgZpYY/QcBTvm0V5/+qFTrePg=;
        b=ZNV5ilmQKNknCXQnKrsZbUY/pLvMYSFVJNDGBrsWeQ4TcCXTPoyvIl7Bh1SrmOVaLq
         fWz7Pk/UiCkdL79QyP2HhVSd8e2ebpxzASB5dOuRKkvF4ziAdzP0SJP6ifeJGwOcGHEY
         NUdDMOUNfSC5PAHBNSqMwfK/IMAusUIKRciSuz9O5hg9ZDdrAjI04PapQvBgQ2fuoJeX
         NF+coh9P6KZGDBcL16oMJ1SJtDy5X+0Ocg2pZ6gtXJ96kHntODdkGR8ZwnfKzwB3LBow
         liQvU0lD1SObv78Kidmrn/F16bEUns+8EL/MxiaiwL6GtKwHDY1GKRaiwsfL2tD6tVkl
         b09g==
X-Gm-Message-State: AOJu0YwAnyTQrt9rPd+5HZxODhG6Bw+VEPevb0LpAxDzLaMCW6cS7AQr
        30MA9kBGqCOdaM9RVLHqroBT7YFtMGNQHVQXyNe+Ry4FD0a2u4uTqkFDGp/MJxylZXkzb9X8QIQ
        c6WQjzQIUboY2Ok7pPIXneh7F
X-Received: by 2002:ac2:52ad:0:b0:501:c223:fa22 with SMTP id r13-20020ac252ad000000b00501c223fa22mr6376186lfm.6.1695375495629;
        Fri, 22 Sep 2023 02:38:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUUe8HTyy/4EL6Odst4XzgDXiLOGONCkCEL6eFFDcOEUE2FUbfJ3+/j9GrgzHVe83euGHv9A==
X-Received: by 2002:ac2:52ad:0:b0:501:c223:fa22 with SMTP id r13-20020ac252ad000000b00501c223fa22mr6376168lfm.6.1695375495215;
        Fri, 22 Sep 2023 02:38:15 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-251-4.dyn.eolo.it. [146.241.251.4])
        by smtp.gmail.com with ESMTPSA id t1-20020a1c7701000000b003fe23b10fdfsm7031406wmi.36.2023.09.22.02.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 02:38:14 -0700 (PDT)
Message-ID: <8864d2741c9bc595d9470041fca3d44beb15a7e0.camel@redhat.com>
Subject: Re: [RFC PATCH net-next 1/2] net: Use SMP threads for backlog NAPI.
From:   Paolo Abeni <pabeni@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wander Lairson Costa <wander@redhat.com>
Date:   Fri, 22 Sep 2023 11:38:13 +0200
In-Reply-To: <20230920155754.KzYGXMWh@linutronix.de>
References: <20230814093528.117342-1-bigeasy@linutronix.de>
         <20230814093528.117342-2-bigeasy@linutronix.de>
         <0a842574fd0acc113ef925c48d2ad9e67aa0e101.camel@redhat.com>
         <20230920155754.KzYGXMWh@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-09-20 at 17:57 +0200, Sebastian Andrzej Siewior wrote:
> On 2023-08-23 15:35:41 [+0200], Paolo Abeni wrote:
> > On Mon, 2023-08-14 at 11:35 +0200, Sebastian Andrzej Siewior wrote:
> > > @@ -4781,7 +4733,7 @@ static int enqueue_to_backlog(struct sk_buff *s=
kb, int cpu,
> > >  		 * We can use non atomic operation since we own the queue lock
> > >  		 */
> > >  		if (!__test_and_set_bit(NAPI_STATE_SCHED, &sd->backlog.state))
> > > -			napi_schedule_rps(sd);
> > > +			__napi_schedule_irqoff(&sd->backlog);
> > >  		goto enqueue;
> > >  	}
> > >  	reason =3D SKB_DROP_REASON_CPU_BACKLOG;
> >=20
> > I *think* that the above could be quite dangerous when cpu =3D=3D
> > smp_processor_id() - that is, with plain veth usage.
> >=20
> > Currently, each packet runs into the rx path just after
> > enqueue_to_backlog()/tx completes.
> >=20
> > With this patch there will be a burst effect, where the backlog thread
> > will run after a few (several) packets will be enqueued, when the
> > process scheduler will decide - note that the current CPU is already
> > hosting a running process, the tx thread.
> >=20
> > The above can cause packet drops (due to limited buffering) or very
> > high latency (due to long burst), even in non overload situation, quite
> > hard to debug.
> >=20
> > I think the above needs to be an opt-in, but I guess that even RT
> > deployments doing some packet forwarding will not be happy with this
> > on.
>=20
> I've been looking at this again and have been thinking what you said
> here. I think part of the problem is that we lack a policy/ mechanism
> when a DoS is happening and what to do.
>=20
> Before commit d15121be74856 ("Revert "softirq: Let ksoftirqd do its
> job"") when a lot of network packets are processed then processing is
> moved to ksoftirqd and continues based on how the scheduler schedules
> the SCHED_OTHER ksoftirqd task. This avoids lock-ups of the system and
> it can do something else in between. Any interrupt will not continue the
> outstanding softirq backlog but wait for ksoftirqd. So it basically
> avoids the networking overload. It throttles the throughput if needed.
>=20
> This isn't the case after that commit. Now, the CPU can be stuck with
> processing networking packets if the packets come in fast enough. Even
> if ksoftirqd is woken up, the next interrupt (say the timer) will
> continue with at least one round.
> By using NAPI-threads it is possible to give the control back to the
> scheduler which can throttle the NAPI processing in favour of other
> threads that ask for CPU. As you pointed out, waking the thread does not
> guarantee that it will immediately do the NAPI work. It can be delayed
> based on current load on the system.
>=20
> This could be influenced by assigning the NAPI-thread a SCHED_FIFO
> priority. Based on the priority it could be ensured that the thread
> starts right away or "later" if something else is more important.
> However, this opens the DoS window again: The scheduler will put the
> NAPI thread on CPU as long as it asks for it with no throttling.
>=20
> If we could somehow define a DoS condition once we are overwhelmed with
> packets, then we could act on it and throttle it. This in turn would
> allow a SCHED_FIFO priority without the fear of a lockup if the system
> is flooded with packets.

I declare ENOCOFFEE before starting, be warned!=20

I fear this is becoming a bit too theoretical, but we can infer a DoS
condition if the napi thread enqueues somewhere (socket buffer, qdisc,
tx ring, ???) a packet and the queue utilization is "high" (say > 75%
of max).

I have no idea how to throttle a FIFO thread retaining its priority.

More importantly, this kind of configuration is not really viable for a
generic !PREEMPT_RT build, while the concern I have with napi threaded
backlog/serving the backlog with ksoftirqd applies there.

Cheers,

Paolo

