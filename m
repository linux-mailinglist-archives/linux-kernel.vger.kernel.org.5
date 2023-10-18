Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F7C7CE7A7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 21:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbjJRTYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 15:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjJRTYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 15:24:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F37D11C;
        Wed, 18 Oct 2023 12:24:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7E1C433C8;
        Wed, 18 Oct 2023 19:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697657046;
        bh=4pqgNCj2VHR73ruj+oEmmVKmJYNHgKP3AZBxoTczZZw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EGcGmANt2u7vd+hQPa+Fc6Vq4Uk9vDD1pnE9zW8eGR4ZoKbQ/3cKMSb07JiVBZEfG
         zylilyHGXi7xU0s3J/MeYg/F+3yR2Cw2S8vI+knHV7vJnlC8znULylVoVtj7jsC0uh
         WSMjp4m4ui+/9u+IqcBAhf9N47KzgaB8mHqhZVgiZcOYCbY+ruSRPRDpmpipiu3eti
         COhWXUeAVz75t2AH5aJYTTKsgn9nBhy4YdvwU3Ho2H5MIglNDsCkP10yNLqwt2Loi4
         rAiDlj8KZl9lbIREk8oc880uk2SHIwzfKeisGL9JXSMTStQQtgOC7RrMdwYIx0vCqo
         orFElBTA317IQ==
Date:   Wed, 18 Oct 2023 20:24:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc:     David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        nuno.sa@analog.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: resolver: ad2s1210: add support for
 adi,fixed-mode
Message-ID: <20231018202425.66c07591@jic23-huawei>
In-Reply-To: <492e8f347d4682ff672f81151ab4b1fe7f5b3059.camel@gmail.com>
References: <20231016135423.16808-1-dlechner@baylibre.com>
        <492e8f347d4682ff672f81151ab4b1fe7f5b3059.camel@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Oct 2023 10:26:43 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Mon, 2023-10-16 at 08:54 -0500, David Lechner wrote:
> > It is possible to use the AD2S1210 with hardwired mode pins (A0 and A1).
> > According to the devicetree bindings, in this case the adi,fixed-mode
> > property will specify which of the 3 possible modes the mode pins are
> > hardwired for and the gpio-modes property is not allowed.
> >=20
> > This adds support for the case where the mode pins are hardwired for
> > config mode. In this configuration, the position and value must be read
> > from the config register.
> >=20
> > The case of hardwired position or velocity mode is not supported as
> > there would be no way to configure the device.
> >=20
> > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > ---
> >  =20
>=20
> LGTM
>=20
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
>=20
Applied to the togreg branch of iio.git and pushed out as testing for 0-day
to see what we missed.

This probably won't make 6.7. Still no problem with getting it queued up for
6.8.

Thanks,

Jonathan

