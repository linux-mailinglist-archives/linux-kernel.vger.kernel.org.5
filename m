Return-Path: <linux-kernel+bounces-78912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8525C861A86
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B1381F27D3A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92EC13A86A;
	Fri, 23 Feb 2024 17:46:12 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85B3140385;
	Fri, 23 Feb 2024 17:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708710371; cv=none; b=hyp9kbULb+rjWBnxJCqQbb23GzEkDRC4vd9NAElnazWTYm7LrvmfO3PomzueSs9eQpuojy57DTuQfIDFWKaCaAmfY1KDT8JWaUZQoDqsldede4ZzQxs3cs8fpYm+TqBi7WUlLxDUtERqwMJm2i9tTNlOiFPd/wOx4vNn0YmiHSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708710371; c=relaxed/simple;
	bh=yIsTcxtkN/WzBu1vfOj5fn+iwsswL34PWc3ew06vqz0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KoBFe8Q1l2CqjiBdcCKO/EtiUcN4xR7z2wrw0oFWP95nnEfpigqxsQzzLibOpoz1N9N+/+7AzTNi/kSHCl3duyQf4vKJJkE2Cx6qtsSmM5wnaMyRpOWSRdvPFX8RJnvBGTqyIq1qZtbsTWYmppwSUUe6EugkBV+1ZeQhYloQez0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ThHQF5r0zz6K8mr;
	Sat, 24 Feb 2024 01:42:13 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 1B52E140684;
	Sat, 24 Feb 2024 01:45:53 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 23 Feb
 2024 17:45:52 +0000
Date: Fri, 23 Feb 2024 17:45:51 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Kees Cook <keescook@chromium.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Nuno =?ISO-8859-1?Q?S=E1?=
	<nuno.sa@analog.com>, <linux-iio@vger.kernel.org>, Nathan Chancellor
	<nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, "Bill
 Wendling" <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
	<linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>,
	<linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] [RFC] iio: pressure: dlhl60d: Check mask_width for IRQs
Message-ID: <20240223174551.00007411@Huawei.com>
In-Reply-To: <202402230912.50332AF1@keescook>
References: <20240222222335.work.759-kees@kernel.org>
	<20240223170918.00006b16@Huawei.com>
	<202402230912.50332AF1@keescook>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 23 Feb 2024 09:14:53 -0800
Kees Cook <keescook@chromium.org> wrote:

> On Fri, Feb 23, 2024 at 05:09:18PM +0000, Jonathan Cameron wrote:
> > On Thu, 22 Feb 2024 14:23:39 -0800
> > Kees Cook <keescook@chromium.org> wrote:
> >  =20
> > > Clang tripped over a FORTIFY warning in this code, and while it seems=
 it
> > > may be a false positive in Clang due to loop unwinding, the code in
> > > question seems to make a lot of assumptions.  =20
> >=20
> > Hi Kees,
> >=20
> > The assumptions are mostly characteristics of how the IIO buffers work
> > with the scan masks defined based on indexes in the driver provided
> > struct iio_chan_spec arrays.
> >=20
> > This driver is doing more work than it should need to as we long ago
> > moved some of the more fiddly handling into the IIO core.
> >  =20
> > > Comments added, and the
> > > Clang warning[1] has been worked around by growing the array size.
> > > Also there was an uninitialized 4th byte in the __be32 array that was
> > > being sent through to iio_push_to_buffers(). =20
> >=20
> > That is indeed not good - the buffer should have been zero initialized.=
 =20
>=20
> Okay, I'll get this respun and include the fix.
>=20
> >  =20
> > >=20
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/2000 [1]
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> > > Cc: Jonathan Cameron <jic23@kernel.org>
> > > Cc: Lars-Peter Clausen <lars@metafoo.de>
> > > Cc: "Uwe Kleine-K=F6nig" <u.kleine-koenig@pengutronix.de>
> > > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Cc: "Nuno S=E1" <nuno.sa@analog.com>
> > > Cc: linux-iio@vger.kernel.org
> > > ---
> > >  drivers/iio/pressure/dlhl60d.c | 11 +++++++++--
> > >  1 file changed, 9 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/iio/pressure/dlhl60d.c b/drivers/iio/pressure/dl=
hl60d.c
> > > index 28c8269ba65d..9bbecd0bfe88 100644
> > > --- a/drivers/iio/pressure/dlhl60d.c
> > > +++ b/drivers/iio/pressure/dlhl60d.c
> > > @@ -250,20 +250,27 @@ static irqreturn_t dlh_trigger_handler(int irq,=
 void *private)
