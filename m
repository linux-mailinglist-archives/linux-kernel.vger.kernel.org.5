Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0238F7B58E3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 19:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjJBRWp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 2 Oct 2023 13:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjJBRWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 13:22:43 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A07AD
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 10:22:39 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-71-1NEcmSlANSi22Ru6WZEOTQ-1; Mon, 02 Oct 2023 18:22:36 +0100
X-MC-Unique: 1NEcmSlANSi22Ru6WZEOTQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 2 Oct
 2023 18:22:34 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 2 Oct 2023 18:22:34 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Steven Rostedt' <rostedt@goodmis.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>,
        "carlos@redhat.com" <carlos@redhat.com>,
        Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Chris Kennelly <ckennelly@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?iso-8859-1?Q?Andr=E9_Almeida?= <andrealmeid@igalia.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Noah Goldstein <goldstein.w.n@gmail.com>,
        Daniel Colascione <dancol@google.com>,
        "longman@redhat.com" <longman@redhat.com>,
        Florian Weimer <fweimer@redhat.com>
Subject: RE: [RFC PATCH v2 1/4] rseq: Add sched_state field to struct rseq
Thread-Topic: [RFC PATCH v2 1/4] rseq: Add sched_state field to struct rseq
Thread-Index: AQHZ8hog0Ykvpvbq8USYUjzds++7brAwU+jQgAZYaYCAABHzEA==
Date:   Mon, 2 Oct 2023 17:22:34 +0000
Message-ID: <845039ad23d24cc687491efa95be5e0d@AcuMS.aculab.com>
References: <20230529191416.53955-1-mathieu.desnoyers@efficios.com>
        <20230529191416.53955-2-mathieu.desnoyers@efficios.com>
        <20230928103926.GI9829@noisy.programming.kicks-ass.net>
        <20230928104321.490782a7@rorschach.local.home>
        <40b76cbd00d640e49f727abbd0c39693@AcuMS.aculab.com>
 <20231002125109.55c35030@gandalf.local.home>
In-Reply-To: <20231002125109.55c35030@gandalf.local.home>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt
> Sent: 02 October 2023 17:51
> 
> On Thu, 28 Sep 2023 15:51:47 +0000
> David Laight <David.Laight@ACULAB.COM> wrote:
> 
> 
> > > This is when I thought that having an adaptive spinner that could get
> > > hints from the kernel via memory mapping would be extremely useful.
> >
> > Did you consider writing a timestamp into the mutex when it was
> > acquired - or even as the 'acquired' value?
> > A 'moderately synched TSC' should do.
> > Then the waiter should be able to tell how long the mutex
> > has been held for - and then not spin if it had been held ages.
> 
> And what heuristic would you use. My experience with picking "time to spin"
> may work for one workload but cause major regressions in another workload.
> I came to the conclusion to "hate" heuristics and NACK them whenever
> someone suggested adding them to the rt_mutex in the kernel (back before
> adaptive mutexes were introduced).

Isn't that exactly what and adaptive mutex does?
Spin 'for a bit' before sleeping.

> > > The obvious problem with their implementation is that if the owner is
> > > sleeping, there's no point in spinning. Worse, the owner may even be
> > > waiting for the spinner to get off the CPU before it can run again. But
> > > according to Robert, the gain in the general performance greatly
> > > outweighed the few times this happened in practice.
> >
> > Unless you can use atomics (ok for bits and linked lists) you
> > always have the problem that userspace can't disable interrupts.
> > So, unlike the kernel, you can't implement a proper spinlock.
> 
> Why do you need to disable interrupts? If you know the owner is running on
> the CPU, you know it's not trying to run on the CPU that is acquiring the
> lock. Heck, there's normal spin locks outside of PREEMPT_RT that do not
> disable interrupts. The only time you need to disable interrupts is if the
> interrupt itself takes the spin lock, and that's just to prevent deadlocks.

You need to disable interrupts in order to bound the time the
spinlock is held for.
If all you are doing is a dozen instructions (eg to remove an
item from s list) then you really don't want an interrupt coming in
while you have the spinlock held.
It isn't the cost of the ISR - that has to happen sometime, but that
the cpu waiting for the spinlock also take the cost of the ISR.

A network+softint ISR can run for a long time - I'm sure I've
seen a good fraction of a millisecond.
You really don't want another (or many other) cpu spinning while
that is going on.
Which (to my mind) pretty much means that you always want to
disable interrupts on a spinlock.
If the architecture makes masking ISR expensive then I've seen schemes
that let the hardware interrupt happen, then disable it and rerun later.

> > I've NFI how CONFIG_RT manages to get anything done with all
> > the spinlocks replaced by sleep locks.
> > Clearly there are a spinlocks that are held for far too long.
> > But you really do want to spin most of the time.
> 
> It spins as long as the owner of the lock is running on the CPU. This is
> what we are looking to get from this patch series for user space.

I think you'd need to detect that the cpu was in-kernel running an ISR.

But the multithreaded audio app I was 'fixing' basically failed
as soon as it had to sleep on one of the futex.
The real problem was ISR while the mutex was held.
So deciding to sleep because the lock owner isn't running (in user)
would already be delaying things too much.

> 
> Back in 2007, we had an issue with scaling on SMP machines. The RT kernel
> with the sleeping spin locks would start to exponentially slow down with
> the more CPUs you had. Once we hit more than 16 CPUs,  the time to boot a
> kernel took 10s of minutes to boot RT when the normal CONFIG_PREEMPT kernel
> would only take a couple of minutes. The more CPUs you added, the worse it
> became.
> 
> Then SUSE submitted a patch to have the rt_mutex spin only if the owner of
> the mutex was still running on another CPU. This actually mimics a real
> spin lock (because that's exactly what they do, they spin while the owner
> is running on a CPU). The difference between a true spin lock and an
> rt_mutex was that the spinner would stop spinning if the owner was
> preempted (a true spin lock owner could not be preempted).
> 
> After applying the adaptive spinning, we were able to scale PREEMPT_RT to
> any number of CPUs that the normal kernel could do with just a linear
> performance hit.

Sounds like it was spinning for far too long at the best of times.
But analysing these sort of latencies is hard.

	David

> 
> This is why I'm very much interested in getting the same ability into user
> space spin locks.
> 
> -- Steve

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

