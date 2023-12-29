Return-Path: <linux-kernel+bounces-13232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6407B820176
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 21:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EACF0B21B11
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 20:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418D814A93;
	Fri, 29 Dec 2023 20:57:38 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13B914A83
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 20:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-311-yCoQCupGOBSlWEcLQ3ukbA-1; Fri, 29 Dec 2023 20:57:31 +0000
X-MC-Unique: yCoQCupGOBSlWEcLQ3ukbA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 29 Dec
 2023 20:57:14 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 29 Dec 2023 20:57:14 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	"'peterz@infradead.org'" <peterz@infradead.org>, "'longman@redhat.com'"
	<longman@redhat.com>
CC: "'mingo@redhat.com'" <mingo@redhat.com>, "'will@kernel.org'"
	<will@kernel.org>, "'boqun.feng@gmail.com'" <boqun.feng@gmail.com>, "'Linus
 Torvalds'" <torvalds@linux-foundation.org>, "'xinhui.pan@linux.vnet.ibm.com'"
	<xinhui.pan@linux.vnet.ibm.com>,
	"'virtualization@lists.linux-foundation.org'"
	<virtualization@lists.linux-foundation.org>, 'Zeng Heng'
	<zengheng4@huawei.com>
Subject: [PATCH next 4/5] locking/osq_lock: Optimise per-cpu data accesses.
Thread-Topic: [PATCH next 4/5] locking/osq_lock: Optimise per-cpu data
 accesses.
Thread-Index: Ado6mZUJWFdx4PkETd+mn/PWVjPd0A==
Date: Fri, 29 Dec 2023 20:57:13 +0000
Message-ID: <bddb6b00434d4492abca4725c10f8d5a@AcuMS.aculab.com>
References: <73a4b31c9c874081baabad9e5f2e5204@AcuMS.aculab.com>
In-Reply-To: <73a4b31c9c874081baabad9e5f2e5204@AcuMS.aculab.com>
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

this_cpu_ptr() is rather more expensive than raw_cpu_read() since
the latter can use an 'offset from register' (%gs for x86-84).

Add a 'self' field to 'struct optimistic_spin_node' that can be
read with raw_cpu_read(), initialise on first call.

Signed-off-by: David Laight <david.laight@aculab.com>
---
 kernel/locking/osq_lock.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
index 9bb3a077ba92..b60b0add0161 100644
--- a/kernel/locking/osq_lock.c
+++ b/kernel/locking/osq_lock.c
@@ -13,7 +13,7 @@
  */
=20
 struct optimistic_spin_node {
-=09struct optimistic_spin_node *next, *prev;
+=09struct optimistic_spin_node *self, *next, *prev;
 =09int locked; /* 1 if lock acquired */
 =09int cpu; /* encoded CPU # + 1 value */
 };
@@ -93,12 +93,16 @@ osq_wait_next(struct optimistic_spin_queue *lock,
=20
 bool osq_lock(struct optimistic_spin_queue *lock)
 {
-=09struct optimistic_spin_node *node =3D this_cpu_ptr(&osq_node);
+=09struct optimistic_spin_node *node =3D raw_cpu_read(osq_node.self);
 =09struct optimistic_spin_node *prev, *next;
 =09int old;
=20
-=09if (unlikely(node->cpu =3D=3D OSQ_UNLOCKED_VAL))
-=09=09node->cpu =3D encode_cpu(smp_processor_id());
+=09if (unlikely(!node)) {
+=09=09int cpu =3D encode_cpu(smp_processor_id());
+=09=09node =3D decode_cpu(cpu);
+=09=09node->self =3D node;
+=09=09node->cpu =3D cpu;
+=09}
=20
 =09/*
 =09 * We need both ACQUIRE (pairs with corresponding RELEASE in
@@ -222,7 +226,7 @@ void osq_unlock(struct optimistic_spin_queue *lock)
 =09/*
 =09 * Second most likely case.
 =09 */
-=09node =3D this_cpu_ptr(&osq_node);
+=09node =3D raw_cpu_read(osq_node.self);
 =09next =3D xchg(&node->next, NULL);
 =09if (next) {
 =09=09WRITE_ONCE(next->locked, 1);
--=20
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


