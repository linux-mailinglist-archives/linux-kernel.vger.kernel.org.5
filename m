Return-Path: <linux-kernel+bounces-34052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EDF837280
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:26:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 057AE1F29891
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3703F8EC;
	Mon, 22 Jan 2024 19:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sq77Rc9L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1B33E46B;
	Mon, 22 Jan 2024 19:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705951500; cv=none; b=nnHcoX4NsiyQus6MaZd18ukrC6KFc06xkTPyFzKScLXVUfGPOFCqpQykbGZPpDunSZF8Qahvgm65mvn9J6P1tUd+5vS3RY3ymV1YJ/aNi02nXHdA0Pe3Fx4RePUYO2modDWDLQpG2fScGySWw56t311lAmaBS3eu7vChdCzpVQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705951500; c=relaxed/simple;
	bh=JYKYjdR3PhfkGGl4WpEt0paoSAx0mC1cwvCa8aHljrM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jG1I0hIVTpSO6GwyGVH5Xu5MNlaJrKUW3u8NEcp5iAY5UcahI12Pd3vCEJvrlNVDhPI9zRx8rCy3yhw9bneuPCXyydKidEv+X2NWm2oTYEELuChJmMF7LEqLWV371TM42gtdFZvEN8oa501wDRM72In8W9jh3h7pYchgsGJlngc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sq77Rc9L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B59C433C7;
	Mon, 22 Jan 2024 19:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705951500;
	bh=JYKYjdR3PhfkGGl4WpEt0paoSAx0mC1cwvCa8aHljrM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sq77Rc9LmdqBXqDJFH8QIME6KdXvbY4SrZPTCej6kdS5rszRS+XOQmNGe1AQTl2aP
	 dkMCNW6G0+xRYkoaRiEYmFsiuG3zHCHu4jpWjmRreW7MPPFp0OYiw+ZzL+GbpOLopO
	 4Dwi1cjbL23NXg9oMQjnmOPnAZCKuNdg2GsFhRDTVbiAhdw4w/xg3g+sroQhALgOzB
	 mQtlYCZjnniyRClmeYvyi2DKAnJ3SeKaiORJCjlVtfcTeFT0Q9Q1ACopFmsYBsrr1I
	 tz65qWJ11H4tF8pqL9UjaMRFgkHEIIgO0BD3tElGVa0vIS5RKTbEHqGsQn6NTZhOiL
	 8So9/r7vb6GLA==
Date: Mon, 22 Jan 2024 19:24:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Laight <David.Laight@ACULAB.COM>
Cc: 'Matti Vaittinen' <mazziesaccount@gmail.com>, Subhajit Ghosh
 <subhajit.ghosh@tweaklogic.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen <lars@metafoo.de>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: gts-helper: Fix division loop
Message-ID: <20240122192448.1493ccf7@jic23-huawei>
In-Reply-To: <2985a200057c4648817094cf747fca35@AcuMS.aculab.com>
References: <ZZZ7pJBGkTdFFqiY@dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi>
	<20240107162253.66c1f0f1@jic23-huawei>
	<a41ef2c9-bd74-4b0e-afb7-12e198847609@tweaklogic.com>
	<717b7e70-5cf8-4671-8a6b-005eefd0535e@gmail.com>
	<2985a200057c4648817094cf747fca35@AcuMS.aculab.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.40; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Jan 2024 16:27:13 +0000
David Laight <David.Laight@ACULAB.COM> wrote:

> From: Matti Vaittinen
> > Sent: 22 January 2024 06:51
> >=20
> > On 1/19/24 13:56, Subhajit Ghosh wrote: =20
> > > On 8/1/24 02:52, Jonathan Cameron wrote: =20
> > >> On Thu, 4 Jan 2024 11:34:28 +0200
> > >> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> > >> =20
> > >>> The loop based 64bit division may run for a long time when dividend=
 is a
> > >>> lot bigger than the divider. Replace the division loop by the
> > >>> div64_u64() which implementation may be significantly faster.
> > >>>
> > >>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> > >>> Fixes: 38416c28e168 ("iio: light: Add gain-time-scale helpers") =20
> > >>
> > >> Hmm. Fix or not perf improvement?=C2=A0 I'm going to take the middle=
 ground
