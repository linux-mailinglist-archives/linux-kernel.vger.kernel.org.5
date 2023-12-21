Return-Path: <linux-kernel+bounces-8107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DF381B23F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 969471C239AE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989A351006;
	Thu, 21 Dec 2023 09:18:20 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7582A50271
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 09:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-69-J7BJckRQMDGfmljkKT1FmA-1; Thu, 21 Dec 2023 09:18:09 +0000
X-MC-Unique: J7BJckRQMDGfmljkKT1FmA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 21 Dec
 2023 09:17:55 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 21 Dec 2023 09:17:55 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Steven Rostedt' <rostedt@goodmis.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
	<akpm@linux-foundation.org>, Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
	Vincent Donnefort <vdonnefort@google.com>, Kent Overstreet
	<kent.overstreet@gmail.com>
Subject: RE: [PATCH v5 02/15] ring-buffer: Page size per ring buffer
Thread-Topic: [PATCH v5 02/15] ring-buffer: Page size per ring buffer
Thread-Index: AQHaMqz+dUnedT4aZk+oEbt0Pk2DGrCx3FFAgABHoICAAVLeAA==
Date: Thu, 21 Dec 2023 09:17:55 +0000
Message-ID: <30f49370d7ae494ab1afca5cf602ab55@AcuMS.aculab.com>
References: <20231219185414.474197117@goodmis.org>
	<20231219185628.009147038@goodmis.org>
	<84d3b41a72bd43dbb9d44921ef535c92@AcuMS.aculab.com>
 <20231220080129.3453bca8@gandalf.local.home>
In-Reply-To: <20231220080129.3453bca8@gandalf.local.home>
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

From: Steven Rostedt
> Sent: 20 December 2023 13:01
>=20
> On Wed, 20 Dec 2023 08:48:02 +0000
> David Laight <David.Laight@ACULAB.COM> wrote:
>=20
> > From: Steven Rostedt
> > > Sent: 19 December 2023 18:54
> > > From: "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
> > >
> > > Currently the size of one sub buffer page is global for all buffers a=
nd
> > > it is hard coded to one system page. In order to introduce configurab=
le
> > > ring buffer sub page size, the internal logic should be refactored to
> > > work with sub page size per ring buffer.
> > >
> > ...
> > > -=09nr_pages =3D DIV_ROUND_UP(size, BUF_PAGE_SIZE);
> > > +=09/* Default buffer page size - one system page */
> > > +=09buffer->subbuf_size =3D PAGE_SIZE - BUF_PAGE_HDR_SIZE;
> > > +
> > > +=09/* Max payload is buffer page size - header (8bytes) */
> > > +=09buffer->max_data_size =3D buffer->subbuf_size - (sizeof(u32) * 2)=
;
> > > +
> > > +=09nr_pages =3D DIV_ROUND_UP(size, buffer->subbuf_size);
> >
> > While not new, does this really make any sense for systems with 64k pag=
es?
> > Wouldn't it be better to have units of 4k?
>=20
> Unfortunately, it has to be PAGE_SIZE (and for now it's a power of 2 to
> make masking easy). It's used for splice and will also be used for memory
> mapping with user space.

Perhaps then the sysctl to set the size should be powers of 4k
with a minimum size of PAGE_SIZE.
Then you don't have to know the page size when setting things up.

I'm also guessing that no Linux kernels have a PAGE_SIZE of 2k?
IIRC some old mmu (maybe 68020 era) used 2k pages.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


