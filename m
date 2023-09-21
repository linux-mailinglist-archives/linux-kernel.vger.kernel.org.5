Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262B37A9D3D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjIUTaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbjIUT3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:29:44 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE97AC3E5;
        Thu, 21 Sep 2023 11:01:51 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31fe2c8db0dso1155065f8f.3;
        Thu, 21 Sep 2023 11:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695319310; x=1695924110; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yFp64Aiq4OgTS6P/UmNQbVYb/YqY2yHQa/A83YIhmwM=;
        b=gzu4JHUJCAZoyxDBUfFOp/tXzfXnkuo7TW74qDc4B2NA3NrDeMq64E3IaVY7KD5IpC
         tvGQYdqTxhRxunChTTRQyDYQ2TPKqflyEKEH297kJg5YHf6oN50wTn/rlNFk/RBhR5Qh
         Uh26Aj8rEyiq0xoSg5fqVUJUBeXh2nspxliTOSyZW7H3BkYR72VffNzU2RNtkMIgvnfr
         8UH1vX9xTNnbWr20cQiHaG8YO/tHFOVG7dOEJSl8uy0yZ1E2ggrQWRWTnFgB0ir8Tn5O
         Ci4dMjdxlGF0qkYiXBdJWte/8VU3X7NCQwkPa78rrFfG5lu7gGIHE4ECk5EPmEURy73R
         xi7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695319310; x=1695924110;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yFp64Aiq4OgTS6P/UmNQbVYb/YqY2yHQa/A83YIhmwM=;
        b=aHupiJ151nl1Y6CBWc4IStrhYcXTdQlVD9VPnSkL5fzOLZnhjTAuaEcFsBKJm6X2nE
         0bQ+rI/XYzjzqsph24o5Z0fylvoQd/aVs+N/+B8Kx/rILUAZnIyrTgFMpKw/+2BD5qzA
         56DGif7EQ6Hlb5sjbr1bzZIyT08ob+t74wOOAIGXjGq/hHlWQt7mT0V6qiek1f1P1c6l
         WJm15FbBPLtba6sWpauC+vJAayVfhR0qsnVR+7CMMyxbL/e/sV9rYkJBp+0fcX2+WNPy
         OypKaQu2Pf90f6PPpOyx8ptQgAwBbSTCN3kGGqzeSa6vAUV+/EN6fn43JrLnl1uAW+NO
         YB4w==
X-Gm-Message-State: AOJu0YzxSYTvtYXVD0tuHPH7wOqd05tzDVFX0CbYRXud8N1BVs743dw2
        0RYWiterQ9xFIIHrWa9dqnd4oFB6BVPsMxxgvpU=
X-Google-Smtp-Source: AGHT+IFCLYbFamU0osn8Cwpa3+RTV2OdXq4qe1ZCQ6bwJ2nYYTCjkS+YsPaiw021Wx7nOYXBW1/1qQ==
X-Received: by 2002:a5d:4988:0:b0:319:7656:3863 with SMTP id r8-20020a5d4988000000b0031976563863mr4309058wrq.47.1695292895471;
        Thu, 21 Sep 2023 03:41:35 -0700 (PDT)
Received: from [10.148.84.122] (business-89-135-192-225.business.broadband.hu. [89.135.192.225])
        by smtp.gmail.com with ESMTPSA id n5-20020a5d4005000000b0031c5dda3aedsm1386459wrp.95.2023.09.21.03.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 03:41:34 -0700 (PDT)
Message-ID: <2eb9af65d098bb54ed54178d7269e7197d6de5a0.camel@gmail.com>
Subject: Re: [RFC PATCH net-next 1/2] net: Use SMP threads for backlog NAPI.
From:   Ferenc Fejes <primalgamer@gmail.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wander Lairson Costa <wander@redhat.com>
Date:   Thu, 21 Sep 2023 12:41:33 +0200
In-Reply-To: <20230920155754.KzYGXMWh@linutronix.de>
References: <20230814093528.117342-1-bigeasy@linutronix.de>
         <20230814093528.117342-2-bigeasy@linutronix.de>
         <0a842574fd0acc113ef925c48d2ad9e67aa0e101.camel@redhat.com>
         <20230920155754.KzYGXMWh@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0-1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Wed, 2023-09-20 at 17:57 +0200, Sebastian Andrzej Siewior wrote:
