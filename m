Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735BE803AF9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjLDQ5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjLDQ5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:57:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D431B6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 08:57:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4CF0C433C7;
        Mon,  4 Dec 2023 16:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701709042;
        bh=JA7nhAup9DhpJ8fK0a5UXnLHxxlgRw9Qra34O3M0DLk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IywsxXmNxf7EfN8QV1/tjNFauk1pAJS2Fvopu37F53svBUnGN1aLpLbTI4n25GtAk
         o5rJ3xFaYQR1WyIJ5oMX2r0dt86WEbsXw1epmbKVrpeCF26v2i0S3RdcEAWDF60CnU
         BUmC9C/TRCS1suPXC6Wf5dawBknoTPYYrYmy8oCg/AuVG2nD0Pt4FVw8nTq11dtXCk
         1vizr32+OhUsxpJCgBlXZAJV5mVwYdKTV8RKvVlrmt+ZoE83qPuMJHywUrO1y2q69L
         p74R/U0zhaO7yCLtDXc1GZII6lvKf3cn3vXqBcpBl2+cv5016NkayySOv3wsQshiTm
         J2s9ImCusIjew==
Date:   Mon, 4 Dec 2023 16:57:12 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc:     David Lechner <dlechner@baylibre.com>, nuno.sa@analog.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Olivier MOYSAN <olivier.moysan@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 10/12] iio: adc: ad9467: convert to backend framework
Message-ID: <20231204165712.73a8e7dd@jic23-huawei>
In-Reply-To: <f0a65ba32a6e988ec5f99a3a02ab5414f28ff106.camel@gmail.com>
References: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com>
        <20231121-dev-iio-backend-v1-10-6a3d542eba35@analog.com>
        <CAMknhBFbLju8UQJ7Uz85kHKrbK4mzt=wTRdnp40+PwWCJa5dsA@mail.gmail.com>
        <026fa80d29054750937cd077b7f4f689de4e18f2.camel@gmail.com>
        <20231204154810.3f2f3f83@jic23-huawei>
        <f0a65ba32a6e988ec5f99a3a02ab5414f28ff106.camel@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Dec 2023 17:23:12 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Mon, 2023-12-04 at 15:48 +0000, Jonathan Cameron wrote:
> > On Fri, 01 Dec 2023 10:08:27 +0100
> > Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> >  =20
> > > On Thu, 2023-11-30 at 17:30 -0600, David Lechner wrote: =20
> > > > On Tue, Nov 21, 2023 at 4:17=E2=80=AFAM Nuno Sa via B4 Relay
> > > > <devnull+nuno.sa.analog.com@kernel.org> wrote:=C2=A0  =20
> > > > >=20
> > > > > From: Nuno Sa <nuno.sa@analog.com>
> > > > >=20
> > > > > Convert the driver to use the new IIO backend framework. The devi=
ce
> > > > > functionality is expected to be the same (meaning no added or rem=
oved
> > > > > features).=C2=A0  =20
> > > >=20
> > > > Missing a devicetree bindings patch before this one?
> > > > =C2=A0  =20
> > > > >=20
> > > > > Also note this patch effectively breaks ABI and that's needed so =
we can
> > > > > properly support this device and add needed features making use o=
f the
> > > > > new IIO framework.=C2=A0  =20
> > > >=20
> > > > Can you be more specific about what is actually breaking?
> > > > =C2=A0  =20
> > > > >=20
> > > > > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > > > > ---
> > > > > =C2=A0drivers/iio/adc/Kconfig=C2=A0 |=C2=A0=C2=A0 2 +-
> > > > > =C2=A0drivers/iio/adc/ad9467.c | 256 ++++++++++++++++++++++++++++=
+----------------
> > > > > --
> > > > > =C2=A02 files changed, 157 insertions(+), 101 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > > > > index 1e2b7a2c67c6..af56df63beff 100644
> > > > > --- a/drivers/iio/adc/Kconfig
> > > > > +++ b/drivers/iio/adc/Kconfig
> > > > > @@ -275,7 +275,7 @@ config AD799X
> > > > > =C2=A0config AD9467
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tristate "Analog Devic=
es AD9467 High Speed ADC driver"
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on SPI
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 depends on ADI_AXI_ADC
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select IIO_BACKEND
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 help
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Say yes he=
re to build support for Analog Devices:
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * AD9467 1=
6-Bit, 200 MSPS/250 MSPS Analog-to-Digital Converter
> > > > > diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> > > > > index 5db5690ccee8..8b0402e73ace 100644
> > > > > --- a/drivers/iio/adc/ad9467.c
> > > > > +++ b/drivers/iio/adc/ad9467.c=C2=A0  =20
> > > >=20
> > > > <snip>
> > > > =C2=A0  =20
> > > > > +static int ad9467_buffer_get(struct iio_dev *indio_dev)=C2=A0  =
=20
> > > >=20
> > > > perhaps a more descriptive name: ad9467_buffer_setup_optional?
> > > > =C2=A0  =20
> > >=20
> > > Hmm, no strong feeling. So yeah, can do as you suggest. Even though, =
now that I'm
> > > thinking, I'm not so sure if this is just some legacy thing we had in=
 ADI tree. I
