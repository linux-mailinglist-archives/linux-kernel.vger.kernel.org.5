Return-Path: <linux-kernel+bounces-9714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D9B81CA1C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 13:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 135B3B21569
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 12:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE3E199D1;
	Fri, 22 Dec 2023 12:40:36 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9DE199A1
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 12:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-15-0Sal0x4pPmmJBasB7i-YNg-1; Fri, 22 Dec 2023 12:40:31 +0000
X-MC-Unique: 0Sal0x4pPmmJBasB7i-YNg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 22 Dec
 2023 12:40:16 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 22 Dec 2023 12:40:16 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Zeng Heng' <zengheng4@huawei.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"will@kernel.org" <will@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "longman@redhat.com" <longman@redhat.com>,
	"boqun.feng@gmail.com" <boqun.feng@gmail.com>
CC: "xiexiuqi@huawei.com" <xiexiuqi@huawei.com>, "liwei391@huawei.com"
	<liwei391@huawei.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] locking/osq_lock: Avoid false sharing in
 optimistic_spin_node
Thread-Topic: [PATCH v2] locking/osq_lock: Avoid false sharing in
 optimistic_spin_node
Thread-Index: AQHaNM91saK4G5Mya06aToQ2I11sa7C1Om0A
Date: Fri, 22 Dec 2023 12:40:16 +0000
Message-ID: <9c48658677a6475eb4fe13baed798e97@AcuMS.aculab.com>
References: <20231222121040.2635879-1-zengheng4@huawei.com>
In-Reply-To: <20231222121040.2635879-1-zengheng4@huawei.com>
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

From: Zeng Heng
> Sent: 22 December 2023 12:11
>=20
> Using the UnixBench test suite, we clearly find that osq_lock() cause
> extremely high overheads with perf tool in the File Copy items:
>=20
> Overhead  Shared Object            Symbol
>   94.25%  [kernel]                 [k] osq_lock
>    0.74%  [kernel]                 [k] rwsem_spin_on_owner
>    0.32%  [kernel]                 [k] filemap_get_read_batch
>=20
> In response to this, we conducted an analysis and made some gains:
>=20
> In the prologue of osq_lock(), it set `cpu` member of percpu struct
> optimistic_spin_node with the local cpu id, after that the value of the
> percpu struct would never change in fact. Based on that, we can regard
> the `cpu` member as a constant variable.
>=20
...
> @@ -9,7 +11,13 @@
>  struct optimistic_spin_node {
>  =09struct optimistic_spin_node *next, *prev;
>  =09int locked; /* 1 if lock acquired */
> -=09int cpu; /* encoded CPU # + 1 value */
> +
> +=09CACHELINE_PADDING(_pad1_);
> +=09/*
> +=09 * Stores an encoded CPU # + 1 value.
> +=09 * Only read by other cpus, so split into different cache lines.
> +=09 */
> +=09int cpu;
>  };

Isn't this structure embedded in every mutex and rwsem (etc)?
So that is a significant bloat especially on systems with
large cache lines.

Did you try just moving the initialisation of the per-cpu 'node'
below the first fast-path (uncontended) test in osq_lock()?

OTOH if you really have multiple cpu spinning on the same rwsem
perhaps the test and/or filemap code are really at fault!

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


