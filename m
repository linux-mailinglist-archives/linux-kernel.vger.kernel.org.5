Return-Path: <linux-kernel+bounces-13231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6943F820174
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 21:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A41A81C2108E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 20:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB2B14A91;
	Fri, 29 Dec 2023 20:56:26 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B480914A84
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 20:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-129-6k2WdJMjPBWp2oR0msDm8g-1; Fri, 29 Dec 2023 20:56:21 +0000
X-MC-Unique: 6k2WdJMjPBWp2oR0msDm8g-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 29 Dec
 2023 20:56:03 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 29 Dec 2023 20:56:03 +0000
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
Subject: [PATCH next 3/5] locking/osq_lock: Clarify osq_wait_next()
Thread-Topic: [PATCH next 3/5] locking/osq_lock: Clarify osq_wait_next()
Thread-Index: Ado6mW78N1Y4ctAHQ36yzrF5D7u/HQ==
Date: Fri, 29 Dec 2023 20:56:03 +0000
Message-ID: <7c8828aec72e42eeb841ca0ee3397e9a@AcuMS.aculab.com>
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

osq_wait_next() is passed 'prev' from osq_lock() and NULL from osq_unlock()
but only needs the 'cpu' value to write to lock->tail.
Just pass prev->cpu or OSQ_UNLOCKED_VAL instead.

Also directly return NULL or 'next' instead of breaking the loop.

Should have no effect on the generated code since gcc manages to
assume that 'prev !=3D NULL' due to an earlier dereference.

Signed-off-by: David Laight <david.laight@aculab.com>
---
 kernel/locking/osq_lock.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
index 55f5db896c02..9bb3a077ba92 100644
--- a/kernel/locking/osq_lock.c
+++ b/kernel/locking/osq_lock.c
@@ -48,18 +48,17 @@ static inline struct optimistic_spin_node *decode_cpu(i=
nt encoded_cpu_val)
 static inline struct optimistic_spin_node *
 osq_wait_next(struct optimistic_spin_queue *lock,
 =09      struct optimistic_spin_node *node,
-=09      struct optimistic_spin_node *prev)
+=09      int old)
 {
-=09struct optimistic_spin_node *next =3D NULL;
+=09struct optimistic_spin_node *next;
 =09int curr =3D node->cpu;
-=09int old;
=20
 =09/*
-=09 * If there is a prev node in queue, then the 'old' value will be
-=09 * the prev node's CPU #, else it's set to OSQ_UNLOCKED_VAL since if
-=09 * we're currently last in queue, then the queue will then become empty=
.
+=09 * If osq_lock() is being cancelled there must be a previous node
+=09 * and 'old' is its CPU #.
+=09 * For osq_unlock() there is never a previous node and old is set
+=09 * to OSQ_UNLOCKED_VAL.
 =09 */
-=09old =3D prev ? prev->cpu : OSQ_UNLOCKED_VAL;
=20
 =09for (;;) {
 =09=09if (atomic_read(&lock->tail) =3D=3D curr &&
@@ -69,7 +68,7 @@ osq_wait_next(struct optimistic_spin_queue *lock,
 =09=09=09 * will now observe @lock and will complete its
 =09=09=09 * unlock()/unqueue().
 =09=09=09 */
-=09=09=09break;
+=09=09=09return NULL;
 =09=09}
=20
 =09=09/*
@@ -85,13 +84,11 @@ osq_wait_next(struct optimistic_spin_queue *lock,
 =09=09if (node->next) {
 =09=09=09next =3D xchg(&node->next, NULL);
 =09=09=09if (next)
-=09=09=09=09break;
+=09=09=09=09return next;
 =09=09}
=20
 =09=09cpu_relax();
 =09}
-
-=09return next;
 }
=20
 bool osq_lock(struct optimistic_spin_queue *lock)
@@ -192,7 +189,7 @@ bool osq_lock(struct optimistic_spin_queue *lock)
 =09 * back to @prev.
 =09 */
=20
-=09next =3D osq_wait_next(lock, node, prev);
+=09next =3D osq_wait_next(lock, node, prev->cpu);
 =09if (!next)
 =09=09return false;
=20
@@ -232,7 +229,7 @@ void osq_unlock(struct optimistic_spin_queue *lock)
 =09=09return;
 =09}
=20
-=09next =3D osq_wait_next(lock, node, NULL);
+=09next =3D osq_wait_next(lock, node, OSQ_UNLOCKED_VAL);
 =09if (next)
 =09=09WRITE_ONCE(next->locked, 1);
 }
--=20
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