> > >> and leave the fixes tag, but not rush this in.
> > >>
> > >> So applied to the togreg branch of iio.git and for now just pushed o=
ut
> > >> as testing for 0-day etc to take a look before I rebase that tree af=
ter
> > >> rc1.
> > >>
> > >>
> > >> =20
> > >>> ---
> > >>>
> > >>> I've implemented also a fixup series for supporting rounding of
> > >>> gains/scales:
> > >>> =20
> > https://lore.kernel.org/lkml/37d3aa193e69577353d314e94463a08d488ddd8d.1=
701780964.git.mazziesaccount@gm
> > ail.com/ =20
> > >>>
> > >>> That series does also remove the offending loop.
> > >>>
> > >>> We don't currently have any in-tree users of GTS helpers which would
> > >>> need the rounding support so pushing the rounding is not urgent (an=
d I
> > >>> haven't heard of Subjahit whose driver required the rounding). Henc=
e, we
> > >>> may want to only take this loop fix in for now (?) and reconsider
> > >>> rounding when someone need that. =20
>=20
> Why did I look as this crappy code :-)
> I think the change breaks the rounding.
> For 'normal' values I think you just want:
> 	return 1 + (max - 1)/scale.
>=20
> The 'avoid overflow' test isn't needed if you subtract 1 from max.
> (Rather than return (max + scale - 1)/scale; where the add can overflow.
> But you do need something to return 1 (or error) if max is zero.
>=20
> 	David
Too late for my brain to process this, so with an abundance
of caution I've dropped it for now (I'm going to push out as hopefully not
rebasing in a few mins)

J

>=20
> > >>>
> > >>> Jonathan, what's your take on this? =20
> > >> Agreed - let us wait for the rounding to have a user, but makes sense
> > >> to tidy this corner up in the meantime.
> > >>
> > >> Thanks,
> > >>
> > >> Jonathan
> > >> =20
> > >>>
> > >>> =C2=A0 drivers/iio/industrialio-gts-helper.c | 5 ++---
> > >>> =C2=A0 1 file changed, 2 insertions(+), 3 deletions(-)
> > >>>
> > >>> diff --git a/drivers/iio/industrialio-gts-helper.c
> > >>> b/drivers/iio/industrialio-gts-helper.c
> > >>> index 7653261d2dc2..abcab2d38589 100644
> > >>> --- a/drivers/iio/industrialio-gts-helper.c
> > >>> +++ b/drivers/iio/industrialio-gts-helper.c
> > >>> @@ -34,7 +34,7 @@
> > >>> =C2=A0 static int iio_gts_get_gain(const u64 max, const u64 scale)
> > >>> =C2=A0 {
> > >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 full =3D max;
> > >>> -=C2=A0=C2=A0=C2=A0 int tmp =3D 1;
> > >>> +=C2=A0=C2=A0=C2=A0 int tmp =3D 0;
> > >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (scale > full || !scale)
> > >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINV=
AL;
> > >>> @@ -48,8 +48,7 @@ static int iio_gts_get_gain(const u64 max, const
> > >>> u64 scale)
> > >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp++;
> > >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > >>> -=C2=A0=C2=A0=C2=A0 while (full > scale * (u64)tmp)
> > >>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp++;
> > >>> +=C2=A0=C2=A0=C2=A0 tmp +=3D div64_u64(full, scale);
> > >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return tmp;
> > >>> =C2=A0 }
> > >>>
> > >>> base-commit: 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab =20
> > >>
> > >> =20
> > > Hi Matti,
> > >
> > > Your fix works beautifully with the latest version of apds9306 driver
> > > which I am working on.
> > > All available scale values can be set without any errors. Thank you. =
=20
> >=20
> > Thanks for testing Subhajit! Just to ensure we have no miscommunication
> > - did you test just this division fix, or the rounding fix here:
> > https://lore.kernel.org/lkml/37d3aa193e69577353d314e94463a08d488ddd8d.1=
701780964.git.mazziesaccount@gm
> > ail.com/
> >  =20
> > > Moving to a new city with a new full time job with the assumption of
> > > getting more time
> > > for my list of opensource projects and contributions proved to be
> > > utterly wrong! =20
> >=20
> > Well, I can't blame you :) Being in a new work at new city sounds like
> > you have a lot on your plate right now. Give it half a year and things
> > will stabilize though :) Oh, and falsely assuming that "when XXX, I will
> > have the time to do YYY" - been there done that :)
> >=20
> > Good luck on the new work and city!
> >=20
> > Yours,
> > 	-- Matti
> >=20
> > --
> > Matti Vaittinen
> > Linux kernel developer at ROHM Semiconductors
> > Oulu Finland
> >=20
> > ~~ When things go utterly wrong vim users can always type :help! ~~
> >  =20
>=20
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1=
 1PT, UK
> Registration No: 1397386 (Wales)


