Return-Path: <linux-kernel+bounces-161442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C4C8B4C05
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 15:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D805B28165A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 13:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90E96D1CE;
	Sun, 28 Apr 2024 13:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYZIobLc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D416BFBD;
	Sun, 28 Apr 2024 13:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714311977; cv=none; b=QaTBy+eOdLwXRHv7T6upYJ432DIaaw4QQdXBMipryTJ7gQd987OZwYycLEP6ZbhX+umvgXBR9ABvCrmRSwEVrputqgNbX2mQSsl3OkUGMmCS2mBDdD5kEDVR75uFzKz4vV+zPb0JCgLFNMlSCw9b3z0otG28C55d+0bSV+v8f6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714311977; c=relaxed/simple;
	bh=XGeSlMdeDD1Qsf+xehzikrE+33otHTVL2krpJMt5DKk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JDFCaDYbjkKRViadbJuNND941s+htHztf/tCCl16PqLr/70m4Owfr3uriulAaGceEpzNCZp5+v1j21qb+xX9EvgXuKZo7QWTrUppyQyEDXyReKA8UNxizT851uNRtWTxTj8Q6bc/UFEw2jD7zbRd+MdGgRsaC9ZUhywX3LNdnpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYZIobLc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB8DC113CC;
	Sun, 28 Apr 2024 13:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714311976;
	bh=XGeSlMdeDD1Qsf+xehzikrE+33otHTVL2krpJMt5DKk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JYZIobLcbB6cD1kT4ntLrXTtY7O2WhUy0BSeOJjbeRKtt5tvpipAr2izMNopXdQyk
	 pPVqDColO/fTFJDJMqv1+tt7X1vhnjD/Upx/e6Po+iqrP+FPSytbleMeFkoN6ykTP9
	 g/De7HCVuuFJWvG67VTBPqLhGcGN0uDxl+V3+juw0s39ZUXI2ocGhdLt0FHR5XVhQ+
	 Yibiu7BWlHRCnopbQf0LAZfsPsNTHga9NwKb0XiMPH6wpWfYY+kGuzv2WgfnBFvvWt
	 oIjOD+Hrly1XGAZQEgV85DGtyJbMfNPMzNYVKwiNwjG+q5PRc4iMVTf+vJ7g26V6QJ
	 35Mxn7ob0mxfQ==
Date: Sun, 28 Apr 2024 14:46:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Andrew Hepp <andrew.hepp@ahepp.dev>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: temperature: mcp9600: Fix temperature reading for
 negative values
Message-ID: <20240428144606.5b3d9a7e@jic23-huawei>
In-Reply-To: <20240427195758.GA3350@debian>
References: <20240424185913.1177127-1-dima.fedrau@gmail.com>
	<Ziy8DsMCeAGK79E7@debian-BULLSEYE-live-builder-AMD64>
	<20240427195758.GA3350@debian>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 27 Apr 2024 21:57:58 +0200
Dimitri Fedrau <dima.fedrau@gmail.com> wrote:

> Am Sat, Apr 27, 2024 at 05:49:18AM -0300 schrieb Marcelo Schmitt:
> > Hi Dimitri,
> >=20
> > Interesting patch this one.
> > I think this does apply, although, the cold junction register has for s=
ign bits
> > so I think we could also have a mask to clear those out.
> > Some code suggestions inline.
> > =20
> Hi Marcelo,
>=20
> the temperature bits are in two=E2=80=99s complement format for hot and c=
old
> junction. Equations to calculate the temperature are also the same in
> the datasheet. There should be no difference when handling them. I don't
> think we need to do anything more with the value except sign_extend it to
> the appropriate data type. If the sign bits aren't right, there is a bug
> in the chip, until then futher processing of it is unneeded. I could add
> a comment here if it helps.

Agreed - by my reading the original patch is correct. Maybe it would act
as cleaner 'documentation' to have the sign_extend32() for the cold junctio=
n be
from bit 12 rather than 15, but I'm not sure it's worth the effort.

Andrew, would be great if you can review this fix in case we are all missing
something!

Jonathan

>=20
> > On 04/24, Dimitri Fedrau wrote: =20
> > > Temperature is stored as 16bit value in two's complement format. Curr=
ent
> > > implementation ignores the sign bit. Make it aware of the sign bit by
> > > using sign_extend32.
> > >=20
> > > Fixes: 3f6b9598b6df ("iio: temperature: Add MCP9600 thermocouple EMF =
converter")
> > > Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> > > ---
> > >  drivers/iio/temperature/mcp9600.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperat=
ure/mcp9600.c
> > > index 46845804292b..7a3eef5d5e75 100644
> > > --- a/drivers/iio/temperature/mcp9600.c
> > > +++ b/drivers/iio/temperature/mcp9600.c =20
> >=20
> > #define MCP9600_COLD_JUNCTION_SIGN_MSK GENMASK(15,12)
> > ...
> >  =20
> > > @@ -52,7 +52,8 @@ static int mcp9600_read(struct mcp9600_data *data,
> > > =20
> > >  	if (ret < 0)
> > >  		return ret;
> > > -	*val =3D ret;
> > > +
> > > +	*val =3D sign_extend32(ret, 15); =20
> > 	if (chan->address =3D=3D MCP9600_COLD_JUNCTION)
> > 		*val &=3D ~MCP9600_COLD_JUNCTION_SIGN_MSK;
> > =20
> This won't work. Assuming int is 32-bit ret =3D 0xfffe and *val =3D -2 af=
ter
> sign_extends32, this would result in *val =3D -61442 which is wrong.
> > > =20
> > >  	return 0;
> > >  }
> > > --=20
> > > 2.39.2
> > >=20
> > >  =20
> Best regards,
> Dimitri Fedrau


