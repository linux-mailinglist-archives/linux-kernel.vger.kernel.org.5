Return-Path: <linux-kernel+bounces-41217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A6A83ED84
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 15:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A70F1F22A41
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 14:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE38425779;
	Sat, 27 Jan 2024 14:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTAPYsyQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B8D28DC3;
	Sat, 27 Jan 2024 14:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706366273; cv=none; b=DDzelmbtXFy/U9484yqyNlcCAYfrDUUn8CTFrYdawlQZUC6OeVuSqbxQh+4wmE7NehKf2y/zZWEkITbIiJoTE9JPJV1QCDQWIxSuFPf4Nr87MNhyHIP2j6Jtob/FUq1u7H6xiW4azEnwYj4qwpCIL+7TnmRtHrbqY0mzV07xHks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706366273; c=relaxed/simple;
	bh=mrSW6WQZjSTOgoOhWP22411NQ5SUJZsI+xs0bT6GJrw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YCOhxSOOmxFeCyJfbCVorgZsxa/Fl/bStM2Nx9FPwhmADJspiz5vTWq6bG6THPr19EyLd7dHIjgyjIP2SCMK5huabFsQEhrpLNqOmppDvoVDNB9uFVXWacD/jOeYL4XA7FLQ0fWHH1XsTVDcUHMpej7lrCJ0+ONsBnUyIdacuNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JTAPYsyQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF39C433A6;
	Sat, 27 Jan 2024 14:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706366272;
	bh=mrSW6WQZjSTOgoOhWP22411NQ5SUJZsI+xs0bT6GJrw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JTAPYsyQHS9EKjNZ2wEyeBDXYFkBjLgvPOHiqdC11yGFcxD3hqQ0etJLw8mk5eADb
	 ecZ82DXvl1rrURtHFXGISTV1pFCdd5EMuxfOviyFmuW8TPFCn1VPcwBlFD+Dx8h8cF
	 14jnTXbhT7ddXXtfEZEqJuAjAQ86UDeLG2VRLyEOlTdzFt81UpXlNkm27ZixNJD5iO
	 N5EcZQqDTV4OhwSP5p0OKbUgRFZ+nEiK9vXb9J7WuuofXVTNlHAReKAkPvitha2wXj
	 sahWMSNAHD3AxCvIY6LYKlnjwTk/HbKmexRhkKzbHUoC/GAR4p7dQdBGAOvqGvXpZP
	 KMBF/AomaDR/w==
Date: Sat, 27 Jan 2024 14:37:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Li peiyu <579lpy@gmail.com>, Lars-Peter
 Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: humidity: hdc3020: fix temperature offset
Message-ID: <20240127143739.1848d64f@jic23-huawei>
In-Reply-To: <20240125110853.GA3857099@debian>
References: <20240125102641.3850938-1-dima.fedrau@gmail.com>
	<0a98e54735cc2a97f393eef6b1cdaf27c946d10e.camel@gmail.com>
	<20240125110853.GA3857099@debian>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.40; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 25 Jan 2024 12:08:53 +0100
Dimitri Fedrau <dima.fedrau@gmail.com> wrote:

> Am Thu, Jan 25, 2024 at 11:49:25AM +0100 schrieb Nuno S=C3=A1:
> > Hi Dimitri,
> > =20
> Hi Nuno,
>=20
> > On Thu, 2024-01-25 at 11:26 +0100, Dimitri Fedrau wrote: =20
> > > The temperature offset should be negative according to the datasheet.
> > > Adding a minus to the existing offset results in correct temperature
> > > calculations.
> > >=20
> > > Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> > > --- =20
> >=20
> > This is a fix. You're missing a Fixes: tag in your commit message.
> > git log --grep=3D"Fixes:" should give you some examples...
> > =20
> Will fix this and resend the patch. Thanks for your help.
For future reference, you can just send the Fixes tag in a reply
and the b4 tooling most maintainers now use will pick it up
automatically.

Thanks,

Jonathan

>=20
> Best regards,
> Dimitri
> > With that, feel free to add:
> >=20
> > Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> >  =20
> > > =C2=A0drivers/iio/humidity/hdc3020.c | 2 +-
> > > =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/iio/humidity/hdc3020.c b/drivers/iio/humidity/hd=
c3020.c
> > > index 4e3311170725..ed70415512f6 100644
> > > --- a/drivers/iio/humidity/hdc3020.c
> > > +++ b/drivers/iio/humidity/hdc3020.c
> > > @@ -322,7 +322,7 @@ static int hdc3020_read_raw(struct iio_dev *indio=
_dev,
> > > =C2=A0		if (chan->type !=3D IIO_TEMP)
> > > =C2=A0			return -EINVAL;
> > > =C2=A0
> > > -		*val =3D 16852;
> > > +		*val =3D -16852;
> > > =C2=A0		return IIO_VAL_INT;
> > > =C2=A0
> > > =C2=A0	default: =20
> >  =20


