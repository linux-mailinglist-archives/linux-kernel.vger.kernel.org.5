Return-Path: <linux-kernel+bounces-13229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 562B2820172
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 21:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 839201C2196E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 20:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1188C1428E;
	Fri, 29 Dec 2023 20:54:12 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F4914267
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 20:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-79-fRwTi2a-NdGsmCtHse5L_g-1; Fri, 29 Dec 2023 20:54:06 +0000
X-MC-Unique: fRwTi2a-NdGsmCtHse5L_g-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 29 Dec
 2023 20:53:49 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 29 Dec 2023 20:53:49 +0000
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
Subject: [PATCH next 1/5] locking/osq_lock: Move the definition of
 optimistic_spin_node into osf_lock.c
Thread-Topic: [PATCH next 1/5] locking/osq_lock: Move the definition of
 optimistic_spin_node into osf_lock.c
Thread-Index: Ado6mSDjgxSGtr3xT6CXt/ONPypOxA==
Date: Fri, 29 Dec 2023 20:53:49 +0000
Message-ID: <6eb23a47953b445281e04f5573aead65@AcuMS.aculab.com>
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

struct optimistic_spin_node is private to the implementation.
Move it into the C file to ensure nothing is accessing it.

Signed-off-by: David Laight <david.laight@aculab.com>
---
 include/linux/osq_lock.h  | 5 -----
 kernel/locking/osq_lock.c | 7 +++++++
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/linux/osq_lock.h b/include/linux/osq_lock.h
index 5581dbd3bd34..ea8fb31379e3 100644
--- a/include/linux/osq_lock.h
+++ b/include/linux/osq_lock.h
@@ -6,11 +6,6 @@
  * An MCS like lock especially tailored for optimistic spinning for sleepi=
ng
  * lock implementations (mutex, rwsem, etc).
  */
-struct optimistic_spin_node {
-=09struct optimistic_spin_node *next, *prev;
-=09int locked; /* 1 if lock acquired */
-=09int cpu; /* encoded CPU # + 1 value */
-};
=20
 struct optimistic_spin_queue {
 =09/*
diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
index d5610ad52b92..d414eef4bec6 100644
--- a/kernel/locking/osq_lock.c
+++ b/kernel/locking/osq_lock.c
@@ -11,6 +11,13 @@
  * called from interrupt context and we have preemption disabled while
  * spinning.
  */
+
+struct optimistic_spin_node {
+=09struct optimistic_spin_node *next, *prev;
+=09int locked; /* 1 if lock acquired */
+=09int cpu; /* encoded CPU # + 1 value */
+};
+
 static DEFINE_PER_CPU_SHARED_ALIGNED(struct optimistic_spin_node, osq_node=
);
=20
 /*
--=20
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


