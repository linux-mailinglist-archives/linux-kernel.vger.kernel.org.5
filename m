Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1145D7B21C6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 17:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbjI1PwC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 28 Sep 2023 11:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbjI1PwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 11:52:00 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69120C0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 08:51:57 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-263-t3_o_l23MdiJDZ5ofAWdtA-1; Thu, 28 Sep 2023 16:51:49 +0100
X-MC-Unique: t3_o_l23MdiJDZ5ofAWdtA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 28 Sep
 2023 16:51:47 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 28 Sep 2023 16:51:47 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Steven Rostedt' <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
        Jonathan Corbet <corbet@lwn.net>,
        Noah Goldstein <goldstein.w.n@gmail.com>,
        Daniel Colascione <dancol@google.com>,
        "longman@redhat.com" <longman@redhat.com>,
        "Florian Weimer" <fweimer@redhat.com>
Subject: RE: [RFC PATCH v2 1/4] rseq: Add sched_state field to struct rseq
Thread-Topic: [RFC PATCH v2 1/4] rseq: Add sched_state field to struct rseq
Thread-Index: AQHZ8hog0Ykvpvbq8USYUjzds++7brAwU+jQ
Date:   Thu, 28 Sep 2023 15:51:47 +0000
Message-ID: <40b76cbd00d640e49f727abbd0c39693@AcuMS.aculab.com>
References: <20230529191416.53955-1-mathieu.desnoyers@efficios.com>
        <20230529191416.53955-2-mathieu.desnoyers@efficios.com>
        <20230928103926.GI9829@noisy.programming.kicks-ass.net>
 <20230928104321.490782a7@rorschach.local.home>
In-Reply-To: <20230928104321.490782a7@rorschach.local.home>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt
> Sent: 28 September 2023 15:43
> 
> On Thu, 28 Sep 2023 12:39:26 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > As always, are syscalls really *that* expensive? Why can't we busy wait
> > in the kernel instead?
> 
> Yes syscalls are that expensive. Several years ago I had a good talk
> with Robert Haas (one of the PostgreSQL maintainers) at Linux Plumbers,
> and I asked him if they used futexes. His answer was "no". He told me
> how they did several benchmarks and it was a huge performance hit (and
> this was before Spectre/Meltdown made things much worse). He explained
> to me that most locks are taken just to flip a few bits. Going into the
> kernel and coming back was orders of magnitude longer than the critical
> sections. By going into the kernel, it caused a ripple effect and lead
> to even more contention. There answer was to implement their locking
> completely in user space without any help from the kernel.

That matches what I found with code that was using a mutex to take
work items off a global list.
Although the mutex was only held for a few instructions (probably
several 100 because the list wasn't that well written), what happened
was that as soon as there was any contention (which might start
with a hardware interrupt) performance when through the floor.

The fix was to replace the linked list with and array and use
atomic add to 'grab' blocks of entries.
(Even the atomic operations slowed things down.)

> This is when I thought that having an adaptive spinner that could get
> hints from the kernel via memory mapping would be extremely useful.

Did you consider writing a timestamp into the mutex when it was
acquired - or even as the 'acquired' value?
A 'moderately synched TSC' should do.
Then the waiter should be able to tell how long the mutex
has been held for - and then not spin if it had been held ages.

> The obvious problem with their implementation is that if the owner is
> sleeping, there's no point in spinning. Worse, the owner may even be
> waiting for the spinner to get off the CPU before it can run again. But
> according to Robert, the gain in the general performance greatly
> outweighed the few times this happened in practice.

Unless you can use atomics (ok for bits and linked lists) you
always have the problem that userspace can't disable interrupts.
So, unlike the kernel, you can't implement a proper spinlock.

I've NFI how CONFIG_RT manages to get anything done with all
the spinlocks replaced by sleep locks.
Clearly there are a spinlocks that are held for far too long.
But you really do want to spin most of the time.
...

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

