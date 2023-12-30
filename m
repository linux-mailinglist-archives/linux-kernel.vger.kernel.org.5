Return-Path: <linux-kernel+bounces-13605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A618208B7
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 23:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76E90281C16
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 22:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4263BF9C4;
	Sat, 30 Dec 2023 22:47:42 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5B9E546
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 22:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-44-HrekTaZ8MoaRuuAvFWTwrg-1; Sat, 30 Dec 2023 22:47:37 +0000
X-MC-Unique: HrekTaZ8MoaRuuAvFWTwrg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 30 Dec
 2023 22:47:19 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 30 Dec 2023 22:47:19 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Ingo Molnar' <mingo@kernel.org>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	"'peterz@infradead.org'" <peterz@infradead.org>, "'longman@redhat.com'"
	<longman@redhat.com>, "'mingo@redhat.com'" <mingo@redhat.com>,
	"'will@kernel.org'" <will@kernel.org>, "'boqun.feng@gmail.com'"
	<boqun.feng@gmail.com>, 'Linus Torvalds' <torvalds@linux-foundation.org>,
	"'xinhui.pan@linux.vnet.ibm.com'" <xinhui.pan@linux.vnet.ibm.com>,
	"'virtualization@lists.linux-foundation.org'"
	<virtualization@lists.linux-foundation.org>, 'Zeng Heng'
	<zengheng4@huawei.com>
Subject: RE: [PATCH next 4/5] locking/osq_lock: Optimise per-cpu data
 accesses.
Thread-Topic: [PATCH next 4/5] locking/osq_lock: Optimise per-cpu data
 accesses.
Thread-Index: Ado6mZUJWFdx4PkETd+mn/PWVjPd0AAxm5QAAARO0qA=
Date: Sat, 30 Dec 2023 22:47:19 +0000
Message-ID: <f11f674ae0ab4ef0a2ae76235c6352d2@AcuMS.aculab.com>
References: <73a4b31c9c874081baabad9e5f2e5204@AcuMS.aculab.com>
 <bddb6b00434d4492abca4725c10f8d5a@AcuMS.aculab.com>
 <ZZB/jIvKgKQ2sV7M@gmail.com>
In-Reply-To: <ZZB/jIvKgKQ2sV7M@gmail.com>
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
> Sent: 30 December 2023 20:38
>=20
> * David Laight <David.Laight@ACULAB.COM> wrote:
>=20
> >  bool osq_lock(struct optimistic_spin_queue *lock)
> >  {
> > -=09struct optimistic_spin_node *node =3D this_cpu_ptr(&osq_node);
> > +=09struct optimistic_spin_node *node =3D raw_cpu_read(osq_node.self);
> >  =09struct optimistic_spin_node *prev, *next;
> >  =09int old;
> >
> > -=09if (unlikely(node->cpu =3D=3D OSQ_UNLOCKED_VAL))
> > -=09=09node->cpu =3D encode_cpu(smp_processor_id());
> > +=09if (unlikely(!node)) {
> > +=09=09int cpu =3D encode_cpu(smp_processor_id());
> > +=09=09node =3D decode_cpu(cpu);
> > +=09=09node->self =3D node;
> > +=09=09node->cpu =3D cpu;
>=20
> This whole initialization sequence is suboptimal and needs to be
> cleaned up first: the node->cpu field is constant once initialized, so
> it should be initialized from appropriate init methods, not runtime in
> osq_lock(), right?

I thought that as well, but there would need to be a list of 'init'
functions for the per-cpu data. I didn't spot one.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


