Return-Path: <linux-kernel+bounces-13233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5FC820178
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 21:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFB671C2134C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 20:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960F11428D;
	Fri, 29 Dec 2023 20:58:43 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEA91426F
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 20:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-202-bl5_I54CNsuf5Ujw93Ax2g-1; Fri, 29 Dec 2023 20:58:32 +0000
X-MC-Unique: bl5_I54CNsuf5Ujw93Ax2g-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 29 Dec
 2023 20:58:15 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 29 Dec 2023 20:58:15 +0000
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
Subject: [PATCH next 5/5] locking/osq_lock: Optimise vcpu_is_preempted()
 check.
Thread-Topic: [PATCH next 5/5] locking/osq_lock: Optimise vcpu_is_preempted()
 check.
Thread-Index: Ado6mcFsTi5k8LaETrKavOOIB4in0Q==
Date: Fri, 29 Dec 2023 20:58:15 +0000
Message-ID: <23cef5ac49494b9087953f529ae5df16@AcuMS.aculab.com>
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

The vcpu_is_preempted() test stops osq_lock() spinning if a virtual
  cpu is no longer running.
Although patched out for bare-metal the code still needs the cpu number.
Reading this from 'prev->cpu' is a pretty much guaranteed have a cache miss
when osq_unlock() is waking up the next cpu.

Instead save 'prev->cpu' in 'node->prev_cpu' and use that value instead.
Update in the osq_lock() 'unqueue' path when 'node->prev' is changed.

This is simpler than checking for 'node->prev' changing and caching
'prev->cpu'.

Signed-off-by: David Laight <david.laight@aculab.com>
---
 kernel/locking/osq_lock.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
index b60b0add0161..89be63627434 100644
--- a/kernel/locking/osq_lock.c
+++ b/kernel/locking/osq_lock.c
@@ -14,8 +14,9 @@
=20
 struct optimistic_spin_node {
 =09struct optimistic_spin_node *self, *next, *prev;
-=09int locked; /* 1 if lock acquired */
-=09int cpu; /* encoded CPU # + 1 value */
+=09int locked;    /* 1 if lock acquired */
+=09int cpu;       /* encoded CPU # + 1 value */
+=09int prev_cpu;  /* actual CPU # for vpcu_is_preempted() */
 };
=20
 static DEFINE_PER_CPU_SHARED_ALIGNED(struct optimistic_spin_node, osq_node=
);
@@ -29,11 +30,6 @@ static inline int encode_cpu(int cpu_nr)
 =09return cpu_nr + 1;
 }
=20
-static inline int node_cpu(struct optimistic_spin_node *node)
-{
-=09return node->cpu - 1;
-}
-
 static inline struct optimistic_spin_node *decode_cpu(int encoded_cpu_val)
 {
 =09int cpu_nr =3D encoded_cpu_val - 1;
@@ -114,6 +110,7 @@ bool osq_lock(struct optimistic_spin_queue *lock)
 =09if (old =3D=3D OSQ_UNLOCKED_VAL)
 =09=09return true;
=20
+=09node->prev_cpu =3D old - 1;
 =09prev =3D decode_cpu(old);
 =09node->prev =3D prev;
 =09node->locked =3D 0;
@@ -148,7 +145,7 @@ bool osq_lock(struct optimistic_spin_queue *lock)
 =09 * polling, be careful.
 =09 */
 =09if (smp_cond_load_relaxed(&node->locked, VAL || need_resched() ||
-=09=09=09=09  vcpu_is_preempted(node_cpu(node->prev))))
+=09=09=09=09  vcpu_is_preempted(node->prev_cpu)))
 =09=09return true;
=20
 =09/* unqueue */
@@ -205,6 +202,7 @@ bool osq_lock(struct optimistic_spin_queue *lock)
 =09 * it will wait in Step-A.
 =09 */
=20
+=09WRITE_ONCE(next->prev_cpu, prev->cpu - 1);
 =09WRITE_ONCE(next->prev, prev);
 =09WRITE_ONCE(prev->next, next);
=20
--=20
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


