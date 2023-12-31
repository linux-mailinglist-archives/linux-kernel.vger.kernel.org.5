Return-Path: <linux-kernel+bounces-13790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04009820F16
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 22:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A753D28271C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 21:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04969BE6D;
	Sun, 31 Dec 2023 21:51:47 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA524BE48
	for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 21:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-176-11hdVQWzMwqIR5R8bjWLew-1; Sun, 31 Dec 2023 21:51:41 +0000
X-MC-Unique: 11hdVQWzMwqIR5R8bjWLew-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 31 Dec
 2023 21:51:20 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 31 Dec 2023 21:51:20 +0000
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
Subject: [PATCH next v2 1/5] locking/osq_lock: Defer clearing node->locked
 until the slow osq_lock() path.
Thread-Topic: [PATCH next v2 1/5] locking/osq_lock: Defer clearing
 node->locked until the slow osq_lock() path.
Thread-Index: Ado8M4Xvt5eQHXh8TpKpithIgw++9g==
Date: Sun, 31 Dec 2023 21:51:20 +0000
Message-ID: <714ca2e587cf4cd485ae04e5afb8d5bb@AcuMS.aculab.com>
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

Since node->locked cannot be set before the assignment to prev->next
it is save to clear it in the slow path.

Signed-off-by: David Laight <david.laight@aculab.com>
---
 kernel/locking/osq_lock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
index 75a6f6133866..e0bc74d85a76 100644
--- a/kernel/locking/osq_lock.c
+++ b/kernel/locking/osq_lock.c
@@ -97,7 +97,6 @@ bool osq_lock(struct optimistic_spin_queue *lock)
 =09int curr =3D encode_cpu(smp_processor_id());
 =09int old;
=20
-=09node->locked =3D 0;
 =09node->next =3D NULL;
 =09node->cpu =3D curr;
=20
@@ -111,6 +110,7 @@ bool osq_lock(struct optimistic_spin_queue *lock)
 =09if (old =3D=3D OSQ_UNLOCKED_VAL)
 =09=09return true;
=20
+=09node->locked =3D 0;
 =09prev =3D decode_cpu(old);
 =09node->prev =3D prev;
=20
--=20
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


