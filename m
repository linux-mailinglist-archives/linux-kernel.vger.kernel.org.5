Return-Path: <linux-kernel+bounces-63985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 831608537F0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBCE61F29B0B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02475FF1C;
	Tue, 13 Feb 2024 17:31:16 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB705FF09;
	Tue, 13 Feb 2024 17:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707845476; cv=none; b=Ez+0qqOdO1rm2JCpn+ZRjf/WIXDVMzguSiX65aELnH8IIzATa/kMNAmtOekZaL8J7f+4pG0CBfeuCsv2hdqBwNm8B6ify2yF7Jk8NnKvkbzZHwcHSRmWlEk7g6WkVqrOFDGVjQTDoUWcN5lvmnLWRSbHlvxPyH9ufMwrYeR2tzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707845476; c=relaxed/simple;
	bh=L/EIR3pZx0fo72yb2xtosrQJh7PostdYu/2WSXKrd9I=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EXrav2hOupugoiB2oUe1eXnXfBiZHHUM98yH8NlE1B0Tu8d6Joq4mMC2KplCNWX8/BGzZ49luyn15qWSs2crQKCmuaeM4M2bvdJyJh77JwUf6XbjPPfnGH6T4C+5UXlWo9ZRlupD/mp4igrFxEENfl6PZzMuUzub/JnyFK9EENM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TZ7YZ34sxz6JB0N;
	Wed, 14 Feb 2024 01:27:14 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id A7393140DD5;
	Wed, 14 Feb 2024 01:31:11 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 13 Feb
 2024 17:31:11 +0000
Date: Tue, 13 Feb 2024 17:31:10 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
CC: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>,
	Martin Sperl <kernel@martin.sperl.org>, David Jander <david@protonic.nl>,
	Jonathan Cameron <jic23@kernel.org>, Michael Hennerich
	<michael.hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=
	<nuno.sa@analog.com>, Alain Volmat <alain.volmat@foss.st.com>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 5/5] iio: adc: ad7380: use spi_optimize_message()
Message-ID: <20240213173110.00007855@Huawei.com>
In-Reply-To: <e03968102b92b3711808eb532685bc9e05fc3c8d.camel@gmail.com>
References: <20240212-mainline-spi-precook-message-v1-0-a2373cd72d36@baylibre.com>
	<20240212-mainline-spi-precook-message-v1-5-a2373cd72d36@baylibre.com>
	<c06dfa1ecf88b07ef467ad7c08667d0cab400613.camel@gmail.com>
	<CAMknhBEU=iMzpE_P0KePL4cZZktBOGHRXaEox5a7XcVjXDT+Dg@mail.gmail.com>
	<e03968102b92b3711808eb532685bc9e05fc3c8d.camel@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 13 Feb 2024 17:08:19 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Tue, 2024-02-13 at 09:27 -0600, David Lechner wrote:
> > On Tue, Feb 13, 2024 at 3:47=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail=
com> wrote: =20
> > >=20
> > > On Mon, 2024-02-12 at 17:26 -0600, David Lechner wrote: =20
> > > > This modifies the ad7380 ADC driver to use spi_optimize_message() to
> > > > optimize the SPI message for the buffered read operation. Since buf=
fered
> > > > reads reuse the same SPI message for each read, this can improve
> > > > performance by reducing the overhead of setting up some parts the S=
PI
> > > > message in each spi_sync() call.
> > > >=20
> > > > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > > > ---
> > > > =C2=A0drivers/iio/adc/ad7380.c | 52 +++++++++++++++++++++++++++++++=
++++++++++--
> > > > ----
> > > > -
> > > > =C2=A01 file changed, 45 insertions(+), 7 deletions(-)
> > > >=20
> > > > diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
> > > > index abd746aef868..5c5d2642a474 100644
> > > > --- a/drivers/iio/adc/ad7380.c
> > > > +++ b/drivers/iio/adc/ad7380.c
> > > > @@ -133,6 +133,7 @@ struct ad7380_state {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct spi_device *spi;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct regulator *vref;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct regmap *regmap;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 struct spi_message *msg;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * DMA (thus cache coherency ma=
intenance) requires the
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * transfer buffers to live in =
their own cache lines.
> > > > @@ -231,19 +232,55 @@ static int ad7380_debugfs_reg_access(struct i=
io_dev
> > > > *indio_dev, u32 reg,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> > > > =C2=A0}
> > > >=20
> > > > +static int ad7380_buffer_preenable(struct iio_dev *indio_dev)
> > > > +{
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 struct ad7380_state *st =3D iio_priv(indi=
o_dev);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 struct spi_transfer *xfer;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 st->msg =3D spi_message_alloc(1, GFP_KERN=
EL);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (!st->msg)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return -ENOMEM;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 xfer =3D list_first_entry(&st->msg->trans=
fers, struct spi_transfer,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 transfer_list);
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 xfer->bits_per_word =3D st->chip_info->ch=
annels[0].scan_type.realbits;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 xfer->len =3D 4;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 xfer->rx_buf =3D st->scan_data.raw;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D spi_optimize_message(st->spi, st-=
>msg);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (ret) {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 spi_message_free(st->msg);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return ret;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > > > +}
> > > > +
> > > > +static int ad7380_buffer_postdisable(struct iio_dev *indio_dev)
> > > > +{
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 struct ad7380_state *st =3D iio_priv(indi=
o_dev);
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 spi_unoptimize_message(st->msg);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 spi_message_free(st->msg);
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > > > +}
> > > > + =20
> > >=20
> > > Not such a big deal but unless I'm missing something we could have the
> > > spi_message (+ the transfer) statically allocated in struct ad7380_st=
ate and
> > > do
> > > the optimize only once at probe (naturally with proper devm action for
> > > unoptimize). Then we would not need to this for every buffer enable +
> > > disable. I
> > > know in terms of performance it won't matter but it would be less cod=
e I
> > > guess.
> > >=20
> > > Am I missing something? =20
> >=20
> > No, your understanding is correct for the current state of everything
> > in this series. So, we could do as you suggest, but I have a feeling
> > that future additions to this driver might require that it gets
> > changed back this way eventually. =20
>=20
> Hmm, not really sure about that as chip_info stuff is always our friend :=
). And
> I'm anyways of the opinion of keeping things simpler and start to evolve =
when
> really needed (because often we never really need to evolve). But bah, as=
 I
> said... this is really not a big deal.
>=20
Oops should have read Nuno's review before replying!

I'd rather we embedded it for now and did the optimization at probe.
Whilst it's a lot of work per transfer it's not enough to worry about delay=
ing
it until preenable().  Easy to make that move and take it dynamic when
driver changes need it.  In meantime, I don't want lots of other drivers
picking up this pattern when they may never need the complexity of
making things more dynamic.

Jonathan

> - Nuno S=C3=A1
>=20


