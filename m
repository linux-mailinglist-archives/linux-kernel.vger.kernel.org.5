Return-Path: <linux-kernel+bounces-13794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4DB820F30
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 22:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD4DF282786
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 21:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67308FBF2;
	Sun, 31 Dec 2023 21:56:17 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84870FBE5
	for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 21:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-169-VmXxqLQzMMGaMcPZew1zOA-1; Sun, 31 Dec 2023 21:56:12 +0000
X-MC-Unique: VmXxqLQzMMGaMcPZew1zOA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 31 Dec
 2023 21:55:50 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 31 Dec 2023 21:55:50 +0000
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
Subject: [PATCH next v2 5/5] locking/osq_lock: Optimise decode_cpu() and
 per_cpu_ptr().
Thread-Topic: [PATCH next v2 5/5] locking/osq_lock: Optimise decode_cpu() and
 per_cpu_ptr().
Thread-Index: Ado8NCf0vtha6NqURtGgfE7//QxHew==
Date: Sun, 31 Dec 2023 21:55:50 +0000
Message-ID: <7c1148fe64fb46a7a81c984776cd91df@AcuMS.aculab.com>
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

per_cpu_ptr() indexes __per_cpu_offset[] with the cpu number.
This requires the cpu number be 64bit.
However the value is osq_lock() comes from a 32bit xchg() and there
isn't a way of telling gcc the high bits are zero (they are) so
there will always be an instruction to clear the high bits.

The cpu number is also offset by one (to make the initialiser 0)
It seems to be impossible to get gcc to convert __per_cpu_offset[cpu_p1 - 1=
]
into (__per_cpu_offset - 1)[cpu_p1] (transferring the offset to the address=
).

Converting the cpu number to 32bit unsigned prior to the decrement means
that gcc knows the decrement has set the high bits to zero and doesn't
add a register-register move (or cltq) to zero/sign extend the value.

Not massive but saves two instructions.

Signed-off-by: David Laight <david.laight@aculab.com>
---
 kernel/locking/osq_lock.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
index 35bb99e96697..37a4fa872989 100644
--- a/kernel/locking/osq_lock.c
+++ b/kernel/locking/osq_lock.c
@@ -29,11 +29,9 @@ static inline int encode_cpu(int cpu_nr)
 =09return cpu_nr + 1;
 }
=20
-static inline struct optimistic_spin_node *decode_cpu(int encoded_cpu_val)
+static inline struct optimistic_spin_node *decode_cpu(unsigned int encoded=
_cpu_val)
 {
-=09int cpu_nr =3D encoded_cpu_val - 1;
-
-=09return per_cpu_ptr(&osq_node, cpu_nr);
+=09return per_cpu_ptr(&osq_node, encoded_cpu_val - 1);
 }
=20
 /*
--=20
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


