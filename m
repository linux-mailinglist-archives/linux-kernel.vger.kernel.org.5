Return-Path: <linux-kernel+bounces-13789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3015B820F0F
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 22:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBD5E1F21E9A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 21:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BDFC129;
	Sun, 31 Dec 2023 21:50:21 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E75BE48
	for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 21:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-309-lFOnXFemMY-uP990CKkryw-1; Sun, 31 Dec 2023 21:50:15 +0000
X-MC-Unique: lFOnXFemMY-uP990CKkryw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 31 Dec
 2023 21:49:53 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 31 Dec 2023 21:49:53 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	"'peterz@infradead.org'" <peterz@infradead.org>, "'longman@redhat.com'"
	<longman@redhat.com>
CC: "'mingo@redhat.com'" <mingo@redhat.com>, "'will@kernel.org'"
	<will@kernel.org>, "'boqun.feng@gmail.com'" <boqun.feng@gmail.com>, "'Linus
 Torvalds'" <torvalds@linux-foundation.org>,
	"'virtualization@lists.linux-foundation.org'"
	<virtualization@lists.linux-foundation.org>, 'Zeng Heng'
	<zengheng4@huawei.com>
Subject: [PATCH next v2 0/5] locking/osq_lock: Optimisations to osq_lock code.
Thread-Topic: [PATCH next v2 0/5] locking/osq_lock: Optimisations to osq_lock
 code.
Thread-Index: Ado8IBeq6d8EUiQSSN60y73H2fc39w==
Date: Sun, 31 Dec 2023 21:49:53 +0000
Message-ID: <2b4e8a5816a742d2bd23fdbaa8498e80@AcuMS.aculab.com>
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

This is an updated series of optimisations to osq_lock.c
Patches #1 and #3 from v1 have been applied by Linus.
Some of the generated code issues I was getting were caused by
CONFIG_DEBUG_PREEMPT being set. No idea why, it isn't any more.

Patch #1 is the node->locked part of the old #2.

Patch #2 removes the pretty much guaranteed cache line reload getting
the cpu number (from node->prev) for the vcpu_is_preempted() check.
It is (basically) the old #5 with the addition of a READ_ONCE()
and leaving the '+ 1' offset (for patch 3).

Patch #3 ends up removing both node->cpu and node->prev.
This saves issues initialising node->cpu.
Basically node->cpu was only ever read as node->prev->cpu in the unqueue co=
de.
Most of the time it is the value read from lock->tail that was used to
obtain 'prev' in the first place.
The only time it is different is in the unlock race path where 'prev'
is re-read from node->prev - updated right at the bottom of osq_lock().
So the updated node->prev_cpu can used (and prev obtained from it) without
worrying about only one of node->prev and node->prev-cpu being updated.

Linus did suggest just saving the cpu numbers instead of pointers.
It actually works for 'prev' but not 'next'.

Patch #4 removes the 'should be unnecessary' node->next =3D NULL
assignment from the top of osq_lock().
Since longman was worried about race conditions, I've added a
WARN_ON_ONCE() check that ensures it is NULL.
This saves dirtying the 'node' cache line in the fast path, but the
check still requires the cache line be loaded.

Patch #5 just stops gcc using two separate instructions to decrement
the offset cpu number and then convert it to 64 bits.
Linus got annoyed with it, and I'd spotted it as well.
I don't seem to be able to get gcc to convert __per_cpu_offset[cpu - 1]
to (__per_cpu_offset - 1)[cpu] (cpu is offset by one) but, in any case,
it would still need zero extending in the common case.

David Laight (5):
  1) Defer clearing node->locked until the slow osq_lock() path.
  2) Optimise vcpu_is_preempted() check.
  3) Use node->prev_cpu instead of saving node->prev.
  4) Avoid writing to node->next in the osq_lock() fast path.
  5) Optimise decode_cpu() and per_cpu_ptr().

 kernel/locking/osq_lock.c | 59 +++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 27 deletions(-)

--=20
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


