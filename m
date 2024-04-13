Return-Path: <linux-kernel+bounces-143810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E698A3DB8
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 18:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA36CB213DB
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 16:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BAB81804E;
	Sat, 13 Apr 2024 16:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZoLC1xy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C93D272;
	Sat, 13 Apr 2024 16:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713026065; cv=none; b=Ybuw7ayj22mEpoPAwnAL1R1qhBr+NdlegZq94C90N5+bJF1I7Mvi65PH6rnsV7giBJ0J7w5opZ0GclOJu35hcUKfbUf+0vuPYvuX3dtuqgNNXvak0COozjiejywMrGM3w6RUyJsYkAieF44SYTWY1jkWSPTf6FS1UlM6YQvpEwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713026065; c=relaxed/simple;
	bh=tRKoTfG5rbwd19Ypqyf3ktswgzx9Alw0vdHmCSCXVCU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PeU8p2004LLGhRyQ1kr5Mf1pDYVJ+i1GjAb7EuQLfIriXpeBAL8ZzqqDWkAjTtV7h6GECUZ8c1mnVQtkblGzxieP0zdeWmasTaOfZEywEWHDpB2CM5TTTA2wrCmbup+dnv+B8oKdNHbEBwH4mn/YQyACcn4nJ/vMvOlw3PABMVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZoLC1xy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A336C113CE;
	Sat, 13 Apr 2024 16:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713026065;
	bh=tRKoTfG5rbwd19Ypqyf3ktswgzx9Alw0vdHmCSCXVCU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LZoLC1xyncJS6z/D4woVXMKIlcbNSMPm/yg71KwoJPSbTSsYTsyDJtFFGpy4umqWe
	 wpMKQLqSIOvAxXTP0yu+W0NqCkIsWLVEXxnXDHlttkyM+OotkKoHIodBJCiAEVHABy
	 VPtGaXshDIS/9eKlW7HVQLjKC/4pgDwmhW23m0OhU7v+YXBuW1RMN999xF7xqEP+Bf
	 /X9UeKL68+883ClyG2vPDcBrIS3FU66zl/935Xp5tAWTAViTGNvZWWxnizKyOdIoAS
	 DMIiZFiLFjm34k5iBg8wMz7VZcn49xwAuNmZTHKLnWUBNu725sejbimJVamxQO+n3x
	 kUBMKhjNb8D+g==
Date: Sat, 13 Apr 2024 17:34:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: Add support for AD4000
Message-ID: <20240413173409.63d33a0a@jic23-huawei>
In-Reply-To: <CAMknhBGVkv9sP0pjmmdFngKmGVu+G4Y3MUDG199az1wOUtwasw@mail.gmail.com>
References: <cover.1712585500.git.marcelo.schmitt@analog.com>
	<1d95d7d023dad69b894a2d0e7b0bad9d569ae382.1712585500.git.marcelo.schmitt@analog.com>
	<CAMknhBEMDg3YF5pvoKJ-6y0Y5OJpmBthWfogCjy90B=F84SvzA@mail.gmail.com>
	<ZhVoTi2amNTOJ4eS@debian-BULLSEYE-live-builder-AMD64>
	<CAMknhBGVkv9sP0pjmmdFngKmGVu+G4Y3MUDG199az1wOUtwasw@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 9 Apr 2024 11:44:26 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On Tue, Apr 9, 2024 at 11:09=E2=80=AFAM Marcelo Schmitt
> <marcelo.schmitt1@gmail.com> wrote:
> >
> > On 04/08, David Lechner wrote: =20
> > > On Mon, Apr 8, 2024 at 9:32=E2=80=AFAM Marcelo Schmitt
> > > <marcelo.schmitt@analog.com> wrote: =20
> > > > =20
>=20
> ...
>=20
> > >
> > > I also still have doubts about using IIO_BE and 8-bit xfers when it
> > > comes to adding support later to achieve max sample rate with a SPI
> > > offload. For example to get 2MSPS with an 18-bit chip, it will require
> > > an approx 33% faster SPI clock than the actual slowest clock possible
> > > because it will have to read 6 extra bits per sample. I didn't check
> > > the specs, but this may not even be physically possible without
> > > exceeding the datasheet max SPI clock rate. Also errors could be
> > > reduced if we could actually use the slowest allowable SPI clock rate.
> > > Furthermore, the offload hardware would have to be capable of adding
> > > an extra byte per sample for 18 and 20-bit chips when piping the data
> > > to DMA in order to get the 32-bit alignment in the buffer required by
> > > IIO scan_type and the natural alignment requirements of IIO buffers in
> > > general. =20
> >
> > Maybe I should already implement support for reading with SPI offload
> > rather than doing it after this set is merged?
> > So we can test what happens at faster sample rates before we commit to =
a solution.
> > =20
>=20
> Yes, that sounds like a wise thing to do.
>=20
> > =20
> > > =20
> > > > +               } data;
> > > > +               s64 timestamp __aligned(8);
> > > > +       } scan;
> > > > +       __be16 tx_buf __aligned(IIO_DMA_MINALIGN);
> > > > +       __be16 rx_buf;
> > > > +}; =20
> > >
> > > scan.data is used as SPI rx_buf so __aligned(IIO_DMA_MINALIGN); needs
> > > to be moved to the scan field. =20
> >
> > I have already tried it. Maybe I did something wrong besides buffer ali=
gnment
> > at that time. Will give it another try. =20
>=20
> This is the alignment for DMA cache coherency. So it should not have
> any affect on the actual data read, only performance.

Nope. It's a correctness issue not a performance one (though you may get
advantages there as well)  You can get potential corruption of
other fields that end up in the same cacheline - so the aim is to make
sure that nothing that we might use concurrently is in that cacheline.
=20
There was a good description of what is going on here in a talk Wolfram
gave a few years back when he was exploring how to avoid bounce buffers
in I2C https://www.youtube.com/watch?v=3DJDwaMClvV-s that includes links to=
 descriptions
of the fun that can happen.  The short description is that a DMA controller=
 is
allowed to grab the whole of a cacheline (typically 64 bytes, can be bigger)
in coherently from the host (basically takes a copy).  It can then merrily
do it's operations before finally copying it back to the actual memory.
The problem lies in that there may be other data in that cacheline that
is accessed at whilst the DMA controller was working on it's own prviate
copy.  Those changes will be wiped out.

Now you probably didn't see it because:
a) Many controllers don't do this - either they don't cache stale data, or
   are sufficiently coherent with CPU caches etc that any changes in this
   'near by' data are correctly handled.

b) It's really hard to hit the races anyway. I've only seen it once when
   debugging real systems, but people run into this occasionally on IIO
   drivers and it is really nasty to debug.

c) On arm64 at least in many cases the DMA core will bounce buffer anyway
   after some changes made a couple of years back.  Unfortunately that isn't
   true on all architectures yet (I think anyway) so we still need to be
   careful around this.

Note some architectures (x86 I think) never allowed this cacheline corrupti=
on
path in the first place so the DMA_MINALIGN value is 8 bytes (IIRC).

Coherency is hard (but fun if you have time, particularly the places where
it is allowed to break and how they are avoided :)

Jonathan

