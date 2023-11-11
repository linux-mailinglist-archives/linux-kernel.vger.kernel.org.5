Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7707E8C4F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 20:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjKKTWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 14:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKKTWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 14:22:36 -0500
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896FFC4;
        Sat, 11 Nov 2023 11:22:32 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 3F9FC1C0050; Sat, 11 Nov 2023 20:22:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1699730551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gYBHhZfO4Zonw2mLzJp9/mYBk9NWDCXNeAvd5RSXH/M=;
        b=aSD553O2GBol1+KPNx5GQbhZ8ta+lXGx48QflcT0blXsTpQLA/c2QXm31YKLwpF9mHZd5f
        Vq8UDaiRwWpUvYLYOB9aPyFuRJxErD3W5qEAGhX4T1Tzd/cUv4ysEgw0DbUQyjJKwbCD25
        SVvZXUkxK1evDhIZ2RNUnVdmTD/sbMQ=
Date:   Sat, 11 Nov 2023 20:22:07 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Alain Volmat <alain.volmat@foss.st.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Rob Herring <robh@kernel.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] media: i2c: gc2145: Galaxy Core GC2145 sensor
 support
Message-ID: <ZU/UX9Jjk288ELUx@duo.ucw.cz>
References: <20231107081345.3172392-1-alain.volmat@foss.st.com>
 <20231107081345.3172392-4-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="4J9NdFSzWSm2YNPV"
Content-Disposition: inline
In-Reply-To: <20231107081345.3172392-4-alain.volmat@foss.st.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4J9NdFSzWSm2YNPV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Addition of support for the Galaxy Core GC2145 XVGA sensor.
> The sensor supports both DVP and CSI-2 interfaces however for
> the time being only CSI-2 is implemented.
>=20
> Configurations is currently based on initialization scripts

"are"?

> coming from Galaxy Core and for that purpose only 3 static

"and so"?

> resolutions are supported.

"supported:"?

>  - 640x480
>  - 1280x720
>  - 1600x1200


> --- /dev/null
> +++ b/drivers/media/i2c/gc2145.c
> @@ -0,0 +1,1404 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * A V4L2 driver for Galaxycore GC2145 camera.
> + * Copyright (C) 2023, STMicroelectronics SA
> + *
> + * Inspired from the imx219.c driver

"by the"?

Link to some kind of datasheet / documentation /... would be welcome
here.

> +/**
> + * struct gc2145_mode - GC2145 mode description
> + * @width: frame width (in pixel)
> + * @height: frame height (in pixel)

"in pixels".

> +static const struct gc2145_mode supported_modes[] =3D {
=2E..
> +	{
> +		/* 1280x720 30fps mode */
> +		.width =3D 1280,
> +		.height =3D 720,
> +		.reg_seq =3D gc2145_mode_1280_720_regs,
> +		.reg_seq_size =3D ARRAY_SIZE(gc2145_mode_1280_720_regs),
> +		.pixel_rate =3D GC2145_1280_720_PIXELRATE,
> +		.crop =3D {
> +			.top =3D 160,
> +			.left =3D 240,
> +			.width =3D 1280,
> +			.height =3D 720,
> +		},
> +		.hblank =3D GC2145_1280_720_HBLANK,
> +		.vblank =3D GC2145_1280_720_VBLANK,
> +	},

Won't this result in 1120x480 mode due to crop?

> +/* All supported formats */
> +static const struct gc2145_format supported_formats[] =3D {
> +	{
> +		.code		=3D MEDIA_BUS_FMT_UYVY8_1X16,
> +		.code		=3D MEDIA_BUS_FMT_VYUY8_1X16,
> +		.code		=3D MEDIA_BUS_FMT_YUYV8_1X16,
> +		.code		=3D MEDIA_BUS_FMT_YVYU8_1X16,
> +		.code		=3D MEDIA_BUS_FMT_RGB565_1X16,
> +};

So ... the hardware can do 10bit ADC, but we don't actually have a
mode exposing that?

> +	 * Adjust the MIPI buffer settings.
> +	 * For YUV/RGB, LWC =3D image width * 2
> +	 * For RAW8, LWC =3D image width
> +	 * For RAW10, LWC =3D image width * 1.25
> +	 */
> +	lwc =3D gc2145->mode->width * 2;
> +	cci_write(gc2145->regmap, GC2145_REG_LWC_HIGH, lwc >> 8, &ret);
> +	cci_write(gc2145->regmap, GC2145_REG_LWC_LOW, lwc & 0xff, &ret);
> +
> +	/*
> +	 * Adjust the MIPI Fifo Full Level

Fifo -> FIFO?

> +	/*
> +	 * Set the fifo gate mode / MIPI wdiv set:
> +	 * 0xf1 in case of RAW mode and 0xf0 otherwise
> +	 */

fifo -> FIFO?

> +	/*
> +	 * Datasheet doesn't mention timing between PWDN/RESETB control and
> +	 * i2c access however experimentation shows that a rather big delay is
> +	 * needed
> +	 */

"however," "needed."

> +static const struct v4l2_ctrl_ops gc2145_ctrl_ops =3D {
> +	.s_ctrl =3D gc2145_s_ctrl,
> +};
> +
> +/* Initialize control handlers */
> +static int gc2145_init_controls(struct gc2145 *gc2145)
> +{
> +	ret =3D v4l2_ctrl_handler_init(hdl, 12);
> +	if (ret)
> +		return ret;
> +
> +	ctrls->pixel_rate =3D v4l2_ctrl_new_std(hdl, ops, V4L2_CID_PIXEL_RATE,
> +					      GC2145_640_480_PIXELRATE,
> +					      GC2145_1280_720_PIXELRATE, 1,

Should the second pixelrate be one from 1600x1200?

> +static int gc2145_check_hwcfg(struct device *dev)
> +{
> +	struct fwnode_handle *endpoint;
> +	struct v4l2_fwnode_endpoint ep_cfg =3D {
> +		.bus_type =3D V4L2_MBUS_CSI2_DPHY
> +	};
> +	int ret =3D -EINVAL;

This "ret" value is unused. Not sure if something will warn about this.

> +MODULE_AUTHOR("Alain Volmat <alain.volmat@foss.st.com");

">" is missing at the end of address.

The driver looks good, thank you!

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--4J9NdFSzWSm2YNPV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZU/UXwAKCRAw5/Bqldv6
8vVBAKDCxu4CgGrrih/Rm8GX9/7B3cQuWQCgpWWBpgMDauJ5u938XZ6XZVDNn0s=
=WQLs
-----END PGP SIGNATURE-----

--4J9NdFSzWSm2YNPV--
