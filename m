Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0A37E2897
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 16:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbjKFPZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 10:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjKFPZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 10:25:27 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30898112;
        Mon,  6 Nov 2023 07:25:20 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8B9891C000B;
        Mon,  6 Nov 2023 15:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699284319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2pwOlCKgsrVcnlIDxwm0ouSDhVl6OxMQWtLYHRhmGAA=;
        b=knpEVn63z2yCNIIMxHFSmyOeMz//fJuxK6DCZgKiPmy5oiiG+KIQ9fNi70eGyIi7bKtugE
        u8uXai1z8wePIrWPd5QMXxTpTmvd1m4DSztlokiwCQgA9x5gQO6bhrR0yoOUUjWpWzQegn
        NMcIjTwPC/o3i9W3Wy3yTgWbMaEKyWMeLbHxm/g8KOysa6zIjxkottB8jgDnOTxZQPWgS4
        TGSV1POUAJLQd+bhTwvVITfZ29xU+VTnqlq5Uo5bowlTKsutKHkAGHmjemhAAe1galVy9W
        G1K1hpHBeT/4s0tbzSyFNkzqJZsY5DL8wY8pwRhQDAHZQyaVo2YXawtqz0+fzA==
Date:   Mon, 6 Nov 2023 16:25:18 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Mehdi Djait <mehdi.djait@bootlin.com>
Cc:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, laurent.pinchart@ideasonboard.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, maxime.chevallier@bootlin.com
Subject: Re: [PATCH v7 3/3] media: i2c: Introduce a driver for the Techwell
 TW9900 decoder
Message-ID: <ZUkFXl7vBS36y4Qi@aptenodytes>
References: <cover.1697463708.git.mehdi.djait@bootlin.com>
 <c3cd9002b2db69a6fb155722adc8410cd6e1f9ab.1697463708.git.mehdi.djait@bootlin.com>
 <ZUNz_h1fn9RH9Uc5@aptenodytes>
 <ZUj/FQTyajQJrxoU@pc-70.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jRydKXW23g1fMu1P"
Content-Disposition: inline
In-Reply-To: <ZUj/FQTyajQJrxoU@pc-70.home>
X-GND-Sasl: paul.kocialkowski@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jRydKXW23g1fMu1P
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mehdi,

On Mon 06 Nov 23, 15:58, Mehdi Djait wrote:
> Hi Paul,
>=20
> thank you for the review!
>=20
> On Thu, Nov 02, 2023 at 11:03:42AM +0100, Paul Kocialkowski wrote:
> > > +static int tw9900_write_reg(struct i2c_client *client, u8 reg, u8 va=
l)
> > > +{
> > > +	int ret;
> > > +
> > > +	ret =3D i2c_smbus_write_byte_data(client, reg, val);
> >=20
> > Is this an SMBUS device in particular? Or is there any reason to use th=
e SMBUS
> > API instead of the general I2C API?
> >=20
>=20
> I think I will keep using the SMBUS API here. The reason is in the
> kernel documentation:
>=20
> -------------------------------------------------------------------------=
-------
> If you write a driver for some I2C device, please try to use the SMBus co=
mmands=20
> if at all possible (if the device uses only that subset of the I2C protoc=
ol).=20
> This makes it possible to use the device driver on both SMBus adapters an=
d I2C=20
> adapters (the SMBus command set is automatically translated to I2C on I2C=
=20
> adapters, but plain I2C commands can not be handled at all on most pure S=
MBus=20
> adapters).
> -------------------------------------------------------------------------=
-------
>=20
> And the vast majority of the drivers under /media/i2c are using the
> SMBUS API.

That is a good reason, so let's keep it that way then.

> > > +static void tw9900_fill_fmt(const struct tw9900_mode *mode,
> > > +			    struct v4l2_mbus_framefmt *fmt)
> > > +{
> > > +	fmt->code =3D MEDIA_BUS_FMT_UYVY8_2X8;
> > > +	fmt->width =3D mode->width;
> > > +	fmt->height =3D mode->height;
> > > +	fmt->field =3D V4L2_FIELD_NONE;
> > > +	fmt->quantization =3D V4L2_QUANTIZATION_DEFAULT;
> > > +	fmt->colorspace =3D V4L2_COLORSPACE_SMPTE170M;
> > > +	fmt->xfer_func =3D V4L2_MAP_XFER_FUNC_DEFAULT(V4L2_COLORSPACE_SMPTE=
170M);
> > > +	fmt->ycbcr_enc =3D V4L2_MAP_YCBCR_ENC_DEFAULT(V4L2_COLORSPACE_SMPTE=
170M);
> > > +}
> > > +
> > > +static int tw9900_cfg_fmt(struct v4l2_subdev *sd,
> >=20
> > You might have to differentiate between set_fmt/get_fmt to return -EBUSY
> > if streaming is on in set_fmt. However I understand it will just copy t=
he
> > current mode in both cases, but this might still be required to follow =
v4l2
> > semantics (please double-check).
> >=20
>=20
> This should be done in the driver calling the pad subdev_call set_fmt,
> right ?

Well the two things are distinct, even though it's not obvious to think abo=
ut
a case where you wouldn't have a video device to grab the frames.

For instance you can see this being done here:
https://elixir.bootlin.com/linux/latest/source/drivers/media/i2c/ov5648.c#L=
2259

I'm just not sure about what the V4L2 subdev API mandates. It would be usef=
ul
to find some piece of documentation that clarifies the requirement.

Cheers,

Paul

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--jRydKXW23g1fMu1P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmVJBV0ACgkQ3cLmz3+f
v9FwFggAkmEu8/zZmjJt0uuqaLlW5ilh1yfYyBAbinAXrrXXvKZLbwnZGl76b0s4
Iuj1fF6Vwwidx2H6t8qkw1hbmUsUIp1f8fE5XKgTdJrGU54+sB7TGY/bOET4DH6S
v5YD7r817UNAn7DnoEIfbxQefxGpbRVqc6y70diZAqgwet5HmJnuhobqFkOVuksS
//AFxaYIi9CzT6DNrkaS0n+gX4FOx6AJzhHzFxJKe2nHvUY5X2FT5OH2uCrsNteo
LwsTFyKGTy7RriIdgusMcK2sUdwtmsAk09XZvVtstaZIPUO80yYTlKeBTOfB6jYn
JWaWT92Bu051DjWLC5NruF8F0dI0lg==
=ZPJU
-----END PGP SIGNATURE-----

--jRydKXW23g1fMu1P--
