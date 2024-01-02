Return-Path: <linux-kernel+bounces-14971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E29EA822581
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 00:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C8A82849E2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 23:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E561F17755;
	Tue,  2 Jan 2024 23:32:30 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF721773F
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 23:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-206-al3PGIShPmOwyO1qSkjVCw-1; Tue, 02 Jan 2024 23:32:19 +0000
X-MC-Unique: al3PGIShPmOwyO1qSkjVCw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 2 Jan
 2024 23:32:05 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 2 Jan 2024 23:32:05 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Boqun Feng' <boqun.feng@gmail.com>
CC: 'Waiman Long' <longman@redhat.com>, "'linux-kernel@vger.kernel.org'"
	<linux-kernel@vger.kernel.org>, "'peterz@infradead.org'"
	<peterz@infradead.org>, "'mingo@redhat.com'" <mingo@redhat.com>,
	"'will@kernel.org'" <will@kernel.org>, 'Linus Torvalds'
	<torvalds@linux-foundation.org>, "'xinhui.pan@linux.vnet.ibm.com'"
	<xinhui.pan@linux.vnet.ibm.com>,
	"'virtualization@lists.linux-foundation.org'"
	<virtualization@lists.linux-foundation.org>, 'Zeng Heng'
	<zengheng4@huawei.com>
Subject: RE: [PATCH next 2/5] locking/osq_lock: Avoid dirtying the local cpu's
 'node' in the osq_lock() fast path.
Thread-Topic: [PATCH next 2/5] locking/osq_lock: Avoid dirtying the local
 cpu's 'node' in the osq_lock() fast path.
Thread-Index: Ado6o/zBb4T2uRNuSTy7E9ZX7SDa6wAKyRqAABQrXQAAo0zNgAAH1EaA
Date: Tue, 2 Jan 2024 23:32:05 +0000
Message-ID: <92f36f59a1c0437e9e4848cb86d1d756@AcuMS.aculab.com>
References: <73a4b31c9c874081baabad9e5f2e5204@AcuMS.aculab.com>
 <fbb1f9ed42b2460c93eeac43a92157c8@AcuMS.aculab.com>
 <835f65d9-a041-4956-b89d-7cd3660c3ab8@redhat.com>
 <fedbf107b9344e7b85711c0de59ae0a3@AcuMS.aculab.com>
 <ZZRbtwwcusePltww@boqun-archlinux>
In-Reply-To: <ZZRbtwwcusePltww@boqun-archlinux>
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

From: Boqun Feng
> Sent: 02 January 2024 18:54
>=20
> On Sat, Dec 30, 2023 at 03:49:52PM +0000, David Laight wrote:
> [...]
> > But it looks odd that osq_unlock()'s fast path uses _release but the ve=
ry
> > similar code in osq_wait_next() uses _acquire.
> >
>=20
> The _release in osq_unlock() is needed since unlocks are needed to be
> RELEASE so that lock+unlock can be a critical section (i.e. no memory
> accesses can escape). When osq_wait_next() is used in non unlock cases,
> the RELEASE is not required. As for the case where osq_wait_next() is
> used in osq_unlock(), there is a xchg() preceding it, which provides a
> full barrier, so things are fine.

I know there have been issues with ACQUIRE/RELEASE/FULL xchg in this code,
but are FULL xchg always needed on node->next?

> /me wonders whether we can relax the _acquire in osq_wait_next() into
> a _relaxed.

I wouldn't have worried about relaxed v release.

> > Indeed, apart from some (assumed) optimisations, I think osq_unlock()
> > could just be:
> > =09next =3D osq_wait_next(lock, this_cpu_ptr(&osq_node), 0);
> > =09if (next)
> > =09=09next->locked =3D 1;
> >
>=20
> If so we need to provide some sort of RELEASE semantics for the
> osq_unlock() in all the cases.

I wonder how often the unqueue code happens, and especially for
the last cpu in the list?
I'd only expect need_resched() to return true after spinning for
a while - in which case perhaps it is more likely that there are
a lot of cpu in the queue and the cpu being removed won't be last.
So osq_wait_next() exits on xchg(&node->next, NULL) !=3D NULL
which is full barrier.

On a slightly different note I've also wondered if 'osq_node'
actually needs to be cache line aligned?
You definitely don't want it spanning 2 cache line, but I'd
expect that per-cpu data is mostly accessed by its own cpu?
So you really aren't going to get false sharing with some
other per-cpu data since the cpu is busy in this code.
So __aligned(16) would do?

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


