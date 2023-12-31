Return-Path: <linux-kernel+bounces-13793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DD7820F2B
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 22:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 717E31F215B8
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 21:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39003F9DE;
	Sun, 31 Dec 2023 21:55:26 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BC1F9CC
	for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 21:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-44-6gjeuhImOKioWY8extJLBA-1; Sun, 31 Dec 2023 21:55:20 +0000
X-MC-Unique: 6gjeuhImOKioWY8extJLBA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 31 Dec
 2023 21:54:59 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 31 Dec 2023 21:54:59 +0000
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
Subject: [PATCH next v2 4/5] locking/osq_lock: Avoid writing to node->next in
 the osq_lock() fast path.
Thread-Topic: [PATCH next v2 4/5] locking/osq_lock: Avoid writing to
 node->next in the osq_lock() fast path.
Thread-Index: Ado8NAjQtRL812H3R1Kc4G+FOscjCQ==
Date: Sun, 31 Dec 2023 21:54:59 +0000
Message-ID: <06a11b2c7d784f2d80dc8e81c7175c57@AcuMS.aculab.com>
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

When osq_lock() returns false or osq_unlock() returns static
analysis shows that node->next should always be NULL.
This means that it isn't necessary to explicitly set it to NULL
prior to atomic_xchg(&lock->tail, curr) on extry to osq_lock().

Just in case there a non-obvious race condition that can leave it
non-NULL check with WARN_ON_ONCE() and NULL if set.
Note that without this check the fast path (adding at the list head)
doesn't need to to access the per-cpu osq_node at all.

Signed-off-by: David Laight <david.laight@aculab.com>
---
 kernel/locking/osq_lock.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
index 27324b509f68..35bb99e96697 100644
--- a/kernel/locking/osq_lock.c
+++ b/kernel/locking/osq_lock.c
@@ -87,12 +87,17 @@ osq_wait_next(struct optimistic_spin_queue *lock,
=20
 bool osq_lock(struct optimistic_spin_queue *lock)
 {
-=09struct optimistic_spin_node *node =3D this_cpu_ptr(&osq_node);
-=09struct optimistic_spin_node *prev, *next;
+=09struct optimistic_spin_node *node, *prev, *next;
 =09int curr =3D encode_cpu(smp_processor_id());
 =09int prev_cpu;
=20
-=09node->next =3D NULL;
+=09/*
+=09 * node->next should be NULL on entry.
+=09 * Check just in case there is a race somewhere.
+=09 * Note that this is probably an unnecessary cache miss in the fast pat=
h.
+=09 */
+=09if (WARN_ON_ONCE(raw_cpu_read(osq_node.next) !=3D NULL))
+=09=09raw_cpu_write(osq_node.next, NULL);
=20
 =09/*
 =09 * We need both ACQUIRE (pairs with corresponding RELEASE in
@@ -104,8 +109,9 @@ bool osq_lock(struct optimistic_spin_queue *lock)
 =09if (prev_cpu =3D=3D OSQ_UNLOCKED_VAL)
 =09=09return true;
=20
-=09node->prev_cpu =3D prev_cpu;
+=09node =3D this_cpu_ptr(&osq_node);
 =09prev =3D decode_cpu(prev_cpu);
+=09node->prev_cpu =3D prev_cpu;
 =09node->locked =3D 0;
=20
 =09/*
--=20
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


