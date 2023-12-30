Return-Path: <linux-kernel+bounces-13404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4C38204A1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 12:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49B7D281F62
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 11:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623F98BFC;
	Sat, 30 Dec 2023 11:35:54 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB43B8BE3
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 11:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-250-bYVrSc7XPvudaj0upR0veg-1; Sat, 30 Dec 2023 11:35:48 +0000
X-MC-Unique: bYVrSc7XPvudaj0upR0veg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 30 Dec
 2023 11:35:32 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 30 Dec 2023 11:35:32 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Ingo Molnar' <mingo@kernel.org>, Waiman Long <longman@redhat.com>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	"'peterz@infradead.org'" <peterz@infradead.org>, "'mingo@redhat.com'"
	<mingo@redhat.com>, "'will@kernel.org'" <will@kernel.org>,
	"'boqun.feng@gmail.com'" <boqun.feng@gmail.com>, 'Linus Torvalds'
	<torvalds@linux-foundation.org>, "'xinhui.pan@linux.vnet.ibm.com'"
	<xinhui.pan@linux.vnet.ibm.com>,
	"'virtualization@lists.linux-foundation.org'"
	<virtualization@lists.linux-foundation.org>, 'Zeng Heng'
	<zengheng4@huawei.com>
Subject: RE: [PATCH next 4/5] locking/osq_lock: Optimise per-cpu data
 accesses.
Thread-Topic: [PATCH next 4/5] locking/osq_lock: Optimise per-cpu data
 accesses.
Thread-Index: Ado6mZUJWFdx4PkETd+mn/PWVjPd0AAdwkAdAABoNTA=
Date: Sat, 30 Dec 2023 11:35:32 +0000
Message-ID: <4b9da867c24f4ff990851050c8f61515@AcuMS.aculab.com>
References: <73a4b31c9c874081baabad9e5f2e5204@AcuMS.aculab.com>
 <bddb6b00434d4492abca4725c10f8d5a@AcuMS.aculab.com>
 <346c40b5-686f-461e-a1e3-9f255418efb2@redhat.com>
 <ZY/6YCNJ7tSCmiGo@gmail.com>
In-Reply-To: <ZY/6YCNJ7tSCmiGo@gmail.com>
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
> Sent: 30 December 2023 11:09
>=20
>=20
> * Waiman Long <longman@redhat.com> wrote:
>=20
> > On 12/29/23 15:57, David Laight wrote:
> > > this_cpu_ptr() is rather more expensive than raw_cpu_read() since
> > > the latter can use an 'offset from register' (%gs for x86-84).
> > >
> > > Add a 'self' field to 'struct optimistic_spin_node' that can be
> > > read with raw_cpu_read(), initialise on first call.
> > >
> > > Signed-off-by: David Laight <david.laight@aculab.com>
> > > ---
> > >   kernel/locking/osq_lock.c | 14 +++++++++-----
> > >   1 file changed, 9 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
> > > index 9bb3a077ba92..b60b0add0161 100644
> > > --- a/kernel/locking/osq_lock.c
> > > +++ b/kernel/locking/osq_lock.c
> > > @@ -13,7 +13,7 @@
> > >    */
> > >   struct optimistic_spin_node {
> > > -=09struct optimistic_spin_node *next, *prev;
> > > +=09struct optimistic_spin_node *self, *next, *prev;
> > >   =09int locked; /* 1 if lock acquired */
> > >   =09int cpu; /* encoded CPU # + 1 value */
> > >   };
> > > @@ -93,12 +93,16 @@ osq_wait_next(struct optimistic_spin_queue *lock,
> > >   bool osq_lock(struct optimistic_spin_queue *lock)
> > >   {
> > > -=09struct optimistic_spin_node *node =3D this_cpu_ptr(&osq_node);
> > > +=09struct optimistic_spin_node *node =3D raw_cpu_read(osq_node.self)=
;
> >
> > My gcc 11 compiler produces the following x86-64 code:
> >
> > 92=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 struct optimistic_spin_node *no=
de =3D this_cpu_ptr(&osq_node);
> > =C2=A0=C2=A0 0x0000000000000029 <+25>:=C2=A0=C2=A0=C2=A0 mov=C2=A0=C2=
=A0=C2=A0 %rcx,%rdx
> > =C2=A0=C2=A0 0x000000000000002c <+28>:=C2=A0=C2=A0=C2=A0 add %gs:0x0(%r=
ip),%rdx=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # 0x34
> > <osq_lock+36>
> >
> > Which looks pretty optimized for me. Maybe older compiler may generate =
more
> > complex code. However, I do have some doubt as to the benefit of this p=
atch
> > at the expense of making the code a bit more complex.

My changed code is one instruction shorter!
  18:   65 48 8b 15 00 00 00    mov    %gs:0x0(%rip),%rdx        # 20 <osq_=
lock+0x20>
  1f:   00
                        1c: R_X86_64_PC32       .data..percpu..shared_align=
ed-0x4
However is might have one less cache line miss.

> GCC-11 is plenty of a look-back window in terms of compiler efficiency:
> latest enterprise distros use GCC-11 or newer, while recent desktop
> distros use GCC-13. Anything older won't matter, because no major
> distribution is going to use new kernels with old compilers.

There must be a difference in the header files as well.
Possibly forced by the older compiler I'm using (7.5 from Ubuntu 18.04).
But maybe based on some config option.

I'm seeing this_cpu_ptr(&xxx) converted to per_cpu_ptr(&xxx, smp_processor_=
id())
which necessitates an array lookup (indexed by cpu number).
Whereas I think you are seeing it implemented as
  raw_cpu_read(per_cpu_data_base) + offset_to(xxx)

So the old code generates (after the prologue):
  10:   49 89 fd                mov    %rdi,%r13
  13:   49 c7 c4 00 00 00 00    mov    $0x0,%r12
                        16: R_X86_64_32S        .data..percpu..shared_align=
ed
  1a:   e8 00 00 00 00          callq  1f <osq_lock+0x1f>
                        1b: R_X86_64_PC32       debug_smp_processor_id-0x4
  1f:   89 c0                   mov    %eax,%eax
  21:   48 8b 1c c5 00 00 00    mov    0x0(,%rax,8),%rbx
  28:   00
                        25: R_X86_64_32S        __per_cpu_offset
  29:   e8 00 00 00 00          callq  2e <osq_lock+0x2e>
                        2a: R_X86_64_PC32       debug_smp_processor_id-0x4
  2e:   4c 01 e3                add    %r12,%rbx
  31:   83 c0 01                add    $0x1,%eax
  34:   c7 43 10 00 00 00 00    movl   $0x0,0x10(%rbx)
  3b:   48 c7 03 00 00 00 00    movq   $0x0,(%rbx)
  42:   89 43 14                mov    %eax,0x14(%rbx)
  45:   41 87 45 00             xchg   %eax,0x0(%r13)

I was also surprised that smp_processor_id() is a real function rather
than an offset from %gs.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