> > >  	struct dlh_state *st =3D iio_priv(indio_dev);
> > >  	int ret;
> > >  	unsigned int chn, i =3D 0;
> > > -	__be32 tmp_buf[2];
> > > +	/* This was only an array pair of 4 bytes. */ =20
> >=20
> > True, which is the right size as far as I can tell.
> > If we need this to suppress a warning then comment should say that. =20
>=20
> Okay. I think I'll leave it as 2 and manually "unroll" the loop.

Without the available mask that is a little fiddly you'll have
deal with  channel 0 only enabled, channel 1 only enabled and
both channels 0 and channel 1 enabled.
Not too bad though as only 2 channels.
=20
>=20
> >  =20
> > > +	__be32 tmp_buf[4] =3D { };
> > > =20
> > >  	ret =3D dlh_start_capture_and_read(st);
> > >  	if (ret)
> > >  		goto out;
> > > =20
> > > +	/* Nothing was checking masklength vs ARRAY_SIZE(tmp_buf)? */ =20
> >=20
> > Not needed but no way a compiler could know that.
> >  =20
> > > +	if (WARN_ON_ONCE(indio_dev->masklength > ARRAY_SIZE(tmp_buf)))
> > > +		goto out;
> > > +
> > >  	for_each_set_bit(chn, indio_dev->active_scan_mask, =20
> >=20
> > This is all a bit pointless if not 'wrong' other than the
> > 4th byte uninitialized part.  The limit can be hard coded as 2 as
> > that's a characteristic of this driver.
> >=20
> > For device that always read a particular set of channels they
> > should provide indio_dev->available_scan_masks =3D { BIT(1) | BIT(0), 0=
 };
> > and then always push all the data making this always
> >=20
> > 	memcpy(&tmp_buf[0], &st->rx_buf[1], 3);
> > 	mempcy(&tmp_buf[1], &st->rx_buf[1] + 3, 3); =20
>=20
> Okay, so this could be unrolled manually to check just for bits 0 and 1?

Ideally it wouldn't check them - the hardwork has been done to read both
channels anyway and the IIO core handles userspace or in kernel consumers
that want a subset of what is enabled, but that needs the available_scan_ma=
sks
to be set so that the IIO core knows all channels always enabled.

>=20
> >=20
> > The buffer demux code in the IIO core will deal with repacking the data
> > if only one channel is enabled.
> >  =20
> > >  		indio_dev->masklength) {
> > > -		memcpy(tmp_buf + i,
> > > +		/* This is copying 3 bytes. What about the 4th? */
> > > +		memcpy(&tmp_buf[i],
> > >  			&st->rx_buf[1] + chn * DLH_NUM_DATA_BYTES,
> > >  			DLH_NUM_DATA_BYTES);
> > >  		i++;
> > >  	}
> > > =20
> > > +	/* How do we know the iio buffer_list has only 2 items? */ =20
> >=20
> > Can only include items from the channels array at indexes up to the max
> > scan_index in there, so 0 and 1 in this case (1 might not be present if=
 only
> > one channel is enabled). Sizes (and alignment) are given by storagebits=
 so
> > 4 bytes for each. =20
>=20
> This code pattern seems repeated through all of iio, so I guess we'll
> leave it as-is. It seems like it'd be nice to have a "length" argument
> to iio_push_to_buffers(), just to sanity check, but that would need to
> be a pretty large patch. :P

yeah. Hindsight!

We could add it in an incremental fashion though
iio_push_to_bufs(struct iio_dev *indio_dev, void *buf, size_t buf_len)
with a length parameter.  The oddity that is
iio_push_to_buffers_with_timestamp() would benefit here as that needs
a bigger buffer than immediately apparent in the driver and we've
had a few bugs around that over the years.

It would probably be a one way check.
I might have a play and see how useful this would be.

>=20
> >  =20
> > >  	iio_push_to_buffers(indio_dev, tmp_buf);
> > > =20
> > >  out: =20
>=20
> Thanks for looking at this!
>=20
> -Kees
>=20


