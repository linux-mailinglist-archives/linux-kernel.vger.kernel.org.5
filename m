Return-Path: <linux-kernel+bounces-25315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8725382CD63
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 16:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACDCD1C20FD5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 15:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96B3139B;
	Sat, 13 Jan 2024 15:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iq3AEaPc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEEC23A3;
	Sat, 13 Jan 2024 15:07:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D621C433C7;
	Sat, 13 Jan 2024 15:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705158463;
	bh=npx79WVFt4saeHYjdMj678Kk6Kku94NQrw7UCTbPtQk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Iq3AEaPcKaJDAuEqSlYPtU0ckNPQWQ8UFKtNa2JU+xwZDAvotTfEBLQScgOx+CYoZ
	 Vo/V13Y8LxWUqmj9nXveSwrLZaVP+bg6CLRCJ2PRHZxo2wtJFRu3Ir8/GdpdICC4dI
	 aU7h8FBVq7vO3abdm0J/TZZWm7IU/L90zRobU1GdHObyGZaBNbyb70G+u6gO5E6hkC
	 imbx89nCk21vtE4kM1odUwlINNASKjZzTrxUfNW9GoCJeB65iCW7Y/Vb2m0RL2WiPN
	 NtCVtAFb0mJyEjgfPrkcnpQSrN5TS3xJJQq1PbvG3VtnglNTHpYK/xSCgpS+YS/DnQ
	 tMHkkJItWfeFg==
Date: Sat, 13 Jan 2024 15:07:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?TcOlcnRlbg==?= Lindahl <marten.lindahl@axis.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kernel@axis.com>
Subject: Re: [PATCH v2] iio: light: vcnl4000: Set ps high definition for
 4040/4200
Message-ID: <20240113150738.0de92b7f@jic23-huawei>
In-Reply-To: <20231221-vcnl4000-ps-hd-v2-1-1b6790d30ae6@axis.com>
References: <20231221-vcnl4000-ps-hd-v2-1-1b6790d30ae6@axis.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Jan 2024 13:58:07 +0100
M=C3=A5rten Lindahl <marten.lindahl@axis.com> wrote:

> The vcnl4040/vcnl4200 proximity sensor defaults to 12 bit data
> resolution, but the chip also supports 16 bit data resolution, which is
> called proximity high definition (PS_HD).
>=20
> Make the vcnl4040/vcnl4200 proximity sensor use the high definition for
> all data readings. Please note that in order to preserve the 12 bit
> integer part of the in_proximity_raw output, the format is changed from
> integer to fixed point.
>=20
> Signed-off-by: M=C3=A5rten Lindahl <marten.lindahl@axis.com>
Hi M=C3=A5rten,

I don't understand why we'd try to carry on with using the device if
the additional register accesses fail.  Just fail the probe, the hardware
is broken.

Jonathan

> ---
> Changes in v2:
> - Update registers for sample rate to align it with 16 bit sensor reading=
s.
> - Change sysfs output from IIO_VAL_INT to IIO_VAL_FRACTIONAL and scale by=
 16.
