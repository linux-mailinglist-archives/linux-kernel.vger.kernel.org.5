Return-Path: <linux-kernel+bounces-2647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F482815FDE
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 15:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 361DA2892D7
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 14:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FEA44C74;
	Sun, 17 Dec 2023 14:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ER6anyDg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857341DFD7;
	Sun, 17 Dec 2023 14:36:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF555C433C8;
	Sun, 17 Dec 2023 14:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702823770;
	bh=ZJHYl2x/5sOZYR/DGxvRXI5eEW8wCSGNtFDh8x+V5bA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ER6anyDg+jhiNEW1JfE8yrcTvOcyVAP0Abw8SQdsCjpjoqLLjgS5jMoiATdIloM46
	 b/FhcviIxYDHyZntmQy5Qc70SgkXtcVdjUeCjFthZJaW0wtLse26fS7MoCrrhmf3Tc
	 c1zs2CeJaoqfs/KY7ZYaHCyIRIn0riKBffgxuMh4gHwk+ILaKNGM30u7y5musRZRhn
	 ThtSw78tFbwtYsdpqlZaLqPv44W/4lUMbm2zO0byt/gSz76j/23SB30K1C6VFyq7Jj
	 WZGKqHkTyDzXB2FCd/+AAQ6Az06U9s66pD8rF/Onv5x/NaL5lruOo7Mfv2gOXCbyFT
	 sldL/41dId8CA==
Date: Sun, 17 Dec 2023 14:35:55 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: jikos@kernel.org, lars@metafoo.de, Basavaraj.Natikar@amd.com,
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?=
 <thomas@t-8ch.de>, stable@vger.kernel.org
Subject: Re: [PATCH] iio: light: hid-sensor-als: Avoid failure for
 chromaticity support
Message-ID: <20231217143555.1f89ddaa@jic23-huawei>
In-Reply-To: <20231215160159.648963-1-srinivas.pandruvada@linux.intel.com>
References: <20231215160159.648963-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 15 Dec 2023 08:01:59 -0800
Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> With the commit ee3710f39f9d ("iio: hid-sensor-als: Add light chromaticity
> support"), there is an assumption that the every HID ALS descriptor has
> support of usage ids for chromaticity support. If they are not present,
> probe fails for the driver . This breaks ALS functionality on majority of
> platforms.
>=20
> It is possible that chromaticity usage ids are not present. When not
> present, restrict number of IIO channels to not include support for
> chromaticity and continue.
>=20
> Fixes: ee3710f39f9d ("iio: hid-sensor-als: Add light chromaticity support=
")
> Reported-by: Thomas Wei=C3=9Fschuh <thomas@t-8ch.de>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D218223
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/iio/light/hid-sensor-als.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-s=
ensor-als.c
> index f17304b54468..9941b0b927c7 100644
> --- a/drivers/iio/light/hid-sensor-als.c
> +++ b/drivers/iio/light/hid-sensor-als.c
> @@ -303,11 +303,14 @@ static int als_parse_report(struct platform_device =
*pdev,
>  				struct hid_sensor_hub_device *hsdev,
>  				struct iio_chan_spec *channels,
>  				unsigned usage_id,
> -				struct als_state *st)
> +				struct als_state *st,
> +				int *max_channels)
>  {
>  	int ret;
>  	int i;
> =20
> +	*max_channels =3D CHANNEL_SCAN_INDEX_MAX;
> +
>  	for (i =3D 0; i <=3D CHANNEL_SCAN_INDEX_ILLUM; ++i) {
>  		ret =3D sensor_hub_input_get_attribute_info(hsdev,
>  						HID_INPUT_REPORT,
> @@ -326,8 +329,12 @@ static int als_parse_report(struct platform_device *=
pdev,
>  				usage_id,
>  				HID_USAGE_SENSOR_LIGHT_COLOR_TEMPERATURE,
>  				&st->als[CHANNEL_SCAN_INDEX_COLOR_TEMP]);
> -	if (ret < 0)
> -		return ret;
> +	if (ret < 0) {
> +		*max_channels =3D CHANNEL_SCAN_INDEX_ILLUM;
> +		ret =3D 0;
> +		goto skip_color_chromaticity;
> +	}
> +
>  	als_adjust_channel_bit_mask(channels, CHANNEL_SCAN_INDEX_COLOR_TEMP,
>  				st->als[CHANNEL_SCAN_INDEX_COLOR_TEMP].size);
> =20
> @@ -354,6 +361,7 @@ static int als_parse_report(struct platform_device *p=
dev,
>  			st->als[next_scan_index].report_id);
>  	}
> =20
> +skip_color_chromaticity:
>  	st->scale_precision =3D hid_sensor_format_scale(usage_id,
>  				&st->als[CHANNEL_SCAN_INDEX_INTENSITY],
>  				&st->scale_pre_decml, &st->scale_post_decml);
> @@ -364,7 +372,7 @@ static int als_parse_report(struct platform_device *p=
dev,
>  /* Function to initialize the processing for usage id */
>  static int hid_als_probe(struct platform_device *pdev)
>  {
> -	int ret =3D 0;
> +	int ret =3D 0, max_channels;
>  	static const char *name =3D "als";
>  	struct iio_dev *indio_dev;
>  	struct als_state *als_state;
> @@ -398,15 +406,15 @@ static int hid_als_probe(struct platform_device *pd=
ev)
> =20
>  	ret =3D als_parse_report(pdev, hsdev,
>  			       (struct iio_chan_spec *)indio_dev->channels,
> -			       hsdev->usage,
> -			       als_state);
> +			       hsdev->usage, als_state, &max_channels);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to setup attributes\n");
>  		return ret;
>  	}
> =20
> -	indio_dev->num_channels =3D
> -				ARRAY_SIZE(als_channels);
> +	/* +1 to include time stamp */
> +	indio_dev->num_channels =3D max_channels + 1;

In the current array the timestamp channel isn't the next one, so how does =
this work?

I think we either have to form the channel array dynamically or pick between
one that does have the colour info and one that doesn't for the original ca=
se.

Given timing we may just need to revert the broken patch and revisit this n=
ext
cycle.

Jonathan


> +
>  	indio_dev->info =3D &als_info;
>  	indio_dev->name =3D name;
>  	indio_dev->modes =3D INDIO_DIRECT_MODE;


