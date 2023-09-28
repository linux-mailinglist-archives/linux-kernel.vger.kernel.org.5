Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF9F7B1AF3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 13:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbjI1LZm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 28 Sep 2023 07:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbjI1LZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:25:25 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2D3359B
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 04:23:04 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-94-16gep9MhMWCHUX4uA_UWOw-1; Thu, 28 Sep 2023 12:22:56 +0100
X-MC-Unique: 16gep9MhMWCHUX4uA_UWOw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 28 Sep
 2023 12:22:55 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 28 Sep 2023 12:22:55 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, "Paul Turner" <pjt@google.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        "Florian Weimer" <fw@deneb.enyo.de>,
        "carlos@redhat.com" <carlos@redhat.com>,
        "Peter Oskolkov" <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Chris Kennelly <ckennelly@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Darren Hart" <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?iso-8859-1?Q?Andr=E9_Almeida?= <andrealmeid@igalia.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Noah Goldstein <goldstein.w.n@gmail.com>,
        Daniel Colascione <dancol@google.com>,
        "longman@redhat.com" <longman@redhat.com>,
        Florian Weimer <fweimer@redhat.com>
Subject: RE: [RFC PATCH v2 1/4] rseq: Add sched_state field to struct rseq
Thread-Topic: [RFC PATCH v2 1/4] rseq: Add sched_state field to struct rseq
Thread-Index: AQHZ8fgZ0Ykvpvbq8USYUjzds++7brAwFQDg
Date:   Thu, 28 Sep 2023 11:22:55 +0000
Message-ID: <ef39143ad24743008a896d2a09da1066@AcuMS.aculab.com>
References: <20230529191416.53955-1-mathieu.desnoyers@efficios.com>
 <20230529191416.53955-2-mathieu.desnoyers@efficios.com>
 <20230928103926.GI9829@noisy.programming.kicks-ass.net>
In-Reply-To: <20230928103926.GI9829@noisy.programming.kicks-ass.net>
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra
> Sent: 28 September 2023 11:39
> 
> On Mon, May 29, 2023 at 03:14:13PM -0400, Mathieu Desnoyers wrote:
> > Expose the "on-cpu" state for each thread through struct rseq to allow
> > adaptative mutexes to decide more accurately between busy-waiting and
> > calling sys_futex() to release the CPU, based on the on-cpu state of the
> > mutex owner.

Are you trying to avoid spinning when the owning process is sleeping?
Or trying to avoid the system call when it will find that the futex
is no longer held?

The latter is really horribly detremental.

> >
> > It is only provided as an optimization hint, because there is no
> > guarantee that the page containing this field is in the page cache, and
> > therefore the scheduler may very well fail to clear the on-cpu state on
> > preemption. This is expected to be rare though, and is resolved as soon
> > as the task returns to user-space.
> >
> > The goal is to improve use-cases where the duration of the critical
> > sections for a given lock follows a multi-modal distribution, preventing
> > statistical guesses from doing a good job at choosing between busy-wait
> > and futex wait behavior.
> 
> As always, are syscalls really *that* expensive? Why can't we busy wait
> in the kernel instead?
> 
> I mean, sure, meltdown sucked, but most people should now be running
> chips that are not affected by that particular horror show, no?

IIRC 'page table separation' which is what makes system calls expensive
is only a compile-time option. So is likely to be enabled on any 'distro'
kernel.
But a lot of other mitigations (eg RSB stuffing) are also pretty detrimental.

OTOH if you have a 'hot' userspace mutex you are going to lose whatever.
All that needs to happen is for a ethernet interrupt to decide to discard
completed transmits and refill the rx ring, and then for the softint code
to free a load of stuff deferred by rcu while you've grabbed the mutex
and no matter how short the user-space code path the mutex won't be
released for absolutely ages.

I had to change a load of code to use arrays and atomic increments
to avoid delays acquiring mutex.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

