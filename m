Return-Path: <linux-kernel+bounces-161436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E0A8B4BF8
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 15:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAD0EB213EF
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 13:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767456D1A6;
	Sun, 28 Apr 2024 13:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W95GWtKH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22383D0C6;
	Sun, 28 Apr 2024 13:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714310637; cv=none; b=kYa/IHinVIs02ur8qERSaAfxbLkovyAQ/FZ6r+m/d8P0VXibFQAdSNPzkzBBe5B+sY3LZ/GukKtEZjVmYgf4aFw4TDRdJ+5uVCjkBr4kdrZHAAoqtId7ng9zW0LC5e3trSfg0ry7A7IXLV4y1KVD8FJAgLPXS8loz9G9kZ5kdK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714310637; c=relaxed/simple;
	bh=c0VpPWI8MfsEnOFEBnCqUTmZY3UuYBr9Ipo6drdPZjI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TJsustc5clg2Sq0bsHP5Ft+G2W+/DxZzX06sR0kYSi2r5l5dT8zdT3uSCAI9AaCivipK2tHJ3kftP2lT+dxSmKfEYdpQIw2IQMbe5cjWgHS3QR+5Don0Y7Wa6bthBivcK92m6YzEolelWp95yFdwU1IgJc9nH4jd1NFgeIsn7O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W95GWtKH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 556E7C113CC;
	Sun, 28 Apr 2024 13:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714310637;
	bh=c0VpPWI8MfsEnOFEBnCqUTmZY3UuYBr9Ipo6drdPZjI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W95GWtKHMYke1Orpm1jATH9mnRoGGPx2WAb267oEkzOZO9+lmEKNFnAJBd794Dusx
	 TdfRcBVELQujdRu+931KvC8ygBu8du6Lb0MM3x73vE9x6p6DJCz0s0VzQTB2Er5Hxm
	 ZzXncRHJMlC9if97RJrCnuHD48s6JV5ScR6GF2VWu14f9mXp3z3NHqjfe4uUwLjRht
	 PbUaZJEuMuiyT00+vjLVpK1vMhtVn4m8rJ7X2QwMwhhGmpIAz8C6cIrJsfDkKDProI
	 riqFH/OKqWgX601bfI1UlQ1qYRtOi1DBjifSWzKCCB1BwmTG4A9+Z2pjFHFL9XG2VK
	 /HRgVCRo2xvwA==
Date: Sun, 28 Apr 2024 14:23:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Shawn
 Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
 <festevam@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/3] iio: cleanup masklength usage
Message-ID: <20240428142343.5067c898@jic23-huawei>
In-Reply-To: <CAMknhBGQB4MC8ejEs_uLgb=iKehXkoetgHjZnCvCKQbuua5kfA@mail.gmail.com>
References: <20240425-b4-iio-masklength-cleanup-v1-0-d3d16318274d@baylibre.com>
	<2630ef8c8363b4fa772a2ff2c95cf115ad3c509d.camel@gmail.com>
	<CAMknhBGQB4MC8ejEs_uLgb=iKehXkoetgHjZnCvCKQbuua5kfA@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 26 Apr 2024 10:26:31 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On Fri, Apr 26, 2024 at 2:13=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.c=
om> wrote:
> >
> > On Thu, 2024-04-25 at 10:03 -0500, David Lechner wrote: =20
> > > While working on other patches I noticed that a few drivers are setti=
ng
> > > the masklength field of struct iio_dev even though it is marked as
> > > [INTERN]. It looks like maybe this was not always the case, but we can
> > > safely clean it up now without breaking anything.
> > >
> > > ---
> > > David Lechner (3):
> > >       iio: adc: ad7266: don't set masklength
> > >       iio: adc: mxs-lradc-adc: don't set masklength
> > >       iio: buffer: initialize masklength accumulator to 0
> > >
> > >  drivers/iio/adc/ad7266.c          | 1 -
> > >  drivers/iio/adc/mxs-lradc-adc.c   | 1 -
> > >  drivers/iio/industrialio-buffer.c | 2 +-
> > >  3 files changed, 1 insertion(+), 3 deletions(-)
> > > ---
> > > base-commit: b80ad8e3cd2712b78b98804d1f59199680d8ed91
> > > change-id: 20240425-b4-iio-masklength-cleanup-86b632b19901
> > > =20
> >
> > Hi David,
> >
> > Nice cleanup. The patches look good to me but there's one thing missing=
 :). As you
> > correctly noted, the field should be internal to the IIO core and drive=
rs should not
> > touch it. Hence, you need to make sure not driver is using it so we can=
 move it into
> > struct iio_dev_opaque [1]. That's the place all the intern fields shoul=
d, eventually,
> > end up.
> >
> > Now, quite some drivers in the trigger handler will read the masklength=
 for looping
> > with for_each_set_bit(). Hence, the straight thing would be an helper t=
o get it.
> > Maybe there's a clever way...
> >
> > I know this is more work than what you had in mind but I think it shoul=
d be fairly
> > simple (hopefully) and since you started it :), maybe we can get the wh=
ole thing done
> > and remove another [INTERN] member from the iio_dev struct.
> >
> > [1]: https://elixir.bootlin.com/linux/latest/source/include/linux/iio/i=
io-opaque.h#L42
> >
> > - Nuno S=C3=A1 =20
>=20
> Sounds like fun. :-p
>=20
> I will look into it.

I think this one might be miss marked as [INTERN]. It should be constant fr=
om the driver
point of view, but given active_scan_masks is meant to be visible to the dr=
iver,
it's length should probably be as well.

Sure every driver should be able to trivially work this out for themselves,=
 but
do we care about stopping them using this?

It might be worth some nice iterator wrappers with names like
iio_for_each_active_channel() though I'd expect those to still be accessing=
 these
fields directly as this is a high performance path so we don't want to to b=
ounce
though a core function to get them.

Jonathan