> > > wonder if it actually makes sense for a device like with no buffering=
 support?!
> > > =C2=A0 =20
> > > > > +{
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct device *dev =3D indi=
o_dev->dev.parent;
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *dma_name;
> > > > > +
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!device_property_presen=
t(dev, "dmas"))
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return 0;
> > > > > +
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (device_property_read_st=
ring(dev, "dma-names", &dma_name))
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 dma_name =3D "rx";
> > > > > +
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return devm_iio_dmaengine_b=
uffer_setup(dev, indio_dev, dma_name);=C2=A0  =20
> > > >=20
> > > > The device tree bindings for "adi,ad9467" don't include dma propert=
ies
> > > > (nor should they). Perhaps the DMA lookup should be a callback to t=
he
> > > > backend? Or something similar to the SPI Engine offload that we are
> > > > working on?
> > > > =C2=A0  =20
> > >=20
> > > Oh yes, I need to update the bindings. In the link I sent you we can =
see my
> > > thoughts
> > > on this. In theory, hardwarewise, it would actually make sense for th=
e DMA to be
> > > on
> > > the backend device because that's where the connection is in HW. Howe=
ver, since
> > > we
> > > want to have the IIO interface in the frontend, it would be hard to d=
o that
> > > without
> > > hacking devm_iio_dmaengine_buffer_setup().=C2=A0I mean, lifetime wise=
 it would be far
> > > from
> > > wise to have the DMA buffer associated to a completely different devi=
ce than the
> > > IIO
> > > parent device. I mean, one way could just be export iio_dmaengine_buf=
fer_free()
> > > and
> > > iio_dmaengine_buffer_alloc() so we can actually control the lifetime =
of the
> > > buffer
> > > from the frontend device. If Jonathan is fine with this, I'm on board=
 for it.... =20
> >=20
> > It is going to be fiddly but I'd kind of expect the front end to be usi=
ng a more
> > abstracted interface to tell the backend to start grabbing data.=C2=A0 =
Maybe that ends
> > up being so slim it's just these interfaces and it's not sensible to wr=
ap it
> > though.
> >  =20
>=20
> Likely I'm missing your point but the discussion here is where the DMA bu=
ffer should
> be allocated. In theory, in the backend (at least on ADI usecases - it's =
the proper
> representation of the HW) but as we have the iio device in the frontend, =
it's more
> appropriate to have the buffer there. Or at least to have a way to contro=
l the buffer
> lifetime from there...

My instinct was put it in the backened and proxy / interfaces as necessary =
but (based
on my vague recollection of how this works) at times these DMA buffers are =
handed off
to userspace which is a front end problem rather than the hardware.  So I g=
uess it's
a question of who logically creates them?  Then as  you say provide the con=
trols for
the other part to mess with their lifetimes or at least ensure the stick ar=
ound whilst
it expects them to.

>=20
> On the our usecases, it's not like we tell the backend to grab data, we j=
ust use the
> normal .update_scan_mode() to enable/disable the channels in the backend =
so when we
> enable the buffer (and the frontend starts receiving and sending data via=
 the serial
> interface) the data paths are enabaled/disabled accordingly. Bah, yeah, i=
n a way is
> another wording for "grab" or "grab not" :)

Yup. It's not as easily separated as simple always on analog only front end=
s. Someone
drives the clock ultimately and that could be either end in theory at least.

What fun.

J
>=20
> - Nuno S=C3=A1