> On 2023-08-23 15:35:41 [+0200], Paolo Abeni wrote:
> > On Mon, 2023-08-14 at 11:35 +0200, Sebastian Andrzej Siewior wrote:
> > > @@ -4781,7 +4733,7 @@ static int enqueue_to_backlog(struct
> > > sk_buff *skb, int cpu,
> > > =C2=A0		 * We can use non atomic operation since we own
> > > the queue lock
> > > =C2=A0		 */
> > > =C2=A0		if (!__test_and_set_bit(NAPI_STATE_SCHED, &sd-
> > > >backlog.state))
> > > -			napi_schedule_rps(sd);
> > > +			__napi_schedule_irqoff(&sd->backlog);
> > > =C2=A0		goto enqueue;
> > > =C2=A0	}
> > > =C2=A0	reason =3D SKB_DROP_REASON_CPU_BACKLOG;
> >=20
> > I *think* that the above could be quite dangerous when cpu =3D=3D
> > smp_processor_id() - that is, with plain veth usage.
> >=20
> > Currently, each packet runs into the rx path just after
> > enqueue_to_backlog()/tx completes.
> >=20
> > With this patch there will be a burst effect, where the backlog
> > thread
> > will run after a few (several) packets will be enqueued, when the
> > process scheduler will decide - note that the current CPU is
> > already
> > hosting a running process, the tx thread.
> >=20
> > The above can cause packet drops (due to limited buffering) or very
> > high latency (due to long burst), even in non overload situation,
> > quite
> > hard to debug.
> >=20
> > I think the above needs to be an opt-in, but I guess that even RT
> > deployments doing some packet forwarding will not be happy with
> > this
> > on.
>=20
> I've been looking at this again and have been thinking what you said
> here. I think part of the problem is that we lack a policy/ mechanism
> when a DoS is happening and what to do.
>=20
> Before commit d15121be74856 ("Revert "softirq: Let ksoftirqd do its
> job"") when a lot of network packets are processed then processing is
> moved to ksoftirqd and continues based on how the scheduler schedules
> the SCHED_OTHER ksoftirqd task. This avoids lock-ups of the system
> and
> it can do something else in between. Any interrupt will not continue
> the
> outstanding softirq backlog but wait for ksoftirqd. So it basically
> avoids the networking overload. It throttles the throughput if
> needed.
>=20
> This isn't the case after that commit. Now, the CPU can be stuck with
> processing networking packets if the packets come in fast enough.
> Even
> if ksoftirqd is woken up, the next interrupt (say the timer) will
> continue with at least one round.
> By using NAPI-threads it is possible to give the control back to the
> scheduler which can throttle the NAPI processing in favour of other
> threads that ask for CPU. As you pointed out, waking the thread does
> not
> guarantee that it will immediately do the NAPI work. It can be
> delayed
> based on current load on the system.
>=20
> This could be influenced by assigning the NAPI-thread a SCHED_FIFO
> priority. Based on the priority it could be ensured that the thread
> starts right away or "later" if something else is more important.
> However, this opens the DoS window again: The scheduler will put the
> NAPI thread on CPU as long as it asks for it with no throttling.
>=20
> If we could somehow define a DoS condition once we are overwhelmed
> with
> packets, then we could act on it and throttle it. This in turn would
> allow a SCHED_FIFO priority without the fear of a lockup if the
> system
> is flooded with packets.

Can this be avoided if we reuse gro_flush_timeout as the maximum time
the NAPI thread can be scheduled?

>=20
> > Cheers,
> >=20
> > Paolo
>=20
> Sebastian

Ferenc
