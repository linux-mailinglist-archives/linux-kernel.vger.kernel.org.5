Return-Path: <linux-kernel+bounces-13792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C41CE820F26
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 22:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00E1A1C21AD9
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 21:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E1FE556;
	Sun, 31 Dec 2023 21:54:29 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEC9DF42
	for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 21:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-254-BKaLleaNN2m97ul2XwiUmA-1; Sun, 31 Dec 2023 21:54:24 +0000
X-MC-Unique: BKaLleaNN2m97ul2XwiUmA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 31 Dec
 2023 21:54:02 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 31 Dec 2023 21:54:02 +0000
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
Subject: [PATCH next v2 3/5] locking/osq_lock: Use node->prev_cpu instead of
 saving node->prev.
Thread-Topic: [PATCH next v2 3/5] locking/osq_lock: Use node->prev_cpu instead
 of saving node->prev.
Thread-Index: Ado8M93l5L/nOR+URXCdpqS8EUheiQ==
Date: Sun, 31 Dec 2023 21:54:02 +0000
Message-ID: <7906aaa73f93493c873e6286c1f96645@AcuMS.aculab.com>
References: <2b4e8a5816a742d2bd23fdbaa8498e80@AcuMS.aculab.com>
In-Reply-To: <2b4e8a5816a742d2bd23fdbaa8498e80@AcuMS.aculab.com>
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

node->prev is only used to update 'prev' in the unlikely case
of concurrent unqueues.
This can be replaced by a check for node->prev_cpu changing
and then calling decode_cpu() to get the changed 'prev' pointer.

node->cpu (or more particularly) prev->cpu is only used for the
osq_wait_next() call in the unqueue path.
Normally this is exactly the value that the initial xchg() read
from lock->tail (used to obtain 'prev'), but can get updated
by concurrent unqueues.

Both the 'prev' and 'cpu' members of optimistic_spin_node are
now unused and can be deleted.

Signed-off-by: David Laight <david.laight@aculab.com>
---
 kernel/locking/osq_lock.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
index eb8a6dfdb79d..27324b509f68 100644
--- a/kernel/locking/osq_lock.c
+++ b/kernel/locking/osq_lock.c
@@ -13,9 +13,8 @@
  */
=20
 struct optimistic_spin_node {
-=09struct optimistic_spin_node *next, *prev;
+=09struct optimistic_spin_node *next;
 =09int locked;    /* 1 if lock acquired */
-=09int cpu;       /* encoded CPU # + 1 value */
 =09int prev_cpu;  /* encoded CPU # + 1 value */
 };
=20
@@ -91,10 +90,9 @@ bool osq_lock(struct optimistic_spin_queue *lock)
 =09struct optimistic_spin_node *node =3D this_cpu_ptr(&osq_node);
 =09struct optimistic_spin_node *prev, *next;
 =09int curr =3D encode_cpu(smp_processor_id());
-=09int old;
+=09int prev_cpu;
=20
 =09node->next =3D NULL;
-=09node->cpu =3D curr;
=20
 =09/*
 =09 * We need both ACQUIRE (pairs with corresponding RELEASE in
@@ -102,13 +100,12 @@ bool osq_lock(struct optimistic_spin_queue *lock)
 =09 * the node fields we just initialised) semantics when updating
 =09 * the lock tail.
 =09 */
-=09old =3D atomic_xchg(&lock->tail, curr);
-=09if (old =3D=3D OSQ_UNLOCKED_VAL)
+=09prev_cpu =3D atomic_xchg(&lock->tail, curr);
+=09if (prev_cpu =3D=3D OSQ_UNLOCKED_VAL)
 =09=09return true;
=20
-=09node->prev_cpu =3D old;
-=09prev =3D decode_cpu(old);
-=09node->prev =3D prev;
+=09node->prev_cpu =3D prev_cpu;
+=09prev =3D decode_cpu(prev_cpu);
 =09node->locked =3D 0;
=20
 =09/*
@@ -174,9 +171,16 @@ bool osq_lock(struct optimistic_spin_queue *lock)
=20
 =09=09/*
 =09=09 * Or we race against a concurrent unqueue()'s step-B, in which
-=09=09 * case its step-C will write us a new @node->prev pointer.
+=09=09 * case its step-C will write us a new @node->prev_cpu value.
 =09=09 */
-=09=09prev =3D READ_ONCE(node->prev);
+=09=09{
+=09=09=09int new_prev_cpu =3D READ_ONCE(node->prev_cpu);
+
+=09=09=09if (new_prev_cpu =3D=3D prev_cpu)
+=09=09=09=09continue;
+=09=09=09prev_cpu =3D new_prev_cpu;
+=09=09=09prev =3D decode_cpu(prev_cpu);
+=09=09}
 =09}
=20
 =09/*
@@ -186,7 +190,7 @@ bool osq_lock(struct optimistic_spin_queue *lock)
 =09 * back to @prev.
 =09 */
=20
-=09next =3D osq_wait_next(lock, node, prev->cpu);
+=09next =3D osq_wait_next(lock, node, prev_cpu);
 =09if (!next)
 =09=09return false;
=20
@@ -198,8 +202,7 @@ bool osq_lock(struct optimistic_spin_queue *lock)
 =09 * it will wait in Step-A.
 =09 */
=20
-=09WRITE_ONCE(next->prev_cpu, prev->cpu);
-=09WRITE_ONCE(next->prev, prev);
+=09WRITE_ONCE(next->prev_cpu, prev_cpu);
 =09WRITE_ONCE(prev->next, next);
=20
 =09return false;
--=20
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


