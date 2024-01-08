Return-Path: <linux-kernel+bounces-19338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B17826B9E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09C441C220FC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2B913FFF;
	Mon,  8 Jan 2024 10:35:05 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD35C13FF5
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 10:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-131-SSdTflTDNiSgu7lU4QYbVg-1; Mon, 08 Jan 2024 10:35:00 +0000
X-MC-Unique: SSdTflTDNiSgu7lU4QYbVg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 8 Jan
 2024 10:34:35 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 8 Jan 2024 10:34:35 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Andrew Lunn' <andrew@lunn.ch>, =?iso-8859-2?Q?Petr_Tesa=F8=EDk?=
	<petr@tesarici.cz>
CC: Eric Dumazet <edumazet@google.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, "Chen-Yu
 Tsai" <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, "Samuel
 Holland" <samuel@sholland.org>, "open list:STMMAC ETHERNET DRIVER"
	<netdev@vger.kernel.org>, "moderated list:ARM/STM32 ARCHITECTURE"
	<linux-stm32@st-md-mailman.stormreply.com>, "moderated list:ARM/STM32
 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list
	<linux-kernel@vger.kernel.org>, "open list:ARM/Allwinner sunXi SoC support"
	<linux-sunxi@lists.linux.dev>, Jiri Pirko <jiri@resnulli.us>
Subject: RE: [PATCH] net: stmmac: protect statistics updates with a spinlock
Thread-Topic: [PATCH] net: stmmac: protect statistics updates with a spinlock
Thread-Index: AQHaP/3Ni9qIc9t6xUGHU0aBdMePobDPuW8A
Date: Mon, 8 Jan 2024 10:34:35 +0000
Message-ID: <d05ca29283eb47df9c58838cb87a887c@AcuMS.aculab.com>
References: <20240105091556.15516-1-petr@tesarici.cz>
 <CANn89iLuYZBersxq4aH-9Fg_ojD0fh=0xtdLbRdbMrup=nvrkA@mail.gmail.com>
 <20240105113402.0f5f1232@meshulam.tesarici.cz>
 <CANn89iLEvW9ZS=+WPETPC=mKRyu9AKmueGCWZZOrz9oX3Xef=g@mail.gmail.com>
 <20240105121447.11ae80d1@meshulam.tesarici.cz>
 <20240105142732.1903bc70@meshulam.tesarici.cz>
 <CANn89iLHLvGFX_JEYU-en0ZoCUpTvjXPBzFECxLFfa_Jhpcjmg@mail.gmail.com>
 <CANn89iKWSemsKmfsLjupwWBnyeKjtHH+mZjTzYiJT4G=xyUrNQ@mail.gmail.com>
 <20240105154558.2ca38aca@meshulam.tesarici.cz>
 <a8bb0eb0-8398-4e7e-8dc5-6ebf2f981ca8@lunn.ch>
In-Reply-To: <a8bb0eb0-8398-4e7e-8dc5-6ebf2f981ca8@lunn.ch>
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

From: Andrew Lunn
> Sent: 05 January 2024 17:37
>=20
> > This only leaves an atomic_t in hard irq context. I have tried to find
> > something that could relax the requirement, but AFAICS at least some
> > setups use several interrupts that can be delivered to different CPUs
> > simultaneously, and all of them will walk over all channels. So we're
> > left with an atomic_t here.
>=20
> You might want to consider per CPU statistics. Since each CPU has its
> own structure of statistics, you don't need atomic.
>=20
> The code actually using the statistics then needs to sum up the per
> CPU statistics, and using syncp should be sufficient for that.

Doesn't that consume rather a lot of memory on systems with
'silly numbers' of cpu?

Updating an atomic_t is (pretty much) the same as taking a lock.
unlock() is also likely to also contain an atomic operation.
So if you update more than two atomic_t it is likely that a lock
will be faster.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


