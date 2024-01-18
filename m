Return-Path: <linux-kernel+bounces-30211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F92831B9A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 698EE1C25DFB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 14:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FFC1DDC7;
	Thu, 18 Jan 2024 14:37:34 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFE32D7B0
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 14:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705588654; cv=none; b=i+cgbOc2XIChGn4mJSor2cO8ZBysm4rlM02g1cK6fhvWETqSiN93fRQavGmOj61oLkmJTrpjP9TJopCoRqV2TQtlixs1CG6FErwTijn49Xqh7NEJhzfDd8vrlBqzpBhqd1QlDVLBH1sI7Yk4FIF6vukVPH+/EBsS49kQf6uuQsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705588654; c=relaxed/simple;
	bh=3MfCdf31cUH20HZg1uT4/uF6Pn0cfZ2WXANUBxZRNt8=;
	h=Received:X-MC-Unique:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-exchange-transport-fromentityheader:x-originating-ip:
	 MIME-Version:X-Mimecast-Spam-Score:X-Mimecast-Originator:
	 Content-Language:Content-Type:Content-Transfer-Encoding; b=H7ZqYnOFO/bmPnES/PVDWVsgoqRw9+2GjJRABER++vx6RCwHMjiHNbW4O6yUp+5jCyiH9p/fiB67LhGdW5KQLyTQa9+OV8IW/KvvtNDrRlUY3N0xOcsOjyD1Qp4Zn/IUaPXH16vouxujeZChfO9U9UjN6+cKnUzbARW0DvtUFEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-322-LN46kXRnMMaCnHGxLJ7dhA-1; Thu, 18 Jan 2024 14:37:22 +0000
X-MC-Unique: LN46kXRnMMaCnHGxLJ7dhA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 18 Jan
 2024 14:37:04 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 18 Jan 2024 14:37:04 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>, Denis Arefev
	<arefev@swemel.ru>
CC: Ian Abbott <abbotti@mev.co.uk>, H Hartley Sweeten
	<hsweeten@visionengravers.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH] comedi: drivers: ni_tio: Fix arithmetic expression
 overflow
Thread-Topic: [PATCH] comedi: drivers: ni_tio: Fix arithmetic expression
 overflow
Thread-Index: AQHaShiS6dX7emI6I0mP4mJbb50t4rDfo15Q
Date: Thu, 18 Jan 2024 14:37:04 +0000
Message-ID: <3f8d1a69e3434d2085aa3564357fa31d@AcuMS.aculab.com>
References: <20240118123747.45795-1-arefev@swemel.ru>
 <2024011842-groggy-badly-393c@gregkh>
In-Reply-To: <2024011842-groggy-badly-393c@gregkh>
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



> -----Original Message-----
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: 18 January 2024 14:14
> To: Denis Arefev <arefev@swemel.ru>
> Cc: Ian Abbott <abbotti@mev.co.uk>; H Hartley Sweeten <hsweeten@visioneng=
ravers.com>; linux-
> kernel@vger.kernel.org; lvc-project@linuxtesting.org; stable@vger.kernel.=
org
> Subject: Re: [PATCH] comedi: drivers: ni_tio: Fix arithmetic expression o=
verflow
>=20
> On Thu, Jan 18, 2024 at 03:37:47PM +0300, Denis Arefev wrote:
> > The value of an arithmetic expression period_ns * 1000 is subject
> > to overflow due to a failure to cast operands to a larger data
> > type before performing arithmetic
> >
> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> >
> > Fixes: 3e90b1c7ebe9 ("staging: comedi: ni_tio: tidy up ni_tio_set_clock=
_src() and helpers")
> > Cc: <stable@vger.kernel.org> # v5.15+
> > Reviewed-by: Ian Abbott <abbotti@mev.co.uk>
> > Signed-off-by: Denis Arefev <arefev@swemel.ru>
> > Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
> > ---
> >  drivers/comedi/drivers/ni_tio.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/comedi/drivers/ni_tio.c b/drivers/comedi/drivers/n=
i_tio.c
> > index da6826d77e60..acc914903c70 100644
> > --- a/drivers/comedi/drivers/ni_tio.c
> > +++ b/drivers/comedi/drivers/ni_tio.c
> > @@ -800,7 +800,7 @@ static int ni_tio_set_clock_src(struct ni_gpct *cou=
nter,
> >  =09=09=09=09GI_PRESCALE_X2(counter_dev->variant) |
> >  =09=09=09=09GI_PRESCALE_X8(counter_dev->variant), bits);
> >  =09}
> > -=09counter->clock_period_ps =3D period_ns * 1000;
> > +=09counter->clock_period_ps =3D period_ns * 1000UL;

What about 32bit systems...

> >  =09ni_tio_set_sync_mode(counter);
> >  =09return 0;
> >  }
> > --
> > 2.25.1
> >
> >
>=20
> Hi,
>=20
> This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> a patch that has triggered this response.  He used to manually respond
> to these common problems, but in order to save his sanity (he kept
> writing the same thing over and over, yet to different people), I was
> created.  Hopefully you will not take offence and will fix the problem
> in your patch and resubmit it so that it can be accepted into the Linux
> kernel tree.
>=20
> You are receiving this message because of the following common error(s)
> as indicated below:
>=20
> - This looks like a new version of a previously submitted patch, but you
>   did not list below the --- line any changes from the previous version.
>   Please read the section entitled "The canonical patch format" in the
>   kernel file, Documentation/process/submitting-patches.rst for what
>   needs to be done here to properly describe this.
>=20
> If you wish to discuss this problem further, or you have questions about
> how to resolve this issue, please feel free to respond to this email and
> Greg will reply once he has dug out from the pending patches received
> from other developers.
>=20
> thanks,
>=20
> greg k-h's patch email bot

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


