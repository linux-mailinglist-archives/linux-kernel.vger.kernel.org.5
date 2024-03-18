Return-Path: <linux-kernel+bounces-105900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD6287E632
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5514D28161F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60CF2C6AF;
	Mon, 18 Mar 2024 09:47:31 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7FA2C68D
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 09:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710755251; cv=none; b=LkmK+l6VLYHIQ/L7D+OzwPHWhxbEojYTWabP1eFyZJIyx9NfxXiXA8R3TzhUvI59UbYIbnajVHB2t82quf8zO3lU/sJAFm+leGg9dlvsOBd7AcaQ/ClRTg5dvvFdPfJqAS7XXUnCN8rLYW56C8bIrfZ7ijkqwfCn+tez4CG52/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710755251; c=relaxed/simple;
	bh=7AzZDMltgpqzqf2GLOUZVXDX7Aq4YrgAyeoVp/fotE0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=TBQe/0tOtcCuvmJ+vypUtb4CHmlwP+JPcEcQpHBx0t5XuAp8hnMWKMbQpOL36tNvcDa1NIeAQ4rEToiugA30+OVz2RGxE6y/h4oKBwT2Wq+VDelYlpGhzo7Wzr1rGKfozvT4z+S9EtkjTovYvrSqfvWpqdplE2e9b+8ot77JbvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mtapsc-6-djy9OhDjPMOIo0c5j2NdMw-1; Mon, 18 Mar 2024 09:47:23 +0000
X-MC-Unique: djy9OhDjPMOIo0c5j2NdMw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 18 Mar
 2024 09:47:02 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 18 Mar 2024 09:47:02 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Guo Hui' <guohui@uniontech.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"will@kernel.org" <will@kernel.org>, "longman@redhat.com"
	<longman@redhat.com>, "boqun.feng@gmail.com" <boqun.feng@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] locking/osq_lock: Optimize osq_lock performance using
 per-NUMA
Thread-Topic: [PATCH v2] locking/osq_lock: Optimize osq_lock performance using
 per-NUMA
Thread-Index: AQHaePhUI3ltDoeEfEiJv05r++lTjLE9NhjQ
Date: Mon, 18 Mar 2024 09:47:02 +0000
Message-ID: <e8e933ab37f84ac68ac70f4b1ed8d524@AcuMS.aculab.com>
References: <20240318055023.25546-1-guohui@uniontech.com>
In-Reply-To: <20240318055023.25546-1-guohui@uniontech.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Guo Hui
> Sent: 18 March 2024 05:50
>=20
> Changes in version v1:
> The queue is divided according to NUMA nodes,
> but the tail of each NUMA node is still stored
> in the structure optimistic_spin_queue.

The description should be before any 'changes'.
The changes between versions don't go into the commit message.

Does this change affect a real workload, or just some benchmark?

In reality you don't want a lot of threads waiting on a single
lock (of any kind).
So if a real workload is getting a long queue of waiters on
an OSQ lock then the underlying code really needs fixing to
'not do that' (either by changing the way the lock is held
or acquired).

The whole osq lock is actually quite strange.
(I worked out how it all worked a while ago.)
It is an ordered queue of threads waiting for the thread
spinning on a mutex/rwlock to either obtain the mutex or
to give up spinning and sleep.
I suspect that the main benefit over spinning on the mutex
itself is the fact that it is ordered.
It also remove the 'herd of wildebeest' doing a cmpxchg - but
one will win and the others do back to a non-locked poll.

Are the gains you are seeing from the osq-lock code itself,
or because the thread that ultimately holds the mutex is running
on the same NUMA node as the previous thread than held the mutex?

One thing I did notice is if the process holding the mutex
sleeps there is no way to get all the osq spinners to
sleep at once. They each obtain the osq-lock, realise the
need to sleep, and release it in turn.
That is going to take a while with a long queue.

I didn't look at the mutex/rwlock code (I'm sure they
could be a lot more common - a mutex is a rwlock that
only has writers!) but if one thread detects that it
needs to be pre-empted it takes itself out of the osq-lock
and, presumably, sleeps on the mutex.
Unless that stops any other threads being added to the osq-lock
wont it get completely starved?

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


