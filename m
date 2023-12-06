Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C453F806B50
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377380AbjLFKIi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Dec 2023 05:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377419AbjLFKId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:08:33 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F60D5B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 02:08:38 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-33-FiOxCgBcM6Sc0jM-G-mxHA-1; Wed, 06 Dec 2023 10:08:34 +0000
X-MC-Unique: FiOxCgBcM6Sc0jM-G-mxHA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 6 Dec
 2023 10:08:20 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 6 Dec 2023 10:08:20 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Steven Rostedt' <rostedt@goodmis.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "luto@kernel.org" <luto@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "jon.grimm@amd.com" <jon.grimm@amd.com>,
        "bharata@amd.com" <bharata@amd.com>,
        "raghavendra.kt@amd.com" <raghavendra.kt@amd.com>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "jgross@suse.com" <jgross@suse.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "bristot@kernel.org" <bristot@kernel.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "anton.ivanov@cambridgegreys.com" <anton.ivanov@cambridgegreys.com>,
        "mattst88@gmail.com" <mattst88@gmail.com>,
        "krypton@ulrich-teichert.org" <krypton@ulrich-teichert.org>,
        "richard@nod.at" <richard@nod.at>,
        "mjguzik@gmail.com" <mjguzik@gmail.com>,
        Simon Horman <horms@verge.net.au>,
        Julian Anastasov <ja@ssi.bg>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: RE: [RFC PATCH 47/86] rcu: select PREEMPT_RCU if PREEMPT
Thread-Topic: [RFC PATCH 47/86] rcu: select PREEMPT_RCU if PREEMPT
Thread-Index: AQHaJ7viiNa4TRbbnU+bBE2OROIvJrCb+7JA
Date:   Wed, 6 Dec 2023 10:08:20 +0000
Message-ID: <267e9e26ce5048d08e347ad8d3438c17@AcuMS.aculab.com>
References: <e939c924-1dfa-4a6a-9309-2430f19467f5@paulmck-laptop>
        <87wmu2ywrk.ffs@tglx>   <fa1249f7-9a5d-4696-9246-4913365b6715@paulmck-laptop>
        <20231205100114.0bd3c4a2@gandalf.local.home>
        <1375e409-2593-45e1-b27e-3699c17c47dd@paulmck-laptop>
 <20231205154518.70d042c3@gandalf.local.home>
In-Reply-To: <20231205154518.70d042c3@gandalf.local.home>
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
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

...
> > > One thing I would like to look into with the new work is to have holding a
> > > mutex ignore the NEED_RESCHED_LAZY (similar to what is done with spinlock
> > > converted to mutex in the RT kernel). That way you are less likely to be
> > > preempted while holding a mutex.
> >
> > I like the concept, but those with mutex_lock() of rarely-held mutexes
> > in their fastpaths might have workloads that have a contrary opinion.
> 
> I don't understand your above statement. Maybe I wasn't clear with my
> statement? The above is more about PREEMPT_FULL, as it currently will
> preempt immediately. My above comment is that we can have an option for
> PREEMPT_FULL where if the scheduler decided to preempt even in a fast path,
> it would at least hold off until there's no mutex held. Who cares if it's a
> fast path when a task needs to give up the CPU for another task?
>
> What I
> worry about is scheduling out while holding a mutex which increases the
> chance of that mutex being contended upon. Which does have drastic impact
> on performance.

Indeed.
You really don't want to preempt with a mutex held if it is about to be
released. Unfortunately this really required a CBU (Crytal Ball Unit).

But I don't think the scheduler timer ticks can be anywhere near frequent
enough to do the 'slightly delayed preemption' that seems to being talked
about - not without a massive overhead.

I can think of two typical uses of a mutex.
One is a short code path that doesn't usually sleep, but calls kmalloc()
so might do so. That could be quite 'hot' and you wouldn't really want
extra 'random' preemption.
The other is long paths that are going to wait for IO, any concurrent
call is expected to sleep. Extra preemption here probably won't matter.

So maybe the software should give the scheduler a hint.
Perhaps as a property of the mutex or the acquire request?
Or feeding the time the mutex has been held into the mix.

It is all a bit like the difference between using spinlock() and
spinlock_irqsave() for a lock that will never be held by an ISR.
If the lock is ever likely to be contended you (IMHO) really want
to use the 'irqsave' version in order to stop the waiting thread
spinning for the duration of the ISR (and following softint).
There is (probably) little point worrying about IRQ latency, a
single readl() to our fpga based PCIe slave will spin a 3GHz cpu
for around 3000 clocks - that it is a lot of normal code.
I've had terrible problems avoiding the extra pthread_mutex() hold
times caused by ISR and softint, they must have the same effect on
spin_lock().

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