> > v2 changes:
> > * Use regmap_bulk_read() instead of new local function.
> > * Simplify adi,fixed-mode property error checking.
> >=20
> > =C2=A0drivers/iio/resolver/ad2s1210.c | 150 +++++++++++++++++++++++++--=
-----
> > =C2=A01 file changed, 119 insertions(+), 31 deletions(-)
> >=20
> > diff --git a/drivers/iio/resolver/ad2s1210.c b/drivers/iio/resolver/ad2=
s1210.c
> > index 1bd1b950e7cc..7f688bfe2172 100644
> > --- a/drivers/iio/resolver/ad2s1210.c
> > +++ b/drivers/iio/resolver/ad2s1210.c
> > @@ -141,7 +141,7 @@ struct ad2s1210_state {
> > =C2=A0	struct spi_device *sdev;
> > =C2=A0	/** GPIO pin connected to SAMPLE line. */
> > =C2=A0	struct gpio_desc *sample_gpio;
> > -	/** GPIO pins connected to A0 and A1 lines. */
> > +	/** GPIO pins connected to A0 and A1 lines (optional). */
> > =C2=A0	struct gpio_descs *mode_gpios;
> > =C2=A0	/** Used to access config registers. */
> > =C2=A0	struct regmap *regmap;
> > @@ -149,6 +149,8 @@ struct ad2s1210_state {
> > =C2=A0	unsigned long clkin_hz;
> > =C2=A0	/** Available raw hysteresis values based on resolution. */
> > =C2=A0	int hysteresis_available[2];
> > +	/* adi,fixed-mode property - only valid when mode_gpios =3D=3D NULL. =
*/
> > +	enum ad2s1210_mode fixed_mode;
> > =C2=A0	/** The selected resolution */
> > =C2=A0	enum ad2s1210_resolution resolution;
> > =C2=A0	/** Copy of fault register from the previous read. */
> > @@ -175,6 +177,9 @@ static int ad2s1210_set_mode(struct ad2s1210_state =
*st,
> > enum ad2s1210_mode mode)
> > =C2=A0	struct gpio_descs *gpios =3D st->mode_gpios;
> > =C2=A0	DECLARE_BITMAP(bitmap, 2);
> > =C2=A0
> > +	if (!gpios)
> > +		return mode =3D=3D st->fixed_mode ? 0 : -EOPNOTSUPP;
> > +
> > =C2=A0	bitmap[0] =3D mode;
> > =C2=A0
> > =C2=A0	return gpiod_set_array_value(gpios->ndescs, gpios->desc, gpios->=
info,
> > @@ -276,7 +281,8 @@ static int ad2s1210_regmap_reg_read(void *context,
> > unsigned int reg,
> > =C2=A0	 * parity error. The fault register is read-only and the D7 bit =
means
> > =C2=A0	 * something else there.
> > =C2=A0	 */
> > -	if (reg !=3D AD2S1210_REG_FAULT && st->rx[1] & AD2S1210_ADDRESS_DATA)
> > +	if ((reg > AD2S1210_REG_VELOCITY_LSB && reg !=3D AD2S1210_REG_FAULT)
> > +	=C2=A0=C2=A0=C2=A0=C2=A0 && st->rx[1] & AD2S1210_ADDRESS_DATA)
> > =C2=A0		return -EBADMSG;
> > =C2=A0
> > =C2=A0	*val =3D st->rx[1];
> > @@ -450,21 +456,53 @@ static int ad2s1210_single_conversion(struct iio_=
dev
> > *indio_dev,
> > =C2=A0	ad2s1210_toggle_sample_line(st);
> > =C2=A0	timestamp =3D iio_get_time_ns(indio_dev);
> > =C2=A0
> > -	switch (chan->type) {
> > -	case IIO_ANGL:
> > -		ret =3D ad2s1210_set_mode(st, MOD_POS);
> > -		break;
> > -	case IIO_ANGL_VEL:
> > -		ret =3D ad2s1210_set_mode(st, MOD_VEL);
> > -		break;
> > -	default:
> > -		return -EINVAL;
> > +	if (st->fixed_mode =3D=3D MOD_CONFIG) {
> > +		unsigned int reg_val;
> > +
> > +		switch (chan->type) {
> > +		case IIO_ANGL:
> > +			ret =3D regmap_bulk_read(st->regmap,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD2S1210_REG_POSITION_MSB,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &st->sample.raw, 2);
> > +			if (ret < 0)
> > +				return ret;
> > +
> > +			break;
> > +		case IIO_ANGL_VEL:
> > +			ret =3D regmap_bulk_read(st->regmap,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD2S1210_REG_VELOCITY_MSB,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &st->sample.raw, 2);
> > +			if (ret < 0)
> > +				return ret;
> > +
> > +			break;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +
> > +		ret =3D regmap_read(st->regmap, AD2S1210_REG_FAULT, &reg_val);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		st->sample.fault =3D reg_val;
> > +	} else {
> > +		switch (chan->type) {
> > +		case IIO_ANGL:
> > +			ret =3D ad2s1210_set_mode(st, MOD_POS);
> > +			break;
> > +		case IIO_ANGL_VEL:
> > +			ret =3D ad2s1210_set_mode(st, MOD_VEL);
> > +			break;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		ret =3D spi_read(st->sdev, &st->sample, 3);
> > +		if (ret < 0)
> > +			return ret;
> > =C2=A0	}
> > -	if (ret < 0)
> > -		return ret;
> > -	ret =3D spi_read(st->sdev, &st->sample, 3);
> > -	if (ret < 0)
> > -		return ret;
> > =C2=A0
> > =C2=A0	switch (chan->type) {
> > =C2=A0	case IIO_ANGL:
> > @@ -1252,27 +1290,53 @@ static irqreturn_t ad2s1210_trigger_handler(int=
 irq,
> > void *p)
> > =C2=A0	ad2s1210_toggle_sample_line(st);
> > =C2=A0
> > =C2=A0	if (test_bit(0, indio_dev->active_scan_mask)) {
> > -		ret =3D ad2s1210_set_mode(st, MOD_POS);
> > -		if (ret < 0)
> > -			goto error_ret;
> > -
> > -		ret =3D spi_read(st->sdev, &st->sample, 3);
> > -		if (ret < 0)
> > -			goto error_ret;
> > +		if (st->fixed_mode =3D=3D MOD_CONFIG) {
> > +			ret =3D regmap_bulk_read(st->regmap,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD2S1210_REG_POSITION_MSB,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &st->sample.raw, 2);
> > +			if (ret < 0)
> > +				goto error_ret;
> > +		} else {
> > +			ret =3D ad2s1210_set_mode(st, MOD_POS);
> > +			if (ret < 0)
> > +				goto error_ret;
> > +
> > +			ret =3D spi_read(st->sdev, &st->sample, 3);
> > +			if (ret < 0)
> > +				goto error_ret;
> > +		}
> > =C2=A0
> > =C2=A0		memcpy(&st->scan.chan[chan++], &st->sample.raw, 2);
> > =C2=A0	}
> > =C2=A0
> > =C2=A0	if (test_bit(1, indio_dev->active_scan_mask)) {
> > -		ret =3D ad2s1210_set_mode(st, MOD_VEL);
> > -		if (ret < 0)
> > -			goto error_ret;
> > +		if (st->fixed_mode =3D=3D MOD_CONFIG) {
> > +			ret =3D regmap_bulk_read(st->regmap,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AD2S1210_REG_VELOCITY_MSB,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &st->sample.raw, 2);
> > +			if (ret < 0)
> > +				goto error_ret;
> > +		} else {
> > +			ret =3D ad2s1210_set_mode(st, MOD_VEL);
> > +			if (ret < 0)
> > +				goto error_ret;
> > +
> > +			ret =3D spi_read(st->sdev, &st->sample, 3);
> > +			if (ret < 0)
> > +				goto error_ret;
> > +		}
> > =C2=A0
> > -		ret =3D spi_read(st->sdev, &st->sample, 3);
> > +		memcpy(&st->scan.chan[chan++], &st->sample.raw, 2);
> > +	}
> > +
> > +	if (st->fixed_mode =3D=3D MOD_CONFIG) {
> > +		unsigned int reg_val;
> > +
> > +		ret =3D regmap_read(st->regmap, AD2S1210_REG_FAULT, &reg_val);
> > =C2=A0		if (ret < 0)
> > -			goto error_ret;
> > +			return ret;
> > =C2=A0
> > -		memcpy(&st->scan.chan[chan++], &st->sample.raw, 2);
> > +		st->sample.fault =3D reg_val;
> > =C2=A0	}
> > =C2=A0
> > =C2=A0	ad2s1210_push_events(indio_dev, st->sample.fault, pf->timestamp);
> > @@ -1299,9 +1363,24 @@ static const struct iio_info ad2s1210_info =3D {
> > =C2=A0static int ad2s1210_setup_properties(struct ad2s1210_state *st)
> > =C2=A0{
> > =C2=A0	struct device *dev =3D &st->sdev->dev;
> > +	const char *str_val;
> > =C2=A0	u32 val;
> > =C2=A0	int ret;
> > =C2=A0
> > +	ret =3D device_property_read_string(dev, "adi,fixed-mode", &str_val);
> > +	if (ret =3D=3D -EINVAL)
> > +		st->fixed_mode =3D -1;
> > +	else if (ret < 0)
> > +		return dev_err_probe(dev, ret,
> > +			"failed to read adi,fixed-mode property\n");
> > +	else {
> > +		if (strcmp(str_val, "config"))
> > +			return dev_err_probe(dev, -EINVAL,
> > +				"only adi,fixed-mode=3D\"config\" is
> > supported\n");
> > +
> > +		st->fixed_mode =3D MOD_CONFIG;
> > +	}
> > +
> > =C2=A0	ret =3D device_property_read_u32(dev, "assigned-resolution-bits",
> > &val);
> > =C2=A0	if (ret < 0)
> > =C2=A0		return dev_err_probe(dev, ret,
> > @@ -1357,12 +1436,21 @@ static int ad2s1210_setup_gpios(struct ad2s1210=
_state
> > *st)
> > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "failed to request sample GPIO\n");
> > =C2=A0
> > =C2=A0	/* both pins high means that we start in config mode */
> > -	st->mode_gpios =3D devm_gpiod_get_array(dev, "mode", GPIOD_OUT_HIGH);
> > +	st->mode_gpios =3D devm_gpiod_get_array_optional(dev, "mode",
> > +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GPIOD_OUT_HIGH);
> > =C2=A0	if (IS_ERR(st->mode_gpios))
> > =C2=A0		return dev_err_probe(dev, PTR_ERR(st->mode_gpios),
> > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "failed to request mode GPIOs\n");
> > =C2=A0
> > -	if (st->mode_gpios->ndescs !=3D 2)
> > +	if (!st->mode_gpios && st->fixed_mode =3D=3D -1)
> > +		return dev_err_probe(dev, -EINVAL,
> > +			"must specify either adi,fixed-mode or mode-
> > gpios\n");
> > +
> > +	if (st->mode_gpios && st->fixed_mode !=3D -1)
> > +		return dev_err_probe(dev, -EINVAL,
> > +			"must specify only one of adi,fixed-mode or mode-
> > gpios\n");
> > +
> > +	if (st->mode_gpios && st->mode_gpios->ndescs !=3D 2)
> > =C2=A0		return dev_err_probe(dev, -EINVAL,
> > =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 "requires exactly 2 mode-gpios\n");
> > =C2=A0 =20
>=20

