Return-Path: <linux-kernel+bounces-11570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1CE81E851
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 17:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 533A3282F5C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 16:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F014F605;
	Tue, 26 Dec 2023 16:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epxO4hWz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B784F5E3;
	Tue, 26 Dec 2023 16:14:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8F3C433C8;
	Tue, 26 Dec 2023 16:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703607263;
	bh=X17uhTrvUB4QI3u0hbcYr4MU2xf6/bp+rJzgV0J90LI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=epxO4hWzji58L5LQDUuSA9/qCgSbnWFNEqV2gMT8eeVzg9uzDWdv3oEg+YmGzbLgA
	 UY3oNsiwNGXk8nsFKxr8v3Z07+bYs+sSBRhZKqazF9yHn/3vQpOyyS7b3990zZ1AhE
	 Rn5l0EW3BZ7BU1UQc8Qesyl0+2KTNAJJ3YbSIaXqi34anwYZ5CHNfht7n2EGlY0VYd
	 lKfa3DB9L9DDF2sNap4XDL26UlzMZhYKzZMAPTZ3DeNGl0Zrl009jyn7sfTaUKv4js
	 6aNilQdolre7XMUHHNoiDel+jVtkWBpwtPDsbQ2wA1bRS+p+4d/vtXuvZH0VSVl/wO
	 xPPis0p6qFkAQ==
Date: Tue, 26 Dec 2023 16:14:14 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Christian Eggers <ceggers@arri.de>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] io: light: as73211: add support for as7331
Message-ID: <20231226161414.47d5171e@jic23-huawei>
In-Reply-To: <20231220-as7331-v1-2-745b73c27703@gmail.com>
References: <20231220-as7331-v1-0-745b73c27703@gmail.com>
	<20231220-as7331-v1-2-745b73c27703@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 23 Dec 2023 11:46:14 +0100
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> The AMS AS7331 is a UV light sensor with three channels: UVA, UVB and
> UVC (also known as deep UV and referenced as DUV in the iio core).
> Its internal structure and forming blocks are practically identical to
> the ones the AS73211 contains: API, internal DAC, I2C interface and
> registers, measurement modes, number of channels and pinout.
> 
> The only difference between them is the photodiodes used to acquire
> light, which means that only some modifications are required to add
> support for the AS7331 in the existing driver.
> 
> The temperature channel is identical for both devices and only the
> channel modifiers of the IIO_INTENSITY channels need to account for the
> device type.
> 
> The scale values have been obtained from the chapter "7.5 Transfer
> Function" of the official datasheet[1] for the configuration chosen as
> basis (Nclk = 1024 and GAIN = 1). Those values keep the units from the
> datasheet (nW/cm^2) because no additional upscaling is required to work
> with integers as opposed to the scale values for the AS73211. Actually
> if the same upscaling is used, their values will not fit in 4-byte
> integers without affecting its sign.
> 
> Instead, the AS7331-specific function to retrieve the intensity scales
> returns decimal values as listed in the datasheet for every
> combination of GAIN and Nclk, keeping the unit as nW/cm^2.
> To achieve that, a fractional value is returned.
> The AS73211 scales use nW/m^2 units to work with integers that fit in
> a 4-byte integer, and in that case there is no need to modify the value
> type.

No need, but in general it's a nice to have if it works well with
IIO_VAL_FRACTIONAL because in kernel users (there aren't really any
for light sensors) can handle the maths better if they need to apply
other scalings etc.

> 
> Add a new device-specific data structure to account for the device
> differences: channel types and scale of LSB per channel.
A may not be worth doing it in this case, but usual approach to refactoring
a driver to allow support of additional devices is to do it in two steps.
1) Refactor with no new support - so should be no operational changes.
2) Add the new device support.


> 
> [1] https://ams.com/documents/20143/9106314/AS7331_DS001047_4-00.pdf
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
...

> diff --git a/drivers/iio/light/as73211.c b/drivers/iio/light/as73211.c
> index ec97a3a46839..d53a0ae5255a 100644
> --- a/drivers/iio/light/as73211.c
> +++ b/drivers/iio/light/as73211.c
...