> - Link to v1: https://lore.kernel.org/r/20231221-vcnl4000-ps-hd-v1-1-a024=
bfb28896@axis.com
> ---
>  drivers/iio/light/vcnl4000.c | 40 ++++++++++++++++++++++++++++++++++++++=
+-
>  1 file changed, 39 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index fdf763a04b0b..a078c573131e 100644
> --- a/drivers/iio/light/vcnl4000.c
> +++ b/drivers/iio/light/vcnl4000.c
> @@ -90,6 +90,7 @@
>  #define VCNL4040_PS_CONF1_PS_SHUTDOWN	BIT(0)
>  #define VCNL4040_PS_CONF2_PS_IT	GENMASK(3, 1) /* Proximity integration t=
ime */
>  #define VCNL4040_CONF1_PS_PERS	GENMASK(5, 4) /* Proximity interrupt pers=
istence setting */
> +#define VCNL4040_PS_CONF2_PS_HD		BIT(11)	/* Proximity high definition */
>  #define VCNL4040_PS_CONF2_PS_INT	GENMASK(9, 8) /* Proximity interrupt mo=
de */
>  #define VCNL4040_PS_CONF3_MPS		GENMASK(6, 5) /* Proximity multi pulse nu=
mber */
>  #define VCNL4040_PS_MS_LED_I		GENMASK(10, 8) /* Proximity current */
> @@ -114,6 +115,13 @@
>  #define VCNL4010_INT_DRDY \
>  	(BIT(VCNL4010_INT_PROXIMITY) | BIT(VCNL4010_INT_ALS))
> =20
> +#define VCNL4040_CONF3_PS_MPS_16BITS	3	/* 8 multi pulses */
> +#define VCNL4040_CONF3_PS_LED_I_16BITS	3	/* 120 mA */
> +
> +#define VCNL4040_CONF3_PS_SAMPLE_16BITS \
> +	(FIELD_PREP(VCNL4040_PS_CONF3_MPS, VCNL4040_CONF3_PS_MPS_16BITS) | \
> +	 FIELD_PREP(VCNL4040_PS_MS_LED_I, VCNL4040_CONF3_PS_LED_I_16BITS))
> +
>  static const int vcnl4010_prox_sampling_frequency[][2] =3D {
>  	{1, 950000},
>  	{3, 906250},
> @@ -195,6 +203,7 @@ struct vcnl4000_data {
>  	enum vcnl4000_device_ids id;
>  	int rev;
>  	int al_scale;
> +	int ps_scale;
>  	u8 ps_int;		/* proximity interrupt mode */
>  	u8 als_int;		/* ambient light interrupt mode*/
>  	const struct vcnl4000_chip_spec *chip_spec;
> @@ -345,6 +354,7 @@ static int vcnl4200_set_power_state(struct vcnl4000_d=
ata *data, bool on)
>  static int vcnl4200_init(struct vcnl4000_data *data)
>  {
>  	int ret, id;
> +	u16 regval;
> =20
>  	ret =3D i2c_smbus_read_word_data(data->client, VCNL4200_DEV_ID);
>  	if (ret < 0)
> @@ -386,9 +396,36 @@ static int vcnl4200_init(struct vcnl4000_data *data)
>  		break;
>  	}
>  	data->al_scale =3D data->chip_spec->ulux_step;
> +	data->ps_scale =3D 16;
>  	mutex_init(&data->vcnl4200_al.lock);
>  	mutex_init(&data->vcnl4200_ps.lock);
> =20
> +	/* Use 16 bits proximity sensor readings */
> +	ret =3D i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
> +	if (ret >=3D 0) {
> +		regval =3D (ret | VCNL4040_PS_CONF2_PS_HD);

Trivial but those brackets are unnecessary.

> +		ret =3D i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1,
> +						regval);
> +	}
> +
> +	if (ret < 0) {
> +		dev_info(&data->client->dev, "Default to 12 bits sensor data");

Silly question - how can we get here?  If it's a case of a read or a write =
failing
then that's a critical failure and we have very little idea what the state =
is.
If that happens I'd just fail to probe the driver rather than carrying on w=
ith
12 bit assumed.

> +		data->ps_scale =3D 1;
> +		goto out;
> +	}
> +
> +	/* Align proximity sensor sample rate to 16 bits data width */
> +	ret =3D i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF3);
> +	if (ret >=3D 0) {

If the read fails, something is very wrong. Fail the probe.

> +		regval =3D (ret | VCNL4040_CONF3_PS_SAMPLE_16BITS);
> +		ret =3D i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF3,
> +						regval);
> +	}
> +
> +	if (ret < 0)
> +		dev_warn(&data->client->dev, "Sample rate may not be accurate");

If this fails, fail the probe.  Don't try to carry on anyway.


> +
> +out:
>  	ret =3D data->chip_spec->set_power_state(data, true);
>  	if (ret < 0)
>  		return ret;
> @@ -901,8 +938,9 @@ static int vcnl4000_read_raw(struct iio_dev *indio_de=
v,
>  			break;
>  		case IIO_PROXIMITY:
>  			ret =3D data->chip_spec->measure_proximity(data, val);
> +			*val2 =3D data->ps_scale;
>  			if (!ret)
> -				ret =3D IIO_VAL_INT;
> +				ret =3D IIO_VAL_FRACTIONAL;
>  			break;
>  		default:
>  			ret =3D -EINVAL;
>=20
> ---
> base-commit: a39b6ac3781d46ba18193c9dbb2110f31e9bffe9
> change-id: 20231221-vcnl4000-ps-hd-863f4f8fcea7
>=20
> Best regards,


