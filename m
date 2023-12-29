Return-Path: <linux-kernel+bounces-13228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 539A0820171
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 21:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E54C2836CF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 20:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B7D1428E;
	Fri, 29 Dec 2023 20:52:16 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2985D1426F
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 20:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-41-5wEkoRtvMh2PFOiaJkfYoA-1; Fri, 29 Dec 2023 20:52:04 +0000
X-MC-Unique: 5wEkoRtvMh2PFOiaJkfYoA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 29 Dec
 2023 20:51:46 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 29 Dec 2023 20:51:46 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "longman@redhat.com"
	<longman@redhat.com>
CC: "mingo@redhat.com" <mingo@redhat.com>, "will@kernel.org"
	<will@kernel.org>, "boqun.feng@gmail.com" <boqun.feng@gmail.com>, "'Linus
 Torvalds'" <torvalds@linux-foundation.org>, "'xinhui.pan@linux.vnet.ibm.com'"
	<xinhui.pan@linux.vnet.ibm.com>,
	"'virtualization@lists.linux-foundation.org'"
	<virtualization@lists.linux-foundation.org>, 'Zeng Heng'
	<zengheng4@huawei.com>
Subject: [PATCH next 0/5] locking/osq_lock: Optimisations to osq_lock code
Thread-Topic: [PATCH next 0/5] locking/osq_lock: Optimisations to osq_lock
 code
Thread-Index: Ado6lJ8STYITmewCRxaK5t3V4duzKg==
Date: Fri, 29 Dec 2023 20:51:46 +0000
Message-ID: <73a4b31c9c874081baabad9e5f2e5204@AcuMS.aculab.com>
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

Zeng Heng noted that heavy use of the osq (optimistic spin queue) code
used rather more cpu than might be expected. See:
https://lore.kernel.org/lkml/202312210155.Wc2HUK8C-lkp@intel.com/T/#mcc46ee=
dd1ef22a0d668828b1d088508c9b1875b8

Part of the problem is there is a pretty much guaranteed cache line reload
reading node->prev->cpu for the vcpu_is_preempted() check (even on bare met=
al)
in the wakeup path which slows it down.
(On bare metal the hypervisor call is patched out, but the argument is stil=
l read.)

Careful analysis shows that it isn't necessary to dirty the per-cpu data
on the fast-path osq_lock() path. This may be slightly beneficial.

The code also uses this_cpu_ptr() to get the address of the per-cpu data.
On x86-64 (at least) this is implemented as:
=09 &per_cpu_data[smp_processor_id()]->member
ie there is a real function call, an array index and an add.
However if raw_cpu_read() can used then (which is typically just an offset
from register - %gs for x86-64) the code will be faster.
Putting the address of the per-cpu node into itself means that only one
cache line need be loaded.

I can't see a list of per-cpu data initialisation functions, so the fields
are initialised on the first osq_lock() call.

The last patch avoids the cache line reload calling vcpu_is_preempted()
by simply saving node->prev->cpu as node->prev_cpu and updating it when
node->prev changes.
This is simpler than the patch proposed by Waimon.

David Laight (5):
  Move the definition of optimistic_spin_node into osf_lock.c
  Avoid dirtying the local cpu's 'node' in the osq_lock() fast path.
  Clarify osq_wait_next()
  Optimise per-cpu data accesses.
  Optimise vcpu_is_preempted() check.

 include/linux/osq_lock.h  |  5 ----
 kernel/locking/osq_lock.c | 61 +++++++++++++++++++++------------------
 2 files changed, 33 insertions(+), 33 deletions(-)

--=20
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