>  
> +static const struct iio_chan_spec as7331_channels[] = {
> +	{
> +		.type = IIO_TEMP,
> +		.info_mask_separate =
> +			BIT(IIO_CHAN_INFO_RAW) |
> +			BIT(IIO_CHAN_INFO_OFFSET) |
> +			BIT(IIO_CHAN_INFO_SCALE),
> +		.address = AS73211_OUT_TEMP,
> +		.scan_index = AS73211_SCAN_INDEX_TEMP,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 16,
> +			.storagebits = 16,
> +			.endianness = IIO_LE,
> +		}
> +	},
> +	AS73211_COLOR_CHANNEL(LIGHT_UVA, AS73211_SCAN_INDEX_X, AS73211_OUT_MRES1),
> +	AS73211_COLOR_CHANNEL(LIGHT_UVB, AS73211_SCAN_INDEX_Y, AS73211_OUT_MRES2),
> +	AS73211_COLOR_CHANNEL(LIGHT_DUV, AS73211_SCAN_INDEX_Z, AS73211_OUT_MRES3),
> +	IIO_CHAN_SOFT_TIMESTAMP(AS73211_SCAN_INDEX_TS),
> +};
> +
>  static unsigned int as73211_integration_time_1024cyc(struct as73211_data *data)
>  {
>  	/*
> @@ -316,6 +361,50 @@ static int as73211_req_data(struct as73211_data *data)
>  	return 0;
>  }
>  
> +static int as73211_intensity_scale(struct as73211_data *data, int chan, int *val, int *val2)
> +{
> +	unsigned int scale;
> +
> +	switch (chan) {
> +	case IIO_MOD_X:
> +		scale = AS73211_SCALE_X;
> +		break;
> +	case IIO_MOD_Y:
> +		scale = AS73211_SCALE_Y;
> +		break;
> +	case IIO_MOD_Z:
> +		scale = AS73211_SCALE_Z;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	scale /= as73211_gain(data);
> +	scale /= as73211_integration_time_1024cyc(data);
> +	*val = scale;
> +
> +	return IIO_VAL_INT;

Obviously it's really a question about the original code but why not
use IIO_VAL_FRACTIONAL here as well as below? Superficially looks
like it should work in a similar fashion.

If not, perhaps a comment here somewhere?

> +}
> +
> +static int as7331_intensity_scale(struct as73211_data *data, int chan, int *val, int *val2)
> +{
> +	switch (chan) {
> +	case IIO_MOD_LIGHT_UVA:
> +		*val = AS7331_SCALE_UVA;
> +		break;
> +	case IIO_MOD_LIGHT_UVB:
> +		*val = AS7331_SCALE_UVB;
> +		break;
> +	case IIO_MOD_LIGHT_DUV:
> +		*val = AS7331_SCALE_UVC;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	*val2 = as73211_gain(data) * as73211_integration_time_1024cyc(data);
> +
> +	return IIO_VAL_FRACTIONAL;
> +}
> +
>  static int as73211_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
>  			     int *val, int *val2, long mask)
>  {
> @@ -355,30 +444,12 @@ static int as73211_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec cons
>  			*val2 = AS73211_SCALE_TEMP_MICRO;
>  			return IIO_VAL_INT_PLUS_MICRO;
>  
> -		case IIO_INTENSITY: {
> -			unsigned int scale;
> -
> -			switch (chan->channel2) {
> -			case IIO_MOD_X:
> -				scale = AS73211_SCALE_X;
> -				break;
> -			case IIO_MOD_Y:
> -				scale = AS73211_SCALE_Y;
> -				break;
> -			case IIO_MOD_Z:
> -				scale = AS73211_SCALE_Z;
> -				break;
> -			default:
> -				return -EINVAL;
> -			}
> -			scale /= as73211_gain(data);
> -			scale /= as73211_integration_time_1024cyc(data);
> -			*val = scale;
> -			return IIO_VAL_INT;
> +		case IIO_INTENSITY:
> +			return data->spec_dev->intensity_scale(data, chan->channel2, val, val2);
Where it doesn't hurt readability, I'd prefer we stayed as close to 80 chars or below
as reasonably possible.  So here wrap so val, val2); is on the next line.

>  
>  		default:
>  			return -EINVAL;
> -		}}
> +		}
>  
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		/* f_samp is configured in CREG3 in powers of 2 (x 1.024 MHz) */
> @@ -676,13 +747,20 @@ static int as73211_probe(struct i2c_client *client)
>  	i2c_set_clientdata(client, indio_dev);
>  	data->client = client;
>  
> +	if (dev_fwnode(dev))
> +		data->spec_dev = device_get_match_data(dev);
> +	else
> +		data->spec_dev = i2c_get_match_data(client);

Take a look at how i2c_get_match_data() is defined...
https://elixir.bootlin.com/linux/latest/source/drivers/i2c/i2c-core-base.c#L117
and in particular what it calls first..

> +	if (!data->spec_dev)
> +		return -EINVAL;
> +
>  	mutex_init(&data->mutex);
>  	init_completion(&data->completion);
>  
>  	indio_dev->info = &as73211_info;
>  	indio_dev->name = AS73211_DRV_NAME;
> -	indio_dev->channels = as73211_channels;
> -	indio_dev->num_channels = ARRAY_SIZE(as73211_channels);
> +	indio_dev->channels = data->spec_dev->channel;
> +	indio_dev->num_channels = data->spec_dev->num_channels;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  


