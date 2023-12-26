Return-Path: <linux-kernel+bounces-11572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DE381E856
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 17:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67C171F21FC2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 16:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38894F601;
	Tue, 26 Dec 2023 16:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g45sIUeC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC224F881;
	Tue, 26 Dec 2023 16:19:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55116C433C8;
	Tue, 26 Dec 2023 16:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703607580;
	bh=H2ibcaT57+cYkmZfd6SOyXk8EAtLtivGTKZa442w6t4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g45sIUeCsUW4bexpFXPm7nJ/m6urJ5E3VveHxrN8Tvo/1CXIX/nS0H9LIY+PB14tm
	 10bRpiaI4q5lvHe0mAZYvzBG/McHmcTU6OU7u/Ciu1MIC+/fDCpJh4YvrvxJs+HrRc
	 +5XUQ7cf+E7jvKrTYO+bNS/MwvETNpgxKUkuNCqNri73r4TWCpo+o3ge1aNq1B+jBb
	 pDhb/vXcia5itg4KPKyM/wMuKfEmYkX66HX0kysgXxSKc/HWGXf5N8jrLl3mxWNYv1
	 JbKemUFGqN3gkEY/MCluIeFDSlgLmEf73Tlb/zyN3epJyYnU/aglEXN5tbPTV1nJxJ
	 CBxeUERomSqYw==
Date: Tue, 26 Dec 2023 16:19:34 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?TcOlcnRlbg==?= Lindahl <marten.lindahl@axis.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kernel@axis.com>
Subject: Re: [PATCH] iio: light: vcnl4000: Set ps high definition for
 4040/4200
Message-ID: <20231226161934.52c8d801@jic23-huawei>
In-Reply-To: <20231221-vcnl4000-ps-hd-v1-1-a024bfb28896@axis.com>
References: <20231221-vcnl4000-ps-hd-v1-1-a024bfb28896@axis.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 21 Dec 2023 17:33:09 +0100
M=C3=A5rten Lindahl <marten.lindahl@axis.com> wrote:

> The vcnl4040/vcnl4200 proximity sensor defaults to 12 bit data
> resolution, but the chip also supports 16 bit data resolution, which is
> called proximity high definition (PS_HD).
>=20
> Make the vcnl4040/vcnl4200 proximity sensor use the high definition for
> all data readings.
>=20
> Signed-off-by: M=C3=A5rten Lindahl <marten.lindahl@axis.com>

Hmm. Was about to apply this and had a nasty thought.  Whilst proximity isn=
't
'scaled' as such because there is no absolute scale applied, I assume this =
change
divides the effective scale (so what someone may be applying in userspace) =
by 16?

So this might cause someone a visible userspace regression?

If so we may have to report it IIO_VAL_FRACTIONAL with the bottom set to 16
so we end up with a suitable fixed point value from sysfs.

Jonathan

> ---
>  drivers/iio/light/vcnl4000.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
> index fdf763a04b0b..4846f3b698b5 100644
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
> @@ -345,6 +346,7 @@ static int vcnl4200_set_power_state(struct vcnl4000_d=
ata *data, bool on)
>  static int vcnl4200_init(struct vcnl4000_data *data)
>  {
>  	int ret, id;
> +	u16 regval;
> =20
>  	ret =3D i2c_smbus_read_word_data(data->client, VCNL4200_DEV_ID);
>  	if (ret < 0)
> @@ -389,6 +391,17 @@ static int vcnl4200_init(struct vcnl4000_data *data)
>  	mutex_init(&data->vcnl4200_al.lock);
>  	mutex_init(&data->vcnl4200_ps.lock);
> =20
> +	/* Use 16 bits proximity sensor readings */
> +	ret =3D i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
> +	if (ret >=3D 0) {
> +		regval =3D (ret | VCNL4040_PS_CONF2_PS_HD);
> +		ret =3D i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1,
> +						regval);
> +	}
> +
> +	if (ret < 0)
> +		dev_info(&data->client->dev, "Default to 12 bits sensor data");
> +
>  	ret =3D data->chip_spec->set_power_state(data, true);
>  	if (ret < 0)
>  		return ret;
>=20
> ---
> base-commit: a39b6ac3781d46ba18193c9dbb2110f31e9bffe9
> change-id: 20231221-vcnl4000-ps-hd-863f4f8fcea7
>=20
> Best regards,


