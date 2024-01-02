Return-Path: <linux-kernel+bounces-14235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A9D821990
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 11:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 281D81C219E3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115C2DDBC;
	Tue,  2 Jan 2024 10:20:36 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8793DDB3
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 10:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-7-5Ka6-v20NqyBx0GakCnmcg-1; Tue, 02 Jan 2024 10:20:31 +0000
X-MC-Unique: 5Ka6-v20NqyBx0GakCnmcg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 2 Jan
 2024 10:20:14 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 2 Jan 2024 10:20:14 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Ingo Molnar' <mingo@kernel.org>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	"'peterz@infradead.org'" <peterz@infradead.org>, "'longman@redhat.com'"
	<longman@redhat.com>, "'mingo@redhat.com'" <mingo@redhat.com>,
	"'will@kernel.org'" <will@kernel.org>, "'boqun.feng@gmail.com'"
	<boqun.feng@gmail.com>, 'Linus Torvalds' <torvalds@linux-foundation.org>,
	"'virtualization@lists.linux-foundation.org'"
	<virtualization@lists.linux-foundation.org>, 'Zeng Heng'
	<zengheng4@huawei.com>
Subject: RE: [PATCH next v2 5/5] locking/osq_lock: Optimise decode_cpu() and
 per_cpu_ptr().
Thread-Topic: [PATCH next v2 5/5] locking/osq_lock: Optimise decode_cpu() and
 per_cpu_ptr().
Thread-Index: Ado8NCf0vtha6NqURtGgfE7//QxHewBLYOUAAABil0A=
Date: Tue, 2 Jan 2024 10:20:14 +0000
Message-ID: <c0bccbe448024994a28b80b5b50d8475@AcuMS.aculab.com>
References: <2b4e8a5816a742d2bd23fdbaa8498e80@AcuMS.aculab.com>
 <7c1148fe64fb46a7a81c984776cd91df@AcuMS.aculab.com>
 <ZZPdUv6uRvqXlyYo@gmail.com>
In-Reply-To: <ZZPdUv6uRvqXlyYo@gmail.com>
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

From: Ingo Molnar
> Sent: 02 January 2024 09:54
>=20
>=20
> * David Laight <David.Laight@ACULAB.COM> wrote:
>=20
> > per_cpu_ptr() indexes __per_cpu_offset[] with the cpu number.
> > This requires the cpu number be 64bit.
> > However the value is osq_lock() comes from a 32bit xchg() and there
> > isn't a way of telling gcc the high bits are zero (they are) so
> > there will always be an instruction to clear the high bits.
> >
> > The cpu number is also offset by one (to make the initialiser 0)
> > It seems to be impossible to get gcc to convert __per_cpu_offset[cpu_p1=
 - 1]
> > into (__per_cpu_offset - 1)[cpu_p1] (transferring the offset to the add=
ress).
> >
> > Converting the cpu number to 32bit unsigned prior to the decrement mean=
s
> > that gcc knows the decrement has set the high bits to zero and doesn't
> > add a register-register move (or cltq) to zero/sign extend the value.
> >
> > Not massive but saves two instructions.
> >
> > Signed-off-by: David Laight <david.laight@aculab.com>
> > ---
> >  kernel/locking/osq_lock.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
> > index 35bb99e96697..37a4fa872989 100644
> > --- a/kernel/locking/osq_lock.c
> > +++ b/kernel/locking/osq_lock.c
> > @@ -29,11 +29,9 @@ static inline int encode_cpu(int cpu_nr)
> >  =09return cpu_nr + 1;
> >  }
> >
> > -static inline struct optimistic_spin_node *decode_cpu(int encoded_cpu_=
val)
> > +static inline struct optimistic_spin_node *decode_cpu(unsigned int enc=
oded_cpu_val)
> >  {
> > -=09int cpu_nr =3D encoded_cpu_val - 1;
> > -
> > -=09return per_cpu_ptr(&osq_node, cpu_nr);
> > +=09return per_cpu_ptr(&osq_node, encoded_cpu_val - 1);
>=20
> So why do we 'encode' the CPU number to begin with?
>=20
> Why not use -1 as the special value? Checks for negative values
> generates similarly fast machine code compared to checking for 0, if
> the value is also used (which it is in most cases here). What am I
> missing? We seem to be going through a lot of unnecessary hoops, and
> some of that is in the runtime path.

You'd really have to ask the person who did the original patch
that changed lock->tail from a pointer to an int (saving 8 bytes)
in every mutex and rwsem.

I suspect the reason is that it is so much safer to have the
initialiser being zero, rather than a non-zero value with zero
being a valid value.

It is also hard to avoid an extra instruction in the per_cpu_ptr()
code - something has to extend the 32bit result from xchg() to
a 64bit one for the array index.
The asm for an unsigned 32bit exchange could return a 64bit result
(which would have the desired effect), but that won't work for
a signed value.
The '-1' in the vcpu_is_preempted() path will be executed in parallel
with something else and is likely to have no measurable effect.

So it is a slightly risky change that has less benefit than the
other changes (which save cache line accesses).

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


