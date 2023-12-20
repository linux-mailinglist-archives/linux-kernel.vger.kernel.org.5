Return-Path: <linux-kernel+bounces-6643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15028819B76
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA6061F25F01
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F73E1F611;
	Wed, 20 Dec 2023 09:34:29 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFA01F5FF
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 09:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-101-Y1C4lIceNx-saF_MBkMcPQ-1; Wed, 20 Dec 2023 09:34:24 +0000
X-MC-Unique: Y1C4lIceNx-saF_MBkMcPQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 20 Dec
 2023 09:34:09 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 20 Dec 2023 09:34:09 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Arnd Bergmann' <arnd@kernel.org>, Sam Ravnborg <sam@ravnborg.org>, "David
 S . Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>
CC: Helge Deller <deller@gmx.de>, Alexander Viro <viro@zeniv.linux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern
	<stern@rowland.harvard.edu>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>
Subject: RE: [PATCH 00/27] sparc32: sunset sun4m and sun4d
Thread-Topic: [PATCH 00/27] sparc32: sunset sun4m and sun4d
Thread-Index: AQHaMx+ySWwYagj4Uk6uFCxcDCifEbCx5d1w
Date: Wed, 20 Dec 2023 09:34:09 +0000
Message-ID: <9c4479a3d194450593d541ae02ad288a@AcuMS.aculab.com>
References: <20231219-sam-sparc32-sunset-v3-v1-0-64bb44b598c5@ravnborg.org>
 <01ea8c41-88cd-4123-95c7-391640845fc3@app.fastmail.com>
In-Reply-To: <01ea8c41-88cd-4123-95c7-391640845fc3@app.fastmail.com>
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

From: Arnd Bergmann
> Sent: 20 December 2023 08:37
>=20
> On Tue, Dec 19, 2023, at 22:03, Sam Ravnborg via B4 Relay wrote:
> > TODO before this can be applied:
> > - Ack from davem - as he is the principal sparc maintainer
> > - Tested-by: preferably on a target or QEMU (see above)
> >   I expect bugs as there are some involved changes!
> >
> > Ideas for the future
> > - Apply the most relevant downstream Gaisler patches
> >   - The ones introducing CAS should have preference as we then
> >     can drop the cmpxchg emulation
>=20
> One note about the CAS -- as far as I can tell, the absence
> of the futex() syscall on sparc32 kernels means that no glibc
> from the past decade can work correctly as it now requires futex
> for its internal locking, though it does work on sparc64 kernels
> in compat32 mode as well as the LEON3 kernel that adds futex
> support.

Does the glibc mutex 'fast path' also require a CAS instruction?

Presumably having CAS also removes the 'really horrid (tm)' code
required to make all the bitmap operations atomic?

Seems a shame to lose old sparc32 support when (I think) the sun3
in my cupboard would still work - if only it had a working psu.
(The 110/220V switch wasn't connected and the FET wasn't rated
for 450V. UK mains can be 240+10% if you are near a substation.)

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


