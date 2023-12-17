Return-Path: <linux-kernel+bounces-2623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FD1815F96
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 15:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BBCF282F98
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 14:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D842F4439E;
	Sun, 17 Dec 2023 14:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTnKX2TM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C7543AB2;
	Sun, 17 Dec 2023 14:16:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B5FC433C7;
	Sun, 17 Dec 2023 14:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702822568;
	bh=FKMJqpUKdDEoupk+PgB+krI637ogNGtEFYDASoVniW0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RTnKX2TMHKW0wO6jKotKn6DqY78jHVCQ8ETBSsxYTPq3/T/l/dF3VOAcPbVZ+vetP
	 6Rf3c90Zx4/f4XN/6WxCpcd0KH4LdCEcUDGpLUoIrMFpvSzto/SS4jnfw61MY4VC51
	 OX5aHtTwIjgeu26PFsevg4W5Q2REyX8bG7I8ke45bIgixEEbi4SJC/hbBBrWU627t7
	 A4qmOWeK1bt65PUPhB+U9UcAahn1miP0uLQy8qmKqOGmOFQvWYaX8GoxmGtYgoE5Bs
	 S/uqX1+c7V8y0mBFhL6vXKomFpXd6A0zNxMsOdnR6/tTFg/UkuaHq9N1Kdl6EECdFT
	 LR4Gln/ZcyAag==
Date: Sun, 17 Dec 2023 14:15:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?TcOlcnRlbg==?= Lindahl <marten.lindahl@axis.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kernel@axis.com>
Subject: Re: [PATCH 2/2] iio: light: vcnl4000: Add ps high definition for
 vcnl4040
Message-ID: <20231217141554.04c8863d@jic23-huawei>
In-Reply-To: <20231212-vcnl4000-ps-hd-v1-2-1c62a95828c0@axis.com>
References: <20231212-vcnl4000-ps-hd-v1-0-1c62a95828c0@axis.com>
	<20231212-vcnl4000-ps-hd-v1-2-1c62a95828c0@axis.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 15 Dec 2023 13:43:05 +0100
M=C3=A5rten Lindahl <marten.lindahl@axis.com> wrote:

> The vcnl4040 proximity sensor defaults to 12 bit data resolution, but
> the chip also supports 16 bit data resolution, which is called proximity
> high definition (PS_HD).
>=20
> Add read/write attribute for proximity resolution, and read attribute
> for available proximity resolution values for the vcnl4040 chip.
>=20
> Signed-off-by: M=C3=A5rten Lindahl <marten.lindahl@axis.com>
I'll review this on basis the usecase is clear (see reply to cover letter)

The manipulation of the CONF1 and CONF2 registers in a pair is rather odd g=
iven you
only want to change one bit here.

Why is that done?
> ---
>  drivers/iio/light/vcnl4000.c | 87 ++++++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 85 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index fdf763a04b0b..2addff635b79 100644
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
> @@ -170,6 +171,11 @@ static const int vcnl4040_ps_calibbias_ua[][2] =3D {
>  	{0, 200000},
>  };
> =20
> +static const int vcnl4040_ps_resolutions[2] =3D {
> +	12,
> +	16
> +};
> +
>  static const int vcnl4040_als_persistence[] =3D {1, 2, 4, 8};
>  static const int vcnl4040_ps_persistence[] =3D {1, 2, 3, 4};
>  static const int vcnl4040_ps_oversampling_ratio[] =3D {1, 2, 4, 8};
> @@ -880,6 +886,54 @@ static ssize_t vcnl4040_write_ps_calibbias(struct vc=
nl4000_data *data, int val)
>  	return ret;
>  }
> =20
> +static ssize_t vcnl4040_read_ps_resolution(struct vcnl4000_data *data, i=
nt *val, int *val2)
> +{
> +	int ret;
> +
> +	ret =3D i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
The field seems to be in PS_CONF2.  So you are reading a word and I guess t=
hat
gets you two registers.  Can we not do a byte read to get just CONF2?
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D FIELD_GET(VCNL4040_PS_CONF2_PS_HD, ret);
> +	if (ret >=3D ARRAY_SIZE(vcnl4040_ps_resolutions))
> +		return -EINVAL;
> +
> +	*val =3D vcnl4040_ps_resolutions[ret];
> +	*val2 =3D 0;
> +
> +	return ret;
> +}
> +
> +static ssize_t vcnl4040_write_ps_resolution(struct vcnl4000_data *data, =
int val)
> +{
> +	unsigned int i;
> +	int ret;
> +	u16 regval;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(vcnl4040_ps_resolutions); i++) {
> +		if (val =3D=3D vcnl4040_ps_resolutions[i])
> +			break;
> +	}
> +
> +	if (i >=3D ARRAY_SIZE(vcnl4040_ps_resolutions))
> +		return -EINVAL;
> +
> +	mutex_lock(&data->vcnl4000_lock);
> +
> +	ret =3D i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
> +	if (ret < 0)
> +		goto out_unlock;
> +
> +	regval =3D (ret & ~VCNL4040_PS_CONF2_PS_HD);
> +	regval |=3D FIELD_PREP(VCNL4040_PS_CONF2_PS_HD, i);
> +	ret =3D i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1,
> +					regval);
> +
> +out_unlock:
> +	mutex_unlock(&data->vcnl4000_lock);
> +	return ret;
> +}
c),
>=20


